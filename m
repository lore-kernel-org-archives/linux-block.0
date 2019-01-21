Return-Path: <SRS0=XolY=P5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C825C2F421
	for <linux-block@archiver.kernel.org>; Mon, 21 Jan 2019 15:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D4E720823
	for <linux-block@archiver.kernel.org>; Mon, 21 Jan 2019 15:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729344AbfAUP6K (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Jan 2019 10:58:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:38230 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728761AbfAUP6K (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Jan 2019 10:58:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3BEE3AC3B;
        Mon, 21 Jan 2019 15:58:09 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 21 Jan 2019 16:58:07 +0100
From:   Roman Penyaev <rpenyaev@suse.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, hch@lst.de, jmoyer@redhat.com,
        avi@scylladb.com, linux-block-owner@vger.kernel.org
Subject: Re: [PATCH 05/17] Add io_uring IO interface
In-Reply-To: <801e00ef-b21d-4420-9fa3-2b19fe2398b2@kernel.dk>
References: <20190118161225.4545-1-axboe@kernel.dk>
 <20190118161225.4545-6-axboe@kernel.dk>
 <20204806b30147da55990e639586cce1@suse.de>
 <801e00ef-b21d-4420-9fa3-2b19fe2398b2@kernel.dk>
Message-ID: <eb1e623843cd26ced5d06deb7fdb7851@suse.de>
X-Sender: rpenyaev@suse.de
User-Agent: Roundcube Webmail
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019-01-21 16:30, Jens Axboe wrote:
> On 1/21/19 2:13 AM, Roman Penyaev wrote:
>> On 2019-01-18 17:12, Jens Axboe wrote:
>> 
>> [...]
>> 
>>> +
>>> +static int io_uring_create(unsigned entries, struct io_uring_params
>>> *p,
>>> +			   bool compat)
>>> +{
>>> +	struct user_struct *user = NULL;
>>> +	struct io_ring_ctx *ctx;
>>> +	int ret;
>>> +
>>> +	if (entries > IORING_MAX_ENTRIES)
>>> +		return -EINVAL;
>>> +
>>> +	/*
>>> +	 * Use twice as many entries for the CQ ring. It's possible for the
>>> +	 * application to drive a higher depth than the size of the SQ 
>>> ring,
>>> +	 * since the sqes are only used at submission time. This allows for
>>> +	 * some flexibility in overcommitting a bit.
>>> +	 */
>>> +	p->sq_entries = roundup_pow_of_two(entries);
>>> +	p->cq_entries = 2 * p->sq_entries;
>>> +
>>> +	if (!capable(CAP_IPC_LOCK)) {
>>> +		user = get_uid(current_user());
>>> +		ret = __io_account_mem(user, ring_pages(p->sq_entries,
>>> +							p->cq_entries));
>>> +		if (ret) {
>>> +			free_uid(user);
>>> +			return ret;
>>> +		}
>>> +	}
>>> +
>>> +	ctx = io_ring_ctx_alloc(p);
>>> +	if (!ctx)
>>> +		return -ENOMEM;
>> 
>> Hi Jens,
>> 
>> It seems pages should be "unaccounted" back here and uid freed if path
>> with "if (!capable(CAP_IPC_LOCK))" above was taken.
> 
> Thanks, yes that is leaky. I'll fix that up.
> 
>> But really, could please someone explain me what is wrong with
>> allocating
>> all urings in mmap() without touching RLIMIT_MEMLOCK at all?  Thus all
>> memory will be accounted to the caller app and if app is greedy it 
>> will
>> be killed by oom.  What I'm missing?
> 
> I don't really what that'd change, if we do it off the ->mmap() or when
> we setup the io_uring instance with io_uring_setup(2). We need this 
> memory
> to be pinned, we can't fault on it.

Hm, I thought that for pinning there is a separate counter ->pinned_vm
(introduced by bc3e53f682d9 ("mm: distinguish between mlocked and pinned
pages")  Which seems not wired up with anything, just a counter, used by
couple of drivers. Hmmm.. Frankly, now I am lost. You map these pages
through remap_pfn_range(), so virtual user mapping won't fault, right?
And these pages you allocate with GFP_KERNEL, so they are already 
pinned.
So now I do not understand why this accounting is needed at all :)
The only reason I had in mind is some kind of accounting, to filter out
greedy and nasty apps.  If this is not the case, then I am lost.
Could you please explain?

--
Roman



