Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B00267B6F;
	Mon, 28 Apr 2025 14:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745851001; cv=none; b=FbMrxAnrko59yshJz1CCNtplN+fYwkMjD5GuikBiRXhLwf2t1GwE5k94H/CWKBHnCskHC8gBJifn4WGUm4MvYBtMprnfO4CRZJd3EGksBl2ztHNZTIlMMdcQnLsGS+0pzQidQwU133SiNcNBSK5H9pkGMNGMVs4S51jabMAN77c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745851001; c=relaxed/simple;
	bh=eRJ32s+d626xp2LcU1QZZ530a+v5i3bNHCiXe1GEmKs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DE4L0KOlvBtDFFrvxjlFSKM8qlJLVvl77TKXRBARDK+UTs06xJGyjB7GvztrpXjN7hN0DGtDRVzHEkLRBg0pbLnmpdfaM6yOfqMT6Ar3zpNifSK0XW34n62HgiXgXeDyh2CgCjHC6RgipMZS7Su8uq5x13IE6OyYYdbTfDYgdB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53SACpON002698;
	Mon, 28 Apr 2025 07:36:30 -0700
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 468ts3rsdk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 28 Apr 2025 07:36:30 -0700 (PDT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Mon, 28 Apr 2025 07:36:29 -0700
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Mon, 28 Apr 2025 07:36:27 -0700
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <hch@infradead.org>
CC: <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lizhi.xu@windriver.com>,
        <ming.lei@redhat.com>,
        <syzbot+6af973a3b8dfd2faefdc@syzkaller.appspotmail.com>,
        <syzkaller-bugs@googlegroups.com>
Subject: [PATCH V5] loop: Add sanity check for read/write_iter
Date: Mon, 28 Apr 2025 22:36:26 +0800
Message-ID: <20250428143626.3318717-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aA-QB7Iu6u9PdgHg@infradead.org>
References: <aA-QB7Iu6u9PdgHg@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI4MDEyMCBTYWx0ZWRfX9dfyde8x5nki CY3ZLvWuxLdj42OarYcNSYKdCy+NS187KP2vG9hOaoxfMCoY5z7GTUKg8Wc8nxmdemvxSBKRM3B sIvGbEaO0pISMGe1qflhX6qXVqbvxFj/4atiMR5lYDabhydQ3LNjrFjHN6/AZSCFcCZtN7cbxW/
 OhMlddX7ihQ3cyojEyV+SaexS1oYz2RyI7Yv3EKNJR6x946u1naeMivw9v8dNmKmB0aoo7SyzGV 3UrsGWRNfDm6KQme3d/rHFFFPSzeRZ6WIM3wARvUgXjuJwINJ0L2RZa6w8w40TlCfntEgbYCWmf DfAxBhOtgWF0K0Q7PvryxrckwrG+qqG5tDArdPql22/LJMxZJGSXnY3b2/hsHq6fFc7x3jW2Cmp
 BrMEE9qqQpFhpa6eFF0m1/Mn4bi0ZJ5Qw3Wy/GF1s8jWbHzE3gkFalzbjDGOnvOR3W276HWD
X-Proofpoint-GUID: 9VEYUVOuDzyBhUEUgr43TLOVLILbv1xt
X-Proofpoint-ORIG-GUID: 9VEYUVOuDzyBhUEUgr43TLOVLILbv1xt
X-Authority-Analysis: v=2.4 cv=YJifyQGx c=1 sm=1 tr=0 ts=680f926e cx=c_pps a=/ZJR302f846pc/tyiSlYyQ==:117 a=/ZJR302f846pc/tyiSlYyQ==:17 a=XR8D0OoHHMoA:10 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8 a=t7CeM3EgAAAA:8 a=rNDPuYlyMNBSQ_icSEMA:9 a=DcSpbTIhAlouE1Uv7lRv:22
 a=cQPPKAXgyycSBL8etih5:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_05,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1015
 suspectscore=0 mlxlogscore=988 mlxscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.21.0-2504070000 definitions=main-2504280120

Some file systems do not support read_iter/write_iter, such as selinuxfs
in this issue.
So before calling them, first confirm that the interface is supported and
then call it.

It is releavant in that vfs_iter_read/write have the check, and removal
of their used caused szybot to be able to hit this issue.

Fixes: f2fed441c69b ("loop: stop using vfs_iter__{read,write} for buffered I/O")
Reported-by: syzbot+6af973a3b8dfd2faefdc@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=6af973a3b8dfd2faefdc
Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
V1 -> V2: move check to loop_configure and loop_change_fd
V2 -> V3: using helper for this check
V3 -> V4: remove input parameters change and mode
V4 -> V5: remove braces around !file->f_op->write_iter

 drivers/block/loop.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 46cba261075f..655d33e63cb9 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -505,6 +505,17 @@ static void loop_assign_backing_file(struct loop_device *lo, struct file *file)
 	lo->lo_min_dio_size = loop_query_min_dio_size(lo);
 }
 
+static int loop_check_backing_file(struct file *file)
+{
+	if (!file->f_op->read_iter)
+		return -EINVAL;
+
+	if ((file->f_mode & FMODE_WRITE) && !file->f_op->write_iter)
+		return -EINVAL;
+
+	return 0;
+}
+
 /*
  * loop_change_fd switched the backing store of a loopback device to
  * a new file. This is useful for operating system installers to free up
@@ -526,6 +537,10 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 	if (!file)
 		return -EBADF;
 
+	error = loop_check_backing_file(file);
+	if (error)
+		return error;
+
 	/* suppress uevents while reconfiguring the device */
 	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 1);
 
@@ -963,6 +978,14 @@ static int loop_configure(struct loop_device *lo, blk_mode_t mode,
 
 	if (!file)
 		return -EBADF;
+
+	if ((mode & BLK_OPEN_WRITE) && !file->f_op->write_iter)
+		return -EINVAL;
+
+	error = loop_check_backing_file(file);
+	if (error)
+		return error;
+
 	is_loop = is_loop_device(file);
 
 	/* This is safe, since we have a reference from open(). */
-- 
2.43.0

