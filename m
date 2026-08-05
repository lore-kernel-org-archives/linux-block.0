Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4523AEF4B
	for <linux-block@vger.kernel.org>; Wed,  5 Aug 2026 16:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785945816; cv=none; b=P7d3qk5XEkyU7tKZk6A0xH3rEPILMHEc5Q4rjQndNc9YORDjxtHDF/QXU98TM69w78qOaYWZw8Qy6wSSim/iRBfh6lz9o5ETlHUBzsOYzfLBI2MU5EjezruRCNUAci0AgMtGR1D5uaHkiDBHeM/B0ykv8JcP1GyYJLZJeQEtTc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785945816; c=relaxed/simple;
	bh=k0KYd6CEvwfvdKYzo8wbD4Pw7IOpB2EZtmbf60xuGzE=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type; b=jatqljM0CSOGFoZlHQpYmBlK4iLzD0LHmzf00dBl1mlSMvNfPFTwhf7zMD6zoh9sPb34avOwM82hLX5xZpIu/xKecZ+bBUyxQBfn+cIJVQ3O9WAsNvbLCBBy+xIfAYVGLmi9w7w6TZSpy4+Eu1aYGvcxYrfgFnXnYLrXgz4og5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=kggsiuqbyqjl@gmx.com header.b=laUf3Nb8; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=kggsiuqbyqjl@gmx.com header.b="laUf3Nb8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1785945804; x=1786550604; i=kggsiuqbyqjl@gmx.com;
	bh=LLC+hyC7kv7Uk3gFwNwffJk7tUdJVOhOXUuXma1wtW8=;
	h=X-UI-Sender-Class:Date:From:To:Message-ID:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=laUf3Nb8zcqsWI3alyA5Dc6AJtlG3Kc3l4+gYTCPMZe2dZNIZSJgHebEci4DSj2r
	 J7DbKL73x1qKiJBx0s6QprrcVu7NIighUff9676P7EDnYmLx0crcPaFK0EV84Zu38
	 uVmUHITI0XebSAwUOWFCdNAVNQAck+bXzA1swJWa13J+50MiXxcAATQu/HBbDzKFg
	 /ul3GtpvASsph3i6lojs5ktPvcJqcWpjHGyeCUtpd+yU3+4zxpOx7F6pYZzfPG5VV
	 nyPbuay7zSKu53sul9Mh7kg5ZvUADjrA0rAD5fzS/is8d9Ce/MQ33L3RRAkpvn/uA
	 8joDI/C73v+3cUaWJg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mplc7-1xGoNC3KdJ-00imqH for
 <linux-block@vger.kernel.org>; Wed, 05 Aug 2026 18:03:24 +0200
Date: Thu, 6 Aug 2026 00:03:20 +0800 (CST)
From: kggsiuqbyqjl@gmx.com
To: linux-block@vger.kernel.org
Message-ID: <954198508.191.1785945800618@e601e7f9c2c7>
Subject: Regarding the integration of blktests translate.js  Open-source
 multilingual solution
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gkMZrA2reyIVSg8FxSanAMVSuj3isZ2U7JsTwT6TSgO/utlCk/Q
 ooGM3piHbxTGBl1TpVmQRXH6JZ1cgISxsq83xi6Mr21ItWdyoCC7AIkdWp6+41ZW3QmvHLT
 2Or7c8P4Sjr+JZzy645SpUv8CW/r9nRJI4GMwYijNeOPyxqd6Pb7WeljU0xMKomxphwpLVf
 aexi9o281jVuaEhHMsTRw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dDmZTsZFmX8=;rM4jd86tA2y9j4BIjWf7Lx5KYJV
 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
 +2+9njh3EA6IV4RQ==

Hello, the maintainer of blktests. I=E2=80=99m Guan Leiming, the founder of=
 Weifang Leiming Cloud Network Technology Co., Ltd., and also=E2=80=A6 tran=
slate.js  Author of open-source projects.

 I have noticed that blktests, as a testing framework for the Linux kernel=
=E2=80=99s block layer, has developers using it around the world; if its do=
cumentation and interface supported multi-language switching, it would grea=
tly reduce the barriers to use for international developers. I sincerely in=
vite blktests to integrate with our open-source multilingual solution =E2=
=80=93 just two lines of JS are sufficient to enable the interface to suppo=
rt hundreds of languages, without any need to modify the source code or con=
figure API keys, aiming to help you serve the global community better.

 If you are interested, you can visit translate.zvo.cn  Learn about the tec=
hnical details, or reply to this email to confirm whether you would like to=
 receive a brief access document.
