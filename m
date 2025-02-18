Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6425917333F
	for <linux-block@vger.kernel.org>; Tue, 18 Feb 2025 05:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739857182; cv=none; b=PpveA4xH3/tC8uswSnHXrBcOwNnSjHB7T+Tpn83qO3TyJMOuxdSh8m6vjD3+xfiOuj/LBl08wB3fDwyIY0T6Wro4ehbMNacSKMcaLwNoVqMFwkqHAg0szCeI50Z2KQdaAYgWepG7qVMIJnrEJP5vcEDbYT4/SJFLSiO2nWiJsXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739857182; c=relaxed/simple;
	bh=vRRjgSWKjOydcIHFw8j60aAcR6D03EOap7Smlhm/P0g=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=cZPx0ap0CPsaI1BPU/8/WkDYrN7hOnGIwzah2EWeM+hpWWrgKentK/iHOcAeIvsGveJSuJ9lzPOjhZjKZoEuoK69WPc+VF5xi4kOPQCTYi9MbTbBm11RZviELtCzj4E6rJqv6qmLEpaA5ORyH06UxvkVXWMdG10bOyIPgb8slIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn; spf=pass smtp.mailfrom=m.fudan.edu.cn; dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b=t8GCAd3z; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.fudan.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b="t8GCAd3z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=m.fudan.edu.cn;
	s=sorc2401; t=1739857167;
	bh=fbLJfUGU9JXb1yuchMtJfvOmanfA1NOlIy+nWkSIRV0=;
	h=Mime-Version:Subject:From:Date:Message-Id:To;
	b=t8GCAd3zGF0+iVixbk5BAuNTsNRDiUZd7HZ9OeI9Tii5Znk3sHVZR7PIUScqKLEBJ
	 ZyeWrm9ODEyAc8xrC+/O+1EwDFM5F72ZeaWmPTkjaHEHb3PAJ+RpI21rjUUSQ9vjXB
	 hvXRkixwQDJE1aCx7EPcrQ4LTLxx8ib92S8OAp/4=
X-QQ-mid: bizesmtpip2t1739857163t0sr30a
X-QQ-Originating-IP: 2KpfU6kzRLAgPw019R7+o5gplrV1cb73pVEGliCoZqU=
Received: from smtpclient.apple ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 18 Feb 2025 13:39:22 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12496570759982188897
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: [PATCH] loop: don't call vfs_flush() with queue frozen
From: Kun Hu <huk23@m.fudan.edu.cn>
In-Reply-To: <7D60046B-4E85-4EAA-A864-C7897539524A@m.fudan.edu.cn>
Date: Tue, 18 Feb 2025 13:39:12 +0800
Cc: Ming Lei <ming.lei@redhat.com>,
 linux-block@vger.kernel.org,
 "jjtan24@m.fudan.edu.cn" <jjtan24@m.fudan.edu.cn>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5F0D9626-55E4-4A42-8776-D7793AA86856@m.fudan.edu.cn>
References: <20250113022426.703537-1-ming.lei@redhat.com>
 <7D60046B-4E85-4EAA-A864-C7897539524A@m.fudan.edu.cn>
To: Kun Hu <huk23@m.fudan.edu.cn>
X-Mailer: Apple Mail (2.3818.100.11.1.3)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:m.fudan.edu.cn:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: N9NPDBT3mqrZ0DJzJrjU0ItqH1eGu/ADhRRNgz6GyHsdLNDzgb67/HJ4
	HlqHcX4ZUrwNIyxQ4t/LcA0Jcv/VWYF7S21pMZ1MXl/YADwbfIaFe4/LVvLHpoUgrq4XcRL
	ly3leU21ZYWnV7LjvSJHVQMERogGu4Ofs+nU1asBQWRVF4sCPlzfhlOZALH9SPDgszH714c
	MVp4JexKVfHz41NLHJ7+ddHJkomz9RHszERqQj1j7e3/4Z1yhy2StVDKA0kJ9m/I60WYaKo
	Fytqp6+5iwTFmWX+llixojUe0Al13RzfkUjk5jdCIjL9GLFJBCj7J6I6eCgM4U9+5pOjOY4
	rJnagFEWrIdYtqhmPhLU23XAiIwJMB1deWw9TA54GcGnCkXLHnXZ/zpbObHV/nIlbVBeqAO
	LmDIdFZc69wtpR+dLKPliQ0PzGSKDEJA9SqheWqMESMiqFGYz0HRHh278apKezGK9qCZStt
	kdeL8DE4/fyoYPH5xVyacWTvMYEqIEbaprYiBenoyKgY2MLv/3ip3Xej/utF0JcTdScqKnX
	KsPI0NKynrHjpUJFjoPkE0IJ40RR23h9snj0hQtzPRLlQSGr2l6/yZfe9bbkOf496dSOUCR
	rv61MfQ7Z/HgtW7BccXM13snfJ2VKGt0ui2BDNixzmQ9JTiIkbzz4I8+DOesRj/ByHy3h4C
	pZ0T3NwG6CnDVpBIutNK+RCgFqDLjH0VVFZ+d1eQv6yuK+7mEoEZoQK93A/I3fC65JGwOJG
	q2lDFCWZs7M+5ElvsyoMNMk/ejZfhnl7xbjfU+lZvjq2q6U3TuDQGeIyN8QLOX2nHdBQgad
	ZRsgnBDN3xTGVGsdrZftYD8qR4v+OvBbGMNASrMt8Y1u7VxNEeXa44xfQ87TrrkzUs3u9x/
	xnFY7hAoyFdGJ+ovlBy77JKWbWCXwHfbrDWQVHBA4i8iA6o1QleLieaerUqbKh2n9mIhRFv
	S+P1EQSHC8IUmDHoCVTp2jze0K7Zz7/R1b0Qe90GP6hIABMFCBUeKahd9
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0



> 2025=E5=B9=B41=E6=9C=8814=E6=97=A5 11:21=EF=BC=8CKun Hu =
<huk23@m.fudan.edu.cn> =E5=86=99=E9=81=93=EF=BC=9A
>=20
>> If vfs_flush() is called with queue frozen, the queue freeze lock may =
be
>> connected with FS internal lock, and potential deadlock could be
>> triggered.
>>=20
>> Fix it by moving vfs_flush() out of queue freezing.
>>=20
>> Reported-by: Kun Hu <huk23@m.fudan.edu.cn>
>> Reported-by: Jiaji Qin <jjtan24@m.fudan.edu.cn>
>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>> ---
>> drivers/block/loop.c | 21 +++++++++++++++------
>> 1 file changed, 15 insertions(+), 6 deletions(-)
>>=20
>> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
>> index 1ec7417c7f00..9adf496b3f93 100644
>> --- a/drivers/block/loop.c
>> +++ b/drivers/block/loop.c
>> @@ -203,7 +203,7 @@ static bool lo_can_use_dio(struct loop_device =
*lo)
>> * loop_get_status will always report the effective LO_FLAGS_DIRECT_IO =
flag and
>> * not the originally passed in one.
>> */
>> -static inline void loop_update_dio(struct loop_device *lo)
>> +static inline bool loop_update_dio(struct loop_device *lo)
>> {
>> bool dio_in_use =3D lo->lo_flags & LO_FLAGS_DIRECT_IO;
>>=20
>> @@ -217,8 +217,7 @@ static inline void loop_update_dio(struct =
loop_device *lo)
>> lo->lo_flags &=3D ~LO_FLAGS_DIRECT_IO;
>>=20
>> /* flush dirty pages before starting to issue direct I/O */
>> - if ((lo->lo_flags & LO_FLAGS_DIRECT_IO) && !dio_in_use)
>> - vfs_fsync(lo->lo_backing_file, 0);
>> + return (lo->lo_flags & LO_FLAGS_DIRECT_IO) && !dio_in_use;
>> }
>>=20
>> /**
>> @@ -589,6 +588,7 @@ static int loop_change_fd(struct loop_device *lo, =
struct block_device *bdev,
>> int error;
>> bool partscan;
>> bool is_loop;
>> + bool flush;
>>=20
>> if (!file)
>> return -EBADF;
>> @@ -629,11 +629,14 @@ static int loop_change_fd(struct loop_device =
*lo, struct block_device *bdev,
>> lo->old_gfp_mask =3D mapping_gfp_mask(file->f_mapping);
>> mapping_set_gfp_mask(file->f_mapping,
>>    lo->old_gfp_mask & ~(__GFP_IO|__GFP_FS));
>> - loop_update_dio(lo);
>> + flush =3D loop_update_dio(lo);
>> blk_mq_unfreeze_queue(lo->lo_queue);
>> partscan =3D lo->lo_flags & LO_FLAGS_PARTSCAN;
>> loop_global_unlock(lo, is_loop);
>>=20
>> + if (flush)
>> + vfs_fsync(lo->lo_backing_file, 0);
>> +
>> /*
>> * Flush loop_validate_file() before fput(), for l->lo_backing_file
>> * might be pointing at old_file which might be the last reference.
>> @@ -1255,6 +1258,7 @@ loop_set_status(struct loop_device *lo, const =
struct loop_info64 *info)
>> int err;
>> bool partscan =3D false;
>> bool size_changed =3D false;
>> + bool flush =3D false;
>>=20
>> err =3D mutex_lock_killable(&lo->lo_mutex);
>> if (err)
>> @@ -1292,7 +1296,7 @@ loop_set_status(struct loop_device *lo, const =
struct loop_info64 *info)
>> }
>>=20
>> /* update the direct I/O flag if lo_offset changed */
>> - loop_update_dio(lo);
>> + flush =3D loop_update_dio(lo);
>>=20
>> out_unfreeze:
>> blk_mq_unfreeze_queue(lo->lo_queue);
>> @@ -1302,6 +1306,8 @@ loop_set_status(struct loop_device *lo, const =
struct loop_info64 *info)
>> mutex_unlock(&lo->lo_mutex);
>> if (partscan)
>> loop_reread_partitions(lo);
>> + if (flush)
>> + vfs_fsync(lo->lo_backing_file, 0);
>>=20
>> return err;
>> }
>> @@ -1473,6 +1479,7 @@ static int loop_set_block_size(struct =
loop_device *lo, unsigned long arg)
>> {
>> struct queue_limits lim;
>> int err =3D 0;
>> + bool flush;
>>=20
>> if (lo->lo_state !=3D Lo_bound)
>> return -ENXIO;
>> @@ -1488,8 +1495,10 @@ static int loop_set_block_size(struct =
loop_device *lo, unsigned long arg)
>>=20
>> blk_mq_freeze_queue(lo->lo_queue);
>> err =3D queue_limits_commit_update(lo->lo_queue, &lim);
>> - loop_update_dio(lo);
>> + flush =3D loop_update_dio(lo);
>> blk_mq_unfreeze_queue(lo->lo_queue);
>> + if (flush)
>> + vfs_fsync(lo->lo_backing_file, 0);
>>=20
>> return err;
>> }
>> --=20
>> 2.44.0
>>=20


Hi Ming,

I wanted to follow up as I haven=E2=80=99t yet seen the fix you =
provided, titled =E2=80=9C[PATCH] loop: don't call vfs_flush() with =
queue frozen=E2=80=9D and =E2=80=9C[PATCH] loop: move vfs_fsync() out of =
loop_update_dio()"  in the kernel tree. Could you kindly confirm if this =
resolves the issue we=E2=80=99ve been discussing? Additionally, I would =
greatly appreciate it if you could share any updates regarding the =
resolution of this matter.

