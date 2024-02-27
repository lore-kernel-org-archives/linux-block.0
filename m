Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF45A14EFDF
	for <linux-block@vger.kernel.org>; Tue, 27 Feb 2024 21:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709068917; cv=none; b=TWjd6F68TF715f/1E2yacUoUwsMXIBigyBdfyhjWsV4EyL0HRR+D32huME2/Zod09bnI8QMeP8FTlRDvOEdkosiI7pTGADlw7cY7y8rD+gmFHNub4EiVuvC8+4wWw96HTR6OL1v1MLMvXycaRNqnO5RpYmukwjcgfSUiliyYZ1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709068917; c=relaxed/simple;
	bh=QjcDl2yYldkbyheJ6SXeNJ3eM6601ARCvTosX7wbXFo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ApgqBNLlThf/sHEHHAIm0vG73qJ67Tbr35gx13TuHr+2ryyIBv+SrR3TxCKrFI6YYX/2f+RUr+BO9ja+rWlX2vp9R9xuW87NZGomIQyPuE/dlNeyipZ2GIBCsSnGwVcvwLV80DN1QVvEXdH98m5zYEFKD1LDWSBqxQKW7RpLkNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=RdaD7irK; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="RdaD7irK"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5cfcf509fbdso2207489a12.1
        for <linux-block@vger.kernel.org>; Tue, 27 Feb 2024 13:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1709068915; x=1709673715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FjjMr/gBxFj+dMQL3GVk8vDb+wPW9nf9Ij7pdIMqb9w=;
        b=RdaD7irKBEt1TVY7tZVfPpQLhh0j0j+ZNy9xKjk8kskVF3IGWiNcnTeMs4tnHxadsX
         nFtSIYTxh9CSLHuQjiZOXnWw6FB2ZUs5k/Nc3NN2lNlFVMFXVkGiHfZ+x3T7ZbpBCo+F
         mx1FJXPYa+z+8NkBZELpgRB2lKjjGlfLPQbhCqVmB3Qs2McIjHbT4m9l1fpIyEtEIh1e
         j6HmpP4UkAmm/QU3Iv+TZ2zreUwrhghVp/bkLrC1ctp4wNFn9AwgAmqRU/9LCVHbltm6
         XfGntBcl2ATFsmU+e7OJHVdQMZcL8LtAWkxBQaDWB3hIlsqUlh+EML5mtGip+jkj2DNf
         2irQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709068915; x=1709673715;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FjjMr/gBxFj+dMQL3GVk8vDb+wPW9nf9Ij7pdIMqb9w=;
        b=u3O8EfN1MJ/m9CAhdJ+ldKuhZeIlzcugIa5mpO/JmQK+Ct2mtcNGocpyyw9gEh2ljR
         bUhIOEg2xhu85m8aqqwe+wCsBxinXIQRYtp2/W4hlpCDItVewfBXtxfjFnRsvVHxUBt9
         gyAoXAO+pA/fF0VAhY/AxH+zXinrl0RhaP/iWGI94/y+BlBX8e0b3zbl4Q3RjF/4nF0w
         MeyAx+g2IfT0TxddnMN4Br0QK3HvU5DR6GSbRmtfAhoeya1waSBpAVFcoL3qTX11kjZv
         2ALqqlDiAGENzLXv+OigVULnIezG+Q894ivv6i9PFtuNESE1nxZYSZPuCirge+UJ2fc/
         /Ycg==
X-Forwarded-Encrypted: i=1; AJvYcCXVs/7iXFnD6hzH+yvJ9PLiPXbP5nyzeLZ7oa35w3ga9Dg7uTS8D1dAcCTptLq7/nyTEwtDEbdmdwVXKlXU0JmpEZR8NnFnJD6fOpk=
X-Gm-Message-State: AOJu0YzZK1+TkiPcpfB21Wxegt1oXKpk1VCJG/+1IxEORiBkqbX9hoj4
	mBNvlsFH3GOG/NySnoTCMQkcaOHKDSJrChmRTAG95nWSTFL2GOxe2gUJaKET4bU=
X-Google-Smtp-Source: AGHT+IEZAGavcZZtXdcIkiylMu4LEvh2cNN62sm+yVcp6Yc3JZRc/+EsVnsDUENSeCCwb7KDsy9F7A==
X-Received: by 2002:a05:6a21:33a5:b0:1a1:5:e8de with SMTP id yy37-20020a056a2133a500b001a10005e8demr6800533pzb.4.1709068915052;
        Tue, 27 Feb 2024 13:21:55 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id r10-20020a635d0a000000b005dc36279d6dsm6125145pgb.73.2024.02.27.13.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 13:21:53 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, Christoph Hellwig <hch@lst.de>
Cc: linux-um@lists.infradead.org, linux-block@vger.kernel.org
In-Reply-To: <20240222072417.3773131-1-hch@lst.de>
References: <20240222072417.3773131-1-hch@lst.de>
Subject: Re: ubd cleanups
Message-Id: <170906891332.1104664.7977100251649709745.b4-ty@kernel.dk>
Date: Tue, 27 Feb 2024 14:21:53 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Thu, 22 Feb 2024 08:24:10 +0100, Christoph Hellwig wrote:
> this series cleans up the uml ubd drivers and gets rid of more blk_queue_*
> calls.  It is a against Jens' for-6.9/block branch.
> 
> Diffstat:
>  ubd_kern.c |  127 +++++++++++++++++++++----------------------------------------
>  1 file changed, 44 insertions(+), 83 deletions(-)
> 
> [...]

Applied, thanks!

[1/7] ubd: remove the ubd_gendisk array
      commit: 32621ad7a7ea4c3add1dd6bd27b62c2b22500d54
[2/7] ubd: remove ubd_disk_register
      commit: 0267e9cac6de0c25ec1b6e3fef4fd8a87a4774a2
[3/7] ubd: move setting the nonrot flag to ubd_add
      commit: b8b364d2af7483ad82975cf35d5201efe1efa29f
[4/7] ubd: move setting the variable queue limits to ubd_add
      commit: 58ebe3e748353960fcc3b2661273737f45d197b1
[5/7] ubd: move set_disk_ro to ubd_add
      commit: 5e4e1ff820e855a328cf2efb795c079f3a58abbe
[6/7] ubd: remove the queue pointer in struct ubd
      commit: f3c17dcc43e207e4fba511e9e63d52f7098ad6f3
[7/7] ubd: open the backing files in ubd_add
      commit: fb5d1d389c9e78d68f1f71f926d6251017579f5b

Best regards,
-- 
Jens Axboe



