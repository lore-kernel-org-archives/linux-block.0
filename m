Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF24F3E0C51;
	Tue,  7 Jul 2026 10:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783420115; cv=none; b=o39IScW34Vw+tYNZW9ON3Qq3TVLYPMVWwJrURJND5qT0izluG6DmFwkfDPNLUzJijiEZg1mzM/jafZd8VtK27W+2v6ntIGWFokXe3O9ixtcE0IlmE/uuc/nsD0VAlwHf7MIqhsfX+HXjzTBPbHZfLKA4LdS+vV17mFE9L1AifB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783420115; c=relaxed/simple;
	bh=rPI405AEN5czSWaqVFEgga7bybgyhCObLvfO7/unjVo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JuF2LyzZDRsXCF85Rp+8eSEP0DCBXyePs8wI0UkxrxXXIncLErWl0rI5sm45ZaNvcyxJvfjZqPKuJV1gUDYqITvtxKjOXP8HlL0dB5Pmzczxt9FZdsjHBt/rppnhK0lhLMWvryq4OvLKkQiKoKoDfClDwUA88sqy253G4PM+6Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=HUYpN43x; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="HUYpN43x"
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6678GlHC1173721;
	Tue, 7 Jul 2026 03:27:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=pYhbLT4PfFAwIweFzAjP0tRW9vm8wKWLPiQXEilVNkI=; b=
	HUYpN43xTprL33ZX5bGmIQ2Iw2u0ncdz8PvbaFdU/KzB345Xvqd1dZ1xQYXqbaiV
	xQ2m5A/fI6dayoWnJodNPzRm8RJF3yQseFS8bBu/64lqg40qyRn/CAOSOcOja3kU
	tLs32zkl4vpJQKGlP2/K98f8A9Ra3KtglYSCVK/omBnyj9Cg4eqzntHK9LLzT2qp
	dAK1uryPxBd43whkrTNiyWIsfMCNaQoJV+w1Ilut0lm8lvHUmx9wLvIIAgpyBFbk
	yhH2Q6a/6AQAVVxqk4nvG1+JHGNnlgmHuTNwA07OI2pRfTAZnd6VFXQQvRbPWwCA
	DkDxqOoApMPsT+Cbvqyp4A==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4f71pe3mfb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 07 Jul 2026 03:27:30 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Tue, 7 Jul 2026 03:27:29 -0700
Received: from pek-yzhou-d3.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Tue, 7 Jul 2026 03:27:27 -0700
From: Yun Zhou <yun.zhou@windriver.com>
To: <josef@toxicpanda.com>, <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, <nbd@other.debian.org>,
        <linux-kernel@vger.kernel.org>, <yun.zhou@windriver.com>
Subject: [PATCH 2/2] nbd: detect management process exit via netlink notifier
Date: Tue, 7 Jul 2026 18:27:24 +0800
Message-ID: <20260707102724.3838638-2-yun.zhou@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707102724.3838638-1-yun.zhou@windriver.com>
References: <20260707102724.3838638-1-yun.zhou@windriver.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: qSkQ9cP_KG4l5hbxPkBAtz_wvXRbHjgE
X-Proofpoint-ORIG-GUID: qSkQ9cP_KG4l5hbxPkBAtz_wvXRbHjgE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDEwMSBTYWx0ZWRfX2yviIXIJJtI7
 GoFuaeQgmzMNXc/aqP1bV0tjH7elLEXeupL3lW5lF31aNFmh0MOSukBAxBpox+f9KGC6Y6trM+8
 yj4FqPZFEkh8e+3xIDNAPj0JjgLJGvUR5oruSEbZPKU+HeAR1PZhdUIPnabEj2vYfIDrRZkGy4u
 VY7agg+a6CZiGgCByJHT6mLNOyGnGlM+5bXioSeRhw7GsS5gEMzautLFQ6czzWeWd3x0T8K2F/q
 nVfyje/jZ/7msHmowGXIYXMUOBfWdFiZwd7j1+UenG6079Ol0M8uBE5YvOdNAxaZqdFSQdqHlRx
 N/NiKopb1RcXFGOY354Oet+OFw5dupci16gCE+JSIe0pfTJnkHKrv63K2CcCTQ3BcrbvnitnsVo
 8e7vFtKvr/+fzVRzCX3STFgRdojIAGIbAS21WmYus3AOSCX64qb1baAQKMbeUErJeIuPs3+m1h2
 2Qw5ooHYx9+5LAo+JTw==
X-Authority-Analysis: v=2.4 cv=VN/tWdPX c=1 sm=1 tr=0 ts=6a4cd492 cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=iKiJcTA2PjBS6x5JeXcw:22 a=t7CeM3EgAAAA:8 a=Lt-lTd8dryHg_DWUlXYA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDEwMSBTYWx0ZWRfX+Pfij7GPSHuJ
 ZYhHSVsSPL08bYjA5mHhfx8M0B1Rdfd3bOOxdIQghUQOYZyi4lDBdSoAMBQEO9PXA9zceGzWxe4
 dygSk0xdVYbkS+WNvwCzLeyCD0ME6ab2xkP2uUkvHGtU6WMkMEN7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 impostorscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070101

Register a netlink notifier to detect when the NBD management process
closes its netlink socket (on exit or crash).

Without this, in-flight I/O waits for socket timeout while udevd holds
disk->open_mutex for partition scanning, blocking poweroff's
sync_bdevs() and causing a hung task during shutdown.

Fix this by tracking the management process's netlink portid and, on
NETLINK_URELEASE, calling sock_shutdown() on all devices it owns.
This fails in-flight I/O immediately so shutdown can proceed.

Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
---
 drivers/block/nbd.c | 59 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 43aa4121f0c5..3bf88f7b3535 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -45,6 +45,7 @@
 #include <linux/nbd.h>
 #include <linux/nbd-netlink.h>
 #include <net/genetlink.h>
+#include <linux/netlink.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/nbd.h>
@@ -131,6 +132,7 @@ struct nbd_device {
 
 	unsigned long flags;
 	pid_t pid; /* pid of nbd-client, if attached */
+	u32 owner_portid; /* netlink portid of management process */
 
 	char *backend;
 };
@@ -2331,12 +2333,19 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
 	}
 	set_bit(NBD_RT_HAS_BACKEND_FILE, &config->runtime_flags);
 
+	/*
+	 * Set owner before starting device so that the netlink notifier
+	 * can clean up if the management process exits during setup.
+	 */
+	nbd->owner_portid = info->snd_portid;
 	ret = nbd_start_device(nbd);
 out:
 	if (!ret) {
 		set_bit(NBD_RT_HAS_CONFIG_REF, &config->runtime_flags);
 		refcount_inc(&nbd->config_refs);
 		nbd_connect_reply(info, nbd->index);
+	} else {
+		nbd->owner_portid = 0;
 	}
 	mutex_unlock(&nbd->config_lock);
 
@@ -2541,6 +2550,12 @@ static int nbd_genl_reconfigure(struct sk_buff *skb, struct genl_info *info)
 		}
 	}
 out:
+	/*
+	 * Update owner to the reconfiguring process so the notifier
+	 * tracks the correct management process.
+	 */
+	if (!ret)
+		nbd->owner_portid = info->snd_portid;
 	mutex_unlock(&nbd->config_lock);
 	nbd_config_put(nbd);
 	nbd_put(nbd);
@@ -2743,6 +2758,48 @@ static void nbd_dead_link_work(struct work_struct *work)
 	kfree(args);
 }
 
+/*
+ * Detect when the management process (the one that issued NBD_CMD_CONNECT)
+ * closes its netlink socket (e.g., exit or crash).  When this happens,
+ * no one can reconnect, so mark all its devices as disconnected to stop
+ * waiting for reconnect and fail pending I/O promptly.
+ */
+static int nbd_netlink_event(struct notifier_block *this,
+			     unsigned long event, void *ptr)
+{
+	struct netlink_notify *n = ptr;
+	struct nbd_device *nbd;
+	int id;
+
+	if (event != NETLINK_URELEASE || n->protocol != NETLINK_GENERIC)
+		return NOTIFY_DONE;
+
+	mutex_lock(&nbd_index_mutex);
+	idr_for_each_entry(&nbd_index_idr, nbd, id) {
+		if (nbd->owner_portid != n->portid)
+			continue;
+
+		nbd->owner_portid = 0;
+		if (refcount_inc_not_zero(&nbd->config_refs)) {
+			/*
+			 * Shut down all sockets.  sock_shutdown() holds
+			 * tx_lock for each socket, preventing races with
+			 * reconnect, and sets NBD_RT_DISCONNECTED so that
+			 * nbd_reconnect_possible() fails immediately.
+			 */
+			sock_shutdown(nbd);
+			nbd_config_put(nbd);
+		}
+	}
+	mutex_unlock(&nbd_index_mutex);
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block nbd_netlink_notifier = {
+	.notifier_call = nbd_netlink_event,
+};
+
 static int __init nbd_init(void)
 {
 	int i;
@@ -2789,6 +2846,7 @@ static int __init nbd_init(void)
 		unregister_blkdev(NBD_MAJOR, "nbd");
 		return -EINVAL;
 	}
+	netlink_register_notifier(&nbd_netlink_notifier);
 	nbd_dbg_init();
 
 	for (i = 0; i < nbds_max; i++)
@@ -2818,6 +2876,7 @@ static void __exit nbd_cleanup(void)
 	 * for the completion of netlink commands.
 	 */
 	genl_unregister_family(&nbd_genl_family);
+	netlink_unregister_notifier(&nbd_netlink_notifier);
 
 	nbd_dbg_close();
 
-- 
2.43.0

