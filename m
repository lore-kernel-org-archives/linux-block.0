Return-Path: <SRS0=XSHr=QR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88BB0C282C2
	for <linux-block@archiver.kernel.org>; Sun, 10 Feb 2019 20:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAA762146F
	for <linux-block@archiver.kernel.org>; Sun, 10 Feb 2019 20:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fjfi.cvut.cz header.i=@fjfi.cvut.cz header.b="zDpSN9fb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbfBJUGA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 10 Feb 2019 15:06:00 -0500
Received: from mailgw1.fjfi.cvut.cz ([147.32.9.3]:56574 "EHLO
        mailgw1.fjfi.cvut.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfBJUGA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 10 Feb 2019 15:06:00 -0500
Received: from localhost (localhost [127.0.0.1])
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTP id D6203A011B;
        Sun, 10 Feb 2019 21:05:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fjfi.cvut.cz;
        s=20151024; t=1549829156; i=@fjfi.cvut.cz;
        bh=AGBoL+sILRpkIa8Ry2g9ONX4x1V/Owe+M90l7khOxP4=;
        h=Date:From:To:cc:Subject:In-Reply-To:References;
        b=zDpSN9fbZOWQ4XJUM3edZhdp8HE0kN9DY9qniCy8aTHBJTHQvptuLT4mksfIJ7ARN
         m+jr90Hq6HMASCqn9UXc0iq14vllfmbNKthmS7m3hSg2Mn0oKyb2OtNGTBAQnXBHMF
         v8OlxHua+2hIRpiClp1pUekCHBt0PGPyts3QAZnQ=
X-CTU-FNSPE-Virus-Scanned: amavisd-new at fjfi.cvut.cz
Received: from mailgw1.fjfi.cvut.cz ([127.0.0.1])
        by localhost (mailgw1.fjfi.cvut.cz [127.0.0.1]) (amavisd-new, port 10022)
        with ESMTP id FRjG72vNAYC6; Sun, 10 Feb 2019 21:05:47 +0100 (CET)
Received: from linux.fjfi.cvut.cz (linux.fjfi.cvut.cz [147.32.5.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTPS id DED33A2398;
        Sun, 10 Feb 2019 21:05:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailgw1.fjfi.cvut.cz DED33A2398
Received: by linux.fjfi.cvut.cz (Postfix, from userid 1001)
        id 6DAB16004E; Sun, 10 Feb 2019 21:05:29 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by linux.fjfi.cvut.cz (Postfix) with ESMTP id 4FAD66004D;
        Sun, 10 Feb 2019 21:05:29 +0100 (CET)
Date:   Sun, 10 Feb 2019 21:05:29 +0100 (CET)
From:   David Kozub <zub@linux.fjfi.cvut.cz>
To:     "Derrick, Jonathan" <jonathan.derrick@intel.com>
cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "sbauer@plzdonthack.me" <sbauer@plzdonthack.me>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "jonas.rabenstein@studium.uni-erlangen.de" 
        <jonas.rabenstein@studium.uni-erlangen.de>
Subject: Re: [PATCH v4 13/16] block: sed-opal: check size of shadow mbr
In-Reply-To: <1549666730.10972.60.camel@intel.com>
Message-ID: <alpine.LRH.2.21.1902101921530.28071@linux.fjfi.cvut.cz>
References: <1549054223-12220-1-git-send-email-zub@linux.fjfi.cvut.cz>  <1549054223-12220-14-git-send-email-zub@linux.fjfi.cvut.cz> <1549666730.10972.60.camel@intel.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 8 Feb 2019, Derrick, Jonathan wrote:

> On Fri, 2019-02-01 at 21:50 +0100, David Kozub wrote:
>> From: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
>>
>> Check whether the shadow mbr does fit in the provided space on the
>> target. Also a proper firmware should handle this case and return an
>> error we may prevent problems or even damage with crappy firmwares.
>>
>> Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
>> Reviewed-by: Scott Bauer <sbauer@plzdonthack.me>
>> ---
>>  block/opal_proto.h | 16 ++++++++++++++++
>>  block/sed-opal.c   | 39 +++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 55 insertions(+)
>>
>> diff --git a/block/opal_proto.h b/block/opal_proto.h
>> index b6e352cfe982..5e8df3245eb0 100644
>> --- a/block/opal_proto.h
>> +++ b/block/opal_proto.h
>> @@ -106,6 +106,7 @@ enum opal_uid {
>>  	OPAL_ENTERPRISE_BANDMASTER0_UID,
>>  	OPAL_ENTERPRISE_ERASEMASTER_UID,
>>  	/* tables */
>> +	OPAL_TABLE_TABLE,
>>  	OPAL_LOCKINGRANGE_GLOBAL,
>>  	OPAL_LOCKINGRANGE_ACE_RDLOCKED,
>>  	OPAL_LOCKINGRANGE_ACE_WRLOCKED,
>> @@ -160,6 +161,21 @@ enum opal_token {
>>  	OPAL_STARTCOLUMN = 0x03,
>>  	OPAL_ENDCOLUMN = 0x04,
>>  	OPAL_VALUES = 0x01,
>> +	/* table table */
>> +	OPAL_TABLE_UID = 0x00,
>> +	OPAL_TABLE_NAME = 0x01,
>> +	OPAL_TABLE_COMMON = 0x02,
>> +	OPAL_TABLE_TEMPLATE = 0x03,
>> +	OPAL_TABLE_KIND = 0x04,
>> +	OPAL_TABLE_COLUMN = 0x05,
>> +	OPAL_TABLE_COLUMNS = 0x06,
>> +	OPAL_TABLE_ROWS = 0x07,
>> +	OPAL_TABLE_ROWS_FREE = 0x08,
>> +	OPAL_TABLE_ROW_BYTES = 0x09,
>> +	OPAL_TABLE_LASTID = 0x0A,
>> +	OPAL_TABLE_MIN = 0x0B,
>> +	OPAL_TABLE_MAX = 0x0C,
>> +
>>  	/* authority table */
>>  	OPAL_PIN = 0x03,
>>  	/* locking tokens */
>> diff --git a/block/sed-opal.c b/block/sed-opal.c
>> index 2459ac4d523b..3493bb979978 100644
>> --- a/block/sed-opal.c
>> +++ b/block/sed-opal.c
>> @@ -139,6 +139,8 @@ static const u8 opaluid[][OPAL_UID_LENGTH] = {
>>
>>  	/* tables */
>>
>> +	[OPAL_TABLE_TABLE]
>> +		{ 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01 },
>>  	[OPAL_LOCKINGRANGE_GLOBAL] =
>>  		{ 0x00, 0x00, 0x08, 0x02, 0x00, 0x00, 0x00, 0x01 },
>>  	[OPAL_LOCKINGRANGE_ACE_RDLOCKED] =
>> @@ -1120,6 +1122,29 @@ static int generic_get_column(struct opal_dev *dev, const u8 *table,
>>  	return finalize_and_send(dev, parse_and_check_status);
>>  }
>>
>> +/*
>> + * see TCG SAS 5.3.2.3 for a description of the available columns
>> + *
>> + * the result is provided in dev->resp->tok[4]
>> + */
>> +static int generic_get_table_info(struct opal_dev *dev, enum opal_uid table,
>> +				  u64 column)
>> +{
>> +	u8 uid[OPAL_UID_LENGTH];
>> +	const unsigned int half = OPAL_UID_LENGTH/2;
>> +
>> +	/* sed-opal UIDs can be split in two halves:
>> +	 *  first:  actual table index
>> +	 *  second: relative index in the table
>> +	 * so we have to get the first half of the OPAL_TABLE_TABLE and use the
>> +	 * first part of the target table as relative index into that table
>> +	 */
>> +	memcpy(uid, opaluid[OPAL_TABLE_TABLE], half);
>> +	memcpy(uid+half, opaluid[table], half);
>> +
>> +	return generic_get_column(dev, uid, column);
>> +}
>> +
>>  static int gen_key(struct opal_dev *dev, void *data)
>>  {
>>  	u8 uid[OPAL_UID_LENGTH];
>> @@ -1535,6 +1560,20 @@ static int write_shadow_mbr(struct opal_dev *dev, void *data)
>>  	u64 len;
>>  	int err = 0;
>>
>> +	/* do we fit in the available shadow mbr space? */
>> +	err = generic_get_table_info(dev, OPAL_MBR, OPAL_TABLE_ROWS);
> Wouldn't you need to multiply this by result from OPAL_TABLE_ROWBYTES?
> What does ROWBYTES return for you?

Hi Jon,

reading the spec[1], I think it defines the MBR table to be a "byte table" 
(see 5.7.2.6 MBR (Byte Table)). For byte tables, it says (see 3.2.5.1 
Kinds of Tables) "A byte table has one unnamed column of type bytes_1." I 
think this implies that each row is 1 byte and so number of rows = size of 
table in rows.

When I actually try to get OPAL_TABLE_ROWS abd OPAL_TABLE_ROWBYTES of the 
MBR table from a Samsung 840 EVO, I get:
* OPAL_TABLE_ROWS 134217728 which is 128 MiB
* OPAL_TABLE_ROWBYTES 0

I'm not sure if I'm doing something wrong here. I just added:

 	err = generic_get_table_info(dev, OPAL_MBR, OPAL_TABLE_ROW_BYTES);
 	if (err) {
 		pr_debug("MBR: could not get shadow row bytes size\n");
 		return err;
 	}

 	row_bytes = response_get_u64(&dev->parsed, 4);

Best regards,
David

[1] https://trustedcomputinggroup.org/wp-content/uploads/TCG_Storage_Architecture_Core_Spec_v2.01_r1.00.pdf
