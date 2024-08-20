Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B12B1AAA5
	for <linux-block@vger.kernel.org>; Tue, 20 Aug 2024 01:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724118667; cv=none; b=UcDSijw4lP6dcfQpkQT8mwctw++2ZtLJXdpBSzU0bS7K46blIhZWNCP1RQ4T940si4couttQAYUYjoVEeB/qM2YyEnhQMcqq5Hj5vHKsQEc+/7OgIJGcbCU875xj3X7FtrmsvSEMyUSY3m+LgC/cSHLgwrGjL3vKyWgzH06Al6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724118667; c=relaxed/simple;
	bh=X7Tf/2sbMns8bMTKUFg1k31n585aRPKOnD1Dmxtvuwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K3jJMrQCrclxGXJMcXFz/a2duRsbfebl5uVbOgErBbp47gZkVCgXUt07ljMWsD6nnyQqXx9rZZrPwp9l9C0m/nt7tz/cyrdpcObUWR8dNLp7iExBGrhfiPu0XajETmSjPza4uAkJ68ffRpuMcIvR4b6kyzNL3sXzX81I4m35UYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aWNPuZ0e; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aWNPuZ0e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724118662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zemSLB7cpZj/xdAoHKekxRhjOKghwOYrL/smZ5zzA84=;
	b=aWNPuZ0eWBKtH0Tj/D192waxu3mjg0TCEYZw18VTvvVmqUSVkOVlIFeknRXhw8bv4Ke41h
	cIDEbpQbSeyDD6qdS2v+QyLatiUGUrVWqO8mciTVHbypFPSnB9tWkPJvurutBkhpvv54Nv
	hKNVRS3Hwwe4mRLV+neeLo+hXP42AzI=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-Fq4FQim-PNC6_RVI7T7RGA-1; Mon, 19 Aug 2024 21:51:01 -0400
X-MC-Unique: Fq4FQim-PNC6_RVI7T7RGA-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2d3c0088813so4489534a91.1
        for <linux-block@vger.kernel.org>; Mon, 19 Aug 2024 18:51:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724118659; x=1724723459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zemSLB7cpZj/xdAoHKekxRhjOKghwOYrL/smZ5zzA84=;
        b=jyEmsHXnV9is8bmpEl6nEmazR7GGTlnvVZmKBvpWPtmNpbiQMJD6mojh28IvJuv/9k
         hgCvCWFtk0J4MGqTci9TyK4nUUWBoKQF5pGZr3XzPOcjG07XSvKgi5NRoIwyy2sCL0yE
         yWpe35ReRNaUrV74BPsdf+VPF2LJeT2EHva2HsFfdnJMDzL4SSAfaq92Do/Rl1E/bO92
         Fegssqa3mLCvbv4GxuZj2IVfkqCNJUAAcqi4aBYLrX9twDbq2WNVtnn0cVblXNmVknhb
         2q1e+mNzFzZIVDj6cgmDSXBY0dEq+Hx3dS4NHlJLrHsAR17aDvFbbQzzPESCxrUwvM9v
         LZaw==
X-Forwarded-Encrypted: i=1; AJvYcCVVqJsa2ywVIuGzfcS3tSi+E5uKhaVADihj0DbhttO+OdjwmpEeNXUHq6xXAdHj2Q4jVCq3fWmTmgrLXQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwo0PcJI6jiA84BjTCyaJwOx1ZHjc+huhlthKgGv9sYctdyVVU
	fZToSAY9dmLB0XTZ2ZoZdGm3dsJRIpAmYdUnbX4pTOeucBLybZ83IFDF/mSg+WdEsejMGSAtfsE
	+QbZsHObp83lY3/kJ20Ljpm68fd/hwJlqEnAHAqyxHVKo5N2YUNAu/UONkBfFzn3pz/X53NcOFw
	PHKK+GidO9e525IoBJT452/XTKEJ3ooNDkaThXoY4Z5SCm7Q==
X-Received: by 2002:a17:90a:8a02:b0:2c8:87e:c2d9 with SMTP id 98e67ed59e1d1-2d3e03e89dcmr12525653a91.39.1724118659444;
        Mon, 19 Aug 2024 18:50:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2xNwaA7efDn4iFU7NRQCn5zeIDhK2iOTMbDt+qvGPJ3lKC0GseK99B8PoX4eAcf/7EG7ilcLRq4e0JUPo6TI=
X-Received: by 2002:a17:90a:8a02:b0:2c8:87e:c2d9 with SMTP id
 98e67ed59e1d1-2d3e03e89dcmr12525636a91.39.1724118659021; Mon, 19 Aug 2024
 18:50:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5yal5unzvisrvfhhvsqrsqgu4tfbjp2fsrnbuyxioaxjgbojsi@o2arvhebzes3>
 <ab363932-ab3d-49b1-853d-7313f02cce9e@linux.ibm.com> <ljqlgkvhkojsmehqddmeo4dng6l3yaav6le2uslsumfxivluwu@m7lkx3j4mkkw>
 <79a7ec0d-c22d-44cf-a832-13da05a1fcbd@linux.ibm.com> <CAHj4cs-5DPDFuBzm3aymeAi6UWHhgXSYsgaCACKbjXp=i0SyTA@mail.gmail.com>
 <1f917bc1-8a6a-4c88-a619-cf8ddc4534a4@linux.ibm.com> <tczctp5tkr34o3k3f4dlyhuutgp2ycex6gdbjuqx4trn6ewm2i@qbkza3yr5wdd>
 <f2f9d5b4-3c50-41a9-bc53-49706f6f4e12@linux.ibm.com>
In-Reply-To: <f2f9d5b4-3c50-41a9-bc53-49706f6f4e12@linux.ibm.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Tue, 20 Aug 2024 09:50:47 +0800
Message-ID: <CAHj4cs8B-Md_WnPo0Z2o6dZ3n30QqL5D-YbW9wWbCMLjxDSrsg@mail.gmail.com>
Subject: Re: blktests failures with v6.11-rc1 kernel
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, "nbd@other.debian.org" <nbd@other.debian.org>, 
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 9:35=E2=80=AFPM Nilay Shroff <nilay@linux.ibm.com> =
wrote:
>
>
>
> On 8/19/24 18:04, Shinichiro Kawasaki wrote:
> > On Aug 14, 2024 / 18:05, Nilay Shroff wrote:
> >>
> >>
> >> On 8/13/24 12:36, Yi Zhang wrote:
> >>> On Sat, Aug 3, 2024 at 12:49=E2=80=AFAM Nilay Shroff <nilay@linux.ibm=
.com> wrote:
> >>>
> >>> There are no simultaneous tests during the CKI tests running.
> >>> I reproduced the failure on that server and always can be reproduced
> >>> within 5 times:
> >>> # sh a.sh
> >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D0
> >>> nvme/052 (tr=3Dloop) (Test file-ns creation/deletion under one subsys=
tem) [passed]
> >>>     runtime  21.496s  ...  21.398s
> >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D1
> >>> nvme/052 (tr=3Dloop) (Test file-ns creation/deletion under one subsys=
tem) [failed]
> >>>     runtime  21.398s  ...  21.974s
> >>>     --- tests/nvme/052.out 2024-08-10 00:30:06.989814226 -0400
> >>>     +++ /root/blktests/results/nodev_tr_loop/nvme/052.out.bad
> >>> 2024-08-13 02:53:51.635047928 -0400
> >>>     @@ -1,2 +1,5 @@
> >>>      Running nvme/052
> >>>     +cat: /sys/block/nvme1n2/uuid: No such file or directory
> >>>     +cat: /sys/block/nvme1n2/uuid: No such file or directory
> >>>     +cat: /sys/block/nvme1n2/uuid: No such file or directory
> >>>      Test complete
> >>> # uname -r
> >>> 6.11.0-rc3
> >>
> >> We may need to debug this further. Is it possible to patch blktest and
> >> collect some details when this issue manifests? If yes then can you pl=
ease
> >> apply the below diff and re-run your test? This patch would capture ou=
tput
> >> of "nvme list" and "sysfs attribute tree created under namespace head =
node"
> >> and store those details in 052.full file.
> >>
> >> diff --git a/common/nvme b/common/nvme
> >> index 9e78f3e..780b5e3 100644
> >> --- a/common/nvme
> >> +++ b/common/nvme
> >> @@ -589,8 +589,23 @@ _find_nvme_ns() {
> >>                 if ! [[ "${ns}" =3D~ nvme[0-9]+n[0-9]+ ]]; then
> >>                         continue
> >>                 fi
> >> +               echo -e "\nBefore ${ns}/uuid check:\n" >> ${FULL}
> >> +               echo -e "\n`nvme list -v`\n" >> ${FULL}
> >> +               echo -e "\n`tree ${ns}`\n" >> ${FULL}
> >> +
> >>                 [ -e "${ns}/uuid" ] || continue
> >>                 uuid=3D$(cat "${ns}/uuid")
> >> +
> >> +               if [ "$?" =3D "1" ]; then
> >> +                       echo -e "\nFailed to read $ns/uuid\n" >> ${FUL=
L}
> >> +                       echo "`nvme list -v`" >> ${FULL}
> >> +                       if [ -d "${ns}" ]; then
> >> +                               echo -e "\n`tree ${ns}`\n" >> ${FULL}
> >> +                       else
> >> +                               echo -e "\n${ns} doesn't exist!\n" >> =
${FULL}
> >> +                       fi
> >> +               fi
> >> +
> >>                 if [[ "${subsys_uuid}" =3D=3D "${uuid}" ]]; then
> >>                         basename "${ns}"
> >>                 fi
> >>
> >>
> >> After applying the above diff, when this issue occurs on your system c=
opy this
> >> file "</path/to/blktests>/results/nodev_tr_loop/nvme/052.full" and sen=
d it across.
> >> This may give us some clue about what might be going wrong.
> >
> > Nilay, thank you for this suggestion. To follow it, I tried to recreate=
 the
> > failure again, and managed to do it :) When I repeat the test case 20 o=
r 40
> > times one of my test machines, the failure is observed in stable manner=
.
>
> Shinichiro, I am glad that you were able to recreate this issue.
>
> > I applied your debug patch above to blktests, then I repeated the test =
case.
> > Unfortunately, the failure disappeared. When I repeat the test case 100=
 times,
> > the failure was not observed. I guess the echos for debug changed the t=
iming to
> > access the sysfs uuid file, then the failure disappeared.
>
> Yes this could be possible. BTW, Yi tried the same patch and with the pat=
ch applied,
> this issue could be still reproduced on Yi's testbed!!
> > This helped me think about the cause. The test case repeats _create_nvm=
et_ns
> > and _remove_nvmet_ns. Then, it repeats creating and removing the sysfs =
uuid
> > file. I guess when _remove_nvmet_ns echos 0 to ${nvemt_ns_path}/enable =
to
> > remove the namespace, it does not wait for the completion of the remova=
l work.
> > Then, when _find_nvme_ns() checks existence of the sysfs uuid file, it =
refers to
> > the sysfs uuid file that the previous _remove_nvmet_ns left. When it do=
es cat
> > to the sysfs uuid file, it fails because the sysfs uuid file has got re=
moved,
> > before recreating it for the next _create_nvmet_ns.
>
> I agree with your assessment about the plausible cause of this issue. I j=
ust reviewed
> the nvme target kernel code and it's now apparent to me that we need to w=
ait for the
> removal of the namespace before we re-create the next namespace. I think =
this is a miss.
> >
> > Based on this guess, I created a patch below. It modifies the test case=
 to wait
> > for the namespace device disappears after calling _remove_nvmet_ns. (I =
assume
> > that the sysfs uuid file disappears when the device file disappears). W=
ith
> > this patch, the failure was not observed by repeating it 100 times. I a=
lso
> > reverted the kernel commit ff0ffe5b7c3c ("nvme: fix namespace removal l=
ist")
> > from v6.11-rc4, then confirmed that the test case with this change stil=
l can
> > detect the regression.
> >
> I am pretty sure that your patch would solve this issue.
>
> > I will do some more confirmation. If it goes well, will post this chang=
e as
> > a formal patch.
> >
> > diff --git a/tests/nvme/052 b/tests/nvme/052
> > index cf6061a..469cefd 100755
> > --- a/tests/nvme/052
> > +++ b/tests/nvme/052
> > @@ -39,15 +39,32 @@ nvmf_wait_for_ns() {
> >               ns=3D$(_find_nvme_ns "${uuid}")
> >       done
> >
> > +     echo "$ns"
> >       return 0
> >  }
> >
> > +nvmf_wait_for_ns_removal() {
> > +     local ns=3D$1 i
> > +
> > +     for ((i =3D 0; i < 10; i++)); do
> > +             if [[ ! -e /dev/$ns ]]; then
> > +                     return
> > +             fi
> > +             sleep .1
> > +             echo "wait removal of $ns" >> "$FULL"
> > +     done
> > +
> > +     if [[ -e /dev/$ns ]]; then
> > +             echo "Failed to remove the namespace $"
> > +     fi
> > +}
> > +
> >  test() {
> >       echo "Running ${TEST_NAME}"
> >
> >       _setup_nvmet
> >
> > -     local iterations=3D20
> > +     local iterations=3D20 ns
> >
> >       _nvmet_target_setup
> >
> > @@ -63,7 +80,7 @@ test() {
> >               _create_nvmet_ns "${def_subsysnqn}" "${i}" "$(_nvme_def_f=
ile_path).$i" "${uuid}"
> >
> >               # wait until async request is processed and ns is created
> > -             nvmf_wait_for_ns "${uuid}"
> > +             ns=3D$(nvmf_wait_for_ns "${uuid}")
> >               if [ $? -eq 1 ]; then
> >                       echo "FAIL"
> >                       rm "$(_nvme_def_file_path).$i"
> > @@ -71,6 +88,7 @@ test() {
> >               fi
> >
> >               _remove_nvmet_ns "${def_subsysnqn}" "${i}"
> > +             nvmf_wait_for_ns_removal "$ns"
> >               rm "$(_nvme_def_file_path).$i"
> >       }
> >       done
>
> I think there's some formatting issue in the above patch. I see some stra=
y characters
> which you may cleanup/fix later when you send the formal patch.
>
> Yi, I think you you may also try the above patch on your testbed and conf=
irm the result.

Nilay/Shinichiro

Confirmed the failure cannot be reproduced with this patch now.

>
> Thanks,
> --Nilay
>


--=20
Best Regards,
  Yi Zhang

