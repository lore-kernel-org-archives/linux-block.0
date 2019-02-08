Return-Path: <SRS0=HTWS=QP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8928DC169C4
	for <linux-block@archiver.kernel.org>; Fri,  8 Feb 2019 19:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 651D22177B
	for <linux-block@archiver.kernel.org>; Fri,  8 Feb 2019 19:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfBHTtM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Feb 2019 14:49:12 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:35920 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbfBHTtL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Feb 2019 14:49:11 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 4BCF6149B2693;
        Fri,  8 Feb 2019 11:49:10 -0800 (PST)
Date:   Fri, 08 Feb 2019 11:49:09 -0800 (PST)
Message-Id: <20190208.114909.2274258441884310233.davem@davemloft.net>
To:     axboe@kernel.dk
Cc:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org, hch@lst.de, jmoyer@redhat.com,
        avi@scylladb.com, jannh@google.com, viro@ZenIV.linux.org.uk,
        netdev@vger.kernel.org
Subject: Re: [PATCH 13/19] net: split out functions related to registering
 inflight socket files
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190208173423.27014-14-axboe@kernel.dk>
References: <20190208173423.27014-1-axboe@kernel.dk>
        <20190208173423.27014-14-axboe@kernel.dk>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 08 Feb 2019 11:49:10 -0800 (PST)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Jens Axboe <axboe@kernel.dk>
Date: Fri,  8 Feb 2019 10:34:17 -0700

> We need this functionality for the io_uring file registration, but
> we cannot rely on it since CONFIG_UNIX can be modular. Move the helpers
> to a separate file, that's always builtin to the kernel if CONFIG_UNIX is
> m/y.
> 
> No functional changes in this patch, just moving code around.
> 
> Cc: netdev@vger.kernel.org
> Cc: David S. Miller <davem@davemloft.net>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

No objections on my end, feel free to merge this in with your series.

Acked-by: David S. Miller <davem@davemloft.net>
