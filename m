Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7146DC6FA99
	for <linux-block@archiver.kernel.org>; Fri, 10 Mar 2023 20:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjCJUQU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 10 Mar 2023 15:16:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjCJUQT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Mar 2023 15:16:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D8312DDE5
        for <linux-block@vger.kernel.org>; Fri, 10 Mar 2023 12:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678479333;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=hnVD7krrqQ4+GWMqPVcp+YfvImsOsWxKBMH5y3xz1f0=;
        b=LlJUSvml86ILjhXIZ49GeY9Bx9GXOZRY6+3y1xRXRWyx93ZeUY0dUODiBhwthhUqaKOhGN
        FlBxolr7oKmobiz1r1xC2+RQPuR1oEvgTsQGmLhxt/a3lmE95JvUXU/F7XKBjb6xsPsVTg
        7UV/o+ZuzRI/Zgj2sXLsff7GKjT1r74=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-17-HfmnwJteMI691XAYC91cyg-1; Fri, 10 Mar 2023 15:15:27 -0500
X-MC-Unique: HfmnwJteMI691XAYC91cyg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 010283C0E463;
        Fri, 10 Mar 2023 20:15:27 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.147])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2A85E40BC781;
        Fri, 10 Mar 2023 20:15:26 +0000 (UTC)
From:   Eric Blake <eblake@redhat.com>
To:     josef@toxicpanda.com, linux-block@vger.kernel.org,
        nbd@other.debian.org
Cc:     philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        christoph.boehmwalder@linbit.com, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] nbd: s/handle/cookie/
Date:   Fri, 10 Mar 2023 14:15:22 -0600
Message-Id: <20230310201525.2615385-1-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

A 64-bit integer is easier to deal with than char[8], and has no
difference over the wire.  This series stems from a review of a patch
I first submitted to the userspace NBD documentation:

https://lists.debian.org/nbd/2023/03/msg00031.html

Eric Blake (3):
  uapi nbd: improve doc links to userspace spec
  uapi nbd: add cookie alias to handle
  block nbd: use req.cookie instead of req.handle

 Documentation/admin-guide/blockdev/nbd.rst |  2 +-
 drivers/block/nbd.c                        |  4 ++--
 include/uapi/linux/nbd.h                   | 25 +++++++++++++++++-----
 3 files changed, 23 insertions(+), 8 deletions(-)

-- 
2.39.2

