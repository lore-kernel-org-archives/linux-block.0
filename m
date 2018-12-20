Return-Path: <SRS0=9Hvz=O5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A3EC43387
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 21:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F6AC218F0
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 21:26:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="EeoaOVpQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731225AbeLTV0Q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Dec 2018 16:26:16 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:39371 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730527AbeLTV0Q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Dec 2018 16:26:16 -0500
Received: by mail-it1-f193.google.com with SMTP id a6so3847565itl.4
        for <linux-block@vger.kernel.org>; Thu, 20 Dec 2018 13:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=kbBDZJveh4PMYMpZdJnjKao+B/F6qlN9GNJPtMDecrg=;
        b=EeoaOVpQXIEkU/X4C9idYmKaXiWIISUuB4pAFM/iPVai/LXzmDo+A4zNnHKgECg5Me
         z3Eul6kVXgKH81DZctfIpQdLgba67j0aF2Et/TH6SVzi7cHUwhJyhQhcCVSPtAM9CKZ1
         Nm1KdtUvFP2Aqzr/axfnOoPqdnHZsMfcqEF0cZ4+DWp8mCNb2Z1yUu35o9VSVDxQLltl
         flNGksDhhodDEDkouYw81eUWYC44bo8rDdv9Q8owwYr1dhFFIUoTB76JGul43QkX1DEn
         caw6whlWqQZztsWmtdsJPgRc5PHu1Tt+v94uNBCqyDKOFIKOy60e3ORZjy1VPdzJZSx5
         zQpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kbBDZJveh4PMYMpZdJnjKao+B/F6qlN9GNJPtMDecrg=;
        b=aJU85PxVuhwg9lhE86izQs5qTuZ2eJx58exhA+Ty9Bm/Um91OFeAS6DOBpTx4bAYkF
         lBGfuL4ej+DbJgGa2rwgBAKm3T8l915eaFDnWHv/T+dL9CYDIePaOUr7iHLdsuN7KJiT
         bsxF+esp41ewdWhiwh+TjiznpAvwjgSsxXIxGogu3bKXMdMuwEqut+nj8KHBDBE1qYq8
         ZtR4NcH0iH8+dqT2eeco9n8MT2noD+8zpUcBv4ZshdEzbLaAl0xovskQ16YoGV4HUa3N
         Q/4SUdPhYdlU3khdt1nvAXhvIVsWwi2uxkCpQ8gX//X30+PmzKS8CPsR4DEvJcbifQFK
         L8TA==
X-Gm-Message-State: AA+aEWb+0/KldiiJQ4NPukU3VHTTX0fORbNJpMf569pn9Wo2sSgwD2pJ
        XPdmXc4nlzTiIKWwQDeTCaAe9L4GXzA4Cg==
X-Google-Smtp-Source: AFSGD/Xxzt+YTfCrF57oHNcC+I37o1iA1mOOTd+ROT7F/3UaSbEDy8oTAilx+8vE4kSIY308OVWFYw==
X-Received: by 2002:a02:908d:: with SMTP id x13mr24471285jaf.65.1545341174926;
        Thu, 20 Dec 2018 13:26:14 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id m20sm6665265itm.29.2018.12.20.13.26.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 13:26:13 -0800 (PST)
Subject: Re: v4.20-rc6: Sporadic use-after-free in bt_iter()
To:     Bart Van Assche <bvanassche@acm.org>,
        "jianchao.wang" <jianchao.w.wang@oracle.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <1545261885.185366.488.camel@acm.org>
 <74c0280c-e557-ad03-cd75-98dd6d868da3@kernel.dk>
 <1545265001.185366.496.camel@acm.org>
 <1ca5cd37-87ce-8cff-6cb4-1fdb29bd4da2@kernel.dk>
 <0560802f-efc0-e9ec-99f7-4bdbdbc234f8@oracle.com>
 <c078750c-ff6b-4939-281b-7556d31dc74d@kernel.dk>
 <fe9dfe60-3cfc-9cfa-56c3-1365cbe8ec53@oracle.com>
 <a45c9931-ce8b-0ac8-f304-412c6042eff9@kernel.dk>
 <372d2960-ff0c-1135-28f9-23eea8670463@oracle.com>
 <ccf50ee5-ff34-39a0-d7eb-3853fee55a4c@kernel.dk>
 <6ae35005-7ba9-91e1-f315-d128f410c12c@kernel.dk>
 <1545328865.185366.508.camel@acm.org>
 <bd78b521-d0d4-22ec-ff7f-2d70709ca742@kernel.dk>
 <b9c3bd7c-9e82-7300-d525-0bd72ed66f66@kernel.dk>
 <1545339362.185366.511.camel@acm.org>
 <e7d6d857-b20a-245c-c6c7-fb9b110215e9@kernel.dk>
 <1545340987.185366.515.camel@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <120bb59a-af93-7d8c-9afc-7087973632bf@kernel.dk>
Date:   Thu, 20 Dec 2018 14:26:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1545340987.185366.515.camel@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/20/18 2:23 PM, Bart Van Assche wrote:
> On Thu, 2018-12-20 at 14:00 -0700, Jens Axboe wrote:
>> On 12/20/18 1:56 PM, Bart Van Assche wrote:
>>> @@ -96,6 +97,9 @@ static void blk_mq_check_inflight(struct blk_mq_hw_ctx *hctx,
>>>  {
>>>  	struct mq_inflight *mi = priv;
>>>  
>>> +	if (rq->q != mi->q)
>>> +		return;
>>
>> Aren't you back to square one with this one, if the tags are shared? You
>> can't dereference it before you know it matches.
> 
> My patch can only work if the new rq->q = NULL assignment in __blk_mq_free_request()
> is executed before the request tag is freed and if freeing a tag does not happen
> concurrently with any bt_iter() call. Would you accept that I add a seqlock to avoid
> this scenario?

Ugh no, let's not go that far. Why not just use my approach that avoids
any need to dereference rq, unless we know it belongs to the queue in
question? I think that's cheaper than resetting ->queue as well when the
rq completes, I'm always wary of adding new stores in the completion
path.

-- 
Jens Axboe

