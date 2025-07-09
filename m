Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6389E2DFA21
	for <linux-block@vger.kernel.org>; Wed,  9 Jul 2025 13:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752067555; cv=none; b=UQ/4J3xCEABsIlp13gFAxRGb2n4vom0WLl2HjdXKpxZKO9IUTmpCClamr+TV41nZ9vhXV5nPxoAwWFsux1e/J2BtTpeQWzwSzd1REQgggESPleOcEWpyRGUxIKWOlGhRmpn65jS0g4jxbz5Ydld/3SEwHMf6leNKaX07KPbnJWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752067555; c=relaxed/simple;
	bh=+CycetGzVdLehehI9aYmJXxbJo98lkIOECW6qGyf0jM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TS9zwiECNygZJ0XIXj2O6e0cGK8g1a3kvKTuSDRmgKHY/lQLZP91s5SVPH4aBoNf+ohlk8uHkjP8S3VkVRvcNifRTP68R4SCvCaFe6ccC61rwqqcyE+04V0m1/i9AfdrZo21Hi0HjKEZDcQh5+7Lob4QnR8pNcJpACWUuiXaUCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NGHJiTTK; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NGHJiTTK"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3a523ce0bb2so2669562f8f.0
        for <linux-block@vger.kernel.org>; Wed, 09 Jul 2025 06:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752067552; x=1752672352; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nudfe3LMBXnEpFO20d+2xerOJ+RoR8Nz6J4cQJSJYIM=;
        b=NGHJiTTKm4HgpFV/QLIyL/NuhIzHZEp1V+oDyBaIwYxsX2LEn2BjMA2PALZ6r02t7E
         aRfsBC/1Z0dN6cIamcsWk6Rn5vsr3PJSXTWKCFu749l4IbE+IzKSF1twe7ePAQE9ySix
         HkMJoM8VHIUIeJQuGLgd2q9q2RADed6RHk2mwszu1Ms2ORDAh2NomMataeoOGZJcLviv
         fk8wKhc+Qa00q3xGcbmWCVmngAZD8snf2BgnC20kofzbS9NAAXaszVqs/Xvfo56nP1cn
         EwQuZDe3+StPT4vItlkYZRJMkpxrEZiETmb7iSt4T5a2iV2G5GQ1VFoWXishq80ZwMRi
         npPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752067552; x=1752672352;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nudfe3LMBXnEpFO20d+2xerOJ+RoR8Nz6J4cQJSJYIM=;
        b=mYxARYcI+jlQyGZLKLW1Go1guj3bSe2RDk9XOJ1ZzqvcOYB09eZ6bjvR55CUzqaoOs
         eN6eH/CyGPvlEwRZlbG7HaIgZIOzvCLsPix0gHAIAUQPcOd7zhJn30LUkH7TFkzX24c1
         SJ1eV5Ch1zd97GUcnaV7N0SgwFBgsJdaz+CGElIm7LuxM0uCmb7pwAWByHsb06x6h4bf
         XuHTHBqVi3CtWMeAcn7ScdFTbwQoO9NbYYdlhrWSaM7jeaFiylcYLUfHezkWH5MNlZg0
         eiFIV0dtqJw6Y452M4TjlDdGTW96khPiiCxXJc2LTWp51ITHxMeX1Gs1ODYzOcnBg03a
         0tSA==
X-Forwarded-Encrypted: i=1; AJvYcCV7DpV5JabB51RpKkTRSeDLXM0v0c+U8jYRv7MGCl06UrKv4FPVdJB18RbyoFThvVbvqgO8PLKPFl2CGg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxWNkb/wF09kGKTX/cvlmaPiVVnAXVK00iWsCM+nSamTW8oZb+6
	4tdeYDbLqgvM7IYEJVhSD8EU0+z7DmfKaURVxmcwBLsbupthU3BS6v7I6KJ3dpv0a0p11NScmnp
	F6kDhwgagYcRGB9J/EA==
X-Google-Smtp-Source: AGHT+IFjwCUuKBGi7YyW0JD/w1lRwcEiAg/jl3/NNA/iOBJCWKQvZrB1uhsRLAuO5rCYZyR58odRAH51V3vaEOs=
X-Received: from wrow10.prod.google.com ([2002:adf:ee4a:0:b0:3a8:2ee1:2bf2])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2313:b0:3a4:fbd9:58e6 with SMTP id ffacd0b85a97d-3b5e4530f28mr2161366f8f.50.1752067551913;
 Wed, 09 Jul 2025 06:25:51 -0700 (PDT)
Date: Wed, 9 Jul 2025 13:25:51 +0000
In-Reply-To: <20250708-rnull-up-v6-16-v2-7-ab93c0ff429b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250708-rnull-up-v6-16-v2-0-ab93c0ff429b@kernel.org> <20250708-rnull-up-v6-16-v2-7-ab93c0ff429b@kernel.org>
Message-ID: <aG5t32-BiZYP1EWm@google.com>
Subject: Re: [PATCH v2 07/14] rust: block: remove trait bound from
 `mq::Request` definition
From: Alice Ryhl <aliceryhl@google.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, Jul 08, 2025 at 09:45:02PM +0200, Andreas Hindborg wrote:
> Remove the trait bound `T:Operations` from `mq::Request`. The bound is not
> required, so remove it to reduce complexity.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
