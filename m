Return-Path: <SRS0=aEt0=ZG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4359C432C3
	for <linux-block@archiver.kernel.org>; Thu, 14 Nov 2019 17:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EE8C206CC
	for <linux-block@archiver.kernel.org>; Thu, 14 Nov 2019 17:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="NQN0ToqN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbfKNR2M (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Nov 2019 12:28:12 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37852 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbfKNR2L (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Nov 2019 12:28:11 -0500
Received: by mail-pg1-f196.google.com with SMTP id z24so4204001pgu.4
        for <linux-block@vger.kernel.org>; Thu, 14 Nov 2019 09:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=js0TL90vo6sSW24Wm6u1FZ4S0IhtgKMjo0707ZbmzkA=;
        b=NQN0ToqNOOUDmCh3U1/j4q6gsVLt7XxHxshTU6Xkrl7oLbr1lkXCLNo+JExlpPjoEe
         P7c4pB1IYNnPwFvL/xuT3YIocsv4lcS4EOgdiRU+F2IyHyU9/lytwUJWS+d1Xx2qlRnd
         z5JypwSQlzhFOp0MMa0ayIxOZUIpKoNEpZpctqh69491nJNu/sCTkBCNT8jEtvkw1pE7
         2bggZHmWKM5Gd7Land/513RShWM5lLCTBtUXlb4PMFQ9JIQ4rcR1Ifl9YPy0bie/H3aL
         8tBUBTEP45E0JFDD3EF+g1n/jHhE74JIVHcwKt8pFejq6knj4XAFZYomHbGXETtn5edV
         H+6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=js0TL90vo6sSW24Wm6u1FZ4S0IhtgKMjo0707ZbmzkA=;
        b=SRe5MiZRf3o+dx7Y24zLV+b2DwnY8W/WSoweGGO0unxvJAsYrujNeP8qbbk31S6Jsl
         D1IE47q7D97ImGv/hC+R76XmCJd2nintPUPOVMBMpiAI2Kca0BVreJQP5CKHWi2UibzH
         d6IYoYlD454V64wvTYulbFZjCmI2xgPdf5EbXsL7XnSYlJ3AusWv52fZfDfWvNsoFe9e
         3COTm2mX+zM3de6V16ShrLUx5PFsCsBejvqO+/ZK0rHB6KuD322cEh63rQNzV/raLrvA
         GHhFClwvu/s/UQ/G142mrA3wZOO/GTOnEkWessnQU9wgcKsj+hqi0HMbB7l/xg/DkA2+
         BC4w==
X-Gm-Message-State: APjAAAW3dkJLpin3pLZ8LuYfP17MdZC9fbJh+8NcXEiFS79IZY987P/n
        KlvCIn8bP4wcaX1jXGcLzSO+Zw==
X-Google-Smtp-Source: APXvYqwb14m5pYvfkZMDvLL43nFtZ1b+ueSMuJLXnmGddbDg3la/xhWgAd8fdMobFPFbDFVKPsse3A==
X-Received: by 2002:a17:90a:1048:: with SMTP id y8mr13826595pjd.22.1573752491227;
        Thu, 14 Nov 2019 09:28:11 -0800 (PST)
Received: from ?IPv6:2600:380:7557:6189:e427:d626:b0fd:93d1? ([2600:380:7557:6189:e427:d626:b0fd:93d1])
        by smtp.gmail.com with ESMTPSA id v23sm6996522pfm.175.2019.11.14.09.28.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Nov 2019 09:28:10 -0800 (PST)
Subject: Re: [PATCH] block: sed-opal: Introduce SUM_SET_LIST parameter and
 append it using 'add_token_u64'
To:     "Rajashekar, Revanth" <revanth.rajashekar@intel.com>,
        linux-block@vger.kernel.org
Cc:     Scott Bauer <sbauer@plzdonthack.me>,
        Jonathan Derrick <jonathan.derrick@intel.com>
References: <20191108230904.7932-1-revanth.rajashekar@intel.com>
 <e1bd6f75-b352-1ff8-af73-1ed9de04cff5@intel.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <63cfa17b-28df-ac52-30ac-d5d6bd93a116@kernel.dk>
Date:   Thu, 14 Nov 2019 10:28:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <e1bd6f75-b352-1ff8-af73-1ed9de04cff5@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/14/19 9:14 AM, Rajashekar, Revanth wrote:
> Hi,
> 
> On 11/8/2019 4:09 PM, Revanth Rajashekar wrote:
>> In function 'activate_lsp', rather than hard-coding the
>> short atom header(0x83), we need to let the function
>> 'add_short_atom_header' append the header based on the
>> parameter being appended.
>>
>> The paramete has been defined in Section 3.1.2.1 of
>> https://trustedcomputinggroup.org/wp-content/uploads/TCG_Storage-Opal_Feature_Set_Single_User_Mode_v1-00_r1-00-Final.pdf
>>
>> Signed-off-by: Revanth Rajashekar <revanth.rajashekar@intel.com>
>> ---
>>   block/opal_proto.h | 4 ++++
>>   block/sed-opal.c   | 6 +-----
>>   2 files changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/block/opal_proto.h b/block/opal_proto.h
>> index 736e67c3e7c5..325cbba2465f 100644
>> --- a/block/opal_proto.h
>> +++ b/block/opal_proto.h
>> @@ -205,6 +205,10 @@ enum opal_lockingstate {
>>   	OPAL_LOCKING_LOCKED = 0x03,
>>   };
>>   
>> +enum opal_parameter {
>> +	OPAL_SUM_SET_LIST = 0x060000,
>> +};
>> +
>>   /* Packets derived from:
>>    * TCG_Storage_Architecture_Core_Spec_v2.01_r1.00
>>    * Secion: 3.2.3 ComPackets, Packets & Subpackets
>> diff --git a/block/sed-opal.c b/block/sed-opal.c
>> index b2cacc9ddd11..880cc57a5f6b 100644
>> --- a/block/sed-opal.c
>> +++ b/block/sed-opal.c
>> @@ -1886,7 +1886,6 @@ static int activate_lsp(struct opal_dev *dev, void *data)
>>   {
>>   	struct opal_lr_act *opal_act = data;
>>   	u8 user_lr[OPAL_UID_LENGTH];
>> -	u8 uint_3 = 0x83;
>>   	int err, i;
>>   
>>   	err = cmd_start(dev, opaluid[OPAL_LOCKINGSP_UID],
>> @@ -1899,10 +1898,7 @@ static int activate_lsp(struct opal_dev *dev, void *data)
>>   			return err;
>>   
>>   		add_token_u8(&err, dev, OPAL_STARTNAME);
>> -		add_token_u8(&err, dev, uint_3);
>> -		add_token_u8(&err, dev, 6);
>> -		add_token_u8(&err, dev, 0);
>> -		add_token_u8(&err, dev, 0);
>> +		add_token_u64(&err, dev, OPAL_SUM_SET_LIST);
>>   
>>   		add_token_u8(&err, dev, OPAL_STARTLIST);
>>   		add_token_bytestring(&err, dev, user_lr, OPAL_UID_LENGTH);
> 
> Kind remainder to review this patch and throw your comments if any :)

I'll be happy to queue it up for 5.5, but Scott/Jonathan should
review/ack it first.

-- 
Jens Axboe

