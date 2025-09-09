Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D741C221FC7
	for <linux-block@vger.kernel.org>; Tue,  9 Sep 2025 16:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757435754; cv=none; b=oYIHTcp5edWAzCInD/OwQ0piZ25FNWw7jDASM4nLaizy8Wp6P4EetAe97t1+5+fqVVX2Uj3RewTspAjnp3Qbn76NJDgo+va9GSAxDF/qsLA9rS5PUnBsrAhf1wLfFeG8bGCJFlt+QBnkAIq1mlzgdOKcU3cnsIL0hz0BQJENIHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757435754; c=relaxed/simple;
	bh=cHOsjKxRXBKer0OgLaCcNyfxWLmesZOboqa1m5/d9NY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=f5p3tWdmy6gPOrvUrjcbW/S5qsK2aVTq7szAAj4hDGjYY+aRr0VOYJ3s1CH4l/I+D0Xt4X+tUBDWfiwCt5t5ppOZKUf3eeVyrgWxasvea06GU5adJiNFe4MohWBoDonBGXBYR3TOYqgbvd/6XgrXk0pDFl3UCOLxwI0fI1xSTtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=G5xyJlHj; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="G5xyJlHj"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3f663c571ffso60177905ab.1
        for <linux-block@vger.kernel.org>; Tue, 09 Sep 2025 09:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1757435752; x=1758040552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=azaY819Deh5pUbCRAwMj+JkZb7rn9xmL1tkkd8jfW24=;
        b=G5xyJlHj79VrS4SLXhfYWQh50hdoIegqj82k0ttSb97yUHDpkWu3pNDywV5mikxxyk
         c2Suh6tNiDgPQeTO3MqJ73WOrnM+llqEw3rwwiW2LUkJ8VslIDfn1XC5Q+55oeZpIDIz
         4dM1m3mr9UVhPiIaTko+hM4ERP/HpaIFiaPMVfauTPv80trB+FvsdnOh9rMCfO2jkZgi
         aPBKnvud1jMKhX3yJVm0B9hBtJ5pWTup8tyjYkYGsvmRxgQ1XfWQAxfLdxfQwQjvREKZ
         +AHwKGWFnzrWprUcb+/PxZKRYVe5nX7ftoT9Z0m6TBhieJdPDaGt2VNLM54+9sTLLEyf
         bWTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757435752; x=1758040552;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=azaY819Deh5pUbCRAwMj+JkZb7rn9xmL1tkkd8jfW24=;
        b=F4RuD45NMxYB/XQdXsit43KbUcKMef47ctJfERNOC978vmwmnYIp/YttLZVmm339hl
         s0CrFz9wQPiaXf4ll/wKUqxSHTdzM2B3vAGG1FDhDfbnjtDKA+bzqjwSFI16vYChuPEH
         N7xQJCKcrysN2AyLwCcij8JlO0BDA4ceu2I0rv517RN8wIZEEnETWcOjx99kT25MI57r
         ibgA6pP7aLeWs1LOdwhgG3/+1whNQedeHhiXOpBcueMGomDBjIGcTIiPPjVEwXxklsbe
         wCMkJHRcXS8nyGvd0nkUiOAbFcXXK78Ax2V6RjirXfGvCQLDdBJUPTROXvbu8zsucsSp
         p/YA==
X-Gm-Message-State: AOJu0Yy6FmCScSTJCmV9onoYyibrVqGioZ3RPhpAw+m3DYgQ/zghpAen
	3QOigBJbxgZgwWmNFbJ9b7oyiCXUvquUYfELC7iL2t1gT+GuTNjyL+POQ7Q40kz+xp24AfeORsz
	jAcCC
X-Gm-Gg: ASbGnctGnM+wv/Y0MNvinhi9j+NI+d2vhBs16oTbck/59jd2hEMeFoqBUkR2ttG5FK1
	Ha2wbNE/V3KjOA9rbfw9weayl+Df/MFry5jlt8oP5VKEzW5T9jGMF/fp8TpLO4MNqOF85r9VVXM
	/JPOhhDk47SuTORe/biTxMxOyXAOZZguj7cPsvIl7FyGW1YTI6YdpJdY7eZDTGjaUMAjFnOo2ri
	2x7daR9pvpEBeEwhltiCJwJQUUspZ2S5vBmnFD3rQRNIouHI5VUO35sbfZgJGTrFIueiyJSBXpD
	Pt+jownkKWi/RAM8gCOqXcNocZ0xM4ngbxASo3qBQ6T/l2U7gaLBAIqA9n9/GAy15B3OK37n05U
	uzjT/g7CIoJfSUQ==
X-Google-Smtp-Source: AGHT+IG1zg6oATQHP0eeaq/wYWBcuVXnvSltFI3aE5ecyguQfrwrGPn0865GKjPXMogjDW+mtYZcsA==
X-Received: by 2002:a05:6e02:17cc:b0:405:b792:32dd with SMTP id e9e14a558f8ab-405b79233b5mr107028745ab.16.1757435751532;
        Tue, 09 Sep 2025 09:35:51 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50d8f31cc4esm9921243173.50.2025.09.09.09.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 09:35:51 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 Keith Busch <kbusch@meta.com>
Cc: hch@lst.de, martin.petersen@oracle.com, leon@kernel.org, 
 Keith Busch <kbusch@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
In-Reply-To: <20250903193317.3185435-1-kbusch@meta.com>
References: <20250903193317.3185435-1-kbusch@meta.com>
Subject: Re: [PATCHv3 0/2] blk-mq-dma: p2p cleanups and integrity fixup
Message-Id: <175743575084.122061.9156524850167958252.b4-ty@kernel.dk>
Date: Tue, 09 Sep 2025 10:35:50 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Wed, 03 Sep 2025 12:33:15 -0700, Keith Busch wrote:
> This series moves the p2p dma tracking from the caller to the block
> layer, and makes it possible to actually use p2p for metadata payloads.
> 
> v2 had a mistake when CONFIG_BLK_DEV_INTEGRITY was not enabled, and this
> update fixes that.
> 
> Keith Busch (2):
>   blk-integrity: enable p2p source and destination
>   blk-mq-dma: bring back p2p request flags
> 
> [...]

Applied, thanks!

[1/2] blk-integrity: enable p2p source and destination
      commit: 05ceea5d3ec9a1b1d6858ffd4739fdb0ed1b8eaf
[2/2] blk-mq-dma: bring back p2p request flags
      commit: d57447ffb5fadffdba920f2fb933296fb6c5ff57

Best regards,
-- 
Jens Axboe



