Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90755311C36
	for <linux-block@vger.kernel.org>; Wed, 21 Jan 2026 02:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768963822; cv=pass; b=aB1PhicEYERK/KtxJudjZXOz7jD+NCsDmIk1ngDC6PyK8Hs0HIzq89wwgGSCbk97lunlvYEs7o8YksgN1fJTQKq72RySifOIOKCWfg5q36buxz0pp1ONcKvYQNDYiPl5493CrmviYLnCBNzf5/1ahlIpBd6NkudeWRji4zLUt8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768963822; c=relaxed/simple;
	bh=N6do5Wb57fjgaugSxi6vIYJ51jlBVRltOuX1FUt8OKA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=J/JXulw3IVMeoKOI6bsFzdJs98EZFPSYPtuF1TvBETmDTidCqTu4DqZKW38pI5ADPrDgXiH7JtgpuVE/A3cNgjbLTVxdtb/OEET7C43Hut8IqZWHlKlYyENyIFNM8Y3lghnuE7mPzorbi5f+IijLl9bJM4mVccW/h1CGxwAbOX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CPFoad5W; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JcFZ8TV8; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CPFoad5W";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JcFZ8TV8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768963817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=fFeKv09HCEkQRsng29UKXvnp+lJB/36rWHXN5G2fdyg=;
	b=CPFoad5WBTghx4S8uugh/qj4d5hL1iqTZELTBKkoXu43dJ1EJPqo/iYrhdceIcgvseQxEA
	+qiRSy2zl8PCWXvDidqBPD+/KKZP0gbXCPyLpDRFWqEEILYeLgLAyQ3sgTY9V7rFgTeZQ5
	8EOnXqIaZIXgIRJClrcO034Q400begc=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-WUJohZ3hOKmDyEzW0dexMg-1; Tue, 20 Jan 2026 21:50:15 -0500
X-MC-Unique: WUJohZ3hOKmDyEzW0dexMg-1
X-Mimecast-MFC-AGG-ID: WUJohZ3hOKmDyEzW0dexMg_1768963814
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-382f6aca49dso33287241fa.0
        for <linux-block@vger.kernel.org>; Tue, 20 Jan 2026 18:50:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768963812; cv=none;
        d=google.com; s=arc-20240605;
        b=AYHv0ADAi0oX/WnWEFqfKlL9vOhZSxfiCz/kSo5U4B09FvPnjaQVr84BXGYxuMCNFI
         QgF4RjEAYzRxcrlPlRSB+y/jVRY1IXTs1CZPIP25MGAgE4BGb4sZ1/+O3MQ0I6o7yDSn
         WV4RsoXOW64Z/IsIC7doAgC6Y3usquo7dU8OJ441CrEaKtq6IYbX/a/0uGoZbOeu0C2R
         z2OoR7lq/Th6EruFGYQrhQf3Qfgm/Jy6DH8EJQlijqlbcTrTLhIuDukChCAfziouMPlB
         o3VyD+ph3x+9axxxJKZHZGj7gkH4DkddQubjVCQz9aeLbLpcFBciP6JRS+9vmZgo54uh
         tDbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=fFeKv09HCEkQRsng29UKXvnp+lJB/36rWHXN5G2fdyg=;
        fh=PRCv3/QECtCzFWWzKJ02OgkM/75kdx7r55usN/M9xh4=;
        b=EEnMVIn99qVRvUVOCTqIpcLYFx7GjiTSicuSnFAJ9diZDXqg4aFVO9s4VpR50HSFVU
         oZ4lcpY4eSG3+jIwYyQgdWLUrJ5rf3mViwjL5zjBMxmlbaiNEGChHWIGa4CWHE4rzv1b
         3PT1IMkL0bGBtMZIC+fYxpZUO4g8E6wu8HYPCOoM3mZzbpVn/BnpI5uvZX2tRLotrwWS
         wRcfZmr90vNrwii6SzUzzhJeM3T2CPQQc5nqAGs0JrAId0NhMMnptv5zkcQf845CQQ9r
         7+abvnAbEBs+7sjAFGLYMRAt5xrfvDR/6Ali9mf9A2fSAcdFzAjbk2pPVWVWEMeFNxj3
         SddA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768963812; x=1769568612; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fFeKv09HCEkQRsng29UKXvnp+lJB/36rWHXN5G2fdyg=;
        b=JcFZ8TV8l4v++lATehoNX8YnpjLVzI3ZAZyatTa8914DuRchJX2G2oxk+oQ+omB8KC
         rljTPvOU5NQRwDDeA+hJz6h8bEY4ArT5i7HwcuOnP+yhoT/6zBH05zbTWIK8l0eAtsom
         FKfP9FpiK7/2wOmOR6pB++jm/euI5eDCV+YN23ZI81Wl0TZKeN8+s4Kb9MAq5lrGFb3P
         4DkmV+wAPapUFNVhf4Of35a8DaiTDWJzNwWGYXV9m9BrWc1UHyG2J+vKZA0gUF7U2FI9
         j8Izje/wIhJzrqUr9DHTFP9xws28G4e9QAJxLjuIcyJEtKzTIbC3mkmQSi5FzzKg7P5e
         IZDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768963812; x=1769568612;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fFeKv09HCEkQRsng29UKXvnp+lJB/36rWHXN5G2fdyg=;
        b=K1ESa2Lh9Dwjas/W68KzwmYX8S0sQ9Ew6zlnehnnAl1toDa73TEO1u09A08yOoa4+o
         Wq1hQRkjV8ASi9c1hu79ibc7USYj4J2DOJLbep0ixaMaf8QuLIug3RNudM324oCxUIbU
         59tsnhPkaGjK39BUGlfmqZ+4/KQKuqEh6QZKse/sgTiQrm5s7dTZRn24pt2gmTY8/PD8
         t4i0VPKjXLCWn/DVEb4QHHhE3HtMU3SajLRT8GPwW0drKaLA4BjEtm03Ou8LUA/iy2EQ
         AyuRy1yTUdDhjzNk7NXWzf1o7FFn3+X3ZFllO601ng6eJ/kbaI0h0yUGfO/kVzaT5Z0E
         7ekw==
X-Gm-Message-State: AOJu0YxfcZQe5ZzrqFX14JUMgYTwWC9ysjfF8aiXblvweTUXz1RP/jG6
	0QnGqWjCtrgvp4JilnSndaS/+buvSdE08RgXqxxQUE5Tt+hM0wBkeDtpFSh294Eni/4L250cQdL
	XpvuGsNzbcFcCDydHWOa4DpcmwYoTafu0efreANBM/irCEh4cTjJNAvhtnOuhFB2V4wI3+P0hvE
	VmZfJ2SRkYcEZGlNAurAr+EOmi+J6rmr6UwfoP64KF5BwGRAqXFHtO4W4=
X-Gm-Gg: AZuq6aJmgKHa+MJa/QMH0H/1PGatgLZnusKEFZGtrtHCgoiizJ8GKdQj21NtjOf4gv6
	iJkWdUAlinw7JlTJWbcE8pWx4U4SJ03XNABRMORyOnbX64TWzHVkVOW1hcpxQ05Qdg/9bwkXeBl
	P4evBviqNKW221EJMudmhCkTNVJ4XDFNM3zgNeorebbtdMy/ICDT0bLJQACEl/1ABS6eI=
X-Received: by 2002:a2e:be0a:0:b0:380:a1c:702b with SMTP id 38308e7fff4ca-38384153c55mr53882751fa.5.1768963812536;
        Tue, 20 Jan 2026 18:50:12 -0800 (PST)
X-Received: by 2002:a2e:be0a:0:b0:380:a1c:702b with SMTP id
 38308e7fff4ca-38384153c55mr53882721fa.5.1768963812089; Tue, 20 Jan 2026
 18:50:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Wed, 21 Jan 2026 10:50:00 +0800
X-Gm-Features: AZwV_QizxBsjzmFkfE3NqLCyhma6GO59nWglwmWfjf5YXHqBLOS6BJ6iFt7QJ8s
Message-ID: <CAHj4cs9JJu+dDZqAvCd1qPM1CZuV-_b-AHxXpU-vJrGHHO-ExA@mail.gmail.com>
Subject: [bug report] nvme-tcp poll queue causes busy loop and 100% CPU in
 nvme_tcp_poll() on the latest linux-block/for-next
To: linux-block <linux-block@vger.kernel.org>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Ming Lei <ming.lei@redhat.com>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <chaitanyak@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

Hi

This issue was observed on the latest linux-block/for-next during CKI
test, where enabling the poll queues leads to a tight busy polling
loop and 100% CPU usage during "nvme connect".
It seems was introduced from v6.19-rc1 and cannot reproduced on v6.18.
I will try to bisect it.
I am happy to test any proposed fixes or provide additional traces if needed.

Reproducer:
#nvme_trtype=tcp  ./check nvme/047
nvme/047 (tr=tcp) (test different queue types for fabric transports) [passed]
    runtime  1061.108s  ...  19857.364s

# ps aux | grep "nvme connect"
root        2492 99.9  0.0  15884  5520 pts/0    R+   01:28   0:13
nvme connect --traddr 127.0.0.1 --transport tcp --trsvcid 4420 --nqn
blktests-subsystem-1
--hostnqn=nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
--hostid=0f01fb42-9f7f-4856-b0b3-51e60b8de349 --nr-write-queues=1
--nr-poll-queues=1 --output-format=json

# perf top -p  2492
Samples: 71K of event 'cycles:P', 4000 Hz, Event count (approx.):
39693035620 lost: 0/0 drop: 0/0
Overhead  Shared O  Symbol
  51.62%  [kernel]  [k] blk_hctx_poll
  34.64%  [kernel]  [k] nvme_tcp_poll
  13.39%  [kernel]  [k] __x86_indirect_thunk_rax
   0.02%  [kernel]  [k] native_irq_return_iret
   0.02%  [kernel]  [k] native_write_msr
   0.02%  [kernel]  [k] update_load_avg
   0.01%  [kernel]  [k] __raw_spin_lock_irqsave
   0.01%  [kernel]  [k] native_sched_clock
   0.01%  [kernel]  [k] read_tsc
   0.01%  [kernel]  [k] sched_balance_trigger
   0.01%  [kernel]  [k] __hrtimer_run_queues
   0.01%  [kernel]  [k] __update_load_avg_cfs_rq
   0.01%  [kernel]  [k] __timekeeping_advance
   0.01%  [kernel]  [k] native_read_msr
   0.01%  [kernel]  [k] ktime_get_update_offsets_now
   0.01%  [kernel]  [k] task_tick_fair
   0.01%  [kernel]  [k] native_apic_msr_eoi
   0.01%  [kernel]  [k] sugov_get_util

dmesg:
[ 5514.212238] run blktests nvme/047 at 2026-01-19 16:37:29
[ 5514.229581] loop0: detected capacity change from 0 to 2097152
[ 5514.235566] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[ 5514.244495] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
[ 5514.267088] nvmet: Created nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[ 5514.269066] nvme nvme0: creating 73 I/O queues.
[ 5514.276926] nvme nvme0: mapped 1/72/0 default/read/poll queues.
[ 5514.301778] nvme nvme0: new ctrl: NQN "blktests-subsystem-1", addr
127.0.0.1:4420, hostnqn:
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[ 5515.068893] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"
[ 5515.150669] nvmet: Created nvm controller 2 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[ 5515.152791] nvme nvme0: creating 74 I/O queues.
[ 5515.161907] nvme nvme0: mapped 1/72/1 default/read/poll queues.
[25370.530190] nvme nvme0: new ctrl: NQN "blktests-subsystem-1", addr
127.0.0.1:4420, hostnqn:
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[25371.283929] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"


--
Best Regards,
  Yi Zhang

