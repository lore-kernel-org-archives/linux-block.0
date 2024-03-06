Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F7F1350EF
	for <linux-block@vger.kernel.org>; Wed,  6 Mar 2024 15:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709739321; cv=none; b=FFHVmVhTVDEX6ArQbMYIJqv5CVG7TsgYOucSx9Z0gpe6vlVMyKj1uKvjPn8jJJZQm9z7M+hwEz7sXJlErFezH3xnc5ut+fVfXejsKnetmHzusFHdkHth0a6+8Er/jVTZg0Si+o18vP/ExUAhuwcZVt+xOP9etuCh93fy8tQwTG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709739321; c=relaxed/simple;
	bh=4XBA7h4gk9kZGoLHOXMtYY2N0kUearBB17+7pA7xfVU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qQrj70C0iwFrAqsCTB6mNWTZAdP2YB9vFcvvUFCNFEg4u9rpbuv4m84+XYN6t2Mul0VQpZi3EBa+KT75ZUdOpOPftiPflsFiaau2ZXSd3a3hMMoxtxHB1IkY2aQehpdgM0DzGlw/pGHtxlyrEgMzf8FqR8Es9ue5p0bTPcZyH6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=yiYpHRKB; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="yiYpHRKB"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7c876b9d070so12642339f.0
        for <linux-block@vger.kernel.org>; Wed, 06 Mar 2024 07:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1709739318; x=1710344118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+7aPckIbaw56xMg4x5zLxwpAKi5vUALOz1YbOan0kQ=;
        b=yiYpHRKB8dxaTeWc9yaeQfLV0CfWjyB8SuSfqu83kzipnPId7gRpCul+My1wnfhrW4
         WeSfOjc1biXB70d9M4Nw+Ml548ypNaxLsqZcGCqzytTtXClHL2XLV6iGUXvQTzXYr4s/
         cbkP2BhCH3FJEF63wysr9C7zXY8XfR/+ZWClTOxWfXR5i8g7bF6Io9svq0Y1cCjQX5Da
         mfmzHV9k13U4vQy4eBhOBBQEp6Rlnsjs4aJMJAs2WHM1PJvSLmHx3JGW9Lp4Sa8UMpwI
         5/6AaD1VIFMMEp5eEtO4w+rXDZZ1p7kFgThU7KGEsU4h65MeP+Ur9GNC5Qy2ya8k8uyz
         gl5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709739318; x=1710344118;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k+7aPckIbaw56xMg4x5zLxwpAKi5vUALOz1YbOan0kQ=;
        b=jxm5IOLUJUfpzhKL7AP31M6zfXBr78zBZ6Ug+znJecmY2NYGfNrZQKh6JgP0GDS6/U
         HiFP89caNrH5Am+HqRtGAICaC59hjL8J+erlijZuyvpH5thWHw6AOt/VpZowBO1BRmL7
         fdEgyCGBlbo3qKJh6yELdffo8tNcgPiHU+4CKdpdwdwMpcHAc4LiY59qefDVj4FoPXaI
         e0VzpfRBlqFTuQ9G9WiuMI4BDPA/A/Q+IW1c3FZN9lqRkZjlE4N9UPHi4SL5/Oyd1s85
         ZVfvrXa4wVy7vzowzJBOC6woeEZI6yasCcy6mn3kGqYSUsx+zfoqx+j/xLdCAdNUOQFY
         KwSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwlnRYlsTHbQL/rbgFJljWy5eAGosOX54Y4TIVmD/sERMfPUAyu+pDsUwcFp0YuTuA6PEXnO5CMzvVhySkl5uSUszUY8bBm3SLpdY=
X-Gm-Message-State: AOJu0Ywlb/rbejgdIUndDsepuMpd+QfQ6KPqmd7FIlZbXF/+5zG8veO0
	1gnm4V0Pcr/0vFIVf7MTOLX2rMCP4kVd7F8Gm2E1Ly++YpaFUOkC+mr37Wwyu6I=
X-Google-Smtp-Source: AGHT+IE5F3k1D3gik/OwYN8x0TQzZJEWeyfDVo1rW4ITdbpkHe2CQWcwgqeqMBIIK+FUBeWV/a2ZZw==
X-Received: by 2002:a05:6e02:1c46:b0:365:fe09:6431 with SMTP id d6-20020a056e021c4600b00365fe096431mr3732415ilg.3.1709739318559;
        Wed, 06 Mar 2024 07:35:18 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id t2-20020a92cc42000000b003660612cf73sm324467ilq.49.2024.03.06.07.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 07:35:18 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Tony Battersby <tonyb@cybernetics.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, 
 Hugh Dickins <hughd@google.com>, Hannes Reinecke <hare@suse.de>, 
 Keith Busch <kbusch@kernel.org>, linux-mm <linux-mm@kvack.org>, 
 linux-block@vger.kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
 linux-kernel@vger.kernel.org
In-Reply-To: <86e592a9-98d4-4cff-a646-0c0084328356@cybernetics.com>
References: <86e592a9-98d4-4cff-a646-0c0084328356@cybernetics.com>
Subject: Re: [PATCH] block: Fix page refcounts for unaligned buffers in
 __bio_release_pages()
Message-Id: <170973931770.23995.2545307873508420124.b4-ty@kernel.dk>
Date: Wed, 06 Mar 2024 08:35:17 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Thu, 29 Feb 2024 13:08:09 -0500, Tony Battersby wrote:
> Fix an incorrect number of pages being released for buffers that do not
> start at the beginning of a page.
> 
> 

Applied, thanks!

[1/1] block: Fix page refcounts for unaligned buffers in __bio_release_pages()
      commit: 38b43539d64b2fa020b3b9a752a986769f87f7a6

Best regards,
-- 
Jens Axboe



