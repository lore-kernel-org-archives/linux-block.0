Return-Path: <SRS0=tltz=RJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 731CAC4360F
	for <linux-block@archiver.kernel.org>; Wed,  6 Mar 2019 08:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 306B120675
	for <linux-block@archiver.kernel.org>; Wed,  6 Mar 2019 08:48:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729629AbfCFIsu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Mar 2019 03:48:50 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:47838 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729632AbfCFIst (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Mar 2019 03:48:49 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from talgi@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 6 Mar 2019 10:48:41 +0200
Received: from gen-l-vrt-691.mtl.labs.mlnx (gen-l-vrt-691.mtl.labs.mlnx [10.141.69.1])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x268mfwg017472;
        Wed, 6 Mar 2019 10:48:41 +0200
Received: from gen-l-vrt-691.mtl.labs.mlnx (localhost [127.0.0.1])
        by gen-l-vrt-691.mtl.labs.mlnx (8.15.2/8.15.2/Debian-11ubuntu1) with ESMTP id x268mfQC057822;
        Wed, 6 Mar 2019 10:48:41 +0200
Received: (from talgi@localhost)
        by gen-l-vrt-691.mtl.labs.mlnx (8.15.2/8.15.2/Submit) id x268mfeW057821;
        Wed, 6 Mar 2019 10:48:41 +0200
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
Subject: [RFC/PATCH net-next 5/9] linux/dim: Rename externally used net_dim members
Date:   Wed,  6 Mar 2019 10:48:28 +0200
Message-Id: <20190306084832.57753-6-talgi@mellanox.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190306084832.57753-1-talgi@mellanox.com>
References: <20190306084832.57753-1-talgi@mellanox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Removed 'net' prefix from functions and structs used by external drivers.

Signed-off-by: Tal Gilboa <talgi@mellanox.com>
---
 drivers/net/ethernet/broadcom/bcmsysport.c    | 16 +++++-----
 drivers/net/ethernet/broadcom/bcmsysport.h    |  2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 10 +++----
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  2 +-
 .../net/ethernet/broadcom/bnxt/bnxt_debugfs.c |  4 +--
 drivers/net/ethernet/broadcom/bnxt/bnxt_dim.c |  5 ++--
 .../net/ethernet/broadcom/genet/bcmgenet.c    | 14 ++++-----
 .../net/ethernet/broadcom/genet/bcmgenet.h    |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  8 ++---
 .../net/ethernet/mellanox/mlx5/core/en_dim.c  | 10 +++----
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  |  4 +--
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 12 ++++----
 .../net/ethernet/mellanox/mlx5/core/en_txrx.c |  8 ++---
 include/linux/dim.h                           | 28 ++++++++---------
 include/linux/net_dim.h                       | 30 +++++++++----------
 15 files changed, 77 insertions(+), 78 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
index 00958c4bf740..840b3bf1ae3e 100644
--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -627,7 +627,7 @@ static int bcm_sysport_set_coalesce(struct net_device *dev,
 				    struct ethtool_coalesce *ec)
 {
 	struct bcm_sysport_priv *priv = netdev_priv(dev);
-	struct net_dim_cq_moder moder;
+	struct dim_cq_moder moder;
 	u32 usecs, pkts;
 	unsigned int i;
 
@@ -1010,7 +1010,7 @@ static int bcm_sysport_poll(struct napi_struct *napi, int budget)
 {
 	struct bcm_sysport_priv *priv =
 		container_of(napi, struct bcm_sysport_priv, napi);
-	struct net_dim_sample dim_sample;
+	struct dim_sample dim_sample;
 	unsigned int work_done = 0;
 
 	work_done = bcm_sysport_desc_rx(priv, budget);
@@ -1034,8 +1034,8 @@ static int bcm_sysport_poll(struct napi_struct *napi, int budget)
 	}
 
 	if (priv->dim.use_dim) {
-		net_dim_create_sample(priv->dim.event_ctr, priv->dim.packets,
-				      priv->dim.bytes, &dim_sample);
+		dim_create_sample(priv->dim.event_ctr, priv->dim.packets,
+				  priv->dim.bytes, &dim_sample);
 		net_dim(&priv->dim.dim, dim_sample);
 	}
 
@@ -1105,13 +1105,13 @@ static void bcm_sysport_resume_from_wol(struct bcm_sysport_priv *priv)
 
 static void bcm_sysport_dim_work(struct work_struct *work)
 {
-	struct net_dim *dim = container_of(work, struct net_dim, work);
+	struct dim *dim = container_of(work, struct dim, work);
 	struct bcm_sysport_net_dim *ndim =
 			container_of(dim, struct bcm_sysport_net_dim, dim);
 	struct bcm_sysport_priv *priv =
 			container_of(ndim, struct bcm_sysport_priv, dim);
-	struct net_dim_cq_moder cur_profile =
-			net_dim_get_rx_moderation(dim->mode, dim->profile_ix);
+	struct dim_cq_moder cur_profile = net_dim_get_rx_moderation(dim->mode,
+								    dim->profile_ix);
 
 	bcm_sysport_set_rx_coalesce(priv, cur_profile.usec, cur_profile.pkts);
 	dim->state = DIM_START_MEASURE;
@@ -1475,7 +1475,7 @@ static void bcm_sysport_init_dim(struct bcm_sysport_priv *priv,
 static void bcm_sysport_init_rx_coalesce(struct bcm_sysport_priv *priv)
 {
 	struct bcm_sysport_net_dim *dim = &priv->dim;
-	struct net_dim_cq_moder moder;
+	struct dim_cq_moder moder;
 	u32 usecs, pkts;
 
 	usecs = priv->rx_coalesce_usecs;
diff --git a/drivers/net/ethernet/broadcom/bcmsysport.h b/drivers/net/ethernet/broadcom/bcmsysport.h
index 0887e6356649..db9143eeb817 100644
--- a/drivers/net/ethernet/broadcom/bcmsysport.h
+++ b/drivers/net/ethernet/broadcom/bcmsysport.h
@@ -710,7 +710,7 @@ struct bcm_sysport_net_dim {
 	u16			event_ctr;
 	unsigned long		packets;
 	unsigned long		bytes;
-	struct net_dim		dim;
+	struct dim		dim;
 };
 
 /* Software view of the TX ring */
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 9bf7b51d9405..131ab07aad83 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -2105,12 +2105,12 @@ static int bnxt_poll(struct napi_struct *napi, int budget)
 		}
 	}
 	if (bp->flags & BNXT_FLAG_DIM) {
-		struct net_dim_sample dim_sample;
+		struct dim_sample dim_sample;
 
-		net_dim_create_sample(cpr->event_ctr,
-				      cpr->rx_packets,
-				      cpr->rx_bytes,
-				      &dim_sample);
+		dim_create_sample(cpr->event_ctr,
+				  cpr->rx_packets,
+				  cpr->rx_bytes,
+				  &dim_sample);
 		net_dim(&cpr->dim, dim_sample);
 	}
 	mmiowb();
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 5c886a700bcc..211f68d3e14b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -810,7 +810,7 @@ struct bnxt_cp_ring_info {
 	u64			rx_bytes;
 	u64			event_ctr;
 
-	struct net_dim		dim;
+	struct dim		dim;
 
 	union {
 		struct tx_cmp	*cp_desc_ring[MAX_CP_PAGES];
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_debugfs.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_debugfs.c
index 94e208e9789f..3d1d53fbb135 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_debugfs.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_debugfs.c
@@ -21,7 +21,7 @@ static ssize_t debugfs_dim_read(struct file *filep,
 				char __user *buffer,
 				size_t count, loff_t *ppos)
 {
-	struct net_dim *dim = filep->private_data;
+	struct dim *dim = filep->private_data;
 	int len;
 	char *buf;
 
@@ -61,7 +61,7 @@ static const struct file_operations debugfs_dim_fops = {
 	.read = debugfs_dim_read,
 };
 
-static struct dentry *debugfs_dim_ring_init(struct net_dim *dim, int ring_idx,
+static struct dentry *debugfs_dim_ring_init(struct dim *dim, int ring_idx,
 					    struct dentry *dd)
 {
 	static char qname[16];
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_dim.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_dim.c
index 16a4588709d1..11605f9fa61e 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_dim.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_dim.c
@@ -13,15 +13,14 @@
 
 void bnxt_dim_work(struct work_struct *work)
 {
-	struct net_dim *dim = container_of(work, struct net_dim,
-					   work);
+	struct dim *dim = container_of(work, struct dim, work);
 	struct bnxt_cp_ring_info *cpr = container_of(dim,
 						     struct bnxt_cp_ring_info,
 						     dim);
 	struct bnxt_napi *bnapi = container_of(cpr,
 					       struct bnxt_napi,
 					       cp_ring);
-	struct net_dim_cq_moder cur_moder =
+	struct dim_cq_moder cur_moder =
 		net_dim_get_rx_moderation(dim->mode, dim->profile_ix);
 
 	cpr->rx_ring_coal.coal_ticks = cur_moder.usec;
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 8ab2d672d2ba..68d96e333c6d 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -643,7 +643,7 @@ static void bcmgenet_set_rx_coalesce(struct bcmgenet_rx_ring *ring,
 static void bcmgenet_set_ring_rx_coalesce(struct bcmgenet_rx_ring *ring,
 					  struct ethtool_coalesce *ec)
 {
-	struct net_dim_cq_moder moder;
+	struct dim_cq_moder moder;
 	u32 usecs, pkts;
 
 	ring->rx_coalesce_usecs = ec->rx_coalesce_usecs;
@@ -1898,7 +1898,7 @@ static int bcmgenet_rx_poll(struct napi_struct *napi, int budget)
 {
 	struct bcmgenet_rx_ring *ring = container_of(napi,
 			struct bcmgenet_rx_ring, napi);
-	struct net_dim_sample dim_sample;
+	struct dim_sample dim_sample;
 	unsigned int work_done;
 
 	work_done = bcmgenet_desc_rx(ring, budget);
@@ -1909,8 +1909,8 @@ static int bcmgenet_rx_poll(struct napi_struct *napi, int budget)
 	}
 
 	if (ring->dim.use_dim) {
-		net_dim_create_sample(ring->dim.event_ctr, ring->dim.packets,
-				      ring->dim.bytes, &dim_sample);
+		dim_create_sample(ring->dim.event_ctr, ring->dim.packets,
+				  ring->dim.bytes, &dim_sample);
 		net_dim(&ring->dim.dim, dim_sample);
 	}
 
@@ -1919,12 +1919,12 @@ static int bcmgenet_rx_poll(struct napi_struct *napi, int budget)
 
 static void bcmgenet_dim_work(struct work_struct *work)
 {
-	struct net_dim *dim = container_of(work, struct net_dim, work);
+	struct dim *dim = container_of(work, struct dim, work);
 	struct bcmgenet_net_dim *ndim =
 			container_of(dim, struct bcmgenet_net_dim, dim);
 	struct bcmgenet_rx_ring *ring =
 			container_of(ndim, struct bcmgenet_rx_ring, dim);
-	struct net_dim_cq_moder cur_profile =
+	struct dim_cq_moder cur_profile =
 			net_dim_get_rx_moderation(dim->mode, dim->profile_ix);
 
 	bcmgenet_set_rx_coalesce(ring, cur_profile.usec, cur_profile.pkts);
@@ -2094,7 +2094,7 @@ static void bcmgenet_init_dim(struct bcmgenet_rx_ring *ring,
 static void bcmgenet_init_rx_coalesce(struct bcmgenet_rx_ring *ring)
 {
 	struct bcmgenet_net_dim *dim = &ring->dim;
-	struct net_dim_cq_moder moder;
+	struct dim_cq_moder moder;
 	u32 usecs, pkts;
 
 	usecs = ring->rx_coalesce_usecs;
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.h b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
index 14b49612aa86..6e418d9c3706 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.h
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
@@ -581,7 +581,7 @@ struct bcmgenet_net_dim {
 	u16		event_ctr;
 	unsigned long	packets;
 	unsigned long	bytes;
-	struct net_dim	dim;
+	struct dim	dim;
 };
 
 struct bcmgenet_rx_ring {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 6dd74ef69389..94826b48aead 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -238,8 +238,8 @@ struct mlx5e_params {
 	u16 num_channels;
 	u8  num_tc;
 	bool rx_cqe_compress_def;
-	struct net_dim_cq_moder rx_cq_moderation;
-	struct net_dim_cq_moder tx_cq_moderation;
+	struct dim_cq_moder rx_cq_moderation;
+	struct dim_cq_moder tx_cq_moderation;
 	bool lro_en;
 	u32 lro_wqe_sz;
 	u8  tx_min_inline_mode;
@@ -356,7 +356,7 @@ struct mlx5e_txqsq {
 	/* dirtied @completion */
 	u16                        cc;
 	u32                        dma_fifo_cc;
-	struct net_dim             dim; /* Adaptive Moderation */
+	struct dim                 dim; /* Adaptive Moderation */
 
 	/* dirtied @xmit */
 	u16                        pc ____cacheline_aligned_in_smp;
@@ -593,7 +593,7 @@ struct mlx5e_rq {
 	int                    ix;
 	unsigned int           hw_mtu;
 
-	struct net_dim         dim; /* Dynamic Interrupt Moderation */
+	struct dim         dim; /* Dynamic Interrupt Moderation */
 
 	/* XDP */
 	struct bpf_prog       *xdp_prog;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_dim.c b/drivers/net/ethernet/mellanox/mlx5/core/en_dim.c
index a80303add7c0..ba3c1be9f2d3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_dim.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_dim.c
@@ -34,7 +34,7 @@
 #include "en.h"
 
 static void
-mlx5e_complete_dim_work(struct net_dim *dim, struct net_dim_cq_moder moder,
+mlx5e_complete_dim_work(struct dim *dim, struct dim_cq_moder moder,
 			struct mlx5_core_dev *mdev, struct mlx5_core_cq *mcq)
 {
 	mlx5_core_modify_cq_moderation(mdev, mcq, moder.usec, moder.pkts);
@@ -43,9 +43,9 @@ mlx5e_complete_dim_work(struct net_dim *dim, struct net_dim_cq_moder moder,
 
 void mlx5e_rx_dim_work(struct work_struct *work)
 {
-	struct net_dim *dim = container_of(work, struct net_dim, work);
+	struct dim *dim = container_of(work, struct dim, work);
 	struct mlx5e_rq *rq = container_of(dim, struct mlx5e_rq, dim);
-	struct net_dim_cq_moder cur_moder =
+	struct dim_cq_moder cur_moder =
 		net_dim_get_rx_moderation(dim->mode, dim->profile_ix);
 
 	mlx5e_complete_dim_work(dim, cur_moder, rq->mdev, &rq->cq.mcq);
@@ -53,9 +53,9 @@ void mlx5e_rx_dim_work(struct work_struct *work)
 
 void mlx5e_tx_dim_work(struct work_struct *work)
 {
-	struct net_dim *dim = container_of(work, struct net_dim, work);
+	struct dim *dim = container_of(work, struct dim, work);
 	struct mlx5e_txqsq *sq = container_of(dim, struct mlx5e_txqsq, dim);
-	struct net_dim_cq_moder cur_moder =
+	struct dim_cq_moder cur_moder =
 		net_dim_get_tx_moderation(dim->mode, dim->profile_ix);
 
 	mlx5e_complete_dim_work(dim, cur_moder, sq->cq.mdev, &sq->cq.mcq);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index 3bbccead2f63..5c693556cd1e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -399,7 +399,7 @@ static int mlx5e_set_channels(struct net_device *dev,
 int mlx5e_ethtool_get_coalesce(struct mlx5e_priv *priv,
 			       struct ethtool_coalesce *coal)
 {
-	struct net_dim_cq_moder *rx_moder, *tx_moder;
+	struct dim_cq_moder *rx_moder, *tx_moder;
 
 	if (!MLX5_CAP_GEN(priv->mdev, cq_moderation))
 		return -EOPNOTSUPP;
@@ -454,7 +454,7 @@ mlx5e_set_priv_channels_coalesce(struct mlx5e_priv *priv, struct ethtool_coalesc
 int mlx5e_ethtool_set_coalesce(struct mlx5e_priv *priv,
 			       struct ethtool_coalesce *coal)
 {
-	struct net_dim_cq_moder *rx_moder, *tx_moder;
+	struct dim_cq_moder *rx_moder, *tx_moder;
 	struct mlx5_core_dev *mdev = priv->mdev;
 	struct mlx5e_channels new_channels = {};
 	int err = 0;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 7d80f803f445..6ed12a77cdb4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -1773,7 +1773,7 @@ static void mlx5e_destroy_cq(struct mlx5e_cq *cq)
 }
 
 static int mlx5e_open_cq(struct mlx5e_channel *c,
-			 struct net_dim_cq_moder moder,
+			 struct dim_cq_moder moder,
 			 struct mlx5e_cq_param *param,
 			 struct mlx5e_cq *cq)
 {
@@ -1978,7 +1978,7 @@ static int mlx5e_open_channel(struct mlx5e_priv *priv, int ix,
 			      struct mlx5e_channel **cp)
 {
 	int cpu = cpumask_first(mlx5_comp_irq_get_affinity_mask(priv->mdev, ix));
-	struct net_dim_cq_moder icocq_moder = {0, 0};
+	struct dim_cq_moder icocq_moder = {0, 0};
 	struct net_device *netdev = priv->netdev;
 	struct mlx5e_channel *c;
 	unsigned int irq;
@@ -4516,9 +4516,9 @@ static bool slow_pci_heuristic(struct mlx5_core_dev *mdev)
 		link_speed > MLX5E_SLOW_PCI_RATIO * pci_bw;
 }
 
-static struct net_dim_cq_moder mlx5e_get_def_tx_moderation(u8 cq_period_mode)
+static struct dim_cq_moder mlx5e_get_def_tx_moderation(u8 cq_period_mode)
 {
-	struct net_dim_cq_moder moder;
+	struct dim_cq_moder moder;
 
 	moder.cq_period_mode = cq_period_mode;
 	moder.pkts = MLX5E_PARAMS_DEFAULT_TX_CQ_MODERATION_PKTS;
@@ -4529,9 +4529,9 @@ static struct net_dim_cq_moder mlx5e_get_def_tx_moderation(u8 cq_period_mode)
 	return moder;
 }
 
-static struct net_dim_cq_moder mlx5e_get_def_rx_moderation(u8 cq_period_mode)
+static struct dim_cq_moder mlx5e_get_def_rx_moderation(u8 cq_period_mode)
 {
-	struct net_dim_cq_moder moder;
+	struct dim_cq_moder moder;
 
 	moder.cq_period_mode = cq_period_mode;
 	moder.pkts = MLX5E_PARAMS_DEFAULT_RX_CQ_MODERATION_PKTS;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
index 6dd820242f4b..432474754d77 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
@@ -48,24 +48,24 @@ static inline bool mlx5e_channel_no_affinity_change(struct mlx5e_channel *c)
 static void mlx5e_handle_tx_dim(struct mlx5e_txqsq *sq)
 {
 	struct mlx5e_sq_stats *stats = sq->stats;
-	struct net_dim_sample dim_sample;
+	struct dim_sample dim_sample;
 
 	if (unlikely(!test_bit(MLX5E_SQ_STATE_AM, &sq->state)))
 		return;
 
-	net_dim_create_sample(sq->cq.event_ctr, stats->packets, stats->bytes, &dim_sample);
+	dim_create_sample(sq->cq.event_ctr, stats->packets, stats->bytes, &dim_sample);
 	net_dim(&sq->dim, dim_sample);
 }
 
 static void mlx5e_handle_rx_dim(struct mlx5e_rq *rq)
 {
 	struct mlx5e_rq_stats *stats = rq->stats;
-	struct net_dim_sample dim_sample;
+	struct dim_sample dim_sample;
 
 	if (unlikely(!test_bit(MLX5E_RQ_STATE_AM, &rq->state)))
 		return;
 
-	net_dim_create_sample(rq->cq.event_ctr, stats->packets, stats->bytes, &dim_sample);
+	dim_create_sample(rq->cq.event_ctr, stats->packets, stats->bytes, &dim_sample);
 	net_dim(&rq->dim, dim_sample);
 }
 
diff --git a/include/linux/dim.h b/include/linux/dim.h
index 7809ffe470ff..8d9f8279ebee 100644
--- a/include/linux/dim.h
+++ b/include/linux/dim.h
@@ -42,13 +42,13 @@
 #define BIT_GAP(bits, end, start) ((((end) - (start)) + BIT_ULL(bits)) & (BIT_ULL(bits) - 1))
 
 
-struct net_dim_cq_moder {
+struct dim_cq_moder {
 	u16 usec;
 	u16 pkts;
 	u8 cq_period_mode;
 };
 
-struct net_dim_sample {
+struct dim_sample {
 	ktime_t time;
 	u32     pkt_ctr;
 	u32     byte_ctr;
@@ -61,10 +61,10 @@ struct dim_stats {
 	int epms; /* events per msec */
 };
 
-struct net_dim { /* Dynamic Interrupt Moderation */
+struct dim { /* Dynamic Interrupt Moderation */
 	u8                                      state;
 	struct dim_stats                        prev_stats;
-	struct net_dim_sample                   start_sample;
+	struct dim_sample                       start_sample;
 	struct work_struct                      work;
 	u8                                      profile_ix;
 	u8                                      mode;
@@ -105,7 +105,7 @@ enum {
 	DIM_ON_EDGE,
 };
 
-static inline bool dim_on_top(struct net_dim *dim)
+static inline bool dim_on_top(struct dim *dim)
 {
 	switch (dim->tune_state) {
 	case DIM_PARKING_ON_TOP:
@@ -118,7 +118,7 @@ static inline bool dim_on_top(struct net_dim *dim)
 	}
 }
 
-static inline void dim_turn(struct net_dim *dim)
+static inline void dim_turn(struct dim *dim)
 {
 	switch (dim->tune_state) {
 	case DIM_PARKING_ON_TOP:
@@ -135,7 +135,7 @@ static inline void dim_turn(struct net_dim *dim)
 	}
 }
 
-static inline void dim_park_on_top(struct net_dim *dim)
+static inline void dim_park_on_top(struct dim *dim)
 {
 	dim->steps_right  = 0;
 	dim->steps_left   = 0;
@@ -143,17 +143,17 @@ static inline void dim_park_on_top(struct net_dim *dim)
 	dim->tune_state   = DIM_PARKING_ON_TOP;
 }
 
-static inline void dim_park_tired(struct net_dim *dim)
+static inline void dim_park_tired(struct dim *dim)
 {
 	dim->steps_right  = 0;
 	dim->steps_left   = 0;
 	dim->tune_state   = DIM_PARKING_TIRED;
 }
 
-static inline void net_dim_create_sample(u16 event_ctr,
-					 u64 packets,
-					 u64 bytes,
-					 struct net_dim_sample *s)
+static inline void dim_create_sample(u16 event_ctr,
+				     u64 packets,
+				     u64 bytes,
+				     struct dim_sample *s)
 {
 	s->time	     = ktime_get();
 	s->pkt_ctr   = packets;
@@ -161,8 +161,8 @@ static inline void net_dim_create_sample(u16 event_ctr,
 	s->event_ctr = event_ctr;
 }
 
-static inline void dim_calc_stats(struct net_dim_sample *start,
-				  struct net_dim_sample *end,
+static inline void dim_calc_stats(struct dim_sample *start,
+				  struct dim_sample *end,
 				  struct dim_stats *curr_stats)
 {
 	/* u32 holds up to 71 minutes, should be enough */
diff --git a/include/linux/net_dim.h b/include/linux/net_dim.h
index 8cddfc93819c..e9363c372b68 100644
--- a/include/linux/net_dim.h
+++ b/include/linux/net_dim.h
@@ -77,28 +77,28 @@
 	{64, 32}   \
 }
 
-static const struct net_dim_cq_moder
+static const struct dim_cq_moder
 rx_profile[DIM_CQ_PERIOD_NUM_MODES][NET_DIM_PARAMS_NUM_PROFILES] = {
 	NET_DIM_RX_EQE_PROFILES,
 	NET_DIM_RX_CQE_PROFILES,
 };
 
-static const struct net_dim_cq_moder
+static const struct dim_cq_moder
 tx_profile[DIM_CQ_PERIOD_NUM_MODES][NET_DIM_PARAMS_NUM_PROFILES] = {
 	NET_DIM_TX_EQE_PROFILES,
 	NET_DIM_TX_CQE_PROFILES,
 };
 
-static inline struct net_dim_cq_moder
+static inline struct dim_cq_moder
 net_dim_get_rx_moderation(u8 cq_period_mode, int ix)
 {
-	struct net_dim_cq_moder cq_moder = rx_profile[cq_period_mode][ix];
+	struct dim_cq_moder cq_moder = rx_profile[cq_period_mode][ix];
 
 	cq_moder.cq_period_mode = cq_period_mode;
 	return cq_moder;
 }
 
-static inline struct net_dim_cq_moder
+static inline struct dim_cq_moder
 net_dim_get_def_rx_moderation(u8 cq_period_mode)
 {
 	u8 profile_ix = cq_period_mode == DIM_CQ_PERIOD_MODE_START_FROM_CQE ?
@@ -107,16 +107,16 @@ net_dim_get_def_rx_moderation(u8 cq_period_mode)
 	return net_dim_get_rx_moderation(cq_period_mode, profile_ix);
 }
 
-static inline struct net_dim_cq_moder
+static inline struct dim_cq_moder
 net_dim_get_tx_moderation(u8 cq_period_mode, int ix)
 {
-	struct net_dim_cq_moder cq_moder = tx_profile[cq_period_mode][ix];
+	struct dim_cq_moder cq_moder = tx_profile[cq_period_mode][ix];
 
 	cq_moder.cq_period_mode = cq_period_mode;
 	return cq_moder;
 }
 
-static inline struct net_dim_cq_moder
+static inline struct dim_cq_moder
 net_dim_get_def_tx_moderation(u8 cq_period_mode)
 {
 	u8 profile_ix = cq_period_mode == DIM_CQ_PERIOD_MODE_START_FROM_CQE ?
@@ -125,7 +125,7 @@ net_dim_get_def_tx_moderation(u8 cq_period_mode)
 	return net_dim_get_tx_moderation(cq_period_mode, profile_ix);
 }
 
-static inline int net_dim_step(struct net_dim *dim)
+static inline int net_dim_step(struct dim *dim)
 {
 	if (dim->tired == (NET_DIM_PARAMS_NUM_PROFILES * 2))
 		return DIM_TOO_TIRED;
@@ -152,7 +152,7 @@ static inline int net_dim_step(struct net_dim *dim)
 	return DIM_STEPPED;
 }
 
-static inline void net_dim_exit_parking(struct net_dim *dim)
+static inline void net_dim_exit_parking(struct dim *dim)
 {
 	dim->tune_state = dim->profile_ix ? DIM_GOING_LEFT :
 					  DIM_GOING_RIGHT;
@@ -189,7 +189,7 @@ static inline int net_dim_stats_compare(struct dim_stats *curr,
 }
 
 static inline bool net_dim_decision(struct dim_stats *curr_stats,
-				    struct net_dim *dim)
+				    struct dim *dim)
 {
 	int prev_state = dim->tune_state;
 	int prev_ix = dim->profile_ix;
@@ -240,8 +240,8 @@ static inline bool net_dim_decision(struct dim_stats *curr_stats,
 	return dim->profile_ix != prev_ix;
 }
 
-static inline void net_dim(struct net_dim *dim,
-			   struct net_dim_sample end_sample)
+static inline void net_dim(struct dim *dim,
+			   struct dim_sample end_sample)
 {
 	struct dim_stats curr_stats;
 	u16 nevents;
@@ -262,8 +262,8 @@ static inline void net_dim(struct net_dim *dim,
 		}
 		/* fall through */
 	case DIM_START_MEASURE:
-		net_dim_create_sample(end_sample.event_ctr, end_sample.pkt_ctr,
-				      end_sample.byte_ctr, &dim->start_sample);
+		dim_create_sample(end_sample.event_ctr, end_sample.pkt_ctr,
+				  end_sample.byte_ctr, &dim->start_sample);
 		dim->state = DIM_MEASURE_IN_PROGRESS;
 		break;
 	case DIM_APPLY_NEW_PROFILE:
-- 
2.19.1

