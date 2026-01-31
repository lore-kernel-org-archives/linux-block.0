Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E8932E6AC
	for <linux-block@vger.kernel.org>; Sat, 31 Jan 2026 13:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769867353; cv=none; b=mgtd9Z6uaAdEev+BqW3p6HGFyK4LF7H188zHykfEEvf55sG37Guc3vkxxj1Wh4nV1QMSdGhS5YI1YhGCFgdze9L/ig/Ql5liDgdZF4E0qUF6SyNiCSQUbJAFI/Rg4yrOApk308Cx6/+Y5XcxjSjMAwI4uRyLyVdKYv1pm+OhUPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769867353; c=relaxed/simple;
	bh=PIuQwJICRkdXwKlZJc2OOqIS3RqDS1HMvtT/iqeO/qM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AyMCxzWwTZ2VkKm2U8t7TRffqEahxG4Ae3n00uBaK/yUl5XLDW6ue1zyjBPGdQsnBSeoYsMgS1D8mwUE+sGAUFRc7sA6PxJ1QF9u0SOVHK3+d8Q6wM9RMBkRqP1Cr3YB23WLBZR0B6Pz3jlTASWSW7s0n9V2qS+kPQsXNBZwxX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=qE6zNfCJ; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="qE6zNfCJ"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-66106a2f8d1so2115724eaf.1
        for <linux-block@vger.kernel.org>; Sat, 31 Jan 2026 05:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1769867351; x=1770472151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EjuuAT4RnNe5hWPU5ljQ0ilmliBzevq8hmX9YQy/wrQ=;
        b=qE6zNfCJ4fj47PVpAhZoHqB9SWEzAtLTFTP1qLpgX14l+bcCP3eSPZfEojUgc1V0pX
         DIZ9GePwZLnm515bO2k6PANKFieX/F3wUawe+kmkLws8Ma29f0rvZPwCFfq0qcsZfiai
         2X6e+TXZ6ROhbeX9Np1ubukshK3rUyc3izcG2lHawjKShUqp0r1DXxCiXuhysfStF6Py
         5pE6c+KPhHMoH+J048UVa+rUveXeCiPEetAWrYcL7Q38SS4r8Ls9a7O6SwhNRvkAw0wD
         TSAThCZ75L1nU47AbpGUgbuubRXqweP8/cn4LClhnptz24MBt7vG0xqxMaIceSjJsF0f
         YPgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769867351; x=1770472151;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EjuuAT4RnNe5hWPU5ljQ0ilmliBzevq8hmX9YQy/wrQ=;
        b=lo4GNsHm6d7gAPFUP2WpR0DD1z7xprW/Fu6mMW6pyjgpZLsw0UtzQAhmX67cKNwvo4
         uMePzWCUOWrdAHf7jxGDODxp1QdlE9bWaSCO2YLtcQ9YWUmwx0Ju+1AkyybDUdJy+zHJ
         XZs9iliUeZt2sN4tpd6myK617F6aTRn+jSEHwtW9/rC6xWt1m+29xBxDk2y0XLvwHHJ8
         WM5VKvm4DKRFHcVYHH1xSa40HxF69UyEtMG397o2L6by9nAokBEfpfutT6gRpEaIxjS+
         9QWtw2NhKXmd63qQpwIY9myeIz8+ntI9VXP90rQmcRiTm9UU6sTotPRudkz2NF9lMx1N
         UKqQ==
X-Gm-Message-State: AOJu0Yw8qLrMyhy73vCpbVEIBQiOLDYI9EAxMHk7hg5idAZ5IbgiBeQA
	5gPeg8Flmalo4Du2HBTZr8TzLk+cPBCfE8l5BuQVZh9ws9nzE5IetgWfcGzWfNs1HCc+x/b5uzw
	yvmeT0PA=
X-Gm-Gg: AZuq6aJpDATBrr83TLLG2S19vT+zOcc//hE4uDxKG3URVawRVUZ+RYbgTDGk+FYQdB9
	Q+Q5ar5HNDD2NS8OLhV4d7yVzt/EgfQHlRGjmv0BQ56ebfYoAv6pU0nwo7buoRdL++SR8mZWPRH
	NZ+XcggyA8HY9fxyzvAvlpfoeVM6UAKUzs3SMsZvW7AsQo0/FBnIVDEzovLKMm6ktUHstwCZR2c
	Xa7OqUM6OEK0iTRNYnz1ThSryTyHCuwwtr4kR2vz9010j6YThkFZP/NlLWvmd6KPlh6SZYpqL0R
	1ApG6r4IjyrQHoWiv3z8fg8/v814e29vJ4WiRUhv1nRU9H8CTzvlYsr5sXvkbftbNg9Ebr7swVZ
	QEYv72Vn9VABdWucG3lk6lNJj7Bjo71KCeaodxQeyHeiR7ucCh5QnHKXGKhf5jCiL0213dFJYn9
	k1Gi4d+CQJG9lvrvR8AJZC+14+H986t8c42JaO5g+IAuUL13Ae3Hxlz/Z8b+5c+H3g
X-Received: by 2002:a05:6820:60f:b0:65e:f0f9:aa7c with SMTP id 006d021491bc7-6630f00a07amr3069502eaf.4.1769867351276;
        Sat, 31 Jan 2026 05:49:11 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-662f9a19cb4sm6575789eaf.9.2026.01.31.05.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jan 2026 05:49:10 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260130152531.1274646-1-csander@purestorage.com>
References: <20260130152531.1274646-1-csander@purestorage.com>
Subject: Re: [PATCH] ublk: remove "can't touch 'ublk_io' any more" comments
Message-Id: <176986734954.961362.1910133026196372474.b4-ty@kernel.dk>
Date: Sat, 31 Jan 2026 06:49:09 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Fri, 30 Jan 2026 08:25:30 -0700, Caleb Sander Mateos wrote:
> The struct ublk_io is in fact accessed in __ublk_complete_rq() after the
> comment. But it's not racy to access the ublk_io between clearing its
> UBLK_IO_FLAG_OWNED_BY_SRV flag and completing the request, as no other
> thread can use the ublk_io in the meantime.
> 
> 

Applied, thanks!

[1/1] ublk: remove "can't touch 'ublk_io' any more" comments
      commit: 491af20b3c6d5baedb96357d4b12232ae490cbe7

Best regards,
-- 
Jens Axboe



