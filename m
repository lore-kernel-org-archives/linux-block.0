Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B5AC433EF
	for <linux-block@archiver.kernel.org>; Mon, 30 May 2022 13:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236327AbiE3NIj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 May 2022 09:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236335AbiE3NIi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 May 2022 09:08:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21E181980
        for <linux-block@vger.kernel.org>; Mon, 30 May 2022 06:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=4aroAkV9hqMPY4J3fHjOJ8aK1ZmGud0BInPy3cIbfy8=; b=mzVfXCFdPMqfOlMPh2DhTmm337
        FQ9Vbfvw/J2L0wBLfCXcBZ56p2GNzArxwgKCctBmbv+BFoTfgzs07+GC0WrJh2qMbblpixJLxlytz
        jc64j/D0bPYr+JFKliTNrsFdFAT6Qf+OyTxS8xeZAAPk4WyKOZ8cByZiGjJ2ebK5UltEykjoCi2UD
        Kj/Duyk89gwLvvs8ynjE7oVB+lTRM7XJlqiVlYSxta8ycFG6rfK+Lz9S5DzGVMMnTZAIGvFdGBLaE
        UMWdufopCQDQixtKLDDZsmJy2BGwpZ97B9Y1m3IZ3Caixb/vujdBZB7yMODBm3p3/l/bDnLKOAHZb
        yJSBGYHg==;
Received: from [2001:4bb8:185:a81e:fda9:da32:3b0c:8358] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nvf8L-006brG-TQ; Mon, 30 May 2022 13:08:34 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH blktests 7/9] scsi: don't require sg to be built in
Date:   Mon, 30 May 2022 15:08:09 +0200
Message-Id: <20220530130811.3006554-8-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220530130811.3006554-1-hch@lst.de>
References: <20220530130811.3006554-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use _have_driver instead of _have_modules in _have_scsi_generic as
nothing requires the sg driver to be modular.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/scsi/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/scsi/rc b/tests/scsi/rc
index c8d2f42..0751e77 100644
--- a/tests/scsi/rc
+++ b/tests/scsi/rc
@@ -15,7 +15,7 @@ group_device_requires() {
 }
 
 _have_scsi_generic() {
-	_have_modules sg
+	_have_driver sg
 }
 
 _require_test_dev_is_scsi() {
-- 
2.30.2

