Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF44C43334
	for <linux-block@archiver.kernel.org>; Tue,  7 Jun 2022 12:47:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244161AbiFGMrq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Jun 2022 08:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242948AbiFGMro (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Jun 2022 08:47:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83AD12ADF
        for <linux-block@vger.kernel.org>; Tue,  7 Jun 2022 05:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=Bv0rKT0dJtqD1+/kygX66Ygr1pk1PsYPko6y8tyQCA8=; b=dR9ft2Mya/Tyo3pYGYRyn+6jFl
        ZR9hDOxThTYmrcWYwIMH0B9snndcYVNjxqtpYrvjAXI+Dr5rns5bOrtRx7PpkjU9fNR7dTauRnO+S
        K2XK/Wm7uLInZa2JQMlnG9HDPEuFKO2d2H4/wZK5jbIznAP71+lMek6lXFl4rWU9pSeulk5Oge0bK
        z9iclBwJ8r2b51wNuu7/WtBJ6W7u7naLBXEBpK+s4E9hkN5w1TinufvVYyj/D04cCVASQcAvvqESX
        7lB6NoG0eRh+DZkHVqSLBbk2Zkh88UwSFFfNp6oYLlJBmpKNSrKS64/lc6grxMpCyK99LopEOSvO2
        krztoIAg==;
Received: from [2001:4bb8:190:726c:b34a:228:52ee:6d34] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nyYcY-007STF-8s; Tue, 07 Jun 2022 12:47:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org
Subject: allow to run most tests with built-in null_blk v2
Date:   Tue,  7 Jun 2022 14:47:26 +0200
Message-Id: <20220607124739.1259977-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Shin'ichiro,

this series updates most tests that use null_blk so that they can
work with a built-in null_blk driver.  The onces that require
shared_tags or failure injection, which currently can only be
controlled through module parameters still require a module until
the kernel is updated (which I plan to look into).

Changes since v1:
 - spelling fixes
 - fix the off by order of 1024 device sizing
 - make the modprobe -r call in _exit_null_blk quiet
 - explicitly load null_blk.ko in _configure_null_blk
