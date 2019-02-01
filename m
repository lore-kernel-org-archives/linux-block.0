Return-Path: <SRS0=mhrr=QI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB569C282D8
	for <linux-block@archiver.kernel.org>; Fri,  1 Feb 2019 07:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F60820869
	for <linux-block@archiver.kernel.org>; Fri,  1 Feb 2019 07:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n19Yh2Wb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbfBAH4H (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Feb 2019 02:56:07 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33972 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbfBAH4G (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Feb 2019 02:56:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cGKNHi2QmmKQIXBuU20qWHo/ZRWcynXEO8C20YUt52o=; b=n19Yh2WbLV5xsAOm3xeg8IBmo
        8ikAt23CZfY82rT4asZZuG73r6cwZkACT+TyyYDJ2BvfiYpde2FxoWygzOCy/vdVbDd1P1M/iKFRJ
        DH1TwIEuzMufxtk0Aun65VTAWDSWRZWG5F38ndh1h1Uf9eaWRKOCFkkXvxweaMXjSjXBZhdE2380q
        UWiOl8QOgK0Aj/5HVwqYSIPp7N46FabAnwksLl25VYwBh49IEr0HdPp/XRN/TOrhabVNiDSA1i3Mj
        pq6MBJzAABFjTJLPlYELTfSdbeuJRu747SF8sJJ766mhhV9Usw87dDqGF0uum8kxKyJ4aHT0QstTW
        3zDLtdgUw==;
Received: from 089144212163.atnat0021.highway.a1.net ([89.144.212.163] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gpTg8-0005Vj-Np; Fri, 01 Feb 2019 07:56:01 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk, martin.petersen@oracle.com, ooo@electrozaur.com
Cc:     Johannes Thumshirn <jthumshirn@suse.de>,
        Benjamin Block <bblock@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: remove exofs, the T10 OSD code and block/scsi bidi support V4
Date:   Fri,  1 Feb 2019 08:55:49 +0100
Message-Id: <20190201075557.9249-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The only real user of the T10 OSD protocol, the pNFS object layout
driver never went to the point of having shipping products, and we
removed it 1.5 years ago.  Exofs is just a simple example without
real life users.

The code has been mostly unmaintained for years and is getting in the
way of block / SCSI changes, and does not even work properly currently,
so I think it's finally time to drop it.

Quote from Boaz:

"As I said then. It is used in Universities for studies and experiments.
Every once in a while. I get an email with questions and reports.

But yes feel free to remove the all thing!!

I guess I can put it up on github. In a public tree.

Just that I will need to forward port it myself, til now you guys
been doing this for me ;-)"

Now the last time this caused a bit of a stir, but still no actual users,
not even for SG_IO passthrough commands.  So here we go again, this time
including removing everything in the scsi and block layer supporting it,
and thus shrinking struct request.
