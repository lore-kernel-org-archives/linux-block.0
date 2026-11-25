Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795647087;
	b=XuyCSv9VWQrT71lFOfd9Tf8JULT8hcKRjaSfhNML3A9z1VdxBkMG+4N/fiqkZgiL5W8f
	 RGbc6KG3VUksPwwPlgIsIdIXB1XSOcoyK2TW69abC2ulwm+3lxY27waF/Z1x7vGFarfe0
	 MXHwptLFFVGSIMN2ANohkYP/VOuxZ3KDbrj/t6sF/4+kBCpyTqmF4IfXanAStDrg0XGcb
	 WyQ5QxivSCP6xfEGx3dHaZhgvqPvp5c06LDU/NV7J1aV9oQRhy5lHinZYW40+FlrqBpcM
	 Szt74K8S0Vpznf/lbedsF9mMCKULBTShy38AfkJl+LFBXzWQgcarGsI+Eq+lTuFyzPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795647087;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=3j5SkbxY4BOP3inGkFuBdyIXvKZsu+lhioXKy5doAU4=;
	b=juB2wlU/T6dWrSUc2VVu6psnK6CAQ1/uyQ22uP/OqdUT6AHZckaMz947CacQvb7o8ktR
	 6yJupaSdV9ZFtk1nHry+XXbuJl3RqJpf5FViBkinYVmoMQ+DEV1MWE7tOBBhX2w3mXCf7
	 iEfBQffT7/J4aFutZQ0g0VJOD9NcbH9tBu7AdBulIukJPA34rMfGcADgt47QH5hZ/FUZj
	 pxxFQOH4ZfjrR8tVOs5vm36Q0R1JTL+MKXA5yjgZgUYCh/CYQi/j4OEdBWKOxPMd651JB
	 JI6NUydmmtETDIohJJRmGfHUrgIGtJh+34zZrw+7DnLLB9boosomW5n2iRMUREVjxOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=protonmail.com;
	spf=pass smtp.mailfrom=protonmail.com;
	dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=FazjHqoN;
	arc=none smtp.remote-ip=79.135.106.101
Received: from mail-106101.protonmail.ch (mail-106101.protonmail.ch [79.135.106.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F82606A68E
	for <linux-block@vger.kernel.org>; Wed, 25 Nov 2026 22:51:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4F82606A68E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=FazjHqoN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1795647084; x=1795906284;
	bh=3j5SkbxY4BOP3inGkFuBdyIXvKZsu+lhioXKy5doAU4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=FazjHqoNQ48Yh1EjHqnL3SCgHm11w3wUtMcwVApXto5AN/ZW8LjC+PmEo2Z7/a9uj
	 B+/3RfL+fjx35zu7z0S9L/lm2o4RWVoUHox64lacvHgLlMqOIXiYz5hPSPLCoDXJ30
	 5Jc3MGOowbw6LaKatrf8N3usZZ9Y2ZKYPdPwqGO4C8xdSd/WJ8saWexUBvbgnT5t1J
	 x1/XocDls6IvCA+Q8zXjH0pd2ruZ+ci+laWtTp8BVvBdLvZh8nnTSOvU+kb3fEZFTL
	 DW+/cXuVLc0PTguBa+Bh0gjD3qwzjXf3olYjBrY+tlKVB8w95Kb7BY1obneYeXWsnU
	 Dep6jzuMG0Wxw==
Date: Wed, 25 Nov 2026 22:51:16 +0000
To: Laurence Oberman <loberman@redhat.com>
From: 70sp <70sp@protonmail.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Thorsten Leemhuis <regressions@leemhuis.info>, Tobias Laas <tobias.laas@posteo.de>, Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>, regressions@lists.linux.dev, linux-block@vger.kernel.org, linux-ide@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Niklas Cassel <cassel@kernel.org>
Subject: Re: [REGRESSION] DMAR fault by Intel H97 SATA controller since "block: Increase BLK_DEF_MAX_SECTORS_CAP" (6.17-rc1)
Message-ID: <uJluFNYGCCrdvnYT3MatN_4Om8UczTJX_dzxumJxyCAC7F-Ubrekb7LPwlRxhCW0J91UBf-TqeRoJQfgYIYBRvMsPmE-Qs1eAg5zbDP0s58=@protonmail.com>
In-Reply-To: <2adaf0ef9e1a2fa18590f7d8dbf203c0f7de2be7.camel@redhat.com>
References: <5ad27a97aafbc08a8702d5b90d09cd59@posteo.de> <awSs5Cw3hFkf4O4T@ryzen> <ec36d13e-e4c2-4bfb-8b50-69d4a1628839@leemhuis.info> <87b1bbd8-8113-4890-8623-738b19a9cc7b@leemhuis.info> <a0ff3156-add0-4f7d-8373-09f95bd7036b@acm.org> <2adaf0ef9e1a2fa18590f7d8dbf203c0f7de2be7.camel@redhat.com>
Feedback-ID: 144929603:user:proton
X-Pm-Message-ID: 71ab037c5ea6bb9141ba5150b2c0bfa808b46652
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,

as I mentioned in the referenced regression thread I reported, the patch I =
sent out was basically an example to show that it works for my use case. I =
wrote that I don't think the patch is ideal (in fact, I think it's an absol=
utely terrible solution to fix this). This is also the reason, why I just s=
ent it as a snippet of code.

Please take a look at the code before the regression started to occur. It w=
as implemented universally. These vibe coded patches are horrible compared =
to the original code. We are literally making an exemption for a specific C=
PU in a place where it shouldn't be. The actual correct solution would be t=
o make a patch which works similarly to the pre-regression state.

If we are going to merge something that is made by a LLM we should at least=
 make it good. Ideally made by an actual human.

Thanks for listening to my opinion.

Best regards,
=C5=A0imon Posp=C3=ADchal
