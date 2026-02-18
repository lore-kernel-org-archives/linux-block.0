Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A69D377EB1
	for <linux-block@vger.kernel.org>; Wed,  4 Mar 2026 12:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772626345; cv=none; b=gdz9WWPtZPRUZeXsac59UKVdKAjHQkeZ7ZgBXHlpR2m3lPCIrNaBt3EV4Zw9lnDLKvIfpcsUKIQvY7QYArgpFUFz8ZgHsNTBUxVWCBC5DpTAb1Uqh0OOrbGEehNG5wEKhTr8ty4c7hUAbTnOF/DP8sdHx0kq8G9RKCXWvLK9jtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772626345; c=relaxed/simple;
	bh=5PBIpDZUoWmzMLSSr4AMFrJThU2kmJNnnlCij9fJqvY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=pKjbOY9mIVma9gR15fqPKO8fuO0HuTYrB0nEhfCln5wmpLKVvK+bP8wK/I/yVfiyik7qDwQ3YXpKbmlBDSAMJUs2Q1mXQa7/RgCy+AtluqiEvzXIDdijTZcxxor8PUmZQW52d6XSaepi3I6+MOh2cvr42mM1lbvN9Xdv0FvqrTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g1QdB4do; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1QdB4do"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-483a233819aso66635455e9.3
        for <linux-block@vger.kernel.org>; Wed, 04 Mar 2026 04:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772626343; x=1773231143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5PBIpDZUoWmzMLSSr4AMFrJThU2kmJNnnlCij9fJqvY=;
        b=g1QdB4do0A00IJyh4YOenmWRPZje1sfomIaSWdoO5KTRgO5tXJt+8mlCMh4NOULI3l
         rajd1URAhDYtIrrmC7Dl/9yuzzy8LzEsml4ruLw7DdnS09rB16NeTdd7e17rNUvZwSC9
         y+RCBni71L2aJUjNqpgSclEzrHB+j8xSMBMGs5fNrBqZPMsOo146NKaZo6xVXlNICYlb
         g2AeNcNca+Mrv5i8L09J//xIzssGVbgx2Z2jiMX+JshtHVijnA1IyOo5laJ4LKvYUL5U
         +z9CSoTGiJuT7cMFN7y0ehzUnNCJf7X2eg30hxprGKPIPBPU+2akv0N/0WUYrIgQfXls
         jMCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772626343; x=1773231143;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5PBIpDZUoWmzMLSSr4AMFrJThU2kmJNnnlCij9fJqvY=;
        b=woc7cKY7SE3d+8j2NNR3J/PrXWoZli/+OOBJotPfpUYgxYi/F616TqEi1Mverv0byE
         lGFaDUAGsjfr8Jxzdkp1UogZrdPNI6+RJbaPH2h3BG/vHXT4dorteoIxSdmvFTOrld2e
         g7t1bc4xmbIc9mQAj/uW3Bnmj9HXm1mMFDCAD5UcGPBEqyD2qfp/xzQxjoWOwyt00voi
         U/dmDJD2RGXC+29qRKayVLmSXFyPPQ/KwkcXPd+2NjZ9pSTDwy2zdujO3aim/omxaIlC
         S6kFZOAy8nrb8U5ILnwd0qVK5qKehEwXQXNC7OJtJ2a/Y0EXMbuQTshy0E2dSDkdlgJN
         Y3AQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKkGE4Tvoks6ihIYraVBUjACW7FioqY/AxZ0ww9vufcpsS4YZN7Seyi3qMROD9dWv/+HpIt4K8yJEYlg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxEutVnHEeCEKgnAydBsBkSZoABcWWkX09j+X3M735bmOlLJgAc
	c3NLlEZ08PUOMRb2eP189n5x1qLBcQ+6BU85elMmYRlxwIB8jeYGsyjx
X-Gm-Gg: ATEYQzxX9ypE1o6l33cXDRK0LOYBLPFrS7MW3q3IxC0NRAlRbjBNfKkg6y/tM1G12gC
	W8/InzZrrcbtdSK2wjEuRr15ng/A7Hlicrh8WbieUYCGWd7uoSsm2TlCNgRkHksWXzXrSIB6cs/
	3WF2zYPejFA+uZOKWGfNteiV2yj7yNGH4g6UP+iCPSj36S7gWYApy7cNbVUQBY6BkWYV0etyqWr
	4ZVXFMzGlsN7Jx14v9TCXtFRiIjhXYSH2PicP8oHHmxyVwu+tIRg97k2daJeX6tZ2kwOzD+XVku
	VxjW3l911Zlp//4vCRWekvJbB763NERBCMALQQIwIhQcJQyr+2ydLfpu3B7gnErpwosshkG9Bj7
	Knin9acCLOfXKPGNdB2Wl7r0qSWuvdkPUvcADEoO9tcZKbNNflDoWURbkFJqV121+756rfBgfaL
	bZk34aJ8QBwnJr6ogcr4TrdcRoqA==
X-Received: by 2002:a05:600c:1f85:b0:47e:e712:aa88 with SMTP id 5b1f17b1804b1-4851989f765mr30694295e9.31.1772626342560;
        Wed, 04 Mar 2026 04:12:22 -0800 (PST)
Received: from imac ([88.97.103.74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485188923c2sm48580075e9.14.2026.03.04.04.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 04:12:21 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Hristo Venev <hristo@venev.name>
Cc: Jakub Kicinski <kuba@kernel.org>,  "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Paolo Abeni
 <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,
  netdev@vger.kernel.org,  Josef Bacik <josef@toxicpanda.com>,  Jens Axboe
 <axboe@kernel.dk>,  linux-block@vger.kernel.org,  nbd@other.debian.org
Subject: Re: [PATCH] netlink: specs: add specification for NBD
In-Reply-To: <6a1339999b091edaaa15e34aceb7961dfc61581b.camel@venev.name>
Date: Wed, 18 Feb 2026 11:28:44 +0000
Message-ID: <m2fr6yl28j.fsf@gmail.com>
References: <20260215180309.2255721-3-hristo@venev.name>
	<m2o6lnlg2y.fsf@gmail.com>
	<6a1339999b091edaaa15e34aceb7961dfc61581b.camel@venev.name>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hristo Venev <hristo@venev.name> writes:

> On Tue, 2026-02-17 at 12:17 +0000, Donald Hunter wrote:
>> There are yamllint errors:
>>=20
>> make -C tools/net/ynl lint
>> make: Entering directory '/home/donaldh/net-next/tools/net/ynl'
>> yamllint ../../../Documentation/netlink/specs
>> ../../../Documentation/netlink/specs/nbd.yaml
>> =C2=A0 159:81=C2=A0=C2=A0=C2=A0 error=C2=A0=C2=A0=C2=A0 line too long (1=
04 > 80 characters)=C2=A0 (line-
>> length)
>> =C2=A0 169:6=C2=A0=C2=A0=C2=A0=C2=A0 error=C2=A0=C2=A0=C2=A0 syntax erro=
r: expected <block end>, but found
>> '<block mapping start>' (syntax)
>> =C2=A0 170:7=C2=A0=C2=A0=C2=A0=C2=A0 error=C2=A0=C2=A0=C2=A0 wrong inden=
tation: expected 5 but found 6=C2=A0
>> (indentation)
>
> Thanks, I will fix the lint errors in v2.
>
>> > +doc: See :file:`drivers/block/nbd.c`
>>=20
>> Prefer to see a meaningful doc string here.
>
> I will add more proper documentation in v2. I couldn't find any
> existing documentation of this netlink interface, so I guess I will
> write it myself.
>
>> > +attribute-sets:
>> > +=C2=A0 -
>> > +=C2=A0=C2=A0=C2=A0 name: nbd-attrs
>> > +=C2=A0=C2=A0=C2=A0 name-prefix: nbd-attr-
>> > +=C2=A0=C2=A0=C2=A0 doc: Configuration policy attributes, used for CON=
NECT
>> > +=C2=A0=C2=A0=C2=A0 attributes:
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name: unspec
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 value: 0
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 type: unused
>>=20
>> No need for unspec in the attribute list, ynl codegen does the right
>> thing.
>
> For me `pyynl.ynl_gen_c --mode uapi --header` no longer generates
> `NBD_ATTR_UNSPEC` if I remove this. Is there a YNL property to specify
> the name of the zero value of the attribute set? If not, should I
> remove it anyway, changing the generated header?

Oh sorry, if your goal is 100% equivalence then I guess you need it. We
have the same in "fou" for example.

>> > +operations:
>> > +=C2=A0 enum-model: unified
>> > +=C2=A0 name-prefix: nbd-cmd-
>> > +=C2=A0 list:
>> > +=C2=A0=C2=A0=C2=A0 -
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name: unspec
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 value: 0
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 doc: NBD_CMD_UNSPEC
>
> A similar question applies here. If I remove this, `pyynl.ynl_gen_c
> --mode uapi --header` no longer generates `NBD_CMD_UNSPEC`. Is there a
> YNL property to generate it? If not, should I remove it anyway?

You'll need to keep it for equivalence.

>> > +=C2=A0=C2=A0=C2=A0 -
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name: connect
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 doc: See :file:`drivers/block/nbd.c`,
>> > :code:`nbd_genl_connect()`
>>=20
>> Prefer to see meaningful doc string (same for other ops)
>
> I guess I will have to document the four operations in v2 as well.
>
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 attribute-set: nbd-attrs
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dont-validate: [strict]
>>
>> nbd.c has strict & dump, should this be [strict, dump] ? (same for
>> other ops)
>
> The NBD operations don't have `dump`, only `do`, so adding `dump` to
> `dont-validate` does not change the output of `pyynl.ynl_gen_c --mode
> kernel --source`. Should I add it anyway?

Ah, so it's redundant in nbd.c.

Thanks,
Donald.
