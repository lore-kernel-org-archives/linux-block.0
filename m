Return-Path: <SRS0=CtFQ=OB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A574C43610
	for <linux-block@archiver.kernel.org>; Thu, 22 Nov 2018 11:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41E082087E
	for <linux-block@archiver.kernel.org>; Thu, 22 Nov 2018 11:13:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41E082087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390805AbeKVVwt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Nov 2018 16:52:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:60012 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732060AbeKVVws (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Nov 2018 16:52:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AC6FFABE6;
        Thu, 22 Nov 2018 11:13:52 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 031CE1E0A16; Thu, 22 Nov 2018 12:13:52 +0100 (CET)
Date:   Thu, 22 Nov 2018 12:13:51 +0100
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 8/8] aio: support for IO polling
Message-ID: <20181122111351.GD9840@quack2.suse.cz>
References: <20181120171953.1258-1-axboe@kernel.dk>
 <20181120171953.1258-9-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120171953.1258-9-axboe@kernel.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Tue 20-11-18 10:19:53, Jens Axboe wrote:
> +/*
> + * We can't just wait for polled events to come to us, we have to actively
> + * find and complete them.
> + */
> +static void aio_iopoll_reap_events(struct kioctx *ctx)
> +{
> +	if (!(ctx->flags & IOCTX_FLAG_IOPOLL))
> +		return;
> +
> +	while (!list_empty_careful(&ctx->poll_submitted) ||
> +	       !list_empty(&ctx->poll_completing)) {
> +		unsigned int nr_events = 0;
> +
> +		__aio_iopoll_check(ctx, NULL, &nr_events, 1, UINT_MAX);
> +	}
> +}
> +
> +static int aio_iopoll_check(struct kioctx *ctx, long min_nr, long nr,
> +			    struct io_event __user *event)
> +{
> +	unsigned int nr_events = 0;
> +	int ret = 0;
> +
> +	/* * Only allow one thread polling at a time */
> +	if (test_and_set_bit(0, &ctx->getevents_busy))
> +		return -EBUSY;
> +
> +	while (!nr_events || !need_resched()) {
> +		int tmin = 0;
> +
> +		if (nr_events < min_nr)
> +			tmin = min_nr - nr_events;
> +
> +		ret = __aio_iopoll_check(ctx, event, &nr_events, tmin, nr);
> +		if (ret <= 0)
> +			break;
> +		ret = 0;
> +	}
> +
> +	clear_bit(0, &ctx->getevents_busy);
> +	return nr_events ? nr_events : ret;
> +}

Hum, what if userspace calls io_destroy() while another process is polling
for events on the same kioctx? It seems we'd be reaping events from two
processes in parallel in that case which will result in various
"interesting" effects like ctx->poll_completing list corruption...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
