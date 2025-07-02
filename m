Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FD734CF5;
	Wed,  2 Jul 2025 04:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751429686; cv=none; b=gVUBMcYWyYQFKRbTeINxG4azyGRnCGzUfjlOzT8WJlMpukUQrFegr5NTMaPTYOOmjSnjDl3ji3zsYpGSJeDz/MOqEdScf3QbfCZTl65V3N3kxNgMXqYFt2PItRwTnKak85JwXggOp67UhXO12uDJxX2vhGWiNorWgVwgtpKH4HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751429686; c=relaxed/simple;
	bh=eX8/YyJWO1JNaHmQ01t6Kk2+5QQXEsKsQVW3egVzbS8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=hzDEELDf4Xlcfc4wSCHlHJfIDpnttJOPG03WqKqkFtcUr+b+bzeHRz0rVmrSjlcKuzholFgpD1siDQtZbP1mV3IKBwUn8ugiHQ2yhghOLChmxYnSC57LQr1pENQFUciwwnfCY0V7cJqMmXGwg5coWeElTaMgnitWNWHKMsraNOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=fUSacZGK; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="fUSacZGK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1751429680; x=1752034480; i=quwenruo.btrfs@gmx.com;
	bh=eX8/YyJWO1JNaHmQ01t6Kk2+5QQXEsKsQVW3egVzbS8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=fUSacZGKDBg5wJEIv9ude6Tgw91HFbDW+1+vhvSHYBOdrdBlTxqyey0zIuO4cE+9
	 iNEGZ0uKvkpaUmVUwE3faxrtaOBGTZnQ2k9vidOa+8Fktgbe7yUyeCajXf6jSiM0h
	 5dpK2OAb090VDcEwVYZ6Y3NNNnf0LEBDPsYN2ZR10WRhNBCbZzyZLU7R/KTv0CAVB
	 WsofjD1uRmp5yPWUbhtT+sn/aj+AlceGnF1HqkVHiqQTzAcittkuKnXE8bj8WieTN
	 dwMWBupbg2PQ+F6CawGPYbzlz4ZOA3yu2n+ZdmfM1aWzPIUQh2Y4iS2fXMnQ/egWY
	 ueP/au674iikcaIXlg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MkHQX-1uzWyP0Vbt-00cmMx; Wed, 02
 Jul 2025 06:14:40 +0200
Message-ID: <74fbcc3c-304c-41bd-9c26-30bc832cc0a3@gmx.com>
Date: Wed, 2 Jul 2025 13:44:37 +0930
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Weird delay introduced in v6.16-rc only, possible regression
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Jens Axboe <axboe@kernel.dk>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <e597d8c6-ed77-47ae-b030-1016727d6abe@gmx.com>
 <20f07b3b-194a-4dfe-936e-0f159bf44485@kernel.dk>
 <69ea6e7a-a6f9-4199-9dc4-01b37092795f@gmx.com>
 <90fa0bd9-71b7-44f7-9175-641d43e9fe1b@kernel.dk>
 <281b5606-894f-4fc9-af13-69ebf0941c87@gmx.com>
Content-Language: en-US
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
In-Reply-To: <281b5606-894f-4fc9-af13-69ebf0941c87@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:epimdVph+99nRCsxvG/hw9Nrz/sewv0qhKTwW4Yhsqj1ZNYLhzQ
 NMHx3UCxFjgZ33dZ0dhbOZIi85uragALPZCuCfO0eq1lc7Rx4jcLG2TuFW130dfQ8oMpsZ+
 vVZRoqU+FQoU6u9pF9UEr2KANzu9MZqv7n0Ql7JWLn8iK3TG9elae4TVDWorykd47XaML0W
 bwQ9EmGDmf603uB6xn4tQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9FCjeivwLr8=;qs+if/1HdsaYTTR6D7NAgZJYxYQ
 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



=E5=9C=A8 2025/7/2 13:22, Qu Wenruo =E5=86=99=E9=81=93:
>=20
>=20
> =E5=9C=A8 2025/7/2 07:41, Jens Axboe =E5=86=99=E9=81=93:
>> On 7/1/25 4:07 PM, Qu Wenruo wrote:
>>>
>>>
>>> ? 2025/7/2 02:00, Jens Axboe ??:
>>>> On 6/29/25 3:45 PM, Qu Wenruo wrote:
>>>>> Hi,
>>>>>
>>>>> Recently I'm hitting a very weird delay when doing development=20
>>>>> inside a x86_64 VM.
>>>>>
>>>>> The dmesg shows the delay (10+ sec) between virtio blk and device-=
=20
>>>>> mapper:
>>>>>
>>>>> [=C2=A0=C2=A0=C2=A0 3.651377] virtio_blk virtio4: 10/0/0 default/rea=
d/poll queues
>>>>> [=C2=A0=C2=A0=C2=A0 3.653075] virtio_scsi virtio2: 10/0/0 default/re=
ad/poll queues
>>>>> [=C2=A0=C2=A0=C2=A0 3.670269] virtio_blk virtio4: [vda] 83886080 512=
-byte logical=20
>>>>> blocks (42.9 GB/40.0 GiB)
>>>>> [=C2=A0=C2=A0=C2=A0 3.672096] scsi host6: Virtio SCSI HBA
>>>>> [=C2=A0=C2=A0=C2=A0 3.708452]=C2=A0 vda: vda1 vda2
>>>>> [=C2=A0=C2=A0=C2=A0 3.711073] virtio_blk virtio5: 10/0/0 default/rea=
d/poll queues
>>>>> [=C2=A0=C2=A0=C2=A0 3.729879] virtio_blk virtio5: [vdb] 167772160 51=
2-byte logical=20
>>>>> blocks (85.9 GB/80.0 GiB)
>>>>> [=C2=A0=C2=A0=C2=A0 3.737535] virtio_blk virtio8: 10/0/0 default/rea=
d/poll queues
>>>>> [=C2=A0=C2=A0=C2=A0 3.747045] virtio_blk virtio8: [vdc] 83886080 512=
-byte logical=20
>>>>> blocks (42.9 GB/40.0 GiB)
>>>>> [=C2=A0=C2=A0 17.453833] device-mapper: uevent: version 1.0.3
>>>>> [=C2=A0=C2=A0 17.455689] device-mapper: ioctl: 4.50.0-ioctl (2025-04=
-28)=20
>>>>> initialised: dm-devel@lists.linux.dev
>>>>> :: performing fsck on '/dev/os/root'
>>>>> /dev/mapper/os-root: clean, 240299/1048576 files, 3372218/4194304=20
>>>>> blocks
>>>>> :: mounting '/dev/os/root' on real root
>>>>> [=C2=A0=C2=A0 17.871671] EXT4-fs (dm-0): mounted filesystem 00a85626=
-=20
>>>>> d289-4817-8183-ee828e221f76 r/w with ordered data mode. Quota mode:=
=20
>>>>> none.
>>>>>
>>>>> The VM is running kernel based on upstream commit 78f4e737a53e=20
>>>>> ("Merge tag 'for-6.16/dm-fixes' of git://git.kernel.org/pub/scm/=20
>>>>> linux/kernel/git/device-mapper/linux-dm"), with a lot of extra=20
>>>>> btrfs patches.
>>>>>
>>>>>
>>>>> The v6.15 kernel from Archlinux is totally fine without any delay.
>>>>>
>>>>> The v6.16-rc kernel may have some different configs, but the config=
=20
>>>>> is used for a long long time, way before v6.15, so it looks like=20
>>>>> it's something in the v6.16 cycle causing problems.
>>>>>
>>>>> I can definitely do a bisection, but any clue would be appreciated.
>>>>
>>>> Probably a good idea to go ahead with a bisect to help pin it down.
>>>>
>>>
>>> BTW, a little more digging shows it's the `udevadm settle` causing=20
>>> the long delay in the initramfs.
>>>
>>> The rootfs is an ext4 on a LVM lv, so initramfs is required to mount=
=20
>>> the rootfs.
>>>
>>> So it may not be the block/dm layer causing the problem.
>>
>> Even the more reason to bisect it then, if we don't quite know why it's
>> slow.
>>
>=20
> It looks like my memory is blurry, I tried as old as v6.14 (v6.13 failed=
=20
> to compile using the latest gcc 15.1.1), all the same delay.
>=20
> Thus I believe it may be some missing kernel config causing the problem.
>=20
> Let me retry with the base Archlinux kernel config and see what's going=
=20
> wrong.

Confirmed, with minimal change/trimming to the Archlinux kernel config,=20
everything is back fine.

So there must be some config being trimmed and causing the `udevadm=20
settle` to wait for some sysfs interface that will never come up.

Sorry for the noise, and thankfully it's not a kernel regression.

Thanks,
Qu

>=20
> Thanks,
> Qu

