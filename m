Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EE13559F0
	for <linux-block@vger.kernel.org>; Tue, 27 Jan 2026 14:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769525870; cv=pass; b=PCSZ1SYHLioyxX12bCrV0zy/7yAYU1Kdz0Q1HGrLtlnZ5HhBaJ/SgVMDfl4B2BMYS8OB+cMQMFeEIeuWJzJCyf8GAqZezOq1k5g7RhjWwdg7hHxFNEbB7adB4J+29ej1O0ILiw83rUABPC3tpvXarccLo9nuXVmKOIzUklkKEZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769525870; c=relaxed/simple;
	bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hZcN0HiEqEr+Ky0csnf2Gfn9goMJqADCwPfIW58zTjcYRioph9eJ2kmQ2+KF+DsyKchM7EUu3ETqXcko4+A83Ft6LdnRQ+jSv9quLiSznM/dQ2aSfBzPEYGa7mfV1m0Jn/pMzLiFAxBUDL6RdViQ1ejGlDoo3soENIQoUoPgvDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fOOj5m9R; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOOj5m9R"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-655af782859so11442459a12.2
        for <linux-block@vger.kernel.org>; Tue, 27 Jan 2026 06:57:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769525867; cv=none;
        d=google.com; s=arc-20240605;
        b=LZdQ+Fkerr9Lg5/mUhLoB9BJjWr125++ec2iidBjD8G3Vp07LKl4nodErNXYrZk/sm
         F02cK4ISc5r+zIQMBfnvyxPITU4QEDMCQaegWOm6cSqrv6F8azg+ISjZ4VUVBxZ/77Im
         BiDu0x+VGVtHv4AcvrFEVI8f8+ADNhFF6uSpgsOfHW+RoxTEqhyjrNOBpQ3xnjR5rJsi
         MT8CkjHMF8KAaV2VvD9Fe4GMUNAyzQyq2yik1fHG54hh6otC+gaEeFqb89r73jXKuHPn
         khQhxoXh3Zo7pp1AIem7iBxznKRs+BYGpB/v8egAD5OtDQrOLItgw3Q1MsqNjhXuAQ73
         VlwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        fh=Gquw1eRED/wMBusyFaggEUzYT8cbkbpKLR1oW+y3DQg=;
        b=Zc1UjPD0eKVBbaQGS7TLI1VbfatC6L27cInIgWdbKR8vusbxwRGAokpW1nvNygWNKU
         QXLcPdcnS/ujWFrM6GSC1klJ6akqqW8biKxSeD1txjDvUvI4Sobv/5Rsy8DhkPTXSUdC
         5nW+hskWAWTy/XF/aVtXrIKE0uambNZxCJINjdLod9jsNd9vExWBhtbk7QXePVq3ucrW
         fb6zG3TdWa6ab2fbD42nQv4phQ79nowXHdn09Sch5FYqjG5Fi1HupaDe3leAXWp9GCIJ
         XKiaylVVNH77Bop7A6lOkkaq56jlAzArihCoi7FozAZCnrtRMnZPSRCuOnQQqM7QE8pa
         YPjg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769525867; x=1770130667; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=fOOj5m9Rr2zn8jmGi3sCVz5AXd+WDsjyCI3+teIiZNkBnZ6Z3To04LLAcmzfCyYy6H
         y1nJfTdZjf8rSyCf5wlPwsZtmQMK+ORo1MbltCQm/Q909Es+0LZEJM3/dg8XR7UyScZj
         edjx2X51oOqyTPAP1oGPGo7hFU/pt+19e86F5D4fHqtP2tEqAO1gAZgYqEscUruc7EaD
         c6DHElCxSfTwNrNaJSsYQp712jykxScyTyQ+WRSsNr28FOfEEf9Qi75NoF0RfcPMDMXd
         Sz1x4UrNCB2tJjIsZfjApDzYYGgoetHaVScquFNH1YDAyXv5t5vC0Ad4jMfNU7H1ezcx
         tflg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769525867; x=1770130667;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=F4ZFkf8Q7LtR4bx1jjo0jHmUOTKzVaFGoHc7AYdOW+TrOOGGDrvEwFGQ3pTyJpt6jV
         wbxzibdiWdHJr+w2/Bxv8plRHN931OyHTqhcieHE+BkQ4aj+UK/6bOs3Gfa9RSGk+vFQ
         Ee9xpFYAfU1r8nBjOF6ZqHxyrPXtRqh/kGBCGP19rqHg1BuBbcqQ28FRv3znkEZkSPCW
         6zQqC9n+3bI1qPOBy1hvMBuuPZqVkqad/KXgm1V2YW6+PEtV26iWsQhPF6T3swrTwpE5
         I5MyuNRibFjubT/h75oxErwwnbPiUZhD8vlgrHLaJQzz3EboFbuAA2WguHe83b+9v80o
         P/QQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5jALRxC5OkPDM6mOaJb3eQ1CkB9dWNVwdlaLXWIaWTaZjUVaU2QsVhFB+1bOUOJm6Bdb3Y4dOTGy01g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzZT+qM8FBhWfXXqlkVj8a2D+VzWaxJOnaSGFrmOWWa3zZulYbh
	bsI+RTlxjKyRlvWARjyHcF1Y8vH3GmgsD7ZgM4Vszoy9OlYehG7RbgeZzhZFF2JSrRw2qj2hLjP
	YKxvbH3vS0ZQbqeXEr/Q5oZeEVgUT/w==
X-Gm-Gg: AZuq6aLxI5DJVSXbM6tEy3I3q//YVo6sOWYx9PsJeHc9usS5wbBLempQ19fieqGOYul
	WIwCV8hk08mSOHGL05TlZ3EEP5T9o25sz9deeDGQIkiJfuc1pGQ4kmsiZaDxVS9n4Y7vkte0UOx
	ms4WHKqBO9PHYP6JvWklq9Mat3qf0p8B16Aa2iXLQvCuSaTDhTo63uoUMYLovsvrYOB8Oj5WS/+
	T4gsnRtdT7Pku3MxCA3Dhc57uPA4EosC3/UDSYElV63NOc1FkZN3NQIDBahx/reeFWg78B1gcA7
	H7RbA0DknOGrqLQb2N9ZeXoYS8KIszhaziG51BFl4g9MXoMj7ViWKHFkU7lICU4FH2NI
X-Received: by 2002:a05:6402:3481:b0:653:9849:df10 with SMTP id
 4fb4d7f45d1cf-658a60a2a1fmr1194748a12.26.1769525867163; Tue, 27 Jan 2026
 06:57:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121064339.206019-1-hch@lst.de> <20260121064339.206019-7-hch@lst.de>
In-Reply-To: <20260121064339.206019-7-hch@lst.de>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Tue, 27 Jan 2026 20:27:10 +0530
X-Gm-Features: AZwV_Qj4X0rX0yo1V91-mqj5DZP7DcX3ShOAwmDMBq59mWSXl3oyqbRMM9BDq0A
Message-ID: <CACzX3AuBQNjOtnmRFFXsyggUWqRB8eJrhpLwjUFzsLzVcKrSog@mail.gmail.com>
Subject: Re: [PATCH 06/15] block: add fs_bio_integrity helpers
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Anuj Gupta <anuj20.g@samsung.com>, 
	Kanchan Joshi <joshi.k@samsung.com>, linux-block@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
