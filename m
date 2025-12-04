Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4D5271A71
	for <linux-block@vger.kernel.org>; Thu,  4 Dec 2025 18:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764872441; cv=none; b=PrLscQCPEK+TPJQT7TJr8K7wAcDd96OcIMi2Af3IyUPcBGASsxXS7OnyGNKs34D1Usw28EtrVfXOEyMuF56QeDWxPlWbuvZzDfCT/Vc1FBRatOyirdwDuhb8zqXWNXfzHBLwiN8I6dA31SHoq3bnaKup8PJT5v1VEeOF1Pb7+Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764872441; c=relaxed/simple;
	bh=E4iaRlftraDlwmQqHLKR3EzuMkbythAKaPWIWuwk/3s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GjzOsUbY7rHWX4gpVYShU3UKWzHb4v9KoORnLk2NCnNrmVYz9wYPw9JI5/z+zfPUd84G4wWNqISD/Y4JX95Cy+VLgzfT6EyxpNmEaDgxnBXEQqqist3Do/rPMF68KIADplOj+1toK7N2dbDQHSAD4jfCK5EaFzpLqmNP7V/cAhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Kj0rt2pU; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Kj0rt2pU"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-3ed15120e55so941250fac.2
        for <linux-block@vger.kernel.org>; Thu, 04 Dec 2025 10:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1764872439; x=1765477239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7l4Bvsh5Fm7h+h3RAFW2TekuY5Wvnkm4pZdsrpvY+08=;
        b=Kj0rt2pU4+pwhHu5foOTezR3MGP5Bvk1aeXvCvHZiiFg3F1Qbzm6aESjPtJKW00T3F
         k4Zlsv19Q0H9YU54qYvw7SYMANXj6c/dx1Zov43sIJLgQN9mtgwYNUm4DgawMlqYrCMH
         U2UMm/AXMu79pXJ8eSabwkaKkYaVCOFbX6DwY7SCIc2BMsSM5kV0zWsUAnIkrlI41QAZ
         njL0vZQR5LfpTOTwkJTQnZv0Q/qIoguTLF5oV3WpomUu8tT8jhYAbiGdE5yPYOr+wam4
         91JozWCeowsb05eiyoCDJOZeRYORCEyni742h6JHwbFdq2ByNG1rDfMJpsuKdtXau/5X
         pv2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764872439; x=1765477239;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7l4Bvsh5Fm7h+h3RAFW2TekuY5Wvnkm4pZdsrpvY+08=;
        b=fNw/m1FRDSxRo1rXZlQ9vTBycmixefjI5s0pyozZbAK+25zyJDWxTUEK9q2OToNX5g
         s3ANtQxWytcglXU0FFrZxrRYiUkm6LpFGidPh+qXzg7vFemBQqJBIhufoVdCmXgZQK/A
         4qf9URYwoBFs9DrjPt3XOUDca+zKQQBxZkoq8nB383OL8YkKTaYOWw/aSf6qMOqShDh1
         5+zEVtLnI7Q548tsfBs9cpxDmkmOXIHquBqIRPjlIxnx7GTIb+DgAKEwmf3S/2q/2sUX
         94gFZFJm0Jzg3vgRqTlUkzDct/JJ0eDeBT92BHGOOSt1ERzF0AJLS1sJO5IvpovLA6c5
         O+KQ==
X-Gm-Message-State: AOJu0YykiUr+9zkxm37kU91e5upfbAsNrqSFjcmOCy0KhMNr1kQLMpeQ
	hn2HYsF3ejqc1vjYG/vmN+3oKwrBnuKjUidSQo9NnWfi16YB7Z3j4C6GXIigVUV+qnyI/FCb+Wu
	Eufye5h8=
X-Gm-Gg: ASbGncvG3OTGSTcm4qx99uzaEFA7HVzu6r+Wt6nR0JYKPzElgA8jgPT+hhn9tFvdauv
	93dtAR0WhkPVFCj07Tlcksu+runxRG82xyuAqs53d19HPFFUN7Q/ES0BgGZXqQPuXawLDZoouA0
	0er/v2SHOKaGUyrn/Ep7ZBJ+KFwqQXYVlwu6Ft0DbVLtc8rwpsPqgZz91BMoY5rvlX40fzqcK9L
	YXaq+bzJm6kZiDjLIiTZ/Mb+on7JXZfxA6g3A4IS6+T+9pM+x4+3nYNOG86unBlIpQUQ3PvOBMe
	ZXotrdkG+R6/MrHWtQAYCUEsqDPqg56/v3+kYXnrmsDSuDp1TbXWNLBZ088bfSKcOSWnH/3PKOi
	BXqz2+DsfJxMuXgqx49rTz3rO+amwQbaeB85hd9K1HZiNzP1dKeHg/FqHqUYVWEnQ0bYrAboEnt
	rBwA==
X-Google-Smtp-Source: AGHT+IFXxmNxHx1/RwmCgScmOCKtrUl6+EjSkjYkHMQhz5CWSvRh2Fg8NSX5nfMZGX4uxn4SYwvcwg==
X-Received: by 2002:a05:6808:d48:b0:444:4086:4524 with SMTP id 5614622812f47-4536e4f420cmr4009135b6e.31.1764872438741;
        Thu, 04 Dec 2025 10:20:38 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4537f8a02b6sm992180b6e.4.2025.12.04.10.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 10:20:38 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: martin.petersen@oracle.com, Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
 david.hunter.linux@gmail.com, khalid@kernel.org, 
 syzbot+527a7e48a3d3d315d862@syzkaller.appspotmail.com, 
 Keith Busch <kbusch@kernel.org>
In-Reply-To: <20251204181259.23864-1-ssrane_b23@ee.vjti.ac.in>
References: <20251204181259.23864-1-ssrane_b23@ee.vjti.ac.in>
Subject: Re: [PATCH] block: fix memory leak in __blkdev_issue_zero_pages
Message-Id: <176487243751.985814.383120227280182840.b4-ty@kernel.dk>
Date: Thu, 04 Dec 2025 11:20:37 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Thu, 04 Dec 2025 23:42:59 +0530, Shaurya Rane wrote:
> Move the fatal signal check before bio_alloc() to prevent a memory
> leak when BLKDEV_ZERO_KILLABLE is set and a fatal signal is pending.
> 
> Previously, the bio was allocated before checking for a fatal signal.
> If a signal was pending, the code would break out of the loop without
> freeing or chaining the just-allocated bio, causing a memory leak.
> 
> [...]

Applied, thanks!

[1/1] block: fix memory leak in __blkdev_issue_zero_pages
      commit: 220d82ee063a38fcdc658b8d4274f59de4398dd0

Best regards,
-- 
Jens Axboe



