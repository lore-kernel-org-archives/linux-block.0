Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205891;
	b=xTe+i/MEJUO3ejzrflfG6Qgim1LuaaCRMfcL6L3qVkjEsOOc+JQm3EhFTayDpQ3qsstD
	 y/eVrUm+S3MgASkZU6y0RnWeSYgze9ATw9bv6Op8S1nYlBK3v8iCHZk1BUdrDH3bKTpB4
	 5ca/3CKBZCCNX0prIfkshbRH4wjFdXBEHNRkr95i+m0gBvkh7oJqb4Q9EXkg0khZtYnwg
	 5BcBe6xayJacnPPjmvhpwlnzbUe4aKghh7kSlvk6TwL8W8lrh6TPXOoUXB4Fwcu6Z+L2w
	 RW2Tgex15TAjmkBPsyzDTVTJrYeMKMSm+DZ5erQqanNek45znJrUE0fJSTRrMXTVumA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205891;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=sZGHEN4JlabjlebP/bd5SVTPzVRpU/GwevMoYZ6Mc2w=;
	b=pNn8lUUXbfnCluMTd+ej80yPCmevdbGfBYDkosatMQDC9eQ6wCeoVWGEf9GDu6ySaBqM
	 wdMkpr7VMG6hCVg+IlZXia3DNkeI1G26VQT2yZyhboo4ohLAKkTcMlzhEFlazykzC33Br
	 0f0eFEjVYtZQAglWMR0DQ76jyV4ImhE/sH1yipQSzbAAx9dP5DbJR9ER4DnM1aBtTuQ59
	 G9rgm3Kl+jdKyjFn1YEnzXRzVVhoWdLanvVajSJoU36y1ucfavNVAs9fjJctYsOQpQjlR
	 P8m0LrDomWWg2XJMAfnoLlbbSwjiRRVNavil2Q2V23SrwBywyyAfXeocSuCE+dxaLnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=mmqKkQem;
	arc=none smtp.remote-ip=209.85.210.46
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2B9606A327
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:44:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D2B9606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=mmqKkQem
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-8253bc5a613so807367a34.0
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205890; x=1793810690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sZGHEN4JlabjlebP/bd5SVTPzVRpU/GwevMoYZ6Mc2w=;
        b=mmqKkQem1A+/tFLltsVDH6uI4VGT0K9TP2qN8wHzCCDpkhVmTM4eSL9uTao+V8w7Fp
         Ys49ZeuKBZ6whrEZKu13vV/12swUHGo6OJjHiw502WtoesTfgugPAQysNMr994/sm/JT
         oGxW1ROtXMdJYpMEGGeqbxfgW5/fiFlJYPX+G8hQa3jA4miK/6XjlPeMBSb01AMFvr6l
         ueDYBjIS7gypkHSdCG3DlFXEM15Gtxsb5cj3cRcuvkW/wCzmAM72/iJZiCrdRl8C9vlB
         VJSfz6t+oKo3p/DZzfk5XiCHiefPj3vCmvouFxv6TH8Idieh3VAH+duCjQKuJO+hLh3/
         RofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205890; x=1793810690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sZGHEN4JlabjlebP/bd5SVTPzVRpU/GwevMoYZ6Mc2w=;
        b=ZBL/mduK4nl1QRryUlktyVvISz16/v4TEgvOGjE4Qdz1FYNoks6IaRHb3cQiefMLpf
         4eoOiBR7LPsu9Pi+zJyAJ+m1N2O4zOhz4XsR6+Zuqk6EWSkI51BiJadzhhnnt0FTESpy
         zFfct9qkf18qbQnLHbM/H9x2LtS/KD1ImQAKkkt8m5sNA0P9JwUOM0F0m2NPy3C9UZ/Q
         +1HkEauP/F4XhtsQ/gcqkUca5fDlCfvzZFP9B2k4aF+5YzgMfSbFFoA2TcVGjtRbxRw+
         EaQBx04w1ivs0KoDzfGNIOa3pjrQChSZtNqQYw1+ZI8EsNLphdsy3Ya5SDx/EDY4VlKx
         +nFA==
X-Gm-Message-State: AFq9FYIUDGKH/PZyEEpVX+vq4eWFfLC+nthSVazWbDtEqNnt6XTlSw6U
	yf6MtMZW0Nj4a0zW4+86YCFpWSWNKCO6ieQlwLIuaqDe18xKqqX80NmxbsWLmzNPO+9uUCWFZ5C
	cQD+x19U=
X-Gm-Gg: AYBFou1IMIldupZFAbfjyKHUq0t8d7mNCH7S0mG73GrZY0XEhaubXxlchMM1nJbFPn2
	jUq7awClbcNDA+dgrJ0QmTZnh/hq4GRNKbrZdZ8DqbBLnkiHeyvAN7apzLoNe06sDo7BurbDRB3
	TKsNi9t043QsebRX06LVFanK5ufETITnReJv0bVxei970JaG+gQx5EWZl+0mcO2JzDOc5qUj4MB
	eYRQQ8ikUnUkOf1fwhad2mndgCZ46g72uQqyz6EqQ6voYvDhDu1p2PKDX+IGxSYFohEo3kF4yyc
	sRF64rxTPw4d2vq7GQ5NEMDVEx/l/MbA6phyIPk8RVob2KtzpMPto75HT4eSHhkzTf461056yUG
	Cs0WKK6LfHyvXK1nJsXienw9mRVNe+Rk0b2IGipbJT1A/X++5erypqxebCRHeTJ32u6lZApXVS4
	tyfkJeD8LMXU9K5GcjgynlngZiJgpBwZE5LyQ0vQGD7wE6DTif9GiQHGADeIMZ2kPjb8LQOpW5y
	y5I7k0sLyv09v+JP9vHZGjcEUJHumahiNxjgB41zoP+xUBgXIv0krNxtHfiK0oKnKMdOg8AJsK0
	hXqezQACv7kMOOE5vP9OzXk2qbEdAU8tpGkj30A5+7TEG3lVeU9BKWOlqLyaT+nl0IkeFSxQXxY
	=
X-Received: by 2002:a05:6830:2e01:b0:81e:bb3a:7ebc with SMTP id 46e09a7af769-85ab83d6f5cmr2784015a34.26.1793205889649;
        Wed, 28 Oct 2026 09:44:49 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:44:49 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Tejun Heo <tj@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 25/98] blk-throttle: pass the I/O counts of a dead group on
Date: Wed, 28 Oct 2026 10:41:28 -0600
Message-ID: <20261028164415.1262013-26-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028164415.1262013-1-axboe@kernel.dk>
References: <20261028164415.1262013-1-axboe@kernel.dk>
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

From: Josef Bacik <josef@toxicpanda.com>

The recursive io_service_bytes and io_serviced files sum up the online
groups plus what dead descendants left in aux_cnt. That worked while the
counters lived in the blkg. Since commit 7ca464383aec they're in the
throtl_grp and nobody passes them up, so the files go backwards when a
child is removed. Add them to the parent in throtl_pd_offline().

Fixes: 7ca464383aec ("blk-throtl: stop using blkg->stat_bytes and ->stat_ios")
Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-throttle.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 4f10fe05744b..80a5e4b2872f 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1670,7 +1670,18 @@ static void tg_flush_bios(struct throtl_grp *tg)
 
 static void throtl_pd_offline(struct blkg_policy_data *pd)
 {
-	tg_flush_bios(pd_to_tg(pd));
+	struct throtl_grp *tg = pd_to_tg(pd);
+	struct throtl_grp *parent = blkg_to_tg(tg_to_blkg(tg)->parent);
+
+	tg_flush_bios(tg);
+
+	/* the recursive files of the ancestors go on counting what it did */
+	if (parent) {
+		blkg_rwstat_add_aux(&parent->stat_bytes, &tg->stat_bytes);
+		blkg_rwstat_add_aux(&parent->stat_ios, &tg->stat_ios);
+		blkg_rwstat_reset(&tg->stat_bytes);
+		blkg_rwstat_reset(&tg->stat_ios);
+	}
 }
 
 struct blkcg_policy blkcg_policy_throtl = {
-- 
2.56.0

