Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F652405EB;
	Thu,  4 Sep 2025 06:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756966056; cv=none; b=StqBTEVi5+7GNs8a/agHFSu9T8Laf8DGEKz8RaUadAPMhTUjfDot38Gqr8DxeQgSTILXEmizVJkDI6c9WND8G3tA0Aq8jLpHH2MPFoOyjX+dpQQCLLZtkvJEkBQmwEaZpKdMZiK7m+zWghsMt1XFtsqOPKw7P0HeBL6VM1iD5b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756966056; c=relaxed/simple;
	bh=J8H2/1AbOetoHqqerx9Xq2CltjS/eK2+c3yjyHTuPKw=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=LVvgPS1uvXF7JoovPEq0ApuAcLJF7taXlj/xeUWWT/ziw1VGHFWbPS2X8XdFl0vCCF8N2sZd5RHG9b5Z+qnWqzX6EMyc4XiNEHEsHFwyL445CDuNxmm03v8SUIkF9DRZFhCTxsjTOY3aA9923jwPPUAU7CqsJXeZZUv40HGLS3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Uw/sMryX; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Uw/sMryX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1756966034; x=1757570834; i=markus.elfring@web.de;
	bh=lxIjahgQXrEjHuhhyBJMhw43Tk07xo2FuX8KJBLyfnI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Uw/sMryXshUYItJRys+awGtPbz5101/5+NGvg76l64EsuxRbKQI6O4oQqPvGFW0X
	 zKJULyNwv2G4o1Ip6I8F4y1Q3sYoSre3z21ri8FqcNnNhlNZZupFq0nrJNB5o3VNf
	 MAl/QnA8jZ3fGsESxtSCZrQLx8JCZb1LtmKFdKURxE3WT5DtyiimM5mPJ9YLKIIlB
	 uX3Hderu1/BV960Q/MdVr8PYObim63/t9sC4oPbnFwCrT40CEkIS3KmT7zbJr8s/+
	 T7ms4pzwTE0NMSEgVZTdqH1b/qwvq+5wPHeY0CqirbQP84yL0Jjs/WB2D45ifSZIU
	 2vjWJ9rbgFnUoKOOgw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.243]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MtPrY-1uc60K2lTS-00tBwC; Thu, 04
 Sep 2025 08:07:14 +0200
Message-ID: <a8d29094-2db3-495e-8a71-9d11992c4d9c@web.de>
Date: Thu, 4 Sep 2025 08:05:54 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Liao Yuanhong <liaoyuanhong@vivo.com>, linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, Damien Le Moal <dlemoal@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20250903121405.386483-1-liaoyuanhong@vivo.com>
Subject: Re: [PATCH] elevator: avoid redundant conditions
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250903121405.386483-1-liaoyuanhong@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FODSkaMuImrxxCiu1HFBh5t2/97XyI4GQJvEgoOxTPGuKc/oIJg
 notBAc5NinyA/vXAwKj7FNWk3XzbgL4S5h+/g4OfvQhpPHmmI4BzIZJRgV4UluKls/WxCy5
 5N8qRoMExfhMM9RWu8S8g2iuSC3Xu+FFAMTYHuAFvbLRwFHwA2tgseErlqjNBfpbRTY9fb2
 YL/XwFLIY08AzCn/iu9OA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Dc4R68xvj8Y=;Qpj5Fn+MfROJuK5JoOgm2S97vZ6
 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

=E2=80=A6
> it avoids writing out a condition that is unnecessary. Let's drop such

                                                         Thus?


> unnecessary conditions.

  an unnecessary condition?


Would a summary phrase like =E2=80=9CAvoid redundant condition in elv_rb_a=
dd()=E2=80=9D
be nicer?


=E2=80=A6
> +++ b/block/elevator.c
> @@ -240,7 +240,7 @@ void elv_rb_add(struct rb_root *root, struct request=
 *rq)
> =20
>  		if (blk_rq_pos(rq) < blk_rq_pos(__rq))
>  			p =3D &(*p)->rb_left;
> -		else if (blk_rq_pos(rq) >=3D blk_rq_pos(__rq))
> +		else
>  			p =3D &(*p)->rb_right;


Would you dare to apply a conditional expression here?

		p =3D (blk_rq_pos(rq) < blk_rq_pos(__rq)) ? &(*p)->rb_left : &(*p)->rb_r=
ight;


Regards,
Markus
