Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEB81ACEDC
	for <linux-block@vger.kernel.org>; Wed,  9 Apr 2025 05:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744177802; cv=none; b=ABUAg4T92CZgwZPXzr6NXQvDkD6EPzvqV7OAtFvlg40faB3HJ5M5mhVYJ2rwUIhflGul9bAs3R+RfTQ46Hz3xNo/ZKGi84wsjM9e35ROsqbJFTQwNK/eV7wVXsZl8UF0v1b/ZZFL+jIflYUq9sOlWYVJsff14rQxkWJt9rMn2oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744177802; c=relaxed/simple;
	bh=3OaoUUjcjZubt+x/5l79bGOdRgxaW/Hhjjcxk77xfQQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=fwMsP3pHg6oZtg7G9RC50voYFr0OuLp2yQG/8tl4iqupi6hEnvLIm149PI23Y0ZxDqwgV8UAGuJzHRQKcqa9E/+lioNV2zY9FEjXmMtpm6pdndtpOcuUNQTA5hHQFtRwgKMF/cNeuk2iJ8iFabvGszo9JZUIHVFBr+Ywf1GkEIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn; spf=pass smtp.mailfrom=m.fudan.edu.cn; dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b=sMuPkjaW; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.fudan.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b="sMuPkjaW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=m.fudan.edu.cn;
	s=sorc2401; t=1744177758;
	bh=zIqJgQ6YkN1XVc+jDF7dQWJ5Wt60Jz8isGdE7Wj47YA=;
	h=Mime-Version:Subject:From:Date:Message-Id:To;
	b=sMuPkjaWjDmfOXBX5p8Ls9aKnVpH/p3+4Ltz5lIHgE27/V2NkshIijh7U1hMBumhw
	 JFCy81vNnaDkGPf+w7TmiDLNEZp7ixPzKyGzsg3Keb2nK3a8Imv6kdFUedgbygchXf
	 3roRIYDXcolKm/0suRkGFbovDLo2YPG3cXtsahz8=
X-QQ-mid: bizesmtpip2t1744177754t495023
X-QQ-Originating-IP: NJrZWzX3gJ3bglMTTKScLHPwZWFagL49sVxok/gbMWw=
Received: from smtpclient.apple ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 09 Apr 2025 13:49:12 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13489796943961601644
EX-QQ-RecipientCnt: 4
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: [PATCH] loop: move vfs_fsync() out of loop_update_dio()
From: =?utf-8?B?6IOh54Sc?= <huk23@m.fudan.edu.cn>
In-Reply-To: <Z9jHP7lFB5jVZELN@fedora>
Date: Wed, 9 Apr 2025 13:49:02 +0800
Cc: linux-block <linux-block@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 "jjtan24@m.fudan.edu.cn" <jjtan24@m.fudan.edu.cn>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F07A9B3D-208D-44E2-83D8-FC2956055F15@m.fudan.edu.cn>
References: <20250113120644.811886-1-ming.lei@redhat.com>
 <tencent_569A521D2FECE6C55D795124@qq.com> <Z9jHP7lFB5jVZELN@fedora>
To: Ming Lei <ming.lei@redhat.com>
X-Mailer: Apple Mail (2.3818.100.11.1.3)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:m.fudan.edu.cn:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: Od0VoHQHM0gioqBw8nD+TmevGOYnw0m9GNFrCWMkx4nZ2OgeHQQv/jSf
	nYgFtmrSZM9KAGtaiElEp/f7d5VL8L5h+42GB+0oN06TMXAGtykGwFRaKrGJm8bBzlmEEwk
	qXPvddVrsOxULR3+GzpV+mCanU4dLoTNJsJyJKfP37ICXgnrsMysEpZ0kNO8JpbfEGNLmNy
	NfgaYeCTJofVCC54vfN/lKqqKOwOP2jO62WJBxwza6NsqnJCrCA9LjChf4eGL1vxe5XF9U/
	yrfMLDLaasQfXA2ejujoWom5PZnkUGSp5ihs9D6UZ6Ruz/ghRkxeWBJmo8NZiLKVZ4FnO6o
	j7SH53EII78g2/+s+QxhylsaBYEgSskb0joS7XjztvJBe3nRsmZwG5fqLu2SFJ7smlaI1KD
	qfFeXd8vFA8ohKSLZMHTKetp9tFjIu3ryDU31OwrmlgsM4G2l8PiB3eCSOKU9DYFHvf38rB
	QA6oMT1MsO5V1RK2JR0j1o2sFe2OOnsJgZTYCLO8m5YmODbdKoX439cjzCt0R8hmU8bEx75
	0uqo8PDZrU0OzatJ7g2v9x7t6h+rAmOCvRVNpAd2qXdBBIM2l+vfnxPvo4jtmg+wTqK7hw0
	fOZXJNgxJR7SOcUHTH6kB8P3nVFG07sIKIV7nTN411ITKrjDxWHz01MyZHG8X8y3TNO1IRV
	8j6JU/1yrEdkWP3Lov6ozhVE2pf4nONheLpLJD7pH+rhovAxxv49EDIhGXKOXHTaW+q2zMN
	BHrh+F+AYmWj5BZfVQIzrZIRinROs/FdfYZ7l6SFtYOuMDWKFsKhLpJLRw7xI0nAl2GL4Fu
	LjdC1fUfWE19QQ/wb5ZFqWtLgpKxz3mypxx/NSIt0FgfVsIcigYxkKILjAb4sJ055o7cW0q
	qwulUqU6bS0Eb1hTysP8Vz7fqlKXzt8srWthWRXi6oPwv6guYQshpHp7wis40dirAU3WzHi
	zu9Alx4mEwINJEA==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0



> 2025=E5=B9=B43=E6=9C=8818=E6=97=A5 09:07=EF=BC=8CMing Lei =
<ming.lei@redhat.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Mon, Mar 17, 2025 at 04:52:16PM +0800, =E8=83=A1=E7=84=9C wrote:
>>> drivers/block/loop.c | 12 ++++++------
>>> 1 file changed, 6 insertions(+), 6 deletions(-)
>>=20
>>> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
>>> index 1ec7417c7f00..be7e20064427 100644
>>> --- a/drivers/block/loop.c
>>> +++ b/drivers/block/loop.c
>>> @@ -205,8 +205,6 @@ static bool lo_can_use_dio(struct loop_device =
*lo)
>>> */
>>> static inline void loop_update_dio(struct loop_device *lo)
>>> {
>>> - bool dio_in_use =3D lo->lo_flags & LO_FLAGS_DIRECT_IO;
>>> -
>>>  lockdep_assert_held(&lo->lo_mutex);
>>>  WARN_ON_ONCE(lo->lo_state =3D=3D Lo_bound &&
>>>       lo->lo_queue->mq_freeze_depth =3D=3D 0);
>>> @@ -215,10 +213,6 @@ static inline void loop_update_dio(struct =
loop_device *lo)
>>>  lo->lo_flags |=3D LO_FLAGS_DIRECT_IO;
>>>  if ((lo->lo_flags & LO_FLAGS_DIRECT_IO) && !lo_can_use_dio(lo))
>>>  lo->lo_flags &=3D ~LO_FLAGS_DIRECT_IO;
>>> -
>>> - /* flush dirty pages before starting to issue direct I/O */
>>> - if ((lo->lo_flags & LO_FLAGS_DIRECT_IO) && !dio_in_use)
>>> - vfs_fsync(lo->lo_backing_file, 0);
>>> }
>>>=20
>>> /**
>>> @@ -621,6 +615,9 @@ static int loop_change_fd(struct loop_device =
*lo, struct block_device *bdev,
>>>  if (get_loop_size(lo, file) !=3D get_loop_size(lo, old_file))
>>> goto out_err;
>>=20
>>> + /* may work in dio, so flush page cache for avoiding race */
>>> + vfs_fsync(file, 0);
>>> +
>>>  /* and ... switch */
>>>  disk_force_media_change(lo->lo_disk);
>>>  blk_mq_freeze_queue(lo->lo_queue);
>>> @@ -1098,6 +1095,9 @@ static int loop_configure(struct loop_device =
*lo, blk_mode_t mode,
>>>  if (error)
>>>  goto out_unlock;
>>=20
>>> + /* may work in dio, so flush page cache for avoiding race */
>>> + vfs_fsync(file, 0);
>>> +
>>>  loop_update_dio(lo);
>>>  loop_sysfs_init(lo);
>>>=20
>>> --
>>> 2.44.0
>>=20
>>=20
>> Hello Ming,
>>=20
>> I would like to double check that this fix doesn't seem to have been =
merged into the main thread, will this version still be merged into =
mainline kernel tree?
>=20
> The V2 has been sent out after updating comment, please verify if it =
fixes your issue:
>=20
> =
https://lore.kernel.org/linux-block/20250318010318.3861682-1-ming.lei@redh=
at.com/
>=20
> If yes, feel free to provide one tested-by for moving on.
>=20
>=20
> Thanks,=20
> Ming


Hi Ming,

I have tested the V2 patch you sent, and it has successfully fixed the =
issue. Thank you for the update!

Tested-by: Kun Hu <huk23@m.fudan.edu.cn>, Jiaji Qin =
<jjtan24@m.fudan.edu.cn>.


=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94
Thanks,
Kun

