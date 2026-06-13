Received: from va-2-50.ptr.blmpb.com (va-2-50.ptr.blmpb.com [209.127.231.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620E5330328
	for <linux-block@vger.kernel.org>; Sat, 13 Jun 2026 15:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781363616; cv=none; b=STlKYGp2+FHTd+uhVCEVQ3502czVT2uK9EEJwgvluPHnRqxLjyUKESkJVMkFJmYxoyucOn+rNqNDweAiLfM6Xre2P0L9tkTpJU1hhG8XQgnQmsDsgh+vKnqFLP19xktJ3j7g7VyWWmZ6YJgW3zigkJL+ARK/Ixw0TP+EXMDFcVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781363616; c=relaxed/simple;
	bh=jqyoUf0sWqcVtfTEhleA2mWENowet0ntymfg+Nj8aQg=;
	h=To:From:Message-Id:References:Cc:Mime-Version:In-Reply-To:Subject:
	 Date:Content-Type; b=W/KikSsO7hJvQSG0MMQWUfZpJnGdr2avt8seNR0BJF4p2akSfr2kRbZWA2Q1cm7deYl5rSbi31qD2NzSMX2qj18RK8iNYV89DnCDIZq6XLNd+AxvirdU9euUdll+EByxH/x2z7UreoTYxSqRmmL6tcEHM/iS40VXkwCvQlw0m5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io; spf=pass smtp.mailfrom=fygo.io; dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b=OGapUK73; arc=none smtp.client-ip=209.127.231.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fygo.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b="OGapUK73"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fygo-io.20200929.dkim.larksuite.com; t=1781363484;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=jqyoUf0sWqcVtfTEhleA2mWENowet0ntymfg+Nj8aQg=;
 b=OGapUK73rilmRpDzV5pEznUCs4BCA1J2W+3LqMuyXt+MzAHePLHJu+SI9z8D0axQg8IG2U
 egx8etAyPOI9ZgUadXjG/8eL0nyWattVKULRPUUGV6YWVNq6nFBInDGhypSzootq0UTt60
 K07G24mOgOUXiCO/Og0gk7mmjk0glVKW49uYaGuO5RmhNAk422/KfPXpX8S+60ZlGpcx51
 CeBJRjS2M3jfgwEPDFwp238YsScmsReQaHm+LxgxsKtlISnGgUCmlRf1aoj0BMh6X50kTb
 Qzie55dkZiA9nxcu5FuJjfxrAKg7TofMxBXtZhmnAeWrZ+qOhQBBsijsKA12aw==
To: <axboe@kernel.dk>
From: "Coly Li" <colyli@fygo.io>
Message-Id: <05943978-E925-46D1-AC7D-AC36CF6DE3E5@fygo.io>
References: <20260613150458.682707-1-colyli@fygo.io>
Cc: <linux-bcache@vger.kernel.org>, <linux-block@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Coly Li <colyli@fygo.io>
X-Mailer: Apple Mail (2.3864.600.51.1.1)
In-Reply-To: <20260613150458.682707-1-colyli@fygo.io>
Subject: Re: [PATCH Resend] MAINTAINERS: Update Coly Li's email address
Date: Sat, 13 Jun 2026 23:11:11 +0800
X-Lms-Return-Path: <lba+26a2d731c+5500f6+vger.kernel.org+colyli@fygo.io>
Received: from smtpclient.apple ([120.245.64.89]) by smtp.larksuite.com with ESMTPS; Sat, 13 Jun 2026 15:11:23 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Jens,

I assume this patch goes into the spam box again (due to the DKIM issue). I=
 use my personal email address to gently notice you.
Could you please take this patch to update my current employer email addres=
s.

Thanks in advance.

Coly Li

> 2026=E5=B9=B46=E6=9C=8813=E6=97=A5 23:04=EF=BC=8Ccolyli@fygo.io =E5=86=99=
=E9=81=93=EF=BC=9A
>=20
> From: Coly Li <colyli@fygo.io>
>=20
> I switch to colyli@fygo.io as my current email address.
>=20
> Signed-off-by: Coly Li <colyli@fygo.io>
> ---
> MAINTAINERS | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8856f10a72bd..d2aaa7dacf90 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4446,11 +4446,11 @@ F: Documentation/networking/batman-adv.rst
> F: include/uapi/linux/batadv_packet.h
> F: include/uapi/linux/batman_adv.h
> F: net/batman-adv/
>=20
> BCACHE (BLOCK LAYER CACHE)
> -M: Coly Li <colyli@fnnas.com>
> +M: Coly Li <colyli@fygo.io>
> M: Kent Overstreet <kent.overstreet@linux.dev>
> L: linux-bcache@vger.kernel.org
> S: Maintained
> W: http://bcache.evilpiepirate.org
> C: irc://irc.oftc.net/bcache
> --=20
> 2.47.3
>=20
>
