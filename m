Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BD13A0E8A
	for <linux-block@vger.kernel.org>; Wed, 19 Aug 2026 14:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787150177; cv=pass; b=GPjKKrQ2P8AF5qZmeeok3foYbTg8DoLAmwBP5Y/+iBP4zp0+mITHS/Zg9LdHRrn79StWHDeXKjn271p6XAGCZnkT1aasVN+jgOvBaLi+W81G1W/538An/9tll4PZrhj9uqw5rxjR1XedK3BuThJpCNt/8aAFLTUEUQ+cAYx6XLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787150177; c=relaxed/simple;
	bh=Rermr5O7zQBvdp7UlCslACPvb4RLrNoTG3kGofUdVhU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i6KFYlVybldhZHOCitpRwyWh3J2ohyEvaSsYz2Fy62zT9MwZ69h9JjurSyzFJWM23LR0yWMmndN676DMttGvmt6qsMtCg52e0RpRHoaXU6Ap0CTTNkOBzrjrWvz16hp3v5TtVkSGa5bcTma3Mx2unMnu9xFP3lf6XxCB2Sl3LiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M8jL2mJV; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M8jL2mJV"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-69fab5a852cso1797702a12.0
        for <linux-block@vger.kernel.org>; Wed, 19 Aug 2026 07:36:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787150175; cv=none;
        d=google.com; s=arc-20260327;
        b=qrvtxKL2fc1zLZ6284ioq8ue2zDklx6m7H/i0FYZy42IWK8ehitrQJ4oKcgt/Md4Rs
         /UMQCFtry62P1KHAwhbtew0wYQQ4K0aepSa5FGricl/tBsPbN41IX7/82zdLBio6vKnp
         O4ZxBmkzhq960aNbL3Uu/2Bmmoy//lcdnv8Jaqoz7ezbhrO/DvvstPczf7o8p2/MngP7
         e+63S+1Bxb0I7z3vKmq8I/z+mxoJ8iCWEV1oadAcWAztMWJPgBK+3fYuemZ4HRxArmrv
         3qsEIJgNKpdz+qKDXhksBahW06NT8TjRNZdCmxFo/5dQpdsZsyBNMS7UVYWtKQZ5tGum
         ZgoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1kxdqNC8r0qbvk7oh4vDXSfmPCJ3uT/yaEKKebfKREM=;
        fh=kuPcR/DDXUCec0jASfngLiudeQxn/Q5BQ+vAqpGBGhU=;
        b=LKMUzB1Nldv21mp/UofYOHO0mAV2egxqlP/K+zUfaIRqD7pcfuawQcoIFlsDyNknXL
         AbKlt16UBYNjJcud8gFZigp3JcX/p5NrDLVWOXNsVaxRP98NZFrL/+B7KXchtDWDZnYL
         rgptXphdelfEPK9AuoTdhs1WSulHotiaQ1vz0zfjuZRduK/a8h9/IkiaLl/XCXZBiCzd
         1gpiauX2iWb+6wJws+8/Tu9k3FQW6cIuOhKY77kVvYaOubX8+mZojf+XPx4kHybrhThB
         C0Q4P/8Uoi/8N6qQahMc45NwFyoOeUPCr6h6bfK9dQhY41DCeioziiH6Td4R3DCw832x
         YVyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787150175; x=1787754975; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1kxdqNC8r0qbvk7oh4vDXSfmPCJ3uT/yaEKKebfKREM=;
        b=M8jL2mJVIjpcaBqmSS4xGCauftiA90F4fg6wSDz5FLRZwVNrjAG0X6KZ+U0MzZ3KAa
         g0+99O2aHmPSIrmpu8Mmh7tSAFx4p3kIilBjVJg3zgMUpjYvlUHHncAFtsZCvynCmXHA
         BtVVzLopGmx+A/epzFEsDkDsJ1+o3XChftnOyCNxH5ENxLsT9I406YlWXszvtv4P7GPk
         vrDUo3/FcpErUCyMevGaqb4W5tHPSb0AUrcwHwzH1gLYTv+/qIkmDn8Ku6mf4pLruOCn
         ar0QtIdsEJvhLkt4L7fWOwsAzn6HjF+5bGec/iXPTVO4WQtITMGCg4knsNtknQ9UuFU4
         JWNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787150175; x=1787754975;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1kxdqNC8r0qbvk7oh4vDXSfmPCJ3uT/yaEKKebfKREM=;
        b=FpRHdhmL31yUZ+/AQt6gUJe6dczREQVob2ebA9ymF7KFy0U23C2XCe3s2hHoOSjpkg
         9Np7zvXJlHV3mt42Z5AJRVzLuGq1Mgus59VsXVIK5EnBwNiHYinWzs3d3mgs7nraLHNq
         TqEfn1XPg63+bjtiNhxz7HYrphNwAX8E/brxToeyRTMJMKcHHnPMF5+U3Kk/7DyJTmdO
         0A7YYR8FXGkKf3Zj/7wC3DqxTIQ4utv9Qw0abi09uanzT0OmvBEe+UkM++UiOS+RTjur
         Vqu8Lz5J6gsuuRpx8nwxXjuvQBrQfh4m0C7JO+vX1qMo6yf1dlbscZGI46CW4OPNED5T
         7e5A==
X-Forwarded-Encrypted: i=1; AHgh+RrH5xj6zSwXxwrdI+IN6FvxtHxKN20p7fx1Sx4w1//JFQtQDMwHgYIgso+P7wReXWr6rzrRPkk5znBnnQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyproxu6rrqvFjrmPhm6L/djdil9jATrp6YnK6J9nfrwrDiqAKJ
	yN9TLYCdB/sjrRYYLCXPv9oebONUb2KhFeUvRQAC311k1pedrPZe1tLp2BFivPcYOeXaOFg1zxJ
	rU8rF5+8996GmLCCiHa6p9pyioCdxbxk=
X-Gm-Gg: AR+sD12jvqN0GizC0+X9B2kulKjG27ZV6GCF2s9hXfTZzlydX+jfB50YC8TNVuQvIor
	4i0tT+LjZB/siU0RrrI1Uc6HVl+Nc5CRpSeFNhbrkmGqmXDlJ8lxCyh5Csa6xOAqGsD565ZKil/
	3lTK1t5i/PvuRHW+/UNVq/eNblmgJ9xB8BECi4y4Wf8EovKl0Jpe/p9JTyKWBHes3ZUy6fZYegV
	b6McV7aa5pEfgHRgP7h02ExUM+sKBrnW9aHVJplqF/614+5ihqlaoutcMyjNW1mny7hmqfdg+LD
	wc1IyeVn/koTaYlwCOgZWkIHHq0tY6D1Kmq2Inas38Jx70dE/c5WiBzP
X-Received: by 2002:a17:907:d26:b0:c19:473b:dc8f with SMTP id
 a640c23a62f3a-c241ec8aa11mr334124766b.3.1787150174511; Wed, 19 Aug 2026
 07:36:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260817195833.2971170-1-coshi036@gmail.com> <20260818220420.1@kernel.org>
In-Reply-To: <20260818220420.1@kernel.org>
From: Chris S <coshi036@gmail.com>
Date: Wed, 19 Aug 2026 10:36:02 -0400
X-Gm-Features: AcwNN1WltV1r_MTk7wtZqp-XXKU1SfgA5uG8lLKnaTaE-VD8qiTLMOfCcUY1ZW8
Message-ID: <CACd_6n2VRLvabdA5UVPxwtW34rAacbnssrMKG8wwWx7m8AWVtA@mail.gmail.com>
Subject: Re: [stable request] block: stop the timeout timer when releasing a
 never added disk
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Weidong Zhu <weizhu@fiu.edu>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you!

Best,
Chao

On Tue, Aug 18, 2026 at 11:32=E2=80=AFPM Sasha Levin <sashal@kernel.org> wr=
ote:
>
> On Mon, Aug 17, 2026 at 03:58:27PM -0400, Chao Shi wrote:
> > Please consider the following mainline commit for the stable trees:
> >
> >   26cb8ebbfaf7 ("block: stop the timeout timer when releasing a never
> >   added disk")
>
> Queued for 7.1, 6.18, 6.12, 6.6 and 6.1, thanks.
>
> --
> Thanks,
> Sasha
