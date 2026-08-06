Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA72C39022B
	for <linux-block@vger.kernel.org>; Thu,  6 Aug 2026 14:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786025675; cv=none; b=TRNpI/6NVlH7WBpqKS/71LBWmzGb9u5yU5Tr4twUytTbcNdJB4Ya2zia/iPO2WPeNDKhX6NwpVpia78iyAxiXJoyZbW4LiOwRio7dgsPkkh4sqNEXLKLPixmVqew1rh8+De67H2UCH6EhdtRUkPd9qxNoTw0lMYLs2EKr4LX/64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786025675; c=relaxed/simple;
	bh=k89shtWZG3PmZqgVkzNtFWdlVRYC43lom7EmtnfML1s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Fb2Mh3mba0T3zpY7xOAnHu5WHMRrkHy9mfldLkxFHtYKS6zdeUJKTFaEh45MIJgIgONT2E9trqBB82IErrW42R6LEjyOuiwszsjkBVQazyvHvAtjuEenn/ZPBlu4LwqBpzD0Jj/JYuJ3kh+QAM5ZomItotPsdqAHB3SyOD0N0Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=Z/L0+Ofd; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="Z/L0+Ofd"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51bfa429aa6so6239561cf.0
        for <linux-block@vger.kernel.org>; Thu, 06 Aug 2026 07:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1786025671; x=1786630471; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lz/ain/HwZmKc61xBLitsuffKEvoWYLNaeOuRF6K5Gs=;
        b=Z/L0+Ofdnm9QnMlqDZ0lySSbbHvwpLVuFUrEwPeNjz9JhHSKC5fYMXX437HODQOp8S
         UK2FTshxVXkFUWTCcUz88If7ikNi57FfdlLi6d3g1GiWEMdwslCQ2kSg+Uiy8t6wVJgH
         +6+DL6PlcKuRFjEdopQlrhC4ctk9AgHNhe8bl64WTNuNX2bopg9DaWzhMSVFAwjgVetI
         0dDvN1wtx6unXC/G28QFA7kSQ82SbdYUbVUpFJh80hS3U0So0xEH/56xQ4IDiDw2jjvW
         n7DjH81h0PLnOfTSiU4AjrqWTwnKiO98EpKXt06yUi3/+WqVMxntGOJFg45Md/eULa/8
         H+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786025671; x=1786630471;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lz/ain/HwZmKc61xBLitsuffKEvoWYLNaeOuRF6K5Gs=;
        b=SSPedc6n2uKWCbZbcsLskorAvDoY88P/dlalA3pIp5Fo1Gxeu7OULjhSHWFHhr4LC+
         PGxklWZWrFCwlkO8Zw8x0sFdjAzrnv/355Wy+sorxGxCZrRWh6RAo2T8RrGFRWA12x6u
         f/qa9K0dCGj8zhk6wWQeCXiUskD70WUcYi98hVnORDPRJ1/WNjcnQdmh/chuxLoNCAHf
         uqn+/hdmTZ5xnMAP9kRvQt3eFQ84VtEjiOQ413qjWiecMyAQqfsywGPqKF+BmSdW0kEi
         09ONrYqdCXOjgwS06p5KOU+Pgd0BGJuCxVTmfEYhiW97riNqIdGMc62jT8L3OrWMarOn
         s89g==
X-Forwarded-Encrypted: i=1; AHgh+RprV4UMOH/ZAfbnTqn76mkMj9tJyBTroDQ8jBpKw+C0h9ow8P/3B4mHfJZI1IcGjwk5Fz6GhEQddlffnw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxIYQPuiczGzYDZ8Qn0cqINtjWBe4eRDnlXpSLHUeNRT610eBOv
	97oq5xE5ZUvOl2QfMUrLynWW6N2O7MXjaSm3uuje0Qe76W/hvY3Ov/LFOPePJKhuhzX0DWh0BIN
	N8IwvBbImDw==
X-Gm-Gg: AR+sD11JqOjashA8Qki8NApck86lfKPk90AaN8MK7d/oEdPR68mu3S1s5drnpoJmg31
	JwIEOVSAGTO+9Uvt0bfgBgYg/gVl/z0aUf5Upu/djh+vYZ/B2LaICJHqgqgESPxN/0qtvZScgEi
	bVxFzBMXIbmoHw8qeEvNASI1mlwUm3Xz2hKpDXsZMmvZndbHkTOeqzSwUYS0q0M2v5q9DrUhyQP
	+YsXLoZyMvpfmOZbPA0vRkHVUOgYzM7WME32Z/QpMwfG2t1B7QZa5zswbpmnpYsC0zKY01eOhYQ
	XIG9hjZKv3LsvRxdNhFDT+asen4bAgPYsKiiQ4L1MAhaW76/Qdy5hBQeEKtvazVX6BVomd/8cz/
	D2Q82fMQhD9Dhn/eOzfC2zrr4qsWisKkZdi2zM5n09m28O+tJDpDGstg/bVKP3Uxd3Z8kKamP5I
	uJD94AdQ3cBKu8+ivfVAjRdc/dg0Gcl14kL3WIcfU9gULFzMoauVbeN3wdAwQIMt3PJSXA1CkaA
	ydPvwsUF7tfNHH6v5NxaWIBwsIK/w6oAX3kAM54MRGvy8s=
X-Received: by 2002:a05:622a:11c7:b0:51c:4f35:81b8 with SMTP id d75a77b69052e-52d0039fafcmr38878621cf.7.1786025670556;
        Thu, 06 Aug 2026 07:14:30 -0700 (PDT)
Received: from [127.0.0.1] ([2605:59ca:42bb:f910:6d9f:8dfb:ae1:441b])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52ce8972e90sm38317191cf.27.2026.08.06.07.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 07:14:29 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Stefan Haberland <sth@linux.ibm.com>, 
 =?utf-8?q?Jan_H=C3=B6ppner?= <hoeppner@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-block@vger.kernel.org
In-Reply-To: <20260806130050.2057443-1-hca@linux.ibm.com>
References: <20260806130050.2057443-1-hca@linux.ibm.com>
Subject: Re: [PATCH 0/2] s390/block: Enable CONTEXT_ANALYSIS
Message-Id: <178602566921.2156166.6463069299091775817.b4-ty@b4>
Date: Thu, 06 Aug 2026 08:14:29 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Thu, 06 Aug 2026 15:00:48 +0200, Heiko Carstens wrote:
> Enable CONTEXT_ANALYSYS for drivers/s390/block.
> 
> Static code checking for acquiring and releasing locks used to be done
> with sparse. That was removed with [1] and replaced with a clang based
> approach [2]. The new approach requires that each subsystem needs to be
> explicitly enabled for checking.
> 
> [...]

Applied, thanks!

[1/2] s390/dasd: Add __context_unsafe() attribute to various functions
      commit: 11d4f5e69fe25bc76e27eca75b4ef6f7aae53214
[2/2] s390/block: Enable CONTEXT_ANALYSIS
      commit: 30df3ab3c92d0e7854c54df6ae66f4aa6eb5b3d2

Best regards,
-- 
Jens Axboe



