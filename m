Return-Path: <SRS0=k455=3T=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A404C35240
	for <linux-block@archiver.kernel.org>; Thu, 30 Jan 2020 08:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 165E5206D5
	for <linux-block@archiver.kernel.org>; Thu, 30 Jan 2020 08:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="BQNpiALD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgA3Itw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Jan 2020 03:49:52 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:58212 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbgA3Itw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Jan 2020 03:49:52 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200130084950euoutp010b31bd353cdb5b83351a458f6767a932~unfQFTsmb2328923289euoutp01O
        for <linux-block@vger.kernel.org>; Thu, 30 Jan 2020 08:49:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200130084950euoutp010b31bd353cdb5b83351a458f6767a932~unfQFTsmb2328923289euoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1580374190;
        bh=36AbOeww7uDH1L53N7RtoklL5hD0MfQcvToc+XcwdqQ=;
        h=From:To:CC:Subject:Date:References:From;
        b=BQNpiALDkCJTIGGfwucBcwchsdVSzu6BEiNwJIC2X7B1AkSyrOpvs+cXc6OGk7pPH
         wefgzLnVUE0X82uLv3derHWMd/xTx7KvFsQh9llqcf0yQW+ihXUUUx3O9skQclv85a
         VEJhposUj3S/dbsm3wEJvR1COfHddcXLGwbjg0IQ=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200130084950eucas1p12c60afd8530cf83f692479e884f65e70~unfP-tRkK0614206142eucas1p1v;
        Thu, 30 Jan 2020 08:49:50 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 38.55.60698.EA8923E5; Thu, 30
        Jan 2020 08:49:50 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200130084950eucas1p2dac69024658d531d5f69ea0bdbd2be81~unfPwJqyE0330403304eucas1p2n;
        Thu, 30 Jan 2020 08:49:50 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200130084950eusmtrp1d4f9203c0456d167c33a9647f032f647~unfPvmFM62913229132eusmtrp1P;
        Thu, 30 Jan 2020 08:49:50 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-e5-5e3298ae2dbf
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 32.DA.07950.EA8923E5; Thu, 30
        Jan 2020 08:49:50 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200130084950eusmtip18e1e298b36b39d7fb15ad7ef75112629~unfPnjEJ40182501825eusmtip1g;
        Thu, 30 Jan 2020 08:49:50 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) by
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
        Server (TLS) id 15.0.1320.4; Thu, 30 Jan 2020 08:49:49 +0000
Received: from apples.local (106.110.32.41) by CAMSVWEXC01.scsc.local
        (106.1.227.71) with Microsoft SMTP Server id 15.0.1320.4 via Frontend
        Transport; Thu, 30 Jan 2020 08:49:49 +0000
From:   Klaus Jensen <k.jensen@samsung.com>
To:     <linux-block@vger.kernel.org>
CC:     <osandov@fb.com>, <its@irrelevant.dk>
Subject: [PATCH blktests] common/fio: do not use norandommap with verify
Date:   Thu, 30 Jan 2020 09:49:41 +0100
Message-ID: <20200130084941.60943-1-k.jensen@samsung.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgleLIzCtJLcpLzFFi42LZduznOd11M4ziDKbtlLbYf/Abq8XeW9oW
        h+9dZXFg9pjY/I7d49yO8+wenzfJBTBHcdmkpOZklqUW6dslcGXcujuBsaCPtWLit6NsDYwz
        WLoYOTkkBEwkHkz5wdrFyMUhJLCCUeLSzj42COcLo8SjRe+gMp8ZJfrbm9lhWl6+v8ECkVjO
        KPHg0HuwBFhV47ZkiMQZRontz84xQiR2MUqc/h0OYrMJaEps//MfbLmIgKLE0xVv2UBsZqB4
        d8NUsHphAQ+JrvlPmUBsFgFViRM/t4Et4BWwlPg+5wfUFfISsxtPs0HEBSVOznzCAjFHXqJ5
        62xmCFtC4uCLF8wgB0kIPGeT2P9mDlSzi8TDjjWMELawxKvjW6DiMhKnJ/ewQDR0M0r0ffgK
        1T2DUWL6su9A6ziAHGuJvjM5EKajxK1PMhAmn8SNt4IQe/kkJm2bzgwR5pXoaBOCmK4msaNp
        KyNEWEbi6RqFCYxKs5A8MAvJA7OQPLCAkXkVo3hqaXFuemqxcV5quV5xYm5xaV66XnJ+7iZG
        YLo4/e/41x2M+/4kHWIU4GBU4uGVKDOME2JNLCuuzD3EKMHBrCTCK+oKFOJNSaysSi3Kjy8q
        zUktPsQozcGiJM5rvOhlrJBAemJJanZqakFqEUyWiYNTqoHxygZ93a3cW5dozjc4qcT+4OR3
        vz3Kagv37role9/yvcE67kMCv670XuDhX2aXOtEyxNkmpG6S7vIL+0ouzuzacd0hkcl2qfVt
        rtylmRPXpDKVlk/U+yux6Or3iYrFaq9XBh+6njb7SyXr8W6WV++uay3ba9h14NSkjzt6eH7W
        5G23UxRc//zDGiWW4oxEQy3mouJEAP2K3qATAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgkeLIzCtJLcpLzFFi42I5/e/4Xd11M4ziDK7d5LHYf/Abq8XeW9oW
        h+9dZXFg9pjY/I7d49yO8+wenzfJBTBH6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqb
        x1oZmSrp29mkpOZklqUW6dsl6GXcujuBsaCPtWLit6NsDYwzWLoYOTkkBEwkXr6/AWRzcQgJ
        LGWUeH/jAhtEQkbi05WP7BC2sMSfa11sEEUfGSWuX73EDOGcYZT48/8ClLOLUWLaj3Vg7WwC
        mhLb//wH2yEioCjxdMVbsDgzULy7YSojiC0s4CHRNf8pE4jNIqAqceLnNrB1vAKWEt/n/IBa
        LS8xu/E0G0RcUOLkzCcsEHPkJZq3zmaGsCUkDr54wTyBUXAWkrJZSMpmISlbwMi8ilEktbQ4
        Nz232EivODG3uDQvXS85P3cTIzAWth37uWUHY9e74EOMAhyMSjy8EmWGcUKsiWXFlbmHGCU4
        mJVEeEVdgUK8KYmVValF+fFFpTmpxYcYTYGemMgsJZqcD4zTvJJ4Q1NDcwtLQ3Njc2MzCyVx
        3g6BgzFCAumJJanZqakFqUUwfUwcnFINjGVJElqJ/G4X9Fa+4T5sk/qZf4b7sW2+m2Q/yN/8
        fLd5l3D7JwbTRyHSij7ZTx48vXvk1r51DUb72RR2GnzW+eWZHxj2Llo9in3xzik2WxWneAdK
        rxKJ0HzoqhL7jnn7le9Lpvtfzo6qW2ZZe3/CO4P8D+rdy5lUxE2EPxjbBW0ViajcwVatp8RS
        nJFoqMVcVJwIAO3X8QmbAgAA
X-CMS-MailID: 20200130084950eucas1p2dac69024658d531d5f69ea0bdbd2be81
X-Msg-Generator: CA
X-RootMTR: 20200130084950eucas1p2dac69024658d531d5f69ea0bdbd2be81
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200130084950eucas1p2dac69024658d531d5f69ea0bdbd2be81
References: <CGME20200130084950eucas1p2dac69024658d531d5f69ea0bdbd2be81@eucas1p2.samsung.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

As per the fio documentation, using norandommap with an async I/O engine
and I/O depth > 1, can cause verification errors.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 common/fio | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/fio b/common/fio
index 2e81b26b50f1..8bfad4238dda 100644
--- a/common/fio
+++ b/common/fio
@@ -180,7 +180,7 @@ _run_fio_rand_io() {
 
 _run_fio_verify_io() {
 	_run_fio --name=verify --rw=randwrite --direct=1 --ioengine=libaio --bs=4k \
-		--norandommap --iodepth=16 --verify=crc32c "$@"
+		--iodepth=16 --verify=crc32c "$@"
 }
 
 _fio_perf_report() {
-- 
2.25.0

