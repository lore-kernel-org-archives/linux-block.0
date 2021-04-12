Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43DDC43460
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 03:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A334C6120A
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 03:16:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235229AbhDLDQl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 11 Apr 2021 23:16:41 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:24556 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235484AbhDLDQj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 11 Apr 2021 23:16:39 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210412031620epoutp03dfae1c39cd02154bf35513911454985f~0-fGmD45E2813528135epoutp03D
        for <linux-block@vger.kernel.org>; Mon, 12 Apr 2021 03:16:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210412031620epoutp03dfae1c39cd02154bf35513911454985f~0-fGmD45E2813528135epoutp03D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1618197380;
        bh=bK4nDd0ajv0JiCnmUeGogNp9S49Fx4Q6ytoarroZWBM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q9Q8fxKXyqkZfUGVICJKAVBuaWYDVGy0wQzakPoDhI4+AsCClEtVh8D0KHn2OEXo2
         b8apdTCghFj+kYMisbjsbGznjqtciGI727LGU3ZxLN7qQVB9HVIj3pLQ+lS5JbSvA/
         cjmN0NG/kcvqkDyN4cmW0o9TXgFjF7FiL2D1bEok=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20210412031619epcas1p40ab3514c09930a364584f69706f1d3e4~0-fF-EtHg2895128951epcas1p4O;
        Mon, 12 Apr 2021 03:16:19 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.159]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4FJYmL38Cqz4x9Q9; Mon, 12 Apr
        2021 03:16:18 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        FE.0E.22618.28BB3706; Mon, 12 Apr 2021 12:16:18 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210412031617epcas1p284fde648f8fa84a0034ab6c93307cf73~0-fERpEwP2735027350epcas1p2K;
        Mon, 12 Apr 2021 03:16:17 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210412031617epsmtrp214caa045af8b903a663e86cc5f63920a~0-fEQnHYE1761817618epsmtrp2N;
        Mon, 12 Apr 2021 03:16:17 +0000 (GMT)
X-AuditID: b6c32a38-e4dff7000001585a-e6-6073bb82a8b9
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        64.C4.08745.18BB3706; Mon, 12 Apr 2021 12:16:17 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.105]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210412031617epsmtip16a8612c312022669a08fe7f7bcdfce64~0-fEChVTo2593925939epsmtip1p;
        Mon, 12 Apr 2021 03:16:17 +0000 (GMT)
From:   Changheun Lee <nanich.lee@samsung.com>
To:     damien.lemoal@wdc.com, bvanassche@acm.org,
        Johannes.Thumshirn@wdc.com, asml.silence@gmail.com,
        axboe@kernel.dk, gregkh@linuxfoundation.org, hch@infradead.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com, osandov@fb.com, patchwork-bot@kernel.org,
        tj@kernel.org, tom.leiming@gmail.com
Cc:     jisoo2146.oh@samsung.com, junho89.kim@samsung.com,
        mj0123.lee@samsung.com, seunghwan.hyun@samsung.com,
        sookwan7.kim@samsung.com, woosung2.lee@samsung.com,
        yt0928.kim@samsung.com, Changheun Lee <nanich.lee@samsung.com>
Subject: [PATCH v6 2/3] ufs: set QUEUE_FLAG_LIMIT_BIO_SIZE
Date:   Mon, 12 Apr 2021 11:58:30 +0900
Message-Id: <20210412025831.31498-3-nanich.lee@samsung.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210412025831.31498-1-nanich.lee@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTVxzHd+5tbwuk7FoQzxqm0DgJKNgCLWcCRoMjNz4WfPwzo2mv5VqI
        pW16KYE9HLEbKm8ER0SQ8ZAZEDDokLKgDDYEoUzHYwYHjMdGsozHQF4OyVoubPz3/Z3z+Z7v
        +Z2HEBfPEhJhrD6eMelpnZRw5tW3+gb4X/qOVcuWx9xRYWU9QFWDWQT6amYZR19eXsCQpayW
        QJ3ZpRhKH7/ER29ShzA0P8KipoHdqKexkEAtuRYM5d8vxFH/cJcAtQ718dBIeQ6Oujtm+ejW
        2AH0+psfAZpe+kWAnjbk4qi2aZk44EH19B6hcixTAspaMCig7t/xo3psZqqu8ipBPS66K6Cm
        H/URVOaDSkDN1W2nLjenYVEup3VhMQwdzZi8GL3GEB2r14ZLj5xURagUSpncX/4+CpF66ek4
        Jlx66GiUf2Sszt6p1CuB1pntQ1E0y0r37g8zGczxjFeMgY0PlzLGaJ1RLjMGsHQca9ZrAzSG
        uH1ymSxQYSfVupi262k8Y58ocex1pyAZtLqkAichJINh1cRLPBU4C8VkA4DfNy8QXDEL4I2V
        u3wHJSbnAMy/KdtwjN1+hXFQI4CNZW3Ef9CzOq1DE+QemDk5sLaSO9mBwaWqTuAocHIMwN6O
        FPuMUOhG7oN5RUkOA498D1Y/49JEZCh8NZnJ59J2wJXhdNyhncgw+Gv7KMExW2DHjXGeQ+N2
        xvLtzbUeIGlxgiMlpQLOfAjWrM6sazf455MH61oC56aaCM6QBqAlpRhwRTaA5RMVGEcFwdm5
        OeDYKU76wtrGvdywN7T+UwS4ZFc4NZ/OdyCQFMErKWIO2Qm7vhjGN7Imqq3rK1Kw90oX4I4u
        C0DrkzYiG3gVbGqoYFNDBf8nfw3wSuDBGNk4LcPKjcGb77gOrD1+P9QAiiZnAloAJgQtAApx
        qbvoXBKrFoui6aSPGZNBZTLrGLYFKOzHnYNLtmoM9t+jj1fJFYFBQUEoWBmiVARJt4nOyX5T
        iUktHc9cYBgjY9rwYUInSTJ2OvhnunAlotet75N0wR/CXXeibKoXpsU9KVX33KITalzzOop/
        r5lWXjh70nb7RfFR2UONVRt5pl+vMA9kbB9deOMXeezU55E++U+7+Veb/x7a70w2jYp8PAds
        f8VNSD7tDbGdr2dn0jIWTW+dqPgs+bp260h6+C5mi/fDwNkTwxmDS6ZHLhL+8Yrd8+2n3hV8
        KOubjDyU90G50bsZvp1vHclip3s0lbaD71wscb2lVla7PV9FB5fL2huuje88f7g/1vd5aMPj
        wWM7Ynx6al4y6m02FbNaktB91sPTu8wmah+lU35ina0/eB5W57pmigtL753BjocW52r6L0Yo
        uxY/Skxsl/LYGFruh5tY+l9HkUHehQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFIsWRmVeSWpSXmKPExsWy7bCSnG7j7uIEgz0LTSzmrNrGaLH6bj+b
        xbQPP5ktWtu/MVk0L17PZnF6wiImi54nTawWf7vuMVl8fVhssfeWtsXlXXPYLA5NbmaymL55
        DrPFtftn2C0O37vKYvFwyURmi3MnP7FazHvsYPFr+VFGi/c/rrNbnNoxmdli/d6fbA5iHpev
        eHtMbH7H7rFz1l12j80rtDwuny312LSqk81j/9w17B7v911l8+jbsorR4/MmOY/2A91MAdxR
        XDYpqTmZZalF+nYJXBnHpnazFFzlrXj86zR7A+Nh7i5GTg4JAROJx0u/MHUxcnEICexglNg5
        o4sJIiElcfzEW9YuRg4gW1ji8OFiiJqPjBLnb+xnBqlhE9CR6Ht7iw0kISJwm0ni0pajLCAO
        s8BrRomux4tYQLqFBawkpsytBGlgEVCVWHthDSuIzStgLfHlbR8rxDJ5iT/3e8CGcgrYSNw5
        8YgNxBYCqnm75iUbRL2gxMmZT1hAbGag+uats5knMArMQpKahSS1gJFpFaNkakFxbnpusWGB
        UV5quV5xYm5xaV66XnJ+7iZGcHRqae1g3LPqg94hRiYOxkOMEhzMSiK8SZXFCUK8KYmVValF
        +fFFpTmpxYcYpTlYlMR5L3SdjBcSSE8sSc1OTS1ILYLJMnFwSjUw1bmIP9gQKnjPbOU73Q9q
        xosjqt0+Rd6IW6uwsqr5+ZaL3NuT9bpbVtrr5nYuPXagOpzJttZztdKSMMXilrbsXbppybNq
        pZquP16+J1XmdZPmkvULHksp/vk3SYvrOnPlPk9lnUvVL+7eYbboe8J9cm2f89XVNlZRL5vd
        Nm35HCawdeKXq9+vJDG1O5f+6ytOFmBhVnxUc1z6/lzrBLfeM60Zc3cvD01/sGX1FGPWkwJT
        vj5bWuCaZ/+Y9aDCi2mfT52tXBLQn2yWwvjNXzv0Yqnug7+7CkNDy29xNE7xCpogwZQbUsjE
        Zr+gL0LS+fixA3nHehxaEtc9mmd19dzpHMVXsS7NXnuUn4QsVdBXYinOSDTUYi4qTgQARVc3
        XD0DAAA=
X-CMS-MailID: 20210412031617epcas1p284fde648f8fa84a0034ab6c93307cf73
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210412031617epcas1p284fde648f8fa84a0034ab6c93307cf73
References: <20210412025831.31498-1-nanich.lee@samsung.com>
        <CGME20210412031617epcas1p284fde648f8fa84a0034ab6c93307cf73@epcas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Set QUEUE_FLAG_LIMIT_BIO_SIZE queue flag to limit bio max size to
queue max sectors size for UFS device.

Signed-off-by: Changheun Lee <nanich.lee@samsung.com>
---
 drivers/scsi/scsi_lib.c   | 2 ++
 drivers/scsi/ufs/ufshcd.c | 1 +
 include/scsi/scsi_host.h  | 2 ++
 3 files changed, 5 insertions(+)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 7d52a11e1b61..73ce6ba7903a 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1838,6 +1838,8 @@ void __scsi_init_queue(struct Scsi_Host *shost, struct request_queue *q)
 	 * Devices that require a bigger alignment can increase it later.
 	 */
 	blk_queue_dma_alignment(q, max(4, dma_get_cache_alignment()) - 1);
+
+	blk_queue_set_limit_bio_size(q, shost->limit_bio_size);
 }
 EXPORT_SYMBOL_GPL(__scsi_init_queue);
 
diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index d3d05e997c13..000eb5ab022e 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -9313,6 +9313,7 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
 	host->max_channel = UFSHCD_MAX_CHANNEL;
 	host->unique_id = host->host_no;
 	host->max_cmd_len = UFS_CDB_SIZE;
+	host->limit_bio_size = true;
 
 	hba->max_pwr_info.is_valid = false;
 
diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
index e30fd963b97d..486f61588717 100644
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -607,6 +607,8 @@ struct Scsi_Host {
 	unsigned int max_segment_size;
 	unsigned long dma_boundary;
 	unsigned long virt_boundary_mask;
+	unsigned int limit_bio_size;
+
 	/*
 	 * In scsi-mq mode, the number of hardware queues supported by the LLD.
 	 *
-- 
2.29.0

