Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A6F199947
	for <linux-block@vger.kernel.org>; Mon, 25 Nov 2024 12:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732539431; cv=none; b=Roorsh0rydSfl8oOAPV+jjvLxjuryVvYqIS+1j7aFfPzlIXJxc0Q0Io/lAqTD45UdwYUPcBaL1clm4HzZxmwTkcLPKpVyr6KyKzfk7l+iRz/y4k1cnHRtDMk22T6Rr1h614G1WTLkY0biKkyqd3nQmA2Rfl32CEj+w29Pm/8yZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732539431; c=relaxed/simple;
	bh=WZuzBvqHJN0MOv2tHja27NlRZn0wiM51wx+X4Vb7BcM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pbinYgrlNQ5SxyrTnDHjXdJRbmRHJVXzS2L5czvfOXk0Q688eKbce+JQgd7d7O4ZwTD2ugyoUYxGgI15eJTiUEXnDxi+WQ81YTKn2f1dBwRxGqZW0hteInQ77+zmf0ow+ChVljuPLVHCy3Zs7HF2z1A+Y4lBIHBpFtS6n5DsEAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I300CLwz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I300CLwz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732539428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LQtxieVHWM9koiiuYBNm81cZWH/nCFoP0WhoMzOLjH0=;
	b=I300CLwzzeJyaT7bC6ZzDJM3sIY7GGCCK90i3LyYpUaQ9dpfAElfe7G0O6HqGTtm8QFttG
	EhrHBleEFwcaizXSFA/r5TjUt6jKwaOfAoH7tJNxOiWvm3shqTjnpiz07OAsRNMV2671Mr
	YpDcfVY+B5QdSrpp8YqzGkloIQHo0fc=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-eDKgbebKO9y1rtGEP7mVhQ-1; Mon, 25 Nov 2024 07:57:06 -0500
X-MC-Unique: eDKgbebKO9y1rtGEP7mVhQ-1
X-Mimecast-MFC-AGG-ID: eDKgbebKO9y1rtGEP7mVhQ
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2ffc44ab459so3752591fa.1
        for <linux-block@vger.kernel.org>; Mon, 25 Nov 2024 04:57:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732539425; x=1733144225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LQtxieVHWM9koiiuYBNm81cZWH/nCFoP0WhoMzOLjH0=;
        b=QPmf2dY+Udo9jU4ae+HvZiH0QxbDeMAVoc9D7ZySNoAzW8LyXWFh5d3bOTO2J29wEw
         V2uPpq2HATjEtfnumtlC+e9NfgyXTbKHBFKPlmcddkkr3xBVVgl46XorpKcpbsGAINW8
         4pvxgplaQL1Q0034rYkI+2jOlyZIssBOoCK9MFcRD24emMgku2BJrOAJ/v09rTs25iYa
         mr3CWmAheKLhhO3hNlSHnVryPUxrk03363vCPoVdOnBnjeW09WXUNK7Yx5gKW6dfv6zU
         5e7Wuo7DWxWDkHzttHI37A05/sQlrtJjFHKXCK38B0GG+AA8EpjHX3M50TPOTn/8Tv6i
         Rt1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXsnzS1t/+YsM1HqbE1Xj5XqTMt5S3XbdEB9u9YCJMOB/Gral/HXF6sRIaMcEt9II8j8sfHjBxSUmllng==@vger.kernel.org
X-Gm-Message-State: AOJu0YwnBT9i9a98CZyqiYAsnXiODp/0/0TPw3vleaa1i3PAy4ooJy87
	+p3LxtE2NDRJq4kB8NwhCdNIfchHg7OE4MfzLuqsG1RXsSka0MrLADrOQPzqPiICPgTz3Opikso
	LahVk65eQRGXLbjvwxMSU5bIpBt2UV1rgA6PDgHwpe5y7Se6jyZ7g8AAbBBLJrNuekFVqoxKi6S
	G66RJ6/RUL7ucrD6hdj7Zqi9a97DiQYRqjyTU=
X-Gm-Gg: ASbGncvvU3K1eb0eJRpnOisgkBr0J8/+zrIdok0YrhGpxQwyNu0sKiptSWTMC7q8aKS
	/1vxCapy0zSoSvODWkt9m9zkk8YHHy6SD
X-Received: by 2002:a2e:a902:0:b0:2ff:a4c6:b144 with SMTP id 38308e7fff4ca-2ffa7180014mr61759961fa.25.1732539425229;
        Mon, 25 Nov 2024 04:57:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFGoW36c4SyCt5Ts8vLHdgIannr8YCBy1YoI+9/Owz/30pylNnh+a/YieDIdSzpYFQ4KlSpF/uVJUK+vghkyPA=
X-Received: by 2002:a2e:a902:0:b0:2ff:a4c6:b144 with SMTP id
 38308e7fff4ca-2ffa7180014mr61759821fa.25.1732539424847; Mon, 25 Nov 2024
 04:57:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241124125628.2532658-1-nilay@linux.ibm.com>
In-Reply-To: <20241124125628.2532658-1-nilay@linux.ibm.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Mon, 25 Nov 2024 20:56:53 +0800
Message-ID: <CAHj4cs9EE0Ty0TVEF-ChV=fK_fghoigzCJmV1zNGJGBc2toEjg@mail.gmail.com>
Subject: Re: [PATCHv2] nvmet: use kzalloc instead of ZERO_PAGE in nvme_execute_identify_ns_nvm()
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, 
	kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@fb.com, 
	chaitanyak@nvidia.com, shinichiro.kawasaki@wdc.com, mlombard@redhat.com, 
	gjoyce@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the fix.

Tested-by: Yi Zhang <yi.zhang@redhat.com>

On Sun, Nov 24, 2024 at 8:57=E2=80=AFPM Nilay Shroff <nilay@linux.ibm.com> =
wrote:
>
> The nvme_execute_identify_ns_nvm function uses ZERO_PAGE for copying
> SG list with all zeros. As ZERO_PAGE would not necessarily return the
> virtual-address of the zero page, we need to first convert the page
> address to kernel virtual-address and then use it as source address
> for copying the data to SG list with all zeros. Using return address
> of ZERO_PAGE(0) as source address for copying data to SG list would
> fill the target buffer with random/garbage value and causes the
> undesired side effect.
>
> As other identify implemenations uses kzalloc for allocating a zero
> filled buffer, we decided use kzalloc for allocating a zero filled
> buffer in nvme_execute_identify_ns_nvm function and then use this
> buffer for copying all zeros to SG list buffers. So esentially, we
> now avoid using ZERO_PAGE.
>
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Fixes: 64a51080eaba ("nvmet: implement id ns for nvm command set")
> Link: https://lore.kernel.org/all/CAHj4cs8OVyxmn4XTvA=3Dy4uQ3qWpdw-x3M3FS=
UYr-KpE-nhaFEA@mail.gmail.com/
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
> Changes from v1:
>     - Use kzalloc instead of ZERO_PAGE() for allocating zero filled
>           buffer (Christoph Hellwing, Keith Busch)
>
>  drivers/nvme/target/admin-cmd.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-=
cmd.c
> index 934b401fbc2f..f92c5cb1a25b 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -901,13 +901,18 @@ static void nvmet_execute_identify_ctrl_nvm(struct =
nvmet_req *req)
>  static void nvme_execute_identify_ns_nvm(struct nvmet_req *req)
>  {
>         u16 status;
> +       struct nvme_id_ns_nvm *id;
>
>         status =3D nvmet_req_find_ns(req);
>         if (status)
>                 goto out;
>
> -       status =3D nvmet_copy_to_sgl(req, 0, ZERO_PAGE(0),
> -                                  NVME_IDENTIFY_DATA_SIZE);
> +       id =3D kzalloc(sizeof(*id), GFP_KERNEL);
> +       if (!id) {
> +               status =3D NVME_SC_INTERNAL;
> +               goto out;
> +       }
> +       status =3D nvmet_copy_to_sgl(req, 0, id, sizeof(*id));
>  out:
>         nvmet_req_complete(req, status);
>  }
> --
> 2.45.2
>


--=20
Best Regards,
  Yi Zhang

