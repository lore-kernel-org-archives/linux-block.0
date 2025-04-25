Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862EB22A1C0;
	Fri, 25 Apr 2025 05:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745559494; cv=none; b=gVutvOo+JlZF9VuqG0NVJJXx2BbiTtW+A4u5XzKAqAjj7rJ2eBz90PSayC3JJx0DgJXz4XKxqCtFQy9AMeOOtEXj0pz+pgsEj1sfi4syPq+a5god6sbEWa3iQ3WgEwGGTNHwAOUbcjzuj44R9BgSL4dkF0cTfBVwNTbzDyEKmjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745559494; c=relaxed/simple;
	bh=tCq1TMcBi/EJFu3yiehmqYHr+5YiokYp40hNMkdBeww=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jZbaA/s3knXMGLTvdmYQ+Hn2gzsgkX/JuvWjmKOhm1NWgrHXqioLoRKNHbPkFTvWC45mRA7rasSHm8nqswbmfCPcxKQbL/+4Kq9+XR1JllDvxCrdFZKUpjtKI/MOd7wZYNotOJfCq3RtYOkhvFqKo4tf/D8Xt+/wB6ErMST/VjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53P5QRW3011328;
	Thu, 24 Apr 2025 22:38:07 -0700
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 466jhd3ans-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 24 Apr 2025 22:38:07 -0700 (PDT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Thu, 24 Apr 2025 22:38:06 -0700
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Thu, 24 Apr 2025 22:38:04 -0700
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <ming.lei@redhat.com>
CC: <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lizhi.xu@windriver.com>,
        <syzbot+6af973a3b8dfd2faefdc@syzkaller.appspotmail.com>,
        <syzkaller-bugs@googlegroups.com>
Subject: [PATCH V2] loop: Add sanity check for read/write_iter
Date: Fri, 25 Apr 2025 13:38:03 +0800
Message-ID: <20250425053803.3614260-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAFj5m9LVuekp_n6pEfs17n6QB3Q0yu-qRP67NOJb9ZXRNyhP3Q@mail.gmail.com>
References: <CAFj5m9LVuekp_n6pEfs17n6QB3Q0yu-qRP67NOJb9ZXRNyhP3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=ZNDXmW7b c=1 sm=1 tr=0 ts=680b1fbf cx=c_pps a=K4BcnWQioVPsTJd46EJO2w==:117 a=K4BcnWQioVPsTJd46EJO2w==:17 a=XR8D0OoHHMoA:10 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8 a=t7CeM3EgAAAA:8 a=5yON4tJlvpFzjYmBgeMA:9 a=DcSpbTIhAlouE1Uv7lRv:22
 a=cQPPKAXgyycSBL8etih5:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: FpZcOjmb2kLse7D_SJIQHczlaX8wGweY
X-Proofpoint-GUID: FpZcOjmb2kLse7D_SJIQHczlaX8wGweY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDAzOSBTYWx0ZWRfXx59o8i9e5iwR jEVbskttJzNY5b0KoXfMX9pCsi4thmrMg0SS0Pp4AfRXzm/XtAf7v7SbxveekH591b/oatynPW0 X8YDguDzrqkmvcVDU9wIl9zRHgsGq+Z6crIMJ80shEEjq3jKwEn3I9rSvgxY06+ddtYvL1fZnE+
 k0+Lb1CQvbttRoy+WQH1gUV6p9+0u/pd0PYJlk0eCBbWyKDeIxECSkbZyp/AP2IFR7dAms+81cn zFTmfTQ5eocc9HifGawFvvSo3wNm4zlhYbKbr0m0D5kMCsVXpr7pwlDVBdnQCLMU5DpXOUhYret 6WHABOUB8Oj/vxZUEIaPFlWFlGbV7eq7qnlmzohFmQgm34pn6pT1OIa4RzMVXYpSHZH/QXRn8It
 8x2yiHx2KnniZ664zc/x39xGkeMFjg6MB5TAbWwEgy/NnU15YH6PUe84lnLSiXVCn/UMBxTN
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_01,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 spamscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=932 mlxscore=0 suspectscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.21.0-2504070000
 definitions=main-2504250039

Some file systems do not support read_iter or write_iter, such as selinuxfs
in this issue.
So before calling them, first confirm that the interface is supported and
then call it.

Reported-by: syzbot+6af973a3b8dfd2faefdc@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=6af973a3b8dfd2faefdc
Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
---
V1 -> V2: move check to loop_configure and loop_change_fd

 drivers/block/loop.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 674527d770dc..d2651e3b5142 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -603,6 +603,12 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 	if (!file)
 		return -EBADF;
 
+	if (unlikely(!file->f_op->read_iter))
+		return -EINVAL;
+
+	if (file->f_mode & FMODE_WRITE && unlikely(!file->f_op->write_iter))
+		return -EINVAL;
+
 	/* suppress uevents while reconfiguring the device */
 	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 1);
 
@@ -1039,6 +1045,14 @@ static int loop_configure(struct loop_device *lo, blk_mode_t mode,
 
 	if (!file)
 		return -EBADF;
+
+	if (unlikely(!file->f_op->read_iter))
+		return -EINVAL;
+
+	if (((file->f_mode & FMODE_WRITE) || (mode & BLK_OPEN_WRITE)) &&
+	    unlikely(!file->f_op->write_iter))
+		return -EINVAL;
+
 	is_loop = is_loop_device(file);
 
 	/* This is safe, since we have a reference from open(). */
-- 
2.43.0

