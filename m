Return-Path: <SRS0=kGct=P2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB961C43387
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 08:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB1B420896
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 08:23:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbfARIXz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Jan 2019 03:23:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:59754 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727502AbfARIXz (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Jan 2019 03:23:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BA4C6AEF5;
        Fri, 18 Jan 2019 08:23:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 18 Jan 2019 09:23:53 +0100
From:   Roman Penyaev <rpenyaev@suse.de>
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-arch@vger.kernel.org, hch@lst.de, avi@scylladb.com,
        linux-block-owner@vger.kernel.org
Subject: Re: [PATCH 05/15] Add io_uring IO interface
In-Reply-To: <x4936pr80uw.fsf@segfault.boston.devel.redhat.com>
References: <20190116175003.17880-1-axboe@kernel.dk>
 <20190116175003.17880-6-axboe@kernel.dk>
 <718b4d1fbe9f97592d6d7b76d7a4537d@suse.de>
 <af41e99c-54f2-a94c-a876-d673fe477e0a@kernel.dk>
 <x49bm4f831e.fsf@segfault.boston.devel.redhat.com>
 <f5ecdead-ea0f-6b79-5f70-b002a103e503@kernel.dk>
 <02568485-cd10-182d-98e3-619077cf9bdc@kernel.dk>
 <x4936pr80uw.fsf@segfault.boston.devel.redhat.com>
Message-ID: <3189352fb5866022d782811a65022a50@suse.de>
X-Sender: rpenyaev@suse.de
User-Agent: Roundcube Webmail
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019-01-17 21:50, Jeff Moyer wrote:
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
>>>>>>> +	sq_ring = io_mem_alloc(struct_size(sq_ring, array, 
>>>>>>> p->sq_entries));
>>>>>> 
>>>>>> It seems that sq_entries, cq_entries are not limited at all.  Can 
>>>>>> nasty
>>>>>> app consume a lot of kernel pages calling io_setup_uring() from a 
>>>>>> loop
>>>>>> passing random entries number? (or even better: decreasing entries
>>>>>> number,
>>>>>> in order to consume all pages orders with min number of loops).
>>>>> 
>>>>> Yes, that's an oversight, we should have a limit in place. I'll add 
>>>>> that.
>>>> 
>>>> Can we charge the ring memory to the RLIMIT_MEMLOCK as well?  I'd 
>>>> prefer
>>>> not to repeat the mistake of fs.aio-max-nr.
>>> 
>>> Sure, we can do that. With the ring limited in size (it's now 4k 
>>> entries
>>> at most), the amount of memory gobbled up by that is much smaller 
>>> than
>>> the fixed buffers. A max sized ring is about 256k of memory.
> 
> Per io_uring.  Nothing prevents a user from calling io_uring_setup in a
> loop and continuing to gobble up memory.

What if we set a sane limit for a uring instance (not for the whole 
io_uring),
but allocate rings on mmap?  Then greedy / nasty app will be killed by 
oom.

--
Roman

