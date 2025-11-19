Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE391C84DC
	for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 00:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763512616; cv=none; b=GxMwZbLm7KDWYaXgCxpESZzLsgMfm4lTu+rNoUQ+ptsu88/mCewAWntc3gsfOBoEo99jJq8rEtP79p3DTwMz8pMAzTGSNOk8Dbg52Wt4GgU48N4aB/ylh7K5+JGXqO96Q1VJpcghpZZW6n5PaZgMg1VXQaX2Hcg4OW8ejDxiUQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763512616; c=relaxed/simple;
	bh=5D029cnt+WTHwAu/MUWrYfxjKBz0PGlwHpM5B6oBJx0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Kp0yFy7H9VWsKZI0P2eJh1UO9LvJ+SLxwIpPV0e0nxlXXdaPqDawo7x7xSybVsj+HDP1vWbZd18ghV9+sECVnIVgJMe1mVzpOKkyU33HW6XtsUmZpas0zCr8Grg99Rf3PASAlWQOZ8DHpRcU7Qf0F4efOMuQPQ/0qGYEU1LHVT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c7OlZNmp; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7OlZNmp"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b6ceb3b68eeso4745021a12.2
        for <linux-block@vger.kernel.org>; Tue, 18 Nov 2025 16:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763512614; x=1764117414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W3lcy2UqBeKot8mViXkim4uY5huIXlEfp/tRFv8N8cI=;
        b=c7OlZNmpEiNAay1kdgMPy1/DWVL6w6/esXzzD9qgwcOLysPHsGjqgksUYBRQhf/6T7
         okdiYQes+MhoxozNYPE+lRxh6kO23WyReSFItO3cLW5iv9KpGkdFxg1F72hLcs3TG6Xt
         7Nhiyyp319bZn6ORH2o85V148fkIuOaL58Tl17H/8YA3TIGOOgMB4wxbdMELD36Ikrsg
         AMrIWzkBBUTcAIHK7q5vXIwNN4w1bju1vXyVzo2+Ha8mQHMQxk+l3N4XwoG5RSpfkAI0
         46E0V944y5xskoHFGIrIg2b38mS8yS/YwfuoUa1MAYnz51wOXY+FMH+k581UOSS7GkWK
         w6Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763512614; x=1764117414;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W3lcy2UqBeKot8mViXkim4uY5huIXlEfp/tRFv8N8cI=;
        b=SdNw99lPKuGrdlVphovCdiT5KXpAqjfs9c8z4UEq3Pct4PCnApgSscVnkPAXe8wVkn
         kxaK3w+JlRitw0nAS3ZNvB+he9v9CS+g5B2BSqsnhfsmKYZjJSNb8sleKBNwWZwKdE5o
         wmWiCCLXKxUCUHsIY2GH054dpkPgk1udLaqpfHDUvXCDSUKBqY2CTIQJv7Ojuax96R66
         uq79p0X+nBHxLTNPs3YVjKpRjkMQrpInJC0YEpnhwZx/beexo+vkCs2dvdcvPBItavou
         BbEmydAT+xqmL2dvcPtlHrV6p69caw1N+NhUHloz15+s4RjurfeWX0OczqE9kkdYE7iO
         OOYQ==
X-Gm-Message-State: AOJu0YxXlN1Oo6oWEiiYAKbgYyFpqIfnKbgfdXJP7sDU4Q37uIScO7ct
	Jb1vqVyqp6kZYAZqhgq7ogMJoxhfUASyNQMGa4Xg09ExfNlcvsAkFM59
X-Gm-Gg: ASbGncvVY00N37I/qTrKb2aB6GojIG6xwHjkjSNrDIntbj6j4GW/pU6+fBIU4VtaciP
	VcdKlaLoMSrXZo4u8oE3bO3t6tx71oqiLh4tchS3NX+uGNsPHN9MUGGVZcCfdI35rrXN7zLFibV
	F6ErDPpOnxTPXV5/gSRvqmiOzKtu1tevkZMFMG5YbJd0a2g9D6/YaGFGVkWMwThZvbwu39A6NQZ
	Kqk1je5UqK+kMcQ67sjfFzGYVglIVaBcaTRiD4q8ArBLXQoGx1f6cMaUBoLPKoFF/0sBAHyRcQM
	3UWb84zswcjZgnt44ObXTKu0yxctloDmdpFs7/NGUjJdLULxKI8ytXCoxUVQoJZLDY80/NPBA8k
	dG4W1+t06vAaUCEtUszsZOPtq5AnV/neIQ8/Vri5gF0Zp0Gj45nRxOiK3nk10X0AFKr9DTeAOKI
	WO3CqH7geoO9vPplXlZCadhd8S5JXw20UKM1cXccCWbq/XadMxHvWMSEyzQg==
X-Google-Smtp-Source: AGHT+IHqd0BPCLlpiwKFcFWmC4coRHXIHSf3S0jQT/Cn1AqXojRQpRpoo+iDFuz0NhlFNjmWz0Huvg==
X-Received: by 2002:a05:7300:d089:b0:2a4:3594:d548 with SMTP id 5a478bee46e88-2a4abb115b8mr9244006eec.21.1763512614282;
        Tue, 18 Nov 2025 16:36:54 -0800 (PST)
Received: from localhost (ip70-175-132-216.oc.oc.cox.net. [70.175.132.216])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a49dad0aefsm48448557eec.3.2025.11.18.16.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 16:36:53 -0800 (PST)
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
To: axboe@kernel.dk,
	dlemoal@kernel.org,
	hch@lst.de
Cc: linux-block@vger.kernel.org,
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Subject: [PATCH 1/2] loop: clear REQ_NOWAIT before workqueue submission
Date: Tue, 18 Nov 2025 16:36:46 -0800
Message-Id: <20251119003647.156537-1-ckulkarnilinux@gmail.com>
X-Mailer: git-send-email 2.40.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

loop advertises REQ_NOWAIT support via BLK_FEAT_NOWAIT (set by default
for all blk-mq devices), but delegates I/O processing to workqueues
where blocking operations are allowed.

Since REQ_NOWAIT is not valid in the workqueue context, clear the
REQ_NOWAIT flag before handing the request over to the workqueue. This
avoids unnecessary non-blocking constraints in a context where blocking
is acceptable.

Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
---

Hi,

Patches are generated on base commit in linux-block/for-next :-

commit 6dbcc40ec7aa17ed3dd1f798e4201e75ab7d7447 (origin/for-next)
Merge: 58625d626327 ba13710ddd1f
Author: Jens Axboe <axboe@kernel.dk>
Date:   Wed Nov 5 18:24:17 2025 -0700

    Merge branch 'for-6.19/block' into for-next

    * for-6.19/block:
      rust: block: update ARef and AlwaysRefCounted imports from sync::aref

-ck

---
 drivers/block/loop.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 13ce229d450c..9d931ff456e7 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -797,6 +797,7 @@ static inline int queue_on_root_worker(struct cgroup_subsys_state *css)
 
 static void loop_queue_work(struct loop_device *lo, struct loop_cmd *cmd)
 {
+	struct request *rq = blk_mq_rq_from_pdu(cmd);
 	struct rb_node **node, *parent = NULL;
 	struct loop_worker *cur_worker, *worker = NULL;
 	struct work_struct *work;
@@ -860,6 +861,9 @@ static void loop_queue_work(struct loop_device *lo, struct loop_cmd *cmd)
 		work = &lo->rootcg_work;
 		cmd_list = &lo->rootcg_cmd_list;
 	}
+
+	rq->cmd_flags &= ~REQ_NOWAIT;
+
 	list_add_tail(&cmd->list_entry, cmd_list);
 	queue_work(lo->workqueue, work);
 	spin_unlock_irq(&lo->lo_work_lock);
-- 
2.40.0

