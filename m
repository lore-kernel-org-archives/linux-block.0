Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA78E3126CA;
	Mon, 30 Mar 2026 14:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774881409; cv=none; b=a4/v/rWf5yXanMo8hChFPLkWM8o9o+SyI9pZEMV+yxBn5Xkb5ldAsV6LkqUcEXewdswAjMEYSDe5UN328xKG0Jyiqs/1stjrpDD4xttGAwCmXH5L66CCpkQ5ckDNQi4Bul0JlFRW8TlJ3jIkoSQTB9ikcYX5Ch/Z0bSXAKv06f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774881409; c=relaxed/simple;
	bh=vVpoliyR40NMOAyv7YwOY69cjLV5eHd75JGozhwhf3c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bRS1xA+fkxL1ZST2qbkca6Ta66575uhBZ7jw6pNhx5hFe5eFRjIRKjANPXsGiDsAJJcSQ8Nk0aM+hbKpzPnAIHvxT78Zoh/75LWS9zYZ2YQsB+Ezmrdc9SJjtlFpUpCKJsxUOGUwJDMQxtDPX+m8Tk4wfw7ZE6mNz4cpn0jg/mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g9tVYo+/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g9tVYo+/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F4091C2BCB9;
	Mon, 30 Mar 2026 14:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774881408;
	bh=vVpoliyR40NMOAyv7YwOY69cjLV5eHd75JGozhwhf3c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=g9tVYo+/wxF7ZbFPBy5BrsmsBGxZw6s4WhGQB9/yR/UrQqv5042utiEGm956nG3bf
	 upr9maz+aE31Qo9e4JhOFPjj8ke8gZBNXNIFzM6elb8qkuEAtErWzN7972MfkOlrEq
	 Qi9FHffHhHkl/zHk+hc9H81UlBO2zVV6ENP7+Ph0nOfkEcE/ocFHTeOWePLj4t0dkl
	 YsRlLjo2O4ALSGI+9u8qJ9jbmwiXTfUSAMmvn7D03yuxZl5FBtWid4qQeZJGNinPbh
	 9bmi/xBfjisA7uw/4WDilevgtyPISJC/IdGdYq1cCameHjsAJfWBhleXpSOthfLQRg
	 1WqpYy2oG8VYA==
From: Chuck Lever <cel@kernel.org>
Date: Mon, 30 Mar 2026 10:36:31 -0400
Subject: [PATCH v2 2/2] iov: Bypass usercopy hardening for copy_from_iter()
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-bypass-user-copy-v2-2-f236179e7fd6@oracle.com>
References: <20260330-bypass-user-copy-v2-0-f236179e7fd6@oracle.com>
In-Reply-To: <20260330-bypass-user-copy-v2-0-f236179e7fd6@oracle.com>
To: Al Viro <viro@zeniv.linux.org.uk>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-hardening@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org, 
 Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1509;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=Evqwgy8Dj/MjDnNEHB1BK5KAeLNE+hXXb/XaBl0KsHA=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBpyop+K2m4G+rBi+DZG2kjAF4uEGyVSY8cjPUcV
 oDs9vq/CpWJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCacqKfgAKCRAzarMzb2Z/
 l3/yD/48hBB8nIDGTQs1BDyX3zN/U97ML7/ciF4Tf0fvSOcfGRWpkGCrps93ZW5SOegcnGjAOsA
 R+4ImV+XI0a0m91AALYh3r54PkK4HZHw2EMyNuFt/8H7tLYlh3XGekwB0n+gHGvYgf40Tr3uVKp
 ss7sPtVeTKBusk6UKpHWKTQMKFSMM/MvYcP5Bsp6XGZamGFUDghKwfHy41jyFybfQzry65BpvvA
 eQXOOWn/7Y6+Y5y1hKX4ZRrPNbmHSXUjeiPXEThtTLQpufNFPlXkH9SpMxITqnUbqzONGOaEhfs
 mB3GpbI4C+oZFNPS+BEYhirjK8obBj8yEVmnyFIbDlEIR9Lxqo4SXa5fBBRVEU4jZ6eE9DjZoBM
 oZhwyF+4MFJQ6epIZQl0KFlYou2bSRiReLJCYehYw1AEY63179oRiMY1jX9HZeVTTkkmB9GKl0D
 +4y1Qr/Q33hUqeoV1mQn9t+p7WQB/BmAZzliVY5EUwdso3E4Bm/PeNjCxnPmCqOPS5ZQqEZqv4G
 M3rnqz1woNaEdw0Wa6hR98HBwPGGYZR3bPTGb/7sjx/87nKAuwBwdyVw4Kri9GHnFiZuAH/er8Y
 h9UqGZFUKBPwZ/GzjWKhpRp3a8GIlY6oegwBf+pWAN6xsKB5uKGes61XuKKPa8o0Mmh4B6++TbG
 pLeNu8CBP+cWqcQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97

From: Chuck Lever <chuck.lever@oracle.com>

The previous patch bypassed runtime usercopy validation in
copy_to_iter() for kernel-only iterators. The same overhead
exists in the copy_from_iter() path: check_object_size()
validates the destination buffer's slab residency on every
call, even when the iterator source is entirely kernel-backed
and the user-copy protection is redundant.

Apply the same bypass so that copy_from_iter() calls
__compiletime_check_copy_size() instead of the full
check_copy_size() when the iterator is not user-backed.

All current callers of copy_from_iter_nocache() pass user-space
addresses, so the same change is deferred for that wrapper.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/uio.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 45b323e4be97..5a6ad2dd5627 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -229,8 +229,13 @@ size_t copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
 static __always_inline __must_check
 size_t copy_from_iter(void *addr, size_t bytes, struct iov_iter *i)
 {
-	if (check_copy_size(addr, bytes, false))
-		return _copy_from_iter(addr, bytes, i);
+	if (user_backed_iter(i)) {
+		if (check_copy_size(addr, bytes, false))
+			return _copy_from_iter(addr, bytes, i);
+	} else {
+		if (__compiletime_check_copy_size(addr, bytes, false))
+			return _copy_from_iter(addr, bytes, i);
+	}
 	return 0;
 }
 

-- 
2.53.0

