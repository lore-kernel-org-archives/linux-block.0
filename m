Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794913934;
	b=r6Z+SB8B7W6esqzxYNJCBmJGnTX+fTD6XgiFc93k1QAMqaUZhQPhKQ312eyhE5tnv1lb
	 2mniGSh5AYLdveJD5xlCYIIjtICU2BObXpqyTo7nSHBA31tJoA4D7I6oUlJVQWQ+zqcwW
	 BjXjh/25ZPhhak5xMPgwxBB2D4F6nLXhYlRl+QF8+S/dIQQ4jmUwX/sZD8/zS0502Gz0a
	 kz3/qkPMzQGnzagpUa+B0mrRlhxTLQSQKLhtZ5zjkvtkxC3AACi+z2fNPusTvfqqpqVyI
	 lybEPlZ2dxxjIH7Ov0Z0OIZSol56i1+gLOivHHXM08yosQu9K0Z46cO8c/PCESDBsUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794913934;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YpT6onB1YW1VQSPE7BNmbI9BqwBaWK5/0IYsluHOeG0=;
	b=vzAWDD3nzxh4RyOUPnricvSjQt0qaHJ6cJVbtYAAJ93oSN4MljlgePhwKDrJSDUw2ka3
	 59Pq24HVxI9yJyTw8A29czXbM/KrY/vIqWEndZeEjFrZ9QrxuQvdUvLY5Nh3ErvLWOiWc
	 s6rnuMl+ADZS3S3N/DJwPJJE0mlZ/x23dSvq7EG8UuMHgyvjKvxOtQqkZigag32NdnTCa
	 36Zlc5fNZjiDoBi17AD3yXEK/kl/kPNlhV0aresqk/46EzIvbF7KlpOVPg568QPIEIy9P
	 RB+ZOoYFBHctTQa4jnWqYaOlD17tijRhLmtIMTMmkFbmTsrccCFdRa+EkLPbfPOWuLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g4LDFMlr;
	arc=none smtp.remote-ip=74.125.227.137
Received: from mail-pj2-f9.google.com (mail-pj2-f9.google.com [74.125.227.137])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E427606A323
	for <linux-block@vger.kernel.org>; Tue, 17 Nov 2026 11:12:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E427606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g4LDFMlr
Received: by mail-pj2-f9.google.com with SMTP id 98e67ed59e1d1-3b18c01238eso1418254a91.1
        for <linux-block@vger.kernel.org>; Tue, 17 Nov 2026 03:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794913934; x=1795518734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YpT6onB1YW1VQSPE7BNmbI9BqwBaWK5/0IYsluHOeG0=;
        b=g4LDFMlrT5xVMlwDAzPW6YO9fwosGC32nZ8FGPwgQ929gmyDlQJBvF7cdWdtE5cxbq
         AA6oag+4HbkPqb5A/aS7cQ4Bypozy14dRYwQxivHjjckNYbKALh6Ybs1Z7iDxwNl/Dyj
         3bNGFHApW4Gms7Rlml3EwnhUunTz07O8k7AdJCwqgbdkhFFsGB/mBlvAAuaBXhQp5F5B
         yP9ah/qyo7/dBzUkKidSA7HDL2e4UIAXIOEctXKSFChg7Nvlmj4R7zRQChhww6K0a8v4
         CcWf9ImLVQjogHY99Igr9wpp0wJo0BAmtRM0xDYMWq5PSOmIaoOWCfzdrtwx+F869Rw0
         qcGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794913934; x=1795518734;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YpT6onB1YW1VQSPE7BNmbI9BqwBaWK5/0IYsluHOeG0=;
        b=PpijLwvoIYJl+Nz7VrkhEsX5xOuGTHZG77G9OUU+Etj1dRujfIt59qkkbiTNHi0+Un
         m5YlZM+WRReeCdieOOn2LuAjO0VIg704qruxRHNZZMHly7rJ5SEV8sM9PwSfzTzkJZFL
         xl4JdmM6O4UVtgKoif+8fRFDTLXBfNzEbJ06FXfqtG8vZYkJmQecxPOVoEBv/Y9uw5cf
         xIY0v1D4+tU3477pusidu21MQ+xfm4uA454IX1Iqescqf/vTzYZLp9dqnlYQu7eHJRIO
         W2u3H8Cd3HIj0rM692fat2hrCa6O0+U8RJqyIkDLU4yml7w2ACTrdW65iV/li/LtwG+q
         s+8g==
X-Forwarded-Encrypted: i=1; AL+hErF2f4YHTWWe/Bq/boCB+nR56ykbSASjQ50XVDJG1u7ZtjuNP8FddkoZW2NzELW9gCm2ih+pf637fCdw0Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z+DlPJCWHXwFlPtRg0mN+kJAKNxG60RoQKAcHO42yWbtsSJ8tAK
	lWIIq4FkrkcJ98MrHd8nyI+Z2gGZSHz8bWSif+rz2gwFXhnPglP6NGru
X-Gm-Gg: AZFdTZfO7mlYE16WBYHzqPqq6GY7yl38+J8IpiXnHdJO53aZo00JDsz4kfo8F8tDrRb
	sF/AadVA3T3w5wG09UciClidjVXyqSU6BxjKEl0g+bwHFsgzYAtHOO8leMt5LVcJcqoOk0JglQM
	wi3lWDAAqmRvft6TbkkX8IPNiGFUnDx2b+N2GAzhZ4z7+YlBgcR+0riQZ4RsOaKmFo7XYjO/jAf
	ipUdhcdkeXjwIj/WOaxG15MqQS5/NdKD+96danLlCyrA1Z7/W2BRFt1rlPGSIkyv/UPU6xc09pc
	XB+fwP8GlmU26HtnrDpEJZ6J3AKJ7qzNFH8iW3slwZU7P+CWW4oaRZw064BmU8G18yVao8iw9fP
	Yo1AgYGrICorIGgK8KZWfgqrsydjxNthERYEBE6OOOb1GtMGcghVBkPpZ+YOCGca/BPknaNk00V
	ZtgqBDm0bxDb5sD0Mvl/bnt+Rwjxv0Mc26pKP3kn47WITi2NJsm7JWy+qiWDmy73613y+2q70mL
	JfTJDYoErH5Ch/xZQj7TV+Li1zZK5I58sfywdtGMQeqzr6fZGHModuVsH/jT0oyGcQ7lTvd2O/t
	nB5HJ+kVOqbGXB6zR1i6eO4qI6mPAZj6zccgyj9UPs6/qa/LSfAX7p72khS/TJVUAxBns2buBKv
	JSmPW/ZvFx5bZpr5nLp603dcZmDyZyJsuf8uOww==
X-Received: by 2002:a17:90b:3b8a:b0:3b0:9f53:e8a8 with SMTP id 98e67ed59e1d1-3b1b0b5f2c1mr13037200a91.52.1794913933750;
        Tue, 17 Nov 2026 03:12:13 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3b6da0fa8sm2752958a91.9.2026.11.17.03.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 03:12:13 -0800 (PST)
From: Hungyu Lin <dennylin0707@gmail.com>
To: axboe@kernel.dk
Cc: tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	josef@toxicpanda.com,
	bvanassche@acm.org,
	cuitao@kylinos.cn,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dennylin0707@gmail.com
Subject: [PATCH v2] blk-ioprio: check capabilities before promoting a cgroup to RT
Date: Tue, 17 Nov 2026 11:11:57 +0000
Message-ID: <20261117111157.2968-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ioprio_set() and the per-request I/O priority of aio and io_uring only
hand out IOPRIO_CLASS_RT to tasks that have CAP_SYS_ADMIN or
CAP_SYS_NICE. The io.prio.class cgroup attribute has no such check.
Writing "promote-to-rt", or its alias "none-to-rt", to it changes the
requests of the cgroup to the RT class.

The attribute exists in every cgroup that has the io controller enabled
and it is not hierarchical. A user that got a cgroup delegated owns the
files of the child cgroups it creates there, so it can create a child
cgroup, move into it and write "promote-to-rt" to its io.prio.class.
Its requests are then issued with IOPRIO_CLASS_RT although ioprio_set()
fails with -EPERM for the same task, and mq-deadline dispatches them
before the best-effort requests of everybody else.

The delegation model in Documentation/admin-guide/cgroup-v2.rst expects
the settings of all resource controllers to be hierarchical, so that a
delegatee can only distribute further what it received from its parent.
This attribute lets it raise the priority class of its own requests
instead.

Require CAP_SYS_ADMIN or CAP_SYS_NICE for the two policies that raise
the priority class, like ioprio_check_cap() does. Check the credentials
of the task that opened the file, like cgroup_release_agent_write()
does, so that the check cannot be bypassed by passing the file
descriptor to a privileged program. The other policies are left alone.

Fixes: 556910e39249 ("block: Introduce the ioprio rq-qos policy")
Cc: stable@vger.kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
Changes in v2:
- Check the credentials of the task that opened the file with
  file_ns_capable() instead of the credentials of the writer (Bart).
- Document the requirement in cgroup-v2.rst (Bart).

v1: https://lore.kernel.org/all/20261116090529.69650-1-dennylin0707@gmail.com/

 Documentation/admin-guide/cgroup-v2.rst | 3 +++
 block/blk-ioprio.c                      | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 9e3c67b02ae2..4424f9cf583e 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2409,6 +2409,9 @@ that attribute:
   none-to-rt
 	Deprecated. Just an alias for promote-to-rt.
 
+Selecting promote-to-rt or none-to-rt requires CAP_SYS_ADMIN or CAP_SYS_NICE
+in the initial user namespace.
+
 The following numerical values are associated with the I/O priority policies:
 
 +----------------+---+
diff --git a/block/blk-ioprio.c b/block/blk-ioprio.c
index 8fa8bca35062..acec62ee94bd 100644
--- a/block/blk-ioprio.c
+++ b/block/blk-ioprio.c
@@ -14,6 +14,8 @@
 
 #include <linux/blk-mq.h>
 #include <linux/blk_types.h>
+#include <linux/capability.h>
+#include <linux/cred.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include "blk-cgroup.h"
@@ -91,6 +93,10 @@ static ssize_t ioprio_set_prio_policy(struct kernfs_open_file *of, char *buf,
 	ret = sysfs_match_string(policy_name, buf);
 	if (ret < 0)
 		return ret;
+	if ((ret == POLICY_PROMOTE_TO_RT || ret == POLICY_NONE_TO_RT) &&
+	    !file_ns_capable(of->file, &init_user_ns, CAP_SYS_ADMIN) &&
+	    !file_ns_capable(of->file, &init_user_ns, CAP_SYS_NICE))
+		return -EPERM;
 	blkcg->prio_policy = ret;
 	return nbytes;
 }
-- 
2.43.0

