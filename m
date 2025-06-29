Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55092066F7;
	Sun, 29 Jun 2025 21:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751233554; cv=none; b=tJD/XExVHKSMonDltAQ+6k/WfNZaUf1wEtoi1AshMSYz9/yRYVDBexnD5L75JbpcvXgYiYtBqg9XIGoqREZMvVA1Gthm24kAEBqiBUhvq4QggycM6SEetN3MIap4oA7luDlKNsnf5Luvq0oIRuWhZXsjVyJvKU2Y6Q/wOwZ8bGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751233554; c=relaxed/simple;
	bh=HknOQ2ySMbkReAfQ37FumZiGMF8SEkFq84H1EkwGl9s=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=u9zmp9eqkrUWmsneunA+nKfSjkMcV14aEMjT35ZOA6nBauSOeUZ9iXl5mK3jkk653Fg5NRk2SjkDQRRygHqnwtY86fa3du2+8UeGBUFLssgCdOe51s+Q7OKAxvKB4AEUGjo6Q83jVNFDYvpdY6/3horLEyUxtgi5wu7LEyAA4z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=i+U7JEFo; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="i+U7JEFo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1751233550; x=1751838350; i=quwenruo.btrfs@gmx.com;
	bh=QNUEwybt3txHmlnVAP27evS+4p3koS18NEtUe9G3Ovc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=i+U7JEFoCFlTef8floPR7ikJDiGMRvPLhsClumNrdaopNH770UgNVyOGkB1CNQal
	 aNDHPB/N1WSFtOgbmxUQPNZyGpzA8JCEVfG8ZThvovQRPkTvf0EHYOUmS2Zv8/WmK
	 DPZkvx8IhMYe/N5XFSt07epoU3+qxxyYDXytl1h9ZamyO0nr+N+d9VmWJIrssirmF
	 pXPmsUYQyqAYqe62DDZwCGv1FjtWo+NsDNfFfGMSx+3o3YA7i4txjdEAE75cL4/Xr
	 MetN3vzRQkEStb13G08kzu/hTAZVvyUr3VDP0av1fOxGXFsVGVtbNjjopRL8UD04a
	 NAY4hkntgSAc2NgVFQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1My32F-1uvUaA1CNb-015YiH; Sun, 29
 Jun 2025 23:45:49 +0200
Message-ID: <e597d8c6-ed77-47ae-b030-1016727d6abe@gmx.com>
Date: Mon, 30 Jun 2025 07:15:46 +0930
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Weird delay introduced in v6.16-rc only, possible regression
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mG4gemtQ9CSwA9XLc0g47oXmyJ/gOBnO5xKdDgl/L3RUfcF5SxK
 B+5sDQADte73lUAP+E8llfQJt+Ypx9YheBfiDRRSC/Pjea2c+K5Pz7U0WEXmrJaPQsJoLXI
 qEt6XGAE9lTHYZ7PWg6mSVf5j7oN1/tgYMbOqrz0GxEOo28QPe4LT4bUQ1gl1cYlgZJdtBg
 iwnZX2syEiMWBWX7YB2Zw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3ff4FfGgOeQ=;OwyhYf9w90R9Pz/MLGEy2bk9lc1
 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
 vbSUCNU2YVccPODIPfeQ==

Hi,

Recently I'm hitting a very weird delay when doing development inside a=20
x86_64 VM.

The dmesg shows the delay (10+ sec) between virtio blk and device-mapper:

[    3.651377] virtio_blk virtio4: 10/0/0 default/read/poll queues
[    3.653075] virtio_scsi virtio2: 10/0/0 default/read/poll queues
[    3.670269] virtio_blk virtio4: [vda] 83886080 512-byte logical=20
blocks (42.9 GB/40.0 GiB)
[    3.672096] scsi host6: Virtio SCSI HBA
[    3.708452]  vda: vda1 vda2
[    3.711073] virtio_blk virtio5: 10/0/0 default/read/poll queues
[    3.729879] virtio_blk virtio5: [vdb] 167772160 512-byte logical=20
blocks (85.9 GB/80.0 GiB)
[    3.737535] virtio_blk virtio8: 10/0/0 default/read/poll queues
[    3.747045] virtio_blk virtio8: [vdc] 83886080 512-byte logical=20
blocks (42.9 GB/40.0 GiB)
[   17.453833] device-mapper: uevent: version 1.0.3
[   17.455689] device-mapper: ioctl: 4.50.0-ioctl (2025-04-28)=20
initialised: dm-devel@lists.linux.dev
:: performing fsck on '/dev/os/root'
/dev/mapper/os-root: clean, 240299/1048576 files, 3372218/4194304 blocks
:: mounting '/dev/os/root' on real root
[   17.871671] EXT4-fs (dm-0): mounted filesystem=20
00a85626-d289-4817-8183-ee828e221f76 r/w with ordered data mode. Quota=20
mode: none.

The VM is running kernel based on upstream commit 78f4e737a53e ("Merge=20
tag 'for-6.16/dm-fixes' of=20
git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm"),=20
with a lot of extra btrfs patches.


The v6.15 kernel from Archlinux is totally fine without any delay.

The v6.16-rc kernel may have some different configs, but the config is=20
used for a long long time, way before v6.15, so it looks like it's=20
something in the v6.16 cycle causing problems.

I can definitely do a bisection, but any clue would be appreciated.

Thanks,
Qu
