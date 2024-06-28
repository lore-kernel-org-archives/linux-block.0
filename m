Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA2F7F460
	for <linux-block@vger.kernel.org>; Fri, 28 Jun 2024 21:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719608983; cv=none; b=ItwuVZxgUq4S/sT/9v48UbwyUZwO8SIEomXNZMBovsLUX25+doX9uSxoHzgj33YjCqXfc72Uh80dW+JAbtWwALPzO7xT51LeTYgemO4RJv8Dwqb99iD+phtQB3MK/dRJHT30CrKC3iag3DyRP7oMjrqgbH3/brSMDoOokb3MuSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719608983; c=relaxed/simple;
	bh=Lf73qwbrnCzxYVgSNLbPPDUG+srbzIv/9LHAQ+8bNjk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Dnmx7zptNNn8DQQxX8s03qWnTwvB6nbFUMS/7xSBNcQ+QPjNBeY98xLqQ1MyiHrXGnfWjpeUd7SI1KBDMHC3EGX5aognVYFZCaUlbBVYg9pc7nyTrDBnpxbMRTDmhNIjpMhTLWS375FF3aibcUyEc8u1E/hZJFbAYRLgBQfsqP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=2ro1xRta; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="2ro1xRta"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5c41eb1979aso24548eaf.0
        for <linux-block@vger.kernel.org>; Fri, 28 Jun 2024 14:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1719608980; x=1720213780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zElu+BIYA/u1mCcKjvBBbaDY3rw26JFwzptDj0Dk4I8=;
        b=2ro1xRtauihzL1Vkp9KduCuX6fZnJd08BpxrRcIdQ/thptbD0TwCyoSw2Z4htHmh+i
         05Ma6XaFO/1wwfxig9EpWwFqlWjqg8sHpI5BAQLBq/SUOyUpJWYNeX+aWEViBe3bqdfX
         dOBPRw2gbWA0rTzb8JrAgFGGe5MFEloJRECgiYU8C2jTU5cle0wr7/MPjm7Ti9mdVpcv
         WbmEHupn2Id7VyAKEnyI726I0z86mndPQuXm3wkDh5KSTsRoK7oCixcPgtWJYigQawQx
         eVnIXS3WaieSPjjJqmO5kTsTvx0JE2Sl+2fzW3nt0lruup66mPXLMi/H1JjCh0DRZj8l
         xWqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719608980; x=1720213780;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zElu+BIYA/u1mCcKjvBBbaDY3rw26JFwzptDj0Dk4I8=;
        b=gvX+qohbP3DexbmhF9KGty8+vWYvw7ZgznKv+XOecIAeEzC4Y9v1QCnownynHa4q87
         llxSSawkuB11pTnMMCwSX26tg72FnMIxQPM0smuMpxFozPMY5UyP5rkShIG+wJGJaULd
         Ez/PzdO0wbr+zcjwIb/X8pPmvtYeLFO9BVpzpjQVHPI02VujrDOVgngP1s7rXIgQwU1y
         rHxwxoQmTyBS9I5uVfn30VQ51l264Xg9g5YpIK1wJxL11YTiCHf55RjaVwo4YrcxPUc6
         E23rB0Fq8Ee4ik5079naGMipW5Y1tC8kyQ/6opoNml52HmgpYALcrH8aqQ+240auPOlA
         ZWow==
X-Gm-Message-State: AOJu0YwPadL0hDH9NEJDbnpwSvXKWc/CvOvqQ81qjQwe6PIXrjb6w6vy
	3PhDgAkNUbYEauyGvvY5kuA0bH6Xri9vBqMONqWvKzVLY4mwQ86Jdt5UanJOMm/XPWJJIQl7ru8
	4PFs=
X-Google-Smtp-Source: AGHT+IGldaLVASKL5rgdf4ypbbOayve1eQKPoBfYtMP15NR8ldd1jJ8g5Dx0NvsDYTSR5oIvIwd6fQ==
X-Received: by 2002:a05:6820:826:b0:5ba:ca86:a025 with SMTP id 006d021491bc7-5c1e5ca2a82mr23760743eaf.0.1719608979778;
        Fri, 28 Jun 2024 14:09:39 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5c4149c4f1asm347671eaf.45.2024.06.28.14.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 14:09:39 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org
In-Reply-To: <20240627111407.476276-1-hch@lst.de>
References: <20240627111407.476276-1-hch@lst.de>
Subject: Re: de-duplicate the block sysfs code
Message-Id: <171960897889.899367.1517944486022900701.b4-ty@kernel.dk>
Date: Fri, 28 Jun 2024 15:09:38 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0


On Thu, 27 Jun 2024 13:14:00 +0200, Christoph Hellwig wrote:
> this series adds a few helpers to de-duplicate the block sysfs code,
> and then switches it to operate on then gendisk, which is the object that
> the kobject is embedded into.
> 
> Diffstat:
>  block/blk-sysfs.c      |  389 ++++++++++++++++++-------------------------------
>  block/elevator.c       |    9 -
>  block/elevator.h       |    4
>  include/linux/blkdev.h |    7
>  4 files changed, 156 insertions(+), 253 deletions(-)
> 
> [...]

Applied, thanks!

[1/3] block: simplify queue_logical_block_size
      (no commit info)
[2/3] block: add helper macros to de-duplicate the queue sysfs attributes
      (no commit info)
[3/3] block: pass a gendisk to the queue_sysfs_entry methods
      (no commit info)

Best regards,
-- 
Jens Axboe



