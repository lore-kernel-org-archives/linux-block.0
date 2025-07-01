Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B00030AAB7;
	Tue,  1 Jul 2025 22:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751407631; cv=none; b=dYA6lIf4q4ZpU4Hx20Tgpmxk9pJ6mdWYYOrJlgSNQTQdGhWCARhJuAn5z9mVQNIRWa5OnM1ccT7ce2MCVrSRKrDPx1749nq5KJr8SWzekdicpa/xH1O8xCbvkf7jub2hqPtGQa48QUH8Ok90I5BQupsbUT7pLyifMhnIxYq8D+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751407631; c=relaxed/simple;
	bh=0vNweIBmoWH2m9+t4BMtJs6ToFQtu2CZZxIzp5Uy6pc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pO2qEGyzd8B5fgZF6NFFJe/CclfYgLWmBhnqx+84ZcIYEfxk7aaju04nk1aw6rfOT25ZXBUyrU1zBxjnQ9GeVFtZ5jPBk4Zd8gT5y08SASnZlM0py8TTltCd7s7ngGmiqFgk28HrbSvS2uYY861wzXSfX523b2encnZxw7qwbpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=isJZjRpr; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="isJZjRpr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1751407625; x=1752012425; i=quwenruo.btrfs@gmx.com;
	bh=LftxjriR+oDBK3YU7Te/GbUG5p1Q2J8rlJhR1bUeG6M=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=isJZjRpreg8TkjS8SPKdQpNK/kawYd2jV8FCh6fdsBeLGJ1rHKLJW/P2Yr4eTQwp
	 cQOc2aaStb4AF0lbdjhaer654FANfV4kU1qXtpA7LHRahhfa38zmqAOJsWlxCaYMu
	 KoSevg0A4OLVJku5W8JUG3HEYEu2F2NlBSt7O1FqlYo+mrGYG2VEMQ0fqoZnza0zI
	 aPmjU6GMAdh4Lz71hmlKNkehWVgaHlwpIQ53qnTRLVwF9mrGPDfd6Meu294gjmmnh
	 1G6s0IMmsDxXokTZRBV39wjdCj/BTkiYD1UsCiKuygee1jdXL1TzKT1iSGJrWs/xY
	 wGB6h9cvEK5f6DlUFQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MTRMi-1u7Niv0BHY-00K0T4; Wed, 02
 Jul 2025 00:07:05 +0200
Message-ID: <69ea6e7a-a6f9-4199-9dc4-01b37092795f@gmx.com>
Date: Wed, 2 Jul 2025 07:37:02 +0930
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
In-Reply-To: <20f07b3b-194a-4dfe-936e-0f159bf44485@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5krxuA31gqY0N+IeZuVMass67jFv9DFhwFOWhA6ilt1HeMNiTUG
 ymO7xN2vt82QpGvrZ1apaCk11FWUemould8Fuu5OB3BJTH65bQOyF+AbB01fOCMnihgAWO2
 5jso4mJaqXnufPlmZ+fcMx5r5GiEUXut8Dt+PkKPDyRUvPoMMg8qeTBhqk46qTnV5cMLie1
 eHXBbIYHKJgSkW/WMFQAg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+Pj83tGXoEo=;Eb4W1lPNBaB5Tg983hAyHlsRYyr
 ZmIfchhkz8wLEGUm5D7x5Py/moerVtPK+xBvj8he5hfr0Uz9D4WSHjtkYQDSz0jeytoylvdIY
 Czmzuf37edvOQs0bnrG+jNcRVwesmElGAgbotZpbbQK6AeohErEup/F4JDfKPZbD0kXZWRR7Y
 bnT2rZsfKo3fDsUy8J63KwBJU8p8Vd5a8sIP2bj1hvUDHdbvYLUgUo4s65gMCjgImNt0HrPgr
 4htFKuOlED/kFXbTm/4R6fZrrtemQ4e1yeZnBnXwHi9u7z/wveiAfz1tDVYE6jTAd+am1n9BG
 k9Tp2BjJSY2VLsKTCHr0sdxp+x/5XyTETqwT7auWjfb4fRalxG0ELam9oZIbD+OLKcTact47A
 /o3QGgQyvRtEpZF+G+PBROw9pVTxwXSAGg669Ge4LkQDRpbCSvmEWQaIG01qz9zBjz7Rghq5E
 zy3UEF6GB6/Wdn55DLrDN0EAxcKXswAz93eEDE/nxBvrPsd3hMFY2ZpFcWO8KXzGmIuLj9EQ7
 HB1f1cgZvjcJXrQ/bxGTwHletlkXK1xosiVNj7tssKmdw16Ljt8xlrCPy2ZlD+kL7B/+hPp6R
 14YcP7DgWuXF8CDphzc8LpMyAMjHGHsOEvXoBOuozajO+6lZjXpjFAwHOikPVpZzdzsQMwMcL
 x1Hljp/WSlO0Jxhi01U7D9nRFRBresk3tnDHtIWM5sI8g01X2wQ+2YTx4ffV/3y/rsNuM0Twc
 1Ql09kR0SFQcgaZOpp3WGWiIfy7LRo1akKD//T9kgjgXRCgW78WfDNrvP6kuaMd9Eg0QDYZ/N
 0G6dWkoA1szxLrjOmRVfr5ozgQDiqn7554fAP2P6LX2fpf1dSbomOxqhb7TMKZfdaA9mFhCik
 JzUANwxlpGVokRQWXhv52Klj5LlClNBiStnzRB0VeXqu5u+XsQq5XEdCIXED88YEjiuP1RcxO
 PrGKFpiCXgPSVyY5X1R828qHNRah4uCX4Q48h4NFlBGvduvPRjFkk1ZpkEcC+egE9Pa0eNlKz
 hFvH+z3oqZBKOhVIl2Fi+B6y89fTkR0BoE+2BbAyqutAhlrLOZCE8Ulij3iIatpKCJ/agQpBK
 hrjsdQVCEzjmozmmMypx9jxjjs1L7lVRMgNNQrn5i6qVBYUD3FOAxUKcr8XtAtxMqFFP3fqhC
 vhuEFGC8Ahd9jul2t3DOxNcOwIAsPjpe2qcWdimmxHPD28cnoKKPpKisZT4Jc1essND17sMP+
 xKzf3OI+fZtZG6MHCJGlaUAh9j8kIPq5/msRVEVSXlwBVUVDGfxV04rzU2lNWpCAilPCdd2Np
 I1WiF7VrHN8tQ1BnnQYuWDWM6MCet9GrXWfkvyXCPvDfKChqWps1vRw0fwtLJWfTAJcHzRlxl
 0NazBrqTf5spOY2iuIyq+nm4vZVfKLJnix1ycCHgzyGBWOq/KvamUpJHKNFBK9jFUwVrNJH/m
 vNJgj4yXpQftuds77jNJMkGmlWoORTIUFNSU4zbyCJH1p6ajh49wYwHP/lWchXoMoEtW5VDX+
 qywXbRUORjf29AVNdrcebK/DkGgwMeevhOlzKDVrE5FX7NenRK1Tz6qTR73furHpKAb5Iz9Du
 ClBbybSkmPqLHxxzKRWM4dwxWp0dY+cw0/CV7UJvtbKRSWPGTcRqp8bfrmiQ38ZGAtIfOtT9q
 +zhrs36oaor2P4xnqyAJOaRFXc2318+1YMo+aaGh+eRqJA0hWPN0+Rog6uWQRfpaooXZeqMw3
 tVHmwzodDO3F8UTRi4uL0Y5Ps15KnN9mTHRDvUahjIJAjNJWzsmgq6JXdjr/9NQUvkofq3ekx
 y648sO4GlYTNWL48gsiJll7ifzymQznMRBghbM6XmD+Ue1M8dlWf6oiri6Fhezzhltuk1DIbB
 ZVT4MQ1kbamK+/P0bwqx9N9Z4KjpkxvTzIaQjBlgSt6lpG9DnXkzrulQrPCiI3yKiQkavYma0
 uLabVY6G2AknmJ1eo6Pk4ZlpknEFM3gqy4cM3/UdramYn716RMIa9IcQ/mtMfEgoWJY5nljVC
 12WZ77qfM7qu2HIYpKIsJDPj/M8FfrcqJ5wvBth1lbxf/4bYFsq+WMOtJw4VwQfGFhizjt5YD
 X+ZUq5gmdpuE6uhqHMOjh50ktt5yzynzj5yCAyRlhUcBtgYorFOboTXcuf1OySU/rJUCguC00
 Et3EIMNlm91oIiEU1sSmUnujiTmvKjbgqEl/tphCBNmS519m2Z1BxWorf8C7Y2tAOvd8f60CS
 qPvM0fPxOHbdxH9Hpi7e8ZV1AVxiA6xJ/XQQ6sAcyBSbF/pep/xNiqavvdyZuMRjUBkgBKhzh
 oNg6ZZWPO+wminG2sJ2aP0AiOInt4Rd7/gceYOIytM4BhSuCMqRlsuXYGdQI9DXt8j6PLG/iU
 B7pibXO4V5tZO/9hZtnuZjTvTTO9SHcum9fxnvp43OR85XiXQnmATPzgvBp0/7T8axk68C7Vr
 dZOxyVeoEYiaicScp9KnqAnq07/dxsZUBfwWRpEzxNS++2edHlwJUAxgaKx1qqxo5Js2dBWcx
 jozFY6ViM7qSAoTigbxTGJTgoirAViXIluES8Qg1H3QEYXQMeroCF6keiAyo5vqW+iv9QQ3Nt
 BSs0uXPYeBK8mQiHIplu8WmwJY6lgnW2E0F5b75EQpGS6EMgc1IY7qkDl0YW1+dnGHHsd3QG0
 qNNmHukHNTIHsWeYPCgllIsPGMoEz+Y9X7Gbx3O1OQ5XXBCBN1rQkUf1IF14JuQMmi2bx4qU3
 IxFczCzq3ccGgbwZ0U+7IVM0lsqKFsQMrx1dQ5JVXSD4X/Exuv6wnivSVojAGeacFnV4i1Md7
 xWuaEdm3yXZ0EdTI04JaECIydtZqwmqZ2hLPXI52PSw1SAj3GEJvi4rkikfAVZcigHKDwfVC6
 U5IxfrSpypk88ss68ENzJu1jWp4KQ70EPOChl7M4mAhzJOxGGQkEJOVmRZYOTFZ0q9jexoh6x
 7gt2mtPCgvJ4Vbshu0lBfiTUIvYjfSb2hG/u3xXX0P9Kx7g+4sZ3stBH9fyXQqmj3yH/RinHw
 Ft16A42fFlp0IUBshODjWe2Ok/SW4CQzr78oU54jOfdY4nM1HK4/Gve/AqEqODOvXkGMzVIZs
 kyVBHbocSjfRrG9NuNtkuGV8OUSI20i/GrMAkrBb9U8ldOkMNhXc9Xdhju5jOWtBQuobHMIdm
 u3hLpeBx9iK9PhUF+wDQA8GaehkZWvHGk9me8mEwr4GdHBLXG1ciUz20qZqqr4yHilaKyZq1P
 gAqYnlcMVkPCNEgbHWmF7Zf1himrCnzn0ew/MQJF63ml8vkxploXMTov6VPs24HIA6z19X5h0
 UVYRuAhyNEdZNqzgl3U2NoomB4lJ1rnmHEdZ3VnvUmwnCfonaE=



=E5=9C=A8 2025/7/2 02:00, Jens Axboe =E5=86=99=E9=81=93:
> On 6/29/25 3:45 PM, Qu Wenruo wrote:
>> Hi,
>>
>> Recently I'm hitting a very weird delay when doing development inside a=
 x86_64 VM.
>>
>> The dmesg shows the delay (10+ sec) between virtio blk and device-mappe=
r:
>>
>> [    3.651377] virtio_blk virtio4: 10/0/0 default/read/poll queues
>> [    3.653075] virtio_scsi virtio2: 10/0/0 default/read/poll queues
>> [    3.670269] virtio_blk virtio4: [vda] 83886080 512-byte logical bloc=
ks (42.9 GB/40.0 GiB)
>> [    3.672096] scsi host6: Virtio SCSI HBA
>> [    3.708452]  vda: vda1 vda2
>> [    3.711073] virtio_blk virtio5: 10/0/0 default/read/poll queues
>> [    3.729879] virtio_blk virtio5: [vdb] 167772160 512-byte logical blo=
cks (85.9 GB/80.0 GiB)
>> [    3.737535] virtio_blk virtio8: 10/0/0 default/read/poll queues
>> [    3.747045] virtio_blk virtio8: [vdc] 83886080 512-byte logical bloc=
ks (42.9 GB/40.0 GiB)
>> [   17.453833] device-mapper: uevent: version 1.0.3
>> [   17.455689] device-mapper: ioctl: 4.50.0-ioctl (2025-04-28) initiali=
sed: dm-devel@lists.linux.dev
>> :: performing fsck on '/dev/os/root'
>> /dev/mapper/os-root: clean, 240299/1048576 files, 3372218/4194304 block=
s
>> :: mounting '/dev/os/root' on real root
>> [   17.871671] EXT4-fs (dm-0): mounted filesystem 00a85626-d289-4817-81=
83-ee828e221f76 r/w with ordered data mode. Quota mode: none.
>>
>> The VM is running kernel based on upstream commit 78f4e737a53e ("Merge =
tag 'for-6.16/dm-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/d=
evice-mapper/linux-dm"), with a lot of extra btrfs patches.
>>
>>
>> The v6.15 kernel from Archlinux is totally fine without any delay.
>>
>> The v6.16-rc kernel may have some different configs, but the config is =
used for a long long time, way before v6.15, so it looks like it's somethi=
ng in the v6.16 cycle causing problems.
>>
>> I can definitely do a bisection, but any clue would be appreciated.
>=20
> Probably a good idea to go ahead with a bisect to help pin it down.
>=20

BTW, a little more digging shows it's the `udevadm settle` causing the=20
long delay in the initramfs.

The rootfs is an ext4 on a LVM lv, so initramfs is required to mount the=
=20
rootfs.

So it may not be the block/dm layer causing the problem.

Thanks,
Qu
