Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBF010E9
	for <linux-block@vger.kernel.org>; Wed,  2 Oct 2024 15:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727881397; cv=none; b=N0xdsekUffJ6/sxCCSJsMIvcdzXmCmxO81pqgN2svGWhf+WungtejbBqkSu1ZWQzaJqz6RI57K7ciVtwEo4fLwSFowsCG50ftUU1Lhqr+jFZb2IldZc4mvAykXG7qomw3GxcDXOu1QdVDIQaDUtVBJDfC3aIXB4espX839XTvvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727881397; c=relaxed/simple;
	bh=HAc5UTPWcxbLVyB3ExKR3J8DVu/xMihDErOtSJavi/0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=X5CNqD16/40IIXlH6JUwNP5Eaiu42iXv70EQnvHWTtwnPlMKgGym7VA6WiTPRSDZpMDiS8c40cfwsRlinREtuj/W0xMqtMjMVpEdVECYqohXZ3+vmC3qOg9tonYq285my5dv5q8ZBlv/al2+N1LuVhdQx1TnzlFimXVW4cKnXIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geexology.org; spf=pass smtp.mailfrom=fe-bounces.geexology.org; dkim=pass (2048-bit key) header.d=geexology.org header.i=@geexology.org header.b=YT7urD2c; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geexology.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.geexology.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geexology.org header.i=@geexology.org header.b="YT7urD2c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geexology.org;
 h=Content-Transfer-Encoding: Content-Type: Cc: To: Subject: Message-ID:
 Date: From: MIME-Version; q=dns/txt; s=fe-7b91e1338f; t=1727881393;
 bh=jvCLfXWsfGjSN5aktBhWAq6X2qEF5Es102uqDOGx0Ms=;
 b=YT7urD2c2ydsWQyKtlGP2OgU1d776L3uup86d7s3V1RECU6XOLsD2dCFpoezq/yDYGJS+nIN7
 DwExNg3RkYcm+vSLfqaUJRmZydQRe1Xgf/2Dtl5giaMcIqjIYVSMX4zTaAT7jcQj8gy1ONMrxco
 odgkBTSImBblClQZL0QLLgNCtwostQo3csvblYOfHj8JoeIeGak2WPedgFSRNrPY+Z+isD/oVeU
 clRk02c8Ngq8BpH1N0Sdc6G+78MRWYYVFAQja7JmmKEHxWR5G+CpXtzyBBcdohw9sviczCPzBTT
 1WvDSzNOggLX4scNSpv+5D//jVHi3sK9kd4OC03thKCw==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a93c1cc74fdso1045690766b.3
        for <linux-block@vger.kernel.org>; Wed, 02 Oct 2024 07:52:54 -0700 (PDT)
X-Gm-Message-State: AOJu0YwKdx18nH1+QFZue6bkAnOQu3W18Hc/KhVCpDY1K54mpPbiXSqm
	XS/HpOQBt295alVQreL+k5MgfJ1Hbk981xILtxH2S8BB5ep+eYPdmy0pM2B3kLvgNoh57MTXn61
	77ogeQ3lX3szJmhHrj2G7db0dRqJWudaLqaJc
X-Google-Smtp-Source: AGHT+IEYSKyQi7KAHswp3vi24/pVTQDHfoOZeL54ewo76pnqYju5+QNVShGjrvw+Z8KslC2JXknVngvZ4zUqkzx0MoM=
X-Received: by 2002:a17:907:9705:b0:a8a:8c04:ce95 with SMTP id
 a640c23a62f3a-a98f83d7a68mr343426366b.43.1727880772581; Wed, 02 Oct 2024
 07:52:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Fred Richards <fredr@geexology.org>
Date: Wed, 2 Oct 2024 10:52:41 -0400
X-Gmail-Original-Message-ID: <CANPzkX=JkOgziVBR5jW7pXa6ZawG7KQjbKQK6wdt4=7ZjjpH8Q@mail.gmail.com>
Message-ID: <CANPzkX=JkOgziVBR5jW7pXa6ZawG7KQjbKQK6wdt4=7ZjjpH8Q@mail.gmail.com>
Subject: apply "none" for io-scheduler causes coredump under 6.11.1
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; fredr@geexology.org, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66fd5e47316f1d07bd3c5ad9

Hello,
 Mainline kernel 6.11.1 on my archlinux machine with several disks, if
I apply "none" as the io-scheduler, it core dumps.

Startup script rc.local has:

echo none  | sudo tee /sys/block/nvme{0n1,1n1}/queue/scheduler

Causes this in the journal log -

Oct 01 14:39:06 tor systemd-coredump[987]: [=F0=9F=A1=95] Process 980 (tee)=
 of
user 0 dumped core.

                                           Stack trace of thread 980:
                                           #0  0x000079b6a0ca43f4 n/a
(libc.so.6 + 0x963f4)
                                           #1  0x000079b6a0c4b120
raise (libc.so.6 + 0x3d120)
                                           #2  0x000079b6a0c324c3
abort (libc.so.6 + 0x244c3)
                                           #3  0x000079b6a0c323df n/a
(libc.so.6 + 0x243df)
                                           #4  0x000079b6a0c43177
__assert_fail (libc.so.6 + 0x35177)
                                           #5  0x0000617a0fb4e3ec n/a
(tee + 0x63ec)
                                           #6  0x0000617a0fb4a34f n/a
(tee + 0x234f)
                                           #7  0x000079b6a0c33e08 n/a
(libc.so.6 + 0x25e08)
                                           #8  0x000079b6a0c33ecc
__libc_start_main (libc.so.6 + 0x25ecc)
                                           #9  0x0000617a0fb4a665 n/a
(tee + 0x2665)
                                           ELF object binary
architecture: AMD x86-64


Problem is reproducible as well.
I can set the nvme disks for "bfq" but then cannot set it back to "none".
Unsure about the origin of the problem but it appears to be something
with libc and the newer kernel.
I can login as root, and redirect ( echo none >
/proc/sys/nvme1n1/queue/scheduler ... ) this procuded no error but the
scheduler does not change.

Also tried on a Rocky 9.4 VM with the mainline 6.11.1 elrepo kernel,
the error just reports no such file or directory ... the VM also has
virtio devices so unsure if that is related.
I can provide other outputs of commands like strace if needed.

-- Fred R.
