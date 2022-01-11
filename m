Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CEBC433EF
	for <linux-block@archiver.kernel.org>; Tue, 11 Jan 2022 08:34:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348935AbiAKIei (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Jan 2022 03:34:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346437AbiAKIeh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Jan 2022 03:34:37 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589C3C06173F
        for <linux-block@vger.kernel.org>; Tue, 11 Jan 2022 00:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=idOVtxgn12323QLg3AYWDEU1cOGoJUWrTbf6WqVChm0=; b=HBub7cboe9T9RvoO0iD5LuuZEk
        Gaq1oZmKcaN6p4pmBb8CvLMW2fHxcu6hH2Axo4l2W1ZVy1svZqeJiprI+bMHe5UmwLfypYuLkOc4P
        zvTCJ70rnOdkl8nAepbE2hL2iV5Khtt+igShGZHfwCgrJux7rG7tXoO/AM/bxygQlRGWiKWER2TZ8
        YbjCBkkkrR5V6GyFJgiuVsBnTdsCLIfSoJ5wXWsri+IO8M5YLZg1xRoELrI8R8ehUo8UBnmOafWxT
        8vY1AjJ4ZmguZHUtWDiHw94kzo8AR1HHN9TWNM9qMASVwy2eP0/aQMkCG0TrXMe99eyxxOCUOmDya
        DUI7DArA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n7Cbu-00FKhf-2T; Tue, 11 Jan 2022 08:34:30 +0000
Date:   Tue, 11 Jan 2022 00:34:30 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: Re: [dm-devel] [PATCH 0/3] blk-mq/dm-rq: support BLK_MQ_F_BLOCKING
 for dm-rq
Message-ID: <Yd1BFpYTBlQSPReW@infradead.org>
References: <20211221141459.1368176-1-ming.lei@redhat.com>
 <YcH/E4JNag0QYYAa@infradead.org>
 <YcP4FMG9an5ReIiV@T590>
 <YcuB4K8P2d9WFb83@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YcuB4K8P2d9WFb83@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 28, 2021 at 04:30:08PM -0500, Mike Snitzer wrote:
> Yeah, people use request-based for IO scheduling and more capable path
> selectors. Imposing bio-based would be a pretty jarring workaround for 
> BLK_MQ_F_BLOCKING. request-based DM should properly support it.

Given that nvme-tcp is the only blocking driver that has multipath
driver that driver explicitly does not intend to support dm-multipath
I'm absolutely against adding block layer cruft for this particular
use case.

SCSI even has this:

	        /*
		 * SCSI never enables blk-mq's BLK_MQ_F_BLOCKING flag so
		 * calling synchronize_rcu() once is enough.
		 */
		WARN_ON_ONCE(shost->tag_set.flags & BLK_MQ_F_BLOCKING);

