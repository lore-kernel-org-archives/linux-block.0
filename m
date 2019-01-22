Return-Path: <SRS0=aewy=P6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E989C282C3
	for <linux-block@archiver.kernel.org>; Tue, 22 Jan 2019 17:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6342C2085A
	for <linux-block@archiver.kernel.org>; Tue, 22 Jan 2019 17:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="uRPsBfNL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729394AbfAVRQT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Jan 2019 12:16:19 -0500
Received: from mail-it1-f169.google.com ([209.85.166.169]:55899 "EHLO
        mail-it1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728719AbfAVRQT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Jan 2019 12:16:19 -0500
Received: by mail-it1-f169.google.com with SMTP id m62so22640048ith.5
        for <linux-block@vger.kernel.org>; Tue, 22 Jan 2019 09:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=32CA6ORJskb39pWwQMqf2lJMW+v0Q/0blEWfAYtj/Uw=;
        b=uRPsBfNLD9xQZxz8vOona9U2GXe3heWfEb2HAnHJv1oWK087rPVMOJt1p7ClB5E+ot
         qD9Qz1ypfjP8trcln0Zhl3y5sA8i+DFc17f7rqyI0WyWjk7WIxeddj00mF8smhuvU6aZ
         nhK0gp+UJ/FTvkUNasJ5emPpxVIxMb4XB+JNFh/bQ3DENl1tj9WLd4aXk+l1ErRAZq6j
         sxBn+V5yCZ/rusrGJMvyzZY1lfc25AWGFeMUvBXNOMpcHfuKYqrojnGoDAsl2nI76aoV
         HE7Wbn4zMcX6eOFhxDpqtH3SDPIvKhvMtGpUBa+Ac9xrsTLSwrtu6dW4K9+rGPgQ2Bnl
         IRpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=32CA6ORJskb39pWwQMqf2lJMW+v0Q/0blEWfAYtj/Uw=;
        b=iBw0S+NvkYSmXuaKYSrYUlXgBNBkmIZ0KFzF0vu9FbDQ/PS6l8eBBWd2nx4cBsELXY
         cddJM74qJjMjTTuiY3G3A16ZFwx5SCzy0Uvd8015h6hCp9Y91gV8nrAnoHFy6+17IMZe
         YvtGlhcJdfuvT1vzsQrJ8OOjbTdyejLV7TFrxV5O1mYehq4/DhtPq0wAbsdIGtUbFIIf
         B2GuCwyWaVRjPpafnzqu/m7rc29r2jNfKyLuSgjpk9922+OF+Z9SyZBtFn+GO4aPQTMA
         VLekcyDrHE+zUdov6dGWBsLabeJ0ruMTV/kOASniwwc0bTBW1FM6I/yLbY2Z13uD/D71
         nzGA==
X-Gm-Message-State: AJcUukfbJqsOp18gUoQbIYD1yZvYTSVg5tQi+NtPYlIRKZvSiq6Dc9te
        n9utr4QFhF/YRHZM7cwWcAvWXQ==
X-Google-Smtp-Source: ALg8bN6X2GKErkkrlYZbRx7klWc3FyMhjBjiWkSJqE7M4jkrTgqMVpZMxl1KeRCLVXpHLGEBdJ2owQ==
X-Received: by 2002:a24:2716:: with SMTP id g22mr2327961ita.40.1548177378325;
        Tue, 22 Jan 2019 09:16:18 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id n124sm8509468itn.4.2019.01.22.09.16.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 09:16:17 -0800 (PST)
Subject: Re: block: cover another queue enter recursion via BIO_QUEUE_ENTERED
To:     Mike Snitzer <snitzer@redhat.com>, Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        NeilBrown <neilb@suse.com>
References: <20190122082017.9020-1-ming.lei@redhat.com>
 <20190122171504.GA11234@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e0a147a8-e936-e818-7f10-b32422ebe9cc@kernel.dk>
Date:   Tue, 22 Jan 2019 10:16:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190122171504.GA11234@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/22/19 10:15 AM, Mike Snitzer wrote:
> On Tue, Jan 22 2019 at  3:20am -0500,
> Ming Lei <ming.lei@redhat.com> wrote:
> 
>> Except for blk_queue_split(), bio_split() is used for splitting bio too,
>> then the remained bio is often resubmit to queue via generic_make_request().
>> So the same queue enter recursion exits in this case too. Unfortunatley
>> commit cd4a4ae4683dc2 doesn't help this case.
>>
>> This patch covers the above case by setting BIO_QUEUE_ENTERED before calling
>> q->make_request_fn.
>>
>> In theory the per-bio flag is used to simulate one stack variable, it is
>> just fine to clear it after q->make_request_fn is returned. Especially
>> the same bio can't be submitted from another context.
>>
>> Fixes: cd4a4ae4683dc2 ("block: don't use blocking queue entered for recursive bio submits")
>> Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>> Cc: Mike Snitzer <snitzer@redhat.com>
>> Cc: NeilBrown <neilb@suse.com>
>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> 
> Looks good, I'll drop my DM patch that set/cleared BIO_QUEUE_ENTERED.
> 
> Jens, you OK with picking this up for 5.0-rc?
> 
> Reviewed-by:  Mike Snitzer <snitzer@redhat.com>

I am, thanks both of you for looking into this. I'm a bit behind on email
and patches from over the long weekend.

-- 
Jens Axboe

