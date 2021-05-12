Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D80C433B4
	for <linux-block@archiver.kernel.org>; Wed, 12 May 2021 17:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B94D61059
	for <linux-block@archiver.kernel.org>; Wed, 12 May 2021 17:31:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235405AbhELRcV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 May 2021 13:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238515AbhELQyb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 May 2021 12:54:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F05C06134C
        for <linux-block@vger.kernel.org>; Wed, 12 May 2021 09:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=5Mzq8BGaLJAU1hwPcx/Yl6disjcASreZGp7sUN8MgtY=; b=Gqz65ElAbfM1iSXG2LCyqu1zP3
        MyXnOJguQIlat81jEv+yMUyaDzQeEWbHxJ8Eyoe2x15RWwQuEg7nnUSI9u65650jcVQFq+spVdFiu
        1dP3+IMTpJyTONr7kpOwosWC5vpTXtXiWIAFBFZ4IVZSt3CIw5QA6fHx2T/exM3B7ZKhPzd93Do3k
        YG/NkTkurgVrDUANAB6I16oS7Ej8yfwxLWdw34Lqt8lIuMsDXqjufmAVVSvJsDnrJpIa2dnFaGRPm
        wHl+EFKdhC5oJnvXTYbVxvY/Z9liz78EBeoWxChUqUM5xyazAzvTFdw2K8VgTd5HU8NFewckXiIR8
        uerKKGZg==;
Received: from [2001:4bb8:198:fbc8:1036:7ab9:f97a:adbc] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lgs4S-00AcH4-8U; Wed, 12 May 2021 16:50:52 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     Gulam Mohamed <gulam.mohamed@oracle.com>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
Subject: fix a race between del_gendisk and BLKRRPART
Date:   Wed, 12 May 2021 18:50:48 +0200
Message-Id: <20210512165050.628550-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi all,

this is based of a patch from Gulam and suggestions from Ming and fixes a
race between del_gendisk and BLKRRPART while also removing a global lock.


Diffstat:
 block/genhd.c         |   19 ++-----------------
 fs/block_dev.c        |   12 ++++--------
 include/linux/genhd.h |    2 --
 3 files changed, 6 insertions(+), 27 deletions(-)
