Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 033B7C4332F
	for <linux-block@archiver.kernel.org>; Mon, 14 Nov 2022 18:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236334AbiKNSUF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Nov 2022 13:20:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236120AbiKNSUB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Nov 2022 13:20:01 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722DE252
        for <linux-block@vger.kernel.org>; Mon, 14 Nov 2022 10:20:00 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.5) with ESMTP id 2AEH5K4t005657
        for <linux-block@vger.kernel.org>; Mon, 14 Nov 2022 10:20:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=E4ef4u8dxXIoaQywGKWE+lnCHBO7RxCb5CWRxp9lxT4=;
 b=nQfp8TE7YPjIblXkzHayBU08jKRuOe3vPqJEU3blH5pnKHhd+Q+xY6SaqJqzDrfKwRoa
 UdNZKUrgB5Z/NUe7TyQujgpjVsrj8tqRWWHGQrQbMs7x9snWvArZ3f5gBoMn1ZNBuhNj
 wD9bdRLwmIme+lOXKYvflH1dwwEb6Z9k3GE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kupbjtyc9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Mon, 14 Nov 2022 10:19:59 -0800
Received: from twshared14438.02.ash8.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 14 Nov 2022 10:19:59 -0800
Received: by devbig003.nao1.facebook.com (Postfix, from userid 8731)
        id A2580C22ABEB; Mon, 14 Nov 2022 10:19:53 -0800 (PST)
From:   Chris Mason <clm@fb.com>
To:     <hch@infradead.org>, <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>, <tj@kernel.org>, <riel@surriel.com>,
        <hannes@cmpxchg.org>
Subject: [PATCH] blk-cgroup: properly pin the parent in blkcg_css_online
Date:   Mon, 14 Nov 2022 10:19:30 -0800
Message-ID: <20221114181930.2093706-1-clm@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: W2ko28UVdav3ZwqV2p8174QjPmVHIApP
X-Proofpoint-ORIG-GUID: W2ko28UVdav3ZwqV2p8174QjPmVHIApP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-14_13,2022-11-11_01,2022-06-22_01
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blkcg_css_online is supposed to pin the blkcg of the parent, but
397c9f46ee4d refactored things and along the way, changed it to pin the
css instead.  This results in extra pins, and we end up leaking blkcgs
and cgroups.

Fixes: 397c9f46ee4d ("blk-cgroup: move blkcg_{pin,unpin}_online out of li=
ne")
Signed-off-by: Chris Mason <clm@fb.com>
Spotted-by: Rik van Riel <riel@surriel.com>
Cc: <stable@vger.kernel.org> # v5.19+
---
 block/blk-cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 6a5c849ee061..ed761c62ad0a 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1213,7 +1213,7 @@ static int blkcg_css_online(struct cgroup_subsys_st=
ate *css)
 	 * parent so that offline always happens towards the root.
 	 */
 	if (parent)
-		blkcg_pin_online(css);
+		blkcg_pin_online(&parent->css);
 	return 0;
 }
=20
--=20
2.30.2

