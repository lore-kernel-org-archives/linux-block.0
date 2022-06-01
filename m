Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE13CCA477
	for <linux-block@archiver.kernel.org>; Wed,  1 Jun 2022 14:51:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343741AbiFAOvP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Jun 2022 10:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346832AbiFAOvO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Jun 2022 10:51:14 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96DFE5DD1F
        for <linux-block@vger.kernel.org>; Wed,  1 Jun 2022 07:51:12 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 45F3821ADE;
        Wed,  1 Jun 2022 14:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654095071; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Jm3NkriK10clZPdZrhmicq7ayC5LHLat0jAGAYbr4Ig=;
        b=bArtzjr2MOhTfEoX7wMv8NAF0mDCwoLzjigECO9orZd/3LQr1qvUZRjnb+DHC1Ryb8z2IC
        +bCxXHwcUiM0Xd/M2nIE0K4i2M6AmTwivqjDg6HNULpAGC8cKLEBOmS6mhuhOH7mSZ47k3
        zJZB/3mHbjpCTiONCtE6DGfkNQFzZIU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654095071;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Jm3NkriK10clZPdZrhmicq7ayC5LHLat0jAGAYbr4Ig=;
        b=EOxJBaPUnyIAOQI/vlaGIt3BDWJDKVqe7zeB29qAGBYDPhScwdyhdAkhBbySuwudLZQ8fn
        EPiPOft73gH4hsDA==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 0D4DB2C142;
        Wed,  1 Jun 2022 14:51:11 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id B6645A0633; Wed,  1 Jun 2022 16:51:10 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 0/3] block: Fix IO priority mess
Date:   Wed,  1 Jun 2022 16:51:03 +0200
Message-Id: <20220601132347.13543-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1002; h=from:subject:message-id; bh=v2aEFdIVh/JRqrASgYvHiy3Nnk812G6k/4Y8Whj+9Cs=; b=owGbwMvMwME4Z+4qdvsUh5uMp9WSGJKm11xsbGN3PfDvrqRC/f6Fu8Pmnt/1T4nFoa5N1n1N+o2o VPODnYzGLAyMHAyyYoosqyMval+bZ9S1NVRDBmYQKxPIFAYuTgGYyHsBDoaZ9rdT3Z6LRW7Z6llQFx Ttamfr6KLr4GEeGppe33QhTcBij1je2cRwbX/dfSJLL+Vssj2WZ7FmOXvbxfSwjidCt0oqDxY+iu34 YHP9b/jOyAi7r273Tz63XRDlupzTUNZ54qUmlb8mkzUDW8+or5c7NPnTl0WVB2U0Virovyr3yP2zIG W6290r/ssaV6w5bnRYa+H0Ry4Fry7brJ5dNavO4niqYttZeRErb62Hf1iXaGpUrWFn4ogsdlJ7EHRJ kH2GvJmSu8wjxxXrF7YV63gJdjUITS7Zk3tXSqtZVPmNVMKGmTpH5z8N4Zm77pzI7tbVIQ+SNooXe9 cr5Gk3lhvfFI4OSdpmGrrSbYYXAA==
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

recently I've been looking into 10% regression reported by our performance
measurement infrastructure in reaim benchmark that was bisected down to
5a9d041ba2f6 ("block: move io_context creation into where it's needed"). This
didn't really make much sense and it took me a while to understand this but the
culprit is actually in even older commit e70344c05995 ("block: fix default IO
priority handling") and 5a9d041ba2f6 just made the breakage visible.
Essentially the problem was that after these commits some IO was queued with IO
priority class IOPRIO_CLASS_BE while other IO was queued with IOPRIO_CLASS_NONE
and as a result they could not be merged together resulting in performance
regression. I think what commit e70344c05995 ("block: fix default IO
priority handling") did is actually broken not only because of this performance
regression but because of other reasons as well (see changelog of patch 3/3
for details) so this patch set aims at fixing it.

								Honza
