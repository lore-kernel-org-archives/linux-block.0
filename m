Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCCC1C46467
	for <linux-block@archiver.kernel.org>; Tue, 10 Jan 2023 14:36:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbjAJOgq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Jan 2023 09:36:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238476AbjAJOgp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Jan 2023 09:36:45 -0500
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774F243A02
        for <linux-block@vger.kernel.org>; Tue, 10 Jan 2023 06:36:42 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230110143638euoutp0128f1580ee964284609d768bd35b8fd5f~4_VODHzbu3100431004euoutp01P
        for <linux-block@vger.kernel.org>; Tue, 10 Jan 2023 14:36:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230110143638euoutp0128f1580ee964284609d768bd35b8fd5f~4_VODHzbu3100431004euoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1673361398;
        bh=R4b4EPkdRWUUjgqA7T04PUXUczW2+piir3kCLNH8c6w=;
        h=From:To:Cc:Subject:Date:References:From;
        b=vj9fHhNZyJGNuQw+SlxiTejcDpA3plVlo/tCNMZSEHuJtq21sIEoCpn3Wi1kJ/RQh
         9oZn17SaUWZO9rtKBg0ohxPvslJaSqlIe0oXxGwnrOgeSfNoW3/Z5E+LEzPGEgEE74
         B6lrPhl/OukQ8bOHzq3vLkf4UnP+rIHunu7k68bs=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230110143637eucas1p28f0c3737e9bc89cacc4efde5292e2a39~4_VNLQdE00230702307eucas1p2h;
        Tue, 10 Jan 2023 14:36:37 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 06.A6.56180.5F77DB36; Tue, 10
        Jan 2023 14:36:37 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230110143637eucas1p1d82528b632ccda1de4fb2795ff691fe2~4_VMxKnHZ1940819408eucas1p1L;
        Tue, 10 Jan 2023 14:36:37 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230110143637eusmtrp1254629674830a830237a3444e6bec537~4_VMwfUdt2765827658eusmtrp1M;
        Tue, 10 Jan 2023 14:36:37 +0000 (GMT)
X-AuditID: cbfec7f2-ab5ff7000000db74-05-63bd77f55590
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 14.D0.52424.5F77DB36; Tue, 10
        Jan 2023 14:36:37 +0000 (GMT)
Received: from localhost (unknown [106.210.248.241]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230110143637eusmtip2e7b0ee7656712050d83a71862abedfa6~4_VMirkDu0980009800eusmtip2J;
        Tue, 10 Jan 2023 14:36:36 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     axboe@kernel.dk
Cc:     linux-nvme@lists.infradead.org, hch@lst.de, bvanassche@acm.org,
        linux-block@vger.kernel.org, damien.lemoal@opensource.wdc.com,
        gost.dev@samsung.com, snitzer@kernel.org,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v2 0/3] block zoned cleanups
Date:   Tue, 10 Jan 2023 15:36:32 +0100
Message-Id: <20230110143635.77300-1-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCKsWRmVeSWpSXmKPExsWy7djP87pfy/cmGxxeomKx+m4/m8W0Dz+Z
        LX6fPc9scfPATiaLlauPMlnsvaVtMX/ZU3aLz0tb2C1O3JJ24PS4fMXb4/LZUo9NqzrZPDYv
        qffYfbOBzWNn631Wj74tqxg9Pm+SC+CI4rJJSc3JLEst0rdL4Mq4u+grS8F/jopz0xcwNzDO
        Ye9i5OSQEDCRaHmyCcjm4hASWMEo8fJJOxuE84VRYkX7dhYI5zOjxL0Vl9lgWm739DNDJJYz
        Sly/d5ARwnnJKPH0QjeQw8HBJqAl0dgJtkNEQFhif0cr2CRmgeuMEtOnXWYBSQgL6Ej86dgL
        NpVFQFXiQtt3RhCbV8BS4vaWXqht8hIzL31nh4gLSpyc+QSslxko3rx1NtgVEgJnOCT2Pupi
        hGhwkZj1sxHKFpZ4dXwL1KcyEqcn97BA2NUST2/8hmpuYZTo37meDeRqCQFrib4zOSAms4Cm
        xPpd+hBRR4n+u4oQJp/EjbeCEBfwSUzaNp0ZIswr0dEmBDFbSWLnzydQOyUkLjfNgdrpIbHz
        4ESwp4QEYiVmP1jAOoFRYRaSv2Yh+WsWwgkLGJlXMYqnlhbnpqcWG+allusVJ+YWl+al6yXn
        525iBCak0/+Of9rBOPfVR71DjEwcjIcYJTiYlUR4V3LuSRbiTUmsrEotyo8vKs1JLT7EKM3B
        oiTOO2Pr/GQhgfTEktTs1NSC1CKYLBMHp1QDk4DH0e7gu5eMZVr4zc5H7HNIituWUr9LUoq9
        wSAsq13cySf7/tQ9B9cHcgaYP8zVdnsSOHPvwv9sX5xrrs9hEPA9msZfOv3EUg2p2InlPzeL
        TdS1nJScFKT8Q3KVw/GprMf+bN4dM8+2RWPbw71GVxp7bjmEbVHh5InZkvVdeX1kqPpjljWf
        Cgy+7q08HR+sk/m3xDF2RnWb/tno0ikhU3V4zfkM1H89NBcVj2TZsotVYmm+QPPe89vftoeU
        dE5xlg5SXxNyc0KMytXSmb83MRfMm3pt0kF3t+OCqywCihXuvrzK/93238ndMb6/d20vLrmV
        6e3k2FCwZ5WzwF3D0AsrUk6pf/l1gunSvDofJZbijERDLeai4kQAoMoTXbcDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEIsWRmVeSWpSXmKPExsVy+t/xe7pfy/cmG1xczmmx+m4/m8W0Dz+Z
        LX6fPc9scfPATiaLlauPMlnsvaVtMX/ZU3aLz0tb2C1O3JJ24PS4fMXb4/LZUo9NqzrZPDYv
        qffYfbOBzWNn631Wj74tqxg9Pm+SC+CI0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2
        j7UyMlXSt7NJSc3JLEst0rdL0Mu4u+grS8F/jopz0xcwNzDOYe9i5OSQEDCRuN3Tz9zFyMUh
        JLCUUWLZpZuMEAkJidsLm6BsYYk/17rYIIqeM0osf3sEqJuDg01AS6KxE2yQCFDN/o5WFpAa
        ZoH7jBJ/Nr1iAkkIC+hI/OnYywZiswioSlxo+w42lFfAUuL2ll42iAXyEjMvfQebySygKbF+
        lz5EiaDEyZlPWEBsZqCS5q2zmScw8s9CqJqFpGoWkqoFjMyrGEVSS4tz03OLjfSKE3OLS/PS
        9ZLzczcxAiNn27GfW3Ywrnz1Ue8QIxMH4yFGCQ5mJRHelZx7koV4UxIrq1KL8uOLSnNSiw8x
        mgJdPZFZSjQ5Hxi7eSXxhmYGpoYmZpYGppZmxkrivJ4FHYlCAumJJanZqakFqUUwfUwcnFIN
        TOrq8r6r10bkb7jha19yOKRUp/DoNIUAmctMovNOrj3zaJHTslM587ce/xat3Hv0UOK3F8I3
        p56f7DHfuc0w+HAmx8a9J6ZOZknkUA2Unt9nlKNxb7fgynt7Tc6XO63aM93oTIj4f9XGHq5H
        /LeqZVdsfbNH6MmWGL7With5Gzbwz+70n6Y3eUN3TomcX87CzRks77TuvmdoTTKJL5k0X7Vo
        ZshfdZnHUkuU1+4p33XweJOO8GeZwE9ZO1nfRmhUzp8mEhkXcm13z7OXP/k0WWqjjm5r/JbZ
        UVvqxPdZ36E5PH9iUXflZ+Y5uVYOk0O0i7xO31S3s9nwS1bydsPyr/faDGuu2NwyPhKjvTpm
        gRJLcUaioRZzUXEiAA5hEkYlAwAA
X-CMS-MailID: 20230110143637eucas1p1d82528b632ccda1de4fb2795ff691fe2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230110143637eucas1p1d82528b632ccda1de4fb2795ff691fe2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230110143637eucas1p1d82528b632ccda1de4fb2795ff691fe2
References: <CGME20230110143637eucas1p1d82528b632ccda1de4fb2795ff691fe2@eucas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,
  It is still unclear whether the support for non-po2 zone size devices
  will be added anytime soon [1]. I have extracted out the cleanup
  patches that doesn't do any functional change but improves the
  readability by adding helpers. This also helps a bit to
  maintain off-tree support as there is an interest to have this feature
  in some companies.

[1] https://lore.kernel.org/lkml/20220923173618.6899-1-p.raghav@samsung.com/

Changes since v1:
- Remove blk_is_zoned() check in bdev_{is_zone_start, offset_from_zone_start} (Damien)
- Minor spelling and variable name changes (Bart and Johannes)
- Remove zonefs patch for now (Damien)
- Send dm patches separately(Christoph)

Pankaj Raghav (3):
  block: remove superfluous check for request queue in bdev_is_zoned()
  block: add a new helper bdev_{is_zone_start, offset_from_zone_start}
  block: introduce bdev_zone_no helper

 block/blk-core.c          |  2 +-
 block/blk-zoned.c         |  4 ++--
 drivers/nvme/target/zns.c |  3 +--
 include/linux/blkdev.h    | 22 +++++++++++++++++-----
 4 files changed, 21 insertions(+), 10 deletions(-)

-- 
2.25.1

