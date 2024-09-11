Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52661A2554
	for <linux-block@vger.kernel.org>; Wed, 11 Sep 2024 13:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726061302; cv=none; b=UpY6+BNMJRsKRoOHDcrhT6+Cd/USI39U7FqoQ1cDGywjg5KC+pYdYO1P7SUvEMtBcktC5SAHA99SKFto5lkgM1U7r5jqqh7QbmXnITCPB+JfYs9C7FgtEhcPjUlfyuGM6kbZXgLX0odBOXEUSUvsHeu4geVnFom/RYT4hdJcSD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726061302; c=relaxed/simple;
	bh=3DSFT/npJi9970T4o3KKbDacAKLL8mWYJ2s0dDKM60k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=smzS5LxzFsSjzfdbnu4gn7Oa2JMR3XLVwXFdEZK1/oc8zXKbrd3wyzkHnUcOWQq5cWsDj28hcjwoLJSimpKaW2PRW3Y9bcfwwFYFpuHI9Zeg1Pn7iyvuMLCyf5fSL8cihjldqOtuNSyGBH50zkDoeGeGPaq7/gHd7wRkFrabq2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=xcpShNGh; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="xcpShNGh"
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-82a151a65b8so96810539f.2
        for <linux-block@vger.kernel.org>; Wed, 11 Sep 2024 06:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1726061298; x=1726666098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nDGxOFZ0RkjN508HAPF7AaCOCUvWSabWSjdbing3vss=;
        b=xcpShNGhM+H2W8OwAoO1rVmqlPK6iDVrQoU0IYFS3L85NCX880+1ZL8aPbRcoEdoTZ
         3uKe6sQl1tQliGYyb8kOBJ9yItG+l74BUJarnjiNJme79bS3n5J4kT3+zfFikGGFVCvn
         HHAGHYOT+eGvol37jd5S8DvR8TcRwUGbyrp/ij74+0LWf48N3pKjnQb4HJ8y81R44Nyo
         u4bHOB3j529eSicrhkpTNIw9nQzUWPKY+++codlgSTQA1Z5HfcpGutdB/lfhzQzm/8y3
         vBLyJQ7gQmD48q54HmZk0aIPZDcDi1cczxISeCf0NQY1jr7ai7u5Z33fmoDYF1Vq6+oS
         oE9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726061298; x=1726666098;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nDGxOFZ0RkjN508HAPF7AaCOCUvWSabWSjdbing3vss=;
        b=mDQV42kIwwvjR/Hv97/jOnNZHKiJuxCpf1K+vxTTyJeULMaQSdat0aYnn3vlJDTvMT
         +XEyx0KLOaZK0bRkCZSLrvkFdfO4Pf/y7Mo3EZFBuXMA0A7Cz+EkEXssYr4mHCVw6DDh
         6ZOrlszBUyyXiTo2EsHBYNJGMdMSNTkPEMfmvLGlNyuKw7t0Fg6hhGccX7famLUQacfm
         34Q34MISCUv3nM7KIYYhnYZDYQi/pVsyE+hkpV8pCqPJ2B0zhOSrYwmNfQmLOLp7Kv0W
         PQOjQAZc6qYazwTqHjZs6ijowBcJ15pj6wN9rEiIE5KOKe7bwUWFthK7JWH9YKAQBZJa
         eorg==
X-Gm-Message-State: AOJu0YyA0RwqOjpl4RiLxiaYEum7+MacLLqH+xOwv/iPgQFxo6g3xclP
	Rq25L48PS4TRBHaKmCL6JHkcKldBh7O5zRUTCt0jcZVbqL4GRpWs1O2EuqEZ7jE=
X-Google-Smtp-Source: AGHT+IGCrT/DmwJG4W9VpZB6ormapW/1oik7LNrpghuqb7IVUOXCEDP4c2dGY0YvQOif98NciO/0bw==
X-Received: by 2002:a05:6602:158b:b0:82c:ed57:ebd9 with SMTP id ca18e2360f4ac-82d0a43a2a1mr320061939f.10.1726061298351;
        Wed, 11 Sep 2024 06:28:18 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-82aa73536fasm263926739f.17.2024.09.11.06.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 06:28:17 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: hch@lst.de, willy@infradead.org, kbusch@kernel.org, 
 Kundan Kumar <kundan.kumar@samsung.com>
Cc: linux-block@vger.kernel.org, joshi.k@samsung.com, mcgrof@kernel.org, 
 anuj20.g@samsung.com, nj.shetty@samsung.com, c.gameti@samsung.com, 
 vishak.g@samsung.com, gost.dev@samsung.com
In-Reply-To: <20240911064935.5630-1-kundan.kumar@samsung.com>
References: <CGME20240911065712epcas5p3611d5bddac1828e54c5628a2536ef7dc@epcas5p3.samsung.com>
 <20240911064935.5630-1-kundan.kumar@samsung.com>
Subject: Re: [PATCH v10 0/4] block: add larger order folio instead of pages
Message-Id: <172606129719.167290.14045583678958786569.b4-ty@kernel.dk>
Date: Wed, 11 Sep 2024 07:28:17 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Wed, 11 Sep 2024 12:19:31 +0530, Kundan Kumar wrote:
> These patches have got the reviews and tested-by.
> Please consider the series for inclusion.
> 
> -----
> User space memory is mapped in kernel in form of pages array. These pages
> are iterated and added to BIO. In process, pages are also checked for
> contiguity and merged.
> 
> [...]

Applied, thanks!

[1/4] block: Added folio-ized version of bio_add_hw_page()
      commit: 7de98954687fe152c5f38afd719b3fdf9f34020a
[2/4] block: introduce folio awareness and add a bigger size from folio
      commit: ed9832bc08db29874600eb066b74918fe6fc2060
[3/4] mm: release number of pages of a folio
      commit: d3bfbfb1248498656cd25c51e41c1e31219bd0dd
[4/4] block: unpin user pages belonging to a folio at once
      commit: eb1d46fcd5d672c9da84925ec38f1aca35d40940

Best regards,
-- 
Jens Axboe



