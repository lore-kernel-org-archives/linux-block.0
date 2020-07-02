Return-Path: <SRS0=sMug=AN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 987E6C433DF
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 15:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 760C1208D5
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 15:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="lsdTsq2i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730214AbgGBPmd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jul 2020 11:42:33 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:50288 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728754AbgGBPmO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jul 2020 11:42:14 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200702154210epoutp0447a725c5c59666fb8b620c00402a5a41~d_dOIl8cR0370403704epoutp04T
        for <linux-block@vger.kernel.org>; Thu,  2 Jul 2020 15:42:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200702154210epoutp0447a725c5c59666fb8b620c00402a5a41~d_dOIl8cR0370403704epoutp04T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593704530;
        bh=K2+mo5xwtG55Pc3yxkOmmDHced+n9HmetT3RPTBR6qo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lsdTsq2iD8fvVh5VNbFGBMQ/P2EE73NS4bOpy1C3SagWi47RvzS8ClZ0fBdJgX1Tf
         +yYA6etUGBCXh0Pcl55VfHPrv2ncP7/q+r0E0ElYPfnqI3WvR6cUaDW3vk0tKMRvPU
         I49W85ySCeyD9d6ZmHR1i/AlZHLd9hdku2jtTcto=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20200702154209epcas5p32cccb69e788b0aebef47dc18e38c6a86~d_dNpPej60760807608epcas5p33;
        Thu,  2 Jul 2020 15:42:09 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        AE.F4.09703.1500EFE5; Fri,  3 Jul 2020 00:42:09 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20200702154208epcas5p39fe202f642a9d5c8dde9b911645c594c~d_dNAacFJ0760807608epcas5p32;
        Thu,  2 Jul 2020 15:42:08 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200702154208epsmtrp267a36aa897c5d7f936c14f2572b63871~d_dM-igcg1523715237epsmtrp2H;
        Thu,  2 Jul 2020 15:42:08 +0000 (GMT)
X-AuditID: b6c32a4a-4cbff700000025e7-7c-5efe00515716
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A2.3A.08382.0500EFE5; Fri,  3 Jul 2020 00:42:08 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200702154206epsmtip10254bcf4288da0e1fe7b88f3d3197880~d_dLAKyfU2838528385epsmtip13;
        Thu,  2 Jul 2020 15:42:06 +0000 (GMT)
From:   Kanchan Joshi <joshi.k@samsung.com>
To:     axboe@kernel.dk, kbusch@kernel.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        hch@lst.de, Damien.LeMoal@wdc.com,
        Kanchan Joshi <joshi.k@samsung.com>,
        Selvakumar S <selvakuma.s1@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>,
        Javier Gonzalez <javier.gonz@samsung.com>
Subject: [PATCH 1/2] block: fix error code for zone-append
Date:   Thu,  2 Jul 2020 21:08:49 +0530
Message-Id: <1593704330-11540-2-git-send-email-joshi.k@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593704330-11540-1-git-send-email-joshi.k@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCIsWRmVeSWpSXmKPExsWy7bCmhm4gw784gz8XpCx+T5/CarH6bj+b
        RWv7NyaLlauPMlk8vvOZ3eLo/7dsFpMOXWO02HtL2+LyrjlsFtt+z2e2uDJlEbPF6x8n2Rx4
        PC6fLfXYtKqTzWP3zQY2j74tqxg9Pm+S82g/0M0UwBbFZZOSmpNZllqkb5fAlXHr8AOmgjls
        FSeW/GNvYOxn7WLk5JAQMJG439rD1sXIxSEksJtR4tiKd1DOJ0aJJVfmM0E43xglVrYfZuli
        5ABrWfRPHSK+F6ho0VNWCOczo8TG20sZQYrYBDQlLkwuBVkhIqAmsXfRJ7CpzAJtTBKzVlxn
        B0kIC1hJnH23lwXEZhFQlTi65TkjiM0r4Cxx98gEZoj75CRunusEszkFXCS+zm1kARkkIfCV
        XWLq9e0sEEUuEr1rVjFB2MISr45vYYewpSQ+v9vLBmEXS/y6c5QZormDUeJ6w0yoZnuJi3v+
        MoFczQx09fpd+iBhZgE+id7fT5ggPuaV6GgTgqhWlLg36Sk07MQlHs5YAmV7SHx6+AhslZDA
        dEaJg4s4JzDKzkIYuoCRcRWjZGpBcW56arFpgVFearlecWJucWleul5yfu4mRnDC0PLawfjw
        wQe9Q4xMHIyHGCU4mJVEeE8b/IoT4k1JrKxKLcqPLyrNSS0+xCjNwaIkzqv040yckEB6Yklq
        dmpqQWoRTJaJg1Oqgam9yFPGZJlsfcRh7v8ru5W/753K89LQXTjOpDH98r1ZFYeXqW2VYU88
        dcXVZi7rb9+vfY5nHhlFfp94oXvCqRmy8mdf2aVKJQlZLdn0Uu+HnlHunw+bjjX/unB/l99s
        eeONGxxeWSbq5juVeOpr/94i3uTgzvbzVLyMTc3q5Eu/WeZt8Nr+M3J9Esdxp31agourPl34
        8vDl1sXRD/mfRpRvEDH+Xvtp3aXsio06ddvV/G9oS2wJbL9be5TdZc/f6N/fVGr/3nRnvMH3
        Z8VZqWCJO/PXNtS8eeOqcO9ZQeeMPK2lE08aKoaI+5Rf9IhZFTkt5ZjWncPXU5dFikx3vl0Y
        IT/X/LUdR27nygqOpmtKLMUZiYZazEXFiQAeGzB+hwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrELMWRmVeSWpSXmKPExsWy7bCSnG4Aw784g3sb9Cx+T5/CarH6bj+b
        RWv7NyaLlauPMlk8vvOZ3eLo/7dsFpMOXWO02HtL2+LyrjlsFtt+z2e2uDJlEbPF6x8n2Rx4
        PC6fLfXYtKqTzWP3zQY2j74tqxg9Pm+S82g/0M0UwBbFZZOSmpNZllqkb5fAlXHr8AOmgjls
        FSeW/GNvYOxn7WLk4JAQMJFY9E+9i5GLQ0hgN6PE1L0zmbsYOYHi4hLN136wQ9jCEiv/PWeH
        KPrIKLH81kRmkGY2AU2JC5NLQWpEBDQkVnxexgRSwyzQxySx5N0MsGZhASuJs+/2soDYLAKq
        Eke3PGcEsXkFnCXuHpkAtUxO4ua5TjCbU8BF4uvcRrB6IaCa7W9a2Ccw8i1gZFjFKJlaUJyb
        nltsWGCYl1quV5yYW1yal66XnJ+7iREcrFqaOxi3r/qgd4iRiYPxEKMEB7OSCO9pg19xQrwp
        iZVVqUX58UWlOanFhxilOViUxHlvFC6MExJITyxJzU5NLUgtgskycXBKNTBxi96pPnn6yu1D
        sxPfq/47ZLT4TFWXQvyz39efRVmuWVX3s2bPkUvLWJtfzTO04v1wmMHty1bD8gPnGRLP3QvX
        /diV+8S+T+2S7QLpNe9rDxw7uiSHd8/i2PvntBjPzP5oWpb7Nq//6am4VQs0FwfWXQ3xXbiE
        Y6bTrsw0vr9TGUomGLVMP6r518f0fG0cy8W9mkq7L7zIVlc+Elhz0q01nWFtuodRMOPide7G
        lgv/9ey3Oiqi82YCg9I6Be94yTjtMlfhi5dj3N4feZ3h0nAt3PejcvxnA8GZnrqbP+zfZ3/5
        1r2bX39LsCzOmn3ImvF85ffXcb5Miqten3APvfq148yhTdXyKopzreTS2ZkmKbEUZyQaajEX
        FScCADYgtYPFAgAA
X-CMS-MailID: 20200702154208epcas5p39fe202f642a9d5c8dde9b911645c594c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20200702154208epcas5p39fe202f642a9d5c8dde9b911645c594c
References: <1593704330-11540-1-git-send-email-joshi.k@samsung.com>
        <CGME20200702154208epcas5p39fe202f642a9d5c8dde9b911645c594c@epcas5p3.samsung.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

avoid returning success when it should report failure, preventing
odd behavior in caller.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
Signed-off-by: Selvakumar S <selvakuma.s1@samsung.com>
Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Javier Gonzalez <javier.gonz@samsung.com>
---
 block/bio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index a7366c0..0cecdbc 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1044,7 +1044,7 @@ static int __bio_iov_append_get_pages(struct bio *bio, struct iov_iter *iter)
 	size_t offset;
 
 	if (WARN_ON_ONCE(!max_append_sectors))
-		return 0;
+		return -EINVAL;
 
 	/*
 	 * Move page array up in the allocated memory for the bio vecs as far as
-- 
2.7.4

