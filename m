Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA0F3B19B2
	for <linux-block@vger.kernel.org>; Mon, 12 Oct 2026 18:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791831085; cv=none; b=e/V2JZL7NtpGvN/qUDtZ4glJ/hsLLFd8sUoumSUJyZCVxadP2PDA8DIqrhjCUENBP5sLtEcWJjVCvEoZ9HgNH0hk/pFv9Xf4LwctwRL+cUmbbUjl+dsJex+l7cG25X9fQJA9c91YEGxDyQpISlMUrgZrBY5ElGaFrrtFIXT2124=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791831085; c=relaxed/simple;
	bh=wKAKzgNbI0A6BpXLwz5kHXWvToiByAgsvNuYzQ7pVqA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZWAoB0+GaW4W5tdHXJmyyoKqrDDrdsK+p8deLqa+nSKWqPNwcaAWjUqfcgRKdTT/ilHOm1FVNBc7Zvgm2bw+MYAjoQfeqXpmYVYrfs2flDHLyTZ9hPYgh6FGhhoV/kEWjdHcahG82p2Jn8HFz4Se7EzcR+e6EfxS0ifTtjl7rzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=bpoBE8c6; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="bpoBE8c6"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-14394530ec6so1174908c88.1
        for <linux-block@vger.kernel.org>; Mon, 12 Oct 2026 11:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1791831082; x=1792435882; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rsqT7W4kYSsaiFbLe1ZcXpmayyG/u2ZTJkWgKdpw3Qs=;
        b=bpoBE8c6j3EXrhMtTATCh5a+Q5MhYlOPMRDwjNKXFaxwlPWhA7bnIel9eGa2Jnat/S
         z0DOdJanV7FbW8w+4vic7yWoIV8a0aAyUyQCPQtwUwCZzbch9u0qyjvk/J4zjIGFQ3Df
         Ggo2jhjBZIvpNQ1ZcdS4cRdbatkj3BSMOGmrQUfeyiA+cedk+xS7et5XOVLFWMIC3gsq
         YUXWXRTEjwkWFhE4LtzjRLlgAXVwI4k5peqQwIfRDiNswNElLkreWjaIMuQbjWAbvDTa
         ncF5gbU56Zb5UIysfcEdu0s2V8Ak46p41cidFXYdLqR79m0yy+U/Y4ahGsXlkddsdu0X
         fStw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791831082; x=1792435882;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rsqT7W4kYSsaiFbLe1ZcXpmayyG/u2ZTJkWgKdpw3Qs=;
        b=NLezhX7pUXqOlRFwzslN7YX9eJ5KC8S1zuXQ0yssoK7OP9apB60Z8wqNfT1tcQ4JWw
         xm2W3Ey6CpqElIcv++yaYDfc1k1zu1xqwOa0sWIPCf5x17G6/GdnJYc1N8Kl+0kB4lgz
         MlkmXVjcqZwoy/AM7/FnCUtBxWRvCewoR8wcdkm2vB3jay3xJCIzzwUacJjjc3gs9pYl
         rFH3iWLxoim8r9fBkm9Tx/jghdNJVaI2fQ5MXqNtkXafCDDGT4uPrjh+GUx+1hsNiJlL
         neHcZwFJlgmQWZnN28mjiiRW+YyXANL+3rjV5dUpzNnTQF1XPuuxqHNYo2AAfIq8jrc3
         1cMA==
X-Forwarded-Encrypted: i=1; AKwUvBz2mjX4eaglaSBIBlTKvDZEZR/R805Ldx8Yj9fBqn4Crr5UboW0/ilO5sS49MzWZZaU0ibe7Hx7OQVDvg==@vger.kernel.org
X-Gm-Message-State: AFq9FYLC41uEwZijrRs4sPiNe8xm+s5vPtCUseRVD2qWB8E8AVXwjohT
	F0aRU7rmgN1YxNPz6vofEUXbyW+o9ni0Q/OT37Lg7f0r7vbD3zWYSyU0znL0JNtrJRI=
X-Gm-Gg: AYBFou2p7z+QIRJW6XVukBZku0l66Nq5OiKjGru7Ee1GsQl50CY5uy47x4TkZHdwwWC
	DZMxVYkj8sm4JZfV29HJsFC1kjvlTbMwa9ma7uWTNjFdt/hnHYWHDo7Jd6ooX+0kJU+UhRKqZ3K
	2zBI1aUvkwvNchZkqup+yAFQ0c/VbxUzTiduQYrPpnEpA3Izo9yGZP0LYnGVEB6LOuPkXthe7vp
	uqyOvIbRReljftm0MVaWkwyR7E1i6obZGanS/GkJ5Uo9GeVi5BjnUqSsUcgv3l4RRy/LExhBoGo
	Er3Zq39N5N9H/EfoQtCSYdBbZlGMawM8aEZfwjpVLwiRERd2GnqCOfHrd+7LVlA1drSm7bfK3eP
	T7qgtBmpzYwh08/3TAHY3RCg7d5goHCAP2MGpyX7tXbYp+ftqdjPvtw5NA8TGaVFhxPlS9F2rzw
	M4iiIk6bW3lUG5wwyxWR1uLVB9WtA6NSW9CNoQ4QIDN5Ffcl1K7wc8VUz6QhU8A/aqqSEkQbOjJ
	QPCT9G7TaMv4ra4qAke8t+BAOUaZTjywPvdQnQTdJZcD1gdZXNVRwCerw==
X-Received: by 2002:a05:701b:2512:b0:149:1feb:6da4 with SMTP id a92af1059eb24-16a6250bc3emr13638433c88.32.1791831081761;
        Mon, 12 Oct 2026 11:51:21 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a2f17feasm41738221c88.9.2026.10.12.11.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 11:51:21 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>, 
 Luis Chamberlain <mcgrof@kernel.org>, Hannes Reinecke <hare@kernel.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 John Garry <john.garry@linux.dev>, Christian Brauner <brauner@kernel.org>, 
 "Darrick J. Wong" <djwong@kernel.org>, Keith Busch <kbusch@kernel.org>, 
 "Martin K. Petersen" <mkp@kernel.org>, Tal Zussman <tz2294@columbia.edu>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Sashiko <sashiko-bot@kernel.org>
In-Reply-To: <20261009-blkdev-fixes-v6-0-307939c387df@columbia.edu>
References: <20261009-blkdev-fixes-v6-0-307939c387df@columbia.edu>
Subject: Re: [PATCH v6 0/9] block device fixes for large block sizes,
 IOCB_NOWAIT, and direct I/O
Message-Id: <179183108065.215281.6738934643920446280.b4-ty@b4>
Date: Mon, 12 Oct 2026 12:51:20 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Fri, 09 Oct 2026 12:50:08 -0400, Tal Zussman wrote:
> A set of independent fixes for the block device file operations. The
> first two were found by Sashiko while reviewing the RWF_DONTCACHE series
> [1]. The fourth and fifth were found by Sashiko's review of v1 of this
> series, and the rest came from asking an LLM to find any similar or
> related issues. Each issue has been reproduced, with the fixes resolving
> the issues.
> 
> [...]

Applied, thanks!

[1/9] block: use iomap_dirty_folio for block devices
      commit: be1e33eda3e6699e57ed3fe6e34078f115b4a1ec
[2/9] block: take i_rwsem for the direct I/O write fallback
      commit: 2fec4fd97cc3ce32283aac03b6882d3d36cbd4bb
[3/9] block: take i_rwsem for the splice read path
      commit: 5574b81c642e83d962732e86399020517f5f15af
[4/9] block: honor IOCB_NOWAIT in the block device buffered read path
      commit: d16519a561f4ccc2cebbf52831435833cac1fec6
[5/9] block: fail a short atomic pin in bio_iov_iter_get_pages()
      commit: 73a0ff6030afcae5aef9a8ebf9c27220f9be888e
[6/9] block: don't fall back to buffered I/O for atomic writes
      commit: 9fd1afea19fa7c4ba438a1d162739e0832073a4c
[7/9] iomap: reject atomic writes in iomap_file_buffered_write()
      commit: 42d502b70ead4c3b387af8fefcd9be80876ca313
[8/9] block: unpin all pages of a bvec in bio_iov_iter_align_down()
      commit: b91a661514f3a3ce5add42fc1f2eb17b61eacaca
[9/9] block: remove dead metadata handling from the async direct I/O path
      commit: 0f6b042f9a13968c4cd6cde1a70a7b242009ef46

Best regards,
-- 
Jens Axboe



