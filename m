Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DBC1C433F5
	for <linux-block@archiver.kernel.org>; Wed,  1 Jun 2022 06:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245483AbiFAGs5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Jun 2022 02:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233201AbiFAGs4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Jun 2022 02:48:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68DEB954A4
        for <linux-block@vger.kernel.org>; Tue, 31 May 2022 23:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=4aroAkV9hqMPY4J3fHjOJ8aK1ZmGud0BInPy3cIbfy8=; b=U8CHWPtT4XtaL78W8OeygRsZCi
        e31xynRjfuOjarU4bH6lZkgSNlM9ZM9/2TpVrq/PDgKD5MxYRLb7KPZBdk8br2zufnXsJlynE26GD
        ac7aLHlqF0QgmzsAJ3hRWzOawkj2+HtLrDdMghhnkt/HZAHohOOKjnT3jlOv6BO4fEXyCLJw4bUaH
        VRsTWX6KkhHreMOK0yk+KGf90PEmmZ1/nkKizoayAota/ogbYjT8RKm0FzudkEgDeoBETB3JCECgW
        2dd7qiv4WR1FAQvYnomxCDGH7y8nnuZKx97u0drZP+J7NpgA2dQWau2Y4rK691AOA8tBHY4L0X8Jv
        SYxTD5pA==;
Received: from [2001:4bb8:185:a81e:471a:4927:bd2e:6050] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nwIA3-00EEYF-L3; Wed, 01 Jun 2022 06:48:56 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH blktests 6/7] scsi: don't require sg to be built in
Date:   Wed,  1 Jun 2022 08:48:36 +0200
Message-Id: <20220601064837.3473709-7-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220601064837.3473709-1-hch@lst.de>
References: <20220601064837.3473709-1-hch@lst.de>
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

