Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C7FC433E0
	for <linux-block@archiver.kernel.org>; Wed,  3 Feb 2021 09:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A41F64F74
	for <linux-block@archiver.kernel.org>; Wed,  3 Feb 2021 09:39:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233299AbhBCJjZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Feb 2021 04:39:25 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:29542 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232815AbhBCJjV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Feb 2021 04:39:21 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210203093838epoutp02b991f23fd5391e1520c991cfb7309b40~gM1e0cY8g2536225362epoutp022
        for <linux-block@vger.kernel.org>; Wed,  3 Feb 2021 09:38:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210203093838epoutp02b991f23fd5391e1520c991cfb7309b40~gM1e0cY8g2536225362epoutp022
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1612345118;
        bh=++Jnb3SqoJaKXZ2SwuM4efupS68kYYz0Kg14bYc0z1k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f4YGsWKHxRSce9baGr9hwT5FKueXznfmOBb22afwuUWLaFpbutFgZym/boBcP/7LJ
         2DdYBLzLS6ni1FDuCYieinBI7nY/gEYu+3a9pPbCINEjPxNHQJ4DfjAWbyReLmemZV
         7EocNEDnUzkenvRKRtyT8u+k6x1muAawtFCYNxbc=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210203093837epcas1p3cde587ad432277e767b65539c8057de4~gM1eNH3GS1876818768epcas1p3B;
        Wed,  3 Feb 2021 09:38:37 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.160]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4DVxSr2Ckxz4x9Q3; Wed,  3 Feb
        2021 09:38:36 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        CE.CE.63458.C1F6A106; Wed,  3 Feb 2021 18:38:36 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210203093835epcas1p2e86a35ba3012882950abc7013cae59b9~gM1cWcHSB1322013220epcas1p27;
        Wed,  3 Feb 2021 09:38:35 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210203093835epsmtrp1e0af78c4d2cb5b81b577e5f66dd467ca~gM1cTWyH70886908869epsmtrp1V;
        Wed,  3 Feb 2021 09:38:35 +0000 (GMT)
X-AuditID: b6c32a36-6c9ff7000000f7e2-ca-601a6f1c67e6
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        3E.5E.08745.B1F6A106; Wed,  3 Feb 2021 18:38:35 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.105]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210203093835epsmtip203e0316ecaa2edc1409ef6193337ae94~gM1cGcN7J1238212382epsmtip2S;
        Wed,  3 Feb 2021 09:38:35 +0000 (GMT)
From:   Changheun Lee <nanich.lee@samsung.com>
To:     gregkh@linuxfoundation.org
Cc:     Johannes.Thumshirn@wdc.com, asml.silence@gmail.com,
        axboe@kernel.dk, damien.lemoal@wdc.com, hch@infradead.org,
        jisoo2146.oh@samsung.com, junho89.kim@samsung.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com, mj0123.lee@samsung.com,
        nanich.lee@samsung.com, osandov@fb.com, patchwork-bot@kernel.org,
        seunghwan.hyun@samsung.com, sookwan7.kim@samsung.com,
        tj@kernel.org, tom.leiming@gmail.com, woosung2.lee@samsung.com,
        yt0928.kim@samsung.com
Subject: [PATCH v4 2/2] bio: add limit_bio_size sysfs
Date:   Wed,  3 Feb 2021 18:22:47 +0900
Message-Id: <20210203092247.29258-1-nanich.lee@samsung.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <YBpmQhqx4pvUh//a@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTVxzHc3rbe8ujeCkgx8YAu5t/iFBbauEMZDFiXJcZQ9z+WNyWcgNX
        IPS1XspkMRMGIq8pYKa8qsg6WAoLW3kMGCBBibyzyYApQ0AwyAwPYaiIj7W9kPHf9/zy+Z7v
        +f3OOUJMPIdLhIm6ZMaoozUU7spvurlXGrxbL4mRrbxyQ+XWJoBqJi7i6Nz5pzyU8X0djvoL
        Knkof/YbAXqVe5+H1qZZ1H5vHxpuLcdR16UMHrpSX46h0ckBAt28P8JH05ZCDA31rgjQ1ZlD
        6EV1N0BLz8cI1Nd8CUN17ev4IR9VYcYioWopnSBU9T8GqoYHTSqbNQdX3TDXEqqljhFcdaHB
        ClSrNj/V+c48XrTrSc3BBIaOY4wBjC5WH5eoi4+kPvxIHaVWhsrkwfJ3URgVoKO1TCR15Fh0
        8NFEjb1BKiCF1pjspWiaZan97x006k3JTECCnk2OpBhDnMYglxmkLK1lTbp4aaxeGy6XyUKU
        djJGk2AZmiYM026ne66189NAsWsucBFC8gD8Y7mMnwtchWKyGcArN6YIbrECYGdJN89BiclV
        AG//q9lypNcPYxzUCuDjJ+WbdjtkKzRjDgong+CFhXu4Q3uTfnB2/KXTgZGPMHg5+28n5EUq
        4a3+B06IT+6Bk+U99rpQKCIj4NqjVC7NHz78ttqJu5B74UZ2nsChRaQn7C2Z5Ts0ZmcyGsuc
        +0NyWQif3+kRcOYjsMYyxuO0F/zndgPBaQmcv5hFcIY8ADOyrgFuUQCgZa5q06GAK6urwHEi
        zB5d17qfK78FWzbMgEv2gItr+QIHAkkRzM4Sc8g7cCBzEtvKmvuphcchKtj4enOiZ6C5opYo
        AAGl29op3dZO6f+5FQCzgp2MgdXGM6zcELL9hm3A+eIDQ5tB0cKytAvwhKALQCFGeYv6inbG
        iEVxdOpXjFGvNpo0DNsFlPZZF2ISn1i9/cvoktVyZYhCoUAHQsNClQrKV0TLptRiMp5OZpIY
        xsAYt3w8oYskjZczaAqfXP3i6YuYpr9Sg4Oidi2dOBz02iPL5Ft5OnNmULvw+WjHb4nXR5NO
        ZR73E6GCH+Z2DY1HsUbt2fSzJyb+3ONDpK0V/67hb2BjFVRi6UyJ55fqoRSbQiltMyepW5Oi
        LVe91ht7dx8dO4m+9qt/m4rN0hK2u5N3r88Pvlmcoo+z7hPdlhqTxTqV8GyE8D7z3SkgPdfR
        HX/MPWK80irx35H/5n3dZ1UNcwPRd1C/qFOLX37CBgZaeR88Jm/9mv7zLzm+aaLwiE93PHMf
        8fT3eLhcpPZJmflYEJL2iZzcV1HT1rw+ffil4kGx1dhcTcwb8NoqY1lYm7m9z801Fq+j+GwC
        LQ/EjCz9H98aPyl6BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAIsWRmVeSWpSXmKPExsWy7bCSvK50vlSCwfI2VYs5q7YxWqy+289m
        0dr+jcmiefF6NovTExYxWfQ8aWK1+Nt1j8ni68Nii723tC0u75rDZnFocjOTxfTNc5gtrt0/
        w25x+N5VFouHSyYyW5w7+YnVYt5jB4tfy48yWrz/cZ3d4tSOycwW6/f+ZHMQ9ZjY/I7dY+es
        u+wem1doeVw+W+qxaVUnm8f+uWvYPd7vu8rm0bdlFaPH501yHu0HupkCuKK4bFJSczLLUov0
        7RK4Mpace8he8JC74sT8vSwNjDO4uhg5OSQETCQaN19m7mLk4hAS2MEoMWP+NGaIhJTE8RNv
        WbsYOYBsYYnDh4shaj4ySvzq/cEKUsMmoCPR9/YWG4gtIiAn8eT2H7BBzAJNLBLXz69mBEkI
        C5hKHDn9CKyIRUBV4v6cE8wgQ3kFrCW+vqiE2CUv8bR3OdheTgFNid8d3WDzhQQ0JH6d6gVr
        5RUQlDg58wkLiM0MVN+8dTbzBEaBWUhSs5CkFjAyrWKUTC0ozk3PLTYsMMpLLdcrTswtLs1L
        10vOz93ECI5ELa0djHtWfdA7xMjEwXiIUYKDWUmE99QksQQh3pTEyqrUovz4otKc1OJDjNIc
        LErivBe6TsYLCaQnlqRmp6YWpBbBZJk4OKUamFapPeLbqVy3uyXc42U4c42X2c9O5S1KCncu
        r49pWzORiyP/QdZ04cC28s15DRU5E2u49c50uSv9WN3Ln/W5+QTfEyfOmgp5tTO6326VzPsy
        2aV6vj9P18aSyEV3DabXWfVyzZk77eCjq/tVr0p5XLSTvtqpW8Iqc6v855aOFSvSjp5UPtW0
        8u/qbRI7rjm9Y/DUrj6mnWwS8PB0aFDc9GlfctewX5vicbLq/sy1UlFOZ/0rs1eUa/8tXzrh
        4yfv5auObyr9O89M5dra8sYpgSEqTrF/N3xL7fqesVMkalGWc8aHjY4p2df/3M2UV9X6bNzF
        eG9Huoj71qWVc/5383zPVuGQ79fycbjNe9l/qxJLcUaioRZzUXEiACQ6ogMzAwAA
X-CMS-MailID: 20210203093835epcas1p2e86a35ba3012882950abc7013cae59b9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210203093835epcas1p2e86a35ba3012882950abc7013cae59b9
References: <YBpmQhqx4pvUh//a@kroah.com>
        <CGME20210203093835epcas1p2e86a35ba3012882950abc7013cae59b9@epcas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add limit_bio_size block sysfs node to limit bio size.
Queue flag QUEUE_FLAG_LIMIT_BIO_SIZE will be set if limit_bio_size is set.
And bio max size will be limited by queue max sectors via
QUEUE_FLAG_LIMIT_BIO_SIZE set.

Signed-off-by: Changheun Lee <nanich.lee@samsung.com>
---
 block/blk-sysfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index b513f1683af0..840d97f427e6 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -288,6 +288,7 @@ QUEUE_SYSFS_BIT_FNS(nonrot, NONROT, 1);
 QUEUE_SYSFS_BIT_FNS(random, ADD_RANDOM, 0);
 QUEUE_SYSFS_BIT_FNS(iostats, IO_STAT, 0);
 QUEUE_SYSFS_BIT_FNS(stable_writes, STABLE_WRITES, 0);
+QUEUE_SYSFS_BIT_FNS(limit_bio_size, LIMIT_BIO_SIZE, 0);
 #undef QUEUE_SYSFS_BIT_FNS
 
 static ssize_t queue_zoned_show(struct request_queue *q, char *page)
@@ -615,6 +616,7 @@ QUEUE_RW_ENTRY(queue_nonrot, "rotational");
 QUEUE_RW_ENTRY(queue_iostats, "iostats");
 QUEUE_RW_ENTRY(queue_random, "add_random");
 QUEUE_RW_ENTRY(queue_stable_writes, "stable_writes");
+QUEUE_RW_ENTRY(queue_limit_bio_size, "limit_bio_size");
 
 static struct attribute *queue_attrs[] = {
 	&queue_requests_entry.attr,
@@ -648,6 +650,7 @@ static struct attribute *queue_attrs[] = {
 	&queue_rq_affinity_entry.attr,
 	&queue_iostats_entry.attr,
 	&queue_stable_writes_entry.attr,
+	&queue_limit_bio_size_entry.attr,
 	&queue_random_entry.attr,
 	&queue_poll_entry.attr,
 	&queue_wc_entry.attr,
-- 
2.28.0

