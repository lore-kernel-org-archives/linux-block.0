Return-Path: <SRS0=hv45=N7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C647FC43610
	for <linux-block@archiver.kernel.org>; Tue, 20 Nov 2018 23:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDBEA20870
	for <linux-block@archiver.kernel.org>; Tue, 20 Nov 2018 23:36:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDBEA20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kazan-networks.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbeKUKIG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Nov 2018 05:08:06 -0500
Received: from mail-eopbgr710051.outbound.protection.outlook.com ([40.107.71.51]:4250
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725946AbeKUKIG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Nov 2018 05:08:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kazannetworks.onmicrosoft.com; s=selector1-kazannetworks-com01c;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yewx5lkoZMi7emwYFQCzwTvbakRMezQqxZYlMgM/B2g=;
 b=AjhbiHxlqEiDfpndJ75QGXXKZnnXqkwuqBMira4OsSfXYreZDs1AMkfFTHlXazS7HIWz8YoxrEORI+7Lx9bCaB0WlAC+XHbWuSKhZbXYkExPFqkFvnUEjieyoQnfZm/GsxqTbODaXxrMul6V3zDR15Mjigb+0TQfVIX0GmgaiTk=
Received: from MWHPR08MB2685.namprd08.prod.outlook.com (10.173.231.144) by
 MWHPR08MB2528.namprd08.prod.outlook.com (10.173.230.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.25; Tue, 20 Nov 2018 23:34:06 +0000
Received: from MWHPR08MB2685.namprd08.prod.outlook.com
 ([fe80::6cbe:cbfe:f6ff:89e6]) by MWHPR08MB2685.namprd08.prod.outlook.com
 ([fe80::6cbe:cbfe:f6ff:89e6%6]) with mapi id 15.20.1339.027; Tue, 20 Nov 2018
 23:34:06 +0000
From:   Narayan Ayalasomayajula 
        <narayan.ayalasomayajula@kazan-networks.com>
To:     Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Christoph Hellwig <hch@lst.de>
Subject: RE: [PATCH v2 14/14] nvme-tcp: add NVMe over TCP host driver
Thread-Topic: [PATCH v2 14/14] nvme-tcp: add NVMe over TCP host driver
Thread-Index: AQHUgH2P1CwD7A1Tpk2QPv03ljdHVaVZOZGA
Date:   Tue, 20 Nov 2018 23:34:05 +0000
Message-ID: <MWHPR08MB2685DD0299C66EE7CD853B3DC0D90@MWHPR08MB2685.namprd08.prod.outlook.com>
References: <20181120030019.31738-1-sagi@grimberg.me>
 <20181120030019.31738-16-sagi@grimberg.me>
In-Reply-To: <20181120030019.31738-16-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=narayan.ayalasomayajula@kazan-networks.com; 
x-originating-ip: [50.225.120.254]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR08MB2528;6:MUzWAEA3jXo/upuCkp9xRx7ZycRtxtDADDIgxwcTbYGdnS1O6f/qPPGfy6jKz6w4D5kKh7ZGzirHCFFbiqIcQgPz1RL9YHKjJp/WHUb2d6pi8+rDjdLF1YUTT5/BSld86rn2eP76cRP1ezrq4cY5fHr4GjUdSIcmYDvU51MsdE4raKfXD0kYEnWT8V0cdXZtmhQhA/3v1FMguPXeXKewoiC4A9WbnTrh52NjQ+yC1M46m4ARpR+9Itu0e8/S0KLc/CAv2cY5YYNr475JwdSMCwuowetUyIZMUcA/qqGWrkYht/SHLksLobWxDouHdw3hc/cdiYkYWO3oHdhn326BllcAk8t1o21+i9zVCov/zDAFWuVE2RqVf+4KNWMVgqrF+aKazAU82KAjyeI1okEKr0AflRrH6GUO0vWQ+NF3hSoQKcK8myW1tYkUc92F7hXulEL89y5eC1NCPHtAh3Kxxg==;5:VDas60zGFSMJxA1UPpKf6s02HyKuGWRchROqVerqnhS3uUbqsZoPHbTVz3lHyLdQmon8F0EBHjpZzcypLnLfNNFyjduAHxd84+NHcMwG9bWW1a5OZ9jwkekdReGXuFWvaeBw10LyLudVHEqR6nXMJYMgXQRyQ1s6SUFXwKOUCWM=;7:You3UXsPw+4xi9kDc7haBWBjsEdw101AnJgjiv8M6s2NJAa4oDRCjUDtTE6+TuWO4DZe59hjyssT9es8SWjJKr8gjLd0CtvmJkg3wNcW+y4xvBDsUlihpXFpfAcjgEuMV+8bYX7z9HrCpi5BKsvnfg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: f00cdff3-06f1-4aa6-8a8a-08d64f40a986
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:MWHPR08MB2528;
x-ms-traffictypediagnostic: MWHPR08MB2528:
x-microsoft-antispam-prvs: <MWHPR08MB2528DE84D228A49E48A569D7C0D90@MWHPR08MB2528.namprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231442)(944501410)(4982022)(52105112)(148016)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123562045)(2016111802025)(20161123564045)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR08MB2528;BCL:0;PCL:0;RULEID:;SRVR:MWHPR08MB2528;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(366004)(376002)(346002)(39830400003)(51234002)(13464003)(199004)(189003)(105586002)(106356001)(14444005)(256004)(4744004)(14454004)(71190400001)(71200400001)(508600001)(229853002)(25786009)(2906002)(33656002)(7736002)(6246003)(446003)(55016002)(476003)(486006)(44832011)(26005)(102836004)(186003)(81156014)(11346002)(2900100001)(1720100001)(6436002)(53936002)(2501003)(76176011)(68736007)(53946003)(6506007)(8676002)(99286004)(9686003)(7696005)(53546011)(6306002)(3846002)(6116002)(86362001)(575784001)(305945005)(97736004)(966005)(66066001)(74316002)(4326008)(8936002)(5660300001)(110136005)(81166006)(316002)(54906003)(559001)(569006);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR08MB2528;H:MWHPR08MB2685.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: kazan-networks.com does not
 designate permitted sender hosts)
x-microsoft-antispam-message-info: KpfMc23iNMeKLcyP/7DwXctz2S0Nv95lMNnLzMjRF9U+Y7/0Zxd0X1yMy/b8GWSBR2VQtiC6xVGQViFEs0aVWjzEhX8RiKFoABkD63XEyDOR8UxYzPRznn/rVdHrAJ6JyIBw0BybSZAsB/5YnRUgohs9na29NSqDBATRq1etiWJ2uhF4AJ9zfDYp/epk9ztAk/P2/No/HLidab4Ohn1qSnxygM+iMd889v6Qf6Ho8VUxZ0AP9Nq1o4wWhq1Q/tt4EU/DdIELTExskLdT95SG+KhkppcP62e7CI8QTzxU7erGXgtD6dEW9bWCSL/9SwaN94UwLoa4eEjR5AAcIlg/98R41zIddZWdpXRz6WEwM0U=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: kazan-networks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f00cdff3-06f1-4aa6-8a8a-08d64f40a986
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 23:34:05.8296
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4be78cb4-18e1-468c-af31-7f1298442f0c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR08MB2528
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Sagi,

>+       icreq->pfv =3D cpu_to_le16(NVME_TCP_PFV_1_0);
>+       icreq->maxr2t =3D cpu_to_le16(1); /* single inflight r2t supported=
 */
>+       icreq->hpda =3D 0; /* no alignment constraint */

The NVMe-TCP spec indicates that MAXR2T is a 0's-based value. To support a =
single inflight R2T as indicated in the comment above, icreq->maxr2t should=
 be set to 0, right?=20

Thanks,
Narayan

-----Original Message-----
From: Linux-nvme <linux-nvme-bounces@lists.infradead.org> On Behalf Of Sagi=
 Grimberg
Sent: Monday, November 19, 2018 7:00 PM
To: linux-nvme@lists.infradead.org
Cc: linux-block@vger.kernel.org; netdev@vger.kernel.org; Keith Busch <keith=
.busch@intel.com>; David S. Miller <davem@davemloft.net>; Christoph Hellwig=
 <hch@lst.de>
Subject: [PATCH v2 14/14] nvme-tcp: add NVMe over TCP host driver

[EXTERNAL EMAIL]
This email was received from outside the organization.
________________________________

From: Sagi Grimberg <sagi@lightbitslabs.com>

This patch implements the NVMe over TCP host driver. It can be used to
connect to remote NVMe over Fabrics subsystems over good old TCP/IP.

The driver implements the TP 8000 of how nvme over fabrics capsules and
data are encapsulated in nvme-tcp pdus and exchaged on top of a TCP byte
stream. nvme-tcp header and data digest are supported as well.

To connect to all NVMe over Fabrics controllers reachable on a given taget
port over TCP use the following command:

        nvme connect-all -t tcp -a $IPADDR

This requires the latest version of nvme-cli with TCP support.

Signed-off-by: Sagi Grimberg <sagi@lightbitslabs.com>
Signed-off-by: Roy Shterman <roys@lightbitslabs.com>
Signed-off-by: Solganik Alexander <sashas@lightbitslabs.com>
---
 drivers/nvme/host/Kconfig  |   15 +
 drivers/nvme/host/Makefile |    3 +
 drivers/nvme/host/tcp.c    | 2306 ++++++++++++++++++++++++++++++++++++
 3 files changed, 2324 insertions(+)
 create mode 100644 drivers/nvme/host/tcp.c

diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index 88a8b5916624..0f345e207675 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -57,3 +57,18 @@ config NVME_FC
          from https://github.com/linux-nvme/nvme-cli.

          If unsure, say N.
+
+config NVME_TCP
+       tristate "NVM Express over Fabrics TCP host driver"
+       depends on INET
+       depends on BLK_DEV_NVME
+       select NVME_FABRICS
+       help
+         This provides support for the NVMe over Fabrics protocol using
+         the TCP transport.  This allows you to use remote block devices
+         exported using the NVMe protocol set.
+
+         To configure a NVMe over Fabrics controller use the nvme-cli tool
+         from https://github.com/linux-nvme/nvme-cli.
+
+         If unsure, say N.
diff --git a/drivers/nvme/host/Makefile b/drivers/nvme/host/Makefile
index aea459c65ae1..8a4b671c5f0c 100644
--- a/drivers/nvme/host/Makefile
+++ b/drivers/nvme/host/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_BLK_DEV_NVME)              +=3D nvme.o
 obj-$(CONFIG_NVME_FABRICS)             +=3D nvme-fabrics.o
 obj-$(CONFIG_NVME_RDMA)                        +=3D nvme-rdma.o
 obj-$(CONFIG_NVME_FC)                  +=3D nvme-fc.o
+obj-$(CONFIG_NVME_TCP)                 +=3D nvme-tcp.o

 nvme-core-y                            :=3D core.o
 nvme-core-$(CONFIG_TRACING)            +=3D trace.o
@@ -21,3 +22,5 @@ nvme-fabrics-y                                +=3D fabric=
s.o
 nvme-rdma-y                            +=3D rdma.o

 nvme-fc-y                              +=3D fc.o
+
+nvme-tcp-y                             +=3D tcp.o
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
new file mode 100644
index 000000000000..4c583859f0ad
--- /dev/null
+++ b/drivers/nvme/host/tcp.c
@@ -0,0 +1,2306 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * NVMe over Fabrics TCP host.
+ * Copyright (c) 2018 LightBits Labs. All rights reserved.
+ */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/err.h>
+#include <linux/nvme-tcp.h>
+#include <net/sock.h>
+#include <net/tcp.h>
+#include <linux/blk-mq.h>
+#include <crypto/hash.h>
+
+#include "nvme.h"
+#include "fabrics.h"
+
+struct nvme_tcp_queue;
+
+enum nvme_tcp_send_state {
+       NVME_TCP_SEND_CMD_PDU =3D 0,
+       NVME_TCP_SEND_H2C_PDU,
+       NVME_TCP_SEND_DATA,
+       NVME_TCP_SEND_DDGST,
+};
+
+struct nvme_tcp_send_ctx {
+       struct bio              *curr_bio;
+       struct iov_iter         iter;
+       size_t                  offset;
+       size_t                  data_sent;
+       enum nvme_tcp_send_state state;
+};
+
+struct nvme_tcp_recv_ctx {
+       struct iov_iter         iter;
+       struct bio              *curr_bio;
+};
+
+struct nvme_tcp_request {
+       struct nvme_request     req;
+       void                    *pdu;
+       struct nvme_tcp_queue   *queue;
+       u32                     data_len;
+       u32                     pdu_len;
+       u32                     pdu_sent;
+       u16                     ttag;
+       struct list_head        entry;
+       struct nvme_tcp_recv_ctx rcv;
+       struct nvme_tcp_send_ctx snd;
+       u32                     ddgst;
+};
+
+enum nvme_tcp_queue_flags {
+       NVME_TCP_Q_ALLOCATED    =3D 0,
+       NVME_TCP_Q_LIVE         =3D 1,
+};
+
+enum nvme_tcp_recv_state {
+       NVME_TCP_RECV_PDU =3D 0,
+       NVME_TCP_RECV_DATA,
+       NVME_TCP_RECV_DDGST,
+};
+
+struct nvme_tcp_queue_recv_ctx {
+       char            *pdu;
+       int             pdu_remaining;
+       int             pdu_offset;
+       size_t          data_remaining;
+       size_t          ddgst_remaining;
+};
+
+struct nvme_tcp_ctrl;
+struct nvme_tcp_queue {
+       struct socket           *sock;
+       struct work_struct      io_work;
+       int                     io_cpu;
+
+       spinlock_t              lock;
+       struct list_head        send_list;
+
+       int                     queue_size;
+       size_t                  cmnd_capsule_len;
+       struct nvme_tcp_ctrl    *ctrl;
+       unsigned long           flags;
+       bool                    rd_enabled;
+
+       struct nvme_tcp_queue_recv_ctx rcv;
+       struct nvme_tcp_request *request;
+
+       bool                    hdr_digest;
+       bool                    data_digest;
+       struct ahash_request    *rcv_hash;
+       struct ahash_request    *snd_hash;
+       __le32                  exp_ddgst;
+       __le32                  recv_ddgst;
+
+       struct page_frag_cache  pf_cache;
+
+       void (*sc)(struct sock *);
+       void (*dr)(struct sock *);
+       void (*ws)(struct sock *);
+};
+
+struct nvme_tcp_ctrl {
+       /* read only in the hot path */
+       struct nvme_tcp_queue   *queues;
+       struct blk_mq_tag_set   tag_set;
+
+       /* other member variables */
+       struct list_head        list;
+       struct blk_mq_tag_set   admin_tag_set;
+       struct sockaddr_storage addr;
+       struct sockaddr_storage src_addr;
+       struct nvme_ctrl        ctrl;
+
+       struct nvme_tcp_request async_req;
+};
+
+static LIST_HEAD(nvme_tcp_ctrl_list);
+static DEFINE_MUTEX(nvme_tcp_ctrl_mutex);
+static struct workqueue_struct *nvme_tcp_wq;
+static struct blk_mq_ops nvme_tcp_mq_ops;
+static struct blk_mq_ops nvme_tcp_admin_mq_ops;
+
+static inline struct nvme_tcp_ctrl *to_tcp_ctrl(struct nvme_ctrl *ctrl)
+{
+       return container_of(ctrl, struct nvme_tcp_ctrl, ctrl);
+}
+
+static inline int nvme_tcp_queue_id(struct nvme_tcp_queue *queue)
+{
+       return queue - queue->ctrl->queues;
+}
+
+static inline struct blk_mq_tags *nvme_tcp_tagset(struct nvme_tcp_queue *q=
ueue)
+{
+       u32 queue_idx =3D nvme_tcp_queue_id(queue);
+
+       if (queue_idx =3D=3D 0)
+               return queue->ctrl->admin_tag_set.tags[queue_idx];
+       return queue->ctrl->tag_set.tags[queue_idx - 1];
+}
+
+static inline u8 nvme_tcp_hdgst_len(struct nvme_tcp_queue *queue)
+{
+       return queue->hdr_digest ? NVME_TCP_DIGEST_LENGTH : 0;
+}
+
+static inline u8 nvme_tcp_ddgst_len(struct nvme_tcp_queue *queue)
+{
+       return queue->data_digest ? NVME_TCP_DIGEST_LENGTH : 0;
+}
+
+static inline size_t nvme_tcp_inline_data_size(struct nvme_tcp_queue *queu=
e)
+{
+       return queue->cmnd_capsule_len - sizeof(struct nvme_command);
+}
+
+static inline bool nvme_tcp_async_req(struct nvme_tcp_request *req)
+{
+       return req =3D=3D &req->queue->ctrl->async_req;
+}
+
+static inline bool nvme_tcp_has_inline_data(struct nvme_tcp_request *req)
+{
+       struct request *rq;
+       unsigned int bytes;
+
+       if (unlikely(nvme_tcp_async_req(req)))
+               return false; /* async events don't have a request */
+
+       rq =3D blk_mq_rq_from_pdu(req);
+       bytes =3D blk_rq_payload_bytes(rq);
+
+       return rq_data_dir(rq) =3D=3D WRITE && bytes &&
+               bytes <=3D nvme_tcp_inline_data_size(req->queue);
+}
+
+static inline struct page *nvme_tcp_req_cur_page(struct nvme_tcp_request *=
req)
+{
+       return req->snd.iter.bvec->bv_page;
+}
+
+static inline size_t nvme_tcp_req_cur_offset(struct nvme_tcp_request *req)
+{
+       return req->snd.iter.bvec->bv_offset + req->snd.iter.iov_offset;
+}
+
+static inline size_t nvme_tcp_req_cur_length(struct nvme_tcp_request *req)
+{
+       return min_t(size_t, req->snd.iter.bvec->bv_len - req->snd.iter.iov=
_offset,
+                       req->pdu_len - req->pdu_sent);
+}
+
+static inline size_t nvme_tcp_req_offset(struct nvme_tcp_request *req)
+{
+       return req->snd.iter.iov_offset;
+}
+
+static inline size_t nvme_tcp_pdu_data_left(struct nvme_tcp_request *req)
+{
+       return rq_data_dir(blk_mq_rq_from_pdu(req)) =3D=3D WRITE ?
+                       req->pdu_len - req->pdu_sent : 0;
+}
+
+static inline size_t nvme_tcp_pdu_last_send(struct nvme_tcp_request *req,
+               int len)
+{
+       return nvme_tcp_pdu_data_left(req) <=3D len;
+}
+
+static void nvme_tcp_init_send_iter(struct nvme_tcp_request *req)
+{
+       struct request *rq =3D blk_mq_rq_from_pdu(req);
+       struct bio_vec *vec;
+       unsigned int size;
+       int nsegs;
+       size_t offset;
+
+       if (rq->rq_flags & RQF_SPECIAL_PAYLOAD) {
+               vec =3D &rq->special_vec;
+               nsegs =3D 1;
+               size =3D blk_rq_payload_bytes(rq);
+               offset =3D 0;
+       } else {
+               struct bio *bio =3D req->snd.curr_bio;
+
+               vec =3D __bvec_iter_bvec(bio->bi_io_vec, bio->bi_iter);
+               nsegs =3D bio_segments(bio);
+               size =3D bio->bi_iter.bi_size;
+               offset =3D bio->bi_iter.bi_bvec_done;
+       }
+
+       iov_iter_bvec(&req->snd.iter, WRITE, vec, nsegs, size);
+       req->snd.iter.iov_offset =3D offset;
+}
+
+static inline void nvme_tcp_advance_req(struct nvme_tcp_request *req,
+               int len)
+{
+       req->snd.data_sent +=3D len;
+       req->pdu_sent +=3D len;
+       iov_iter_advance(&req->snd.iter, len);
+       if (!iov_iter_count(&req->snd.iter) &&
+           req->snd.data_sent < req->data_len) {
+               req->snd.curr_bio =3D req->snd.curr_bio->bi_next;
+               nvme_tcp_init_send_iter(req);
+       }
+}
+
+static inline void nvme_tcp_queue_request(struct nvme_tcp_request *req)
+{
+       struct nvme_tcp_queue *queue =3D req->queue;
+
+       spin_lock_bh(&queue->lock);
+       list_add_tail(&req->entry, &queue->send_list);
+       spin_unlock_bh(&queue->lock);
+
+       queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
+}
+
+static inline struct nvme_tcp_request *
+nvme_tcp_fetch_request(struct nvme_tcp_queue *queue)
+{
+       struct nvme_tcp_request *req;
+
+       spin_lock_bh(&queue->lock);
+       req =3D list_first_entry_or_null(&queue->send_list,
+                       struct nvme_tcp_request, entry);
+       if (req)
+               list_del(&req->entry);
+       spin_unlock_bh(&queue->lock);
+
+       return req;
+}
+
+static inline void nvme_tcp_ddgst_final(struct ahash_request *hash, u32 *d=
gst)
+{
+       ahash_request_set_crypt(hash, NULL, (u8 *)dgst, 0);
+       crypto_ahash_final(hash);
+}
+
+static inline void nvme_tcp_ddgst_update(struct ahash_request *hash,
+               struct page *page, off_t off, size_t len)
+{
+       struct scatterlist sg;
+
+       sg_init_marker(&sg, 1);
+       sg_set_page(&sg, page, len, off);
+       ahash_request_set_crypt(hash, &sg, NULL, len);
+       crypto_ahash_update(hash);
+}
+
+static inline void nvme_tcp_hdgst(struct ahash_request *hash,
+               void *pdu, size_t len)
+{
+       struct scatterlist sg;
+
+       sg_init_one(&sg, pdu, len);
+       ahash_request_set_crypt(hash, &sg, pdu + len, len);
+       crypto_ahash_digest(hash);
+}
+
+static int nvme_tcp_verify_hdgst(struct nvme_tcp_queue *queue,
+       void *pdu, size_t pdu_len)
+{
+       struct nvme_tcp_hdr *hdr =3D pdu;
+       __le32 recv_digest;
+       __le32 exp_digest;
+
+       if (unlikely(!(hdr->flags & NVME_TCP_F_HDGST))) {
+               dev_err(queue->ctrl->ctrl.device,
+                       "queue %d: header digest flag is cleared\n",
+                       nvme_tcp_queue_id(queue));
+               return -EPROTO;
+       }
+
+       recv_digest =3D *(__le32 *)(pdu + hdr->hlen);
+       nvme_tcp_hdgst(queue->rcv_hash, pdu, pdu_len);
+       exp_digest =3D *(__le32 *)(pdu + hdr->hlen);
+       if (recv_digest !=3D exp_digest) {
+               dev_err(queue->ctrl->ctrl.device,
+                       "header digest error: recv %#x expected %#x\n",
+                       le32_to_cpu(recv_digest), le32_to_cpu(exp_digest));
+               return -EIO;
+       }
+
+       return 0;
+}
+
+static int nvme_tcp_check_ddgst(struct nvme_tcp_queue *queue, void *pdu)
+{
+       struct nvme_tcp_hdr *hdr =3D pdu;
+       u32 len;
+
+       len =3D le32_to_cpu(hdr->plen) - hdr->hlen -
+               ((hdr->flags & NVME_TCP_F_HDGST) ? nvme_tcp_hdgst_len(queue=
) : 0);
+
+       if (unlikely(len && !(hdr->flags & NVME_TCP_F_DDGST))) {
+               dev_err(queue->ctrl->ctrl.device,
+                       "queue %d: data digest flag is cleared\n",
+               nvme_tcp_queue_id(queue));
+               return -EPROTO;
+       }
+       crypto_ahash_init(queue->rcv_hash);
+
+       return 0;
+}
+
+static void nvme_tcp_exit_request(struct blk_mq_tag_set *set,
+               struct request *rq, unsigned int hctx_idx)
+{
+       struct nvme_tcp_request *req =3D blk_mq_rq_to_pdu(rq);
+
+       page_frag_free(req->pdu);
+}
+
+static int nvme_tcp_init_request(struct blk_mq_tag_set *set,
+               struct request *rq, unsigned int hctx_idx,
+               unsigned int numa_node)
+{
+       struct nvme_tcp_ctrl *ctrl =3D set->driver_data;
+       struct nvme_tcp_request *req =3D blk_mq_rq_to_pdu(rq);
+       int queue_idx =3D (set =3D=3D &ctrl->tag_set) ? hctx_idx + 1 : 0;
+       struct nvme_tcp_queue *queue =3D &ctrl->queues[queue_idx];
+       u8 hdgst =3D nvme_tcp_hdgst_len(queue);
+
+       req->pdu =3D page_frag_alloc(&queue->pf_cache,
+               sizeof(struct nvme_tcp_cmd_pdu) + hdgst,
+               GFP_KERNEL | __GFP_ZERO);
+       if (!req->pdu)
+               return -ENOMEM;
+
+       req->queue =3D queue;
+       nvme_req(rq)->ctrl =3D &ctrl->ctrl;
+
+       return 0;
+}
+
+static int nvme_tcp_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
+               unsigned int hctx_idx)
+{
+       struct nvme_tcp_ctrl *ctrl =3D data;
+       struct nvme_tcp_queue *queue =3D &ctrl->queues[hctx_idx + 1];
+
+       BUG_ON(hctx_idx >=3D ctrl->ctrl.queue_count);
+
+       hctx->driver_data =3D queue;
+       return 0;
+}
+
+static int nvme_tcp_init_admin_hctx(struct blk_mq_hw_ctx *hctx, void *data=
,
+               unsigned int hctx_idx)
+{
+       struct nvme_tcp_ctrl *ctrl =3D data;
+       struct nvme_tcp_queue *queue =3D &ctrl->queues[0];
+
+       BUG_ON(hctx_idx !=3D 0);
+
+       hctx->driver_data =3D queue;
+       return 0;
+}
+
+static enum nvme_tcp_recv_state nvme_tcp_recv_state(struct nvme_tcp_queue =
*queue)
+{
+       return  (queue->rcv.pdu_remaining) ? NVME_TCP_RECV_PDU :
+               (queue->rcv.ddgst_remaining) ? NVME_TCP_RECV_DDGST :
+               NVME_TCP_RECV_DATA;
+}
+
+static void nvme_tcp_init_recv_ctx(struct nvme_tcp_queue *queue)
+{
+       struct nvme_tcp_queue_recv_ctx *rcv =3D &queue->rcv;
+
+       rcv->pdu_remaining =3D sizeof(struct nvme_tcp_rsp_pdu) +
+                               nvme_tcp_hdgst_len(queue);
+       rcv->pdu_offset =3D 0;
+       rcv->data_remaining =3D -1;
+       rcv->ddgst_remaining =3D 0;
+}
+
+void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
+{
+       if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
+               return;
+
+       queue_work(nvme_wq, &ctrl->err_work);
+}
+
+static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
+               struct nvme_completion *cqe)
+{
+       struct request *rq;
+       struct nvme_tcp_request *req;
+
+       rq =3D blk_mq_tag_to_rq(nvme_tcp_tagset(queue), cqe->command_id);
+       if (!rq) {
+               dev_err(queue->ctrl->ctrl.device,
+                       "queue %d tag 0x%x not found\n",
+                       nvme_tcp_queue_id(queue), cqe->command_id);
+               nvme_tcp_error_recovery(&queue->ctrl->ctrl);
+               return -EINVAL;
+       }
+       req =3D blk_mq_rq_to_pdu(rq);
+
+       nvme_end_request(rq, cqe->status, cqe->result);
+
+       return 0;
+}
+
+static int nvme_tcp_handle_c2h_data(struct nvme_tcp_queue *queue,
+               struct nvme_tcp_data_pdu *pdu)
+{
+       struct nvme_tcp_queue_recv_ctx *rcv =3D &queue->rcv;
+       struct nvme_tcp_request *req;
+       struct request *rq;
+
+       rq =3D blk_mq_tag_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
+       if (!rq) {
+               dev_err(queue->ctrl->ctrl.device,
+                       "queue %d tag %#x not found\n",
+                       nvme_tcp_queue_id(queue), pdu->command_id);
+               return -ENOENT;
+       }
+       req =3D blk_mq_rq_to_pdu(rq);
+
+       if (!blk_rq_payload_bytes(rq)) {
+               dev_err(queue->ctrl->ctrl.device,
+                       "queue %d tag %#x unexpected data\n",
+                       nvme_tcp_queue_id(queue), rq->tag);
+               return -EIO;
+       }
+
+       rcv->data_remaining =3D le32_to_cpu(pdu->data_length);
+       /* No support for out-of-order */
+       WARN_ON(le32_to_cpu(pdu->data_offset));
+
+       return 0;
+
+}
+
+static int nvme_tcp_handle_comp(struct nvme_tcp_queue *queue,
+               struct nvme_tcp_rsp_pdu *pdu)
+{
+       struct nvme_completion *cqe =3D &pdu->cqe;
+       int ret =3D 0;
+
+       /*
+        * AEN requests are special as they don't time out and can
+        * survive any kind of queue freeze and often don't respond to
+        * aborts.  We don't even bother to allocate a struct request
+        * for them but rather special case them here.
+        */
+       if (unlikely(nvme_tcp_queue_id(queue) =3D=3D 0 &&
+           cqe->command_id >=3D NVME_AQ_BLK_MQ_DEPTH))
+               nvme_complete_async_event(&queue->ctrl->ctrl, cqe->status,
+                               &cqe->result);
+       else
+               ret =3D nvme_tcp_process_nvme_cqe(queue, cqe);
+
+       return ret;
+}
+
+static int nvme_tcp_setup_h2c_data_pdu(struct nvme_tcp_request *req,
+               struct nvme_tcp_r2t_pdu *pdu)
+{
+       struct nvme_tcp_data_pdu *data =3D req->pdu;
+       struct nvme_tcp_queue *queue =3D req->queue;
+       struct request *rq =3D blk_mq_rq_from_pdu(req);
+       u8 hdgst =3D nvme_tcp_hdgst_len(queue);
+       u8 ddgst =3D nvme_tcp_ddgst_len(queue);
+
+       req->pdu_len =3D le32_to_cpu(pdu->r2t_length);
+       req->pdu_sent =3D 0;
+
+       if (unlikely(req->snd.data_sent + req->pdu_len > req->data_len)) {
+               dev_err(queue->ctrl->ctrl.device,
+                       "req %d r2t length %u exceeded data length %u (%zu =
sent)\n",
+                       rq->tag, req->pdu_len, req->data_len,
+                       req->snd.data_sent);
+               return -EPROTO;
+       }
+
+       if (unlikely(le32_to_cpu(pdu->r2t_offset) < req->snd.data_sent)) {
+               dev_err(queue->ctrl->ctrl.device,
+                       "req %d unexpected r2t offset %u (expected %zu)\n",
+                       rq->tag, le32_to_cpu(pdu->r2t_offset),
+                       req->snd.data_sent);
+               return -EPROTO;
+       }
+
+       memset(data, 0, sizeof(*data));
+       data->hdr.type =3D nvme_tcp_h2c_data;
+       data->hdr.flags =3D NVME_TCP_F_DATA_LAST;
+       if (queue->hdr_digest)
+               data->hdr.flags |=3D NVME_TCP_F_HDGST;
+       if (queue->data_digest)
+               data->hdr.flags |=3D NVME_TCP_F_DDGST;
+       data->hdr.hlen =3D sizeof(*data);
+       data->hdr.pdo =3D data->hdr.hlen + hdgst;
+       data->hdr.plen =3D
+               cpu_to_le32(data->hdr.hlen + hdgst + req->pdu_len + ddgst);
+       data->ttag =3D pdu->ttag;
+       data->command_id =3D rq->tag;
+       data->data_offset =3D cpu_to_le32(req->snd.data_sent);
+       data->data_length =3D cpu_to_le32(req->pdu_len);
+       return 0;
+}
+
+static int nvme_tcp_handle_r2t(struct nvme_tcp_queue *queue,
+               struct nvme_tcp_r2t_pdu *pdu)
+{
+       struct nvme_tcp_request *req;
+       struct request *rq;
+       int ret;
+
+       rq =3D blk_mq_tag_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
+       if (!rq) {
+               dev_err(queue->ctrl->ctrl.device,
+                       "queue %d tag %#x not found\n",
+                       nvme_tcp_queue_id(queue), pdu->command_id);
+               return -ENOENT;
+       }
+       req =3D blk_mq_rq_to_pdu(rq);
+
+       ret =3D nvme_tcp_setup_h2c_data_pdu(req, pdu);
+       if (unlikely(ret))
+               return ret;
+
+       req->snd.state =3D NVME_TCP_SEND_H2C_PDU;
+       req->snd.offset =3D 0;
+
+       nvme_tcp_queue_request(req);
+
+       return 0;
+}
+
+static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff =
*skb,
+               unsigned int *offset, size_t *len)
+{
+       struct nvme_tcp_queue_recv_ctx *rcv =3D &queue->rcv;
+       struct nvme_tcp_hdr *hdr;
+       size_t rcv_len =3D min_t(size_t, *len, rcv->pdu_remaining);
+       int ret;
+
+       ret =3D skb_copy_bits(skb, *offset, &rcv->pdu[rcv->pdu_offset], rcv=
_len);
+       if (unlikely(ret))
+               return ret;
+
+       rcv->pdu_remaining -=3D rcv_len;
+       rcv->pdu_offset +=3D rcv_len;
+       *offset +=3D rcv_len;
+       *len -=3D rcv_len;
+       if (queue->rcv.pdu_remaining)
+               return 0;
+
+       hdr =3D (void *)rcv->pdu;
+       if (queue->hdr_digest) {
+               ret =3D nvme_tcp_verify_hdgst(queue, rcv->pdu, hdr->hlen);
+               if (unlikely(ret))
+                       return ret;
+       }
+
+
+       if (queue->data_digest) {
+               ret =3D nvme_tcp_check_ddgst(queue, rcv->pdu);
+               if (unlikely(ret))
+                       return ret;
+       }
+
+       switch (hdr->type) {
+       case nvme_tcp_c2h_data:
+               ret =3D nvme_tcp_handle_c2h_data(queue, (void *)rcv->pdu);
+               break;
+       case nvme_tcp_rsp:
+               nvme_tcp_init_recv_ctx(queue);
+               ret =3D nvme_tcp_handle_comp(queue, (void *)rcv->pdu);
+               break;
+       case nvme_tcp_r2t:
+               nvme_tcp_init_recv_ctx(queue);
+               ret =3D nvme_tcp_handle_r2t(queue, (void *)rcv->pdu);
+               break;
+       default:
+               dev_err(queue->ctrl->ctrl.device, "unsupported pdu type (%d=
)\n",
+                       hdr->type);
+               return -EINVAL;
+       }
+
+       return ret;
+}
+
+static void nvme_tcp_init_recv_iter(struct nvme_tcp_request *req)
+{
+       struct bio *bio =3D req->rcv.curr_bio;
+       struct bio_vec *vec =3D __bvec_iter_bvec(bio->bi_io_vec, bio->bi_it=
er);
+       unsigned int nsegs =3D bio_segments(bio);
+
+       iov_iter_bvec(&req->rcv.iter, READ, vec, nsegs,
+               bio->bi_iter.bi_size);
+       req->rcv.iter.iov_offset =3D bio->bi_iter.bi_bvec_done;
+}
+
+static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff=
 *skb,
+                             unsigned int *offset, size_t *len)
+{
+       struct nvme_tcp_queue_recv_ctx *rcv =3D &queue->rcv;
+       struct nvme_tcp_data_pdu *pdu =3D (void *)rcv->pdu;
+       struct nvme_tcp_request *req;
+       struct request *rq;
+
+       rq =3D blk_mq_tag_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
+       if (!rq) {
+               dev_err(queue->ctrl->ctrl.device,
+                       "queue %d tag %#x not found\n",
+                       nvme_tcp_queue_id(queue), pdu->command_id);
+               return -ENOENT;
+       }
+       req =3D blk_mq_rq_to_pdu(rq);
+
+       while (true) {
+               int recv_len, ret;
+
+               recv_len =3D min_t(size_t, *len, rcv->data_remaining);
+               if (!recv_len)
+                       break;
+
+               /*
+                * FIXME: This assumes that data comes in-order,
+                *  need to handle the out-of-order case.
+                */
+               if (!iov_iter_count(&req->rcv.iter)) {
+                       req->rcv.curr_bio =3D req->rcv.curr_bio->bi_next;
+
+                       /*
+                        * If we don`t have any bios it means that controll=
er
+                        * sent more data than we requested, hence error
+                        */
+                       if (!req->rcv.curr_bio) {
+                               dev_err(queue->ctrl->ctrl.device,
+                                       "queue %d no space in request %#x",
+                                       nvme_tcp_queue_id(queue), rq->tag);
+                               nvme_tcp_init_recv_ctx(queue);
+                               return -EIO;
+                       }
+                       nvme_tcp_init_recv_iter(req);
+               }
+
+               /* we can read only from what is left in this bio */
+               recv_len =3D min_t(size_t, recv_len,
+                               iov_iter_count(&req->rcv.iter));
+
+               if (queue->data_digest)
+                       ret =3D skb_copy_and_hash_datagram_iter(skb, *offse=
t,
+                               &req->rcv.iter, recv_len, queue->rcv_hash);
+               else
+                       ret =3D skb_copy_datagram_iter(skb, *offset,
+                                       &req->rcv.iter, recv_len);
+               if (ret) {
+                       dev_err(queue->ctrl->ctrl.device,
+                               "queue %d failed to copy request %#x data",
+                               nvme_tcp_queue_id(queue), rq->tag);
+                       return ret;
+               }
+
+               *len -=3D recv_len;
+               *offset +=3D recv_len;
+               rcv->data_remaining -=3D recv_len;
+       }
+
+       if (!rcv->data_remaining) {
+               if (queue->data_digest) {
+                       nvme_tcp_ddgst_final(queue->rcv_hash, &queue->exp_d=
dgst);
+                       rcv->ddgst_remaining =3D NVME_TCP_DIGEST_LENGTH;
+               } else {
+                       nvme_tcp_init_recv_ctx(queue);
+               }
+       }
+
+       return 0;
+}
+
+static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
+               struct sk_buff *skb, unsigned int *offset, size_t *len)
+{
+       struct nvme_tcp_queue_recv_ctx *rcv =3D &queue->rcv;
+       char *ddgst =3D (char *)&queue->recv_ddgst;
+       size_t recv_len =3D min_t(size_t, *len, rcv->ddgst_remaining);
+       off_t off =3D NVME_TCP_DIGEST_LENGTH - rcv->ddgst_remaining;
+       int ret;
+
+       ret =3D skb_copy_bits(skb, *offset, &ddgst[off], recv_len);
+       if (unlikely(ret))
+               return ret;
+
+       rcv->ddgst_remaining -=3D recv_len;
+       *offset +=3D recv_len;
+       *len -=3D recv_len;
+       if (rcv->ddgst_remaining)
+               return 0;
+
+       if (queue->recv_ddgst !=3D queue->exp_ddgst) {
+               dev_err(queue->ctrl->ctrl.device,
+                       "data digest error: recv %#x expected %#x\n",
+                       le32_to_cpu(queue->recv_ddgst),
+                       le32_to_cpu(queue->exp_ddgst));
+               return -EIO;
+       }
+
+       nvme_tcp_init_recv_ctx(queue);
+       return 0;
+}
+
+static int nvme_tcp_recv_skb(read_descriptor_t *desc, struct sk_buff *skb,
+                            unsigned int offset, size_t len)
+{
+       struct nvme_tcp_queue *queue =3D desc->arg.data;
+       size_t consumed =3D len;
+       int result;
+
+       while (len) {
+               switch (nvme_tcp_recv_state(queue)) {
+               case NVME_TCP_RECV_PDU:
+                       result =3D nvme_tcp_recv_pdu(queue, skb, &offset, &=
len);
+                       break;
+               case NVME_TCP_RECV_DATA:
+                       result =3D nvme_tcp_recv_data(queue, skb, &offset, =
&len);
+                       break;
+               case NVME_TCP_RECV_DDGST:
+                       result =3D nvme_tcp_recv_ddgst(queue, skb, &offset,=
 &len);
+                       break;
+               default:
+                       result =3D -EFAULT;
+               }
+               if (result) {
+                       dev_err(queue->ctrl->ctrl.device,
+                               "receive failed:  %d\n", result);
+                       queue->rd_enabled =3D false;
+                       nvme_tcp_error_recovery(&queue->ctrl->ctrl);
+                       return result;
+               }
+       }
+
+       return consumed;
+}
+
+static void nvme_tcp_data_ready(struct sock *sk)
+{
+       struct nvme_tcp_queue *queue;
+
+       read_lock(&sk->sk_callback_lock);
+       queue =3D sk->sk_user_data;
+       if (unlikely(!queue || !queue->rd_enabled))
+               goto done;
+
+       queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
+done:
+       read_unlock(&sk->sk_callback_lock);
+}
+
+static void nvme_tcp_write_space(struct sock *sk)
+{
+       struct nvme_tcp_queue *queue;
+
+       read_lock_bh(&sk->sk_callback_lock);
+       queue =3D sk->sk_user_data;
+
+       if (!queue)
+               goto done;
+
+       if (sk_stream_is_writeable(sk)) {
+               clear_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
+               queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
+       }
+done:
+       read_unlock_bh(&sk->sk_callback_lock);
+}
+
+static void nvme_tcp_state_change(struct sock *sk)
+{
+       struct nvme_tcp_queue *queue;
+
+       read_lock(&sk->sk_callback_lock);
+       queue =3D sk->sk_user_data;
+       if (!queue)
+               goto done;
+
+       switch (sk->sk_state) {
+       case TCP_CLOSE:
+       case TCP_CLOSE_WAIT:
+       case TCP_LAST_ACK:
+       case TCP_FIN_WAIT1:
+       case TCP_FIN_WAIT2:
+               /* fallthrough */
+               nvme_tcp_error_recovery(&queue->ctrl->ctrl);
+               break;
+       default:
+               dev_info(queue->ctrl->ctrl.device,
+                       "queue %d socket state %d\n",
+                       nvme_tcp_queue_id(queue), sk->sk_state);
+       }
+
+       queue->sc(sk);
+done:
+       read_unlock(&sk->sk_callback_lock);
+}
+
+static inline void nvme_tcp_done_send_req(struct nvme_tcp_queue *queue)
+{
+       queue->request =3D NULL;
+}
+
+static void nvme_tcp_fail_request(struct nvme_tcp_request *req)
+{
+       union nvme_result res =3D {};
+
+       nvme_end_request(blk_mq_rq_from_pdu(req),
+               NVME_SC_DATA_XFER_ERROR, res);
+}
+
+static int nvme_tcp_try_send_data(struct nvme_tcp_request *req)
+{
+       struct nvme_tcp_queue *queue =3D req->queue;
+
+       while (true) {
+               struct page *page =3D nvme_tcp_req_cur_page(req);
+               size_t offset =3D nvme_tcp_req_cur_offset(req);
+               size_t len =3D nvme_tcp_req_cur_length(req);
+               bool last =3D nvme_tcp_pdu_last_send(req, len);
+               int ret, flags =3D MSG_DONTWAIT;
+
+               if (last && !queue->data_digest)
+                       flags |=3D MSG_EOR;
+               else
+                       flags |=3D MSG_MORE;
+
+               ret =3D kernel_sendpage(queue->sock, page, offset, len, fla=
gs);
+               if (ret <=3D 0)
+                       return ret;
+
+               nvme_tcp_advance_req(req, ret);
+               if (queue->data_digest)
+                       nvme_tcp_ddgst_update(queue->snd_hash, page, offset=
, ret);
+
+               /* fully successfull last write*/
+               if (last && ret =3D=3D len) {
+                       if (queue->data_digest) {
+                               nvme_tcp_ddgst_final(queue->snd_hash,
+                                       &req->ddgst);
+                               req->snd.state =3D NVME_TCP_SEND_DDGST;
+                               req->snd.offset =3D 0;
+                       } else {
+                               nvme_tcp_done_send_req(queue);
+                       }
+                       return 1;
+               }
+       }
+       return -EAGAIN;
+}
+
+static int nvme_tcp_try_send_cmd_pdu(struct nvme_tcp_request *req)
+{
+       struct nvme_tcp_queue *queue =3D req->queue;
+       struct nvme_tcp_send_ctx *snd =3D &req->snd;
+       struct nvme_tcp_cmd_pdu *pdu =3D req->pdu;
+       bool inline_data =3D nvme_tcp_has_inline_data(req);
+       int flags =3D MSG_DONTWAIT | (inline_data ? MSG_MORE : MSG_EOR);
+       u8 hdgst =3D nvme_tcp_hdgst_len(queue);
+       int len =3D sizeof(*pdu) + hdgst - snd->offset;
+       int ret;
+
+       if (queue->hdr_digest && !snd->offset)
+               nvme_tcp_hdgst(queue->snd_hash, pdu, sizeof(*pdu));
+
+       ret =3D kernel_sendpage(queue->sock, virt_to_page(pdu),
+                       offset_in_page(pdu) + snd->offset, len,  flags);
+       if (unlikely(ret <=3D 0))
+               return ret;
+
+       len -=3D ret;
+       if (!len) {
+               if (inline_data) {
+                       req->snd.state =3D NVME_TCP_SEND_DATA;
+                       if (queue->data_digest)
+                               crypto_ahash_init(queue->snd_hash);
+                       nvme_tcp_init_send_iter(req);
+               } else {
+                       nvme_tcp_done_send_req(queue);
+               }
+               return 1;
+       }
+       snd->offset +=3D ret;
+
+       return -EAGAIN;
+}
+
+static int nvme_tcp_try_send_data_pdu(struct nvme_tcp_request *req)
+{
+       struct nvme_tcp_queue *queue =3D req->queue;
+       struct nvme_tcp_send_ctx *snd =3D &req->snd;
+       struct nvme_tcp_data_pdu *pdu =3D req->pdu;
+       u8 hdgst =3D nvme_tcp_hdgst_len(queue);
+       int len =3D sizeof(*pdu) - snd->offset + hdgst;
+       int ret;
+
+       if (queue->hdr_digest && !snd->offset)
+               nvme_tcp_hdgst(queue->snd_hash, pdu, sizeof(*pdu));
+
+       ret =3D kernel_sendpage(queue->sock, virt_to_page(pdu),
+                       offset_in_page(pdu) + snd->offset, len,
+                       MSG_DONTWAIT | MSG_MORE);
+       if (unlikely(ret <=3D 0))
+               return ret;
+
+       len -=3D ret;
+       if (!len) {
+               req->snd.state =3D NVME_TCP_SEND_DATA;
+               if (queue->data_digest)
+                       crypto_ahash_init(queue->snd_hash);
+               if (!req->snd.data_sent)
+                       nvme_tcp_init_send_iter(req);
+               return 1;
+       }
+       snd->offset +=3D ret;
+
+       return -EAGAIN;
+}
+
+static int nvme_tcp_try_send_ddgst(struct nvme_tcp_request *req)
+{
+       struct nvme_tcp_queue *queue =3D req->queue;
+       int ret;
+       struct msghdr msg =3D { .msg_flags =3D MSG_DONTWAIT | MSG_EOR };
+       struct kvec iov =3D {
+               .iov_base =3D &req->ddgst + req->snd.offset,
+               .iov_len =3D NVME_TCP_DIGEST_LENGTH - req->snd.offset
+       };
+
+       ret =3D kernel_sendmsg(queue->sock, &msg, &iov, 1, iov.iov_len);
+       if (unlikely(ret <=3D 0))
+               return ret;
+
+       if (req->snd.offset + ret =3D=3D NVME_TCP_DIGEST_LENGTH) {
+               nvme_tcp_done_send_req(queue);
+               return 1;
+       }
+
+       req->snd.offset +=3D ret;
+       return -EAGAIN;
+}
+
+static int nvme_tcp_try_send(struct nvme_tcp_queue *queue)
+{
+       struct nvme_tcp_request *req;
+       int ret =3D 1;
+
+       if (!queue->request) {
+               queue->request =3D nvme_tcp_fetch_request(queue);
+               if (!queue->request)
+                       return 0;
+       }
+       req =3D queue->request;
+
+       if (req->snd.state =3D=3D NVME_TCP_SEND_CMD_PDU) {
+               ret =3D nvme_tcp_try_send_cmd_pdu(req);
+               if (ret <=3D 0)
+                       goto done;
+               if (!nvme_tcp_has_inline_data(req))
+                       return ret;
+       }
+
+       if (req->snd.state =3D=3D NVME_TCP_SEND_H2C_PDU) {
+               ret =3D nvme_tcp_try_send_data_pdu(req);
+               if (ret <=3D 0)
+                       goto done;
+       }
+
+       if (req->snd.state =3D=3D NVME_TCP_SEND_DATA) {
+               ret =3D nvme_tcp_try_send_data(req);
+               if (ret <=3D 0)
+                       goto done;
+       }
+
+       if (req->snd.state =3D=3D NVME_TCP_SEND_DDGST)
+               ret =3D nvme_tcp_try_send_ddgst(req);
+done:
+       if (ret =3D=3D -EAGAIN)
+               ret =3D 0;
+       return ret;
+}
+
+static int nvme_tcp_try_recv(struct nvme_tcp_queue *queue)
+{
+       struct sock *sk =3D queue->sock->sk;
+       read_descriptor_t rd_desc;
+       int consumed;
+
+       rd_desc.arg.data =3D queue;
+       rd_desc.count =3D 1;
+       lock_sock(sk);
+       consumed =3D tcp_read_sock(sk, &rd_desc, nvme_tcp_recv_skb);
+       release_sock(sk);
+       return consumed;
+}
+
+static void nvme_tcp_io_work(struct work_struct *w)
+{
+       struct nvme_tcp_queue *queue =3D
+               container_of(w, struct nvme_tcp_queue, io_work);
+       unsigned long start =3D jiffies + msecs_to_jiffies(1);
+
+       do {
+               bool pending =3D false;
+               int result;
+
+               result =3D nvme_tcp_try_send(queue);
+               if (result > 0) {
+                       pending =3D true;
+               } else if (unlikely(result < 0)) {
+                       dev_err(queue->ctrl->ctrl.device,
+                               "failed to send request %d\n", result);
+                       if (result !=3D -EPIPE)
+                               nvme_tcp_fail_request(queue->request);
+                       nvme_tcp_done_send_req(queue);
+                       return;
+               }
+
+               result =3D nvme_tcp_try_recv(queue);
+               if (result > 0)
+                       pending =3D true;
+
+               if (!pending)
+                       return;
+
+       } while (time_after(jiffies, start)); /* quota is exhausted */
+
+       queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
+}
+
+static void nvme_tcp_free_crypto(struct nvme_tcp_queue *queue)
+{
+       struct crypto_ahash *tfm =3D crypto_ahash_reqtfm(queue->rcv_hash);
+
+       ahash_request_free(queue->rcv_hash);
+       ahash_request_free(queue->snd_hash);
+       crypto_free_ahash(tfm);
+}
+
+static int nvme_tcp_alloc_crypto(struct nvme_tcp_queue *queue)
+{
+       struct crypto_ahash *tfm;
+
+       tfm =3D crypto_alloc_ahash("crc32c", 0, CRYPTO_ALG_ASYNC);
+       if (IS_ERR(tfm))
+               return PTR_ERR(tfm);
+
+       queue->snd_hash =3D ahash_request_alloc(tfm, GFP_KERNEL);
+       if (!queue->snd_hash)
+               goto free_tfm;
+       ahash_request_set_callback(queue->snd_hash, 0, NULL, NULL);
+
+       queue->rcv_hash =3D ahash_request_alloc(tfm, GFP_KERNEL);
+       if (!queue->rcv_hash)
+               goto free_snd_hash;
+       ahash_request_set_callback(queue->rcv_hash, 0, NULL, NULL);
+
+       return 0;
+free_snd_hash:
+       ahash_request_free(queue->snd_hash);
+free_tfm:
+       crypto_free_ahash(tfm);
+       return -ENOMEM;
+}
+
+static void nvme_tcp_free_async_req(struct nvme_tcp_ctrl *ctrl)
+{
+       struct nvme_tcp_request *async =3D &ctrl->async_req;
+
+       page_frag_free(async->pdu);
+}
+
+static int nvme_tcp_alloc_async_req(struct nvme_tcp_ctrl *ctrl)
+{
+       struct nvme_tcp_queue *queue =3D &ctrl->queues[0];
+       struct nvme_tcp_request *async =3D &ctrl->async_req;
+       u8 hdgst =3D nvme_tcp_hdgst_len(queue);
+
+       async->pdu =3D page_frag_alloc(&queue->pf_cache,
+               sizeof(struct nvme_tcp_cmd_pdu) + hdgst,
+               GFP_KERNEL | __GFP_ZERO);
+       if (!async->pdu)
+               return -ENOMEM;
+
+       async->queue =3D &ctrl->queues[0];
+       return 0;
+}
+
+static void nvme_tcp_free_queue(struct nvme_ctrl *nctrl, int qid)
+{
+       struct nvme_tcp_ctrl *ctrl =3D to_tcp_ctrl(nctrl);
+       struct nvme_tcp_queue *queue =3D &ctrl->queues[qid];
+
+       if (!test_and_clear_bit(NVME_TCP_Q_ALLOCATED, &queue->flags))
+               return;
+
+       if (queue->hdr_digest || queue->data_digest)
+               nvme_tcp_free_crypto(queue);
+
+       sock_release(queue->sock);
+       kfree(queue->rcv.pdu);
+}
+
+static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
+{
+       struct nvme_tcp_icreq_pdu *icreq;
+       struct nvme_tcp_icresp_pdu *icresp;
+       struct msghdr msg =3D {};
+       struct kvec iov;
+       bool ctrl_hdgst, ctrl_ddgst;
+       int ret;
+
+       icreq =3D kzalloc(sizeof(*icreq), GFP_KERNEL);
+       if (!icreq)
+               return -ENOMEM;
+
+       icresp =3D kzalloc(sizeof(*icresp), GFP_KERNEL);
+       if (!icresp) {
+               ret =3D -ENOMEM;
+               goto free_icreq;
+       }
+
+       icreq->hdr.type =3D nvme_tcp_icreq;
+       icreq->hdr.hlen =3D sizeof(*icreq);
+       icreq->hdr.pdo =3D 0;
+       icreq->hdr.plen =3D cpu_to_le32(icreq->hdr.hlen);
+       icreq->pfv =3D cpu_to_le16(NVME_TCP_PFV_1_0);
+       icreq->maxr2t =3D cpu_to_le16(1); /* single inflight r2t supported =
*/
+       icreq->hpda =3D 0; /* no alignment constraint */
+       if (queue->hdr_digest)
+               icreq->digest |=3D NVME_TCP_HDR_DIGEST_ENABLE;
+       if (queue->data_digest)
+               icreq->digest |=3D NVME_TCP_DATA_DIGEST_ENABLE;
+
+       iov.iov_base =3D icreq;
+       iov.iov_len =3D sizeof(*icreq);
+       ret =3D kernel_sendmsg(queue->sock, &msg, &iov, 1, iov.iov_len);
+       if (ret < 0)
+               goto free_icresp;
+
+       memset(&msg, 0, sizeof(msg));
+       iov.iov_base =3D icresp;
+       iov.iov_len =3D sizeof(*icresp);
+       ret =3D kernel_recvmsg(queue->sock, &msg, &iov, 1,
+                       iov.iov_len, msg.msg_flags);
+       if (ret < 0)
+               goto free_icresp;
+
+       ret =3D -EINVAL;
+       if (icresp->hdr.type !=3D nvme_tcp_icresp) {
+               pr_err("queue %d: bad type returned %d\n",
+                       nvme_tcp_queue_id(queue), icresp->hdr.type);
+               goto free_icresp;
+       }
+
+       if (le32_to_cpu(icresp->hdr.plen) !=3D sizeof(*icresp)) {
+               pr_err("queue %d: bad pdu length returned %d\n",
+                       nvme_tcp_queue_id(queue), icresp->hdr.plen);
+               goto free_icresp;
+       }
+
+       if (icresp->pfv !=3D NVME_TCP_PFV_1_0) {
+               pr_err("queue %d: bad pfv returned %d\n",
+                       nvme_tcp_queue_id(queue), icresp->pfv);
+               goto free_icresp;
+       }
+
+       ctrl_ddgst =3D !!(icresp->digest & NVME_TCP_DATA_DIGEST_ENABLE);
+       if ((queue->data_digest && !ctrl_ddgst) ||
+           (!queue->data_digest && ctrl_ddgst)) {
+               pr_err("queue %d: data digest mismatch host: %s ctrl: %s\n"=
,
+                       nvme_tcp_queue_id(queue),
+                       queue->data_digest ? "enabled" : "disabled",
+                       ctrl_ddgst ? "enabled" : "disabled");
+               goto free_icresp;
+       }
+
+       ctrl_hdgst =3D !!(icresp->digest & NVME_TCP_HDR_DIGEST_ENABLE);
+       if ((queue->hdr_digest && !ctrl_hdgst) ||
+           (!queue->hdr_digest && ctrl_hdgst)) {
+               pr_err("queue %d: header digest mismatch host: %s ctrl: %s\=
n",
+                       nvme_tcp_queue_id(queue),
+                       queue->hdr_digest ? "enabled" : "disabled",
+                       ctrl_hdgst ? "enabled" : "disabled");
+               goto free_icresp;
+       }
+
+       if (icresp->cpda !=3D 0) {
+               pr_err("queue %d: unsupported cpda returned %d\n",
+                       nvme_tcp_queue_id(queue), icresp->cpda);
+               goto free_icresp;
+       }
+
+       ret =3D 0;
+free_icresp:
+       kfree(icresp);
+free_icreq:
+       kfree(icreq);
+       return ret;
+}
+
+static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl,
+               int qid, size_t queue_size)
+{
+       struct nvme_tcp_ctrl *ctrl =3D to_tcp_ctrl(nctrl);
+       struct nvme_tcp_queue *queue =3D &ctrl->queues[qid];
+       struct linger sol =3D { .l_onoff =3D 1, .l_linger =3D 0 };
+       int ret, opt, rcv_pdu_size;
+
+       queue->ctrl =3D ctrl;
+       INIT_LIST_HEAD(&queue->send_list);
+       spin_lock_init(&queue->lock);
+       INIT_WORK(&queue->io_work, nvme_tcp_io_work);
+       queue->queue_size =3D queue_size;
+
+       if (qid > 0)
+               queue->cmnd_capsule_len =3D ctrl->ctrl.ioccsz * 16;
+       else
+               queue->cmnd_capsule_len =3D sizeof(struct nvme_command) +
+                                               NVME_TCP_ADMIN_CCSZ;
+
+       ret =3D sock_create(ctrl->addr.ss_family, SOCK_STREAM,
+                       IPPROTO_TCP, &queue->sock);
+       if (ret) {
+               dev_err(ctrl->ctrl.device,
+                       "failed to create socket: %d\n", ret);
+               return ret;
+       }
+
+       /* Single syn retry */
+       opt =3D 1;
+       ret =3D kernel_setsockopt(queue->sock, IPPROTO_TCP, TCP_SYNCNT,
+                       (char *)&opt, sizeof(opt));
+       if (ret) {
+               dev_err(ctrl->ctrl.device,
+                       "failed to set TCP_SYNCNT sock opt %d\n", ret);
+               goto err_sock;
+       }
+
+       /* Set TCP no delay */
+       opt =3D 1;
+       ret =3D kernel_setsockopt(queue->sock, IPPROTO_TCP,
+                       TCP_NODELAY, (char *)&opt, sizeof(opt));
+       if (ret) {
+               dev_err(ctrl->ctrl.device,
+                       "failed to set TCP_NODELAY sock opt %d\n", ret);
+               goto err_sock;
+       }
+
+       /*
+        * Cleanup whatever is sitting in the TCP transmit queue on socket
+        * close. This is done to prevent stale data from being sent should
+        * the network connection be restored before TCP times out.
+        */
+       ret =3D kernel_setsockopt(queue->sock, SOL_SOCKET, SO_LINGER,
+                       (char *)&sol, sizeof(sol));
+       if (ret) {
+               dev_err(ctrl->ctrl.device,
+                       "failed to set SO_LINGER sock opt %d\n", ret);
+               goto err_sock;
+       }
+
+       queue->sock->sk->sk_allocation =3D GFP_ATOMIC;
+       queue->io_cpu =3D (qid =3D=3D 0) ? 0 : qid - 1;
+       queue->request =3D NULL;
+       queue->rcv.data_remaining =3D 0;
+       queue->rcv.ddgst_remaining =3D 0;
+       queue->rcv.pdu_remaining =3D 0;
+       queue->rcv.pdu_offset =3D 0;
+       sk_set_memalloc(queue->sock->sk);
+
+       if (ctrl->ctrl.opts->mask & NVMF_OPT_HOST_TRADDR) {
+               ret =3D kernel_bind(queue->sock, (struct sockaddr *)&ctrl->=
src_addr,
+                       sizeof(ctrl->src_addr));
+               if (ret) {
+                       dev_err(ctrl->ctrl.device,
+                               "failed to bind queue %d socket %d\n",
+                               qid, ret);
+                       goto err_sock;
+               }
+       }
+
+       queue->hdr_digest =3D nctrl->opts->hdr_digest;
+       queue->data_digest =3D nctrl->opts->data_digest;
+       if (queue->hdr_digest || queue->data_digest) {
+               ret =3D nvme_tcp_alloc_crypto(queue);
+               if (ret) {
+                       dev_err(ctrl->ctrl.device,
+                               "failed to allocate queue %d crypto\n", qid=
);
+                       goto err_sock;
+               }
+       }
+
+       rcv_pdu_size =3D sizeof(struct nvme_tcp_rsp_pdu) +
+                       nvme_tcp_hdgst_len(queue);
+       queue->rcv.pdu =3D kmalloc(rcv_pdu_size, GFP_KERNEL);
+       if (!queue->rcv.pdu) {
+               ret =3D -ENOMEM;
+               goto err_crypto;
+       }
+
+       dev_dbg(ctrl->ctrl.device, "connecting queue %d\n",
+                       nvme_tcp_queue_id(queue));
+
+       ret =3D kernel_connect(queue->sock, (struct sockaddr *)&ctrl->addr,
+               sizeof(ctrl->addr), 0);
+       if (ret) {
+               dev_err(ctrl->ctrl.device,
+                       "failed to connect socket: %d\n", ret);
+               goto err_rcv_pdu;
+       }
+
+       ret =3D nvme_tcp_init_connection(queue);
+       if (ret)
+               goto err_init_connect;
+
+       queue->rd_enabled =3D true;
+       set_bit(NVME_TCP_Q_ALLOCATED, &queue->flags);
+       nvme_tcp_init_recv_ctx(queue);
+
+       write_lock_bh(&queue->sock->sk->sk_callback_lock);
+       queue->sock->sk->sk_user_data =3D queue;
+       queue->sc =3D queue->sock->sk->sk_state_change;
+       queue->dr =3D queue->sock->sk->sk_data_ready;
+       queue->ws =3D queue->sock->sk->sk_write_space;
+       queue->sock->sk->sk_data_ready =3D nvme_tcp_data_ready;
+       queue->sock->sk->sk_state_change =3D nvme_tcp_state_change;
+       queue->sock->sk->sk_write_space =3D nvme_tcp_write_space;
+       write_unlock_bh(&queue->sock->sk->sk_callback_lock);
+
+       return 0;
+
+err_init_connect:
+       kernel_sock_shutdown(queue->sock, SHUT_RDWR);
+err_rcv_pdu:
+       kfree(queue->rcv.pdu);
+err_crypto:
+       if (queue->hdr_digest || queue->data_digest)
+               nvme_tcp_free_crypto(queue);
+err_sock:
+       sock_release(queue->sock);
+       queue->sock =3D NULL;
+       return ret;
+}
+
+static void nvme_tcp_restore_sock_calls(struct nvme_tcp_queue *queue)
+{
+       struct socket *sock =3D queue->sock;
+
+       write_lock_bh(&sock->sk->sk_callback_lock);
+       sock->sk->sk_user_data  =3D NULL;
+       sock->sk->sk_data_ready =3D queue->dr;
+       sock->sk->sk_state_change =3D queue->sc;
+       sock->sk->sk_write_space  =3D queue->ws;
+       write_unlock_bh(&sock->sk->sk_callback_lock);
+}
+
+static void __nvme_tcp_stop_queue(struct nvme_tcp_queue *queue)
+{
+       kernel_sock_shutdown(queue->sock, SHUT_RDWR);
+       nvme_tcp_restore_sock_calls(queue);
+       cancel_work_sync(&queue->io_work);
+}
+
+static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
+{
+       struct nvme_tcp_ctrl *ctrl =3D to_tcp_ctrl(nctrl);
+       struct nvme_tcp_queue *queue =3D &ctrl->queues[qid];
+
+       if (!test_and_clear_bit(NVME_TCP_Q_LIVE, &queue->flags))
+               return;
+
+       __nvme_tcp_stop_queue(queue);
+}
+
+static int nvme_tcp_start_queue(struct nvme_ctrl *nctrl, int idx)
+{
+       struct nvme_tcp_ctrl *ctrl =3D to_tcp_ctrl(nctrl);
+       int ret;
+
+       if (idx)
+               ret =3D nvmf_connect_io_queue(nctrl, idx);
+       else
+               ret =3D nvmf_connect_admin_queue(nctrl);
+
+       if (!ret) {
+               set_bit(NVME_TCP_Q_LIVE, &ctrl->queues[idx].flags);
+       } else {
+               __nvme_tcp_stop_queue(&ctrl->queues[idx]);
+               dev_err(nctrl->device,
+                       "failed to connect queue: %d ret=3D%d\n", idx, ret)=
;
+       }
+       return ret;
+}
+
+static void nvme_tcp_free_tagset(struct nvme_ctrl *nctrl,
+               struct blk_mq_tag_set *set)
+{
+       blk_mq_free_tag_set(set);
+}
+
+static struct blk_mq_tag_set *nvme_tcp_alloc_tagset(struct nvme_ctrl *nctr=
l,
+               bool admin)
+{
+       struct nvme_tcp_ctrl *ctrl =3D to_tcp_ctrl(nctrl);
+       struct blk_mq_tag_set *set;
+       int ret;
+
+       if (admin) {
+               set =3D &ctrl->admin_tag_set;
+               memset(set, 0, sizeof(*set));
+               set->ops =3D &nvme_tcp_admin_mq_ops;
+               set->queue_depth =3D NVME_AQ_MQ_TAG_DEPTH;
+               set->reserved_tags =3D 2; /* connect + keep-alive */
+               set->numa_node =3D NUMA_NO_NODE;
+               set->cmd_size =3D sizeof(struct nvme_tcp_request);
+               set->driver_data =3D ctrl;
+               set->nr_hw_queues =3D 1;
+               set->timeout =3D ADMIN_TIMEOUT;
+       } else {
+               set =3D &ctrl->tag_set;
+               memset(set, 0, sizeof(*set));
+               set->ops =3D &nvme_tcp_mq_ops;
+               set->queue_depth =3D nctrl->sqsize + 1;
+               set->reserved_tags =3D 1; /* fabric connect */
+               set->numa_node =3D NUMA_NO_NODE;
+               set->flags =3D BLK_MQ_F_SHOULD_MERGE;
+               set->cmd_size =3D sizeof(struct nvme_tcp_request);
+               set->driver_data =3D ctrl;
+               set->nr_hw_queues =3D nctrl->queue_count - 1;
+               set->timeout =3D NVME_IO_TIMEOUT;
+       }
+
+       ret =3D blk_mq_alloc_tag_set(set);
+       if (ret)
+               return ERR_PTR(ret);
+
+       return set;
+}
+
+static void nvme_tcp_free_admin_queue(struct nvme_ctrl *ctrl)
+{
+       if (to_tcp_ctrl(ctrl)->async_req.pdu) {
+               nvme_tcp_free_async_req(to_tcp_ctrl(ctrl));
+               to_tcp_ctrl(ctrl)->async_req.pdu =3D NULL;
+       }
+
+       nvme_tcp_free_queue(ctrl, 0);
+}
+
+static void nvme_tcp_free_io_queues(struct nvme_ctrl *ctrl)
+{
+       int i;
+
+       for (i =3D 1; i < ctrl->queue_count; i++)
+               nvme_tcp_free_queue(ctrl, i);
+}
+
+static void nvme_tcp_stop_admin_queue(struct nvme_ctrl *ctrl)
+{
+       nvme_tcp_stop_queue(ctrl, 0);
+}
+
+static void nvme_tcp_stop_io_queues(struct nvme_ctrl *ctrl)
+{
+       int i;
+
+       for (i =3D 1; i < ctrl->queue_count; i++)
+               nvme_tcp_stop_queue(ctrl, i);
+}
+
+static int nvme_tcp_start_admin_queue(struct nvme_ctrl *ctrl)
+{
+       return nvme_tcp_start_queue(ctrl, 0);
+}
+
+static int nvme_tcp_start_io_queues(struct nvme_ctrl *ctrl)
+{
+       int i, ret =3D 0;
+
+       for (i =3D 1; i < ctrl->queue_count; i++) {
+               ret =3D nvme_tcp_start_queue(ctrl, i);
+               if (ret)
+                       goto out_stop_queues;
+       }
+
+       return 0;
+
+out_stop_queues:
+       for (i--; i >=3D 1; i--)
+               nvme_tcp_stop_queue(ctrl, i);
+       return ret;
+}
+
+static int nvme_tcp_alloc_admin_queue(struct nvme_ctrl *ctrl)
+{
+       int ret;
+
+       ret =3D nvme_tcp_alloc_queue(ctrl, 0, NVME_AQ_DEPTH);
+       if (ret)
+               return ret;
+
+       ret =3D nvme_tcp_alloc_async_req(to_tcp_ctrl(ctrl));
+       if (ret)
+               goto out_free_queue;
+
+       return 0;
+
+out_free_queue:
+       nvme_tcp_free_queue(ctrl, 0);
+       return ret;
+}
+
+static int nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
+{
+       int i, ret;
+
+       for (i =3D 1; i < ctrl->queue_count; i++) {
+               ret =3D nvme_tcp_alloc_queue(ctrl, i,
+                               ctrl->sqsize + 1);
+               if (ret)
+                       goto out_free_queues;
+       }
+
+       return 0;
+
+out_free_queues:
+       for (i--; i >=3D 1; i--)
+               nvme_tcp_free_queue(ctrl, i);
+
+       return ret;
+}
+
+static unsigned int nvme_tcp_nr_io_queues(struct nvme_ctrl *ctrl)
+{
+       return min(ctrl->queue_count - 1, num_online_cpus());
+}
+
+static int nvme_alloc_io_queues(struct nvme_ctrl *ctrl)
+{
+       unsigned int nr_io_queues;
+       int ret;
+
+       nr_io_queues =3D nvme_tcp_nr_io_queues(ctrl);
+       ret =3D nvme_set_queue_count(ctrl, &nr_io_queues);
+       if (ret)
+               return ret;
+
+       ctrl->queue_count =3D nr_io_queues + 1;
+       if (ctrl->queue_count < 2)
+               return 0;
+
+       dev_info(ctrl->device,
+               "creating %d I/O queues.\n", nr_io_queues);
+
+       return nvme_tcp_alloc_io_queues(ctrl);
+}
+
+void nvme_tcp_destroy_io_queues(struct nvme_ctrl *ctrl, bool remove)
+{
+       nvme_tcp_stop_io_queues(ctrl);
+       if (remove) {
+               if (ctrl->ops->flags & NVME_F_FABRICS)
+                       blk_cleanup_queue(ctrl->connect_q);
+               nvme_tcp_free_tagset(ctrl, ctrl->tagset);
+       }
+       nvme_tcp_free_io_queues(ctrl);
+}
+
+int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
+{
+       int ret;
+
+       ret =3D nvme_alloc_io_queues(ctrl);
+       if (ret)
+               return ret;
+
+       if (new) {
+               ctrl->tagset =3D nvme_tcp_alloc_tagset(ctrl, false);
+               if (IS_ERR(ctrl->tagset)) {
+                       ret =3D PTR_ERR(ctrl->tagset);
+                       goto out_free_io_queues;
+               }
+
+               if (ctrl->ops->flags & NVME_F_FABRICS) {
+                       ctrl->connect_q =3D blk_mq_init_queue(ctrl->tagset)=
;
+                       if (IS_ERR(ctrl->connect_q)) {
+                               ret =3D PTR_ERR(ctrl->connect_q);
+                               goto out_free_tag_set;
+                       }
+               }
+       } else {
+               blk_mq_update_nr_hw_queues(ctrl->tagset,
+                       ctrl->queue_count - 1);
+       }
+
+       ret =3D nvme_tcp_start_io_queues(ctrl);
+       if (ret)
+               goto out_cleanup_connect_q;
+
+       return 0;
+
+out_cleanup_connect_q:
+       if (new && (ctrl->ops->flags & NVME_F_FABRICS))
+               blk_cleanup_queue(ctrl->connect_q);
+out_free_tag_set:
+       if (new)
+               nvme_tcp_free_tagset(ctrl, ctrl->tagset);
+out_free_io_queues:
+       nvme_tcp_free_io_queues(ctrl);
+       return ret;
+}
+
+void nvme_tcp_destroy_admin_queue(struct nvme_ctrl *ctrl, bool remove)
+{
+       nvme_tcp_stop_admin_queue(ctrl);
+       if (remove) {
+               free_opal_dev(ctrl->opal_dev);
+               blk_cleanup_queue(ctrl->admin_q);
+               nvme_tcp_free_tagset(ctrl, ctrl->admin_tagset);
+       }
+       nvme_tcp_free_admin_queue(ctrl);
+}
+
+int nvme_tcp_configure_admin_queue(struct nvme_ctrl *ctrl, bool new)
+{
+       int error;
+
+       error =3D nvme_tcp_alloc_admin_queue(ctrl);
+       if (error)
+               return error;
+
+       if (new) {
+               ctrl->admin_tagset =3D nvme_tcp_alloc_tagset(ctrl, true);
+               if (IS_ERR(ctrl->admin_tagset)) {
+                       error =3D PTR_ERR(ctrl->admin_tagset);
+                       goto out_free_queue;
+               }
+
+               ctrl->admin_q =3D blk_mq_init_queue(ctrl->admin_tagset);
+               if (IS_ERR(ctrl->admin_q)) {
+                       error =3D PTR_ERR(ctrl->admin_q);
+                       goto out_free_tagset;
+               }
+       }
+
+       error =3D nvme_tcp_start_admin_queue(ctrl);
+       if (error)
+               goto out_cleanup_queue;
+
+       error =3D ctrl->ops->reg_read64(ctrl, NVME_REG_CAP, &ctrl->cap);
+       if (error) {
+               dev_err(ctrl->device,
+                       "prop_get NVME_REG_CAP failed\n");
+               goto out_stop_queue;
+       }
+
+       ctrl->sqsize =3D min_t(int, NVME_CAP_MQES(ctrl->cap), ctrl->sqsize)=
;
+
+       error =3D nvme_enable_ctrl(ctrl, ctrl->cap);
+       if (error)
+               goto out_stop_queue;
+
+       error =3D nvme_init_identify(ctrl);
+       if (error)
+               goto out_stop_queue;
+
+       return 0;
+
+out_stop_queue:
+       nvme_tcp_stop_admin_queue(ctrl);
+out_cleanup_queue:
+       if (new)
+               blk_cleanup_queue(ctrl->admin_q);
+out_free_tagset:
+       if (new)
+               nvme_tcp_free_tagset(ctrl, ctrl->admin_tagset);
+out_free_queue:
+       nvme_tcp_free_admin_queue(ctrl);
+       return error;
+}
+
+static void nvme_tcp_teardown_admin_queue(struct nvme_ctrl *ctrl,
+               bool remove)
+{
+       blk_mq_quiesce_queue(ctrl->admin_q);
+       nvme_tcp_stop_admin_queue(ctrl);
+       blk_mq_tagset_busy_iter(ctrl->admin_tagset, nvme_cancel_request, ct=
rl);
+       blk_mq_unquiesce_queue(ctrl->admin_q);
+       nvme_tcp_destroy_admin_queue(ctrl, remove);
+}
+
+static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
+               bool remove)
+{
+       if (ctrl->queue_count > 1) {
+               nvme_stop_queues(ctrl);
+               nvme_tcp_stop_io_queues(ctrl);
+               blk_mq_tagset_busy_iter(ctrl->tagset, nvme_cancel_request, =
ctrl);
+               if (remove)
+                       nvme_start_queues(ctrl);
+               nvme_tcp_destroy_io_queues(ctrl, remove);
+       }
+}
+
+static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl)
+{
+       /* If we are resetting/deleting then do nothing */
+       if (ctrl->state !=3D NVME_CTRL_CONNECTING) {
+               WARN_ON_ONCE(ctrl->state =3D=3D NVME_CTRL_NEW ||
+                       ctrl->state =3D=3D NVME_CTRL_LIVE);
+               return;
+       }
+
+       if (nvmf_should_reconnect(ctrl)) {
+               dev_info(ctrl->device, "Reconnecting in %d seconds...\n",
+                       ctrl->opts->reconnect_delay);
+               queue_delayed_work(nvme_wq, &ctrl->connect_work,
+                               ctrl->opts->reconnect_delay * HZ);
+       } else {
+               dev_info(ctrl->device, "Removing controller...\n");
+               nvme_delete_ctrl(ctrl);
+       }
+}
+
+static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
+{
+       struct nvmf_ctrl_options *opts =3D ctrl->opts;
+       int ret =3D -EINVAL;
+
+       ret =3D nvme_tcp_configure_admin_queue(ctrl, new);
+       if (ret)
+               return ret;
+
+       if (ctrl->icdoff) {
+               dev_err(ctrl->device, "icdoff is not supported!\n");
+               goto destroy_admin;
+       }
+
+       if (opts->queue_size > ctrl->sqsize + 1)
+               dev_warn(ctrl->device,
+                       "queue_size %zu > ctrl sqsize %u, clamping down\n",
+                       opts->queue_size, ctrl->sqsize + 1);
+
+       if (ctrl->sqsize + 1 > ctrl->maxcmd) {
+               dev_warn(ctrl->device,
+                       "sqsize %u > ctrl maxcmd %u, clamping down\n",
+                       ctrl->sqsize + 1, ctrl->maxcmd);
+               ctrl->sqsize =3D ctrl->maxcmd - 1;
+       }
+
+       if (ctrl->queue_count > 1) {
+               ret =3D nvme_tcp_configure_io_queues(ctrl, new);
+               if (ret)
+                       goto destroy_admin;
+       }
+
+       if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE)) {
+               /* state change failure is ok if we're in DELETING state */
+               WARN_ON_ONCE(ctrl->state !=3D NVME_CTRL_DELETING);
+               ret =3D -EINVAL;
+               goto destroy_io;
+       }
+
+       nvme_start_ctrl(ctrl);
+       return 0;
+
+destroy_io:
+       if (ctrl->queue_count > 1)
+               nvme_tcp_destroy_io_queues(ctrl, new);
+destroy_admin:
+       nvme_tcp_stop_admin_queue(ctrl);
+       nvme_tcp_destroy_admin_queue(ctrl, new);
+       return ret;
+}
+
+static void nvme_tcp_reconnect_ctrl_work(struct work_struct *work)
+{
+       struct nvme_ctrl *ctrl =3D container_of(to_delayed_work(work),
+                       struct nvme_ctrl, connect_work);
+
+       ++ctrl->nr_reconnects;
+
+       if (nvme_tcp_setup_ctrl(ctrl, false))
+               goto requeue;
+
+       dev_info(ctrl->device, "Successfully reconnected (%d attepmpt)\n",
+                       ctrl->nr_reconnects);
+
+       ctrl->nr_reconnects =3D 0;
+
+       return;
+
+requeue:
+       dev_info(ctrl->device, "Failed reconnect attempt %d\n",
+                       ctrl->nr_reconnects);
+       nvme_tcp_reconnect_or_remove(ctrl);
+}
+
+static void nvme_tcp_error_recovery_work(struct work_struct *work)
+{
+       struct nvme_ctrl *ctrl =3D container_of(work,
+                       struct nvme_ctrl, err_work);
+
+       nvme_stop_keep_alive(ctrl);
+       nvme_tcp_teardown_io_queues(ctrl, false);
+       /* unquiesce to fail fast pending requests */
+       nvme_start_queues(ctrl);
+       nvme_tcp_teardown_admin_queue(ctrl, false);
+
+       if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING)) {
+               /* state change failure is ok if we're in DELETING state */
+               WARN_ON_ONCE(ctrl->state !=3D NVME_CTRL_DELETING);
+               return;
+       }
+
+       nvme_tcp_reconnect_or_remove(ctrl);
+}
+
+static void nvme_tcp_teardown_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
+{
+       nvme_tcp_teardown_io_queues(ctrl, shutdown);
+       if (shutdown)
+               nvme_shutdown_ctrl(ctrl);
+       else
+               nvme_disable_ctrl(ctrl, ctrl->cap);
+       nvme_tcp_teardown_admin_queue(ctrl, shutdown);
+}
+
+static void nvme_tcp_delete_ctrl(struct nvme_ctrl *ctrl)
+{
+       nvme_tcp_teardown_ctrl(ctrl, true);
+}
+
+static void nvme_reset_ctrl_work(struct work_struct *work)
+{
+       struct nvme_ctrl *ctrl =3D
+               container_of(work, struct nvme_ctrl, reset_work);
+
+       nvme_stop_ctrl(ctrl);
+       nvme_tcp_teardown_ctrl(ctrl, false);
+
+       if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING)) {
+               /* state change failure is ok if we're in DELETING state */
+               WARN_ON_ONCE(ctrl->state !=3D NVME_CTRL_DELETING);
+               return;
+       }
+
+       if (nvme_tcp_setup_ctrl(ctrl, false))
+               goto out_fail;
+
+       return;
+
+out_fail:
+       ++ctrl->nr_reconnects;
+       nvme_tcp_reconnect_or_remove(ctrl);
+}
+
+static void nvme_tcp_stop_ctrl(struct nvme_ctrl *ctrl)
+{
+       cancel_work_sync(&ctrl->err_work);
+       cancel_delayed_work_sync(&ctrl->connect_work);
+}
+
+static void nvme_tcp_free_ctrl(struct nvme_ctrl *nctrl)
+{
+       struct nvme_tcp_ctrl *ctrl =3D to_tcp_ctrl(nctrl);
+
+       if (list_empty(&ctrl->list))
+               goto free_ctrl;
+
+       mutex_lock(&nvme_tcp_ctrl_mutex);
+       list_del(&ctrl->list);
+       mutex_unlock(&nvme_tcp_ctrl_mutex);
+
+       nvmf_free_options(nctrl->opts);
+free_ctrl:
+       kfree(ctrl->queues);
+       kfree(ctrl);
+}
+
+static void nvme_tcp_set_sg_null(struct nvme_command *c)
+{
+       struct nvme_sgl_desc *sg =3D &c->common.dptr.sgl;
+
+       sg->addr =3D 0;
+       sg->length =3D 0;
+       sg->type =3D (NVME_TRANSPORT_SGL_DATA_DESC << 4) |
+                       NVME_SGL_FMT_TRANSPORT_A;
+}
+
+static void nvme_tcp_set_sg_inline(struct nvme_tcp_queue *queue,
+               struct nvme_tcp_request *req, struct nvme_command *c)
+{
+       struct nvme_sgl_desc *sg =3D &c->common.dptr.sgl;
+
+       sg->addr =3D cpu_to_le64(queue->ctrl->ctrl.icdoff);
+       sg->length =3D cpu_to_le32(req->data_len);
+       sg->type =3D (NVME_SGL_FMT_DATA_DESC << 4) | NVME_SGL_FMT_OFFSET;
+}
+
+static void nvme_tcp_set_sg_host_data(struct nvme_tcp_request *req,
+               struct nvme_command *c)
+{
+       struct nvme_sgl_desc *sg =3D &c->common.dptr.sgl;
+
+       sg->addr =3D 0;
+       sg->length =3D cpu_to_le32(req->data_len);
+       sg->type =3D (NVME_TRANSPORT_SGL_DATA_DESC << 4) |
+                       NVME_SGL_FMT_TRANSPORT_A;
+}
+
+static void nvme_tcp_submit_async_event(struct nvme_ctrl *arg)
+{
+       struct nvme_tcp_ctrl *ctrl =3D to_tcp_ctrl(arg);
+       struct nvme_tcp_queue *queue =3D &ctrl->queues[0];
+       struct nvme_tcp_cmd_pdu *pdu =3D ctrl->async_req.pdu;
+       struct nvme_command *cmd =3D &pdu->cmd;
+       u8 hdgst =3D nvme_tcp_hdgst_len(queue);
+
+       memset(pdu, 0, sizeof(*pdu));
+       pdu->hdr.type =3D nvme_tcp_cmd;
+       if (queue->hdr_digest)
+               pdu->hdr.flags |=3D NVME_TCP_F_HDGST;
+       pdu->hdr.hlen =3D sizeof(*pdu);
+       pdu->hdr.plen =3D cpu_to_le32(pdu->hdr.hlen + hdgst);
+
+       cmd->common.opcode =3D nvme_admin_async_event;
+       cmd->common.command_id =3D NVME_AQ_BLK_MQ_DEPTH;
+       cmd->common.flags |=3D NVME_CMD_SGL_METABUF;
+       nvme_tcp_set_sg_null(cmd);
+
+       ctrl->async_req.snd.state =3D NVME_TCP_SEND_CMD_PDU;
+       ctrl->async_req.snd.offset =3D 0;
+       ctrl->async_req.snd.curr_bio =3D NULL;
+       ctrl->async_req.rcv.curr_bio =3D NULL;
+       ctrl->async_req.data_len =3D 0;
+
+       nvme_tcp_queue_request(&ctrl->async_req);
+}
+
+static enum blk_eh_timer_return
+nvme_tcp_timeout(struct request *rq, bool reserved)
+{
+       struct nvme_tcp_request *req =3D blk_mq_rq_to_pdu(rq);
+       struct nvme_tcp_ctrl *ctrl =3D req->queue->ctrl;
+       struct nvme_tcp_cmd_pdu *pdu =3D req->pdu;
+
+       dev_dbg(ctrl->ctrl.device,
+               "queue %d: timeout request %#x type %d\n",
+               nvme_tcp_queue_id(req->queue), rq->tag,
+               pdu->hdr.type);
+
+       if (ctrl->ctrl.state !=3D NVME_CTRL_LIVE) {
+               union nvme_result res =3D {};
+
+               nvme_req(rq)->flags |=3D NVME_REQ_CANCELLED;
+               nvme_end_request(rq, NVME_SC_ABORT_REQ, res);
+               return BLK_EH_DONE;
+       }
+
+       /* queue error recovery */
+       nvme_tcp_error_recovery(&ctrl->ctrl);
+
+       return BLK_EH_RESET_TIMER;
+}
+
+static blk_status_t nvme_tcp_map_data(struct nvme_tcp_queue *queue,
+                       struct request *rq)
+{
+       struct nvme_tcp_request *req =3D blk_mq_rq_to_pdu(rq);
+       struct nvme_tcp_cmd_pdu *pdu =3D req->pdu;
+       struct nvme_command *c =3D &pdu->cmd;
+
+       c->common.flags |=3D NVME_CMD_SGL_METABUF;
+
+       if (!req->data_len) {
+               nvme_tcp_set_sg_null(c);
+               return 0;
+       }
+
+       if (rq_data_dir(rq) =3D=3D WRITE &&
+           req->data_len <=3D nvme_tcp_inline_data_size(queue))
+               nvme_tcp_set_sg_inline(queue, req, c);
+       else
+               nvme_tcp_set_sg_host_data(req, c);
+
+       return 0;
+}
+
+static blk_status_t nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
+               struct request *rq)
+{
+       struct nvme_tcp_request *req =3D blk_mq_rq_to_pdu(rq);
+       struct nvme_tcp_cmd_pdu *pdu =3D req->pdu;
+       struct nvme_tcp_queue *queue =3D req->queue;
+       u8 hdgst =3D nvme_tcp_hdgst_len(queue), ddgst =3D 0;
+       blk_status_t ret;
+
+       ret =3D nvme_setup_cmd(ns, rq, &pdu->cmd);
+       if (ret)
+               return ret;
+
+       req->snd.state =3D NVME_TCP_SEND_CMD_PDU;
+       req->snd.offset =3D 0;
+       req->snd.data_sent =3D 0;
+       req->pdu_len =3D 0;
+       req->pdu_sent =3D 0;
+       req->data_len =3D blk_rq_payload_bytes(rq);
+
+       if (rq_data_dir(rq) =3D=3D WRITE) {
+               req->snd.curr_bio =3D rq->bio;
+               if (req->data_len <=3D nvme_tcp_inline_data_size(queue))
+                       req->pdu_len =3D req->data_len;
+       } else {
+               req->rcv.curr_bio =3D rq->bio;
+               if (req->rcv.curr_bio)
+                       nvme_tcp_init_recv_iter(req);
+       }
+
+       pdu->hdr.type =3D nvme_tcp_cmd;
+       pdu->hdr.flags =3D 0;
+       if (queue->hdr_digest)
+               pdu->hdr.flags |=3D NVME_TCP_F_HDGST;
+       if (queue->data_digest && req->pdu_len) {
+               pdu->hdr.flags |=3D NVME_TCP_F_DDGST;
+               ddgst =3D nvme_tcp_ddgst_len(queue);
+       }
+       pdu->hdr.hlen =3D sizeof(*pdu);
+       pdu->hdr.pdo =3D req->pdu_len ? pdu->hdr.hlen + hdgst : 0;
+       pdu->hdr.plen =3D
+               cpu_to_le32(pdu->hdr.hlen + hdgst + req->pdu_len + ddgst);
+
+       ret =3D nvme_tcp_map_data(queue, rq);
+       if (unlikely(ret)) {
+               dev_err(queue->ctrl->ctrl.device,
+                       "Failed to map data (%d)\n", ret);
+               return ret;
+       }
+
+       return 0;
+}
+
+static blk_status_t nvme_tcp_queue_rq(struct blk_mq_hw_ctx *hctx,
+               const struct blk_mq_queue_data *bd)
+{
+       struct nvme_ns *ns =3D hctx->queue->queuedata;
+       struct nvme_tcp_queue *queue =3D hctx->driver_data;
+       struct request *rq =3D bd->rq;
+       struct nvme_tcp_request *req =3D blk_mq_rq_to_pdu(rq);
+       bool queue_ready =3D test_bit(NVME_TCP_Q_LIVE, &queue->flags);
+       blk_status_t ret;
+
+       if (!nvmf_check_ready(&queue->ctrl->ctrl, rq, queue_ready))
+               return nvmf_fail_nonready_command(&queue->ctrl->ctrl, rq);
+
+       ret =3D nvme_tcp_setup_cmd_pdu(ns, rq);
+       if (unlikely(ret))
+               return ret;
+
+       blk_mq_start_request(rq);
+
+       nvme_tcp_queue_request(req);
+
+       return BLK_STS_OK;
+}
+
+static struct blk_mq_ops nvme_tcp_mq_ops =3D {
+       .queue_rq       =3D nvme_tcp_queue_rq,
+       .complete       =3D nvme_complete_rq,
+       .init_request   =3D nvme_tcp_init_request,
+       .exit_request   =3D nvme_tcp_exit_request,
+       .init_hctx      =3D nvme_tcp_init_hctx,
+       .timeout        =3D nvme_tcp_timeout,
+};
+
+static struct blk_mq_ops nvme_tcp_admin_mq_ops =3D {
+       .queue_rq       =3D nvme_tcp_queue_rq,
+       .complete       =3D nvme_complete_rq,
+       .init_request   =3D nvme_tcp_init_request,
+       .exit_request   =3D nvme_tcp_exit_request,
+       .init_hctx      =3D nvme_tcp_init_admin_hctx,
+       .timeout        =3D nvme_tcp_timeout,
+};
+
+static const struct nvme_ctrl_ops nvme_tcp_ctrl_ops =3D {
+       .name                   =3D "tcp",
+       .module                 =3D THIS_MODULE,
+       .flags                  =3D NVME_F_FABRICS,
+       .reg_read32             =3D nvmf_reg_read32,
+       .reg_read64             =3D nvmf_reg_read64,
+       .reg_write32            =3D nvmf_reg_write32,
+       .free_ctrl              =3D nvme_tcp_free_ctrl,
+       .submit_async_event     =3D nvme_tcp_submit_async_event,
+       .delete_ctrl            =3D nvme_tcp_delete_ctrl,
+       .get_address            =3D nvmf_get_address,
+       .stop_ctrl              =3D nvme_tcp_stop_ctrl,
+};
+
+static bool
+nvme_tcp_existing_controller(struct nvmf_ctrl_options *opts)
+{
+       struct nvme_tcp_ctrl *ctrl;
+       bool found =3D false;
+
+       mutex_lock(&nvme_tcp_ctrl_mutex);
+       list_for_each_entry(ctrl, &nvme_tcp_ctrl_list, list) {
+               found =3D nvmf_ip_options_match(&ctrl->ctrl, opts);
+               if (found)
+                       break;
+       }
+       mutex_unlock(&nvme_tcp_ctrl_mutex);
+
+       return found;
+}
+
+static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
+               struct nvmf_ctrl_options *opts)
+{
+       struct nvme_tcp_ctrl *ctrl;
+       int ret;
+
+       ctrl =3D kzalloc(sizeof(*ctrl), GFP_KERNEL);
+       if (!ctrl)
+               return ERR_PTR(-ENOMEM);
+
+       INIT_LIST_HEAD(&ctrl->list);
+       ctrl->ctrl.opts =3D opts;
+       ctrl->ctrl.queue_count =3D opts->nr_io_queues + 1; /* +1 for admin =
queue */
+       ctrl->ctrl.sqsize =3D opts->queue_size - 1;
+       ctrl->ctrl.kato =3D opts->kato;
+
+       INIT_DELAYED_WORK(&ctrl->ctrl.connect_work,
+                       nvme_tcp_reconnect_ctrl_work);
+       INIT_WORK(&ctrl->ctrl.err_work, nvme_tcp_error_recovery_work);
+       INIT_WORK(&ctrl->ctrl.reset_work, nvme_reset_ctrl_work);
+
+       if (!(opts->mask & NVMF_OPT_TRSVCID)) {
+               opts->trsvcid =3D
+                       kstrdup(__stringify(NVME_TCP_DISC_PORT), GFP_KERNEL=
);
+               if (!opts->trsvcid) {
+                       ret =3D -ENOMEM;
+                       goto out_free_ctrl;
+               }
+               opts->mask |=3D NVMF_OPT_TRSVCID;
+       }
+
+       ret =3D inet_pton_with_scope(&init_net, AF_UNSPEC,
+                       opts->traddr, opts->trsvcid, &ctrl->addr);
+       if (ret) {
+               pr_err("malformed address passed: %s:%s\n",
+                       opts->traddr, opts->trsvcid);
+               goto out_free_ctrl;
+       }
+
+       if (opts->mask & NVMF_OPT_HOST_TRADDR) {
+               ret =3D inet_pton_with_scope(&init_net, AF_UNSPEC,
+                       opts->host_traddr, NULL, &ctrl->src_addr);
+               if (ret) {
+                       pr_err("malformed src address passed: %s\n",
+                              opts->host_traddr);
+                       goto out_free_ctrl;
+               }
+       }
+
+       if (!opts->duplicate_connect && nvme_tcp_existing_controller(opts))=
 {
+               ret =3D -EALREADY;
+               goto out_free_ctrl;
+       }
+
+       ctrl->queues =3D kcalloc(opts->nr_io_queues + 1, sizeof(*ctrl->queu=
es),
+                               GFP_KERNEL);
+       if (!ctrl->queues) {
+               ret =3D -ENOMEM;
+               goto out_free_ctrl;
+       }
+
+       ret =3D nvme_init_ctrl(&ctrl->ctrl, dev, &nvme_tcp_ctrl_ops, 0);
+       if (ret)
+               goto out_kfree_queues;
+
+       if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING)) {
+               WARN_ON_ONCE(1);
+               ret =3D -EINTR;
+               goto out_uninit_ctrl;
+       }
+
+       ret =3D nvme_tcp_setup_ctrl(&ctrl->ctrl, true);
+       if (ret)
+               goto out_uninit_ctrl;
+
+       dev_info(ctrl->ctrl.device, "new ctrl: NQN \"%s\", addr %pISp\n",
+               ctrl->ctrl.opts->subsysnqn, &ctrl->addr);
+
+       nvme_get_ctrl(&ctrl->ctrl);
+
+       mutex_lock(&nvme_tcp_ctrl_mutex);
+       list_add_tail(&ctrl->list, &nvme_tcp_ctrl_list);
+       mutex_unlock(&nvme_tcp_ctrl_mutex);
+
+       return &ctrl->ctrl;
+
+out_uninit_ctrl:
+       nvme_uninit_ctrl(&ctrl->ctrl);
+       nvme_put_ctrl(&ctrl->ctrl);
+       if (ret > 0)
+               ret =3D -EIO;
+       return ERR_PTR(ret);
+out_kfree_queues:
+       kfree(ctrl->queues);
+out_free_ctrl:
+       kfree(ctrl);
+       return ERR_PTR(ret);
+}
+
+static struct nvmf_transport_ops nvme_tcp_transport =3D {
+       .name           =3D "tcp",
+       .module         =3D THIS_MODULE,
+       .required_opts  =3D NVMF_OPT_TRADDR,
+       .allowed_opts   =3D NVMF_OPT_TRSVCID | NVMF_OPT_RECONNECT_DELAY |
+                         NVMF_OPT_HOST_TRADDR | NVMF_OPT_CTRL_LOSS_TMO |
+                         NVMF_OPT_HDR_DIGEST | NVMF_OPT_DATA_DIGEST,
+       .create_ctrl    =3D nvme_tcp_create_ctrl,
+};
+
+static int __init nvme_tcp_init_module(void)
+{
+       nvme_tcp_wq =3D alloc_workqueue("nvme_tcp_wq",
+                       WQ_MEM_RECLAIM | WQ_HIGHPRI, 0);
+       if (!nvme_tcp_wq)
+               return -ENOMEM;
+
+       nvmf_register_transport(&nvme_tcp_transport);
+       return 0;
+}
+
+static void __exit nvme_tcp_cleanup_module(void)
+{
+       struct nvme_tcp_ctrl *ctrl;
+
+       nvmf_unregister_transport(&nvme_tcp_transport);
+
+       mutex_lock(&nvme_tcp_ctrl_mutex);
+       list_for_each_entry(ctrl, &nvme_tcp_ctrl_list, list)
+               nvme_delete_ctrl(&ctrl->ctrl);
+       mutex_unlock(&nvme_tcp_ctrl_mutex);
+       flush_workqueue(nvme_delete_wq);
+
+       destroy_workqueue(nvme_tcp_wq);
+}
+
+module_init(nvme_tcp_init_module);
+module_exit(nvme_tcp_cleanup_module);
+
+MODULE_LICENSE("GPL v2");
--
2.17.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
