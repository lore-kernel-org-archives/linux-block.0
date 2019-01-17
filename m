Return-Path: <SRS0=sC6v=PZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32893C43387
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 20:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F26E620859
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 20:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="fjRezZAh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729529AbfAQUOM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Jan 2019 15:14:12 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:53291 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729313AbfAQUOM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Jan 2019 15:14:12 -0500
Received: by mail-it1-f196.google.com with SMTP id g85so3445620ita.3
        for <linux-block@vger.kernel.org>; Thu, 17 Jan 2019 12:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XyRrDI3BH5M0SQKfmOW5KmC4HdgD8pjALNOmbTA6qAM=;
        b=fjRezZAhlht5g3vpPbBL94ihrpsSDmU+UkqOod54zIRfnRVmyaSCmlqWnB/3f1fOqs
         OQ2tZlFaWri8N4NtUBUeWd3OIiixTtEzzRu+eOrgjoQBjfkKwYIkE5JAI+inMw93vvOi
         pEJUHzCtuO2ss/iy9bGSn0fbOkgOibfv/cZRV+LnBi95sEV3Tr0tyx2lfM2gEAoR+YMp
         6HMbJJYpMIm/cROCyqkX6a7IPnseTi+IEsfvkDQVEWjadJDJ5acK+ineqxjdgHaKayyq
         4c9QA+XmzeAo/y+aQOCINt3AswNrOLjglrqsCBCF+SGRyFKdprLwuTKaUV/rsLaLLGVR
         iYEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XyRrDI3BH5M0SQKfmOW5KmC4HdgD8pjALNOmbTA6qAM=;
        b=lPiigc7BQDMMYRoGoNUHjJFxbO1wYpFappumIAes+ldBr9zCv7ktMbWm7OcNpEkE7C
         n+oIId0SsnY43olgqtBpTlNPF+a/pa4IsoTgInNByfMswvTOLTDo86WBljmNR4dDkkZ1
         LC+WO5eABure31Mj4qaHyP92Ql950kiU4hHrcJO3hBRx31AvDGx6edJlBlLt7Fh062+6
         IzQN256VQiEX2IfpQtSfXWNxoN0noYV+9SNPc84XStmnMUdCs/Xu8y4JTDfT58NS/VC6
         KMKW9Cyvlz2FoYtE5BAsQpqxTlWfR8BuOJQs6nuFo3ljKA5eUZxdH94TYATcWLPH7yQc
         hjAg==
X-Gm-Message-State: AJcUukcfcRj/pnn9xPbUWGQgWlpOXtQFnby6oX/T5X9pF2dbn0kbLIev
        //F/0rln1Zp56FCUchkcAgAVXw==
X-Google-Smtp-Source: ALg8bN7o783jjdmJouM/SIB9WNij+RjQ6S4T56Pjc/qBzSPkM/CJxbLe3eBaVsGM2rmsqa5eyWoyuQ==
X-Received: by 2002:a02:b424:: with SMTP id i33mr9690951jaj.37.1547756051483;
        Thu, 17 Jan 2019 12:14:11 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id v19sm1144935itb.0.2019.01.17.12.14.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 12:14:10 -0800 (PST)
Subject: Re: [PATCH 05/15] Add io_uring IO interface
From:   Jens Axboe <axboe@kernel.dk>
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     Roman Penyaev <rpenyaev@suse.de>, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-arch@vger.kernel.org, hch@lst.de, avi@scylladb.com,
        linux-block-owner@vger.kernel.org
References: <20190116175003.17880-1-axboe@kernel.dk>
 <20190116175003.17880-6-axboe@kernel.dk>
 <718b4d1fbe9f97592d6d7b76d7a4537d@suse.de>
 <af41e99c-54f2-a94c-a876-d673fe477e0a@kernel.dk>
 <x49bm4f831e.fsf@segfault.boston.devel.redhat.com>
 <f5ecdead-ea0f-6b79-5f70-b002a103e503@kernel.dk>
Message-ID: <02568485-cd10-182d-98e3-619077cf9bdc@kernel.dk>
Date:   Thu, 17 Jan 2019 13:14:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <f5ecdead-ea0f-6b79-5f70-b002a103e503@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/17/19 1:09 PM, Jens Axboe wrote:
> On 1/17/19 1:03 PM, Jeff Moyer wrote:
>> Jens Axboe <axboe@kernel.dk> writes:
>>
>>> On 1/17/19 5:48 AM, Roman Penyaev wrote:
>>>> On 2019-01-16 18:49, Jens Axboe wrote:
>>>>
>>>> [...]
>>>>
>>>>> +static int io_allocate_scq_urings(struct io_ring_ctx *ctx,
>>>>> +				  struct io_uring_params *p)
>>>>> +{
>>>>> +	struct io_sq_ring *sq_ring;
>>>>> +	struct io_cq_ring *cq_ring;
>>>>> +	size_t size;
>>>>> +	int ret;
>>>>> +
>>>>> +	sq_ring = io_mem_alloc(struct_size(sq_ring, array, p->sq_entries));
>>>>
>>>> It seems that sq_entries, cq_entries are not limited at all.  Can nasty
>>>> app consume a lot of kernel pages calling io_setup_uring() from a loop
>>>> passing random entries number? (or even better: decreasing entries 
>>>> number,
>>>> in order to consume all pages orders with min number of loops).
>>>
>>> Yes, that's an oversight, we should have a limit in place. I'll add that.
>>
>> Can we charge the ring memory to the RLIMIT_MEMLOCK as well?  I'd prefer
>> not to repeat the mistake of fs.aio-max-nr.
> 
> Sure, we can do that. With the ring limited in size (it's now 4k entries
> at most), the amount of memory gobbled up by that is much smaller than
> the fixed buffers. A max sized ring is about 256k of memory.

One concern here is that, at least looking at my boxes, the default
setting for RLIMIT_MEMLOCK is really low. I'd hate for everyone to run
into issues using io_uring just because it seems to require root,
because the memlock limit is so low.

That's much less of a concern with the fixed buffers, since it's a more
esoteric part of it. But everyone should be able to setup a few io_uring
queues and use them without having to worry about failing due to an
absurdly low RLIMIT_MEMLOCK.

Comments?

-- 
Jens Axboe

