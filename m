Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB071D79B2
	for <linux-block@vger.kernel.org>; Wed,  4 Sep 2024 13:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725455853; cv=none; b=bZ1lC7oFGWxbRPl04TkTpU5mAzhFCaRqa6lXZScGClBRmp6H5LGlNw3+e/t1bqOev3E7xBSMtaBeuBTbU2Xt5r6NCG+ENGeRVkJUEWYHKNzpmkPuBGESUUZpdUJkhJS8PPdiUAMjRzMZp8CZs5+wnkOZAqEKGdRtqFxRDq3bZoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725455853; c=relaxed/simple;
	bh=bRAtStrpjHf7s8fhqahQ4zdFVQ1e2mbdCQKy3TGj624=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SNiDmoPV8amC586MLc2O4LU+IOqRE7yOLdxkbvHJXuP7vh+jKmrSFCPqwa5HO7I1AvLo1PsGvFqd8BElcWvMy0PVnFA/634i/yj7FmfIjNSNgUzzCmGeFbJVwm/YvpE4dfgcPZr7a6qqV54u0VAt3WFqfmU9vPaD9bEtuB3cT3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=u7jonnLA; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="u7jonnLA"
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-82a1af43502so334636739f.0
        for <linux-block@vger.kernel.org>; Wed, 04 Sep 2024 06:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725455849; x=1726060649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mz/+r1kYYto6vaE1HN5Lr4ygnqrDF3yK2sRAOefUGM0=;
        b=u7jonnLAeccs4MdbNXWYOyuDH8KcUw7HBmUiy6UXqk3cE1IW310d82RtmqlpcMw+5S
         bOxSAe8c5K5fPg7RdMfY2BTAn1ytuQ70zni2BW5WZjJN42YE6OrTJj0aw4amU3aiIhYC
         ttZ4y+A9LPHSijeREbu15sA8uHnqFY4nJwNNHqmfN5tzEB4XyUej9RLuwzlSu8eyCh3K
         R9MBN5Rp7cI0wG4CCjOR1VBEJ48j8MX1ce6KkeiNx70jBC9/eWbQxUKGqeNHq4YDByTf
         7G5CXV80sLI9xukuGeA0969P9Cas4CVyXmKsVFWDYpwFX42T7h0t6wh0DotYPi3DWyqY
         IfFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725455849; x=1726060649;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mz/+r1kYYto6vaE1HN5Lr4ygnqrDF3yK2sRAOefUGM0=;
        b=Zd71bY0P7XlREe6X/AIzL0XWCEBYNdaeTjGnsfKcLEMOSDT3J4EMVHcqrst96K/myj
         3nbBW5+Efdo/CD9KPrsfSsITnncOf7apKQochD3YqsohdLyCfWA7oyUCswdfpgggWGbX
         TaHZc1GYTUeYntA3DCmx/ZZFHDt3TvoV05ZO6WPAog1Ylmrc1f2807TyK9vTa84CMUvx
         oIE8sWr0qx32MyI9dVcLMPd7InXx96br2Q6p3xAkwsBYlK8eEmPh1ptyqfyWpFgYVoa7
         hIcqVUQ6SIWX7j4wvYjnfVjaq/wt9F44nS65I4JvnokWwVWQOtZh8v5wncM62iVsfd3C
         e1LA==
X-Forwarded-Encrypted: i=1; AJvYcCUzKqAdPYa03JspbaKhSxTS1KWoHx5prUBDXG5cWLsh72I5XANJCgAqa6ThcnXh93ZS/H3x30LT8oQr8A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe4hYc1uB2TCc8mMx/8eTSqFoW40xVYKQcVeZLzJeJ2D0tGz9X
	mp2VgP2ynU8RT7xuU67b+U+6b3eAEsNgZ2EEMNOXETfUPR0iCGON+s24H9vJP/KiMG6bgIeLqRj
	6
X-Google-Smtp-Source: AGHT+IG1USYy7tqF1IkbtzHH4ZPJtKLMXIpGPGIRPp4DSTusYeKv+BCRJq3Gax192M3qUxFdzSbxgg==
X-Received: by 2002:a05:6602:6b07:b0:82a:23b4:4c90 with SMTP id ca18e2360f4ac-82a23b44d62mr1864522239f.1.1725455849127;
        Wed, 04 Sep 2024 06:17:29 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ced2dcdf02sm3128987173.26.2024.09.04.06.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 06:17:27 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Jinyoung Choi <j-young.choi@samsung.com>, 
 Christoph Hellwig <hch@lst.de>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
 linux-block@vger.kernel.org, dm-devel@lists.linux.dev
In-Reply-To: <e41b3b8e-16c2-70cb-97cb-881234bb200d@redhat.com>
References: <e41b3b8e-16c2-70cb-97cb-881234bb200d@redhat.com>
Subject: Re: [PATCH] bio-integrity: don't restrict the size of integrity
 metadata
Message-Id: <172545584759.61712.16420606261657015873.b4-ty@kernel.dk>
Date: Wed, 04 Sep 2024 07:17:27 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Tue, 03 Sep 2024 21:47:59 +0200, Mikulas Patocka wrote:
> I added dm-integrity inline mode in the 6.11 merge window. I've found out
> that it doesn't work with large bios - the reason is that the function
> bio_integrity_add_page refuses to add more metadata than
> queue_max_hw_sectors(q). This restriction is no longer needed, because
> big bios are split automatically. I'd like to ask you if you could send
> this commit to Linus before 6.11 comes out, so that the bug is fixed
> before the final release.
> 
> [...]

Applied, thanks!

[1/1] bio-integrity: don't restrict the size of integrity metadata
      commit: b858a36fe9a1261dfd097aec855161ad135bed60

Best regards,
-- 
Jens Axboe



