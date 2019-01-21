Return-Path: <SRS0=XolY=P5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A164C282DB
	for <linux-block@archiver.kernel.org>; Mon, 21 Jan 2019 09:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DED202084A
	for <linux-block@archiver.kernel.org>; Mon, 21 Jan 2019 09:13:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbfAUJNe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Jan 2019 04:13:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:52578 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726030AbfAUJNe (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Jan 2019 04:13:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C225FAF81;
        Mon, 21 Jan 2019 09:13:32 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 21 Jan 2019 10:13:32 +0100
From:   Roman Penyaev <rpenyaev@suse.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, hch@lst.de, jmoyer@redhat.com,
        avi@scylladb.com, linux-block-owner@vger.kernel.org
Subject: Re: [PATCH 05/17] Add io_uring IO interface
In-Reply-To: <20190118161225.4545-6-axboe@kernel.dk>
References: <20190118161225.4545-1-axboe@kernel.dk>
 <20190118161225.4545-6-axboe@kernel.dk>
Message-ID: <20204806b30147da55990e639586cce1@suse.de>
X-Sender: rpenyaev@suse.de
User-Agent: Roundcube Webmail
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019-01-18 17:12, Jens Axboe wrote:

[...]

> +
> +static int io_uring_create(unsigned entries, struct io_uring_params 
> *p,
> +			   bool compat)
> +{
> +	struct user_struct *user = NULL;
> +	struct io_ring_ctx *ctx;
> +	int ret;
> +
> +	if (entries > IORING_MAX_ENTRIES)
> +		return -EINVAL;
> +
> +	/*
> +	 * Use twice as many entries for the CQ ring. It's possible for the
> +	 * application to drive a higher depth than the size of the SQ ring,
> +	 * since the sqes are only used at submission time. This allows for
> +	 * some flexibility in overcommitting a bit.
> +	 */
> +	p->sq_entries = roundup_pow_of_two(entries);
> +	p->cq_entries = 2 * p->sq_entries;
> +
> +	if (!capable(CAP_IPC_LOCK)) {
> +		user = get_uid(current_user());
> +		ret = __io_account_mem(user, ring_pages(p->sq_entries,
> +							p->cq_entries));
> +		if (ret) {
> +			free_uid(user);
> +			return ret;
> +		}
> +	}
> +
> +	ctx = io_ring_ctx_alloc(p);
> +	if (!ctx)
> +		return -ENOMEM;

Hi Jens,

It seems pages should be "unaccounted" back here and uid freed if path
with "if (!capable(CAP_IPC_LOCK))" above was taken.

But really, could please someone explain me what is wrong with 
allocating
all urings in mmap() without touching RLIMIT_MEMLOCK at all?  Thus all
memory will be accounted to the caller app and if app is greedy it will
be killed by oom.  What I'm missing?

--
Roman


