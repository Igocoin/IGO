// Copyright (c) 2011-2014 The Bitcoin Core developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#ifndef IGOCOIN_QT_IGOCOINADDRESSVALIDATOR_H
#define IGOCOIN_QT_IGOCOINADDRESSVALIDATOR_H

#include <QValidator>

/** Base58 entry widget validator, checks for valid characters and
 * removes some whitespace.
 */
class IgocoinAddressEntryValidator : public QValidator
{
    Q_OBJECT

public:
    explicit IgocoinAddressEntryValidator(QObject *parent);

    State validate(QString &input, int &pos) const;
};

/** Igocoin address widget validator, checks for a valid igocoin address.
 */
class IgocoinAddressCheckValidator : public QValidator
{
    Q_OBJECT

public:
    explicit IgocoinAddressCheckValidator(QObject *parent);

    State validate(QString &input, int &pos) const;
};

#endif // IGOCOIN_QT_IGOCOINADDRESSVALIDATOR_H
