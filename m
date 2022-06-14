Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B8EC433EF
	for <linux-block@archiver.kernel.org>; Tue, 14 Jun 2022 07:12:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353346AbiFNHMI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Jun 2022 03:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352657AbiFNHMH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Jun 2022 03:12:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED963B55A
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 00:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XaYagSW75B6nLaDXhgpvIsi+aS0I26iQBLM4oKHrCuc=; b=kIEn3K9z2SVKKi/qsjU8o/lgzz
        nUVdWNUIJaSdFdoOk8d/8UdNMg2ff5igayvvkAYnNqqgInEqb2YuT0qZ7ZmXR0N0wUuIRFXOMz6cu
        gWaNYMn069Glfdkig/P4XbWys7/2JireBK6jX/GqvJvhpdAvEMKvdeVCx0KGSW3ghr4mOZWDdZvKG
        TOKs5gEami/gEiW4N6MTcbVXFD8G+iLcdf8+9+fBnJmZDbE8hPQ1CEV1+Ic0/vDVBMiZxyRXglYws
        SZAjVlD1XC73wI/z9iArZpHdah3valJQfOLHh85RhuWRcobCl1FK0XqfnFl9C5d+2y72pHaMRIfPS
        TCctuV7w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o10iZ-007VAz-F3; Tue, 14 Jun 2022 07:12:03 +0000
Date:   Tue, 14 Jun 2022 00:12:03 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCH] block: fix rq_qos leak for bio based queue
Message-ID: <Yqg0w2tC6ac39ayJ@infradead.org>
References: <20220614064426.552843-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614064426.552843-1-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 14, 2022 at 02:44:26PM +0800, Ming Lei wrote:
> Commit 5ca7546fe317 ("block: move rq_qos_exit() into disk_release()")
> moves rq_qos_exit() to disk_release(), but only done for blk-mq queue.
> 
> However, now rq qos can be created via blkcg_init_queue() for bio based
> queue, so we need to call rq_qos_exit() for bio queue too.
> 
> In theory, so far, rq_qos is only implemented for request based queue,
> and we should only add it for blk-mq queue. However, if using blk-mq
> during allocating queue may not be known, fix the rq qos leak issue by
> always releasing rq qos for both two kinds of queues.

This is also fixed by "block: disable the elevator int del_gendisk"
which was just resent yesterday, and fundamentally gets the lifetimes
right rather than doctoring around even more.
