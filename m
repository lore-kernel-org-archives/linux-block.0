Return-Path: <SRS0=RPGG=PR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D5CC43444
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 15:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7A352070B
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 15:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="aiLv0fyH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731483AbfAIPdg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Jan 2019 10:33:36 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:11916 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730795AbfAIPdg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Jan 2019 10:33:36 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190109153333epoutp0374cee62f09b6a818d48543556c6aa6e3~4N-i_N-5Q3068430684epoutp03U;
        Wed,  9 Jan 2019 15:33:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190109153333epoutp0374cee62f09b6a818d48543556c6aa6e3~4N-i_N-5Q3068430684epoutp03U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1547048013;
        bh=KEEdHPxt8zVpWOJmHeHM+ChnuJz6QXi5nwb717WENh8=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=aiLv0fyHTyzu5dSzbilHtnzVYMFEHTydvY11PtgyQWCW4yMPZ4hzCcZicSo+Qpx78
         OpLJFnuJoxco3lOU4rjnB567utP+r6aN8DdV6av68r/vzbiXT/wTvA/9h46zokZLEY
         br5CPfptFplqthWmq6bogr7/0tlx6Fz/p8g+3s24=
Received: from epsmges1p2.samsung.com (unknown [182.195.42.54]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190109153332epcas1p30513979c98743197b120f5b530caf081~4N-ig42hR2086620866epcas1p3V;
        Wed,  9 Jan 2019 15:33:32 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        6A.A3.04057.C44163C5; Thu, 10 Jan 2019 00:33:32 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190109153332epcas1p187b419176a8d1d0be4982a275c0b9e86~4N-iMGEwl0086100861epcas1p1b;
        Wed,  9 Jan 2019 15:33:32 +0000 (GMT)
X-AuditID: b6c32a36-d31ff70000000fd9-f5-5c36144cb0e0
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B5.7C.03601.C44163C5; Thu, 10 Jan 2019 00:33:32 +0900 (KST)
Received: from test-PowerEdge-R720.sa.corp.samsungelectronics.net
        ([107.108.221.212]) by mmp1.samsung.com (Oracle Communications Messaging
        Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PL2000VLLVH1220@mmp1.samsung.com>; Thu, 10 Jan 2019 00:33:32 +0900 (KST)
From:   Kanchan Joshi <joshi.k@samsung.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-nvme@lists.infradead.org, jack@suse.com, david@fromorbit.com,
        tytso@mit.edu, prakash.v@samsung.com,
        Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH 1/4] block: Increase count of supported write-hints
Date:   Wed, 09 Jan 2019 21:00:58 +0530
Message-id: <1547047861-7271-2-git-send-email-joshi.k@samsung.com>
X-Mailer: git-send-email 2.7.4
In-reply-to: <1547047861-7271-1-git-send-email-joshi.k@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEIsWRmVeSWpSXmKPExsWy7bCmvq6PiFmMwaajVhZbjt1jtHi+fDGj
        xdH/b9ks9t7Stpg57w6bxZ69J1ks5i97ym5xZcoiZovWnp/sDpwepxZJeGxeUu/RdOYos0ff
        llWMHuu3XGXx+LxJLoAtissmJTUnsyy1SN8ugStj86W1TAU3WStaLy9jaWB8xNLFyMkhIWAi
        sXDOC8YuRi4OIYEdjBLP985nh3C+M0qcO/OWEabqyLV3bBCJ3YwST97OA0sICUxnknixwbKL
        kYODTUBT4sLkUhBTREBR4vJ7J5ByZoFzjBJLP05kAikXFnCW+LjsGSuIzSKgKvFs0Rkwm1fA
        SeL9jblQF8lJ3DzXyQxicwLV/+r5yQwySEJgDpvEox9v2SGKXCQuLTgJZQtLvDq+hR1ksYSA
        tMSlo7YQ4WKJX3eOQvV2MEpcb5gJtcBe4uKev2AHMQvwSbz72sMK0csr0dEmBFHiIfHszk9W
        iH+nMUo8nP2UdQKj5AJGhlWMYqkFxbnpqcWGBUZ6xYm5xaV56XrJ+bmbGMExqWW2g3HROZ9D
        jAIcjEo8vAn/TGOEWBPLiitzDzFKcDArifCq3zGJEeJNSaysSi3Kjy8qzUktPsQozcGiJM77
        RGputJBAemJJanZqakFqEUyWiYNTqoGxRtG/wNzD8HlV+63F6RIO0ROb1IMaNSQj789JCrv4
        v6nVrucuz2utkiy+wrgfvFWrUjoPp5hOSWldnn9JYaLu5oL+6T+yT2X8Wrb63wLH5wcuxp59
        XKgrH8J1dJVOp17K0dB3TZmHJz48ePKWFVPVbxOxVUuqkm46vtWoOrUrvWGNm8AXc14lluKM
        REMt5qLiRABG9swVxQIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOLMWRmVeSWpSXmKPExsVy+t9jAV0fEbMYg6aJChZbjt1jtHi+fDGj
        xdH/b9ks9t7Stpg57w6bxZ69J1ks5i97ym5xZcoiZovWnp/sDpwepxZJeGxeUu/RdOYos0ff
        llWMHuu3XGXx+LxJLoAtissmJTUnsyy1SN8ugStj86W1TAU3WStaLy9jaWB8xNLFyMkhIWAi
        ceTaO7YuRi4OIYGdjBKPTj1ihHBmMklc/rWSvYuRg4NNQFPiwuRSEFNEQFHi8nsnkBJmgXOM
        EtdvdDCDDBIWcJb4uOwZK4jNIqAq8WzRGTCbV8BJ4v2NuVDL5CRunusEq+cEqv/V8xPMFgKq
        uXjrKtsERp4FjAyrGCVTC4pz03OLjQoM81LL9YoTc4tL89L1kvNzNzECg2vbYa2+HYz3l8Qf
        YhTgYFTi4U34ZxojxJpYVlyZe4hRgoNZSYRX/Y5JjBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHe
        23nHIoUE0hNLUrNTUwtSi2CyTBycUg2M2UlC88xWZl85aeD977Jx9O3LGyO0Lm88rRy6/k/j
        rheqB9I+ceguKfE7WvRrZ8MiiYmTOBKPTCnt8ss2jOY6qHsiofJP+bWDoWxOh+7HpvQ4zK2c
        VtFvL/dshiRbnXainXDZEx3JqTv1e/ZK/YyyVPknlyz/asJ5++YZnV/3PhHzDNj2wdhaiaU4
        I9FQi7moOBEARxNr3ioCAAA=
X-CMS-MailID: 20190109153332epcas1p187b419176a8d1d0be4982a275c0b9e86
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20190109153332epcas1p187b419176a8d1d0be4982a275c0b9e86
References: <1547047861-7271-1-git-send-email-joshi.k@samsung.com>
        <CGME20190109153332epcas1p187b419176a8d1d0be4982a275c0b9e86@epcas1p1.samsung.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch bumps up write-hint count to support four new, in-kernel
hints.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 include/linux/blkdev.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 338604d..df07759 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -568,7 +568,10 @@ struct request_queue {
 
 	struct work_struct	release_work;
 
-#define BLK_MAX_WRITE_HINTS	5
+#define BLK_MAX_USER_WRITE_HINTS	5
+#define BLK_MAX_KERNEL_WRITE_HINTS	4
+#define BLK_MAX_WRITE_HINTS	(BLK_MAX_USER_WRITE_HINTS + \
+				BLK_MAX_KERNEL_WRITE_HINTS)
 	u64			write_hints[BLK_MAX_WRITE_HINTS];
 };
 
-- 
2.7.4

