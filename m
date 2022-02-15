Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF62FC433FE
	for <linux-block@archiver.kernel.org>; Tue, 15 Feb 2022 10:05:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbiBOKGA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Feb 2022 05:06:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236307AbiBOKF7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Feb 2022 05:05:59 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C84913CD4
        for <linux-block@vger.kernel.org>; Tue, 15 Feb 2022 02:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=Xj4qIRWHRdWkUAVvbK40owa1x/9gn71ap4d2ZA9XH04=; b=DZxNva9cqRcunfJYX4uN6xXoW/
        vGSIhpjO7RBZMhBtsCZ9+W3aP8Z4XyFQEoNDwCSteyqW9JG0oTlAbmlX3MxmL6L+GnN9ETPeexYvM
        76OppiDcHu26oyLwb0KcjInABTV+mYHFNYZXPqNHzdDQGGI5cSHC/rVTnMYIeu84OCoGMESIJrTrr
        XQ2wZyNnuA/iWelz/IWZAPL3FEdLZduQ4H3VEW83vKmkoPybtsL2Q4tpWS3ysV6usZe5GGv/uiBa0
        UAsAkvQ//UntxnMq/RiVRWHaIgJGzAmsyG5EWt3LI1jlqka4QQCASPPNVSO4kDzQTfrE5yhzqaLQl
        TsPHA3PA==;
Received: from [2001:4bb8:184:543c:6bdf:22f4:7f0a:fe97] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJuiM-002Dzz-Js; Tue, 15 Feb 2022 10:05:43 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: make the blk-mq stacking interface optional
Date:   Tue, 15 Feb 2022 11:05:35 +0100
Message-Id: <20220215100540.3892965-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

this series requires an explicit select to use the blk-mq stacking
interfaces.  This means they don't get build without dm support, and
thus the buildbot should catch abuses like the one we had in the ufs
driver more easily.  And while I touched this code I also ended up
cleaning up various loose ends.

Diffstat:
 block/Kconfig          |    3 +++
 block/blk-mq.c         |   45 +++++++++------------------------------------
 drivers/md/Kconfig     |    1 +
 drivers/md/dm-rq.c     |   26 +++++++++-----------------
 include/linux/blk-mq.h |    3 +--
 5 files changed, 23 insertions(+), 55 deletions(-)
