Return-Path: <SRS0=bAqE=SN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E92C10F13
	for <linux-block@archiver.kernel.org>; Thu, 11 Apr 2019 06:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 708092082E
	for <linux-block@archiver.kernel.org>; Thu, 11 Apr 2019 06:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ui/9frl7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbfDKGX4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Apr 2019 02:23:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60370 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbfDKGX4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Apr 2019 02:23:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GyLiEuwmSDvgfgDVNlQrycxouzuZDlkHOzeNnN5hMEA=; b=Ui/9frl7lefnxv3yEzCcxU/ib
        BzDCZdi+LB9oHTZTQ07CTaULZs5ikgEs1/mv0opJWgc9T5Ii+W+baCDk8kdnZAdMqi+IIK0w6Ad3Y
        m7tC0k2c1RQuwpkcGQAiyOP98Gl3R5b6p09v//+/QAguC467s8uRgCc6Vd9bIKgZuNhCPz/df8sIK
        eRgDsiw5ps01UEOAqs4nU/BQSRUI9cXM7QUwDJ5Zpxr/ElRgwWEE5Xm7o0bg8K5waMjEsvJXe+6UV
        cxOUqYqzKLGCrnvTSLmmjGB+cJjQIKDTh21AJyUuiHXomyKBQH2U8JMILFAGWzpkU8+q27KKT3X/m
        u9bclQGiA==;
Received: from 089144214194.atnat0023.highway.a1.net ([89.144.214.194] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hET7q-0005LL-EY; Thu, 11 Apr 2019 06:23:54 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
Subject: avoid calling nth_page in the block I/O path v2
Date:   Thu, 11 Apr 2019 08:23:26 +0200
Message-Id: <20190411062331.27800-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

you complained about the overhead of calling nth_page in the multipage
bio_vec enabled I/O path a while ago.  While I can't really reproduce
the numbers on my (slower) hardware we could avoid the nth_page calls
pretty easily with a few tweaks.  Can you take a look at this series?

Changes since v1:
 - remove a spurious variable initialization
