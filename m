Received: from mail98.out.titan.email (mail98.out.titan.email [54.147.227.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62760185935
	for <linux-block@vger.kernel.org>; Mon, 10 Mar 2025 14:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.147.227.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741616907; cv=none; b=rZPNKaqTF3APlUC/ysoVsCp+TT5MvTb4wPu8itrP11/MTx9fyab1fdqWJtgd1b5aHHJLdd/oHeHbM+J0FKm9WyN9bo2wCRBhIZngyfNlllKuMZlAezlRGkZTGb4qFwOjgqmJJyuVKTeaKf3O4oF3cvNYyot4kpWr+YZ7TGvKOl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741616907; c=relaxed/simple;
	bh=7+qQRUhv7b4kq271X5sv0B8yzkRLD28nvzLqDZA78EY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=GJFL0KyN4NC925j2cGiMArxlxw7WPBqo7j6MKKP2c3cu1EqpyOIBgRwknWT9YbRfZU+kGkRP7BxVOzrJlUyJ9ujoWXceAjjlt+s/vsgvxTyoACOF9emReBgYnhZv6QOgTQ7RV+aIu5TTSf3SnbwIaaasjbB+1jPBOuffr+87SMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=coly.li; spf=pass smtp.mailfrom=coly.li; dkim=pass (1024-bit key) header.d=t12smtp-sign004.email header.i=@t12smtp-sign004.email header.b=STtSyI30; arc=none smtp.client-ip=54.147.227.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=coly.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coly.li
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t12smtp-sign004.email header.i=@t12smtp-sign004.email header.b="STtSyI30"
Received: from smtp-out.flockmail.com (localhost [127.0.0.1])
	by smtp-out.flockmail.com (Postfix) with ESMTP id D9BCD1403AA;
	Mon, 10 Mar 2025 13:51:09 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=7+qQRUhv7b4kq271X5sv0B8yzkRLD28nvzLqDZA78EY=;
	c=relaxed/relaxed; d=t12smtp-sign004.email;
	h=date:in-reply-to:cc:message-id:from:references:subject:to:mime-version:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
	q=dns/txt; s=titan1; t=1741614669; v=1;
	b=STtSyI30nmMr0AIroRYTb9Z9jXN5Gk8tLjxOqYd0nBQgGe3kUtHOuDuyF/XcZJmYYDA97cwi
	ogRTcm/iH1BdfEbbTBj6wE5Cr/x+zoDO71vfL0s1qre9SLLPhfCsisYAHDGCcBqSggeEtAArwN3
	FgFfpSs8pDB/XgAlDISj2Np8=
Received: from smtpclient.apple (v133-18-178-219.vir.kagoya.net [133.18.178.219])
	by smtp-out.flockmail.com (Postfix) with ESMTPA id 8662D140471;
	Mon, 10 Mar 2025 13:51:08 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH] badblocks: Fix a nonsense WARN_ON() which checks whether
 a u64 variable < 0
Feedback-ID: :i@coly.li:coly.li:flockmailId
From: Coly Li <i@coly.li>
In-Reply-To: <a254a3b0-1913-45e3-aaf0-97486d4c4cbf@kernel.dk>
Date: Mon, 10 Mar 2025 21:50:56 +0800
Cc: linux-block@vger.kernel.org,
 Dan Carpenter <dan.carpenter@linaro.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <21AB5A4E-9A90-44A4-933B-D8014C7FFA5E@coly.li>
References: <20250309160556.42854-1-colyli@kernel.org>
 <18D3673D-575E-4002-B5A8-FEE56A732EDC@coly.li>
 <de3a5313-b0b5-432f-ace2-f6859eeb4436@kernel.dk>
 <DB1BA32F-C77C-4606-A886-B519ADC3FCB5@coly.li>
 <a254a3b0-1913-45e3-aaf0-97486d4c4cbf@kernel.dk>
To: Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3826.400.131.1.6)
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1741614669745126386.32605.5668741791299078627@prod-use1-smtp-out1003.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=I9+fRMgg c=1 sm=1 tr=0 ts=67ceee4d
	a=6yy/x1GoN29p2+/2k52XZQ==:117 a=6yy/x1GoN29p2+/2k52XZQ==:17
	a=IkcTkHD0fZMA:10 a=CEWIc4RMnpUA:10 a=4VLkNouyPJADuaSus2gA:9
	a=QEXdDO2ut3YA:10
X-Virus-Scanned: ClamAV using ClamSMTP



> 2025=E5=B9=B43=E6=9C=8810=E6=97=A5 21:49=EF=BC=8CJens Axboe =
<axboe@kernel.dk> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On 3/10/25 7:44 AM, Coly Li wrote:
>>=20
>>=20
>>> 2025?3?10? 21:42?Jens Axboe <axboe@kernel.dk> ???
>>>=20
>>> On 3/9/25 10:12 AM, Coly Li wrote:
>>>> Hi Jens,
>>>>=20
>>>> Could you please take a look at it and pick this patch into the =
for-6.15/block branch? The patch is generated based on the =
for-6.15/block branch.
>>>=20
>>> Just a heads-up - you don't need to send these emails outside of
>>> just sending the patch, I do get the patches. If I didn't, then =
that'd
>>> be a problem. If you feel patches need extra context, then just do a
>>> cover letter for them.
>>=20
>> So if you are the receiver of the patch email, then I don?t need to
>> worry that you will treat it as a normal patch for review. Can I take
>> this as a rule?
>=20
> Yes of course - I don't think I've ever seen anyone else send out a
> patch with a followup a few minutes later to apply it. Just send out =
the
> patch, and it should get applied. If it doesn't after a week or
> whatever, then feel free to send a reminder. But a reminder to apply =
it
> a few min after the original patch is a bit unusual and odd.

Copied. So normally I will not send a following email to explain the =
extra information. If it is necessary, I will compose a cover letter.

Thanks for the notice.

Coly Li=
