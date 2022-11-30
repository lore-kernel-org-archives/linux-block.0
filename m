Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49859C433FE
	for <linux-block@archiver.kernel.org>; Wed, 30 Nov 2022 12:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233039AbiK3Mbg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Nov 2022 07:31:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiK3Mbf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Nov 2022 07:31:35 -0500
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E4D450A0
        for <linux-block@vger.kernel.org>; Wed, 30 Nov 2022 04:31:31 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20221130123127euoutp01c1b0cd86c6c9a519411a55413ddbfc45~sXLNiqumg2206222062euoutp01s
        for <linux-block@vger.kernel.org>; Wed, 30 Nov 2022 12:31:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20221130123127euoutp01c1b0cd86c6c9a519411a55413ddbfc45~sXLNiqumg2206222062euoutp01s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1669811487;
        bh=qb9Dh27FjbzpWGH4YkG2c6zhRXSlzcG/3M3cYxZitTo=;
        h=From:To:Cc:Subject:Date:References:From;
        b=aQ2ZZTArbkGMs54T3No94XUV2Js8yCyoA+cCvscxAsAiCVGXiLaEUAVa+5eWB5hnQ
         Qwdk0UlVxL4YWHmUamYF7F7hXWETyIgLTuHAhu/WWG/9vx6fjweyITArXsy8miinWO
         ZV/HH7g33tGQsM0rNSnOMS7dH99aFX7L4QaF3svs=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20221130123126eucas1p101098d1c5a633a578b8a2e8e74823cc6~sXLMwskCp0046300463eucas1p1p;
        Wed, 30 Nov 2022 12:31:26 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id F5.FB.10112.E1D47836; Wed, 30
        Nov 2022 12:31:26 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20221130123126eucas1p2cd3287ee4e5c03642f1847c50af0e4f2~sXLMSxSh50476404764eucas1p2S;
        Wed, 30 Nov 2022 12:31:26 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221130123126eusmtrp251ed07774dddd399c04ef82334c21375~sXLMSFtwF0601306013eusmtrp2L;
        Wed, 30 Nov 2022 12:31:26 +0000 (GMT)
X-AuditID: cbfec7f4-d09ff70000002780-bf-63874d1e330d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 55.E8.08916.D1D47836; Wed, 30
        Nov 2022 12:31:25 +0000 (GMT)
Received: from localhost (unknown [106.210.248.101]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20221130123125eusmtip19c287b735b8bcc473f3e967544a38832~sXLMGPNHZ1121411214eusmtip1W;
        Wed, 30 Nov 2022 12:31:25 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     stefanha@redhat.com, pbonzini@redhat.com
Cc:     jasowang@redhat.com, mst@redhat.com, gost.dev@samsung.com,
        Pankaj Raghav <pankydev8@gmail.com>, axboe@kernel.dk,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH] virtio-blk: replace ida_simple[get|remove] with
 ida_[alloc_range|free]
Date:   Wed, 30 Nov 2022 13:30:03 +0100
Message-Id: <20221130123001.25473-1-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTcRTH+917d3cdzK6z8mQvGVpppU4MbvRAo8egB0FBWITNedNou8rm
        ehhRqdka4SIrdVlJaYa9zGq5IjUrp9SQdIpbL6iZNVtp08rCVvMu6r/P+Z7zPY8fPwqXVAjC
        qe1cDqvhFCopKSLMLSPt86avOayM786bxlx+aSQZR5MFYy52eDHmvnMO4/vhFjDeqgIhc8XR
        SzCN5l8Cpv+4T8BU286SSSK5xfRSKO+06eTFPdVI/rmhi5QX3apBcm/d9HXkJtGidFa1fSer
        iVuyVZRp7m0kswdEu+stJ4kDKD/IgCgK6ETwfskyIBEloS8huGn/hvPBEIJhpw/jAy+CvKGW
        P5mgMUfJcJmAT1QjGHBfIvjgAwJ9ZTHm70vSMXDwiNCPE+i5MNhO+r043YfAMRDq51A6BRwV
        L8Z0go6Cs4dLxlhML4CRtnIhP2sGlHV8E/J6CLSVuQi+zwzIv316bFOgmyiwFjYFDMug6FAp
        xnMouK23AvpU8FnOBfS90NvzM2AuQGC0XCf5t1gIRU9VfsTpaLh+N44vT4bi/lEBXxEMPZ4Q
        foVgOG4uwXlZDPpCCV8tBcuIKzAUoDOvnOBZDqOP3gr8LKG3gPFBk/AYijD9d5jpv8NM/3ao
        QHgNCmN1WnUGq03g2F2xWoVaq+MyYpVZ6jr05xM9+WUdqkfV7sHYZoRRqBkBhUsniPXeQqVE
        nK7Yk8tqslI1OhWrbUZTKEIaJiZLY5QSOkORw+5g2WxW8zeLUUHhB7C0M/GPs1OvbMbaW33L
        4uvHc6WDDW2jGbobHjYqPs9QJVu/y3ZP50rGZ/VV7iM3ne9bQdtlrjvzxzu/9rtqPJF1ykxV
        4ttcS4jHd8SUPLG1ztrSbY9YucBcO/pAlKtYqu6sHe43tZ005D6LLLd9TLo8aXlPd3CY7ISR
        i7YJXid9n5uflmzQaDbIrmlXddnnzLy7bZHUrW++V5bj4aKfJ5hqry7m0sWV4S+Gwq2HohLj
        3s9uXB39qdX+rmNt+W3j+YYUY3uRU57wvVIp3EzHbqmhTnXtfp72ynRhozJlZtUjLlS/v14d
        4ZkUWXCqZO/k1Kish0HONwvHzb5zlHFccK6SEtpMhSwG12gVvwE//EpjswMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFLMWRmVeSWpSXmKPExsVy+t/xu7qyvu3JBvv/WFmsvtvPZnHzwE4m
        i2WXPjNZ7L2lbfH/1ytWi89LW9gt1tx8ymKxf9s/VovXk/6zWiw/O4/Ngctj56y77B6Xz5Z6
        TL6xnNHj/b6rbB59W1YxenzeJBfAFqVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5r
        ZWSqpG9nk5Kak1mWWqRvl6CXse3pfraCD1wVO3ZOZWlgbObsYuTkkBAwkZj+dSZrFyMXh5DA
        UkaJrc1TmCASEhK3FzYxQtjCEn+udbFBFD1nlLj6dTlLFyMHB5uAlkRjJztIjYiAnkTH3Faw
        QcwC7xklTk3azgKSEBYIl3i5aDKYzSKgKjGvfTobiM0rYCnx8+QcdogF8hIzL31nh4gLSpyc
        +QSsnhko3rx1NvMERr5ZSFKzkKQWMDKtYhRJLS3OTc8tNtQrTswtLs1L10vOz93ECIyEbcd+
        bt7BOO/VR71DjEwcjIcYJTiYlUR4Oz63JQvxpiRWVqUW5ccXleakFh9iNAW6byKzlGhyPjAW
        80riDc0MTA1NzCwNTC3NjJXEeT0LOhKFBNITS1KzU1MLUotg+pg4OKUamNzEZbjKJ5cXrnhX
        fN/eZmbz7tfmG6TOzUq8cmez1Qlf1/4pHzUcNq3087my+oG04t7UizPdzkd6tLfv/sJfd4pb
        VjN115zCTnsWZe93x4sWcV52OqMfpHT6Ff8y7/A1ro5fS8Jd/udWnVJeMc/6+2WJiVJ6DZeV
        /exfMfVXRb3z5Dn48qGi2rlT70sqjE7MOhZ620jHVOz3soJJ+s07vm/pOX+vv2HBt/eOLi+t
        8t85/zcN/CJllLZrxcWUarbrPCkPA0+vDn+o4D7jh+uZp+Zbtq1bWv3iXNfdexpcZ24b2V3m
        3Np2fcrkqCN5KvdlvySp+mS9+PrcOq3EomXlxCfLvS5kTUyY3uper96wlE2JpTgj0VCLuag4
        EQCPJ9h0DQMAAA==
X-CMS-MailID: 20221130123126eucas1p2cd3287ee4e5c03642f1847c50af0e4f2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20221130123126eucas1p2cd3287ee4e5c03642f1847c50af0e4f2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20221130123126eucas1p2cd3287ee4e5c03642f1847c50af0e4f2
References: <CGME20221130123126eucas1p2cd3287ee4e5c03642f1847c50af0e4f2@eucas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

ida_simple[get|remove] are deprecated, and are just wrappers to
ida_[alloc_range|free]. Replace ida_simple[get|remove] with their
corresponding counterparts.

No functional changes.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 drivers/block/virtio_blk.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 19da5defd734..68bd2f7961b3 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -512,7 +512,7 @@ static void virtblk_free_disk(struct gendisk *disk)
 {
 	struct virtio_blk *vblk = disk->private_data;
 
-	ida_simple_remove(&vd_index_ida, vblk->index);
+	ida_free(&vd_index_ida, vblk->index);
 	mutex_destroy(&vblk->vdev_mutex);
 	kfree(vblk);
 }
@@ -902,8 +902,8 @@ static int virtblk_probe(struct virtio_device *vdev)
 		return -EINVAL;
 	}
 
-	err = ida_simple_get(&vd_index_ida, 0, minor_to_index(1 << MINORBITS),
-			     GFP_KERNEL);
+	err = ida_alloc_range(&vd_index_ida, 0,
+			      minor_to_index(1 << MINORBITS) - 1, GFP_KERNEL);
 	if (err < 0)
 		goto out;
 	index = err;
@@ -1163,7 +1163,7 @@ static int virtblk_probe(struct virtio_device *vdev)
 out_free_vblk:
 	kfree(vblk);
 out_free_index:
-	ida_simple_remove(&vd_index_ida, index);
+	ida_free(&vd_index_ida, index);
 out:
 	return err;
 }
-- 
2.35.1

