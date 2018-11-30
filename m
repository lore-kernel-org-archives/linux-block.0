Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB40C64EB4
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 09:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67FA020863
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 09:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="C2RvEX1T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67FA020863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbeK3UmH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 15:42:07 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:33874 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbeK3UmG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 15:42:06 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181130093323euoutp0176fb5d41985f2853c92e68e38c9eee5f~r3RqdPkM-3041530415euoutp01n;
        Fri, 30 Nov 2018 09:33:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181130093323euoutp0176fb5d41985f2853c92e68e38c9eee5f~r3RqdPkM-3041530415euoutp01n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1543570403;
        bh=b0j9kY8FKIwVtLg9zCAlfYPZ50/GQ/mZ4VtIp7PbXgE=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=C2RvEX1TuwOOCaIA2Sa8o1DqA2thjU/nciJ85YCgE7zrqzr63QRso+dtHBenBBgzA
         fYOvMIjMTAoXh7lbAy5DU5xYXy3McDqeZPLn03xzX7SbfTYErakNsPNLD3vtpqRdLc
         Dcy9i8ycRlyMJan/9Og3MQtfCRFnuebbURxMNnGI=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181130093323eucas1p1e3f8ea1b8b56743881d20e472a6a970d~r3RqFppxk0419704197eucas1p1p;
        Fri, 30 Nov 2018 09:33:23 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 8C.F9.04806.2E3010C5; Fri, 30
        Nov 2018 09:33:22 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181130093322eucas1p2aab6a9716469d9d2a9de1ffa91dd42f0~r3RpZC4Ig3027030270eucas1p2o;
        Fri, 30 Nov 2018 09:33:22 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-01-5c0103e24a69
Received: from eusync4.samsung.com ( [203.254.199.214]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 5C.6D.04128.2E3010C5; Fri, 30
        Nov 2018 09:33:22 +0000 (GMT)
Received: from localhost.localdomain ([10.88.99.240]) by eusync4.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PJ000IWU2IN3A70@eusync4.samsung.com>; Fri, 30 Nov
        2018 09:33:22 +0000 (GMT)
From:   Huijin Park <huijin.park@samsung.com>
To:     Andreas Dilger <adilger.kernel@dilger.ca>,
        Michael Callahan <michaelcallahan@fb.com>
Cc:     Omar Sandoval <osandov@fb.com>, js07.lee@samsung.com,
        Huijin Park <huijin.park@samsung.com>,
        Huijin Park <bbanghj.park@gmail.com>,
        linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH,2/2] ext4: change type to same as sectors in disk_stats
Date:   Fri, 30 Nov 2018 04:32:41 -0500
Message-id: <1543570361-3168-2-git-send-email-huijin.park@samsung.com>
X-Mailer: git-send-email 2.7.4
In-reply-to: <1543570361-3168-1-git-send-email-huijin.park@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLIsWRmVeSWpSXmKPExsWy7djP87qPmBljDCZMtbL4+qWDxeLl3kPM
        Fh0XXSwe3fzNarH3lrbFzHl32Cwu75rDZnHhdBubxeF7V1kcOD1aNpd7TGx+x+6xc9Zddo++
        LasYPT5vkgtgjeKySUnNySxLLdK3S+DKmLroG3tBD3fFzp77jA2Mczi7GDk5JARMJLZP/MnY
        xcjFISSwglFi86xnrBDOZ0aJ5WdvsnQxcoBVLVojBhFfxiixuGkyVNFfRonZF08ygYxiE9CW
        uL52KyOILSIQJdHWMpEFpIhZ4BGjxMMnMxhBJgkLuEtsa5ICqWERUJWYs+IuWJhXwE3i0ZZw
        iIvkJG6e62QGsTmBquetWwt2nYTABDaJS88nMUMUuUicnn2SFcIWlnh1fAs7hC0jcXlyNwuE
        nS3x61Er1AMVEm/nqUCEjSXevV0LNoZZgE9i0rbpzBAlvBIdbUIQJR4SL+YvYIZ4cRajxJ6b
        8xgnMEouYGRYxSieWlqcm55abJyXWq5XnJhbXJqXrpecn7uJERiJp/8d/7qDcd+fpEOMAhyM
        Sjy8Dr/+RwuxJpYVV+YeYpTgYFYS4T3XxhAjxJuSWFmVWpQfX1Sak1p8iFGag0VJnLea4UG0
        kEB6YklqdmpqQWoRTJaJg1OqgdHcakeLPzv/5tbPOccfaDOLrZxQpLT67oepHvF39O+Klf5a
        pLRwusbFX/8sJbdf3s8b5OXceGz/jClLGDM2CNV0x1bfW/fw69K0eUtlAzYYqN9vO52/5pay
        xMZvLE0/a34lf/jMwXEnbMOFyh3rVn4L7HK+Ztx7qqNAl8PALWpSa9PGxydvt2kosRRnJBpq
        MRcVJwIASfdLEsACAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupiluLIzCtJLcpLzFFi42I5/e/4Nd1HzIwxBp++SFl8/dLBYvFy7yFm
        i46LLhaPbv5mtdh7S9ti5rw7bBaXd81hs7hwuo3N4vC9qywOnB4tm8s9Jja/Y/fYOesuu0ff
        llWMHp83yQWwRnHZpKTmZJalFunbJXBlTF30jb2gh7tiZ899xgbGOZxdjBwcEgImEovWiHUx
        cnIICSxhlPgxraCLkQvI/s8ocaJzOhNIgk1AW+L62q2MILaIQJTE0sWvWECKmAUeMUpcPPKC
        EWSQsIC7xLYmKZAaFgFViTkr7oKFeQXcJB5tCQcJSwjISdw818kMYnMCVc9btxasRAio5PAB
        2QmMPAsYGVYxiqSWFuem5xYb6RUn5haX5qXrJefnbmIEhtC2Yz+37GDsehd8iFGAg1GJh9fh
        1/9oIdbEsuLK3EOMEhzMSiK859oYYoR4UxIrq1KL8uOLSnNSiw8xSnOwKInznjeojBISSE8s
        Sc1OTS1ILYLJMnFwSjUw8u09eGNh1kJe+2uHXvLarVObucrcKXXO/0vzJcVP3770kfmBsFLN
        vh3Lwn/xfngdrbD8nNuX7NXf7fcGbGo1Oab54Jdgsldtj+XOzRJ6s8M++OUdlojcvbdn7m5V
        hv2ykVIfVor1X1WYE+jAcyLyJN/iJScf5j/n0GTZHFBbNzvs1sIslVqbCCWW4oxEQy3mouJE
        AD1cOS0dAgAA
X-CMS-MailID: 20181130093322eucas1p2aab6a9716469d9d2a9de1ffa91dd42f0
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181130093322eucas1p2aab6a9716469d9d2a9de1ffa91dd42f0
References: <1543570361-3168-1-git-send-email-huijin.park@samsung.com>
        <CGME20181130093322eucas1p2aab6a9716469d9d2a9de1ffa91dd42f0@eucas1p2.samsung.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: "huijin.park" <huijin.park@samsung.com>

This patch changes the 's_sectors_written_start' type to u64
same as the 'sectors' type in disk_stats.
Because if the 'sectors' has more than about 2TiB,
the 's_sectors_written_start' will overflow in 32 bit system.
And it makes invalid statistics([session|lifetime]_write_kbytes).

Signed-off-by: huijin.park <huijin.park@samsung.com>
---
 fs/ext4/ext4.h  |    2 +-
 fs/ext4/sysfs.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 3f89d0a..d3a08b2 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1457,7 +1457,7 @@ struct ext4_sb_info {
 	struct ext4_locality_group __percpu *s_locality_groups;
 
 	/* for write statistics */
-	unsigned long s_sectors_written_start;
+	u64 s_sectors_written_start;
 	u64 s_kbytes_written;
 
 	/* the size of zero-out chunk */
diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
index 9212a02..59ac5cf 100644
--- a/fs/ext4/sysfs.c
+++ b/fs/ext4/sysfs.c
@@ -57,7 +57,7 @@ static ssize_t session_write_kbytes_show(struct ext4_sb_info *sbi, char *buf)
 
 	if (!sb->s_bdev->bd_part)
 		return snprintf(buf, PAGE_SIZE, "0\n");
-	return snprintf(buf, PAGE_SIZE, "%lu\n",
+	return snprintf(buf, PAGE_SIZE, "%llu\n",
 			(part_stat_read(sb->s_bdev->bd_part,
 					sectors[STAT_WRITE]) -
 			 sbi->s_sectors_written_start) >> 1);
-- 
1.7.9.5

