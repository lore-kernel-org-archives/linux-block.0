Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4924648B376
	for <linux-block@vger.kernel.org>; Thu, 23 Jul 2026 17:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784826353; cv=pass; b=MEswxdOWFsHsS8SmL2nhPBIMqeUcaPgkTVdR7oCulj8iESLeaNocSbrnAEk0gbfeMF/58gV8wJHuq54OhDq9Zg0s7+zpkkTpyhkSFWL6ZZ1VWWnI/TF9yHsufWjVhxSLcqgsGRqjzvTfOlvFCliSfa1rrEqEqXPcls04UAmabzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784826353; c=relaxed/simple;
	bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qt24NUt2FA4FLRxNbag0V6t7ZhHbZGsKLxZwIhkmFqfBiPEJ4NjY1ua5iEI4nA3DRoHcccn/KjYNewHUS2MICGUR3MS4HX0YwOMR8f9BIMRHRTIJNr6FUBuwl98HlIwoUUVss4KvM3V1PXjuE95zMf0gFqVhERKmgI7UPt+BpTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l8pkA7oJ; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8pkA7oJ"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c12614b81c9so138558566b.3
        for <linux-block@vger.kernel.org>; Thu, 23 Jul 2026 10:05:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784826348; cv=none;
        d=google.com; s=arc-20260327;
        b=JGqmb1Pc01pTScePBE3UVADUWbqfbzZWnf+3/5QE+3S5mSkBqADflbMDuInmh1a88M
         5ZPg+qSVuYbvKAlmetjeWkmvUkzXr+JM6ikwTwmUqkPEHD+Ilcjnp/RvFN7KL+tIgJRA
         OfQLLXI4H6VL7cmAcoQ5QIVOXSyMrF/YdzFVOEWhmJ6fzr1MtSfFpZJisn8a/vZRqI/2
         xlWEX9UVy4j8Dhuw7yqdolCFvsHFb1SKf+WOysx612DZYHLgdii0lZAGtHTd1F8goNiV
         95TB7v3eCiYLhPLN/uUjAdALdKIsdzy0AutHSzg4BoOU7knYeBOm0Metro2HvLdU3dgZ
         lhQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        fh=RqUplsYlZFCikNZXlQ8BvCiJcetoKpzmFET/HauxT7Q=;
        b=Uq3a1mi+cdm6zWrsCD2S6uIL8Qvl9vXXVjPI1P2/oEiVy6OpPgB2sI+1qR/SqR3C49
         JN5l4baqNWDnHMafPQ3DP8Ug5DAvjWJI2f/qnAvkh+T6H/TxytafAYDxJUv0gJvKiN/n
         qENVrgV61fwrGoreG2pOlP+EjKk+R6lIogBEv1xg7UL0UFOTsWisV39cBUCEKIZ5akqu
         LF+xdXKWIjx9S9P8N3/uDMnYxvxka2F4A787cAn8HgNIxDB0xQSB6V2T6AcpWSTWgcth
         n1NVWFgrgK7/Sraq6nPNHMsUvDq1XV4aBBMBtCS/N0KDzq5Dxdl17qD3BazKLV+X1aRt
         6R9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784826348; x=1785431148; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=l8pkA7oJLih8TzuvTDGh7j0dMOl6Eb9Nrun3ybHk91qSM1/ZqamVq51elv79Ndy4aN
         L4+7SrUjtKtmoGwa1tNEQxBxhuWfYLqVZwNrhC81cIf7IR1JoLsJZ1znekQ/5tZrvHQT
         M1IvSMRdCj29VDkj0qw7igjvkqLE8fVDl5sdnQrGoXo14i8HrALrM0LPwQCIxY8u3uPg
         y86xoHXl1TJOzQYuCunnpAnCcpNVXX/P0WDUKNre1PTW3TtLNrKUYMUAMjOEQUN7fwqk
         9FiLydcKYQpgYmvsHWElZNb9x5pvHnfoXzL7wbr1bKgxb8J16ovuFAZezrsKvJL/OK87
         JR6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784826348; x=1785431148;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=hPVO3UB5BNhfsfpFr4/T51u/Ki+AfMJHa7D1licsT5MKVYSvA4HoL9ASbOjapDu+F/
         tlXNVZIsKZJD1OGiFajfHB8rvVBPzqgkSA8dE8Krq+MNE33hXR0R1UACaUPsx+UlpQOl
         ht6cZsQv3nCKs686YJQpABa1AlyfHoX9ITCotpJD17lonPwaOF+i8AtVFGUcGOL3BLEP
         d5k4vYO3+cJR0xghHXE3a32OzueSw71cTTa5anOAifa4GbZHTlGMgNIN12hRiKxS0Si3
         RgsUEfGIjw23azbaq5gOOSLLq633SGm0tqJpI9mHEZAn86bxPQ/i935ZA4I+UQSsqkQu
         Klig==
X-Forwarded-Encrypted: i=1; AHgh+RqrL0KZOBhCVTEstDbEoVjiCkwnFLKXvu+F8VXWDDV+bxGPzY2C0N6XwjXlpAshy1aCIaJniQeum7Jhxg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyImwO2395u5bxHprLO/J+1maJWHgAtF1GIQrK2eMs3R3xhyxQm
	3PTKJWZ5yjY4NXD4cYZVvL065B5za0Y7g62YjK6sFiyAU0yumN9Ouj+Bpt5pYpOVg8jLSo1KEUy
	VNQEYOqUWqndDW04ce8TdjMoItjTReA==
X-Gm-Gg: AR+sD13QRFv5z1d4JNunDpQT6frZ55YOPZjQ/6Ge8c8TzZTB07n/hinsRnswohquX/C
	lGdyR7sQ5ce7uvdTXzcaqZnR7vXsr0tvO5rTutEN/EzvROSVSNxy8lsuku2wPa9gj0Qi15Iyucc
	wCApCe7FaGcCxcyWzGMM/hwnqjjKsla3EbSXLrV0dmZrDgyHk3gVUUv0kw4WyHggdXYhYG2urzA
	eXx/c5c0tK519rPJJPul9XSlKjIPAdu3QLkceGeV4tg+uCO+mP6JFAR48CGf9ANtY45RFFKaBry
	ioq5KxH//i3GNnfKDV9U5NjrNmhCvdPL72FF+9dG22s=
X-Received: by 2002:a17:906:9fce:b0:c16:a9e0:d5eb with SMTP id
 a640c23a62f3a-c1c509a83b2mr202122866b.56.1784826348034; Thu, 23 Jul 2026
 10:05:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723145000.116419-1-hch@lst.de> <20260723145000.116419-5-hch@lst.de>
In-Reply-To: <20260723145000.116419-5-hch@lst.de>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Thu, 23 Jul 2026 22:35:08 +0530
X-Gm-Features: AUfX_mx42CjHuGi597hWO-eDmQkzzqIKaOn08um8jFHZz68xIGpeWOmFM7SNP0w
Message-ID: <CACzX3AsOLiKnG=spMY5uHOJX06QB759HY6fh7Z+=zBgjwEPfZg@mail.gmail.com>
Subject: Re: [PATCH 04/22] block: handle nogenerate/noverify properly in fs-integrity
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>, Tal Zussman <tz2294@columbia.edu>, 
	Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
