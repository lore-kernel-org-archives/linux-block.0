Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B455C07E9D
	for <linux-block@archiver.kernel.org>; Tue, 27 Sep 2022 06:50:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbiI0GuF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Sep 2022 02:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiI0GuE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Sep 2022 02:50:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D009F4B4BC
        for <linux-block@vger.kernel.org>; Mon, 26 Sep 2022 23:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ig/9IeIaotbm4chXStL8uNNJEevS08tdGD4wwqkMoS8=; b=YINGAhs6dzBGF1i9YU853+dEhm
        B8dXuL+vzEQrdqEciSLwmfLidipz4A+HB0htrHkoubjkrTlh3EJAdHrQHDX2bd4tKMWn0e47cIYjB
        Q1eruEN+uoN5H6RLzFzYbdQUBJJdF3Uy0ob3jbIBGjhIhNErGeAFuMMgfSqQWz47o8m1YLPkrtWH/
        Pnzjk9bZOlpZCz8Pd+dRPB4KNA6KgCOuYV+Z6CE3CfUtjwTTjTtGQT171HcOqfNBIPB/mXBKEMygX
        Kmj+pBZInoB99l3E60jazPElNPDuMyunA8v7Cg2qAVQigVWbU2lA95EZ0nQbHfLre1IrgKJTMUEY6
        KCgqOUvg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1od4Po-008etW-EV; Tue, 27 Sep 2022 06:50:00 +0000
Date:   Mon, 26 Sep 2022 23:50:00 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Keith Busch <kbusch@fb.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] blk-mq: use queisced elevator switch
Message-ID: <YzKdGAscBCIYLXzb@infradead.org>
References: <20220926210702.1776648-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220926210702.1776648-1-kbusch@fb.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good, although the subject has a spelling error and would benefit
from ammend where the quiesced switch is used, e.g.

blk-mq: use quiesced elevator switch when updating number of queues

Reviewed-by: Christoph Hellwig <hch@lst.de>
