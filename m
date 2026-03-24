Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4B43A4511
	for <linux-block@vger.kernel.org>; Tue, 24 Mar 2026 10:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774347024; cv=pass; b=FlLfTRm/tdTGS0W285ZkS8OssxzIBfOR9BpAo5ObFE18tnHvKr5lz72KVnkK//Jenbc8sOMC9sCfUllwt6LD4VVYKKEn6CICpEw8NdaqQAGciLodpVIhRz8vsxF14dRd5EQt5dweNgOl6RWltf1H/6nnoRrhi01aZKd3S5XToIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774347024; c=relaxed/simple;
	bh=9Ek7AJI4xdm8ormJKdTuU+K0CnPhIRmyXsrFat6ksds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QDC+D4EaWRyuZAVowO6knKO6AGsRqVUrXX6O6cuVl4tg3jtEiKcsnvk4gTC44D4LJJ/6SJeT1HscXnaEDqvT+R4Di1I9P1yJfPoUDP8UqCipP3NJsKZJ1/5YKV5bd0f2XQYiKGSjcGtP878sVXFR2sSoXjUuq6D8tvNFOn16Pw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=APzdwePv; arc=pass smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="APzdwePv"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3878de20527so27289791fa.3
        for <linux-block@vger.kernel.org>; Tue, 24 Mar 2026 03:10:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774347019; cv=none;
        d=google.com; s=arc-20240605;
        b=fQn0qfEVVGM/4sSKAGVlL6jyKvCQ5eiaxR3dYqoWZwPy+hasFlvT6ZWFi+VBsiHu4i
         tfOPYICfy4jTkko5m+mkPvrU9TWNl5lqbMyvQIfyvmQ1qJwpXqVeUtfyObk+qX1g4t22
         YJW1JDFmQbCSMJieYuULTOJ9KOdOtScoT5fdQVq51Ok8okx8aHZdWXsN/2NCbqpJWDJN
         hvprS9qo+1fdhs+MK8WcM1M5mGwC/rNpmkfJIAH5oHU2Wd8PSgqQMZZb00o0nTMLwMC8
         G+O4zrMcgqetXjvwTU7WKd2S6aqPY6SUSu9KYuZ+XW8xHem1w44bKBWrpPymWPjSakhw
         jvbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EPF+TV96jiFOeR963Kh3r/N94rHBy9mldlcZSNoUqI8=;
        fh=J9aGrwLIDyQhEXMVPXc2XH/TCtDrLgh8d3l2wl1Hwsw=;
        b=Vek3tlYSODeN1qILoY27yo2u+oZcJP4R6zcrAricjUWzpAabN2e1VSnjBvzs6vbnE0
         DOLxI8dCRzuSujxVFvY4hGVm/aX+f/w9/koFI5TLSad5FG8IoxbefLQPBzPea29jraiM
         yqNRyUYEh4xR8+qd6Ax+jhnAFMZ1SDzujwkbCifTxYbXi01jpwgkJAOxL1q1a0+b12B0
         hTWDHJgEPjKdm5au/P4+Ac7mV5j/inG6JCwdyfSgDonC/GS+/YpD+FUZeutsZCYMWK9o
         6amw4r1XYnUkKgJsvJsA8c6znjgTAwp090LQhx2ZZxfeVzvjFx6GYc4WiC2etm5AvHLM
         2Xnw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1774347019; x=1774951819; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EPF+TV96jiFOeR963Kh3r/N94rHBy9mldlcZSNoUqI8=;
        b=APzdwePvyiZhp5VS0zRI4PsAddmlhdtCFQojq1TTWFHv1E3gvfpp/LKzhjGwBYca4m
         6NyIosrxjhxXOkpSfNn0aAm1harHSUXGprxbeQ93BgNDaAD846yzWQnZ1S6c2bHV0zPm
         XnN0VCXe1ZZau1R5JCc23MEqDu2c7j4cYSUCsF0nvmNntGJmcQ8ttoCr4rFjMZy23oxi
         18Txsuik6nuzeNVvKrYmrFpJbf1ScDcI5QR3UbGODaHf4bOO0GIbHhwvKjWrIJ+yhOot
         L91g6BMTzRvm+c5RjShvp5zNilYBAPeXOvsafJVEOzDCqCpIE0ZewyT784cZr9mCBKvC
         s9mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774347019; x=1774951819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EPF+TV96jiFOeR963Kh3r/N94rHBy9mldlcZSNoUqI8=;
        b=r/uVwfCO+iUhjEW2JRa405QKDe35nIEcM4LszXGn8K7OD/SGnojG+XGx7OZuXtNzWX
         Kh2f2Qs+LlqMLikD5d8ISSZ/WTl/vv4K48sFG41V0hW1WzMvJ8/R3Vl0nmPuqyT+6Urs
         n/FNSqNnXb+/dBW8EGAPpzXy8/CAisB5oLvlvRVrWiwHY8KWd+mndxEPziQCW84gSS0N
         VsXhtWU3TeZPKXmCwfaCx7CzdYUkGP3YUTCkbwCS8HQGCUANwgQFTl4xQnPhfx9LGs4p
         spxJa6DVGYPUk5yunMHUVh9Mn5RXsgW7jDJHnKLwhQvZO9xnQUMKQF31Xg7W1reUy/9x
         Y6nQ==
X-Gm-Message-State: AOJu0Yy8JMCWzS7T6xVFmd3OGbUsM2cO2ClcyGAniUOp8jQOFjuKSbev
	6+hgNRx8ILVXwvLXKzoj6EgqUNe4Wv33B2gRj5iveQtJOi+hljQVIc+eKjhCZbnrSnjK8MOcCKV
	9jUNdf6zxzy5WHpZ2sZ/jd5sBYvyhXDRgvKKo53VDs4u+Il7/u6n7
X-Gm-Gg: ATEYQzz4VfDxw1ZgjztZOTFn8ecUVNzCzVTZdlCCz92LvVA+/vK6NUbUdmIPS97PN8Y
	LVyW5ioc/0f4d8JumHnNsy2/uwvPxTNaoTcsO4xeTOT6qnJew+nvz4brAeIN+gCq6Ery1NcCcH9
	Y8Fo2mM6l6WPBb9x5r0KUAIsL2E+fnRxcRQA4TbYhirTqOV6wC7w8fE+lIJH/DIkp6wvfrszq24
	UBSnh7Mpd7NS8iRFdAykPONNslReqVBSgB6KKex/F88VG+ErG762OVdn03lj94DAbOMNmHbZLaD
	bcLMVT7tyZqxNYYLL5AqOSOKyFhnpHXYXaw0pv+UgQ7F/mFNK+wyCiAeSso5AyNtiKPs
X-Received: by 2002:a2e:be11:0:b0:38b:e305:a03b with SMTP id
 38308e7fff4ca-38bf96ddf1cmr49020941fa.30.1774347018896; Tue, 24 Mar 2026
 03:10:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHj4cs_mRpS=uqW=2NF8RdzW2jjgu+3LhmCFiSK2kahRmTS-tw@mail.gmail.com>
In-Reply-To: <CAHj4cs_mRpS=uqW=2NF8RdzW2jjgu+3LhmCFiSK2kahRmTS-tw@mail.gmail.com>
From: Haris Iqbal <haris.iqbal@ionos.com>
Date: Tue, 24 Mar 2026 11:10:01 +0100
X-Gm-Features: AQROBzAKCOd3b1KWlVmDIptuhRqjXLCQO7kKHpoXhHy-IkmRsf-em7cfPKsqJm4
Message-ID: <CAJpMwyjAQhL9H_5Odz3zg12D-ja3VdsbZbwE2TxuLEsaP5KQbg@mail.gmail.com>
Subject: Re: [bug report] blktests rnbd/001 hang on s390x server
To: Yi Zhang <yi.zhang@redhat.com>
Cc: linux-block <linux-block@vger.kernel.org>, jinpu.wang@ionos.com, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	"Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 21, 2026 at 2:00=E2=80=AFPM Yi Zhang <yi.zhang@redhat.com> wrot=
e:
>
> Hi
>
> I found this issue when I running blktests rnbd/ on s390x server,
> please help check it and let me know if you need any info, thanks.

Thanks for reporting.
We'll take a look and come back.

>
> dmesg:
> [   72.319120] rdma_rxe: loaded
> [   72.358181] rtrs_server L2371: Loading module rtrs_server, proto
> 2.0: (max_chunk_size: 131072 (pure IO 126976, headers 4096) ,
> sess_queue_depth: 512, always_invalidate: 1)
> [   72.380277] loop: module loaded
> [   72.399060] run blktests rnbd/001 at 2026-03-21 08:42:02
> [   72.408570] infiniband enc600_rxe: set active
> [   72.408573] infiniband enc600_rxe: added enc600
> [   72.422914] rnbd_client L607: Mapping device /dev/loop0 on session
> blktest, (access_mode: rw, nr_poll_queues: 0)
> [   72.488056] rnbd_client L1192: [session=3Dblktest] mapped 2/2
> default/read queues.
> [   72.488199] rtrs_server L1058: <blktest>: Processing read request
> failed, invalid message
>
> # uname -r
> 7.0.0-0.rc4.260317g2d1373e4246d.37.fc45.s390x
>
> # ps aux | grep rnbd
> root        1492  0.0  0.0   8276  4436 pts/0    S+   08:42   0:00
> /bin/bash ./check rnbd/001
> root        1521  0.0  0.0   8288  3292 pts/0    S+   08:42   0:00
> /bin/bash ./check rnbd/001
> root        1523  0.0  0.0   8424  3664 pts/0    D+   08:42   0:00
> /bin/bash ./check rnbd/001
>
> # cat /proc/1523/stack
> [<0>] send_usr_msg+0x120/0x170 [rnbd_client]
> [<0>] send_msg_sess_info+0x1d2/0x210 [rnbd_client]
> [<0>] find_and_get_or_create_sess+0x274/0x2f0 [rnbd_client]
> [<0>] rnbd_clt_map_device+0xf6/0x7b0 [rnbd_client]
> [<0>] rnbd_clt_map_device_store+0x228/0x320 [rnbd_client]
> [<0>] kernfs_fop_write_iter+0x168/0x220
> [<0>] vfs_write+0x282/0x450
> [<0>] ksys_write+0x84/0x110
> [<0>] __do_syscall+0x166/0x600
> [<0>] system_call+0x6e/0x90
>
> --
> Best Regards,
>   Yi Zhang
>
