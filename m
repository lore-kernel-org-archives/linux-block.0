Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940233C1D70
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 15:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785424701; cv=none; b=ipWEXk8p2SWKHpnwyQtN9cxhrbL/jyqX4u10peunBey50025FOHQcbvZW6TmXKQ4K8KbrUaqTyvMGkPKFX5yub7aa0gU791BULzZZcjt3IytIHywVvqgRbZC7OavEDDzbLoQsEP8enhWHDNk2W9pvf50jafYNPPhbnvpqFUJZJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785424701; c=relaxed/simple;
	bh=WQYZ0jRX0zeO9RPdXp27mMy+Z/RV671WJFI/dIseCnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kFZ9u5R7Ksm8zTGGspX8V3DdWE5Hz0DRTjdvXK9jU68tpjySp4SZHS5FWiAnJXH5NTDPQ3yIsT0rvx10j/PuH+aIiHDroEi/g6atPEeKwIlnkQmSgqjyQKJ+WiLMTNmTV/j+yNcqkjuZZsoYD6tmg3+p+5Ftvy3JXyN/AUI/6bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n6cg7XPV; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n6cg7XPV"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47f752b3423so1436963f8f.3
        for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 08:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785424698; x=1786029498; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4xubJdGIMIyB1Za5QMsHLEPZoFTDPQnDT99ep9CTLO8=;
        b=n6cg7XPVSYMPyOZ378g9t48IrQ0jbRzEibtnpjS7bSAnXmv/SjwIhf7gFO06OUaqKN
         IRu4vCckUMogD0n+W6cGvmFXWPgsF6d2qj9JdVTB6zRZCqsugL3lmxTd03GpJttz7l6k
         i6ypfuMX+/eJMw0x/+/OyVH9w4h1DXfSri8YjI8HOCTQiy6OA3pHg3Z7Ms/sLUT74w6K
         97Nh7yKJNEUgkAmgg574thoAZemJW6wZnPxW0CHAQBhlvmr4svPrvpNF2AS85C7cn6jI
         j6jiiacvAHja9D59q6U8YjLuiVvHjm6x10Ge9r/RHozI5nQPCrRApP4TJChh1WgIlpc3
         0LrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785424698; x=1786029498;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4xubJdGIMIyB1Za5QMsHLEPZoFTDPQnDT99ep9CTLO8=;
        b=XTsymTnVR+cHEdUBkfWRcqD5PuSkcSRbdI52/23sUewFfb/Q++r8QWmVftdzQWh/V9
         BUGmamtEsliWFaLgisTA8pO6xLd3vZuZUyKwFSanGSBSpV1DUEJd+yI+dKWt12s/0fa5
         xbqDCnYvLmkKprxbGUjcX76Bm4a9zMk7BFixapCN0KQOmIThISkOQNu/UsNdN76GMsrp
         QT5GRvu9z5mnxPVCAc//Nk4u/jCBQ2L2HTIdCM3nKvHy1Jl1x22PzX2akjYHCLyu80RB
         hwGi4Ftf95aEL4R2b1Ox4MzXk3keKuVW0Gxjeem7sUotWsRqpqkWd8epr2IdvdFUao+f
         ZtfA==
X-Forwarded-Encrypted: i=1; AHgh+RrakVkJ3D/dnkGckvep4clYhDSjbcjES/a4usxc/FFF4uZMU6FZiriGzGdgxyPxBaU0X9odvr93G3U6Ow==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg1/PkR27wRyRr39BQRblA10WqNBM9taROWiLgdGvEfQCqi2XI
	UIkmuUAfo8qR6Ox1rFOdR512NvZ3YFRFHnopg1qiQh7aFonB9+xoDnYfFqPYK2iz
X-Gm-Gg: AR+sD11N2pxEFC5Y1QQ3CMb0Ew/Vrk29pGU942GZrRKmeNIgrwEPSiM4iBHL6/g5I+C
	jJM/EBsoT1wWoaX8aeMMZJ+vixLjLUtOdCAND0N6+Z8NyoVJkSg3YnYeefUi+D4l7QCVLZYfXdE
	Kq5X6tzeTsunHiPY7X4tWqUMfdhDiCBlS+6ZKkIpzsXVLwM29q49QJUOGqtHVCi65iRDK5smJM+
	P9uRAfoTnB7gihyWK8e33/ZgXjOxoKrcZ3t58HsmYV/teozZ4oZ+dVRbu4xB32KEWEFTIOh1s3F
	Ni6dhtXsESTlqnTSyv7s+V16J3OsPpRc+obPC2w/88A/kaxwf3uWWO8MVfrORIDG36poMJlS6+d
	QNx3STI1/G5P9wkaVOoXw60Cs2qxlLNYugCEfUdibz8j2Scn5ePAgwtdHDuevyihMl/FSgvOZ6G
	H9NQ5A0KOaM0+DyrdwodfavGFNdUAH8d6CGLw/79djzYF2uGjtO5qIJ/0vw2/wARd4Gh0GyumiE
	bZKiXlY5wzV4xbkO1urVE0Tcd4lC6F28GvJcXfIWCJr6Ltig3QwRw==
X-Received: by 2002:a05:6000:2909:b0:47e:f3d:2b3 with SMTP id ffacd0b85a97d-47fc82028b9mr4314366f8f.39.1785424697916;
        Thu, 30 Jul 2026 08:18:17 -0700 (PDT)
Received: from fedora-laptop ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fc892cc3asm7766881f8f.23.2026.07.30.08.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 08:18:17 -0700 (PDT)
Date: Thu, 30 Jul 2026 10:17:43 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] ublk: lift need_map check out of ublk_{,un}map_io()
Message-ID: <amtrF4dFF1HImoMn@fedora-laptop>
References: <20260729012951.3744582-1-csander@purestorage.com>
 <20260729012951.3744582-7-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729012951.3744582-7-csander@purestorage.com>

On Tue, Jul 28, 2026 at 07:29:51PM -0600, Caleb Sander Mateos wrote:
> ublk_map_io() and ublk_unmap_io() are no-ops for ublk devices that
> enable user copy or zero copy. However, the implementation is a bit
> convoluted, returning the full request data length and relying on the
> caller to check the return value against the request length.
> UBLK_F_SHMEM_ZC recently added branches to skip the ublk_{,un}map_io()
> call for I/Os using a shared-memory buffer. This is a more logical place
> for the need_map check, so move it there from ublk_{,un}map_io().
> 
> Checking need_map early also avoids the expensive pointer-chasing for
> the ublk_iod_is_shmem_zc() check in __ublk_complete_rq() in the common
> case of a ublk device using user copy or zero copy.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <tom.leiming@gmail.com>

Thanks,
Ming
