Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C02F3E44F5;
	Tue,  7 Jul 2026 10:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783420067; cv=none; b=ZBOE7Ktmtubm6eq82SX/4puuRaDCRpHpdcI5MMYQKPbI7bGJ7AmEd9HOkmkBA+6OB8cJkjXqaHwI3t6SvjV3ePWC73QDDp+oJKUFc+aj8p9k/2ZvosZ549U9+xHupaN1f/w7KGQ5uPfnqJXBECMuiw2YI3S8efu//ca6QQHCwj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783420067; c=relaxed/simple;
	bh=H8OUpUI3VSvVlFqzlcV0JER00AZy86msv+BHgoPqKPw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=f15CSwkx+j+fiUvXqbue0NdoWAUYYuDj/zST1EZCf9SSxMAMFeLAYY46qQ43nD97MLNHme2Npq702TC5O7Bw8rgZbawD/6FFQahSdWmCrtgrp3JrvXK5mFBqD9bX7eZ6FRH9ibmC4bj5tq5ynhdTxNr/1z35dv646jjj9XMa+zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=IztUMqsw; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="IztUMqsw"
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6678Gw3p1008994;
	Tue, 7 Jul 2026 10:27:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=x1szRj3FD
	G9O4iCY4UTwsWmMm4oeZ5ID9u1/8xEIauo=; b=IztUMqswB0PywPCIQ2B0l0eHh
	nyGuDoXMAG+HsHvLzkY07MQ2bRKJWneSt9uFYb7XrWk/pH8Rvn1klZon8Zhw/buh
	Jqm2Nkd70BGBW0u5OVo/79VFst9qTThjMDs93vAdmB+QZ6X5BZVnZx5Au0+pb6hc
	yGXpceRn8Q6aJLtif1qtN4Hm4nyv2izgfEtr5AYsRZm22ztglxhRSo/+9TDiFBdy
	bYETS3tDgMGMNGfW/DzcDy7H1txRb++4fWzNeIRFgdfh0qwRCisqhXOqFZ63cGJm
	bUDpfpzmK6SDh5nWbYW9M72s6kdn3QgR6D8k3Mv0sNI/3AGMlt+JrfvQpL9nA==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4f6s58c0b4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 07 Jul 2026 10:27:28 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Tue, 7 Jul 2026 03:27:27 -0700
Received: from pek-yzhou-d3.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Tue, 7 Jul 2026 03:27:25 -0700
From: Yun Zhou <yun.zhou@windriver.com>
To: <josef@toxicpanda.com>, <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, <nbd@other.debian.org>,
        <linux-kernel@vger.kernel.org>, <yun.zhou@windriver.com>
Subject: [PATCH 1/2] nbd: replace wait_for_reconnect with non-blocking retry
Date: Tue, 7 Jul 2026 18:27:23 +0800
Message-ID: <20260707102724.3838638-1-yun.zhou@windriver.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDEwMSBTYWx0ZWRfX3BfxGrC9VvW6
 dIWcc0yc2bC18NzcVuL1X/UyaH15JYmDuiT35IIZwah4S/M456x/cdBOJDmOjJ1JQT6YtWw5prF
 8bHAcfb7RUGYo0LHzFocAK7FDHF+iQZStSvsfF8Rb3ApHHbbs3dA
X-Proofpoint-ORIG-GUID: HmK6BRuKuxvEVvTTfOWMZhcqQTiAxydh
X-Proofpoint-GUID: HmK6BRuKuxvEVvTTfOWMZhcqQTiAxydh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDEwMSBTYWx0ZWRfX2xEq2VSnKxFJ
 T288DtxBjtAaYFHQ2K3+pp5BJWSIsicKCjuSM5hJGTaxKOqI/+5Wejk9TnS+7c3IyQajm4IG09O
 q4WCyggmhma4lNfetBBBx/feOCNy3OU9DFWxO7LpE7lblq4b5WxyZZOmjdeKFzMejeJ7VZrzp+z
 LasYyB+KizhxtJc5pG4qZ7x3XiBar1cHHJM6k0mIJ1QqpMdZ30daITXSdnVBq2+Zd7qczjnDNv7
 3Q7zzaRnZ+cgp3G2Ho1YpkY9/hvCnTGLSgAiqB4blupv3vDcHz1stccwel8WpEzOYK51uUQMCQq
 20jjp3TJghp4bC2x8HbGNWAqx6OIVm1UR1HFo6JP/OVV93kutwa7YoaM6CDs1HsvHLxK1MDZ3zS
 M2KxOb5+KrbHA8i3MWfnjNrxINcnzEFuBlWYyFsFuvhXRGWD1KTtsLGiMtVoupw/01FdKN9K/xi
 GXTiqL3rLfW5qlpaYCg==
X-Authority-Analysis: v=2.4 cv=H5frBeYi c=1 sm=1 tr=0 ts=6a4cd490 cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=fTW__CHxibyLmBMfj2wP:22 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8 a=t7CeM3EgAAAA:8
 a=BqvD2fTxkrx_Rfrxhs8A:9 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 phishscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070101

wait_for_reconnect() sleeps in the block dispatch path holding the
SRCU read lock.  This blocks blk_mq_quiesce_queue() (which needs
synchronize_srcu) for the entire dead_conn_timeout duration, triggering
hung task warnings.

Replace it with a non-blocking nbd_reconnect_possible() check that
returns BLK_STS_DEV_RESOURCE to keep the request on the dispatch list,
with a 1-second delayed queue run to re-evaluate.  Once the timeout
expires or the device is disconnected, fail the I/O immediately.

Fixes: 560bc4b39952 ("nbd: handle dead connections")
Reported-by: syzbot+30c16035531e3248dcbc@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=30c16035531e3248dcbc
Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
---
 drivers/block/nbd.c | 61 +++++++++++++++++++++++++++------------------
 1 file changed, 37 insertions(+), 24 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 70a04d541ea4..43aa4121f0c5 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -94,11 +94,11 @@ struct nbd_config {
 	u32 flags;
 	unsigned long runtime_flags;
 	u64 dead_conn_timeout;
+	unsigned long dead_conn_start; /* jiffies, 0 = not waiting */
 
 	struct nbd_sock **socks;
 	int num_connections;
 	atomic_t live_connections;
-	wait_queue_head_t conn_wait;
 
 	atomic_t recv_threads;
 	wait_queue_head_t recv_wq;
@@ -1124,20 +1124,25 @@ static int find_fallback(struct nbd_device *nbd, int index)
 	return new_index;
 }
 
-static int wait_for_reconnect(struct nbd_device *nbd)
+static bool nbd_reconnect_possible(struct nbd_device *nbd)
 {
 	struct nbd_config *config = nbd->config;
+
 	if (!config->dead_conn_timeout)
-		return 0;
+		return false;
+	if (test_bit(NBD_RT_DISCONNECTED, &config->runtime_flags))
+		return false;
 
-	if (!wait_event_timeout(config->conn_wait,
-				test_bit(NBD_RT_DISCONNECTED,
-					 &config->runtime_flags) ||
-				atomic_read(&config->live_connections) > 0,
-				config->dead_conn_timeout))
-		return 0;
+	/* Record when all connections first went dead */
+	if (!READ_ONCE(config->dead_conn_start))
+		WRITE_ONCE(config->dead_conn_start, jiffies ? : 1);
+
+	/* Check if we've exceeded the reconnect timeout */
+	if (time_after(jiffies, READ_ONCE(config->dead_conn_start) +
+		       (unsigned long)config->dead_conn_timeout))
+		return false;
 
-	return !test_bit(NBD_RT_DISCONNECTED, &config->runtime_flags);
+	return true;
 }
 
 static blk_status_t nbd_handle_cmd(struct nbd_cmd *cmd, int index)
@@ -1168,23 +1173,24 @@ static blk_status_t nbd_handle_cmd(struct nbd_cmd *cmd, int index)
 	nsock = config->socks[index];
 	mutex_lock(&nsock->tx_lock);
 	if (nsock->dead) {
-		int old_index = index;
 		index = find_fallback(nbd, index);
 		mutex_unlock(&nsock->tx_lock);
 		if (index < 0) {
-			if (wait_for_reconnect(nbd)) {
-				index = old_index;
-				goto again;
+			if (!nbd_reconnect_possible(nbd)) {
+				sock_shutdown(nbd);
+				nbd_config_put(nbd);
+				return BLK_STS_IOERR;
 			}
-			/* All the sockets should already be down at this point,
-			 * we just want to make sure that DISCONNECTED is set so
-			 * any requests that come in that were queue'ed waiting
-			 * for the reconnect timer don't trigger the timer again
-			 * and instead just error out.
+			/*
+			 * All connections are dead but reconnect timeout
+			 * has not expired.  Return BLK_STS_DEV_RESOURCE
+			 * so the request stays on the dispatch list, and
+			 * schedule a delayed queue run after 1 second to
+			 * re-evaluate.
 			 */
-			sock_shutdown(nbd);
+			blk_mq_delay_run_hw_queues(nbd->disk->queue, 1000);
 			nbd_config_put(nbd);
-			return BLK_STS_IOERR;
+			return BLK_STS_DEV_RESOURCE;
 		}
 		goto again;
 	}
@@ -1437,7 +1443,9 @@ static int nbd_reconnect_socket(struct nbd_device *nbd, unsigned long arg)
 		queue_work(nbd->recv_workq, &args->work);
 
 		atomic_inc(&config->live_connections);
-		wake_up(&config->conn_wait);
+		/* Reconnected -- stop waiting for dead_conn_timeout */
+		WRITE_ONCE(config->dead_conn_start, 0);
+		blk_mq_run_hw_queues(nbd->disk->queue, true);
 		return 0;
 	}
 	sk_clear_memalloc(sock->sk);
@@ -1499,6 +1507,13 @@ static int nbd_disconnect(struct nbd_device *nbd)
 	dev_info(disk_to_dev(nbd->disk), "NBD_DISCONNECT\n");
 	set_bit(NBD_RT_DISCONNECT_REQUESTED, &config->runtime_flags);
 	set_bit(NBD_DISCONNECT_REQUESTED, &nbd->flags);
+	/*
+	 * If all connections are already dead, no sock_shutdown callback
+	 * will fire to set NBD_RT_DISCONNECTED.  Set it here so
+	 * nbd_reconnect_possible() stops waiting immediately.
+	 */
+	if (atomic_read(&config->live_connections) == 0)
+		set_bit(NBD_RT_DISCONNECTED, &config->runtime_flags);
 	send_disconnects(nbd);
 	return 0;
 }
@@ -1766,7 +1781,6 @@ static int nbd_alloc_and_init_config(struct nbd_device *nbd)
 
 	atomic_set(&config->recv_threads, 0);
 	init_waitqueue_head(&config->recv_wq);
-	init_waitqueue_head(&config->conn_wait);
 	config->blksize_bits = NBD_DEF_BLKSIZE_BITS;
 	atomic_set(&config->live_connections, 0);
 
@@ -2337,7 +2351,6 @@ static void nbd_disconnect_and_put(struct nbd_device *nbd)
 	mutex_lock(&nbd->config_lock);
 	nbd_disconnect(nbd);
 	sock_shutdown(nbd);
-	wake_up(&nbd->config->conn_wait);
 	/*
 	 * Clear NBD_RT_BOUND before releasing config_lock so that
 	 * nbd_genl_reconfigure() won't queue new recv_work between
-- 
2.43.0

