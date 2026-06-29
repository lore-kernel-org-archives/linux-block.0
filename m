Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6801367;
	Mon, 29 Jun 2026 06:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782713028; cv=none; b=MjOVTcv0pm3U8AckcT5afdJWJGc8LMbAuSVTFZVkl3r00apJGJyJn69Za+dYVbytXfAagh3W225lTdHfGrZHIC+BOdN0m0JiL90acPWYjyFubZ/2Mh3364aHbY+q1+Nhz0EIHIexnVEGzvy4clHcwFtV7r4OemFqAe153JyshTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782713028; c=relaxed/simple;
	bh=/hNFodQsx+w1ZoCRma3uxi5HpdDnGhbOWhfOLpZhTSU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uCoVIoNXwNLB2E0P75GX2+xLFyyAxpY8c9QapBxs/Qnjy7Elhi5Cw2omyLlR20glubVOxyLjwdHdGV/ZvQkAJF8JJCMzKVBnFvWEdDveEU1sP0i6bNDYwbQ5OzRpvHh96vmPtmo54lqnJ2w5mG7+Tc2pCaZjcjhjsoHxjiHD3pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=T8vdfZYW; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="T8vdfZYW"
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T5e24L2030107;
	Mon, 29 Jun 2026 06:03:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=Q/yb8i4Oc
	o9DBVGPDK8dXmVjRM6lRe/fowlbm5qkJQc=; b=T8vdfZYW2W7RPw+idaNuHOkqH
	qmUBjU+zqEY3bAQ3BJL1fFMVRy77I5Tx1B1ykMKAYqh/M9D+Sor2aiyYnfVGS2a4
	sGuNzDolc6+F22FbUMtt58vZVna0mkIRZaMYFnrGIdR1mVRBb0l5gnM8LTBM9ESC
	GaM9MlPLWkQLaSK9BpyUtUzLdJ2N0RpXUKr7jxCw3C3PGAfCehDM1YWWp8zHUt9B
	33Q8fRPkWM/6ICi7ECQbZgrLywzLYYAJWD8xwftlqt/1G2bFTrc6oBt8K4+2nCQo
	Ef1sJbWnkZw9UHlz3VKUcbJQJ88vIAKNnZFprKDyRONPcYcbrGd6QXHQmS3Sg==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4f23r09tdh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 29 Jun 2026 06:03:40 +0000 (GMT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Sun, 28 Jun 2026 23:03:39 -0700
Received: from pek-yzhou-d3.wrs.com (10.11.232.110) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Sun, 28 Jun 2026 23:03:37 -0700
From: Yun Zhou <yun.zhou@windriver.com>
To: <josef@toxicpanda.com>, <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, <nbd@other.debian.org>,
        <linux-kernel@vger.kernel.org>, <yun.zhou@windriver.com>
Subject: [PATCH] nbd: fix circular lock dependency in nbd_reconnect_socket
Date: Mon, 29 Jun 2026 14:03:36 +0800
Message-ID: <20260629060336.1654834-1-yun.zhou@windriver.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=DNC/JSNb c=1 sm=1 tr=0 ts=6a420abc cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=klDOsUkWDRETUCZYPvoE:22 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8 a=t7CeM3EgAAAA:8
 a=ZQijHMFe3N0cKPiTkksA:9 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: bMtrL8E8HqO5lqKEMa_fthmUUDBI8KyX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA0OSBTYWx0ZWRfX1uuTjNsvZ89k
 mTdJLrzsMFrdjqmh/92CnqT9yhOE6c9YeSTh3a6IJbpijLwO41hEkkjeEOX1/Gxr2+0Q4apsf2k
 aRR7ynyBTC11P+5LxNTLBCcN7MsIdFY158/JGuWSQjEJXLmivC1AhN5ulO4745zS/8X+lqF6je4
 vsr9wy+5U4ptZSzHt/eZ1J8j5d9orKlegce5dUxBdwYuAmSfgZwWHF7Z3gogZLfKACHyvaO2wfC
 WVpGk6YQO0v+RRn4lzWGMz0dZ8M3c/mG1jnXxu5oFjADXyzoTBJFFdFf9GaTpGM1SGLcZOIqRSb
 um4eqJ0FJeQuiYhd1UTxTGyMA5Am9LRtF66j7zxf2FEu7wp6dx33y8ocUPTL+OuHXOu3J2Ks59x
 utllnbN+doUk2pOL+vU2pwN/mJ2Yj3USXEXwLBjwX+gx2p1dgj1p8d4/SF9zrZlCgJ42cMofvLL
 E/QES7ur1F0jaSQuO5w==
X-Proofpoint-GUID: bMtrL8E8HqO5lqKEMa_fthmUUDBI8KyX
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA0OSBTYWx0ZWRfXxDi/7N6WpX0J
 Bx0LAVaXBDqSX91qRERL5+s57A9cl9xCqxkx3Rv4E+JXv/eMNOOrptZMy9HlC24cZiiJSLMmUc9
 qIFIUJccgUoN52QofOx/oiTChoOVN/dKT0Fo9ZONVP5CKpWtZ8/P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290049

Move sk_set_memalloc() out of the tx_lock critical section in
nbd_reconnect_socket() to break a circular lock dependency.

sk_set_memalloc() internally calls static_branch_inc() which acquires
cpu_hotplug_lock. When called under tx_lock, this creates the dependency:

  tx_lock -> cpu_hotplug_lock

The lockdep splat shows the following circular chain:

  cmd->lock -> tx_lock
    from nbd_queue_rq() in the block I/O dispatch path.

  tx_lock -> cpu_hotplug_lock
    from nbd_reconnect_socket() calling sk_set_memalloc() under tx_lock.

  cpu_hotplug_lock -> fs_reclaim -> q_usage_counter(io)
    from create_worker() during CPU hotplug needing memory allocation,
    which depends on block I/O completion to reclaim memory.

  q_usage_counter(io) -> elevator_lock
    from nbd_start_device() -> blk_mq_update_nr_hw_queues() ->
    elevator_change() which freezes the queue then acquires elevator_lock.

  elevator_lock -> set->srcu -> cmd->lock
    from elevator_switch() -> blk_mq_quiesce_queue() waiting for srcu,
    which waits for the I/O dispatch path holding cmd->lock.

Fix this by moving sk_set_memalloc() and sk_sndtimeo setup before the
tx_lock acquisition. This is safe because the new socket has not yet
been assigned to nsock->sock and is invisible to other code paths. In
the failure path (no dead connection found), sk_clear_memalloc() is
called to undo the setup before releasing the socket.

Fixes: b7aa3d39385d ("nbd: add a reconfigure netlink command")
Reported-by: syzbot+3dbc6142c85cc77eaf04@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3dbc6142c85cc77eaf04
Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
---
 drivers/block/nbd.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 497f3bbe5795..c5d3ae8f5fc5 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1392,6 +1392,14 @@ static int nbd_reconnect_socket(struct nbd_device *nbd, unsigned long arg)
 		return -ENOMEM;
 	}
 
+	/* Setup new socket properties before taking tx_lock to avoid
+	 * circular dependency: tx_lock -> cpu_hotplug_lock (via
+	 * sk_set_memalloc -> static_branch_inc).
+	 */
+	sk_set_memalloc(sock->sk);
+	if (nbd->tag_set.timeout)
+		sock->sk->sk_sndtimeo = nbd->tag_set.timeout;
+
 	for (i = 0; i < config->num_connections; i++) {
 		struct nbd_sock *nsock = config->socks[i];
 
@@ -1403,9 +1411,6 @@ static int nbd_reconnect_socket(struct nbd_device *nbd, unsigned long arg)
 			mutex_unlock(&nsock->tx_lock);
 			continue;
 		}
-		sk_set_memalloc(sock->sk);
-		if (nbd->tag_set.timeout)
-			sock->sk->sk_sndtimeo = nbd->tag_set.timeout;
 		atomic_inc(&config->recv_threads);
 		refcount_inc(&nbd->config_refs);
 		old = nsock->sock;
@@ -1433,6 +1438,7 @@ static int nbd_reconnect_socket(struct nbd_device *nbd, unsigned long arg)
 		wake_up(&config->conn_wait);
 		return 0;
 	}
+	sk_clear_memalloc(sock->sk);
 	sockfd_put(sock);
 	kfree(args);
 	return -ENOSPC;
-- 
2.43.0

