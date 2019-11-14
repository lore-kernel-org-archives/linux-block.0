Return-Path: <SRS0=aEt0=ZG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 911D2C432C3
	for <linux-block@archiver.kernel.org>; Thu, 14 Nov 2019 14:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6849220718
	for <linux-block@archiver.kernel.org>; Thu, 14 Nov 2019 14:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SdTYODw9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbfKNOem (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Nov 2019 09:34:42 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38494 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfKNOem (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Nov 2019 09:34:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=h0+KfShj/hbh9KorMa27iuNKVk2KN9dDikUHnkzzops=; b=SdTYODw9JHDo1+SRJOunPbjhQ
        Vz8Ku+nFOsspaFPbQuoxFG5zAZwSCbhNW0SSAmD1H/S6JFwzpb7biilIJ/cXPWVyFZ+2vunnJycvl
        T/GorzuVR06XI0I41beBhwbKTCcF5xYKpFYQKdzE2EXnGQMjYJs6jujCNfCtiOKrfr0KnTUs+ymYt
        yWJXNiYU8MARTfc8UAiG/QyoIg69LNZa6fQInaqannrSW9+uuQd8O3biLpW6Lisp2OlURF0fapWU2
        qN9JsHB9Abby3edc22UruWCbTxiw/548ypdWHj03q4nr9zB4dXrQ9RDyduOqjr7tlbVQff9UTa9XC
        35SC7Q9Yg==;
Received: from [2001:4bb8:180:3806:c70:4a89:bc61:6] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iVGCm-0004im-Qy; Thu, 14 Nov 2019 14:34:41 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>
Cc:     linux-block@vger.kernel.org, linux-s390@vger.kernel.org
Subject: disk revalidation cleanups and fixlets v2
Date:   Thu, 14 Nov 2019 15:34:31 +0100
Message-Id: <20191114143438.14681-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens and Jan,

this series takes the disk size change detection and revalidations
from Jan a step further and fully integrate the code path for
partitioned vs non-partitioned devices.  It also fixes up a few
bits where we have unintentionally differing behavior.

Changes since v1:
 - rebased on to of for-5.5/zoned
 - fixed a commit message
 - added two new trivial patches
