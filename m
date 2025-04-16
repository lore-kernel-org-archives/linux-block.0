Received: from mail-io1-f104.google.com (mail-io1-f104.google.com [209.85.166.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8510218C32C
	for <linux-block@vger.kernel.org>; Wed, 16 Apr 2025 18:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744826920; cv=none; b=dt575eDW/iMoiNS+gu7Djo+DbPIX/pBFAY4F3KusHZ2LMCLCsp9Ucl7moMKXXARcYfspKY1KuaWVrSJEQdmEuXQkS/Iy8gLbbr41qsoPtmBHMZIL2SL8nvVZrufroncmNyGm10f3eyDCdQtvIXZYz9L0a8PjywYAvn3tycb9eOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744826920; c=relaxed/simple;
	bh=8OyViLUCHII16I1nEOvw8VBmdRPbm9PLpU/EteHs0ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PIUUrtAg1O9y+vSHbYcuAQj6XE/LAFIExUWP3Ug81eDUWtkAj+g20bbvXjB1YT4BQ0lOxDRoHj5WKIccMat03FT9Y1uQQJ2NoC2pggeiE2zzcUvkNhuxu5KwGzVHhHDRMmLst7iLpkJzFL95RYVGVtfdIieT/8JMHK7qG7RxeHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=M59+Bezv; arc=none smtp.client-ip=209.85.166.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="M59+Bezv"
Received: by mail-io1-f104.google.com with SMTP id ca18e2360f4ac-85de3e8d0adso147461239f.1
        for <linux-block@vger.kernel.org>; Wed, 16 Apr 2025 11:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1744826917; x=1745431717; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8OyViLUCHII16I1nEOvw8VBmdRPbm9PLpU/EteHs0ns=;
        b=M59+BezvZC4gDaLIcyIBZM4u8H+AGGT3MejdM6xRyKsRkHDHkn9PFB5h5ajInmOKkP
         dRDN2UF7DwiZvGv9rmflzrsbX/usY6Oi333rCH4meMkdxwVQnrUM3NKBNi1eLLAIl+Dm
         KjYDpMIz7Zot0ZA8T8P/0wmz4dRLKmfFE1K8IFot+4dko4XA9NF0GxXGnmTltNAcpx/T
         yU9ftSqj9PSJexAnUNaXOK2IsXw9e8uLncGb9W6i41GugjOSZcgXI7vqGIIsOxwrsLtC
         Sil3dK8Z517bF8gjUlp2UQLJv5Pg7c0NrLYRqamUPUqbOV4B65BFDCaVOoBNRk+heIYs
         OTaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744826917; x=1745431717;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8OyViLUCHII16I1nEOvw8VBmdRPbm9PLpU/EteHs0ns=;
        b=UL/qhNcxo7nKDq2oj4qHBUSddlHukdCw/LXNVdIfuR7HbkzaXTFmmX6r0cPRQnceb3
         d7yhNnAr6DwafUeh3sfS/UBohLtWuKgqP3JVV4oUY7fO02GmjI40Q2Y32yzgx+PuEVYn
         Yzf8+JYpkcvY9Tn5QzEkK/aEEk4L31UO6kxSqeGh2I7Kr2xymDs+8x0tvvhqqkDpo6Bn
         T16bo7QRiZqC541+vcLBLSEtjbcv2DedrhfQDTZuhEsEOxHJQxlob82nHxmdSB8OJ1mj
         ziIOrXqd+RVFns8FKZ1nk0baKOIRVLlOp9rV08RUZOTmUFRlqAIj5ynDPSdO0+N6Qz5W
         vguw==
X-Forwarded-Encrypted: i=1; AJvYcCU4T/RFAmi112TOvYLTSbGB+H0RRgBBa8VxAIWhedW7wvWiT4l0LObzVDeOurP82lj8DxXrjxx3xgo+aQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwLhWhvppi1okiQLPvkpmTJqBtAjLBeeM/m5sNne/No7b/flr1f
	sam3rXh0uzjKZjWTgKHfJFk1ffUliu5bgVmkIh80AMb9a/O9UBiEUUMDcEq380TPTaTc5eRCRMd
	HBt+cTstI0wlVksjF6tPnSkxadLAwWs7+d2POiCnbGIdU3RG+
X-Gm-Gg: ASbGncvcR/M8c8rN6otYXX9HYXikgsORKLFDy6liM5P2WCvnoTe6qHoGx12YXlckLfQ
	bRVP6rnlLA5KCofCZfkq9B+CIECInecVhG7vhs6OnzwPHWzm3wWtX9UkWFqKjSNEa1OdGlzSmqc
	A1QunoFXJKdZyowe2Rx1+0EtbnHf8rU0u+O3CX7aX62VMRmf21VGBLrsLFu05sStCR13S16mHN6
	qoXvbKj19iesSMh0oocWBszybbuGjTYvsCIja1nxzxiphRD5uEK1zCYWmIgCdPQ1ajw0Yok7nr+
	9+YYBDyvRjackT0Fniq3SVw+Eh9GjQw=
X-Google-Smtp-Source: AGHT+IHubmPMI3D+iMP9Z4MxiqL5kz//to5CHZZ6BvyWbGkfWWYz2Hn9RKWknQzdAstPB9lXS32dUwQB8QlU
X-Received: by 2002:a05:6e02:4904:b0:3d8:18f8:fae9 with SMTP id e9e14a558f8ab-3d818f8fd17mr16407925ab.6.1744826917459;
        Wed, 16 Apr 2025 11:08:37 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-4f505d18f83sm761090173.25.2025.04.16.11.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 11:08:37 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 41E4C34035E;
	Wed, 16 Apr 2025 12:08:36 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 357AFE40318; Wed, 16 Apr 2025 12:08:36 -0600 (MDT)
Date: Wed, 16 Apr 2025 12:08:36 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ublk: pass ubq, req, and io to ublk_commit_completion()
Message-ID: <Z//yJApTjXvfVnga@dev-ushankar.dev.purestorage.com>
References: <20250416171934.3632673-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416171934.3632673-1-csander@purestorage.com>

On Wed, Apr 16, 2025 at 11:19:33AM -0600, Caleb Sander Mateos wrote:
> __ublk_ch_uring_cmd() already computes struct ublk_queue *ubq,
> struct request *req, and struct ublk_io *io. Pass them to
> ublk_commit_completion() to avoid repeating the lookups.

I think this is rolled into https://lore.kernel.org/linux-block/20250415-ublk_task_per_io-v4-2-54210b91a46f@purestorage.com/

