Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F1F43147
	for <linux-block@vger.kernel.org>; Fri,  3 Apr 2026 08:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775205997; cv=pass; b=InaCIAaWIb2NeiSTVQD95FWGklBwCgr/Jc0Wg+YpH4uMSk0zr/CvlME5Zurrnp0OGI/fQ6qwkpP7uyd6HTeF5EU3bWBfTjpFRJBzssJNpGFs1IK2WxLJii2rwrpK/cbi1swzJqjcfD7gAC6Asq10XnPsITADj267i4HmFjY/JCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775205997; c=relaxed/simple;
	bh=lK4z/soybLHqUrAnHMP+0DuYZGd5ISSUIXevv6smCqg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=FNxn3IPcF3KtGTPGqWD0NhsU5e2ZfD0Y14vOopIrrGSKEYDO/9vu0DXg4awKyF76RHtCE0KEQ1LQuSDcaSxPuEqbLSEC9wmv5UJpzhgd7teEzYgPuJxA17zhYIzLoryXbDOJTTKtTyJFyKPu59SpojBNfDlWM6eGjDLkXygBb1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DUr+LrCB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=s8uf8Pyw; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DUr+LrCB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="s8uf8Pyw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775205994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=fCwNU7Sp3CYoOqCOWrviSarlb23sn7PdteY27S6tMKU=;
	b=DUr+LrCBWfZY7DDBnzTyUUQgBGCLh/h1rypRJbMHR7Ica3FW6mbW+G5etXXe1wTvbvzRSk
	qaLND7n9exUBK/DemEIUQAZpK8FHPF1cUifgHRjPi0sHl9NmCyF4UtXtXUkSSHt300cboP
	y7nwCnOlCOvMKCLjIqSJxtpk5FXEbv8=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-pDTc0ThUNdCPJtsQeYApng-1; Fri, 03 Apr 2026 04:46:32 -0400
X-MC-Unique: pDTc0ThUNdCPJtsQeYApng-1
X-Mimecast-MFC-AGG-ID: pDTc0ThUNdCPJtsQeYApng_1775205991
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-38a7fe9b5deso8107151fa.0
        for <linux-block@vger.kernel.org>; Fri, 03 Apr 2026 01:46:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775205989; cv=none;
        d=google.com; s=arc-20240605;
        b=AaFIkICIlyV3LJ//bie44oVMzk5QziF0oIyigkwdvI4VnnuwVgEcVTDJkBcNJmlB+W
         A+PSQ54P+OVweyLpfS2I7SEu4QKaPqp1Sb751wBXHO+Pkg2qebcnQXJfuiXE79BHvWi8
         2uXyW4nAo8cOaENIhTdxObl2LbLXky/G9C667hc1ILEoA3cfF4L58Y8QTgZMurLhF7yw
         9oiJAtlFTVMro1IIVzcjm/j6niRsewvI6LbokuTiC0CGc3iQc0Z6eoJfiyLSMoYckPRG
         70Hque0WYebHfeA4JMKS2FCrStfgvn544m9Kw4o1ff7fkvoSwFd77SAHA5ASI0s7OSbh
         rWJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=fCwNU7Sp3CYoOqCOWrviSarlb23sn7PdteY27S6tMKU=;
        fh=/Z+v3+1qCLvk7TpZ32adrb63Q0R2hJOO5raNiww7xoY=;
        b=FwXQlfC/Bf5AqexnJdDaJdYvAgTTgvCKhyCDwJTRfz3MUUeonsyeCctJKrKgc6PQK3
         RmcNAYEvCe22MVRaRW0KqMhaUBL4XicVjuZPwWZqOiCrnHrrO4lFnxFNlj944OjxRyu2
         77s9r313FInvvIpgSqerSEK3GV+XaZ2k65Cel5H4bJ7tqFuEqN9udJDfNyCmMaPyqplU
         rkbU2qIR4zBcHRbO+MP9KLWQeesW9fDRpVsGOggYjmMX4yczHnvkxHoH3Bh9bUhVoNxG
         g51E4rKZvddtHtnvgtBPUwBEjJ4qVbvg7KtpPJTmEmmOKjRoFQ/qk0EkxdFAZ9Vl990G
         koFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775205989; x=1775810789; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fCwNU7Sp3CYoOqCOWrviSarlb23sn7PdteY27S6tMKU=;
        b=s8uf8PywMltvnOQEB3AQ2KehjfI69418YSAR1b6vImY6C+Nd1n3cp6cx0SSYiIhT5T
         MdvdH05ooS1OluH9ojcUFsUT9g9DP87l4DRoBeqXyPGGKGKvTqV1e0QUaTDm3q4UmQjl
         IUTvPluIJBf+UWOLpZ1fFXxBfYJcRvGamMwChI+xl3Z+ZIOG5RYTa3cgwHf/WvtMZqcx
         IBvtBxn44hqF4pfHBwLnNxgauygTrsnmd2XU6cYC47+C5Ceca2GQk1eizloooI+szsBb
         pPZhT8CN9AkJOo4q4iT2x7GB+R/gH3IOIN+Y/2LMpuqJAV7eOSz9pKfWNK/7oh4ngdng
         iglA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775205989; x=1775810789;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fCwNU7Sp3CYoOqCOWrviSarlb23sn7PdteY27S6tMKU=;
        b=sxcDC9VsiKcnYbsxR27TZ6vYvgQNRLECybhPqDx5eb62ZQpVFMCZDp5JxtPJ2NfJR8
         CgD6i6FrocbrVn++XXe29H+j3bklIly0tGZZaxngBKcEmY1/PeDGf3s9glZShEsaL7IR
         CHQXfsAZyhxC71Qx1E5UFoQM05VVGhB0gsHssMxnrAxSRSdbVfP1rFClQoDpjRMtooSZ
         2pJavOmkMISwDw7NuSUiuk6zRRR+66VAECoGbKlpKjPIM/f5koPyjGSN/XSsycctX39+
         0JBxLJ5oF6Kqnw7t7Xa35omBgFdD9ReWolmq9zrgtgRgxSMwiqdkF7NwYMF6IN3p0ZgI
         vtww==
X-Gm-Message-State: AOJu0YxTH6HleTNseOVzY98Grfe9Du3Uh69gxAzHW89LQIhqj0KnIph5
	bT19grZ0A9iVxpUlyYPXx6MEjmjvrwSOL4hXjxA76FWUI5a9qw/3O+tFhrlNj/jckKwDh5uHwbn
	OPoR+4CqiRHLuYl18hEcDJq4eaqNSZ+m9J6zOeCTyLNQHExZ1bG5DGabXBUjZbfBpmjCukY4WoZ
	PV/qOmOHlGaALUq/LBcLIsyYfCgNN39QfjvcYjdzoIKbm0CXM2yQ==
X-Gm-Gg: AeBDiess2/R8TVfFg9t6WjgcwFYWgVtkYp+aet2DPX2nQXCkFK8vFDUB1PBfxRAEoX6
	G7DPfkr5lO69TL4Y4VOeGhrH29SlThjTo/SF5TlSV/VKI6nvib64X5bwwiH84h/i4PButOYb1lX
	nQ+wSjOzrfdDDkj61hOPpYlHmDxDW7ruDLBZyI1xM7QrlsqQRW//jY0f4gMAfsONiwDMMnTEbsX
	8Dh26Cvn/8mF4gNvpa/4GaP68B9b11ZttwiUFjDfpPUcKlOkgw=
X-Received: by 2002:a05:651c:2119:b0:387:e49:cd1d with SMTP id 38308e7fff4ca-38d97871bb0mr6533301fa.15.1775205989115;
        Fri, 03 Apr 2026 01:46:29 -0700 (PDT)
X-Received: by 2002:a05:651c:2119:b0:387:e49:cd1d with SMTP id
 38308e7fff4ca-38d97871bb0mr6533241fa.15.1775205988551; Fri, 03 Apr 2026
 01:46:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Fri, 3 Apr 2026 16:46:15 +0800
X-Gm-Features: AQROBzAQ78fwkXubOgtbZaqx8rqq2RB-a-89zkthjSFZ4eCs7txZci810HEA3qA
Message-ID: <CAHj4cs-u3MWQR4idywptMfjEYi4YwObWFx4KVib35dZ5HMBDdw@mail.gmail.com>
Subject: [bug report]nvmet_auth kmemleak observed during blktests
To: linux-block <linux-block@vger.kernel.org>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset="UTF-8"

Hi

I found the following kmemleak during blktests on the
linux-block/for-next, please help check it and let me know if you need
any test/info for it, thanks.

commit:
aac56c7b77fa (HEAD -> for-next, origin/for-next) Merge branch
'for-7.1/io_uring' into for-next

reproducer:
nvme_trtype=loop ./check nvme/041 nvme/042 nvme/043 nvme/044 nvme/045
nvme/051 nvme/052

kmemleak:
unreferenced object 0xff11000305c48240 (size 32):
  comm "kworker/u48:3", pid 123223, jiffies 4401374163
  hex dump (first 32 bytes):
    30 1e 78 66 9b 04 e7 4a d5 d7 a3 a2 ab 1f f1 22  0.xf...J......."
    11 4a aa 11 b5 f7 fa f6 24 a6 17 11 e6 f8 e7 dc  .J......$.......
  backtrace (crc 58405ce8):
    __kmalloc_noprof+0x635/0x870
    nvmet_auth_challenge+0x329/0x9f0 [nvmet]
    nvmet_execute_auth_receive+0x381/0x7b0 [nvmet]
    process_one_work+0xd98/0x1390
    worker_thread+0x60b/0x1000
    kthread+0x36c/0x470
    ret_from_fork+0x5dc/0x8e0
    ret_from_fork_asm+0x1a/0x30
unreferenced object 0xff1100027be14c00 (size 256):
  comm "kworker/u48:3", pid 123223, jiffies 4401374168
  hex dump (first 32 bytes):
    30 96 ec 83 33 bb fc 41 ec 81 70 14 1e ad 32 fd  0...3..A..p...2.
    39 b8 ca 9c 99 22 ff 28 f0 80 f3 e0 1d 82 36 a9  9....".(......6.
  backtrace (crc e365275d):
    __kmalloc_noprof+0x635/0x870
    nvmet_auth_ctrl_sesskey+0xfa/0x3a0 [nvmet]
    nvmet_auth_reply+0x436/0xd00 [nvmet]
    nvmet_execute_auth_send+0xc7f/0x14f0 [nvmet]
    process_one_work+0xd98/0x1390
    worker_thread+0x60b/0x1000
    kthread+0x36c/0x470
    ret_from_fork+0x5dc/0x8e0
    ret_from_fork_asm+0x1a/0x30
unreferenced object 0xff11000305c48d40 (size 32):
  comm "kworker/u48:3", pid 123223, jiffies 4401374170
  hex dump (first 32 bytes):
    c0 8b 24 c4 c1 5a 37 d1 fc 49 ec 3e 44 05 7e 19  ..$..Z7..I.>D.~.
    70 39 6a d0 53 22 6d 23 fc b9 94 83 e3 3a 60 e2  p9j.S"m#.....:`.
  backtrace (crc 8284cf12):
    __kmalloc_node_track_caller_noprof+0x637/0x880
    kmemdup_noprof+0x22/0x50
    nvmet_auth_reply+0x2ba/0xd00 [nvmet]
    nvmet_execute_auth_send+0xc7f/0x14f0 [nvmet]
    process_one_work+0xd98/0x1390
    worker_thread+0x60b/0x1000
    kthread+0x36c/0x470
    ret_from_fork+0x5dc/0x8e0
    ret_from_fork_asm+0x1a/0x30
unreferenced object 0xff1100016dd8c7c0 (size 32):
  comm "kworker/u48:2", pid 139664, jiffies 4401374600
  hex dump (first 32 bytes):
    21 1e e5 a0 b9 e6 a0 6b 85 cb 62 ff 30 d6 21 0f  !......k..b.0.!.
    05 89 bc 6a 44 fe 2a c4 bd 35 23 59 6c 56 2b 2e  ...jD.*..5#YlV+.
  backtrace (crc e32fd56c):
    __kmalloc_noprof+0x635/0x870
    nvmet_auth_challenge+0x329/0x9f0 [nvmet]
    nvmet_execute_auth_receive+0x381/0x7b0 [nvmet]
    process_one_work+0xd98/0x1390
    worker_thread+0x60b/0x1000
    kthread+0x36c/0x470
    ret_from_fork+0x5dc/0x8e0
    ret_from_fork_asm+0x1a/0x30
unreferenced object 0xff11000255549600 (size 256):
  comm "kworker/u48:2", pid 139664, jiffies 4401374604
  hex dump (first 32 bytes):
    11 1a 6e 99 d1 bc ae 48 5d aa f1 74 62 30 68 c4  ..n....H]..tb0h.
    07 9f 31 dc 83 a4 a4 92 47 18 9c 04 1e 7d 68 c1  ..1.....G....}h.
  backtrace (crc db3ad817):
    __kmalloc_noprof+0x635/0x870
    nvmet_auth_ctrl_sesskey+0xfa/0x3a0 [nvmet]
    nvmet_auth_reply+0x436/0xd00 [nvmet]
    nvmet_execute_auth_send+0xc7f/0x14f0 [nvmet]
    process_one_work+0xd98/0x1390
    worker_thread+0x60b/0x1000
    kthread+0x36c/0x470
    ret_from_fork+0x5dc/0x8e0
    ret_from_fork_asm+0x1a/0x30
unreferenced object 0xff1100016dd8cc00 (size 32):
  comm "kworker/u48:2", pid 139664, jiffies 4401374609
  hex dump (first 32 bytes):
    51 ff e9 8e 10 6b b4 b3 3f 6c 7d f2 74 eb 42 98  Q....k..?l}.t.B.
    6c f8 ab ec 10 d6 e8 0f 02 79 4a e4 ec b2 ce ed  l........yJ.....
  backtrace (crc 7099040d):
    __kmalloc_node_track_caller_noprof+0x637/0x880
    kmemdup_noprof+0x22/0x50
    nvmet_auth_reply+0x2ba/0xd00 [nvmet]
    nvmet_execute_auth_send+0xc7f/0x14f0 [nvmet]
    process_one_work+0xd98/0x1390
    worker_thread+0x60b/0x1000
    kthread+0x36c/0x470
    ret_from_fork+0x5dc/0x8e0
    ret_from_fork_asm+0x1a/0x30
unreferenced object 0xff1100025554a800 (size 256):
  comm "kworker/u48:2", pid 139664, jiffies 4401374633
  hex dump (first 32 bytes):
    eb a9 ed 0e b7 42 c6 6c 48 ee 56 29 a4 8a 99 18  .....B.lH.V)....
    1c 90 2a 53 22 7a ee 5a c0 6e 60 43 5b 33 a1 d2  ..*S"z.Z.n`C[3..
  backtrace (crc 3ce24e58):
    __kmalloc_noprof+0x635/0x870
    nvmet_auth_ctrl_sesskey+0xfa/0x3a0 [nvmet]
    nvmet_auth_reply+0x436/0xd00 [nvmet]
    nvmet_execute_auth_send+0xc7f/0x14f0 [nvmet]
    process_one_work+0xd98/0x1390
    worker_thread+0x60b/0x1000
    kthread+0x36c/0x470
    ret_from_fork+0x5dc/0x8e0
    ret_from_fork_asm+0x1a/0x30
unreferenced object 0xff11000267237a80 (size 32):
  comm "kworker/u48:2", pid 139664, jiffies 4401374635
  hex dump (first 32 bytes):
    20 25 77 95 60 f2 19 5a 09 20 2c 25 8b 04 2a 4b   %w.`..Z. ,%..*K
    b9 53 8e 10 39 b9 07 0d e0 fc 93 3f 82 50 86 0c  .S..9......?.P..
  backtrace (crc 3f42440d):
    __kmalloc_node_track_caller_noprof+0x637/0x880
    kmemdup_noprof+0x22/0x50
    nvmet_auth_reply+0x2ba/0xd00 [nvmet]
    nvmet_execute_auth_send+0xc7f/0x14f0 [nvmet]
    process_one_work+0xd98/0x1390
    worker_thread+0x60b/0x1000
    kthread+0x36c/0x470
    ret_from_fork+0x5dc/0x8e0
    ret_from_fork_asm+0x1a/0x30
unreferenced object 0xff11000138f46e40 (size 32):
  comm "kworker/u48:2", pid 139664, jiffies 4401374654
  hex dump (first 32 bytes):
    2d da 99 66 3b e7 d6 65 aa d7 1f a6 51 b4 ab 19  -..f;..e....Q...
    46 d7 30 0d 12 fd 55 90 c4 6a 4a 7a b8 55 7f 4f  F.0...U..jJz.U.O
  backtrace (crc 3ab35d56):
    __kmalloc_noprof+0x635/0x870
    nvmet_auth_challenge+0x329/0x9f0 [nvmet]
    nvmet_execute_auth_receive+0x381/0x7b0 [nvmet]
    process_one_work+0xd98/0x1390
    worker_thread+0x60b/0x1000
    kthread+0x36c/0x470
    ret_from_fork+0x5dc/0x8e0
    ret_from_fork_asm+0x1a/0x30
unreferenced object 0xff11000126860400 (size 256):
  comm "kworker/u48:2", pid 139664, jiffies 4401374658
  hex dump (first 32 bytes):
    cb 48 8c 49 58 82 bd fd 21 5b e4 a5 5b 5e 7b 8b  .H.IX...![..[^{.
    48 6a 47 3e 9f b7 76 06 c8 47 6a 5f 3e b4 20 15  HjG>..v..Gj_>. .
  backtrace (crc b164cda1):
    __kmalloc_noprof+0x635/0x870
    nvmet_auth_ctrl_sesskey+0xfa/0x3a0 [nvmet]
    nvmet_auth_reply+0x436/0xd00 [nvmet]
    nvmet_execute_auth_send+0xc7f/0x14f0 [nvmet]
    process_one_work+0xd98/0x1390
    worker_thread+0x60b/0x1000
    kthread+0x36c/0x470
    ret_from_fork+0x5dc/0x8e0
    ret_from_fork_asm+0x1a/0x30
unreferenced object 0xff11000138f468c0 (size 32):
  comm "kworker/u48:2", pid 139664, jiffies 4401374662
  hex dump (first 32 bytes):
    01 dd af 3b af a0 f8 ec 61 80 c4 aa ad 56 9a 27  ...;....a....V.'
    d4 f9 f9 8d 98 64 ce 5a 81 e2 14 e0 e3 5c 79 97  .....d.Z.....\y.
  backtrace (crc b24f43c2):
    __kmalloc_node_track_caller_noprof+0x637/0x880
    kmemdup_noprof+0x22/0x50
    nvmet_auth_reply+0x2ba/0xd00 [nvmet]
    nvmet_execute_auth_send+0xc7f/0x14f0 [nvmet]
    process_one_work+0xd98/0x1390
    worker_thread+0x60b/0x1000
    kthread+0x36c/0x470
    ret_from_fork+0x5dc/0x8e0
    ret_from_fork_asm+0x1a/0x30
unreferenced object 0xff11000185c80580 (size 64):
  comm "kworker/u48:2", pid 139664, jiffies 4401374716
  hex dump (first 32 bytes):
    bf a4 73 5a 5c a7 d7 8e f7 6e f9 39 3a 94 66 a4  ..sZ\....n.9:.f.
    8e f9 bc f6 9a 23 ac dc c8 71 85 ef 09 4c ac 38  .....#...q...L.8
  backtrace (crc 70f5e8bf):
    __kmalloc_noprof+0x635/0x870
    nvmet_auth_challenge+0x329/0x9f0 [nvmet]
    nvmet_execute_auth_receive+0x381/0x7b0 [nvmet]
    process_one_work+0xd98/0x1390
    worker_thread+0x60b/0x1000
    kthread+0x36c/0x470
    ret_from_fork+0x5dc/0x8e0
    ret_from_fork_asm+0x1a/0x30

-- 
Best Regards,
  Yi Zhang

