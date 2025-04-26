Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFA310F9;
	Sat, 26 Apr 2025 02:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745633476; cv=none; b=VrinoPohedvQmi7k4AikrqgNoFMcKRCP35m5LUfsKzOKkkVkANAXFwgg7Sfl0zJmShTiaf1i6i607zz7/hZQmbbwSTnfGaiAn58O7MIcDgiB+2OYkwcmEEZ65joq5Inr+hC0vmi5/DqGJTpKBkCTfRhhAwTtjN/lVzAkSXzbYxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745633476; c=relaxed/simple;
	bh=Jw7F1D6YkLAty219ZY+jebJe6PoKEARc/QsYTfjiD00=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ttEk57CLxwf7TII+PcAEnWUKgko4lEAZq/gRikCpItu0EAsXgNX6jXLGo4gJ5fMF1CZKvDZaHANoVTcCN/UBXX8NwILOctkNB+7eW90PLdpaUkGHzaDpLuXEfxHodj1QMGmR5oRBGhlEdi30b+y9k1/tpnS7XfupzWfIuo37SG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53Q2AT5i029409;
	Fri, 25 Apr 2025 19:11:00 -0700
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 466jhd4c3q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 25 Apr 2025 19:10:59 -0700 (PDT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Fri, 25 Apr 2025 19:10:58 -0700
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Fri, 25 Apr 2025 19:10:56 -0700
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <hch@infradead.org>
CC: <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lizhi.xu@windriver.com>,
        <ming.lei@redhat.com>,
        <syzbot+6af973a3b8dfd2faefdc@syzkaller.appspotmail.com>,
        <syzkaller-bugs@googlegroups.com>
Subject: [PATCH V3] loop: Add sanity check for read/write_iter
Date: Sat, 26 Apr 2025 10:10:55 +0800
Message-ID: <20250426021055.312912-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aAuOC8djgRrq-Gdj@infradead.org>
References: <aAuOC8djgRrq-Gdj@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=ZNDXmW7b c=1 sm=1 tr=0 ts=680c40b3 cx=c_pps a=K4BcnWQioVPsTJd46EJO2w==:117 a=K4BcnWQioVPsTJd46EJO2w==:17 a=XR8D0OoHHMoA:10 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8 a=t7CeM3EgAAAA:8 a=LV0KdC98gc1ixML1xO8A:9 a=DcSpbTIhAlouE1Uv7lRv:22
 a=cQPPKAXgyycSBL8etih5:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: Z6NCK6Faewv0NcLTu7p9XuCbvFHNivMq
X-Proofpoint-GUID: Z6NCK6Faewv0NcLTu7p9XuCbvFHNivMq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI2MDAxNCBTYWx0ZWRfX36t69HVb4iNb 9OGoam/8PVy0YAbU9RbN5ikQFtWiv9eMuDcBpD3Wqrw+NUiMr+97FfLXK+MJtju9the5iAiY1xF J9VcXPlL6UmehvZtK1Nz8jNCEswCofNvsKbRJ4a9XdX700PANxrJ5+LJfyM9kVWn1BgHLd1f8aC
 yGDQhLr3sa9oqcNqUfF9buapoWqLspHNqxR4Tz8g78BXH+urHI7Fkbgay2jMIQ6Ab0htQtKg0me gHlI8TtlKkkn9WKlBRq3tr/cRVR1J9LMJSh6zQrShc6y6RNwTt/yWWWtuLJx/orgDof0CwqVPFT ts6x7eHjeZ7xKwsDP2fTDAac89n391xoaWGNoB/7ZsbD6rHZ7GAZekyxURrdutVoVUtTtbDiCg2
 Glg6lDbWUCucYRBmR7RLqlMWkmA9RqYaUkDyzq+90tECP3hwUEB/wF3Zibc3DrxplP0J2gij
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_07,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 spamscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=943 mlxscore=0 suspectscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.21.0-2504070000
 definitions=main-2504260014

Some file systems do not support read_iter/write_iter, such as selinuxfs
in this issue.
So before calling them, first confirm that the interface is supported and
then call it.

Fixes: f2fed441c69b ("loop: stop using vfs_iter__{read,write} for buffered I/O")
Reported-by: syzbot+6af973a3b8dfd2faefdc@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=6af973a3b8dfd2faefdc
Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
---
V1 -> V2: move check to loop_configure and loop_change_fd
V2 -> V3: using helper for this check

 drivers/block/loop.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 674527d770dc..7b78ddf7b819 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -582,6 +582,19 @@ static void loop_assign_backing_file(struct loop_device *lo, struct file *file)
 	lo->lo_min_dio_size = loop_query_min_dio_size(lo);
 }
 
+static int loop_check_backing_file(struct file *file, blk_mode_t mode, bool change)
+{
+	if (!file->f_op->read_iter)
+		return -EINVAL;
+
+	if (((file->f_mode & FMODE_WRITE) ||
+	     (!change && (mode & BLK_OPEN_WRITE))) &&
+	    (!file->f_op->write_iter))
+		return -EINVAL;
+
+	return 0;
+}
+
 /*
  * loop_change_fd switched the backing store of a loopback device to
  * a new file. This is useful for operating system installers to free up
@@ -603,6 +616,10 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 	if (!file)
 		return -EBADF;
 
+	error = loop_check_backing_file(file, 0, true);
+	if (error)
+		return error;
+
 	/* suppress uevents while reconfiguring the device */
 	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 1);
 
@@ -1039,6 +1056,11 @@ static int loop_configure(struct loop_device *lo, blk_mode_t mode,
 
 	if (!file)
 		return -EBADF;
+
+	error = loop_check_backing_file(file, mode, false);
+	if (error)
+		return error;
+
 	is_loop = is_loop_device(file);
 
 	/* This is safe, since we have a reference from open(). */
-- 
2.43.0

