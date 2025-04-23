Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4739C266EF9
	for <linux-block@vger.kernel.org>; Wed, 23 Apr 2025 19:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745438309; cv=none; b=MNHwR1bwrgNfnSl3UGCSJNjH4qjcFO469SsCr2+Cq+S7b8lj+EVmnygwZ2q4d3nIMiNbzD64qLoVobLdtYI9gdiiz3baQrz4yO5F3zaAj8SQikdkybTEdYPaJ9OxyCaGX5ZR6n1nxx2TB64SppfGX7eT+Ln8CtvXo2gHk8AxifY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745438309; c=relaxed/simple;
	bh=sABJ0zDjI+HdAYjK6q+W6i4zhTPiFN5NjWMMBT+eTh4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=diATECQWwOPR4VUFqO6ilwxga8d/0SKSUs2fgK4RnzIZa81pita4Jvno6F2aHOT+5JCPZboa2lDftoRHYJROIYE0f+eaZQ7ONJGpsMu5VoSviDbkU7TWeXbBBXcMUmH6Ii57pVwLLmCxiklLv38Q6Q90a3Ib+I/XD8KgbMHqw7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Ts2gYgC7; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Ts2gYgC7"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3d6d162e516so1918075ab.1
        for <linux-block@vger.kernel.org>; Wed, 23 Apr 2025 12:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1745438304; x=1746043104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9j5LjmU56b5qAgJCmFZDj31NsIm7pWmTfna1PU4IFm8=;
        b=Ts2gYgC7nfnC0WsxXQFgF6BZ9YN9hd1ccmdVEi6RTerUyu8PFoWyG7nhKy7a9AsYNp
         6bf1rHf8xvdODrEoF/3aJiUzgficfHfx9sUGCkOhXlPoFmRk2BFG1Er3fzERcJ2CuaAc
         hJePFjC9sqTqLcOU8xGH6ZZ6X0EPUXxIpn17FwPdolr/bqu+prehcfn5iEUquq0HW/Ou
         9pU3hcG1oX85Agg6VoU1+Xh3cAtjmRE0z2aK/+2Zu3Fp3sgbNh7rTSoCCmfpxuLvKwCf
         f4WcVmbeV8cgiImtCWFvQGn1pmAfKvOujlInYK5+Lf0XDA4AiW5JQ17UqJSFASXYUh2U
         g/ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745438304; x=1746043104;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9j5LjmU56b5qAgJCmFZDj31NsIm7pWmTfna1PU4IFm8=;
        b=bkQS53bOCkS6Kctz3gJ1N+u6T6PoBj8Ij3CsZCQ5FCx3uIkMHz1gk/z9dDmBApNuzG
         wHlm3hAfj0lVsECEEqyMMrIOYhbJB38FT7BfyXXhSvp//7sTu3mRbGlMZV8xRdqNnbuz
         3a43zMEFp+zCsGTeGd9CrpfD+lbwI9DL0msc45s5XLoa4xE7cvNRriPMZjdHUgYznpGG
         4xVWWMYpWH072WNTYAtcmxaqjKiL6bbWpVBu1yyjg0JHRxWVNMftEtkbfT3NNNJY1GoU
         u+xdkH8g1B1NqoAoRLlXRKTikorj38sSNpbtZ/+xoUfqm77+uCc1BkJWgVUe6AxoDd98
         cJ3A==
X-Forwarded-Encrypted: i=1; AJvYcCWMB24TUfgLD2M0pNYv3Bt/boZdiEI+msCOOKDGU1k336jOQqCsgPXL56ETsNKXTe7v2Xv26z11M7/oXA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxM2HEyGg+5jOvmGtqhZfYKKQNhKbKSsd9v3pUODeiTQJNKBFav
	3QXn8wm5oi19FMQCQihBZ9mdp8W9ULdLs0kfUHGyImqTYklNu3N5HTTGUtfVWYs=
X-Gm-Gg: ASbGncsOPDLhzKRdsHXr6u0JxaIKGR1rGx1M0pupvTQyB/vymGJAXCLXJWG84KVJYK/
	oLall0DPoMgvzaiH2PgQ1ea2uupZNhO7kIdrCIDCZXn2N/r6AVHOS0brcx5zrjSPnY/zk29KRRo
	OfBtKGIS85WmLyw2W4Lrj82eQ7daZY1b1kxp1kRug1EkG7fhdrW7XxLTQA3nyW+iyEzDEDjhZR2
	YqRKrd0yFoqT/HGLaae7C080S3qgh206o/X3QynZzTb1XQ9e2n+lERziCjuhoHL+Q9WX/xe2ogI
	vr3BCrI/vQbgOEq5hV1lrSH+QWQm4T4=
X-Google-Smtp-Source: AGHT+IEMJ0bRGRXiRlKdRhkAgWX19pwillKCdqIlVb4cy4gK+d8U2A8s+2kwKh/p2ao3kPhQzF0MkQ==
X-Received: by 2002:a05:6e02:b21:b0:3d3:d823:5402 with SMTP id e9e14a558f8ab-3d92ea8af22mr11668365ab.7.1745438304290;
        Wed, 23 Apr 2025 12:58:24 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f6a39335casm2960256173.84.2025.04.23.12.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 12:58:23 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: cem@kernel.org, "Darrick J. Wong" <djwong@kernel.org>
Cc: hch@lst.de, mcgrof@kernel.org, shinichiro.kawasaki@wdc.com, 
 hch@infradead.org, willy@infradead.org, linux-xfs@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, shinichiro.kawasaki@wdc.com, 
 linux-block@vger.kernel.org, mcgrof@kernel.org
In-Reply-To: <174543795664.4139148.8846677768151191269.stgit@frogsfrogsfrogs>
References: <174543795664.4139148.8846677768151191269.stgit@frogsfrogsfrogs>
Subject: Re: (subset) [PATCHSET V4] block/xfs: bdev page cache bug fixes
 for 6.15
Message-Id: <174543830334.539678.13336981984894472656.b4-ty@kernel.dk>
Date: Wed, 23 Apr 2025 13:58:23 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Wed, 23 Apr 2025 12:53:36 -0700, Darrick J. Wong wrote:
> Here are a handful of bugfixes for 6.15.  The first patch fixes a race
> between set_blocksize and block device pagecache manipulation; the rest
> removes XFS' usage of set_blocksize since it's unnecessary.  I think this
> is ready for merging now.
> 
> v1: clean up into something reviewable
> v2: split block and xfs patches, add reviews
> v3: rebase to 6.15-rc3, no other dependencies
> v4: add more tags
> 
> [...]

Applied, thanks!

[1/3] block: fix race between set_blocksize and read paths
      commit: c0e473a0d226479e8e925d5ba93f751d8df628e9
[2/3] block: hoist block size validation code to a separate function
      commit: e03463d247ddac66e71143468373df3d74a3a6bd

Best regards,
-- 
Jens Axboe



