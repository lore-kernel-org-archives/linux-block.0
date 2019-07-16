Return-Path: <SRS0=S2CA=VN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A3FC76188
	for <linux-block@archiver.kernel.org>; Tue, 16 Jul 2019 08:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 752F220659
	for <linux-block@archiver.kernel.org>; Tue, 16 Jul 2019 08:35:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbfGPIf3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Jul 2019 04:35:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45708 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727829AbfGPIf2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Jul 2019 04:35:28 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AED12C057EC0;
        Tue, 16 Jul 2019 08:35:28 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id 8F193600C1;
        Tue, 16 Jul 2019 08:35:27 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 16 Jul 2019 10:35:28 +0200 (CEST)
Date:   Tue, 16 Jul 2019 10:35:26 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, kernel-team@fb.com,
        peterz@infradead.org
Subject: Re: [PATCH 4/4] rq-qos: don't reset has_sleepers on spurious wakeups
Message-ID: <20190716083526.GB15528@redhat.com>
References: <20190715201120.72749-1-josef@toxicpanda.com>
 <20190715201120.72749-5-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190715201120.72749-5-josef@toxicpanda.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 16 Jul 2019 08:35:28 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 07/15, Josef Bacik wrote:
>
> If we had multiple sleepers before we don't need to worry about never
> being woken up.  If we're woken up randomly without having gotten our
> inflight token then we need to go back to sleep, we won't be properly
> woken up without being given our inflight token anyway so this resetting
> isn't needed.

Yes, and this means that we can avoid acquire_inflight_cb() if e're woken
up randomly, so

> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  block/blk-rq-qos.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
> index f4aa7b818cf5..35bc6f54d088 100644
> --- a/block/blk-rq-qos.c
> +++ b/block/blk-rq-qos.c
> @@ -261,7 +261,6 @@ void rq_qos_wait(struct rq_wait *rqw, void *private_data,
>  			break;
>  		}
>  		io_schedule();
> -		has_sleeper = false;

I still think it should do

		has_sleeper = true;

Oleg.

