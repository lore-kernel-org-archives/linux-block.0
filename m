Return-Path: <SRS0=TF98=TN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2BC6C04AB1
	for <linux-block@archiver.kernel.org>; Mon, 13 May 2019 06:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B401020879
	for <linux-block@archiver.kernel.org>; Mon, 13 May 2019 06:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Qzq1aLLq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbfEMGik (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 May 2019 02:38:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35908 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbfEMGij (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 May 2019 02:38:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Vh2FjkmtOCCA9fW+lAXSokRpIE9jVVR9Q8e0H4loa3Q=; b=Qzq1aLLq7kI4NmF9DNycrX6wW
        JmFydJTf2WBgfydDcp3NSK4UhFT8ngFR+NNnznqg7ATotvOSDKp6opkWzZ/Y/cOpnULj/7G9rL6mV
        Uh5z3iw45QRCuqN5HIdGEhh/eDWtPEKelJCEN/4FR13LedshNUfZ8znDIQtTxf9dBIs6oWtTDWA9H
        SHGUrd9TgHOjtaKEd6+MjYyr5WfAN4k7jSf3Sm2qWQCI1gpyafBhT3QD+ZKQX+Ekw6GBuTZkSpaL1
        wZBLKi+Gd6VGAMLt3ngFdANgVD/4Dj/BHch/wN8XeZF1dTAcCaTaN+GUrgXTlFRSvWzhTAgTVvnAf
        xNwQ4Iflw==;
Received: from 089144210233.atnat0019.highway.a1.net ([89.144.210.233] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hQ4bd-0007OG-6B; Mon, 13 May 2019 06:38:37 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@fb.com
Cc:     ming.lei@redhat.com, Matias Bjorling <mb@lightnvm.io>,
        linux-block@vger.kernel.org
Subject: fix nr_phys_segments vs iterators accounting
Date:   Mon, 13 May 2019 08:37:44 +0200
Message-Id: <20190513063754.1520-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi all,

we have had a problem for a while where the number of segments that
the bvec iterators will iterate over don't match the value in
req->nr_phys_segments, causing problems for anyone looking at
nr_phys_segments and iterating over bvec directly instead of using
blk_rq_map_sg.  The first patch in this series fixes this by
making sure nr_phys_segments matches the actual number of segments.
Drivers using blk_rq_map_sg will still get the lower number returned
from function eventually, but the fact that we don't reduce the
value earlier will not allow some merges that we might otherwise
allow.

With that in place I also noticed that we do not properly account
segements sizes on devices with a virt_boundary, but it turns out that
segment sizes fundamentally don't make sense for such devices, as their
"segment" is a fixed size "device page", and not a variable sized
scatter/gather elements as in the block layer, so we make that fact
formal.

Once all that is sorted out it is pretty clear that there is no
good reason to have the front/back segement accounting, and that
the bio nr_phys_segments is only needed in the submission path,
so we can remove three members of struct bio.
