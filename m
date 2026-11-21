Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795234456;
	b=DunfKc2Zamm/PiRX/FYtpxSy8fvnJ/g+TrRPqV0PqWMJr6a0mpoXATSGgvDaqzMnGTev
	 wZRsjc/TShhpe8xUik+mTbEtv9w0n7YNdS+FaQlfqXj9rRHELxotQ99NQM/H0kzDvMmtg
	 0i/Oam9rxelQSY/Jy+wOSNNCR/VFBc3vEe6hZQZw3RiAHXveZ+uyiQB75VXoff0mYWv7X
	 RiYmcaIylV2pfluxRqU6ahmbF5oqK2H/R8M/Ysb8gvjDChePTycjRitgkTgPengUkblXK
	 1d9RAUMMARJe2Uanm6BUcEQJfDx2hz32h6AGDLDHLvKAEg9AktxYUpF8l88sc2Cw1WA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795234456;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=3VWikePojs6Z/sOqx2CC1EDbJrjAJsIrE6pNTxCdNqs=;
	b=o6Y3x+67Fv+//Uesekp2UnDHZW/3AmggDhGXmVC71ZAT6d7t/ao4NOEUfH+WM1SHZZGp
	 9pnCitkjjmiEf8k4OvyYMT3pThKsin0lBFZYkoF5ZDhU2lBspu+H2A4nZusy/UMjc89td
	 ioYf4UAq6xj7e0PTIYPdshwD2peBBaOQk7yCQw9kfK70ZNh1FEzDq4mR5w5b/qkeNFn7U
	 IhDp+L+Mv+2OEy1PsDveS49KBVJS4sveAuiIXu7RPpAC2rkQ2BC0EVbz9x1Csygcv7uHV
	 pP+/uUxe+h3J7IvqV6WQ+1VDnMrsDdR/KIyLwHvMzbkdpwtqifJkHGDPXSIJdyjz40A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=purestorage.com;
	spf=pass smtp.mailfrom=purestorage.com;
	dkim=pass header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=K3bPr1S0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.50
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85214606A6A7
	for <linux-block@vger.kernel.org>; Sat, 21 Nov 2026 04:14:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85214606A6A7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=K3bPr1S0
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-71ad3b9de7aso73278eaf.3
        for <linux-block@vger.kernel.org>; Fri, 20 Nov 2026 20:14:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795234454; cv=none;
        d=google.com; s=arc-20260327;
        b=gb3jJffNoqw65AENps83ChHMPkgOHMXQ603NKqTQKTPv1myCruTrY37voOQ7/agpeT
         ud4nqAkQyeg2WjPhIg5W54SQNeSrMOLZmL6/EJRwzlnNgY7+D9E3IFssH+ZqTOMpnkuZ
         aigcR+dRWcNCD3S3fecLJdGm1s1HpmsRTtd75hklaSexRhC1ci1mEHfsv3dDk5A3p/1i
         vNUZvrF01heDE2DM4j8wK3Pdn3dZAtVwVNjqWbHts6826Pjhcz9Q4TvpuYti6BDpv6Ik
         ZG9QukTrSTnHA8mcYxlwotAkdr5uKIOK2W8iB1vqetC1hO10qo6HGw87ZpqH2Pp8aUSk
         5Z+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3VWikePojs6Z/sOqx2CC1EDbJrjAJsIrE6pNTxCdNqs=;
        fh=D63ND8xLIyOBtxG7CM3KeUcrirNaZAMAPKr49wm9Rm0=;
        b=J17Gks7DnoPHqHk/WtKpBlxqxCPQ7M0J0sz+nHdSQRWtvXfmB0UxAqStvZvhdFTQO2
         1tu0WTedbjuCIBFAC9vOiS5hKCc2s6SrcWFxiq/jMVDxG0p0Vxx4v8vlnSdJE6Rl7fwt
         EfOYJU4AtrSWXv2rzluOcJmgifoARdVqwWwg7Dv0pgXKUVoLhjz4RyrgY3D2uE5lMmwJ
         nQaycKFb9rPAkeqRf6u2PZwgFCU0+JmHhTbSEMxhNvnGEFDEUUC//HdIryPYZ025zT1M
         VRtaG7GipSt9sjHy+lalM15HLZMdsFSrXOyjaVFioOpwdA7KqMPPwxzoEysR3WpaEzyP
         IZGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1795234454; x=1795839254; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3VWikePojs6Z/sOqx2CC1EDbJrjAJsIrE6pNTxCdNqs=;
        b=K3bPr1S0ihAhALCu7A9KmU/u8VZ1fhbV5BeNsDZUZUUCpiWJYUQMYcu7a+ws3qpVNk
         frFSBx6zuvxBmaIvLzzDUZYLu+CVS0HeUbDLDCzlTWEcY7ILjSk3h7mQNZZVSQwr1q2Q
         TcG/rI3edxM54Gb4ZAS1KFxg+Hx3hAmlAtLeBx6rz39MJX2t8MDWfpho/mmSho0zmpM0
         Dol6+ci4KTWP5gO3Z1oE/WfCV1KA8WVa4APSptrpNLRiknH2F5YIH/62q03ePu42jcqT
         901bwEO3AYON6vRjveAv9PBwzCLstzc9L8HUfMvw4w07E8mgpNarILptfQlV0fxYA1Hf
         JGIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795234454; x=1795839254;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3VWikePojs6Z/sOqx2CC1EDbJrjAJsIrE6pNTxCdNqs=;
        b=2oHC+ycWD6CJm4vAAwsuxxhLAWNdDMg7u06ogXlllwXCXP08UdM3C50se8iQTWBEmn
         tKZSARLeysAlMpqK9uP88oEPkI+K1+F4FPkqLJc35m/xhCvwHRIzrOBKnRqNtovdC6j5
         aprMRvm13KsLqGDRj6jjFX78e9yf45JbwhoLMrHMzvPgTagJ1bwg1IVoXEEep0op4DRd
         MSCv6bsJZZVUUhstQu2H6l86+Ru477Tci0AJXj5TkQlyvGBdKuMu0va1QZRyN1sGhGnK
         8CL8BbMYv9C5jV2489Goa9guq7HUNadpL0SrMqw4Yv9EmshHMqLJBXIsizmwIMZrAZDy
         brqA==
X-Forwarded-Encrypted: i=1; AL+hErFxTBJ4ZZg+NEDMobnc7s8Werh94aOlG2Nvr/Tis2ihMCLJgfSRBRbx+eZFDmfyjuYsn01TuaIUQegyKg==@vger.kernel.org
X-Gm-Message-State: APuU4Z83jGCCxKghp5RT6TtvpTz0+ZwFj+mcSC2NABRTvmxy3/wttnM5
	4ZT4ZdEyGmv9DTiO3/SbyQSjuYz4hbAJ923PUcifv9d+mVCBAFOGi1HZo3Gc0LL6/x+k51LJCMC
	dAdIXPA0q8V52z00EayDvMf1Gu/UIrK039+o9wzecOw==
X-Gm-Gg: AYBFou2AkThVF2hA4qpLkV2L91ub04A+wyEWZADoORn2VlegFOFHibdpisMqnxLzKnu
	qt6v2XrY86oAthRfxHeURwTaWZcIwUH+dpj0X+a8BCDy+wi8rhexuiVh8xgqu3g8LF5n5S/joWr
	vRxSL9bwjgWwXDvRYhIMBXFMY3ziU2H+l0jBRfWjs/ORiHaRypmMJZG/Qkd3JX4P7YFH8/Fpam5
	OJMK54Bqh3G86L98yJ7R1rECqF6X5p3X0l1k2Ai/ilmDve/5w4mbPR8mej8WmkQzrBlxWkeUjNu
	i0NakD8eqT3+qJMS7J+JzMNF/OTrJ5Rmda4ROMQKfjyuhYE48pjcYrxSSegGfCNve8aymYC3eqf
	3hsfCrdVqQLvF+NRngafuvRFHQmy8UYm0IP2x
X-Received: by 2002:a05:6820:840d:b0:71a:ee8a:5d26 with SMTP id
 006d021491bc7-71b3903669fmr4532415eaf.0.1795234454393; Fri, 20 Nov 2026
 20:14:14 -0800 (PST)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261120064806.752251-1-csander@purestorage.com>
 <awBuiVyOQj_YHCZD@infradead.org> <CADUfDZonvcOkM7DD76Gg=Z6NHhM87a+n0xPirfTYS+wLLnHfmQ@mail.gmail.com>
 <awDjRMv-TSvZKDdS@infradead.org>
In-Reply-To: <awDjRMv-TSvZKDdS@infradead.org>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Fri, 20 Nov 2026 20:14:03 -0800
X-Gm-Features: Aa3M54oMrehaCiS0ijZqohcZujok_ypFHbY0vJAi3ID-ob0bR0tgHb-XgCK5_G8
Message-ID: <CADUfDZrXabOX1qM_4DrxwhQSZGo2tF6KUQ3yhDSgBr6hSGyUDQ@mail.gmail.com>
Subject: Re: [PATCH] block/t10-pi: deduplicate blk_reftag_remap_{prepare,complete}()
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 4:18=E2=80=AFPM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Fri, Nov 20, 2026 at 10:29:18AM -0800, Caleb Sander Mateos wrote:
> > Sure, happy to switch to an if statement instead of the ternaries to
> > initialize from and to. However, the code generation is worse with the
> > 2 calls to blk_reftag_remap()/blk_tuple_remap(). The compiler doesn't
> > notice that the calls are identical except for the swapped arguments
> > and emits 2 out-of-line calls to the function instead of inlining it.
>
> Add a __force_inline tag to blk_tuple_remap and see if that fixes it?

I mean, sure, you can apply __always_inline to blk_tuple_remap(),
blk_set_ext_remap_ref(), and blk_set_t10_remap_ref() to force them to
be inlined, but that doesn't change the fact that there are 2 separate
(inlined) calls to blk_tuple_remap(). That makes the generated
assembly for blk_integrity_remap() significantly longer. I don't think
compilers generally merge common pieces from if and else branches
(even if they can detect the common code, they may choose to keep
separate copies to improve branch prediction for any nested branches
correlated with the outer branch).

Best,
Caleb
