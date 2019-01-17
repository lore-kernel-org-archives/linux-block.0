Return-Path: <SRS0=sC6v=PZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34391C43387
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 20:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0388820873
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 20:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="j3Lz1rMw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbfAQUxQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Jan 2019 15:53:16 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:53764 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728995AbfAQUxO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Jan 2019 15:53:14 -0500
Received: by mail-it1-f196.google.com with SMTP id g85so3625807ita.3
        for <linux-block@vger.kernel.org>; Thu, 17 Jan 2019 12:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0Tr9g6uQYGDh9lFoFSkW7oFbHEBDEb1ZCM8QJ+f5RGw=;
        b=j3Lz1rMwgoZ03DwtDHEHtc366K54fZC1Ihv/zEsqPJJ01K3xoVs6pFF9MjBmiZfb2r
         0D6LwTFgussU9NhwXTMN+JmR1tryMQbCVc5pQo/9Y50mv8KZLogKcsMY5od4FhIHWn1l
         4bFdPQTZJehxyAVtguHRj7Afq2Y3Idg8VGst+cxhIh1zVtOKTA7AiujgmIO8GX+L9bPz
         a4SOV8io7YWkaY0vRdur6iisShnwsBAMcQi10uEmWICGAGUz9g6/2i14oEbetr2hFEWc
         +dHCXzXXGp4GhvG6tCTNsX/8HO8cTJtj3vRQgbxf5B4W229LyiyYKR1MnJ8NuRF87htp
         mIyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0Tr9g6uQYGDh9lFoFSkW7oFbHEBDEb1ZCM8QJ+f5RGw=;
        b=Flb9A8snc9LLf7cCGsmLHUnCkGglcrZRnVRh6qB3dk4SmYbGz9dJTJJ0PiCtykd24s
         3y+QNt89ENSlNnh2DTb/KCiTHWs03S1laMyWc5pZ9912arN585g3hhg3Kx9KFhkKeV30
         einFetBH5tisl6jmXM7UWvVD6kCdvLA7jVIIgvv4ZL18yCGbYCii3V46Sd/EIIhZBoCp
         JDsPloz9aXC3n9F6KvXjcGGP+z32QlvB0QVs+1lSdrdqYsVNe1qgcnlhukIDPxTRonaV
         w6fu9qfBBBsxD2eduyeJQ/aIypQMyLymMCu7tWRIFUPFpHRgvc5frCDux4Ks6fWYHv09
         cCWQ==
X-Gm-Message-State: AJcUukfx0E6yr+YdWpjJhr8TKeST0iQqokveHsvsICmi5Z3wkJiWoBVU
        YvkWS52N2U1ylN+bGpmv3NaTkw==
X-Google-Smtp-Source: ALg8bN4wV0wKWpVBCbYuEwQjJzCrcjf7IkrFBvRCcIvExQt5ZanCfAIvayrdfvELZVjLxWoGcJ8plQ==
X-Received: by 2002:a24:af07:: with SMTP id t7mr7757746ite.168.1547758393307;
        Thu, 17 Jan 2019 12:53:13 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id f142sm727700itc.15.2019.01.17.12.53.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 12:53:12 -0800 (PST)
Subject: Re: [PATCH 05/15] Add io_uring IO interface
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
 <02568485-cd10-182d-98e3-619077cf9bdc@kernel.dk>
 <x4936pr80uw.fsf@segfault.boston.devel.redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3180aa85-68a6-0eb2-082b-f177344cefa9@kernel.dk>
Date:   Thu, 17 Jan 2019 13:53:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <x4936pr80uw.fsf@segfault.boston.devel.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/17/19 1:50 PM, Jeff Moyer wrote:
> Jens Axboe <axboe@kernel.dk> writes:
> 
>> On 1/17/19 1:09 PM, Jens Axboe wrote:
>>> On 1/17/19 1:03 PM, Jeff Moyer wrote:
>>>> Jens Axboe <axboe@kernel.dk> writes:
>>>>
>>>>> On 1/17/19 5:48 AM, Roman Penyaev wrote:
>>>>>> On 2019-01-16 18:49, Jens Axboe wrote:
>>>>>>
>>>>>> [...]
>>>>>>
>>>>>>> +static int io_allocate_scq_urings(struct io_ring_ctx *ctx,
>>>>>>> +				  struct io_uring_params *p)
>>>>>>> +{
>>>>>>> +	struct io_sq_ring *sq_ring;
>>>>>>> +	struct io_cq_ring *cq_ring;
>>>>>>> +	size_t size;
>>>>>>> +	int ret;
>>>>>>> +
>>>>>>> +	sq_ring = io_mem_alloc(struct_size(sq_ring, array, p->sq_entries));
>>>>>>
>>>>>> It seems that sq_entries, cq_entries are not limited at all.  Can nasty
>>>>>> app consume a lot of kernel pages calling io_setup_uring() from a loop
>>>>>> passing random entries number? (or even better: decreasing entries 
>>>>>> number,
>>>>>> in order to consume all pages orders with min number of loops).
>>>>>
>>>>> Yes, that's an oversight, we should have a limit in place. I'll add that.
>>>>
>>>> Can we charge the ring memory to the RLIMIT_MEMLOCK as well?  I'd prefer
>>>> not to repeat the mistake of fs.aio-max-nr.
>>>
>>> Sure, we can do that. With the ring limited in size (it's now 4k entries
>>> at most), the amount of memory gobbled up by that is much smaller than
>>> the fixed buffers. A max sized ring is about 256k of memory.
> 
> Per io_uring.  Nothing prevents a user from calling io_uring_setup in a
> loop and continuing to gobble up memory.
> 
>> One concern here is that, at least looking at my boxes, the default
>> setting for RLIMIT_MEMLOCK is really low. I'd hate for everyone to run
>> into issues using io_uring just because it seems to require root,
>> because the memlock limit is so low.
>>
>> That's much less of a concern with the fixed buffers, since it's a more
>> esoteric part of it. But everyone should be able to setup a few io_uring
>> queues and use them without having to worry about failing due to an
>> absurdly low RLIMIT_MEMLOCK.
>>
>> Comments?
> 
> Yeah, the default is 64k here.  We should probably up that.  I'd say we
> either tackle the ridiculously low rlimits, or I guess we just go the
> aio route and add a sysctl.  :-\  I'll see what's involved in the
> former.

After giving it a bit of thought, let's go the rlimit route. It is cleaner,
and I don't want a sysctl knob for this either. 64k will enable anyone to
set up at least one decently sized ring.

-- 
Jens Axboe

