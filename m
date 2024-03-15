Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE985C8F0
	for <linux-block@vger.kernel.org>; Fri, 15 Mar 2024 23:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710544202; cv=none; b=E5Ov4DzZ773ZmI134v4ZW79g886tZj9kJ6fOeCO+GAvxUBugHC9rVGEZQBlDQ6qbKAbtNlLW+V8tZST5XEePmXFMozD6FF6BnVi7D4v/hsgvdrIHekYBjq1y4iIwqyIZGo2XrFkOlQDWCRSiY7GJuyIrRMkIPqeVE2STzwDebYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710544202; c=relaxed/simple;
	bh=QTbZeGiMgUaz1lrrezvqUqJtHYXg2m/fAHoPY/cRNDg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=G7gbpyr2vmZLgsm/1HnE4Qa+eu+6x7dtg3C/oGj4MhMKT98WA0llZMwB8GDy5QKTAqrXPwNshzYbW3N2XOlVhzi/uw0HThRYV7hLH/eta5NFHQsQIieNMOmNAWWTNw3SwLUhyYndKpezT7mDKHdoQT7MUpDWRcKKxxJxhn4HiNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=omte322i; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="omte322i"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e6c9f6e654so570468b3a.0
        for <linux-block@vger.kernel.org>; Fri, 15 Mar 2024 16:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1710544199; x=1711148999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dJQL4y7RIiEtsA2ncrYwa8km+WzEsBBdhDkUK3w+e6o=;
        b=omte322iloF2PCd0k+eabJyxJ9IaB5NDbqmGXwlJlS6g/M5/2BA7vet+w4tCDS6etx
         3F7mRmFe951+Qfi7ZVzHpJHdVu4EhH9njP2B7Jtpb3FQGypFsHJEwTxLWrQp6Sw4CfXo
         YWUitY4Csf5zQYqUHjrRbd4PWUVRGVAq1CSEXmiDul5QZ8Uf/LgKUO2QTquOt6hAeU6V
         vKqfS4ALZo7MkWjpd5VStB+S8Az2uX6eiUQiFTp12wWL0v6UODWrgWuo7fvU33srju82
         HH8QDVfy41C8DHXLL5oidm1ZMI55WVdCEFzQ9HAsxlWXKGhocXcq55d6MYw1kfFHGShn
         voTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710544199; x=1711148999;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dJQL4y7RIiEtsA2ncrYwa8km+WzEsBBdhDkUK3w+e6o=;
        b=BJJI3vD/3Kc56gOaTdO1bUww3aWkM1+X5rZWo8dKA6j4zHx0XDQqHz831VEtNOMY+r
         4m7u7D0loAVw/Huv5eMKa7PLcevVkOJSSDBLYF0zEXB0Ag3q9uCBccRUUYqKRFdm8yPu
         pIBpQE2+yJQiGuFYXyHiPhaWDXvla+VwF2egTCVyQGHvlpZOTN/DjfifEzzlGKttT0eJ
         jiwcBO8UoG8VY+wbVFQdPv63KgaN3/bXEepTwyIJxvsHigmPMkVlcwV/kwYmo+GKObRO
         ZnMtlhqyzRMlL4ZHwnyDLiaTvh2e6MU5fWuz+xlOfnm57wGh5SytJuccGK6a6/aj0zoM
         hgkw==
X-Gm-Message-State: AOJu0YxBowTgyiFmnkoP2Hc9CT3zTvTk5d7TB56/OI6iJpqfy3iJZlFD
	fUrAN/XK8LgdSxt0T6i494Wjbp/fsYa8eHAhbtm4/BaDC5ytH1l0c4qZdZL4H60=
X-Google-Smtp-Source: AGHT+IFhgfnVHgcAuGMOjHK+7LfBSRMDmCqacWPrIIYv80LYJF8fuYLZFlKI0dBePzUYn8URaSlRYg==
X-Received: by 2002:a05:6a21:3286:b0:1a1:481b:475d with SMTP id yt6-20020a056a21328600b001a1481b475dmr3773404pzb.6.1710544199175;
        Fri, 15 Mar 2024 16:09:59 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id it16-20020a056a00459000b006e5667793d4sm3906747pfb.66.2024.03.15.16.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 16:09:58 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-block@vger.kernel.org, Pankaj Raghav <p.raghav@samsung.com>, 
 Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240315181212.2573753-1-willy@infradead.org>
References: <20240315181212.2573753-1-willy@infradead.org>
Subject: Re: [PATCH] brd: Remove use of page->index
Message-Id: <171054419807.405744.17613685383641288937.b4-ty@kernel.dk>
Date: Fri, 15 Mar 2024 17:09:58 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Fri, 15 Mar 2024 18:12:09 +0000, Matthew Wilcox (Oracle) wrote:
> This debugging check will become more costly in the future when we shrink
> struct page.  It has not proven to be useful, so simply remove it.
> 
> This lets us use __xa_insert instead of __xa_cmpxchg() as we no longer
> need to know about the page that is currently stored in the XArray.
> 
> 
> [...]

Applied, thanks!

[1/1] brd: Remove use of page->index
      commit: 3d2496fd32c27ddaf530356a9284ac0235c9d9ce

Best regards,
-- 
Jens Axboe



