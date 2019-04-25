Return-Path: <SRS0=cXaM=S3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9FCDC10F03
	for <linux-block@archiver.kernel.org>; Thu, 25 Apr 2019 07:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79C9A217D7
	for <linux-block@archiver.kernel.org>; Thu, 25 Apr 2019 07:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LL3I/UJw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387421AbfDYHFD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Apr 2019 03:05:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46736 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387404AbfDYHFC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Apr 2019 03:05:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ga6j2qI9PO4ghINZZ4RAq8H/0ATUZ+O7ohzce0trHtg=; b=LL3I/UJwERmumQigZ2SbIk0HF
        cPy239K/3HwRdHyeC7I130uAxqZzxLG1MODlV3Gx+m8FihmJw+l+p0ESiHc+3m18S14s0Re5Y9ejZ
        x+5l5LkhiBvN1VCt4+DAaU85cjK7JMxUdsWR09YXWoVe0h1MGQ2tiEk7EkEvq6QRPw91QIzPVaw+k
        CV0AGawZmO2bgC1dhBKFZM1zLuq+CLxM2kstK//HNYJOfs8uUwxkdvlwizfsvJnOfPAqhdwC3YWo2
        Mk3xw83nnGj6R3HCW/n/EhTHDyYe6ZE4ewybHPwojS6h39rZukjGwZNIIA9rvhlgXuimZ535FEJEu
        08FG3BQKQ==;
Received: from 213-225-37-80.nat.highway.a1.net ([213.225.37.80] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJYRJ-0006If-V5; Thu, 25 Apr 2019 07:05:02 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: bio_add_pc_page cleanups
Date:   Thu, 25 Apr 2019 09:04:32 +0200
Message-Id: <20190425070435.3478-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

please take a look at these trivial bio_add_pc_page cleanups.
