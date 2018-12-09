Return-Path: <SRS0=93Gy=OS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A41C07E85
	for <linux-block@archiver.kernel.org>; Sun,  9 Dec 2018 17:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C05920855
	for <linux-block@archiver.kernel.org>; Sun,  9 Dec 2018 17:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="mvcb8X4/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C05920855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbeLIRuy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 9 Dec 2018 12:50:54 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44430 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbeLIRuy (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 9 Dec 2018 12:50:54 -0500
Received: by mail-pl1-f194.google.com with SMTP id k8so4102908pls.11
        for <linux-block@vger.kernel.org>; Sun, 09 Dec 2018 09:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=n3fDLjtN9HluwYxr5S1AV21djoICktjCloPV+d7S070=;
        b=mvcb8X4/+L3IORywIk9ZY+Fb7gPPhG0b7OoCbbv1/LqlqGkmvYiRYbH2+igNNWHylC
         kh2Zwg2/SyOkfyBs4e18cicnd/GRY5WEzRhT6S5IuqDSNfJ1dLcp5rvURKTzR6tUkHn6
         iqnrM5jO+WM+36C5X2m5huCg24+wpxgaSN+oLBqNg6cFoIZ5nh7ICiFs/3DWCrQXI78r
         cUPysTRAbgKYUfdd3OEn9JdnxQAJBQvEnr6sdwI06SQmceGdKYqC+yPuCXKMTKYg5Vlt
         eN0jaUVid99ZAiZZuKeIuQmnan9mRKP6TywUy20x1fLlTmV7GLTGE8yfk415QCq+qE0R
         G7eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n3fDLjtN9HluwYxr5S1AV21djoICktjCloPV+d7S070=;
        b=oPthjPiZtrGUbDNeCRYV5BycMDrv8bH57wwbwvpuH1Ok/rT1kui4OAl6d2EnV2DVOw
         ctu7zMB7jWF5u8pTdD63GPC2ejYxJRIFpGowhK1B85fcSoO2xUBaz5ysX8vmLS5D4oyn
         T4S9m14GvKJ+4QMYlq2eE3KpVzPn3PJ7wJ2SgGC9vGtMVcKnmUzAKepEUgdIPm047PXG
         5biwyj7Tnans8+MPTePVr7uM7EC78VW80wP7WLJzs3HvYA9UcAa8SoDFFZrdTei07854
         MsSKFtwXnVNr6caIOivZygEHSS4m2vvJqKqHAeb5BeZjGfWoOqgH3gCOmTcdZdXy0h0j
         /xMA==
X-Gm-Message-State: AA+aEWZ5ta5+N42EcbkB0eBrc3UvYVxWYmYa6hGj0aBmYssjff2n+0Yr
        oWX9aMg/iJfoCsX7uzqX0W1XfQ==
X-Google-Smtp-Source: AFSGD/XYG3Ndq/+RD7n4Al0kf7cXHBQ0//rQYulQmGugSysBUP8j9XzeivYA5EF82ZvFTUecb1DCfw==
X-Received: by 2002:a17:902:96a:: with SMTP id 97mr9038956plm.45.1544377853315;
        Sun, 09 Dec 2018 09:50:53 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id u137sm13725376pfc.140.2018.12.09.09.50.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 09:50:52 -0800 (PST)
Subject: Re: [PATCH] sbitmap: silence bogus lockdep IRQ warning
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@osandov.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>
References: <20181209165847.GA31213@roeck-us.net>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f57e00fe-9f59-e1c2-2af3-8c41ebe1fe51@kernel.dk>
Date:   Sun, 9 Dec 2018 10:50:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181209165847.GA31213@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/9/18 9:58 AM, Guenter Roeck wrote:
> On Sun, Dec 09, 2018 at 07:26:47AM -0700, Jens Axboe wrote:
>>
>> Ming that lockdep spews the following trace. What this essentially says
>> is that the sbitmap swap_lock was used inconsistently in IRQ enabled
>> and disabled context, and that is usually indicative of a bug that will
>> cause a deadlock.
>>
>> For this case, it's a false positive. The swap_lock is used from process
>> context only, when we swap the bits in the word and cleared mask. We
>> also end up doing that when we are getting a driver tag, from the
>> blk_mq_mark_tag_wait(), and from there we hold the waitqueue lock with
>> IRQs disabled. However, this isn't from an actual IRQ, it's still
>> process context.
>>
>> Mark the swap_lock as not needing validation to silence this warning.
>>
> 
> checkpatch says:
> 
> $ scripts/checkpatch.pl jens2
> ERROR: lockdep_no_validate class is reserved for device->mutex.
> #357: FILE: lib/sbitmap.c:68:
> +		lockdep_set_novalidate_class(&sb->map[i].swap_lock);
> 
> ... which I think explains the warning I am seeing with this patch applied. 

Try the other patch I sent out earlier, that should work.

-- 
Jens Axboe

