Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205897;
	b=N5ZIa6pFzBhZsDhvcLnFNmbBPjyUql1Z93BKRPOMAm/MGtJtScL+XdEucJCoF3o9ZIBV
	 3nE1XILkQNKpD9r2F4B0s0tWPjUOsCAo7IInkmMVFTW4QMb5f2AoqORhiclewyikcZZsS
	 zs0tMOhor2lCgdRQrQqctakD82u/en5obUJsegbyI9ZWHuc+4Kd2bqJrAmy6PzUsvkdGN
	 /10Kx5yyIfs2GhJ8SpMBg9wH//PDPBCBVjlPBnUrsWcaNS4tSMTpWw/hmpYtLudnOgGHn
	 tW2+DQMu6Q0M/Mxmkf2VMHy//qwt+patZNCOpcseFxQu01cqasnkShtWX6LeBiIDtpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205897;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=oryCUjBv6jPEuQ0d1fWG2FszN1dJPUYk6n/CLIakuhc=;
	b=vw/ldnspu7/S8BdJOgc8Xahz81BbBVI/JG5cyMWj8ahNtFM8hdNyO5Trm9xRKiocJ1X4
	 avRQKfhPfMuBC+rlLt7FQf/yWeedpMVfpp3GI5vkI9BWhd4wwU98/uGcP38ladTDH9naG
	 SuTW/1iiTjEyd0iW/4RmQXh1rsG28g0mp94yoo5N/Shu7SSe45LvTn1q7RjJV+BqnKjM2
	 r73zlsRStqbgbd+h+LOw7nfi2ZF10PzGi6wCyNtP9cFsUQ8pC2jPtAdGlwZURTjc3EIL7
	 qh1jrE+jSAfl50zp/ekzLrJppqmUOGZJy0+kGVPgnNzpTJs2gqt4m7YZZEsSmnbME4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=LpGutu0j;
	arc=none smtp.remote-ip=209.85.210.42
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FC3606A322
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:44:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91FC3606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=LpGutu0j
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-854b6e2e41fso591708a34.3
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205896; x=1793810696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oryCUjBv6jPEuQ0d1fWG2FszN1dJPUYk6n/CLIakuhc=;
        b=LpGutu0jRvSbrnv87iMb8lDznfen9I3NkoIRYwsGpl2CpxMyk9/OMapw7TOCTd6gPe
         vgXXMNRn9RlVOfB/pWNTOiAs0J8qi3fKpQThQNn/cgiZkdwTAm06XmzP6eS2PfFwFjqd
         cJwcgsc9m5yC/IqGEG9h7Afz0reHk0wK2e0dPyZx/5+AlG16mLLSOpgcybKQiwbszxQP
         KAw9WnrYtwQstNdkRVe8ts2KSeQoQiS0JBWvbVquRneCoTJiPo65IWBRj+ph7V7XeCue
         05XQx/4j9sbDed48RD24VbwbEn479I3FEUsnnp8QWdGnV01xT9SMaMASXplU8lvoYCMZ
         PnUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205896; x=1793810696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oryCUjBv6jPEuQ0d1fWG2FszN1dJPUYk6n/CLIakuhc=;
        b=LjCAHiJ/JcCH8tdNG5p4A3Q2ZBNw3niuU+EDcSErkPim2eYgqAxyzUJOIslipolZMW
         btU2T8HAoQ4iRHU0ovzP8dFeeebC5wAqBPRemsPUkJXBazl9jJ5knCAHIkLiuwS86Wyx
         Jpu0ylmKVDwMkryZ7sDjJthqWzMNYX2zpkoDpdtbLnQp9AhYAGHXH89B2j2vrAv/ERbk
         rvGxvfFjVzXfJQH/4dR5O+xSpMK8IWYEbmCDkJBBUNe0Vuc2OVcN4/EYyPirDnu7ka7g
         cccOz0TMaj3CZ31k+SpKUhN2X2Vihq9/GABzYg3o3dSXFdrAsx+pKCji2w4qX0Vr0Foi
         mPVg==
X-Gm-Message-State: AFq9FYJSvlyUN09YbaDvG1zeXMRzWBGyla1s5itZznFfyn2+EVWAygGe
	p5WQW0ux7AAWYzhVWFsRkj25a5J9jP0ryMkD6/xGENowDLZb3BnmlnEMj7sKLpVMgLxe2SX2H0E
	8OanFUqQ=
X-Gm-Gg: AYBFou0uMaye3gMH540qvtydtHn+Zx1NfJBMuK81mbCR3H+7L8wjy3E7RZtFRUjN0u1
	hjoFTP9hQOUYPJC7+/R6v1kfpZsoTDyCRJmtxZU0xJUQ6RQz3EHC7h15JprbTHLNHwOZ3ywXYjk
	2j0pghjExyrTOYzzmK8KwG4BJs0Bp1Cd9w9/MkyUdkTnpFNrhKKEbeuM2Ta/30SfGKKk4E/i2Jb
	aUI92P0kcA43mLQ4SD0airVblys6nRIFGGMC/Nlf3fyq4bGcr139wdEiHPCcm1YXEMvTIXSkVV6
	22BBng5Rnknwqz+9chibD2VkZIsmQRV2AWtvZUCmkNBlvpDKOVcazCddYW3GHZTRZd/HSN87N4x
	MpGLc2oFju9oe/smWRzaV0QaSq0ZaLFH5rSEZd8e1qN/ah23YwonurLShfHG3BK3ej+rizzsRQX
	jMDLA9azd7RtT7qURPfunW7T2nWVs3epiq4NwCiXOeOnOAkHB3nHF+RqSQ7jlk+Tw5J7V/RGEwq
	pVWCbIfMA30z/vlN8zMG3z2DaQ+qH6Hi6u9GLS4hOqMk7uoWoeBg0HoAHYB92weAIdaHaqPr7fi
	TmAAwpLsZKHGANkPGfAtYtMJoNSYhVDfuNmYBj0jRUamDwmB4ItR1u6ix4luqMbbjFbzFCmXsA=
	=
X-Received: by 2002:a05:6830:4393:b0:806:dbd8:9929 with SMTP id 46e09a7af769-85abd90dd7fmr2638828a34.15.1793205896550;
        Wed, 28 Oct 2026 09:44:56 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:44:55 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 31/98] blk-mq: don't forget a timer the driver has restarted
Date: Wed, 28 Oct 2026 10:41:34 -0600
Message-ID: <20261028164415.1262013-32-axboe@kernel.dk>
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

If ->timeout() returns BLK_EH_RESET_TIMER, blk_add_timer() gives the
request a new deadline that blk_mq_timeout_work() doesn't know about
when it picks the next expiry. A 2s nbd read next to a 60s one expires
once and then not again for a minute. Let the new deadline take part.

Fixes: 320ae51feed5 ("blk-mq: new multi-queue block IO queueing mechanism")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 0491e9821322..6d3ea97f9a00 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1710,8 +1710,11 @@ static bool blk_mq_handle_expired(struct request *rq, void *priv)
 {
 	struct blk_expired_data *expired = priv;
 
-	if (blk_mq_req_expired(rq, expired))
+	if (blk_mq_req_expired(rq, expired)) {
 		blk_mq_rq_timed_out(rq);
+		/* If its timer has been started again, count the new deadline */
+		blk_mq_req_expired(rq, expired);
+	}
 	return true;
 }
 
-- 
2.56.0

