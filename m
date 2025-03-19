Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1890122A7E2
	for <linux-block@vger.kernel.org>; Wed, 19 Mar 2025 01:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742347891; cv=none; b=nMM8q5iU9zHqpCwqTsQrjMMUYwBvcPcKAS+lxfjG0ZWVb8Ak5CPMIpbdEHbZ61uS0pwzzIA20oT/mEyZ/asuGaT1VHwHflAcvgeJWLekwAMYAEpwqCsQlBPB3brRE+lcEqM/6FAmllUGbNxL3yMBvRQ5P4uQM+CXlu6DafkpnTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742347891; c=relaxed/simple;
	bh=DHZelnR7wnUwmRR1ABhpcZ9smZSWcd8V7v2jlbkpDko=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:References:Cc:
	 Date; b=XGtN9pUUp/vHNVv3ejBVyidwhjAAaTRiSiPRQ4vkt6oo5VbPehxH7lHFNQP7OI9GgsC0qJST7zdFiUtOLHis/a5yzs1QXRGSCCwqI1M5SdUWP5chZkiDU3gaEkqbbZGf+brecIAuH0aaQHPJhDK8G4uIBW9LJWuPICLOYsVWJ1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn; spf=pass smtp.mailfrom=m.fudan.edu.cn; dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b=GqM2iNlJ; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.fudan.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b="GqM2iNlJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=m.fudan.edu.cn;
	s=sorc2401; t=1742347880;
	bh=NkTd0y2TVD+MQ9DfV75ZnmdKqLG5Z0oBv4TCv0CWq2U=;
	h=From:Mime-Version:Subject:Message-Id:Date;
	b=GqM2iNlJJrNJ1vX9Un1ONYzt8DCEzau5HvCzBp5NlU/GbKC60oq4Mx4T7Rs96LIyE
	 XbT64Vu2NXNUplSuB1seV+AeTmC8JxaU9A/XcaHrMvHUSX6nf5Uev0dbOQ/m3bKkNu
	 9oWBy2SdmAhakt5+UM2gg1fU3/s1GCtsb1l7FZKU=
X-QQ-mid: bizesmtp91t1742347877tws8wsmz
X-QQ-Originating-IP: 58QYHAoG97RdgEXkUC0TtGdSEdDLI/4ru+S4XKpl5Ao=
Received: from smtpclient.apple ( [202.120.235.103])
	by bizesmtp.qq.com (ESMTP) with SMTP id 0
	for <linux-block@vger.kernel.org>; Wed, 19 Mar 2025 09:31:15 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5735509248963139012
From: Kun Hu <huk23@m.fudan.edu.cn>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Fwd: HTML message rejected: Re: [PATCH] loop: move vfs_fsync() out of
 loop_update_dio()
Message-Id: <A525902F-B87C-45FD-92CB-5D7D5B9FE519@m.fudan.edu.cn>
References: <1742347764-26432-mlmmj-3c0aa216@vger.kernel.org>
Cc: linux-block <linux-block@vger.kernel.org>
Date: Wed, 19 Mar 2025 09:31:05 +0800
X-Mailer: Apple Mail (2.3818.100.11.1.3)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:m.fudan.edu.cn:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OGZxhFXqN7PJvb8rNV3Q7zpGPGDRpEaiSyxYYCE3woy6SWwU1QgbGkGq
	xtrQpJm2UVmoFnkf4WsxsTJmxY76xCcDsBf1/BEYOHNOFmNg41wQ8DNIsXpgfdPVGUSsIj7
	RYQQaRMQfwd3xhgUdQb/9qrxbKY2oeayzCgu7MbtRQHAbU1zSZgj5WS9AZ2Ef6HIwfis5LC
	hip2XReK4n+cm1kFUEqaZPCCdpVe+zGwC+VKuAbfDvniNUBk7mMHe15LfEOSrEjOCddN2Yu
	+cUzZCzor0VCBWk8/1rATpITaSPsb77IvJC6SrnnzAu7PXkDI+N8BX/q1lkgGkpq14juq11
	nW1vKIjPCJIxyXEbBvmt7A+C2rNpVCX/VCCs/CM+F6IlFgIzf7JZv6sGdzc6PbATc3LOEXw
	AGxHH06tOi6ARx54dfBjEFbuJ5oU3MSC8X9SPIUFuCqzS/NOg6iFYsLAzE2NCwZlXV/Cy9Q
	lhi+k4w/aG7WsSsxSDU9G5FSh38Hgwk2Bm+ZVRGyXd6HnFV/Qs0fDS4+HADxVpsmMUtXkoe
	SK4H5k0jIDYEOJYYkyQQAO99giKd4uUfdGm3kkLPlmOMLQhwuJ/UFI9YcJniWtYlpxivPA1
	Ili7rEXVETh0uD0pUph17QZEA3GVEhKbCT45duS2AXBvZ+lYT8bxl/F9MRBgFJbTtP/fnSi
	2gZjnE310NMaxR+FZ/lTKfd1GteZM01CMAnxvLmTADOwXlGa19XMyJoMHEUq7YSGOfUdluE
	EB6kXTDt15nPqfxLCi9Ko7ezyKVTDCJL9Lq1vmU6Ga5PBVFq6y2ppTA7hF5O/L8eSqIUv4y
	jhCb9htL5cbvdSWDp2c07a3hCWBpeQ7KX9smIj2nCcw1lqsQjwqIo7rnAfQVuZLs4uEIoiH
	KI0ViX2meF20JzMt8msIbuzSd9lD1NlN2nPrv++NI25LoxwxaN85vePLUGdek1b3ahYAQtb
	mt4oSzM0j1VCpEO3YLv93sAcxPgTXYD+3SWwJwpvricZgeveEYpGHtIWwx6w/nqI8qjfZiO
	NPGSx6oA==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0



> =E4=B8=8B=E9=9D=A2=E6=98=AF=E8=A2=AB=E8=BD=AC=E5=8F=91=E7=9A=84=E9=82=AE=
=E4=BB=B6=EF=BC=9A
>=20
> =E5=8F=91=E4=BB=B6=E4=BA=BA: linux-block+owner@vger.kernel.org
> =E4=B8=BB=E9=A2=98: HTML message rejected: Re: [PATCH] loop: move =
vfs_fsync() out of loop_update_dio()
> =E6=97=A5=E6=9C=9F: 2025=E5=B9=B43=E6=9C=8819=E6=97=A5 GMT+8 09:29:24
> =E6=94=B6=E4=BB=B6=E4=BA=BA: huk23@m.fudan.edu.cn
>=20
> Greetings!
>=20
> This is the mlmmj program managing the <linux-block@vger.kernel.org>
> mailing list.
>=20
> Your message to <linux-block@vger.kernel.org> was not delivered to the =
list
> because it contained a HTML part. Only text/plain messages are allowed =
on
> this list.
>=20
> Please configure your mail client to only send plain text mail.
>=20
> For your reference, the rejected message follows below.
>=20
> =E5=8F=91=E4=BB=B6=E4=BA=BA: Kun Hu <huk23@m.fudan.edu.cn>
> =E4=B8=BB=E9=A2=98: =E5=9B=9E=E5=A4=8D=EF=BC=9A[PATCH] loop: move =
vfs_fsync() out of loop_update_dio()
> =E6=97=A5=E6=9C=9F: 2025=E5=B9=B43=E6=9C=8819=E6=97=A5 GMT+8 09:28:24
> =E6=94=B6=E4=BB=B6=E4=BA=BA: Ming Lei <ming.lei@redhat.com>
> =E6=8A=84=E9=80=81: linux-block <linux-block@vger.kernel.org>, =
Christoph Hellwig <hch@infradead.org>, "jjtan24@m.fudan.edu.cn" =
<jjtan24@m.fudan.edu.cn>
>=20
>=20
>=20
>=20
>> 2025=E5=B9=B43=E6=9C=8818=E6=97=A5 09:07=EF=BC=8CMing Lei =
<ming.lei@redhat.com> =E5=86=99=E9=81=93=EF=BC=9A
>>=20
>> On Mon, Mar 17, 2025 at 04:52:16PM +0800, =E8=83=A1=E7=84=9C wrote:
>>>> drivers/block/loop.c | 12 ++++++------
>>>> 1 file changed, 6 insertions(+), 6 deletions(-)
>>>=20
>>>> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
>>>> index 1ec7417c7f00..be7e20064427 100644
>>>> --- a/drivers/block/loop.c
>>>> +++ b/drivers/block/loop.c
>>>> @@ -205,8 +205,6 @@ static bool lo_can_use_dio(struct loop_device =
*lo)
>>>> */
>>>> static inline void loop_update_dio(struct loop_device *lo)
>>>> {
>>>> - bool dio_in_use =3D lo->lo_flags & LO_FLAGS_DIRECT_IO;
>>>> -
>>>>  lockdep_assert_held(&lo->lo_mutex);
>>>>  WARN_ON_ONCE(lo->lo_state =3D=3D Lo_bound &&
>>>>       lo->lo_queue->mq_freeze_depth =3D=3D 0);
>>>> @@ -215,10 +213,6 @@ static inline void loop_update_dio(struct =
loop_device *lo)
>>>>  lo->lo_flags |=3D LO_FLAGS_DIRECT_IO;
>>>>  if ((lo->lo_flags & LO_FLAGS_DIRECT_IO) && !lo_can_use_dio(lo))
>>>>  lo->lo_flags &=3D ~LO_FLAGS_DIRECT_IO;
>>>> -
>>>> - /* flush dirty pages before starting to issue direct I/O */
>>>> - if ((lo->lo_flags & LO_FLAGS_DIRECT_IO) && !dio_in_use)
>>>> - vfs_fsync(lo->lo_backing_file, 0);
>>>> }
>>>>=20
>>>> /**
>>>> @@ -621,6 +615,9 @@ static int loop_change_fd(struct loop_device =
*lo, struct block_device *bdev,
>>>>  if (get_loop_size(lo, file) !=3D get_loop_size(lo, old_file))
>>>> goto out_err;
>>>=20
>>>> + /* may work in dio, so flush page cache for avoiding race */
>>>> + vfs_fsync(file, 0);
>>>> +
>>>>  /* and ... switch */
>>>>  disk_force_media_change(lo->lo_disk);
>>>>  blk_mq_freeze_queue(lo->lo_queue);
>>>> @@ -1098,6 +1095,9 @@ static int loop_configure(struct loop_device =
*lo, blk_mode_t mode,
>>>>  if (error)
>>>>  goto out_unlock;
>>>=20
>>>> + /* may work in dio, so flush page cache for avoiding race */
>>>> + vfs_fsync(file, 0);
>>>> +
>>>>  loop_update_dio(lo);
>>>>  loop_sysfs_init(lo);
>>>>=20
>>>> --
>>>> 2.44.0
>>>=20
>>>=20
>>> Hello Ming,
>>>=20
>>> I would like to double check that this fix doesn't seem to have been =
merged into the main thread, will this version still be merged into =
mainline kernel tree?
>>=20
>> The V2 has been sent out after updating comment, please verify if it =
fixes your issue:
>>=20
>> =
https://lore.kernel.org/linux-block/20250318010318.3861682-1-ming.lei@redh=
at.com/
>>=20
>> If yes, feel free to provide one tested-by for moving on.
>>=20
>>=20
>> Thanks,=20
>> Ming
>=20
>=20
>=20
> Thank you very much, this crash has not triggered again after several =
rounds of testing!
>=20
> Best,
> Kun
>=20

