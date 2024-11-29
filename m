Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5FF14B075
	for <linux-block@vger.kernel.org>; Fri, 29 Nov 2024 16:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732896347; cv=none; b=IHPO+whT8uOyGqEzFK30x4QXZp9+IyIzWi5iBcYu6ZIFXad2lzNFadIl/oPAf3Zn4063rjZMBIrEh0WBbJleo5WA4SDNA0LRtAzwX2KaUqotnSh9mdy+ALCIiMDQTx9Q/pKPRSRhFSr/GbdI0zBdsv0Ail6/NHjr0SDMNOQozzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732896347; c=relaxed/simple;
	bh=As/MSv+xoRhm+qluxK+si1wEhMytmUboEsGJtTw6GxA=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YxDZMvg0dxK+eGzL+jszEftvgc2ICavEv9SVmjcDeU3yz9Zst77uysgYCKFpop8/yHTYLwEsssy/DGqoxY1QuKt7rxL8Ck57FSTffK8sOTn8P3ycCMIt0dTrIGA1KPyzicpTJtBdz+ZmCSCveUaLljD+FeN7ueEHcRq8z7lPlaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=XRCrfrUo; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="XRCrfrUo"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7fbd9be84bdso1513595a12.1
        for <linux-block@vger.kernel.org>; Fri, 29 Nov 2024 08:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1732896345; x=1733501145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PS82+F3F+rTdHg56n5bGp80bnYHjUJJMQ2IK+x9kNT0=;
        b=XRCrfrUooXHvfI5N2wPmc/wPsu+SawSaSiXgvwR1LeFvelZQezivc3gmUv7caAyCl7
         gzD0jNgwZ4Rs4BSczj1aOiTjQaAGpKIHeOVEVRAh/bHFTdCbgtv/9mI6CGl7O+db9QT2
         h5NKwKTiDNVxF2CulCW52gh6Rg+hxdyPCfUcO+ww8yTc8/54LeXMkW+3cx2+MqY1YAi1
         DAhs2k3IX4Zweb36CXXmjBbFIEP4w+V9P+JTNJlLQZMdddbyAALUnkosRSUWVWdVmuiZ
         /X+Lk0EduBrS72YgVAl72lJza71BXygyblL93tJD2SdYMoih9/nOihOXbN7wljpDH15h
         UqKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732896345; x=1733501145;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PS82+F3F+rTdHg56n5bGp80bnYHjUJJMQ2IK+x9kNT0=;
        b=iVe/06C4JzN/+Y+59m7Xx18Eao57kusKQrk5haT0iA4AA2jM1+4EKr1SECVIYeSN0U
         j/tMyXrwYevX7VH+SsYkM/WcGGudcNEs0cRm/pJWHPI1eTbE0k08MyyVDyChHaDI7agY
         zlr/XS/rmX7IhF3JBN6Sin13XIc238cavLsEV0NE/AKqevT4uUKa93bEF7sykzX2KO9E
         BMUAzHZ19Xx2JKjZ73Bp0ovR6yRP+pO1il5bJ34kIVyy2t3Qiu7mEpzq5f9dOniE99wv
         3ghjGPDwn7E45QHd2Qc1VGzapNY2bJBwtIQlVJAN7fUFVSC10hHGPV71bg2sPNQ54PdF
         kuNA==
X-Gm-Message-State: AOJu0YzFDNl3FMeYnrpPkfY3lvkV1T8QYs1en9P99BLwpdu3Q9zami2N
	d39gdXboEzrTvJ+IldHXK//3foUQ9afl6XBx9tJc5JACUDs0jd574yr8YnXYXsErSt5XKv3Kygv
	F
X-Gm-Gg: ASbGncvkIGYwCexuX7XNW2BbjsBpReADsQpzJu/gNzhCf19mgbctX4u95wgVlDvwtw0
	aYkmKx2fJCA9VrnMhtEjsRf+aSiO4n145obJGI1dfKAxuECKLsFakrO4Lpn59I/EPdOawIyRDu3
	nugOmB103PdeZRjsVAgBJc3Wj65TeR+x3qBrR3uPdn/PKRzfSFQ5JoNeoekxIb2oe7YKkJKSZRO
	yySb9dLI9mpBR34oY2+gA91Qo/cFUX8y7iuYZjzmA==
X-Google-Smtp-Source: AGHT+IF12KiFQg10fHkECaKVyOJUaxaSU+Ks/nJ2Z1d+Heri8r2AAtuRZtYw1pfbjwgvfCtQMMGZ+g==
X-Received: by 2002:a17:90b:2808:b0:2ee:59af:a432 with SMTP id 98e67ed59e1d1-2ee59afa5c2mr3586728a91.31.1732896344791;
        Fri, 29 Nov 2024 08:05:44 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee538ab0f4sm1697053a91.1.2024.11.29.08.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 08:05:44 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
In-Reply-To: <20241128125029.4152292-1-ming.lei@redhat.com>
References: <20241128125029.4152292-1-ming.lei@redhat.com>
Subject: Re: [PATCH 0/2] blktrace: fix one kind of lockdep warning
Message-Id: <173289634386.195600.7193577799069876067.b4-ty@kernel.dk>
Date: Fri, 29 Nov 2024 09:05:43 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-86319


On Thu, 28 Nov 2024 20:50:25 +0800, Ming Lei wrote:
> This patchset kills one big kind of lockdep warning by cutting
> dependency between q->debugfs_lock and mm->mmap_lock around copy_to_user()
> and copy_from_user(().
> 
> 
> Ming Lei (2):
>   blktrace: don't centralize grabbing q->debugfs_mutex in
>     blk_trace_ioctl
>   blktrace: move copy_[to|from]_user() out of ->debugfs_lock
> 
> [...]

Applied, thanks!

[1/2] blktrace: don't centralize grabbing q->debugfs_mutex in blk_trace_ioctl
      commit: 36a76c9c0f6dc999834ad34d64ff85be0b2923f9
[2/2] blktrace: move copy_[to|from]_user() out of ->debugfs_lock
      commit: 98c00f3a7804ebdaacd80a269910f80179aa4a51

Best regards,
-- 
Jens Axboe



