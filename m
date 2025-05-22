Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E0C28F92F
	for <linux-block@vger.kernel.org>; Thu, 22 May 2025 15:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747926481; cv=none; b=BnR0FG6dSZ/jNr16z+iaqjC/dYBXGffCN33p/gdzrt2vorHV1XRgG6/iTEtR2G/cG36ZmvGQbkNh9aFvoRn73OPuKUHfvkrFtV43oDeI02ErxtBrkvBSMxr0SEUO8x+0O40EiQcFDmwqcPkmFWmS2ofaaGjaHSqC20LNRZyZ0jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747926481; c=relaxed/simple;
	bh=EeuSDgqVKj63XH/BsGOarDmziKxpR2gx3k140iln9W4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q/njEBTFh82Fud9slhwslfpeMsy4wxcmFV0ky5Iv8OBn0X3EA9hyTyvvCAo4ortFkz+Ik4NIkdxVvSzks5/wdH5jDkpyrL1620KBX7KWLxX73SD0btLNvUoYFTw6ONscu6GteUgHIAGc7MKpNDzYHaaDSI++n7K0BSqXliyWdJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GAtNb+kj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GAtNb+kj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747926478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EeuSDgqVKj63XH/BsGOarDmziKxpR2gx3k140iln9W4=;
	b=GAtNb+kjXpoKlM3U8trmVEvhwOcYnk+wURRW8prw4RFRSIUzvootdlkijFO8sXrszEj1HG
	Gow0LmG588SbWpYLECR2/tQ92OLZY2C1Htm8R7gDCgRT3tU01Y8y7hdyczDfvtGH6WEBVz
	tJ5NKE61B3ZWmhTrtspz3f19HtfK9MQ=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-vi3_wTHYMUuo0pAU8WHgrQ-1; Thu, 22 May 2025 11:07:56 -0400
X-MC-Unique: vi3_wTHYMUuo0pAU8WHgrQ-1
X-Mimecast-MFC-AGG-ID: vi3_wTHYMUuo0pAU8WHgrQ_1747926476
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-70a5434825cso113050907b3.3
        for <linux-block@vger.kernel.org>; Thu, 22 May 2025 08:07:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747926476; x=1748531276;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EeuSDgqVKj63XH/BsGOarDmziKxpR2gx3k140iln9W4=;
        b=gpat8DzrCts9mwcm56Aq1AgGnaYtgS3/T2wVQ/yst2pPgrrYkzYEJpYSQ4oZd8QHu3
         nEq6E0RknBwPTRD6k05UCdefa1ZY7Nniv/44GsH6/slE255ANInFyBCAGoHjS8VAhYxK
         XyoFr5bazL1gA6aroKJO7UjP9GN40+XloV1pKKTpSSAmP+/gNS0POizgSNiDZoRfZZJ3
         qgy/6qpCMf4r5f69A2XIAD2fdvv0P44nm0HZr+hpLgiWJu4bXAurQBRpACjPW8tF7A2o
         4KPKvGr6bQH4GYT+BUdUlbEZ9lDzj86QxncqLsjZ/uxzh/dNTkp/7h3fuCCRKMKoIDTq
         NoWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqynMJ90Q8xl8N3VNlGbnDtJPaO5g80/R1VrSkxo3YEs+u3JpAbz8y/uAPlYJsPmSy9wlQUl6J6lPQZQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwsYZokkSjT0STGWtqzXT9WK3ETdnWjDgpdsIukHR853FNsIC+1
	DTPGzclEkZoiPpSb3ADwfbkHJztPqACNava7UFrtakXL1VTPEns47GeauOFxMxKFaK+SyAAnzPL
	J+jumeK9QiSw8t81VaUDdl0CzY0IJogqbZn9zHX/MuTol588QzEjdW8WRD0kzJOI1
X-Gm-Gg: ASbGncvZ06Xt6hSLWrmR7L3YKEZdrpKLwgcH6HNWdGFJtFhnBKkdTUwgY2o4zflAlr3
	AUS93UUpatC0BjWkZrLjJFS7nkT0avfTxfYoK5JRZPwA6lpTXe0VhT+tQWC8GGuSRdcTxkLB/au
	uidlPKgKXRNTUHuoe+e7ptx2l5Jf7BourkJMeWCmCRLl5jHuCbB8uLVs6QmA/jdAXFDBnLn9odC
	gbSeX1glkOPgr6Opobcgb1bRF7Pm+D60ZKnJGKdbsejpy5SlWUHku9fTT06TbCgaiHYsQLBCQFT
	NnhdTatiUTTMHuab4qZbbg2dutaswfIoJqQVXyvlwhvcPX5cpKa5hm+mEFv9yg==
X-Received: by 2002:a05:690c:4c13:b0:70c:a57c:94a3 with SMTP id 00721157ae682-70ca7a070b3mr360606437b3.19.1747926476153;
        Thu, 22 May 2025 08:07:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEwejxGi9nhRL8K2qREaXlEOIvA5oHyKuV51mEoHSEqpfOw/2WGHKr40KQ8uc0OMSjq9xOjA==
X-Received: by 2002:a05:690c:4c13:b0:70c:a57c:94a3 with SMTP id 00721157ae682-70ca7a070b3mr360605927b3.19.1747926475650;
        Thu, 22 May 2025 08:07:55 -0700 (PDT)
Received: from ?IPv6:2600:6c64:4e7f:603b:fc4d:8b7c:e90c:601a? ([2600:6c64:4e7f:603b:fc4d:8b7c:e90c:601a])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-70ca82f8d40sm30812717b3.18.2025.05.22.08.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 08:07:54 -0700 (PDT)
Message-ID: <f08554fccd3d5e2c2ec4849b0a8158d63414e356.camel@redhat.com>
Subject: Re: Sequential read from NVMe/XFS twice slower on Fedora 42 than on
 Rocky 9.5
From: Laurence Oberman <loberman@redhat.com>
To: Dave Chinner <david@fromorbit.com>, Anton Gavriliuk
 <antosha20xx@gmail.com>
Cc: linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org, 
	linux-block@vger.kernel.org
Date: Thu, 22 May 2025 11:07:53 -0400
In-Reply-To: <f01719b1901f9d796837669086d7c1cd14c9922c.camel@redhat.com>
References: 
	<CAAiJnjoo0--yp47UKZhbu8sNSZN6DZ-QzmZBMmtr1oC=fOOgAQ@mail.gmail.com>
	 <aBaVsli2AKbIa4We@dread.disaster.area>
	 <CAAiJnjor+=Zn62n09f-aJw2amX2wxQOb-2TB3rea9wDCU7ONoA@mail.gmail.com>
	 <aBfhDQ6lAPmn81j0@dread.disaster.area>
	 <7c33f38a52ccff8b94f20c0714b60b61b061ad58.camel@redhat.com>
	 <a1f322ab801e7f7037951578d289c5d18c6adc4d.camel@redhat.com>
	 <f01719b1901f9d796837669086d7c1cd14c9922c.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-05-05 at 13:39 -0400, Laurence Oberman wrote:
> On Mon, 2025-05-05 at 09:21 -0400, Laurence Oberman wrote:
> > On Mon, 2025-05-05 at 08:29 -0400, Laurence Oberman wrote:
> > > On Mon, 2025-05-05 at 07:50 +1000, Dave Chinner wrote:
> > > > [cc linux-block]
> > > >=20
> > > > [original bug report:
> > > > https://lore.kernel.org/linux-xfs/CAAiJnjoo0--yp47UKZhbu8sNSZN6DZ-Q=
zmZBMmtr1oC=3DfOOgAQ@mail.gmail.com/
> > > > =C2=A0]
> > > >=20
> > > > On Sun, May 04, 2025 at 10:22:58AM +0300, Anton Gavriliuk
> > > > wrote:
> > > > > > What's the comparitive performance of an identical read
> > > > > > profile
> > > > > > directly on the raw MD raid0 device?
> > > > >=20
> > > > > Rocky 9.5 (5.14.0-503.40.1.el9_5.x86_64)
> > > > >=20
> > > > > [root@localhost ~]# df -mh /mnt
> > > > > Filesystem=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Size=C2=A0 Used Avail Us=
e% Mounted on
> > > > > /dev/md127=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 35T=C2=A0 1.3T=C2=
=A0=C2=A0 34T=C2=A0=C2=A0 4% /mnt
> > > > >=20
> > > > > [root@localhost ~]# fio --name=3Dtest --rw=3Dread --bs=3D256k
> > > > > --filename=3D/dev/md127 --direct=3D1 --numjobs=3D1 --iodepth=3D64=
 --
> > > > > exitall
> > > > > --group_reporting --ioengine=3Dlibaio --runtime=3D30 --time_based
> > > > > test: (g=3D0): rw=3Dread, bs=3D(R) 256KiB-256KiB, (W) 256KiB-
> > > > > 256KiB,
> > > > > (T)
> > > > > 256KiB-256KiB, ioengine=3Dlibaio, iodepth=3D64
> > > > > fio-3.39-44-g19d9
> > > > > Starting 1 process
> > > > > Jobs: 1 (f=3D1): [R(1)][100.0%][r=3D81.4GiB/s][r=3D334k IOPS][eta
> > > > > 00m:00s]
> > > > > test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D43189: Sun May=C2=
=A0 4
> > > > > 08:22:12
> > > > > 2025
> > > > > =C2=A0 read: IOPS=3D363k, BW=3D88.5GiB/s (95.1GB/s)(2656GiB/30001=
msec)
> > > > > =C2=A0=C2=A0=C2=A0 slat (nsec): min=3D971, max=3D312380, avg=3D18=
17.92,
> > > > > stdev=3D1367.75
> > > > > =C2=A0=C2=A0=C2=A0 clat (usec): min=3D78, max=3D1351, avg=3D174.4=
6, stdev=3D28.86
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0 lat (usec): min=3D80, max=3D1352, avg=3D=
176.27, stdev=3D28.81
> > > > >=20
> > > > > Fedora 42 (6.14.5-300.fc42.x86_64)
> > > > >=20
> > > > > [root@localhost anton]# df -mh /mnt
> > > > > Filesystem=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Size=C2=A0 Used Avail Us=
e% Mounted on
> > > > > /dev/md127=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 35T=C2=A0 1.3T=C2=
=A0=C2=A0 34T=C2=A0=C2=A0 4% /mnt
> > > > >=20
> > > > > [root@localhost ~]# fio --name=3Dtest --rw=3Dread --bs=3D256k
> > > > > --filename=3D/dev/md127 --direct=3D1 --numjobs=3D1 --iodepth=3D64=
 --
> > > > > exitall
> > > > > --group_reporting --ioengine=3Dlibaio --runtime=3D30 --time_based
> > > > > test: (g=3D0): rw=3Dread, bs=3D(R) 256KiB-256KiB, (W) 256KiB-
> > > > > 256KiB,
> > > > > (T)
> > > > > 256KiB-256KiB, ioengine=3Dlibaio, iodepth=3D64
> > > > > fio-3.39-44-g19d9
> > > > > Starting 1 process
> > > > > Jobs: 1 (f=3D1): [R(1)][100.0%][r=3D41.0GiB/s][r=3D168k IOPS][eta
> > > > > 00m:00s]
> > > > > test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D5685: Sun May=C2=
=A0 4
> > > > > 10:14:00
> > > > > 2025
> > > > > =C2=A0 read: IOPS=3D168k, BW=3D41.0GiB/s (44.1GB/s)(1231GiB/30001=
msec)
> > > > > =C2=A0=C2=A0=C2=A0 slat (usec): min=3D3, max=3D273, avg=3D 5.63, =
stdev=3D 1.48
> > > > > =C2=A0=C2=A0=C2=A0 clat (usec): min=3D67, max=3D2800, avg=3D374.9=
9, stdev=3D29.90
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0 lat (usec): min=3D72, max=3D2914, avg=3D=
380.62, stdev=3D30.22
> > > >=20
> > > > So the MD block device shows the same read performance as the
> > > > filesystem on top of it. That means this is a regression at the
> > > > MD
> > > > device layer or in the block/driver layers below it. i.e. it is
> > > > not
> > > > an XFS of filesystem issue at all.
> > > >=20
> > > > -Dave.
> > >=20
> > > I have a lab setup, let me see if I can also reproduce and then
> > > trace
> > > this to see where it is spending the time
> > >=20
> >=20
> >=20
> > Not seeing 1/2 the bandwidth but also significantly slower on
> > Fedora42
> > kernel.
> > I will trace it
> >=20
> > 9.5 kernel - 5.14.0-503.40.1.el9_5.x86_64
> >=20
> > Run status group 0 (all jobs):
> > =C2=A0=C2=A0 READ: bw=3D14.7GiB/s (15.8GB/s), 14.7GiB/s-14.7GiB/s (15.8=
GB/s-
> > 15.8GB/s), io=3D441GiB (473GB), run=3D30003-30003msec
> >=20
> > Fedora42 kernel - 6.14.5-300.fc42.x86_64
> >=20
> > Run status group 0 (all jobs):
> > =C2=A0=C2=A0 READ: bw=3D10.4GiB/s (11.2GB/s), 10.4GiB/s-10.4GiB/s (11.2=
GB/s-
> > 11.2GB/s), io=3D313GiB (336GB), run=3D30001-30001msec
> >=20
> >=20
> >=20
> >=20
>=20
> Fedora42 kernel issue
>=20
> While my difference is not as severe we do see a consistently lower
> performance on the Fedora
> kernel. (6.14.5-300.fc42.x86_64)
>=20
> When I remove the software raid and run against a single NVME we
> converge to be much closer.
> Also latest upstream does not show this regression either.
>=20
> Not sure yet what is in our Fedora kernel causing this.=20
> We will work it via the Bugzilla
>=20
> Regards
> Laurence
>=20
> TLDR
>=20
>=20
> Fedora Kernel
> -------------
> root@penguin9 blktracefedora]# uname -a
> Linux penguin9.2 6.14.5-300.fc42.x86_64 #1 SMP PREEMPT_DYNAMIC Fri
> May
> 2 14:16:46 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
>=20
> 5 runs of the fio against /dev/md1
>=20
> [root@penguin9 ~]# for i in 1 2 3 4 5
> > do
> > ./run_fio.sh | grep -A1 "Run status group"
> > done
> Run status group 0 (all jobs):
> =C2=A0=C2=A0 READ: bw=3D11.3GiB/s (12.2GB/s), 11.3GiB/s-11.3GiB/s (12.2GB=
/s-
> 12.2GB/s), io=3D679GiB (729GB), run=3D60001-60001msec
> Run status group 0 (all jobs):
> =C2=A0=C2=A0 READ: bw=3D11.2GiB/s (12.0GB/s), 11.2GiB/s-11.2GiB/s (12.0GB=
/s-
> 12.0GB/s), io=3D669GiB (718GB), run=3D60001-60001msec
> Run status group 0 (all jobs):
> =C2=A0=C2=A0 READ: bw=3D11.4GiB/s (12.2GB/s), 11.4GiB/s-11.4GiB/s (12.2GB=
/s-
> 12.2GB/s), io=3D682GiB (733GB), run=3D60001-60001msec
> Run status group 0 (all jobs):
> =C2=A0=C2=A0 READ: bw=3D11.1GiB/s (11.9GB/s), 11.1GiB/s-11.1GiB/s (11.9GB=
/s-
> 11.9GB/s), io=3D664GiB (713GB), run=3D60001-60001msec
> Run status group 0 (all jobs):
> =C2=A0=C2=A0 READ: bw=3D11.3GiB/s (12.1GB/s), 11.3GiB/s-11.3GiB/s (12.1GB=
/s-
> 12.1GB/s), io=3D678GiB (728GB), run=3D60001-60001msec
>=20
> RHEL9.5
> ------------
> Linux penguin9.2 5.14.0-503.40.1.el9_5.x86_64 #1 SMP PREEMPT_DYNAMIC
> Thu Apr 24 08:27:29 EDT 2025 x86_64 x86_64 x86_64 GNU/Linux
>=20
> [root@penguin9 ~]# for i in 1 2 3 4 5; do ./run_fio.sh | grep -A1
> "Run
> status group"; done
> Run status group 0 (all jobs):
> =C2=A0=C2=A0 READ: bw=3D14.9GiB/s (16.0GB/s), 14.9GiB/s-14.9GiB/s (16.0GB=
/s-
> 16.0GB/s), io=3D894GiB (960GB), run=3D60003-60003msec
> Run status group 0 (all jobs):
> =C2=A0=C2=A0 READ: bw=3D14.6GiB/s (15.6GB/s), 14.6GiB/s-14.6GiB/s (15.6GB=
/s-
> 15.6GB/s), io=3D873GiB (938GB), run=3D60003-60003msec
> Run status group 0 (all jobs):
> =C2=A0=C2=A0 READ: bw=3D14.9GiB/s (16.0GB/s), 14.9GiB/s-14.9GiB/s (16.0GB=
/s-
> 16.0GB/s), io=3D892GiB (958GB), run=3D60003-60003msec
> Run status group 0 (all jobs):
> =C2=A0=C2=A0 READ: bw=3D14.5GiB/s (15.6GB/s), 14.5GiB/s-14.5GiB/s (15.6GB=
/s-
> 15.6GB/s), io=3D872GiB (936GB), run=3D60003-60003msec
> Run status group 0 (all jobs):
> =C2=A0=C2=A0 READ: bw=3D14.7GiB/s (15.8GB/s), 14.7GiB/s-14.7GiB/s (15.8GB=
/s-
> 15.8GB/s), io=3D884GiB (950GB), run=3D60003-60003msec
>=20
>=20
> Remove software raid from the layers and test just on a single nvme
> ---------------------------------------------------------------------
> -
>=20
> fio --name=3Dtest --rw=3Dread --bs=3D256k --filename=3D/dev/nvme23n1 --
> direct=3D1
> --numjobs=3D1 --iodepth=3D64 --exitall --group_reporting --
> ioengine=3Dlibaio
> --runtime=3D60 --time_based
>=20
> Linux penguin9.2 5.14.0-503.40.1.el9_5.x86_64 #1 SMP PREEMPT_DYNAMIC
> Thu Apr 24 08:27:29 EDT 2025 x86_64 x86_64 x86_64 GNU/Linux
>=20
> [root@penguin9 ~]# ./run_nvme_fio.sh
>=20
> Run status group 0 (all jobs):
> =C2=A0=C2=A0 READ: bw=3D3207MiB/s (3363MB/s), 3207MiB/s-3207MiB/s (3363MB=
/s-
> 3363MB/s), io=3D188GiB (202GB), run=3D60005-60005msec
>=20
>=20
> Back to fedora kernel
>=20
> [root@penguin9 ~]# uname -a
> Linux penguin9.2 6.14.5-300.fc42.x86_64 #1 SMP PREEMPT_DYNAMIC Fri
> May
> 2 14:16:46 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
>=20
> Within the margin of error
>=20
> Run status group 0 (all jobs):
> =C2=A0=C2=A0 READ: bw=3D3061MiB/s (3210MB/s), 3061MiB/s-3061MiB/s (3210MB=
/s-
> 3210MB/s), io=3D179GiB (193GB), run=3D60006-60006msec
>=20
>=20
> Try recent upstream kernel
> ---------------------------
> [root@penguin9 ~]# uname -a
> Linux penguin9.2 6.13.0-rc7+ #2 SMP PREEMPT_DYNAMIC Mon May=C2=A0 5
> 10:59:12
> EDT 2025 x86_64 x86_64 x86_64 GNU/Linux
>=20
> [root@penguin9 ~]# for i in 1 2 3 4 5; do ./run_fio.sh | grep -A1
> "Run
> status group"; done
> Run status group 0 (all jobs):
> =C2=A0=C2=A0 READ: bw=3D14.6GiB/s (15.7GB/s), 14.6GiB/s-14.6GiB/s (15.7GB=
/s-
> 15.7GB/s), io=3D876GiB (941GB), run=3D60003-60003msec
> Run status group 0 (all jobs):
> =C2=A0=C2=A0 READ: bw=3D14.8GiB/s (15.9GB/s), 14.8GiB/s-14.8GiB/s (15.9GB=
/s-
> 15.9GB/s), io=3D891GiB (957GB), run=3D60003-60003msec
> Run status group 0 (all jobs):
> =C2=A0=C2=A0 READ: bw=3D14.8GiB/s (15.9GB/s), 14.8GiB/s-14.8GiB/s (15.9GB=
/s-
> 15.9GB/s), io=3D890GiB (956GB), run=3D60003-60003msec
> Run status group 0 (all jobs):
> =C2=A0=C2=A0 READ: bw=3D14.5GiB/s (15.6GB/s), 14.5GiB/s-14.5GiB/s (15.6GB=
/s-
> 15.6GB/s), io=3D871GiB (935GB), run=3D60003-60003msec
>=20
>=20
> Update to latest upstream
> -------------------------
>=20
> [root@penguin9 ~]# uname -a
> Linux penguin9.2 6.15.0-rc5 #1 SMP PREEMPT_DYNAMIC Mon May=C2=A0 5
> 12:18:22
> EDT 2025 x86_64 x86_64 x86_64 GNU/Linux
>=20
> Single nvme device is once again fine
>=20
> Run status group 0 (all jobs):
> =C2=A0=C2=A0 READ: bw=3D3061MiB/s (3210MB/s), 3061MiB/s-3061MiB/s (3210MB=
/s-
> 3210MB/s), io=3D179GiB (193GB), run=3D60006-60006msec
>=20
>=20
> [root@penguin9 ~]# for i in 1 2 3 4 5; do ./run_fio.sh | grep -A1
> "Run
> status group"; done
> Run status group 0 (all jobs):
> =C2=A0=C2=A0 READ: bw=3D14.7GiB/s (15.7GB/s), 14.7GiB/s-14.7GiB/s (15.7GB=
/s-
> 15.7GB/s), io=3D880GiB (945GB), run=3D60003-60003msec
> Run status group 0 (all jobs):
> =C2=A0=C2=A0 READ: bw=3D18.1GiB/s (19.4GB/s), 18.1GiB/s-18.1GiB/s (19.4GB=
/s-
> 19.4GB/s), io=3D1087GiB (1167GB), run=3D60003-60003msec
> Run status group 0 (all jobs):
> =C2=A0=C2=A0 READ: bw=3D18.0GiB/s (19.4GB/s), 18.0GiB/s-18.0GiB/s (19.4GB=
/s-
> 19.4GB/s), io=3D1082GiB (1162GB), run=3D60003-60003msec
> Run status group 0 (all jobs):
> =C2=A0=C2=A0 READ: bw=3D18.2GiB/s (19.5GB/s), 18.2GiB/s-18.2GiB/s (19.5GB=
/s-
> 19.5GB/s), io=3D1090GiB (1170GB), run=3D60005-60005msec
>=20
>=20

This fell of my radar, I aologize and I was on PTO last week.
Here is the Fedora kernel to install as mentioned
https://people.redhat.com/loberman/customer/.fedora/

tar hxvf fedora_kernel.tar.xz
rpm -ivh --force --nodeps *.rpm

