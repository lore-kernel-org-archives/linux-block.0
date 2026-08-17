Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C823B0582
	for <linux-block@vger.kernel.org>; Mon, 17 Aug 2026 19:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786995241; cv=pass; b=kXrWy69LjkeADRF5+RQQQMCv5rv2dewrwrbaavJgtiKNZALH+GbhUD+dl8f4aRHVpS7KZUMivdbTSIrnXUlKvfCjERKEOdP4u22RDeKY7T1uQvKauoKUMRKvaVc2B5fG0RCPusC5UGMoLkBNUrlXCyjgQl0PkVLC29C2p40v37U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786995241; c=relaxed/simple;
	bh=M6ppWr+jktQJTeRcX+Vduh9Y31qHLnVhze1x2Qj6j6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cCt7dLT03EwOtOl5J2zd1Wj88aX+hU2GQxoVvsPlu6Z8KCy6PM9j0wNzZFlOHLwZ9qDZmtNGV8UoCSaMeRHSkwZsjK4KtWbnsuQ8mdBoOslC4bFOwTWtoaqYNtZCwPg8Wk8t35ePa/i6V/UztwTdv2ayyZ13gbdkwpFdEor9AtM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jJFLsa9s; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lk/wxaHP; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jJFLsa9s";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lk/wxaHP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786995238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zkJj2JcDlUPOQbYD6rVCALNPgZi2ktrvt0VeFhD7xJQ=;
	b=jJFLsa9sx3/iYBncJzYChBuY88vevAWgs4rWBDsZNojyt03Jc/haU39FxQYst34DCu4OTK
	0ISQFrIjKchKmukfeF4ORtdHOvUFclMrcJGkZ7VVpAPM3nRWhQBp4bWuzNI2mepI7LnipE
	ceI+d35gw8aPw8l5te0bvpVNNhi4AcY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-w6J4GcZyOw-6QFaAfakeVA-1; Mon, 17 Aug 2026 15:33:57 -0400
X-MC-Unique: w6J4GcZyOw-6QFaAfakeVA-1
X-Mimecast-MFC-AGG-ID: w6J4GcZyOw-6QFaAfakeVA_1786995236
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4994d67d0e3so28021865e9.2
        for <linux-block@vger.kernel.org>; Mon, 17 Aug 2026 12:33:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786995236; cv=none;
        d=google.com; s=arc-20260327;
        b=m2eZ0tP3/nza7x4PNoT+AX5uq3JXWuRUoI9rqdWgzEjtn4lxnxPzYwn7tLGelaphv7
         rrROf4gKCbMr+6B/kw9cFjFfdDE7CDS8xohFY5lMmy4JYeas26IuUgMoxZMhZy0OxJ26
         jI8iK+qrSiWBebA3B2+BJBTHjxd6n2yi39/esib+Y0iAA4HNiXigLq+Fb78fjYYRHr80
         qGGEvLraJYnQenK40VndmClAj8lSLMuDwJEGmPbXn7YMcSg/XS72MSmdvIhRGJmVgKdb
         hIDNTgpbNLckTf2ZsevSSWfmGZuvOJORjBH5rOkC6rB70oza0pyGPyhtpc7oFGVwU0vN
         3qrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zkJj2JcDlUPOQbYD6rVCALNPgZi2ktrvt0VeFhD7xJQ=;
        fh=Pw/ychRNAooBzKui/Jk9ssFo29jUtMBp3hgqp66ulHw=;
        b=jIWKtZbUopZOkt2+gaJcBZOEIVuU/rzkU5mKdnEnzX2HmmeGhNC1Csdotq/f9gmXYe
         IM6lCGzUKh1Pijd7mp2/D0hMoqc8kh5ZGx57YsQEZ/6cB/xfU3su1qpvmDMa4fzDbFri
         rszCYHwbLdzIZv0jLwRBP5hrIuM1mxU3ee31RRuRwI3HCQ9KwXizVluRgGj9WgJ+tjZd
         0GR6hpQpVK7xKQpzExqp3L49Ysw9WBauBw0QXPWRE0r4xjCKTOtf2JV+YLKEmtYpIZgO
         lk6tVOr5qABt30dUq9EnbLpHis7azHUfbvfVFvv80HAPTkBwMakB63WyeU6QRA1evKVB
         upZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786995236; x=1787600036; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zkJj2JcDlUPOQbYD6rVCALNPgZi2ktrvt0VeFhD7xJQ=;
        b=Lk/wxaHPyi+aHqMhtskiNG3YTMP8MrXZhuR9Kbe5+gM7i3NPNdrsckoFynHEeyRsp4
         BRIylLqfZ92w/MZPf+w3BvUSaFe6e28WN9wCOvPbfsEY8wjLeCJ9LpKkFsfkNSHYZOMy
         5g0ri06oT7Fb+KXR850agET1nkta71OG6yeW070oQ9cfVn6UgU02dFl2X4XG2XMNuTnl
         fRn0mcycej9eInIvV8GfBEJe77tnAm3/EkZU91hyzlU7opLgthcFckp99EaSzaCJGYWY
         SYXlVJEvxWw6wnchvOodAjgVAX3vxE95PQd8y+vR1rtcXnaCTFqrXPux0xcZ/VVtDeAC
         iXTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786995236; x=1787600036;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zkJj2JcDlUPOQbYD6rVCALNPgZi2ktrvt0VeFhD7xJQ=;
        b=eZBLCt2BPrAdrKCR4YwV0+jKQ1VkqsRcmnEPhccJVIEYSC+BsZem0/4u6tA6L9STCl
         qRO3HjDtrYlJ7WGKexjGCItSImPfV1PGv2t3CVmqFi0CnYptXLtC03SjVY1uu+NzmqZk
         EacAgNwNgNyKu5TguYJVR/HPbqD27F10DmmXa94z3ZfgNGF20OvfXRIBn8JSKGqBGfNs
         y8kxy5i4rnzG5mZkJcq4p18MgOOxAdgrRbXMPX4aa2lgzgLB5zPhKftsdLDZZcfXe2o+
         yGEjHBZDUohzOmNmH/CILTpOyK3UZp+LhHgUt3XKE3aiD00UmDonn1ZNYL75QbOJotRn
         MIsw==
X-Gm-Message-State: AOJu0YyEBo8Z2Rxh73/IRnn3EO8xTDwtRr9K8j29xQCIehe2Y7mbn5J8
	G9L9U9X7G4ySxfr9ylHigsOyD+GyGBluEaU00pUwX8v7ezkAS9tG94G6hkYgWHjiDK24egREEzR
	EPqACgyQl7NuY4jO5tk/sbm35LgPYiOrZhuk5AO3LIMo+lzCy6ywO4zPsZwZAqZiusV/0MfIKlG
	WfdMAnIHh3pCkV2ur5GsKBcmXg1BxyUv9xCSqsFYQ=
X-Gm-Gg: AR+sD13Nes88FmZ1fMb1YeNLYjHUTMy1zirs7479R6U7ABv/8ykwQ9/4gst7z0ERyHh
	yoEwAhOVi2bMXtE69hKIg8RJQ8fhnqkZU0qTOdjLOxo/ikI35ivtXcQjyoi72YkGf99RODfLqao
	4vqHYdcJzK6+OCPAhZOJIEhI21dmow6JzQudLcI//ZsSCJnRBy56EbyNYEMnFyQE1BTSeKLu5RZ
	C21W2FwN64B7pXC/w==
X-Received: by 2002:a05:600c:3b8e:b0:499:a0f3:9d5c with SMTP id 5b1f17b1804b1-499a0f3a47bmr12732725e9.3.1786995236073;
        Mon, 17 Aug 2026 12:33:56 -0700 (PDT)
X-Received: by 2002:a05:600c:3b8e:b0:499:a0f3:9d5c with SMTP id
 5b1f17b1804b1-499a0f3a47bmr12732225e9.3.1786995235695; Mon, 17 Aug 2026
 12:33:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812174503.3705830-1-jtaubepe@redhat.com> <an75bRJc8J6NexeH@shinmob>
 <CADRr4beUeZo9ZA9TZVmWQ9Vegm2LvTXkW0wGNxYA6_7z_njMEA@mail.gmail.com> <aoK5sfNpxIUz7C02@shinhome>
In-Reply-To: <aoK5sfNpxIUz7C02@shinhome>
From: Jesse Taube <jtaubepe@redhat.com>
Date: Mon, 17 Aug 2026 15:33:44 -0400
X-Gm-Features: AcwNN1U_VZTy9a8fJk48fdV_hK07jAcQCVb6Zq1f-ghl9ACCE-z76QTZw-W5I1o
Message-ID: <CADRr4bfXLi_EbQzL_Z-a1VfZmr61H2pbGcLtc8A0Huigd0sOfw@mail.gmail.com>
Subject: Re: [PATCH blktests 0/2] Test multipath and marginal ports
To: "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	John Meneghini <jmeneghi@redhat.com>, Daniel Wagner <dwagner@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2026 at 3:39=E2=80=AFAM Shin'ichiro Kawasaki
<shinichiro.kawasaki@wdc.com> wrote:
>
> On Aug 14, 2026 / 10:18, Jesse Taube wrote:
> ...
> > > I applied the series on top of v7.2-rc7 kernel. Then I ran the test c=
ase added
> > > by this blktests series and observed the failurea below:
> > >
> > > nvme/070 (tr=3Dfc) (test nvme-fc marginal path handling)       [faile=
d]
> > >     runtime  33.581s  ...  33.028s
> > >     --- tests/nvme/070.out      2026-08-14 12:03:21.338000000 +0900
> > >     +++ /home/shin/Blktests/blktests/results/nodev_tr_fc/nvme/070.out=
.bad       2026-08-14 20:17:04.731000000 +0900
> > >     @@ -2,7 +2,8 @@
> > >      Starting background I/O
> > >      Testing iopolicy: numa
> > >      Changing FC links to online
> > >     -Set all online: pass
> > >     +No FC ports are being used, expected atleast one in use when all=
 are online in numa mode.

This is should pass even without my patches. I had this happen once
when a link got stuck in connecting.
it could be solved by adding a longer delat after _run_fio_verify_io
as it sometimes takes a bit to connect

> > >     +Set all online: fail
> > >      One host marginal: pass
> > >     ...
> > >     (Run 'diff -u tests/nvme/070.out /home/shin/Blktests/blktests/res=
ults/nodev_tr_fc/nvme/070.out.bad' to see the entire diff)
> > >
> > > Is this failure expected?
> >
> > No. I can't reproduce the issue either.
> > Does this happen consistently?
>
> Yes, it happnes always I run the test case.
> After I rebased to v7.2 kernel, it shows a bit different message:
>
> nvme/070 (tr=3Dfc) (test nvme-fc marginal path handling)       [failed]
>     runtime  37.200s  ...  38.926s
>     --- tests/nvme/070.out      2026-08-17 11:13:53.073000000 +0900
>     +++ /home/shin/Blktests/blktests/results/nodev_tr_fc/nvme/070.out.bad=
       2026-08-17 16:34:17.997000000 +0900
>     @@ -3,10 +3,14 @@
>      Testing iopolicy: numa
>      Changing FC links to online
>      Set all online: pass
>     -One host marginal: pass
>     +FC port on (/sys/class/nvme-subsystem/nvme-subsys6/nvme6) is being u=
sed, expected no use.
>     +One host marginal: fail
>      All marginal: pass
>     ...
>     (Run 'diff -u tests/nvme/070.out /home/shin/Blktests/blktests/results=
/nodev_tr_fc/nvme/070.out.bad' to see the entire diff)
>
> > Maybe the links are still connecting?
>
> Should I try to add some sleeps in the test script? If so, could you sugg=
est
> where to put the sleeps?

maybe add a delay before the cat command in _rport_in_use it might take a s=
econd
for the io to move paths

> If it helps, I will share the kernel config I use. If you want it, please=
 let
> me know.

That would be good. Im using the base centos10 config with
https://github.com/Mr-Bossman/linux/tree/dev/jesse/fpin_v11k

Thanks,
Jesse Taube

