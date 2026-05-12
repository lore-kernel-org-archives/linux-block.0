Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A662A3AB48F
	for <linux-block@vger.kernel.org>; Tue, 12 May 2026 15:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778599666; cv=none; b=PRbM8dVLxK0Wft/HpkN/BhuKIQVYzmXwJCpxzLpLqS3Xm9uBNQ2e+37sauFsd37/ZicPli/RWkvbaU0S3EcSV6tuVUmBdIlReys6ewiyfXDhHXuAZfkll/UcaTqtFfZPYiksN3IgLT6feDwXkVgfYkEkf3ppXRADfAU7Q82ixsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778599666; c=relaxed/simple;
	bh=HLUhc5HHtpftWCZ6Y1/i8yq4cRHnGXoC1sTYBAVjKUA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tOXhRIaUsdwwh2IOSI6gTgWysXYadic1BPeVZZU7O9UiKp1QiMnIXBwc+eU8/q8lIObL/hH3VSwTibsEF0qljGIGYUsp65oyz3ghvV62PPXYGMzAuao1yZOyRic6xA0PK6TooQgeJm/PJsdFl1jC7eDtJ21IaszdzyJqR/RXx0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=nDKcd8sN; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="nDKcd8sN"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6969c864c89so3235515eaf.2
        for <linux-block@vger.kernel.org>; Tue, 12 May 2026 08:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1778599664; x=1779204464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yb4jYsBpJxWnv6Sc4WqEJv4u+xz0eaToc6YnUYkbiFA=;
        b=nDKcd8sNIKNbzGElKb73rJqzzY2SggbYaL1yIClRJ5iEr6kaj2u7M/0VGWQTaPR5SE
         Er1g/4/lfSpMygNdorsaZinctxBj9Sw1EURbzmIz5EFP1d8DfZJvLGqDVfahIy8ws7NC
         ftjIDveZGz5pEs9WabFWx2uZtlrcl0rUeutDmJ+0Hdqsi3jcW7VGXR/GCd4kcy+41L+N
         ZbBCu+GcRcleC6zT2Kh/h+DLuv7d7yP/ty4iqPsMJUEb7n2WWrZM1eToI10NvtIFssRz
         v/mFzx+ezVMQZt/x6NHjnA0s499yctvC0uHf4/aohgNWPT40P4ZmW2ar2xYfdY0bClC5
         11+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778599664; x=1779204464;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yb4jYsBpJxWnv6Sc4WqEJv4u+xz0eaToc6YnUYkbiFA=;
        b=B//SF9RAEW6mt1cYd/wzyl6uHZIh/HeOiyL2yzeqI9TUgr1Cm+76e5n6K13KQwhYbD
         wsGS+9D7pzH2CkM/BvyEslM35uMYFzbcze5tHF6vho1e/Wo6innVt6Q1Ze1RMNjx3XaZ
         NrXp9pefJH0BJM25ag9/HBpIRvhCMpnNwKTQoLQW+eHW0I2W/iBeV4CRANclnM5HhWFQ
         Aoeh80EeP2ZodEXV9x2kE7wWmH4XADmMGmtXpvpKdHSDzxQ2TfWN1RyG3kSAY+zTF/lE
         0pHiu9uVxxsxqG4Adt9qugJpm0jyjO1pcLZ7myKP+n+l7V7FdTov9fYny1kFM/tu1zAF
         r0aA==
X-Forwarded-Encrypted: i=1; AFNElJ8rHGLFV2WhgEr9MUcdZnliZoUcOHP4LnSuOG5pK4Tn/EgbiZc4phyxHvU/qPNqxniC7A3VcdPM3T0CCw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyKY7b+ZpbxXVJQZv/9w6fMvh4LZEDHXS5Jqk11vBb5SuaomxLr
	RdX3Dtxuu3DrmeyyBPVtuq4+J8hIWLKb44tKpAWxgsBUS8FND/utJaKtGzntr47aClo=
X-Gm-Gg: Acq92OGP3TBG72L5ELw2Gb0Z20m2sCFBoEA5mpUGyT/2+MpkUxdiix1L7EAb74QohSx
	q40FwKPVURcLNshhKYofxeECJGqRKMSvfCmZgXXEESxxqg727wLJsxigQ69tlQmARJ7ctkx9B3A
	eJK5PpwTcoOLEEhXAmXthL5hJ4GcT4ONmnHO60TPfq8N51RGRc/DlQjkeb8GAAE0gQz4bKy+056
	gMeG9hoSP+/0asKVFScNKWWhIpbZ4mzJdEude0HQJFgoXXHWjEPluDwE1omw+iDsnBDvPuVBDHC
	YRju+yxEV6s7PUU2rEwhbWeUqcgd0djfsoepwWDnTEOHFXd0CS8NslyBAofAoymbSRY/LChWcKk
	LCWUi4WYkZhlmCUfEM8ZnfZO282p94G6QnZnJViTvUZW/QRM8GylXcWOb92iQs043DYsGT7leb0
	dPgCcwbY4HLdAiqRShnKTu6ILNpfyOyOThwqhEUjLwZPKdIGA7BL2xqbaEHs76t5SVA89bfrY3K
	OI=
X-Received: by 2002:a05:6820:1627:b0:68a:f494:e8fc with SMTP id 006d021491bc7-69b36c91403mr7828020eaf.33.1778599663739;
        Tue, 12 May 2026 08:27:43 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4355736f517sm13044552fac.12.2026.05.12.08.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 08:27:43 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: David Carlier <devnexen@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, 
 "Martin K . Petersen" <martin.petersen@oracle.com>, 
 Anuj Gupta <anuj20.g@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260511215151.346228-1-devnexen@gmail.com>
References: <20260511215151.346228-1-devnexen@gmail.com>
Subject: Re: [PATCH] block: don't overwrite bip_vcnt in
 bio_integrity_copy_user()
Message-Id: <177859966278.306312.2440099833392948308.b4-ty@b4>
Date: Tue, 12 May 2026 09:27:42 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Mon, 11 May 2026 22:51:51 +0100, David Carlier wrote:
> bio_integrity_add_page() already sets bip_vcnt to 1 for the bounce
> segment. Overwriting it with nr_vecs breaks bip_vcnt <= bip_max_vcnt
> on WRITE (bip_max_vcnt is 1), so the gap-merge checks in block/blk.h
> read past the bip_vec[] flex array. On READ the read is in bounds
> but lands on a saved user bvec instead of the bounce.
> 
> The line was added for split propagation, but bio_integrity_clone()
> doesn't copy bip_vcnt and BIP_CLONE_FLAGS excludes BIP_COPY_USER.
> 
> [...]

Applied, thanks!

[1/1] block: don't overwrite bip_vcnt in bio_integrity_copy_user()
      commit: 637ad3a56a3b889527d1dacea6fea2a8bd648140

Best regards,
-- 
Jens Axboe



