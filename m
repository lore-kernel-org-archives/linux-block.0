Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18111C433F5
	for <linux-block@archiver.kernel.org>; Fri, 11 Feb 2022 09:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbiBKJmZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Feb 2022 04:42:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243159AbiBKJmX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Feb 2022 04:42:23 -0500
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0AB10A0
        for <linux-block@vger.kernel.org>; Fri, 11 Feb 2022 01:42:20 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220211093603euoutp02540410c3c9913f6fcfc1f0653b6cf4b0~SsatqGIij2463324633euoutp02j
        for <linux-block@vger.kernel.org>; Fri, 11 Feb 2022 09:36:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220211093603euoutp02540410c3c9913f6fcfc1f0653b6cf4b0~SsatqGIij2463324633euoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1644572163;
        bh=SRQrFTd0rG07SC/2FQxJ9s6G6cclyw5X+oCD+oinaOo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hodlomVhqJq0PHwHBq8Y/hdnzyzWhuon7JgiV/4DzIMI6FBUPz78GIXaoYz6JoDvY
         P3OeManImmH3nLF/Oj90yM15grY+94Jwnh31r55dodKmIDFUBjAg3iHEK0hnlT/fXk
         XNR3X2o56+E2359lgw+6afPMHxdI6DB4kT6JBlng=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220211093602eucas1p11bcd3d7c36fab67e48cb18c15ccbc837~Ssas7uZhz2914829148eucas1p1Q;
        Fri, 11 Feb 2022 09:36:02 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 91.0B.10260.40E26026; Fri, 11
        Feb 2022 09:36:04 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220211093602eucas1p1fe39e931232162a686b2feb06ea1f314~SsasPRwuv2710227102eucas1p1B;
        Fri, 11 Feb 2022 09:36:02 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220211093602eusmtrp1bde1100b437552cfc0b526b3e6ba19d9~SsasNct1w1150811508eusmtrp1G;
        Fri, 11 Feb 2022 09:36:02 +0000 (GMT)
X-AuditID: cbfec7f5-bddff70000002814-b8-62062e0460a7
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id AF.3A.09522.30E26026; Fri, 11
        Feb 2022 09:36:03 +0000 (GMT)
Received: from localhost (unknown [106.210.248.166]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220211093601eusmtip2d696e68ff5610779f48dda885aa9fe8a~Ssar72FjP2236022360eusmtip2I;
        Fri, 11 Feb 2022 09:36:01 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org, Pankaj Raghav <pankydev8@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        kanchan Joshi <joshi.k@samsung.com>,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v1 1/1] block: Add handling for zone append command in
 blk_complete_request
Date:   Fri, 11 Feb 2022 10:34:25 +0100
Message-Id: <20220211093425.43262-2-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220211093425.43262-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDKsWRmVeSWpSXmKPExsWy7djP87osemxJBr936FhMP6xosfpuP5vF
        6QmLmCwe3/nMbnH0/1s2i723tC1uTHjKaPF5aQu7xZqbT1kcOD12zrrL7rF5hZbH5bOlHptW
        dbJ59G1ZxejxeZNcAFsUl01Kak5mWWqRvl0CV8a726dZC26xVby+s42xgXEnaxcjJ4eEgInE
        5H+NzF2MXBxCAisYJR7e6GOCcL4wSsxf8g4q85lRYkLndnaYlqsndkJVLWeUWLK/nxXCecko
        MXPJXaAMBwebgJZEYydYg4iAu8T9AyfAapgFljJJ9J9aCpYQFoiV+Nz3iRnEZhFQlWh4+gws
        zitgKbF3/xKoA+UlZl76zg4yk1PASuL+8UqIEkGJkzOfsIDYzEAlzVtng10qIXCGQ+LRhSmM
        EL0uEi+evIWaIyzx6vgWqA9kJE5P7mGBaOhnlJja8ocJwpnBKNFzeDPYBxIC1hJ9Z3JATGYB
        TYn1u/Qheh0ljv+bzgpRwSdx460gxA18EpO2TWeGCPNKdLQJQVQrSez8+QRqq4TE5aY5LBC2
        h8SKM1+ZJzAqzkLyzSwk38xC2LuAkXkVo3hqaXFuemqxcV5quV5xYm5xaV66XnJ+7iZGYAI6
        /e/41x2MK1591DvEyMTBeIhRgoNZSYR3xQ3WJCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8yZkb
        EoUE0hNLUrNTUwtSi2CyTBycUg1MMa83uS3/E8O4+6/ajk9GW5zLJnsZsVzYNXdWg5jSOzP+
        tDTuoA17J2kF9p9r6s5RzPd/tq0h94np1txThmq9haEb5tcILJEx+Bd/Z3/W0Uq2f9Z5ndYX
        +Wb/r69yP72vdAnPz5MWAsXdLfuqJeLeynYcTP5Z5TaV/0qDfK15AOuXlrtNn/8tbp15LETO
        f32EzmvepgPbDjy6FrWyKPmKwMaw4NjnB9hPZFROOfZle9k8CaWT8uH7JlrM+2mbybirdfu8
        DsOCuq+qx7p+WmnVyVkc/225LXiO60N2jjs/JLdNDFkYevqni0NyQcTvyY/ep3muXBI/lcUq
        RLx8a0rIuaIEk95Qm8ZyQ6lZGllKLMUZiYZazEXFiQCKFfEkrwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkkeLIzCtJLcpLzFFi42I5/e/4PV1mPbYkg0ezLSymH1a0WH23n83i
        9IRFTBaP73xmtzj6/y2bxd5b2hY3JjxltPi8tIXdYs3NpywOnB47Z91l99i8Qsvj8tlSj02r
        Otk8+rasYvT4vEkugC1Kz6Yov7QkVSEjv7jEVina0MJIz9DSQs/IxFLP0Ng81srIVEnfziYl
        NSezLLVI3y5BL+Pd7dOsBbfYKl7f2cbYwLiTtYuRk0NCwETi6omdTCC2kMBSRokjn5Mh4hIS
        txc2MULYwhJ/rnWxdTFyAdU8Z5Q4s+IcUDMHB5uAlkRjJztIjYiAp0TbxnZWkBpmgdVMEn/P
        9bKAJIQFoiWmP7kFVsQioCrR8PQZmM0rYCmxd/8SqCPkJWZe+s4OMpNTwEri/vFKiHssJXbP
        m88IUS4ocXLmE7CRzEDlzVtnM09gFJiFJDULSWoBI9MqRpHU0uLc9NxiQ73ixNzi0rx0veT8
        3E2MwDjZduzn5h2M81591DvEyMTBeIhRgoNZSYR3xQ3WJCHelMTKqtSi/Pii0pzU4kOMpkBn
        T2SWEk3OB0ZqXkm8oZmBqaGJmaWBqaWZsZI4r2dBR6KQQHpiSWp2ampBahFMHxMHp1QDU7rl
        wi8eixrmV9/ielteIl/i3s4292b6JIv561lNxZY8fTijaEN67Tc5rd8FU6aW9TP/+p/iE7Wh
        7dPU3vnCSz/ZffL6uemZRc60GfdaleuuTCq2/s5eIc9jnvU9/EYK1xqxHf0N/q/sDpmnXMsP
        lpSf8E/4xMyfx/ydwsNnuDh8+Bh5X0vszn9uMzX3JR/fi2nUvg43k1zY+f5qs4BzqkBNSNl3
        0d037ve2B5ktanxiFXOF7VVL9AeOFdubqw/uPnju8vYtN9/lW3w8zF/yJVBm4rG3v0UXf4wM
        3jpPvOr5Fl/9FZUfWr/eeLl3o6e1x1emvDulPmyOpkuCvnw4sPIt44rjQssEVrd0/1AtCVVi
        Kc5INNRiLipOBAC5kC1xHAMAAA==
X-CMS-MailID: 20220211093602eucas1p1fe39e931232162a686b2feb06ea1f314
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220211093602eucas1p1fe39e931232162a686b2feb06ea1f314
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220211093602eucas1p1fe39e931232162a686b2feb06ea1f314
References: <20220211093425.43262-1-p.raghav@samsung.com>
        <CGME20220211093602eucas1p1fe39e931232162a686b2feb06ea1f314@eucas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Zone append command needs special handling to update the bi_sector
field in the bio struct with the actual position of the data in the
device. It is stored in __sector field of the request struct.

Fixes: 5581a5ddfe8d ("block: add completion handler for fast path")
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 block/blk-mq.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4b868e792ba4..6c2231e52991 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -736,6 +736,10 @@ static void blk_complete_request(struct request *req)
 
 		/* Completion has already been traced */
 		bio_clear_flag(bio, BIO_TRACE_COMPLETION);
+
+		if (req_op(req) == REQ_OP_ZONE_APPEND)
+			bio->bi_iter.bi_sector = req->__sector;
+
 		if (!is_flush)
 			bio_endio(bio);
 		bio = next;
-- 
2.25.1

