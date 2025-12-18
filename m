Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00742FFDC4
	for <linux-block@vger.kernel.org>; Thu, 18 Dec 2025 17:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766079360; cv=none; b=J/v+iN+7lpV9M2gBd5KAJlZBoMlHBidaT16OxchltMojglwVBa5/bUbnXpHZv/EiibYiAw4uvbYHjJPZzwNvmpG2cCpaHeqdJkuCiLRqqvCn3DP+hbTMwbe2c3vt1TitBX8MQ3ThQX0B5Bfgkgz64+RACeNAl80emxON8084V0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766079360; c=relaxed/simple;
	bh=nzcA7c48q5XS5Roy2lXR024dj4daYm4zvfVsLU6ahz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g62KDwj9bZ4bOJHufbeeVLkQ1DfSuPll4GIhc64Cq9DDT485lEghdm4Bl+qDkI7l/1mLFX13g53UD1Z9T1H9HJAKBtOjdggPfdUoxoBduca18R+pQFzYPgU3Ll2Ex1e6YZUQJ1D5EPfSeIwyniL44Yqs6YZLdn15XyiPOK02vD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A9AoR5Rz; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9AoR5Rz"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-88a367a1db0so14062456d6.3
        for <linux-block@vger.kernel.org>; Thu, 18 Dec 2025 09:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766079358; x=1766684158; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Km2T1I5YBUewLvu5wzssTsrcMP7r1tKGG8gU9jwLlQI=;
        b=A9AoR5Rz2lM8QcNHSifTM9yZxbEWZu6JOhGY571VCvQwXm0yjUfbizldzkCCTP611Y
         aH63eDBUDvvuEJyeiQeabvVFNLgeB9jDTfFtO9IawP7BsrnT2eWdW9mNLf2B8dVtUPzX
         sbSNdWrdfse1QaiVhx1p4znKipW2e9zG2WEgmftq2cKQptR6BVS6vXkm1wcnbJcKxnb9
         E6y8N8FcgcBR6p6DyTvirL0qb3LEXVSzqknW1T1ib/ImK+dDdX4PSn+eF6QTtbENdzut
         909U+YosHK+Vi+ZA3+wQhKOFVkMYXCt91Bs4oh3cz9QtH+PN18JrFsYOBqQC0f63ejYf
         1HxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766079358; x=1766684158;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Km2T1I5YBUewLvu5wzssTsrcMP7r1tKGG8gU9jwLlQI=;
        b=Xtx9YSvXwUszlND9Pgm9q/PI++S9is9FFrTYSRzRv0PI7UQ4E1NRR/0sKMJ0RdKFF0
         P4Ws5ELQ9OFTs0CgEDXZRbhHyhN19L8mdEMC5tngFc41N75dpk5X/8ntUzUtLOzJ4KM6
         kkVkaZmPoleOCjIvjmagoNFVJ6jWUu06wql3WW6RPT+pbxLply48S1Bl+BPKEBZbXfsF
         dWIK6QuUq86ZjzZdo1GR+KipsyPiAX2vdNbGYGGYXwbVGAos8hNyMmmPY+DVEMc+HFKw
         W59K8NrA+1JsLc35QkTWLfj27b5s1Wy75ygyy14dmqt7Si7nchsXhBnOYj7/+6ptCByI
         gdwg==
X-Gm-Message-State: AOJu0YwE2/aSiL3QHcJkbU1ZyNdyj88/cM2/R7hcfbNFAVe5gZmpNCA5
	dKP5Hhh+ksyHVyMth5yX2biMbuJIf9F8+EeUhur2kSV1r60Y4CVYYHLEaHqdqXvFI101s24r3HD
	Mxu2CZbUsDtsDplLYIjCFEsqni0amFVY=
X-Gm-Gg: AY/fxX631lPDsp4VEyo0tPMKJYChV9fZanYoLk1S+eyVicBbD/YDgBkjsis3IHpQpN/
	CSgb5mis8yAkDYfp6FS7lsIKFy/hHxqE1MsD+NK8X0YrmDO4d56K5ZviNyUnlTuEhb8UQaIul/V
	dvl7Hex3iyGHCZgukHYjI5EZpXqmZxCZWALJ6gXcMNtqJ19rOyNTDz/qHgMN02Ggs45h2dxIi8f
	VMsrx1Fd+ZIEPCxx+IfDVzd0uTB2Kb65/4f13Ws+8qyQRQnQS8FHKU5hUjxxUHGapEDnSJ35lYH
	BlDbWUs=
X-Google-Smtp-Source: AGHT+IHWmp4l+iwvvk4UGfOw4WyIVuDTX+WygPNaY3MwlLjW0z28sFuGsm38Zc7fjoo+CRsLN7xb1TW05w1c4WM+paQ=
X-Received: by 2002:a05:6214:5789:b0:880:3e92:3d33 with SMTP id
 6a1803df08f44-88d8369e698mr6123316d6.34.1766079357608; Thu, 18 Dec 2025
 09:35:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5b023828-b03d-4351-b6f0-e13d0df8c446@wdc.com>
In-Reply-To: <5b023828-b03d-4351-b6f0-e13d0df8c446@wdc.com>
From: Justin Tee <justintee8345@gmail.com>
Date: Thu, 18 Dec 2025 09:34:45 -0800
X-Gm-Features: AQt7F2oCL92KL5RlafjzhPSPhxdJJT7DMmF2OqVJY7G1K2GtyDi2MGUAHicBT6Q
Message-ID: <CABPRKS-2zsAEjhsJX8aPjzud9LeOTCsF8WN=amSKpBzxxzJ-iQ@mail.gmail.com>
Subject: Re: blktests failures with v6.18 kernel
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, "nbd@other.debian.org" <nbd@other.debian.org>, 
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Shinichiro,

> List of failures
> ================
> #2: nvme/041 (fc transport)
>
>      The test case nvme/041 fails for fc transport. Refer to the report for the
>      v6.12 kernel [3]. Daniel posted the fix patch series [4].
>
>      [3] https://lore.kernel.org/linux-nvme/6crydkodszx5vq4ieox3jjpwkxtu7mhbohypy24awlo5w7f4k6@to3dcng24rd4/
>      [4] https://lore.kernel.org/linux-nvme/20250829-nvme-fc-sync-v3-0-d69c87e63aee@kernel.org/

This has been fixed in 6.19
https://lore.kernel.org/linux-nvme/20251117184343.97605-1-justintee8345@gmail.com/

commit 13989207ee29 (tag: nvme-6.19-2025-12-04) nvme-fabrics: add
ENOKEY to no retry criteria for authentication failures

Regards,
Justin
