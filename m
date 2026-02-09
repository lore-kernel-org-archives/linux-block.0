Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D87134B1A1;
	Mon,  9 Feb 2026 10:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770632398; cv=none; b=rrhp+x7tkg8d6o/UZBYlPRdJymMNFBxd6gAbYrcxxaAH9v+Yt3MInpBghPe99N7Nx1buzgtpeCCobfu9wpfq22oXk1h+rcyBWRkPRHP3QaB/BnYaaGcJrEkdTxqYRRhSzPLnZ515vqXaJcN8K9Rnsg0i7sXe/+er2PdvtjWAW3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770632398; c=relaxed/simple;
	bh=frF/ygmT6BMadE5omuNNyjVPtF9+GASqvwXA/+PB+88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M0yE49BUgIOAdoyzbiv0l7AJaSQw6uAv3hhQbCr3M+hrHUPubbjgO7FSAURH84q9cm2kfwSaPEVrX8CQun88koUSXgAhdcb+w97MdusyPDwOwCaufSVsZSO0fSh+O3MeKkW2J+vICPG7v06Pr1oSXYrhTAZ+zdBGQWTe6qCCMSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=L7SgNe1H reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="L7SgNe1H"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id ACEAC40E02E5;
	Mon,  9 Feb 2026 10:19:55 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 4C9Q5WVVx173; Mon,  9 Feb 2026 10:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1770632389; bh=qEUrs9aV2UevLern7cWNO8zzbe1KAW/M2x98IuKSaBo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L7SgNe1HGQWJrNNPxIw1k6KgoWfev2wqz1jZbCcdXa3N+r4Sl/iSwK3+WgzxAFLP8
	 QDIumwRX6KDqKNsBiOjqrW8IUFJtEx9sgCqb/bAzmbANjrv039vpmzj4gjo9THzeU+
	 YSeKDxKiC0bvOQQrRgAmB1w4YLy5TCWky0ssa46YJD12Zf3DncxHeqLZnCEyiDvmok
	 ImdQ26bRkjFZie01PrBcG6QN7TlXcb7KBJhmBUxPdA+piF7m7xZKSZWgb7o4p/oBoW
	 65Eq70rBCFjVlN2eomT3o1+/ySJUpqMssMZEfzXq/CyGEHZVfOrzEhVna54KL/dc4S
	 7ZeL+vs8Y7GtRdbrr9C4RHiMxtgKQPEoyMTb//9gb0Y2+3+7wDLh1B9yHuqbWjz+Kr
	 Yb/Ws3PqB19EwD6aoi/Tt1w25wr/ScLec10clV/Mjn/qpU5jib/sg2vHOJVaaKm4Sh
	 oDhL5LGnFq1wjriJrXcmG4Vw3VjwohtUAQmP5GMIB5HnkpO6y85vAK8EPWtn6A4K9+
	 TJ9NGVpHZA3Fht96JrON+2jvKS3NfRstQvYDeF17seJMrMjba69iIQPkiaMVYjiH5s
	 0ihBjjGUpmtKls4QpuZphm5tynBcgqWNyCG4hiKuLtwqpBtWM+74IOdgKLcwwzTB+v
	 5v/tPeD19u9TgLlvgaBntID4=
Received: from zn.tnic (pd95306e3.dip0.t-ipconnect.de [217.83.6.227])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 917DA40E0326;
	Mon,  9 Feb 2026 10:19:30 +0000 (UTC)
Date: Mon, 9 Feb 2026 11:19:18 +0100
From: Borislav Petkov <bp@alien8.de>
To: Juergen Gross <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	virtualization@lists.linux.dev, kvm@vger.kernel.org,
	linux-block@vger.kernel.org, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	xen-devel@lists.xenproject.org, Denis Efremov <efremov@linux.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v4 0/6] x86: Cleanups around slow_down_io()
Message-ID: <20260209101918.GAaYm0plbeXIBr8p9a@fat_crate.local>
References: <20260119182632.596369-1-jgross@suse.com>
 <6ee93510-1f43-4cd2-952e-8ed3ce7ba0e5@suse.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6ee93510-1f43-4cd2-952e-8ed3ce7ba0e5@suse.com>
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 09, 2026 at 10:11:49AM +0100, Juergen Gross wrote:
> PING?
>=20
> Now 3 weeks without any reaction...

J=C3=BCrgen, there are other patchsets that need review too. And we have =
merge
window right now so no reviewing anyway.

And you know all that damn well!

How about you help us out and you start reviewing x86 patches instead of
pinging every week?

Thx.

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
