Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D4B4AF9FD
	for <linux-block@vger.kernel.org>; Tue, 15 Sep 2026 17:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789493297; cv=pass; b=IEGrcYMnh64T/DMkpgDKN0IGNSKqMk/VS7kY2cVMEoY8R4vVvqaTMeTepDvh2qRg+kJknrQWUirE7S+Q4VNml+Ji+JPkimV9GjWq7nU2va/lUPmfzZBNTmFRzjbCFSSOcB325Q15aHP9p56DY04+q8ktIhG9UJBUUTkzq+F73dg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789493297; c=relaxed/simple;
	bh=cXz8ov4bwHxMA/tyqY3Crch8C4r5Qa4kwtPDiQjwdE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hy4rB/KFnlFribqjM2HIhk1iyRIvxztT9F6Vf58uugO3qu8gjVAKm+0uxemd6Kqdb/fV24U1q1dBk8JwstOJ02bAWdhYNhBUBzplwYemUbNlm3WGoafOVJ8pA/Q30I8VNtafmUBVicEf8KoTZ5Q4Nd2L5BDbQg4+Rg4vTicwR5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uci.edu; spf=pass smtp.mailfrom=uci.edu; dkim=pass (2048-bit key) header.d=uci.edu header.i=@uci.edu header.b=iAnhVCfC; arc=pass smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uci.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uci.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uci.edu header.i=@uci.edu header.b="iAnhVCfC"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfc9b6ebso172966d6.2
        for <linux-block@vger.kernel.org>; Tue, 15 Sep 2026 10:28:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789493294; cv=none;
        d=google.com; s=arc-20260327;
        b=WkjrWFfgvFTCkm+FPKkJvzjwdyQxBYYenIptEpSPr2lIpBEjSoSpWijoOfZ3VgRldQ
         vQndSqnvsTk4kUOKAKMwsIpUGADqxYWD0Il3CkvBLSM8P3ZBZXG7kiSBpOKPwtNKKhts
         WNNqgR1hTB+a1qolFuEX0O1WLX9Qlbr80OSh3/8hUfqzj2S08wNDU0kM0gWUFn1skw4v
         lhD7CiTgl6tXS7zQle924xNqWt2YMj8dkpsMC46VrG6r5NC6r3ilB+FLb9nrp3yYDhNI
         bvdPGfuTb5zDr3F3IHJ0jF2BmSJ41AcC4cTQ3fNA8Mv+T2cvFQs8BrGwjd8p5663nyiN
         52EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cXz8ov4bwHxMA/tyqY3Crch8C4r5Qa4kwtPDiQjwdE0=;
        fh=VKPVrwyyT14wG427tzszc+fE8CYO989fkh4b08uh75g=;
        b=N8tiMouk39udsrnwI9Fq2jowal71aRLhBl4d+USzR3bsjieUJm6itrqj8rpxFSA37w
         8/ZG93R2Tb+MIDeLQP9QUmpQ4RdvJhe8haddwec2+2G/USgkBWHE97mf1cX3X4a78ATG
         h9b34Gkd4ebCIHDBfPTepqfKZ60be5CZ4zqvSQLIxPLVMHC5OYQHTAvJ5AQi5j25lheh
         LlZhErdMWN6VYl55ZwVw1upDaR/P6TPng8JSb2kaF2rlxybAN4pCuPsz6IVLll14bozG
         0nfMq+87kQoynl0xvurUlWpI/yfaRvMatkwnE+bi5HjP4FYTurXIg7qW+G2pITty7nhZ
         /Sag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uci.edu; s=google; t=1789493294; x=1790098094; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cXz8ov4bwHxMA/tyqY3Crch8C4r5Qa4kwtPDiQjwdE0=;
        b=iAnhVCfC/GstWFVuRgRJqT4FHWl13NHy/zwExXynjnm5UUwuK1tsidgxWQTwSqUx9R
         iw+pGss6Ol7j5LSJf54+7JMruq5s6Z3ikQxyL8zjpo+Bka5bxohBTljsAVCpmcNt78YA
         SIPltXHdi2JugNArVzfhsR8X4gEU+dzBj9DGBO4drkD7VsrbavxCH8Murp1LwLblpSQ6
         aWRcFBUDQEfJ9h8r8ArrMo866/Bt3evWV5F6xJDsQxnX569NPYUqjPqaXBKFT/F6iXja
         QEvgYl7qyWGnxOpcKwZTloXr+myvGFYdQTOWpzXzP6c/AKdplgya5i4X7g4YfrFhNo6v
         HyQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789493294; x=1790098094;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cXz8ov4bwHxMA/tyqY3Crch8C4r5Qa4kwtPDiQjwdE0=;
        b=rbiJxaPVeHcRKnTwWzvk44zZmk8mOtvVsdGt195ZwCO/yHH9q8j8XCrhg75iDMsr/K
         fR6pZn7D4ZPZAelawYHwGy3oWdNgR9nCQih0N0q5vQzI6vMxX1UYjW6qYr9zZ9M0FeuV
         SgjvJ18CI81kwg3BX/3geN3+tBilBQuWnA1QOSFgNA8Zcj6Zqx4EIYZFm4E1YvRUE6zn
         u3LwPtibYJJZJN10NZPveMsS3twvLe0LM+BRdKz++KNRWAIOWHULNKIEJSmCqSztRZIa
         338v2oyj3Im1kBeuUIC1EtPLa8Rp3V4/ZXOGjNTLEzN7ZmNsE7yVrD3LwYRmMBiTE7wS
         QZcA==
X-Forwarded-Encrypted: i=1; AKwUvBzd9CkWTAODClGloEuBDks0QVOScOuks6ilKW0qNmqMtshAbJw00flZkp9JWtN6QSOiI/kIOK9gKFFjkQ==@vger.kernel.org
X-Gm-Message-State: AFuF++lm0f+hwFQlG/6ho4KAB9hv2vcR8WkSlZ17Xnwzrend7VRntncx
	5/g4xRhWWGoB+McguErHcKaw4bG916R6Q+5RBXFA1F56GB7SmRpCA0HSdZ6pX84K1N03MI4GdYx
	vxmOGpIsjvLdqDTa0Wjo30+oTycUJy4sNwVC6Hls3Ow==
X-Gm-Gg: AYBFou3K+QS4F+YBQhFPR+F+hu1Qsne8/kzFR/qRNXLmHGfETG7DIyGQqXJC8wzz5yb
	9I4uqFTJqJO/6YXYltr2+nZeqR5pWYi49aZAfFJdPoGBxAiqaAtY6FkkCeoykJSsHP03mVX+PlY
	f0x3NPSsRq1+ZJZ9bC77UD1q6/raDn3Mp83CtiCyOy1hbYNSkwuTPM/jCh/yxiJve+qa//lGY3H
	oML5eYZZ3mkIqVUk/fIiwqHym7AHB8Xlsw65/pFg1pN8HVPSdWqtOt0JPycl+9XYx4uBKSwZBMX
	UGS5wCLQer/yg7D0sZ5eWTmZ8PwJGTiDy9/Ro7C2Xue4dKhQhmnTApRGWCuEu+tBgT5m3TPWt98
	B2S09PDlOIZg=
X-Received: by 2002:a05:6214:4285:b0:90e:873f:112b with SMTP id
 6a1803df08f44-9122e51912amr132309106d6.16.1789493292175; Tue, 15 Sep 2026
 10:28:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1789420324.git.pgovind2@uci.edu> <f515b62bb05e7b6bf0bb06c8fdb362486fea25a8.1789420324.git.pgovind2@uci.edu>
 <CANiq72=jRupLtnQSnAewyZZC7q4-oeAVmA=SfBGN+z_nefsnvQ@mail.gmail.com> <CANiq72nPhNRxesnUQ3HKBxtfxUD4r5rPYVQOxbiOAvpEtzUrbA@mail.gmail.com>
In-Reply-To: <CANiq72nPhNRxesnUQ3HKBxtfxUD4r5rPYVQOxbiOAvpEtzUrbA@mail.gmail.com>
From: Priya Bala Govindasamy <pgovind2@uci.edu>
Date: Tue, 15 Sep 2026 10:28:02 -0700
X-Gm-Features: AcwNN1WfaadzBgQ5koNE2WDSXdYwEBE4lZ6PVotun2aDdrF6D5VwA-Z1FB1DNk4
Message-ID: <CAPPBnEYRjm80r2v=jBnRS8xGf4WS1g0vo1=xagu+xPxixxb9wA@mail.gmail.com>
Subject: Re: [PATCH 1/1] rust: block: Fix unsoundness in `Operations::queue_rq`
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: a.hindborg@kernel.org, boqun@kernel.org, ojeda@kernel.org, 
	rust-for-linux@vger.kernel.org, ardalan@uci.edu, zhiyunq@cs.ucr.edu, 
	dzueck@uci.edu, 
	"linux-block @ vger . kernel . org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for your response. I will send a v2 patch addressing the feedback.

Best regards,
Priya


On Mon, Sep 14, 2026 at 11:55=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Tue, Sep 15, 2026 at 6:39=E2=80=AFAM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
> >
> > Finally, it is usually nice to provide a simple example when possible
> > of the safe code that triggers the issue.
>
> Ah, in case it helps: the cover letter was on my spam folder -- I see
> you provided a full example there, thanks (it may still be nice to
> show the key bits in the commit message, e.g. the part of the impl
> that goes wrong), since that is what will be kept in the Git log.
>
> Cheers,
> Miguel
