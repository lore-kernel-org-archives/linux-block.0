Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB0EA32
	for <linux-block@vger.kernel.org>; Fri, 11 Jul 2025 07:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752217464; cv=none; b=Z4KogVN/Fe0IfUsG56RB5qEL2wzfbsS/beJ2/cVoFXpTnaI9gixwKtBtf9gr0lc/tDiCrVi4V59YE4iJdsR+sNPdl6dqCVsiUtR/eQQIj8J9e93AM4TTEqvbNCbIcVOkpqJs9Uj5iagiywLcHpMy+9yiMM+Vf3VdST26j6/6FEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752217464; c=relaxed/simple;
	bh=Y2knosoW+4Nu7fAjfNCGSdWDubhgGsVxF8MqtSL31cQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=U7fhprzNMr4SCHcGVnT0g9uMc3C2OSun1mXTVAU+e1JdonN976qzOhDHgQe4odJZXwIOwNAnvmm88qcmGESlyMMs9OEXcLLr0Ap9zexjef6MBH3tqw7ccMA9xrTiP8i6S5TLRVMgO0oSQgRsqH1K7Wv0UNpTrKfMSTOET4Mdqnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=S2T0UI7Z; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S2T0UI7Z"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-31c38e75dafso1582914a91.2
        for <linux-block@vger.kernel.org>; Fri, 11 Jul 2025 00:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1752217462; x=1752822262; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6LXIV2Gq9HLLgeJUYaj6Eb1VhhwLGzBLega5iQdaGc8=;
        b=S2T0UI7ZGgS8Rc0ksaYCYA4IHZD2oA5Dnnfcr4ALinA/fj43F7aCT+lWjixVqi9xJl
         7V5FTZOIeqJvfBuphWYZ7rWwCdWd7UmJnATd4aSOl/i3XKPuarL6DA0lhwxQ3JAACyMO
         pHln08eZXJLarcFVgdJEjXMfr0ygf6kqwriG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752217462; x=1752822262;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6LXIV2Gq9HLLgeJUYaj6Eb1VhhwLGzBLega5iQdaGc8=;
        b=hFYJLFOVTITEVwsyzAxb50sQ1db0z7Sk6AnMr5eRoC3y4w3ysUm6aEmyx/AmBfp2bA
         vGGtddFd70Bo3HDG+VqfWNNoMGYFq6mvVViLqx6jAEV12pA6IInwDfyQMC7akyI73oio
         LYClAmhjSSvxGBOcNFhJ8L8af5wI4cgKXTrc+W8Cp87XW0fT4NnrLcFOy4UJwgFuQowe
         +yeLjpHHJgxkXkkzF66EhBuYyZZMVTmsvUea+dIqXKLgtKzdaSahPFQ+c3yMwWNkJFzL
         Yx7cKaXPjXIP8NJyumc87sVQqZ8m6npVe6z3DdMqeUQpVJKhtUj41y8d32oBo/VtuB9N
         TAew==
X-Forwarded-Encrypted: i=1; AJvYcCUnV8Y3Y9sxhcKHMbgXaWxst7NsBuDflT8VYESoWXt4rtmYO7XpJbuWMLM0xOsZlsuPWfazJ5EHRnjgJw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzniPUNEvn0s1E06m3P5Ik1gdSX1LgWer7JVb2YSPtNA6LuX3ya
	rd9QHAUrgo07So3i0tk2HW2HcNeITvFeJ+kwe52MHVY7HFgU8Cex85Bk2ccro09DPw==
X-Gm-Gg: ASbGncta5aOAF7tLx2BLUN2G5ABPt9lzZeHdP9IWG3PKpVl3F0efGeW7TC+r3sB2zjK
	AWMgJAV6OS4b4xL2AMUNfH0fR9/FhLIojhiV/RSejZBWK9DGEapOTX9vXlAo5nrowOkGmX/o0fE
	BdyDhZg1sMLTVVzZMDgNxlKZHOhV4ea6u4cCAZifTzX4mfZFaZ2JUS3T4BRnSBq2CxMaXD5ClUZ
	i6JyqZeUrHgTx2XTuT19p8Cf/hmF9KW2zHdr+BAb6kKoymxatkexTX628RYSPD7rZZ8+IvDHq1O
	og+cv0XRDjvu8csz12X4MwniZ0yniu/RTL8zx3QKtTsnVH1/7Ev2fQwWYhpu8tb7zT+XCVs10iA
	MdZisNguUL+nC9K/3qD8tmIsh
X-Google-Smtp-Source: AGHT+IGHuVtZZysdgymmFoLrlBJdG+mI3CBXaytS1FE7dNiWZCW+ndbBQD1raYD1f5BYuPW/9buodQ==
X-Received: by 2002:a17:90a:e7d1:b0:311:2f5:6b1 with SMTP id 98e67ed59e1d1-31c4ccddbd8mr3302077a91.22.1752217462338;
        Fri, 11 Jul 2025 00:04:22 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:1248:20c:c8b1:669b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3017cc3bsm7795159a91.24.2025.07.11.00.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 00:04:21 -0700 (PDT)
Date: Fri, 11 Jul 2025 16:04:17 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Phillip Potter <phil@philpotter.co.uk>, Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>, 
	Chris Rankin <rankincj@gmail.com>, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: cdrom: cdrom_mrw_exit() NULL ptr deref
Message-ID: <uxgzea5ibqxygv3x7i4ojbpvcpv2wziorvb3ns5cdtyvobyn7h@y4g4l5ezv2ec>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

We are seeing the same NULL ptr deref upon cdrom release, as reported
in [1] (Chris Cc-ed) in our fleet.  Currently on 6.6 LTS (could be the
same for older kernels as well, I didn't check.)

Phillip, is this a known issue?

<1>[335443.339244] BUG: kernel NULL pointer dereference, address: 0000000000000010
<1>[335443.339262] #PF: supervisor read access in kernel mode
<1>[335443.339268] #PF: error_code(0x0000) - not-present page
<6>[335443.339273] PGD 0 P4D 0
<4>[335443.339279] Oops: 0000 [#1] PREEMPT SMP NOPTI
<4>[335443.339287] CPU: 1 PID: 1988 Comm: cros-disks Not tainted 6.6.76-07501-gd42535a678fb #1 (HASH:7d84 1)
<4>[335443.339301] RIP: 0010:blk_queue_enter+0x5a/0x250
<4>[335443.339312] Code: 03 00 00 4c 8d 6d a8 eb 1c 4c 89 e7 4c 89 ee e8 8c 62 be ff 49 f7 86 88 00 00 00 02 00 00 00 0f 85 ce 01 00 00 e8 86 10 bd ff <49> 8b 07 a8 03 0f 85 85 01 00 00 65 48 ff 00 41 83 be 90 00 00 00
<4>[335443.339318] RSP: 0018:ffff9be08ab03b00 EFLAGS: 00010202
<4>[335443.339324] RAX: ffff8903aa366300 RBX: 0000000000000000 RCX: ffff9be08ab03cd0
<4>[335443.339330] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
<4>[335443.339333] RBP: ffff9be08ab03b58 R08: 0000000000000002 R09: 0000000000001b58
<4>[335443.339338] R10: ffffffff00000000 R11: ffffffffc0ccd030 R12: 0000000000000328
<4>[335443.339344] R13: ffff9be08ab03b00 R14: 0000000000000000 R15: 0000000000000010
<4>[335443.339348] FS: 00007d52be81e900(0000) GS:ffff8904b6040000(0000) knlGS:0000000000000000
<4>[335443.339357] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
<4>[335443.339362] CR2: 0000000000000010 CR3: 0000000140ac6000 CR4: 0000000000350ee0
<4>[335443.339367] Call Trace:
<4>[335443.339372] <TASK>
<4>[335443.339379] ? __die_body+0xae/0xb0
<4>[335443.339389] ? page_fault_oops+0x381/0x3e0
<4>[335443.339398] ? exc_page_fault+0x4f/0xa0
<4>[335443.339404] ? asm_exc_page_fault+0x22/0x30
<4>[335443.339416] ? sr_check_events+0x290/0x290 [sr_mod (HASH:ab3e 2)]
<4>[335443.339432] ? blk_queue_enter+0x5a/0x250
<4>[335443.339439] blk_mq_alloc_request+0x16a/0x220
<4>[335443.339450] scsi_execute_cmd+0x65/0x240
<4>[335443.339458] sr_do_ioctl+0xe3/0x210 [sr_mod (HASH:ab3e 2)]
<4>[335443.339471] sr_packet+0x3d/0x50 [sr_mod (HASH:ab3e 2)]
<4>[335443.339482] cdrom_mrw_exit+0xc1/0x240 [cdrom (HASH:9d9a 3)]
<4>[335443.339497] sr_free_disk+0x45/0x60 [sr_mod (HASH:ab3e 2)]
<4>[335443.339506] disk_release+0xc8/0xe0
<4>[335443.339515] device_release+0x39/0x90
<4>[335443.339523] kobject_release+0x49/0xb0
<4>[335443.339533] bdev_release+0x19/0x30
<4>[335443.339540] deactivate_locked_super+0x3b/0x100
<4>[335443.339548] cleanup_mnt+0xaa/0x160
<4>[335443.339557] task_work_run+0x6c/0xb0
<4>[335443.339563] exit_to_user_mode_prepare+0x102/0x120
<4>[335443.339571] syscall_exit_to_user_mode+0x1a/0x30
<4>[335443.339577] do_syscall_64+0x7e/0xa0
<4>[335443.339582] ? exit_to_user_mode_prepare+0x44/0x120
<4>[335443.339588] entry_SYSCALL_64_after_hwframe+0x55/0xbf
<4>[335443.339595] RIP: 0033:0x7d52bea41f07

[1] https://lore.kernel.org/all/CAK2bqVJGsz8r8D-x=4N6p9nXQ=v4AwpMAg2frotmdSdtjvnexg@mail.gmail.com/
