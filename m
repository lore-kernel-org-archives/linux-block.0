Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08BCFC27C47
	for <linux-block@archiver.kernel.org>; Fri, 27 Oct 2023 18:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbjJ0SUM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Oct 2023 14:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbjJ0SUL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Oct 2023 14:20:11 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1203318A
        for <linux-block@vger.kernel.org>; Fri, 27 Oct 2023 11:20:10 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39RE5mP8006170
        for <linux-block@vger.kernel.org>; Fri, 27 Oct 2023 11:20:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=jAGKyWeA8QTcQMk/vfy8VOIt2qAQYrVxiznwPWy89lU=;
 b=muaMpsn5JwFC8QzqI6QwjpDHnwsPDP3VcazR0bJrhYgTvVu/Y4KL3B4u5y9Np88Xzo55
 VFpcmtq5RKRGhn1kA3RIjd7yOF9lPqxN2ckEB5YH++RXDxG6LtUFggYfyCQkZZJtyYW7
 T4IXiL2H64qdPfENsG96qWNc9I1UNtfjvtkcF3ObyKoz5LtyKN5XqbzuSbEUKs8ge0Oc
 WqcteQj1S72NijhUQpyx2hFTjtZZ5jl6U/EJyX3HtflLrigEBvCNKyfFphkO9PDGGBRo
 QJu+ewZG4Pgq1SUtKblUchWwPjVEyUe/KhDwrTIsNgXvVu5xS1SVFKnfNHWjZIkCZMRD Cw== 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3tywry0fu4-17
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Fri, 27 Oct 2023 11:20:09 -0700
Received: from twshared10830.02.ash9.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 11:19:59 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id 6F25520D093C6; Fri, 27 Oct 2023 11:19:50 -0700 (PDT)
From:   Keith Busch <kbusch@meta.com>
To:     <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <io-uring@vger.kernel.org>
CC:     <axboe@kernel.dk>, <hch@lst.de>, <joshi.k@samsung.com>,
        <martin.petersen@oracle.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 3/4] iouring: remove IORING_URING_CMD_POLLED
Date:   Fri, 27 Oct 2023 11:19:28 -0700
Message-ID: <20231027181929.2589937-4-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027181929.2589937-1-kbusch@meta.com>
References: <20231027181929.2589937-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: R4nHpHdHSOOJSKz8BEeZ-Fjx_XRMekad
X-Proofpoint-GUID: R4nHpHdHSOOJSKz8BEeZ-Fjx_XRMekad
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_17,2023-10-27_01,2023-05-22_02
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

No more users of this flag.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 include/linux/io_uring.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/io_uring.h b/include/linux/io_uring.h
index aefb73eeeebff..fe23bf88f86fa 100644
--- a/include/linux/io_uring.h
+++ b/include/linux/io_uring.h
@@ -28,7 +28,6 @@ enum io_uring_cmd_flags {
=20
 /* only top 8 bits of sqe->uring_cmd_flags for kernel internal use */
 #define IORING_URING_CMD_CANCELABLE	(1U << 30)
-#define IORING_URING_CMD_POLLED		(1U << 31)
=20
 struct io_uring_cmd {
 	struct file	*file;
--=20
2.34.1

