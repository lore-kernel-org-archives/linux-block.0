Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818F425742F;
	Tue, 30 Jun 2026 03:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782789036; cv=none; b=GRDfjktUSll9WNvXvXU53tVubyADX7KGfr31VxmFl1JTBP8NmC+n2nnSn8KrpEaXzFRwEs9/mpzHwpPUSEV2RkGZHKAUoKhFjKaUeyJbv9RZnPyTFpvqdrtQgfVeGOSQfZ0ceZMEWEy8XBCJ0fFLNwKIPwuk+MXy5VbONxlcPXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782789036; c=relaxed/simple;
	bh=kQ63zt/PJD/0qTKICcWo2MKqlVnl/UQMVCx4eoRCMhE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aR/7qQ+TMIL4cZv2bp+KxdirJuakCNU3nQEtTFYK7tAkdpRgHl22vRt2pDCrQO/lTg8RbB330ojpHOV0dPhNu0mH+8Jdc50OyZphOhGsm/4sH+Ah8ajIC/NVsEC3p1Dw+bhPotwOoXG3z6lGA2hshp3U7SoLq7NgS8uU1bB3w9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=h175bM1d; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="h175bM1d"
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U32JIf4190786;
	Tue, 30 Jun 2026 03:10:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=fNF5FCuCP
	jrD2LewI+ejwK4ajB9tIREeCkTRUUiVowM=; b=h175bM1dLr8JXLN/o69W+xUxE
	s6i/ulzT7yplaIh0ew+Dr5dsCZZDjqluSxrJeRG9GtYinCQh4nRkHNrX35cCu8K0
	zbKaPqw6DtHkNWsdLulB2YeKXX2RmJgOM+p7S/MoAWE1ywhrj1DBCnfro5ZvkC6Q
	5lNaofjPVX6oErfrrFwunIclSqKxwPU3OrKP9HtdHKS63IWEJqUdfQEYZlGfxsMm
	eJMV4nPjdTKEXoAa5r2anNKbFbZIhCnarC8Hd/mobS0GzY2wz+Vwlqpp06qbki6u
	JfhvRCoiouDi48z6gkkhnAszAHWVKrKv3mH3BdWg1OYHvlj7ERjF+YLvKAiCg==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4f25g5k9ct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 30 Jun 2026 03:10:24 +0000 (GMT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Mon, 29 Jun 2026 20:10:23 -0700
Received: from pek-yzhou-d3.wrs.com (10.11.232.110) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Mon, 29 Jun 2026 20:10:22 -0700
From: Yun Zhou <yun.zhou@windriver.com>
To: <josef@toxicpanda.com>, <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, <nbd@other.debian.org>,
        <linux-kernel@vger.kernel.org>, <yun.zhou@windriver.com>
Subject: [PATCH] nbd: fix circular lock dependency in nbd_disconnect_and_put
Date: Tue, 30 Jun 2026 11:10:21 +0800
Message-ID: <20260630031021.3321628-1-yun.zhou@windriver.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDAyNiBTYWx0ZWRfXy15oBaALL31M
 D5kb7b9MDShFs7R9ygwfZfgme+C9sjVBCpZ/EQKejbOXtQRF35TVwK9lf8tewYwzEPO38vIq7cc
 Y2Gxv/HmEYVMMLGlP6uNoNMEqo7r3sMwgWJXFteh3bmdcEziAatP
X-Proofpoint-ORIG-GUID: P3MJ3eZBml1LzM0XUvnqosrHVY4Lmqf0
X-Proofpoint-GUID: P3MJ3eZBml1LzM0XUvnqosrHVY4Lmqf0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDAyNiBTYWx0ZWRfX3XMMuotHU0jA
 jhnH3gnnE+vhmQP2gGGAuKiR9JkTiB+aFy/v3SxOaIBrtujeancTD7lZ7D1KYmGtNWlZFog5FzV
 iO7b0nMyIywar4zmk7x9Kz2EGKI5nCEGrVXcLcWFenSKNX3UCKqD6HemnCLw4NgQW7jKqSgp6yz
 oALoWO0ku6rbxW/bYt91SWq3yBuocKszRP8sKLCXBwz+rBlioRbiLB4unFp20jq2Dcfzxhsqki7
 v5gdIdmy5qEQ+Bs5apBvtG4sFnyxrNEBKfa0gJKDHajF2GWsMyljtDMWrPSTJ4ZhZrcnDz2lC+A
 dBNtVLbiY5DTLQMTB4nXUoOGpn4z6lZuf/C2b4hxQQMOxbtvLZRNQrwavvcrMUsu/GBh3YY9xWA
 +IgRkX2CA6iJEFckOEvqHTskl8vva0iPWhQ+DCAnYzRjdbTfF7tePf/M3/SIS5uu16NIypryoHv
 sz1Z3dWC0aA3A9hCpHw==
X-Authority-Analysis: v=2.4 cv=TvLWQjXh c=1 sm=1 tr=0 ts=6a4333a0 cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=fTW__CHxibyLmBMfj2wP:22 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8 a=t7CeM3EgAAAA:8
 a=KBjEgWPWrn1WYosy2ncA:9 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 suspectscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300026

Move flush_workqueue() out of the config_lock critical section in
nbd_disconnect_and_put() to break a circular lock dependency.

The lockdep splat shows:

  config_lock -> (wq_completion)nbd0-recv
    from nbd_disconnect_and_put() holding config_lock then calling
    flush_workqueue() which waits for recv_work to complete.

  (work_completion)(&args->work) -> config_lock
    from recv_work() -> nbd_config_put() -> refcount_dec_and_mutex_lock()
    which may acquire config_lock when the last reference is dropped.

Fix by splitting the config_lock region: first hold config_lock to
perform nbd_disconnect(), sock_shutdown(), and clear NBD_RT_BOUND (to
prevent nbd_genl_reconfigure from queueing new recv_work during the
window), then release config_lock before flush_workqueue(), and
re-acquire it for nbd_clear_que(). This is safe because:

- sock_shutdown() ensures recv_work will observe errors and exit
- NBD_RT_BOUND cleared prevents concurrent reconfigure from reconnecting
- flush_workqueue() guarantees all recv_work has completed before
  the second config_lock section clears the queue

Fixes: e2daec488c57 ("nbd: Fix hungtask when nbd_config_put")
Reported-by: syzbot+3add0454d5a2619b8e80@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3add0454d5a2619b8e80
Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
---
 drivers/block/nbd.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index c5d3ae8f5fc5..87b97bd9d0d3 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -2329,14 +2329,23 @@ static void nbd_disconnect_and_put(struct nbd_device *nbd)
 	nbd_disconnect(nbd);
 	sock_shutdown(nbd);
 	wake_up(&nbd->config->conn_wait);
+	/*
+	 * Clear NBD_RT_BOUND before releasing config_lock so that
+	 * nbd_genl_reconfigure() won't queue new recv_work between
+	 * here and flush_workqueue().
+	 */
+	nbd->task_setup = NULL;
+	clear_bit(NBD_RT_BOUND, &nbd->config->runtime_flags);
+	mutex_unlock(&nbd->config_lock);
+
 	/*
 	 * Make sure recv thread has finished, we can safely call nbd_clear_que()
 	 * to cancel the inflight I/Os.
 	 */
 	flush_workqueue(nbd->recv_workq);
+
+	mutex_lock(&nbd->config_lock);
 	nbd_clear_que(nbd);
-	nbd->task_setup = NULL;
-	clear_bit(NBD_RT_BOUND, &nbd->config->runtime_flags);
 	mutex_unlock(&nbd->config_lock);
 
 	if (test_and_clear_bit(NBD_RT_HAS_CONFIG_REF,
-- 
2.43.0

