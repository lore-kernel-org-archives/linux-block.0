Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACC4272E41
	for <linux-block@vger.kernel.org>; Thu,  4 Sep 2025 03:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756955995; cv=none; b=PImO37YBOsiXtZii3+PmQ4artdr8D8EZji5dBH2oSboWBV5XqfvvxVNWdmco+ZxQYe2/G56OOpeQkC2WhTatPB5cnbrpvv5YLbij77rrwLoUkVI3LLdgrRukQZuh/1YFlVjq3ATzM02UJ+sdYoR64cBg02KdhvLvDzO8WS7LVLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756955995; c=relaxed/simple;
	bh=RTId2bcFt1iHsAEfnkVSHU9E8Vj/59eBZrHfC4oUOYU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PH12rGCtolDcUqS44jw2LsKiskeRPH5h5gguL0HJi0jOFOWJ+EGkSp0a4Y9Ls4kB6fUSDLD0MXdovvhjGh0RtLqq3luWLy5e3PQ8UT1w5YcWBQ+46M25NZ5ar9qO7oe+9IjACW4CNxIk5u08Ld58SKrXjELvxz8whx9AnkFM4KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iie.ac.cn; spf=pass smtp.mailfrom=iie.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iie.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iie.ac.cn
Received: from localhost.localdomain (unknown [159.226.95.28])
	by APP-03 (Coremail) with SMTP id rQCowACH14HeA7looDlqAA--.21165S2;
	Thu, 04 Sep 2025 11:13:37 +0800 (CST)
From: Chen Yufeng <chenyufeng@iie.ac.cn>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	Chen Yufeng <chenyufeng@iie.ac.cn>
Subject: [PATCH] Sanitize set_task_ioprio() permission checks
Date: Thu,  4 Sep 2025 11:13:12 +0800
Message-ID: <20250904031312.887-1-chenyufeng@iie.ac.cn>
X-Mailer: git-send-email 2.43.0.windows.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowACH14HeA7looDlqAA--.21165S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AFy7GrW7CF45KFW5AF17GFg_yoW8Wr4rpF
	ZIkFyYgrZrKa4IkFs2ya1IvFy8J3s5WFZ7ZasxKa1a9wnrZrnFkF9ayw1FqrySqr4fAa13
	XFyjqrW7Zr1Du3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyG14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F
	4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
	k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbrMaUUUUUU==
X-CM-SenderInfo: xfkh05xxih0wo6llvhldfou0/1tbiDAYPEmi4wjv1vAAAs3

A patch similar to commit 197e7e521384("Sanitize 'move_pages()' permission 
checks").

The set_task_ioprio function is responsible for setting the IO priority of a 
specified process. The current implementation only checks if the target 
process's uid matches the calling process's euid/uid, or if the caller has the 
CAP_SYS_NICE capability. This permission check is too permissive and allows a 
user to modify the IO priority of other processes with the same uid, including 
privileged or system processes.

Local users can affect the IO scheduling of other processes with the same 
uid, including suid binaries and system services, potentially causing denial 
of service (DoS) or performance degradation.

So change the access checks to the more common 'ptrace_may_access()'
model instead.

Signed-off-by: Chen Yufeng <chenyufeng@iie.ac.cn>
---
 block/blk-ioc.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/block/blk-ioc.c b/block/blk-ioc.c
index 9fda3906e5f5..bd3e556809c5 100644
--- a/block/blk-ioc.c
+++ b/block/blk-ioc.c
@@ -244,12 +244,9 @@ static struct io_context *alloc_io_context(gfp_t gfp_flags, int node)
 int set_task_ioprio(struct task_struct *task, int ioprio)
 {
 	int err;
-	const struct cred *cred = current_cred(), *tcred;
 
 	rcu_read_lock();
-	tcred = __task_cred(task);
-	if (!uid_eq(tcred->uid, cred->euid) &&
-	    !uid_eq(tcred->uid, cred->uid) && !capable(CAP_SYS_NICE)) {
+	if (!ptrace_may_access(task, PTRACE_MODE_READ_REALCREDS)) {
 		rcu_read_unlock();
 		return -EPERM;
 	}
-- 
2.34.1

