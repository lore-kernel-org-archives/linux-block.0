Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:35569 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751852AbdC0JOV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Mar 2017 05:14:21 -0400
Date: Mon, 27 Mar 2017 02:14:19 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jitendra Bhivare <jitendra.bhivare@broadcom.com>
Cc: linux-block@vger.kernel.org,
        Somnath Kotur <somnath.kotur@broadcom.com>
Subject: Re: [PATCH] blk-mq: Add NULL pointer check for HW dispatch queue
Message-ID: <20170327091419.GD6879@infradead.org>
References: <1490002801-16280-1-git-send-email-jitendra.bhivare@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1490002801-16280-1-git-send-email-jitendra.bhivare@broadcom.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Mar 20, 2017 at 03:10:01PM +0530, Jitendra Bhivare wrote:
> As part of blk_mq_realloc_hw_ctx(), if the init_hctx() ops is
> failed by the underyling transport, the hctx pointer is freed and
> initialized to NULL.
> However, functions down the line, access this hwctx pointer without
> a NULL pointer check, which could lead to a kernel crash.

Shouldn't we fail initializing the queue if any of the hctx allocations
fail?
