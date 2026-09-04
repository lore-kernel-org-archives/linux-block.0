Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0AD36655D;
	Fri,  4 Sep 2026 09:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514369; cv=none; b=KFx79YdG03CsyKm3KwVWUTi12R0helprm+uwpUNUJQ0PR7GNyhnp/WG4NgbSFRA1dP29R4wsL2wt/vR0qGCLKP/SF2lfnW1nTeYwo5k3gV5jLQllhKps6tTOsdZg0K2WuHzqf2KhXrtCUAbY0dJI7J5xYEpm/2YAWxcnyrYlpX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514369; c=relaxed/simple;
	bh=dRxuwALk9YTnOMKnzKeofGyeSaQ0m7a8H+eg7bi7LxY=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=FHYBBe1r23bioCPLgQx6/xNJUCx7kfisIRl1asuzfTqJ7ekYC8G9EbMIyI42ZFdllxUWOX54jRuUAikjXTtbCLb1G01/WP5imsC/meMb6zCjjwWUCYsi2DIcGXKMLSVj9fRp/Pjp9w9qKK1uXjqLJtp3vmoZtT3A0e0CiIOFKfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GbWKv6nQ; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GbWKv6nQ"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id D7394EC0077;
	Fri,  4 Sep 2026 05:32:47 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 04 Sep 2026 05:32:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788514367; x=
	1788600767; bh=bFm/w+S7jL9RAO8mk/A15H+X8AjGs3DD7Z/cWbm6Tao=; b=G
	bWKv6nQL7sbe6+0eRgTKF1oBRhW5UwRe7qe2guazWoX8jcoAul6Ax2is8D2HxSOB
	I3DE5424H5/QPWO+SUfavPRSwQr2vnDkr8GfJ7KJ1hiXZ9ZjU8/i9toAYG/tre1u
	eGRxqhZJT8g1c730o+QtjtcRS++jxMuWVEtK5RORZpTuJ3GnqZ6Q6JWv2O041l3t
	DuI2rh6oeW7UxbylturuCaTgWpDFpQ+ixDr4avdwtxnE2ecv2cItUG2clG2r/VAQ
	FtlW4Q4TZzco48a7+1HlGqDNnR2NPVAc4bAndCHCIzpHUZjCHzC2DDGuRk1bzV0l
	g+jiD7HoPViJdOsJnuBiw==
X-ME-Sender: <xms:P5CaalOkx4c2MaNhiMMmumFQmgD-TCJ0-lgiR4O0yAqvoSoRXdb4rw>
    <xme:P5CaaiDpdPaxGCwXufoG3bIVJ4yJtn54QnZAl3HRGAnqwpOLT9eh4FJrlp50S-ehL
    zzij5_lbBgJNT_t4KYHkfrXYu4ZGhBgeiC3gMpQ9TTdofdpYW7MOAik>
X-ME-Received: <xmr:P5CaakJelBYkr07XOAKp1Gyjue3qGs4tAlW7Cf_VDvUP-hIpi1v9vY88WKh052gAq8lWXMN7cWP0q5L_9Vh04iqjOuiZMMU3oGQ>
X-ME-Proxy-Cause: dmFkZTEAKPWJVEMqJ16jAjOL9FB/rBffUzJbSVLQHlq9+RC52fsBvb13o/7yjvGYTuY3IH
    ZNCMm3A3s3Wzl4RLMlWp0jCSYNVS7BZQKRPO2yqi1PfebCSoLOeHqK6FATWT8bd3IKpoKZ
    CEwyBEjTXEy3FLlbxSNZDKwf3xO9EeiRAKVkzcAluKXcPMqMkrDpp1BPxnn7TPE8fvHu4l
    eJtWE0FI2UehL/YEbD5REmldbzGnWmAWgAUgfm0dSu3fH37RyKRhvYbjCw4HLJaLhP6501
    B+Avisf8hlO2cQGDcAA1USTZdkjGliJjHtwHNkdXiWoCX0/+3sglem9KJOr2WDslSbN9AZ
    9w7O41MwDchT6dcIB/ylTa1ARjQAipj4a5vGdq+12spXTRve241PxWv/ILCej2HM63ehSO
    7ef9VoyTqpIRf5MlmqdqNx/esu3RkKqVsQm7RyAtTjMkHdUcY/MqI1qesKyQYIGxkAT0Vt
    zoyCGtnBDTudJXOF7y/xqtrR6Cz+Q2PMfWNDs7ABqx9+x4PlKCnTPRVnOzsZaFqLDy/RSW
    vEbfnZZjZlsnGvfJBbmDO6lPvj1nbCadNg2T7hI14SEXdKbTvsCXQgxWUn/6olcarAwouN
    8lHPpgUDzNy9ZU5EkG6jyhuGZdb7OCXOhb7JQtNhIsoTFmsaP8Qp4ltzTb1w
X-ME-Proxy: <xmx:P5CaajNpHJkcOEAl_rQT8X3KfuzcskrWSHI-zU4hvqhvyt_Hcmx5aQ>
    <xmx:P5Caaq5aLYChpRlpotHDHn0X6eXvPsw-7nAEdvkvGKbF7IJRbo6Low>
    <xmx:P5Caat4NGUTP7P-T6tJf8tja2N1m97d1ZDGqB8pcWze8dx4kWwvmcA>
    <xmx:P5CaagHqBvZ1iJb7GUPsfpKgNmsZFxcEXFKjm-f2w6SCp6q_PVsJSw>
    <xmx:P5Caar8hY4EH1sLU0AAmJRDfwjvnwHZdjxTHgzdzgBH83M7ATKb2PTDY>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 05:32:46 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>,
    Laurent Vivier <laurent@vivier.eu>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <7ea60e0bf6135b9bcd4be0991a257d4c5de22bb3.1788513997.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1788513996.git.fthain@linux-m68k.org>
References: <cover.1788513996.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v3 09/33] swim: Don't start motor until medium is present
Date: Fri, 04 Sep 2026 19:26:36 +1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The spindle motor should not be running when a disk is to be inserted.
Don't start the motor while the drive is empty.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Fixes: 8852ecd97488 ("m68k: mac - Add SWIM floppy support")
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 drivers/block/swim.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index 1ade5c497e10..64073e8f6c36 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -630,8 +630,7 @@ static int floppy_open(struct gendisk *disk, blk_mode_t mode)
 		fs->ref_count++;
 
 	swim_drive(base, fs->location);
-	swim_motor(base, ON);
-	swim_action(base, SETMFM);
+
 	if (fs->ejected)
 		setup_medium(fs);
 	if (!fs->disk_in) {
@@ -639,6 +638,9 @@ static int floppy_open(struct gendisk *disk, blk_mode_t mode)
 		goto out;
 	}
 
+	swim_motor(base, ON);
+	swim_action(base, SETMFM);
+
 	set_capacity(fs->disk, fs->total_secs);
 
 	if (mode & BLK_OPEN_NDELAY)
-- 
2.52.0

