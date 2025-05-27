Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EE929A9
	for <linux-block@vger.kernel.org>; Tue, 27 May 2025 13:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748353114; cv=none; b=bfS5m5Edorxq/+piPsthoLSdHrRV4Ttq3lTTDyVmazz5RIeoGfKmH4hg5yxewzoe++g7HgRo1RW7Ceq60ReUi5qm5JHi7RrlNF8uLSV23dPOzG/0Q6zyCCxmkN80wVSpHsO1gBjrCzi5xROgKsaXNZEsnBtEIIef2BPA7A0zSN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748353114; c=relaxed/simple;
	bh=IRnL26yWQubYAmM0trqw8iZN/s8xec1ny+6viPQeVy0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=K/JuMiqvC4i6X3bSB2F1zNDPfUI0vVGeATPjQAi0qKc50o4OBkmxFmITlTdmKf5Zt/LEGP/Ipti0tj8e+9AnLOlwjbS0Ove888g4W+V+rRrCMXA1GxYzp5a4V/vgG4s3VasD53b50vvIUeFCeWGoyuRRNUHzW/SbAAOfZd3BQC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=YULFVzmm; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="YULFVzmm"
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-85b38fb692fso46632439f.2
        for <linux-block@vger.kernel.org>; Tue, 27 May 2025 06:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1748353112; x=1748957912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TXdprp2M4n4x/hDHTn7TaL1n02o3UoZxEfZi2MHg6Oo=;
        b=YULFVzmmBBSBhReT8rBtY/5duSHSFBPe7OthXm6GxkUeQfZKN8xE88n2ojPco/ZA3F
         kDpwz4Mcm3/ReIUUjhCWfXgTJaDzK7l/XUInlSkfTfGTryCkh5yHzkqs67XNpSG32qnn
         6Za80s2w0Z7kLGg9ez+zeKPxQV13dLfu3/tUs3URzB7TINszzV9JxcIXq6eWdFy5AumS
         DDxUub1F+ufYe2IheONEuBhgVmW/9X5oa0FCrp/8TreFYpvai0rW7ABKJeWfKVtJ0cLK
         /hotddT516MCj1SvsmyerfA8jSrIXJ+e39Rh/2cdqkrmIunEbB0bGp/0ucNZihNptQQl
         dF1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748353112; x=1748957912;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TXdprp2M4n4x/hDHTn7TaL1n02o3UoZxEfZi2MHg6Oo=;
        b=Xw/kTq35Hqdp+7wwCiE9PiWterjZQ6f2vPA16F1WgRSrKz2OO1NzbXkJ4o6ompVtl6
         mxHB2PwCeGEj79Kebs4F3sJs1MdH7agX25bCHLLZHBD2B8n3NvrDaxXBzMeMBW/7hXKZ
         NS11vK6QfnNYsFL3TqhK0v9q9rO2A5OvJpiNCgvID/YfmRaYU7GsskwU2zsT8vg3QNk0
         ALS34KSQwKaqQ1Ur69q2fW9bXMqIHW9670UcXnUlkt+DEWKoNhS6B+ciy3TE6LiYUQb+
         W97QaZbXXn9GAWiqu/wdve/Yb0ioASxipKc0YIbRtMe8/JeyhdrHFZFGaUIaPHUJAvd4
         viNw==
X-Forwarded-Encrypted: i=1; AJvYcCW+Ll+CvbpHOGPJDzOnhPp3gQ4pgvyha9GqgATk/XCeArrUinXgI6HtyNfAYMtcwCSF9UsaA+vqJFFDOw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzI7igAM8UJY+ev592auvXpJfCrCkGAyebl1FElGYCK9qNj6N8S
	deVqqgEcWxzIN67gTyFAkE3MzvR99lodyPDeaE8RX81ocu2sN8I/hG5isettrIH2dc36cWjN6NB
	Jl6Y9
X-Gm-Gg: ASbGncvKclaKaj7uyeCg4lbY64nbxwwtDgawARZoHJXVpUrs22Mq8keurdCWJOXyhoC
	toGtLleSAoklaSLeiD/sw5WKOU8j9HWy4R/aAymrlHADaVpX6wtMbq0SNWDn0lAhSQ3M9J7VJ5N
	SlZ6A/7gmAGLbyS4MUVHk85LkiENtKx90RUGIFIqgFD/Gtzd48MS0/cDE7yusgY7yr0n+NLSFS2
	6sgwewtZfJQ6ydszNqf6VvxBt5ufYPLENO5EmxG7HY/puZgcfgZEM8a1LVNQtEzuYnE5reYUz++
	KvUcSkXEdwarqTfJnIYD7j+BPqdHYTK45gZirk5ptA==
X-Google-Smtp-Source: AGHT+IGqdnA8GXR4KIorpMW2Y8clpddOdkxA/tTng2GsFFAogRkjTZs38r3zpV0pNXTj8mDhdGeBNw==
X-Received: by 2002:a05:6e02:12c6:b0:3dc:5be8:9695 with SMTP id e9e14a558f8ab-3dc9b663fccmr113230395ab.3.1748353111711;
        Tue, 27 May 2025 06:38:31 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3dc84ceeca7sm35685895ab.57.2025.05.27.06.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 06:38:31 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: colyli@kernel.org
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
In-Reply-To: <20250527051601.74407-1-colyli@kernel.org>
References: <20250527051601.74407-1-colyli@kernel.org>
Subject: Re: [PATCH 0/3] bcache-6.16-20250527
Message-Id: <174835311090.454262.3692110373889951104.b4-ty@kernel.dk>
Date: Tue, 27 May 2025 07:38:30 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Tue, 27 May 2025 13:15:58 +0800, colyli@kernel.org wrote:
> Please consider to take these patches for 6.16. They are generated
> against linux-block tree for-6.16/block branch.
> 
> Linggang and Mingzhe from Easystack contribute two important fixes, the
> patches are verified in their production environment for quite long
> time. This time we have a new contributor Robert Pang from Google who
> posts a code clean patch.
> 
> [...]

Applied, thanks!

[1/3] bcache: fix NULL pointer in cache_set_flush()
      commit: 1e46ed947ec658f89f1a910d880cd05e42d3763e
[2/3] bcache: remove unused constants
      commit: 5a08e49f2359a14629f27da99aaf0f1c3a68b850
[3/3] bcache: reserve more RESERVE_BTREE buckets to prevent allocator hang
      commit: 208c1559c5b18894e3380b3807b6364bd14f7584

Best regards,
-- 
Jens Axboe



