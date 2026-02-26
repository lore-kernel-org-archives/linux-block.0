Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF9F19CCF5
	for <linux-block@vger.kernel.org>; Thu, 26 Feb 2026 16:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772125182; cv=pass; b=SIwVV/NsQLQn12n5UmPAFkyHhJYksIXTz9o7baSqaH4ST8k1yZ4YQSAierguyR5RwS4qQn/S/TWjHELPztZzJobAeCX2LT1P7ZUtrDf903+GnsTaxQW9Irmrqi4syw8CXD7MT1e4C3MBYUY/vQYUwBZbL6pxgyyOxxmNoR564B8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772125182; c=relaxed/simple;
	bh=uvc/s0Y5DW5Tp6YKReyYkJ43WymRLpx+TR1HPE7kpYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pTPc7QcGxyE4Nb/QzxxXUjq+ShvLsrV96ZJswTbqh5bzda2nsjopw4yX9Zkqqrj99izJd860a3Y2sBHj8bCXibSrdq97G3QV8tWK+9qsdXHF7j9ENvI+J9AcMGJDnFareMAwYOJRqIewp4UbTI5ihEW0rz/EuVSCSJz3UpPMP9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=FG6OqDil; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="FG6OqDil"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b8fa033d805so18647566b.1
        for <linux-block@vger.kernel.org>; Thu, 26 Feb 2026 08:59:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772125179; cv=none;
        d=google.com; s=arc-20240605;
        b=g1ikW5X8ddDG7kVLNsTtapxAwl0Ew8VSxg84hVCD3YxuwQTohNT70lWuW+YdGgt8pF
         q3gdfyTpdGQiCcNl421mkMmub6/HFVHLT3XgHNKo3MOMC0P9LTO9+JDdLULkjFk2eqFT
         3J+cjZGL39kA+WOEXVfAz6LW6H0EgDIXKu1P/sAeGerWWf7NvZhiQDVqjoddMQ6kIHUw
         Ec9QfbLwBP0N/Pc/PKmx+aNPR3pdE/XKO7dnjmi0ycgpv3G1qb51h1Omv6KHdm4frRcK
         GT7lGfuBALQ6UlmfmZIXcQRyipVKf5JolZXUpMy9qjOLwPCCDXSbBB21fCR0DF5rUPG+
         U0bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VQTahQG7JlQriU0U/uIUNDwnC7GIEojKelvv8zx/TyY=;
        fh=KSyE+9LUGNdy/z9VaA1YTwARFGrcBKqOyTpS4u+D2pg=;
        b=RXvtlPpgEpS9A/tLc2E/hIsDriiaP9ce/Me3Y7fLTL/qn60Xgd/VTTqAfzHg4OdTGi
         fKGvwoRDBsVzRMaAPqxc50JGO58Iw3B063EmMlvxN5T5OIHG8P+ICwaxRpNQ6gV2R1Sv
         o3yb5WS/1EHimS+Pe11bCLZIUiJFoMldbcV6I1lO9S+p7n77wyIAua9uIZv2v8Wto1KC
         ICLsHtuIYoVJd7RDx8TOADakWKLLxaxgYH98IlfCUIoHrTmKFBA5ymqDn8H3JoudkDOd
         cWBG53vtujdo4wHBHjae5KZSrXD+ICKcB33FPcCx2Zjd2EsltNbZpxmw2VzwUsfobwWQ
         tP5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1772125179; x=1772729979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VQTahQG7JlQriU0U/uIUNDwnC7GIEojKelvv8zx/TyY=;
        b=FG6OqDilZwMaSAef2v9+7pA9cpE01TjvEBhjenRv/yVMREy2oWSb2vBDanhKsfoBj4
         Prd8P5j1+FsqXU4DNI54j9Q6KhfuuvBvJr/G9VGcfGBgUkhM/BqxappFeh4DFqZUjZDP
         NN01K7Oh0od6QnatAVenIvnp5GRlOHdvwshtAI+ISFPMfidEbH28aHPDxm6aFFqbPP5O
         6gGJSxmQvsfzwIEY0WrsqNiVcYW+BSA8DZOI1Kfehj8iikZXyqG2SPNLLZCb9vH4wYMj
         K7SN7ZZbt7+p9JJ5qAs7/LBEeQTI0FZzQSF4nyTePapJ4ZXwLtu+sV41bz3UhFrOc2kY
         BFjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772125179; x=1772729979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VQTahQG7JlQriU0U/uIUNDwnC7GIEojKelvv8zx/TyY=;
        b=E5KsikM6J5PgjRKn5oihNo/ir/TxInGArBUhXqbWjtUMW4+YL2lRxcBwWtyDAXPzkQ
         UF+RioU1fNbXhGPFb6ztgLL7hr/49LXXND1uaVjrRuu5iOPq+8GBCVCA3EWftEndJw3r
         hunf3bdN9ggyD9jw/IeOdE2dGvICBG5XU1P63VeLbJwTDsTkb3psiW38vu4gxkPkhty+
         l4dhsnKNWWGQHHe9OSp7nMSXDki6vf1LFlh99l9Op/N61gOdfv6l3aJgbxC3Cc9YJe5C
         M+HtoiKfkCRz+LjAHSGwvxsZcmuA7R5Kl0l69Ew0+67++WDh8KvxG7VcQLDUIXVjljWz
         9WIw==
X-Forwarded-Encrypted: i=1; AJvYcCUhZrXxvWaWrtbog2iY6palGdMQM8y02M/rvku/gnQwJvR9lkNOeiABpwvJdIu6wyGLxYSCjl3yeoZGsQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YydekS9E+6KWvCCDrLeCH9BJ6ZMt/ZdbYmR6bT3YAG2ZMWCJwzx
	shRJ0wRGkxk4tTRjHh+Y99zjzwjQiJisvlTmbZTgisqBBCF8MGRlAbAQ2uKLv6MJOgdlM/i2yaO
	d4IB/f4l2jnqRd9s1msUrxrTeMBfahWZci3vxYzoVdQ==
X-Gm-Gg: ATEYQzwDhNgy8PhEiV0FSdwB+mc+ab1Qv4jDYVVAj8EYFjJg8CrnhkedIZu6gVFp2Cg
	f8ZcOQCHKB4UB6xcJWGgVIO10SwuDASgbbwBLU2qTpfyHl2sAKQGlv0U709Ql7uwjOSevJuPk3g
	zRloJO21pAZ59WvzfS7hCWiPTv5Wj2rtBtyuzjZbytbRqXcCK0Nybk3taIsrz2na+fZbDE2ECgt
	H0Af2aSmJcTcx64BOaoYCCOBfxmFS/IGuyNNt4166cfE1iKuRJuHGy+ZPcqeal2sv2iWLcYZz0F
	evLqLSd7wqQXzN0ZmQ==
X-Received: by 2002:a17:907:3da5:b0:b73:59b0:34c6 with SMTP id
 a640c23a62f3a-b9081aee279mr725994366b.4.1772125179302; Thu, 26 Feb 2026
 08:59:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGVVp+U0EYVX+VbbEHzcYP70zdmOXwAmUvpMYV9y3jBSRFmS6g@mail.gmail.com>
 <CAFj5m9L8ahNYFf-tUAZFKAUzkeyqV-Sx94MxC268XJ-hqHPCig@mail.gmail.com> <CAFj5m9+OCswLULgVx8eSydTG0OeN4f-8dK1-JyoAA70CNF88Qg@mail.gmail.com>
In-Reply-To: <CAFj5m9+OCswLULgVx8eSydTG0OeN4f-8dK1-JyoAA70CNF88Qg@mail.gmail.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Thu, 26 Feb 2026 08:59:27 -0800
X-Gm-Features: AaiRm50GWYX4r6oeginYJ_RUg2KTIoXKruIV8H25SbNGKcfgCAGwcyPjO6BwPXE
Message-ID: <CADUfDZrq96YGiMN9==gMitAHZtXydOAwy-767-d0j5LdUqO91Q@mail.gmail.com>
Subject: Re: [bug report] Bug: Write fault blocked by KUAP!
To: Ming Lei <ming.lei@redhat.com>
Cc: Changhui Zhong <czhong@redhat.com>, Linux Block Devices <linux-block@vger.kernel.org>, 
	linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 26, 2026 at 4:44=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Thu, Feb 26, 2026 at 6:48=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wr=
ote:
> >
> > Hi Changhui,
> >
> > Thanks for the report!
> >
> > Loop Caleb Sander Mateos  in.
> >
> > Thanks,
> >
> > On Thu, Feb 26, 2026 at 6:37=E2=80=AFPM Changhui Zhong <czhong@redhat.c=
om> wrote:
> > >
> > > Hello,
> > >
> > > on the ppc64le arch, I hit the issue below with ublksrv on the latest
> > > linux-block/for-next, please help check it, and let me know if you
> > > need any info/test for it. Thanks.
> > >
> > > INFO: HEAD of cloned kernel
> > > commit 37a43fd770f3dcac8f72f3ea909b3e893e2385c9
> > > Merge: 13cd9b41227a c1dfbd7e71b0
> > > Author: Jens Axboe <axboe@kernel.dk>
> > > Date:   Wed Feb 25 08:37:06 2026 -0700
> > >
> > >     Merge branch 'for-7.1/block' into for-next
> > >
> > >     * for-7.1/block:
> > >       ublk: report BLK_SPLIT_INTERVAL_CAPABLE
> > >
> > > reproducer:
> > > compile and install https://github.com/ublk-org/ublksrv.git
> > > #echo 0 > /proc/sys/kernel/io_uring_disabled
> > > #modprobe ublk_drv
> > > #cd ublksrv
> > > #make test T=3Dnull
> > > #make test T=3Dloop
> > >
> > > dmesg log=EF=BC=9A
> > > Feb 26 00:24:30 ibm-p9z-27-lp26 journal: running null/002
> > > Feb 26 00:24:30 ibm-p9z-27-lp26 ublksrvd-0[57921]: start ublksrv io
> > > daemon ublksrvd-0
> > > Feb 26 00:24:30 ibm-p9z-27-lp26 ublksrvd-0[57921]: tid 57923: ublk de=
v
> > > 0 queue 0 started
> > > Feb 26 00:24:30 ibm-p9z-27-lp26 ublksrvd-0[57921]: tid 57924: ublk de=
v
> > > 0 queue 1 started
> > > Feb 26 00:24:36 ibm-p9z-27-lp26 NetworkManager[818]: <warn>
> > > [1772083476.4882] platform-linux: do-add-ip6-address[2:
> > > fe80::8448:a3ff:fe51:f102]: failure 13 (Permission denied - ipv6: IPv=
6
> > > is disabled on this device)
> > > Feb 26 00:24:36 ibm-p9z-27-lp26 NetworkManager[818]: <warn>
> > > [1772083476.4885] platform-linux: do-add-ip6-address[2:
> > > 2620:52:9:160c:8448:a3ff:fe51:f102]: failure 13 (Permission denied -
> > > ipv6: IPv6 is disabled on this device)
> > > Feb 26 00:24:36 ibm-p9z-27-lp26 NetworkManager[818]: <warn>
> > > [1772083476.4938] l3cfg[0f1985ec14299e62,ifindex=3D2]: unable to
> > > configure IPv6 route: type unicast fe80::/64 dev 2 metric 1024 mss 0
> > > rt-src ipv6ll
> > > Feb 26 00:24:38 ibm-p9z-27-lp26 NetworkManager[818]: <warn>
> > > [1772083478.4938] ipv6ll[95ab7f3fdbfe643d,ifindex=3D2]: changed: no I=
Pv6
> > > link local address to retry after Duplicate Address Detection failure=
s
> > > (back off)
> > > Feb 26 00:24:38 ibm-p9z-27-lp26 NetworkManager[818]: <warn>
> > > [1772083478.4943] platform-linux: do-add-ip6-address[2:
> > > 2620:52:9:160c:8448:a3ff:fe51:f102]: failure 13 (Permission denied -
> > > ipv6: IPv6 is disabled on this device)
> > > Feb 26 00:24:48 ibm-p9z-27-lp26 NetworkManager[818]: <warn>
> > > [1772083488.5034] platform-linux: do-add-ip6-address[2:
> > > fe80::8448:a3ff:fe51:f102]: failure 13 (Permission denied - ipv6: IPv=
6
> > > is disabled on this device)
> > > Feb 26 00:24:48 ibm-p9z-27-lp26 NetworkManager[818]: <warn>
> > > [1772083488.5037] platform-linux: do-add-ip6-address[2:
> > > 2620:52:9:160c:8448:a3ff:fe51:f102]: failure 13 (Permission denied -
> > > ipv6: IPv6 is disabled on this device)
> > > Feb 26 00:24:48 ibm-p9z-27-lp26 NetworkManager[818]: <warn>
> > > [1772083488.5041] l3cfg[0f1985ec14299e62,ifindex=3D2]: unable to
> > > configure IPv6 route: type unicast fe80::/64 dev 2 metric 1024 mss 0
> > > rt-src ipv6ll
> > > Feb 26 00:24:50 ibm-p9z-27-lp26 NetworkManager[818]: <warn>
> > > [1772083490.5034] ipv6ll[95ab7f3fdbfe643d,ifindex=3D2]: changed: no I=
Pv6
> > > link local address to retry after Duplicate Address Detection failure=
s
> > > (back off)
> > > Feb 26 00:24:50 ibm-p9z-27-lp26 NetworkManager[818]: <warn>
> > > [1772083490.5039] platform-linux: do-add-ip6-address[2:
> > > 2620:52:9:160c:8448:a3ff:fe51:f102]: failure 13 (Permission denied -
> > > ipv6: IPv6 is disabled on this device)
> > > Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: Kernel attempted to read user
> > > page (7fff81210000) - exploit attempt? (uid: 0)
> > > Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: ------------[ cut here ]-----=
-------
> > > Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: Bug: Read fault blocked by KU=
AP!
> > > Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: WARNING:
> > > arch/powerpc/mm/fault.c:231 at bad_kernel_fault.isra.0+0xc8/0x2c0,
> > > CPU#5: lt-ublk.null/57924
>
> oops, it shouldn't be related with `ublk: report BLK_SPLIT_INTERVAL_CAPAB=
LE`,
> Perhaps one issue lies in the ppcle64 architecture code.

Agreed, the "Kernel attempted to read user page" error seems
incorrect. The call trace shows this is in copy_from_iter(), so
reading a user page is expected. I too would be suspicious of the
powerpc copy_from_iter() implementation.

Best,
Caleb
