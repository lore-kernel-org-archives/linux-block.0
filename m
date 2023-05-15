Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BFA3C77B7D
	for <linux-block@archiver.kernel.org>; Mon, 15 May 2023 14:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232713AbjEOOtJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 May 2023 10:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjEOOtH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 May 2023 10:49:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94EB710C2
        for <linux-block@vger.kernel.org>; Mon, 15 May 2023 07:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684162084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=kxIb/DJVvTKsZSfT583qaAtwd5bsP9iPO2Cu0acztiE=;
        b=ShuL9TnRgWPaTVCM/3mW0wMCQztHFUUx/Dy4dhx0gHSaXG8NjNDkISFTR2YScZYzwy1yz/
        e0AVfKenzPEtWXFTYeipW4Armpw6yY4iG7AxBARif8ksU7to85b4jywOB7Tytr6UT+wzP3
        NS+LpT1sCmJEUtJqKxAuHC9bKdyZ898=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-338-MxQK-VXPOIOIv-2tJDPyNA-1; Mon, 15 May 2023 10:48:03 -0400
X-MC-Unique: MxQK-VXPOIOIv-2tJDPyNA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C58303847081;
        Mon, 15 May 2023 14:48:02 +0000 (UTC)
Received: from localhost (ovpn-8-26.pek2.redhat.com [10.72.8.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E12A740C206F;
        Mon, 15 May 2023 14:48:01 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 0/2] blk-mq: handle passthrough request as really passthrough
Date:   Mon, 15 May 2023 22:45:59 +0800
Message-Id: <20230515144601.52811-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

The 1st patch avoids to queue pt requests from plug list into scheduler.

The 2nd patch avoids to call elevator callbacks for passthrough.

V2:
	- improve patch style as suggested by Jens (1/2)
	- add comments (1/2)
	- add patch 2


Ming Lei (2):
  blk-mq: don't queue plugged passthrough requests into scheduler
  blk-mq: make sure elevator callbacks aren't called for passthrough
    request

 block/blk-mq-sched.h |  9 +++++++--
 block/blk-mq.c       | 23 ++++++++++++++++++-----
 2 files changed, 25 insertions(+), 7 deletions(-)

-- 
2.40.1

