Return-Path: <SRS0=Dd+4=PL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D8CC43387
	for <linux-block@archiver.kernel.org>; Thu,  3 Jan 2019 01:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CD7E2073F
	for <linux-block@archiver.kernel.org>; Thu,  3 Jan 2019 01:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfACBtP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Jan 2019 20:49:15 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:49114 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfACBtP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Jan 2019 20:49:15 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B2B73145E7465;
        Wed,  2 Jan 2019 17:49:14 -0800 (PST)
Date:   Wed, 02 Jan 2019 17:49:11 -0800 (PST)
Message-Id: <20190102.174911.1224897930304340408.davem@davemloft.net>
To:     ming.lei@redhat.com
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, matorola@gmail.com,
        sparclinux@vger.kernel.org
Subject: Re: [PATCH] block: sunvdc: don't run hw queue synchronously from
 irq context
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190103011948.25706-1-ming.lei@redhat.com>
References: <20190103011948.25706-1-ming.lei@redhat.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 02 Jan 2019 17:49:14 -0800 (PST)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Ming Lei <ming.lei@redhat.com>
Date: Thu,  3 Jan 2019 09:19:48 +0800

> vdc_blk_queue_start() may be called from irq context, so we can't run
> queue via blk_mq_start_hw_queues() since we never allow to run queue
> from irq context. Use blk_mq_start_stopped_hw_queues(q, true) to fix
> this issue.
> 
> Fixes: fa182a1fa97dff56cd ("sunvdc: convert to blk-mq")
> Reported-by: Anatoly Pugachev <matorola@gmail.com>
> Tested-by: Anatoly Pugachev <matorola@gmail.com>
> Cc: Anatoly Pugachev <matorola@gmail.com>
> Cc: David Miller <davem@davemloft.net>
> Cc: sparclinux@vger.kernel.org
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Acked-by: David S. Miller <davem@davemloft.net>
