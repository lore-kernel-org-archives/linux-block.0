Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795699919;
	b=VnLOHInakzDxhRwzjrdl0Ln2q81ZYafj1Ag5G//GwTHtMgf4ckTrz5xEAdykNJiRUBLv
	 GkJUSCv7j8FqPHxM3/6v69WWWQGUVxvB4q+bJAKYjVxohlD9P3hD9mHH2bJQ2n5ig5MD5
	 thklBw2l5do/6aQ228O/D6quK7MaA6yERg0j/EbSf8d/lY22ZWR1vsjGNEMPn1FjGGEMb
	 hIZPgmPrRyaK6VmrSspRKBDGZ6+whyEGhOClDblHrifxne0vriQQZ66XJGXVKZOXtQf4+
	 dO+vRVqYBfBFLCBOkasZ24KkzcD2MWwwC2YDVLtnhjsXP5iMOvxFUZdUJsAMAA5jaWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795699919;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:User-Agent:
	 MIME-Version;
	bh=3B43kyyzUUTLVNXK4AN+mljA56km2Ewzy7V4dK6lZDs=;
	b=OHVSGfpIvA+YPYakfRd1M+W1+mcIqB90XOSnnV1MR+D0SozCOo8Q8G7KqWZM0Axo5X7O
	 FBKOQG14dgUVxitdwGY9Iq5vHUeDfnnpIvNFGdqbXmnwCxMqpDfaAKp8bbxwaFaiJ9Trj
	 Oi0YQymB0vxURgAtsKlF+bv2W5WeVHk//Y9CjOU0Dcx9qSmccvZEcHp8nKrUWXeam3top
	 gxoQEjwYlltxOse0tg74GWiH/pj/I7DJCMiZGq1/PJ3wkiSx1SVlijmn8Y7mkPxukf5gg
	 ZzcGoY0NII6WPt0KX0sURTYlaIcwssmhUxifvoCYNF+vuj25ryEFQvaeDbiONR66U8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="WJ/MpnsM";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=nGSgsnqo;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611CC606A684
	for <linux-block@vger.kernel.org>; Thu, 26 Nov 2026 13:31:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 611CC606A684
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WJ/MpnsM;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=nGSgsnqo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795699917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3B43kyyzUUTLVNXK4AN+mljA56km2Ewzy7V4dK6lZDs=;
	b=WJ/MpnsMhiux4kO2TcryEy1ZEU7GoPXkgoJC32P2byjNky3ic9339pCaDTb4YOSj89LiDp
	rc4Gd6JzCwvDpsVXmeNc7EB00f/DQHaNnauPQ8lOEkPdN3VZy41AWjLpA3/DF6cxQdMzPb
	Ny3szvQ5hjT6sVl0cCoyl5kbCKp27XU=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-QgPa48cINX6GessPtxzeHw-1; Thu, 26 Nov 2026 13:31:55 +0000
X-MC-Unique: QgPa48cINX6GessPtxzeHw-1
X-Mimecast-MFC-AGG-ID: QgPa48cINX6GessPtxzeHw_1795699915
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-5eac42e83e0so1224210e0c.2
        for <linux-block@vger.kernel.org>; Thu, 26 Nov 2026 05:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795699915; x=1796304715; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=3B43kyyzUUTLVNXK4AN+mljA56km2Ewzy7V4dK6lZDs=;
        b=nGSgsnqoRMrE+qrMFEsSkU/tQ3HLdkXLXstgOgqOBsANPRb0DKIxVqqQmNqtHDEPmR
         +YZ1CcsR9IKN41qJQoYZHvWWRPF5xX0sljXv1ttS1AarGOnLH9KPr2Ok4IUaKZZYKtmq
         6C9zZiu9umnh1r24LoO58f5w5fMNlT9SoWTw5wghEeoNGfTHCo/S+BzPM823ikV4uRJB
         8erygb8voY11I3M98KnlBcGereAWXTTuZBIzUjY7vewCUNvt//9XH70uBt+VmJvio+eM
         bn2QGMVcVaVoGjhTFccrJAkZeYLqzueKmlzSZqxIuXmuWvM7MK+x584Slmt21gMLPXiA
         M4lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795699915; x=1796304715;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3B43kyyzUUTLVNXK4AN+mljA56km2Ewzy7V4dK6lZDs=;
        b=vvfd4xWQvYBDFY0116AGWai6aPus12v7qPX6J2qqg0zPRK5APrM3xqIMJ0dWxl3h/Y
         /BWUJ3SLEO1MkrA3Vovwe+bf5P5/DfALLVejLjjxeSajCcds471t83Nw4ZHVAfzFukAe
         GoXKp/QyoEe6NlukffA9rYuaf7UZIWgLWKlBOYnT7xPw0E3cZn7AWBeu6k2kQTTFIN8+
         CKKnSz0b5PPUCyNOumk9QiDsvON90BlDZbbIQuM9Ld4cI0mWsoe1ONLu3qqwk/te+0t1
         kzPE4fMfvGO/iqpAFLJpAtKTe3VmqfKNQChXFGCb4mThaFnu330uzkuqyZbML5nY5xAK
         jKCg==
X-Forwarded-Encrypted: i=1; AL+hErEqTbTx6jU/+5VkBChoLDSSsK/u2r+YQHJdOW8DhxFLptd9nCC1Y/vI2gZEm7aL0hCDsqfBScv0gMGePA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/pyiHUu1Z+uN1HaXMNGfTXsDPReH6l6UinXRR5mZ6jU7ZImD8E
	v9VQmW4nXdZUVee+P/zbhhwkH02ss9mrI79R5oBq2q+lc015J2PnRzkdpLa10HHB5Quvz2YtQRx
	VgkIKi/Zdpt5EzGswglTcY434nC1fn1jHcgShKeZBsVp9+efgAC5XAdr7SAT5OrRb
X-Gm-Gg: AZFdTZciKMirIuwnpKaBWA+EYEzGbeaKgI3eDsRo4gZ68mjp0bfMpHn+V62Cg3iM+b7
	jHSSFGP+b2sentJIb/3EAR2rtFKb9Si/JHnhr840TPei5Ydx0ySe1pGNk1MMqt/P5ekCds79mKY
	EWjfcxLggc3AycZDzFZ9zdlZAxuH8UJsJ82j9Wyi0pOt/bGkd1jMB+FiQqANKPT9oQHSHvOXidr
	TWAnq3D8t6XnRN47yZmj0BIWfuu5XyCsRirvqppowj6nNscLlguzudB8UspBciJElUqoQNPBxge
	NbiCz3V7LPlDkrdh1cvdkBNdezYuRTOHLpmC8M1RHrgYzlMGN5jXoA7rsPFpA9QqELj6if0IFd9
	qHUaMPGc7FBG48VQXwP0LdvT0lPfeeTAqndacR7q8qCFHIyqpowRd0wfOjEDP9yWw7sRlwvxMAk
	P1iCOmk9ZYaSd8zU+p1FD2QFMpzB00OxGVwuTWpEjULgELbKJxA3Fszlo80qCYx3u9DEK5ow==
X-Received: by 2002:a05:6122:29cd:b0:5ec:d751:a18e with SMTP id 71dfb90a1353d-5ee8af5d5c6mr11288987e0c.19.1795699915146;
        Thu, 26 Nov 2026 05:31:55 -0800 (PST)
X-Received: by 2002:a05:6122:29cd:b0:5ec:d751:a18e with SMTP id 71dfb90a1353d-5ee8af5d5c6mr11288267e0c.19.1795699910439;
        Thu, 26 Nov 2026 05:31:50 -0800 (PST)
Received: from loberman-thinkpadp1gen5.rmtusma.csb ([2600:6c65:2440:d8c:929c:b769:6def:faa3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d788506b0sm180018331cf.17.2026.11.26.05.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 05:31:49 -0800 (PST)
Message-ID: <f323c3d62265dfe90fa71514028af4d35f6e2420.camel@redhat.com>
Subject: Re: [REGRESSION] DMAR fault by Intel H97 SATA controller since
 "block: Increase BLK_DEF_MAX_SECTORS_CAP" (6.17-rc1)
From: Laurence Oberman <loberman@redhat.com>
To: Bart Van Assche <bvanassche@acm.org>, Lu Baolu
 <baolu.lu@linux.intel.com>,  Jason Gunthorpe	 <jgg@ziepe.ca>, Joerg Roedel
 <joro@8bytes.org>
Cc: 70sp <70sp@protonmail.com>, Thorsten Leemhuis
 <regressions@leemhuis.info>,  Tobias Laas <tobias.laas@posteo.de>, Damien
 Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	regressions@lists.linux.dev, linux-block@vger.kernel.org, 
	linux-ide@vger.kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org,  David Woodhouse <dwmw2@infradead.org>, Will
 Deacon <will@kernel.org>, Niklas Cassel <cassel@kernel.org>
Date: Thu, 26 Nov 2026 08:31:48 -0500
In-Reply-To: <0edb9525-5068-42e6-b6c3-a1dcebcbcea7@acm.org>
References: <5ad27a97aafbc08a8702d5b90d09cd59@posteo.de>
	 <awSs5Cw3hFkf4O4T@ryzen>
	 <ec36d13e-e4c2-4bfb-8b50-69d4a1628839@leemhuis.info>
	 <87b1bbd8-8113-4890-8623-738b19a9cc7b@leemhuis.info>
	 <a0ff3156-add0-4f7d-8373-09f95bd7036b@acm.org>
	 <2adaf0ef9e1a2fa18590f7d8dbf203c0f7de2be7.camel@redhat.com>
	 <uJluFNYGCCrdvnYT3MatN_4Om8UczTJX_dzxumJxyCAC7F-Ubrekb7LPwlRxhCW0J91UBf-TqeRoJQfgYIYBRvMsPmE-Qs1eAg5zbDP0s58=@protonmail.com>
	 <0edb9525-5068-42e6-b6c3-a1dcebcbcea7@acm.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Wed, 2026-11-25 at 15:27 -0800, Bart Van Assche wrote:
> On 11/25/26 2:51 PM, 70sp wrote:
> > as I mentioned in the referenced regression thread I reported, the
> > patch I sent out was basically an example to show that it works for
> > my use case. I wrote that I don't think the patch is ideal (in
> > fact,
> > I think it's an absolutely terrible solution to fix this). This is
> > also the reason, why I just sent it as a snippet of code.
> >=20
> > Please take a look at the code before the regression started to
> > occur. It was implemented universally. These vibe coded patches are
> > horrible compared to the original code. We are literally making an
> > exemption for a specific CPU in a place where it shouldn't be. The
> > actual correct solution would be to make a patch which works
> > similarly to the pre-regression state.
> >=20
> > If we are going to merge something that is made by a LLM we should
> > at least make it good. Ideally made by an actual human.
> (+Lu, Jason and Joerg, signers/reviewers of the patch mentioned in
> the
> Fixes: tag)
>=20
> Is a better solution possible than the patch "iommu/vt-d: Disable
> superpages on Haswell with integrated graphics" I posted here:
> https://lore.kernel.org/linux-block/uJluFNYGCCrdvnYT3MatN_4Om8UczTJX_dzxu=
mJxyCAC7F-Ubrekb7LPwlRxhCW0J91UBf-TqeRoJQfgYIYBRvMsPmE-Qs1eAg5zbDP0s58=3D@p=
rotonmail.com/T/#mc147f250c5356e3742ab3d30ccf6b4a3a8c4196b
> =C2=A0
> ?
>=20
> Thanks,
>=20
> Bart.

@Simon,
To be clear, What I tested was the patch Bart suggested. Not your
original suggestion. We will still need a test from Tobias to make
sure.

Thanks
Laurence

