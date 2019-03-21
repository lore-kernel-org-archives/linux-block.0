Return-Path: <SRS0=o3qj=RY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 354D1C4360F
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 23:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB39F218D3
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 23:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oM21dYjc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbfCUXLA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Mar 2019 19:11:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42330 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727413AbfCUXLA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Mar 2019 19:11:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QI2fj1cuP4DMI2mYgpZWZTfBokyUQ59a/q+4zMVYux0=; b=oM21dYjcb/lT2mVseMmNtn7sz
        1iJCpMElXGmQP6EYn7vOA2RjlpBTs1WxScMUAjRAIyCDD5H8I6Nacrxn19gsGvaPj95AH56VhkaW+
        2lZ6tUeYkB8MhIXUA7fZ4IVOaOqsR3WK374l8ON7ntKrgZedNg4CoThNwV7qVnfKaX+3tZjf8sGRz
        mvziO0MrJFR/knbsA3ApbuW/OAXc6xQ+SpygfTaMdX8OUKVBnePqk23PgWvb8Ld/DzJan4xXcC7zB
        aCjKDv4G1I/trLnsfOzP4CG5KNb23SOw0R14mW63iWWFXyOgkf2hb13lpEH52tJXHUSF45qZJCp8Z
        NxjZTXDRg==;
Received: from [199.255.44.128] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h76pr-0002Ew-53; Thu, 21 Mar 2019 23:10:55 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@fb.com>, Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: [RFC] optimize nvme single segment I/O
Date:   Thu, 21 Mar 2019 16:10:22 -0700
Message-Id: <20190321231037.25104-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi all,

with all the discussion on small I/O performance lately I thought
it was time off to dust my old idea to optimize this path a bit
by avoiding to build a scatterlist.  I've only done very basic
testing because I've been a bit busy, but I thought it might be
worthwhile to get it out for feedback.
