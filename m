Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FD97462
	for <linux-block@vger.kernel.org>; Sun, 23 Jun 2024 01:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719106658; cv=none; b=geH9pSdfdoQytEle28bHpDYAjsjsduY9osPdlOdnXDYF0/2DaeGoKENc4RB65orMxJdwlw4UIb+K+iINmSlbx4l+5pb+t94sRv4vhIHRajnDRnsVz0Zllep7jpTGbui40YlNU7/dsoYvMdVtl7/ZcSlh0elIFRqmFSpeSlJZako=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719106658; c=relaxed/simple;
	bh=D1sfuQFlXtVLKm0+GBHs0ovkL3CcJ6Yc6UB4cc/TbY0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AJymgymJENXUtPApZ8P0dhpbPD1WgUU/qPQZxst6JFwVakvkWh4qT0ZoYtvo+PhfCQOtItFy7a2/0yxf/j7BMt5q8ETth2EI8ETdiIe3PMWqyVSXV8jwVVodbTztYZwg8shgygmv7BOeybVFfPDmZ4VE6Zt8zU+2l2wrVIsX1P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=qj/kQw5b; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="qj/kQw5b"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f9c2640730so730525ad.3
        for <linux-block@vger.kernel.org>; Sat, 22 Jun 2024 18:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1719106654; x=1719711454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T/mY0MTkt4mqINDs5K7H2z5PLsmRtojkaTglOL72hBc=;
        b=qj/kQw5b7xfJcLRZf8fzWeNyxUI89xRG17Rcyj9O7oa4/f0/IKlSYvD5veBZi6uIIj
         VMphEPzVCIHnaG5DFyyAPB+yQT7F8ZXt3wE1SJPhrha+hhL8RTlECN4vohtbN0QSbXwP
         HuD9qGdlHeagLqDlAVp88wRMUXMvjVs6HztTjNaMxD6y8rrINb0M6hSvg39MLvFs9LNa
         V76WwuY9uxwmgWaXHHMup/2yDQi2z/u32UqlUb5VWnAwFhZlbeEn3VnY+pupZi4Pxrct
         /ZvF4Cf3JuuFYPGYuk7UL2FbCHXT+5Aox+pNDWPwwH2NzDXhEx0TGbx0STofh9bi0Tjp
         P/Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719106654; x=1719711454;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T/mY0MTkt4mqINDs5K7H2z5PLsmRtojkaTglOL72hBc=;
        b=aR/xR5RTIij64zx8sXj5p2reY/5pfzRLWdI1oCFs/7ig1jryVct3boxmKnzLU+T+S7
         piF1fHqMUPZ8WbSn4wjTLfpb2JseJHkbaazlFDeWynXGGCBKAPCqZi2WNqYgwEFSwLmf
         Uctp5KvVlQPqnNsq+vtNT6q6FzBCAg8C5tCfZ0nCFFgWEyo8uBtq5Uu4UOuBnE3yOH1Q
         Z2GRmaSAGWqDNuyZYfPnnGZmw3w4sp77zsnWKDoKROJlR5ym6W3jaY0cH9j8tj7TNLVn
         e7UljGHcsg1RG/MwnLIN/PjNmyrW10Gr1wY2lcQxOf/pjkDCYdy2Kv3xqm6S6f8Zsl7J
         +Vjg==
X-Gm-Message-State: AOJu0YxSTtdUoFs2LyJhATLlG4nmnPZU0exVSwuYLTTmUV6D9xc90d34
	OrVK8PdRRhwKE2o+jFRocbOVDM+8J4EkxkkqcdvynfgbSqEB1a7DKcy8kvYoVenL8rTluqxdP1e
	p
X-Google-Smtp-Source: AGHT+IF8itcWU0dNvjzKokVnBcx0eFMhE9Nh0p/yKPEmIWDKL9W5rKRTDb1CM+4vz5so9TWepBIsOg==
X-Received: by 2002:a17:903:234a:b0:1f9:b35f:65dc with SMTP id d9443c01a7336-1fa0d832226mr30587775ad.6.1719106654274;
        Sat, 22 Jun 2024 18:37:34 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fa044a3fb3sm22976795ad.271.2024.06.22.18.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jun 2024 18:37:33 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Phillip Potter <phil@philpotter.co.uk>
Cc: linux-block@vger.kernel.org
In-Reply-To: <20240601221816.136977-2-phil@philpotter.co.uk>
References: <20240601221816.136977-1-phil@philpotter.co.uk>
 <20240601221816.136977-2-phil@philpotter.co.uk>
Subject: Re: [PATCH 1/1] cdrom: Add missing MODULE_DESCRIPTION()
Message-Id: <171910665328.191393.8296424421130440904.b4-ty@kernel.dk>
Date: Sat, 22 Jun 2024 19:37:33 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0


On Sat, 01 Jun 2024 23:18:16 +0100, Phillip Potter wrote:
> make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cdrom/cdrom.o
> 
> Add the missing MODULE_DESCRIPTION() macro invocation.
> 
> 

Applied, thanks!

[1/1] cdrom: Add missing MODULE_DESCRIPTION()
      commit: 85f86c5ede7697162c54744258908e657e456f57

Best regards,
-- 
Jens Axboe



