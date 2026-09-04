Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C9543FD0B;
	Fri,  4 Sep 2026 09:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514306; cv=none; b=dHFQkSqm228YRzOyxysp7fCS6iHt+ZxMUpcKMyKgbzCnio+ZLQY8N2TBbN0Ehbyp2QXnEHrmNgqpt+//twEfk6NKWbk3PdSn82fTcLuNvb7FCvJ1q3YcCeQMB1WQAIR5n1cyqCZ9FsLfP1+58vsQf/ofA92AzV1y7Wf+VMU28mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514306; c=relaxed/simple;
	bh=zLTL0XSX377Q5uxNjt9iEMwwDbPUSFjdEiz/iPykOT4=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=KV+ESIqOalQO8tkr+uQ6B2m1AbA4zJLUeWpikzmd+mSRHIG7WUmMV5MjzOPUi9cylTp9cLmpSXjrdh29jvuStJDgVmha+VsgcLsmO5tBooVgRAJzqOuryMbBU1m+3ijV6QL2i85u1c6QIZ9K4+kG4R3VMGGsRb65YP8THsE8lrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JM8p6LZe; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JM8p6LZe"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EB3D21400032;
	Fri,  4 Sep 2026 05:31:42 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 04 Sep 2026 05:31:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788514302; x=
	1788600702; bh=6enK1e/BFMkuBg8+irnlLj0CqFHztSRmCrF0cLMxqjM=; b=J
	M8p6LZe1YpTgYlrsryI1mg2tesLwa8dqyQdeyUovoE673BUHR8YEeivKcLtkiysr
	k2VLWd2hzbtb80eZXGwng42YKGZTLBpk2iOecccpwKJWqw8Whe5tJbOl38A+R0rd
	0nUwodBUtvyRUYQszgm1ayvg+DUW702j2qKfv20P8/8F8to9I8FZdAsxlEPrBYNL
	hl50FQIBWqaannYFdCebgUeiRYRhaUbDwkvMLgR9eJzmP8Bvln8F7MOLmn1SE0bc
	vQck2fTnTCnkRzDHBJOpHs4CavJekHyZQA/5/vvfKjnOvuR24QmCVZ9qtJJCY7WX
	OwfEzqrANvn22iPeU01sg==
X-ME-Sender: <xms:_o-aavCniIi7ZUZjB0_TxuIfSMivisaKOcRDIxh7_L6VhKJlDT8Sdw>
    <xme:_o-aavmAniyhYFdRAxZfnjT7fnYoKbYu-9XJZZ9RcLwNoofySxNOL2Tx_Z1ZA634e
    pMzmfyTDv1ii_eJgMhS7o7oHvibR8S8RujXx9WQcsXxH6fwXLU2XRtA>
X-ME-Received: <xmr:_o-aaqf7wq66X212N26es7bBoKNTIrLqZeNsrWQY8H8zXEjuDUDBgW6mXC7FZdmAu7gU3ZyN3SQe71890H4n8vtVYzJfeGeOvmQ>
X-ME-Proxy-Cause: dmFkZTEAKPWJVEMqJ16jAjOL9FB/rBffUzJbSVLQHlq9+RC52fsBvb13o/7yjvGYTuY3IH
    ZNCMm3A3s3Wzl4RLMlWp0jCSYNVS7BZQKRPO2yqi1PfebCSoLOeHqK6FATWT8bd3IKpoKZ
    CEwyBEjTXEy3FLlbxSNZDKwf3xO9EeiRAKVkzcAluKXcPMqMkrDpp1BPxnn7TPE8fvHu4l
    eJtWE0FI2UehL/YEbD5REmldbzGnWmAWgAUgfm0dSu3fH37RyKRhvYbjCw4HLJaLhP6501
    B+Avisf8hlO2cQGDcAA1USTZdkjGliJjHtwHNkdXiWoCX0/+3sglem9KJOr2WDslSbN9I5
    0PdLxvukadh6i2I3gYKXNv7IUbX6BNxZpHmSMD7c9cj8LUjNETU3CYGgAF/J4UVV6dMxuF
    NPnLK6Ty1cymiY7Q0u4mmW9Kf+3vrd1G/oLEe7QURr78z4cLt7dXc0lqGib3Sp+Kcg11c1
    AbWe88+ExaurIfJicFrg+aWUlTF9szELhEp2fVGQ3+bCbjylHX5ooSrmBmDeCcnRkkSXCk
    HMQAyrlX/EEVccTPF6gaXCVaFc8QqKZgnKOqwR7Ow/RGau2wAYeTKEMTRgAVVkZCmhi/9W
    uJrwU8pGoc/+MaucrM+CH78ecivNEgAJY6B5QFHs6GZvbzQRtJ2L0BtEXd0g
X-ME-Proxy: <xmx:_o-aajQrevXg06CEthrRaLw_txR_iqS9lVWCo2ADbii0jVAPbkFrDA>
    <xmx:_o-aahvbUcfjaK3E4hACd3ZPsRw1V-OnOVwPgyfb8Rk6G5joHF36bA>
    <xmx:_o-aakeqgUTFJEVvQYvUEVgbuaS5sr-brcgtpkny2_ZgtvTrg6-HLg>
    <xmx:_o-aarbY413FD-hqoJ6xbO9o09jwIgGAp8zuX_e10fYgucu_3rH-Zg>
    <xmx:_o-aanyDRnMPvYRreEi-47BJw4AUytzzOTIeVoQsIsFJKJxYXfyT1Qco>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 05:31:41 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>,
    Laurent Vivier <laurent@vivier.eu>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <370f73fcceb53ce4860904ce6cf4f06ade0e43d5.1788513996.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1788513996.git.fthain@linux-m68k.org>
References: <cover.1788513996.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v3 02/33] swim: Select appropriate drive once only
Date: Fri, 04 Sep 2026 19:26:36 +1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

Before turning off the spindle motor, call swim_drive() to select the
appropriate drive. Remove the swim_drive() call from swim_add_floppy()
because it was already called by swim_floppy_init().

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Fixes: 8852ecd97488 ("m68k: mac - Add SWIM floppy support")
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 drivers/block/swim.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index 5d89e7813049..4721e073a874 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -679,8 +679,10 @@ static void floppy_release(struct gendisk *disk)
 	else if (fs->ref_count > 0)
 		--fs->ref_count;
 
-	if (fs->ref_count == 0)
+	if (fs->ref_count == 0) {
+		swim_drive(base, fs->location);
 		swim_motor(base, OFF);
+	}
 	mutex_unlock(&swim_mutex);
 }
 
@@ -752,8 +754,6 @@ static int swim_add_floppy(struct swim_priv *swd, enum drive_location location)
 
 	fs->location = location;
 
-	swim_drive(base, location);
-
 	swim_motor(base, OFF);
 
 	fs->type = HD_MEDIA;
-- 
2.52.0

