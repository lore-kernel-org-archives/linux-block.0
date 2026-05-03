Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5F539524B
	for <linux-block@vger.kernel.org>; Sun,  3 May 2026 03:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777780627; cv=none; b=j7vcPPW/+8IT7Gay6XuuXlXZ+EJy2Z0eMQXxuviXQucn4YMoATNLWQmoT0i9MjaFkPscRdpHilikkpU9AuETgIUDTV5T5rL4ZKX/EZRdnKBo5W00Y9I6wHS01ji8wQuDIJEDOZHQS42dNz9opuDMnMJ7mqJsl+s/PwbU0+SoFWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777780627; c=relaxed/simple;
	bh=6G4wKlX0zo1jHPqX7RH9W8wPuQmHfTUtMAViJ7TEYLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GaxMkrp1Bbmfxrn5yWjBgnUFaBU8VQUDIzA9cLvSmxptHV0+WdrZEnYp1w+GAbUe2CXbZqaEuJbLHMVqOlOfyGbV0hT6PnL761uavH7xYLzaTtEJmET/c4UacCWkH17tJejZNNHF90oIc4Vef50sfwEGrAYa0TBx2k7xKUPLCZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=duXzc8O7; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="duXzc8O7"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777780623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QDbfqpo/kWoDEd8LDUkjAyHgL8/MvRl9aZnHCn01hLw=;
	b=duXzc8O7x2poXRdeV0qKBWwaBHQEumGyZ8rve9ETVOWt7Qd4e8U9Ffc0DEE7ASz4Jgdccq
	VGBXDDKEM+JAoaqVSjNMwRwaxRH5l4padCwaIgDa50OvgF1jEVqosAAXRBw4V5as0OV4E8
	EqaWuwkvf96ian4JWrLtXMSGR8c5qzk=
From: Kaitao cheng <kaitao.cheng@linux.dev>
To: axboe@kernel.dk,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	john.fastabend@gmail.com
Cc: bpf@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kaitao Cheng <chengkaitao@kylinos.cn>
Subject: [RFC v2 1/3] bpf: Add KF_SPIN_LOCK flag for kfuncs under bpf_spin_lock
Date: Sun,  3 May 2026 11:56:21 +0800
Message-ID: <20260503035623.28771-2-kaitao.cheng@linux.dev>
In-Reply-To: <20260503035623.28771-1-kaitao.cheng@linux.dev>
References: <20260503035623.28771-1-kaitao.cheng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Kaitao Cheng <chengkaitao@kylinos.cn>

Introduce the KF_SPIN_LOCK kfunc metadata flag in BTF so kfuncs may be
explicitly marked as safe to call while holding bpf_spin_lock.

Allow kfuncs defined in kernel modules to be marked with KF_SPIN_LOCK.

Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
---
 include/linux/btf.h   |  1 +
 kernel/bpf/verifier.c | 20 +++++++++++++++-----
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index c82d0d689059..08d8a023ffe6 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -79,6 +79,7 @@
 #define KF_ARENA_ARG1   (1 << 14) /* kfunc takes an arena pointer as its first argument */
 #define KF_ARENA_ARG2   (1 << 15) /* kfunc takes an arena pointer as its second argument */
 #define KF_IMPLICIT_ARGS (1 << 16) /* kfunc has implicit arguments supplied by the verifier */
+#define KF_SPIN_LOCK    (1 << 17) /* kfunc is allowed inside bpf_spin_lock-ed region */
 
 /*
  * Tag marking a kernel function as a kfunc. This is meant to minimize the
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4d78d834c609..cffba6a714f3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11403,11 +11403,21 @@ static bool is_bpf_stream_kfunc(u32 btf_id)
 	       btf_id == special_kfunc_list[KF_bpf_stream_print_stack];
 }
 
-static bool kfunc_spin_allowed(u32 btf_id)
+static bool kfunc_spin_allowed(struct bpf_verifier_env *env, s32 func_id, s16 offset)
 {
-	return is_bpf_graph_api_kfunc(btf_id) || is_bpf_iter_num_api_kfunc(btf_id) ||
-	       is_bpf_res_spin_lock_kfunc(btf_id) || is_bpf_arena_kfunc(btf_id) ||
-	       is_bpf_stream_kfunc(btf_id);
+	struct bpf_kfunc_meta kfunc;
+	int err;
+
+	if (is_bpf_graph_api_kfunc(func_id) || is_bpf_iter_num_api_kfunc(func_id) ||
+	    is_bpf_res_spin_lock_kfunc(func_id) || is_bpf_arena_kfunc(func_id) ||
+	    is_bpf_stream_kfunc(func_id))
+		return true;
+
+	err = fetch_kfunc_meta(env, func_id, offset, &kfunc);
+	if (err || !kfunc.flags)
+		return false;
+
+	return *kfunc.flags & KF_SPIN_LOCK;
 }
 
 static bool is_sync_callback_calling_kfunc(u32 btf_id)
@@ -17025,7 +17035,7 @@ static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
 				     insn->imm != BPF_FUNC_spin_unlock &&
 				     insn->imm != BPF_FUNC_kptr_xchg) ||
 				    (insn->src_reg == BPF_PSEUDO_KFUNC_CALL &&
-				     (insn->off != 0 || !kfunc_spin_allowed(insn->imm)))) {
+				     !kfunc_spin_allowed(env, insn->imm, insn->off))) {
 					verbose(env,
 						"function calls are not allowed while holding a lock\n");
 					return -EINVAL;
-- 
2.50.1 (Apple Git-155)

