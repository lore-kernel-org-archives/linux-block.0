Return-Path: <SRS0=iCYb=RZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96248C43381
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 16:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C0EE2190A
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 16:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbfCVQyQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Mar 2019 12:54:16 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:59785 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727105AbfCVQyQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Mar 2019 12:54:16 -0400
Received: from wuerfel.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1M8k65-1h2gTH00P3-004mJ7; Fri, 22 Mar 2019 17:54:06 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Ilya Dryomov <idryomov@gmail.com>, Sage Weil <sage@redhat.com>,
        Alex Elder <elder@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Jason Dillaman <dillaman@redhat.com>,
        ceph-devel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] rdb: convert all rbd_assert(0) to BUG()
Date:   Fri, 22 Mar 2019 17:53:56 +0100
Message-Id: <20190322165404.2859356-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:9kgBA2cbnRZk1i7YZLWqG1BdAeDV8UzUFASQ9XFdMYjFhQImGcv
 hP/iOC0k4KcHtN7O3aZWiOdH1ORPIuPXShFLw5gr0rlhtF53wet6TKS1c7NMjWLJDDkaDW1
 DzDNZMX2TyY9wu2UgQJ+7AAvabTPy9i0Moje1IbLZwQMzKd6DmezY9YLlv46DUUAzdTZ3P0
 U646LJTfJz2bKys6ReLyQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1gE2ja/erWc=:7ItfjD0NVLyHNwuHNqMbmB
 H7Oxt2McCETD0/CqqJfEj+fKTPxKDkKtNnVpx/hAyFOS+ekoqipMOXW6qMCUjHHCJdbeYG3By
 8d1lgj7i08tMujKujbNgQ8Z40KnKdRvPyfqz0di8CCJjxq0uF4cGfnUTAYH+glqH/tJa4LUeR
 R6U/QZ7Ku2yw+W958s5s4xzadtZP/el8tHjpRmNxZUAKrJaYf26NQhqRxTS5cSzzk6WnppFQi
 9DC49fPkKM9r74x9NeMD/pNzLigf4DhkIhPHrzIn9LZkep9FZquW5QvqhEOWa+T71RUNUgT2j
 2l3pt3QO4/I77gIgy0sAR35FNHz1SVAcNd97e0Ut/YUkYUoyscj2rn+TI0zMY/VPhsGhwS5Ya
 /BS/RffWwuADH+AGiIMVoHUH182BvDTYyingtJY/Q69MeZQZ0VEqZArNs+uAlf28BKXP8NXrV
 PO5Rj7vXih2WBb1P/og7Cpu2K6RlaU4TArfLma3y9TE1MPa/cjTDW8x6lGbS47TahHW/xHLk8
 htQGt2Ou3K5GzewjdM7gK6LpdqDxaFeU9YxLPFDzZVU/0l19w6YQ0Z4OzK6s2i+9PtqKFqFsj
 Moy+iYSqCMrqVXwPbu9ANCng+ZT/Z2AbJ4IYqYmytfWfiYUbbPXciZJLxMFTzkj54UY9ZIGPZ
 IoIiVBKFaPu2/APQugBCcuiCoM2k3ux3+V9nkKnJosbjgjdZPfRcfdkdpGOye4T0Lr/GlmIVw
 qlb4n9oGo4yTX56UYHL5dwbmtaKExD1ZVOpKPA==
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

rbd_assert(0) has caused different issues depending on
the compiler version in the past, so it seems better to avoid it
completely.

Replace the remaining instances.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/block/rbd.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index cbcc3baf3807..564c5069cc78 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1342,7 +1342,7 @@ static void rbd_obj_zero_range(struct rbd_obj_request *obj_req, u32 off,
 		zero_bvecs(&obj_req->bvec_pos, off, bytes);
 		break;
 	default:
-		rbd_assert(0);
+		BUG();
 	}
 }
 
@@ -1597,7 +1597,7 @@ static void rbd_obj_request_destroy(struct kref *kref)
 		kfree(obj_request->bvec_pos.bvecs);
 		break;
 	default:
-		rbd_assert(0);
+		BUG();
 	}
 
 	kfree(obj_request->img_extents);
@@ -1797,7 +1797,7 @@ static void rbd_osd_req_setup_data(struct rbd_obj_request *obj_req, u32 which)
 						    &obj_req->bvec_pos);
 		break;
 	default:
-		rbd_assert(0);
+		BUG();
 	}
 }
 
@@ -2052,7 +2052,7 @@ static int __rbd_img_fill_request(struct rbd_img_request *img_req)
 			ret = rbd_obj_setup_zeroout(obj_req);
 			break;
 		default:
-			rbd_assert(0);
+			BUG();
 		}
 		if (ret < 0)
 			return ret;
@@ -2531,7 +2531,7 @@ static int rbd_obj_issue_copyup_ops(struct rbd_obj_request *obj_req, u32 bytes)
 		num_osd_ops += count_zeroout_ops(obj_req);
 		break;
 	default:
-		rbd_assert(0);
+		BUG();
 	}
 
 	obj_req->osd_req = rbd_osd_req_create(obj_req, num_osd_ops);
@@ -2558,7 +2558,7 @@ static int rbd_obj_issue_copyup_ops(struct rbd_obj_request *obj_req, u32 bytes)
 		__rbd_obj_setup_zeroout(obj_req, which);
 		break;
 	default:
-		rbd_assert(0);
+		BUG();
 	}
 
 	ret = ceph_osdc_alloc_messages(obj_req->osd_req, GFP_NOIO);
-- 
2.20.0

