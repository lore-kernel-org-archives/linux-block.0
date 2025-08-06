Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3BB86334
	for <linux-block@vger.kernel.org>; Wed,  6 Aug 2025 01:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754445490; cv=none; b=KXISf6vz326Iyn7LpLhpfADqSQJQj9iDa04CQk5wc3zjh8xoMdkte+G6TRSx89zPih4PiYwIbpKDrgg63OLaFxNymqvmR13iE/omEe3IvBJ+Vn9hOS0m2SiYCBCAwBOUJc10oPq0TYsL2Y9+2bsfoaL8a4aQapqz9LcST/64i8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754445490; c=relaxed/simple;
	bh=FyrPuAdHQ4ou3SVe0Xd0OjaDurh4Zc9QXumK+rn0OUQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=q36meSZ9//VZNpo8slnt/qebwJC9wIXkeNA8cVF+3tWxE6/0NUA11QhB1P5IL007dt/fKt3PtQMLbb845vR7XsorYHdVRF3Ms9tM3zyCDgHYReD5IzzVBNbTTcIXYr1CuduWUdFdvWOwdC8dgtDm42tT3GiT4jY57oMouh9Iul4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lg1ltH0B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lg1ltH0B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754445486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=OqUoh3I3BDccAUBqCY48AqRN2HWxXASUn79xbObtqew=;
	b=Lg1ltH0BGEXZQyOA/gVAGc+idQEnYER2ykbat6BTlYc1l5e/XPdJrpeZqmU2130kpiPfr9
	KLsNh8XU6LCOUU4bBtIuucaeLxCrQ3MWjAEqhlDPghNud6eNHwDWbfgJxvfGb/P7mQAE/U
	PDe9NmoLiCT+QDtSiFVugXK/vucOw/8=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-v2Bo8EblP5yM6MDHokN11A-1; Tue, 05 Aug 2025 21:58:05 -0400
X-MC-Unique: v2Bo8EblP5yM6MDHokN11A-1
X-Mimecast-MFC-AGG-ID: v2Bo8EblP5yM6MDHokN11A_1754445484
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-33212ba3b7aso21488031fa.1
        for <linux-block@vger.kernel.org>; Tue, 05 Aug 2025 18:58:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754445482; x=1755050282;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OqUoh3I3BDccAUBqCY48AqRN2HWxXASUn79xbObtqew=;
        b=IwR/Y502ealUAt3InUS49IYlKZdr80xHnAt3xoE8gd8tVSV9TudBkyuKvdgo/xnnDm
         1U8fQymjqXqr9mIZEPUXFehCr3BwrqdbhxThJdt/DkOGSUnKvqwOajL4nZx8SsN3JAU4
         8w3fCToEwUhC6Gazwnl0qNgx1UaTm3OsXym2ZTXeEL1tTFf3JksIdNvumoBtaGRCQ2PC
         GeprTfX7gYYk28E1avw8x52PCbMno9R5HHG67Sr8JPTgErr/S6vsLtnBFIenGBeW+anq
         Kg8/ngCrVSEB5r66v4i7xbIIAYaMoxC20RxhwPGgP5frpTmscNwX6j/S05TUbUxiAhk+
         CmnQ==
X-Gm-Message-State: AOJu0Yy2V+UmIIbVu0y5zF6xhQeukYAPnxFgEKnjxzZEgxX/cYVkbhx8
	XhDdkfjoHn9k8yxttjecfxIDcr5r0FJxTblWqidCizLD7ayN05+/D4uAcUznI/d2Q6Xdvcgi2PP
	1hMteqcuqKNTlHdMISZ6Vxy+G3k1JurjhHjSk+ud/BYeBhMPQarhjmxGAaJ/1eM8qa6H6BalDSQ
	Ry8pRpPUR7hN10iJIB1y0pLg9/oL0yzdUMo6yf+41FVLSoDIbAmg==
X-Gm-Gg: ASbGncszneczW2Pv69NuNFwcGR6iDDOUujRJ85Bqr4qmj740JTknC3APdJpy47fiy1e
	hlW7CAfmAVfNTuh6TaTItSArYFtRqDrXFshycXUsDUXvfOSHHGYZ3eZQvksgwQenPgmjIUAiu1S
	1IXZVK83S1dTY7KrZRT52v5g==
X-Received: by 2002:a05:651c:19a3:b0:32a:6aa0:2173 with SMTP id 38308e7fff4ca-333813cb421mr2257061fa.20.1754445481900;
        Tue, 05 Aug 2025 18:58:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYN4bkZdO3F6XuoA4A1uWIZ2ryNf71YLTvNMpWj7RYcCDCwKboopxLHSKuq4FQtJyLIGeQlBo9LIENVgTtgP0=
X-Received: by 2002:a05:651c:19a3:b0:32a:6aa0:2173 with SMTP id
 38308e7fff4ca-333813cb421mr2257001fa.20.1754445481258; Tue, 05 Aug 2025
 18:58:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Wed, 6 Aug 2025 09:57:49 +0800
X-Gm-Features: Ac12FXyBhnWnJHerlSUK699FhRlGNBd51WtppFw9Q2Xvm-q5zj5m12GjXj2PupA
Message-ID: <CAHj4cs-zu7eVB78yUpFjVe2UqMWFkLk8p+DaS3qj+uiGCXBAoA@mail.gmail.com>
Subject: [bug report] blktests nvme/tcp nvme/060 hang
To: linux-block <linux-block@vger.kernel.org>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Maurizio Lombardi <mlombard@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Hello
I hit this issue when I was running blktests nvme/tcp nvme/060 on the
latest linux-block/for-next with rt enabled, please help check it and
let me know if you need any info/testing for it, thanks.

[  195.356104] run blktests nvme/060 at 2025-08-06 01:50:45
[  195.578659] loop0: detected capacity change from 0 to 2097152
[  195.620986] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  195.681508] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
[  195.904991] nvmet: Created nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[  195.919199] nvme nvme1: creating 80 I/O queues.
[  196.035295] nvme nvme1: mapped 80/0/0 default/read/poll queues.
[  196.175655] nvme nvme1: new ctrl: NQN "blktests-subsystem-1", addr
127.0.0.1:4420, hostnqn:
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[  196.195731] nvme (3558) used greatest stack depth: 19248 bytes left
[  197.786460] nvmet: ctrl 1 fatal error occurred!
[  197.789337] nvme nvme1: starting error recovery
[  197.932751] nvme nvme1: Reconnecting in 1 seconds...
[  198.980348] nvmet: Created nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[  198.985848] nvme nvme1: creating 80 I/O queues.
[  199.318924] nvme nvme1: mapped 80/0/0 default/read/poll queues.
[  199.423818] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
[  199.556572] nvme nvme1: Failed reconnect attempt 1/600
[  200.075342] systemd-udevd (3501) used greatest stack depth: 17888 bytes left
[  200.496781] nvme nvme1: Property Set error: 880, offset 0x14
[  200.977968] nvmet: Created nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[  200.985964] nvme nvme1: creating 80 I/O queues.
[  201.076602] nvme nvme1: mapped 80/0/0 default/read/poll queues.
[  201.189249] nvme nvme1: new ctrl: NQN "blktests-subsystem-1", addr
127.0.0.1:4420, hostnqn:
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[  201.206511] nvme (3741) used greatest stack depth: 17712 bytes left
[  201.867978] nvmet: ctrl 1 fatal error occurred!
[  201.868127] nvme nvme1: starting error recovery
[  201.986566] nvme nvme1: Reconnecting in 1 seconds...
[  203.049519] nvmet: Created nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[  203.056878] nvme nvme1: creating 80 I/O queues.
[  203.399239] nvme nvme1: mapped 80/0/0 default/read/poll queues.
[  203.569429] nvme nvme1: Successfully reconnected (attempt 1/600)
[  203.918129] nvmet: ctrl 1 fatal error occurred!
[  203.918261] nvme nvme1: starting error recovery
[  204.026795] nvme nvme1: Reconnecting in 1 seconds...
[  204.423104] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
[  205.336507] nvme nvme1: Property Set error: 880, offset 0x14
[  205.855722] nvmet: Created nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[  205.861038] nvme nvme1: creating 80 I/O queues.
[  205.944537] nvme nvme1: mapped 80/0/0 default/read/poll queues.
[  205.965862] nvmet: ctrl 1 fatal error occurred!
[  206.053046] nvme nvme1: starting error recovery
[  206.147337] nvme nvme1: Failed to configure AEN (cfg 900)
[  206.147495] nvme nvme1: new ctrl: NQN "blktests-subsystem-1", addr
127.0.0.1:4420, hostnqn:
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[  206.176163] nvme nvme1: Reconnecting in 1 seconds...
[  207.208170] nvmet: Created nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[  207.211901] nvme nvme1: creating 80 I/O queues.
[  207.336799] nvme nvme1: mapped 80/0/0 default/read/poll queues.
[  207.349663] nvme nvme1: Successfully reconnected (attempt 1/600)
[  208.017068] nvmet: ctrl 1 fatal error occurred!
[  208.017201] nvme nvme1: starting error recovery
[  208.126889] nvme nvme1: Reconnecting in 1 seconds...
[  209.199440] nvmet: Created nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[  209.203685] nvme nvme1: creating 80 I/O queues.
[  209.382909] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
[  209.503420] nvme nvme1: mapped 80/0/0 default/read/poll queues.
[  209.706412] nvme nvme1: Failed reconnect attempt 1/600
[  210.617622] nvme nvme1: Property Set error: 880, offset 0x14
[  211.158138] nvmet: Created nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[  211.163794] nvme nvme1: creating 80 I/O queues.
[  211.245927] nvme nvme1: mapped 80/0/0 default/read/poll queues.
[  211.350477] nvme nvme1: new ctrl: NQN "blktests-subsystem-1", addr
127.0.0.1:4420, hostnqn:
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[  212.097987] nvmet: ctrl 1 fatal error occurred!
[  212.098122] nvme nvme1: starting error recovery
[  212.217345] nvme nvme1: Reconnecting in 1 seconds...
[  213.280774] nvmet: Created nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[  213.284617] nvme nvme1: creating 80 I/O queues.
[  213.625320] nvme nvme1: mapped 80/0/0 default/read/poll queues.
[  213.787167] nvme nvme1: Successfully reconnected (attempt 1/600)
[  214.147984] nvmet: ctrl 1 fatal error occurred!
[  214.148113] nvme nvme1: starting error recovery
[  214.248455] nvme nvme1: Reconnecting in 1 seconds...
[  214.604818] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
[  215.431717] nvme nvme1: Property Set error: 880, offset 0x14
[  216.014626] nvmet: Created nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[  216.020186] nvme nvme1: creating 80 I/O queues.
[  216.101613] nvme nvme1: mapped 80/0/0 default/read/poll queues.
[  216.195783] nvmet: ctrl 1 fatal error occurred!
[  216.536582] nvme nvme1: failed to send request -32
[  216.537991] nvme nvme1: failed nvme_keep_alive_end_io error=4
[  280.196270] nvme nvme1: I/O tag 0 (0000) type 4 opcode 0x7f
(Fabrics Cmd) QID 80 timeout
[  280.198058] nvme nvme1: Connect command failed, error wo/DNR bit: 881
[  280.198353] nvme nvme1: failed to connect queue: 80 ret=881
[  285.369827] nvmet: Created nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[  285.375603] nvme nvme1: creating 80 I/O queues.
[  285.449676] nvme nvme1: mapped 80/0/0 default/read/poll queues.
[  285.554119] nvme nvme1: new ctrl: NQN "blktests-subsystem-1", addr
127.0.0.1:4420, hostnqn:
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[  287.344206] nvmet: ctrl 1 fatal error occurred!
[  287.344349] nvme nvme1: starting error recovery
[  287.466244] nvme nvme1: Reconnecting in 1 seconds...
[  288.479300] nvmet: Created nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[  288.483283] nvme nvme1: creating 80 I/O queues.
[  288.785415] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
[  288.856766] nvme nvme1: mapped 80/0/0 default/read/poll queues.
[  289.066215] nvme nvme1: Failed reconnect attempt 1/600
[  290.116265] nvme nvme1: Property Set error: 880, offset 0x14
[  320.802045] loop: module loaded
[  321.017366] run blktests nvme/060 at 2025-08-06 01:52:51
[  321.220243] loop0: detected capacity change from 0 to 2097152
[  321.262034] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  321.322296] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
[  321.511316] nvmet: Created nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[  321.524993] nvme nvme1: creating 80 I/O queues.
[  321.636336] nvme nvme1: mapped 80/0/0 default/read/poll queues.
[  321.754764] nvme nvme1: new ctrl: NQN "blktests-subsystem-1", addr
127.0.0.1:4420, hostnqn:
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[  323.431491] nvmet: ctrl 1 fatal error occurred!
[  323.434219] nvme nvme1: starting error recovery
[  323.566948] nvme nvme1: Reconnecting in 1 seconds...
[  324.653738] nvmet: Created nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[  324.662270] nvme nvme1: creating 80 I/O queues.
[  324.993712] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
[  325.052085] nvme nvme1: mapped 80/0/0 default/read/poll queues.
[  325.481710] nvmet: ctrl 1 fatal error occurred!
[  327.286111] nvmet: ctrl 1 keep-alive timer (1 seconds) expired!
[  390.435380] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[  390.441500] rcu: Tasks blocked on level-1 rcu_node (CPUs 0-15):
P4784/2:b..l P1049/8:b..l
[  390.449771] rcu: (detected by 13, t=6503 jiffies, g=8845, q=2243 ncpus=80)
[  390.456724] task:kworker/u329:1  state:D stack:19264 pid:1049
tgid:1049  ppid:2      task_flags:0x4208060 flags:0x00000010
[  390.467850] Workqueue: nvme-wq nvme_tcp_reconnect_ctrl_work [nvme_tcp]
[  390.474378] Call trace:
[  390.476813]  __switch_to+0x1d8/0x330 (T)
[  390.480731]  __schedule+0x860/0x1c30
[  390.484297]  schedule_rtlock+0x30/0x70
[  390.488037]  rtlock_slowlock_locked+0x464/0xf60
[  390.492559]  rt_read_lock+0x2bc/0x3e0
[  390.496211]  nvmet_tcp_listen_data_ready+0x3c/0x118 [nvmet_tcp]
[  390.502125]  nvmet_tcp_data_ready+0x88/0x198 [nvmet_tcp]
[  390.507429]  tcp_data_ready+0xdc/0x3e0
[  390.511171]  tcp_data_queue+0xe30/0x1e08
[  390.515084]  tcp_rcv_established+0x710/0x2328
[  390.519432]  tcp_v4_do_rcv+0x554/0x940
[  390.523172]  tcp_v4_rcv+0x1ec4/0x3078
[  390.526825]  ip_protocol_deliver_rcu+0xc0/0x3f0
[  390.531347]  ip_local_deliver_finish+0x2d4/0x5c0
[  390.535954]  ip_local_deliver+0x17c/0x3c0
[  390.539953]  ip_rcv_finish+0x148/0x238
[  390.543693]  ip_rcv+0xd0/0x2e0
[  390.546737]  __netif_receive_skb_one_core+0x100/0x180
[  390.551780]  __netif_receive_skb+0x2c/0x160
[  390.555953]  process_backlog+0x230/0x6f8
[  390.559866]  __napi_poll.constprop.0+0x9c/0x3e8
[  390.564386]  net_rx_action+0x808/0xb50
[  390.568125]  handle_softirqs.constprop.0+0x23c/0xca0
[  390.573082]  __local_bh_enable_ip+0x260/0x4f0
[  390.577429]  __dev_queue_xmit+0x6f4/0x1bd8
[  390.581515]  neigh_hh_output+0x190/0x2c0
[  390.585429]  ip_finish_output2+0x7c8/0x1788
[  390.589602]  __ip_finish_output+0x2c4/0x4f8
[  390.593776]  ip_finish_output+0x3c/0x2a8
[  390.597689]  ip_output+0x154/0x418
[  390.601081]  __ip_queue_xmit+0x580/0x1108
[  390.605081]  ip_queue_xmit+0x4c/0x78
[  390.608647]  __tcp_transmit_skb+0xfac/0x24e8
[  390.612908]  tcp_write_xmit+0xbec/0x3078
[  390.616821]  __tcp_push_pending_frames+0x90/0x2b8
[  390.621515]  tcp_send_fin+0x108/0x9a8
[  390.625167]  tcp_shutdown+0xd8/0xf8
[  390.628646]  inet_shutdown+0x14c/0x2e8
[  390.632385]  kernel_sock_shutdown+0x5c/0x98
[  390.636560]  __nvme_tcp_stop_queue+0x44/0x220 [nvme_tcp]
[  390.641865]  nvme_tcp_stop_queue_nowait+0x130/0x200 [nvme_tcp]
[  390.647691]  nvme_tcp_setup_ctrl+0x3bc/0x728 [nvme_tcp]
[  390.652909]  nvme_tcp_reconnect_ctrl_work+0x78/0x290 [nvme_tcp]
[  390.658822]  process_one_work+0x80c/0x1a78
[  390.662910]  worker_thread+0x6d0/0xaa8
[  390.666650]  kthread+0x304/0x3a0
[  390.669869]  ret_from_fork+0x10/0x20
[  390.673437] task:kworker/u322:77 state:D stack:27184 pid:4784
tgid:4784  ppid:2      task_flags:0x4208060 flags:0x00000210
[  390.684562] Workqueue: nvmet-wq nvmet_tcp_release_queue_work [nvmet_tcp]
[  390.691256] Call trace:
[  390.693692]  __switch_to+0x1d8/0x330 (T)
[  390.697605]  __schedule+0x860/0x1c30
[  390.701171]  schedule_rtlock+0x30/0x70
[  390.704911]  rwbase_write_lock.constprop.0.isra.0+0x2fc/0xb30
[  390.710646]  rt_write_lock+0x9c/0x138
[  390.714299]  nvmet_tcp_release_queue_work+0x168/0xb48 [nvmet_tcp]
[  390.720384]  process_one_work+0x80c/0x1a78
[  390.724470]  worker_thread+0x6d0/0xaa8
[  390.728210]  kthread+0x304/0x3a0
[  390.731428]  ret_from_fork+0x10/0x20


-- 
Best Regards,
  Yi Zhang

