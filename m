Return-Path: <SRS0=2dDp=UK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E5BC43218
	for <linux-block@archiver.kernel.org>; Tue, 11 Jun 2019 15:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F748206BB
	for <linux-block@archiver.kernel.org>; Tue, 11 Jun 2019 15:10:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e8hLzpWh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404460AbfFKPKX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Jun 2019 11:10:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44700 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404447AbfFKPKW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Jun 2019 11:10:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1uybRGCER4ck23OzEHTFty/nL17PvBLmNwqTpGnIuw0=; b=e8hLzpWhJEthv8oMV5OXSCC1a
        F25Xnva785Ty9QQ4n4oIhh+ewoVQIrws5eDGSgRCcMK8bHhbgu7YY4OYjGe/+BuxbPObA9GeXGgau
        m7YzHsjcVC2blUVRzkaoEE8bkduyFgyLdhTT/pDP0RRxZsiufJC9zPMIqMXVgcqYwGrgCfGflNzD8
        GL5W3RFAUMw/6JCaA3/NeBfElsqRnge2proHSDaVQDcxpQbCzrlY6kOABhtsjZibCc+hloqLdg7K5
        NIw28uOIvh5SGVu7aeggVUewmPcc3kT4LyVCkC0XTZtFpBWn9yBXqrdDpYaaQP3lYA+WtXJfHqwB2
        7Yv1XQfpw==;
Received: from mpp-cp1-natpool-1-037.ethz.ch ([82.130.71.37] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1haiPc-0000n5-4s; Tue, 11 Jun 2019 15:10:12 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>
Cc:     David Gibson <david@gibson.dropbear.id.au>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-block@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: alternative take on the same page merging leak fix
Date:   Tue, 11 Jun 2019 17:10:02 +0200
Message-Id: <20190611151007.13625-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens, hi Ming,

this is the tested and split version of what I think is the better
fix for the get_user_pages page leak, as it leaves the intelligence
in the callers instead of in bio_try_to_merge_page.
