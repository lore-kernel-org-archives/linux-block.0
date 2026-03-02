Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BCC391505
	for <linux-block@vger.kernel.org>; Mon,  2 Mar 2026 21:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772485497; cv=none; b=Z9poCm8TRS9RbpahgSeQrhDErMYHwo0JPPnoF/LP9svRZpKrz948VKQhIm2xWWb4rcozvBaYDpiMXHMtk3+etkHYAU/WaR51HZ4828m9rGZb8Et5QsodC6T0/N/iHiIgsLF9lNoAq8/ooAXdhPs5peueuPc7opvbedZJYaS9br8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772485497; c=relaxed/simple;
	bh=bp8MxfLVfOLDFq0aYZEWtSvDAoA1yKcF7Xeisqp8xdM=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=H6qdg6T+kz84sZ8qXtc/kItA+DcJ6zEuaq0jw8E+hzVfbcd3WKTlKBbTxm8WMkE3zd7Bh+bhI6kKe/tSwAYlHoHL3/KvjmSCbEkm7n8Ky2e2ASWWWQw1al7vp0L2yH5X/DNij1Zbpq5sYvk73LWrMfnVQQ0wjsm9A1hMsLQ/cgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=EwFZJAoF; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="EwFZJAoF"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-464ba2bb3aeso3891362b6e.1
        for <linux-block@vger.kernel.org>; Mon, 02 Mar 2026 13:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1772485494; x=1773090294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A+IPbqMq77bOpkXLRkjJ3UFsST92OHSHvZuEyO94T9Y=;
        b=EwFZJAoFW1Wa8eTWGw+cVu6ZnPfwxnM84odhTiQ6Duqsm2P5Y1dbp6KxVwShV+vDZs
         /k3GnrRHNpqFNe5FSIc4HsyqjV4a9R/5eSw5BxQJ6Az7XUEjKJYHT3dG25ySfAT/ao2f
         wZKRpe0x36T4T9viuR4cwDmZ+YnbgMyaO/2bEtn/DvoRc86skNGgzENgM12YBXESwe0O
         JVrTdR6zGPV734wQ+/w3Fnta4zMk4M+SfsnQiCV9VXSXMMk94F0AnD90o7wG7ETcm6fU
         4Z1F0T1FlHPvuGZkuawZgGcN14vh+yZB3Z5g+k/wMS+D+CCh1MqwxOvgk0Mg6UnR3/Wl
         45Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772485494; x=1773090294;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A+IPbqMq77bOpkXLRkjJ3UFsST92OHSHvZuEyO94T9Y=;
        b=rIht4D2IGevWGP/KI8i27XuDyqPlLb69X1B+wwa0YI+RVTSsugSMOaGPltk+tYNDKk
         jvrxqo49uUg5Q9iZiz7lhY46rpB0SqAyCq2Vzf9AxLlrJrCUNxOR4JsRZTumPLXgR34y
         3W0v03CWyxTXy4PhouRrW5UujkYzqlrwSaCHszzbl6KZk4UAA0N7cRuB7OMtsUlo++Sl
         t6VU1rwCWiVFkYRhb3kYj1kIqEwn16Fw8IyntikmfQZigiJlBDbLEKPF/0LxI4et5oct
         fPFIULs0ZnjpXHCI4lXRW5LEmpiASSe6IFeHDzaeLxD1ocBKJCwtYe3ehGCys+E2W55E
         7LTA==
X-Gm-Message-State: AOJu0YyaI/HXDzSxhUzoGLMoRZBi/b+HNLEhHSCXqdXrHBtKNGbaj4QG
	FdM/Z7tR9S2HqU7mwryDe6R5BYTte8HYcsPx+Bk7Ps2VeiA0I88qjshmYwVXih9CgIpU18W8FFx
	siR9frnU=
X-Gm-Gg: ATEYQzyynzJX7FWOpD4xilzkvfgP/C2UtzqTefIDVzgDVhCXfiiT9U1LzN/zpf7TvhQ
	iTVCYnwqfaIq+Wj5TsW9ay+53E5G0XY34FUHAm5XL1gXfKvg1gxtGFrOlo8qHP/7ZU395Gavsq+
	Nt0cCfPUJklqpXZOUwFzuVucs5sQ5gEwPOe8PIwEaRgxwg0dnY87bTBRm2EO8QZSDjedw09A+Py
	L65UE8rQ+eCsHDtEtPvSDePaTnDTp85dCxw4g7BWChr3uuxnfOE6M2comn8Uv8896UARBVLBCXC
	aofFWJeaP//tK3Z3n5h/G7A0MJbSgBmkgY3+x0En4DWnosnGYRg9+xu2Y9DCvX8sYiYC1Lbgwgl
	JKm/k+kmSMHnpKZMq2HAVLLZ5WzZx5aDn4HJ+T/JEjR4Tj+QZaVIKJsQ3Fm/GUn0wEMHHut1V/i
	WRc/Gtaj2AAdsIeMUF1gYWd91ZvbvATu5ASXEu1+aMrEca+efj4lCRbVquM/3Thrx5prwwfoqrw
	rSP
X-Received: by 2002:a05:6808:16a2:b0:451:4d80:5ab1 with SMTP id 5614622812f47-464a5f0d5e0mr10177242b6e.33.1772485494483;
        Mon, 02 Mar 2026 13:04:54 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4160cff1aacsm12335332fac.9.2026.03.02.13.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 13:04:53 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Song Liu <song@kernel.org>, 
 Yu Kuai <yukuai@fnnas.com>, linux-raid@vger.kernel.org, 
 "Martin K . Petersen" <martin.petersen@oracle.com>, 
 linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, 
 David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, 
 Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org, 
 Andreas Dilger <adilger.kernel@dilger.ca>, 
 Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
 Kairui Song <kasong@tencent.com>, linux-mm@kvack.org, 
 Damien Le Moal <dlemoal@kernel.org>
In-Reply-To: <20260226075448.2229655-1-dlemoal@kernel.org>
References: <20260226075448.2229655-1-dlemoal@kernel.org>
Subject: Re: [PATCH] block: remove bdev_nonrot()
Message-Id: <177248549254.151113.14982963467044589269.b4-ty@kernel.dk>
Date: Mon, 02 Mar 2026 14:04:52 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Thu, 26 Feb 2026 16:54:48 +0900, Damien Le Moal wrote:
> bdev_nonrot() is simply the negative return value of bdev_rot().
> So replace all call sites of bdev_nonrot() with calls to bdev_rot()
> and remove bdev_nonrot().
> 
> 

Applied, thanks!

[1/1] block: remove bdev_nonrot()
      commit: d47f7c173262bbeb09645ec72bf91755eed6b1b3

Best regards,
-- 
Jens Axboe



