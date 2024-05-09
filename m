Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76142149DE9
	for <linux-block@vger.kernel.org>; Thu,  9 May 2024 06:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715235330; cv=none; b=c3WdMjFmc/eWJ+ofney/hhSpzeMb/WvRzSie78t7q/yIUYqye3vnYqLZcuDt2Py4qs366I6eotR1gi3e82nJ/6BHPOpGrU5GS3wJavLZoms9BP2clLj70Uhf8dbm/Cbqjo/YqXQY/75pLzlPgx/PyMD/qzRe5qu5sK+Nl0qd4Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715235330; c=relaxed/simple;
	bh=/LJ3yhryClVUdRG/BWqc4cpjzzONjh+nbbHnfDzN2qM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gg9V3rbROza4flqe3MPLjLxicyaw6QmhETqfy3VhESVkeV7dSR1/fcpv91j9f5Tvwm5b04+fHmCzNSx5UxlUVJLm6FpTOYshdk6enLK3eKNAL/BMIVSDvX3R+fET5WlUnZEPd9QOnUIa/GTBeCEnQ6MS+fEmt4ON2a8BfRl9awM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IBeI8NyI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IBeI8NyI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715235321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J5tjZkb1xEbjulPOqAqbeWuJeVgKtzpvbp1WvlMGcxs=;
	b=IBeI8NyIpf5Q04YAV1hm+vFQgwif0jK1B+msvGbtlIuNwzAhk/FWrdoIQZFjLcI96FrRIT
	YTsxKFmC1lzP6tkZzSvODm1wMZNXEsOxZKt0eo3eIY3iSURH5ndPx6+FKB4jHbuVRCao2k
	TxnQwupwPuRB9efULwp6CzDK98Ffwko=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-hRpUlPpEM-WXEGNCrsKitA-1; Thu, 09 May 2024 02:15:19 -0400
X-MC-Unique: hRpUlPpEM-WXEGNCrsKitA-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-61cb5628620so546370a12.3
        for <linux-block@vger.kernel.org>; Wed, 08 May 2024 23:15:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715235317; x=1715840117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J5tjZkb1xEbjulPOqAqbeWuJeVgKtzpvbp1WvlMGcxs=;
        b=trKoR9PIsvJTxmi2+HvRhP3fhlx62ON4czsupasybwS1YeDidIGkNOoqEwdqngrbWH
         iWMDgNjKU2uMP9fI7To6arRXnqPO/4a2r4Jbiwalr6mrKECPIVE2fj01eIkPfMgYJbgF
         6LhPoxFBmEmaEZChsyTtu6MwKsE+ized8PY5eYzTlJTREdI00zILFUYcuffumDRYiUSD
         cGN7YWWnLkU5Ai4w/3+wEdUPbL1iSCHTDS2P/28Us0MlG/tB27ONP/oXKNRTpELjbzvM
         gxv0cXuHY4MAZDcf4kzQYuBtoY5mAcGBY0cDAN7eRTv2A7uXsO4xtFtCNq7oKdN6R9aC
         /YKA==
X-Forwarded-Encrypted: i=1; AJvYcCXv1+sw/4VyDY9xeOvwCM0+HN14e9+5OkFTF4mR194FOElEj2S9oS6mGiB0li7GULc0YuhrL/Z1HqctE4fREm+op00j0Y8baWnOolU=
X-Gm-Message-State: AOJu0YyGNLMykpvHE6VxMkqx5++PhOodIAd2fGh5JNVW5Rcred9BrqUE
	MJgC3GY8ePab/65l/ftk+1tEuDhI8SWbzK0vKu1C5xXTWFporjPNa6D8wITFNlogy0r7p7Yxfqw
	XlPpburMrFzDYWrhECcPE95gNqPqfe8Bd82A1ZFauWx22cZJwq/W/4DGg0vZDNPM5FVlgErtC3m
	ZNwR/0WLBvuA6ocjVKkD4HlaKP6wR2RWwfbpIDu/8DXjG8bJytdT4=
X-Received: by 2002:a05:6a21:3d83:b0:1af:ab0b:1c08 with SMTP id adf61e73a8af0-1afc8d9938amr5296197637.46.1715235316997;
        Wed, 08 May 2024 23:15:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6IvY4S7f3az5NCB7DGqMhZ5hgkvbcffBBogyGjcywqeE+OgeoXdE6dGWD2sKHFjk+USctmLniTam+uNy+Zn4=
X-Received: by 2002:a05:6a21:3d83:b0:1af:ab0b:1c08 with SMTP id
 adf61e73a8af0-1afc8d9938amr5296183637.46.1715235316629; Wed, 08 May 2024
 23:15:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHj4cs8X31NnOWGVLniT5OWBRtEphxw-AcYrPaygG_uYaoeENQ@mail.gmail.com>
 <dcc6150c-d632-4b14-9b0d-1b3b45fb5c24@wdc.com> <aded9da3-347a-4268-8190-6f39692ea8ee@nvidia.com>
 <25fd1c08-fe6a-48dc-874e-464b2b0e12e5@wdc.com> <CAHj4cs-h7Fi+G_aQiv-q4+ea4uki8Yiw6AHpWdZvaazg11Gd9Q@mail.gmail.com>
 <e229f273-e3ec-489c-bf89-0f985212c415@grimberg.me> <76c17ab2-b3a2-491c-a6b3-7bd39d6d5229@wdc.com>
 <1ceb71ce-c4fb-419a-8800-8ebbbe1706fe@grimberg.me> <87d1ac8a-df56-459d-a2f8-bcf940aa9e0b@nvidia.com>
In-Reply-To: <87d1ac8a-df56-459d-a2f8-bcf940aa9e0b@nvidia.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Thu, 9 May 2024 14:15:04 +0800
Message-ID: <CAHj4cs_+NaQ4eZQo1b8rRLsGPMgCKUyaOW8e5Rpi1AUW7vJ8rw@mail.gmail.com>
Subject: Re: [bug report] RIP: 0010:blk_flush_complete_seq+0x450/0x1060
 observed during blktests nvme/tcp nvme/012
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, 
	Damien Le Moal <dlemoal@kernel.org>, linux-block <linux-block@vger.kernel.org>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Confirmed the issue was fixed with this patch.
https://lore.kernel.org/linux-block/20240501110907.96950-9-dlemoal@kernel.o=
rg/

On Sat, May 4, 2024 at 5:14=E2=80=AFAM Chaitanya Kulkarni <chaitanyak@nvidi=
a.com> wrote:
>
>
> >> This is something Damien added to his patch series. I just wonder, why=
 I
> >> couldn't reproduce the failure, even with nvme-mpath enabled. I tried
> >> both nvme-tcp as well as nvme-loop without any problems.
> >
> > Not exactly sure.
> >
> >  From what I see blk_flush_complete_seq() will only call
> > blk_flush_restore_request() and
> > panic is for error !=3D 0. And if that is the case, any request with it=
s
> > bios stolen must panic.
> >
> > However, nvme-mpath always ends a stolen request with error =3D 0.
> >
> > Seems that there is code that may override the request error status in
> > flush_end_io() but I cannot
> > see it in the trace...
>
>
> I confirm that after several tries I cannot reproduced it either with
> and without multi-pathing, blktests is passing without any errors for
> both nvme-loop and nvme-tcp ....
>
> -ck
>
>


--=20
Best Regards,
  Yi Zhang

