Return-Path: <SRS0=J0qc=5I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 328DEC4332B
	for <linux-block@archiver.kernel.org>; Mon, 23 Mar 2020 11:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A35B206F9
	for <linux-block@archiver.kernel.org>; Mon, 23 Mar 2020 11:29:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbgCWL3L (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Mar 2020 07:29:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:50218 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728115AbgCWL3L (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Mar 2020 07:29:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E9708AD88;
        Mon, 23 Mar 2020 11:29:09 +0000 (UTC)
Date:   Mon, 23 Mar 2020 12:29:09 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Omar Sandoval <osandov@fb.com>, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH blktests v3 4/4] Add a test that triggers the
 blk_mq_realloc_hw_ctxs() error path
Message-ID: <20200323112909.wrbnlvdioe37mni7@beryllium.lan>
References: <20200320222413.24386-1-bvanassche@acm.org>
 <20200320222413.24386-5-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320222413.24386-5-bvanassche@acm.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Bart,

On Fri, Mar 20, 2020 at 03:24:13PM -0700, Bart Van Assche wrote:
> Add a test that triggers the code touched by commit d0930bb8f46b ("blk-mq:
> Fix a recently introduced regression in blk_mq_realloc_hw_ctxs()"). This
> test only runs if a recently added fault injection feature is available,
> namely commit 596444e75705 ("null_blk: Add support for init_hctx() fault
> injection").

[...]

> +test() {
> +	local i sq=/sys/kernel/config/nullb/nullb0/submit_queues
> +
> +	: "${TIMEOUT:=30}"
> +	if ! _init_null_blk nr_devices=0 queue_mode=2 "init_hctx=$(nproc),100,0,0"; then

Doesn't make the $(nproc) the test subtil depending on the execution
environment?

Thanks,
Daniel
