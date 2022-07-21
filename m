Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F59C43334
	for <linux-block@archiver.kernel.org>; Thu, 21 Jul 2022 13:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233908AbiGUNJa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Jul 2022 09:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234235AbiGUNJY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jul 2022 09:09:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755B111A
        for <linux-block@vger.kernel.org>; Thu, 21 Jul 2022 06:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=ZzsedOdQM/JJ/DntbtOybRWskpmoulpAvSue0E3oPv8=; b=nTmfFrrZChsnrkYeEwPTDMZJ5O
        prhKBim0LJThsf96t+rvJvExik9vFrgOQirdUNZbzxLyPjbVs0NRyjpvch2pSG327Bn5XR3x8gQtQ
        xKs4qAGwlAeVwM3d4OM8+DL+YwIRrVs7WmB+xgAi8zIHb9luJFLB8Q9fk3EmvNosaqZ35ke4OtS1T
        opJzugwdxfwY4LLOmy8I6qOx2+bDMP1CV4WtZ+F0Hs5uHTVy4z5w4lG1MoCO0/PRxpaBrbBBgOvVk
        7Wl6bDMSl/txhATe3evEHfny7OWrs1/KFevNSC4qXuYJUAOMl/eDiU00SvSc0LJ2zISJGc0diAGCD
        OzUAoTqg==;
Received: from [2001:4bb8:18a:6f7a:1b03:4d0e:b929:ebb2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oEVvb-006mhQ-5c; Thu, 21 Jul 2022 13:09:19 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: ublk fixups v2
Date:   Thu, 21 Jul 2022 15:09:08 +0200
Message-Id: <20220721130916.1869719-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Ming, hi Jens,

this series has a bunch of fixes and cleanups of ublk.  The most important
one is the last one, which moves ublk over to a proper gendisk life cycle.

This series passes the ubdsrv tests.

Changes since v1:
 - keep allocation the tag_set at ADD_DEV time, and use the tag_set mq_map
   for the GET_AFFINITY ioctl
 - call the debug dump helper on the right structure

Diffstat:
 MAINTAINERS                   |    7 
 drivers/block/ublk_drv.c      |  449 ++++++++++++++++++------------------------
 include/uapi/linux/ublk_cmd.h |    1 
 3 files changed, 202 insertions(+), 255 deletions(-)
