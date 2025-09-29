Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8132EC0B3;
	Mon, 29 Sep 2025 12:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759150430; cv=pass; b=ETUFeOrOM30Wdtej1bSIBsS2oadjm5yk6NdEoAkLbM1gnfT4fahGPNBqLV9ttSrsEyJCBNNScDmrsOhorNU6VTC65Jd5Zu7Y31HJG6ttDrCpTOISubv4ouRNKaT50WcvzyyxSLI7dz3kMkm//4V3cSXhPK9w2dUsPzyiuNT14Q0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759150430; c=relaxed/simple;
	bh=eBKxTtwMbWWsVmRTK8+SCP8Efd4jfs62T+R7mc64XII=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Vqq7YbaUxx3bFOlEJHVYQQxcJX0KgGUZoWwrOeZHpDX6r9nL+OCGrR7u8NdMvE1MB6pyQBHV5QwTwzEAlBwzuN9s8q47AsxHcbLnROTz9D83+Ma/5GwWg5ne40Oon4caVgfCIuUxk1k7DwIuSzlV03VxB7YYzqd1V+J+vzDPBso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=K9Dvhsws; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="K9Dvhsws"
ARC-Seal: i=1; a=rsa-sha256; t=1759150406; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=XKs8IiVjPegrhhG0vEVkbIx0k3SKSv7NZ+RDhF5T9hPHatVs9ElF10F6rEF/za72TRkviTJhboelBur8bj9usRMhZoy9WyVb+MwnxIDlEG/1JdCUUmQ0KYKSlhQyUKJheNyXNTPYWDx+wHCKjLhQDYswRe3F2+EcXjT84NUJLLw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1759150406; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=uOmVlFLdpvtEjwlJedRpqA8qvL1y14ne4vIVGveE6s4=; 
	b=PXRh6+UX8zFMydyoVAaYS7Lzeots4HyiWi5Se7K7Wg2S86j3fJUM8ekQOyoEUg5S3U2qAq2uPtYSOGb3VF8yIoxxpvOqJXyL+HUb4UM/qNbr7K0suCMIReDmmOximXiLkim45+RBMtlHcnovCuccCbPURUTlr+gd4f9Da41AN+c=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1759150406;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=uOmVlFLdpvtEjwlJedRpqA8qvL1y14ne4vIVGveE6s4=;
	b=K9Dvhswss/WDdeSocR3mM4hJ6dOPmMkp4JArX2Gj5I5zRvVqlm1hbqKCNFFYD4vC
	gmpVbgwTtREtNzUU7A+ki27uZmBXeJFIxJytvWy7Q3HyHJXLlXlt+1L7gKPGhBx/uRn
	Jf2ND4WG8qP1SBPO23NilVIQlqkUsg0ndieGAXNM=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1759150403924705.9548897883606; Mon, 29 Sep 2025 05:53:23 -0700 (PDT)
Date: Mon, 29 Sep 2025 20:53:23 +0800
From: Li Chen <me@linux.beauty>
To: "Markus Elfring" <Markus.Elfring@web.de>
Cc: "Li Chen" <chenl311@chinatelecom.cn>,
	"linux-block" <linux-block@vger.kernel.org>,
	"Jens Axboe" <axboe@kernel.dk>,
	"LKML" <linux-kernel@vger.kernel.org>,
	"Yang Erkun" <yangerkun@huawei.com>
Message-ID: <1999588f143.5af31c76548207.2814872385181806897@linux.beauty>
In-Reply-To: <9f6acb84-02cb-4f76-bf37-e79b87157f1e@web.de>
References: <20250926121231.32549-1-me@linux.beauty> <9f6acb84-02cb-4f76-bf37-e79b87157f1e@web.de>
Subject: Re: [PATCH] loop: fix backing file reference leak on validation
 error
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

Hi Markus,

 ---- On Sun, 28 Sep 2025 21:48:23 +0800  Markus Elfring <Markus.Elfring@we=
b.de> wrote ---=20
 > =E2=80=A6
 > > Fix this by calling fput(file) before returning the error.
 > =E2=80=A6
 > > +++ b/drivers/block/loop.c
 > =E2=80=A6
 >=20
 > How do you think about to increase the application of scope-based resour=
ce management?
 > https://elixir.bootlin.com/linux/v6.17-rc7/source/include/linux/file.h#L=
97

Looks good; I will add a commit to switch to scope-based resource managemen=
t in v2.
Thanks for your suggestion!

Regards,
Li
