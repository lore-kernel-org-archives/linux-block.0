Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A4A21B9FD
	for <linux-block@vger.kernel.org>; Thu,  9 Oct 2025 15:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760025185; cv=none; b=CByhW4DWkykoeH71IFXZy6iiannDJMawonfXBDrfYzNzrlcpbvbySUiAfs1FzAFYLKHm+vyTvEecJcU/jE9ZsyVgN4pHHceun7SuFhyKkoxAtwOJhZxAeXtFTY6ERC0KtGU3IVqacYXNLg0wrHY/nr38HAE8GZ4Z41x+HO0fKUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760025185; c=relaxed/simple;
	bh=v9Ip7LNP2VEiwnHZrZ8eVNmTBgLbYlpDgpYqVaxsXCg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OiWMuqw/0T6nu2uZ57yMCds91Pr6ic/+I4VhFCo/QH3rZceWluVwjnkD/PJxNUs2FXmw0Rnwj9tPjo5xc4grKzaRznideqSrrH4TPYn46gkyVZRak1Kk7CPq7PrKVkd1FPBLpifdDouqkIUeP/A5w4xL4szYLUeIjvUDWRk/0Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=afuDnMMP; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="afuDnMMP"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b62fcddfa21so728943a12.1
        for <linux-block@vger.kernel.org>; Thu, 09 Oct 2025 08:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760025181; x=1760629981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pBjelIz1jAb9hQtmfEuYUisyoqOeEVtNaaf0UqITCHw=;
        b=afuDnMMPd4LULkh9nJ5IgXG0ZxtaNMtF+hE3Z09mah3UpPNVfjlE4J98urDV22mn9F
         wBIq8AvIhvP1ZEeLuZAOmAHc/mFrAkKCRl0IoTXevXuaGbgee2Z7PLOF5T6YC87nhPHU
         k/Oz7GAiQqkI0g+87KdXwPJdludaBP6UB4oLKg7700QGl7EFYdmy6hujvMDFe4lrzrMo
         V8OJZDAPnR1sZZJVQDmeeBvUwyXjs3TinoxFzqav77G1nk9IzzVnTJBw9EuTsFQvZEwC
         +AdbFZWzOjcN1GaKl1eAwPoyfHVWwQYY7PgEZeN64GjcZDI1IqKZ750x7ri50QDV+K+r
         p3/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760025181; x=1760629981;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pBjelIz1jAb9hQtmfEuYUisyoqOeEVtNaaf0UqITCHw=;
        b=KJcmOulXezPClgiadDFL49iGywLtYQ1UYhsfZpshXb6S0xFkBqh7hnEcszRPQ8GM5z
         pV246M1KDu4R1+wpewmiAzJneawzAJYQCJ5b+Dm8jCaAy+unDd07LjddZJseqSWKhN8z
         QKQOgg9H8agEmPn7+6jGRbStWY07jjIMw9EG0AJme7NAmPMefdM5TEWCZ7Lhn6uoO/N4
         yGtYYniEmuNnaxca7I4DKZW6wEh4xeaYdcr1fpUrAuwv5AbNaGDxAsNsRLDLMyXUlIUb
         /ZJUr6hwpSNbKvLxd25iIWB6wg8tHQFnyTlookzCo4wwpr94+CtwfG8W3aZTsp/ksaOd
         2Zqw==
X-Gm-Message-State: AOJu0YwMiBUnvNtKLYz8u7uusDynaTexztu+4lsn6PjPKFh/visHnDlT
	wB70Fe1/gJnsVlQvxACQhk4S21mLolJtoe5lQMMgJNqyBWHVoHqgNXXYo/vH8cyH
X-Gm-Gg: ASbGncs5QqlilsVc+6cHyEFlwHUMO2VNm883tyeyaKsy8fDhLw3kl2LdoVmm0PIE8tP
	Xk4kP2r/8kLfHrF8iocByviFT/y1rjDti/dg30uIlh7YDNkwbnpTGNxKW87nkZacjaL8NBR3n8v
	1MSXzgQsWAkdDckswx0nhudH6GRq341CjFrsR+svIfizX6HKk5Tl5QchbOlaFteTHYYbSc6pZsw
	HiRPfBEgTDcNaRUSzuHvRt3/Om5+DLwh7JMuiIyWIEjPdC2Bx+ynT65XQPUGwP6y3KauYLwwNxo
	mwLumZ8aLWov+kJXDcTu9E9bclSueZN1Qm8Y+bccLXbrA4ayLvXBU364VS6Uf6DyW/nbXllCL52
	t0kimeNSkeK6rd1tDAZ2WIbTKhfLb8dX5jX7Qgz4Uk2miphZdgE40niexBXPhYva8IGEDyV1uUd
	9JZ/oL0g==
X-Google-Smtp-Source: AGHT+IEdT0C5qPAQpYvvT5gBwcW+zTEsCEkcKCV8GsD4mlbpRYW3wavevl7sYSUR5UGpbsxfvQUkAQ==
X-Received: by 2002:a17:903:1b2e:b0:249:3efa:3c99 with SMTP id d9443c01a7336-29027305700mr93726095ad.61.1760025180843;
        Thu, 09 Oct 2025 08:53:00 -0700 (PDT)
Received: from localhost.localdomain ([113.218.252.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f08eb7sm32372795ad.82.2025.10.09.08.52.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 09 Oct 2025 08:53:00 -0700 (PDT)
From: chengkaitao <pilgrimtao@gmail.com>
To: axboe@kernel.dk,
	dlemoal@kernel.org
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengkaitao <chengkaitao@kylinos.cn>
Subject: [PATCH v2] block/mq-deadline: adjust the timeout period of the per_prio->dispatch
Date: Thu,  9 Oct 2025 23:52:53 +0800
Message-ID: <20251009155253.14611-1-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chengkaitao <chengkaitao@kylinos.cn>

When adding a request to the sort_list/fifo_list, the kernel assigns
{jiffies + dd->fifo_expire[data_dir]} to the fifo_time member.
Consequently, we must subtract {dd->fifo_expire[rq_data_dir(rq)]} in
the started_after function.

In contrast, Commit (725f22a1477c) introduced changes to utilize the
fifo_timevmember of requests on a dispatch list. The patch assigns
{jiffies} to the fifo_time member when adding a request to a dispatch
list. However, it continues to use the started_after function, which
still subtracts {dd->fifo_expire[rq_data_dir(rq)]} from the start_time.
The commit message does not explain this design choice, though it appears
reasonably justifiable since dispatch lists should inherently have higher
priority than sort_lists/fifo_lists. Thus, the default fifo_time set for
dispatch lists should be smaller than that set for sort_lists/fifo_lists.

Originally, {dd->fifo_expire[data_dir]} was exclusively used in the
deadline_check_fifo function to control the timing of scanning fifo_lists.
This subsequently determines the offset for the next scan of sort_lists
via {dd->per_prio[prio].latest_pos[data_dir]}. Therefore, a larger
{dd->fifo_expire[data_dir]} value makes it less likely for timed-out
requests to be scanned.

However, Commit (725f22a1477c) reversed the semantic meaning of
{dd->fifo_expire[data_dir]}. When adding a request to a dispatch list,
the patch only assigns {jiffies} to the fifo_time member without
compensating for the {start_time -= dd->fifo_expire[rq_data_dir(rq)]}
operation in the started_after function. This results in larger
{dd->fifo_expire[data_dir]} values making timed-out requests more likely
to be scanned. By default, fifo_expire[DD_WRITE] > fifo_expire[DD_READ],
which incorrectly gives write-IO-requests higher priority than
read-IO-requests and creates inherently illogical prioritization.

On the other hand, the Commit (725f22a1477c) merges the effects of
fifo_expire and prio_aging_expire on the same code behavior, creating
redundant interactions. To address this, our new patch introduces
numerical compensation for {dd->fifo_expire[data_dir]} when adding
requests to dispatch lists. To maintain original logic as much as
possible while enhancing dispatch list priority, we additionally
subtract {dd->prio_aging_expire / 2} from the fifo_time, with default
values, {dd->prio_aging_expire / 2} equals {dd->fifo_expire[DD_WRITE]}.

Signed-off-by: Chengkaitao <chengkaitao@kylinos.cn>
---
v2: Add a more detailed commit message

Link to V1:
https://lore.kernel.org/all/20250926023818.16223-1-pilgrimtao@gmail.com/

 block/mq-deadline.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 3e741d33142d..fedc66187150 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -659,7 +659,8 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 
 	if (flags & BLK_MQ_INSERT_AT_HEAD) {
 		list_add(&rq->queuelist, &per_prio->dispatch);
-		rq->fifo_time = jiffies;
+		rq->fifo_time = jiffies + dd->fifo_expire[data_dir]
+				- dd->prio_aging_expire / 2;
 	} else {
 		deadline_add_rq_rb(per_prio, rq);
 
-- 
2.50.1 (Apple Git-155)

