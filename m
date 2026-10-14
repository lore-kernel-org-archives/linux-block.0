Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF01051CF4D
	for <linux-block@vger.kernel.org>; Wed, 14 Oct 2026 17:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791997260; cv=none; b=gh8IeqD+JtEO6lw5NUw/nm96ILA+nF4LZi3p5wo0wzOLFwfLgxle6KORmLEGwuY7nzfM45vU127LIdNL9ysk3pshjIvGpejx55QK0zmckDzw8isLcCMsuFKHoiODkGh1NoC45DC0xPeX3O93Um5TGOFnsNOqV2BfT+6jXACwgVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791997260; c=relaxed/simple;
	bh=0L7C8ctYfi293cNCLCSW7hT8n4TfzolwC1rYjwjGgVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A6K0IgB0qzEuMa1dnqg3dYydEzz158zjJ2TnLvcXlU5nf+iEM4N2ESQvCmy/9KAeusWT7D6l8H4mvZcpl+Lf7ZiqPX4pJkHPGr3w8ojZ+m1Px77oeTiwI7FMm0L183FHkJMeaOSipXAqmvZ3jCy2v5WIoXKDryxB/FR//5TisxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hsApGbIv; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hsApGbIv"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a02667ccebso32050555e9.0
        for <linux-block@vger.kernel.org>; Wed, 14 Oct 2026 10:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791997257; x=1792602057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cLpXe4/u91k9DHDDYoXmFNxRFAC/Zm9beCfIpbWNzcY=;
        b=hsApGbIvwlPnvYvA06B8Bfc9dES7svKX8kjnDoCuzUIq031bdXB2KShiHrQJZFFot0
         CgSqDOklCBf52gBA0N75Qs5cfBKJtAJA9I0o89s2r+KMWgGjVbXE9BWSjzx1zEoF2X7S
         +N/jwI+ZtcXpmcmjRAqwInFaHHmY75GnSJFybwBSl+Gdt/zdGbtUvUEbRgJtA02To8Mc
         xK4iio/Nzvi/yG6wXLzHQmrsHwti2DjNq/Moxyikrkj8iQCvHF8B3unHy6OCXCiOkO0J
         lJ8je+HDGwVJjT5DvPV/WsBf5MupX3KUpbllJrt/ndJ5I34Ba2ti1EHP/jy2EkNKf7u0
         JG9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791997257; x=1792602057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cLpXe4/u91k9DHDDYoXmFNxRFAC/Zm9beCfIpbWNzcY=;
        b=u6/oIbj739yNFjvsi6XmFjLbNhjXKXOetmeTjPMTv98r/l5pfSwpv3ft7jz0+90+hE
         d75AE8psIe3yLkWCwC2rUXV+gY4PHvxmXXg4IKfczK5KWd9i7VetEP6mdgdNQ73tJ/g2
         yLVHD13uPC3ryEvYgqNzYlHUL/NkJnNHi5k2aiSkTwPEQ6Cb08ulqakWhNPpcCBB5Pku
         G9gOO9HzbmNccok6pAn3YNrf3DMx0LmRB82SkiZGP/WHKh/ia3yRqvyl5sKdobbIBRCa
         lmIxAvxaF1gDoEsveBf1LzrvbDAu23HbYhrSO1jcmkPuoXnj8ipAUWdrVEJnr8otenVv
         JJ7A==
X-Forwarded-Encrypted: i=1; AKwUvBx7K2bw+bHyD14hR/LaJKbDZtzckywc1BF/oTvESGh2Udgkeg9IOYJS6rkX5CYWGYyK+DsNq/QqUoRXiQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYJG+76IhUNfjFqR/wp5/l95KYwxOmtAD3R89C7r1xKF7EKlzo30
	BfWXTTMFPPjZdnfLNmJYkHuuLr2qSSVOO38GQpsU5PD/f8Vos934/M6F
X-Gm-Gg: AYBFou1FYAZ88wt0519PLzOFZR5BJ8BzEcQJt/n7L6KlYuG/m7ezTvZoDxoZXBtdPQn
	HRkTOXPPAfde8oQjvrZsMax2yZP+Pbwkbg7eted6mBEcA7z1CHBBtPY+TOC2ZbCftY0fNBdxnVt
	4KBmGxkH/0RTa8AqunISikotFcIbyTEG4okyPw/A6jJ3EtozNfOi/oF9gQbVokTt5z0lG8nprjT
	22I45ld4SseFEmuWaf0bkHPJMTy/Ji6R8LIErgFKwvha+Vix10CHwY4g64R3HjiaE4y8hEHkps0
	EY7mGykBHYSSyr+dFOVnNbqlQjNbM8o8w6nGfNSv+FgFLxvVyW8nYPJP2sTK/eS1Z463keGoVES
	9l8y1u19/M7UW4lvIs0ZbVksw+94TUEh0GMAYxg3zFPpwzNkZYczMMGnxSLpCjGLnGFeP2fvfWl
	MComD/P3aOVJ7ADsUqWyD5L4VFLy0Vk/ppkBEOvGvie/ZKAPDUHo6ctDjNSAwwDsMOKRoD7LG+L
	kyOK237pBKnhE/1CKfTqaIeo8z2zlcu0kE5+rjLDw06Kw==
X-Received: by 2002:a05:600c:190b:b0:4a1:82cc:1e9a with SMTP id 5b1f17b1804b1-4a18e4b2b25mr330216135e9.17.1791997256518;
        Wed, 14 Oct 2026 10:00:56 -0700 (PDT)
Received: from andreayoga.wind3.hub ([31.189.109.133])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd9a8a22sm5349415e9.5.2026.10.14.10.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 10:00:56 -0700 (PDT)
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
Subject: [PATCH blktests 1/4] nvme/rc: add zoned null_blk target helpers
Date: Wed, 14 Oct 2026 19:00:38 +0200
Message-ID: <20261014170046.2516-2-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014170046.2516-1-parri.andrea@gmail.com>
References: <20261014170046.2516-1-parri.andrea@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add helpers that export a zoned null_blk device as a namespace of the
default subsystem and connect to it, tear that setup down again, and
issue a partial Zone Management Receive and check its completion status.

The zone report tests added next share them.

Assisted-by: LLM
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
 tests/nvme/rc | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index c415ca1234407..270fad19d61f1 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -408,6 +408,67 @@ _nvmet_passthru_target_cleanup() {
 	_remove_nvmet_host "${def_hostnqn}"
 }
 
+# Export a zoned null_blk device as a namespace of the default subsystem and
+# connect to it. Callers must source common/null_blk.
+_nvmet_zoned_target_setup() {
+	if ! _init_null_blk nr_devices=0; then
+		return 1
+	fi
+	if ! _configure_null_blk nullb0 blocksize=512 size=1024 zoned=1 \
+	     zone_size=1 power=1 >>"$FULL" 2>&1; then
+		echo "could not configure zoned null_blk device"
+		return 1
+	fi
+
+	_nvmet_target_setup --blkdev none
+	_create_nvmet_ns --blkdev /dev/nullb0 --uuid "$def_subsys_uuid" \
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

