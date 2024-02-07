Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C5D134A6
	for <linux-block@vger.kernel.org>; Wed,  7 Feb 2024 03:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707276115; cv=none; b=IlP5JZa5lP/HT4DaDKLQlPEkBI7VvoUyNdrOIsbNSPwnrpw134WdwQ44Npl2Ddp6l9XlLa1uuiuh/SRLJoZXFE+4TIwi3wejIrrhb1USovGjPuITW+Y2JOhdppF4Y3+unxo0zCer3iSg4ChaRTSY4AqyTlfoPs3um73do8o6D2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707276115; c=relaxed/simple;
	bh=5pxzaNmMZc9+qSFaBDVXGxDHawGlWqY/JZ8hS8+iA/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nz6O5b8ZZVDKsCKajFp5GbrWpyZRmFflJUXoZGIPqUbAMVpWQchWEuwGYqoY8lYdcf8+UZYf9pCkiDmPpNDw5vcwwdpPiViJ5T3SkLH6nqUvABPEl9zncwpYDKffSaseVMSonPOyRA6zKiajzmRPAPltuH6bw14weEeNV34e0N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Hg5NaB+5; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Hg5NaB+5"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-296717ccc2aso1014638a91.1
        for <linux-block@vger.kernel.org>; Tue, 06 Feb 2024 19:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707276113; x=1707880913; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DvweSH+qaZmcX1cjz0FHPCeSe3ppOV6nsVuJOUHpS18=;
        b=Hg5NaB+5qH4U8XnMsCctozNra0lNjVsahf7j+AExLjJRv3Jr3e8IHJddILao0B7k/M
         dFvYG04kbDFIS9+W66nh0f9DSWet8Ji3JHlAGDLm0lDZdz+sIc8BvfDrbS0690Z206sy
         cVB4E0I/4pMVlao34Uo7kfsQalVDU1e9sqbcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707276113; x=1707880913;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DvweSH+qaZmcX1cjz0FHPCeSe3ppOV6nsVuJOUHpS18=;
        b=Hpu0c5wCKB4xmEb0oQFfQe4ARhL3Qv0Mlt1CiV/eVEdDl3uzYgsLzvp9bot96eYt1k
         6IzPlE2N1sMHlPVMBTEYsCNzxcnW7eL2IQFSuhttAGz+76nU/oUkPKoRcm+rsCYahtei
         /Yd34T35hpsm3Q7auhuhU2BFOJBZT4B/b6kzatRHzAszk20Kn+D3cZEBlUjwi5x8oRbn
         uzD0WEkCvhlSB6D7fyrmayn9LHF8VKB3Q+uL2yXYeetpOzeAP9ecgAXOFzdeoWcx72tF
         T3GIFdodFb6k0Rw0/+NfwDI37tpAptr91meJ1BClIv2MxO9LG45i2MMQ85x6jxH+fP4W
         sUQA==
X-Gm-Message-State: AOJu0Ywk+BNgGyAYp4ALJpOhaF6Ywa0ePnD/y1BnK/hsCLrvtC5rQr5V
	p4udwdZccKFwjfIXEseRhpGN9puNGW4Rk6916jENUGD+kfFMFiD4aErh9jp3sg==
X-Google-Smtp-Source: AGHT+IFJrrXprbZA+CjwH0Psh35AauMdJ0AuyLavTsMPHVZnSrSEAQq2gD2PzSdKXhnW3v8ZjxPsOg==
X-Received: by 2002:a17:90b:198e:b0:296:321c:9bdc with SMTP id mv14-20020a17090b198e00b00296321c9bdcmr1908930pjb.13.1707276113036;
        Tue, 06 Feb 2024 19:21:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW//AN5BX7VQ8JkwSzM/quJewDTXmLAecgV0tXzXipo0HobAr7UGghImrAeUePNCeTkSW877AftbHTzxouMh2hZCb0Aps8B+o7vF7E+0RJzp6ZskQqwfX08+JwR7fGVUp/UdkiGrv/jMCiBitpcn03LU1b/MFpWllH8GmlJ7mmibPQ9Kjob5vSx7Fo6kxfmJZhq+CI83bRzRqpysF9EFzwi5P+UcZOUnjq5O20Cv3OJXkj9CljVTxiYBdmAcJgCmugjn3m/r06oHyjtWebXgwW/RkBeNovY+Pc=
Received: from google.com ([2401:fa00:8f:203:679b:7168:b5c0:a415])
        by smtp.gmail.com with ESMTPSA id eu15-20020a17090af94f00b00296c9971348sm349487pjb.17.2024.02.06.19.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 19:21:52 -0800 (PST)
Date: Wed, 7 Feb 2024 12:21:48 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Barry Song <21cnbao@gmail.com>, Jens Axboe <axboe@kernel.dk>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Minchan Kim <minchan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	zhengtangquan@oppo.com, Barry Song <v-songbaohua@oppo.com>
Subject: Re: [PATCH v2] zram: easy the allocation of zcomp_strm's buffers
 through vmalloc
Message-ID: <20240207032148.GB489524@google.com>
References: <20240206202511.4799-1-21cnbao@gmail.com>
 <20240207014442.GI69174@google.com>
 <41226c84-e780-4408-b7d2-bd105f4834f5@kernel.dk>
 <20240207031447.GA489524@google.com>
 <79926b88-c1ef-4042-a871-61752d29c838@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79926b88-c1ef-4042-a871-61752d29c838@kernel.dk>

On (24/02/06 20:17), Jens Axboe wrote:
[..]
> >>> Minchan, if you have any objections, please chime in.
> >>
> >> Not Minchan, but I do have an issue with the title of the commit, it
> >> doesn't make any sense. Can the maintainer please re-write that to be
> >> something that is appropriate and actually describes what the patch
> >> does?
> > 
> > Thanks Jens. I fully agree, I requested a better commit message in
> > v1 feedback, we probably still can improve on this.
> > 
> > 
> > Something like this?
> > 
> > ---
> > 
> > zram: do not allocate physically contiguous strm buffers
> > 
> > Currently zram allocates 2 physically contigous pages per-CPU's
> > compression stream (we may have up to 3 streams per-CPU). Since
> > those buffers are per-CPU we allocate them from CPU hotplug path,
> > which may have higher risks of failed allocations on devices with
> > fragmented memory.
> > 
> > Switch to virtually contiguos allocations - crypto comp does not
> > seem impose requirements on compression working buffers to be
> > physically contiguous.
> 
> Yep, this is much better! Thanks.

Thanks.

Barry, can you please send v3 with the suggested subject and commit
message?
