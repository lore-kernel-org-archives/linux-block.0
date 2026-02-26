Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF6029B77C
	for <linux-block@vger.kernel.org>; Thu, 26 Feb 2026 10:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772102898; cv=pass; b=HJgyVor4Oj+pJhq8WIGSNTWgSUyKwWMdHCPuDpRZk5r7ybkh+hnig4y8ehpJBklWCAym+TsknCLDCU2QIH8zrmXUC6TU9VnPEDZgDq8BhNjRykUa3UNLlCVv1bHYpTnBn/1cmxScu8e86AuS14kC5P8PzwxZc1dnaDeq3JhHuZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772102898; c=relaxed/simple;
	bh=9KOOI/TBpQm5SXL9vvlraeen0p9NnsJWf159aLuIsP8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XK99ZZB3Q/d5OWrWUduaElZzAFPMTpNq2KkpPtH8UU1Um/KjWEzGAEm3P7aJedbN5bQlZ1EgGu16XsPXQlUmwHA8tcaETbvQDGyQNk97wBTKaYSweFKGCb4CmRYEVN9M8fl8PUm541j0bFtApnhutqqOtWZ++2IW2xL5ePLGgMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FHEWdl38; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=TAvoubj3; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FHEWdl38";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="TAvoubj3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772102896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EEAIiy0cX7HmjFEi1Ezk7H57ZUWzHsKoXfvbKhwg8C8=;
	b=FHEWdl38E2R34nUPxaOWLsEHkrID4hf4hxX7QtoE3l9+SyjhOZafsJwSQGFkvWf0HJk+NN
	0eI6nSpQgjAvogiKjY6lZk+BV6zkGyD2KDL9ioaHl2VPrHDucrL/bfmIcizc7blnG+MWjq
	zRM5jUj/2tufiHzdfkGlQDSsaZsC+/U=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-1nIH0UU6MF6ZFX32JchGWg-1; Thu, 26 Feb 2026 05:48:14 -0500
X-MC-Unique: 1nIH0UU6MF6ZFX32JchGWg-1
X-Mimecast-MFC-AGG-ID: 1nIH0UU6MF6ZFX32JchGWg_1772102894
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-94d6c5433a0so9664208241.1
        for <linux-block@vger.kernel.org>; Thu, 26 Feb 2026 02:48:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772102893; cv=none;
        d=google.com; s=arc-20240605;
        b=kRg+6AcdUzBgc3GOZFqLHLr1W/EjPiccpVRt+EAFKKLwu2Kd+twGYdHUcFclEjTPY+
         Tye2ZIL4TZ/+KpMlirprfKei5zc8oTczQL2oUZDLfiZWyPfn7iE2H6i04AWlMHOFvG0Q
         zajKT5J3XfJSzrF8+KFP5eyU/vuvADyUy5T5ET+N1kSjW4+7IBUoB+noRAgaWvu2XeEG
         c8uf9EZtqcKzU262Vq2JgQaqS0PFgJvl396F7tCD34rRWOGyUIl7MLMtwIcaelbLxpiJ
         mrOoOWcdqHhIZA/9UVzxXoN9aCZc4JUleI7OLSW0z4kVYysWDeAjUKOeJesgIhBQR899
         5ZVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EEAIiy0cX7HmjFEi1Ezk7H57ZUWzHsKoXfvbKhwg8C8=;
        fh=iROjcOdfxFe2m64+T8H4wO5ni8/g6pgDAoPhk3O8eHE=;
        b=L2WBD4ecndvLXh7mLgedXZNYyMSTpqWazTFQgIzXnYFiZyjuHDhWgIUnx2ujjbQY2P
         TCNB1AOywN9NxmrxUYXmr1S5fcl+IyOgGcfVOrFB6dxf/gAD5ZVhSlxG4mo7kssMmjfS
         qIlA0rvwt5t64rnkYSGVcA9XebMiZv01scPbQjPiGEWS5TXI6bhGuP9ulYh4o7hg5LeV
         rtQ1mMPKkLCQfofABVVZTQdWI5ZZ4MaJtubRaIZNft4g9z0M2E36WXInh4/hmRk+Jqzl
         IoHrXcFh9Q+TO1F5hoTV3QgXSPTyuE7xpG13HeIqtP7hzlJs0x2ULaLDVPJ9cKAVeyEB
         LZIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772102893; x=1772707693; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EEAIiy0cX7HmjFEi1Ezk7H57ZUWzHsKoXfvbKhwg8C8=;
        b=TAvoubj3yxFKMUIC9DY/uyv4zAXEpt6M/USn0dpRy1ON5fcXlsPeQf/ZlmE5KFbWe4
         yQgkP1Kl0AYsCFZ+gGp0VrZYHCscOiqXzmoKLp/CrQIlpF5Kx7AHCJtv2Ug02/uMS3YH
         MiGK5fT7gN9kmqM+UzeBx0pJL2GWDuCQuaDTYpev0zvCq5KtYnwucCCumjRKdECEWvqi
         +S4JvwU1f0O5WR1u/9tjnic/Gn6Hccc37L9DMVYCJzsKoGakf9rUZ6S03HyNHq6zgmA9
         L5D3Z8A/by0jnbLMVETcc9n5u1rOJ4QLgyLFntEo71BdZ7I2k7sx3FjNPLS669/BDV7Y
         PuAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772102893; x=1772707693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EEAIiy0cX7HmjFEi1Ezk7H57ZUWzHsKoXfvbKhwg8C8=;
        b=vJ70QMl9MKfluB++sX+waZmpnwkFkoovPdnhOo+Z6oAfy9bZs/Ysybs4M6SP60gIEl
         xD0Pb2gr+ixbiKwWunHoqLkSKt8FEj4MXACgHjqzDWG3XeiQYgNcloK6Un5Rb+di3BoQ
         V9yC+cvBiO5fI9qRw1ferMMIooh5xPNmc+OLBZKu1xSjRf6gKppknCt7hkhkDgczQSMq
         8scHH7gAhzYmmBTgUwXj6hV+r00GITMwv+yHu0wOjcjATRhUAUtrffrWlgeYoOJYlsSg
         wzznC0NxwVBg2NXiNVeA0JzWYqFrwIo8sZX82m2ZMG35pCHuu4Ej34mVbv/Zm39x3uq3
         HMQA==
X-Gm-Message-State: AOJu0YysiDoUeDpJwArVhufl2n6XtWXdgqhHpoIl17dJsYevAwCb7VYF
	rxeMqqrGpgiRRaqKpiyBoPQiBInzCo40q69iebg+wjSNFKLTxW0dA25Gm04Hx4idd3ZoQ3f0jvl
	8Mrl/QYHwg105UFJifvi5EIvTiLM0dA8A5/QeLHrDKY2mSoNEC6mOUgapQmj1tzQvmo6t2uUiLK
	bNGDTM/DL/xMUvmoidQw2srEnCNgxtxRZQiGcCNWNmd7u7cii5UG6R
X-Gm-Gg: ATEYQzw/kI1boV7yWpmpWt1GgpeirADcv7B9yEqUAcZV8pYZyrAWoB6IXyyGCWVcv/B
	VeFNhFP0+jSahmUI6jSL7DIFAX3H4EKDhE1hX49Gzm82BnXZtnifFGRyXjMtuFQUwfBlTGGj+4r
	GCvO2fYBCn6Qum/fue4JXUL77D+AabwbNk0CcQ3X6GaV0CQoQaw2LrN01YK2CEv874Jgc/IYr+i
	31OOS4=
X-Received: by 2002:a05:6102:3a09:b0:5ef:6550:e9f0 with SMTP id ada2fe7eead31-5ff20c71950mr949823137.36.1772102893486;
        Thu, 26 Feb 2026 02:48:13 -0800 (PST)
X-Received: by 2002:a05:6102:3a09:b0:5ef:6550:e9f0 with SMTP id
 ada2fe7eead31-5ff20c71950mr949812137.36.1772102893045; Thu, 26 Feb 2026
 02:48:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGVVp+U0EYVX+VbbEHzcYP70zdmOXwAmUvpMYV9y3jBSRFmS6g@mail.gmail.com>
In-Reply-To: <CAGVVp+U0EYVX+VbbEHzcYP70zdmOXwAmUvpMYV9y3jBSRFmS6g@mail.gmail.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Thu, 26 Feb 2026 18:48:01 +0800
X-Gm-Features: AaiRm53AfAQHBdsGvuk1gvgykxCcsoeLngJyiflDkBUZ25PumdBBGF1PQbqSyek
Message-ID: <CAFj5m9L8ahNYFf-tUAZFKAUzkeyqV-Sx94MxC268XJ-hqHPCig@mail.gmail.com>
Subject: Re: [bug report] Bug: Write fault blocked by KUAP!
To: Changhui Zhong <czhong@redhat.com>, Caleb Sander Mateos <csander@purestorage.com>
Cc: Linux Block Devices <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Changhui,

Thanks for the report!

Loop Caleb Sander Mateos  in.

Thanks,

On Thu, Feb 26, 2026 at 6:37=E2=80=AFPM Changhui Zhong <czhong@redhat.com> =
wrote:
>
> Hello,
>
> on the ppc64le arch, I hit the issue below with ublksrv on the latest
> linux-block/for-next, please help check it, and let me know if you
> need any info/test for it. Thanks.
>
> INFO: HEAD of cloned kernel
> commit 37a43fd770f3dcac8f72f3ea909b3e893e2385c9
> Merge: 13cd9b41227a c1dfbd7e71b0
> Author: Jens Axboe <axboe@kernel.dk>
> Date:   Wed Feb 25 08:37:06 2026 -0700
>
>     Merge branch 'for-7.1/block' into for-next
>
>     * for-7.1/block:
>       ublk: report BLK_SPLIT_INTERVAL_CAPABLE
>
> reproducer:
> compile and install https://github.com/ublk-org/ublksrv.git
> #echo 0 > /proc/sys/kernel/io_uring_disabled
> #modprobe ublk_drv
> #cd ublksrv
> #make test T=3Dnull
> #make test T=3Dloop
>
> dmesg log=EF=BC=9A
> Feb 26 00:24:30 ibm-p9z-27-lp26 journal: running null/002
> Feb 26 00:24:30 ibm-p9z-27-lp26 ublksrvd-0[57921]: start ublksrv io
> daemon ublksrvd-0
> Feb 26 00:24:30 ibm-p9z-27-lp26 ublksrvd-0[57921]: tid 57923: ublk dev
> 0 queue 0 started
> Feb 26 00:24:30 ibm-p9z-27-lp26 ublksrvd-0[57921]: tid 57924: ublk dev
> 0 queue 1 started
> Feb 26 00:24:36 ibm-p9z-27-lp26 NetworkManager[818]: <warn>
> [1772083476.4882] platform-linux: do-add-ip6-address[2:
> fe80::8448:a3ff:fe51:f102]: failure 13 (Permission denied - ipv6: IPv6
> is disabled on this device)
> Feb 26 00:24:36 ibm-p9z-27-lp26 NetworkManager[818]: <warn>
> [1772083476.4885] platform-linux: do-add-ip6-address[2:
> 2620:52:9:160c:8448:a3ff:fe51:f102]: failure 13 (Permission denied -
> ipv6: IPv6 is disabled on this device)
> Feb 26 00:24:36 ibm-p9z-27-lp26 NetworkManager[818]: <warn>
> [1772083476.4938] l3cfg[0f1985ec14299e62,ifindex=3D2]: unable to
> configure IPv6 route: type unicast fe80::/64 dev 2 metric 1024 mss 0
> rt-src ipv6ll
> Feb 26 00:24:38 ibm-p9z-27-lp26 NetworkManager[818]: <warn>
> [1772083478.4938] ipv6ll[95ab7f3fdbfe643d,ifindex=3D2]: changed: no IPv6
> link local address to retry after Duplicate Address Detection failures
> (back off)
> Feb 26 00:24:38 ibm-p9z-27-lp26 NetworkManager[818]: <warn>
> [1772083478.4943] platform-linux: do-add-ip6-address[2:
> 2620:52:9:160c:8448:a3ff:fe51:f102]: failure 13 (Permission denied -
> ipv6: IPv6 is disabled on this device)
> Feb 26 00:24:48 ibm-p9z-27-lp26 NetworkManager[818]: <warn>
> [1772083488.5034] platform-linux: do-add-ip6-address[2:
> fe80::8448:a3ff:fe51:f102]: failure 13 (Permission denied - ipv6: IPv6
> is disabled on this device)
> Feb 26 00:24:48 ibm-p9z-27-lp26 NetworkManager[818]: <warn>
> [1772083488.5037] platform-linux: do-add-ip6-address[2:
> 2620:52:9:160c:8448:a3ff:fe51:f102]: failure 13 (Permission denied -
> ipv6: IPv6 is disabled on this device)
> Feb 26 00:24:48 ibm-p9z-27-lp26 NetworkManager[818]: <warn>
> [1772083488.5041] l3cfg[0f1985ec14299e62,ifindex=3D2]: unable to
> configure IPv6 route: type unicast fe80::/64 dev 2 metric 1024 mss 0
> rt-src ipv6ll
> Feb 26 00:24:50 ibm-p9z-27-lp26 NetworkManager[818]: <warn>
> [1772083490.5034] ipv6ll[95ab7f3fdbfe643d,ifindex=3D2]: changed: no IPv6
> link local address to retry after Duplicate Address Detection failures
> (back off)
> Feb 26 00:24:50 ibm-p9z-27-lp26 NetworkManager[818]: <warn>
> [1772083490.5039] platform-linux: do-add-ip6-address[2:
> 2620:52:9:160c:8448:a3ff:fe51:f102]: failure 13 (Permission denied -
> ipv6: IPv6 is disabled on this device)
> Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: Kernel attempted to read user
> page (7fff81210000) - exploit attempt? (uid: 0)
> Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: ------------[ cut here ]---------=
---
> Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: Bug: Read fault blocked by KUAP!
> Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: WARNING:
> arch/powerpc/mm/fault.c:231 at bad_kernel_fault.isra.0+0xc8/0x2c0,
> CPU#5: lt-ublk.null/57924
> Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: Modules linked in: ublk_drv
> ext4 crc16 mbcache jbd2 raid10 raid1 raid0 dm_raid raid456
> async_raid6_recov async_memcpy async_pq async_xor async_tx xor
> raid6_pq nf_tables rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs
> lockd grace nfs_localio netfs bonding tls rfkill sg pseries_rng
> vmx_crypto fuse loop vsock_loopback vmw_vsock_virtio_transport_common
> vsock xfs sd_mod ibmvscsi ibmveth scsi_transport_srp sunrpc dm_mirror
> dm_region_hash dm_log dm_multipath dm_mod nfnetlink [last unloaded:
> nbd]
> Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: CPU: 5 UID: 0 PID: 57924 Comm:
> lt-ublk.null Tainted: G        W           7.0.0-rc1+ #1 PREEMPT
> Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: Tainted: [W]=3DWARN
> Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: Hardware name: IBM,8375-42A
> POWER9 (architected) 0x4e0202 0xf000005 of:IBM,FW940.00 (VL940_027)
> hv:phyp pSeries
> Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: NIP:  c00000000014d698 LR:
> c00000000014d694 CTR: 0000000000000000
> Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: REGS: c000000004b12f10 TRAP:
> 0700   Tainted: G        W            (7.0.0-rc1+)
> Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: MSR:  8000000000029033
> <SF,EE,ME,IR,DR,RI,LE>  CR: 42002222  XER: 20040000
> Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: CFAR: c0000000002363e8
> IRQMASK: 3 #012GPR00: c00000000014d694 c000000004b131b0
> c000000001a48100 0000000000000020 #012GPR04: 00000000ffff7fff
> c000000004b12fb0 c000000004b12fa8 00000001fba00000 #012GPR08:
> 0000000000000027 0000000000000001 c0000000065eff00 0000000000000000
> #012GPR12: c00000000046d080 c000000017ffa300 0000000000000000
> 0000000000000000 #012GPR16: 0000000000000000 0000000000000000
> 0000000000000000 0000000000000000 #012GPR20: 0000000000000000
> 0000000000000000 0000000000000000 0000000000000000 #012GPR24:
> 0000000000000000 0000000000000000 0000000000000300 c00000005ec52a80
> #012GPR28: 00007fff81210000 0000000000000000 00007fff81210000
> c000000004b13370
> Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: NIP [c00000000014d698]
> bad_kernel_fault.isra.0+0xc8/0x2c0
> Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: LR [c00000000014d694]
> bad_kernel_fault.isra.0+0xc4/0x2c0
> Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: Call Trace:
> Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: [c000000004b131b0]
> [c00000000014d694] bad_kernel_fault.isra.0+0xc4/0x2c0 (unreliable)
> Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: [c000000004b13230]
> [c00000000014e1c8] ___do_page_fault+0x318/0xa80
> Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: [c000000004b132e0]
> [c00000000014ea1c] hash__do_page_fault+0x2c/0xc0
> Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: [c000000004b13310]
> [c000000000159268] do_hash_fault+0x128/0x1d0
> Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: [c000000004b13340]
> [c000000000008be0] data_access_common_virt+0x210/0x220
> Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: ---- interrupt: 300 at
> __copy_tofrom_user_power7+0x3ec/0x7ac
> Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: NIP:  c000000000176b60 LR:
> c000000000abd620 CTR: 0000000000000020
> Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: REGS: c000000004b13370 TRAP:
> 0300   Tainted: G        W            (7.0.0-rc1+)
> Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: MSR:  800000000280b033
> <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 24002420  XER: 20040000
> Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: CFAR: c000000000176b0c DAR:
> 00007fff81210000 DSISR: 00200000 IRQMASK: 0 #012GPR00:
> 000000000e000000 c000000004b13610 c000000001a48100 c000000151b50000
> #012GPR04: 00007fff81210000 0000000000001000 0000000000000020
> 03ffffffeae4b000 #012GPR08: 0000000080000000 0000000000000010
> 0000000000000020 0000000000000030 #012GPR12: 0000000000000040
> c000000017ffa300 0000000000000050 0000000000000060 #012GPR16:
> 0000000000000070 0000000000000000 0000000000000000 0000000000000000
> #012GPR20: 0000000000000000 c0000000da0e5500 c000000015325f00
> 0000000000000000 #012GPR24: 0000000000000228 0000000000010000
> 0000000000000001 c000000151b50000 #012GPR28: c000000004b138d0
> 0000000000001000 c000000004b13850 0000000000001000
> Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: NIP [c000000000176b60]
> __copy_tofrom_user_power7+0x3ec/0x7ac
> Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: LR [c000000000abd620]
> _copy_from_iter+0xf0/0x890
> Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: ---- interrupt: 300
> Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: [c000000004b13610]
> [c0000000001769ec] __copy_tofrom_user_power7+0x278/0x7ac (unreliable)
> Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: [c000000004b13710]
> [c000000000abd620] _copy_from_iter+0xf0/0x890
> Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: [c000000004b137d0]
> [c008000011371b20] ublk_copy_user_bvec.isra.0+0x138/0x190 [ublk_drv]
> Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: [c000000004b13820]
> [c008000011371c64] ublk_copy_user_pages.isra.0+0xec/0x1d0 [ublk_drv]
> Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: [c000000004b138b0]
> [c008000011374fec] __ublk_complete_rq+0x274/0x340 [ublk_drv]
> Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: [c000000004b13920]
> [c008000011379898] ublk_ch_uring_cmd_local+0x230/0x720 [ublk_drv]
> Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: [c000000004b139b0]
> [c000000000a940ac] io_uring_cmd+0x1ac/0x260
> Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: [c000000004b13a00]
> [c000000000a77e5c] __io_issue_sqe+0x6c/0x230
> Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: [c000000004b13a50]
> [c000000000a7fb3c] io_issue_sqe+0x6c/0x3f0
> Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: [c000000004b13ac0]
> [c000000000a8058c] io_submit_sqes+0x15c/0x670
> Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: [c000000004b13b50]
> [c000000000a80cd8] __do_sys_io_uring_enter+0x238/0x4a0
> Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: [c000000004b13c00]
> [c000000000031f6c] system_call_exception+0x13c/0x320
> Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: [c000000004b13e50]
> [c00000000000d05c] system_call_vectored_common+0x15c/0x2ec
> Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: ---- interrupt: 3000 at 0x7fff914=
63e14
> Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: NIP:  00007fff91463e14 LR:
> 00007fff91463e14 CTR: 0000000000000000
> Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: REGS: c000000004b13e80 TRAP:
> 3000   Tainted: G        W            (7.0.0-rc1+)
> Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: MSR:  800000000000d033
> <SF,EE,PR,ME,IR,DR,RI,LE>  CR: 48002822  XER: 00000000
> Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: IRQMASK: 0 #012GPR00:
> 00000000000001aa 00007fff90aee310 00007fff91557000 0000000000000000
> #012GPR04: 0000000000000020 0000000000000001 0000000000000019
> 00007fff90aee400 #012GPR08: 0000000000000018 0000000000000000
> 0000000000000000 0000000000000000 #012GPR12: 0000000000000000
> 00007fff90af68c0 0000000000000000 00007fff90aef1c0 #012GPR16:
> 0000000000000268 00007fff90aef8c0 0000000000000740 0000000000000004
> #012GPR20: 0000000000000000 00007fff91b80000 000000000080e9c0
> 00007fff902e0000 #012GPR24: 0000000000000001 0000000000000000
> 0000000000000000 00007fff90aee4d8 #012GPR28: ffffffffffffff90
> 0000000000000000 00007fff90aee418 00007fff8c0039a8
> Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: NIP [00007fff91463e14] 0x7fff9146=
3e14
> Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: LR [00007fff91463e14] 0x7fff91463=
e14
> Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: ---- interrupt: 3000
> Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: Code: 40820130 e87f0100
> 481279a9 60000000 2c230000 41820114 3c82ffd7 38847e30 3c62ffd7
> 38637ec8 480e8c39 60000000 <0fe00000> e8010090 ebe10078 7c0803a6
> Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: ---[ end trace 0000000000000000 ]=
---
> Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: Kernel attempted to read user
> page (7fff81210280) - exploit attempt? (uid: 0)
> Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: ------------[ cut here ]---------=
---
>
> Best Regards,
> Changhui
>

