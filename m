Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64A1C35275
	for <linux-block@archiver.kernel.org>; Fri, 18 Feb 2022 19:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238664AbiBRT61 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Feb 2022 14:58:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238654AbiBRT6W (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Feb 2022 14:58:22 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E63225592
        for <linux-block@vger.kernel.org>; Fri, 18 Feb 2022 11:58:05 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 21IB6C0f018136
        for <linux-block@vger.kernel.org>; Fri, 18 Feb 2022 11:58:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=jPeOECZX0sWUMx56391qkpkiGcCwlyU3M4gP+uk5hfo=;
 b=YUQZ3hMWy88HpcF/Q4wZgDMG8eUsRVvCILXIe6Wfqv0dhnSmyiIWPRhV9QhlzAzXd+9W
 WCJ/yFvXsIrwBRUO/PkvKScxEkJI06Z5fRtcvXUSKlbSsB9UwsyPBEIbXG5N/EdvtggW
 mlqfizaZpmvC2O1fjDMhBAEO5BnTdF5+bDc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net (PPS) with ESMTPS id 3e9e7xd4ss-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Fri, 18 Feb 2022 11:58:04 -0800
Received: from twshared7634.08.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 18 Feb 2022 11:58:02 -0800
Received: by devvm225.atn0.facebook.com (Postfix, from userid 425415)
        id 8FCFAAEB6601; Fri, 18 Feb 2022 11:57:50 -0800 (PST)
From:   Stefan Roesch <shr@fb.com>
To:     <io-uring@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-block@vger.kernel.org>, <kernel-team@fb.com>
CC:     <shr@fb.com>
Subject: [PATCH v2 02/13] mm: Introduce do_generic_perform_write
Date:   Fri, 18 Feb 2022 11:57:28 -0800
Message-ID: <20220218195739.585044-3-shr@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220218195739.585044-1-shr@fb.com>
References: <20220218195739.585044-1-shr@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: YUGff2qjxFd2kM8byX92HnPIieI1qqzF
X-Proofpoint-GUID: YUGff2qjxFd2kM8byX92HnPIieI1qqzF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-18_08,2022-02-18_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 malwarescore=0
 bulkscore=0 spamscore=0 mlxlogscore=754 priorityscore=1501 impostorscore=0
 mlxscore=0 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202180121
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This splits off the do generic_perform_write() function, so an
additional flags parameter can be specified. It uses the new flag
parameter to support async buffered writes.

Signed-off-by: Stefan Roesch <shr@fb.com>
---
 include/linux/fs.h |  1 +
 mm/filemap.c       | 20 +++++++++++++++-----
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index e2d892b201b0..b7dd5bd701c0 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -278,6 +278,7 @@ enum positive_aop_returns {
 #define AOP_FLAG_NOFS			0x0002 /* used by filesystem to direct
 						* helper code (eg buffer layer)
 						* to clear GFP_FS from alloc */
+#define AOP_FLAG_NOWAIT			0x0004 /* async nowait buffered writes */
=20
 /*
  * oh the beauties of C type declarations.
diff --git a/mm/filemap.c b/mm/filemap.c
index ad8c39d90bf9..5bd692a327d0 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3725,14 +3725,13 @@ generic_file_direct_write(struct kiocb *iocb, str=
uct iov_iter *from)
 }
 EXPORT_SYMBOL(generic_file_direct_write);
=20
-ssize_t generic_perform_write(struct file *file,
-				struct iov_iter *i, loff_t pos)
+static ssize_t do_generic_perform_write(struct file *file, struct iov_it=
er *i,
+					loff_t pos, int flags)
 {
 	struct address_space *mapping =3D file->f_mapping;
 	const struct address_space_operations *a_ops =3D mapping->a_ops;
 	long status =3D 0;
 	ssize_t written =3D 0;
-	unsigned int flags =3D 0;
=20
 	do {
 		struct page *page;
@@ -3801,6 +3800,12 @@ ssize_t generic_perform_write(struct file *file,
=20
 	return written ? written : status;
 }
+
+ssize_t generic_perform_write(struct file *file,
+				struct iov_iter *i, loff_t pos)
+{
+	return do_generic_perform_write(file, i, pos, 0);
+}
 EXPORT_SYMBOL(generic_perform_write);
=20
 /**
@@ -3832,6 +3837,10 @@ ssize_t __generic_file_write_iter(struct kiocb *io=
cb, struct iov_iter *from)
 	ssize_t		written =3D 0;
 	ssize_t		err;
 	ssize_t		status;
+	int		flags =3D 0;
+
+	if (iocb->ki_flags & IOCB_NOWAIT)
+		flags |=3D AOP_FLAG_NOWAIT;
=20
 	/* We can write back this queue in page reclaim */
 	current->backing_dev_info =3D inode_to_bdi(inode);
@@ -3857,7 +3866,8 @@ ssize_t __generic_file_write_iter(struct kiocb *ioc=
b, struct iov_iter *from)
 		if (written < 0 || !iov_iter_count(from) || IS_DAX(inode))
 			goto out;
=20
-		status =3D generic_perform_write(file, from, pos =3D iocb->ki_pos);
+		status =3D do_generic_perform_write(file, from, pos =3D iocb->ki_pos, =
flags);
+
 		/*
 		 * If generic_perform_write() returned a synchronous error
 		 * then we want to return the number of bytes which were
@@ -3889,7 +3899,7 @@ ssize_t __generic_file_write_iter(struct kiocb *ioc=
b, struct iov_iter *from)
 			 */
 		}
 	} else {
-		written =3D generic_perform_write(file, from, iocb->ki_pos);
+		written =3D do_generic_perform_write(file, from, iocb->ki_pos, flags);
 		if (likely(written > 0))
 			iocb->ki_pos +=3D written;
 	}
--=20
2.30.2

