Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656142749C3
	for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 09:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752572692; cv=none; b=sDY0HZb/Ql6PJp3joSsjsH1CxG7/AQuPlI9jgM5kLsqJ98IY8ZGy/UWF/E/cMO+Z9QaN3ApUTTtt4pncwWwvnA03reUObHfqbxq8ObQQ92Rxj7dxgpkQd2fKxsKJ3RNjdP6waYPLcO1Z7EdHiFgkPjPhg+vtfvyYGzLprWskk9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752572692; c=relaxed/simple;
	bh=0OaGNFrB0fgqNoatwO5iBlV6OZUBZFJqA1edmIJr3/k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D+BEonJZMe8QmK4k52r4FTlo1XJIRmKwr9gBy2xLtD11/T4mV1X+/PaUnRpxTTdjRAWHCh/fSRJMFGs57MRXdFKzsGDuIw5Obl6+QmghBCChPb9s0SZrszoo+MF69QrQXdkPDw79daxzgGC62aSZKbIlsvTKyHDB+22LtNZeYS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kD3IUD7L; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kD3IUD7L"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-455e9e09afeso18656665e9.2
        for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 02:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752572690; x=1753177490; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=h7io7fgXMymKFOK46/kCrzMZ1PRBvZpU4cGSv0rsLuU=;
        b=kD3IUD7LpcrERm5AcjCmjXQC93taCQNI2Kpi0T7mzWPKkkOJTc3YC0DsDIyPNXxxPB
         eQKXTKDBWnYfSWVsps/FDyNxzr55W4YSAAnweVYoRmkQ22SuCIbnOyl1JcFWxxFAf3ph
         9VztT42B0sNHopH0G5BxrHpeOm78qR/7LgR8v4x9GTqk/yeOetYH3NpeE1e5NPdhy9bk
         Q2G3oDtSdl6AX43z1Vl5+BX6RWSa7rcL24Ym6/LQv3mltj0vhpmGBjAgq8djnsObF65Z
         gsYEFNFwVnkKxQnPNb6fovHkEeQFrPQxhXsnyaOMJWXg6UhrNSWL7Pr76MgU7RATJhay
         YPxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752572690; x=1753177490;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h7io7fgXMymKFOK46/kCrzMZ1PRBvZpU4cGSv0rsLuU=;
        b=VLV2o0oJoksGkuMuOqcro1u37ZpRhXM+aIaX5cVXb+H7/JI12BtRqwchRtBbkQ/aZi
         5XaqA1prIAwwcBszErYcKVhy+C2g7e4k9KHk8tL9Cq2Sm4/8pKXiX95oy2tPcwPkeCDv
         oElY8HpNLrh3JFtFxxnegOYhd01M1THvl0YKQWnxfGvONFsps0Zi8sxd5yzP2eFmiiU9
         JVtSBHrVf5N0wPCjIlTn38TYI/Nqwm5a3ELaKJgKDuA/AGkdddjjR9S37ZA8eOjFDolC
         WwtKXcfEKxfk1F/jZ6Sj8XGn03hjD4mzUUGLNteen+XmxPsL0bSDm957Z3K9xdUz1cvY
         diIw==
X-Forwarded-Encrypted: i=1; AJvYcCVH/G26CkSzeT0sy6XdoJiyT68BwqmttfKuubig/fmUEUVBgYlen48DBF1/Be8Ds6pU2RFeJZ6JSmqcpg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwjS5J3u2Qm2FH+nV7xK0E+s+NWiWZt+w7tHAd86h7QglespZAq
	UjiiE9KabJSsRB8EVdsa2LcUhy0qBdlSQdywEPxRYfe9fW/hzhHcVre/RGFeWErP/etMd4t9bwI
	s5QIj7GWHMCypoZ9Nmg==
X-Google-Smtp-Source: AGHT+IH5FEueWO8S7kcW3OwX1kpGtZLu82D3VsejIUYP0K855tlzIywd/DLT8PldrQkxvXurLF5xNuUIeWHiZ1s=
X-Received: from wmbhc25.prod.google.com ([2002:a05:600c:8719:b0:456:1b6f:c878])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:5304:b0:456:207e:fd83 with SMTP id 5b1f17b1804b1-456207efef8mr51348465e9.4.1752572689951;
 Tue, 15 Jul 2025 02:44:49 -0700 (PDT)
Date: Tue, 15 Jul 2025 09:44:48 +0000
In-Reply-To: <20250711-rnull-up-v6-16-v3-11-3a262b4e2921@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250711-rnull-up-v6-16-v3-0-3a262b4e2921@kernel.org> <20250711-rnull-up-v6-16-v3-11-3a262b4e2921@kernel.org>
Message-ID: <aHYjEIZkXhInJMfS@google.com>
Subject: Re: [PATCH v3 11/16] rnull: move driver to separate directory
From: Alice Ryhl <aliceryhl@google.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, Jul 11, 2025 at 01:43:12PM +0200, Andreas Hindborg wrote:
> The rust null block driver is about to gain some additional modules. Rather
> than pollute the current directory, move the driver to a subdirectory.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
