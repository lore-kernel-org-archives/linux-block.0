Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E721EB1BC
	for <linux-block@vger.kernel.org>; Wed, 12 Mar 2025 20:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741810046; cv=none; b=IDl1755HPecohA3tr1IkhfoMubZzbmPZXI4FvP1pC0bFKZTWFxRV91moKVhwlwD+V0CXQVjalBk8CZS0ZJMywJIJEs7aBJ6vEBnxZPNEtu8YgyeXJjF0Be71R8tXRJ3Zglh/USaJQtkbK9CUp+Cl6/mqDvEgU7f+Nwv8iYGvqBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741810046; c=relaxed/simple;
	bh=LAkT/tOT8dQrbIpjaUrDwD+3dfF1F3HO+QUlA7X5i4s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Oh6KO0jyThRASmPk/RgXiicttldpWZ3bJlPm2htLbUKKuLrFwrhW4AoUpqfdPgrEKNLgklZ7FChgTxizz55rSz9Cqprifb+V5GmDvR+aAjUaB7sJY7Y7C8oHaYsldTBc4SKETlzMd2pYGnSBAnPE6NXT7UM3sW7Wiurf/whL6+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=z6iImYc+; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="z6iImYc+"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-85b3f92c866so7335839f.3
        for <linux-block@vger.kernel.org>; Wed, 12 Mar 2025 13:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1741810041; x=1742414841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zs+JHuVzCzmJXMaRgEjaF0R391VifEtbQgd2zWrhVVA=;
        b=z6iImYc+Z6RmqWN6tdWETLLtjnldZKeUhSFqvJOOutIskeCXav1+z/hURX8Iz+PvxV
         2BzI1/xMFI6NigF6YeaSC5LyfE6jQnEdXBeOM6ea6BWL3AdDL8zc8llFsZXP1z3Tc4NO
         Cw09WuHNok/jDnRGBlERhW4NGHraeqESBKidvEeFp5ZDNqwWsWLsaWS1d2WWIZ2l4Aei
         u/Zl4Sjo7ZyGyfudrGpuhTKb4xItUVqJWzZVenrlOyIFr1q3pnQYEXqqxNo7s/cmBRbJ
         c/uYZd0UoU/6C0hyPBhQ9RFQq/wbQbuH7A0L2NhIy6gqQO5v21CwLTPaFdQ6ahVdxWiR
         zVrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741810041; x=1742414841;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zs+JHuVzCzmJXMaRgEjaF0R391VifEtbQgd2zWrhVVA=;
        b=Ui17DR0LQXWLo9lWmb7wrZrH2YQ25HuDL6WdYw0tvXVV2tPeaWnqC1AQ2VVJiSWbpC
         6luSh6tGGLhfpabcWuZOx/1kxKf6VO8MOiuwrAChHbtm2sQaRoXMynvGmNqhQekcSS+J
         P8qqwOImIGqCx9VZ0IsY8K3E8Rqw07zCiQYUaOLNRMQZcavoZ2xVdeRnUzIy+dHOcCDv
         9hjK5SRa86SAZslsDUlwYuMvF6YhTDfBpSxg0BN8s00DNnkdOBpuxFPZm1LPLTGpzY20
         Xi16jFK4ukkNhzAZ/f8X/WbrRXgwi3251SBRzkw2cng4naCGXR4Wmq2B8gA9AU66e+PU
         D9bQ==
X-Gm-Message-State: AOJu0Ywa6SLaNQHZpFox8X/hNk42ORYZxJ8FiOfZ+jO7IZhYEt7gHUq7
	7TfCKD85DcsU3xvo+u6SL8IY64/qtniQfq/PmxctcBF56YA9brf1NvZzyp1NiII=
X-Gm-Gg: ASbGncv7Wm84iRxEUysesLkIGOX28fzwmmhql3lw3J1AC1NBxXjcQhhc8oNOM80frkl
	aQ9CIbbK5Bm/5t9TjYkB1+zUHTfHbFNqyQ99tkXmIQrLm8+HMopp4Prs+f/krS/VONt436HQ9bq
	SBBwS/rAmNkp9H6jtU8pW8CKpf/SVS8ovU4on/bEC6kfq702edsgLSeBs0XgAMLuOsVR7RYyIGB
	UzlyvxEEKBtho/eFiD1KmeIUUQ6TULAOrFo0xKgSS9+y7oMN4ZEcTJAGarRgm3WxKyHtxMgBSbW
	C6H5ByxB/CsaR5yaMZeaeWG88qLoPZcCjC4=
X-Google-Smtp-Source: AGHT+IGIzH+yOltZkX5lMeovSjx8b4BPACrMDzOX2NiBQTIhyQiuXkEMKxnndlxI7LpOYOkC62qUzA==
X-Received: by 2002:a05:6e02:240a:b0:3d3:fcff:edae with SMTP id e9e14a558f8ab-3d441932f94mr280888025ab.3.1741810041106;
        Wed, 12 Mar 2025 13:07:21 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d43b5997cesm30985295ab.72.2025.03.12.13.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 13:07:20 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: Kundan Kumar <kundan.kumar@samsung.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Christoph Hellwig <hch@lst.de>, Luis Chamberlain <mcgrof@kernel.org>, 
 Gavin Shan <gshan@redhat.com>
In-Reply-To: <20250312145136.2891229-1-ming.lei@redhat.com>
References: <20250312145136.2891229-1-ming.lei@redhat.com>
Subject: Re: [PATCH V2] block: fix adding folio to bio
Message-Id: <174181003989.552203.3963254271467140733.b4-ty@kernel.dk>
Date: Wed, 12 Mar 2025 14:07:19 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Wed, 12 Mar 2025 22:51:36 +0800, Ming Lei wrote:
> >4GB folio is possible on some ARCHs, such as aarch64, 16GB hugepage
> is supported, then 'offset' of folio can't be held in 'unsigned int',
> cause warning in bio_add_folio_nofail() and IO failure.
> 
> Fix it by adjusting 'page' & trimming 'offset' so that `->bi_offset` won't
> be overflow, and folio can be added to bio successfully.
> 
> [...]

Applied, thanks!

[1/1] block: fix adding folio to bio
      commit: 26064d3e2b4d9a14df1072980e558c636fb023ea

Best regards,
-- 
Jens Axboe



