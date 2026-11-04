Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793832865;
	b=jGx8VfdzvJiAe5+2rl4RwjgTDB7BN+HUALdalZKvHn+pI+Qj2pktzDIfpDcMpEKT7l0d
	 I1XhNMCXdLTNUCAMfRs3UEAiUBMFlnqxQ7hy87UgQ51C9n0TJh62WVAr6XNcbm8BRuGM0
	 FnWp/kUZqcyYDuVVcIWhh6VG7XKHkUGuurcsKfdZNxtYysRs1VqYx4yO9znLJxH8W9v43
	 smLk6CGFuNSyVbKAIeLkIA3TOlgYB/mERE3GRM7BH9eWz2+jpqf9XiDd4pqM85otPBsdV
	 MWt8qfbAZRr51ZF5Gz+HjUddCvFuG5OVUnRLbei/S804xgK5WMGZTdUlyU+4Jcbqq8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793832865;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=ORn+lsJjXoHLPpvJz/SuX8WFL5k3oX7zpiKn62p+lV8=;
	b=q0VElr7CoOstA51NnKJX2W+zuGFXON3rDRdbT06FlMxQX5JdgJiyJQAPJAeTiY6c7dVt
	 KmV6BNT/h0hHh0/ymOHwK24xsF4lRjMpRkLwHVMfXmlOsHVxxEIlvrdmEklLUw3p2Wzcm
	 P02IrvJB6tgrzE0PaJikd6EIqjYIPX7CpeeR75eU8ZU3oIYKI/kgjntLJhVNTupi1lRRr
	 Vw7nTswPCWpKK9rrsUW8NDcclgvLrrjXpMS8TEvj2wmNUBW6fCwIJEl7y48KR2jj00Twx
	 jNWlEVGY6lNv+3Nd+JaXg1MOZAUY+3XDVaUWfA+ppEp6QlZVQ5hjYSvA3MKo4H+aVhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=philpotter.co.uk;
	spf=pass smtp.mailfrom=philpotter.co.uk;
	dkim=pass header.d=philpotter-co-uk.20260707.gappssmtp.com header.i=@philpotter-co-uk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Xf2JeQau;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B22606A329
	for <linux-block@vger.kernel.org>; Wed,  4 Nov 2026 22:54:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7B22606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=philpotter.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=philpotter-co-uk.20260707.gappssmtp.com header.i=@philpotter-co-uk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Xf2JeQau
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48b060ec084so802275f8f.0
        for <linux-block@vger.kernel.org>; Wed, 04 Nov 2026 14:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20260707.gappssmtp.com; s=20260707; t=1793832863; x=1794437663; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ORn+lsJjXoHLPpvJz/SuX8WFL5k3oX7zpiKn62p+lV8=;
        b=Xf2JeQauMqnsTgK8FoGw0SFXw3g8HbgpDcw0zP/bb7QPesVQRX7pzBr+pHAkHFVnTa
         CkxWEcG5FkWKU0IHwR5SfoKHMg1ciYKdxJ+O9/FbpDxZVuZzGebt+HrRe7JD9ObL1Pnu
         8tysy+NIIJI6oa2ryTg5v38dh6ferArLcmqcST9Tk0NZhxgYWwW3fLiR4YQ+PIQnRqGk
         4bgjlYoHwWdg2GKjJF+PUPhiTSR6EWnPSM0/2vlRANNcNSzUW3NeHLM9qrIFxv5EJRPk
         YpZSG6yLGPIX8YEHjTWr/YxPrFiqhodrNq34+vnKdLsHg3zdsR/thYUaN31pS0gm9gAj
         aAsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793832863; x=1794437663;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ORn+lsJjXoHLPpvJz/SuX8WFL5k3oX7zpiKn62p+lV8=;
        b=wI+bBeIgQ8SvQRYbASBQy9adoo6j5j4HMbVIgRmP7x4zXfm2SiLfcNOeo3zYJYmDLV
         Hhy9i0ZW9M4llujDcOA2r1OFZX9Wp4yz/b1LOKCATYReisW8QwqMjVEudc9CHLkCSkZv
         o402hi5piuR0bc5xb/F3iw5BG2SwEGihCouu4Ley54+0Wubpm4vmz8RG2GbWIgu2xQ5j
         HGpwtSQvCr9rDFDpDudSp8kJDLwSL2KktsRaB3Q6sPMZgKwb7aqkvKJw/g93MJDWEDDg
         xATPmL/eiDEW4skY3EWcNY9tpH7oHCa5G538Ih99hxSW/juqGtSPVfjhXkL6eaAXBjz1
         yZuA==
X-Forwarded-Encrypted: i=1; AKwUvBxfFOpmZfn5g+YAG83K9ft8d9AbqE1Jd+Cuad09lIYGmJpzXAplSUj24cfs6Ma63lb3h9flNh+gz0TtYg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8sdMXBvsaDQihoZWHfIaCbDhKU29I5CkzTH3FqQLhZoeHwWYOO
	4AaAIgnbwFRTOhusUmWS2XkBYN/XKSoo+5R61ceh0gCfGnoCi7Cdv+3kXBc/b3+YSMU=
X-Gm-Gg: AYBFou1OEyZ1HzxZOXPafDH+hzjV416daP4ij1s6JAH+gT+glDKiMeRtFP8cLJgV7tV
	rM5XSXrgIvx1xE0V6Zz3zK21ad9kDvvsHnAeqCIEGpf10Z4/W8tJrvpJn7JVw5CJrbMpmZ42bCH
	WCAC0hGIEt3x6ysSsQeyzpQavfdMKWvnU72MkCo9i2TQsY8VtRuULxayU1bEhVYLAZJzTO09qy7
	/wEaYvFSIx/4wffDTX9SrqO9pHlR4spw18tM8tabqjSW1OQNiVpjof47RYdYVILjlsnAq90i9JE
	KdKZKKtHTZtq13oEdlyGvC7s3q5zF2EzH9wup1Ry3DnsYQWzTpt0MGN8oYQ6Zfr4acQFGtVDUkT
	C/FPTGXXXGDmBMR++KjenaKsi2vmL5pjrZhinaXl0NfmExQzn0fKPDxQI1nhandsGI8ZRhrTswh
	xIDfUoIFsz9ApOuTgXMTNT52UGuG0VSpcKa0MAQ7J5538H4cueQRudW+tdWN0CPs15EiZ9Ldalt
	/Lw/SEhAqOT8QPmgWu1dkGGLoX8e41Lvk1fGkVaulKfOLMjLq9tzgSHbIucKUm0Z3iDOtFmTg==
X-Received: by 2002:a05:6000:4804:b0:48e:390:80cf with SMTP id ffacd0b85a97d-48e6e2fe070mr39241809f8f.32.1793832863228;
        Wed, 04 Nov 2026 14:54:23 -0800 (PST)
Received: from equinox ([2001:8b0:df16::2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fecac1caesm5848494f8f.17.2026.11.04.14.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 14:54:22 -0800 (PST)
Date: Wed, 4 Nov 2026 22:54:21 +0000
From: Phillip Potter <phil@philpotter.co.uk>
To: Manuel Ebner <manuelebner@mailbox.org>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/1] cdrom: fix brackets
Message-ID: <auu3nehR6aepSHLU@equinox>
References: <20260902183723.1584-1-phil@philpotter.co.uk>
 <20260902183723.1584-2-phil@philpotter.co.uk>
 <d57ee45e25cd429372298b1481a58c232d052569.camel@mailbox.org>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d57ee45e25cd429372298b1481a58c232d052569.camel@mailbox.org>

On Tue, Nov 03, 2026 at 02:40:56PM +0100, Manuel Ebner wrote:
> On Wed, 2026-09-02 at 19:37 +0100, Phillip Potter wrote:
> > From: Manuel Ebner <manuelebner@mailbox.org>
> > 
> > Fix missing ')' and add '()' to function.
> > 
> > Fixes: e327cfcb2542 ("docs: cdrom-standard.tex: convert from LaTeX to ReST")
> > Signed-off-by: Manuel Ebner <manuelebner@mailbox.org>
> > Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> > Tested-by: Randy Dunlap <rdunlap@infradead.org>
> > Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> 
> Can I do something to get this applied?
> 
> Thanks
>  Manuel
> 
> > ---
> >  Documentation/cdrom/cdrom-standard.rst | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/cdrom/cdrom-standard.rst b/Documentation/cdrom/cdrom-standard.rst
> > index b97a4e9b9bd3..b6dde1d1eaaa 100644
> > --- a/Documentation/cdrom/cdrom-standard.rst
> > +++ b/Documentation/cdrom/cdrom-standard.rst
> > @@ -1014,7 +1014,7 @@ How to update your driver
> >    just calls to the routines you adapted in the previous step.
> >  - You may remove all remaining memory checking code in the
> >    *audio_ioctl()* function that deals with audio commands (these are
> > -  listed in the second part of cdrom_ioctl_. There is no
> > +  listed in the second part of cdrom_ioctl()). There is no
> >    need for memory allocation either, so most *case*s in the *switch*
> >    statement look similar to::
> >

Hi Manuel,

Perhaps this has just dropped off the radar for Jens for whatever
reason, or was filtered or such like when I originally forwarded it on.

Jens, please can this be merged? Many thanks.

Regards,
Phil
