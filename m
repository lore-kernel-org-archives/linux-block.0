Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585A63CE0A2
	for <linux-block@vger.kernel.org>; Tue,  1 Sep 2026 14:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788273864; cv=none; b=lt9Rp390aifyUU7Iy7Zcj/oUOINw6LW6s2Dyek6hh8SJhGdvs2pYrx23AdQNkvz3vCrzZBIIGaicVHRa89ljAvAEnGE/e1rJbJBZut+Tr4VxPglzF/1elLEmjgzlOcojLz5iLFpk3epE1aAy9b54RjIEwm/gViPEgwbAWOUCx/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788273864; c=relaxed/simple;
	bh=xdgt4fLnKndojZJegMBWAOFeh61WPm9mm35ze05doGk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cZ7QvaBcteqGllueUo2Psv8sOET6pJHTSTJiLisdWJmiEevd8EX7SzGtRZntNygfemstA2NQocfPyKQiNp1+B+5X6lEb+D+AtwTPtgHJBFUjHiBNSnHmRPAsksoF+O1my/L6ECVuwr0E8+6R2qpbaRFEtwv9Ca9SNmyvjPVsCx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=AWSYK5Yk; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="AWSYK5Yk"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c9b373d5af0so3911569a12.2
        for <linux-block@vger.kernel.org>; Tue, 01 Sep 2026 07:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1788273861; x=1788878661; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g6g9ew4pjxJX3xUkRdSmU42jlWYwsAUid3GO0GRYIto=;
        b=AWSYK5YkWeF/6363ukp7sO+mgcr8b55aWoJ/Dki+WIj9BC2iZJWY/w/dw+CdM9QXD9
         9hhek+CABfxzryd2vk03im4Cp/+++ax8iKBgbqFNfS6BeWlMcS1fIgC3uUfTQej9BTu/
         lZIZorlZnJfIkFmIgyJX4of4bMqlZj3cbZCKZAMzttD3AxhuASPagCOw/D1QvVcGfnhe
         4ABSSFIyuB9mBzCx+e3G7VeDs12kGTiDZwdx3siKk2y0Y7Fnib37sfQMm8RlX7ndxL9u
         EP8FPuTGzW60Br1+nSqwGI1/M9kzgHK0m4GXQDR6pbbabKNcjNzeeuTOSYzeJWiMKmvF
         NM2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788273861; x=1788878661;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g6g9ew4pjxJX3xUkRdSmU42jlWYwsAUid3GO0GRYIto=;
        b=Z7VxGJ/3cyQqCpA8fkeP7RKUKyAc4Tgfs0QDBIhyX9qqGApGjhQJEv2FnEieHD8v+S
         QEmQFwFlXAibWUsP3t/xIIPfc8D3dpBebg4DOj74S0t5W6Gk2C0YgxWZNzyeR/sApXUt
         AxC2NdXtwfX3mpncD/FQrIAn660bWbFDudYnXTL+jf9Ys1lc37JqzGirH5xJ0H1aVIFU
         s+pc+4sTVlnIiuBxIVsffIEyGDgmYaU7Qx0tkFZjg+mTG4Kq6uyMhYxQSc/9Mhq0rpoO
         ukP00vA2V23KgycKuSoorqHqUxqKUuBaLroN0GUlTFX8DRpdGUnAndkhEQoffZFl5JB9
         2oTA==
X-Gm-Message-State: AFuF++mEVSOM5QHIHfthtiVCuUKStSOgl8T6M/n4FME8QEguHosWdSYU
	kh/ayLq35kOcIjIntMjaZ4QapIqPs2CHjpxqeLpHuxm42c/NdwMXDuqi4RYMfPJ7XEg=
X-Gm-Gg: AR+sD13+FNpLWTnlwCRjm3EJlLfszc8DiRe9HGRFBo1eTwDpb2HWd7pjWqDktNGrzE/
	hoYWIsX2KS4QhQk4RJlRH62POZl2SVIGg0mH3UDupJQ6fUpVFcdwn1975UOjF2v/Ae347NLnbkc
	BKuphhRO5lkspOIVBrbx08QJ0IvxTA1wcoTxHGmgstIaZ+2uwp7FWm1tsduMt22FuPboTruJePg
	BCA8MoatI8+NzYxsHf5fMRtuXp6wpx3MtYauWuff93aptY6GJkgerQag8fBIiqBeifmh0LswAro
	ipotdIOk8Ze/KZfKngVyDrRRGmhFEjT58MAEmneYj1UbQoFD5PZaHIxzccCYDkUWBxbJYy7AeJH
	qXR5s+XhAW3q4DJ/MFcRK1XlTpgX1rMPdF6BcwPlPGMJyvtGl4n1Mc5sNaUa2Kub8Xa5SJmJUfz
	gKsuPH1PXKeTmr9N6xFFLwNJWDUy+de+ZHnMiDF48TdjLSfp4wmBH2ApgPOOdedDgpmWuXnBV06
	nRO+gC4CYL6/vNJFnqgfk+P3jSv7tVlgS1eRLct/F0=
X-Received: by 2002:a05:6a20:6a1f:b0:3d1:4225:9bb with SMTP id adf61e73a8af0-3d265a41ee0mr45746192637.2.1788273861521;
        Tue, 01 Sep 2026 07:44:21 -0700 (PDT)
Received: from [127.0.0.1] ([192.77.111.15])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f9e907fsm34773046eec.25.2026.09.01.07.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 07:44:21 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Keith Busch <kbusch@meta.com>
Cc: hch@lst.de, Keith Busch <kbusch@kernel.org>, 
 Eric Auger <eauger@redhat.com>, Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260819154937.3903312-1-kbusch@meta.com>
References: <20260819154937.3903312-1-kbusch@meta.com>
Subject: Re: [PATCHv2] block: save page offset gaps in cloned bio
Message-Id: <178827386087.2511601.16223997201252856898.b4-ty@b4>
Date: Tue, 01 Sep 2026 08:44:20 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Wed, 19 Aug 2026 08:49:37 -0700, Keith Busch wrote:
> The cloned bio needs to inherit the accumulated gaps between vectors so
> that we can know if this bio can subscribe to the iova coalescing
> optimization.
> 
> When cloning for a split, the gap only applies to the front bio since
> that's as far as has been processed. The remaining bio can reset its
> gaps to 0 since it advanced past the checked vectors, and will start its
> accounting from there on the next split check.
> 
> [...]

Applied, thanks!

[1/1] block: save page offset gaps in cloned bio
      commit: 96c8ea3c5add7920b3c43840d1ea76b3354c8d2d

Best regards,
-- 
Jens Axboe



