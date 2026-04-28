Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0073D34AA
	for <linux-block@vger.kernel.org>; Tue, 28 Apr 2026 11:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777376915; cv=none; b=dOxiGGBJFhogtW+r/Ize460FpMuzEdTIATVOF5pgp4k/wjfo0r63Jp1IN+tZZeN/0eoIkYI8IQw4qeJOR60aUb/F3y2OnkSpc1O198TmFJvmK8Dt8XWLibkefuBtppSg8wP+RXyfNr9KzM2RIAIAVuK/PGlxl7GeaByKmH1VwiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777376915; c=relaxed/simple;
	bh=qX2bhrVL6DGhAuCi5mMHQZwzShUDXueVFhAJMpkztws=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m5RLD0mjXN9F0tmvOXXyj2SjhxfjfwFVsniPl267i4lrsbmGwAgmlryVz3+EO0vWLQl46o3QjrcgoZE0E7UVE36x2Bsg42grSyJwHoCHlu4zOEj3dnXOer7HytjTy3laIN/9vOcImPJjz6x0WKZvli/miUesdm3BzrPxxaT3l2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e1/Q/gqT; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1/Q/gqT"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c795f441ff7so7805992a12.2
        for <linux-block@vger.kernel.org>; Tue, 28 Apr 2026 04:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777376914; x=1777981714; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:subject:cc:to:from:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qX2bhrVL6DGhAuCi5mMHQZwzShUDXueVFhAJMpkztws=;
        b=e1/Q/gqT2+g//ZfE/HuidYk+JplBwU+Tb5Wwc8lvL05eYyEngF/+VRcpMJlSykjwJB
         GLoCuuVeXgOB7vM1y44Iq7JXgZ3SJynv8+PBbslCHGyMoG7ydFqSBfk2KHGvoJ7xIXRy
         nTr2TVWKVM8YFR8FnecxsyM7n8a3Ub7xrlbnf6+AXdABtCsAbTcVbvMt7BWi2d5htK4Q
         HeEslJyHqjTMGeLYzd9+VGSKl0t0Mu+GqDnWZJ88wCq9WMTMiwJ4falaFkM+RI6UL82F
         9th9S3glrh65UTI/KTtpNSdyiOHpa2sTFy3kOoHNiwVxsZk7sugM+xzs7pK66WoINDVB
         L9bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777376914; x=1777981714;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:subject:cc:to:from:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qX2bhrVL6DGhAuCi5mMHQZwzShUDXueVFhAJMpkztws=;
        b=m+z/x076aUti0k7NGYSfibi5JqeRBj8TGKuT9XwtW315SnBOUH6GvV3SuzeCb+n72j
         l/pUopXeLWcmZ5oTD5P8QYIdCPTJTHmnOpXOVedZCScViNVvDWrGqKnNPzSuqNHy7EVs
         VtQsDxn4JLX6VzefjN2Fd3zlg4ywlaXhK9DAfO+GE53kPR7PBIf/9FvrgOaqA6CdOF8A
         YmZ+f7ghO0ibVfP+8fE0DdyLiE/9aASsm3dEDuct95kMIf/nQIoAIKHj/xucM9xM4H/N
         3fyhZm1bEmTQE871else3V/c2loMqs/+qK1NjV/X4z744rL3SHkpJO/T0kZv2nnxFWd1
         pgsQ==
X-Forwarded-Encrypted: i=1; AFNElJ/9cxrnzV6gtND362gLqkx5A85sTPvUSPCTcOjwuuIlppSOTcOR07DaznYbYk4kTN2WdmMf9Dp4hfticw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzci7IyPd/9GlsBwOIfzZ9DeVIQfX+AC9cnpwmOgIyQnB7YkMHC
	dRdsNmEWnKveoUsL6n+8ujRBy7bmnTNY4P7tGxYx5abmnXonap8D4Ge/
X-Gm-Gg: AeBDieseKERVZaZt7EocShz2x9wuH1uXAvR78B6Qozje3EwLwJce6q6jONOeAqoFwdC
	CyTTYNsnDoxvi/LaPmBF2NgHOhrUUchA8fFk3r+9oynQkBUOTApYF8a+SgYzKh13i/vWD2+gB+f
	yPk5GjIqdxffNW/Vo9DfVM9x5WONdgQMHJ01cUVe5GBfxvukj5ghwkRAleKMNvUnE1HIVITni6E
	wMHjeQvT77wk/FKJn1O/iIzBElzOjFAyN+ycZAuHl0gptFCgXC3afuKfiJC1dRsZeKj0Q8gUBcG
	jdUg9YalAxj+oRai6NIZxy17vx1GsqQl7ip4PDVJ5pWSTexIFRSJYrGIvxf8wjNcFqFDE8CIPAU
	lrWwCOo0+9G8Njl7B3lpVrNCFoXn93eA2vQqBHFq36RTZj82MFqdCEKcW6lmrjdgbOKNVjueyeB
	YFceARK6L8bjj0oTCC5lSJw2rVXo0U9ZQ8a/5O7NSRQTz8woo=
X-Received: by 2002:a05:6a20:e210:b0:39b:bee4:2952 with SMTP id adf61e73a8af0-3a39c2ccbe9mr3361030637.45.1777376914173;
        Tue, 28 Apr 2026 04:48:34 -0700 (PDT)
Received: from yuwhisper-pc. ([49.213.140.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7fc35d0eadsm2370893a12.27.2026.04.28.04.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 04:48:33 -0700 (PDT)
Message-ID: <69f09e91.630a0220.1921a.7948@mx.google.com>
X-Google-Original-Message-ID: <afCejXqBKYo_jZ4g@yuwhisper-pc.>
Date: Tue, 28 Apr 2026 19:48:29 +0800
From: Hsiu Che Yu <yu.whisper.personal@gmail.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Hsiu Che Yu <yu.whisper.personal@gmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: block: fix comment referring to states by wrong
 labels
Mail-Followup-To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20260428-fix-docs-mq-req-v1-1-260079853836@gmail.com>
 <CANiq72mN+tGZ+AMoxVbok5HwnHFMsmoZ1bpwPmSvN6CbC-Z-fQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <CANiq72mN+tGZ+AMoxVbok5HwnHFMsmoZ1bpwPmSvN6CbC-Z-fQ@mail.gmail.com>

On Tue, Apr 28, 2026 at 01:42:31PM +0200, Miguel Ojeda wrote:
>Since this commit exists in stable kernels, and this is visible in
>generated docs, we generally tag them for backport, so I am doing so
>here:
>
>Cc: stable@vger.kernel.org

Thanks!
