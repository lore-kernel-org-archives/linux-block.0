Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43426279DC2
	for <linux-block@vger.kernel.org>; Mon, 24 Aug 2026 13:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787578277; cv=none; b=eaZkE2qE1HK2MS6+Oyz3fT6pD1gnSaIAVXevh7Tmsnfx17ZkITeefTAxPm0PIL/XDCrn9w/sFGsfkMZBowP/d8SLC6VpLxWVPieNOvMkrDXPwcxD+v+SBuLx2j0z4dm8gTwqOxt7cDqQ9Lge5RFJMTl3PQ+oBe3HickZ0oJ79cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787578277; c=relaxed/simple;
	bh=uGg/m1YBOeJTowj4uybIy6jrf/stiCcAnS70kdk5Udc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ddqwLOWDR5ED1W/tkz0WDn+07Ce7aety1SRij9sjAdawtJR7DL5+SlenMOm6gHtGRhbnC05vJWZNgWHivhNZSxiNdvpTerDTuQYiRa6KkygIo0OR1OJIqFvZ8AdFSw0R2d7Ais9iDQ5eYEPs2CyIKbceJR5+5vZ/HBe/5jmV1RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IBeD2Ghu; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBeD2Ghu"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7eb5bdb50fcso3229357a34.1
        for <linux-block@vger.kernel.org>; Mon, 24 Aug 2026 06:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787578272; x=1788183072; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=y60jwkQhoD4s3eswGlcI736vrGSva62DV1OEGb13gfY=;
        b=IBeD2GhuMv+wZ4tp5hrIbamZda45IfxUCzStv5gTB+BxmKE+5dMkfIzmb5/qxTkyr0
         djPAt7CQ1PcM0D/jdtwWpjtvYsgokGjb993nsYnBq8hUBZV2pLHz58GxyGWq7Dl3VaKO
         XM9xFN0no+U/vcBceyEvunzz1Vrt8uZfid7xU3BLOp2rRQWeK72thoOtx3xQMwaYeWxC
         08pY0brQSNH4qu7o6QZgJ72wY/WWQqx5bWgGIxfQC/dnuWYEVDsJXDc7BIW5wwPh7BzH
         1uggRCVLgiis+2ed9gmjeHRLsrifJjkQTy4Wme7nt8aYo+DXGJbMfVe8laPXt+edroad
         bJ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787578272; x=1788183072;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y60jwkQhoD4s3eswGlcI736vrGSva62DV1OEGb13gfY=;
        b=G1zvJYA5E+Bg7oTG17csv5n9HnHg8vJO5iaNWXK19YBefZFNzZXJ4Zg2eXzziyS6KQ
         S/aCG9oC815g6gjvPqsbd42eZfqcGpNAiMiyn6IMqDRpCgQvftDFc+9j2jI8fGj6fIqv
         nqpWSyW57s/tPlBAZXQchJdndYdBE7ErWhhh5ZE6kvBgjuoFzNoVHdwmrwuEMrAq4Jmt
         eqJQ7439m9cF7keEf4Ciu0GmHxXJm+30RvLi9IuhrzNoWdV3HFTK1fJ86K8x5S6ov4XK
         fhd+NuvzrZ6vgUfKYp33cSPq58VD57ssWMN6jUHYRN3XS266z3G+4cgf/+p+qFk2Q6ZM
         0NaQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr/ExkhpmhIil26hFeWpvzWHW2GZxjl/ojBOJ+mNZrPhVXam3tH9L0Pl2PkHvXRLuTktYseLrmdi+hy8Q==@vger.kernel.org
X-Gm-Message-State: AFuF++kDV4o8nRamVVHvD3Yq+l2+18yVuNrkioFP5DJ/zaFOVGNmcSLi
	MSpkCBMUr3Cs3sk4Sc+NpBDMkTbXXmEhA99IshVU+JRYka0vKuOVuAas
X-Gm-Gg: AR+sD11iFJScLCBt6P0OJnRyfb8iv5HJpqgU2VWIcfLw1CH7VTH4IIGsm6x0uI73/R1
	3M0Wg6gugumbTTjiCAcCsktBczRyJBPI3tAi1DL1+0gZsPsgp6kFdrle3Zl6QzpBb4nK9rmVV0P
	YvReFu2EQaPyu64W4ztAAGf09Vmc8vvlyPGtU1wi2BDHw5T3wmXZOh16Wx9sBefVE5K5LC2xMgv
	1zBQrUH5s+j2FscaJoWu+o0LtdQVPlLkst1oLyihk4ogQvh1ZKK2c2pPJZrCJiFQa4gj0uM1XgE
	KPbSfA8pdoWGPN8X3kIA81gV++rIA1OdYyIZnLzF64cwWv1gln+fCzNFRZfWkaf0xF5wk/BXbY9
	/aQZhUq5j+wex/yzkeKjQ5f4GW8MYgPbXhuJx537UnvC+Qc8HEYZAYRjfVQlr7uSPmu5RYSER8P
	G0Mo+MPbkNXmBRAq4XlTVNRkweKeUa29wu20GxVEaVfY4B6EZtv65HbTsTP6HNkNLdXDbkXzO1q
	PW3E7eMgIT2zalSCs31UrPNd8OE1+XyK+vSLbVvRVHn7+c9Ig/kmxeprsdHs8yX8nGN6MvjUQ==
X-Received: by 2002:a05:6830:600d:b0:7df:5fc:3fd5 with SMTP id 46e09a7af769-7f461421249mr32340464a34.1.1787578272534;
        Mon, 24 Aug 2026 06:31:12 -0700 (PDT)
Received: from fedora-laptop ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f48fcb4fa2sm4207470a34.25.2026.08.24.06.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 06:31:11 -0700 (PDT)
Date: Mon, 24 Aug 2026 08:31:01 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Yang Xiuwei <yangxiuwei@kylinos.cn>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 0/2] ublk: fix force_abort leftover after quiesce recover
Message-ID: <aoxHlXhGrrFDN8SE@fedora-laptop>
References: <20260821103047.369522-1-yangxiuwei@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821103047.369522-1-yangxiuwei@kylinos.cn>

On Fri, Aug 21, 2026 at 06:30:45PM +0800, Yang Xiuwei wrote:
> Hi,
> 
> Quiesce on a batch device leaves ubq->force_abort set. Recovery does
> not clear it, so batch fetch fails with -ENODEV and the device stays
> QUIESCED.
> 
> Patch 1 clears force_abort in ublk_queue_reset_io_flags().
> Patch 2 adds -b coverage to recover_03.
> 
> Tested: recover_01, recover_03 (with and without -b).
> 
> Yang Xiuwei (2):
>   ublk: clear force_abort in ublk_queue_reset_io_flags()
>   selftests: ublk: add batch IO cases to recover_03

Reviewed-by: Ming Lei <tom.leiming@gmail.com>


Thanks,
Ming
