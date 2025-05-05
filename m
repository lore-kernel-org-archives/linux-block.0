Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04701A2C25
	for <linux-block@vger.kernel.org>; Mon,  5 May 2025 13:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746451288; cv=none; b=GxNXtgMz4A+EK1yeFs90Ay8SqjCIL7y1zTOvfiKbCf0X3z2bvP3236wwkuNh8FyzREPVov6DFmsLI2lf2o0cXAvtxLfmrGWF/gIk2+yGP/T7UZdhttQMz1EJIfRSIshDFZ3uls4SALiJzVac7Nw78dZOYaq/mf9H3l/7xfPitck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746451288; c=relaxed/simple;
	bh=10JdmTbzM7ykq2euDY1kEaDgHmZ6iXvGazWjRGf2rjI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oflfmif+CZkWuMZKh4kgVarW7NTCelVyFYtcDIvpVIm8gOWewSSZETDUaXIIdjF44cqIen+WiQHv2hSseFIsOBiXii/DswRVR76O07PPmDTizRZ/qV2qnzx9xpXyUcTEZBsp7MU662Ql03zzHNHQ3zk7lzzem0InkkA3iaK2I8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ck62QZBA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ck62QZBA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746451285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VIG82GRDutsfX6ZuO5wxnZIciX/BmGs6c3KresObAZ8=;
	b=Ck62QZBAWSJi3YaxmrzTxEbQ1G5G16NvC/yyi2uye/+cMuDekMdXf7erSxVe3om4TuK/is
	gXzd2pra03zjixonZ+eie7bzk6egaOoj3uyDbVW3bpvISV2Fj5e4bWAJNJsHMS1ky6EED4
	JQRjxTiE51u6alR2rAEiNSWvRNBARSc=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-PzhMvzyRMV2wZQH25imqwQ-1; Mon, 05 May 2025 09:21:22 -0400
X-MC-Unique: PzhMvzyRMV2wZQH25imqwQ-1
X-Mimecast-MFC-AGG-ID: PzhMvzyRMV2wZQH25imqwQ_1746451282
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-6062b390adeso5015076eaf.2
        for <linux-block@vger.kernel.org>; Mon, 05 May 2025 06:21:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746451281; x=1747056081;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VIG82GRDutsfX6ZuO5wxnZIciX/BmGs6c3KresObAZ8=;
        b=uWx0GFjrid0y0rn8J5AFSjDo+b1zjgiCM0L3nI9rmkY7IKPxn7DqoMWrOg9tRY0srr
         s/EZSIRM1xptgD3rhSfj+w4cPpDa93qXpmXOdDu+zbBcWQGKdKTS4640xFbt6NWEhUIb
         oFBNeXk1umQqopknWht9kjihLl9iYL53OrxVc19pw1Lu5oeY0BFPYTggK1Xt7eMZs1B+
         AuqLuohxlQD2+9Y7isLnC5UQAAcqKfOzrwjMNnqp292KxjiOhDnSG2Nj+zt54iJe3E7a
         Lx9b3YTAwm9lNgH7iqHe067zmahxhQMOreB55kZ+LaOwZ1zbxf0FRetB3MMX+O0u75kF
         IG0g==
X-Forwarded-Encrypted: i=1; AJvYcCXE/xRvGUvQDA8y6jLCnh2xZeSv98+Swh3U9I1A8VvK6oCwO1hIyKadXvtvC11AYfOIQvBdiR2I9HS76g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyuJsbvey2YAQATJ14l+f8kBj8FIES5yorJu+7y2uhkIAHpz7eY
	uwF63KtarVUj6PFY+k8FoQPT9TpBrJloFzSLnIaYGV3+Itjy9WQJ9kVeQ3kyWOnFCBFYyR7KY7e
	VI83b6/3fOpIEUEZMAnmkz5E4nkyNR2vMW0qYGaEM6dsFXAo0C5usKDeT1Op9
X-Gm-Gg: ASbGnct37L8CEcZErkdykXMbgx318217/WhRQvYFugXsQOj5hOgXavowQhUJcR2Xw2s
	cT0ZTCoRCcteohQyLuHh2Iip93IZBhP7ulQUu/KDhf0SpXHnUe47YHhMKpPB/3yYeGDtMmHEeJF
	4ok83HHfMPwxsgkYppmFA7YmiKnt/l0KBixPyFVNx3hpjlUEPh3N6ZxaSiZs8UkEAiZWWltWBOe
	mqQym/Cx05EcVD6dgIkR1vAv4dvkxMPmF0cMn6DUMYGWfykWLbqu+fseCXf9yidFb/sk75UH8aS
	DsIwEO1yNtJx1om2bnzIeqwEEWX4sMUrpbozeqC3EKiwJfdYQWq+z9HnPb1L9A==
X-Received: by 2002:a05:6870:241d:b0:2b7:f58d:6dcf with SMTP id 586e51a60fabf-2dab306a348mr7088222fac.18.1746451281670;
        Mon, 05 May 2025 06:21:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJSFoVMOrZluBnw+MORthCitmUF2zcmvueOnmkO8JsVGz6KhUlfEjQyECXfa5BsXBb6t8dxQ==
X-Received: by 2002:a05:6870:241d:b0:2b7:f58d:6dcf with SMTP id 586e51a60fabf-2dab306a348mr7088214fac.18.1746451281316;
        Mon, 05 May 2025 06:21:21 -0700 (PDT)
Received: from ?IPv6:2600:6c64:4e7f:603b:fc4d:8b7c:e90c:601a? ([2600:6c64:4e7f:603b:fc4d:8b7c:e90c:601a])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2daa1207873sm1985356fac.38.2025.05.05.06.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 06:21:20 -0700 (PDT)
Message-ID: <a1f322ab801e7f7037951578d289c5d18c6adc4d.camel@redhat.com>
Subject: Re: Sequential read from NVMe/XFS twice slower on Fedora 42 than on
 Rocky 9.5
From: Laurence Oberman <loberman@redhat.com>
To: Dave Chinner <david@fromorbit.com>, Anton Gavriliuk
 <antosha20xx@gmail.com>
Cc: linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org, 
	linux-block@vger.kernel.org
Date: Mon, 05 May 2025 09:21:19 -0400
In-Reply-To: <7c33f38a52ccff8b94f20c0714b60b61b061ad58.camel@redhat.com>
References: 
	<CAAiJnjoo0--yp47UKZhbu8sNSZN6DZ-QzmZBMmtr1oC=fOOgAQ@mail.gmail.com>
	 <aBaVsli2AKbIa4We@dread.disaster.area>
	 <CAAiJnjor+=Zn62n09f-aJw2amX2wxQOb-2TB3rea9wDCU7ONoA@mail.gmail.com>
	 <aBfhDQ6lAPmn81j0@dread.disaster.area>
	 <7c33f38a52ccff8b94f20c0714b60b61b061ad58.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-05-05 at 08:29 -0400, Laurence Oberman wrote:
> On Mon, 2025-05-05 at 07:50 +1000, Dave Chinner wrote:
> > [cc linux-block]
> >=20
> > [original bug report:
> > https://lore.kernel.org/linux-xfs/CAAiJnjoo0--yp47UKZhbu8sNSZN6DZ-QzmZB=
Mmtr1oC=3DfOOgAQ@mail.gmail.com/
> > =C2=A0]
> >=20
> > On Sun, May 04, 2025 at 10:22:58AM +0300, Anton Gavriliuk wrote:
> > > > What's the comparitive performance of an identical read profile
> > > > directly on the raw MD raid0 device?
> > >=20
> > > Rocky 9.5 (5.14.0-503.40.1.el9_5.x86_64)
> > >=20
> > > [root@localhost ~]# df -mh /mnt
> > > Filesystem=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Size=C2=A0 Used Avail Use% M=
ounted on
> > > /dev/md127=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 35T=C2=A0 1.3T=C2=A0=
=C2=A0 34T=C2=A0=C2=A0 4% /mnt
> > >=20
> > > [root@localhost ~]# fio --name=3Dtest --rw=3Dread --bs=3D256k
> > > --filename=3D/dev/md127 --direct=3D1 --numjobs=3D1 --iodepth=3D64 --
> > > exitall
> > > --group_reporting --ioengine=3Dlibaio --runtime=3D30 --time_based
> > > test: (g=3D0): rw=3Dread, bs=3D(R) 256KiB-256KiB, (W) 256KiB-256KiB,
> > > (T)
> > > 256KiB-256KiB, ioengine=3Dlibaio, iodepth=3D64
> > > fio-3.39-44-g19d9
> > > Starting 1 process
> > > Jobs: 1 (f=3D1): [R(1)][100.0%][r=3D81.4GiB/s][r=3D334k IOPS][eta
> > > 00m:00s]
> > > test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D43189: Sun May=C2=A0 4=
 08:22:12
> > > 2025
> > > =C2=A0 read: IOPS=3D363k, BW=3D88.5GiB/s (95.1GB/s)(2656GiB/30001msec=
)
> > > =C2=A0=C2=A0=C2=A0 slat (nsec): min=3D971, max=3D312380, avg=3D1817.9=
2, stdev=3D1367.75
> > > =C2=A0=C2=A0=C2=A0 clat (usec): min=3D78, max=3D1351, avg=3D174.46, s=
tdev=3D28.86
> > > =C2=A0=C2=A0=C2=A0=C2=A0 lat (usec): min=3D80, max=3D1352, avg=3D176.=
27, stdev=3D28.81
> > >=20
> > > Fedora 42 (6.14.5-300.fc42.x86_64)
> > >=20
> > > [root@localhost anton]# df -mh /mnt
> > > Filesystem=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Size=C2=A0 Used Avail Use% M=
ounted on
> > > /dev/md127=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 35T=C2=A0 1.3T=C2=A0=
=C2=A0 34T=C2=A0=C2=A0 4% /mnt
> > >=20
> > > [root@localhost ~]# fio --name=3Dtest --rw=3Dread --bs=3D256k
> > > --filename=3D/dev/md127 --direct=3D1 --numjobs=3D1 --iodepth=3D64 --
> > > exitall
> > > --group_reporting --ioengine=3Dlibaio --runtime=3D30 --time_based
> > > test: (g=3D0): rw=3Dread, bs=3D(R) 256KiB-256KiB, (W) 256KiB-256KiB,
> > > (T)
> > > 256KiB-256KiB, ioengine=3Dlibaio, iodepth=3D64
> > > fio-3.39-44-g19d9
> > > Starting 1 process
> > > Jobs: 1 (f=3D1): [R(1)][100.0%][r=3D41.0GiB/s][r=3D168k IOPS][eta
> > > 00m:00s]
> > > test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D5685: Sun May=C2=A0 4 =
10:14:00
> > > 2025
> > > =C2=A0 read: IOPS=3D168k, BW=3D41.0GiB/s (44.1GB/s)(1231GiB/30001msec=
)
> > > =C2=A0=C2=A0=C2=A0 slat (usec): min=3D3, max=3D273, avg=3D 5.63, stde=
v=3D 1.48
> > > =C2=A0=C2=A0=C2=A0 clat (usec): min=3D67, max=3D2800, avg=3D374.99, s=
tdev=3D29.90
> > > =C2=A0=C2=A0=C2=A0=C2=A0 lat (usec): min=3D72, max=3D2914, avg=3D380.=
62, stdev=3D30.22
> >=20
> > So the MD block device shows the same read performance as the
> > filesystem on top of it. That means this is a regression at the MD
> > device layer or in the block/driver layers below it. i.e. it is not
> > an XFS of filesystem issue at all.
> >=20
> > -Dave.
>=20
> I have a lab setup, let me see if I can also reproduce and then trace
> this to see where it is spending the time
>=20


Not seeing 1/2 the bandwidth but also significantly slower on Fedora42
kernel.
I will trace it

9.5 kernel - 5.14.0-503.40.1.el9_5.x86_64

Run status group 0 (all jobs):
   READ: bw=3D14.7GiB/s (15.8GB/s), 14.7GiB/s-14.7GiB/s (15.8GB/s-
15.8GB/s), io=3D441GiB (473GB), run=3D30003-30003msec

Fedora42 kernel - 6.14.5-300.fc42.x86_64

Run status group 0 (all jobs):
   READ: bw=3D10.4GiB/s (11.2GB/s), 10.4GiB/s-10.4GiB/s (11.2GB/s-
11.2GB/s), io=3D313GiB (336GB), run=3D30001-30001msec




