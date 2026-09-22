Received: from mail-pj2-f7.google.com (mail-pj2-f7.google.com [74.125.227.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A49753ECEF
	for <linux-block@vger.kernel.org>; Tue, 22 Sep 2026 12:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790079462; cv=none; b=Dm/wE47DpDFrB626zh/t9PyaSsIeJedVdT21ENnRmNnumcpo66YU1i+haX6nAVQ3nADBEfL9OHJxIxU9Xdhkr0lIiBPPmsEAOOOSLP96cQ2evi5txXOlpzCCAt01Kz9b2xiMDslGD0kNQGADGPSyD4F0Mm5Ovkg/G+RZysqv+0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790079462; c=relaxed/simple;
	bh=Jwu8MyzOC2LLhO+SlqloCZGM/Bml9CbxrRt/Few6LS8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HPyOf7NYdheeT/W/Iuy/lGw7aVjm3E+Y0MfAbWvkr4ySh3AyKpFcgyFLHyd97I4yq/Dtd2EiDC9wGc0t3VATX8BUu19Q5oBr+voLPcMNfHn/N16GhjtCwi9NMkF8lWf/6jjdd3ydfGmUmM4fYRcBM6RyR4Z8QADml6luc3TCqE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YLsBVL20; arc=none smtp.client-ip=74.125.227.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLsBVL20"
Received: by mail-pj2-f7.google.com with SMTP id 98e67ed59e1d1-39e37c430bbso1915717a91.1
        for <linux-block@vger.kernel.org>; Tue, 22 Sep 2026 05:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790079461; x=1790684261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=e05fSioi2aryDDHJ7lqPTQ6ph0EZpuAJ3Kl8RbYZsrw=;
        b=YLsBVL20HBq1ziEnnDx5jxBZSoH+eRapyznoHKXU4clGjLPGMPk+EoxZ/US63K2+Aa
         3gUlyTb1dQwGcYH8KqSdhb8bowPR9JxOUaDfHAv+0CVhAzUnQAf3sphInUKC6hUeWgLP
         Zzrtlo5Zin48JK8QzPuF0YZSIYer6qwf5hwEzSnW/BySAftaiWTsUicVdBJiGu9HlTPb
         BU9XKw465PYzQbisqpQcDDHMzGUTEVRnHSrkgWOakO2xzDUSjaxstbTeftp3o4WRPtlk
         h2VacJY/D2Mftu9xC86kSSDQpJEhbJexX6VSw1itX8uWxzr2+sc8Z72TMC49TpRIoCgK
         pbTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790079461; x=1790684261;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e05fSioi2aryDDHJ7lqPTQ6ph0EZpuAJ3Kl8RbYZsrw=;
        b=eUQz3izpnD5HvCCDti4WUiYwa3/+mROhO0xboMuTYHPY+HyPVOA15IQLGcwhi1LhYK
         mo2Z1YuD/mb07ywWRp2yGZ0p9bQEerxlqSVAgW8FpUa0fyM1iS8NoHNXz55GdLGXt6Pt
         C12bO34A/KZntavW/ZRjsrNpNUJF799gRAQdjcHwFfIw2qFQEM7NIubKW/Fr2QfHYMzu
         3gq3e3mtZTVRF9L4TKKWfV7lmSeDsOogJ+fR43q66eMVivdr9g2xDQi7Pww4Qjj+lNfS
         6LxGflhp7sEljBtkMqaK4XPeRYXwPx2ofCSEznb9nin51FCjHz9uE4kSl1FiJB0PxXaj
         nzqw==
X-Gm-Message-State: AFuF++nrOL/xZypsDhrZBtLyHsyc/H7urNEYhKaLXe24EMig40okh0Z5
	8UK5c4j/YQReViXTm4nqpeCRs0vSz0EqWkPRKVE8FgxvbwMY5F0WeZCg
X-Gm-Gg: AYBFou29tqiuyN5R8taTFl4xWHHd4OTHRkfPzmPALK5JD02S9ro0c4qPpkySUTuROHT
	inQQErLyQkyuj8hg1UJ9EvjtORPi45btyb9xtWuAScnSVdFlVp+24jFbaC6B7q9cFfPH51O14Mt
	oSl/wyakMt3M6GPc/43DTGT70AGzrcegPV5MraWliisCDzIRE94AbbAIbFj+27w6Wji0zG3jYeD
	ZUnW/iMgcprTzOHYDoA/i1SIFy/Z4BB9KERZDqkC4sUduYYHJrgGujqek7imwI9tTc45W6mcBQw
	9PSxos1QjVEdRC3j2VSRRxkv2lMAihzkgIvYE++8/JzjaU3ADlfVJo+JxeuxERPupGckyESijci
	jnip+S8Lbg+8MvGH3vxgWDgmIp12dG25ndWmD91nou4eQfvjKM+Lrq4iB9KQnetvL8QfpphfMLV
	il6M/efqgngtUpfHXnHRkxNObYRGQYkOxc64JUP1gpK9KwI/kZRO0QncJGTeNC916zhcY46OXQ1
	o7Vnz516qQC6YSBfDlItCMFKAO3cZ69i1pLi6Qpn0H0iF7D2VuxwmUs
X-Received: by 2002:a17:90a:e7cc:b0:3a0:2900:f57e with SMTP id 98e67ed59e1d1-3a07320034amr1105288a91.40.1790079460421;
        Tue, 22 Sep 2026 05:17:40 -0700 (PDT)
Received: from Raccoon ([2409:408d:3188:aa03:3bb2:acc7:b581:620])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144f2a44cc8sm4892510c88.13.2026.09.22.05.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 05:17:39 -0700 (PDT)
From: Rohinthan <rokinthanp03@gmail.com>
To: Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rohinthan <rokinthanp03@gmail.com>,
	syzbot+fb23651a7efbea8868ed@syzkaller.appspotmail.com
Subject: [PATCH] zram: reject zero or overflowed disksize in disksize_store
Date: Tue, 22 Sep 2026 17:47:20 +0530
Message-ID: <20260922121720.11241-1-rokinthanp03@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When userspace writes a value close to U64_MAX (such as (u64)-1) to the
sysfs attribute /sys/block/zram<id>/disksize, disksize_store() parses it
with memparse() and then calls:

    disksize = PAGE_ALIGN(disksize);

Because adding PAGE_SIZE - 1 to values in the range
[U64_MAX - PAGE_SIZE + 2, U64_MAX] causes an integer overflow wrapping
to 0, disksize becomes 0. disksize_store() then passes 0 to
zram_meta_alloc(), which computes num_pages = 0 and calls vzalloc(0).

In mm/vmalloc.c, __vmalloc_node_range_noprof() checks
`if (WARN_ON_ONCE(!size))` and triggers a kernel warning:

    WARNING: mm/vmalloc.c:4038 at __vmalloc_node_range_noprof
    Call trace:
     __vmalloc_node_range_noprof
     vzalloc_noprof
     disksize_store
     dev_attr_store
     sysfs_kf_write

Fix this by checking if disksize wrapped to 0 after PAGE_ALIGN(disksize)
and returning -EINVAL. Also add a defensive check in zram_meta_alloc()
to return false if disksize is 0, avoiding vzalloc(0) under any
circumstance.

Fixes: cd67e10ac699 ("zram: promote zram from staging")
Reported-by: syzbot+fb23651a7efbea8868ed@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=fb23651a7efbea8868ed
Signed-off-by: Rohinthan <rokinthanp03@gmail.com>
---
 drivers/block/zram/zram_drv.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 6cb44e2..fdd13df 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1989,6 +1989,9 @@ static bool zram_meta_alloc(struct zram *zram, u64 disksize)
 {
 	size_t num_pages;
 
+	if (!disksize)
+		return false;
+
 	num_pages = disksize >> PAGE_SHIFT;
 	zram->table = vzalloc(array_size(num_pages, sizeof(*zram->table)));
 	if (!zram->table)
@@ -2878,6 +2881,9 @@ static ssize_t disksize_store(struct device *dev, struct device_attribute *attr,
 	}
 
 	disksize = PAGE_ALIGN(disksize);
+	if (!disksize)
+		return -EINVAL;
+
 	if (!zram_meta_alloc(zram, disksize))
 		return -ENOMEM;
 
-- 
2.53.0

