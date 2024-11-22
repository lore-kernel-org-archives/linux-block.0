Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEC6230987
	for <linux-block@vger.kernel.org>; Fri, 22 Nov 2024 05:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732253911; cv=none; b=I1ytPO/V6XE08Uu4SKHyO3mf641LTSteqK7urssMtK8xQKysM6X0Z8bXtHkVXQ1ZZRTGC6lrou/JBgSUUAgCRlX7P31skDgrnF6sRCh1ggOwpbGpDz4Udbipa76vbw7TnaBL75CFO+cR89xIFRaP0bP+ezEPFiCEdQ/5YTRC6yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732253911; c=relaxed/simple;
	bh=wya7JDkx436Rq24gS9/tOjCXKJu7Qe0tsjisOC19Ekc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JPJNXXS0PxDCHB91trRURwNexgd+7H2SPXHIenm6C7rGVpNjUM53Gj++sT2TKBmYCsptzQkSEwhrGJ48Jo37MEC3Gr20yc3x3P405wbtkQ79vascYcnRBWZdtaoJBrDpHlIyRogxCaXexO+b8hKuqQwfpD2mW1HLXWJTg48cUCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KRjUV3B5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KRjUV3B5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732253908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eqLIUso4tQH5JQgm1n9hufVV38KZMRy/YQqOEuyyBVo=;
	b=KRjUV3B5/7kwsPjoDeZlEzJPHyL76Ta0I1ePwCi2A1wAFb56RnuhCOocqWwm6H3bSv9p0t
	muT8l1KUrOq5tf6yDMjwb1UcL5QFGf91QZhntD2I/pbC+u5aYk4J67Y2VOV7e+yL/Ch+G3
	ruSfR1ri2KBcgsm54yGhyzeYzePzYMY=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-cESyWNlQPI2eApjzxea9mg-1; Fri, 22 Nov 2024 00:38:26 -0500
X-MC-Unique: cESyWNlQPI2eApjzxea9mg-1
X-Mimecast-MFC-AGG-ID: cESyWNlQPI2eApjzxea9mg
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2fb652f40f1so11337841fa.2
        for <linux-block@vger.kernel.org>; Thu, 21 Nov 2024 21:38:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732253903; x=1732858703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eqLIUso4tQH5JQgm1n9hufVV38KZMRy/YQqOEuyyBVo=;
        b=HvugGRXPQlFoiItLZat2fq6kYeT9Y5Ubi+ONdpPByk93yLYTMIRJiltwByOX+38k45
         Inaq464aE/cD2FdfHpGYklfOKOtSFoxSI/ksKh3w+ncn2yyoN+Cft9mMwbVE7MmlVTar
         q3de1Mwiu8NTZ2p/bjs94I0du8ACGMQhu3cQzMCj2xuHIOCcsKGQbBFtN5e/vuUQbEFk
         3lfVih7NiEj06ELZX5e3P7jlM7qZn5zLqRCU2FSY1C5nBY5IxZiV4DUnpK5+3KeVOQ9M
         TE2Hx6z4m972MlozaSEi0hHH/ddgtQMd3uS/szMmeQatyM/yv87c4Z8nAfY3ht6s/9HQ
         I1uQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6oZukrBeGq7944/hfkuQPI9+b4P+v2NzlDSdpYhtc+9jsi/IwMw4vZAtTlLjxg6CpDct8oQledV0/Pg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxY0nl6gPnqxD1qIQ4yZ2nguZXWIfTapJB/+Iy8fEnGlAGrHuCI
	zmzB5TsrPLYUTLnh1KTZYh+jPpBLyy+K6E8Y1BuTurTPfhEX5ypKry5w2jDJhlUOgUqTTOgBbFY
	6QZqorOWQMX5iiIWdSOP0tTQ+KoJabQ3fPKi5Y7fDbzo8aqQi74Td3Jb0E5GZGY8wlCQhrHcFoC
	gErUbHj8kIYYTWd/3t9JxiHiq6ZMKYrkjfju2J+f46X52SVg==
X-Gm-Gg: ASbGnctqgaYuBxk5tTVQV3SFMgDDEiI8LiYS2gnBk2SHIjrNfse4fgYMi4/o8Lrn6Nh
	9eQKkajmOSKn++5pqr30fpJZfk6Anw1NK
X-Received: by 2002:a2e:99cc:0:b0:2ff:a8e9:a648 with SMTP id 38308e7fff4ca-2ffa8e9a718mr1387131fa.9.1732253903182;
        Thu, 21 Nov 2024 21:38:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGyiHYbnShueV2QlXyoqutfmjwmFNVa31kdxiDclSeTsg/UZjBfpV4Xcv8hm7EQFaLHVWAq1LagBSGG3TA0lco=
X-Received: by 2002:a2e:99cc:0:b0:2ff:a8e9:a648 with SMTP id
 38308e7fff4ca-2ffa8e9a718mr1387101fa.9.1732253902828; Thu, 21 Nov 2024
 21:38:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHj4cs8OVyxmn4XTvA=y4uQ3qWpdw-x3M3FSUYr-KpE-nhaFEA@mail.gmail.com>
 <7f35cbe9-9e12-498b-b46a-be1f570772fc@linux.ibm.com> <CAHj4cs91daKS2Sexvs3y_m=r=+a+gJdk9=Z+76TdsE6=0nNcYg@mail.gmail.com>
 <9ea5ac64-283c-40e6-a70d-285b81c55c06@linux.ibm.com>
In-Reply-To: <9ea5ac64-283c-40e6-a70d-285b81c55c06@linux.ibm.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Fri, 22 Nov 2024 13:38:11 +0800
Message-ID: <CAHj4cs_nbdbzo_Rc+LDp9NS_Ffi1FTmk-9XKw-6TAav9LM4__Q@mail.gmail.com>
Subject: Re: [bug report][regression] blktests nvme/029 failed on latest linux-block/for-next
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, 
	linux-block <linux-block@vger.kernel.org>, Keith Busch <kbusch@kernel.org>, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Maurizio Lombardi <mlombard@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 7:10=E2=80=AFPM Nilay Shroff <nilay@linux.ibm.com> =
wrote:
>
>
>
> On 11/21/24 08:28, Yi Zhang wrote:
> > On Wed, Nov 20, 2024 at 10:07=E2=80=AFPM Nilay Shroff <nilay@linux.ibm.=
com> wrote:
> >>
> >>
> >>
> >> On 11/19/24 16:34, Yi Zhang wrote:
> >>> Hello
> >>>
> >>> CKI recently reported the blktests nvme/029 failed[1] on the
> >>> linux-block/for-next, and bisect shows it was introduced from [2],
> >>> please help check it and let me know if you need any info/test for it=
, thanks.
> >>>
> >>> [1]
> >>> nvme/029 (tr=3Dloop) (test userspace IO via nvme-cli read/write
> >>> interface) [failed]
> >>>     runtime    ...  1.568s
> >>>     --- tests/nvme/029.out 2024-11-19 08:13:41.379272231 +0000
> >>>     +++ /root/blktests/results/nodev_tr_loop/nvme/029.out.bad
> >>> 2024-11-19 10:55:13.615939542 +0000
> >>>     @@ -1,2 +1,8 @@
> >>>      Running nvme/029
> >>>     +FAIL
> >>>     +FAIL
> >>>     +FAIL
> >>>     +FAIL
> >>>     +FAIL
> >>>     +FAIL
> >>>     ...
> >>>     (Run 'diff -u tests/nvme/029.out
> >>> /root/blktests/results/nodev_tr_loop/nvme/029.out.bad' to see the
> >>> entire diff)
> >>> [2]
> >>> 64a51080eaba (HEAD) nvmet: implement id ns for nvm command set
> >>>
> >>>
> >>> --
> >>> Best Regards,
> >>>   Yi Zhang
> >>>
> >>>
> >> I couldn't reproduce it even after running nvme/029 in a loop
> >> for multiple times. Are you following any specific steps to
> >> recreate it?
> >
> > From the reproduced data[1], seems it only reproduced on x86_64 and
> > aarch64, and from the 029.full[2], we can see the failure comes from
> > the "nvme write" cmd.
> > [1]
> > https://datawarehouse.cki-project.org/issue/3263
> > [2]
> > # cat results/nodev_tr_loop/nvme/029.full
> > Reference tag larger than allowed by PIF
> > NQN:blktests-subsystem-1 disconnected 1 controller(s)
> > disconnected 1 controller(s)
> >
> > I also attached the kernel config file in case you want to try it, than=
ks.
> >
> Thanks for the additional information!
> Now I could understand the issue and have a probable fix. If possible, ca=
n you try
> the below patch and check if it help resolve this issue?

Yes, the issue was fixed now.

>
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-=
cmd.c
> index 934b401fbc2f..7a8256ae3085 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -901,12 +901,14 @@ static void nvmet_execute_identify_ctrl_nvm(struct =
nvmet_req *req)
>  static void nvme_execute_identify_ns_nvm(struct nvmet_req *req)
>  {
>         u16 status;
> +       void *zero_buf;
>
>         status =3D nvmet_req_find_ns(req);
>         if (status)
>                 goto out;
>
> -       status =3D nvmet_copy_to_sgl(req, 0, ZERO_PAGE(0),
> +       zero_buf =3D __va(page_to_pfn(ZERO_PAGE(0)) << PAGE_SHIFT);
> +       status =3D nvmet_copy_to_sgl(req, 0, zero_buf,
>                                    NVME_IDENTIFY_DATA_SIZE);
>  out:
>         nvmet_req_complete(req, status);
>
> Thanks,
> --Nilay
>


--=20
Best Regards,
  Yi Zhang

