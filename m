Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EE323182D
	for <linux-block@vger.kernel.org>; Thu, 27 Nov 2025 01:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764208260; cv=none; b=OZ5QJYYg4z4+a0N8BVV2huiEXuNgrwRE3YqBC54b8FH85xF6Z1rgQJLT2HP7HEaPFNmh1dhMgB11wcZpeCmugoTtJHnBGwcxzFlMsOKerVh3sq/m773ua4WhuoVEdQbgDUh60+WoDxNaq2LwXBZlSFdeRGhxsKlj3979UhJkcWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764208260; c=relaxed/simple;
	bh=MZSEKfmMnHlvurFNv95j0nac1t3VXpKhhn5h8/GbAks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BWycVT8rWPSJEz+MFMZcbjjD2apk6664RhuOz0IyttK5KCZD00aZG1hzAjLCcAc6aZXV8oXJMM561x0L4C8XQaguu1LhfH53OUONBKB7/SdvReL6k5xn7VRx8HyeJChdMUpXLSjaZcyNRRk1bfwN0wKabhmQDspwJWloqxfJyik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DabOXUtr; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=opR6MaBh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DabOXUtr";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="opR6MaBh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764208257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lElirKkQwj+Wul4u5PQgf1fM9iGLm4BTJoRcqUrjCBA=;
	b=DabOXUtrqj5qiIq0a6CDpPOyI8mx2CRGzLH1fNHS+kZX9wS4C4WjS04iPgbiu+dZOzPYIO
	XXbB3B8CmyqOzk9yMpqG1h6nmg23Vgx6ChS/0Sqa6TpTE8kU7FLyp2Bs6Oz/FyV5IbnHt8
	u3nqbo6mlofiS86AqqKNGrNA4WWeHJA=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-z4FK5u93OTizn0eVfw7VFA-1; Wed, 26 Nov 2025 20:50:55 -0500
X-MC-Unique: z4FK5u93OTizn0eVfw7VFA-1
X-Mimecast-MFC-AGG-ID: z4FK5u93OTizn0eVfw7VFA_1764208255
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-5dfc0924912so101485137.0
        for <linux-block@vger.kernel.org>; Wed, 26 Nov 2025 17:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764208255; x=1764813055; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lElirKkQwj+Wul4u5PQgf1fM9iGLm4BTJoRcqUrjCBA=;
        b=opR6MaBh17Br1pfklhYDF9ytB0waDQQJD3I9bDZsdnrMwvz3wFoFIaLHbLbRVT/BKC
         w32zRBPpZ+XiNzn1XWb3ak8nor1ctq4h/zwpDl0/WzAuPcAgdUFl96Q8fZrRTEbah/OB
         2yjddZhOCc5Lcz82cGf2eEQhS5EiKvfqrW2ZypVfLNC5WzxKgzF21hsjFlUiHXv0FOS1
         37L+hyX1Nlodi9iVSyzEIHDeJLkWR60t80h1U34z6W+a+9t0Fi+LSZxPMb7ESRi628dJ
         8/+Fuh5GEvdCoM0MEK0B+SaeaixMi1UoEimxkUf042JLYOnAhaF1bkYOqcUSfr7G6g6U
         vRBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764208255; x=1764813055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lElirKkQwj+Wul4u5PQgf1fM9iGLm4BTJoRcqUrjCBA=;
        b=enq9QpTqSX8P6fe/Eaii5+d+bxppc3ShUh4Gf6a7vRCSX3CTl+3LYDN16h4Hcz8jYf
         SILELqVrh4qJLfT9ChRMcf/5ajrAF4njqQxxbjs0K88mSlz0oDSGvzMDLVKqpy5JUYsR
         DDGnfvOMO2/pNCsRDryF74tRUoqDNndb/5zmfxjVCjDCdcMjbqmGPwyfchikOZed4owf
         oZ1MumD8ybtDBkc0PMuLHeM2wjCKZQHN2z7JHwmUmFb5revSzgHtryCxXm9ZPV7Bi8RW
         QdWBJWUhluf9pncE9x3SfmeQ0/PS46bd8tiE69oQfACciBFY7lJGBq7n2CN/2fJ6Gbph
         4xBA==
X-Gm-Message-State: AOJu0YzuNVwnc2EWLxz1byv3JoFSvFPxQ501DrwXbzi5yRT3Ss8dFWwM
	L84EtMvLdm7r9gDeKivLJVsSj4bvHKDmioOpAA2xfAvOhtJkqIwRmx55BGSVkKl771/L3cax8O6
	k4VNzyxxR/BtpIDrUCUcAh8QHPGYuUHaMoCgRRgj5eTe0xc7/Vr2Y+oD3qlIVWIvzeig1zhvDMu
	Uleih14G9HB74Q0QUh3ghlo0xaVNEsMHcQ5XE1K6A=
X-Gm-Gg: ASbGncu7wQaMv4FRbUr+vB+R6+R1dw+K7WrO8t89mvPfAG3KqmS3RZsSOv4h3Q/WxBD
	qkd3lcEt4BNcIyzTwfLFgosFdc8Z2b+nb0mE9LO6FuZF4rPGpKwXWuTvsAN25vG0l9pw6c7wwTI
	qAhxbAEKfmTe8Ndp3C+F7bA/WERwpRPP0MqauzdB/HU0lIhSaHAGDl2MIsftG2v6ybp9c=
X-Received: by 2002:a05:6102:6b0b:b0:5b1:15:1986 with SMTP id ada2fe7eead31-5e2242748f5mr2649542137.15.1764208255025;
        Wed, 26 Nov 2025 17:50:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IENmpcTh4wDCxE84LmqPkItxz8pZAJxsuXPRgouCJK5CFKP+PTT/dz0R0byu4BRfkfKglb1D55svKVXD/jnEqI=
X-Received: by 2002:a05:6102:6b0b:b0:5b1:15:1986 with SMTP id
 ada2fe7eead31-5e2242748f5mr2649533137.15.1764208254640; Wed, 26 Nov 2025
 17:50:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126124835.1132852-1-kevin.brodsky@arm.com>
In-Reply-To: <20251126124835.1132852-1-kevin.brodsky@arm.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Thu, 27 Nov 2025 09:50:42 +0800
X-Gm-Features: AWmQ_bnM2vqgeC75A22rpJZjfN0spRMzKFAX-gIezPmONdN4WiOI1HdFmxM22pQ
Message-ID: <CAFj5m9J3KPtYkwUJjUiXBqK4t-5PRnZztHBiH5eS3yXmNhuBdw@mail.gmail.com>
Subject: Re: [PATCH] ublk: prevent invalid access with DEBUG
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ali Utku Selen <ali.utku.selen@arm.com>, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2025 at 8:49=E2=80=AFPM Kevin Brodsky <kevin.brodsky@arm.co=
m> wrote:
>
> ublk_ch_uring_cmd_local() may jump to the out label before
> initialising the io pointer. This will cause trouble if DEBUG is
> defined, because the pr_devel() call dereferences io. Clang reports:
>
> drivers/block/ublk_drv.c:2403:6: error: variable 'io' is used uninitializ=
ed whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
>  2403 |         if (tag >=3D ub->dev_info.queue_depth)
>       |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/block/ublk_drv.c:2492:32: note: uninitialized use occurs here
>  2492 |                         __func__, cmd_op, tag, ret, io->flags);
>       |
>
> Fix this by initialising io to NULL and checking it before
> dereferencing it.
>
> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
> ---
> Cc: Ali Utku Selen <ali.utku.selen@arm.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Jens Axboe <axboe@kernel.dk>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

