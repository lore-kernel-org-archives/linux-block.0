Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF795C433F5
	for <linux-block@archiver.kernel.org>; Thu, 27 Jan 2022 09:09:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232133AbiA0JJz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jan 2022 04:09:55 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:60239 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234750AbiA0JJy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jan 2022 04:09:54 -0500
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220127090952epoutp03c0608441c05b5ec4ccb43e8cd9feec69~OFYkAy-JN1726017260epoutp03U
        for <linux-block@vger.kernel.org>; Thu, 27 Jan 2022 09:09:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220127090952epoutp03c0608441c05b5ec4ccb43e8cd9feec69~OFYkAy-JN1726017260epoutp03U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1643274592;
        bh=MOfeOPd7/DFATfoZjnU6xbRzKs1j45E6h/F7a0S2hfo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LgOkL1mSJMLC9bphloG/Q8fVjuAQvxRvzhi4iX5t7khzQ/SBtEb930Et6f7kpFQNz
         qxlHcNKOPrrpoG1a69qLvPXHg+SwzENwOHAREsuwgJ0G9b1ZrFqPg3h3l0FGico02V
         IAcAN2jH/8xzhm5cYSO5qbD0vQYW8ZQSr7Sp3cyI=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220127090951epcas5p4d4d45a10412a1a36b65127618ead83a3~OFYjai02D3200332003epcas5p4P;
        Thu, 27 Jan 2022 09:09:51 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4JkvtG1xQBz4x9QP; Thu, 27 Jan
        2022 09:09:42 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        08.71.46822.E7F52F16; Thu, 27 Jan 2022 18:01:50 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220127083034epcas5p4aaafaf1f40c21a383e985d6f6568cbef~OE2QXjYOB3236932369epcas5p48;
        Thu, 27 Jan 2022 08:30:34 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220127083034epsmtrp2ef12992cff65ef55c8c95dbae36be6d7~OE2QWm8-W2535825358epsmtrp27;
        Thu, 27 Jan 2022 08:30:34 +0000 (GMT)
X-AuditID: b6c32a4a-dfbff7000000b6e6-d8-61f25f7e17b2
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        CE.85.08738.A2852F16; Thu, 27 Jan 2022 17:30:34 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220127083033epsmtip2e9189d63b40ede8fa23d741df046fd91~OE2PYSIZC1931219312epsmtip2T;
        Thu, 27 Jan 2022 08:30:33 +0000 (GMT)
From:   Kanchan Joshi <joshi.k@samsung.com>
To:     hch@lst.de, kbusch@kernel.org, axboe@kernel.dk
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        joshiiitr@gmail.com
Subject: [PATCH 1/2] block: introduce and export blk_rq_map_user_vec
Date:   Thu, 27 Jan 2022 13:55:35 +0530
Message-Id: <20220127082536.7243-2-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220127082536.7243-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupik+LIzCtJLcpLzFFi42LZdlhTU7cu/lOiwYV/Uhar7/azWaxcfZTJ
        4vzbw0wWkw5dY7TYe0vbYv6yp+wObB47Z91l97h8ttRj06pONo/NS+o9dt9sYPP4vEkugC0q
        2yYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMH6AYlhbLE
        nFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToFJgV5xYm5xaV66Xl5qiZWhgYGRKVBhQnZG
        5/vFrAXX+Cp2rP/O2MDYzdPFyMEhIWAicX15bhcjF4eQwG5GiWkPJrNDOJ8YJZ5+mMYK4Xxm
        lJjwYwobTMeLSxIQ8V2MEu9+zWSEK7p2oJEJpIhNQFPiwuRSEFNEwEji9tuYLkZODmaBMIlD
        PVNYQGxhAReJ/bs+go1kEVCV+HZHAiTMK2AusWnyXDYQW0JAXmLmpe/sIDangIXEqysPWSFq
        BCVOznzCAjFSXqJ562xmkAskBB6xS3w+84EdotlFYt+iblYIW1ji1fEtUHEpic/v9kItKJb4
        decoVHMHo8T1hpksEAl7iYt7/oK9wgz0yvpd+hBhWYmpp9YxQSzmk+j9/YQJIs4rsWMejK0o
        cW/SU6i94hIPZyyBsj0kWhu/QMOzm1HibtMutgmMCrOQPDQLyUOzEFYvYGRexSiZWlCcm55a
        bFpglJdaDo/i5PzcTYzgRKnltYPx4YMPeocYmTgYDzFKcDArifAKaX1MFOJNSaysSi3Kjy8q
        zUktPsRoCgzwicxSosn5wFSdVxJvaGJpYGJmZmZiaWxmqCTOezp9Q6KQQHpiSWp2ampBahFM
        HxMHp1QDk0XN+wmVhbefNOs0i2WXvHRYxtXQZiIhUa71hjf2lwXz8lkKHg9//D4fUe34MZT3
        gJPoq8aXC1SCea4K/2tp3adVLJ0j81vri0132ePvyS/PfVxbd6pjjsR709ycj36TV5ydpJQx
        qyYz7LXKwew58VcXRSWnntnht/ywHPvjSKbKyXXu/Ns49WbPEGnLePekqWFtTPLjnbvNKs9+
        9D5VUxpXxTa5NOuujdu8o/tW/7044w3jJaEK9oN1XM1LvnZ0/sr4v+HI9vPFzaKlopYTPP5M
        vSgn8/26eUW2yt8tt8/8NgxaI1ClyNjLldcp73Plym8b4ZOugZczb+3yZjWbcn55ZqGvs0uI
        r3Zmc+I9JZbijERDLeai4kQA50FT1B0EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrILMWRmVeSWpSXmKPExsWy7bCSvK5WxKdEg7enFSxW3+1ns1i5+iiT
        xfm3h5ksJh26xmix95a2xfxlT9kd2Dx2zrrL7nH5bKnHplWdbB6bl9R77L7ZwObxeZNcAFsU
        l01Kak5mWWqRvl0CV0bn+8WsBdf4Knas/87YwNjN08XIwSEhYCLx4pJEFyMXh5DADkaJro6V
        rF2MnEBxcYnmaz/YIWxhiZX/nrNDFH1klNg26SwbSDObgKbEhcmlIDUiAmYSCxbMYwGxmQUi
        JA5t2MQEYgsLuEjs3/URrJxFQFXi2x0JkDCvgLnEpslz2SDGy0vMvPQdbBWngIXEqysPwU4Q
        Aqq58OsaO0S9oMTJmU+gxstLNG+dzTyBUWAWktQsJKkFjEyrGCVTC4pz03OLDQuM8lLL9YoT
        c4tL89L1kvNzNzGCQ1lLawfjnlUf9A4xMnEwHmKU4GBWEuEV0vqYKMSbklhZlVqUH19UmpNa
        fIhRmoNFSZz3QtfJeCGB9MSS1OzU1ILUIpgsEwenVAOTpqNxz9W//I2pXEJ+1oY7+CacCn8X
        uLA6ZWJv1w03x8joxXfmfeTK+uPZqm4SeqCWccmN9HfrOnXOb3OO3vl78+ofCRcjOvKfz0xr
        n5CRs3OVotlTixc7OjZWavDs6/v4OFOr6kB2sbn8/RWBty96drnF6Z8+Vuv7sVC4PvqUSXhD
        7uGzGyp9Z3Ru19fbP+3QZDb38xWx30UaFvPzM/pHPqoVO6mdvD62RE+3Jo25ODZI8LPCHTYL
        pfJs37n3gg6/+5199c2braqTV356YmAplOfpytq3lm9ibYoSq9rHvu8P1V+vN3144SNP6zHJ
        n2Ef8n9buAsdOhYvFNS8/uJS/93cq/m0dji13Ev4KqzEUpyRaKjFXFScCAA+NhTZ1AIAAA==
X-CMS-MailID: 20220127083034epcas5p4aaafaf1f40c21a383e985d6f6568cbef
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220127083034epcas5p4aaafaf1f40c21a383e985d6f6568cbef
References: <20220127082536.7243-1-joshi.k@samsung.com>
        <CGME20220127083034epcas5p4aaafaf1f40c21a383e985d6f6568cbef@epcas5p4.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Similiar to blk_rq_map_user except that it operates on iovec.
This is a prep patch.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 block/blk-map.c        | 19 +++++++++++++++++++
 include/linux/blk-mq.h |  2 ++
 2 files changed, 21 insertions(+)

diff --git a/block/blk-map.c b/block/blk-map.c
index 4526adde0156..7fe45df3e580 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -577,6 +577,25 @@ int blk_rq_map_user(struct request_queue *q, struct request *rq,
 }
 EXPORT_SYMBOL(blk_rq_map_user);
 
+int blk_rq_map_user_vec(struct request_queue *q, struct request *rq,
+		    struct rq_map_data *map_data, void __user *uvec,
+		    unsigned long nr_vecs, gfp_t gfp_mask)
+{
+	struct iovec fast_iov[UIO_FASTIOV];
+	struct iovec *iov = fast_iov;
+	struct iov_iter iter;
+	int ret;
+
+	ret = import_iovec(rq_data_dir(rq), uvec, nr_vecs, UIO_FASTIOV, &iov, &iter);
+	if (unlikely(ret < 0))
+		return ret;
+	ret = blk_rq_map_user_iov(q, rq, NULL, &iter, gfp_mask);
+	kfree(iov);
+
+	return ret;
+}
+EXPORT_SYMBOL(blk_rq_map_user_vec);
+
 /**
  * blk_rq_unmap_user - unmap a request with user data
  * @bio:	       start of bio list
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index d319ffa59354..0fda666d2230 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -966,6 +966,8 @@ struct rq_map_data {
 
 int blk_rq_map_user(struct request_queue *, struct request *,
 		struct rq_map_data *, void __user *, unsigned long, gfp_t);
+int blk_rq_map_user_vec(struct request_queue *, struct request *,
+		struct rq_map_data *, void __user *, unsigned long, gfp_t);
 int blk_rq_map_user_iov(struct request_queue *, struct request *,
 		struct rq_map_data *, const struct iov_iter *, gfp_t);
 int blk_rq_unmap_user(struct bio *);
-- 
2.25.1

