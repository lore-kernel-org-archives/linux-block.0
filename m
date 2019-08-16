Return-Path: <SRS0=fyvH=WM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 351CAC3A589
	for <linux-block@archiver.kernel.org>; Fri, 16 Aug 2019 01:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00BD82064A
	for <linux-block@archiver.kernel.org>; Fri, 16 Aug 2019 01:21:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="SJlvcLO/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbfHPBVr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Aug 2019 21:21:47 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36442 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbfHPBVr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Aug 2019 21:21:47 -0400
Received: by mail-pf1-f194.google.com with SMTP id w2so2246232pfi.3
        for <linux-block@vger.kernel.org>; Thu, 15 Aug 2019 18:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6CKv4mkfNNk8RW3F42qCrFLU7TFR5atokUhC6zDK/OI=;
        b=SJlvcLO/iy3GJa6Jh0LuScAPOuD0mP6I/b7sDVRZ9C1md9sQv3dOf7llE6UHih6I15
         +tQDwsFIZq5W1K5MxHwxpo43YW3DLY4ChWPg07BlArmMhVxu2QFljFyx7VjHUo8ygwUQ
         8CmTHe63SQAPST8co8RsTwLRuik4uqOGhr6Uf1b1JKUPet4a3QCT2dS8s0NjQC+aKib8
         SANYKU1YtSPFKn1cUSNA9qkAdoMFOMyYQHEA2mFMOuOPVKWmDbmG8Lm8wlwd+TU3mKP8
         uYQMcVTxOvu6hZevRWpOtNp54WC//QlNzUM5De5laOtDyvCLeDNcmV4IWLDdByaVn/42
         8d4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6CKv4mkfNNk8RW3F42qCrFLU7TFR5atokUhC6zDK/OI=;
        b=oDAS6nbGk93o8+DgxPORmCJ3UdQ/dgjM9F3Ma7Ewe+26tfteGbD8PHXTQhKOF1eWEw
         ZDxoYsggeHeGAz9tiCdVb/JexQ110DhEnVGJNRpnN/1meqg2+SPWfwCLOcgsY2ZRoecf
         lAfa2nE+gM5dpsyQ1vKXM1eMHyYppHC5dxyxaMpVeDoUmoyy9qbdSoepUuhsVj8XAvGw
         3EMVjmnVfmNj84jVg8dcBcwfqpib3uKU7jjX9TaCSsaBYW+g78p8kV1nt/WUYHs6aAHT
         uxXjDrc01A3wojZscH6YH4GJWXCMuEljxCyZNQFbE3pgeQ7uDt0AGzJRtOCD6i9wPLKa
         pWgw==
X-Gm-Message-State: APjAAAWgTqb6m1rkLgi/N4DQGwaRI1usklvKG7XmTVSMZnIHu9VcbVJ9
        E/MPb7BrQET19BxrUbOReKgBFZmaATsbaQ==
X-Google-Smtp-Source: APXvYqyW18yDazXho5bnEg4o2CgBwUN4B8Qbw4ZSBQzppZFOz+bPI7x5W1v2mz5qoLYK0SI0MG9dww==
X-Received: by 2002:a63:f04:: with SMTP id e4mr5517761pgl.38.1565918505569;
        Thu, 15 Aug 2019 18:21:45 -0700 (PDT)
Received: from [192.168.1.188] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id v15sm3213137pfn.69.2019.08.15.18.21.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Aug 2019 18:21:44 -0700 (PDT)
Subject: Re: [PATCH 1/2] io_uring: fix issue when IOSQE_IO_DRAIN pass with
 IOSQE_IO_LINK
To:     Jackie Liu <liuyun01@kylinos.cn>
Cc:     linux-block@vger.kernel.org
References: <1565775322-10296-1-git-send-email-liuyun01@kylinos.cn>
 <d72a6911-d1fb-5c88-7992-8d4715ddbcc8@kernel.dk>
 <6EC9DDF3-3142-4FE1-831B-E5A823FBFC51@kylinos.cn>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ebe617aa-1a63-bd70-4096-e8f67b9f8adb@kernel.dk>
Date:   Thu, 15 Aug 2019 19:21:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <6EC9DDF3-3142-4FE1-831B-E5A823FBFC51@kylinos.cn>
Content-Type: text/plain; charset=gbk
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/15/19 6:48 PM, Jackie Liu wrote:
> 
> 在 2019年8月16日，01:07，Jens Axboe <axboe@kernel.dk> 写道：
> 
>>
>> On 8/14/19 3:35 AM, Jackie Liu wrote:
>>> Suppose there are three IOs here, and their order is as follows:
>>>
>>> Submit:
>>> 	[1] IO_LINK
>>> 	    |
>>> 	    |---  [2] IO_LINK | IO_DRAIN
>>> 		      |
>>> 		      |- [3] NORMAL_IO
>>>
>>> In theory, they all need to be inserted into the Link-list, but flag
>>> IO_DRAIN we have, io[2] and io[3] will be inserted into the defer_list,
>>> and finally, io[3] and io[2] will be processed at the same time.
>>>
>>> Now, it is directly forbidden to pass these two flags at the same time.
>>>
>>> Fixes: 9e645e1105c ("io_uring: add support for sqe links")
>>> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
>>> ---
>>>   fs/io_uring.c | 7 ++++++-
>>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/io_uring.c b/fs/io_uring.c
>>> index d542f1c..05ee628 100644
>>> --- a/fs/io_uring.c
>>> +++ b/fs/io_uring.c
>>> @@ -2074,10 +2074,13 @@ static void io_submit_sqe(struct io_ring_ctx *ctx, struct sqe_submit *s,
>>>   {
>>>   	struct io_uring_sqe *sqe_copy;
>>>   	struct io_kiocb *req;
>>> +	unsigned int flags;
>>>   	int ret;
>>>
>>> +	flags = READ_ONCE(s->sqe->flags);
>>>   	/* enforce forwards compatibility on users */
>>> -	if (unlikely(s->sqe->flags & ~SQE_VALID_FLAGS)) {
>>> +	if (unlikely((flags & ~SQE_VALID_FLAGS) ||
>>> +		     (flags & (IOSQE_IO_DRAIN | IOSQE_IO_LINK)))) {
>>
>> This doesn't look right, as any setting of either DRAIN or LINK would now
>> fail?
>>
>> Did you mean something ala:
>>
>> 	if ((flags & (IOSQE_IO_DRAIN | IOSQE_IO_LINK)) ==
>> 	    (IOSQE_IO_DRAIN | IOSQE_IO_LINK)) {
>> 		... fail ...
>> 	}
>>
>> which makes me worried that you didn't test this at all...
>>
>> -- 
>> Jens Axboe
> 
> Oh, yes, it's my fault, I just simulated it in my head, thank you for
> pointing out.  I think I'd add an [RFC PATCH] next time.

Even for an RFC, it better be more tested than just being thought
about... If something hasn't been run at all, it should always include
wording to that effect ("Totally untested, but something like this
perhaps"). I have higher expectations for even an RFC patch, I do expect
that to be both thought about AND tested.

> For this issue, I have two solutions, first is this, just avoid
> passing DRAIN and LINK at the same time; second is allow, let the SQE
> following LINK inherit the DRAIN flag, but It's more complicated, I
> prefer the first one.
> 
> I will rewrite this patch later, with a real test. Thanks again.

If an SQE has both set, it should first wait for any inflight sqe to
complete, then execute the chain. Once things have drained, it should
behave like an SQE that just had LINK set. I'd be interested in seeing a
patch that fixes this instead of just making it illegal, it seems to be
a valid use case.

-- 
Jens Axboe

