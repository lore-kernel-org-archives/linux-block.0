Return-Path: <SRS0=wMCK=QO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B8EC282C2
	for <linux-block@archiver.kernel.org>; Thu,  7 Feb 2019 22:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B39C021721
	for <linux-block@archiver.kernel.org>; Thu,  7 Feb 2019 22:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fjfi.cvut.cz header.i=@fjfi.cvut.cz header.b="tSn87r6Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbfBGW44 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Feb 2019 17:56:56 -0500
Received: from mailgw1.fjfi.cvut.cz ([147.32.9.3]:43946 "EHLO
        mailgw1.fjfi.cvut.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbfBGW4z (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Feb 2019 17:56:55 -0500
Received: from localhost (localhost [127.0.0.1])
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTP id 8CB44AE33D;
        Thu,  7 Feb 2019 23:56:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fjfi.cvut.cz;
        s=20151024; t=1549580212; i=@fjfi.cvut.cz;
        bh=rtVb3ivpOblZf8WHdo5sutGCTv0TgBQL/UA1qMhZ9xY=;
        h=Date:From:To:cc:Subject:In-Reply-To:References;
        b=tSn87r6YCtPVfkZ7AOH8a6y+vuSM6D/yfEl/4dnrCo3edcGH3CMUWIE/sVejP+wpB
         SK17M15O7oErm64CndBMfwRISbaqBUyh7MuG4iUDXdr1VStf+8JwXiIcs7s/AI5Kmo
         66HWW8NDMPZYDXAwKaVLFR0rl490kKiv3M9DU8tk=
X-CTU-FNSPE-Virus-Scanned: amavisd-new at fjfi.cvut.cz
Received: from mailgw1.fjfi.cvut.cz ([127.0.0.1])
        by localhost (mailgw1.fjfi.cvut.cz [127.0.0.1]) (amavisd-new, port 10022)
        with ESMTP id Xa472l_5-7j3; Thu,  7 Feb 2019 23:56:49 +0100 (CET)
Received: from linux.fjfi.cvut.cz (linux.fjfi.cvut.cz [147.32.5.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTPS id B5960AE33C;
        Thu,  7 Feb 2019 23:56:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailgw1.fjfi.cvut.cz B5960AE33C
Received: by linux.fjfi.cvut.cz (Postfix, from userid 1001)
        id 6167C6004E; Thu,  7 Feb 2019 23:56:48 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by linux.fjfi.cvut.cz (Postfix) with ESMTP id 5532C6004D;
        Thu,  7 Feb 2019 23:56:48 +0100 (CET)
Date:   Thu, 7 Feb 2019 23:56:48 +0100 (CET)
From:   David Kozub <zub@linux.fjfi.cvut.cz>
To:     Christoph Hellwig <hch@infradead.org>
cc:     Jens Axboe <axboe@kernel.dk>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Subject: Re: [PATCH v4 10/16] block: sed-opal: add ioctl for done-mark of
 shadow mbr
In-Reply-To: <20190204145244.GJ31132@infradead.org>
Message-ID: <alpine.LRH.2.21.1902072247060.29258@linux.fjfi.cvut.cz>
References: <1549054223-12220-1-git-send-email-zub@linux.fjfi.cvut.cz> <1549054223-12220-11-git-send-email-zub@linux.fjfi.cvut.cz> <20190204145244.GJ31132@infradead.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 4 Feb 2019, Christoph Hellwig wrote:

> On Fri, Feb 01, 2019 at 09:50:17PM +0100, David Kozub wrote:
>> From: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
>>
>> Enable users to mark the shadow mbr as done without completely
>> deactivating the shadow mbr feature. This may be useful on reboots,
>> when the power to the disk is not disconnected in between and the shadow
>> mbr stores the required boot files. Of course, this saves also the
>> (few) commands required to enable the feature if it is already enabled
>> and one only wants to mark the shadow mbr as done.
>>
>> Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
>> Reviewed-by: Scott Bauer <sbauer@plzdonthack.me>
>> ---
>>  block/sed-opal.c              | 33 +++++++++++++++++++++++++++++++--
>>  include/linux/sed-opal.h      |  1 +
>>  include/uapi/linux/sed-opal.h |  1 +
>>  3 files changed, 33 insertions(+), 2 deletions(-)
>>
>> diff --git a/block/sed-opal.c b/block/sed-opal.c
>> index 4b0a63b9d7c9..e03838cfd31b 100644
>> --- a/block/sed-opal.c
>> +++ b/block/sed-opal.c
>> @@ -1996,13 +1996,39 @@ static int opal_erase_locking_range(struct opal_dev *dev,
>>  static int opal_enable_disable_shadow_mbr(struct opal_dev *dev,
>>  					  struct opal_mbr_data *opal_mbr)
>>  {
>> +	u8 token = opal_mbr->enable_disable == OPAL_MBR_ENABLE
>> +		? OPAL_TRUE : OPAL_FALSE;
>>  	const struct opal_step mbr_steps[] = {
>>  		{ opal_discovery0, },
>>  		{ start_admin1LSP_opal_session, &opal_mbr->key },
>> -		{ set_mbr_done, &opal_mbr->enable_disable },
>> +		{ set_mbr_done, &token },
>>  		{ end_opal_session, },
>>  		{ start_admin1LSP_opal_session, &opal_mbr->key },
>> -		{ set_mbr_enable_disable, &opal_mbr->enable_disable },
>> +		{ set_mbr_enable_disable, &token },
>> +		{ end_opal_session, },
>> +		{ NULL, }
>
> This seems to be a change of what we pass to set_mbr_done /
> set_mbr_enable_disable and not really related to the new functionality
> here, so it should be split into a separate patch.
>
> That being said if we really care about this translation between
> the two sets of constants, why not do it inside
> set_mbr_done and set_mbr_enable_disable?

Hi Christoph,

I agree, this should be split. Furthermore I think I found an issue here: 
OPAL_MBR_ENABLE and OPAL_MBR_DISABLE are defined as follows:

enum opal_mbr {
 	OPAL_MBR_ENABLE = 0x0,
 	OPAL_MBR_DISABLE = 0x01,
};

... while OPAL_TRUE and OPAL_FALSE tokens are:

 	OPAL_TRUE = 0x01,
 	OPAL_FALSE = 0x00,

so in the current code in kernel, when the IOCTL input is directly passed 
in place of the TRUE/FALSE tokens (in opal_enable_disable_shadow_mbr), 
passing OPAL_MBR_ENABLE (0) to IOC_OPAL_ENABLE_DISABLE_MBR ends up being 
interpreted as OPAL_FALSE (0) and passing OPAL_MBR_DISABLE (1) ended up 
being interpreted as OPAL_TRUE (1). So the behavior is:

OPAL_MBR_ENABLE: set MBR enable to OPAL_FALSE and done to OPAL_FALSE
OPAL_MBR_DISABLE: set MBR enable to OPAL_TRUE and done to OPAL_TRUE

Am I missing something here? This seems wrong to me. And I think this 
patch actually changes it by introducing:

+    u8 token = opal_mbr->enable_disable == OPAL_MBR_ENABLE
+            ? OPAL_TRUE : OPAL_FALSE;

which is essentially a negation (map 0 to 1 and 1 to 0).

I had a strange feeling of IOC_OPAL_ENABLE_DISABLE_MBR behaving 
incorrectly when I first tried it. But when I checked later I was not able 
to reproduce it - probably originally I tested without this patch.

With regard to the new IOC_OPAL_MBR_STATUS: I find the usage of 
OPAL_MBR_ENABLE/DISABLE for this confusing: what should passing 
OPAL_MBR_ENABLE do? Should it enable the shadow MBR? Or should it 
enable the MBR-done flag? I think the implementation in this patch 
interprets OPAL_MBR_ENABLE as 'set the "done" flag to true', thus hiding 
the shadow MBR. But this is not obvious looking at the IOCTL name.

What if I introduced two new constants for this? OPAL_MBR_DONE and 
OPAL_MBR_NOT_DONE? Maybe the IOCTL could be renamed too - 
IOC_OPAL_MBR_DONE? Or is it only me who finds this confusing?

Best regards,
David
