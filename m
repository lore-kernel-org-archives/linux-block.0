Return-Path: <SRS0=Ef4g=6A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A142C352BE
	for <linux-block@archiver.kernel.org>; Thu, 16 Apr 2020 16:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38A902076D
	for <linux-block@archiver.kernel.org>; Thu, 16 Apr 2020 16:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GuWc+GrB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732631AbgDPQzM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Apr 2020 12:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728178AbgDPQzJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Apr 2020 12:55:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32977C061A0F;
        Thu, 16 Apr 2020 09:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=d7Vlwe2aKDqTMiX+cGDF/ob+g8bDVVcumQ1n7FVFp2g=; b=GuWc+GrBqIhCrk85P1n1+uMQ47
        xrhSRybfRHQ8iNjRq/o1CFSgsDDBue9h/D6KpN5gy9hTcSl/uOm3HxnqaZ8hpkzfdcgcOkyco6lPQ
        X0rrg0qbeodKBPgHskr0MeXDaREJzX3nQQITe+9FPOpPlqcr4ml1TagbeSY50QNB+y6PtGBlFZxUQ
        E6jgWl/ZciN8TyblGUj0FCMILr7oFE18biZucrDe3X1zLpOe/tN2QkuMutUF0sHZh29rK5Q7D0QB0
        G/sfqxox9pIoQmfzBa7znZFwKM13/AWBLUIKNO2Py3T3HhugZxP//2efkFS54slnWrdPRzdpgpZgM
        rT2VWw+A==;
Received: from [2001:4bb8:184:4aa1:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jP7my-0001xa-4G; Thu, 16 Apr 2020 16:54:56 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     yuyufen@huawei.com, tj@kernel.org, jack@suse.cz,
        bvanassche@acm.org, tytso@mit.edu, gregkh@linuxfoundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: bdi: fix use-after-free for dev_name(bdi->dev) v2
Date:   Thu, 16 Apr 2020 18:54:45 +0200
Message-Id: <20200416165453.1080463-1-hch@lst.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi all,

the first three patches are my take on the proposal from Yufen Yu
to fix the use after free of the device name of the bdi device.

The rest is vaguely related cleanups.

Changes since v1:
 - use a static dev_name buffer inside struct backing_dev_info
