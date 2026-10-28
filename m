Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205870;
	b=1vCGPS6hVHFhR+dnnjNRwMV4wsllvLwKf8HXQQA2xXrHE7iQKHjANDFPwquA72Wo9kAk
	 9j3Ebq4u2+zCerAczV9yvpIFN1Loj4RhAZRs0Ps5vzh81aI2SBHId5m8HkYF07MFtmaNA
	 F5ucLQE3EULa2LLcorJ5KTAWY7pwRPO+VGmmLjAI2iG/03Dp2kbXoQgihNcbtSD4F8s35
	 nBpXbNicDKFtVzmo2IQKey3xW+qXpj8Nc+933WP0k3R5zoWc/SFdgrOZOoWA2TKij6NQy
	 a+5vVXqBRdnG0s71Gl1JIYkG1ByggmyHbut2JQroIMCjNI5jq3QmLah3WRKgfnZgUYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205870;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=S3eA+VZAlvc0S5NUkn11h2f3zPy5b0KqjbtK62gwd4Y=;
	b=XS0LOmxB3FP//8c2nGrjdr4H19Pxj3pCa5plkZQnqI7IpsBZhjJWshXDvTAUYgMzoSkR
	 70+VsmDMY38oAHVARyknsJImHTl+N3Nsl5ZY/glkMaqUpyFcExizz3jGWu65ZwzyjNqRT
	 0R3SFzr/G0XRBgwA6rq4pO3U6VXQ3i8IKq8xziG47AWI1iJmlYvJnHFrKKq8Hk8Wl817O
	 Xv8t04gk+whXUrSu2i0CciCGJb/wnwqQPlA8LVQscJKPn1yBpXGlFZ5sY1ounAMa4w94v
	 veSb9LdJ3fgsfi2oPOcyQ246oiGPUIjLR9yaSYAXk3xq1kvlM24gXEIsmDu7TvqVI2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=hZu47N+7;
	arc=none smtp.remote-ip=209.85.210.46
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD698606A31C
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:44:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD698606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=hZu47N+7
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-84e513877a3so1110898a34.0
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205869; x=1793810669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S3eA+VZAlvc0S5NUkn11h2f3zPy5b0KqjbtK62gwd4Y=;
        b=hZu47N+7mOHHt3NleGNOFycRvbyjgEA1eWpLC+K88CN/gO+DlH4rOMEl1ixapaHRRQ
         JIQYn7s6WJNfCBo3pVuXA1hfDJcpV8FdjsFURq28v/gD4DwB0ua8xZVa38jgL5ezBXm8
         FOCz5Jmw3uMjB9YNFgLEPR7JHMUhppuANjEszFAAHLoh6BNA/a2DsS6DlW0atetEbkdE
         0yneZg5pLE14JXOSFUGw0SghIH1ukv6nCGpJWwAF7GDodgfZJ0GkdijQ/vcGziWeRA+H
         2nbrlHJqZ2SAtlSYTSoRZQS7I0BUeYWIEuAf3K04MVlG8f6hIt2kl32l/Rn2M7+hVked
         Xm1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205869; x=1793810669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=S3eA+VZAlvc0S5NUkn11h2f3zPy5b0KqjbtK62gwd4Y=;
        b=Sat0WQzwWAEPs0V6761Zywd+jwMVEDoYm53SjaFG6Km+Ln97iEquApDNTeoa2OC5dK
         7Jl5J9LSBGCfu8d7pGN3YKyzs1lppgPgBdV7Gh912WF/c3U0ScS537IEUK4KQ7eTPoNB
         DmVkWaWTU4RsLE3nk8yARPj6svuGJ51MIvRdLzpBuAj0w2Jpqvm73w6U9MNpG9SSmn4s
         6ThRwJNsa151b5UTOY5laQZjXnITat2Xku94xlL/LFNckC1WvLPH0BayMjVqWgQEv7WE
         XpPLCP8XSTGn+aRaVOqHXiWnaUmfC1AFiQMsaRcf+D7kALXzXszCfSMjaPMEY5bv9KgT
         RZcg==
X-Gm-Message-State: AFq9FYJKcTGLuTG+TWbFstytbLs9eDqiUeJeuuzkQGw5lxTziebGvya4
	abADVGksmXi3DyjawOXPgRnoEDzAv8eod2hokqXY/xEeBv1tFjvZfJAsVI3H6AO3MHrkamg07ka
	xkZIcbzU=
X-Gm-Gg: AYBFou3Qy+nAwsn9VtMv8qIvLPXMuqtvANIEAGsPY3/ej1tODe6mjydO1PHfs9KgnSp
	i9jK0ufN5EVnuqiiF7oce10UQgjYImekQbe1HqZLbXzyiaC60Zm0naFufio36++knF+7QWCoY1n
	sQUq7m955bQwTsJqxzNbwpdfw5xBb1vrhBVWANtwzVoYHb3OvSS7hMk1jsHsq0xUAvZJvI1ep9Q
	LRkNIJsp51MpGRoMMXxmQOOHP5ifOkk7S55n/cGZMfibtwYQGpKm4lLImK+GFS9Kv1saHPQ5Ida
	Ykq52QoI6GVMtiuoxkw/LwkKhwRbPEHTXiGoJ248KZf+vx9YtLYckP3XlmF90z3VJWM6PHxDgwB
	kJO9QVMP1JD6LeJGLSDDbVc0GgoS83X2vhPOHaLznvELpbV5U7ExPmgWaGqFyIPB1hBjyHYPrq6
	WRiwL9wDcKLWjpNAwA/0p3MKqaXluKY/8Iux2jQjd1oNHoUNwyVS8M338aSyKrEb3qYznm0hN0U
	3Lth4jKa4sMSsv2TUl1GQLCGRhVFGWJiaixvQY+8C02lznrVsfkr04hEABToxvwfhgRLFPSxbdO
	pfzZrhyYIJBICFOZmb4zFssK9BnGqqbjTF6uQuhOxOZGpSIHH0Xnh+VrNeJ1nPlWUNZhPqpF/g=
	=
X-Received: by 2002:a05:6830:6511:b0:817:d181:50ad with SMTP id 46e09a7af769-85c1e1a9a55mr83185a34.2.1793205868658;
        Wed, 28 Oct 2026 09:44:28 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:44:27 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 08/98] block: keep the zone write plug of a failed write
Date: Wed, 28 Oct 2026 10:41:11 -0600
Message-ID: <20261028164415.1262013-9-axboe@kernel.dk>
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

When a write fails, blk_zone_write_plug_bio_endio() sets
BLK_ZONE_WPLUG_NEED_WP_UPDATE as the write pointer offset is now wrong.
disk_zone_wplug_unplug_bio() doesn't look at that flag, so a failed
write that would have filled the zone makes it look full, the plug is
freed and "full" is written to zones_cond[] for a partially written
zone. Reports then show it as full and zone append emulation fails with
unaligned writes, even after the zone report an error requires.

Leave the plug alone while BLK_ZONE_WPLUG_NEED_WP_UPDATE is set.

Fixes: fe0418eb9bd6 ("block: Prevent potential deadlocks in zone write plug error recovery")
Cc: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-zoned.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 18c05e2a1746..882d07a7c80a 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -1817,9 +1817,13 @@ static void disk_zone_wplug_unplug_bio(struct gendisk *disk,
 	 * here. It may already have reset the zone and started to write it
 	 * again, in which case the zone is empty but has BIOs plugged. The plug
 	 * must stay alive to track them.
+	 *
+	 * If the write failed, the write pointer offset says nothing about the
+	 * zone. Keep the plug until the offset was updated.
 	 */
-	if ((!zwplug->wp_offset && bio_list_empty(&zwplug->bio_list)) ||
-	    disk_zone_wplug_is_full(disk, zwplug))
+	if (!(zwplug->flags & BLK_ZONE_WPLUG_NEED_WP_UPDATE) &&
+	    ((!zwplug->wp_offset && bio_list_empty(&zwplug->bio_list)) ||
+	     disk_zone_wplug_is_full(disk, zwplug)))
 		disk_mark_zone_wplug_dead(zwplug);
 
 	spin_unlock_irqrestore(&zwplug->lock, flags);
-- 
2.56.0

