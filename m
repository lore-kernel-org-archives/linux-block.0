Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166C61548C
	for <linux-block@vger.kernel.org>; Thu, 15 May 2025 13:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747316528; cv=none; b=kHEvjIL/AeLsvkBx6oITeXs91fre3arUniwwhujUyUjSR6oxRFXVIvr5eUZ5GnZXP0hWfsyjYTxLS6VggYB2c+wnr75e3wHfFxmGi3GEhbM9brxa8A13DEyFasGWtuYqee8ye3jH6vIP49+ClzlCGaBHLksnL6Zqc7HPLYIY8ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747316528; c=relaxed/simple;
	bh=NKeTeTI+Ej4E4a9IRGHAUTiQHbmwe5zH9oboYpbZcLo=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Cc:Content-Type; b=nkxi9q7lZHWIvjG8EZcrVCUtwyE/26YkhFGb6g3JihNPym4T2pId7TxOwzp2QSh4gC4MUQI1DisrEDit/CBZ84ipa7hziLXBW48UnwcaA5UpIWFiI5GxOYiOo9FWCPwC3z4Rn/7pXc4IkyFtMriE8ILGTzbZR1GjZV7zXiKw5e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=KBEtlNah; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="KBEtlNah"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3d948ce7d9dso2987815ab.2
        for <linux-block@vger.kernel.org>; Thu, 15 May 2025 06:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1747316523; x=1747921323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n+FCRX6VPnxaflRJTsTRuTW2pZHs/h26n2smy0pvtVQ=;
        b=KBEtlNah/1lyZHdTeBFcRf7kxE88DqUnLbOgSTHWumxNE5qUmaJ9TTFP7FyvVBNLeg
         MKDR/g+81JN7Og9b4Xgy71xgL97sJMedf2QO92NlDycUMc8toLCVI2/kCMYScuiwBjlc
         nGFqmwmQxTrdYdHpVHgLUzI1NwXxAgKjiAhCdk024VWgwWMfiSgHp9EqDo+MWI6/SCUn
         N1IhAZnfFryN2MmZ2ArJZr8Ir18+X/PlUPHqiYxj2ZG+BHeqO1YyFhr9l9QAXG8P5IOu
         m55og8g+bFouXemPfJ+SPCiVs9rO8tjB5+uvPMdlEpTzgfX01ETndWQtWnr2/lpkli47
         CQlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747316523; x=1747921323;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n+FCRX6VPnxaflRJTsTRuTW2pZHs/h26n2smy0pvtVQ=;
        b=nBjepRcHttwmmvLHLq8JIkt6wEFIZjWFpZUcNoowdk2WxZNaZnEFT1/ZZG8l1xWV6s
         DlBNownP5JDQGFzHobs+47RnQ7SZy0fNOJwmgV5bmO3t1gN25mAnfa511TE/Q7wqSxSG
         EJ/XB4FTHwt4P6OXRtQ7opEfUfKOTq83alHBD1UPcS8zSsC4+tDMYgRRnMCeyldusuQB
         Mx1+GUEukF9LRauXR1CiC8SgfFrYL+88ITrzBGoFV/xyudy/WU6OwMqWNUyUqCZXVwP6
         bkFR7gdkONfRC92cUc3jgqRFtFxbbw6CFeMMCf0KxA79b6aDV4RwE/hGLeHuWerp9vFZ
         wJCg==
X-Gm-Message-State: AOJu0YwGGU9+wgQj0O/R6iMD5QJNl/PLunSq6/R1PuCZJKaHIxwWw4Si
	C/GQnAf4v9we5rSl3a2qVnzwEhVCI4tHy90V8uwfY3i2Cek8ti0ES2bC3KpJ34ZJuK34pYzlCKy
	c
X-Gm-Gg: ASbGncuiOzp++rgus5gLRoWTWM/SvtrQ1lmkNJUpQEbzpEfeo2jmqZcOsXCadNXUbqi
	s6NyGTb6zS3Ih2jzWYsh4ZOWyxpHdjF8AEDake99UsTZXmHpENKuengqJmNzAOYIrlqyxYXjZwQ
	ySif6sfpOz8VOCul0wbX9V987O6Fb9hJizrAVdkBk+9CnvFZjcNmFxqCtDbS6kGEwDEfRN2ub+f
	HBgJEywH8wfyFgtCshszP83c6GKN9FeJpt3IVu+flqYoqZ2+2jA9JEqdsspP438Gyv+4D+y36xd
	y+dY7EYrK1R7hJBRXFlTbr7gdg7nqL62UOf/W8peZ0FiqIxF
X-Google-Smtp-Source: AGHT+IExea/bN6iiyW7cll09oFrZpVfoCR+tVCGoUOYIBv3yNqZAZDJFNXzbfVx5qcnLxkNSsfcTaQ==
X-Received: by 2002:a05:6e02:470f:b0:3da:715a:dde4 with SMTP id e9e14a558f8ab-3db6f7acf65mr71456165ab.9.1747316523334;
        Thu, 15 May 2025 06:42:03 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3da7e0f9a5dsm39275695ab.15.2025.05.15.06.42.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 May 2025 06:42:02 -0700 (PDT)
Message-ID: <0687b8cb-d543-4166-9d92-d22fc7188707@kernel.dk>
Date: Thu, 15 May 2025 07:42:02 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH for-next] block/blk-throttle: silence !BLK_DEV_IO_TRACE
 variable warnings
Cc: Aishwarya <aishwarya.tcv@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

If blk-throttle is enabled but blktrace is not, then the compiler will
notice that the following two variables are unused:

../block/blk-throttle.c: In function 'throtl_pending_timer_fn':
../block/blk-throttle.c:1153:30: warning: unused variable 'bio_cnt_w' [-Wunused-variable]
 1153 |                 unsigned int bio_cnt_w = sq_queued(sq, WRITE);
      |                              ^~~~~~~~~
../block/blk-throttle.c:1152:30: warning: unused variable 'bio_cnt_r' [-Wunused-variable]
 1152 |                 unsigned int bio_cnt_r = sq_queued(sq, READ);
      |                              ^~~~~~~~~

Silence that my annotating them with __maybe_unused.

Fixes: 28ad83b774a6 ("blk-throttle: Split the service queue")
Link: https://lore.kernel.org/all/20250515130830.9671-1-aishwarya.tcv@arm.com/
Reported-by: Aishwarya <aishwarya.tcv@arm.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index bf4faac83662..bd15357f23bd 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1149,8 +1149,8 @@ static void throtl_pending_timer_fn(struct timer_list *t)
 	dispatched = false;
 
 	while (true) {
-		unsigned int bio_cnt_r = sq_queued(sq, READ);
-		unsigned int bio_cnt_w = sq_queued(sq, WRITE);
+		unsigned int __maybe_unused bio_cnt_r = sq_queued(sq, READ);
+		unsigned int __maybe_unused bio_cnt_w = sq_queued(sq, WRITE);
 
 		throtl_log(sq, "dispatch nr_queued=%u read=%u write=%u",
 			   bio_cnt_r + bio_cnt_w, bio_cnt_r, bio_cnt_w);

-- 
Jens Axboe

