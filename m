Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BC02D949C
	for <linux-block@vger.kernel.org>; Tue, 22 Sep 2026 03:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790048445; cv=none; b=WmCIKlvWoPbh426Cv9lpxVvmaETuUL59RwrRJHrfJ1m5l1u0PYDP1YK2pjJQnd8AYcP4RjV9aXO4A8DqqCxSimIBxZJrztLyo7HEIRBdblEKwpfaOJrasWl0IIB/gsQrKgOo9EYoK4ieYguJYh8Frh9KIK4UOS/HAsA4xN7TsiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790048445; c=relaxed/simple;
	bh=0xg/9XRL25RybIS6ohHuHvgZW7EH5ABEOTFdeK+l46I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gTxi7aIbi9e/LfBEjgwrEKF/mywoZGFSsLrZ7GAwLGJH629i7XBLYJgr6/WUwPDEhAiIDmISIlS3MmAyh/ZJlJZcKavb5HBIcT5F+TH8TsZQCGmG5+olbWRmuQJHowjqWA3zZkEoiBUpyJXoxl4KGk2I29bk0IWA9Hnu4q0oXOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=jfG7JvzF; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="jfG7JvzF"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-85469d249c4so3264887b3a.2
        for <linux-block@vger.kernel.org>; Mon, 21 Sep 2026 20:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1790048443; x=1790653243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HmLr6ctIBfRz+487t7olFZJDBL/YcLep23adJGDGqxg=;
        b=jfG7JvzFK2iidcyAivplN9K0bkIgfW50hw2kn0gA1Blic5Gtsmvs4EagHKG9LhjvCM
         zbThAEv6mRwrpKcTmRH/Vb/C2abPU2c0solhgtqd8dgQhKywKcOA7kPXPfQ/jBgoV9yb
         yjtjDJcLhVXYdF7riji41KN226xLU5ZY8CvTSBqtnO73VXnzvzvIO2HknajNO3mEep1/
         kT3I1FXtohpLkSzDpjWbxyUW6iu0NPmLFZ+sC62S5hiN6X0WsddZFffdU38fayIXdlfe
         /KBQxti7apcArBO9LQFz3sErv3PGJGaw0gLqWNX7nghVbrdAuK9mJIsAJpzUYzkm7A/I
         6LpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790048443; x=1790653243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HmLr6ctIBfRz+487t7olFZJDBL/YcLep23adJGDGqxg=;
        b=svS+bT7H2vAU/8kANbBmzM4eA7ThYv3oQe4aW7mNPnsc+DXV0CnlE1XM39ZAEeNj4a
         hjd5Ef7SYGk/nq3+YYFvcy0plqi5nAWNu9TlhGs7EHbgQbOlNmbIcHC0h5XKQLwPYwRJ
         daDVXz/ab7U8lvcbRfh8CZF3pTawBjrkbJx6kaa8TtAe4eR6d29xY2POnbn08YMovN8E
         +TyprnjP/+Vd1RQFlCD/ve+DpslMElQclciuBEt6xxQ9uj0N0k3hvVplDXvmmfSstDoc
         UtJOEhDdBfk+afHFvoBbkQown+fXDvRDKDJLbrSCMWSaI49MhLBGHPSJsSWGHsOPuOwg
         xzjA==
X-Gm-Message-State: AFuF++mE0X7EqNkejfTuevdGIiGZ3ZrgPFkKGndLH6ogg2vzkDqZ6cHw
	h84/rZydmLpknbLD1qLKK20JAlH0fjXVAHQ75ipkQ0QehShhfJwi4csOfCL/MLXNK1iX28VpVfv
	nCMIRxh3/
X-Gm-Gg: AYBFou2A7DfFDSXh8fofnXtOH6gndDn3rXyqYVsan2ykopchhQcNUe/+i0+H7Wt6/tx
	ntPpQpvGmV3H9wbNeJtsdegtpWsJwIOwn1v3aOaFceEAP54I+onhMWR80L0cE8o2qzwez0CEbKy
	xa3M+bATTk1LPLGUTD4a7wEUMEUCiJiq2e1V/YWbMKmtTVvwKImYsvwgI8ZAXIXVu2N0MYz2lq5
	pttJa8nJifrcQFIWNhQcBQIFa1icEmhFKurNrcnYqD00WXf7TaJRu3/68i8e+mmrG7deZZn6DKQ
	KjAvoDZF8WdOaB8ZXH+WiWMcN7g7IFYauYB1AajP90JzxWH4x+qHywVUW9mUsieLrIeaECa7gQZ
	Joru7DJXHePXkiQna5ubJx1mB7YKWxEhv0dfBW4oA6tlYzFsY/lXO2XwnSub1W+4XySlcZ0LVOk
	xJuvO885B7pYqpDfuBx61SU+3pgHiFMO4iJUN3Qu42DQMFU+zw1v9IwUG7l+EwLDh80wTCGlPgj
	mJw2DDz
X-Received: by 2002:a05:6a00:278d:b0:879:ffd9:126d with SMTP id d2e1a72fcca58-879ffd91ae4mr6148848b3a.15.1790048443207;
        Mon, 21 Sep 2026 20:40:43 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([167.71.204.91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87c324d0154sm151769b3a.23.2026.09.21.20.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 20:40:42 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk,
	kees@kernel.org,
	objecting@objecting.org,
	phdm@macqel.be,
	akpm@linux-foundation.org,
	vega@nebusec.ai,
	rakukuip@gmail.com,
	weir@nebusec.ai
Subject: [PATCH 1/1] block: partitions: sysv68: validate slice count
Date: Tue, 22 Sep 2026 11:40:10 +0800
Message-ID: <72850b6d00233f9d93b82d27a60ef13e895eb8d1.1790005101.git.rakukuip@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790005101.git.rakukuip@gmail.com>
References: <cover.1790005101.git.rakukuip@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luxiao Xu <rakukuip@gmail.com>

sysv68_partition() reads the on-disk slice count from dkconfig without
validation. It then reads a single 512-byte sector to hold the slice
table records.

Since each struct slice is 8 bytes, a single sector can hold at most
SECTOR_SIZE / sizeof(struct slice) = 64 slice records. The parser
decrements slices by one (as the last slice represents the whole disk)
and then iterates slices entries.

A crafted disk image with an out-of-bounds slice count (such as 66)
causes the loop to walk past the end of the 512-byte sector buffer,
leading to an out-of-bounds read and triggering KASAN warnings when the
sector is near the end of a mapped page/folio.

Validate that slices is at least 1 and does not exceed the number of
struct slice records that fit in a single sector, releasing the sector
and returning 0 if the check fails.

Fixes: 19d0e8ce856a ("partition: add support for sysv68 partitions")
Cc: stable@vger.kernel.org
Reported-by: VEGA <vega@nebusec.ai>
Assisted-by: LLM
Signed-off-by: Luxiao Xu <rakukuip@gmail.com>
Signed-off-by: Ren Wei <weir@nebusec.ai>
---
 block/partitions/sysv68.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/partitions/sysv68.c b/block/partitions/sysv68.c
index 470e0f9de7be..0edf2ff80c5e 100644
--- a/block/partitions/sysv68.c
+++ b/block/partitions/sysv68.c
@@ -72,6 +72,10 @@ int sysv68_partition(struct parsed_partitions *state)
 	if (!data)
 		return -1;
 
+	if (slices < 1 || slices > (int)(SECTOR_SIZE / sizeof(struct slice))) {
+		put_dev_sector(sect);
+		return 0;
+	}
 	slices -= 1; /* last slice is the whole disk */
 	seq_buf_printf(&state->pp_buf, "sysV68: %s(s%u)", state->name, slices);
 	slice = (struct slice *)data;
-- 
2.43.0
