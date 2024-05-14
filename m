Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE4B10949;
	Tue, 14 May 2024 07:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715672594; cv=none; b=TQjPN7S/9ovXLldLWXRMrjQ/g+cDbhQ37Dsbvx6hkt0ur1PeLMCwPB1HlIINV9xTzw31V7F2nWaw8fIghm/xMJ17VzWk7oS5JQ5u2gxeBdGs71hK+gd983we8oMtrtAiaGKPMuIqyrWMFFF6tG5GWgOihzGD4hD5u2LqRovlj4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715672594; c=relaxed/simple;
	bh=xIgik0zA2zjBXDJKdFRqlH5x+cgMRBqk7Ror5EhZ4Ic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LbJOJgNEpHPUCIGto5Bm98OvMcNv6iYn6VXeGPmGO4E0mHt8way65NBaqcnsfafyfRwKujw/2Nl5CnQfVkJh9YG4ZlxmZjzRAKkYDZZSg/FC0kZFleZWR97yhi6int3BbH+esPzLaCaOdC9GJIpAK+K0mbuTDZWdP+NGbxmOPn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=gKLOAC5s; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="gKLOAC5s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1715672580; x=1716277380; i=markus.elfring@web.de;
	bh=xIgik0zA2zjBXDJKdFRqlH5x+cgMRBqk7Ror5EhZ4Ic=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=gKLOAC5srdxebxFMnFQrRFawlnUsEYlZIKY3gty8iTg2w7NQKqwErUosuK3jobaF
	 RaVF5vr8MiOumQBiPJrw3+RayISaNmeD1V/TNH+PslAAW2Sz+U50jJho1TCBCazEv
	 Vo4Lk+pDwTduJTI+VqviFz2Bpohd0uYClakZVJH4U1ivyu2loALDhBfBhMaL35E4y
	 KJtkF8YJsQ+49uvxn5DJjvWwq1JjLZixEIcZVD5HjAc5IdYgz99Z0cqeY8zpBNist
	 C8ffiSTxG6Kw0rO8f3RRJ3JUDeS7qpQAVnqMsiuWTBhJAEVpcJuGK5IG6KbLH5gtc
	 xaTdwqNDI2t/8GiulA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MNfYN-1rv1OZ1mhv-00YRev; Tue, 14
 May 2024 09:43:00 +0200
Message-ID: <d18294d0-7274-4786-a443-24e7cb79c66d@web.de>
Date: Tue, 14 May 2024 09:42:14 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] aoe: fix the potential use-after-free problem in more
 places
To: Chun-Yi Lee <jlee@suse.com>, linux-block@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Chun-Yi Lee
 <joeyli.kernel@gmail.com>, "David S . Miller" <davem@davemloft.net>,
 Jens Axboe <axboe@kernel.dk>, Justin Sanders <justin@coraid.com>,
 Kirill Korotaev <dev@openvz.org>, Nicolai Stange <nstange@suse.com>,
 Pavel Emelianov <xemul@openvz.org>
References: <20240514054214.924-1-jlee@suse.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240514054214.924-1-jlee@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DGjkXyi2KlCMQRSTOVqzP8gfkfTT0kNd0N2Qw9GVKhXl4BSfnoz
 gpJJnMvWxsX6OOjAgZ5DFSjNVaMlt3dVoghWEVr2yb2wQHaC1C62GRxAxs69smC1n4lhsxw
 kFSG4ztiZG327F93i4a3ZjCEdL5j7hpklwaZiR75+KtbR9CEPxR8Xsw2T1XME838RIPo83j
 KX6T95gIS9EzQ+SeWBtmg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:uYv8A1Ly0n4=;IAiyijM2BQxduskgcWiCxwjQzA5
 J3y/osG8FjbEpfV8qhdEGN+6Oj/0BeJxWIFJXB43L6Pb9c2FrFIgkEOd5Pn6cdpVhX9yg8SZL
 o64LELRG1aY3rMG9u8cC6LOgbF8Ix80qB5POOgHtlcecLud5VJY6cjptLwcs8wARS85s0mOUL
 0837LdEJ1CIHA+U8Dw4cl1rGbF7r1EzNLKj9PPekzcZVE3EkqW4ctvkUIj9uAlyqfBTnSRSPl
 NGI4nEJnTkp9AEsUzEIh+mMpsGaPwo4mFVi0Bx6lodDy3A4Ev0WTCiZVsXLofvXCxWxpUohCN
 CUrUOOT7ffjQH2L6QpkEect0VEndv3wJJ7eaZINrCYOPvsQR2SEMfaLAS1bZUpNBXgP0qZPbS
 afW2+E4C01Bx97TRoP0cSkKvlRkP4OC8If9U4hCmNrwzrxsqriZO4qO/VnTNVHMgZfQiyMaNq
 7o/AwMDedTfihGGO2i5+n+AegS+62/nxBv1FmZy4fyxIhiH7TuNPxtCTaA7yddnNdj4BKVg5b
 qbwxNyrSzH5kopy+7gHVeCLdRLmzq8WzmzWuqYhTYszAeUTwRaYruhVAGdyAJueE0vUChf6xa
 U14rqN6B6QXaP+KrljrzNqCYqjoG6XIv8O1YV44ehN50i5tJXdoOmYgfuDGfqRDnhT11E/ALK
 5GQ/AwdSqGtXpB6BPz0p0Vpty0kWpHVNFE5r9dr8+T0seDxOcRegSZotYgdUZuI4zQEG/P5Vl
 lP7WZC49SGvxMMEftLBs486wbjv9F555Cz5ApLlFkFoZLwoouVP5VK1MctI2syLVTeTLKNQS1
 wRwk6kC3WvGxEcKGSNX6zzRKovGQ0u8B+1oPxWr0xPvcM=

Please add a version identification to your patch subject.


=E2=80=A6
> This patch adds =E2=80=A6

Please use imperative wordings for improved change descriptions also in yo=
ur patches.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.9#n94


> v2:
> - Base on submitting-patches.rst document to improve patch description.
=E2=80=A6

* Was any information overlooked here?

* Such version descriptions should be put behind a marker line.


Regards,
Markus
