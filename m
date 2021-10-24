Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26DB1C433EF
	for <linux-block@archiver.kernel.org>; Sun, 24 Oct 2021 13:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04DDC60FBF
	for <linux-block@archiver.kernel.org>; Sun, 24 Oct 2021 13:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbhJXN5W (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 24 Oct 2021 09:57:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52290 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230355AbhJXN5W (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 24 Oct 2021 09:57:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635083700;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=tewEIaGWIVgpjWlRNV0G2f4scnW96h9ilayJkc4j6ck=;
        b=SHlmIvgXpoJwJ7zrtm0AeR08yz8WFr+ZztwzGzpDMcKYFTtCPBwk4lnP9a8dO0BVP4UAAo
        KCWwSEC2aeuNTU1lOQOkumVtyLtoAQWnT9wV7vTWvD1iP0JycH21vCnGdLeMJRy7CO5Wuy
        yX6kqv9+IlkaJRYtn8I1xNAStkbq/Ec=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-AbA_UdlcOx247N-UDqN_PQ-1; Sun, 24 Oct 2021 09:54:59 -0400
X-MC-Unique: AbA_UdlcOx247N-UDqN_PQ-1
Received: by mail-ed1-f72.google.com with SMTP id z20-20020a05640240d400b003dce046ab51so7554083edb.14
        for <linux-block@vger.kernel.org>; Sun, 24 Oct 2021 06:54:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=tewEIaGWIVgpjWlRNV0G2f4scnW96h9ilayJkc4j6ck=;
        b=R7K4LUdkFZSQXbYWsRm5TMvc7pAWxLepDHQC5Eb+DFriNre59VsEUXDvafXWEmSwSD
         Un0N3aEflLb8AAgcz4wiQDhpJP+DO4n8fDzZAy8r+q67Fao/VBy5Wbp/qUe13eqZM3V7
         oSMplkkPqsra/VNPHVW7juaH0YJPeLv09QZNE+UeSD4in9nqCdfG3JkOah+k22Ri9zZx
         4OA9RnXGWK4r89kZjK2Gvuaxn80zmObzuhwaZ1hk4w6Jd90LeNkM1eQZXTc6vpSMIOra
         Vc/Atacrtl8VK7XqhfBY1EShbpYmNpbZmFkDXUnY5zqxrEJYAUkbvAr6QM6eJxrU8mA7
         EnOQ==
X-Gm-Message-State: AOAM5336WElHuX5n9jKF9y69dhdHFblDB1ZmShCTokBkwEmdMxNreI6g
        iziNniZnhWGETFSp/ByfSNuYZ3oIbOvzDOhMvWiKVmqxCABbXEwfSAQyLW6D394guWEYiFH5t4U
        jQXwtbEy4g2l69F6Xol7OqGY=
X-Received: by 2002:aa7:de8f:: with SMTP id j15mr17998590edv.347.1635083697860;
        Sun, 24 Oct 2021 06:54:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJziB449a0jkGnMyxw5Nq/yiWf48HjGMENXG4KqcvYNiRPrUcOY/ICO7KLwSoXi1Wh6vBRnxxA==
X-Received: by 2002:aa7:de8f:: with SMTP id j15mr17998572edv.347.1635083697702;
        Sun, 24 Oct 2021 06:54:57 -0700 (PDT)
Received: from redhat.com ([2.55.151.113])
        by smtp.gmail.com with ESMTPSA id bx2sm1887573edb.44.2021.10.24.06.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Oct 2021 06:54:57 -0700 (PDT)
Date:   Sun, 24 Oct 2021 09:54:54 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Max Gurtovoy <mgurtovoy@nvidia.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
Subject: [PATCH] virtio_blk: allow 0 as num_request_queues
Message-ID: <20211024135412.1516393-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The default value is 0 meaning "no limit". However if 0
is specified on the command line it is instead silently
converted to 1. Further, the value is already validated
at point of use, there's no point in duplicating code
validating the value when it is set.

Simplify the code while making the behaviour more consistent
by using plain module_param.

Fixes: 1a662cf6cb9a ("virtio-blk: add num_request_queues module parameter")
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/block/virtio_blk.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 6318134aab76..c336d9bb9105 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -30,20 +30,8 @@
 #define VIRTIO_BLK_INLINE_SG_CNT	2
 #endif
 
-static int virtblk_queue_count_set(const char *val,
-		const struct kernel_param *kp)
-{
-	return param_set_uint_minmax(val, kp, 1, nr_cpu_ids);
-}
-
-static const struct kernel_param_ops queue_count_ops = {
-	.set = virtblk_queue_count_set,
-	.get = param_get_uint,
-};
-
 static unsigned int num_request_queues;
-module_param_cb(num_request_queues, &queue_count_ops, &num_request_queues,
-		0644);
+module_param(num_request_queues, uint, 0644);
 MODULE_PARM_DESC(num_request_queues,
 		 "Limit the number of request queues to use for blk device. "
 		 "0 for no limit. "
-- 
MST

