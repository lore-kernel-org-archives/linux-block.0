Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.128
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795189191;
	b=hhKEJPoXT2QelfC02XDlGhOwEVWvljDfHflE8aXCNmBw2VT9EzOcYxyaGJhLhMLITEjy
	 KbRb7CikhyJc9AjB4FmJyLJp1/vVWMrzaSs3FVnYBECHWEyQi2Oi54poAnE1/fd018c/j
	 OrKfqrsesZcX5BMqTsioHikjR3G3t1BlTGBKcKEb6BFlz0+ENuvWGVh8EUaZz4JqPHWQ9
	 ZI86a7gsKfRNrBa7LZc5OlvpyGkF5aESvuvqcfyy63a88oHylxrLdX2grTJf0UvcZb2of
	 RXewN6e4M/BI4qXf/nH2rs5b7m1G+3HjGHmcft58snVv742C0I8i5Un9pyuQDVrCIAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795189191;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jn+/Prnek8JqUOnxYbtVgNU+Atd7uT15342oBo1hEcs=;
	b=AHkBCO+JpkxGEOp0ghcUGFhIbVbeiiEnXRUyGZ83LzD5x5TGJyoZst1przKWVS5OzjMK
	 DTGaCFan4bRwH8PXsSCoR8drLmLKLTqyQgv7HQ/WQwedzfVFaWtWQ7YY/aIkDv4OT0yGT
	 Tq4KdD9IAYkssHf8vomdA1um4c3gDSQknBouvpq2/i2ACCD7nYRQoGJETp9S4z+rmhUgO
	 Hwf/+aNGzFYi1L1eyrgTzo4s7fVHfBb1YFLYQuBuYM4kG32YAjQfJ1ypCih2hKndaYzuU
	 OmveHdtiSOcV1UKCpfCrwJOU8R/+8WAKHuef5/+Rjo6R3SlSb07yKAuzDhWZmbDrcqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Bx687rB1;
	arc=none smtp.remote-ip=74.125.231.128
Received: from mail-oo2-f0.google.com (mail-oo2-f0.google.com [74.125.231.128])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54EF606A331
	for <linux-block@vger.kernel.org>; Fri, 20 Nov 2026 15:39:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E54EF606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Bx687rB1
Received: by mail-oo2-f0.google.com with SMTP id 006d021491bc7-71af372c22cso267252eaf.1
        for <linux-block@vger.kernel.org>; Fri, 20 Nov 2026 07:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795189190; x=1795793990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jn+/Prnek8JqUOnxYbtVgNU+Atd7uT15342oBo1hEcs=;
        b=Bx687rB12yGEl1N7bKZ0d2BpxUpChnr56saZNNmjNyJ6Yhb2Ff3oHO4n1ObwWJwRJo
         0pwsXCN8T0gNuVHW1v8LzGehH0brcqX1h8x/cUbE5/zxq1eA+/Vd/jllr+90jk2ZDYOU
         6tl5q+rvrc6sI62Ho4xRBNpPoQLgdDBSJDdqV88+FrupfpttK0jNBWY+eafEIHtbAihr
         GtRvZ26mJxnSsoLcxfp9XyausfXJF9U3gYjWu8A2axIUjwS97bBQaOkeHNx6YtptEki6
         0uEa5KWJLrOUcRgCL5cA2d+D1xHBp2EP0lJF69eXy/dXAGWcaYRmk2HavCf6OV1xYGAL
         0rPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795189190; x=1795793990;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jn+/Prnek8JqUOnxYbtVgNU+Atd7uT15342oBo1hEcs=;
        b=i8Ofz42A1ftVfQKCWOqkU/tWcFihF43ryNJHk/tds/FF6O5lnW5RiDf1/wIeWyjfZz
         nrG4VK52Ww9xsRqzdsNGV+fbQ4cyohkkVKeSV8mj01qln42NLiZg7o28Dkyyd6fM9qu4
         H0fIMlji10iePs2NhiQXyFPMawZ5uBGYSfgxIX4tzLfztTovwFY2zyMJKFxUPkhY4L5n
         PCKKvTrl7rFzokwgccK7RF8iENNslZfnMd76b1sPOP6voUcuzfJ7NypmgIPG9BwaL/at
         lV0yVaqDkDf8vONkh23MIuMBzyf1wOb4tV1l1R/O9PL1O+S1ZI9FH76xfJuW1/6HOhrr
         v/ZA==
X-Forwarded-Encrypted: i=1; AL+hErHYk/nsoPxKNkvmhfDMT67VzLD2ZlRPpTWF9Wun8dfRDusZKswfGGII0CvaKyXOUoypgqG9VAAAoo1GYQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z8Z9ENfKG+qn2pMtuFL4LW+RShyW9Emv3YM+or/OfhiltTn+CGB
	m6Or5ZIIayIStQHLpcJmh1FQs94zO8Blr2pdqp8vIvsv88U/BQyvIU8qNfkqlas7heeBnRlC
X-Gm-Gg: AYBFou2XcIEkxFxE2zbdAKD21mrcaqiknxcvZMUTbIAztRoh6jqeb4meDRd6BeIlVGR
	eFV3deROHD1KqqDU8+lcn3ZVhbU+d9zfSjffGalCd5nSWUb+6z0kbTJlYfNgWrj5ZtuKl8NPCGu
	luiqwCRc8vIsGwsQVcPtl3VlsxyQ6F2c37h9o3pjekPL8+ZNWb/eH1UPEzRSmXOjefWKOBtZXSR
	FqedSCTl9fwJiIRG5Ufejkwf7c0DriqCaWjU94CD4VDkOpRUtIgeduYT9KAFVlGAvEx6cQ8iMnt
	Ay3ogTTppIx7y3vzJGfZ2CEU7RC4VXGYfdUTu6IFESCV2MXhxy3XxfPA5LJhjWBvUZtBlLjasFT
	MUGzJXRUOB2i7EW4ME2f8yWHjws+2r7LCAl3KRXfNT7fRmQPnkBjwO+JqwnZwus58fR5f7YM8nJ
	fDHVL/J0gtK4dvIPCDLunyfrtPTSt8sZpkVSevwnyEDt9VcdADRzvZo9wcSVZg+u/B5GAjfCmHg
	gFrtWJK30lBH/DvtQ81PLjmpwqM50KeOKPmNuT3qB+xk77bYuu3JJjtlqNajsspbm4949+cOdT3
	oaxYTw645sQtw4Ozl1AfO/n6SeXhJ8YcyZjFLMbrgKAZ+aEA92vqBJfDvpIUPFuA04+GUpkoHyl
	L69UQ+fffAhm2e2nc0M36Qw1Z3nanD04iFDqtEw==
X-Received: by 2002:a05:6820:c5d1:20b0:71b:c46:3ac9 with SMTP id 006d021491bc7-71b39401a4emr1770546eaf.25.1795189189676;
        Fri, 20 Nov 2026 07:39:49 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b38058102sm1950557eaf.6.2026.11.20.07.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 07:39:49 -0800 (PST)
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
Subject: [PATCH v3] blk-ioprio: check capabilities before promoting a cgroup to RT
Date: Fri, 20 Nov 2026 15:39:39 +0000
Message-ID: <20261120153939.81178-1-dennylin0707@gmail.com>
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
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
Changes in v3:
- Include <linux/user_namespace.h> instead of <linux/cred.h> for
  init_user_ns (Bart).
- Add the Reviewed-by tag from Bart.

Changes in v2:
- Check the credentials of the task that opened the file with
  file_ns_capable() instead of the credentials of the writer (Bart).
- Document the requirement in cgroup-v2.rst (Bart).

v2: https://lore.kernel.org/all/20261117111157.2968-1-dennylin0707@gmail.com/
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
index 8fa8bca35062..7fabac24dbfa 100644
--- a/block/blk-ioprio.c
+++ b/block/blk-ioprio.c
@@ -14,8 +14,10 @@
 
 #include <linux/blk-mq.h>
 #include <linux/blk_types.h>
+#include <linux/capability.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/user_namespace.h>
 #include "blk-cgroup.h"
 #include "blk-ioprio.h"
 #include "blk-rq-qos.h"
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

