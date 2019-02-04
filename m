Return-Path: <SRS0=Gtqi=QL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 635C9C282C4
	for <linux-block@archiver.kernel.org>; Mon,  4 Feb 2019 21:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29A6C20815
	for <linux-block@archiver.kernel.org>; Mon,  4 Feb 2019 21:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fjfi.cvut.cz header.i=@fjfi.cvut.cz header.b="caEjJeLA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbfBDVHS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Feb 2019 16:07:18 -0500
Received: from mailgw1.fjfi.cvut.cz ([147.32.9.3]:56434 "EHLO
        mailgw1.fjfi.cvut.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728004AbfBDVHS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Feb 2019 16:07:18 -0500
Received: from localhost (localhost [127.0.0.1])
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTP id F321FA56E3;
        Mon,  4 Feb 2019 22:07:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fjfi.cvut.cz;
        s=20151024; t=1549314436; i=@fjfi.cvut.cz;
        bh=qIsXIybMN4JZAKYykZ+HO6nWKxzVOzex+fvfhz5N07c=;
        h=Date:From:To:cc:Subject:In-Reply-To:References;
        b=caEjJeLABtz2v7mxn4PcjhM7vheabyj61rDlBrPCH2srNPaK8u4yxNMpn9NvzVOPX
         fUCt8x7wUhQCc4EOi3bhTYOfFXOwjjRwXUNnEy1QfWBx7T13TbawAUp2HqrHfr2CEZ
         lUwpLn8/rAbNLd7hOOYd6UTOvl+t3ulOS33ED7OU=
X-CTU-FNSPE-Virus-Scanned: amavisd-new at fjfi.cvut.cz
Received: from mailgw1.fjfi.cvut.cz ([127.0.0.1])
        by localhost (mailgw1.fjfi.cvut.cz [127.0.0.1]) (amavisd-new, port 10022)
        with ESMTP id 3IQaWAbQyOTw; Mon,  4 Feb 2019 22:07:10 +0100 (CET)
Received: from linux.fjfi.cvut.cz (linux.fjfi.cvut.cz [147.32.5.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTPS id E35C2A55B1;
        Mon,  4 Feb 2019 22:07:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailgw1.fjfi.cvut.cz E35C2A55B1
Received: by linux.fjfi.cvut.cz (Postfix, from userid 1001)
        id A0C706004E; Mon,  4 Feb 2019 22:07:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by linux.fjfi.cvut.cz (Postfix) with ESMTP id 880C56004D;
        Mon,  4 Feb 2019 22:07:09 +0100 (CET)
Date:   Mon, 4 Feb 2019 22:07:09 +0100 (CET)
From:   David Kozub <zub@linux.fjfi.cvut.cz>
To:     Christoph Hellwig <hch@infradead.org>
cc:     Jens Axboe <axboe@kernel.dk>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Subject: Re: [PATCH v4 03/16] block: sed-opal: unify space check in
 add_token_*
In-Reply-To: <20190204144418.GC31132@infradead.org>
Message-ID: <alpine.LRH.2.21.1902042145330.10661@linux.fjfi.cvut.cz>
References: <1549054223-12220-1-git-send-email-zub@linux.fjfi.cvut.cz> <1549054223-12220-4-git-send-email-zub@linux.fjfi.cvut.cz> <20190204144418.GC31132@infradead.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 4 Feb 2019, Christoph Hellwig wrote:

> On Fri, Feb 01, 2019 at 09:50:10PM +0100, David Kozub wrote:
>> From: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
>>
>> All add_token_* functions have a common set of conditions that have to
>> be checked. Use a common function for those checks in order to avoid
>> different behaviour as well as code duplication.
>>
>> Co-authored-by: David Kozub <zub@linux.fjfi.cvut.cz>
>> Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
>> Signed-off-by: David Kozub <zub@linux.fjfi.cvut.cz>
>> Reviewed-by: Scott Bauer <sbauer@plzdonthack.me>
>> ---
>>  block/sed-opal.c | 30 +++++++++++++++++++++---------
>>  1 file changed, 21 insertions(+), 9 deletions(-)
>>
>> diff --git a/block/sed-opal.c b/block/sed-opal.c
>> index 5c123a5b4ab1..980705681806 100644
>> --- a/block/sed-opal.c
>> +++ b/block/sed-opal.c
>> @@ -510,15 +510,29 @@ static int opal_discovery0(struct opal_dev *dev, void *data)
>>  	return opal_discovery0_end(dev);
>>  }
>>
>> -static void add_token_u8(int *err, struct opal_dev *cmd, u8 tok)
>> +static size_t remaining_size(struct opal_dev *cmd)
>> +{
>> +	return IO_BUFFER_LENGTH - cmd->pos;
>> +}
>
> This function seem a little pointless to me, at least as of this patch
> where it only has a single user just below.

It is eventually used for the second time in 11/16 block: sed-opal: ioctl 
for writing to shadow mbr.

If you feel strongly about this I can exclude it from this commit and 
introduce it in 11/16 (where it then will called from here and from 
write_shadow_mbr).

Best regards,
David
