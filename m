Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 038B7C433ED
	for <linux-block@archiver.kernel.org>; Tue, 13 Apr 2021 03:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE79D613B1
	for <linux-block@archiver.kernel.org>; Tue, 13 Apr 2021 03:13:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242313AbhDMDNY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Apr 2021 23:13:24 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:19212 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240114AbhDMDNX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Apr 2021 23:13:23 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210413031302epoutp046abddabcde5cbbee51dd0e3817c12c69~1TFglsfNg0547105471epoutp04R
        for <linux-block@vger.kernel.org>; Tue, 13 Apr 2021 03:13:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210413031302epoutp046abddabcde5cbbee51dd0e3817c12c69~1TFglsfNg0547105471epoutp04R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1618283582;
        bh=bK4nDd0ajv0JiCnmUeGogNp9S49Fx4Q6ytoarroZWBM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CN8AMiEDVhUWv7W5C99mgejOgp+X9nFDTvKBGUE7Yjwyez7DkMHgGZXMuxajbBiMe
         TgLFRsqj8xMz/aDV+BA1sMnM2/fmIMyujg4cBvJIpUNXwfqqgsYLE2U+dxKrKB7654
         LK/8ktUSsG96e8BPZqVoHOx4c8GtXudqrH19WAbA=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210413031301epcas1p1aba87996b6bc34877033f1547e1564ed~1TFfX8BCm1620716207epcas1p1V;
        Tue, 13 Apr 2021 03:13:01 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.160]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4FK9f400dvz4x9Q1; Tue, 13 Apr
        2021 03:12:59 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        F8.02.23820.B3C05706; Tue, 13 Apr 2021 12:12:59 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20210413031258epcas1p469e9bd0145a49d440541cee899fd4d8e~1TFdFdXaF0620806208epcas1p4J;
        Tue, 13 Apr 2021 03:12:58 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210413031258epsmtrp2d1608837fee540975b05e8ef50d793c0~1TFdDgmP63149931499epsmtrp2d;
        Tue, 13 Apr 2021 03:12:58 +0000 (GMT)
X-AuditID: b6c32a37-a59ff70000015d0c-13-60750c3bcbcd
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        61.A5.33967.A3C05706; Tue, 13 Apr 2021 12:12:58 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.105]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210413031258epsmtip2271b5f7f945641380558b255d5cba0cd~1TFcwidlf1169811698epsmtip2W;
        Tue, 13 Apr 2021 03:12:58 +0000 (GMT)
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
Subject: [PATCH v7 2/3] ufs: set QUEUE_FLAG_LIMIT_BIO_SIZE
Date:   Tue, 13 Apr 2021 11:55:01 +0900
Message-Id: <20210413025502.31579-3-nanich.lee@samsung.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210413025502.31579-1-nanich.lee@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xbVRzHPfeW28KsuRaEI1m2rorJQKClK5zxMEQRr6sakGzOja107RWI
        faUPYNO5KlDGIxvsARkUmYyHgY0uDBFQtgWiA4tEB0Vlg4owpy5QBjJ5bGjLHZH/fo/P7/c9
        v985h4PzXEQgJ1NjpPUauUpA+LDae7eHhcY8aUoTjpyLQNamdoCax04SqHx2CUf5BQ8wlHvB
        RiB7aS2GSqY+8UKPisYxtDBhQN2jIWioy0qgntO5GKq4YsXRiHOAjXrHHSw0UVeGo8H+OS/0
        6WQ8Wm78BiDX4k9s9F3HaRzZupeIeH9qaFhKleXOsKnOyjE2deXzYGroexPV2lRIUNeqL7Ip
        11UHQZ1oawLUfOsWquB6MZa0aZ8qNoOWK2k9n9YotMpMTXqcQJoie0UmiRSKQkU7UZSAr5Gr
        6ThBwhtJoYmZKvekAn6WXGVyh5LkBoMg/KVYvdZkpPkZWoMxTkDrlCqdSKgLM8jVBpMmPUyh
        VUeLhMIIiZtMU2V8e7aYpXNwcyaX7Wwz6N1UBLw5kNwBy6seEUXAh8MjOwA0V7fgjDMHYMnX
        S8BD8cgH7kzha+sVLdZCFgN1A/iztRljnHkAG/9o8fJQBPkiPDE9utbXj+zH4GKzHXgcnJwE
        cLjf4s5wOL5kNGzu8/WYLDII2vITPSaXjIGXygyM2Fb40FmCe8LeZCx01Ko9YS75NOw/N8Xy
        2Lgbyf2iau3QkPyXA++PujAPD8kEmHdnL9PGF/51o43N2IFwfqabYPhiAHMtNYBxSgGsu9uA
        MZQYzs3PA08jnNwObV3hTHgb7FypBozwU3BmocSL0eLC4xYegzwPB/Kc+LrW3UudjztS8LZj
        7PHeTgJ4od7BKgX8yg3zVG6Yp/J/5fMAbwL+tM6gTqcNIp144wW3grWXHxzVAcqnZ8N6AMYB
        PQBycIEfN/GMMY3HVcoPH6H1WpnepKINPUDiXnUZHviMQuv+OhqjTCSJEIvFaEdkVKRELAjg
        HhL+KuOR6XIj/T5N62j9eh3G8Q40Yw37L++ZmHMujkfsL16przpvTaDfZemzDimybRVH03Ko
        TN3thPwjvcm7Zu8RfkpHTPZXyf/smby6+doHt3wix6J+9BN+OaKYynTtK1wIWF61nPros2cD
        U+1LsqyQ8d5RZfkWvA6kWvIu8u+f8Zf0eaVoW1y/fzyw+9Z7Q+KuG3ufUGA2KT54PTXo1VX/
        AP+zZllBfMrrb/95cE5nP2h5rtFR41jJ3rk7Y5ta07oaXNUwbJdNDpIV3scbpQcOY/ofpqXc
        Y7vMybVbvZ0VH/qQjYU3j9bX/HL5Zrt1oSAnzqtteDHkt7iZO211Aff+7nu574WdB04FvfVO
        0EPpsa7ocPubm83OJAHLkCEXBeN6g/w/3tMAiIIEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOIsWRmVeSWpSXmKPExsWy7bCSvK4VT2mCQUuLmsWcVdsYLVbf7Wez
        mPbhJ7NFa/s3JovmxevZLE5PWMRk0fOkidXib9c9JouvD4st9t7Stri8aw6bxaHJzUwW0zfP
        Yba4dv8Mu8Xhe1dZLB4umchsce7kJ1aLeY8dLH4tP8po8f7HdXaLUzsmM1us3/uTzUHM4/IV
        b4+Jze/YPXbOusvusXmFlsfls6Uem1Z1snnsn7uG3eP9vqtsHn1bVjF6fN4k59F+oJspgDuK
        yyYlNSezLLVI3y6BK+PY1G6Wgqu8FY9/nWZvYDzM3cXIySEhYCKxbk4nSxcjF4eQwG5GicfP
        nrNAJKQkjp94y9rFyAFkC0scPlwMUfORUeL6t5dsIDVsAjoSfW9vsYEkRARuM0lc2nIUbBKz
        wGtGia7Hi1hAuoUFrCRWnxAGMVkEVCXWt7qBmLwC1hJrJxZDrJKX+HO/hxkkzClgI3F1US5I
        WAio4u+uo8wgNq+AoMTJmU/ALmMGKm/eOpt5AqPALCSpWUhSCxiZVjFKphYU56bnFhsWGOal
        lusVJ+YWl+al6yXn525iBMelluYOxu2rPugdYmTiYDzEKMHBrCTC6zalJEGINyWxsiq1KD++
        qDQntfgQozQHi5I474Wuk/FCAumJJanZqakFqUUwWSYOTqkGJsuZUqwXjCbFZakGCGV1BKr1
        5z+bvIQlWWgJT8j/pXGTihg4rqs02gdsOiZ37cCvxGP/ixW33zLt8a7ZXJt+WlexQkJzXU2/
        wOqdr1kUZrj/Mf58PUbqZlSot8bim5dvs0xlZr+UM++TglBi+0rOdfoHHRdEnZ4assV32g2N
        Ndt6Vkd89uisdJqtIFbTZeKqua4ss9+Q+1yadtG8vvg7bf2/0xvfGb70+DJx0a/Q7LV8vbWH
        AvKPav785Pzy0acUd7HEvEDj1Y7O5sFO3FIWQt+uvDiiwHF8hXpphlNClj6TCuvLs/6zll3t
        zl/svXDFyz6PZquzV3Y/UzvjuHTyJMNH7IUpFaILMkRPZk5SYinOSDTUYi4qTgQA9Vc3BToD
        AAA=
X-CMS-MailID: 20210413031258epcas1p469e9bd0145a49d440541cee899fd4d8e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210413031258epcas1p469e9bd0145a49d440541cee899fd4d8e
References: <20210413025502.31579-1-nanich.lee@samsung.com>
        <CGME20210413031258epcas1p469e9bd0145a49d440541cee899fd4d8e@epcas1p4.samsung.com>
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

