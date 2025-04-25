Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04F8187332;
	Fri, 25 Apr 2025 03:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745552466; cv=none; b=nO/gLtZYCXJLqnykLyphdLMAIMoRfsEX8blWdS+1RX5cbp8xiWIAqgvrCH7oz9Bk02sNlCU4fP4ytXNKywhpGlqZ5/WLVpWcd+ZYK2xeY5mxgfR35PC/AyNpS7lT+fDzY0TY1VhF9/ZjE6l65VEYZOC8pGE1bnKGxQPQpu9C/98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745552466; c=relaxed/simple;
	bh=wPvyuyfU1DAjAWhrRG/W1tcYDV8l4b+Yl+1azMhL93k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sYrTk/pfwd/u3euZGm8oTiIOUmOkz6iP3Ibf0BOLuP8zCR1HyQYKvjKHbS2vufIHGEWmeOW5bVAHaGcRQ93TJQpfKpVV16qFIpybd+PVYGlzgwiyhaBk21Gnad4zNsVv4rAQ6z6JyfkbEAcgynxs7hurgTKxSgGQQ7nisU0Ba6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53P33LLm029783;
	Thu, 24 Apr 2025 20:41:00 -0700
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 466jhd384p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 24 Apr 2025 20:41:00 -0700 (PDT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Thu, 24 Apr 2025 20:40:59 -0700
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Thu, 24 Apr 2025 20:40:57 -0700
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <syzbot+6af973a3b8dfd2faefdc@syzkaller.appspotmail.com>
CC: <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <syzkaller-bugs@googlegroups.com>
Subject: [PATCH] loop: Add sanity check for read/write_iter
Date: Fri, 25 Apr 2025 11:40:57 +0800
Message-ID: <20250425034057.3133195-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <680a45db.050a0220.10d98e.000a.GAE@google.com>
References: <680a45db.050a0220.10d98e.000a.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=ZNDXmW7b c=1 sm=1 tr=0 ts=680b044c cx=c_pps a=K4BcnWQioVPsTJd46EJO2w==:117 a=K4BcnWQioVPsTJd46EJO2w==:17 a=XR8D0OoHHMoA:10 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8 a=t7CeM3EgAAAA:8 a=5yON4tJlvpFzjYmBgeMA:9 a=DcSpbTIhAlouE1Uv7lRv:22
 a=cQPPKAXgyycSBL8etih5:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: lqNWFcyHey-Bm6QNdnYGMW3-o9h4qBYy
X-Proofpoint-GUID: lqNWFcyHey-Bm6QNdnYGMW3-o9h4qBYy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDAyNCBTYWx0ZWRfX7V26i8R6fC+b DFQHxqIDwy3XF8AlzTzA+TbNH+WWJ14inoiE2zBjce3R9em5gHWOCmnAIlBPhsDWnpMgtWaASeP cgJMZOx38Gku7zMr0jukIZW7BXoP/Q6Afw3eIAbO7q5avshA+/o0qwVtJc0WxiIjqWBnrRkWp34
 4WTVOfxjTO3hlaxHLXoaSZBHiy3mubV/c15qEM4baziqeknKTRfXb3K423lmnR/CEVvHVpttXAh kecvMVstrmq7WvH2g/BcxvFgjU8X7H0utMGWHDGzSck+krI8+wd/BjTZeYzsCioYnNYCVUYSuNL IknxDUudOG2IozPKH8EC4Jez83rjK4Zyy5k9FWcgiYt1jLydwApUlcZt1/GSxZQxpPE5gmn7LlM
 JUYadnABwQd1w4An56dFfeWdfSny9qmAXxWYAjgbgh2hkAi6yAja+shDoGVhQZ/zn5Qun3an
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_01,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1011 adultscore=0 spamscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=893 mlxscore=0 suspectscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.21.0-2504070000
 definitions=main-2504250024

Some file systems do not support read_iter or write_iter, such as selinuxfs
in this issue.
So before calling them, first confirm that the interface is supported and
then call it.

Reported-by: syzbot+6af973a3b8dfd2faefdc@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=6af973a3b8dfd2faefdc
Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
---
 drivers/block/loop.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 674527d770dc..4f968e3071ed 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -449,10 +449,15 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 	cmd->iocb.ki_flags = IOCB_DIRECT;
 	cmd->iocb.ki_ioprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_NONE, 0);
 
-	if (rw == ITER_SOURCE)
-		ret = file->f_op->write_iter(&cmd->iocb, &iter);
-	else
-		ret = file->f_op->read_iter(&cmd->iocb, &iter);
+	ret = 0;
+	if (rw == ITER_SOURCE) {
+		if (likely(file->f_op->write_iter))
+			ret = file->f_op->write_iter(&cmd->iocb, &iter);
+	}
+	else {
+		if (likely(file->f_op->read_iter))
+			ret = file->f_op->read_iter(&cmd->iocb, &iter);
+	}
 
 	lo_rw_aio_do_completion(cmd);
 
-- 
2.43.0

