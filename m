Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68787C433DB
	for <linux-block@archiver.kernel.org>; Tue, 30 Mar 2021 03:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FA9A61996
	for <linux-block@archiver.kernel.org>; Tue, 30 Mar 2021 03:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbhC3DAr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 Mar 2021 23:00:47 -0400
Received: from eu-shark1.inbox.eu ([195.216.236.81]:58600 "EHLO
        eu-shark1.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbhC3DAV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Mar 2021 23:00:21 -0400
Received: from eu-shark1.inbox.eu (localhost [127.0.0.1])
        by eu-shark1-out.inbox.eu (Postfix) with ESMTP id 19AEA6C0174C;
        Tue, 30 Mar 2021 06:00:18 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1617073218; bh=TnXIbCBSN+HC1OG8+CsGEcBQ5zNKgqtLlrc9DB8j5FE=;
        h=References:From:To:Cc:Subject:Date:In-reply-to;
        b=eZxWwkTmjox5VLw5WSkG7U2Jje8/1SVRJh20EAoA5bF3GfD3mK8+jZ5Q3o10434mD
         MV7mP9yuxvPPUdYiSvjABchkZv69rVtQLzjTapnnrnaIcjJFXtHYHkBZB/BiyBF+Tb
         EI7RpvDFJwWOdMhk4iM3bGBs5CYNITn//6O3O4TE=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id 0AAFE6C0170A;
        Tue, 30 Mar 2021 06:00:18 +0300 (EEST)
Received: from eu-shark1.inbox.eu ([127.0.0.1])
        by localhost (eu-shark1.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id Lvnhz8UdmVtE; Tue, 30 Mar 2021 06:00:17 +0300 (EEST)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id 9631D6C00C15;
        Tue, 30 Mar 2021 06:00:17 +0300 (EEST)
Received: from nas (unknown [45.87.95.48])
        (Authenticated sender: l@damenly.su)
        by mail.inbox.eu (Postfix) with ESMTPA id 71A771BE0038;
        Tue, 30 Mar 2021 06:00:14 +0300 (EEST)
References: <20210323081440.81343-1-ming.lei@redhat.com>
 <20210323081440.81343-3-ming.lei@redhat.com>
User-agent: mu4e 1.5.8; emacs 27.1
From:   Su Yue <l@damenly.su>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] blktrace: limit allowed total trace buffer size
Date:   Tue, 30 Mar 2021 10:57:04 +0800
In-reply-to: <20210323081440.81343-3-ming.lei@redhat.com>
Message-ID: <mtul73da.fsf@damenly.su>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Virus-Scanned: OK
X-ESPOL: 6NpmlYxOGzysiV+lRWenZQszqjRBW/Ps/vm+2AEq4na6bm6YDTsAKnCr/x97SGA=
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Tue 23 Mar 2021 at 16:14, Ming Lei <ming.lei@redhat.com> wrote:

> On some ARCHs, such as aarch64, page size may be 64K, meantime 
> there may
> be lots of CPU cores. relay_open() needs to allocate pages on 
> each CPU
> blktrace, so easily too many pages are taken by blktrace. For 
> example,
> on one ARM64 server: 224 CPU cores, 16G RAM, blktrace finally 
> got
> allocated 7GB in case of 'blktrace -b 8192' which is used by 
> device-mapper
> test suite[1]. This way could cause OOM easily.
>
> Fix the issue by limiting max allowed pages to be 1/8 of 
> totalram_pages().
>
> [1] https://github.com/jthornber/device-mapper-test-suite.git
>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  kernel/trace/blktrace.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
> index c221e4c3f625..8403ff19d533 100644
> --- a/kernel/trace/blktrace.c
> +++ b/kernel/trace/blktrace.c
> @@ -466,6 +466,35 @@ static void blk_trace_setup_lba(struct 
> blk_trace *bt,
>  	}
>  }
>
> +/* limit total allocated buffer size is <= 1/8 of total pages 
> */
> +static void validate_and_adjust_buf(struct blk_user_trace_setup 
> *buts)
> +{
> +	unsigned buf_size = buts->buf_size;
> +	unsigned buf_nr = buts->buf_nr;
> +	unsigned long max_allowed_pages = totalram_pages() >> 3;
> +	unsigned long req_pages = PAGE_ALIGN(buf_size * buf_nr) >> 
> PAGE_SHIFT;
> +
> +	if (req_pages * num_online_cpus() <= max_allowed_pages)
> +		return;
> +
> +	req_pages = DIV_ROUND_UP(max_allowed_pages, 
> num_online_cpus());
> +
> +	if (req_pages == 0) {
> +		buf_size = PAGE_SIZE;
> +		buf_nr = 1;
> +	} else {
> +		buf_size = req_pages << PAGE_SHIFT / buf_nr;
>
Should it be:
buf_size = (req_pages << PAGE_SHIFT) / buf_nr;
?
The priority of '<<' is lower than '/', right? :)

--
Su
> +		if (buf_size < PAGE_SIZE)
> +			buf_size = PAGE_SIZE;
> +		buf_nr = req_pages << PAGE_SHIFT / buf_size;
> +		if (buf_nr == 0)
> +			buf_nr = 1;
> +	}
> +
> +	buts->buf_size = min_t(unsigned, buf_size, buts->buf_size);
> +	buts->buf_nr = min_t(unsigned, buf_nr, buts->buf_nr);
> +}
> +
>  /*
>   * Setup everything required to start tracing
>   */
> @@ -482,6 +511,9 @@ static int do_blk_trace_setup(struct 
> request_queue *q, char *name, dev_t dev,
>  	if (!buts->buf_size || !buts->buf_nr)
>  		return -EINVAL;
>
> +	/* make sure not allocate too much for userspace */
> +	validate_and_adjust_buf(buts);
> +
>  	strncpy(buts->name, name, BLKTRACE_BDEV_SIZE);
>  	buts->name[BLKTRACE_BDEV_SIZE - 1] = '\0';

