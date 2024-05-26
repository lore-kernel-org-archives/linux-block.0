Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8A7B640;
	Sun, 26 May 2024 12:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716728305; cv=none; b=TZAvROF2v5glUwE9Je18iorPNayR+WqEWTByTRJn2LgH158zwbgZ5APgmSvhkr3mWLiy+5LG5pyrUBugLsNP6v5wMO9DGzDs6yy4Ff5LzY79HgnbWE5NERmDmx5VRhJ8GnnEIAnPMa2GOL4ZxK/Af5QB7c+GGRu/FFgDQ8B2oVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716728305; c=relaxed/simple;
	bh=+Jk/U5uDbfjV3TVqCr1thBx3H0i66FuEANV7xC+xlvQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=tLyQ+0Gz8nFk8rG9B78zKQY37flALSgPVgyd6yuSCzQQ1i6hcstWRckHpP+9dgTB/HQ6f7f8G8Su8/MQrd5sgSUqIuETLyDIjNfWIzJC0soQkaiedeFUttzlu4an7DMPAXOFPXenwkBwa4hitSJRvHyzMvMCAqqWr0GeOFUXJPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=uG0ygbpX; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="uG0ygbpX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1716728235; x=1717333035; i=markus.elfring@web.de;
	bh=TH4bJDOAOe0AwLA0U7wO9TtqPvaa/z7ZkRomrKnaLd4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=uG0ygbpXlIzchJJB+ZdOgUQP4d/HFkCO8o4Ry3NUK+JNWGVW5k2T4bvra9f5+K1f
	 z1WlHA5y263i+om7NxkheRkx6Ly4c46fT6T2r1+nYVkrBro/p6bbfLjKXqomo/hu2
	 B/IMzN3Ciguh4J9g63On2I4BKA8h9RYhbr1WMbHAYd57uXVnLWNu/onDtyBAyyjlW
	 zMJQv8Qc3V11NMrOKokYrmIKmAtz7022B6qOPv1wIZ/pfWVbkUxlCwH/E+kqAK31T
	 0OxlMt0lD1uTBSPEt5r/Yo0yuBHDVmO1hYpYqltVQffBf2jaQav3RjhUoH9DKsn8d
	 CLQTdcTc1GEgfwiAuw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mmhnu-1sts6v2L1a-00jhaj; Sun, 26
 May 2024 14:57:15 +0200
Message-ID: <369912bd-2ccf-4cb7-817a-a32ccbb3d83d@web.de>
Date: Sun, 26 May 2024 14:57:07 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Yu Kuai <yukuai3@huawei.com>, linux-block@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Chengming Zhou <zhouchengming@bytedance.com>,
 Damien Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@suse.de>,
 Jens Axboe <axboe@kernel.dk>, Johannes Thumshirn
 <johannes.thumshirn@wdc.com>, Yi Zhang <yi.zhang@redhat.com>,
 Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: LKML <linux-kernel@vger.kernel.org>, Yang Erkun <yangerkun@huawei.com>,
 Yi Zhang <yi.zhang@huawei.com>, Yu Kuai <yukuai1@huaweicloud.com>
References: <20240523153934.1937851-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH v2] null_blk: fix null-ptr-dereference while configuring
 'power' and 'submit_queues'
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240523153934.1937851-1-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FdTFfjKeMbueufJpEs7qeLt78+mhGzQxV8dbJ8BZleWz5WKA7rT
 FmGUKdTjZd2dbVMLZpVl7LIsbMuJLfg+tHDnPWxHvuhi4yjHMtb/37F+G0k0OMUZSklQxrR
 U7j1LjI7dnRcX0WfLVIBFx/4LC/ivVsTNZYd13CSXIxcr2ousa0Dmfbf7RWLbsBjyhD+AZc
 v55JqHyCA8lj+nijOSZUg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:RONZyowvkdA=;qIEX4tPfOuBuJwMVujzM1AjwnE1
 fXfbD52+wJJcpo3wOabKrMkSIDjnDwSl8GM15LMmisc19pOR3V1pMZesXaadRNs19u8Xj7375
 ePbES4D9Y13fcIO69qSLHjB0GJOzqN1TjG3+fwRBflTPOHV3nDH95sWqVwau/8cJ16OCuMlnd
 JLcVWuVRbp3MH/xfZIly7mLV5lD8gulrxBpKEFZf79OHWlW4Tt0Gcdry76SWw9MQRLDcG0A3e
 JwEaAbBxy58YkZSiznpsrgVYiv66q5V0Ow35UxwhXLeIIVTAK1bGII4kWds/QUDkZpgkNILOk
 qA/HkQ8le1/9K056RAc5NuuDSrPfK7IUZkWFvCOPhZzJstTLDDsDr9LZP8vgNGZRglHCBsm3v
 MPrn8D4F35ovmZK5Vz9ZoP/BX4EOx95a6zsjCZVytgapfmRh6St6kTQr8gZuBKOjuEj1rbr3l
 VGBXNl3fUnB1UlMgEzgSjXkdDLUevJcAeFjelk2oyHUvKxh4PFLQ7OHiWlwIzQBpvg23n92SP
 iUljOEXZuzg744GjEZWWBu4h0sufg8aEQ9b80BwlA9h51WGarTeWFZr5LiQai5FFX3gv7ocB/
 xVPeRvCZkvX8szP0Mh6KajMJxHkXuRF4en0E0V0ksrB+pBYbTc1lcwZqX6cbCndW/GgGyoVxh
 fhZWIYqzDqq7GlbKlxkxrQRrxuajaCtdgO+c0TsaAkZ5lwxQNJspvrvDocMxoWx1hI1Fe1eSg
 FLZeQNSEiGmu2i/N7RndvIWx8gLjsysEzPI3H6Fkw5QFsIVUUP1ZdGJQdQI1tdddeB0HINLIi
 +kkcErcdMI7Ry4PI9w7+koiRTUQ1nuSTln1TGTqLt8OPo=

=E2=80=A6
> Fix this problem by resuing the global mutex to protect
> nullb_device_power_store() and nullb_update_nr_hw_queues() from configfs=
.
>
> Fixes: 45919fbfe1c4 ("null_blk: Enable modifying 'submit_queues' after a=
n instance has been configured")
=E2=80=A6
> +++ b/drivers/block/null_blk/main.c
> @@ -413,13 +413,25 @@ static int nullb_update_nr_hw_queues(struct nullb_=
device *dev,
>  static int nullb_apply_submit_queues(struct nullb_device *dev,
>  				     unsigned int submit_queues)
>  {
> -	return nullb_update_nr_hw_queues(dev, submit_queues, dev->poll_queues)=
;
> +	int ret;
> +
> +	mutex_lock(&lock);
> +	ret =3D nullb_update_nr_hw_queues(dev, submit_queues, dev->poll_queues=
);
> +	mutex_unlock(&lock);
> +
> +	return ret;
>  }
=E2=80=A6

How do you think about to increase the application of scope-based resource=
 management here?
https://elixir.bootlin.com/linux/v6.9.1/source/include/linux/cleanup.h#L12=
4

Will development interests grow for the usage of a statement like =E2=80=
=9Cguard(mutex)(&lock);=E2=80=9D?

Regards,
Markus
