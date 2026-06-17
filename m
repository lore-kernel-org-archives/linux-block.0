Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F4E407CC8
	for <linux-block@vger.kernel.org>; Wed, 17 Jun 2026 13:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781702938; cv=none; b=ZIkWpEUvYvxrSuoxGDEDh9e4l5gJcelQ88/ihnxTP7Cod44slQQzNLzyrHHhxPaZPXrUEAuD3iBOz9JiBAlm0NzaM1lnXW8SF0ziENoFU9hsuRasBuweLzZ+KDF/oYJszRmlWgiVBGvQg4xw72KVZUiUHQFbwqclpfdB2Au636o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781702938; c=relaxed/simple;
	bh=DT/SfVu1raNTf+QcCPueydGtPFXgb4ImBDNRId1NFQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=De5R32kFhfazNQloZh+9Y1n3hqHb6hsY2zhkZYq0i4KS1lRBcmxX8r275NR6YxELgJO2iqXRo7+r9AttdfHeUDPkFrbOFrQ5fHJjfDC1Ur8LjOf7miUoWAR36A7/IaMhiumKeR1SGY7Udo8Zlx5xcw2dhRr8MrCz/FGGuKxB1dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jcx+M93A; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jcx+M93A"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49222b6e871so42322255e9.3
        for <linux-block@vger.kernel.org>; Wed, 17 Jun 2026 06:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781702934; x=1782307734; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=po8WtOITJfbEGYTYX/+2jWNreDSLIEwOM2fWXbXrA1w=;
        b=Jcx+M93A82+c+nWCyoqoahdZiPOi1S0QQ/Y8E53xE9dIHhlugGuU6yyIzvS7tTNCsk
         7VKNdc4hw7wzVaxHgnm/AFr65Zcyl8QWrkxv5OaO778U6lPdgHsIS371hK9B4mdz6NxV
         iA9+L7dok+y5cWsjoncftGBPqZXPnPmSFA2MXDAu9u2NFO2TQ2Ngr6rohu36yMgvrH4P
         gx/+vA6pvwWi9+hAzF0z9y+fkrfY6HKuEVHDX02rw5VxdhTSSDeq6HVqaeZP/UIH+tq4
         oSOy9QvnGdqipsavb26KodoAkGVa+uUM0Pa9Cdzp+I5z304Efa18A9oikx9Oudltkt+q
         mjbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781702934; x=1782307734;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=po8WtOITJfbEGYTYX/+2jWNreDSLIEwOM2fWXbXrA1w=;
        b=Zy6xgaE7u4rZ+kIkXfMpywCgpTYZ3rQ1K0gkMJm5ImsU+RuY6m+36YhfDmjNJCoBbh
         jA09zjazmNgxkJOnG7lUv4XayCVNzgZOQn9MjMk0xSNKwbH3laN+MLP4mrhXFu8I6K/U
         7MGIPHbmxhM1NND2ogx0ByguZ0wE4HkAyJX4jvGMjegcpGsSxss82L8qkF15Yq3ETyIl
         nb8n/pOSOq7jZ5l4tSbaKjQSW5R4y3OCBZXbQhPkzR+366HYfnoNjgyVb9ao+9TK6t1Z
         yq+KvBKYcMSduEcraYM7FSJfdhpvoTA5lPVNXE7qtqF9kbz5nDVfGsDf5KCly8F4temZ
         HkZg==
X-Forwarded-Encrypted: i=1; AFNElJ+zJB44WP1yvU3uOli84Oa50ifOkho+xITplNZwApK0GlIUhwCYJk1te3CeH9mQ21nQ/Gyk0mSJ37IPrw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzP5P3Tv6uWFml1O+tFF9S9dunm68FltMgZVphemhKmhu34pjsO
	Vp75VfREuGOl7TlTnIMvTKZbYgz5QRVHRXQezEGGuFaADkrfJjbEmHiH
X-Gm-Gg: Acq92OFWloPlOENeb/M9r5CRsZk73/tHT6qVn4x7NZhHZbtIOKaorP03eziGVm/DqiM
	L6mKs8tGUYZGQEPa/1BI2aLoqsAzLe3k0A5/NhE65hHwFN6WO4YJ0imZrVsSTquLIpqgT5wmCeI
	xl1AZc6i2TA67vyv57KUKUOKbRXG+WRj6k3nmgX4AVWISwzlmyLHpVWQCDsat0V1kTJZHHmUh8w
	9HLCF3rW03U1KXOmHwHXXay5KOpGM2R+/hHA1wH5o6eGhT6Wbb/489VVd0b2YDMNjPhyWaxh77c
	WkatvKnZ3tP0K6jKacnG6USp4ipx++ifooJzm0O0+7BTQi3xQy8qPrvZSzybVwUNIIvlwbxEDCe
	ShSAW2E67klQ7IJ+GP08WEPDzl1K3moWFEMojB9/VSWYRxtj3OgFa6y027uxSnWV5DEgqYT2KN2
	QHAPa+nmVpopYQ3yyArv3zhKUO4KCB173R2JEJzhti516TH6RoyuvT
X-Received: by 2002:a05:600c:4e54:b0:490:d32b:39d6 with SMTP id 5b1f17b1804b1-4923412f17amr53648445e9.19.1781702933455;
        Wed, 17 Jun 2026 06:28:53 -0700 (PDT)
Received: from [172.16.16.38] ([195.100.225.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49230a4ff67sm159911185e9.6.2026.06.17.06.28.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 06:28:52 -0700 (PDT)
Message-ID: <6d77253b-d628-4aba-a820-13d1757698a5@gmail.com>
Date: Wed, 17 Jun 2026 15:28:51 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] rust: add procedural macro for declaring configfs
 attributes
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Breno Leitao
 <leitao@debian.org>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Luis Chamberlain <mcgrof@kernel.org>,
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-block@vger.kernel.org, linux-modules@vger.kernel.org
References: <20260612-configfs-syn-v3-1-3292fbc5cc32@gmail.com>
 <CANiq72=RX5V6W+1tj0GHxZusrk5OqYbZ5-xV=wvSssrx_CWXAA@mail.gmail.com>
 <75552e2d-0bc8-40a0-b783-fba64482aea9@gmail.com>
 <CANiq72=fUuX7fF1=AQ12ahYHwW7k2i28Hkpo0TtUhwV7qeojQQ@mail.gmail.com>
Content-Language: en-US, en-AU
From: Malte Wechter <maltewechter@gmail.com>
In-Reply-To: <CANiq72=fUuX7fF1=AQ12ahYHwW7k2i28Hkpo0TtUhwV7qeojQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 6/17/26 11:32 AM, Miguel Ojeda wrote:
> On Wed, Jun 17, 2026 at 11:13 AM Malte Wechter <maltewechter@gmail.com> wrote:
>> As of now doc strings are not generated for private items in the macros
>> crate. I am moving the `parse_ordered_fields!` macro into
>> macros/helpers.rs but this means the doc strings are not generated for
>> the macro anymore. The `parse_ordered_fields!` macro is a larger helper
>> function, and the doc strings are relevant and helpful for macro
>> developers that wants to use it.
> If it is private, then it is what it is, don't worry about it --
> developers can still read the source code.
>
> But, yes, having a render of the private items is something I have
> wanted for a long time, but as a runtime toggle, so that it is easy to
> go from one to the other (and without having to have 2 entire copies
> of the docs).
>
> Please the entry "Private documentation (perhaps as an extension of
> the private items/fields toggle)" I have at:
>
>    https://github.com/Rust-for-Linux/linux/issues/350
>
> Upstream `rustdoc` implemented an MVP of the idea via CSS/JS in this draft PR:
>
>    https://github.com/rust-lang/rust/pull/141299
>
> If you want to help on that, then you could try it and leave some
> feedback there! :)
>
> Thanks!
>
> Cheers,
> Miguel
I will leave it as it is then.
I will try and look at it if time permits :)

Best regards,

Malte

