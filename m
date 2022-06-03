Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38717C433EF
	for <linux-block@archiver.kernel.org>; Fri,  3 Jun 2022 04:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238915AbiFCE4E (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Jun 2022 00:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbiFCE4D (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Jun 2022 00:56:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72A036E10
        for <linux-block@vger.kernel.org>; Thu,  2 Jun 2022 21:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=jRtJGgD7wPt/jLJZB3mENSBiIv3I4OxlBVxIpB3RyPM=; b=3+wrxvmQKzuWL3rBI/dw2VQ504
        fzPVBN9HdPvhDFo8G8crNP5zRm/9R28JePEWe9K1cabSqZWOhQvN/pjsQ/R8AsUJ7/MSRitH1uscI
        ap08Ff1qQhyVoIY2P3fE2rxT0CJboiSsUdKCEzdWra5c6Gyf6+4bciG9rXA19HMgeLUUcvV5RS8b/
        ZrZrNsI+pN0cnR5mPm0aTC/8gYhauXXZilYbZAUYIHVzEDt0T0cwZ0c8oWloGPoNVwO9TJTZ+G/v0
        o5vrcv8x9ZUUOHXUjeS8KmSezJBb5jrZLl+BrJpbmeGTzVmIXe2+Qhojbr5nymTotTRneQZyCW/Pp
        a5cGt0tQ==;
Received: from [2001:4bb8:185:a81e:9865:e17e:4c0c:3e17] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nwzLs-005qO0-Pg; Fri, 03 Jun 2022 04:56:01 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org
Subject: allow to run most tests with built-in null_blk
Date:   Fri,  3 Jun 2022 06:55:45 +0200
Message-Id: <20220603045558.466760-1-hch@lst.de>
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
