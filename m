Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A244D3976A7
	for <linux-block@vger.kernel.org>; Thu, 14 May 2026 09:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778751422; cv=none; b=EAPDiiH4X1EiZ7OiNYdPDH3uqL5sRvS4cLBIa468J6OkfV59lOQJgUmDpJyDVlNNyow32z08Fqreudu04GgXeet+v4BpLsgMCzOZLplHUe+Ia9ks54cNSE+10cE6rhkYE45ByZL2turP0D0Ylq/fAybHyUH8X/EFTwSJrXgAphU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778751422; c=relaxed/simple;
	bh=XN1Y08zg1c/vHFKW689QAWB9RSwo74yJvQL3yg9ve8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SDMuN4zCD3l+a2EJp4EHMsRWLGlc7dBgnWbHWiOrm6/FlehzJnu80nDKB6JG5OJaIIYH1W7+wktaeioG8PXFRfmzgsgqZMgqem209eJ4pvgqr7dlPxmysX4E5z8BWw39yqJnZ2+rmO2bwsc48IrNafUFHpcL9SzSCsLlzPxNq+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B+xjFHgo; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+xjFHgo"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-47cbd444fd0so4972498b6e.2
        for <linux-block@vger.kernel.org>; Thu, 14 May 2026 02:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778751420; x=1779356220; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2DerFgBz6k83Qq7dtP6zw622SF3fHdfZj6SqqTvLKeU=;
        b=B+xjFHgo7JjIl8InvDeW5HV4u7RHpuG2EaJ0vcaCjtZzXtOjV5WJc4ikugvH73c+tN
         9LN9m955o4G267Pnu79OJSQJ6p1q/CDqA/n3kmcM4Ec0BdQhGoRQjhdkK44mjWHO1uDp
         fJOQ8hgVXNbTnwXdTekkKZ0pnC/jnNzgQpW/Q8q3gtfJgv5OS2IKTvOKprnRQwNtohRi
         JW5NIFKxGT6B7L5Q5/6oAUCVCx+EpayyduHOu6CgwwolQCQvlAkWxSbLgv2yLgbHwsHK
         DlfZhYW0N4nWEjBdWJI8kCol+Q8bYn7xbm2+W4Wbd1DPaTH8v1DPYgrKvvtgzVO4TY0y
         iS+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778751420; x=1779356220;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2DerFgBz6k83Qq7dtP6zw622SF3fHdfZj6SqqTvLKeU=;
        b=QqLp2DIHgabIyjSPXmuZqFP6lsXG4nT4iNmdH6FeOQCBAHv2VhweyTmNojkqRLGTUT
         sP8AfX33erRzXBQkBQ3uJV403PHXPWPLJTr08pg/i80BmUhbVmikb/1Nl55CtA34lEFp
         QkWt6KCHH8Q6mHds5lhWNawE8ZV0gfKiqJa5+yKCB/D8ticnUQFY+GVNiKszInAeb2hS
         kP93WwTL9vQjMWSB0P5d13snC+4XgtVl8SqGnvpqx7VkIb7ufVPget6r93svyZo0MoVT
         VyWqpSeIbYS8TE3/wroj7RJ1ZyBDd9c8HElusZjkGLdMph09l8oH6Typ3RqL3x2ZryOs
         Gn0w==
X-Forwarded-Encrypted: i=1; AFNElJ8ENfL8p3jN/ah5H86vG5WHMumS/+vbydi3+42/nUbD1HfMW7YpqNhZg+Z27Iq978r5r97swj9pc0rRgQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwPpqUpgNfwJKDbVfS7/bXjPVdgoiR+fg6LQnOpgtZhRGxSp7Kf
	tsiHzsUm3fUQfeHKKx2fw1F5jOtIdFo27P0JmdAFEC8dA8U5+qLbWN3V
X-Gm-Gg: Acq92OFTTMVaTGD7IvLHM9tNqO1NTjYF+NCJqmp56clfTgV6TbNfH71RJehvZ1xx+Il
	j3c6yAmyQrXAMVNdI3tZggCXuf5+WPBB6u4ib24pDoNFWReEVSgGoTbzuZD9Ix4fzv6sQYpLqZV
	cF+Ybk+K4FQFr3po+S16TjCrThRZ5wYF9NjOrSvQVLuglqoUIfw/Xml7b4roPUBCaSUJ2mdTJmA
	oT8RtUjqxQVLAHN+tg541oq7R2xEnGPt2bPb+utH1cDJUZm3YwMN/I+I2jwwfhthZzvVwWTdtc5
	TUIOrn3lD1NTDDOCq46kzv0IOt7gxHR+2SOBnqL/Q9BbxDaeeqQJ2J8+JdZaZMhpm4gX5Bi1hjh
	1eZfvxbFHdEJrrp7AnfdcE4WJH0RBNDRyjeeGD0SsEu2Qckp355wrYqmnsmjFLtR1ziVfe+v4qJ
	WhBOJYP7/5Ryu34S3ZwGYz8aeRnk8wuVfJQ4CgipPva7avNs1GpWFf6qdgJGsZyIpAFNQnznvAb
	36peC5WljCQr4yJzgR+jkVdyhbYCC79i8VRq+R3AQ==
X-Received: by 2002:a05:6820:4d06:b0:694:9f32:11 with SMTP id 006d021491bc7-69b7a9dd215mr3248558eaf.5.1778751420483;
        Thu, 14 May 2026 02:37:00 -0700 (PDT)
Received: from fedora ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69b8ca9a856sm910974eaf.9.2026.05.14.02.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 02:36:59 -0700 (PDT)
Date: Thu, 14 May 2026 17:36:55 +0800
From: Ming Lei <tom.leiming@gmail.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7.2 2/2] ublk: optimize ublk_rq_has_data()
Message-ID: <agWXt-gsA7KxX7Ci@fedora>
References: <20260513211846.1956810-1-csander@purestorage.com>
 <20260513211846.1956810-3-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513211846.1956810-3-csander@purestorage.com>

On Wed, May 13, 2026 at 03:18:46PM -0600, Caleb Sander Mateos wrote:
> ublk_rq_has_data() currently uses bio_has_data(), which involves 2
> indirections and several branches. Use blk_rq_has_data() instead to save
> an indirection and NULL check.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <tom.leiming@gmail.com>


Thanks,
Ming
