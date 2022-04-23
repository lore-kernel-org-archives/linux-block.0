Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB526C433FE
	for <linux-block@archiver.kernel.org>; Sat, 23 Apr 2022 14:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiDWOnU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 23 Apr 2022 10:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbiDWOnN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 23 Apr 2022 10:43:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 060762EC
        for <linux-block@vger.kernel.org>; Sat, 23 Apr 2022 07:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650724813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=IkzhhVnkUxYjT/7gR1JFnmPpfNe00fJimbaY0ZI0gSg=;
        b=D62wGlUUUwJgQbz7xcGMElHqxUOIEiEE9l0meG1zCXv0buuhYgKqF3bx0ub6jcxAV9nMfJ
        szbyz7332PzbUT9M/vBmToZJ39Aq32yD3BIItd4lo7zBzJnL0jSlmb3zkvr3pHe2WIeTeG
        tFwVMvIjbp1zpopeoEZ+H1J0In6hU2M=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-331-iCPWoP0oMsSqycxLPCWBAg-1; Sat, 23 Apr 2022 10:40:07 -0400
X-MC-Unique: iCPWoP0oMsSqycxLPCWBAg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E8C941C04B48;
        Sat, 23 Apr 2022 14:40:05 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DA6ED5739A2;
        Sat, 23 Apr 2022 14:40:04 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 0/2] block: fix "Directory XXXXX with parent 'block' already present!"
Date:   Sat, 23 Apr 2022 22:39:50 +0800
Message-Id: <20220423143952.3162999-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

The 1st patch fixes declaration of debugfs_rename for avoiding warning
caused by the 2nd patch.

The 2nd patch fixes warning of "Directory XXXXX with parent 'block'
already present!"

Ming Lei (2):
  debugfs: fix declaration of debugfs_rename
  block: fix "Directory XXXXX with parent 'block' already present!"

 block/blk-core.c        | 4 ++++
 block/blk-sysfs.c       | 4 ++--
 block/genhd.c           | 8 ++++++++
 include/linux/debugfs.h | 2 +-
 4 files changed, 15 insertions(+), 3 deletions(-)

-- 
2.31.1

