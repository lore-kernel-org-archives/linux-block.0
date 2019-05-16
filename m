Return-Path: <SRS0=mde3=TQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A9AAC04AB4
	for <linux-block@archiver.kernel.org>; Thu, 16 May 2019 08:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5279F205C9
	for <linux-block@archiver.kernel.org>; Thu, 16 May 2019 08:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lmEnSll9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfEPIls (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 May 2019 04:41:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33612 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbfEPIls (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 May 2019 04:41:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EeCKjhaduVtSZJnpKMcIjpCiszmkbuGPBmpfGcGwj28=; b=lmEnSll9k0JnqIF/czrq4/Iev
        oprJZFr5tUekpR2BKt27f9NcqI84sXd3cl/WQKVJcfsNZk+mXhDKPN/8ghqz0COKAcqyKQ58aRK44
        RmNmDOliE+e+q8muAJP11sfcx3bJmKAFhR5kgBf5lvJPBDQG8cElZtm/rsaHWFMI49YghurCfe3zG
        lnwQdxjbXBhJGS5Qhj4D6Da1OeLhRj4MOa6ZhWqBZIYf17er5BiKOqRIYdKkrzhV4UArIAFaG6r+m
        js1m8xtKLQjx7l47+fHpShdDPYIIGjAsrIpYMonA/h/fHQRK7n+VFN0wff/2hx9ZSg8oEy9hlckQx
        0XH4aF9Kw==;
Received: from 089144210233.atnat0019.highway.a1.net ([89.144.210.233] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hRBxR-0005OS-Np; Thu, 16 May 2019 08:41:46 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@fb.com
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org
Subject: fix nr_phys_segments vs iterators accounting v2
Date:   Thu, 16 May 2019 10:40:54 +0200
Message-Id: <20190516084058.20678-1-hch@lst.de>
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
good reason to have the front/back segement accounting to start
with.

Changes since v1:
  - update a commit log
  - add fixes tags
  - drop the follow on patches not suitable for 5.2
