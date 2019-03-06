Return-Path: <SRS0=tltz=RJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7932AC10F00
	for <linux-block@archiver.kernel.org>; Wed,  6 Mar 2019 08:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53F0C20828
	for <linux-block@archiver.kernel.org>; Wed,  6 Mar 2019 08:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbfCFIsr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Mar 2019 03:48:47 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:47826 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729623AbfCFIsr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Mar 2019 03:48:47 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from talgi@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 6 Mar 2019 10:48:41 +0200
Received: from gen-l-vrt-691.mtl.labs.mlnx (gen-l-vrt-691.mtl.labs.mlnx [10.141.69.1])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x268meZB017447;
        Wed, 6 Mar 2019 10:48:40 +0200
Received: from gen-l-vrt-691.mtl.labs.mlnx (localhost [127.0.0.1])
        by gen-l-vrt-691.mtl.labs.mlnx (8.15.2/8.15.2/Debian-11ubuntu1) with ESMTP id x268meiI057820;
        Wed, 6 Mar 2019 10:48:40 +0200
Received: (from talgi@localhost)
        by gen-l-vrt-691.mtl.labs.mlnx (8.15.2/8.15.2/Submit) id x268meBE057819;
        Wed, 6 Mar 2019 10:48:40 +0200
From:   Tal Gilboa <talgi@mellanox.com>
To:     linux-rdma@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Cc:     Yishai Hadas <yishaih@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Tal Gilboa <talgi@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Idan Burstein <idanb@mellanox.com>,
        Yamin Friedman <yaminf@mellanox.com>,
        Max Gurtovoy <maxg@mellanox.com>
Subject: [RFC/PATCH net-next 4/9] linux/dim: Rename net_dim_sample() to net_dim_create_sample()
Date:   Wed,  6 Mar 2019 10:48:27 +0200
Message-Id: <20190306084832.57753-5-talgi@mellanox.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190306084832.57753-1-talgi@mellanox.com>
References: <20190306084832.57753-1-talgi@mellanox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In order to avoid confusion between the function and the similarly
named struct.
In preparation for removing the 'net' prefix from dim members.

Signed-off-by: Tal Gilboa <talgi@mellanox.com>
---
 drivers/net/ethernet/broadcom/bcmsysport.c        | 4 ++--
 drivers/net/ethernet/broadcom/bnxt/bnxt.c         | 8 ++++----
 drivers/net/ethernet/broadcom/genet/bcmgenet.c    | 4 ++--
 drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c | 6 ++----
 include/linux/dim.h                               | 8 ++++----
 include/linux/net_dim.h                           | 4 ++--
 6 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
index 0dbdef541f3c..00958c4bf740 100644
--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -1034,8 +1034,8 @@ static int bcm_sysport_poll(struct napi_struct *napi, int budget)
 	}
 
 	if (priv->dim.use_dim) {
-		net_dim_sample(priv->dim.event_ctr, priv->dim.packets,
-			       priv->dim.bytes, &dim_sample);
+		net_dim_create_sample(priv->dim.event_ctr, priv->dim.packets,
+				      priv->dim.bytes, &dim_sample);
 		net_dim(&priv->dim.dim, dim_sample);
 	}
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 08d0679ccf63..9bf7b51d9405 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -2107,10 +2107,10 @@ static int bnxt_poll(struct napi_struct *napi, int budget)
 	if (bp->flags & BNXT_FLAG_DIM) {
 		struct net_dim_sample dim_sample;
 
-		net_dim_sample(cpr->event_ctr,
-			       cpr->rx_packets,
-			       cpr->rx_bytes,
-			       &dim_sample);
+		net_dim_create_sample(cpr->event_ctr,
+				      cpr->rx_packets,
+				      cpr->rx_bytes,
+				      &dim_sample);
 		net_dim(&cpr->dim, dim_sample);
 	}
 	mmiowb();
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index eee48dae8ed5..8ab2d672d2ba 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -1909,8 +1909,8 @@ static int bcmgenet_rx_poll(struct napi_struct *napi, int budget)
 	}
 
 	if (ring->dim.use_dim) {
-		net_dim_sample(ring->dim.event_ctr, ring->dim.packets,
-			       ring->dim.bytes, &dim_sample);
+		net_dim_create_sample(ring->dim.event_ctr, ring->dim.packets,
+				      ring->dim.bytes, &dim_sample);
 		net_dim(&ring->dim.dim, dim_sample);
 	}
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
index b4af5e19f6ac..6dd820242f4b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
@@ -53,8 +53,7 @@ static void mlx5e_handle_tx_dim(struct mlx5e_txqsq *sq)
 	if (unlikely(!test_bit(MLX5E_SQ_STATE_AM, &sq->state)))
 		return;
 
-	net_dim_sample(sq->cq.event_ctr, stats->packets, stats->bytes,
-		       &dim_sample);
+	net_dim_create_sample(sq->cq.event_ctr, stats->packets, stats->bytes, &dim_sample);
 	net_dim(&sq->dim, dim_sample);
 }
 
@@ -66,8 +65,7 @@ static void mlx5e_handle_rx_dim(struct mlx5e_rq *rq)
 	if (unlikely(!test_bit(MLX5E_RQ_STATE_AM, &rq->state)))
 		return;
 
-	net_dim_sample(rq->cq.event_ctr, stats->packets, stats->bytes,
-		       &dim_sample);
+	net_dim_create_sample(rq->cq.event_ctr, stats->packets, stats->bytes, &dim_sample);
 	net_dim(&rq->dim, dim_sample);
 }
 
diff --git a/include/linux/dim.h b/include/linux/dim.h
index adb20e58bf19..7809ffe470ff 100644
--- a/include/linux/dim.h
+++ b/include/linux/dim.h
@@ -150,10 +150,10 @@ static inline void dim_park_tired(struct net_dim *dim)
 	dim->tune_state   = DIM_PARKING_TIRED;
 }
 
-static inline void net_dim_sample(u16 event_ctr,
-				  u64 packets,
-				  u64 bytes,
-				  struct net_dim_sample *s)
+static inline void net_dim_create_sample(u16 event_ctr,
+					 u64 packets,
+					 u64 bytes,
+					 struct net_dim_sample *s)
 {
 	s->time	     = ktime_get();
 	s->pkt_ctr   = packets;
diff --git a/include/linux/net_dim.h b/include/linux/net_dim.h
index 98ea0bb6f130..8cddfc93819c 100644
--- a/include/linux/net_dim.h
+++ b/include/linux/net_dim.h
@@ -262,8 +262,8 @@ static inline void net_dim(struct net_dim *dim,
 		}
 		/* fall through */
 	case DIM_START_MEASURE:
-		net_dim_sample(end_sample.event_ctr, end_sample.pkt_ctr, end_sample.byte_ctr,
-			       &dim->start_sample);
+		net_dim_create_sample(end_sample.event_ctr, end_sample.pkt_ctr,
+				      end_sample.byte_ctr, &dim->start_sample);
 		dim->state = DIM_MEASURE_IN_PROGRESS;
 		break;
 	case DIM_APPLY_NEW_PROFILE:
-- 
2.19.1

