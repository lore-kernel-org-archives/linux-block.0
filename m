Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A41382388
	for <linux-block@vger.kernel.org>; Wed, 29 Apr 2026 10:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777458914; cv=none; b=EdGkgbWC44BPhvnE32Jj8ykrUofzQp6R/L+7ILn4oxrd02C3KBJJ5CS+sRk0HTTXO1VYVv3a9+EaXGZ2Ys+8vCe0rVaQvcJtr+YmpLjilbbAzOkgRWG+dOwWs1lQqiIqXKgCSyLTmG6s8Ratt1vNQxRCYBnj+qQFtFUTt6udKMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777458914; c=relaxed/simple;
	bh=OF+Lroejiv5nI/a5KUmbw9PHHNa6qmut29sztZOGeeM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VTyElzyIi5Frhk/IpFY+Ukk92Ryp1P7Tz02lL3vLlFB6nTw6//xwZi6OBR55TeofDa21FkQK/mwbt0/NKHI2ax3zF4LrngSQNsO0enlWaQNW9uS93rJLUiiYZ7GCWpPuQzXtSnsVXtFP2tLQ1esXpXw1gHsBpbMF5pEz5bAEr8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KvVkzJTJ; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KvVkzJTJ"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-35d99031e4eso8736070a91.1
        for <linux-block@vger.kernel.org>; Wed, 29 Apr 2026 03:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777458913; x=1778063713; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:subject:cc:to:from:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OF+Lroejiv5nI/a5KUmbw9PHHNa6qmut29sztZOGeeM=;
        b=KvVkzJTJzsZ5E/Tn6rRm6os6h9PRKW2hpkkucsRLSsxWkntHjNSjDX+ZKLjtS/Gs2D
         EbR3B2Uvh+hws2/3g+1ienQdvBpnDPcj9LPM5nQ/Qxy7TOYSxUhPdiYz4pnt/rrox7nh
         aHPGN/rifdnJoxBXl6g4e2DUlqpTf2TZu8AG2bPxsrE8CwoidhrNjSjjRRwmNvl/Psl7
         e0tIDA0LnPU0fz7BOfMv3rL0fXz2A8CrWk2xi97KOj8YBDNnVhhS1MhauXu0F/6tR5UM
         7RwKeU5PbKragQN3DqYTZg39YPqTyTGG2eqYa7fNH3rh1bwM4K3CRKpCKmYx/gqdWPVl
         HR4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777458913; x=1778063713;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:subject:cc:to:from:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OF+Lroejiv5nI/a5KUmbw9PHHNa6qmut29sztZOGeeM=;
        b=gjVMwWVM92lWUn8fITnaNNOMaGJndtEz0CFRc7ZO8q2F2wY6VNfk5x+4iezg7V4on/
         Wd7kI1aeHtU4g6NElO2oCOsCaGyjq/vvW9RqhrqpxAv8q4SOWdZIHMXMsQQ/5i9UwSQm
         ohBREPYVDgB2tcP2xN/18aOJRslzngWnVt1xF34aQRfwhwCttc6qajYdnBmP1u1ma/o3
         F54D5kOyxbCQ82RLa3qh/HwoX+UCyhN9DBDgjBdctizr1O2/8LnAs1DWUMb53nl3xr3i
         fkTGzCe/XTNTmvTQRxIZSW/2mxCxuY4RyIYXx3Szl4RSULXSnhc6G/yJurAtTOTNh3FR
         52Ag==
X-Forwarded-Encrypted: i=1; AFNElJ9GHjqtIH48uwiv6tjyL3RFVhCyCgronqqwpYxMh/xcZ0Oej/PCVX7L4n8PBvsN+17Yajzu2FoVfx2HCw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy26POdjf/xxVJZQgBhslOnxV5gLIwMkAAVZwYcwphHKl2g6zWo
	kTyTMQRzy7aLKGVc1TyThZyza44m6Bedztv6taLaZNkCwHizJxUhHWrO
X-Gm-Gg: AeBDieumKNV/tUG39GC5xkKjPeYKBBPRivdfhbULR33KdRCt+KlNx41NX3xS12ETEYu
	dXFnjnkc58F3dE63Ien2kQt3V9gzcYSPeQuotFHMXonz8TiOr5j9GvzOjY831oAg84ZRofcEaFG
	LcSEN2RyCkMxB1Yr2KA2OnCF3pw+Js68V0sIc0HKNgCVR+0/MZvCCrG41S50QTTShD4be7C1AtH
	fK5CkIHKmg61PdIntSmlqxALrniCrSI8PgeN3iyaggO2SdQl8WabSDdzeQY9zfWLa3ApyK0JpaI
	87loZHXCvCzw7zLSUCxmcO3HEop5ONcxCWHvCAp65F97EBcVfPa8dTJ7py+O9XDavwBXFH3smXd
	iGXdJVtXzP35qOFsTmfW6qb0OPXvRht+Web3LhMNY4WWx8mMt/dnla9NsLyAu5zhxOwc3ef/8Eg
	cUu0+MN+UEUtqPILHhuWaHC8/ECOjSiQrnxcw3s0hrQiyvJiHzTHcJampINA==
X-Received: by 2002:a17:90b:4c92:b0:359:f2e1:5906 with SMTP id 98e67ed59e1d1-36491f6c206mr6861094a91.4.1777458912886;
        Wed, 29 Apr 2026 03:35:12 -0700 (PDT)
Received: from yuwhisper-pc. ([49.213.140.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364a02c54b5sm3066416a91.10.2026.04.29.03.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 03:35:12 -0700 (PDT)
Message-ID: <69f1dee0.170a0220.115a12.6bcf@mx.google.com>
X-Google-Original-Message-ID: <afHe3HAh1mSqXD2t@yuwhisper-pc.>
Date: Wed, 29 Apr 2026 18:35:08 +0800
From: Hsiu Che Yu <yu.whisper.personal@gmail.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Hsiu Che Yu <yu.whisper.personal@gmail.com>,
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
Mail-Followup-To: Andreas Hindborg <a.hindborg@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <u8w2aT8RMDhNK-zCkHKofFcml9mE8ndgtCnpwTrMWy6Kby41yC9ODSFCSKRZF8QahViSy2ANwHyurTUyVlgroA==@protonmail.internalid>
 <20260428-fix-docs-mq-req-v1-1-260079853836@gmail.com>
 <87cxzioyt4.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <87cxzioyt4.fsf@t14s.mail-host-address-is-not-set>

On Wed, Apr 29, 2026 at 12:17:43PM +0200, Andreas Hindborg wrote:
>Thanks for the patch. Please be aware that this mistake is fixed in the
>latest rust null block series [1]. Please take a look at that series if
>you have more patches for the rust block subsystem queued.

Thank you for letting me know. I'll take a look at the series.

Best regards,
Hsiu
