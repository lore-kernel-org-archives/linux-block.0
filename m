Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE152431486;
	Mon,  6 Jul 2026 15:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783353489; cv=none; b=X2+SonTFMeBNbLVFHyRD8zVh5wkBfkRct1DBRNLroTtXLDOEgcoJPtrzf4E1rhhvtadPbz3AAO9j98mOTKrWRhs9/1gRsVL1ldAGqdiIm3MG9/tRBxkah9BZVwzFHPk/swd3v7lDzMgi/JOgff3gtEsAJftOpBABzcPfgEIbdWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783353489; c=relaxed/simple;
	bh=q9q2yxBhJ7g99xaJFDAKkgpshIy4KuEE+3OrI7yOdoQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qt+pittmtOvhRelxPnzw2tvB3Bpokkpa4K1ICYKrW8AzYA5+0+fY9P+H5RZ/17FZ0VBezpr5H5WKv+ulCX2vLUTCRmybViVgylFYgUQxSjin6yhTUfyLCkH9ltZN4IdKMlg8EHbUjfnl9l9K7eZy4+l8lr2x1FdA2t70LoNhKSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=SSg0x9ie; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="SSg0x9ie"
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666FHMXk3568838;
	Mon, 6 Jul 2026 15:57:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=0BKF1C3IE
	6jZi/U5HMWjXUgvONmjodZpKBdFhgoirb0=; b=SSg0x9ieVu1o//DTUkc4CM/e5
	TOFhiQSP/jJOAN+JZVs5tC8r7dKKIYnCcAyJPe/k04PB3ugjBuQkU7YGE92hdDdO
	3nKvj6WKyJS75GbgaZHiV7vN/2TRD8u4olJSqPLDcRC9LNwjiX7q0nzkioxiWhgU
	O3ca76Py22/AU9LYy0uydh+O3YKsPpIYBj+1hd10og4tIm6gUutpEw5cR5fkW6Iy
	/klxuAym/H8fqpBdY8QY2vR9KzAIUKWJH8iYhTfeQDBs8KlaHMVSdt9CO9VmYJnb
	DM9Npfxkwx2MY8uzEKN8GeMrqam4U6nx3wncUoc67OF89ljMVcJULMl9I34yA==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4f6qcwam73-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 06 Jul 2026 15:57:47 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Mon, 6 Jul 2026 08:57:46 -0700
Received: from pek-yzhou-d3.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Mon, 6 Jul 2026 08:57:44 -0700
From: Yun Zhou <yun.zhou@windriver.com>
To: <josef@toxicpanda.com>, <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, <nbd@other.debian.org>,
        <linux-kernel@vger.kernel.org>, <yun.zhou@windriver.com>
Subject: [PATCH] nbd: reclassify socket lock in nbd_reconnect_socket
Date: Mon, 6 Jul 2026 23:57:44 +0800
Message-ID: <20260706155744.1399153-1-yun.zhou@windriver.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=D4537PRj c=1 sm=1 tr=0 ts=6a4bd07b cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=klDOsUkWDRETUCZYPvoE:22 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8 a=t7CeM3EgAAAA:8
 a=U_4kNCBNHIan1B1hxH8A:9 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: ytdGydgsP-qHm6EvRQjibrzSZJg3lsvw
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE2MiBTYWx0ZWRfXxhcZ9QQhNVV5
 WmZJECatQbxlK5KVszuduIjKveeZfyhLwfDsHUVIkD5vZlUiLr8vQrPCbtB3DV5jQsh5ncI3U15
 YuMhqWjfNaIootDiGvJBJXI3mJAW/m0Vj+jbfcRTSsAb8R/SX/UJ
X-Proofpoint-GUID: ytdGydgsP-qHm6EvRQjibrzSZJg3lsvw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE2MiBTYWx0ZWRfX5TJkzUMiRPOW
 9PNt0sXCSkTpkuJ5smjbIu9oObIhSEYKyEL4iEmN135Z7QCcRyoQby9WkCS6/f6kTnmoKR/3aor
 Qv+zC+cq9uwowbTHyIA2rJ6ni7rAY47z0M1ffvV11l5rD+RyCkA8zIvW7f+3MoNMUPhKTUrhy6E
 sEAKzDDx4MAwrcenMoMYni07lUYG2Ec1smAtctfUqZm9fwfsU/1FPzV8aGLlXrY1NuBSax76UOP
 7cm4SI4R6vmkD29tPQfesagX5ByjyeTkCuzWXTM69IDm8piNztvso5ir3K9H9RynZ92qu0PQ7gI
 w59J8VoywI5TmqrDDe92y9JPrVw1bxpbSqV6GPKb1+7tVR0eVLMLi4hOZJnjre3+E3QuF0WtaUT
 yKVRJI9tpEmqsmz6kqycbSQzNEVc/qBr2IBTtRPPBRE0ixYXFvcUaJO9G5zcEuh52nL5mOG3cya
 r09unRsg66cozY93V7g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060162

nbd_reconnect_socket() obtains a new socket via nbd_get_socket() but
does not call nbd_reclassify_socket(), leaving the socket's sk_lock in
the default AF_INET6 lockdep class.  This causes false circular lock
dependency warnings because lockdep merges the NBD socket's sk_lock
with unrelated sockets (e.g., rawv6_sendmsg) that establish a
sk_lock -> fs_reclaim dependency in normal operation.

nbd_add_socket() already reclassifies correctly on the initial connect
path, but the reconnect path was missed.

Add the missing nbd_reclassify_socket() call after nbd_get_socket() in
nbd_reconnect_socket().

Reported-by: syzbot+576095eed5658cbd9b63@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=576095eed5658cbd9b63
Fixes: d532cddb6c60 ("nbd: Reclassify sockets to avoid lockdep circular dependency")
Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
---
 drivers/block/nbd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 8c6028e71e83..70a04d541ea4 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1386,6 +1386,8 @@ static int nbd_reconnect_socket(struct nbd_device *nbd, unsigned long arg)
 	if (!sock)
 		return err;
 
+	nbd_reclassify_socket(sock);
+
 	args = kzalloc_obj(*args);
 	if (!args) {
 		sockfd_put(sock);
-- 
2.43.0

