Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5EE1BC20
	for <linux-block@vger.kernel.org>; Mon, 18 Nov 2024 01:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731892326; cv=none; b=jEr5R4MvwkmA+JSnoCtJ+zL6KjReIKHgwayng6642PyDIe5KkJGoI1dmQS0xzaHeuOCEA4iyZPOUzMINy9EY4z5HzgYuq/0zyVIj4qQz3m0FhQ7szhTUR/h/1CknNGmqCticgFRjltOnFdbnDFMbNcW5RaR9SO1fZuIl4D2ds4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731892326; c=relaxed/simple;
	bh=8jguRpTCIFX5X4hwFVJsZtjemrkZFYD9SjCUJnKItdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KCVleVRSDR4i/27gynV6+B3exmLznia9tI5BJUQISK3LqS0ZDVcRJjxvGQZOcnR6+m0IMPMVRQ911mZ83bH/e9YZV/6GQkm5Or2Pmw7QaPH30RjElR0L9BOJUYXamTG5D8lmxPSJ4456GvnuDikliiVFHap1yQr9M0IzjuO7Gmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iiitd.ac.in; spf=pass smtp.mailfrom=iiitd.ac.in; dkim=pass (1024-bit key) header.d=iiitd.ac.in header.i=@iiitd.ac.in header.b=jwURfuKy; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iiitd.ac.in header.i=@iiitd.ac.in header.b="jwURfuKy"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21207f0d949so8401235ad.2
        for <linux-block@vger.kernel.org>; Sun, 17 Nov 2024 17:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iiitd.ac.in; s=google; t=1731892324; x=1732497124; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V7XycAloiFoCMfmssnZcbAgPsNHHq3RcS44NRT2jaAI=;
        b=jwURfuKyWIi6U7Qg3dWQM3pz/EMpp/6U7KmIKnqOoSnY4YGIkuJefT5TNyrVWMcel1
         9vF3amvSz35vkJtufx8Y13SQzgwcrxtGSho47dupVvsDvyaphQ/8SlawbVzwrdu1+MzW
         OL5D6xgxScKgSyG8L0jD5ptijFHmCpVm27eNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731892324; x=1732497124;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V7XycAloiFoCMfmssnZcbAgPsNHHq3RcS44NRT2jaAI=;
        b=Y2sd4ByC145CZSTiuvPGDO+Is6P+ctTjYsdHtK+/sm+X9l7je0jyYcCzbHIsiKyt6v
         P65l+P8ONnkPkpsxIRpB72D8lECey2ATN0fZBf6VR7BPIkIqalwD1dEQXvmDFwaEdycS
         BjEjWbjh7aceiYPqfmchDKbXG45QSLxXyXVLktHEmLU0FtLwxUkoC907nYmeszTfs5/Z
         +dmA8gxsXLzRs6QHlRmbcdmZFpeGNmbo4opG1w3X2novOX7fTkQp1XrCrrad8DYC8oRg
         T8sFBhWcAZECexW4ZsEuFl5xkIKl2memVpZlnzj2nTK0qF8cm7kCoP3ioCWHK+wDR2PX
         /dSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfio44DcxbbO42NwQKnopJkzWOcC7AOzLxyfNZHTFa02W8/JkYvjgzVHY9zBJotmB+c/8aDXOa3vKs+A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxkPw8y8IBd6PqdTOaXPyW1xF0MhtWUgeuTdNDMFzN2CUoqNaVW
	wHx6jTC5I33NoXtuk2dpjOpD53Rp69iPMq7qqKU9I+q0E/im5FkXOmSfFBoIi3o=
X-Google-Smtp-Source: AGHT+IHRSOFCwCSJbllUPYVx/zvEltTAQTSkv822oSEiRkDjFOTOd3vI//iN+/Xz+fTAre/iOFBDmw==
X-Received: by 2002:a17:903:22c4:b0:20b:861a:25c7 with SMTP id d9443c01a7336-211d0f1183dmr149393135ad.54.1731892323798;
        Sun, 17 Nov 2024 17:12:03 -0800 (PST)
Received: from fedora ([103.3.204.126])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea5fe3e689sm1449857a91.6.2024.11.17.17.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2024 17:12:03 -0800 (PST)
Date: Mon, 18 Nov 2024 06:41:50 +0530
From: Manas <manas18244@iiitd.ac.in>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Trevor Gross <tmgross@umich.edu>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Alice Ryhl <aliceryhl@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Anup Sharma <anupnewsmail@gmail.com>, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] rust: simplify Result<()> uses
Message-ID: <5qtqdzljvzly5onzhfdq63fzcqcj26ybktm2cgomijpnfnyrbj@ln2kbp73csf6>
References: <20241117-simplify-result-v1-1-5b01bd230a6b@iiitd.ac.in>
 <3721a7b2-4a8f-478c-bbeb-fdf22ded44c9@lunn.ch>
 <CANiq72kk0gsC8gohDT9aqY6r4E+pxNC6=+v8hZqthbaqzrFhLg@mail.gmail.com>
 <q5xmd3g65jr4lmnio72pcpmkmvlha3u2q3fohe2wxlclw64adv@wjon44dqnn7e>
 <CANiq72kQJw4=qBEPwykrWBsqmycwS+mR27OE2dTPQd3tKjx-Tw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <CANiq72kQJw4=qBEPwykrWBsqmycwS+mR27OE2dTPQd3tKjx-Tw@mail.gmail.com>

On 18.11.2024 01:54, Miguel Ojeda wrote:
>By the way, for the purposes of the Signed-off-by, is "Manas" a "known
>identity" (please see [1])?
>
>[1] https://docs.kernel.org/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin
>
Yes.

-- 
Manas
