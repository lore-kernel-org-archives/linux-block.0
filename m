Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3DB2F39CE;
	Mon,  1 Jun 2026 19:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780340721; cv=none; b=h6nu8yw90IHwaMHT8EwezgVj3BdvTDVn0fzCBB8cTzpCbvYRS++bfRDvNsikTMUeUZwIx9DlOf/NkJ/nE60PxjOryTx63aSHEyTC1UqLx79AYlqtyesMR29mCAQNERks1Hd5rqcPo5BecgS9QrpdM3mEqDudeGjqpcIuZRbJk00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780340721; c=relaxed/simple;
	bh=BgDWW1g7rNywB4H6AACTNNWqVGslzNiqnPqXuTucn7M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QCFYJiFN5d0fCl/qoYjj8n/HHIuRbNG8z0RvILjNSb1LJZ7CKD9CxNlunV2hukW1BgzpyHMwrjOQZX0jTb0wvUE8ndEYu6AKe1LV9zRUCyjL9Pnbw760H/shdnUO2UqH1WAYm7X3IHaU1HbaSfPvfj6d47a1oxdE+7cENzhnyGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=fail smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=qweCHwW6; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="qweCHwW6"
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 651HpCAU3980382;
	Mon, 1 Jun 2026 11:55:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=vKsCj21f0
	6MKhuieakW4HkJcvnqBsIueXfH2RskP7zQ=; b=qweCHwW6Sf/0c+DXISdTmPhHL
	7J6qr2WY7W+gbMN/kdurEItbBVhFvaURehNh7pb5TQeoqK1ks0Tufn/BWKBCzxSl
	Qb5AhJmZATu7+Ho6pVYByRTnaBCa5iXLPA/gW7PkRqQR7R7zbiB510iZ/AYIsVHi
	Af12hGR6Jfwg9gu2VvxF2NQe2VEzDIK82NYKfBN7lMBlRm3liYBfsoWGNpsoFDBn
	KqpEnl2O8DV5sg05brqq/0nj7+cK3f5p2g21+MA4rXktnbRP5ah+3Ge3w73dHahc
	zKxqiPp7ZJ3+61kzMyAM5AsjRc15D6SlhWb6+hWQxp0kUyE0ayQ66VK9d2epw==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4efydeb73x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 01 Jun 2026 11:55:48 -0700 (PDT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Mon, 1 Jun 2026 11:55:46 -0700
Received: from c38b02c5ee49.wrs.com (10.11.232.110) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Mon, 1 Jun 2026 11:55:45 -0700
From: Yun Zhou <yun.zhou@windriver.com>
To: <tom.leiming@gmail.com>, <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yun.zhou@windriver.com>
Subject: [PATCH] ublk: fix null-ptr-deref in ublk_queue_cmd
Date: Tue, 2 Jun 2026 02:55:43 +0800
Message-ID: <20260601185544.1180263-1-yun.zhou@windriver.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDE4NiBTYWx0ZWRfX9S/ZkuiZtfi0
 RNN8V1ABwUHGGkwj57T6lPcTjd/hf3aPchdGlx2gPBwD9JrATh27QjlHzgF2NERvRXS04X7WSQO
 7pdpyDgSr8aXKIOHXl5jrpq4QCLu6rXod0Fx7HCosPhWTn16z8fTTy8y8r3Dzf3F4jkUx/bioDV
 fitoLLgOnghM1FKstE74Oo+TjbUbHMaGYPEOyZZWdx/GwAJB//sb/eSlU06BBO8nuuvhjrx33Rx
 75SXHdheG0+OwqfwXY2L8EAdbmzfweTn3TngRVXa+tFMWv9bNDyGWvQ8sZE9pQiKv5IYMqZ53W3
 5SLzVDmtN+dYbNREN2qMcoLWhW15Qq+l7fK80QrDofdDmhuT+daLYwjo0of3auYG+6OwpEGehy/
 oDqRpUBGzcmfpvZgbS+qKm5a0AQd6AEp4fPaPyRlFKmrWT6x+DfwoHHggb46qG5enFcgRLdxo84
 mJO6rPTQh7JTyah+/0Q==
X-Proofpoint-GUID: TSUX0mV6r5MkXFqM7vozdV-KFP2b_MTm
X-Authority-Analysis: v=2.4 cv=Iq0utr/g c=1 sm=1 tr=0 ts=6a1dd5b4 cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=iKiJcTA2PjBS6x5JeXcw:22 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8 a=t7CeM3EgAAAA:8
 a=nFqGxSASerJtwWmRO4wA:9 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: TSUX0mV6r5MkXFqM7vozdV-KFP2b_MTm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 priorityscore=1501 clxscore=1011
 malwarescore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010186

ublk_queue_cmd() dereferences ios[tag].cmd without NULL check. The cmd
pointer can be NULL when ublk_cancel_cmd() races with IO dispatch during
server teardown:

  CPU0 (partition scan work)        CPU1 (io_uring cancel callback)
  ublk_queue_rq()
    ublk_prep_req() -> OK
    check canceling -> false
                                    ublk_start_cancel()
                                      quiesce, set canceling, unquiesce
                                    ublk_cancel_cmd()
                                      io->cmd = NULL
    ublk_queue_cmd()
      cmd = ios[tag].cmd  -> NULL
      ublk_get_uring_cmd_pdu(cmd) -> null-ptr-deref

The race window exists because ublk_cancel_cmd() can execute between the
canceling flag check and the cmd dereference in ublk_queue_cmd(). This
cannot be closed with simple synchronization since blk_mq_quiesce_queue
only waits for in-flight dispatches, not requests already past the
canceling check.

Fix by checking cmd for NULL before dereferencing. When NULL, abort the
request via __ublk_abort_rq() which handles both recovery (requeue) and
non-recovery (end with IOERR) cases.

Fixes: 71f28f3136af ("ublk_drv: add io_uring based userspace block driver")
Reported-by: syzbot+415b9ec753cd2a196087@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=415b9ec753cd2a196087
Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
---
 drivers/block/ublk_drv.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 6c041eaebdb9..656e0d4e92bb 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2090,8 +2090,14 @@ static void ublk_batch_queue_cmd(struct ublk_queue *ubq, struct request *rq, boo
 static void ublk_queue_cmd(struct ublk_queue *ubq, struct request *rq)
 {
 	struct io_uring_cmd *cmd = ubq->ios[rq->tag].cmd;
-	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
+	struct ublk_uring_cmd_pdu *pdu;
+
+	if (unlikely(!cmd)) {
+		__ublk_abort_rq(ubq, rq);
+		return;
+	}
 
+	pdu = ublk_get_uring_cmd_pdu(cmd);
 	pdu->req = rq;
 	io_uring_cmd_complete_in_task(cmd, ublk_cmd_tw_cb);
 }
-- 
2.43.0

