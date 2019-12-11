Return-Path: <SRS0=X6jZ=2B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B7C7C43603
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 20:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D18D6222C4
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 20:45:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfLKUp5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Dec 2019 15:45:57 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:44829 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbfLKUp4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Dec 2019 15:45:56 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Mz9hF-1hkH0n3Mhf-00w9tu; Wed, 11 Dec 2019 21:44:54 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>,
        Keith Busch <kbusch@kernel.org>,
        Hans Holmberg <hans.holmberg@wdc.com>,
        Matias Bjorling <matias.bjorling@wdc.com>
Cc:     linux-kernel@vger.kernel.org, y2038@lists.linaro.org,
        Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        Ajay Joshi <ajay.joshi@wdc.com>,
        Dmitry Fomichev <dmitry.fomichev@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-block@vger.kernel.org
Subject: [PATCH 05/24] compat_ioctl: block: handle add zone open, close and finish ioctl
Date:   Wed, 11 Dec 2019 21:42:39 +0100
Message-Id: <20191211204306.1207817-6-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191211204306.1207817-1-arnd@arndb.de>
References: <20191211204306.1207817-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:T3P5inF1wAM0JTp0sDl4O/rqOEQcKKwFPNK080bhsoSzCuvH5os
 ZIz9G1k8iLEMcivvXznzuZIw7nXoa/IH9pBhTIMo4P4a9A/jq38deJ8BsqLgViD1Gy9X9Z2
 amoGNEETinCQm5AIH4yoHFkPvGOvZBVENg0im+gyXDWmVBV4mvW65rzxxvxBlkQGl7iAkuq
 keBfNdGCjbKGo/blJPJ3A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:y0zEiubbezU=:bi2nIJ6/zTdNQgNrAQOGBX
 V7vMHhKw/sGC5woyeRTf4QRRUx0TgILAMf8tehFX0MaOP6jFADznPL5YvFZdP/8KBsa8VHUbC
 aTSmvIjP91oBYVflD9bf3dTv+TM4jQxTpzv15O6HEdOexET67KWy3Be6UFfb4hG5D8FXNGm9F
 GdOgK7uOqItMAqHbxSqQOX0m0PDdLflVHlRzfCzmMtszJqW33G3ZUyE7yj1rXZzDg7gDYuZdc
 idOE65NXc3yZz+eiqNSKf2IzdL0nbFdboeLDpfE9UayxXtFjNaqvmEwlyUtogWyleRJXi4Ook
 gNqQntW55PioCE+OFYKe+s7zE9lN3rNUQ0uWWkCcU50lFGb3Ghd2ImwjmjTtJX9avACuqBLl4
 Eq222g4k2YtpuZralMccFnATxMli3e1iUWiT909sw8PyG1g9bap0E1UM6a4URRJ9FE75iUisi
 tNPlPIwCqTv63RQ3ffUFwl2rWDoRRxjNGhaE32WBkrUYUb8HDWOYNnToxia5Lqhr834m5/QNG
 xZg8yXK4XMgdHWgXB6c3t63k6K0W0hNB1XAE4cad/gkEFsSZjw8JGgSVsbMMM5nXxdC6RKT/S
 ZdqOOs6nRczydptZAMhfub/HIFnQPsECNsGVeErqLKRWYl5VVSwAYzmGjjvhhOCBkrl9oV1oL
 pEb5rDH4teu/dkisZNrqdJgJnE9MGEuDMShclIPlpqmwwC+pVhxb3vTzOIWAFiQHY2YtKYlcU
 W+/gq1Grakw6tdd5G7LstR7Mm8eYYSBldJ1lCrJ6q/MgyasJLcJ+FBr6vxzpiSG7I1Urf4OAj
 0uZU2cZH62GHsFyTBOmKkvWmRX3czxeCNqr4zQA78VMDQQRYzn1QsCw8Kj9LoaPBw9tA7oJpa
 z3grqTX8c9r65hGmvbqQ==
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

These were added to blkdev_ioctl() in linux-5.5 but not
blkdev_compat_ioctl, so add them now.

Fixes: e876df1fe0ad ("block: add zone open, close and finish ioctl support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 block/compat_ioctl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/compat_ioctl.c b/block/compat_ioctl.c
index f5c1140b8624..5b13e344229c 100644
--- a/block/compat_ioctl.c
+++ b/block/compat_ioctl.c
@@ -356,6 +356,9 @@ long compat_blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg)
 	case BLKRRPART:
 	case BLKREPORTZONE:
 	case BLKRESETZONE:
+	case BLKOPENZONE:
+	case BLKCLOSEZONE:
+	case BLKFINISHZONE:
 	case BLKGETZONESZ:
 	case BLKGETNRZONES:
 		return blkdev_ioctl(bdev, mode, cmd,
-- 
2.20.0

