Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B54847C
	for <linux-block@vger.kernel.org>; Tue,  3 Dec 2024 01:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733189241; cv=none; b=QKf0kIpCHJZ562S0H0hR3rRi4qov+pUjlUWAw+fRri+g3802HMq07MI6vEWEFcud/48uS8NvF3om5SHymFNgST6K/z4XETYtcloOO4APQZ/Eigv0US/7KFmC8fYF6mtpIFaiJWHYzSt3FIjvvWRJjDYIpdWaQFDUrkD+ZP80ekk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733189241; c=relaxed/simple;
	bh=a9lT9H4NEQfuwaNC8AoxqJZrNy8QTgzpahtPmt/Wo/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j8nHn4jp+SqFQ0xMgbHpA06VdHB/lzDRlaooUB15Jk+y2yOZq8YXilcmqMtIBc6BzKZ9wSJq4OKeskB3G9Mq0J+tnDX6OAnXTAFj46m6vFSzBhgYPSHellsFj8dQwtSiTzWlV3+/Kh1n2T8Q5pSOOl0zg10z8VVvUDJliyVKNDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R8W2vBpp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R8W2vBpp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733189237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GoVr8yKNrcM33Zng6FyWSYwo6EaMYdGNMob5ttK40vc=;
	b=R8W2vBpp/hv8VcKupk/FjyJhKuSO3n7OL0aUSuDaIUhzbIZ9nC3NYUjKlfXQOZnMZ/rlze
	fWxhYMu5eIixx16Uoqhq4tTRSgtmRSpSTF44IBNcmjoAQpNgvkN2QUfveoweKYv2IjJhE/
	DVUeuZ4iCVzFVdf+1xejXtSBv9ieMeg=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-nBiDJ2_xPZuLBkfZEbSDQA-1; Mon, 02 Dec 2024 20:27:16 -0500
X-MC-Unique: nBiDJ2_xPZuLBkfZEbSDQA-1
X-Mimecast-MFC-AGG-ID: nBiDJ2_xPZuLBkfZEbSDQA
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2ffcaf83611so28257771fa.1
        for <linux-block@vger.kernel.org>; Mon, 02 Dec 2024 17:27:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733189233; x=1733794033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GoVr8yKNrcM33Zng6FyWSYwo6EaMYdGNMob5ttK40vc=;
        b=XhsN5/tF4uZItSrjOuhxNSlOyhddnAH24DOzgcvhQYcSAJ6Al2D7Nuf/90PGoG5hFJ
         4VOkjktOaEJoJQemTBR65cWoR2HvztTxANXcu1rnT3A1oZ/24kxd/2ib+ryqe2/UDMzl
         joqPHukwy1VH1qMjkJyy4wSUcXyMPfq3lqitqYrnCVZYhUvka5GhgPNoP9Ts8At6Oqp4
         zIKXDIchhxNRyortbTOJYMzf9Q6x8Il083Nc7lRuyfnwOBqKuJZwl0YsjLqSe6oYTPmE
         bXL1yUhhPRWgn/Jvx0GodXC4aTrVH6Z9df/xC1q+m43ohSz2wfTaS1z8ysl/N7DT0TZ1
         im8g==
X-Gm-Message-State: AOJu0YzzRW/kuSf0vQP3uoV3rk0d46HUjeIJuJPaHHKGjHYnqb3t3Ici
	2iHY/ffwdZOJIc/+YkiSb9uI15tGZB9RdUfyjuTOvW1QierXusbaWGdsXu5B0+yjq51DqUvaVco
	8E0yZ5lTkw+gdvOjfqN/Wu+WjxsUZwfQ4A9Hny4isaXWg/lRQInS6ZonkJ70bGse2bTuveAwpTV
	zubh0HtgOpv9EYWqL7lf8RSnZmCmVjrwTKielTLPwEy/Tn0Iep
X-Gm-Gg: ASbGncu9Ee2R6fMG4lglkn0uTNi40HKPhT2hnLX/pxxKrVkcAQdCg8CuRMbr3mgWl0K
	wQoKPjZqvv+CX5KxoxYUMF6Q9NDcpMWzj
X-Received: by 2002:a2e:a907:0:b0:2fb:4ca9:8f4 with SMTP id 38308e7fff4ca-30009c53fe2mr3897821fa.23.1733189233574;
        Mon, 02 Dec 2024 17:27:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFImmN1drf8nfc7QiF7Xze1LZV9nlgMIA79oGnRTwWc0rJ4znNssD7h7exnnVZ7bL2lRtp9S3LzJGfQolFo7ZE=
X-Received: by 2002:a2e:a907:0:b0:2fb:4ca9:8f4 with SMTP id
 38308e7fff4ca-30009c53fe2mr3897741fa.23.1733189233155; Mon, 02 Dec 2024
 17:27:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fecc3814-cc34-4349-8a51-98670d0d868d@fujitsu.com>
In-Reply-To: <fecc3814-cc34-4349-8a51-98670d0d868d@fujitsu.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Tue, 3 Dec 2024 09:27:00 +0800
Message-ID: <CAHj4cs_eaa5mGH=6JbZLC+f2wUZrKkWqCD37gtVW0_L+L3Pe-w@mail.gmail.com>
Subject: Re: [blktests] zbd/009 fails due to "No space left on device"
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Zhijian
Seems it's one btfs issue, you can find more here:

https://github.com/osandov/blktests/issues/150

On Tue, Dec 3, 2024 at 8:58=E2=80=AFAM Zhijian Li (Fujitsu)
<lizhijian@fujitsu.com> wrote:
>
> Hey all,
>
> This case always fails on my environment Fefora40 + upstream kernel 6.13.=
0-rc1+(6.12-rcx also failed)
>
> It can be resolved if I enlarge the block device size to 2GiB(1.5GiB also=
 failed).
> $ git diff
> diff --git a/tests/zbd/009 b/tests/zbd/009
> index 6226d83..11bcafb 100755
> --- a/tests/zbd/009
> +++ b/tests/zbd/009
> @@ -44,7 +44,7 @@ test() {
>
>          local params=3D(
>                  delay=3D0
> -               dev_size_mb=3D1024
> +               dev_size_mb=3D2048
>                  sector_size=3D4096
>                  zbc=3Dhost-managed
>                  zone_cap_mb=3D3
>
>
> I have no idea why we need to enlarge the block size while the FIO only r=
un with size '1M' in this case.
> If you want more details, feel free to let me know.
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> $ ./check zbd/009
> zbd/009 (test gap zone support with BTRFS)                   [failed]
>      runtime    ...  6.234s
>      --- tests/zbd/009.out      2022-10-11 10:59:29.796928869 +0800
>      +++ /home/lizhijian/blktests/results/nodev/zbd/009.out.bad 2024-12-0=
3 08:46:29.118932788 +0800
>      @@ -1,2 +1,2 @@
>       Running zbd/009
>      -Test complete
>      +Test failed
>
>
> $ cat /home/lizhijian/blktests/results/nodev/zbd/009.full
> btrfs-progs v6.8
> See https://btrfs.readthedocs.io for more information.
>
> Resetting device zones /dev/sdb (256 zones) ...
> NOTE: several default settings have changed in version 5.15, please make =
sure
>        this does not affect your deployments:
>        - DUP for metadata (-m dup)
>        - enabled no-holes (-O no-holes)
>        - enabled free-space-tree (-R free-space-tree)
>
> Label:              (null)
> UUID:               63a9f0ee-7f88-4696-b705-3ebb0e2ac6e2
> Node size:          16384
> Sector size:        4096        (CPU page size: 4096)
> Filesystem size:    1.00GiB
> Block group profiles:
>    Data:             single            4.00MiB
>    Metadata:         DUP               4.00MiB
>    System:           DUP               4.00MiB
> SSD detected:       yes
> Zoned device:       yes
>    Zone size:        4.00MiB
> Features:           extref, skinny-metadata, no-holes, free-space-tree, z=
oned
> Checksum:           crc32c
> Number of devices:  1
> Devices:
>     ID        SIZE  ZONES  PATH
>      1     1.00GiB    256  /dev/sdb
>
> fio: io_u error on file /home/lizhijian/blktests/results/tmpdir.zbd.009.1=
IJ/mnt/verify.0.0: No space left on device: write offset=3D1024000, buflen=
=3D4096
> fio: io_u error on file /home/lizhijian/blktests/results/tmpdir.zbd.009.1=
IJ/mnt/verify.0.0: No space left on device: write offset=3D905216, buflen=
=3D4096
> fio: io_u error on file /home/lizhijian/blktests/results/tmpdir.zbd.009.1=
IJ/mnt/verify.0.0: No space left on device: write offset=3D688128, buflen=
=3D4096
> fio: io_u error on file /home/lizhijian/blktests/results/tmpdir.zbd.009.1=
IJ/mnt/verify.0.0: No space left on device: write offset=3D540672, buflen=
=3D4096
> fio: io_u error on file /home/lizhijian/blktests/results/tmpdir.zbd.009.1=
IJ/mnt/verify.0.0: No space left on device: write offset=3D630784, buflen=
=3D4096
> fio: io_u error on file /home/lizhijian/blktests/results/tmpdir.zbd.009.1=
IJ/mnt/verify.0.0: No space left on device: write offset=3D1028096, buflen=
=3D4096
> fio: io_u error on file /home/lizhijian/blktests/results/tmpdir.zbd.009.1=
IJ/mnt/verify.0.0: No space left on device: write offset=3D12288, buflen=3D=
4096
> fio: io_u error on file /home/lizhijian/blktests/results/tmpdir.zbd.009.1=
IJ/mnt/verify.0.0: No space left on device: write offset=3D233472, buflen=
=3D4096
> fio: io_u error on file /home/lizhijian/blktests/results/tmpdir.zbd.009.1=
IJ/mnt/verify.0.0: No space left on device: write offset=3D339968, buflen=
=3D4096
> fio: io_u error on file /home/lizhijian/blktests/results/tmpdir.zbd.009.1=
IJ/mnt/verify.0.0: No space left on device: write offset=3D876544, buflen=
=3D4096
> fio: io_u error on file /home/lizhijian/blktests/results/tmpdir.zbd.009.1=
IJ/mnt/verify.0.0: No space left on device: write offset=3D704512, buflen=
=3D4096
> fio: io_u error on file /home/lizhijian/blktests/results/tmpdir.zbd.009.1=
IJ/mnt/verify.0.0: No space left on device: write offset=3D589824, buflen=
=3D4096
> fio: io_u error on file /home/lizhijian/blktests/results/tmpdir.zbd.009.1=
IJ/mnt/verify.0.0: No space left on device: write offset=3D995328, buflen=
=3D4096
> fio: io_u error on file /home/lizhijian/blktests/results/tmpdir.zbd.009.1=
IJ/mnt/verify.0.0: No space left on device: write offset=3D397312, buflen=
=3D4096
> fio: io_u error on file /home/lizhijian/blktests/results/tmpdir.zbd.009.1=
IJ/mnt/verify.0.0: No space left on device: write offset=3D16384, buflen=3D=
4096
> fio: io_u error on file /home/lizhijian/blktests/results/tmpdir.zbd.009.1=
IJ/mnt/verify.0.0: No space left on device: write offset=3D782336, buflen=
=3D4096
> fio exited with status 1
> fio: verification read phase will never start because write phase uses al=
l of runtime
> 4;fio-3.36;verify;0;28;700416;364610;91152;1921;3;110;9.283027;2.078678;2=
;1234;159.304360;28.925367;1.000000%=3D23;5.000000%=3D112;10.000000%=3D150;=
20.000000%=3D156;30.000000%=3D156;40.000000%=3D158;50.000000%=3D160;60.0000=
00%=3D162;70.000000%=3D168;80.000000%=3D173;90.000000%=3D181;95.000000%=3D1=
85;99.000000%=3D205;99.500000%=3D220;99.900000%=3D259;99.950000%=3D276;99.9=
90000%=3D428;0%=3D0;0%=3D0;0%=3D0;10;1243;168.587388;28.998837;0;0;0.000000=
%;0.000000;0.000000;700416;191789;47951;3652;4;5023;17.928978;27.794189;1;5=
446;303.143928;124.069601;1.000000%=3D59;5.000000%=3D124;10.000000%=3D150;2=
0.000000%=3D199;30.000000%=3D242;40.000000%=3D280;50.000000%=3D301;60.00000=
0%=3D325;70.000000%=3D358;80.000000%=3D391;90.000000%=3D444;95.000000%=3D48=
9;99.000000%=3D602;99.500000%=3D675;99.900000%=3D798;99.950000%=3D872;99.99=
0000%=3D1011;0%=3D0;0%=3D0;0%=3D0;17;5452;321.055559;125.717726;110376;1331=
20;65.710471%;126025.454545;6491.718607;0;0;0;0;0;0;0.000000;0.000000;0;0;0=
.000000;0.000000;1.000000%=3D0;5.000000%=3D0;10.000000%=3D0;20.000000%=3D0;=
30.000000%=3D0;40.000000%=3D0;50.000000%=3D0;60.000000%=3D0;70.000000%=3D0;=
80.000000%=3D0;90.000000%=3D0;95.000000%=3D0;99.000000%=3D0;99.500000%=3D0;=
99.900000%=3D0;99.950000%=3D0;99.990000%=3D0;0%=3D0;0%=3D0;0%=3D0;0;0;0.000=
000;0.000000;0;0;0.000000%;0.000000;0.000000;15.679943%;47.560100%;282053;0=
;30;0.4%;0.8%;1.6%;3.1%;94.1%;0.0%;0.0%;0.08%;0.21%;0.01%;0.20%;0.87%;1.69%=
;62.65%;32.17%;2.02%;0.09%;0.01%;0.00%;0.01%;0.00%;0.00%;0.00%;0.00%;0.00%;=
0.00%;0.00%;0.00%;0.00%
>
> Thanks
> Zhijian



--=20
Best Regards,
  Yi Zhang

