Return-Path: <SRS0=OuBg=6W=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5364C38A2A
	for <linux-block@archiver.kernel.org>; Fri,  8 May 2020 08:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 809D5206D5
	for <linux-block@archiver.kernel.org>; Fri,  8 May 2020 08:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oH1sj15j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbgEHISj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 May 2020 04:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726922AbgEHISi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 May 2020 04:18:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2D9C05BD43;
        Fri,  8 May 2020 01:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=SCz/5fDbFeJge8pf2aofQUU4MkhPjaxjTbfpUInCcrg=; b=oH1sj15jPtuTgELMSO49xRyHG6
        Xz4T+yiM5JRheAq/G+39CcheBu0WmMHjwx6XysEsSHevttX6rly7elXR8/vfx1GspChmzwdHbr417
        /qrLsJvBG+yVXB8HlbGrjUAxHpXu7MVBFulDUPgtHHc/82I8Hr5pnujeLyLgPhw4jzOBeyy5L5iWQ
        NtT6PuSVvI/8UkX3X/7mJGUFy+iuAMvXyL3qzCWTZAlzKFBAPfEqMeAnGHINtB+Yn47PxMpt8ftJB
        Y1h7kIeqztwvKIc6qKG9wJrPe/cpY5Z5rJxoY8skYYlPaBpJRpkAzc76i82X3BMWc7e5HFkgZS4Ao
        7zgNe0xQ==;
Received: from [2001:4bb8:180:9d3f:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWyDN-0004OE-VL; Fri, 08 May 2020 08:18:38 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RESEND] last missing patch in the cdrom ioctl_by_bdev removal series
Date:   Fri,  8 May 2020 10:18:27 +0200
Message-Id: <20200508081828.590158-1-hch@lst.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

can you pick up this patch, which is the last missing one in converting
file systems away from using ioctl_by_bdev for CDROM information access?


