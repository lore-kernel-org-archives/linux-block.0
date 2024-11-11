Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CCD155382
	for <linux-block@vger.kernel.org>; Mon, 11 Nov 2024 07:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731309643; cv=none; b=T/c37BAZsB/d7kGHdr0vUFpcMLAtl2VxaDVEGG+7OEibN8xhqopwbe0ZNipbCS2isMLp2vglTaypFgL081redyVqbZU7Ay1G8Ux+Ao7f5RzRSiYAd1Hh2cr7SaQpfLnr2Em0dAUCLOVMH4jSUS8DUwhssNx0TzBLqmHiBs0FEN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731309643; c=relaxed/simple;
	bh=2BApFlK1J/dcKJTFvdQMMeBu4sujMW4HYzzpTBwqlus=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=uZsDBqLTxMnOH52H2LSlyRrAjVbI1L6O+yGb7VE6gQnSMsqJ7y5UQsNQirMXCb0nwZeE5bbB1+m76E7hOmaCHnU+dJEF4Q2PMURBKrvyBBr3WxuMYAZcOnCldNxfVIgMHl9VtqxlNv+gYjEH2YPQbO6zykLOgVT+rd4LDI8BRdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aNDo9CZM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aNDo9CZM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731309640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=GJ1AuVG23mOikcqNf/gsqClWSrvCjqTRMPTWIiYeHOA=;
	b=aNDo9CZMCKa/fYkBemH5Fp8s/qxqNRSsyX4Akwfui4jXDL6fv+yvUguQ/sK70Vhr38DMfV
	XUE2tYv6xvc8Fq7DQtBip1wWYrtuoZRCSnGemY1zzY2HjJgH/JLEv31d3AVCeR5fSlkPMG
	Ys2vQOwkwW3LQpzmV+I8H5dUw6mL/qc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-Zz6BCMQGOQWW7KQOPXtWbw-1; Mon, 11 Nov 2024 02:20:35 -0500
X-MC-Unique: Zz6BCMQGOQWW7KQOPXtWbw-1
X-Mimecast-MFC-AGG-ID: Zz6BCMQGOQWW7KQOPXtWbw
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a9e0eb26f08so380649566b.0
        for <linux-block@vger.kernel.org>; Sun, 10 Nov 2024 23:20:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731309633; x=1731914433;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GJ1AuVG23mOikcqNf/gsqClWSrvCjqTRMPTWIiYeHOA=;
        b=WMwEtpyo7OWN+rHaaQMljWEalXivb5Vapu5kf0T0qPEYmqcWwent43/3/QnrvKTehv
         IrM2bhcnUNRwjeEh4amH7rkv1ifYpzdEfFRWGLcptyF6QPJF6/ICSq3Kub6ft+A+0mZ/
         z8bEkvSoCYAzPxEbxjOC/n0FYbCrnfaO7l7DskEJLcHaIjfYwHGKrfY8lSBxNIwGFG9m
         sqRsNwnPM7kbwM2lH3LXOo2wSViFafKRWxYhfYJ6V//xaLSfKz++Tf6Ja9fj8jtlxjcm
         aZeXtVcjKlDPxgSFZu6ni32EaG80Ultej+K4+A2xARNO414bBlKh7/MH7KYyaSJ9xIFm
         XtBA==
X-Gm-Message-State: AOJu0YynSu0FwhGPfnFtHijXXe02nEZoS4+CRYHRl4seHkm5GEXO55Yo
	VUNSLWG2SzNUf2YAlGQeKLQ8A0+BVUobR/4ZoCyT2yKBWoEW7rkmh/ZP3XrtYlJseQlk/Jr5CvV
	j1wVh608fsyV2mmTbadm4ainK2i2LoufBmChYtNTSILHxNy8OtjMKBulCpS47Xucuri3eezOa4x
	XJl0JctZPrJGYVjNYOcqZ+PwXxuQmc130YLZmcO6mLlKPAcw==
X-Received: by 2002:a17:907:6d24:b0:a99:36ab:d843 with SMTP id a640c23a62f3a-a9eefff1217mr1159369966b.38.1731309633494;
        Sun, 10 Nov 2024 23:20:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMYVEoVq7kx6QoXmygKFXHUtL99RMAa6gitdjwB2OtPN3Cxl32/faHQAGrIP2fFtyK0SPUVand6r0EykMNFIE=
X-Received: by 2002:a17:907:6d24:b0:a99:36ab:d843 with SMTP id
 a640c23a62f3a-a9eefff1217mr1159367866b.38.1731309633145; Sun, 10 Nov 2024
 23:20:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Guangwu Zhang <guazhang@redhat.com>
Date: Mon, 11 Nov 2024 15:20:22 +0800
Message-ID: <CAGS2=YqYbvNi6zu8e9e=R+gZMKwY_LegK2vi2MSgdsL1pMyDLA@mail.gmail.com>
Subject: [bug report] fio failed with --fixedbufs
To: linux-block@vger.kernel.org, io-uring@vger.kernel.org, 
	Ming Lei <ming.lei@redhat.com>, Jeff Moyer <jmoyer@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Hi,

Get the fio error like below, please have a look if something wrong  here,
can not reproduce it if remove "--fixedbufs".

Kernel repo: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
Commit: 51b3526f50cf5526b73d06bd44a0f5e3f936fb01

# fio --numjobs=1 --ioengine=io_uring_cmd --runtime='300'
--size='300G' --filename=/dev/ng1n1 --rw='randrw' --name='fio_test'
--iodepth=64 --bs=8k --group_reporting=1 --cmd_type='nvme'
--md_per_io_size='4K'  --fixedbufs
fio_test: (g=0): rw=randrw, bs=(R) 8192B-8192B, (W) 8192B-8192B, (T)
8192B-8192B, ioengine=io_uring_cmd, iodepth=64
fio-3.38-13-gf241
Starting 1 process
fio: io_u error on file /dev/ng1n1: Bad address: read
offset=314721697792, buflen=8192
fio: io_u error on file /dev/ng1n1: Bad address: read
offset=278937288704, buflen=8192
fio: io_u error on file /dev/ng1n1: Bad address: read
offset=211560456192, buflen=8192
fio: io_u error on file /dev/ng1n1: Bad address: write
offset=166314262528, buflen=8192
fio: io_u error on file /dev/ng1n1: Bad address: read
offset=194210742272, buflen=8192
fio: io_u error on file /dev/ng1n1: Bad address: read
offset=314948960256, buflen=8192
fio: io_u error on file /dev/ng1n1: Bad address: write
offset=4652392448, buflen=8192
fio: io_u error on file /dev/ng1n1: Bad address: write
offset=72851734528, buflen=8192
fio: io_u error on file /dev/ng1n1: Bad address: write
offset=105412198400, buflen=8192
fio: io_u error on file /dev/ng1n1: Bad address: read
offset=269298982912, buflen=8192
fio: io_u error on file /dev/ng1n1: Bad address: write
offset=217188352000, buflen=8192
fio: io_u error on file /dev/ng1n1: Bad address: read
offset=182140698624, buflen=8192
fio: io_u error on file /dev/ng1n1: Bad address: write
offset=306352644096, buflen=8192
fio: io_u error on file /dev/ng1n1: Bad address: read
offset=123246698496, buflen=8192
fio: io_u error on file /dev/ng1n1: Bad address: read
offset=4156350464, buflen=8192
fio: io_u error on file /dev/ng1n1: Bad address: read
offset=240869728256, buflen=8192
fio: io_u error on file /dev/ng1n1: Bad address: write
offset=257956913152, buflen=8192
fio: io_u error on file /dev/ng1n1: Bad address: write
offset=157641924608, buflen=8192
fio: io_u error on file /dev/ng1n1: Bad address: read
offset=248337874944, buflen=8192
fio: io_u error on file /dev/ng1n1: Bad address: read
offset=192326352896, buflen=8192
fio: io_u error on file /dev/ng1n1: Bad address: write
offset=59785117696, buflen=8192
fio: io_u error on file /dev/ng1n1: Bad address: write
offset=159764578304, buflen=8192
fio: io_u error on file /dev/ng1n1: Bad address: write
offset=113134592000, buflen=8192
fio: io_u error on file /dev/ng1n1: Bad address: write
offset=162308825088, buflen=8192
fio: io_u error on file /dev/ng1n1: Bad address: read
offset=150173917184, buflen=8192
fio: io_u error on file /dev/ng1n1: Bad address: write
offset=14641209344, buflen=8192
fio: io_u error on file /dev/ng1n1: Bad address: read
offset=271883075584, buflen=8192
fio: io_u error on file /dev/ng1n1: Bad address: write
offset=55705149440, buflen=8192
fio: io_u error on file /dev/ng1n1: Bad address: write
offset=258477580288, buflen=8192
fio: io_u error on file /dev/ng1n1: Bad address: write
offset=34678931456, buflen=8192
fio: io_u error on file /dev/ng1n1: Bad address: write
offset=311085285376, buflen=8192
fio: io_u error on file /dev/ng1n1: Bad address: read
offset=129028251648, buflen=8192
fio: io_u error on file /dev/ng1n1: Bad address: read
offset=195086909440, buflen=8192
fio: io_u error on file /dev/ng1n1: Bad address: write
offset=300242763776, buflen=8192
fio: io_u error on file /dev/ng1n1: Bad address: read
offset=310458490880, buflen=8192
fio: io_u error on file /dev/ng1n1: Bad address: write
offset=91683938304, buflen=8192
fio: io_u error on file /dev/ng1n1: Bad address: write
offset=142651342848, buflen=8192
fio: io_u error on file /dev/ng1n1: Bad address: read
offset=225977384960, buflen=8192
fio: io_u error on file /dev/ng1n1: Bad address: read
offset=271599779840, buflen=8192
fio: io_u error on file /dev/ng1n1: Bad address: write
offset=52967882752, buflen=8192
fio: io_u error on file /dev/ng1n1: Bad address: write
offset=303015387136, buflen=8192
fio: io_u error on file /dev/ng1n1: Bad address: read
offset=273026170880, buflen=8192
fio: io_u error on file /dev/ng1n1: Bad address: write
offset=318919712768, buflen=8192
fio: io_u error on file /dev/ng1n1: Bad address: read
offset=185858064384, buflen=8192
fio: io_u error on file /dev/ng1n1: Bad address: read
offset=291365412864, buflen=8192
fio: io_u error on file /dev/ng1n1: Bad address: write
offset=170794999808, buflen=8192
fio: io_u error on file /dev/ng1n1: Bad address: write
offset=31619899392, buflen=8192
fio: io_u error on file /dev/ng1n1: Bad address: read
offset=240495542272, buflen=8192
fio: io_u error on file /dev/ng1n1: Bad address: write
offset=185245155328, buflen=8192
fio: io_u error on file /dev/ng1n1: Bad address: write
offset=65555390464, buflen=8192
fio: io_u error on file /dev/ng1n1: Bad address: write
offset=290169774080, buflen=8192
fio: io_u error on file /dev/ng1n1: Bad address: read
offset=199942692864, buflen=8192
fio: io_u error on file /dev/ng1n1: Bad address: read
offset=11003101184, buflen=8192
fio: io_u error on file /dev/ng1n1: Bad address: write
offset=147007119360, buflen=8192
fio: io_u error on file /dev/ng1n1: Bad address: read
offset=48097304576, buflen=8192
fio: io_u error on file /dev/ng1n1: Bad address: write
offset=178375688192, buflen=8192
fio: io_u error on file /dev/ng1n1: Bad address: read
offset=138726440960, buflen=8192
fio: io_u error on file /dev/ng1n1: Bad address: write
offset=239489859584, buflen=8192
fio: io_u error on file /dev/ng1n1: Bad address: write
offset=142543421440, buflen=8192
fio: io_u error on file /dev/ng1n1: Bad address: read
offset=73279242240, buflen=8192
fio: io_u error on file /dev/ng1n1: Bad address: read
offset=16768991232, buflen=8192
fio: io_u error on file /dev/ng1n1: Bad address: write
offset=252541501440, buflen=8192
fio: io_u error on file /dev/ng1n1: Bad address: write
offset=269492428800, buflen=8192
fio: pid=112524, err=14/file:io_u.c:1976, func=io_u error, error=Bad address

fio_test: (groupid=0, jobs=1): err=14 (file:io_u.c:1976, func=io_u
error, error=Bad address): pid=112524: Mon Nov 11 02:05:53 2024
  write: IOPS=35.0k, BW=8000KiB/s (8192kB/s)(8192B/1msec); 0 zone resets
    slat (nsec): min=576, max=20959, avg=1331.14, stdev=3417.56
    clat (nsec): min=59294, max=59294, avg=59294.00, stdev= 0.00
     lat (nsec): min=80253, max=80253, avg=80253.00, stdev= 0.00
    clat percentiles (nsec):
     |  1.00th=[59136],  5.00th=[59136], 10.00th=[59136], 20.00th=[59136],
     | 30.00th=[59136], 40.00th=[59136], 50.00th=[59136], 60.00th=[59136],
     | 70.00th=[59136], 80.00th=[59136], 90.00th=[59136], 95.00th=[59136],
     | 99.00th=[59136], 99.50th=[59136], 99.90th=[59136], 99.95th=[59136],
     | 99.99th=[59136]
  lat (usec)   : 100=1.56%
  cpu          : usr=0.00%, sys=0.00%, ctx=0, majf=0, minf=9
  IO depths    : 1=1.6%, 2=3.1%, 4=6.2%, 8=12.5%, 16=25.0%, 32=50.0%, >=64=1.6%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=66.7%, 8=0.0%, 16=0.0%, 32=0.0%, 64=33.3%, >=64=0.0%
     issued rwts: total=29,35,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
  WRITE: bw=8000KiB/s (8192kB/s), 8000KiB/s-8000KiB/s
(8192kB/s-8192kB/s), io=8192B (8192B), run=1-1msec




-- 
Guangwu Zhang
Thanks

