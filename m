Return-Path: <SRS0=CiZa=NZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1352DC43441
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 16:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0E7F208E7
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 16:02:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pI5N4I4K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0E7F208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731585AbeKOCGK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Nov 2018 21:06:10 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41620 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbeKOCGK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Nov 2018 21:06:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0Vd2wJ2tYkHvqYYHl/ZjVEpvnY1uv6JceXS/GXPbZLQ=; b=pI5N4I4KKvJBWPFK6HrWGVs79
        hY46juJYyunEAIMTWJdw7XP1Wsu+efrqDLFuxUVEnpyPxn/QIDBkrj7Uo8E/fhe0z3e7vGz2vkQDc
        cycKFIz3sHJjTilyfYJcyKmx7wkg5AGqML9nPenQ3G4QyaNcsIZ1rIJtS+ix3ldsImrzpIob7kC7X
        gIGSMr6ZMTMYQZAGdD6o1VlJ44zlxRRSJVkPnKMUSmuocLZISvmzC8UxUXpFwLU/RlLM/fKjmfyvF
        IYsRoJHcHEzkQBj5A+YLwPvgYFwHXhed1AoEQ6gr5ptd60s1PifVEaoHwW5xKOABX3F+8fYySPIV7
        hA2IAssXg==;
Received: from 089144211136.atnat0020.highway.a1.net ([89.144.211.136] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gMxcT-00067y-4N; Wed, 14 Nov 2018 16:02:21 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-mmc@vger.kernel.org,
        drbd-dev@lists.linbit.com
Subject: remove more legacy request leftover
Date:   Wed, 14 Nov 2018 17:02:03 +0100
Message-Id: <20181114160219.28328-1-hch@lst.de>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

this series removes another bunch of legacy request leftovers,
including the pointer indirection for the queue_lock.

Note that we have very few queue_lock users left, I wonder if
we should get rid of it entirely and have separate locks for
the cgroup and I/O scheduler code, which are the only heavy
users?
