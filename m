Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com [209.85.222.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C105C3218B3
	for <linux-block@vger.kernel.org>; Sat, 17 Jan 2026 02:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768618302; cv=none; b=dO+QqJj/Sxf/2QwkLQ6QS1SmK3IjsAkDcISEdUcm4N3JILwbvU0kIGGJneD7F9vDyO0A8anNq5ac827qeG88YFWKQtpnJ0Kr88mrWVEeaQRik04e0FiP910mrDjEyqD8mbSDUtoH8jHE+S29b0OBJw7V33JD7Eq2PeCzS9W1YTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768618302; c=relaxed/simple;
	bh=JR2lB6SpwQyYKrn3A+sb/GAiufPu5j/SZUDtKHTacRg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TynL13/87A6hgrpaaCvLy9d0pT8mrnt4o/reAFFN57l4ks3muGc7SJC7FOB1VSjbGJ0WlibSWCdQGBWosoA6q42GC8OCpkCwpwmVtFgYLy+40VLoRn7nNPFdjxvg0Ht+XYdMNeM1Zf1pHaCnozh55KBrlmZciwZdmRX4zHPs5hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iei1Y9D1; arc=none smtp.client-ip=209.85.222.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iei1Y9D1"
Received: by mail-qk1-f193.google.com with SMTP id af79cd13be357-8c07bc2ad13so188099085a.2
        for <linux-block@vger.kernel.org>; Fri, 16 Jan 2026 18:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768618299; x=1769223099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g52RCNxKP5yWPLz6Ydp2XilgQT0ikaZD3cfRfzbViX4=;
        b=Iei1Y9D1hiBbSXQkhJ7pRvzkEU10RXKvJeHPQOp9PPInZ8tvYcE1TdRNaEHwuk6oN8
         t21rWkSnnNL6I4utjSmlyRM3IisRWFxXHu6yy0OO6rPMLquEgR0Ptv0bK4i6T+gYWdVx
         LE6d59KAKMpg6P7kXwdzFdoqbMDfWnAGHDIWazEjLatBLkpug4QYmEgVb4Cih1F/XKD5
         j1TMyQp7i6SO/GUqA+2mCtWpJG2rB+eVOqX1v5cehsD/cbjerRJ0qyZrmgV7VKvdSUAE
         7Z4nTLQsn5PkFz47fnymQ7qmXZGWyDC8dGSboAN+i1UpENeP5CXTrydvs4KopOR/RKif
         BPrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768618299; x=1769223099;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g52RCNxKP5yWPLz6Ydp2XilgQT0ikaZD3cfRfzbViX4=;
        b=mFMvpMrJW+kin3qOKdAOYd4k5SSLOiYm6DFY/ZBeUcvRL8iO1FkPA+Mo2v3qsUqmxf
         huSa1aRUp5Y3JZ4iQPodIMV5in7j4iNtX5+OTu9LHEBPhNszy9oh6XUCRBZEqBJD3mU1
         /nuOjIdYvsvYk2vSelpHff4E6ICp1d0rhIFOZvt2VEEpfPMDoF59sWwuqSGe3E4UgLRs
         rJQv/X1uH2wPFHVu57H+Ag7GD09chrMBsqYLgoK7jMD/Js5M4ZTblxxbHnMaXUT7VInU
         92KZzpJ4aRFnB9HWf+AKx18t4GvDChK9fNe9N4FApqF/Fxs36E1w/WiPs95fBeqnsXOb
         9m4w==
X-Gm-Message-State: AOJu0YzRDkh7GW98edg3NmXBzYb2ac6TJofoX9do4ZXPgJAK09zZUgoV
	ph2CBw0mRiluwV1gjgP8/pvemLnyp47aGE539wvQvgjPX2NuHyxc9mkN12JhiBHtc08=
X-Gm-Gg: AY/fxX6PprPTIUJR7ctVW2VVQvLRWjLMQg4czxZ1DLor5FM6QYOL0/H4vQYP+RPqJMJ
	Ioq9HmbNwCKwsy+f1r8d51uzkgrbCPd3xqgvttPaCBUstu6zQ0ZBLdvF5TlUZyQDhxUQejqLk8T
	3/P4uC//BZbVwcQG/jBjIi7c1i3wN85+4oqg+DuT0NvKALpFMgUGySfpG+8ujS3U2hpj4zYlpuv
	z8c3sjpXcsvoFFiQH6HAwIS7zsp04eVVfSQxYsnwFMxUsF7GRPWqIv5JfPVQ89mers09zCzKsVX
	6Ujfbvk07BuS4/COtbD2lEcLXpPKnd8rMwWURUZmsbVITd2cAjop5AzMqY8OWURsL6/elE5Ja7H
	jB6/BBixjYYagP0EqW9uErtwLbLg/DJffVGTIfwaHinQI5bXS+NO4SwE/+H+dN3f47lY5eEUQyl
	TM9ao446q6mKDx5Sqw06wg
X-Received: by 2002:a05:620a:254a:b0:8c3:6f44:46c0 with SMTP id af79cd13be357-8c6a66edbd8mr718053085a.16.1768618299277;
        Fri, 16 Jan 2026 18:51:39 -0800 (PST)
Received: from biancapradeep.lan ([2605:a601:a619:8500::8])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8942e603a8bsm37163326d6.17.2026.01.16.18.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 18:51:38 -0800 (PST)
From: Hithashree Bojanala <bojanalahithashri@gmail.com>
To: linux-block@vger.kernel.org
Cc: bojanala hithashri <bojanalahithashri@gmail.com>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: =?UTF-8?q?=5BREGRESSION=5D=20fio=204k=20randread=3A=20=7E1=E2=80=933=2E5=25=20IOPS=20regression=20on=20linux-next=20=286=2E19=2E0-rc1-next-20251219=29=20vs=20RHEL9=205=2E14=20on=20PERC=20H740P?=
Date: Fri, 16 Jan 2026 21:44:07 -0500
Message-ID: <20260117024413.484508-2-bojanalahithashri@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: bojanala hithashri <bojanalahithashri@gmail.com> 


Hello,

I am reporting a small but consistent block I/O performance regression
observed when running 4k random reads across queue depths on a hardware
RAID device.

The regression appears when comparing a RHEL9 downstream kernel against
a linux-next snapshot.

System / Hardware
-----------------
CPU:   
      Model: Intel Xeon Gold 6130 @ 2.10GHz
      Architecture: x86_64
      Sockets: 2
      Cores per socket: 16
      Threads per core: 2
      NUMA nodes: 2
Memory: 
      Total: 187 GB
      NUMA nodes: 2
      Node 0: ~94 GB
      Node 1: ~97 GB
      Swap: 4 GB (unused during test)

Storage controller:
  Dell PERC H740P (hardware RAID)

Block device:
  /dev/sdh

lsblk output:
  NAME MODEL           SIZE ROTA TRAN SCHED
  sdh  PERC H740P Adp  1.6T    1      mq-deadline

Active scheduler:
  /sys/block/sdh/queue/scheduler
    none [mq-deadline] kyber bfq

Kernels Tested
--------------
Baseline (downstream):
  5.14.0-427.13.1.el9_4.x86_64

Test (upstream integration tree):
  6.19.0-rc1-next-20251219

Workload / Reproducer
---------------------
fio version: 3.35
Raw block device, direct I/O, libaio, single job, long runtime (300s)

Command used:

for depth in 1 2 4 8 16 32 64 128 256 512 1024 2048; do
  fio --rw=randread \
      --bs=4096 \
      --name=randread-$depth \
      --filename=/dev/sdh \
      --ioengine=libaio \
      --numjobs=1 --thread \
      --norandommap \
      --runtime=300 \
      --direct=1 \
      --iodepth=$depth \
      --scramble_buffers=1 \
      --offset=0 \
      --size=100g
done

Observed Behavior
-----------------
Across all queue depths tested, the linux-next kernel shows:

- ~1–3.5% lower IOPS
- Corresponding bandwidth reduction
- ~1–3.6% higher average completion latency
- Slightly worse p99 / p99.9 latency

The throughput saturation point remains unchanged
(around iodepth ≈ 128), suggesting the regression is
related to service/dispatch efficiency rather than a
change in device limits.

Example Data Points
-------------------
- iodepth=32:
    old: 554 IOPS → new: 535 IOPS  (~-3.4%)
    avg clat: 57.7 ms → 59.8 ms

- iodepth=64:
    old: 608 IOPS → new: 588 IOPS  (~-3.3%)
    avg clat: 105 ms → 109 ms

- iodepth=128:
    old: 648 IOPS → new: 640 IOPS (~-1.2%)

This behavior is consistent across multiple runs.

Notes
-----
I understand this comparison spans a downstream RHEL kernel
and a linux-next snapshot. I wanted to report this early
because the regression is consistent and may relate to recent
blk-mq or mq-deadline changes affecting rotational / hardware
RAID devices.

I am happy to:
- Re-test on a specific mainline release (e.g. v6.18 or v6.19-rc)
- Compare schedulers (mq-deadline vs none / bfq)
- Provide additional instrumentation (iostat, perf, bpf)
- Assist with bisection if a suspect window is identified

Please let me know how you would like me to proceed.

Thanks,
Hithashree
