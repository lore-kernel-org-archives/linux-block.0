Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B24420481
	for <linux-block@vger.kernel.org>; Wed, 15 Jul 2026 15:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784129447; cv=pass; b=OKzgz1nNKlscs7pzKVTy0g2eJ81UplqJJsqLkWkIapQ3Wu0XqI8EGVAg1hpDa8YyRtehGqV5+V8byqCVgx1qVaNeg4ZXSm3ZO9NS1bdp9DKAdiW1X7SeMQKOWLx8nSqrVQpwf7lAlZhzc38yiTXSPRfbCptW+U+IpP4mA3ce1gQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784129447; c=relaxed/simple;
	bh=oih6BEAC9IlPg7VwsK03FEa6S4q91uost2WmMEnafbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z4J27JdHFTy3W8C4SKCe3iCmtobBrbig45hrKfgcXcTUAEsnUKcupLBlfOCHuecfNXYyLQFpgIndot9VrzHArxzbONNcy5tHBOCNq7QLhEyRQZIyg9bbe9Hn7vFoCMByI1ukwjrw9JNpmqD1srUkmnu+AdspDJsRwxAypevxLPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=JyTpB0lQ; arc=pass smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="JyTpB0lQ"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-6a3dabf2d61so48583eaf.1
        for <linux-block@vger.kernel.org>; Wed, 15 Jul 2026 08:30:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784129444; cv=none;
        d=google.com; s=arc-20260327;
        b=Ikb1Wp0KnT9PchVVm66RG+rioFtay/GzA/mjiyoD7bWjRDm4ot7ce6/OGkLGXMs/8a
         tvZL5lgvC4sxj6+1U69Dlh8LKSzGnBCWqRgblyoZ5WGUCGSfTRXslp5AE4cmvmthw4to
         AVGclil6ERKjwSMGhsC2fC4bYIAkIxJ+18k+BuuOEElhAauUfo0LaSVC6zhr7TsZmZFq
         zY7NE+YuU9uJNpZD9GfRKX40/Py0kbqUSYot2yA4AmHqn03P/0nsEKCGYDjsFUpShBqP
         kV7JCARxl3DHFhObzxwh5TXKl/+R1mRuho9azfO6DcT3Gy9xXdSqDT1kIu2xpO6MA6BG
         EZkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ciDlz/JF2okrWUKZolnPsQiK1AaPriH2d5olMSaW/OM=;
        fh=PcgzSuBgc+xtFehY+yeRFIlXX12yQNgPfqmJEs1pbbU=;
        b=DlAzmvf9J89RXHhhcSh0fjrDeYTB8TR8n7QVNYcZDg4NqiMc/dKRg6tp3MxEcS9oor
         Bp8CZhk18o6ypXhQ/vPtD2BMCfsC+XZ8qpBFo8hhZs0/D1Tl8A6BdJQ3Oxdq1V1fdDp9
         eRVCaov7HXvJpolSoFkpuY9LYv6kcGGIyiSP+bk2MydYlBZkYpD6IqKa+0zBd4Y+cBJZ
         Sb7stmzAEvuAktfs08L7bn5IMPzvSc7Tny2SDf1OgbH9/ZCs1JnB4PcCGKAz9Z+QELEV
         daBYMBgXP5O1kilJntYDIeVlmEKLKbCH5PauiYvztOSQCTwm9HoZ9t8qfYyDSO+eAimP
         p8JA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1784129444; x=1784734244; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ciDlz/JF2okrWUKZolnPsQiK1AaPriH2d5olMSaW/OM=;
        b=JyTpB0lQl1DpFqRY36xy7GlKlRfruwo9ErAvpG4MTdiIUierWKGpyV0JkoADMm4sPf
         qCZBt/7QNnfdyRBeEqouVC4xdc931l92aCDT0vK8zlISLlwNm+4h7FhN2MoInQwE6xx3
         8vHCgMbECqVHQw4Q0CatYB54eshrAoYbVuCT7n7GKhn1I/d1ARElGKFMIbx6+1rQBTsw
         PfVOcXotlBZ5QzmVhqxlszI7C9jtDnUisr2RL14ApEjxUWebPZXCJrX+fW8l5P8AbEjh
         gxX42RAvNJfVM/k5RJBbtLN4aUzkMv/8Q3QDnPLI//3GI+MUDGjilh1M9Po5uitcyDGX
         +Xeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784129444; x=1784734244;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ciDlz/JF2okrWUKZolnPsQiK1AaPriH2d5olMSaW/OM=;
        b=P5BUFYwVQHVPGp5YaUSWKzCIsGPZzhwl6TXlS7M/1njnU0TTYz60v3pwW/Y7JX76Pr
         tFKfIv8d7Wqb41pMRXUVwdYQ2kFqmiaQCL62DidnfeSxHYaC/33rqb6//hqJjE98YxOv
         qITFvO3b52rbbh0tWb5JNhrLIb/RobGFoZA0ThR8yuw5HJASyKil09gxnZKLDKejgzZW
         czOx7z+W+wvVQnO8e3m0fHMiBe4uy2JXvHh5CvTeSFmFouP+SonpnulzmhTIv6+HhW4s
         WheMA5aR8FT0AQCgWr8uJ6v+2zeax7yIgRKz/w+kIuBooTzbg3RxR9AoryYDkNSjhTam
         aWIQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrk8clEzEy3mBr6Z6l5bm3ETylH11bLaJ1xXnzkHO5AGItzTAdviWBi+6iSRRECzB/ugxflwvEOs+4Ycw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxO5+nOS0jg00qdNIj2ftLK0H8bNwZ9uSs7tSs+i1I/MHbNPg3H
	+vrMUX2qzR4vhKw6P3yiqU1UVxZnX7oZrdYeqweSlK+i3AA8SMmqBG4Cm4xP/5aJAE55H5Twrn8
	ZLRrYa98/SpdFJUcgZu/QQs+y5O1KhIErffcQ+X7nFw==
X-Gm-Gg: AfdE7cnKTO7W2+qcbboTePrH6IambLAxD78spPUxthwgnvXodOh/cozpV/ONW8bGSBg
	kaxF+kvb4AEMKYc3ARy4rg5GaHj5dnXgI2MYwZ/eHf/bYELXjzNwNkybh77NUTK1m3FUG/hBr0E
	9mr2Hiz+WcINWr9eC23g5lC6rsDH7u682o1cAtAixncrg/ocTtJzpCOMrSWbEXpAxzli+3q4HE6
	O6xiKjrWfir1Pt6/7vVOYLWfnJGSOckF1Ftc9AMTaGcYVhEfJUcVJVq1ReLGCRHUv2UuCYy
X-Received: by 2002:a05:6808:191b:b0:485:7c46:b870 with SMTP id
 5614622812f47-4a42ac4c1d1mr7855454b6e.2.1784129444114; Wed, 15 Jul 2026
 08:30:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260627061933.2187447-1-csander@purestorage.com>
 <20260627061933.2187447-3-csander@purestorage.com> <20260714135310.GB714@lst.de>
In-Reply-To: <20260714135310.GB714@lst.de>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 15 Jul 2026 08:30:33 -0700
X-Gm-Features: AUfX_mxo7lB146q5JXEsmTmctGA9iKJ24a4jDXPS2pCRNBa9UNhJ5U7jlOaJJJA
Message-ID: <CADUfDZoGheGP6JCwwV=BCBnqxAspJ1n9Aes=UsjtS-DxAMxeEA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] nvme/core: advertise BLK_EXPECTED_REF_TAG_CAPABLE
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2026 at 6:53=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Sat, Jun 27, 2026 at 12:19:33AM -0600, Caleb Sander Mateos wrote:
> > NVMe Read, Write, and Write Zeroes commands include an (E)ILBRT field t=
o
> > specify the expected initial reference tag for the controller to check
> > against the ref tags in the protection information buffer. However, the
> > NVMe driver currently always sets (E)ILBRT to the lower bits of the LBA=
.
> > The block integrity layer generates/verifies the PI ref tags according
> > to the bio's ref tag seed, so it must "remap" the ref tags, adjusting
> > for the difference between the ref tag seed and the absolute integrity
> > interval number (=3D LBA).
> >
> > If a request has an integrity payload, set (E)ILBRT to its ref tag seed
> > so no ref tag remapping is required. Set BLK_EXPECTED_REF_TAG_CAPABLE i=
n
> > NVMe devices' enum blk_integrity_flags to skip the block integrity laye=
r
> > ref tag remapping.
>
> I don't really understand how this is supposed to work.  For type 1 PI,
> NVMe requires (E)ILBRT to match the lower bits of the start LBA:

Good point. I suppose we could only set BLK_EXPECTED_REF_TAG_CAPABLE
for namespaces that report Type 2 PI.

>
>   If the namespace is formatted for Type 1 protection, the value of the
>   computed reference tag for the first logical block of the command is
>   the value contained in the Initial Logical Block Reference Tag (ILBRT)
>   or Expected Initial Logical Block Reference Tag (EILBRT) field in the
>   command, and the computed reference tag is incremented for each
>   subsequent logical block. The controller shall complete the command
>   with a status of Invalid Protection Information if the ILBRT field or
>   the EILBRT field does not match the value of the least significant bits
>   of the SLBA field sized to the number of bits in the Logical Block
>   Reference Tag"
>
> For Type 2 this remapping could work, but doing it unconditionally
> will make all data written using and earlier kernel in a partition
> unreadable once this changes has been applied.

I mentioned this in the cover letter (and that's why I marked these
patches "RFC"). Unless you have a clever idea, it does seem like an
insurmountable obstacle here.

Thanks,
Caleb
