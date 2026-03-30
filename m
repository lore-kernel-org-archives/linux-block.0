Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1153101A6;
	Mon, 30 Mar 2026 14:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774881408; cv=none; b=gcFVdqD1PKNCv8mUGTgGn94RqyVag6iBISo5eYVRYZah3VcQLK8jEYuRFR7IbXW0ZTnVDGzXyUu+DDOb0m+6Yi1UMTXo7dAaTp/jXcBED5znkcvT+ItUKtmzU3BKmm9DuxlxM19Rx38hiQoyTYJGSkiXzW5qGzGjLpoReE9iQvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774881408; c=relaxed/simple;
	bh=UXh2dl4L1EvGQ/qJN9Y8o6/htMWhsjl1N90/1482duQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HnLirGozlVJimAuVC5zLJNaibRIk+fIOz1GRf4Qh/kqBmUiRObD2AYnbF/QHdtFcOUdvemDYf5OAJFlj7e+c2flWEtK09vuW8gvC+2HSbDzM2uQXU8BBjKL3z/bdKByCSjq74UunqeFbmmbK+vOIJh+y1XuusN3zeo3Z1t0NMMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P8ypRhzQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P8ypRhzQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E69AC19423;
	Mon, 30 Mar 2026 14:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774881407;
	bh=UXh2dl4L1EvGQ/qJN9Y8o6/htMWhsjl1N90/1482duQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=P8ypRhzQMC0yedPqARnRzUtP5I57SRQI9aXnlUCeHmeHnzBSSr49ST4q/WDME09zO
	 ej2KlYNXLvZSlEUM+HKb9FjzLytYIlnVAGKrQb0RQYTl+9q4LB3H/aNBJFnWOpd1zF
	 1t22xMufUdGKcCL9oYB9GvtBotvW5F0OGt/9SoUk5QsHQVG5J601YQ8mzeFqSqFYnR
	 KiPo0B8tAoOU4cQ2aAEpjx71QH1XnjpuaGnPdmzN1BMIDOE6kTHmgJrOmev3BpmGpq
	 lBXKmw7jec3ZxsaHeRW1tLmaj5w9bE8708GUhsjc3/ZAREfkiqTT7LVDiCNc3vppkJ
	 aW4PEixzCTrUA==
From: Chuck Lever <cel@kernel.org>
Date: Mon, 30 Mar 2026 10:36:30 -0400
Subject: [PATCH v2 1/2] iov: Bypass usercopy hardening for copy_to_iter()
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-bypass-user-copy-v2-1-f236179e7fd6@oracle.com>
References: <20260330-bypass-user-copy-v2-0-f236179e7fd6@oracle.com>
In-Reply-To: <20260330-bypass-user-copy-v2-0-f236179e7fd6@oracle.com>
To: Al Viro <viro@zeniv.linux.org.uk>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-hardening@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org, 
 Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3711;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=vkDqNygjZxJNc4bXE44VUc8jF1dZM3EzsNtQ7jsipmo=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBpyop+WjDbtRfqMGx8uUmIU27py/y9i2V7G2o/4
 J7zEm0gRsiJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCacqKfgAKCRAzarMzb2Z/
 l7QJEACWp/JJDO84UCavMeVEEx9EqDeLtlU4X3TEA2FT29O4g2Hj7Awwr54+v80osBobu2FCe4m
 PR+juveu6V0HyKpfl3Pl+Rf0Gqv56xC+363pNIN6/unUDPWUtKn7ToPTCOP9pnRR8RX6y9Z5xc/
 gQhdpeuTHAcayj3JxH1uMPX/FojgoBbPv1Y6q7Ms5nOOLDJUqAdEiVdVPJJ6EjQGAowmeO4Msjv
 ob+1MNOidRMULuWi8DRNljtmAIxFdJ03n2dgZ3piqXWcLrmDIivE8BsVqsa2lK4E48/1dXa0f27
 apzBYaVtcO0ZWoizItC85uRz9ff8IO59f+UryLut2Jufzfkbnq4f1DcT7Y0lZIvS73bPSeoHkio
 4tfdklicamskMznzxMiv3NA0ckbftL2lMWeX/gZWAm5k0qlOZoQMAbFr8vL43KwKqJNZYgegN7L
 5Y4K0cC72pxpycKL6YEDaq1i6jvmBCRVi4wAz8tJBq0OZnz+PBlSk1Zv1dVobaA28Ec3hWr7LCX
 SqV7u0wmd7xSjg/ilJjaanvQe2gDW1/7ckBw0XLoQdwdxr5/eiCpa9vNbz8jeNeu4EkMYoD1/bu
 1/4hKrvZx8nNC4G+HD8BUqfj42D0XZGnxkcDIOmfzERRztdDxkd9z4BqJtlefWfobbeYO4MLUVi
 fm0Fqc0teUNLrNA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97

From: Chuck Lever <chuck.lever@oracle.com>

Profiling NFSD under an iozone workload showed that hardened
usercopy checks consume roughly 1.3% of CPU in the TCP receive
path. The runtime check in check_object_size() validates that
copy buffers reside in expected kernel memory regions (slab,
stack, and non-text), which is meaningful when data crosses
the user/kernel boundary but adds no value when both source
and destination are kernel addresses.

Split check_copy_size() so that copy_to_iter() can bypass
the runtime check_object_size() call for non-user-backed
iterators (ITER_KVEC, ITER_BVEC, ITER_FOLIOQ, ITER_XARRAY,
and ITER_DISCARD). Existing callers of check_copy_size() are
unaffected; user-backed iterators still receive the full
usercopy validation.

This benefits all kernel consumers of copy_to_iter(),
including the TCP receive path used by the NFS client and
server, NVMe-TCP, and any other subsystem that uses
non-user-backed receive buffers.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/ucopysize.h      | 16 +++++++++++++++-
 include/linux/uio.h            |  9 +++++++--
 tools/virtio/linux/ucopysize.h |  6 ++++++
 3 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/include/linux/ucopysize.h b/include/linux/ucopysize.h
index 41c2d9720466..d187108f845a 100644
--- a/include/linux/ucopysize.h
+++ b/include/linux/ucopysize.h
@@ -41,8 +41,14 @@ static inline void copy_overflow(int size, unsigned long count)
 		__copy_overflow(size, count);
 }
 
+/*
+ * Copy size validation without usercopy hardening. Checks
+ * compile-time object size and runtime overflow, but skips
+ * check_object_size(). Use check_copy_size() when @addr
+ * may point to userspace-accessible memory.
+ */
 static __always_inline __must_check bool
-check_copy_size(const void *addr, size_t bytes, bool is_source)
+__compiletime_check_copy_size(const void *addr, size_t bytes, bool is_source)
 {
 	int sz = __builtin_object_size(addr, 0);
 	if (unlikely(sz >= 0 && sz < bytes)) {
@@ -56,6 +62,14 @@ check_copy_size(const void *addr, size_t bytes, bool is_source)
 	}
 	if (WARN_ON_ONCE(bytes > INT_MAX))
 		return false;
+	return true;
+}
+
+static __always_inline __must_check bool
+check_copy_size(const void *addr, size_t bytes, bool is_source)
+{
+	if (!__compiletime_check_copy_size(addr, bytes, is_source))
+		return false;
 	check_object_size(addr, bytes, is_source);
 	return true;
 }
diff --git a/include/linux/uio.h b/include/linux/uio.h
index a9bc5b3067e3..45b323e4be97 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -216,8 +216,13 @@ size_t copy_page_to_iter_nofault(struct page *page, unsigned offset,
 static __always_inline __must_check
 size_t copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
 {
-	if (check_copy_size(addr, bytes, true))
-		return _copy_to_iter(addr, bytes, i);
+	if (user_backed_iter(i)) {
+		if (check_copy_size(addr, bytes, true))
+			return _copy_to_iter(addr, bytes, i);
+	} else {
+		if (__compiletime_check_copy_size(addr, bytes, true))
+			return _copy_to_iter(addr, bytes, i);
+	}
 	return 0;
 }
 
diff --git a/tools/virtio/linux/ucopysize.h b/tools/virtio/linux/ucopysize.h
index 8beb7755d060..a330e14c81c5 100644
--- a/tools/virtio/linux/ucopysize.h
+++ b/tools/virtio/linux/ucopysize.h
@@ -12,6 +12,12 @@ static inline void copy_overflow(int size, unsigned long count)
 {
 }
 
+static __always_inline __must_check bool
+__compiletime_check_copy_size(const void *addr, size_t bytes, bool is_source)
+{
+	return true;
+}
+
 static __always_inline __must_check bool
 check_copy_size(const void *addr, size_t bytes, bool is_source)
 {

-- 
2.53.0

