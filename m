Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09522267731
	for <linux-block@vger.kernel.org>; Thu, 13 Mar 2025 13:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741872283; cv=none; b=UA1pW+5WLGUt9JgxomWzMsxmDY1/OG7XZBw+KaY9MmsxACsVmfgyAGLvKWuz7z/l0TC5hHHW9wFxBjq+7ko1+4j+Q8WezKRBX2PQfxLmBnOb0EAfxOUPQitJokUi40dumDJp9svTi2Z2FG983U8uIVgljCuj9qL/ivWaeE5NBbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741872283; c=relaxed/simple;
	bh=InbA8onC9F6wquLTdvjEiZ8sMyqB35U9iUYYVebe2iI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=n+6+i3a3oQOkRnOMKm71irk+seiLAck5jr+alaNcVrI24ruxqs3taOTj0jx9NaLictH9wRYSCP1q6p5d5zs4FTOLgrKGEYHNO9yVvzsfTkUVR6mfJuT9yJlSCoCAwnRENSBBmgHF0PSXqg7XHN+WplBqCjcX5ZvSvA3jC+647hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=FC6hBmSW; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="FC6hBmSW"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-85da5a36679so91028039f.3
        for <linux-block@vger.kernel.org>; Thu, 13 Mar 2025 06:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1741872281; x=1742477081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9m9TYRFM2Wbb2YmUjUbp0Vo4gnj5yl1hodZTOu8t4Kg=;
        b=FC6hBmSW5gd8i9HU2Fx8wd+OsdocdQ4lmMpdb1MrGPU1fM6VD46ewflA3mdAwNz1bV
         E5GDBaSzaP25t059jAbItI0r4rhcS7WEpOZgL6GR7SGFUPrP6bPVCCe8Qb5aKFdHrMCZ
         K3HLbH27BUwDz7lvDlF5aSYe8ELGsOt/WBbHI9z+IZB6Swd1CGJZStRPq03V8aQbJ324
         jkBlnunQIaTb3aGGufdO+H/sD1t7I/09HAJkt4M6tk0hD2WbTlCW+TGX78l5YCIR0638
         1hZN8Y7RPiO9stQ1gskDnIGx5BQm8EqkmriV1gTOvzcZCnUgYSUFVt/aoE7b0r/m2NHT
         rYzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741872281; x=1742477081;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9m9TYRFM2Wbb2YmUjUbp0Vo4gnj5yl1hodZTOu8t4Kg=;
        b=v9yG2fN0+exVTBpbo+rpFL48nof/uVkDz/tY+RtV08odGjA0qTylJNHImkmaZ8mKN4
         AHf6ZJbaI4y/zUWGrsB9vUjUn/y8LP640N03u17dic2E87wDyzlISzrEKQXd1t+Iat9Z
         2WsMAKvtdVwNWzuDfuGJqCQjjGgeBoFL6o1wyfeSOmvfqCXlLIiZ64WMk3A7gUV5rzhR
         NfWiOMYDnTGbzJyG0EpqdUFR9y/h5aSbYidLOqNkpk9aZgtS5Vl1Lp/d78/j5GNyM2Ru
         sZ81YyOm13VWoskuzlfjsoKfwoRe9v1q/K2so54UH5hxpodUJ7mujskoPTJ5jFVSG2va
         OJBA==
X-Gm-Message-State: AOJu0YzPmOJ7HlyiOA/orNFC7Ixu7KhXk5PvEeTP81rAvmcn/C1p5A2C
	R7QkQ2I5szk/FMl0FXymGiZFQrgi5NEsx+IYe1yap7mBO0aaRiB3oBUaQXOyiz0=
X-Gm-Gg: ASbGncv1Ydy5E/TlNpF5PCkzWG26fezrB/FiDJg1GuSqv8u7zBq79j+Bm/Yy3ie5iRs
	OrvgG0Ut2Jxgz3jQRoX2/KGCCjCZ8cyt7SPP84CyjZXz61OMdcETdPEbDYK8UA5qu6ADbzA0WSm
	ZUZGtnxwJ650a5cwms4PRmKmfk74ny7mMYZOPec0SFEHQo4N9+yUdvNNC6KCnRUNO12a/JWoeiY
	RWDm5zRWA4uimVzHSU9G7lxRv5jzzkRTggq+XSO6L/AC2v6S7apDYvlkX4AKWouoWYDFor6Ukld
	kdTMT9eq+rU4/FXvsj3FJv2ZyTEY2H6ydss=
X-Google-Smtp-Source: AGHT+IH2AcCTgvyT+v79+H3REQPUXzHVkcIlt/2zAciSI4sX6xtn023o14ZRz+Vz7W9fdHJ4nUm77Q==
X-Received: by 2002:a05:6602:4008:b0:85b:577a:e419 with SMTP id ca18e2360f4ac-85d8e1ac1cfmr1282781639f.1.1741872281089;
        Thu, 13 Mar 2025 06:24:41 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-85db879e512sm31580739f.28.2025.03.13.06.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 06:24:40 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Nilay Shroff <nilay@linux.ibm.com>
Cc: hch@lst.de, ming.lei@redhat.com, dlemoal@kernel.org, hare@suse.de, 
 gjoyce@ibm.com
In-Reply-To: <20250313115235.3707600-1-nilay@linux.ibm.com>
References: <20250313115235.3707600-1-nilay@linux.ibm.com>
Subject: Re: [PATCHv2 0/3] block: protect debugfs attributes using
 elavtor_lock
Message-Id: <174187227989.18244.2426507810626348446.b4-ty@kernel.dk>
Date: Thu, 13 Mar 2025 07:24:39 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Thu, 13 Mar 2025 17:21:49 +0530, Nilay Shroff wrote:
> This patchset contains total three patches.
> The first patch helps protect debugfs attributes using q->elevator_lock
> instead of q->sysfs_lock.
> The second patch in the series removes the goto labels from the read
> methods of debugfs attributes that improves code readability and reducing
> complexity.
> The third patch in the series protects debugfs attribute method hctx_
> busy_show using q->elevator_lock.
> 
> [...]

Applied, thanks!

[1/3] block: protect debugfs attrs using elevator_lock instead of sysfs_lock
      commit: a3996d11f3ab743e6cc4e3529ce9459c2cd27139
[2/3] block: Remove unnecessary goto labels in debugfs attribute read methods
      commit: 78800f5997d8ae0f20d4aced66a524f0f2fc4c7f
[3/3] block: protect debugfs attribute method hctx_busy_show
      commit: 0e94ed33681424a6dce65c62837e08e4c7aa09ac

Best regards,
-- 
Jens Axboe



