Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D541E35E53C
	for <linux-block@vger.kernel.org>; Tue, 18 Nov 2025 14:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763477531; cv=none; b=TfRAPWAeVvtRXKFbHX8+rukv3YXKczSn2DG6R5tg2w/01ra1uslYdkOp5wz7Zn2Tb0nyLaopXuN9crTtT2ECAFWUx7EnnfFU7h+zRrns1x1KqFRYdmTHUHhx4avCH5jLgyVAGeniq3Wuwh3KsoTmKdbvKlEo0V6g/2MHcdDwAA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763477531; c=relaxed/simple;
	bh=LviKJ4bEu2hQ4gW0DX/RBHbHNVCLyxxnqp1Y3ZNOFAI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Jcu9ghJg3Hbwu28XWf1iq/Ej6Am2XyEBaPCUuh5gxubZlikkgkpT9YfswC0xUnDrgGn7z/Kr6vsqColjdpgcEa5dqRHwqMjS/Gs4/+zg23H10cfOBYt2pgmy+vNS7hHBAwhQ0AhAvyOmxLh+abyxYQS6fkGpwev9oTW5lOh2dxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LWwTrC3A; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=odEIyl6c; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LWwTrC3A";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="odEIyl6c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763477526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=nXl5A1LzIc3mraM+u+KCuIUN2D9cbOD/IWOomrXYJb8=;
	b=LWwTrC3Ap1gR/YXvm2HBK5qT3L2XBySvCw1qZVOHUBee8SkLJuNbeVFGDk5x1l6QoCYI4w
	ieQsAgyapvmU1vgKqKGWp5nAxcSQ1c2yZRHevCS9TZYnkwLzxdchw3Gutr+KGZs0yq9xyV
	kXCSmFCAhP53xeuYpvtcxW7KXjDGJho=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-36-WgeuDt2tNQClVGEi6PRTtw-1; Tue, 18 Nov 2025 09:52:03 -0500
X-MC-Unique: WgeuDt2tNQClVGEi6PRTtw-1
X-Mimecast-MFC-AGG-ID: WgeuDt2tNQClVGEi6PRTtw_1763477522
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-37a492d719dso25159551fa.1
        for <linux-block@vger.kernel.org>; Tue, 18 Nov 2025 06:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763477521; x=1764082321; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nXl5A1LzIc3mraM+u+KCuIUN2D9cbOD/IWOomrXYJb8=;
        b=odEIyl6cCamcFE61xsFOljUye9lKJUkOqKemLa74LH12W6Y6uyD+Aw3pDXqXBuRB4l
         zgNm/kdV0p/lwDYj6yoEZyeSVtu85URQtxwq8njN3mwnciZisnNFOCTU95Yp53vxcyAQ
         ZpjHuZJPLuJJ36QatdHHsRMt3Mg2kGNS5aQy9HdHWnDTBpsp0lCwLIA2Q+p10J3Kx29t
         yW5fuNZb7VzMvJ6RY4SggnCMvZ0tFdSM6atXhq0hlGY3epbUBPQdAAybaTJ8l/UzUu+t
         zUFvXcpZrQzmCJO7lVPsbvOjEzLGu4cVvZ7f4F0beWMdYBD9/AUqisyB2LH7blhjApBU
         ONEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763477521; x=1764082321;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nXl5A1LzIc3mraM+u+KCuIUN2D9cbOD/IWOomrXYJb8=;
        b=Wb9ty95gPFq+8cTeWw+GPgdlookIo8+BEc/q4k2NCmsfoKVcEaaYvDxVOLBGxcC1Bf
         Rwp+AezvjkjwZrsBga6XGw4hXIbaU56S1MS8ORi0pvDgpG/TyVinnv2z66QCUM8jIp3y
         9D+2KxeQT3gaRTS8EtTP0dah10ewxpW0vUtMHFnhAkNPVug/X3kfF5ddxlXjSrk9xItv
         CVIM0HAaJP1yr/fayz5fRoERs00rH/T3vqY/0OhbRajVa73ByY0ez8aXXT/cigtDJ8Pa
         EPnXM3+wK8cy9nymUDZ9ws8dtavB1OAeuY+65fLp/4c7u5DzOs1KSuqg7zlnOK3GmKiH
         ap7Q==
X-Gm-Message-State: AOJu0YzEm/mq451UDLQl0qXhtvbcpyHNdSMpikCuPVg+kDwYmZT6u6s0
	wwRyQzDkTNodBABCYQ0wYdEJki9fuwrGwApzn0+zifrLdlZv19rYjehLSN7rVkf0zScT3YlPqva
	x6hyar8hjxejo8mymbbPb9VObE8rJpZrNVnkRKrQFpHYmkgyEhlng9xjGeGjr+6W7UtCGbfkwH9
	ynvnj6wOUgpbYYMXcIQjp8eY5kbErySnse7dSotvOuuY1a4QDsbV7O
X-Gm-Gg: ASbGncukHjWbfwk5w9OBRrD4cC5YvCCYNjbDiMbfMD9T/nKfPU/pPz3qXWsVXFOhlUX
	EOO0vJ9xG8vwV4Xlt59UAXmYM6ZkURMLixiJaOe3ZJDJiS80UV+cF10T+oRgjIE44A/hVTRO0a1
	6rGtH3GJGCUzD9BlqDb55Q6PqxVHYRM8/XIB3zQ9N+r0QumvxLhThj9P/4uFhKydcNm9Y=
X-Received: by 2002:a2e:964b:0:b0:37b:9a1d:dee8 with SMTP id 38308e7fff4ca-37babbcc10emr36504871fa.15.1763477520677;
        Tue, 18 Nov 2025 06:52:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGyZ3N04ZxpnfVzJf09np+5pwDccRdD1dMw6KLtuf4+C06OpBVgTUB3Yn/aySAd4cyXLVGoKEAi/qJf9VKVxXY=
X-Received: by 2002:a2e:964b:0:b0:37b:9a1d:dee8 with SMTP id
 38308e7fff4ca-37babbcc10emr36504791fa.15.1763477520210; Tue, 18 Nov 2025
 06:52:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Tue, 18 Nov 2025 22:51:45 +0800
X-Gm-Features: AWmQ_bmOuSLfPUtcCfBv7z24hH4u1afg_aOOLf4o3S4kLdKSu8mnBlOFDqSFZeg
Message-ID: <CAHj4cs9Ez5f+SsHMcbYVeKGScuL9vq71i57kRgu2KneRtXRwmw@mail.gmail.com>
Subject: [bug report] kernel BUG at mm/hugetlb.c:5868! triggered by blktests
 nvme/tcp nvme/029
To: linux-block <linux-block@vger.kernel.org>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"

Hi

The following BUG was triggered during CKI tests. Please help check it
and let me know if you need any info/test for it. Thanks.

commit: for-next - 5674abb82e2b

[ 1486.502840] run blktests nvme/029 at 2025-11-17 21:34:13
[ 1486.551942] loop0: detected capacity change from 0 to 2097152
[ 1486.563593] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[ 1486.580648] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
[ 1486.627702] nvmet: Created nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[ 1486.631269] nvme nvme0: creating 32 I/O queues.
[ 1486.639689] nvme nvme0: mapped 32/0/0 default/read/poll queues.
[ 1486.655324] nvme nvme0: new ctrl: NQN "blktests-subsystem-1", addr
127.0.0.1:4420, hostnqn:
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[ 1487.242297] ------------[ cut here ]------------
[ 1487.242945] kernel BUG at mm/hugetlb.c:5868!
[ 1487.243628] Oops: invalid opcode: 0000 [#1] SMP NOPTI
[ 1487.243923] CPU: 3 UID: 0 PID: 56899 Comm: nvme Not tainted
6.18.0-rc5 #1 PREEMPT(lazy)
[ 1487.244450] Hardware name: HP ProLiant DL385p Gen8, BIOS A28 03/14/2018
[ 1487.244807] RIP: 0010:__unmap_hugepage_range+0x79b/0x7f0
[ 1487.245098] Code: 89 ef 48 89 c6 e8 25 90 ff ff 48 8b 3c 24 e8 fc
c3 df 00 e9 d0 fb ff ff 0f 0b 49 8b 50 30 48 f7 d2 4c 85 e2 0f 84 ec
f8 ff ff <0f> 0b 0f 0b 65 48 8b 05 f1 4e 10 03 48 8b 10 f7 c2 00 00 00
10 74
[ 1487.246461] RSP: 0018:ffffd4108e577a20 EFLAGS: 00010206
[ 1487.246784] RAX: 0000000000400000 RBX: 0000000000000000 RCX: 0000000000000009
[ 1487.247559] RDX: 00000000001fffff RSI: ffff8ca241389800 RDI: ffffd4108e577b98
[ 1487.248566] RBP: ffffffffffffffff R08: ffffffff963c0658 R09: 0000000000200000
[ 1487.249340] R10: 00007f6ee0c05000 R11: ffff8ca4772ec000 R12: 00007f6ee0a05000
[ 1487.250191] R13: ffffd4108e577b98 R14: ffff8ca241389800 R15: ffffd4108e577b40
[ 1487.250962] FS:  00007f6ee1bfa840(0000) GS:ffff8ca6a1838000(0000)
knlGS:0000000000000000
[ 1487.251416] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1487.252127] CR2: 00007f6ee1a7ccf0 CR3: 0000000441bcf000 CR4: 00000000000406f0
[ 1487.252933] Call Trace:
[ 1487.253094]  <TASK>
[ 1487.253638]  ? unmap_page_range+0x257/0x400
[ 1487.253876]  unmap_vmas+0xa6/0x180
[ 1487.254482]  exit_mmap+0xf0/0x3b0
[ 1487.255095]  __mmput+0x3e/0x140
[ 1487.255713]  exit_mm+0xaf/0x110
[ 1487.256328]  do_exit+0x1ad/0x450
[ 1487.256905]  ? filemap_map_pages+0x27e/0x3d0
[ 1487.257540]  do_group_exit+0x30/0x80
[ 1487.257789]  __x64_sys_exit_group+0x18/0x20
[ 1487.258008]  x64_sys_call+0x14fa/0x1500
[ 1487.258251]  do_syscall_64+0x84/0x800
[ 1487.258472]  ? do_read_fault+0xf5/0x220
[ 1487.258687]  ? do_fault+0x156/0x280
[ 1487.259260]  ? __handle_mm_fault+0x55c/0x6b0
[ 1487.259911]  ? count_memcg_events+0xdd/0x1b0
[ 1487.260555]  ? handle_mm_fault+0x220/0x340
[ 1487.260784]  ? do_user_addr_fault+0x2c3/0x7f0
[ 1487.261419]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1487.261712] RIP: 0033:0x7f6ee1a7cd08
[ 1487.261954] Code: Unable to access opcode bytes at 0x7f6ee1a7ccde.
[ 1487.262691] RSP: 002b:00007ffdb391b628 EFLAGS: 00000206 ORIG_RAX:
00000000000000e7
[ 1487.263484] RAX: ffffffffffffffda RBX: 00007f6ee1ba7fc8 RCX: 00007f6ee1a7cd08
[ 1487.264266] RDX[ 1487.359221] R10: 00007ffdb391b420 R11:
0000000000000206 R12: 0000000000000001
[ 1487.365268] R13: 0000000000000001 R14: 00007f6ee1ba6680 R15: 00007f6ee1ba7fe0
[ 1487.366071]  </TASK>
[ 1487.366251] Modules linked in: nvmet_tcp nvmet nvme_tcp
nvme_fabrics nvme nvme_core nvme_keyring nvme_auth rtrs_core rdma_cm
iw_cm ib_cm ib_core hkdf rfkill sunrpc amd64_edac edac_mce_amd
ipmi_ssif acpi_power_meter acpi_ipmi ipmi_si ipmi_devintf kvm
irqbypass i2c_piix4 ipmi_msghandler hpilo tg3 acpi_cpufreq i2c_smbus
fam15h_power k10temp pcspkr loop fuse nfnetlink zram lz4hc_compress
lz4_compress xfs ata_generic pata_acpi polyval_clmulni
ghash_clmulni_intel hpsa mgag200 serio_raw i2c_algo_bit
scsi_transport_sas hpwdt sp5100_tco pata_atiixp i2c_dev [last
unloaded: nvmet]
[ 1487.369378] ---[ end trace 0000000000000000 ]---
[ 1487.373697] ERST: [Firmware Warn]: Firmware does not respond in time.
[ 1487.374212] pstoreffff R08: ffffffff963c0658 R09: 0000000000200000
[ 1487.775150] R10: 00007f6ee0c05000 R11: ffff8ca4772ec000 R12: 00007f6ee0a05000
[ 1487.776024] R13: ffffd4108e577b98 R14: ffff8ca241389800 R15: ffffd4108e577b40
[ 1487.776853] FS:  00007f6ee1bfa840(0000) GS:ffff8ca6a1838000(0000)
knlGS:0000000000000000
[ 1487.777313] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1487.778210] CR2: 00007f6ee1a7ccf0 CR3: 0000000441bcf000 CR4: 00000000000406f0
[ 1487.778978] Kernel panic - not syncing: Fatal exception
[ 1487.779714] Kernel Offset: 0x11a00000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[ 1487.814610] ---[ end Kernel panic - not syncing: Fatal exception ]---
[-- MARK -- Mon Nov 17 21:35:00 2025]

-- 
Best Regards,
  Yi Zhang

