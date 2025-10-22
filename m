Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D201FF7B3
	for <linux-block@vger.kernel.org>; Wed, 22 Oct 2025 04:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761105707; cv=none; b=GwyQ9us3hHG2UYrcw/zf7CfbGEQmKmeFzPxkqmdWKInYAZKomYkC6wdMHZRq/moFu4zY0W8QxY4WxF2F18GmzyHEWWdhETOrXexJZ4J36KR+DxayqXrn0JTdrf/FFCQfFEYdBUSlucyuJS9xcYTQcnbC8hqNNmek4w2nOb81elQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761105707; c=relaxed/simple;
	bh=9jY3EA5gEkdui7bFU/atDea6tp+oL2Xa05/E1ZXf344=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E+HmVPzvJd+ZUTZHwVgE9vkvd5XoxdCG4O9s+J7xfnRw+1NMPG+MozCK0WuWgtFMEhsRLhUQ9upVHOQKqEIFaUNn2M2EsI0O2YGJ9/IF1VN5gzhSN/Nq5Vz+0UueXkNbjk9nhE8CDCS1uTCXH1gKCRlzfvI6MhKCMDoKoCHSg6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iFw8Gssu; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iFw8Gssu"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b5515eaefceso5206111a12.2
        for <linux-block@vger.kernel.org>; Tue, 21 Oct 2025 21:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761105705; x=1761710505; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5XEGeI2U2r41+s29akUYCWbcwFKMTqkQOw+6CMAYMfM=;
        b=iFw8Gssub0rHLihQtmEQ/Py/Rtd0e0Q826rqACMtralrtUXw5FLLIuwfqr+fSyv3Ac
         1fH/5SRTMeCM9vG6TIoj6OFUS+O/s3PgFqMQXwqxleXqoIupf5/h65xAR9gv3cuSVElx
         PY+UEN8qoZF5rW0PVx6Ll2Yy6/DegeLAoSp5wA2pAO+k3HcbqWX6LWMM0sWqrnBntCn6
         xdnqvYfXboFd6mfCMC49Py0MmynGJcSmCWl2oqToAheHUCr8b3FoPmeTcLrlBpe6w4oU
         kdfx2KenWYD3Cqblcxs4S5JPijSu33S44Vq0qJHDlwFFuSr221qiGHJkvVBBy3Oal/Ov
         HToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761105705; x=1761710505;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5XEGeI2U2r41+s29akUYCWbcwFKMTqkQOw+6CMAYMfM=;
        b=kf4qt1Z0m4j1EFa5zXfgTzm8IjyJCr6l3z0YeiXqIGYvF7do0dFSGr7aCELS4A6JMc
         yJ8S4qUrAHEZWVH0X4Qo6v0aOuSQG3e8zmywkNM1srPB+KfMW6goXDGi0WzxHqNBCfFx
         txSU6Iq/LFYcxgZuoNoK9YlpkYHhx6rJF8VxAtAqZeEVKA0McFu/B2qDBHeeb6T9Lmb3
         SjgmysokyxRx5Uj+psKu0PsmDoO8KBhBz28u+Mima7nWREBbji++Lp+P3oUfQRsubEjz
         rDXnGYuxHQ9ZLXNIGUVh2fJAJXvhEKMlHPX600PghOp3eivrOlK9Y3309VctSJF771I3
         tveQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwdpKNTpmn3Dmy3+ba68seTHuWEyGd5BXpYofLPvPTZ3wQKLo2paINA19Veeo9efTnYMg6AEMqrN8K9w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2GBncPzHOop7M6l/c6OmyEMRI3r0/GEPxkB4MmhyFv44CI7Qc
	kH8CUDg+PWHEAgmLZJRVoZwS2J3mmkaWp2fy5ZA1ENk3U9m4hrME5TQ5yOp5sgN6c6Q=
X-Gm-Gg: ASbGncs7AMitJ/yI+PSUe1JcwaLsRetr8bslmerWYOTF/xKlADyNVbS7bRsFxhnQmxq
	+W9RcnLErDF7xC0QrOixUc7horh3G8UH4AyNOlsUkfs/rSpsb9ae7+3T77Bic3fnnKoN7eXPKY7
	BkH+8XhA+fMcFG98LyWG1GFiavN/Cxqdj7rg6uL+ZMcgGyLK/Cd/uBDu5JP45TdCW5lR4ipcvql
	bL1PKiaKLDP2m5SExDcqLvdENBMiLeia1RYvKxzXSRH/UwbZB2UNj3fKudiIvIPyWbbuV7ezeak
	omyRHIfOGvo1ALzKX8si519MzYUDRkoAwcw27cgxobx0RY4n3kvWq6IhjmsBvr+wZ/vraXeA0km
	DYG34MLMpCyTEZ+fqALti/kaRg386r7Wzjq+rflQVHLlqgeHPMjMZ+Us4Mt09HKJjXFEMQ5dSmH
	bHMFFykjJ4XSmF
X-Google-Smtp-Source: AGHT+IEYWTGPLkVLKAMGZYnPNOk1bG7CyHUMxRahoDXL1MDVvSzLtlyzXLVhQRT4L6q1WhaGPTRqNA==
X-Received: by 2002:a17:902:f70f:b0:290:2a14:2eab with SMTP id d9443c01a7336-290c9cf8f2fmr233326615ad.11.1761105704778;
        Tue, 21 Oct 2025 21:01:44 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292472193acsm125225365ad.108.2025.10.21.21.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 21:01:44 -0700 (PDT)
Date: Wed, 22 Oct 2025 09:31:41 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	Breno Leitao <leitao@debian.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v18 11/16] rust: opp: fix broken rustdoc link
Message-ID: <bjoulx2acrfpnqmwmnamunihzuaakyk3i6m3gvtcxklssmznt2@azfbrjhiedi3>
References: <20251018-cstr-core-v18-0-ef3d02760804@gmail.com>
 <20251018-cstr-core-v18-11-ef3d02760804@gmail.com>
 <gcdcwpotzidrksmsnyvesnojcylbb2fqpiue4fijhj2cmayli5@7lpyessslxka>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gcdcwpotzidrksmsnyvesnojcylbb2fqpiue4fijhj2cmayli5@7lpyessslxka>

On 22-10-25, 07:57, Viresh Kumar wrote:
> On 18-10-25, 13:45, Tamir Duberstein wrote:
> > Correct the spelling of "CString" to make the link work.
> > 
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> > ---
> >  rust/kernel/opp.rs | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

I have instead applied this one now. Thanks.

-- 
viresh
