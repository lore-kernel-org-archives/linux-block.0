Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330117405A
	for <linux-block@vger.kernel.org>; Fri, 10 Oct 2025 15:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760108451; cv=none; b=R7mtMzFdt1kxc92t9/2h0DlAxGmm8js2z2OXVvWSFQTPAOhSHt/JVDk5Mp1n2ikkHE/nq/b1HN/0n7atRrG7EUZm0NQNscvosGacGmNuu6C96l6DR6gGcWP4ZyucbdXwyIE0zVOg4vx8dxYIFowiFWNiQiKPtfUMze2kTFRB6UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760108451; c=relaxed/simple;
	bh=pp246uTerFZJog/e4hjFA9+XB/z68RB5I0evQ/CPXSw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EL09/nXUvkJNQcSE4qep8JRWc/ViTcxVuWGGCOEiC0UMfigoGk1Prewuk1yAkL0hShPGZAOC+LsmIzU/MKyNDYrG9PaSh1Prvcj98q5MuK2lBHbmNksAQ8EZJ/YFmQ72JSVs0ZMsIGXQukxSZlkB2X3jNYe0p+G6vAENkAPZfII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=DxekZ+5s; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="DxekZ+5s"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-32eb45ab7a0so2357323a91.0
        for <linux-block@vger.kernel.org>; Fri, 10 Oct 2025 08:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760108449; x=1760713249; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PrnkWgVz/Z49/J8nG6GzbbPnjpZrG1a+SrZMq+zyDL0=;
        b=DxekZ+5skgFkvqgU6WuwVzk9hY7rSewoNtCFzppYRPWjIxh5GzTEljyVUZH+zG0fUb
         mNbSnfsT3gM61WkBPbG7ZSB2qr9hXH2nm6pJ+nTZePkudmQr78Iis9g3AQl3/h3pq8Dz
         pSqLfqloidh1Ew1IkVMEYedvW52lZQQhic9EKnGoCnJ+oRiJeGw9FWkwQbguZY63hMU0
         uaFPItLW5lnDXs9+HGt0kQpkc9hYwWPCeMP63rWssiRCaUsEqP6CLzXOUGVySQHr9tzH
         Zd+L8scuSAAI7AQSwvqWMepbDCkuDpwimVCkpuozVbyOx5RkkEtolGqju/2cnJiTDqKZ
         n3+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760108449; x=1760713249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PrnkWgVz/Z49/J8nG6GzbbPnjpZrG1a+SrZMq+zyDL0=;
        b=ve6JQ11MGyDnOArFcbyvX9s+1T+qGLKc/aQz1gD/mzcKt1zMqh4Qt5XMa4WkvdJ+P5
         KqjIgDpivuOR10ZYfnZExLCM02mUrLcZSKbSfE119bQ9f6JqXQG+WojSX5mrdVIa8CRM
         QUztS2FAYFOJM8QDxd/7vdM2ePz3Bph722pBdJxkB7A5m+D4AsllAEwW8oe0jELPJoEC
         eJ0e5GWJm8xjLG2uZUmOxWF4sJYyI6+lwvDIOuBnI/hvtbbxahCe8IjGwBUl3K8TnckU
         ODZrVTYBeHGKJn5NjyqzmewHIVEXXfop24Q+GZFDDIUfhXe/PzjLbCdosFQIUqld9EY7
         0b1g==
X-Forwarded-Encrypted: i=1; AJvYcCVrysAq9wZnmt32rzB8MKwrXSjoq0Okbz+N6hrcc3tIOEfbcetetCNJvREK4wmS6ZTIIL4xviC5c6UjRQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwmGIGH9hcuLbpqH6ZYmG5jokGnwXltBGrTHgiE0XFdPgIpgQrQ
	rwPlEL9kz4b1fIOxt49A2yIVXEnM7XwNKgHmcMYXVMFM2Rig14+bHOBB277afMtznoMIgWeHb2/
	m9yIgOx26Hxu2dgQ30l661GC+A2tbphAKM3/e5MQs
X-Gm-Gg: ASbGncs2dDASkF7Cy8j8q3s60n3Z7R5eW+gm51mqDoUIq1+1KQqILk8hPPKGxO+RVWN
	sbAxvPul+713dKWhZINXJNsAFGmiLMVV47wbjYwnJuPHDsgap5tV59PDiLYO5w1MFYwBMXhvZuU
	wPPLQnQGkNeKb4sORZ6q0+4ykan7FpUPFu8FV3WjKoAVfv4bs+FVsZaAhfJfqpbRSfxdVYXj7P0
	iMwDrXsdRi08gjJB1m9O7gBkw==
X-Google-Smtp-Source: AGHT+IHTYyhEFkKDD3X150o5MD7ZP8eFJxfaJJZoy46BgzM/dN96rHz0DqKMzJSZ8COyShPASIiBWoiLtZwKUFbGRtg=
X-Received: by 2002:a17:90b:1d8b:b0:32b:355a:9de with SMTP id
 98e67ed59e1d1-33b513d005amr16427754a91.32.1760108448726; Fri, 10 Oct 2025
 08:00:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010080900.1680512-1-omosnace@redhat.com>
In-Reply-To: <20251010080900.1680512-1-omosnace@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 10 Oct 2025 11:00:37 -0400
X-Gm-Features: AS18NWDk8nitfjQpo1v3aBdPKBaoi907QLUPlKp_SF-2hEkCLZTSq-1OKrB7XMM
Message-ID: <CAHC9VhQxnTsZV=vjf1Wk5po16mLuKNPoi3UR-7gN6PxodncgxQ@mail.gmail.com>
Subject: Re: [PATCH v2] nbd: override creds to kernel when calling sock_{send,recv}msg()
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	nbd@other.debian.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 4:09=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.co=
m> wrote:
>
> sock_{send,recv}msg() internally calls security_socket_{send,recv}msg(),
> which does security checks (e.g. SELinux) for socket access against the
> current task. However, _sock_xmit() in drivers/block/nbd.c may be called
> indirectly from a userspace syscall, where the NBD socket access would
> be incorrectly checked against the calling userspace task (which simply
> tries to read/write a file that happens to reside on an NBD device).
>
> To fix this, temporarily override creds to kernel ones before calling
> the sock_*() functions. This allows the security modules to recognize
> this as internal access by the kernel, which will normally be allowed.
>
> A way to trigger the issue is to do the following (on a system with
> SELinux set to enforcing):
>
>     ### Create nbd device:
>     truncate -s 256M /tmp/testfile
>     nbd-server localhost:10809 /tmp/testfile
>
>     ### Connect to the nbd server:
>     nbd-client localhost
>
>     ### Create mdraid array
>     mdadm --create -l 1 -n 2 /dev/md/testarray /dev/nbd0 missing
>
> After these steps, assuming the SELinux policy doesn't allow the
> unexpected access pattern, errors will be visible on the kernel console:
>
> [  142.204243] nbd0: detected capacity change from 0 to 524288
> [  165.189967] md: async del_gendisk mode will be removed in future, plea=
se upgrade to mdadm-4.5+
> [  165.252299] md/raid1:md127: active with 1 out of 2 mirrors
> [  165.252725] md127: detected capacity change from 0 to 522240
> [  165.255434] block nbd0: Send control failed (result -13)
> [  165.255718] block nbd0: Request send failed, requeueing
> [  165.256006] block nbd0: Dead connection, failed to find a fallback
> [  165.256041] block nbd0: Receive control failed (result -32)
> [  165.256423] block nbd0: shutting down sockets
> [  165.257196] I/O error, dev nbd0, sector 2048 op 0x0:(READ) flags 0x0 p=
hys_seg 1 prio class 2
> [  165.257736] Buffer I/O error on dev md127, logical block 0, async page=
 read
> [  165.258263] I/O error, dev nbd0, sector 2048 op 0x0:(READ) flags 0x0 p=
hys_seg 1 prio class 2
> [  165.259376] Buffer I/O error on dev md127, logical block 0, async page=
 read
> [  165.259920] I/O error, dev nbd0, sector 2048 op 0x0:(READ) flags 0x0 p=
hys_seg 1 prio class 2
> [  165.260628] Buffer I/O error on dev md127, logical block 0, async page=
 read
> [  165.261661] ldm_validate_partition_table(): Disk read failed.
> [  165.262108] I/O error, dev nbd0, sector 2048 op 0x0:(READ) flags 0x0 p=
hys_seg 1 prio class 2
> [  165.262769] Buffer I/O error on dev md127, logical block 0, async page=
 read
> [  165.263697] I/O error, dev nbd0, sector 2048 op 0x0:(READ) flags 0x0 p=
hys_seg 1 prio class 2
> [  165.264412] Buffer I/O error on dev md127, logical block 0, async page=
 read
> [  165.265412] I/O error, dev nbd0, sector 2048 op 0x0:(READ) flags 0x0 p=
hys_seg 1 prio class 2
> [  165.265872] Buffer I/O error on dev md127, logical block 0, async page=
 read
> [  165.266378] I/O error, dev nbd0, sector 2048 op 0x0:(READ) flags 0x0 p=
hys_seg 1 prio class 2
> [  165.267168] Buffer I/O error on dev md127, logical block 0, async page=
 read
> [  165.267564]  md127: unable to read partition table
> [  165.269581] I/O error, dev nbd0, sector 0 op 0x0:(READ) flags 0x0 phys=
_seg 1 prio class 2
> [  165.269960] Buffer I/O error on dev nbd0, logical block 0, async page =
read
> [  165.270316] I/O error, dev nbd0, sector 0 op 0x0:(READ) flags 0x0 phys=
_seg 1 prio class 2
> [  165.270913] Buffer I/O error on dev nbd0, logical block 0, async page =
read
> [  165.271253] I/O error, dev nbd0, sector 0 op 0x0:(READ) flags 0x0 phys=
_seg 1 prio class 2
> [  165.271809] Buffer I/O error on dev nbd0, logical block 0, async page =
read
> [  165.272074] ldm_validate_partition_table(): Disk read failed.
> [  165.272360]  nbd0: unable to read partition table
> [  165.289004] ldm_validate_partition_table(): Disk read failed.
> [  165.289614]  nbd0: unable to read partition table
>
> The corresponding SELinux denial on Fedora/RHEL will look like this
> (assuming it's not silenced):
> type=3DAVC msg=3Daudit(1758104872.510:116): avc:  denied  { write } for  =
pid=3D1908 comm=3D"mdadm" laddr=3D::1 lport=3D32772 faddr=3D::1 fport=3D108=
09 scontext=3Dsystem_u:system_r:mdadm_t:s0-s0:c0.c1023 tcontext=3Dunconfine=
d_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 tclass=3Dtcp_socket permissive=
=3D0
>
> The respective backtrace looks like this:
> @security[mdadm, -13,
>         handshake_exit+221615650
>         handshake_exit+221615650
>         handshake_exit+221616465
>         security_socket_sendmsg+5
>         sock_sendmsg+106
>         handshake_exit+221616150
>         sock_sendmsg+5
>         __sock_xmit+162
>         nbd_send_cmd+597
>         nbd_handle_cmd+377
>         nbd_queue_rq+63
>         blk_mq_dispatch_rq_list+653
>         __blk_mq_do_dispatch_sched+184
>         __blk_mq_sched_dispatch_requests+333
>         blk_mq_sched_dispatch_requests+38
>         blk_mq_run_hw_queue+239
>         blk_mq_dispatch_plug_list+382
>         blk_mq_flush_plug_list.part.0+55
>         __blk_flush_plug+241
>         __submit_bio+353
>         submit_bio_noacct_nocheck+364
>         submit_bio_wait+84
>         __blkdev_direct_IO_simple+232
>         blkdev_read_iter+162
>         vfs_read+591
>         ksys_read+95
>         do_syscall_64+92
>         entry_SYSCALL_64_after_hwframe+120
> ]: 1
>
> The issue has started to appear since commit 060406c61c7c ("block: add
> plug while submitting IO").
>
> Cc: Ming Lei <ming.lei@redhat.com>
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D2348878
> Fixes: 060406c61c7c ("block: add plug while submitting IO")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>
> Changes in v2:
>  * Move put_cred() after destroy_workqueue() in nbd_cleanup() to avoid a =
UAF
>  * Add some more details into the commit message
>  * Add a Fixes: tag
>
> v1: https://lore.kernel.org/linux-block/20251009134542.1529148-1-omosnace=
@redhat.com/
>
>  drivers/block/nbd.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
