Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68378C07E96
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 09:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45938611AB
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 09:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239662AbhGOJwk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Jul 2021 05:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbhGOJwj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Jul 2021 05:52:39 -0400
X-Greylist: delayed 66 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 15 Jul 2021 02:49:46 PDT
Received: from forwardcorp1o.mail.yandex.net (forwardcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB76EC06175F;
        Thu, 15 Jul 2021 02:49:46 -0700 (PDT)
Received: from vla1-fdfb804fb3f3.qloud-c.yandex.net (vla1-fdfb804fb3f3.qloud-c.yandex.net [IPv6:2a02:6b8:c0d:3199:0:640:fdfb:804f])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 4D4772E1946;
        Thu, 15 Jul 2021 12:48:35 +0300 (MSK)
Received: from vla1-81430ab5870b.qloud-c.yandex.net (vla1-81430ab5870b.qloud-c.yandex.net [2a02:6b8:c0d:35a1:0:640:8143:ab5])
        by vla1-fdfb804fb3f3.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id 5VFpkroome-mYxWKXe3;
        Thu, 15 Jul 2021 12:48:35 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1626342515; bh=M8sXLYpZ29UOBWOw8OrxQsbt1CGJcZeYG/DJHYHn3yo=;
        h=Message-Id:Date:Subject:To:From:Cc;
        b=JwCzcqluAn8RgpAEvvMPxxGxxTVAyelO6WPZ8NsHlbe3LndnpAR2jb5YAwyjRHedG
         aLsOi+qHMbdpZLhv/jT6D/TM2g+mI4KKi76w0iczcyAWxZ7wJTHZFV4uyQxFcvg+/z
         i9jN35DN+2Eec7DDsG8/FHrVlSCfmbP53q5Rqago=
Authentication-Results: vla1-fdfb804fb3f3.qloud-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from 77.88.0.204-spb.dhcp.yndx.net (77.88.0.204-spb.dhcp.yndx.net [77.88.0.204])
        by vla1-81430ab5870b.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id JSE0wE09V8-mY2Km1xc;
        Thu, 15 Jul 2021 12:48:34 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Yury Kamenev <damtev@yandex-team.ru>
To:     mst@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
        stefanha@redhat.com, axboe@kernel.dk, hch@lst.de, cand@gmx.com,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yury Kamenev <damtev@yandex-team.ru>
Subject: [PATCH 0/1] virtio: disable partitions scanning for no partitions block
Date:   Thu, 15 Jul 2021 12:47:06 +0300
Message-Id: <20210715094707.19997-1-damtev@yandex-team.ru>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Some virtio blocks definitely have no partitions and should not be scanned.

Yury Kamenev (1):
  virtio: disable partitions scanning for no partitions block

 .../admin-guide/kernel-parameters.txt         |  3 +++
 drivers/block/Kconfig                         |  7 +++++
 drivers/block/virtio_blk.c                    | 26 +++++++++++++++++++
 include/uapi/linux/virtio_blk.h               |  2 ++
 4 files changed, 38 insertions(+)

-- 
2.24.3 (Apple Git-128)

