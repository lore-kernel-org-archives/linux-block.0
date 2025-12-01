Received: from sg-1-14.ptr.blmpb.com (sg-1-14.ptr.blmpb.com [118.26.132.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA191E766E
	for <linux-block@vger.kernel.org>; Mon,  1 Dec 2025 05:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764567769; cv=none; b=Oj6bqA2WDbmmG+Yz429rYEB3Dk9HK25wezoLw36dlOs7M67/QOFLv9j1tdjWz7Rnz1NEbz8CoWDQeiZOPOBUJvjP4aLLnwH5sFyp2Vl9yBYUvVPpI/bSVUP2lEauvvBIunYjJgQ6ESUnA1GkvJ1AV56k0yezyPiMcsUWPCD3TiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764567769; c=relaxed/simple;
	bh=c1rjV/8l6N5f1RM2rQjR3SlHORaNasTZ5ipYnJkZFDQ=;
	h=From:Date:In-Reply-To:Cc:Message-Id:Content-Type:References:To:
	 Subject:Mime-Version; b=hfPvPzX4bpxDyNMbb2uMqSp2KUx8FbPrBaNTkv7RvePZHJQlvNT8p1hnKe7hgWUroQwrqKXudnWR/rGnRsIL6sijyg8tnOndhdeKa/XPIsF5c1VPJxF7DNWPHLnzRl+WZPLZ9uSc1sRd7niryhgLkH2mfV9P5YHpbzteiNmW7Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=none smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=MjNzpAAN; arc=none smtp.client-ip=118.26.132.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="MjNzpAAN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1764567755;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=c1rjV/8l6N5f1RM2rQjR3SlHORaNasTZ5ipYnJkZFDQ=;
 b=MjNzpAANlYctCOptHx7qmyvN2J0YX+8JCV6JeYdi861oS/dWVuAIyMMBujx1D5GHdb1vFX
 858dMeQ/4+hdOZIIfvmoXXYqWAd5KcHC21JRni7LKd2WhEltRFAyXZIowviHf7pmTyyT3r
 kwv8FN55eKgjmby6IiJiRGCosEKJb7zZVvWopY2bXK5EDDAJtabeofKD8hDRiG4venN3WW
 n344r30BgSrYW9CbhHmLppqwPBieyawzfryQ7tqqt6sXhIciR8w6e6ubB/AAvW/uVgNEdy
 bAc09oixfEIdfN8QIvcZeF4rzV7XUCOmFmputhllrPSdPE4+x6H+9zCZQRh7hw==
From: "Coly Li" <colyli@fnnas.com>
Date: Mon, 1 Dec 2025 13:42:20 +0800
Received: from smtpclient.apple ([120.245.66.121]) by smtp.feishu.cn with ESMTPS; Mon, 01 Dec 2025 13:42:32 +0800
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CANubcdUGqYsaxsd-cUtjhtCSL4G1kQGevei1m25qKm0ip0-i9g@mail.gmail.com>
X-Original-From: Coly Li <colyli@fnnas.com>
X-Mailer: Apple Mail (2.3864.200.81.1.6)
Cc: <baijiaju1990@gmail.com>, "Christoph Hellwig" <hch@infradead.org>, 
	<linux-bcache@vger.kernel.org>, <linux-block@vger.kernel.org>, 
	<stable@vger.kernel.org>, "zhangshida" <zhangshida@kylinos.cn>
Message-Id: <D4188931-CEEE-49CB-94AF-FE81D952BAA4@fnnas.com>
Content-Type: text/plain; charset=UTF-8
References: <CANubcdUGqYsaxsd-cUtjhtCSL4G1kQGevei1m25qKm0ip0-i9g@mail.gmail.com>
To: "Stephen Zhang" <starzhangzsd@gmail.com>
Subject: Re: [PATCH] bcache: call bio_endio() to replace directly calling bio->bi_end_io()
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+2692d2ac9+9329a4+vger.kernel.org+colyli@fnnas.com>

> 2025=E5=B9=B412=E6=9C=881=E6=97=A5 10:49=EF=BC=8CStephen Zhang <starzhang=
zsd@gmail.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Hi Coly,
>=20
> For this issue, I've previously sent a fix here:
> https://lore.kernel.org/all/20251129090122.2457896-2-zhangshida@kylinos.c=
n/
> Would you be able to take a look and see if that one is suitable to pick =
up?

Hi Shida,

It seems my email server didn=E2=80=99t handle the v3 patch set well. Yes, =
now I see your patch,
I will reply your in the patch context.

Thanks.

Coly Li
