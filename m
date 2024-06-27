Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BAD17837F
	for <linux-block@vger.kernel.org>; Thu, 27 Jun 2024 12:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719492914; cv=none; b=Hr4T+7Uue8aTTB3mu5Pm2LSEbGxZ+UhxXKbrqWPm3opiZqX3uRaDg0tiM7cqnIk3pm8NAwgu0XzIoNkzN62mYfNf54ALsbpljKok6SCMWMLQOsZoXBeEZb7+8cDP8T6PgFnjoCIb4EXDBgsWjBp+oP4Jjtkhe7ImmX1Z1ZBUVBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719492914; c=relaxed/simple;
	bh=BzKX2RCxsDLJwDXBUL4bY44QUlPMSz5TOWJt4YxUTco=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CKzo05bfa/V2ICjVWUr/q4QMnBFiShLo87rsIj5V5PS8sIp5OEpvY8oeMXCDFk93mdZyZ+dhQHJOKxZgA9C3VESyxhddSDzxkoEZQ3R4GO81Sr1LiW9X6Khnu4AzYLND9NvwOZv8bFKlXK6bPDaEcG+5QR9dShhbxaIqVaEeRXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=UcqrkKVj; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="UcqrkKVj"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-57d2fc03740so1793077a12.0
        for <linux-block@vger.kernel.org>; Thu, 27 Jun 2024 05:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1719492909; x=1720097709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KV2Jhus+OXpMif6WcrDI5bhMXm30qPlwZGq+tLeLlDc=;
        b=UcqrkKVjOWEZJ6GxNNy7P6WnxHTuxsf6xbSo6623QEarwmhcXWoetdaqMnn+uRVDIL
         MbyRRNeMZXnPk9vj76RaC5byfsogPf9cat7vq1tncm9ELE4k8PTaDMZNzr7tKZGOulTi
         nfEEOQTQNvjIICn+orMzy0Y6tdSA4wKyy+wD19fD0HixuwCtDpwpg5Qds6mgzdNq//3l
         DHOHGVnT6K/Y/pBNH5N4ZlBAXmub9MoJ7Z+WVFtOd1reWNq7Y7v6q24dgL3BvZjXP3mK
         aWngRafES5pyNX2onhK1KBObieJis6pER+FXftlcauA90EaMwrPxbu5n4V2AK0QewCiX
         vefA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719492909; x=1720097709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KV2Jhus+OXpMif6WcrDI5bhMXm30qPlwZGq+tLeLlDc=;
        b=AxFPUIf+Rx8cl0F58H+FWVl4tqtQpJsSYAU3qeEugjBMAUmXNM+1ec2PqBviW3+k1A
         NDaeDPNiFBNAdqqhSDXHgQYkN5rKUJTi3JVqgQKypUfZOUa9Us3ZVSSulCbCRSQktCRX
         NgCst+FSCdlFUXPJgv0Q6OkJVHq/Pq49MaR93l1iVJcba4PFm5LULXpiZ91rasmonH0i
         Br+iJU+Ic0HhiZRJlarv5jWmf/dSQa/kLIZ13tN5JPHQhK0NrBa9l57ggPmXT39BRpFF
         hWP8JvGHfrJxGDzXIeba9imByCAqSWbEaGzxkkXnNqRvosv2sgDGKTHJVIAteU/HmSfs
         xz/A==
X-Forwarded-Encrypted: i=1; AJvYcCV9vGL3yW4RtHQirySW9FdDEmuB0wisP18R28CgSNaGv/i0LkBYPNwBQA+QyFaJfBzp3pbISLZ9ObqZh+AKvQHuoXNZ+XUvsdlL0Po=
X-Gm-Message-State: AOJu0YxI5WMxVEZIMhPkTM+fRTGN68OrRe6xJKUHoR9+QtAQM0xsogUS
	BD2g5ROWRh4nDaOs53Z0Ga1YdqLCrdXFRRrgSF+PMdgvrk3LUDKI56Sh3++YzfyBteGabf2kmto
	1ZwF+AnGJKOdZlZErjSW6COLU6VNAkSAs2XJn4Q==
X-Google-Smtp-Source: AGHT+IEwk5RD6nihuxTjJ8SQtviL0Wb0/3Jiu4h/ED2HVymctlWOu2V2rnNzMu7+f2Uvx90KsSu2i2wMUPyMVmkskW0=
X-Received: by 2002:a50:9e29:0:b0:57c:6767:e841 with SMTP id
 4fb4d7f45d1cf-57d4bd71015mr8596646a12.13.1719492909356; Thu, 27 Jun 2024
 05:55:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627124926.512662-1-hch@lst.de> <20240627124926.512662-5-hch@lst.de>
In-Reply-To: <20240627124926.512662-5-hch@lst.de>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Thu, 27 Jun 2024 14:54:58 +0200
Message-ID: <CAMGffEm+8fD-GPwQMHyaDh6+mF7fG97YqYj5VF7i+svu75wJhQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] rnbd: don't set QUEUE_FLAG_SAME_COMP
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>, 
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>, Kashyap Desai <kashyap.desai@broadcom.com>, 
	Sumit Saxena <sumit.saxena@broadcom.com>, 
	Shivasharan S <shivasharan.srikanteshwara@broadcom.com>, 
	Chandrakanth patil <chandrakanth.patil@broadcom.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Sathya Prakash <sathya.prakash@broadcom.com>, 
	Sreekanth Reddy <sreekanth.reddy@broadcom.com>, 
	Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>, linux-block@vger.kernel.org, 
	megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org, 
	MPT-FusionLinux.pdl@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 2:49=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> QUEUE_FLAG_SAME_COMP is already set by default.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

 Acked-by: Jack Wang <jinpu.wang@ionos.com>
Thx!
>
> ---
>  drivers/block/rnbd/rnbd-clt.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.=
c
> index 4918b0f68b46cd..0e3773fe479706 100644
> --- a/drivers/block/rnbd/rnbd-clt.c
> +++ b/drivers/block/rnbd/rnbd-clt.c
> @@ -1397,7 +1397,6 @@ static int rnbd_client_setup_device(struct rnbd_clt=
_dev *dev,
>         dev->queue =3D dev->gd->queue;
>         rnbd_init_mq_hw_queues(dev);
>
> -       blk_queue_flag_set(QUEUE_FLAG_SAME_COMP, dev->queue);
>         blk_queue_flag_set(QUEUE_FLAG_SAME_FORCE, dev->queue);
>         return rnbd_clt_setup_gen_disk(dev, rsp, idx);
>  }
> --
> 2.43.0
>
