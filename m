Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16BCAC04EB8
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 09:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D28A120863
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 09:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="cLUbSKXh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D28A120863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbeK3UmD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 15:42:03 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:33848 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbeK3UmD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 15:42:03 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181130093319euoutp017af98d0857d1b4dde7ec8aa034081615~r3RmbodG-3041130411euoutp01l;
        Fri, 30 Nov 2018 09:33:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181130093319euoutp017af98d0857d1b4dde7ec8aa034081615~r3RmbodG-3041130411euoutp01l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1543570399;
        bh=nSLhx1ar/BOyMEygR9ic4hCyK7Fpp5gQ4mfRx7Sn+Zk=;
        h=From:To:Cc:Subject:Date:References:From;
        b=cLUbSKXh0e0FK19/GvOfA08Vui6cZq10vVgNyJwpQmjB3aQbV5A6a0RhUjvsidk64
         5cTuG9a7S3YcVHtiFK+AUS0k+927kEUXwl7mmDasrI3z7TQNa0U/wdx/n2YQn9iHWI
         MZ7XnzzOshE9wprOjN5R1yjuMIk/hsBTc9Cr6IDM=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181130093318eucas1p1d86d3ec97575dbaf8ef673dfcd1a058c~r3RmEyFrX1212812128eucas1p19;
        Fri, 30 Nov 2018 09:33:18 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id C4.DF.04441.ED3010C5; Fri, 30
        Nov 2018 09:33:18 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181130093318eucas1p24feb8e649c8f244ce149a7f87e43c828~r3RlUuC6M0956509565eucas1p2t;
        Fri, 30 Nov 2018 09:33:18 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-9d-5c0103de267c
Received: from eusync4.samsung.com ( [203.254.199.214]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 6A.6D.04128.DD3010C5; Fri, 30
        Nov 2018 09:33:17 +0000 (GMT)
Received: from localhost.localdomain ([10.88.99.240]) by eusync4.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PJ000IWU2IN3A70@eusync4.samsung.com>; Fri, 30 Nov
        2018 09:33:17 +0000 (GMT)
From:   Huijin Park <huijin.park@samsung.com>
To:     Andreas Dilger <adilger.kernel@dilger.ca>,
        Michael Callahan <michaelcallahan@fb.com>
Cc:     Omar Sandoval <osandov@fb.com>, js07.lee@samsung.com,
        Huijin Park <huijin.park@samsung.com>,
        Huijin Park <bbanghj.park@gmail.com>,
        linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH,1/2] genhd: avoid overflow of sectors in disk_stats
Date:   Fri, 30 Nov 2018 04:32:40 -0500
Message-id: <1543570361-3168-1-git-send-email-huijin.park@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsWy7djP87r3mBljDO6u1bb4+qWDxeLl3kPM
        Fh0XXSwe3fzNarH3lrbFzHl32Cwu75rDZnHhdBubxeF7V1kcOD1aNpd7TGx+x+6xc9Zddo++
        LasYPT5vkgtgjeKySUnNySxLLdK3S+DK+HM8pOAZT8XS2c8YGxgncnUxcnJICJhI3H/Yzgpi
        CwmsYJQ41aPSxcgFZH9mlGj99YANpujstCUsEIlljBINh08xQjh/GSWObn/OAlLFJqAtcX3t
        VkYQW0QgSqKtZSJYB7PAI0aJh09mACU4OIQFnCVergkHMVkEVCX+/QgBKecVcJPYd3E1K8Qy
        OYmb5zqZIeyPrBLTfnNA2C4SZ+beh6oRlnh1fAs7hC0jcXlyNwuEnS3x61ErC8h4CYEKibfz
        VCDCxhLv3q4FG8kswCcxadt0ZogSXomONiGIEg+JT1vvsEDCIVZi88yXTBMYJRYwMqxiFE8t
        Lc5NTy02zEst1ytOzC0uzUvXS87P3cQIjLXT/45/2sH49VLSIUYBDkYlHt4X3/9HC7EmlhVX
        5h5ilOBgVhLhPdfGECPEm5JYWZValB9fVJqTWnyIUZqDRUmct5rhQbSQQHpiSWp2ampBahFM
        lomDU6qBkaVJTO3UhVoeTX22iYIlT8qSJ83cZ952Zts7xxVMWUnLXCLfRl2Mdd0t8vekyqlK
        hSfv3pT0/biy/Tx32vI53KcvF3Y9/P7o3f/ixtkp1z39Ax+Y1a9gF5wm03ty14wEDvldft9X
        KBi5tvqFZPOu/RBaUCblNrtgyhYdnjMZsc+nfH54soOXUYmlOCPRUIu5qDgRAI7Rg12xAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCJMWRmVeSWpSXmKPExsVy+t/xa7p3mRljDHoemVp8/dLBYvFy7yFm
        i46LLhaPbv5mtdh7S9ti5rw7bBaXd81hs7hwuo3N4vC9qywOnB4tm8s9Jja/Y/fYOesuu0ff
        llWMHp83yQWwRnHZpKTmZJalFunbJXBl/DkeUvCMp2Lp7GeMDYwTuboYOTkkBEwkzk5bwtLF
        yMUhJLCEUWLV0evsEM5/RonpL7oYQarYBLQlrq/dCmaLCERJLF38CqyDWeARo8TFIy+AEhwc
        wgLOEi/XhIOYLAKqEv9+hICU8wq4Sey7uJoVYpmcxM1zncwTGLkWMDKsYhRJLS3OTc8tNtIr
        TswtLs1L10vOz93ECAyLbcd+btnB2PUu+BCjAAejEg+vw6//0UKsiWXFlbmHGCU4mJVEeM+1
        McQI8aYkVlalFuXHF5XmpBYfYpTmYFES5z1vUBklJJCeWJKanZpakFoEk2Xi4JRqYFz2Le18
        bUzUvWduPw5P3u0XFai37Z7bu9l59X+372dQOrFRTNUq991P0+r2dev2upcvqn8uKs2zgVeq
        9wvz5epkc/3oiW+0ki5JvrkuVKDQdLSvJP3Ls2TF9Iiaye9C1qtP/3VUWORI7OliFZG2ImP+
        yLx9ize6hrRtysw69HV+66wAuRsT4pVYijMSDbWYi4oTAZmPxVcHAgAA
X-CMS-MailID: 20181130093318eucas1p24feb8e649c8f244ce149a7f87e43c828
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181130093318eucas1p24feb8e649c8f244ce149a7f87e43c828
References: <CGME20181130093318eucas1p24feb8e649c8f244ce149a7f87e43c828@eucas1p2.samsung.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: "huijin.park" <huijin.park@samsung.com>

This patch changes the 'sectors' type to an u64.
In 32 bit system, the 'sectors' can accumulate up to about 2TiB.
If a 32 bit system makes i/o over 2TiB while running,
the 'sectors' will overflow.
As a result, the part_stat_read(sectors), the diskstats in proc and
the (lifetime|session)_write_kbytes in sysfs return invalid statistic.

Signed-off-by: huijin.park <huijin.park@samsung.com>
---
 block/genhd.c         |    6 +++---
 include/linux/genhd.h |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 0145bcb..7518dcd 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1343,10 +1343,10 @@ static int diskstats_show(struct seq_file *seqf, void *v)
 		part_stat_unlock();
 		part_in_flight(gp->queue, hd, inflight);
 		seq_printf(seqf, "%4d %7d %s "
-			   "%lu %lu %lu %u "
-			   "%lu %lu %lu %u "
+			   "%lu %lu %llu %u "
+			   "%lu %lu %llu %u "
 			   "%u %u %u "
-			   "%lu %lu %lu %u\n",
+			   "%lu %lu %llu %u\n",
 			   MAJOR(part_devt(hd)), MINOR(part_devt(hd)),
 			   disk_name(gp, hd->partno, buf),
 			   part_stat_read(hd, ios[STAT_READ]),
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 0c5ee17..5bf86f9 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -84,7 +84,7 @@ struct partition {
 
 struct disk_stats {
 	u64 nsecs[NR_STAT_GROUPS];
-	unsigned long sectors[NR_STAT_GROUPS];
+	u64 sectors[NR_STAT_GROUPS];
 	unsigned long ios[NR_STAT_GROUPS];
 	unsigned long merges[NR_STAT_GROUPS];
 	unsigned long io_ticks;
-- 
1.7.9.5

