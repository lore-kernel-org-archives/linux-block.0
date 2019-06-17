Return-Path: <SRS0=14Po=UQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F70C31E58
	for <linux-block@archiver.kernel.org>; Mon, 17 Jun 2019 09:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 625C320848
	for <linux-block@archiver.kernel.org>; Mon, 17 Jun 2019 09:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UInbDl/V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbfFQJO2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Jun 2019 05:14:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40712 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbfFQJO2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Jun 2019 05:14:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Jip0ZGg8mIlW0wx4ABnrNhzzgAzdJm1IqwVFVoEmP34=; b=UInbDl/VNAPdNLQhgzGt4KQQm
        A1NwUPgRnbXxcRx7IBioldtQ9EcxPO+s99ey3jsYgMYf35MtM8T8rG7n5sW6+aFSoXgSvAUVsRsUw
        rE4hE6FfkfiAvzAfKD64hSpZNtHYOrVVAFXp0uwbYT/B+WlXvBwnMfXYU0FT1213RbkqZnSXN7T8N
        gwbA7dID1S7c4IyHOS51dPUtr3jg6+udS2BgHla8ZZB5wKt+rcEzWu4Zz+23DVnpfQXAEKagKQqo+
        Rnw8AGPZlFWOPtqFemmFEutjWqxkMJ6EQ7M89ImZnycrQBPZgHsc/wDSEvDlOAUxpJTPkrDmVu/7J
        a7omV2aRA==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hcniS-00059k-ON; Mon, 17 Jun 2019 09:14:17 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>
Cc:     David Gibson <david@gibson.dropbear.id.au>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-block@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: same page merging leak fix v4
Date:   Mon, 17 Jun 2019 11:14:10 +0200
Message-Id: <20190617091412.15923-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens, hi Ming,

this is the tested and split version of what I think is the better
fix for the get_user_pages page leak, as it leaves the intelligence
in the callers instead of in bio_try_to_merge_page.

Changes since v2:
 - pass a proper same_page variable from the passthrough path

Changes since v1:
 - drop patches not required for 5.2
 - added Reviewed-by tags
