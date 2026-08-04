Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62513E009B
	for <linux-block@vger.kernel.org>; Tue,  4 Aug 2026 12:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785848260; cv=pass; b=IAjPjW2XUEjr4ASc922HAHT4Jw6mvyMtnEda95ntXxzvdX0MltpT59eGh2fhMjPJZf+f/M+cC5hcTSSAxZ363MJjx3FzWHxwY8bQ/1EOEbKx1yykUTApf8pDyhzqDZNMacApoy7JJub8In9dl01WQOa5VBzmAH96/7xOGilNgkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785848260; c=relaxed/simple;
	bh=+WmRghJef1r5J+QMpdMAEUZ9j2c1Uw767yzVkm0wDNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KPAnTDGijYBfPXyasw5N35vbynP2V8WioxxwcyaHF6K5Zu5ZoLzKA2HHKaqkoMpwlnF2cKro5wnySjfDcjy+l6rnuFS//I/brUGZDBCpwQImGtp9iwA3ffTerQaIMLIvSdOxhK2jkTmxjUEzT92hZmrGp+kWe0weTqM5R+49ddo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C/sIO0rM; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/sIO0rM"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-69c600f76ccso6845208a12.0
        for <linux-block@vger.kernel.org>; Tue, 04 Aug 2026 05:57:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785848257; cv=none;
        d=google.com; s=arc-20260327;
        b=hp5yOeQOeVUKvug8M7GC78zq5QO2S//DpqWhOIo8Q38B+0HzSWrWIXyPR07gKnXdXE
         X+Q4EBtz5D4KikQafEZ63mGkLF5n3bJsL71nT7Qdboge1SKb0C+EBgcycWfsLYD0GboJ
         CY1gnb8oyHqjDHobj5UtPBMbupFcrc1kEN7y9CbfQH2CYA9VvVHlp2og+O6lCypp0VOT
         UmLHOo15JjDa0J7fO5y4Btv/M8j0pXxsRwvXQy6d8VTTu1kY0xu139NitgPXRhTgfzii
         f9sudnCTur3ivOH2Wb+sreRB7hXDGmpXtRPqkNUYoalVexyiniUvyNuNogfWZI4lZdDC
         wRzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+WmRghJef1r5J+QMpdMAEUZ9j2c1Uw767yzVkm0wDNU=;
        fh=oy0alxfl31bsWp99VLxMP1gnsdzE3EmOUUOYkQ340MM=;
        b=FQzHuKfSjlwSMUTikHZvQgZeW7bHnjk/sy5ZhxlTPe24r+VHgFsSabHHc916qkFBdx
         QP7eJIH1hG5rBCFrixRv15k9bTpnSRAUGodhLhTfxdDFyITZVO6nuvzG88oQHANicVK6
         GlApsXNT8ptGFBWe1hmhHKqhCHAO0b8BavYITXP+oZI8K7GDzkGJfHZiRKmJv3b5wxPm
         4eRGYpcY7wS6a3EED6TMy+suXEsGRKnRwZ21+f3uV7CFT7gXEhHSiiIztJHg+1FCJ3rn
         s28BCJfrYliDpGTLKVeZhgy27EYUBUsJHiCAs6zhwMEMzs+1J1AyUoGK+VbCXKD76rjR
         Un4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785848257; x=1786453057; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+WmRghJef1r5J+QMpdMAEUZ9j2c1Uw767yzVkm0wDNU=;
        b=C/sIO0rM8eRwvBwCBzyXbcxX35ZAfc61TSZrb/dx5BqgNWgqdPL7xgJLZMyPOIuZmB
         sqZiezOg/NnvVOaxZUuV+jCD6nJifdwyN7Do+W3eOhv58cQgmv8MceGSQkMP6W5CnKEx
         Duc/NomN1WwNXBpS4eveyrcbt/LfN/Rr2DG0TIAfDctsK54Gfz2VC+afAThD2vSFPOOq
         Q1cXDb1Ttorw2kKIqy2jTaTOTXsZu38aOEAtvST7SRKgjNN+J3NWoOu5ONaKc+GRY3TV
         d+hAwwMjWIfP5b+rv3EPRdj3Kgb5w1JOGKhl/XRP1nNAob8EYc5F1mF8sbR2s/Ga/fir
         WUeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785848257; x=1786453057;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+WmRghJef1r5J+QMpdMAEUZ9j2c1Uw767yzVkm0wDNU=;
        b=e+wW/H/I+HQuFhm9bSf4F4Li8LS4YKHu18OqA5qPExejHe0I6oWw+fP+HDde/8c+Fs
         bgy2Np/F8txfVHy1eVuRJj3LDT6H6REofGRlWTdgH+jY1fO44sGdEqljhkur2MKgYxdU
         51ZCaNYT9Wr6yrBiiH1mqz5M0BmgAJFdUWNFgLp+MXnaBexW051LAIJLBs3m7mIDy8hN
         197+fgpGxvbPLsPNqjtILWfMIALD5+4tHtivp4XM0WoSgjBZZ2mko88wTWI8nanfpY6B
         EWUBDE/Efl2rlMpE67uKaDsoPm2fx77mJfv9EXjRedY3YmENoa/2BkwatTN2MXxOala+
         PsPQ==
X-Forwarded-Encrypted: i=1; AHgh+RqhqgHCvRZvoC9bkPYcXbCPfdbJfsOp1MkXG2X9KP+CGezIDg3Fg0Y7WSaiyXXBqa5+bI9Z0yPSqfMoyw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxius2XIR5M6pyfmkfmxpgLedEul7b7c9EZao+pKFWvepK/bE8u
	gPqkaXihahNdhBcnrN1PbztTa80UBaWBddl7oDIyOTQ1HCAUtUWG5QVLjSn1jjOKGTymbFgCmgG
	24dudR1h2zpwf1CLb4RBnsK3WpyMnjg==
X-Gm-Gg: AR+sD10ilnDEl1zAVBy9xemOaS/SoJY0ahp5m34W2dMNGS+0h5qYUlHnTRsTsCAHqKQ
	vx9ZnbXS5BI1VRCXb/cPObzF4jHYdLynPyytqjr6/xLZv7FTYFga9TgtlupwDWGos7dAedwCYWm
	tJpLnU22v5ZpqsQclQV90DbUTQbeXf7r0mdF2xWdQu/Y7p3LCLWwWkU3EfBsvlDdVGpHZe2E7F1
	D9D/uPyfjjaO2SlocJr4O+gx5/K7BexPpw72SrrbfLH/Xc07QYUmhPMVeuD7FTIH9tx9n4O7xc0
	G4gZf1WYcDtOfDH0pyKNZ48DuCrOwPe/pDyghPNngZFwzfCd+ynO4cvGGXuLFI5TlYIIJkRzgWW
	GrYzXfJadPvAw+Ns=
X-Received: by 2002:a05:6402:3241:b0:697:e8e1:d3c0 with SMTP id
 4fb4d7f45d1cf-6a0a7c60f6fmr9974383a12.2.1785848256625; Tue, 04 Aug 2026
 05:57:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804123928.736596-1-hch@lst.de> <20260804123928.736596-4-hch@lst.de>
In-Reply-To: <20260804123928.736596-4-hch@lst.de>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Tue, 4 Aug 2026 18:26:58 +0530
X-Gm-Features: AUfX_mwFmmpC_U35ny59wFjG-bBG3cjk5l5jGDZtPGJTJ13E215K0Y1Na_HqAxM
Message-ID: <CACzX3AtEvhTmX8aGVi6zrWWu1=Cfoi8z9=Z17RsZB+pD0LU=9w@mail.gmail.com>
Subject: Re: [PATCH 3/3] block: handle nogenerate/noverify properly in fs-integrity
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Kanchan Joshi <joshi.k@samsung.com>, Anuj Gupta <anuj20.g@samsung.com>, 
	Christian Brauner <brauner@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Pretty sure I reviewed this patch before, but FWIW:
Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
