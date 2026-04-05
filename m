Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07B33368AA
	for <linux-block@vger.kernel.org>; Sun,  5 Apr 2026 11:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775388589; cv=pass; b=u/CNg4quPCFrWrcEVhaE2Pv1h3A2wgEuCvAuY1+vDCTaUuwv++StriQeoGUzqD2zmWi7qxNYMVV6DVSfo9DaMcmYDQDOPKohmRbkjoXtJjMpk51kDI/o9BreVmiJhfeVKexDJLV8aoDcMtqr+tKTiPtjfnYCzeFdmZ9R2TUi5BI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775388589; c=relaxed/simple;
	bh=DvF0YtJZCPbcobMdQgE3+ZNHa9Fjrq28Jh3rCZ4Bn5k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GX7Ee4bIFSqfpsACEy12Wwtlg5Z0/yQHJUlwwUK/UkGzqZuRXtydvfwaANRniAEUnYSi9PPhZ8kptmbgVp88NZs46cE7nMCTR8KC+4v4jqPfuAaznzR//gFIcTZrCyd5YQAeounRNtOXMpDux/W38axB915hN9uxwaR2jHVC7h0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pE95XAwt; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pE95XAwt"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-66e8cc714fbso1645584a12.0
        for <linux-block@vger.kernel.org>; Sun, 05 Apr 2026 04:29:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775388586; cv=none;
        d=google.com; s=arc-20240605;
        b=gPQfx4RvKBLz/KQJNoSStV/pbHYeriwQQgSIYweGo8Bm5wtjc3Q2Yd0/hfwGK2ZPHG
         uBDH5E3qpn+rvvkcG5/5yrll2dNwnIuzDAlMssMOqSX+kAMzJ2mi4QAJaV8/qbJf8/06
         wfMMGA9N+ZPB8jGN+IDFlB07o0kP93OyGmU59zLW31Bax6XI7Vo0Fm96BmpsOWby7lQr
         0yYZInXlVOuFKz8J/JrHuq/V6O251zJpaHLkP/uaKqvtlNKvksfAf7NWGf7kMKGh39O3
         TQBp/92c+mvJdJY3ynpyqUQWpFBi23Dbxzh5vcFzWWMtMfW3L6iJatTAPDAGc0EKcjU3
         0P8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=DvF0YtJZCPbcobMdQgE3+ZNHa9Fjrq28Jh3rCZ4Bn5k=;
        fh=DgWgSlw4oPFoXVbPM4fge56x8f29zm5pMOQqCH+lAYc=;
        b=TYBb99PYdOhsbYbKT8Po0AeLQWhdeYe0Bpz/lZHG39HFxpE+Et5R6nwhHL+qT3bTNw
         Na8EnQIDyYj7IWhSj9ZXkpQ0FtBwVF8pzYzUfY95JnfwyB7mTd1qX7+oOEqqSt/FWDp4
         NTMGS8zKZegyGNVRQusVXeH/atdmqYCBvyu3k6S5IpVdLS9F94PocePm49/pTRdmseBf
         1gVE/4JJMV0LLgaGK/Znw2JIrhH4aXlFN48dLYuZ4Io3Sfe0RB5i6y7FfrJdKIyzRZ6j
         8VB62set5Fw4vPiv+Ih8a1AjZ5QC/2CqpfXKNLVHo3cVmDll8zuusxos1L3g0SaxZJyo
         WmCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775388586; x=1775993386; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DvF0YtJZCPbcobMdQgE3+ZNHa9Fjrq28Jh3rCZ4Bn5k=;
        b=pE95XAwtwxOXbJ/Z4BDWhFnqXZrLB7gEIp1M05dFOC8azSmLghypBFD5OslO0PS7iS
         qYaDO+CqoNPe9bcUOOB6BRcQUrEiD840y906gHgC+wR+Vjfydyjm6mi9YuKMb9G8HW1P
         fw/zKydgp9y0OPidnEyJO6UZLps8f2OirwXkwWcexuUhdMRpAX6W+704jzNBCaWj0l9b
         GvEo3aOywqVu6erIrdla4764jBFkKpPF0klBbJlTVqnE8pi+rdy3A/cUV33MuJYQy7Tq
         8CiMVHKDMjDrVvCVjYpEw6UJpYwuWBUwdT6GS7A98SAYwaB61Lmw4vS7EpkfxyTsxQkH
         qCLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775388586; x=1775993386;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DvF0YtJZCPbcobMdQgE3+ZNHa9Fjrq28Jh3rCZ4Bn5k=;
        b=TTN/0anmzewpsPyc6SYsdBHd5ec39lbydiGe1l+Eu+Wd+23+QUG0a5IFMmTIzZsBod
         AY9NkVkPeUDaombR2qi7PcJyjFFLMFxn+9TzBnCaHOqKUy1uCMdaLE5QQxKkmLOdn6qJ
         MkXsiCUCV9CvtJNJGNAvLJLbx0UwyPPI1QtTizZO1MXCVoROKZsZC8+r2XTsMRCQHaLA
         HLvEBOZmA9Arbi6Z3AD2VUzPexX5LjVP5avj2lFoCruLHS6ZzOVfV6kf80NEVulj8dm9
         NQBLyqOI2yllqbjlfZ0nHOLPO/eugD5RsU1Y3JaEeOd9L3W/impSsx1kqY4WzUpCPWP2
         4Mdg==
X-Forwarded-Encrypted: i=1; AJvYcCW3r3lskis+KjXLcVVAEGfcp2d0/vsLnkFyu2YaPQm+I4z14p1lYDJKtY+FE43qCiwP+HVod39Ng24z+A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7bshVJZqUBJHgFTHfgAc3mN+AWqIdeinWEM6uV9yUvKie+61C
	Q4BVBSLnhIqsEIr3KTyrmNZ7jyMLoHXhLaYwNg6pbHfp5tfdADapmjdp/fhSGecWup4b3xv+9zC
	i3DX14VbAwTPexIDVroGtc71f7ZnQeQ==
X-Gm-Gg: AeBDieuc3JcUyRBP/kmVEsd5nR70yL8POilvSsPK99UFLKtyX6Wep3BAUsXikmWpyR4
	4olYAXVsEOoZMgg2bW9+fQYx3P/qf4V+XD+5QhMb+pyUcwWLVVs78knRyWhmh2W86DIorb3R0A3
	APCgw78wl/iB6DBONYseOgv+hB5z5w6jj6Q85vQN9SKVKQR7uoJyXuZZjkPBw+UVf/kxZmknWd6
	TyVOKCeXiehI3IWPtQDiL0yJQYcXJVGIislCv9d2cdDfDK8Gpn79EZN3czUwOSBlzPTXjHuXUc4
	GYcxvbdOKnzuRnHOFCp3FN450uODPLxeEl842+SOaLr3bCc4OtCYM+OVL9wqnFrrQJEF1Q==
X-Received: by 2002:a05:6402:3593:b0:66c:204:5d05 with SMTP id
 4fb4d7f45d1cf-66e3eeded1dmr4265550a12.4.1775388586173; Sun, 05 Apr 2026
 04:29:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403194109.2255933-1-csander@purestorage.com> <20260403194109.2255933-5-csander@purestorage.com>
In-Reply-To: <20260403194109.2255933-5-csander@purestorage.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Sun, 5 Apr 2026 16:59:07 +0530
X-Gm-Features: AQROBzCtWGel72grOiSfI-Erz5HUztph0xDvnagBcgqetrQpIdqD-KiXs-24Oas
Message-ID: <CACzX3AtoogGGYdJVhbea55+XfAuQLd4BVzsjwp9Q2R5_SugDHA@mail.gmail.com>
Subject: Re: [PATCH 4/6] bio-integrity-fs: use integrity interval instead of
 sector as seed
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Looks ok to me.
Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
