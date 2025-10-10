Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2770A2882AC
	for <linux-block@vger.kernel.org>; Fri, 10 Oct 2025 12:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760098108; cv=none; b=HFl4nJd23zTZhiOZ968JMq6qS4WhEQNyvQrS4w96Wb5tNTZmDZE6oeEc0OkjeVMCkYMDN+nYdGLy/pG7brx4h3pR5vEpMZyLFpPDKGMe6obPdAaUfNCnqg5akzppPMZzoTDpSUXcm3GaSfH8fZlSuMTWu3sMe2iJ6DrvfWyiRVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760098108; c=relaxed/simple;
	bh=zcaI6CSEbhqxLoQcI9taAy0s6jtPiBiF0WGMdYpmq18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=et3XhrejkhSEdDLcb7//5ZISrvXuU68HB5nDU8rFwW5Q2OtH7AicwbIRkd+lEz6ffkTZVdlEaLdf4AAfPNsn4JXYWo0fi4wUBCS+oMrf7RWeFjZSCiodv8S8Tym2rORbzo2xjTIHSXWSq9O/PB+h+SiKQruos1JpTc9J/BlPOu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jDu+fuFz; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jDu+fuFz"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3307de086d8so1917645a91.2
        for <linux-block@vger.kernel.org>; Fri, 10 Oct 2025 05:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760098106; x=1760702906; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gyN7lXnTaK8IaXEFqCkUb5h/ibnrqzy+7MVgC3+77oo=;
        b=jDu+fuFzd9BcGFDYDG9cbc5zUu7pefIn0vhypkMSJ5jvSRw40BRl1InKbaLKMiRoWm
         c1zx0kDXVOFUaIiGQCDQXZDT9lnnsSJ2cQhBK0crTt0NYUHIhiYbGFrORWr3wZBXUCi/
         GloUU7qJy+uuEf6f8g7too9RA5Td5KN7Yc4jZ+hjTwO6zo7JU0Q3wJ/xEZGeV8LbqDPI
         fb0YE42DeFg7CR7COPPZ2S2m1Wt3dln7fTUDQYgjalCTiV3fZN2wKql5UlYpWVt363jA
         Vanhv7dzONxQEdgbjPoCPg1casmBByfuDsJisJ83KQg93oVNQZhowaXJt8kHRzcGcg6k
         R2kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760098106; x=1760702906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gyN7lXnTaK8IaXEFqCkUb5h/ibnrqzy+7MVgC3+77oo=;
        b=V7TgFuQUf3jAv6I25glo/xitP3T2Yh/L8QIaqQfBXlb972s1lPWjmSNEa8fuDdt464
         nR+cku/4Pt8hUW0DJE6W6UEHgYfMgl/4elAIv4SOGh2DuRGTbAlvCyYwRmau8DuHeLiE
         d6SfY2lXfSKpmYLj8nSewvIggo+Mr8P09rHM+klLzifj1gZvV2QuwM3yycO4kggj3U3y
         c5eMOJYu8+4N+l4cBMjmx8xrxC0g1GMDEshkSBJUY8dSNLoQFbSPbey5zBC38m1RxaMa
         ogzgQFAulfQOX9LARaK32D9Dmq2ZktAIGMyJcvIurfdW+ptw95fJtEI+co/RH5LAFW0Y
         dFZg==
X-Forwarded-Encrypted: i=1; AJvYcCVw/AxZwpQ+FuIGEKLVgNpk31JUxSlj6AVCkgGLtfiePl1vu6lOQQOVeBJGcqKwmDjTWkG6irduW8bGoA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwVoreXv+7cec0hW3i9dICb93Snpr+Gib3BJEIvIVV/qIs5e+QC
	bWMAIIr7YGx9qnSk+RlRiKMr54Op3fCRzbg/RPv/aAI7Hg8MoGaMY7dAhXxgeRTzKr4amZJicnp
	hAtyhhYbVI3Og4E59+YWbk/3pR9HLe9g=
X-Gm-Gg: ASbGncuOOFF38prtw6+P7MoHWwNoZfGtNI+vdP8eBQSPCIFWGdIq48zwD2sG7KillAV
	nTR9SV7hUd/5uOFUFSX6dsC9T+l/Wre8fT7amVvkDd1bLnsaetck0OiDCzjBrnvpA/Q2y/ujmFh
	aT3K4xUnXFkgrImIYTTVqkfoVO5Ys2Dia3PM+gzbkOoRhtJ33OLCeZWnSu2xwm41iZjt0fjfTIJ
	OZzX2SpQ2mm85YE37e4Db5yow==
X-Google-Smtp-Source: AGHT+IFKYzOMQc122jmlre5WJIXFEi/4+PfvNDcYAbH1vr/MLmoCXHZvxwb00ePPpGWd+GqkYLTKVWQTMxl08jlTSTg=
X-Received: by 2002:a17:90b:1b11:b0:330:7f80:bbd9 with SMTP id
 98e67ed59e1d1-33b5139a422mr13988155a91.31.1760098105906; Fri, 10 Oct 2025
 05:08:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010080900.1680512-1-omosnace@redhat.com>
In-Reply-To: <20251010080900.1680512-1-omosnace@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 10 Oct 2025 08:08:14 -0400
X-Gm-Features: AS18NWDxhhZAS1kvm57-iPhBXV02-sgGciufiPMvEf50RLd-mNe42UizpQ0NPWU
Message-ID: <CAEjxPJ4bpznYK+MvFOseq84oGPexcE3SKaUDv-S97-s1nRROow@mail.gmail.com>
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

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

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
>
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 6463d0e8d0cef..3903186e8a4e4 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -52,6 +52,7 @@
>  static DEFINE_IDR(nbd_index_idr);
>  static DEFINE_MUTEX(nbd_index_mutex);
>  static struct workqueue_struct *nbd_del_wq;
> +static struct cred *nbd_cred;
>  static int nbd_total_devices =3D 0;
>
>  struct nbd_sock {
> @@ -554,6 +555,7 @@ static int __sock_xmit(struct nbd_device *nbd, struct=
 socket *sock, int send,
>         int result;
>         struct msghdr msg =3D {} ;
>         unsigned int noreclaim_flag;
> +       const struct cred *old_cred;
>
>         if (unlikely(!sock)) {
>                 dev_err_ratelimited(disk_to_dev(nbd->disk),
> @@ -562,6 +564,8 @@ static int __sock_xmit(struct nbd_device *nbd, struct=
 socket *sock, int send,
>                 return -EINVAL;
>         }
>
> +       old_cred =3D override_creds(nbd_cred);
> +
>         msg.msg_iter =3D *iter;
>
>         noreclaim_flag =3D memalloc_noreclaim_save();
> @@ -586,6 +590,8 @@ static int __sock_xmit(struct nbd_device *nbd, struct=
 socket *sock, int send,
>
>         memalloc_noreclaim_restore(noreclaim_flag);
>
> +       revert_creds(old_cred);
> +
>         return result;
>  }
>
> @@ -2669,7 +2675,15 @@ static int __init nbd_init(void)
>                 return -ENOMEM;
>         }
>
> +       nbd_cred =3D prepare_kernel_cred(&init_task);
> +       if (!nbd_cred) {
> +               destroy_workqueue(nbd_del_wq);
> +               unregister_blkdev(NBD_MAJOR, "nbd");
> +               return -ENOMEM;
> +       }
> +
>         if (genl_register_family(&nbd_genl_family)) {
> +               put_cred(nbd_cred);
>                 destroy_workqueue(nbd_del_wq);
>                 unregister_blkdev(NBD_MAJOR, "nbd");
>                 return -EINVAL;
> @@ -2724,6 +2738,7 @@ static void __exit nbd_cleanup(void)
>         /* Also wait for nbd_dev_remove_work() completes */
>         destroy_workqueue(nbd_del_wq);
>
> +       put_cred(nbd_cred);
>         idr_destroy(&nbd_index_idr);
>         unregister_blkdev(NBD_MAJOR, "nbd");
>  }
> --
> 2.51.0
>
>
