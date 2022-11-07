Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D8EC433FE
	for <linux-block@archiver.kernel.org>; Mon,  7 Nov 2022 13:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbiKGNTu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Nov 2022 08:19:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbiKGNTt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Nov 2022 08:19:49 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1B61B1FE
        for <linux-block@vger.kernel.org>; Mon,  7 Nov 2022 05:19:48 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id q9so10583510pfg.5
        for <linux-block@vger.kernel.org>; Mon, 07 Nov 2022 05:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rzdGFzx+TjrS2t/GJ6Iu3kMxv9cIRqVUv64fPauPFm0=;
        b=F7cXjfSf19tEVXERpGhFZ3N96C5ZCflSrOoC5zJMo+h5rWDYg2apBlZxqwLOLJPjJz
         yRZ8cy9QggpxoLnJ/ghZfJ6NMookoDhE+YXYRpnh+1RbzwlVT5TX5zTuNF+YTGLDN1Xm
         CbXRGE6UPehar8BnwS5ZFoS3Ev3KL8rxgKy4sqDkV3QefmfwEoWj+gOJKcjZ/2JW3JA0
         KBQHQpAwrkhd1g1cO4jaFzdIsO/qH6DRT3gT9dx+SoWhTt/e5bCRnbpMzlJZHqTB0nsF
         RVcfndWHOKBj2FkaK6kNR6Wof7Hsd5cN1s0YvNUVH6F93wpPZQSFFwzmywHoQ/b1iTzu
         fxqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rzdGFzx+TjrS2t/GJ6Iu3kMxv9cIRqVUv64fPauPFm0=;
        b=j74BB9uBydVZe9a8b6hgf5RIxyOcPZh7zzbxarJIII0kieFJqBa827MGk+BRf3agjP
         mFi/+cZ9NGD9eJt41QaEmJggCaC0tzpZW405KOD6JW7ZeE2vQ0KexmYzCFTMv11p2smh
         Je8SftNu5qriyXRIbj4g7F6AofXYnTZXGRLG8OBXjArkGJXbuhpWazwzusUMNwxUijNd
         mWIWAzqht2e7SLchQlc1UXqw6C+FlX/0fssVzvcnMfLQeiXIWurYZHSzAp8t2/cucNcf
         pzvD16LJ2NqhcgMv3mF/PPuz3/H0KZeYV2MtJH82ffmH/FnlhnWLJfcVoJ2rOZ50bIG4
         QBPQ==
X-Gm-Message-State: ACrzQf1Gw37+9I38Gf1Qp79pk1xPHpTArcnvCYJ72Xpwrfm3XmuQDd5v
        SaTGmQ+J2LgsB/VUlCcrfeU0EWnbEzI=
X-Google-Smtp-Source: AMsMyM5lT8zvjKnq3E1/QSQWFZP+AZcU3UHWRAJJMiFoK6fW/0pNZeiB6CzY3m1T15KyU8J+yOS50w==
X-Received: by 2002:a05:6a00:2386:b0:56c:b791:40f2 with SMTP id f6-20020a056a00238600b0056cb79140f2mr51038017pfc.4.1667827187893;
        Mon, 07 Nov 2022 05:19:47 -0800 (PST)
Received: from localhost.localdomain ([114.200.4.15])
        by smtp.googlemail.com with ESMTPSA id m2-20020a17090a4d8200b00212d4c50647sm6097401pjh.36.2022.11.07.05.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 05:19:47 -0800 (PST)
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        pbonzini@redhat.com, hch@infradead.org
Cc:     virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, Suwan Kim <suwan.kim027@gmail.com>
Subject: [PATCH] virtio-blk: set req->state to MQ_RQ_COMPLETE after polling I/O is finished
Date:   Mon,  7 Nov 2022 22:17:48 +0900
Message-Id: <20221107131748.11892-1-suwan.kim027@gmail.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Driver should set req->state to MQ_RQ_COMPLETE after it finishes to process
req. But virtio-blk doesn't set MQ_RQ_COMPLETE after virtblk_poll() handles
req and req->state still remains MQ_RQ_IN_FLIGHT. Fortunately so far there
is no issue about it because blk_mq_end_request_batch() sets req->state to
MQ_RQ_IDLE. This patch properly sets req->state after polling I/O is finished.

Fixes: 4e0400525691 ("virtio-blk: support polling I/O")
Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
---
 drivers/block/virtio_blk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 19da5defd734..cf64d256787e 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -839,6 +839,7 @@ static void virtblk_complete_batch(struct io_comp_batch *iob)
 	rq_list_for_each(&iob->req_list, req) {
 		virtblk_unmap_data(req, blk_mq_rq_to_pdu(req));
 		virtblk_cleanup_cmd(req);
+		blk_mq_set_request_complete(req);
 	}
 	blk_mq_end_request_batch(iob);
 }
-- 
2.26.3

