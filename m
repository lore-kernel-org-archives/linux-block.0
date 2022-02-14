Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F330CC43217
	for <linux-block@archiver.kernel.org>; Mon, 14 Feb 2022 17:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357217AbiBNRom (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Feb 2022 12:44:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357220AbiBNRoj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Feb 2022 12:44:39 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3E165493
        for <linux-block@vger.kernel.org>; Mon, 14 Feb 2022 09:44:29 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21E6TxTs007087
        for <linux-block@vger.kernel.org>; Mon, 14 Feb 2022 09:44:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=NyHGbvRDPUnqdpOE6VaZfsgtyNPgunO2oZLXVjCcuJk=;
 b=LXKE5cZOW1sSeGRTkXphI9MF6ttdrSHbLt6EkJHPda1//FOL2GHqe4pss9zowQij0p8P
 aNhNxXwujFs0OMMiHs54VnMHV1qTxX8+aN9qcvKiggPgc3s0a0ziGccTh/4FD+vS6tNe
 phNG8EcKyXQkyaQkXjc0DtCafMZI8SJsR6U= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e7hv53hx9-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Mon, 14 Feb 2022 09:44:29 -0800
Received: from twshared7634.08.ash8.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 14 Feb 2022 09:44:25 -0800
Received: by devvm225.atn0.facebook.com (Postfix, from userid 425415)
        id BACDEABBD103; Mon, 14 Feb 2022 09:44:09 -0800 (PST)
From:   Stefan Roesch <shr@fb.com>
To:     <io-uring@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-block@vger.kernel.org>, <kernel-team@fb.com>
CC:     <shr@fb.com>
Subject: [PATCH v1 08/14] fs: add support for async buffered writes
Date:   Mon, 14 Feb 2022 09:43:57 -0800
Message-ID: <20220214174403.4147994-9-shr@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220214174403.4147994-1-shr@fb.com>
References: <20220214174403.4147994-1-shr@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: pR4wyYhVXEugnDCfjxb_iI-eJerYeheY
X-Proofpoint-GUID: pR4wyYhVXEugnDCfjxb_iI-eJerYeheY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-14_07,2022-02-14_03,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 mlxscore=0
 mlxlogscore=837 priorityscore=1501 malwarescore=0 phishscore=0
 clxscore=1015 adultscore=0 impostorscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202140105
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This adds support for the AOP_FLAGS_BUF_WASYNC flag to the fs layer. If
a page that is required for writing is not in the page cache, it returns
EAGAIN instead of ENOMEM.

Signed-off-by: Stefan Roesch <shr@fb.com>
---
 fs/buffer.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 5e3067173580..140f57c1cbdd 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2069,6 +2069,10 @@ int __block_write_begin_int(struct folio *folio, l=
off_t pos, unsigned len,
 			*wait_bh++=3Dbh;
 		}
 	}
+
+	/* No wait specified, don't wait for reads to complete. */
+	if (!err && wait_bh > wait && (flags & AOP_FLAGS_NOWAIT))
+		return -EAGAIN;
 	/*
 	 * If we issued read requests - let them complete.
 	 */
@@ -2143,8 +2147,11 @@ int block_write_begin(struct address_space *mappin=
g, loff_t pos, unsigned len,
 	int status;
=20
 	page =3D grab_cache_page_write_begin(mapping, index, flags);
-	if (!page)
+	if (!page) {
+		if (flags & AOP_FLAGS_NOWAIT)
+			return -EAGAIN;
 		return -ENOMEM;
+	}
=20
 	status =3D __block_write_begin_int(page_folio(page), pos, len, get_bloc=
k, NULL, flags);
 	if (unlikely(status)) {
--=20
2.30.2

