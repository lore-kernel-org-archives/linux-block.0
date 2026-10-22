Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792674581;
	b=wtX8XSiLH3s1J2A1nZn2KUy/RH8XboVzBDC8zeT2LtPSN0u1sJ+5dLq5XFd9ik0TXADT
	 z8L5sA1txKct5h5C95SkdHqBpayJwIX/j7pB6PWGQm3egbqOcUtsY8nQYgyOcRoExPhvx
	 l2QiSl58YDISPTiEyv9uqPnfpRCqWZr+JYFri0NLNkrRaOZ1uzfDmBZkSZjo/3+FeT0QX
	 1iw56xNLyFJ/ERqijfU5dE/VN4I6VJ9SkXq+htzsE0O2EzIGVo3xgyx8WkiyWvPgSwD1m
	 m2nIQmGHzhFYl8RCdPCa0Ammrf/AH6LZCoMvXFnguBbKJxTAj+5aswjMnUoH/6Q4/0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792674581;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=bJlNgn1WBW2DrWAS5ZGfcDqNOjcwVQOGGu+jWU8TgLc=;
	b=ilyiIrbhQSSr5nagdsUIBxWMQuWp1RTrlfVO6DPkLQTdVsS51pkx0UZY/K/wdETV1SY0
	 CJKE0FPTOqpuULilWencRKuPfX0XMzfsuuG7tw2lssLmxMkhAMHZTvDm+fQHb6dxeyRaW
	 wP6MR0aI7OhdNrNkGQBwBFMQsZasjScrmDF/IrZpiQ1DYyoT3RycSlYNZoinadzO26MBl
	 cmpV4KKMDFCTcRJhz0fYDhiO9Jk3IFr64zo92Ai4Xp+7OduLZgGRxzEyuLrgBcSoxDGig
	 JAm5OIfiClCtzlGs+vciC1zFdzy5K0waDd/A1fb/za9P/eQu/FSdJJUHpzaffPUk7kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NRunan+n;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A937606A31A
	for <linux-block@vger.kernel.org>; Thu, 22 Oct 2026 13:09:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A937606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NRunan+n
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a2074a66beso5226045e9.0
        for <linux-block@vger.kernel.org>; Thu, 22 Oct 2026 06:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792674580; x=1793279380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bJlNgn1WBW2DrWAS5ZGfcDqNOjcwVQOGGu+jWU8TgLc=;
        b=NRunan+nklWF6FKq7Bk68xEyOwNZmUSmu4bYMzsZQYka+inlyxH/DuKoprXZjzAyn+
         299AthRQqy6vQ6OfNTMlLtyNQuLY5AS7QlQfpxKHrRP2Hzbb8kCtMxIbEXf3/0rir4xP
         TattvgF3kXekIiLIObneOGd383vtVOUgq6CPDZohpifgX8jK/2iRSVna+KkQtlJUm5Zx
         2C2k3/wd3rBXed32RRj02bAimV6zcQOueeWG8U+EcA+7iGY6fhbd5gDPzPn4z9j4uxJb
         zkExs3ntxJUFhgfIyOvW4kFGFgfvcz2pHTuTSw3LIIB0wHYNk8aQqldPWpvl5GLsnrW/
         nJkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792674580; x=1793279380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bJlNgn1WBW2DrWAS5ZGfcDqNOjcwVQOGGu+jWU8TgLc=;
        b=F5L9A/INNx1B2lGgpgRQlNF4g7MuVkAd2pg++5uqXzmvPbltNhh+e29vdL6t/5tLdI
         LBKHzUqHMzJF0zBpfIBfnQVbbD78obrc0BOUVFDVK2kI4X2CZxmzzANzfPDQD1tVO77P
         gZbSIt/7oy+A09fBYo5nswlhgVnTzJUUa8Xx9zI89I7X3shqNf+FWyRAQYxpA4YAkPHV
         VxTPCjiZ8D5Sb59UIiWuovOSnvM5wYwKVW4LB2VXWoS2Muu5pk5zWCzXSJreEPF40BU0
         OFYTs7zeVWg08sbVyQINUu4m5/lLQk/YBhdm+/gCKm8aaP3doZ6aaR57yGqH5DMQ1nT5
         0M/A==
X-Forwarded-Encrypted: i=1; AKwUvBwJNURmoYZpLDjn5vsRUPKT7i8ufEclYEP8ftG+o+QyxDxyk0t3sNn8siSy+sOTqt65xEFWkWEDTCKQxg==@vger.kernel.org
X-Gm-Message-State: AFq9FYIct+o0ZVCagvc/98Syh4e5zqwqOi0xHinw2xhv8+bFJpxHdbsc
	Q6gfKZJ9gr6rEnpxDTsoMVprx20O0Eb8eb3Wr0njS3RCwDBjjCvBvZFI
X-Gm-Gg: AYBFou3Q7c91n0kVPtlb1TABymjMWatxPcXnQ42losR4GW209lgsIBGPvFzUYHU0ytf
	eoEh2jslj6EjgIadOf4c6BhEyRFmTLNiiPjuuO6URTlGjTda0g18UEydrxGHdoa20wiOjJHMiPA
	8Cra7M9EZF+Ddof+qBReLZ30Ay3mix4oforU4gkqDZA9No+fTx592aYOkCTr9n/RXWgNulYFyV/
	Ngk+b5sw/lqV/F1qN8+MlyRaKFOtxZkOur3skiQhPfi6Fxy7diHVbscY+w0dbbX6xRPOlIWmNof
	IKXsk3PBLMGlXMAygVnye3xx2iDlOh86mEMlgiZ3JW3qLOBxEVPe5+AbnpD7cetJ9k7OvJyJmMA
	cvQNGYQy6R3ivrTXRf6axQ9QsNVIP1QjhFvsEMZHHSaxzS6aTEbV1DMVvnuu0Vti5NXo3XI28Dp
	YN57LRBut9Waw6KUUP+qqkWlejZS9ZSjgdQnI18wB73QYg7VUls2/fLIcV0xa0wLIOnCzuiTBgv
	DUz05odB9wR1D5TJtlmoxU5JslheRBsEacLtk31knYDdcG9B2SeZFdohHLktgbdxqI4YHgyxKp/
	MhJtnId980YdQmLbfyG3HNhZ
X-Received: by 2002:a05:600c:b86:b0:4a1:83f0:7c8a with SMTP id 5b1f17b1804b1-4a1fd8a68b1mr103975625e9.1.1792674579522;
        Thu, 22 Oct 2026 06:09:39 -0700 (PDT)
Received: from andreayoga.wind3.hub ([151.76.51.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fcd2eff9sm119664695e9.4.2026.10.22.06.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 06:09:38 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	linux-block@vger.kernel.org
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Daniel Wagner <dwagner@suse.de>,
	linux-nvme@lists.infradead.org
Subject: [PATCH blktests v2 1/4] nvme/rc: add zoned null_blk target helpers
Date: Thu, 22 Oct 2026 15:09:21 +0200
Message-ID: <20261022130927.3583166-2-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261022130927.3583166-1-parri.andrea@gmail.com>
References: <20261022130927.3583166-1-parri.andrea@gmail.com>
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

Add helpers that export a zoned null_blk device as a namespace of the
default subsystem and connect to it, tear that setup down again, and
issue a partial Zone Management Receive and check its completion status.

The zone report tests added next share them.

Assisted-by: LLM
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
 tests/nvme/rc | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index c415ca1234407..8abd14eeb1129 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -408,6 +408,64 @@ _nvmet_passthru_target_cleanup() {
 	_remove_nvmet_host "${def_hostnqn}"
 }
 
+# Export a zoned null_blk device as a namespace of the default subsystem and
+# connect to it. Callers must source common/null_blk.
+_nvmet_zoned_target_setup() {
+	if ! _configure_null_blk nullb1 blocksize=512 size=1024 zoned=1 \
+	     zone_size=1 power=1 >>"$FULL" 2>&1; then
+		echo "could not configure zoned null_blk device"
+		return 1
+	fi
+
+	_nvmet_target_setup --blkdev none
+	_create_nvmet_ns --blkdev /dev/nullb1 --uuid "$def_subsys_uuid" \
+		>/dev/null
+	_nvme_connect_subsys
+}
+
+_nvmet_zoned_target_cleanup() {
+	_nvme_disconnect_subsys
+	_nvmet_target_cleanup
+	_exit_null_blk
+}
+
+# Test cleanup handler to register with _nvmet_zoned_target_setup().
+_cleanup_nvmet_zoned_target() {
+	_cleanup_nvmet
+	_exit_null_blk
+}
+
+# Issue a partial zone report from zone 0 of namespace device $1 with a
+# $2-byte data buffer and NUMD $3, and check that it completes with status
+# code $4, or succeeds if $4 is 0.
+_check_zone_report() {
+	local dev=$1 data_len=$2 numd=$3 expected=$4 desc err rc status
+
+	desc="zone report with $data_len bytes and NUMD $numd"
+	err=$(nvme io-passthru "$dev" --namespace-id=1 --opcode=0x7a --read \
+		--data-len="$data_len" --cdw10=0 --cdw11=0 --cdw12="$numd" \
+		--cdw13=0x10000 2>&1 >/dev/null)
+	rc=$?
+	status=$(sed -n \
+		's/^NVMe status:.*(\(0x[[:xdigit:]][[:xdigit:]]*\)).*/\1/p' \
+		<<<"$err")
+	printf '%s: exit=%d status=%s\n' "$desc" "$rc" "${status:-none}" \
+		>>"$FULL"
+
+	if ((expected == 0)); then
+		if ((rc != 0)); then
+			echo "$desc failed"
+		fi
+	elif ((rc == 0)); then
+		echo "$desc was not rejected"
+	elif [[ -z "$status" ]]; then
+		echo "$desc returned no NVMe status"
+	elif (((status & 0x7ff) != expected)); then
+		printf '%s returned status %s, expected %#x\n' "$desc" \
+			"$status" "$expected"
+	fi
+}
+
 _discovery_genctr() {
 	local port=${1}
 
-- 
2.53.0

