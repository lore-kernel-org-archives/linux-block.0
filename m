Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064CC1822CB
	for <linux-block@vger.kernel.org>; Wed, 12 Jun 2024 17:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718211634; cv=none; b=oX5u4H4VrrSorRYvSrxSFGH3tIEkCUwLEldEgov/Z96rbXHhRAf0dwTm9vJ0syWuR/FEKPZLRSnWLep4KUUn1EUXw6HEovlyobQ89Wwp4VoCLynugCBzJEGrFiT7UqE8wrRcNylUZZq5mFKeWUwon87UhQvM5ZRwpCiyTo3XVi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718211634; c=relaxed/simple;
	bh=FGodosjCuK1l5IwdCzmgVPoV1DySj8ltOWup6queEB0=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YvHtzjUIWMBLfzEuhyhUNcFpT5574qvOLqppnr6RLyWDLoz/wCioT+tBDV32HaqV7CwFWqdc4aPz0clFWQYc1UiEYIwaEBnVgtOnKGChFtyUHL80cTzh8dzsG1QUTBtzW8lG0etAU43al3kkeHCglvwMkOqHfjt5P16DBxcirow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ESAuPSoD; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ESAuPSoD"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6f97787ad4dso1048a34.2
        for <linux-block@vger.kernel.org>; Wed, 12 Jun 2024 10:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1718211631; x=1718816431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FLC7J8Mgipnai6tMkIu2Aw7sXa9Nh2VSSClMV3jWnwc=;
        b=ESAuPSoDH+6GTDHIgc7K3WtGKwumnrVdAd2BBPsOpeqJS/LZaAK9Kc61ZZbsCx/uK2
         eDOuNCbXeCVklaNQ7mqsi1VxvqG7d8+2YCC0n0NkggNk/VsFRaFOLKYXTwzyNj6y7Yjf
         ln7JB0Sn99eX6WPeGSod/btG+qC+W6LBcgKtDq2BCAWqLVIcYsrrVW0TfrcsfsDchTJn
         37Kn9Mn7RnOXUiGsk89HF0sBVIn8apQCaiMKC/tXNv+KH6p5gTTNgCq/+MACEiujqNNV
         P1Eh7ZwzODzcsSSNnGTV48kuyIBgUmOuPl3d6HKEpENOazl0vTF9+fZi+th4Inxdzqpm
         NqgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718211631; x=1718816431;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FLC7J8Mgipnai6tMkIu2Aw7sXa9Nh2VSSClMV3jWnwc=;
        b=t/STzp/bchlGeBZau4lnQCBB2XsTDspvBI2YPAdzIbuEAB8prMY2Z5xgQiSYJBC+31
         8e8GHPtbYgdMrLwFjPvK9Wo6Dn+T/10V8+j72HabFfMaYoziMAN3Sc5kD/5EyYJI7CX0
         a+LeHQK/QsNUm+UvJ5AdYc/RGm3KwLch4x741U/vAsqAPGRhGLbODzsNqgR9T+PtpTOy
         3B7OE1rev/lrOiWmljQXmBecJODvrfX8SxHD2JFslJxbHcliljh4pXqjTtVlCgvAQdmb
         sub0LpSCdRwGnuSu8Yo/zDCTmVfcbVWCl5ewQjo42ehXL0t5mRlwez4brGs869hTp1Ro
         2Z5Q==
X-Gm-Message-State: AOJu0YxTDYe9PI5Dn6Hmou1NE3phDPq3OqvxgOIThVDKqcHiE+q6Q8L0
	r0SMmh6EWcmiMdkrFeoYLZfXgK4hyBKKePtUKo+ugbXM6Z/Fgrq5RXJqmoSlebsA410KOOaTwt9
	k
X-Google-Smtp-Source: AGHT+IGD7kMHTySUNBriw0c8o3eMwK51FQscs0lyEAF7fFxaQMPZPY4smWo7T75MMpdHCPqUCSdWaQ==
X-Received: by 2002:a05:6808:1990:b0:3d2:2412:36a9 with SMTP id 5614622812f47-3d23e0d7019mr2901334b6e.3.1718211629808;
        Wed, 12 Jun 2024 10:00:29 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d242affa88sm115841b6e.1.2024.06.12.10.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 10:00:29 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, dm-devel@lists.linux.dev, 
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>, 
 Damien Le Moal <dlemoal@kernel.org>
In-Reply-To: <20240607002126.104227-1-dlemoal@kernel.org>
References: <20240607002126.104227-1-dlemoal@kernel.org>
Subject: Re: [PATCH] block: Optimize disk zone resource cleanup
Message-Id: <171821162890.49689.5201501208480966687.b4-ty@kernel.dk>
Date: Wed, 12 Jun 2024 11:00:28 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Fri, 07 Jun 2024 09:21:26 +0900, Damien Le Moal wrote:
> For zoned block devices using zone write plugging, an rcu_barrier() call
> is needed in disk_free_zone_resources() to synchronize freeing of zone
> write plugs and the destrution of the mempool used to allocate the
> plugs. The barrier call does slow down a little teardown of zoned block
> devices but should not affect teardown of regular block devices or zoned
> block devices that do not use zone write plugging (e.g. zoned DM devices
> that do not require zone append emulation).
> 
> [...]

Applied, thanks!

[1/1] block: Optimize disk zone resource cleanup
      commit: 1933192a91be0a570663a3c6310c46e4ce3b2baa

Best regards,
-- 
Jens Axboe



