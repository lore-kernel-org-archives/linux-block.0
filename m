Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D190AC38145
	for <linux-block@archiver.kernel.org>; Tue,  6 Sep 2022 23:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiIFXAj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Sep 2022 19:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiIFXAh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Sep 2022 19:00:37 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D87F7E03D
        for <linux-block@vger.kernel.org>; Tue,  6 Sep 2022 16:00:36 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286F3P1F018679
        for <linux-block@vger.kernel.org>; Tue, 6 Sep 2022 16:00:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=r2lQa3t1UMzc6JgvyfiufHyfCGfvROv2bUlwSj39Q00=;
 b=SzBFHb24yjtrKcVVXQo3c863iT0dNE5Wj+Ie/JuDqDwdd8lqubtioxM1qT2NZJ5eUUxv
 Cy2GzZ074q1QvjIQp/LzIEFftpWjOzL4FOLTyw5yAoHGwkN9dvdiRSflILK6Xt+vUwsI
 j/gIZ3IQhYLkc+yGKdgEOYpELJQrJFdgcf4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jc4eyt966-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Tue, 06 Sep 2022 16:00:35 -0700
Received: from twshared2273.16.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 6 Sep 2022 16:00:34 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id D836E84BC4B3; Tue,  6 Sep 2022 16:00:30 -0700 (PDT)
From:   Keith Busch <kbusch@fb.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC:     Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 1/2] sbitmap: check waitqueue_active prior to decrement
Date:   Tue, 6 Sep 2022 16:00:28 -0700
Message-ID: <20220906230029.1287526-2-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220906230029.1287526-1-kbusch@fb.com>
References: <20220906230029.1287526-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: K6k_nmFNzSRjLN8MvjjuVi2u12OQTCYY
X-Proofpoint-ORIG-GUID: K6k_nmFNzSRjLN8MvjjuVi2u12OQTCYY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

The bitmap wait state may have set an active count, but doesn't have an
active waiter due to racing with adding it. If that happens, the state's
wait_cnt will be set at the wrong value, and could prevent future wakes
until the atomic_dec wraps back to 0.

Check the waitqueue_active before decrementing so that we don't need to
account for fixing it up after.

Fixes: 040b83fcecfb8 ("sbitmap: fix possible io hung due to lost wakeup")
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 lib/sbitmap.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index a39b1a877366..ad0670b580d3 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -609,12 +609,16 @@ static bool __sbq_wake_up(struct sbitmap_queue *sbq=
)
 	if (!ws)
 		return false;
=20
+	if (!waitqueue_active(&ws->wait))
+		return true;
+
 	wait_cnt =3D atomic_dec_return(&ws->wait_cnt);
+
 	/*
 	 * For concurrent callers of this, callers should call this function
 	 * again to wakeup a new batch on a different 'ws'.
 	 */
-	if (wait_cnt < 0 || !waitqueue_active(&ws->wait))
+	if (wait_cnt < 0)
 		return true;
=20
 	if (wait_cnt > 0)
--=20
2.30.2

