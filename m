Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B6D53A7;
	Wed,  2 Jul 2025 03:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751428387; cv=none; b=CnxSoAcLcrZz9czi2Qr3qXiSK0wCZZmHVTrRxRjSiE1HjABLAUKCvtOliKyelfejyQJ+rFXQNL5ODg780IsU+V/nkGDxMevcxa8qB7FhxjM7ZZT8XiUVBsvteHD8UCbt4u1X7V+F3WcQ2pQwYZfi+eUpd5Tgode0HOQrGOZ/eNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751428387; c=relaxed/simple;
	bh=duTa0unexyP40dwW0FOLLZP8BP3cm7B57q1vv6y6/so=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aAOFbEboKsjF5k84kXXbEVh2V9jEOL2Cz0fNUxFBIy8fDQ5hKYk+a3lgFoao7fBJcnpPZ/RcBBKvcvWpxoN8/sL9HNUMfCteJ9dpG2zCYkNuiWHkWd5kiu8vLzGiweh+/zi/TwA1SEd+eXZP4EZnDCaVb75ZPlYQTgtqPznAlsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=YvUrbnoV; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="YvUrbnoV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1751428383; x=1752033183; i=quwenruo.btrfs@gmx.com;
	bh=W5HRfOt+lspy5Oi6J0LPHdd2cSYz01zEa2Bs2WBPDUY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=YvUrbnoVl1PyD+Y/YILcsVCrKpfbTKnCIHw2n7kn5UeR9y55Eq+07Vs1db35/95h
	 v34AI5E9yw6R66zDE7z0MNpkAK1XucVeiiYq0/uRMMsj0meiDj10iJDuS3WDDjoYe
	 rucw8DExRK8N+D3KfiKnCinwX+X83AAhEC8Ehcbiesx1u+8RfVnTMBGlpRDMJDz5/
	 N3l99SM+frQV6QPhmOSaNeVfurQSuzd2a178rZf+AXiWiOQrM6HXxp2QKuC9AZhJw
	 6GbnKdCQlX7POuZ18MxSlGZGQgcV/5BZlsx3T28I/8XvZvjl/IgqFeEr8ODmGbP72
	 YeEHhlAdTp+GKek7Gg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MGQj7-1uTl3r1Zyn-006PGa; Wed, 02
 Jul 2025 05:53:02 +0200
Message-ID: <281b5606-894f-4fc9-af13-69ebf0941c87@gmx.com>
Date: Wed, 2 Jul 2025 13:22:59 +0930
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Weird delay introduced in v6.16-rc only, possible regression
To: Jens Axboe <axboe@kernel.dk>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <e597d8c6-ed77-47ae-b030-1016727d6abe@gmx.com>
 <20f07b3b-194a-4dfe-936e-0f159bf44485@kernel.dk>
 <69ea6e7a-a6f9-4199-9dc4-01b37092795f@gmx.com>
 <90fa0bd9-71b7-44f7-9175-641d43e9fe1b@kernel.dk>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
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
In-Reply-To: <90fa0bd9-71b7-44f7-9175-641d43e9fe1b@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qLQv5W7NvdE90zMnCjENeIiH58ODtp/g73S4070/tKRX6WO1taT
 V6shdjS4tAJbzmYi3FvmQ3xwHYzYr6yWUfglE0Px7Ttw2u7V7y1v8izCGWsq9mNVw4kcEb9
 1YDw0Tkt/e/aWNSPl09aDWaU1uHWJyjd1MwgDENcjWo2TFnpJw3z7HqK22E+M4/WB22E4U8
 wtmBT4Ac8wTlBSsvvjp0Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ay4/e63wevY=;X41lRONQhkcE4Zy9kj0+CrnQP7T
 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
 f94g1aIBH2LYlmCnl8UEHlnLy6n5w==



=E5=9C=A8 2025/7/2 07:41, Jens Axboe =E5=86=99=E9=81=93:
> On 7/1/25 4:07 PM, Qu Wenruo wrote:
>>
>>
>> ? 2025/7/2 02:00, Jens Axboe ??:
>>> On 6/29/25 3:45 PM, Qu Wenruo wrote:
>>>> Hi,
>>>>
>>>> Recently I'm hitting a very weird delay when doing development inside=
 a x86_64 VM.
>>>>
>>>> The dmesg shows the delay (10+ sec) between virtio blk and device-map=
per:
>>>>
>>>> [    3.651377] virtio_blk virtio4: 10/0/0 default/read/poll queues
>>>> [    3.653075] virtio_scsi virtio2: 10/0/0 default/read/poll queues
>>>> [    3.670269] virtio_blk virtio4: [vda] 83886080 512-byte logical bl=
ocks (42.9 GB/40.0 GiB)
>>>> [    3.672096] scsi host6: Virtio SCSI HBA
>>>> [    3.708452]  vda: vda1 vda2
>>>> [    3.711073] virtio_blk virtio5: 10/0/0 default/read/poll queues
>>>> [    3.729879] virtio_blk virtio5: [vdb] 167772160 512-byte logical b=
locks (85.9 GB/80.0 GiB)
>>>> [    3.737535] virtio_blk virtio8: 10/0/0 default/read/poll queues
>>>> [    3.747045] virtio_blk virtio8: [vdc] 83886080 512-byte logical bl=
ocks (42.9 GB/40.0 GiB)
>>>> [   17.453833] device-mapper: uevent: version 1.0.3
>>>> [   17.455689] device-mapper: ioctl: 4.50.0-ioctl (2025-04-28) initia=
lised: dm-devel@lists.linux.dev
>>>> :: performing fsck on '/dev/os/root'
>>>> /dev/mapper/os-root: clean, 240299/1048576 files, 3372218/4194304 blo=
cks
>>>> :: mounting '/dev/os/root' on real root
>>>> [   17.871671] EXT4-fs (dm-0): mounted filesystem 00a85626-d289-4817-=
8183-ee828e221f76 r/w with ordered data mode. Quota mode: none.
>>>>
>>>> The VM is running kernel based on upstream commit 78f4e737a53e ("Merg=
e tag 'for-6.16/dm-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git=
/device-mapper/linux-dm"), with a lot of extra btrfs patches.
>>>>
>>>>
>>>> The v6.15 kernel from Archlinux is totally fine without any delay.
>>>>
>>>> The v6.16-rc kernel may have some different configs, but the config i=
s used for a long long time, way before v6.15, so it looks like it's somet=
hing in the v6.16 cycle causing problems.
>>>>
>>>> I can definitely do a bisection, but any clue would be appreciated.
>>>
>>> Probably a good idea to go ahead with a bisect to help pin it down.
>>>
>>
>> BTW, a little more digging shows it's the `udevadm settle` causing the =
long delay in the initramfs.
>>
>> The rootfs is an ext4 on a LVM lv, so initramfs is required to mount th=
e rootfs.
>>
>> So it may not be the block/dm layer causing the problem.
>=20
> Even the more reason to bisect it then, if we don't quite know why it's
> slow.
>=20

It looks like my memory is blurry, I tried as old as v6.14 (v6.13 failed=
=20
to compile using the latest gcc 15.1.1), all the same delay.

Thus I believe it may be some missing kernel config causing the problem.

Let me retry with the base Archlinux kernel config and see what's going=20
wrong.

Thanks,
Qu
