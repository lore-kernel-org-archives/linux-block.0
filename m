Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0801DC433F5
	for <linux-block@archiver.kernel.org>; Wed,  1 Jun 2022 06:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241586AbiFAGsn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Jun 2022 02:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233201AbiFAGsm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Jun 2022 02:48:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B17F87A0F
        for <linux-block@vger.kernel.org>; Tue, 31 May 2022 23:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=I+b/oHM3AWbgLVV8FDuLkX1ZhVirbZYwsLB8JSIf0/w=; b=DxygcEk9U6wDKTAe3O6I+Si8yu
        GReV6fUw9xfK8GKLbWY42FVNZpnsVZ4vVXxCKyQg26NSOU6AkLmlqR8WZJwRfHgphYY0wefL8FBHk
        LCARtsxLQSD+uOSUQcoJhgfI7Wcka85Dt1wu9rnSPiv88y6K151s1MxnCWX8uIzr9IIu1Y1nvEHG3
        12hPc9LuijP+4q0bfMnU+Dc9Ag9jBUKSTBbSXdVhAJDxJ67sADKZ2/obg6AG2EoXDEZM+nke3IKfM
        L1/+gXJ9h6PxBG2th3fM6EyXHNF1b2BQR2GQ1fi2hsvUUltCYSj6O3KnxEqwwSwG01B1Q0IWIZlg4
        teKid6Mw==;
Received: from [2001:4bb8:185:a81e:471a:4927:bd2e:6050] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nwI9n-00EESH-Os; Wed, 01 Jun 2022 06:48:40 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org
Subject: reduce the dependency on modules v2
Date:   Wed,  1 Jun 2022 08:48:30 +0200
Message-Id: <20220601064837.3473709-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Shin'ichiro,

this series reduces the dependency of blktests on modular builds
of various block drivers.  There are still plenty of tests that
do require modules, mostly because a lot of scsi_debug and null_blk
can only be set at load time, but I plan to address those in the
kernel soon.

Changes since v1:
 - drop the partial null_blk and scsi_debug changes.  They caused to
   much trouble for just enabling one test each.
 - more quoting
 - two spelling fixes
