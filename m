Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7633A7198
	for <linux-block@vger.kernel.org>; Mon,  7 Sep 2026 06:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788763311; cv=none; b=XZVjPU1uI3aeO92lwLlL6IzJbjcD90RsvAiXRfED57Xvs5YsutefArQ1N0if1cUIsMCO2nsCOooABiDp0zVUt3aPsvZ2ZbR2WODv8sUKVspO49DjZUR8/upQibl5spnMuA2JuuTJi+kvBnkRhbhISaH2YYiFxYw1mb6pCYx3AhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788763311; c=relaxed/simple;
	bh=eafPgUhy9IynSAtvFbXAit1hK6ESnxmns9zqLM/jKZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iD4BO+hme+rHL6xcz4sX4prhIfKltS2DxHB5U6tSKhnVkrUBdWEKostApJd6znE46WuUSLhgkMriYrrecr6cyUhS0F/7j0mDylQiolqf+X0hT/DfkhwdNSf8yx1VjM6NJOJYtu+4PX3zDqI/JJGXXMNtIyfzsV2b838RibKMOqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e+xAe+Bo; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+xAe+Bo"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-398d2b28acfso2258034a91.1
        for <linux-block@vger.kernel.org>; Sun, 06 Sep 2026 23:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788763309; x=1789368109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AeK2I1AiWRpjY7VAGe4JrwBL3S2TxoFeFpHn4sVFSG4=;
        b=e+xAe+Bo0nwJI5oTNV94ciTCBgdy2KejrvEjAMDuSqgoRVOI64A62mILLxFCvhC1aZ
         /PRTqjm6Gj29RCLscxvM0fGwb+xKx//LzPP/4mVB0VGPonwPvyqXFHv8YvjV/7+2zwB2
         AMj482hST5UTYoQCQg/Co3sNVhYpGvAjhTtde3s/wJxjp2MOiIs8Xk0aiFUehuX/1kbA
         qaHTUg0eaSbyHGCNjWZhH+ukQoqA1sHk8IfOuXcdk3yIeU/fqiQbkqSiehgY8S96JXNp
         44klfgp+18i0gQWBXAiTlQH4vVvwIvFlGKo2x50shy4PomIN+0RcaWir+25YhLS86Bo2
         7p3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788763309; x=1789368109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AeK2I1AiWRpjY7VAGe4JrwBL3S2TxoFeFpHn4sVFSG4=;
        b=Umv33fVXs36/LSUWCrbEv1gA/y9JBZh0KpWbefaQJYiABFVDlbxRvmEvf4GPos3Cyr
         QqohnlLfKsB9UiH+j7csEbQT8+V7sGWDWPCKjsEySzDren0zptr/wKuilyVPwAa46abr
         DWdrm2uyGiIUlDC3xNh9tuEMX886lcEUET6yHsw+FqNdoC6n519QiobjhTFXbndJVwq/
         y2OawpBB3cNfFJle+eS6LZQJIZUFeA/YdqlLyt8qBalYWHxxMSpDKcv7nbAIoebdKoIQ
         5oxgAC3AGlBJ58oiPjJVFxF49LXNzAwyazYX/3WvjojFGSYLfkKYlVc6HHuvCMdkna0O
         SRqQ==
X-Forwarded-Encrypted: i=1; AKwUvBw/unNadPzeGvZlMVU9sDlyMVc7zfEWLKWZj91ljVOCQEH84DHjKgST+4ZjIOJ/fkhJDysg4Ai4s8Sc/w==@vger.kernel.org
X-Gm-Message-State: AFuF++m349iLcwHN2xP+uZx5qvOV/E/27+UYyl9TK2fo0Uuh8pAzONvb
	EaSGodeHIM6BgEgMd4hutvcD4D8o61tAt1Ap/ppCmsrzIvTv0FqvF9lA
X-Gm-Gg: AYBFou3iMTy58NLL3nESdNl58OJ2M2UnqS4BZjHiLGBTopkvggYhPcsupJ6s+bVcHSm
	alWvu5+ux2AH94O9tcyeY62cRGugsBt7LXjdcDcsZNWzYGnyG/tPuzVKv2Psb+JFfyYEREbqumh
	qqZKKxNka03mNxff+z13N+d1brNwtUbF5LjfZcawwYosuAcGGH/efEgo9FVBYiIcG4zr0aicNXt
	ZW7dAn5wl7BHGcwAVy5BThWdE+OX6RAZtfU0SBT3Xp9GjAHXiovUhe1GE+lJWW9DhW3rmZKD2J0
	/5IpyDBfF4EKmdH/5t9IxuY58+KZu021UKy02kcxlKlMPJxMc+C/2Icfmm6SwEBkCikFWR495cJ
	cRjOF9bHSSXHe7qbJRO51FMwgMlnrT9vsS3AMXjwpszsE7VTAN/BI3JCbvavF+g0phu+Fmi9k9w
	05mFQQiwCHgNC6eSb5P+81vOoTCEcvdIhCi7CjfR6Gkf2l+7NsCFB0qt+RNtzRA/kF3P/YSY9lh
	nohWjHyDqnHgSgTypWCRbSW
X-Received: by 2002:a17:90b:2808:b0:398:b46d:48c0 with SMTP id 98e67ed59e1d1-39b262aaeb7mr33803957a91.18.1788763309146;
        Sun, 06 Sep 2026 23:41:49 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-143240d86c3sm22413038c88.0.2026.09.06.23.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 23:41:48 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Shuah Khan <shuah@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	x86@kernel.org,
	Dave Martin <Dave.Martin@arm.com>,
	James Morse <james.morse@arm.com>,
	Babu Moger <babu.moger@amd.com>,
	Ming Lei <tom.leiming@gmail.com>
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH 1/2] selftests: fix typos in comments
Date: Mon,  7 Sep 2026 12:11:37 +0530
Message-ID: <20260907064138.38689-2-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260907064138.38689-1-hemanth.selam@gmail.com>
References: <20260907064138.38689-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos in comments, reported by scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt.  Only touches comments, no code
changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 tools/testing/selftests/amd-pstate/tbench.sh | 4 ++--
 tools/testing/selftests/proc/setns-dcache.c  | 2 +-
 tools/testing/selftests/proc/setns-sysvipc.c | 2 +-
 tools/testing/selftests/resctrl/resctrlfs.c  | 6 +++---
 tools/testing/selftests/ublk/kublk.h         | 2 +-
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/amd-pstate/tbench.sh b/tools/testing/selftests/amd-pstate/tbench.sh
index 2a98d9c9202e..b54b9d0396a1 100755
--- a/tools/testing/selftests/amd-pstate/tbench.sh
+++ b/tools/testing/selftests/amd-pstate/tbench.sh
@@ -103,7 +103,7 @@ parse_tbench()
 	en_sum=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum}' $OUTFILE_TBENCH-energy-$1-$2.log)
 	printf "Tbench-$1-#$2 power consumption(J): $en_sum\n" | tee -a $OUTFILE_TBENCH.result
 
-	# Permance is throughput per second, denoted T/t, where T is throught rendered in t seconds.
+	# Permance is throughput per second, denoted T/t, where T is through rendered in t seconds.
 	# It is well known that P=E/t, where P is power measured in watts(W), E is energy measured in joules(J),
 	# and t is time measured in seconds(s). This means that performance per watt becomes
 	#       T/t   T/t    T
@@ -161,7 +161,7 @@ gather_tbench()
 	avg_en=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum/'$LOOP_TIMES'}' $OUTFILE_TBENCH-energy-$1.log)
 	printf "Tbench-$1 avg power consumption(J): $avg_en\n" | tee -a $OUTFILE_TBENCH.result
 
-	# Permance is throughput per second, denoted T/t, where T is throught rendered in t seconds.
+	# Permance is throughput per second, denoted T/t, where T is through rendered in t seconds.
 	# It is well known that P=E/t, where P is power measured in watts(W), E is energy measured in joules(J),
 	# and t is time measured in seconds(s). This means that performance per watt becomes
 	#       T/t   T/t    T
diff --git a/tools/testing/selftests/proc/setns-dcache.c b/tools/testing/selftests/proc/setns-dcache.c
index 60ab197a73fc..70389832dd22 100644
--- a/tools/testing/selftests/proc/setns-dcache.c
+++ b/tools/testing/selftests/proc/setns-dcache.c
@@ -50,7 +50,7 @@ int main(void)
 
 	atexit(f);
 
-	/* Check for priviledges and syscall availability straight away. */
+	/* Check for privileges and syscall availability straight away. */
 	if (unshare(CLONE_NEWNET) == -1) {
 		if (errno == ENOSYS || errno == EPERM) {
 			return 4;
diff --git a/tools/testing/selftests/proc/setns-sysvipc.c b/tools/testing/selftests/proc/setns-sysvipc.c
index 903890c5e587..d03aa4838f0f 100644
--- a/tools/testing/selftests/proc/setns-sysvipc.c
+++ b/tools/testing/selftests/proc/setns-sysvipc.c
@@ -49,7 +49,7 @@ int main(void)
 
 	atexit(f);
 
-	/* Check for priviledges and syscall availability straight away. */
+	/* Check for privileges and syscall availability straight away. */
 	if (unshare(CLONE_NEWIPC) == -1) {
 		if (errno == ENOSYS || errno == EPERM) {
 			return 4;
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index b9c1bfb6cc02..b6d69bf4fc1f 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -517,8 +517,8 @@ int get_mask_no_shareable(const char *cache_type, unsigned long *mask)
 
 /*
  * taskset_benchmark - Taskset PID (i.e. benchmark) to a specified cpu
- * @bm_pid:		PID that should be binded
- * @cpu_no:		CPU number at which the PID would be binded
+ * @bm_pid:		PID that should be bound
+ * @cpu_no:		CPU number at which the PID would be bound
  * @old_affinity:	When not NULL, set to old CPU affinity
  *
  * Return: 0 on success, < 0 on error.
@@ -693,7 +693,7 @@ int write_bm_pid_to_resctrl(pid_t bm_pid, const char *ctrlgrp, const char *mongr
  * write_schemata - Update schemata of a con_mon grp
  * @ctrlgrp:		Name of the con_mon grp
  * @schemata:		Schemata that should be updated to
- * @cpu_no:		CPU number that the benchmark PID is binded to
+ * @cpu_no:		CPU number that the benchmark PID is bound to
  * @resource:		Resctrl resource (Eg: MB, L3, L2, etc.)
  *
  * Update schemata of a con_mon grp *only* if requested resctrl resource is
diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index d98f3d612d88..88248b802c86 100644
--- a/tools/testing/selftests/ublk/kublk.h
+++ b/tools/testing/selftests/ublk/kublk.h
@@ -257,7 +257,7 @@ struct ublk_thread {
 	unsigned short nr_bufs;
 	unsigned short auto_buf_stride;
 
-       /* followings are for BATCH_IO */
+       /* following are for BATCH_IO */
 	unsigned short commit_buf_start;
 	unsigned char  commit_buf_elem_size;
        /*
-- 
2.48.1

