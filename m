Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1338C2F9D84
	for <linux-block@vger.kernel.org>; Mon, 13 Oct 2025 08:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760345054; cv=none; b=hpbYvXb26jqkYeGsyKfOGZG1gsmtIph6fLE+3mp9n+Dm2FBzTJX8yH8w8FhEq4ViyWIKb72Pj6C187rdrPxlXMmk5yyEflDDyx8SfatZ5D9EW49jam0P1jC28huo8aGSxH/Bb52N3y6Crg1OCoVbDDgA6HOdz4P1nob5uGihWo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760345054; c=relaxed/simple;
	bh=CCiwcbz0Xa80/3Iu0vLGj45hC3B+HOSp/IJLkFWl8I0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=crZe8VzvctQv8HQfp3F36D1JFpy7qHcqGK8B4tW8O+SamKxdE0sxWbmnS3Eln+bz/ZbIs/MHWeEkcUE7Qs4AKj9O0JYA4snbfjyyuASxQunrfvDXCNnzXrFDAxEl5/Y9SbquNZ9p0Wm1XSoJI04HwPKlWUDoMuSkGLEOKR8+yis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZFzSL+Ku; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZFzSL+Ku"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-782e93932ffso3569830b3a.3
        for <linux-block@vger.kernel.org>; Mon, 13 Oct 2025 01:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760345052; x=1760949852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HEm8mSyxrlTqcu1WsEF7ZOgpa+/kS2dzVEZPsYbteWY=;
        b=ZFzSL+KuxWJW5hNFcUUZTqcKt090DExRs4NV9BsWW7oBBGyciz/+hW3vbrjppyBcFc
         hWfSGymMZ1rz8vy6+P3t8oz0Tp9naxxNY/h0965DOCcVHqB2o3UEzKTfw/FjnWPB/Z3v
         iyyFB5d6Dtv5H5KqB2aTZHHejSmSc2aMVBh8Tvm8EIT96dQVMGLDVsHycPgFj3YsR/vr
         tXXSklCvYEXDrJiQbhp4/z1mCbJIBA75SxlVGotuChWshIu8T+QGn4vlDB/JuHz+hDac
         ViYg1kkoqTpIxKz06WxE4qxpXe0RgMN8RdYtGv6Lx8AHLHx8UnOavSuUW6cng+HbYtO5
         6/ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760345052; x=1760949852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HEm8mSyxrlTqcu1WsEF7ZOgpa+/kS2dzVEZPsYbteWY=;
        b=L0uDdDRwJJ/yBx8vfmSBBFmijCDxi/i1MKnLTcrorvmgK+ABNhnFpj6xxehEcfU0Bs
         KCpcajlrsvKxHGYPPWvYZINx0T1ufCZAhpGWchRNbLwH4p22w0p0nmjelvvI/17CmuUh
         KRWj+R3HvwTTUpqjJL1UMpglr+OSMaIRVbFHony3vJY171ZClSSASn78smZzwBI5x9g0
         2bOEbA9vxt+xhpF4oFRdkJGkF3fJDesQiCp31AQc/cipUgec5Gv/ICrrXLJr+e5yjyLK
         sOZtLdOpMrlVI6zE3c7RWb6onWdgsBCjteaJlOlRdYh2r3XUwZ91KgKAl39tCg9JEyYT
         gCIg==
X-Forwarded-Encrypted: i=1; AJvYcCU+00aLGQeQvgL9eJ0ikafsejlKqFzvyZVlySTkH2FDS0B4CZPPfpNd6fEoMKDNfF6WqhndS9Qi7wCP2Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwWp3dCHf0jJkcEd/c4E0cNJthsbVJ9IhY/5ElvpcfDKdmd5Exz
	2Uw0mX26HBgaDUDunU1iuqxz9QX5sCgUGzBnM/p2eet2xyOsKFJOtnI4
X-Gm-Gg: ASbGncssh6ilJjU1wAoFBWUap+h83FYf7GeDHA/aONhnGPCfbyuzltCFkpUYtvlHsms
	ofRR5nDdJ3EKkY57MejW/Kj6wCSsqtelaKhv6qSNciR8cIgBUH4zhfdF4GeMX4jaEtRcKcvk1rm
	OOmf0zwuJouu4RFzUaIQuioxq+12yQjeXoMHXgvouJSshGiSjLOtE8qA5JFwXMIAC0BcVatfv9W
	gNHX2Mi7KELjDdBLS5sszeosGRKK0wMfWjNNiIyqBa4lPxvZ/3M7muhFCAqo01k74CwOIvDMPaU
	YCmYG/21gxsY8sTv3CiXtbB5ow2ewWBPAk49vW685MCXeL7ZmxRDR7sKzSAOomVkWGcj9rfUKj+
	/JiLqaO6CRyeHjZndjw0fVWIRi/ObR9rQQpvTFGRgodVdJo0aNScS4Wtygg==
X-Google-Smtp-Source: AGHT+IH8BLldBUPUKFQibBJX7aY+OAIgjY1foYAVc8whufp2ZR2zdRzdCGMjbGvERedS1YiA3XEzRw==
X-Received: by 2002:a05:6a20:a123:b0:2fd:71cb:e908 with SMTP id adf61e73a8af0-32da839f7bdmr27396737637.39.1760345052180;
        Mon, 13 Oct 2025 01:44:12 -0700 (PDT)
Received: from shankari-IdeaPad.. ([49.128.169.246])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d9992ddsm10777474b3a.80.2025.10.13.01.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 01:44:11 -0700 (PDT)
From: Shankari Anand <shankari.ak0208@gmail.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	linux-block@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Shankari Anand <shankari.ak0208@gmail.com>
Subject: Re: [PATCH 1/7] rust: block: update ARef and AlwaysRefCounted imports from sync::aref
Date: Mon, 13 Oct 2025 14:14:02 +0530
Message-Id: <20251013084402.300397-1-shankari.ak0208@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CANiq72=hSTpAj7w8bvcwoJkivxD_FPKnx9jD6iNvhsENnnXBzg@mail.gmail.com>
References: <CANiq72=hSTpAj7w8bvcwoJkivxD_FPKnx9jD6iNvhsENnnXBzg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, Oct 12, 2025 at 08:01:19PM +0200, Miguel Ojeda wrote:
> On Sun, Oct 12, 2025 at 4:05 PM Shankari Anand
> <shankari.ak0208@gmail.com> wrote:
> >
> > I'll resend it on top of -rc1.
> 
> Yeah, please, thanks! (in v2 I think you say it is on top of
> linux-next -- did you mean -rc1?).
>
I've rebased it on linux-next, and I've included the exact base commit at the end for reference.

Let me know if you'd prefer it to be rebased onto the latest mainline instead.

> 
> I think it is simpler if I apply (even if temporarily) a commit that
> moves everything and removes the re-export in linux-next -- that way
> people will notice when they try to introduce the code during the
> cycle.
> 

That sounds good. Just to confirm - since this spans multiple drivers/subsystems,
is it still okay to send it as a single patch?

Thanks and regards,
Shankari
