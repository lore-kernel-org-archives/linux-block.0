Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C6AC433F5
	for <linux-block@archiver.kernel.org>; Tue,  8 Mar 2022 16:54:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbiCHQzn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Mar 2022 11:55:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348038AbiCHQzm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Mar 2022 11:55:42 -0500
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB78D4EF56
        for <linux-block@vger.kernel.org>; Tue,  8 Mar 2022 08:54:45 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220308165444euoutp016c904ec0013a4e678be6b32761ea50cc~adh3pJcRT3241132411euoutp01M
        for <linux-block@vger.kernel.org>; Tue,  8 Mar 2022 16:54:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220308165444euoutp016c904ec0013a4e678be6b32761ea50cc~adh3pJcRT3241132411euoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1646758484;
        bh=H53xp6yeGBlTuoGeu8BDVoyhOFj9m5618FQoTrdC9pQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BQ1ndsTEal0EQVH1QKa750Kwu3/+ZGAobYTIZtSdStjcNFGqwbF2meimoWHdDEiG2
         CuPQcdPw7cpF5G1xP0gkBGPENHFW0B3V6i2JWVcZKj3NRDqpOUdFG6RnCp2VHp6JCP
         2dqEiD1Oic8XWhHbOpKN1nGbtc1MxyKwdyDEKUiI=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220308165444eucas1p1dc6f150ebe97c32b17af0c232b120eec~adh3TqMe00406404064eucas1p12;
        Tue,  8 Mar 2022 16:54:44 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 80.BD.09887.45A87226; Tue,  8
        Mar 2022 16:54:44 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220308165443eucas1p17e61670a5057f21a6c073711b284bfeb~adh20X0_30374103741eucas1p1A;
        Tue,  8 Mar 2022 16:54:43 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220308165443eusmtrp22016d5d24eb1bec006c0eb956c4f0969~adh2zoTfc0464104641eusmtrp2k;
        Tue,  8 Mar 2022 16:54:43 +0000 (GMT)
X-AuditID: cbfec7f4-45bff7000000269f-43-62278a5498c3
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id BF.96.09404.35A87226; Tue,  8
        Mar 2022 16:54:43 +0000 (GMT)
Received: from localhost (unknown [106.210.248.181]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220308165443eusmtip2d2d4bc26adfa27ddce92481060f6f699~adh2iffUO1078010780eusmtip2c;
        Tue,  8 Mar 2022 16:54:43 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>,
        kanchan Joshi <joshi.k@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias.bjorling@wdc.com>,
        jiangbo.365@bytedance.com
Cc:     Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshiiitr@gmail.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH 5/6] null_blk: forward the sector value from
 null_handle_memory_backend
Date:   Tue,  8 Mar 2022 17:53:48 +0100
Message-Id: <20220308165349.231320-6-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220308165349.231320-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKKsWRmVeSWpSXmKPExsWy7djP87ohXepJBltXcVhMP6xosfpuP5vF
        77PnmS1Wrj7KZPH4zmd2i54DH1gsjv5/y2Zx/u1hJotJh64xWuy9pW0xf9lTdosJbV+ZLW5M
        eMpo8XlpC7vFmptPWSzWvX7P4iDg8e/EGjaPnbPusnucv7eRxePy2VKPTas62Tw2L6n32H2z
        ASjXep/Vo2/LKkaPz5vkPNoPdDMFcEdx2aSk5mSWpRbp2yVwZUw9Z1PwW6Diwt07zA2MP3m7
        GDk5JARMJFb+OcvexcjFISSwglGi/8ARKOcLo0RD3womCOczo8St/z+YYVrm7v3NCmILCSxn
        lNjeLw5R9JJRYm/XXKAODg42AS2Jxk52kBoRgQvMEj9uKoLUMAtsZpT4MGkFWLOwQKTEk94H
        jCD1LAKqEjs35oKEeQWsJPZdeMoGsUteYual72BzOAWsJZ52zmSDqBGUODnzCQuIzQxU07x1
        NjPIfAmBxZwSt7pOMUI0u0g8n30dyhaWeHV8CzuELSPxf+d8JoiGfkaJqS1/oJwZjBI9hzeD
        fSABtK7vTA6IySygKbF+lz5E1FHie3cehMknceOtIMQJfBKTtk1nhgjzSnS0CUEsUpLY+fMJ
        1FIJictNc1ggbA+Jlw1PWSYwKs5C8swsJM/MQli7gJF5FaN4amlxbnpqsVFearlecWJucWle
        ul5yfu4mRmDKO/3v+JcdjMtffdQ7xMjEwXiIUYKDWUmE9/55lSQh3pTEyqrUovz4otKc1OJD
        jNIcLErivMmZGxKFBNITS1KzU1MLUotgskwcnFINTEuieaV/lp6RuanScO3kpBMbFjxlfF53
        RaajzbC3eeVTvW+akurXTv9x32OekrjgT5poz+TkpJkBcaeUK91V3fbcmpemFqqULP96acfM
        rR2Cumv+MHn82VDU2M289lnPGiF5Zh6h3prvLqmCy/uquHk2xueFTfo42XLG6/AfcvwzVjX2
        5z6fuX5Swm5nfvMnEXU564I+3Zzs2L2b58AJE+fNlct5ODQFfj67EXDAjEX6rtPmnV9Prsps
        ErZQ33X4v/JPFaPAtLD9b3S3bF5ev3f2ubNy28u2MogEyZ5O/bx6qe4OZ8fEvTK8ca2VPNM1
        xc8tr/sekP1xPa9+9tmVmkd+SgnL3H21zLnr/czVHUosxRmJhlrMRcWJAM4BaxPoAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsVy+t/xe7rBXepJBtN3q1lMP6xosfpuP5vF
        77PnmS1Wrj7KZPH4zmd2i54DH1gsjv5/y2Zx/u1hJotJh64xWuy9pW0xf9lTdosJbV+ZLW5M
        eMpo8XlpC7vFmptPWSzWvX7P4iDg8e/EGjaPnbPusnucv7eRxePy2VKPTas62Tw2L6n32H2z
        ASjXep/Vo2/LKkaPz5vkPNoPdDMFcEfp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvH
        WhmZKunb2aSk5mSWpRbp2yXoZUw9Z1PwW6Diwt07zA2MP3m7GDk5JARMJObu/c0KYgsJLGWU
        +NKvDhGXkLi9sIkRwhaW+HOti62LkQuo5jmjxIKvDUAJDg42AS2Jxk52kLiIwA1miWVT2xhB
        HGaB7YwSG1bOYQPpFhYIl5i1cB8rSAOLgKrEzo25IGFeASuJfReeskEskJeYeek7O4jNKWAt
        8bRzJhvEQVYSvw60MkHUC0qcnPmEBcRmBqpv3jqbeQKjwCwkqVlIUgsYmVYxiqSWFuem5xYb
        6RUn5haX5qXrJefnbmIExue2Yz+37GBc+eqj3iFGJg7GQ4wSHMxKIrz3z6skCfGmJFZWpRbl
        xxeV5qQWH2I0BTp7IrOUaHI+MEHklcQbmhmYGpqYWRqYWpoZK4nzehZ0JAoJpCeWpGanphak
        FsH0MXFwSjUw7XkU/JN9j6weC6uMgXP4wfNbnI/t1XY87a4dWpRld84++KajWa37Zc26iWlB
        gVU/7HnDObal/25oWDm96d3VZQyu13iqZnW6sUvWd1qtKdtieFKtNoeR527P1vj7s8odOvj3
        lOdIqP4ufndo9pOiSU82Rny2vf6K8fTab0zLTlidnfTmaoO92q6dMqKX67etsi5vvj5Fn/FS
        d3zTgt2paqdkL8TWzUvccuTzgekXw/1m/noRkSTPKDt5TqvGrejnRpePT5dn3XPMp6fssFaZ
        W+oM/z95U8pvVOl0lxkn73UvSF3b9d7N4lLP3Himn6f+16mV5DJ/suS6ctz8UcDhKwefzPP5
        L5p89dWXWQt3KbEUZyQaajEXFScCAFyGh6lYAwAA
X-CMS-MailID: 20220308165443eucas1p17e61670a5057f21a6c073711b284bfeb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220308165443eucas1p17e61670a5057f21a6c073711b284bfeb
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220308165443eucas1p17e61670a5057f21a6c073711b284bfeb
References: <20220308165349.231320-1-p.raghav@samsung.com>
        <CGME20220308165443eucas1p17e61670a5057f21a6c073711b284bfeb@eucas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is a preparation patch to add support for power_of_2 emulation in
the null_blk driver.

Currently, the sector value from null_handle_memory_backend is not
forwarded to the lower layer functions such as null_handle_rq and
null_handle_bio but instead they are fetched again from the request or
the bio respectively. This behaviour will not work when zone size
emulation is enabled.

Instead of fetching the sector value again from the request or bio, pass
down the sector value from null_handle_memory_backend to
null_handle_rq/bio.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 drivers/block/null_blk/main.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 05b1120e6623..625a06bfa5ad 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1204,13 +1204,12 @@ static int null_transfer(struct nullb *nullb, struct page *page,
 	return err;
 }
 
-static int null_handle_rq(struct nullb_cmd *cmd)
+static int null_handle_rq(struct nullb_cmd *cmd, sector_t sector)
 {
 	struct request *rq = cmd->rq;
 	struct nullb *nullb = cmd->nq->dev->nullb;
 	int err;
 	unsigned int len;
-	sector_t sector = blk_rq_pos(rq);
 	struct req_iterator iter;
 	struct bio_vec bvec;
 
@@ -1231,13 +1230,12 @@ static int null_handle_rq(struct nullb_cmd *cmd)
 	return 0;
 }
 
-static int null_handle_bio(struct nullb_cmd *cmd)
+static int null_handle_bio(struct nullb_cmd *cmd, sector_t sector)
 {
 	struct bio *bio = cmd->bio;
 	struct nullb *nullb = cmd->nq->dev->nullb;
 	int err;
 	unsigned int len;
-	sector_t sector = bio->bi_iter.bi_sector;
 	struct bio_vec bvec;
 	struct bvec_iter iter;
 
@@ -1320,9 +1318,9 @@ static inline blk_status_t null_handle_memory_backed(struct nullb_cmd *cmd,
 		return null_handle_discard(dev, sector, nr_sectors);
 
 	if (dev->queue_mode == NULL_Q_BIO)
-		err = null_handle_bio(cmd);
+		err = null_handle_bio(cmd, sector);
 	else
-		err = null_handle_rq(cmd);
+		err = null_handle_rq(cmd, sector);
 
 	return errno_to_blk_status(err);
 }
-- 
2.25.1

