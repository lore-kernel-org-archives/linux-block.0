Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD30684FB0
	for <linux-block@vger.kernel.org>; Thu,  1 Feb 2024 18:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706810424; cv=none; b=pOEkmY7NeOUVEotWTZr2jVK8GZXsKvjjj8OlC8Yaqtz94BjPPlLtFNn35M0Ihj7z8i1W0ZI3YX6iVSW1b44ygPoJjKp+aneVe3BH4fVyq5bkPT5/qnDY8+ZH9oVBNpPV4mZUzvlAeuIkTA9OsDFH7ztrYL93SBsrCEaYq8QfuRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706810424; c=relaxed/simple;
	bh=tggWUAivVyJhHb3WLH9fYfPCLVXtiXbZt06E4ruadzg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GGOQ92V1QAPm6DyyB0xBKbEkStrKAGp2pkSnRsdFeJ17TvF/fAFbeS8i5Zq6L6yrRKngC35Um/C/hn1yfmsApacXzEixzutMyjUzAa46XIF+NvLmXh7Rmhi25WfVuOtsxzyeVvOnFzSsfkLKIsDPjoClVon7O7PZYBmBV3lVd6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=2LTv9N4h; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="2LTv9N4h"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-361a8f20e22so354405ab.0
        for <linux-block@vger.kernel.org>; Thu, 01 Feb 2024 10:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1706810421; x=1707415221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xuXs00SouWU+bfUEvdSrCjdAuWK9g2pMKfreEo+/SA8=;
        b=2LTv9N4heP3zy4/IGtLMcWNTfn8ff09NWuAu/hSXrUA9D+A7StyyEKfVlaMB1P99db
         0EHoOUms/+cg+2QtkuUH5EiPG0PUz33eIK6dhPF65IU7inalZTBl4549DaDP5y6gHO1v
         l6u83RYhX0JeSA6I5tYvxTuWv0Yzue/EB1yodQtQpoLDUVKEzYOxEqQrp3xa8yAQSt/Z
         JbGBPk457R4kI/oM6JGd6nSUwiNjERcopZM6EIE2eaHjGJ9gfeeGLqoVevvB92LS5tCR
         41Cifhww/MmWTgiulwcv5jvgCB8dLXcdryvEvWRoJFCEwGdWwy1Ve1QoXLvhfve+/yPQ
         Vz+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706810421; x=1707415221;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xuXs00SouWU+bfUEvdSrCjdAuWK9g2pMKfreEo+/SA8=;
        b=M95ymC8LGUxWWxn9/20Z3STQLgFo8GF8/eOfH5T2wwwiwGwRqMFzQx8VPFGZo9K6yc
         HFnfS/1fzHoi6ZmKJbU3vY16LOB7FVxYMWmCgKznhAxxOlBN9U6rcIhGn5LbGyF6pvH7
         /w/yzuPb23BOg+AkMpJrCD4B5r/u5FPFTlY2YmtDboXoqIuy72pRujbh32dUY2gDELbd
         SpyJAK1McRc4vVpty5vxCjodA/Yol8FGjYg8heI/ZY0LpWwePqUCkAX3HiotlgOodGaa
         Np35MNJd0X/c2iUKGm7lPrnOvWesGylKmcJz91nU0rhcWYxRQAFipkca/5g/g8dqvrQo
         ljFQ==
X-Gm-Message-State: AOJu0YxyYeI1wWIS6XFPLHcio7LaYmqruok+GTfPfsYIwmkv5AKXSxFn
	tMrd5WXMhl/UsnOT8myMj51NFNHkSa5SyAkv3TGUrPbBTqTGnXS8oi/bpd+C0iQ=
X-Google-Smtp-Source: AGHT+IHFGMCDx/rCwfIbzWpWJzB8ZT69Ezk9RJWEnazXn7AI05wsEpCY8hFKJqRYkJQrNa2d8Dd6RA==
X-Received: by 2002:a6b:ef13:0:b0:7c0:374a:dbd2 with SMTP id k19-20020a6bef13000000b007c0374adbd2mr609538ioh.1.1706810420863;
        Thu, 01 Feb 2024 10:00:20 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVEu2AcV1cc6clQ9bxFiZCjuSibYqUr+oawrqsuMmBSYqbKtSam92vJM+1k6MJ+Gvz0gP2RclcgsuqZ6fOvH0SdoZUS3BQeY4ZgSDKRwaGxbS8SdfPTZwEnrnwFWSMHL037IRAfootBfFt0ZwE7rP+SEKjC4VP++RUT
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id x1-20020a02ac81000000b0046f3f0622b9sm14729jan.84.2024.02.01.10.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 10:00:19 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: hongyu.jin.cn@gmail.com, Mike Snitzer <snitzer@kernel.org>
Cc: ebiggers@kernel.org, dm-devel@lists.linux.dev, 
 linux-block@vger.kernel.org
In-Reply-To: <20240130202638.62600-1-snitzer@kernel.org>
References: <20240130202638.62600-1-snitzer@kernel.org>
Subject: Re: (subset) [PATCH v9 0/5] Fix I/O priority lost in device-mapper
Message-Id: <170681041965.31162.2641020095015336621.b4-ty@kernel.dk>
Date: Thu, 01 Feb 2024 11:00:19 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Tue, 30 Jan 2024 15:26:33 -0500, Mike Snitzer wrote:
> I've revised the patch headers a bit (patch 1 more so than others).
> 
> Jens, please let me know how you'd like to see patch 1 land
> upstream. I feel like it should probably go as a fix for 6.8-rcX; I
> have some DM fixes I will be sending Linus this week and can include
> it (with your Ack of course). But you're welcome to pick it up just
> like any other block fix.
> 
> [...]

Applied, thanks!

[1/5] block: Fix where bio IO priority gets set
      commit: f3c89983cb4fc00be64eb0d5cbcfcdf2cacb965e

Best regards,
-- 
Jens Axboe



