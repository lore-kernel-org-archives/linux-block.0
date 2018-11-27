Return-Path: <SRS0=Byed=OG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A7BC04EBA
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 10:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84B9F2086B
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 10:10:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84B9F2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbeK0VIS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Nov 2018 16:08:18 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39954 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbeK0VIS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Nov 2018 16:08:18 -0500
Received: by mail-wm1-f67.google.com with SMTP id q26so21447596wmf.5
        for <linux-block@vger.kernel.org>; Tue, 27 Nov 2018 02:10:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZpwRr9Usmhxjfdd2LUg8frRot24GZIBMVFJgRWYj9+o=;
        b=osTSHyI1CSzoEGMdt+QXHMovNfxbCwufAP680UcgCAUpXrWjTQZuS94QaIqvLal5dl
         n6kPoVngxtyavuLHkL21GBBYhsOjJAfsUoQ6Cfpyljqeoq0zaijyCepnqlccchxWM0Kz
         0B8l44oBAFyVmLGWx2V44TGH5BrRFnRpvPVtxOV9FmXFmBDisqHXwc96ZcVwaoiuEULa
         uHoyWPb4RCmg7pTlUyVAdKEs7OmPU/LRUhyKUDEFCRpKJ4i0lp+Ib2+XZ2EhZxuqifZp
         cOG9Lsbk2alHlFOZb1gSOJ1hv0VrdFaFxfwG/o02tDO25waKlgIePmA2Px8JuJ46hVRw
         u4mw==
X-Gm-Message-State: AGRZ1gKdxl9vlHPBk3fKB7iAxpnzxtyAP/aMzVOWLqFLd/nB4tuIBZlK
        xfe3yXZSvuBSFHpwg8DSP/0=
X-Google-Smtp-Source: AJdET5cjTOt3t6O46Fpv3NzpnYjn/HbZ37OoxNF6oWXu7mnU9U0K2Ki7CUINubAuetIaZEhs8Z6NXg==
X-Received: by 2002:a1c:b54b:: with SMTP id e72mr27098286wmf.73.1543313453022;
        Tue, 27 Nov 2018 02:10:53 -0800 (PST)
Received: from ?IPv6:2601:647:4800:973f:7888:b13c:bff:87b0? ([2601:647:4800:973f:7888:b13c:bff:87b0])
        by smtp.gmail.com with ESMTPSA id s16sm2398668wrt.77.2018.11.27.02.10.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 02:10:52 -0800 (PST)
Subject: Re: [PATCH 2/7] block: have ->poll_fn() return number of entries
 polled
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
References: <20181117214354.822-1-axboe@kernel.dk>
 <20181117214354.822-3-axboe@kernel.dk>
 <fb1200ad-35ef-1c2e-25cf-d8a71bc505b5@grimberg.me>
 <ba2d191c-cf9d-07f1-5875-6a07ef043949@kernel.dk>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <eee2f768-5ca2-aaa1-7d04-4fd7c9623312@grimberg.me>
Date:   Tue, 27 Nov 2018 02:10:48 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <ba2d191c-cf9d-07f1-5875-6a07ef043949@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>> We currently only really support sync poll, ie poll with 1
>>> IO in flight. This prepares us for supporting async poll.
>>
>> Hey Jens,
>>
>> So are we sure that this is fine to simply replace the
>> poll functionality? you say that that we support poll
>> with only 1 I/O inflight but is it entirely true?
>> semantically speaking?
> 
> It is, unless you have multiple threads all doing polling.  Which is
> pretty inefficient, as I'm sure you know.

I am, wasn't referring to multiple threads though..


>> The interface is selective polling, which means that
>> the user can have more than a single I/O inflight but wants
>> to poll for a specific one that it really cares about.
>>
>> Would this introduce a regression for users that rely
>> on preadv2 to basically "complete *this* IO as fast as possible"?
> 
> No, it'll be exactly the same, and believe me, I've done plenty of
> performance testing to ensure that it works well.  In fact, with the
> changes queued up and this on top, polling is both faster and more
> efficient than it ever has been before, for both the classic
> preadv2/pwritev2 and the async polled IO.

I don't argue that this has not been tested, I was referring to the
following use-case: app queues say 16 I/Os with io_submit and then
issues preadv2 for an "important" 512B sector.

With this proposed change, is poll_fn more likely to return with the
first completion it sees rather than continue poll until it sees that
specific I/O it polled for?

> I think that would be useless. For SYNC type polling with one thread, it
> doesn't matter if we're looking for a particular IO, or just any IO.
> Once your into two threads, you're already wasting huge amounts of CPU,
> just to get to QD=2. The poll loop handles finding each others IOs just
> fine, so there's no worry on that side.
> 
> Polling was originally designed for the strictly SYNC interfaces, and
> since we had the cookie anyway, it was tempting to look for a specific
> IO. I think that was a mistake, as it assumed that we'd never do async
> polling.

Not arguing. Just now that we already have the selective interface in
place I'm asking is it OK to change that (IFF the above question is
indeed real) esoteric as this use-case may be...
