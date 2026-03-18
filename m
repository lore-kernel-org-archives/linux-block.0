Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B04AE55A
	for <linux-block@vger.kernel.org>; Wed, 18 Mar 2026 01:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773797267; cv=none; b=GszHLOPkUU+znS0SNpsmoyTeQGjLOYntj2UtotHdGrWtLt8g/5uhH1C42KaibKptTxY9cgyAyIiiniWfBqm/SyAzhNClFiYsQMctj48EzzIpSO1opUeT6mH5IyaDRlgdqaLbSJk3U9ONzkYlKxqjRO8/Lp8HyQdwOcTntoLlbkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773797267; c=relaxed/simple;
	bh=W8Oh4aE6nMcOqU3pO1mi1krnUUV7i96E4KlVXBABDs0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cUkPXWBAIIRsafqRL/7fnRrEXijSAbTKxpvD21NUjT0LD/wRM0ywcDYOpsAbURMI/bLLLwEJM9X4DerTae6ZKsNc3PlHqhQzJknq748RX2rHJSzZT0/MStKld/qJZPzYCmSUitRoyahBlGez2n+ssksrFBL6Cdl1xDrkY7zM+UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ZwfoxaWi; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ZwfoxaWi"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7d7447778b9so3207368a34.2
        for <linux-block@vger.kernel.org>; Tue, 17 Mar 2026 18:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1773797264; x=1774402064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1dBm6vk2zKd0SxvQd3iNwq7Y1KyeY5QNSXnmQ130+vg=;
        b=ZwfoxaWiHm6EjCM9St6n8KgUus2mPa3Pg0rGeYevZZdTfu2Me96T+q06SLQjhhLTCA
         FTgeyNyrm6IWHP0Z9afNO1CAgEWoch7m0M+Op7b5gHXOUgeIVFky4LkClYUvtM+TfNgV
         Qx9I/lUi9bPjmIOq+Q0GaUXTuLaYAVfItNyTIp2GYprgVXA8ukIPCJbjMNOyV0GT80em
         MJNBFxSlixbagKw7lGivnfsRLdCpsucTbyIxUaU1a6L98FOL9UFMUHEeaLnJTI7Z7PKE
         5dTQB5QPksxdFUIR39uafiCtGoIP7wX6jiY5ITCuR8zEQzAwJ1ilt/nkrEtFvTL4iBRj
         tGPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773797264; x=1774402064;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1dBm6vk2zKd0SxvQd3iNwq7Y1KyeY5QNSXnmQ130+vg=;
        b=FimImOHphKOrG/6hbBFKzwCtkRINGquwDB6fy5ll8FvtSzYRSMzMItJxaJoseX1oEO
         yTPg9hyqvJSic/3C4pNe3o+nWrV1Y2L4fCcI9lbTjGsFXm+qXwm1pFGitvUY42R7HNkh
         JWazOCg32U1uCWxNNk2DajnDtAKf2AXMmAQyxFZm++MCvDGnwU2zK7yr2cAk8OSpQnk9
         5X5b4dVETNuy44dizs131UywV7nVBc65GkJ/KeszntfTbm2b0pRFM9/+kjNW8Qk9F57B
         6mKULBJxapx59WikvdVrxnT77mIDm0LL5AdlHKZG4c+kF87/cDuvDE5GvJm91K5NKth9
         +H8A==
X-Gm-Message-State: AOJu0YyRWhq+BgP89CcMMGI0t5HhKYTtekthEZHDZNXwBAFDIIbx77QI
	1uiOGtuOImM4BhpoXPr/rQA6W74og+9eaAKVKy18C8jwUGdQl+HjNHmH62vjAlxpsWsnsvCCxyY
	RmoE3CvY=
X-Gm-Gg: ATEYQzzIRZLuDlHsw5KsXkZyMbebffnx0Z8iudF0+++u1BiEtJuKzH6pYovr18JuTxe
	gmoFk9T4tz4GFTeoVIhpML8NdK3RxPkYz/OOOEnutQBHEHJDl59KmGBwRlGIQEPocYB+Vic+2+z
	8NE+EQeY2vYQqU4DsHXldWlR6a0FsKm3ay2tWRdTOwxRu0tE8Dvo/bddjwJKKA/ZawlUS66Bqo6
	nX1wGWvwWiGlD4GiCBe9u+HXCaFD9wiZAdGRRQ/kyLEBqTynlf5HLhfKbgaZ1NIGAVP/uEENkDL
	0gNFVGI8yQe++0kkVFatlV+xPWRtnNTy+rgkdBPstk0Ei6QjhtMUNOFopMQvmyFrQAV/nd6MdOY
	dQJdDahh4m3WJV3oj2BLvcR7EZH02x9msIIdVSaXKtlUqLiE90Lvh5YDcZkyip9PPOnP5oyKkRr
	I9s20eFBfCqSF0C7Of1gQT/vUvFJQC8iQuulBJh6yFy91KfeOuSJsmRNffVYT/FC0amsjy9129T
	AoX
X-Received: by 2002:a05:6830:82e4:b0:7d7:b85f:36c7 with SMTP id 46e09a7af769-7d7ca671b36mr947870a34.22.1773797264543;
        Tue, 17 Mar 2026 18:27:44 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d7c9950ef9sm1164417a34.2.2026.03.17.18.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 18:27:43 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org
In-Reply-To: <20260316161144.1607877-1-hch@lst.de>
References: <20260316161144.1607877-1-hch@lst.de>
Subject: Re: bio allocation cleanups
Message-Id: <177379726372.1034588.509989848962284977.b4-ty@kernel.dk>
Date: Tue, 17 Mar 2026 19:27:43 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Mon, 16 Mar 2026 17:11:28 +0100, Christoph Hellwig wrote:
> I recently looked into a batch bio allocator for a project I'm working on,
> and notice how convoluted the bio allocator has become.
> 
> This series unwinds it so that the the fast-path slab allocation is
> better separated from the mempool fallback, which reduces the code
> complexity a lot, and avoids indirect calls for common cases.
> 
> [...]

Applied, thanks!

[1/3] block: mark bvec_{alloc,free} static
      commit: fed406f3c1c2feb97adcbc557218713c5f7ec6a7
[2/3] block: split bio_alloc_bioset more clearly into a fast and slowpath
      commit: b520c4eef83dd406591431f936de0908c3ed7fb9
[3/3] block: remove bvec_free
      commit: e80fd7a08940093aad5ea247a42046b57709a7bd

Best regards,
-- 
Jens Axboe



