Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B4E3859E4
	for <linux-block@vger.kernel.org>; Thu, 26 Feb 2026 12:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772109890; cv=pass; b=eHcqN7pplqGOW+j52uheq1LSibXUij4wzlHm+H6bkm0IDmS15gnGJlgZN5Id7qTAbMZ+XnMkt3HqilHeN37/PUcw95pbf9WFMBeF1yd95TXZQqTb9Vtw77Paf0mGivCuuzMFAdcPtmq+obgKdF7HqGdi7fiJZPE7R59XGz6fomw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772109890; c=relaxed/simple;
	bh=Bd7TSH3sQ1ydVDukcJUgRGcoc75et8kxJkirb6I8QwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZRDbuvcL8j0RMVYhJD9pSXflXZbUCeSZcqm0LWCAH7jHVrdel5vrpHJfUzTnY2/SV2Won8lD4OzTJD2sDvDmSD8QisJIxXtI2Z2W8bpOK2GDLNYdfOlJXJpea0EslXGsqA0DFXGxap6db3aM4VrSYJo6SEmwDmIX+1NWk7bo01M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MaLeT8ry; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZAC2Fsu9; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MaLeT8ry";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZAC2Fsu9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772109886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bshf/mcnbaq0IwjhUA3zsi8qImySXUNgNqm9NtsMnU8=;
	b=MaLeT8ryuCaSjf1DkX0A98fRgc1wFIDXBqgnh1QJwPmCyBdFu2w4dJLa4086XioU+oeGzS
	XH12h4djhrhP2YWTfdoVHbb4sBYzOObE13yw5mB8hauSZKMOGHMetFVrntVpoF1goUHsuf
	0IU2iw8NVeYNmrYnS5SiCj4gNnbkKU8=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-iZxrqC4wMheAdSIOqZjrcA-1; Thu, 26 Feb 2026 07:44:45 -0500
X-MC-Unique: iZxrqC4wMheAdSIOqZjrcA-1
X-Mimecast-MFC-AGG-ID: iZxrqC4wMheAdSIOqZjrcA_1772109885
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-5fef501e24cso996399137.2
        for <linux-block@vger.kernel.org>; Thu, 26 Feb 2026 04:44:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772109885; cv=none;
        d=google.com; s=arc-20240605;
        b=IenswSs5IFeDwc6frHhsS/d11Iye+KGER43Z/BpHMOftnJYA5gaOfY7n14u7kcJRGY
         Dh8/PKik7fTB0ZH64Xw8C53OGgCN9m6yckj/I8Jjnj67NxRpbORWmD5vZeOcKIy1Rjg1
         gpqeUWhkLiV9yEaa0ZsPaGW2yfda8rNtGahnhdrT/2lwpKdZMyNxow5g9hTGZsVcCaPC
         6MxVBrDRY2OLjgc5ugmFNUuI77Vn/6WJSwSCvJkwZGShqZ3kwl8P55wdNoi+TYiSYRAT
         148U/R/ndFqe0rnvBNBzuHKXj0MqGJZBxSGIG5iUTdarq1x8METrRK2Wn+NeoVUJx3G9
         WDzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bshf/mcnbaq0IwjhUA3zsi8qImySXUNgNqm9NtsMnU8=;
        fh=MtoI2tufSuVONEM44zYiFzTZ+wa95BRySs8S7rSrS0g=;
        b=REumcb7c8BJr2+WbrAL+jN/GvsOJ0EqTa9N5UtS2mhv+/pLmdLZvnDsx4RWInIrx7c
         SW9Aptz/g0GTdEjFJH4VOXbuBdpnYFPm25D+T8plTgV54iQZe7jgFV1u5ZjnOPDxtBvf
         QheaApCh6i+KHX/VO0qJ6PJjIGNs0TsY/3atBu65sB/q7Jhs2dddK2lLvwmMGqSulMF0
         cSi4qi5nj9383cUXEZgPkp1nATpvHhKVpJBNgPyJaB+usNoq8QgvWbJVfIqgtLdiAKFF
         MB9GOy14JRE4cpej8+3q6SbhHybscMqaNw5Z3KdgtX+z8T12q5dVUCOcX5njFsz1gNoI
         4rBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772109885; x=1772714685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bshf/mcnbaq0IwjhUA3zsi8qImySXUNgNqm9NtsMnU8=;
        b=ZAC2Fsu9WWNbCekhd90Y3TsWoHG85j1W7e7KlK2sKkw7FCuwpO77QSbVkiI2mYMR0u
         3HheCn7JiWXLdfpH0x72wd9z+cPLVeurdSPanviD9P3z6oyVUvzEkbYSojnHbsmvaP4W
         ir8Dt+97YPwk+KdTneX2ck+BrLUyTICK8LoOy1PqEtKnUj1DGrYHV+y1nk8E7RepnCxS
         ArLIb9O9YgcqntRDZDNl/fRgT6pa2ELLpnxKUzK2YmpzDuVtVDkmvoSlrSa89sgquW8D
         BDz9vBlXaj0ClzR17BRst2jkobBlcI4VWKX1dUo/G42sQqFjKtIt0XHCmwIJ6SFsTdjh
         F3Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772109885; x=1772714685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bshf/mcnbaq0IwjhUA3zsi8qImySXUNgNqm9NtsMnU8=;
        b=JMSMqdjzKykGEClh0vuoSZxhuatmfFmJWzhMyu5X36E2YrO4CPQdYP+zfp8/GENwzW
         3qW+IvhTcodK32Z8RGbs2x5eAcf6zD/f5RG3ohj9XCgkZDfgjfhRSYkxwo884S/msgN1
         KgAzOPYsrOiRwOskVr08ucqEIYdRabwAGhknoluZejr6h4bj65Chhxz8DaPVqo5LJAat
         d87qmT6Cmiz1bUmV2EkBLqgvDixF4nr0AeTcowp2PHBTRKs5wwj+Rg84GuE7rYVVKbTY
         P4QS0gZo0NFo60Tq+WAKn6Y0AQnqDcZDXINiSz7aO43eHQe1+WeG4HI0N9DwpDHDJvbq
         8RKg==
X-Gm-Message-State: AOJu0Yxsl502fFfo+69Wld+bMKmFBz1jrnwEZq0IWBm7Em6brWNEWdfi
	eAmSaMQpMK1Qvg5cSf2ESi8KIwXRS+V/QORGz0CV9L7T3U0g8fucR3ShDAoXT064YIzSh2Y16oy
	3xAybY6Vqn75HOumPehaY97q/nDldMTmSs8LIXXQxHrJIhzMMP3BYSnfoAeUM1D/IYk5W5E676y
	H0T20vaevpTwgSfHYGK5osudWHZ/n6HbyNrnrnj8g=
X-Gm-Gg: ATEYQzwyxQJAturEFEyK7sZIcmCa+/3RudiPcqQcJejkpISdmVevcVkEjKEwEfpXdmQ
	SDqc3TYgFzhEujpakTPSZRr6WBCxlBCJxpBVwnPvj2afQaK6qSXxqO48peUawOVQ9UJ20BzxqP0
	DeAQGzObEcKcssvPs/SSuV8zeFJRsnuSuGzWhCIogGCgBzLBqU+IGRpWJhzw6scbUokiSsjjxWP
	WAIhyo=
X-Received: by 2002:a05:6102:26c4:b0:5fd:fa29:ae15 with SMTP id ada2fe7eead31-5ff20a24165mr745709137.9.1772109884907;
        Thu, 26 Feb 2026 04:44:44 -0800 (PST)
X-Received: by 2002:a05:6102:26c4:b0:5fd:fa29:ae15 with SMTP id
 ada2fe7eead31-5ff20a24165mr745697137.9.1772109884400; Thu, 26 Feb 2026
 04:44:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGVVp+U0EYVX+VbbEHzcYP70zdmOXwAmUvpMYV9y3jBSRFmS6g@mail.gmail.com>
 <CAFj5m9L8ahNYFf-tUAZFKAUzkeyqV-Sx94MxC268XJ-hqHPCig@mail.gmail.com>
In-Reply-To: <CAFj5m9L8ahNYFf-tUAZFKAUzkeyqV-Sx94MxC268XJ-hqHPCig@mail.gmail.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Thu, 26 Feb 2026 20:44:32 +0800
X-Gm-Features: AaiRm53VyTpzKmhhQXSLZ_ZoPRe94CeaxghmO6T7uoyLJFYCNdev5YhkPNpazsI
Message-ID: <CAFj5m9+OCswLULgVx8eSydTG0OeN4f-8dK1-JyoAA70CNF88Qg@mail.gmail.com>
Subject: Re: [bug report] Bug: Write fault blocked by KUAP!
To: Changhui Zhong <czhong@redhat.com>, Caleb Sander Mateos <csander@purestorage.com>
Cc: Linux Block Devices <linux-block@vger.kernel.org>, Ming Lei <ming.lei@redhat.com>, 
	linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 26, 2026 at 6:48=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> Hi Changhui,
>
> Thanks for the report!
>
> Loop Caleb Sander Mateos  in.
>
> Thanks,
>
> On Thu, Feb 26, 2026 at 6:37=E2=80=AFPM Changhui Zhong <czhong@redhat.com=
> wrote:
> >
> > Hello,
> >
> > on the ppc64le arch, I hit the issue below with ublksrv on the latest
> > linux-block/for-next, please help check it, and let me know if you
> > need any info/test for it. Thanks.
> >
> > INFO: HEAD of cloned kernel
> > commit 37a43fd770f3dcac8f72f3ea909b3e893e2385c9
> > Merge: 13cd9b41227a c1dfbd7e71b0
> > Author: Jens Axboe <axboe@kernel.dk>
> > Date:   Wed Feb 25 08:37:06 2026 -0700
> >
> >     Merge branch 'for-7.1/block' into for-next
> >
> >     * for-7.1/block:
> >       ublk: report BLK_SPLIT_INTERVAL_CAPABLE
> >
> > reproducer:
> > compile and install https://github.com/ublk-org/ublksrv.git
> > #echo 0 > /proc/sys/kernel/io_uring_disabled
> > #modprobe ublk_drv
> > #cd ublksrv
> > #make test T=3Dnull
> > #make test T=3Dloop
> >
> > dmesg log=EF=BC=9A
> > Feb 26 00:24:30 ibm-p9z-27-lp26 journal: running null/002
> > Feb 26 00:24:30 ibm-p9z-27-lp26 ublksrvd-0[57921]: start ublksrv io
> > daemon ublksrvd-0
> > Feb 26 00:24:30 ibm-p9z-27-lp26 ublksrvd-0[57921]: tid 57923: ublk dev
> > 0 queue 0 started
> > Feb 26 00:24:30 ibm-p9z-27-lp26 ublksrvd-0[57921]: tid 57924: ublk dev
> > 0 queue 1 started
> > Feb 26 00:24:36 ibm-p9z-27-lp26 NetworkManager[818]: <warn>
> > [1772083476.4882] platform-linux: do-add-ip6-address[2:
> > fe80::8448:a3ff:fe51:f102]: failure 13 (Permission denied - ipv6: IPv6
> > is disabled on this device)
> > Feb 26 00:24:36 ibm-p9z-27-lp26 NetworkManager[818]: <warn>
> > [1772083476.4885] platform-linux: do-add-ip6-address[2:
> > 2620:52:9:160c:8448:a3ff:fe51:f102]: failure 13 (Permission denied -
> > ipv6: IPv6 is disabled on this device)
> > Feb 26 00:24:36 ibm-p9z-27-lp26 NetworkManager[818]: <warn>
> > [1772083476.4938] l3cfg[0f1985ec14299e62,ifindex=3D2]: unable to
> > configure IPv6 route: type unicast fe80::/64 dev 2 metric 1024 mss 0
> > rt-src ipv6ll
> > Feb 26 00:24:38 ibm-p9z-27-lp26 NetworkManager[818]: <warn>
> > [1772083478.4938] ipv6ll[95ab7f3fdbfe643d,ifindex=3D2]: changed: no IPv=
6
> > link local address to retry after Duplicate Address Detection failures
> > (back off)
> > Feb 26 00:24:38 ibm-p9z-27-lp26 NetworkManager[818]: <warn>
> > [1772083478.4943] platform-linux: do-add-ip6-address[2:
> > 2620:52:9:160c:8448:a3ff:fe51:f102]: failure 13 (Permission denied -
> > ipv6: IPv6 is disabled on this device)
> > Feb 26 00:24:48 ibm-p9z-27-lp26 NetworkManager[818]: <warn>
> > [1772083488.5034] platform-linux: do-add-ip6-address[2:
> > fe80::8448:a3ff:fe51:f102]: failure 13 (Permission denied - ipv6: IPv6
> > is disabled on this device)
> > Feb 26 00:24:48 ibm-p9z-27-lp26 NetworkManager[818]: <warn>
> > [1772083488.5037] platform-linux: do-add-ip6-address[2:
> > 2620:52:9:160c:8448:a3ff:fe51:f102]: failure 13 (Permission denied -
> > ipv6: IPv6 is disabled on this device)
> > Feb 26 00:24:48 ibm-p9z-27-lp26 NetworkManager[818]: <warn>
> > [1772083488.5041] l3cfg[0f1985ec14299e62,ifindex=3D2]: unable to
> > configure IPv6 route: type unicast fe80::/64 dev 2 metric 1024 mss 0
> > rt-src ipv6ll
> > Feb 26 00:24:50 ibm-p9z-27-lp26 NetworkManager[818]: <warn>
> > [1772083490.5034] ipv6ll[95ab7f3fdbfe643d,ifindex=3D2]: changed: no IPv=
6
> > link local address to retry after Duplicate Address Detection failures
> > (back off)
> > Feb 26 00:24:50 ibm-p9z-27-lp26 NetworkManager[818]: <warn>
> > [1772083490.5039] platform-linux: do-add-ip6-address[2:
> > 2620:52:9:160c:8448:a3ff:fe51:f102]: failure 13 (Permission denied -
> > ipv6: IPv6 is disabled on this device)
> > Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: Kernel attempted to read user
> > page (7fff81210000) - exploit attempt? (uid: 0)
> > Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: ------------[ cut here ]-------=
-----
> > Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: Bug: Read fault blocked by KUAP=
!
> > Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: WARNING:
> > arch/powerpc/mm/fault.c:231 at bad_kernel_fault.isra.0+0xc8/0x2c0,
> > CPU#5: lt-ublk.null/57924

oops, it shouldn't be related with `ublk: report BLK_SPLIT_INTERVAL_CAPABLE=
`,
Perhaps one issue lies in the ppcle64 architecture code.

I will find one ppc box and try to reproduce this.

Thanks,

