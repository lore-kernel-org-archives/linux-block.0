Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09AB411679
	for <linux-block@vger.kernel.org>; Wed, 10 Jun 2026 14:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781102902; cv=none; b=PdN/DxY+DCeLn+MEFEJ/B3Kc4IsbQ0RUeHbyE20lHWy0k1M199liVAh611IcbacGLJIiK3RrvKt676fOrRJSig5oayJcaEQVuu/hhgteG/3o2SiIkhWd4jCKxv0b43HDhuYLb3EOfyfrRLJ+pF4zmA+VpjPbwBOQDGbYUjTHfCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781102902; c=relaxed/simple;
	bh=wPnpLp8Tkf1EcxdmimD9podW7Pj9Kcz4BTuowIEiEmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dB3AJ70WzRX9hTV4LEHlSHULsj94lF466TgczV6ISLF7Bx76qaFskooy9m/uAX2TygcehJmrEcpzHX5nHaC10vI4uccrzRu4Pziu/vR8F5/g1Bc55moJbRlXIPa/qcYAsmBvy9BC+HsvgiMOhi46Yx0Aw+ZAH9+xmq4s1EFv5hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FNqcUa72; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNqcUa72"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490a76757e5so45539935e9.2
        for <linux-block@vger.kernel.org>; Wed, 10 Jun 2026 07:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781102899; x=1781707699; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=arsHl3hytXvoPGGCrzWJqM/sm6/JUsgdcn4JlpnXn2E=;
        b=FNqcUa72ScWLu0CO27P2nrHmh9XlvJ8GxaOtJAb3/ee4tNYLqEckT0lSgidX9zbI4d
         qaO1NgQjMRNywFo1Wa6LDjPh9M3hzS76eire4QzHtFg3tL1WrPzGCoaqAB2b5OuByU5t
         K++Ou7KeluGyISAkCbps3u7DN+NILqnK3e+SOCD+lvxYqtZyvmXX0JXfhyRILkhtM2T/
         L+mbi+f4QpDN+tuOhJ/h0/Uu/0mcqw/iRK+mRO88o4d/bNKcNYFBftnlnMT3N9cG++MD
         q1xzNkadajAlTo8AAVFSIxhim4T3wh0t0UGEVl2czjA2FMAhKUM9S6TxbwgHldAgZeEW
         aDFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781102899; x=1781707699;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=arsHl3hytXvoPGGCrzWJqM/sm6/JUsgdcn4JlpnXn2E=;
        b=fqg+1Eh3ikDw0ZqlbrQPHuOBwnEqiEtZNW1sl0IUEWzddWsMfew5R+VbtYLXMpMF1l
         nzN8fv/aF3aC8mH/6/vcDbsU+ydEF8kEq/wIL0a6yNRkQN0k4W9M3n14PDdOdwI+tG79
         oVeijVi5o4jtlHVeJyqYKDbwahgYRXXB76iufn2QeM8+6AaSLXATJiW1NNwhmqWJkMx8
         I8A0xH4MXO4Krg7kU9qmlO2ZppGVxsE3kJSPMnjDub7fIeFWM+n5Unl2rZxPyi5XmLqb
         hZ9xEIrmERQnjy9u12vTdu6HJ5XqoIq+wpOWK/b8V2DuLSeJcegNpEQmBBPaIFJOJfOk
         H27A==
X-Forwarded-Encrypted: i=1; AFNElJ9TbLBe22Q8XHca7wYgMq1K6TPpKTlnoe9jRGDiGav6PDwvW8vMhbA9GnScExs2bg7rHZJiSxzvVnsN9w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7pZD7+zZYNjaOJmJUaeCG50iX8hOxNThbZynTIfF0YymugDiR
	8YSdZuJG742MCBqWO7rw7qz3Rk/g0eySHycFPVowxl4Bv7V7QYuFBmCA
X-Gm-Gg: Acq92OGvnvxLUKobiCl/IwUM7LNNDrQHVaC9HKX2bH+r5DAKxr11hrnLFb4JBW6RRlP
	pZlZQ3cwIQW5RLWziezsiQKS7iIYkF8HkhqKyp5Y7/rP4Ou61LqNr+q/rneGGVJQDaRGQvRAtxK
	q9DRSRkQm6yaKl1Ize2JMKN0wGq6xQlqkFqOgUwGeMDCXG+erNN2AMcbbfnXNmRolKmfN3sNW//
	/ks+r3wXNPoMrf9TNwsD1vJYNMSC4KKwuPctu80cYpRlqnzRf9qTU7F8WTxpoWEiaS+1oX235p7
	QBe2A9y7hTHvDSlp587ZNtr9y2VvlTtlapHHCSi8nzgfFLIOoyXUNSQExcLTGykCuJxcBLE160J
	2aaMy6O+Tmov4As5z22l4ui5VWP25ircUJUx0BlEE1C0+UQ/UM+doUBQCUCKPwirEn2MqahjnzA
	K3nrJgt+0NYA6o+ciBbup6ZC0HVJZie5Jam3rZB+MN21blWiCGTRore6uFfW6sScwB4N+1STR36
	A==
X-Received: by 2002:a05:600c:b93:b0:48a:93f8:dd02 with SMTP id 5b1f17b1804b1-490c4e0414emr409860885e9.14.1781102898732;
        Wed, 10 Jun 2026 07:48:18 -0700 (PDT)
Received: from [172.16.16.15] ([195.100.225.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490dcab44dfsm69288225e9.2.2026.06.10.07.48.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 07:48:18 -0700 (PDT)
Message-ID: <9627f522-7d94-48c8-9848-30761c9234bd@gmail.com>
Date: Wed, 10 Jun 2026 16:48:16 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rust: add procedural macro for declaring configfs
 attributes
To: Gary Guo <gary@garyguo.net>, Andreas Hindborg <a.hindborg@kernel.org>,
 Breno Leitao <leitao@debian.org>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-block@vger.kernel.org
References: <20260603-configfs-syn-v2-1-cb58489c2647@gmail.com>
 <DIZHKJSZXQ4Z.6SPXJVGDV9ZW@garyguo.net>
 <f6a513e8-227f-4b22-bd4d-81d88536eff1@gmail.com>
 <DJ5A9HIJ43EJ.2K3SCFI7UR3NF@garyguo.net>
Content-Language: en-US, en-AU
From: Malte Wechter <maltewechter@gmail.com>
In-Reply-To: <DJ5A9HIJ43EJ.2K3SCFI7UR3NF@garyguo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 6/10/26 12:05 PM, Gary Guo wrote:
> On Wed Jun 10, 2026 at 10:15 AM BST, Malte Wechter wrote:
>>>> +
>>>> +        Ok(ConfigfsAttrs {
>>>> +            container,
>>>> +            data,
>>>> +            child,
>>>> +            attributes,
>>>> +        })
>>>> +    }
>>>> +}
>>>> +
>>>> +fn make_static_ident<T: ToTokens>(ty: &T, suffix: &str) -> syn::Ident {
>>>> +    let raw_id = quote! { #ty }.to_string();
>>>> +
>>>> +    // Sanitizing syn::Type::Path, this is safe since it is
>>>> +    // only used as the identifier.
>>>> +    let normalized = raw_id
>>>> +        .split("::")
>>>> +        .map(|s| String::from(s.trim()))
>>>> +        .reduce(|a, b| format!("{a}_{b}"))
>>>> +        .expect("Cannot be empty")
>>>> +        .to_uppercase()
>>>> +        .replace(|c: char| !c.is_alphanumeric(), "_");
>>>> +
>>>> +    Ident::new(&format!("{}_{}", normalized, suffix), ty.span())
>>>> +}
>>>> +
>>>> +pub(crate) fn configfs_attrs(cfs_attrs: ConfigfsAttrs) -> proc_macro2::TokenStream {
>>>> +    let (container_ty, data_ty) = (&cfs_attrs.container, &cfs_attrs.data);
>>>> +
>>>> +    let data_tp_ident = make_static_ident(data_ty, "TPE");
>>>> +    let data_attr_ident = make_static_ident(data_ty, "ATTR_LIST");
>>> Instead of creating identifers like this, just scope them properly so that
>>> a fixed identifier is used without colliding.
>> I believe it is nice to keep the identifiers unique, especially if you
>> have many fields
>> you can easily differentiate them.
> What make_static_ident is doing I think is quite hacky. I'd rather not having
> them. Plus, the identifiers are not seen by users anyway.
>
> Best,
> Gary

I will simplify the naming of the static variables greatly (removing 
make_static_ident), but still generate unique identifiers.

Best regards,

Malte

