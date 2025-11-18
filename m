Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EE4364EB2
	for <linux-block@vger.kernel.org>; Tue, 18 Nov 2025 15:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763480327; cv=none; b=oH4YPk2Ju8p9gYi6zeaIDZE3JczYdjhQ1kafPk+sUn3sWvDGVDj56fUaPIGBKhm9PbfCV/r5YNruwCMn+RFD+3onIrH5QmIfTx7kzMhF0TYcBXiCHg/p2T9dzeJMKQ1k7hfyHh6/zd5bo0fWsQlSxb8l2YMDfHPLnGttD+HaLF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763480327; c=relaxed/simple;
	bh=aen+oC0Mjgw/Hi8fNaWzr5NBAgJMpRWGDxaNwPjp2nY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TJAGs/3NILyvZGu4EVtI5aGKe/CSizAcddrWBqJaYnofQbKleD7SqVMiuhdeKpI/vuEAozBl2iUjt/WFQTFNej/auHpCYVw8zJD9uyp8OEr6/UI/Y1n/+0ihmxPjBV3AtF45pkz6y1J6cJEgOF2wAf2WTitlffOvdFbhhdLD13g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Tuy8DMQs; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Tuy8DMQs"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-43326c74911so31490175ab.2
        for <linux-block@vger.kernel.org>; Tue, 18 Nov 2025 07:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1763480326; x=1764085126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QQZtZQUP7iDlBt71n10+YLz3pZiAQuGTG+NACjojoXo=;
        b=Tuy8DMQss+gB7vMm7uxGbOPuZi+Cqj4OQj7pSfS2eCoN9CqSQZaS34agKoD42FTx4T
         0WJDUFP1N4w4a08DPpBBDQQBIknAVbyBlF+IttavRuuyh9xBqDgjxKCfE/9cD9vMMD6c
         gW1B7WO+gQCkZWxJbw6r+U56RzqbDtlU6CBzKYGTa1XLZ1B7QN2tejXmU1qGT0mkzxw3
         mXhp1AbEaVempdhS9tN1ehbJBwfpqWZFv7HG32Z7lF2d2pteidH6wN/Y3HjbV7X7TOyZ
         sau2bQZsnvXYAsLrCNBDGWXilStNr4M2dDM+zqrK6WA1t6DicE4ebaJGCHDS/PEW4qG1
         glrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763480326; x=1764085126;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QQZtZQUP7iDlBt71n10+YLz3pZiAQuGTG+NACjojoXo=;
        b=u/ANusZsqqbkUdd35aOmu8j7vZjBn7Nh9hWKQ+aoCWwZD//y6bpbTsgkHUN8SdgOh1
         aSuLhMM/3F2kFQ6w3HTg1BZqZBcMWdgnjGomVNwRpsOmmk/efUPHabdg+xPE/kJL9M3h
         75hrd5+QrucNxcMtmhJfdK6tzzyBzmDXu9A1gssDBnwVEPiVH8Zr45Rv8X3t4C63TNh6
         G4MDk0kfxLxHuwwC0tzsmiUQyPvyMRHAQ+D6MfDvhXGiJQAHXpVb92t8HVvpDF4WlhA7
         HA+v0Wxms9+ZdcHTpxwWuaHf7aOV+yEiZfM45QbnByl2lb11xg/aFFKYcCgY/0/Cu+q8
         UPJQ==
X-Gm-Message-State: AOJu0Yz0UokOvyH1rQr+fMjnZdN56hH4HXrpOJ8oeRb8lOhpfJrKvagX
	1ebnb5NNgFlTtOT4dBLtvh+qBZIeTT93tzYnZ92AOHnHl5O6u8A6UnZ2/bkbzYTmV/MNWUDUwR/
	JxD2C
X-Gm-Gg: ASbGnctOEesrn7j+YEg22uyNfS2WwkaK1v0j7+Ew1Jy+O/lld7M3cI3uqf6sBQAFCSm
	kMex2cD/PjCFGckHkxGOrF0j6zh+VrusS3MCuBjGt0+i23HWBB0wLn+bR0cqcveoR6rFHkZQsqJ
	YLjhMCQyQMFZSdtfPIn/d8pos+Ej3CN/cXN29rRdcRx4ordU1hqmh98spxmd6MPEfTOpG0TBv/A
	HnpaklU0cYWgO0fyEk7Qjg2ZAvM1QnB5RgcLKecfYA6o/F3GYLkr5cZM96HCpdo4u8d3ryEnyjh
	MMY2okeOjR0CBlaZcu7MU8YL7eKyEJVWp3jECaWVeK4aVr63kOMeAXn3E7ZoAldMQue3R18Q9a4
	EFQKvSdoaCIFLpBJ31OaVumMpHLErlw2Cn+AdP5yUrUK0ivNNTPUTAebEtTPVkvzPsq0L
X-Google-Smtp-Source: AGHT+IEeZcvV60mvVdg2S5XFfVy/rWwizYdULD7M/cWgiMQN9Bm6wPPCZXeHffazR6JWeZdNihZorQ==
X-Received: by 2002:a05:6e02:214f:b0:434:77cf:9df with SMTP id e9e14a558f8ab-4348c94e04dmr238340335ab.32.1763480325708;
        Tue, 18 Nov 2025 07:38:45 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-434833e94f1sm83498515ab.10.2025.11.18.07.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 07:38:44 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Xue He <xue01.he@samsung.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ming Lei <ming.lei@redhat.com>
In-Reply-To: <20251118073230.261693-1-xue01.he@samsung.com>
References: <CGME20251118073708epcas5p141bfdb82151031d41cc4c6c5e606a90f@epcas5p1.samsung.com>
 <20251118073230.261693-1-xue01.he@samsung.com>
Subject: Re: [PATCH v7 RESEND] block: plug attempts to batch allocate tags
 multiple times
Message-Id: <176348032462.300553.2758635392838520236.b4-ty@kernel.dk>
Date: Tue, 18 Nov 2025 08:38:44 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Tue, 18 Nov 2025 07:32:30 +0000, Xue He wrote:
> This patch aims to enable batch allocation of sufficient tags after
> batch IO submission with plug mechanism, thereby avoiding the need for
> frequent individual requests when the initial allocation is
> insufficient.
> -----------------------------------------------------------
> HW:
> 16 CPUs/16 poll queues
> Disk: Samsung PM9A3 Gen4 3.84T
> 
> [...]

Applied, thanks!

[1/1] block: plug attempts to batch allocate tags multiple times
      commit: ddc32b7f2921c4b9f4f9a98a668b887c3514229b

Best regards,
-- 
Jens Axboe



