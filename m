Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205862;
	b=v0RvRWcNnezyLk6YcpTtJYtmcwCTktWw2w9ivZmlrVDgbUQgmEmo9rStcB7aNZAt4u5e
	 ZE3TG3ghsVMZFB6j6Kucr5aGksgr8JdASlKABqwHRWMDcV3j5eIeVq+TuXQeOQO1I4mq3
	 fiStbmrwpQqJrJ4g/1d4ffgXnRKPq570dN7mDd+WCnRu8Ow4cpj7jn1yRAYDqaE5btVD/
	 gf0AlgWDTuVUM66LUSsfCYr/4h9fA9hfWdAIlWgkBAJK+FJqVPCBsfvmwbxubLk3Kw4iq
	 vTKiraZi3ka81Mw0/ARzIBzGzzPLLs0XqroVX8h0EYSWOfTvCiwrPApA5S6a42WKbsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205862;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ovoAGAx3+qZE9nYJjvNhj2uy7RSMUZ0V9cqFX+7AYts=;
	b=QGX6UXdsObHtlBdDLu/RqWkCxycjdFNnM23im8VCmgFQkH9fUU9ImzcHkszRE4Q9wrM+
	 S5nh3juO+R9ICgCGCKyK/dU8PjsuHTpJvQ5JqQuciLxoMsC1eLS+QGsi6hH2jagNTFkTU
	 O3z19PCTQM00sBEAXzt8XTXRWYUnZ+UYDPLsK4lOhTnMNfrXluWHl0gzRix1/XPbUUdtR
	 l4kb3ZmYBmD+hK/szUufBSG1DxzEVS0JxmMHy+rYqvIV17ZfcOi6qJ/V981qFk0qHsOlO
	 m5IMG3dPUtvbpbiZoKT3hnPYbJgwPIzXjZknQ1YKDxSvpRslb3yAvprOIxi9KaVWYPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=mCAXVuLb;
	arc=none smtp.remote-ip=209.85.210.41
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0625B606A31C
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:44:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0625B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=mCAXVuLb
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7f84a55cc06so644014a34.2
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205860; x=1793810660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ovoAGAx3+qZE9nYJjvNhj2uy7RSMUZ0V9cqFX+7AYts=;
        b=mCAXVuLbRcJw+niA14B7dBN6frmTG0VkXvv/PeVaFifauD6dwxZ6JHiwy9XkQxNFG+
         RZV1IcRp+w2GutHi86H6VkMplicMvR62EFewBZDNjUQXX19gS9ml/SNGF4FPW46ezeQD
         Y18P11OPZCHf6GPtHJ4q9B7Xm4Jp8vhRVPtcofbr7hqagexQCeIlHX3IIE5oN2jErhq4
         gUjOAX5b3EtK2HTxFzEQOuFdCHFkNHFy6E7GIgIoQgkJd0TWERJJwUQ5wxqURhWjGWMg
         kRo7Gp5cP+oLDfUNcSwesXbAIEmn35pYgqFw1NKr/RHIlxbwfvnEr6W+DL2+z4/uxvM/
         rRMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205860; x=1793810660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ovoAGAx3+qZE9nYJjvNhj2uy7RSMUZ0V9cqFX+7AYts=;
        b=VEyofWJa4RAdvVS5nFzwg94OmkAgtw2JQiWGMgEVnDS1LiMfnVPpr59MTvK/ZtBe3Z
         ZWtiF430XyaR4LILF8EXzn725V6Xhoau9+JFjKYwAhnTKDLzakWlr+7+x7OB1pRs7+/m
         GAvM9K2pdAFkSsLLfS2DZO3IIvo3eykqHepp0HbCwKFF2+UvSIG7DNxOc0MD4VTVO279
         rL/YULQDonbBWW7+a4NsZ6u4TJrsLCKHwyoKBK9tcFr1Rs871F2gUNrggYmB0Pe/zB7O
         m5XYRZH4U0iW31fFDPKDAzIjcPatUE0fmdYRKWIiCBc2nEc+M4Zht5QVGK6Q+9PEfjJa
         65bA==
X-Gm-Message-State: AFq9FYLQrgCjxfcUKNqL/jhQpYX9pdgTPZw/muzvvXCUST6mDZF+wc2M
	0IoFMFb3VVd3F4qMZnn4NZrFf6fGvEikG3cm659CNaUV7C6cHKPyenFxzyWbA85aVRy/1IGGCvC
	ZJtqPWU8=
X-Gm-Gg: AYBFou2FwKNXX93AhoDUQDrR92dFSh8YBAQ1HlqWkO3ggmHB3+VjYJwh8dm6Kymnr1E
	GfZ+d8MPUIIyPKpKu8x6CgIg59oLGSLUiC1JQmsndhC2h5WoWHqWqo7hS1VGGZpYhB1OhtiRd5m
	fYeHiTloATNWvxppzbytjcRUrfAl2mDDsOqVF7JMW7StDBBK1rLLfjhfC5qsw8WOo02l8JDwt3U
	QcrTx6goKO3kBu7lkx6hGbJ8oqlrQ8G8IA96AJVMFdzjXXjulQH8x5UdWc5Y8KSKK7j037j7Wsz
	iEj2k76u9s0KrCgKsX9/sb1fK8emKglWdg2WSNhaLXbJCccEad1Qlqvt92viDp6kdgxTF4Lcbon
	qjCkek2V6NEnvII6dKviJqNhE2VeHq2VfPqcq1/eObX2POJL4ourp8Thrja8qji2A6StirXJlVB
	5I4pA7Jwt7Zteb7HQ0juVuv3/MJW9UxUwbUVnPktl46hy8PxEsYtRK4sqKUd7/BKEaCSmUBLWZp
	cC5g62ch0uN0ZkXJXe0YNivgpqNmwVM44TTmHcKdnh1NoY2Pcb2huFvYU9NqV/brLzkomb0EpL7
	nc2Diy2jJDOnDGn0h11yko7NPrKKtVvsTz1JwnyN1p5ZCBhvdoL5aPixtfkrsNpuhEu+Bak/FA=
	=
X-Received: by 2002:a05:6830:2b26:b0:845:8d86:9f7f with SMTP id 46e09a7af769-85abf969183mr2587584a34.8.1793205859856;
        Wed, 28 Oct 2026 09:44:19 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:44:19 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Tejun Heo <tj@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 01/98] blk-cgroup: keep the old blkg while reassociating a bio
Date: Wed, 28 Oct 2026 10:41:04 -0600
Message-ID: <20261028164415.1262013-2-axboe@kernel.dk>
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

bio_associate_blkg_from_css() drops the bio's old blkg before it looks up
the new one through the css. The css is pinned by the blkg, not by the
bio, so if the cgroup is gone the bio may hold the last reference and the
blkcg can be freed under blkg_tryget_closest(). The rcu_read_lock()
around the whole thing used to cover that, until commit 457d3c4f0fdd
dropped it.

Put the old blkg after the new one has been looked up.

Fixes: 457d3c4f0fdd ("blk-cgroup: don't nest queue_lock under rcu in bio_associate_blkg()")
Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-cgroup.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 82b66147d778..e79177ac2dc2 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -2139,8 +2139,7 @@ static inline struct blkcg_gq *blkg_tryget_closest(struct bio *bio,
 void bio_associate_blkg_from_css(struct bio *bio,
 				 struct cgroup_subsys_state *css)
 {
-	if (bio->bi_blkg)
-		blkg_put(bio->bi_blkg);
+	struct blkcg_gq *old_blkg = bio->bi_blkg;
 
 	if (css && css->parent) {
 		bio->bi_blkg = blkg_tryget_closest(bio, css);
@@ -2148,6 +2147,10 @@ void bio_associate_blkg_from_css(struct bio *bio,
 		blkg_get(bdev_get_queue(bio->bi_bdev)->root_blkg);
 		bio->bi_blkg = bdev_get_queue(bio->bi_bdev)->root_blkg;
 	}
+
+	/* @old_blkg may be the only thing which pins @css */
+	if (old_blkg)
+		blkg_put(old_blkg);
 }
 EXPORT_SYMBOL_GPL(bio_associate_blkg_from_css);
 
-- 
2.56.0

