Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0C4276054
	for <linux-block@vger.kernel.org>; Sun, 12 Oct 2025 14:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760277902; cv=none; b=ZPcn7sNahes4ja/avsxJil8/aaYRvyIgbjIMwSYxtT88d+1hs1pKvAP9a3LWRS1znjW3r4yRGX8acZ4iW/twS/xa/49Qt4RVOBXiLO/vsG0hG2Pibi+VMDvhXr1511wX/oqiShu8SxSWxPrvGpq3YWFhKuvWJYJ6OPHvCKjJucw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760277902; c=relaxed/simple;
	bh=SUCKplIlV9GbXZf1FJNwlR6/8RVMJUgrM/szCfbpnQI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sM+/IA1pvcIN52dnNHCFZQlzi+9B2MRklYn0ugT0yjSxwS/QIv80K726d+s/CCxM3TTRIKy6cKwcd7JADh4OorZ+D0ge1F/BiqfdZP/0HRpkDrKE6Ns/CPa8m77HwcAx+Ch/Jdb3pev27cnrsv+o3yH/dYeKEKofU70ae8I1vpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QzAvT7MF; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QzAvT7MF"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b63148d25c3so2347428a12.1
        for <linux-block@vger.kernel.org>; Sun, 12 Oct 2025 07:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760277901; x=1760882701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wi4T0TH8A0fKPF3Zs0o2a/X6S5Z36f1SXjrYZd4ibpk=;
        b=QzAvT7MFQDWnd6+ebDn9P8mvAQlhCqGZCgvF/XfWUwXBjJRGE28M++c+1qQy07cX/l
         8HCZJTHSvBUvSEqQDb1j5ebax03wetg8ZF8oqQnEKm4cWYXuzD0zGqh91giWFS+zmayq
         dGpmKlz1Cv7v4/RwhgYTDckXhD/715PfCqsNXTuDLmyBLh31887P1EcRNM8cw7LpSJhI
         DmhU1a9JQB2fblefacXZoj2ftFmgMMSjVlafx+0QdeaVQ7UwM9mGp4DJUWYblhYF+Esl
         teVbvddceYsFKPX+OAbyDyTAVczHEGoMotrJrzv8Eb8bSVl6Lj3rijROdoocazGiPoWW
         XUyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760277901; x=1760882701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wi4T0TH8A0fKPF3Zs0o2a/X6S5Z36f1SXjrYZd4ibpk=;
        b=iZh504Id4sR6EooQJJOnUHu+30VUHv1tF1j3VSNvOknFABGBmZ1Xa7DILkZ6mAV2H/
         kwzftd2v/Z4YCk5V/NzGvb0g+2uActLUj5s1BJIIimrxSBt6xOKz9FI+0EoAlrvqtTY3
         pI3ie0ySooe1gMgfFQYHZlKHfJVL28CxQYZqtTjPxo9e7BjNwwVyJ35SjlO1vFOgN9UF
         znFa7qk2DSgGqex6hMfh784cKdIRfiA+P+mqketTcocpDX6DuS0YBfpoPEJtosRj4xjJ
         KAnONjka+E4SYD5ipiG7MFR+lw+fVONUx485scTIhNIohJiT8fF03IpR479qzisaoEgv
         Fr0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWfVKvIs7xcGURqhJ8554mdWEq5QhNOBdZGEtQqFFjEsReTX1G4YsWdrcOjpAxA39BikCTfPvC9BMCKnA==@vger.kernel.org
X-Gm-Message-State: AOJu0YycalmRdtK+Bpz+8QQxD6sBGVkqaBxzNcjkGrwLps3c1DvaK9N/
	OUEc9b/nWfZoIdQ7Y/Xyhu3Z7rvm9ZUD9JtRCwiIUDDGKKbFHyr+MDgh
X-Gm-Gg: ASbGncstJ54nG2tnPQPYoq3XUo1ZogAJBtYXf1HXnUmJ7v4KTwnP4RyM+YG4Xtsszto
	sbLellK+x0t7sjTWxYHm9KRSaSwG0MD25MQqUm7Ttkfq7wYde8c7F2tNgKm7v6kbFzrSaCy4K9y
	JO+Q75I31+RESBm8L3D7vMwg7ZFAtIyx9dO2uo6O33fGghGzcdfim1fgRMvl5bYqEJ0lZScc6FN
	jcXrClQS3fRariBOW69Rv1Nh/hcNLwWPZfuEkm45g9+MhT4A4WISZNBSXUnJUr+rGmHSRRfhSFs
	0JegkQHwEm1sRZYERIlMOp7bYn3afxYYq/VGNjT0CKppOa2ueDA5tac1JtFmV8u8A0yyBJe4R+I
	nWpOy7zjILbwgcX7pSte68XJsRUWAnQ+iQgZrp7bInHOX468jipLSZ0Go1Wa0tTfrgDWm
X-Google-Smtp-Source: AGHT+IGavuFKFawAItq7cPjSq7/3icbEiNsjEbDay5mb/KvWr80bnaNSCF+3IOgnuF8amEVi9WUINg==
X-Received: by 2002:a17:902:db09:b0:25c:43f7:7e40 with SMTP id d9443c01a7336-29027e788c9mr237734005ad.10.1760277900591;
        Sun, 12 Oct 2025 07:05:00 -0700 (PDT)
Received: from shankari-IdeaPad.. ([49.128.169.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034e4930esm106828495ad.54.2025.10.12.07.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 07:04:59 -0700 (PDT)
From: Shankari Anand <shankari.ak0208@gmail.com>
To: Andreas Hindborg <a.hindborg@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	linux-block@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Shankari Anand <shankari.ak0208@gmail.com>
Subject: Re: [PATCH 1/7] rust: block: update ARef and AlwaysRefCounted imports from sync::aref
Date: Sun, 12 Oct 2025 19:34:51 +0530
Message-Id: <20251012140451.155219-1-shankari.ak0208@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CANiq72=ox809CAhMijbvxvy_-tx4QgJ=pGbbWfCcZR8J8XFrkg@mail.gmail.com>
References: <CANiq72=ox809CAhMijbvxvy_-tx4QgJ=pGbbWfCcZR8J8XFrkg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Sep 30, 2025 at 06:00:41PM +0200, Miguel Ojeda wrote:
>  
> Thanks, that would be appreciated -- if you can, please rebase it and
> send it on top of -rc1 when it gets published in less than 2 weeks,
> then we can apply it soon after.
> 
> Cheers,
> Miguel

Hi Miguel,

I'll resend it on top of -rc1.

I also noticed that several files have received new commits using 
types::ARef or types::AlwaysRefCounted.
I wanted to check if it would make sense to update the documentation
to reflect their new file location.
Without clear documentation, it might become increasingly difficult
to remove the re-export as soon as possible, especially as more such commits are added.

Let me know what you think.

Best regards,
Shankari
