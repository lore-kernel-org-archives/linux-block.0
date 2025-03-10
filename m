Received: from mail86.out.titan.email (mail86.out.titan.email [209.209.25.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FCC1D79BE
	for <linux-block@vger.kernel.org>; Mon, 10 Mar 2025 14:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.209.25.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741615258; cv=none; b=mF9NdCP5P4SHlC2IpUv3LN475gjajryJDhHN4SUU39AtK7sSVigC/2pGQoubqsjwMo+NhB0Q+k2plRqOtiOn5RoUSeBHk/GnBICl+Ep3ej7fSb/HgML+R8W+rxuuATLXfSppXya6ai8WvqTK2mST48kM2008de1V5xKIBJcdhEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741615258; c=relaxed/simple;
	bh=o3jo8Yp6GBl1EzB187l+mO+RUd+WDfgcPP/VmFEaNZQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=kt8bovE3Eak+YQB+eceO+1kUdspx8RW6MXrtDPBpyP4JNIXJk275HZnPIKrZCx6vn84kLpvCk8KCPkacH/2p0oeWzukJGQddnCVQVIDpnce6YoLXsmaQdMJlCyMlU548yip7R5REoSh1rjArHg7Xuq/OSi7vB3PM/BaoC9a74OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=coly.li; spf=pass smtp.mailfrom=coly.li; dkim=pass (1024-bit key) header.d=t12smtp-sign004.email header.i=@t12smtp-sign004.email header.b=gpTfGvb8; arc=none smtp.client-ip=209.209.25.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=coly.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coly.li
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t12smtp-sign004.email header.i=@t12smtp-sign004.email header.b="gpTfGvb8"
DKIM-Signature: a=rsa-sha256; bh=o3jo8Yp6GBl1EzB187l+mO+RUd+WDfgcPP/VmFEaNZQ=;
	c=relaxed/relaxed; d=t12smtp-sign004.email;
	h=mime-version:date:references:to:subject:from:in-reply-to:cc:message-id:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
	q=dns/txt; s=titan1; t=1741614317; v=1;
	b=gpTfGvb8e/wHWyCIe6OuqWrYd3zTM6cZgGpZSnY4ENXCOa8gHLJhb1YlnmERxzlY/zRiyU14
	fX8ovwJm2+EiFVFnJwA3N96mw6l953h1EpoHbq8uNEptEKZVe3cLXH05xoFxD9eQXanXfrtKZq8
	PevqyG1OcMqQAJ5xJzsfihyA=
Received: from smtpclient.apple (v133-18-178-219.vir.kagoya.net [133.18.178.219])
	by smtp-out.flockmail.com (Postfix) with ESMTPA id 9BACB1004A4;
	Mon, 10 Mar 2025 13:45:14 +0000 (UTC)
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
In-Reply-To: <de3a5313-b0b5-432f-ace2-f6859eeb4436@kernel.dk>
Date: Mon, 10 Mar 2025 21:44:59 +0800
Cc: linux-block@vger.kernel.org,
 Dan Carpenter <dan.carpenter@linaro.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <DB1BA32F-C77C-4606-A886-B519ADC3FCB5@coly.li>
References: <20250309160556.42854-1-colyli@kernel.org>
 <18D3673D-575E-4002-B5A8-FEE56A732EDC@coly.li>
 <de3a5313-b0b5-432f-ace2-f6859eeb4436@kernel.dk>
To: Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3826.400.131.1.6)
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1741614317168885566.29396.279708926236796156@prod-use1-smtp-out1002.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=IeV9WXqa c=1 sm=1 tr=0 ts=67ceeced
	a=6yy/x1GoN29p2+/2k52XZQ==:117 a=6yy/x1GoN29p2+/2k52XZQ==:17
	a=IkcTkHD0fZMA:10 a=CEWIc4RMnpUA:10 a=i1v2BhhCwKSZKKg_S70A:9
	a=QEXdDO2ut3YA:10



> 2025=E5=B9=B43=E6=9C=8810=E6=97=A5 21:42=EF=BC=8CJens Axboe =
<axboe@kernel.dk> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On 3/9/25 10:12 AM, Coly Li wrote:
>> Hi Jens,
>>=20
>> Could you please take a look at it and pick this patch into the =
for-6.15/block branch? The patch is generated based on the =
for-6.15/block branch.
>=20
> Just a heads-up - you don't need to send these emails outside of
> just sending the patch, I do get the patches. If I didn't, then that'd
> be a problem. If you feel patches need extra context, then just do a
> cover letter for them.

So if you are the receiver of the patch email, then I don=E2=80=99t need =
to worry that you will treat it as a normal patch for review. Can I take =
this as a rule?

Thanks.

Coly Li=
