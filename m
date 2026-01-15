Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB3824B28
	for <linux-block@vger.kernel.org>; Thu, 15 Jan 2026 05:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768455561; cv=pass; b=aEpXf/xyGWPyQBzvpCJMn1hr5PrawjMJLQ922J9qdulthuGikJiBCTuBRtwz3H7pmcx/27XzK5NV8oFUc0wsnhLn3MsmuYt08V/efVdik8crEfgQw1HWWc+Ji6ILw8UVXL7hIxc2KFdXqqSUXbgFATTx/+1i7XRRzL442WaVCpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768455561; c=relaxed/simple;
	bh=SMLk9vrg25IpTKlrZ0wITCpi0ypeJ5osshTSMMSTsD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z1agO4N4lZMSVmqLVH5QqpzQ/1nhih8x9+nG1BosnWJlIV6FjU7MbL8/4jSlXdpTeWKz8RDhwcwT6R2+sd7cvpTdPwsnUwXcVY2mjU6NYB5QyjkeB/ys7cDLV4fpuemiiv0DOtr2ZbgJVvNnXA/UEGHdFI1BpBbx0eAYSxDIUBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=GbKbtTG7; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="GbKbtTG7"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b8719f5a2b5so11664566b.3
        for <linux-block@vger.kernel.org>; Wed, 14 Jan 2026 21:39:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768455558; cv=none;
        d=google.com; s=arc-20240605;
        b=MF265IL59xJK5MA6xMoYKSR+1zASEjmBpuaxmfgiVrthoer0JHXU8PTQq4KSz/0BD/
         6GUnkRdzvGppe8Gxgq8ZgmBcxF/JMrmNOXbCEHIsqrJgVQ15ihnK81LqF8EqJCqVqbaW
         Mf+4y7AJC2iD/meZq+vxsfDjcqwLY5WH0CHj8LnJgYiBfAr61843fqAX0RwPYSsxy3zq
         K3OtEGT7JPM3hwx5mHNiwV6jgialTTo2AnJ7DqoTbKw/gFycUNLyfPrntrduFYju/RXY
         vXCwur8TPI9J6fAHScOH5eXhHFHh++NiJot0pqYYPoTWsDoD9Sb2s2IjuNGpWdtxX52O
         GFLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SMLk9vrg25IpTKlrZ0wITCpi0ypeJ5osshTSMMSTsD8=;
        fh=Jd5e3Z23TA+vKD/OI1pkZKi5h7SlPqjxRWY/vF6sf1A=;
        b=HGJBpGAE6bdX+WBSPuXQ8PecOo9iUZOjuXiCYZsjngW4tIyNKHn3vn+cu9XzaFURF5
         qAyx3tTopqeSnvOdWEQU5Y5fmIXjIFcdWDcSpA8P2lUd5NT7uiH0DG/frj9GI1JN1wuk
         RX8f0ScWwW8bPZWBvMnQPEjB+nZB2XKbgdnBiDZ1W7NsKCcCJxKctVHfY1H9Oib09Kc/
         lsG+BHed23nHA6f7uomHicS2YDch1TIKP7PqE2MQ7Gz6eeYTgGTTB+wvszgW/oHCBMbn
         4GXUHWPcdFrexUk41geaMosRnQ3vValEoz15/OoBWmSW7ab0n3/4DwlkXBU+nqm1UHaW
         FdwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1768455558; x=1769060358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SMLk9vrg25IpTKlrZ0wITCpi0ypeJ5osshTSMMSTsD8=;
        b=GbKbtTG7Ee9VlsIijnMVj/3ZC7r8xlVWEzQTzcFEZ3mfJIX+Y8DR2IVXJ8LV+i6Me8
         IdO2eAILUgtD3N8nuXqsgfTIdRCMUlLXsDAgpOCWmpCII3ycYAr+b/fWcAVw77wGbbzq
         LJ6mVyYY5TC+sKBF6hVqUqnGNmdQdoIys53UQlCjiCKiS0RUGeM5QnWXxH715BPFixAl
         PP+dmuyw352BTW8abI3si4pQK1zzOv92O7vwvK13Z/DlhUsSbh5fIoHWAAqMS6HCL2/R
         OHkWPcLeMRvhRLHrRihN5gnfA1nc96N+zCDg11QAd8DV6EukKKT2EazugPmGPEBZ40Ne
         jr9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768455558; x=1769060358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SMLk9vrg25IpTKlrZ0wITCpi0ypeJ5osshTSMMSTsD8=;
        b=TBes5ArLLWiwzzgUk+2bPHutat0VJ94xE3SeqV4nEM5JihrBPGN4dSqX3zCR+V3h/v
         b89urF+MA/t4VBFRyewvQkI9xDhG9yEZ7m0dNHjSQnC8e+t9gQ7evywsvHPHB/FiJEla
         wk+5juaZWs85Zzp758h8KpbUBVmSkhjiscj6i0/5qnEs+lO40y2ATQ5afQkksuDTYrir
         mjIMN/Ke3KtLjMA3ZPLNw6lvvbsXk+zTSa86nuTMEkDfyOEEFvrejnbId9wH2+jOHhTp
         Q5YoWe2TB5H+fg9GZEKQ6f+wDYJxcDxN9CTjQ8jr7xrqULV8FWLPcDIsa2rMksEMen7N
         V8Gg==
X-Forwarded-Encrypted: i=1; AJvYcCWEhldKHbmhomqF3v0ff9ADOq6UJrViewTofszvZys1PoD0EqMfS3WNrhDSryUiXsiycJUTB3uXSoxmdA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxxHCVjJJwPzPmn9a348lhAMiEbhzI9r2z4/agXa5s8Y3V3P6wc
	0DcJTqlUmFXF4lv+Gp0/N+cLPdPDSdCwiFp0FEL+or+ltLKMARoZQ5VILHvApKDs41HrSyZQ6fn
	PiirDFcirnAqvjJNwdD9dFKRCbGaR+TZo9dtsBHqOlg==
X-Gm-Gg: AY/fxX5XIl7+CY2W0bn/Q3zW1YqsRPds8mmv7A7OxS9gLvvoeE9h/dFs6709jtdmzLz
	HPIO6kVILoSfobr73ZFtLhyJU6UH+MQMybPcvOJ+lVjoA+TT4Wcv4nYE8tTls3JQfWU5CWyGFTo
	9eYD1pa9b94g8/AifX6c0Txwwt7y/6BHoaTbYt4BGJNnBAOm8pPD2aS22n6hZf4lNL7DMVppIeR
	OdXeWZHkqmyJgCAk9erHciUEEMuGN2wlXTpAumkRrktvIJeBHDESWDw+3luKtvDNDg+NdjDC9f2
	VqCtkOYimJoYCMS4gKV7RaUl7clt
X-Received: by 2002:a17:907:3da0:b0:b87:1ac:2968 with SMTP id
 a640c23a62f3a-b876155f3aemr232938566b.5.1768455558055; Wed, 14 Jan 2026
 21:39:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112231928.68185-1-ckulkarnilinux@gmail.com>
 <CAMGffEmPCB4j-SfufLAdnBo=x-5HsM-vkzhu7o1ocHwnc0=jVg@mail.gmail.com> <bc5b7643-8f6e-4801-8d73-06e869318cd6@nvidia.com>
In-Reply-To: <bc5b7643-8f6e-4801-8d73-06e869318cd6@nvidia.com>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Thu, 15 Jan 2026 06:39:07 +0100
X-Gm-Features: AZwV_QhDshwN82VZ4uF4VXWEffsBQ5jxvTVo4Cnz-73-kqlps4s2hGzb3xrdQno
Message-ID: <CAMGffE=BTbcw0odN3B9KZCqyJDGZrVqNVMx733VziX_OTB-PVg@mail.gmail.com>
Subject: Re: [PATCH] rnbd-clt: fix refcount underflow in device unmap path
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>, 
	"haris.iqbal@ionos.com" <haris.iqbal@ionos.com>, "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>, 
	"grzegorz.prajsner@ionos.com" <grzegorz.prajsner@ionos.com>, "axboe@kernel.dk" <axboe@kernel.dk>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 2:58=E2=80=AFAM Chaitanya Kulkarni
<chaitanyak@nvidia.com> wrote:
>
> On 1/14/26 00:40, Jinpu Wang wrote:
> >> This follows the kernel pattern where sysfs removal (kobject_del) is
> >> separate from object destruction (kobject_put).
> >>
> >> Fixes: 581cf833cac4 ("block: rnbd: add .release to rnbd_dev_ktype")
> >> Signed-off-by: Chaitanya Kulkarni<ckulkarnilinux@gmail.com>
> > lgtm, thx for the fix.
> > Acked-by: Jack Wang<jinpu.wang@ionos.com>
>
> If this is correct we will needs reviewed-by tag to apply this patch.
My understanding is as module maintainer of rnbd, acked-by is enough
for Jens to pickup/apply the fix.
Anyway.
Reviewed-by: Jack Wang <jinpu.wang@ionos.com>
>
> -ck
>
>
