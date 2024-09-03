Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A611D5891;
	Tue,  3 Sep 2024 20:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725394232; cv=none; b=jH0+a6K33d/xs/X55vPjljGyQWOxTnHTqo9SW8kFyq5318x4TWV+bH4ZD7W3lwjGyFG3ljWEcsGCGx6eVPHFC46TWjjK01ocKZRoUB15oyZNpmRdNvdaQQvypww3Om5Dy0en3p25k+3MWuyTC82WqyL1xWcpdmVluiM55rdqlXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725394232; c=relaxed/simple;
	bh=vpwZJNPO0XrbJLguy28wBPuADqR/WcUHSbWi9p0uZDY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BjG8VfzVCvgnX50m4399RBWn55rPjNJCcVEpY4/s+NqdshO6VaI5MSTW88vrn1RFLO2/nPhfXMg8Oj47kKJhvL1wVIPqnpVvBKhAdQuyczr5dH1/ctVt6It4oriR7rhgponPfnYwwBDNJtrwK7kQQ/OL2g9vuCYSnv6HMClc6Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qRAcwvVd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qRAcwvVd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BF10C4CEC4;
	Tue,  3 Sep 2024 20:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725394232;
	bh=vpwZJNPO0XrbJLguy28wBPuADqR/WcUHSbWi9p0uZDY=;
	h=From:To:Cc:Subject:Date:From;
	b=qRAcwvVd2eHpjA3jqDUsvYtdam6X8bME6gg5HXXUOHKZ+buSHVCOcMmKkf6zSFvtH
	 bc0WLzmSNFI+A96qAImSwLa6SEOI3qy02fBAo4qQn/kDUy4qXzpC7WOwAh52iZhZYj
	 MRvbvsUJjNNkcXImZdxkv5l5hiidyPLSBkVSR/5iRZ/zHd/9i3gWuWKkQl+kuu0fpi
	 RILQc+ttytzz/sRz4+/osg27juptkcZH8oq/bG1EtcgAI2O8QBzqN4UB3AyzpPPd0F
	 zrv6+UGNg6ncZSBphgOeZPhJdjp66/wREu2SSYU/OTit7APZ5rhtoB+AcZ9ySXjuBF
	 0wppFT6T/T8Kg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>,
	rust-for-linux@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Andreas Hindborg <a.hindborg@kernel.org>
Subject: [PATCH] MAINTAINERS: mailmap: Update Andreas Hindborg's email address
Date: Tue,  3 Sep 2024 22:09:48 +0200
Message-ID: <20240903200956.68231-1-a.hindborg@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1622; i=a.hindborg@kernel.org; h=from:subject; bh=fioxQcbG3apiE4VFtEFZfVL7qHBv3evTsbReL36QZSQ=; b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFwTDlrQTBEQUFvQjRiZ2FQb mtvWTNjQnl5WmlBR2JYYTV3NzlQRmpZVW1maEdRR0RQejdYVEpXCjhPVWc1YkkwZnVJeFVRMDRz ejh1ZDRrQ013UUFBUW9BSFJZaEJCTEIrVWRXdjN3cUZkYkFFdUc0R2o1NUtHTjMKQlFKbTEydWN BQW9KRU9HNEdqNTVLR04zbG1jUCtnSU5kRWZ3YkR2QVAweHBvOE1LdTlIMjMzeS83MmNVa2JudA oyNFl0QVdlMmswVVFXYW05QXkvVkwxZDVVYVFWYTBwMW8venFVMXltOGR5OVZ5eHNMUGhTZ1Erc mdIVWVtR1RqCk81S3BRVjMyZE8ySkFydGVwMGw4Y3FuQTczOHloSXdLSkpxRFlNSGphajRVWVg3 SXdHOXdxUHBaM2tsOFE3c1AKZEV2eXljclhMSDViYzFiN0FNbGtzWlpNNmFjeU1Cdmp6TjI0SGt zMC9qeVVETmM5VkFoRWI5TWZqN1RjSUpGUgpESFNLcG5Bb1laNlZUYVRyTkJ5N0s5S1ZDN2g5dl huWUg3UDVtcnVLQjkwUTVpMUNrMFUyQjhkRTZPU0VLODFFCko0M3o4MVNPakRZTEJKK3BWV0tqQ kY4SlNnY2FteHR2K0xxcm9ENVZRMUE5WXRRMExFZDNjNzU1cHhCMjJZVlcKS2VCVDFaNC9acHph UEtxRFI5Yk1hNzluUi9sWEE1R2JxQXlpcEZrTjVhM2tBUUZvVi93d1dhM0pBc2l1bDNEMQpOVkR xOWtMZUlnYlJrWG9yNVB4aHYyMzRDemNQVGJlbExGWmVaK2duOVdWSWJTYmhFRHBPVllhRE1UUW d6UEFvCmFCRkhBUkxxaU5qUFVFMWxiMlpRMC9tQ0Vaa1RCbEFJSlpEdzJDS01vOXlzb2RhNnFiN GE2UW9FeWp3YndrUjYKbU9XRk03Y2pvKytPeFpGTWhFRTgxNHJRbklHbkQ4T3pUK2FOcTZMY0M4 NkN0Yk5YbG5VdG5kR28rbk1ON29obgo5ejA5TmxwQk5XOTZHNm1EaHVhL2gxR1NRa1JyNTNIMTV mNTRNSzlZTlpMK0xrenRWOGFNM3hJN1duSFpVMDlDClAyOE9pQ3RKTFV3aENnPT0KPVRiYzEKLS 0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp; fpr=3108C10F46872E248D1FB221376EB100563EF7A7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Move away from corporate infrastructure for upstream work. Also update
mailmap.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 .mailmap    | 1 +
 MAINTAINERS | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/.mailmap b/.mailmap
index caf46a652f15..c0e3de93a481 100644
--- a/.mailmap
+++ b/.mailmap
@@ -60,6 +60,7 @@ Amit Nischal <quic_anischal@quicinc.com> <anischal@codeaurora.org>
 Andi Kleen <ak@linux.intel.com> <ak@suse.de>
 Andi Shyti <andi@etezian.org> <andi.shyti@samsung.com>
 Andreas Herrmann <aherrman@de.ibm.com>
+Andreas Hindborg <a.hindborg@kernel.org> <a.hindborg@samsung.com>
 Andrej Shadura <andrew.shadura@collabora.co.uk>
 Andrej Shadura <andrew@shadura.me> <andrew@beldisplaytech.com>
 Andrew Morton <akpm@linux-foundation.org>
diff --git a/MAINTAINERS b/MAINTAINERS
index fe83ba7194ea..3f932a631420 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3868,7 +3868,7 @@ F:	kernel/trace/blktrace.c
 F:	lib/sbitmap.c
 
 BLOCK LAYER DEVICE DRIVER API [RUST]
-M:	Andreas Hindborg <a.hindborg@samsung.com>
+M:	Andreas Hindborg <a.hindborg@kernel.org>
 R:	Boqun Feng <boqun.feng@gmail.com>
 L:	linux-block@vger.kernel.org
 L:	rust-for-linux@vger.kernel.org
@@ -19937,7 +19937,7 @@ R:	Boqun Feng <boqun.feng@gmail.com>
 R:	Gary Guo <gary@garyguo.net>
 R:	Björn Roy Baron <bjorn3_gh@protonmail.com>
 R:	Benno Lossin <benno.lossin@proton.me>
-R:	Andreas Hindborg <a.hindborg@samsung.com>
+R:	Andreas Hindborg <a.hindborg@kernel.org>
 R:	Alice Ryhl <aliceryhl@google.com>
 L:	rust-for-linux@vger.kernel.org
 S:	Supported
-- 
2.46.0


