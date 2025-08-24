Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F8914A8B
	for <linux-block@vger.kernel.org>; Sun, 24 Aug 2025 14:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756044376; cv=none; b=DCTRiSFD+tEffAXi5cH7IqcTzbs3xRVu+L8vDN49n55zhaiZu0+y8Nk4Yy5wNLO0fN/uERwOpQnGh2qW65WQst5dttEqUn0X4D2WaZannLu12EqDkQqeh9N3f+W3ml1qRvK/NTpdz0J2hYAyCrMT45r+t7rEg0CA66Sa5J4mMUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756044376; c=relaxed/simple;
	bh=nGemA6wR36SfaTX9FjGvqqAmcSomoWzFjaNl31BZnQU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=qaJuyW33+YvmtQHpvSyhiyy+CtJHaIo8HU70YjYkva18EA2wm+DaTeeu6Qt1LdcYDHzbE6aRm6QM3jQF/PvvAQUfCjFrhww07k6IUz2JaTRGm/meQ3WPG0FyKl/heOuFANBhmrH49IPYrr1BDbccpOglm7XXv7hXdk6p0jzhGfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gMn29BEQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gMn29BEQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756044371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=mX7J1uDxfUFvd7oWRu2x2D7y9Lt8VwYau0YW6qKiJxI=;
	b=gMn29BEQuoyYvi6aAl0bg/nqMxJkAUJKhqZFjr1rHz1vXMi5bS9/uk/RZDu1+pjhUahhQH
	nEvn19Khzl219XYxKpsbipTglwux0l75JawmhDPUaMEY/KPVIIt+quj5amPqJXRiKsMf+s
	KlCG2Dei6WB7EgzXrFaKr1KXvrKjWTA=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-o5gfE0WpMh-CEDaB1paIWQ-1; Sun, 24 Aug 2025 10:06:10 -0400
X-MC-Unique: o5gfE0WpMh-CEDaB1paIWQ-1
X-Mimecast-MFC-AGG-ID: o5gfE0WpMh-CEDaB1paIWQ_1756044369
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-55f3f8e33d3so513263e87.1
        for <linux-block@vger.kernel.org>; Sun, 24 Aug 2025 07:06:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756044367; x=1756649167;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mX7J1uDxfUFvd7oWRu2x2D7y9Lt8VwYau0YW6qKiJxI=;
        b=MBBkFSetiUB4g5U3WD2oEpnOiuNnb356gA9pXdafSpVJOo93h7aZmg7lY4eR6TxjaB
         0kjrhKcWb3Tt4QMFA/YPMeAnJ0GrvBS924pHuMadJ7Zb+y9ucDR1qe4HPwBEBpMETkmv
         Nk+QLHzhoW0yLYAWOMVW4glpRXDjaTo0nX5kk5tpQplVL2h3vsPXpcFOQAzSK08PBaUM
         0JDiRjLByFnbyD+m5R6VOKS4Z8n77LMGsWLOoliQbM0LiwAZkpQAUCugQH64eDuUFadX
         DgjjiY5iCba+J90IhbOtGMPu05CjnVW+AHf9sduZh7Ky0TbvvkO2O//7PdE2MThvjH7t
         2kpg==
X-Gm-Message-State: AOJu0YxAD0jPfqOYy7b6bUGH1jLHtSHNdZqe28A8RF6mHQp+e+oYwAPQ
	1eDN9mFK2CLPV0q3vH0yFmPSgAVTRh7MgroNnmT3Xa7pdwVjRSuxpW1EVflXQDfZKm1RFwkXn1D
	KeAd8lYBsVV8TM6GOJRkEgQ9jq9VkVH6ad7SDFWw5l3d2J5Ql/Jot1lZCEeln0WtjXnzAU4Ldtd
	7Sr16YvlDhsgh1bKZhBPjYi3ozQcVlwKnHW6pYw+lAbx+0rgLPiQ==
X-Gm-Gg: ASbGncs6j0vYBezfc1Y/uRuk8/e8rEvBR6hBOnwkgdf9qFMXb1LZk/GQs539ZWlBj4j
	Z4SpH4rzfevVBaRkCrf4SsQhYxoOs2ZMSfXmRXfOmnP2cT8A8p0MgXYgXMlNjCtKIpglqE2z919
	5nhQ2Mi+ZX//XVrFUFIkN7Zg==
X-Received: by 2002:a05:651c:2357:20b0:333:e4cf:d5d7 with SMTP id 38308e7fff4ca-33650dda6b2mr15524211fa.12.1756044367168;
        Sun, 24 Aug 2025 07:06:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE09qyj1F1hKutxBJDZZtN4iFm6oq8cKUMrqBr4L07Bcj87faKRwwDbPQvCEOvtlP0X+2b55XG1mfuj2ZlqqyU=
X-Received: by 2002:a05:651c:2357:20b0:333:e4cf:d5d7 with SMTP id
 38308e7fff4ca-33650dda6b2mr15524161fa.12.1756044366755; Sun, 24 Aug 2025
 07:06:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Sun, 24 Aug 2025 22:05:53 +0800
X-Gm-Features: Ac12FXwJKHU4HhdZzVJoJaIa8x9yQt-vgM85kSPyNzo4C76lvKEdpbyhSx1Xv2w
Message-ID: <CAHj4cs8+9S7_4H03_dcNS-wMrT_9iUpSWPF+ic5gRHmfC4dx+Q@mail.gmail.com>
Subject: [bug report][regression] blktests loop/004 failed
To: linux-block <linux-block@vger.kernel.org>
Cc: rajeevm@hpe.com, Ming Lei <ming.lei@redhat.com>, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset="UTF-8"

Hi

I found the blktests loop/004[1] failed on the latest
linux-block/for-next, and it was introduced from the commit[2] from my
testing,
please help check it and let me know if you need any info/testing, thanks.

[1]
# ./check loop/004
loop/004 (combine loop direct I/O mode and a custom block size) [failed]
    runtime  2.770s  ...  5.375s
    --- tests/loop/004.out 2025-08-24 01:41:06.768628600 -0400
    +++ /root/blktests/results/nodev/loop/004.out.bad 2025-08-24
10:01:44.489825116 -0400
    @@ -1,4 +1,5 @@
     Running loop/004
     1
    -769bd186841c10e5b1106b55986206c0e87fc05a7f565fdee01b5abcaff6ae78  -
    +pwrite: No space left on device
    +e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855  -
     Test complete
[2]
47b71abd5846 loop: use vfs_getattr_nosec for accurate file size
[3] dmesg
[  279.880860] run blktests loop/004 at 2025-08-24 10:01:38
[  280.249598] scsi_debug:sdebug_driver_probe: scsi_debug: trim
poll_queues to 0. poll_q/nr_hw = (0/1)
[  280.259112] scsi host10: scsi_debug: version 0191 [20210520]
                 dev_size_mb=8, opts=0x0, submit_queues=1, statistics=0
[  280.289850] scsi 10:0:0:0: Direct-Access     Linux    scsi_debug
   0191 PQ: 0 ANSI: 7
[  280.302147] scsi 10:0:0:0: Power-on or device reset occurred
[  280.336792] sd 10:0:0:0: Attached scsi generic sg5 type 0
[  280.342300] sd 10:0:0:0: [sdf] 2048 4096-byte logical blocks: (8.39
MB/8.00 MiB)
[  280.343809] sd 10:0:0:0: [sdf] Write Protect is off
[  280.343925] sd 10:0:0:0: [sdf] Mode Sense: 73 00 10 08
[  280.347889] sd 10:0:0:0: [sdf] Write cache: enabled, read cache:
enabled, supports DPO and FUA
[  280.355174] sd 10:0:0:0: [sdf] permanent stream count = 5
[  280.359355] sd 10:0:0:0: [sdf] Preferred minimum I/O size 4096 bytes
[  280.359503] sd 10:0:0:0: [sdf] Optimal transfer size 4194304 bytes
[  280.506461] sd 10:0:0:0: [sdf] Attached SCSI disk
[  285.158954] sd 10:0:0:0: [sdf] Synchronizing SCSI cache

-- 
Best Regards,
  Yi Zhang

