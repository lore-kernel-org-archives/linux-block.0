Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0F9194C6A;
	Fri,  7 Feb 2025 23:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738969922; cv=none; b=kP0jqUPObr6UFAWKpEjkY4akVm+V6SkFSuD3mnoWKf8kyQe+ULVlttvuuNu4xOHgMevOynIOmi1Cy7zp9OmHDUTjdANLtucfTXJ4/HWXrUNgVx2lQ597XPv74HaySSEMMmgSocCv80x5xZHyrI6DiaSzhntWzZnXdeS7LgKTLfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738969922; c=relaxed/simple;
	bh=Oo3RrxKhrvpz9Z7Fg0GxqsF0JzC7ycu+gkRfh21rysA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lLZYmyDWYzvrhfuyVV8rchCoqZk+EcCr/f1Fjki9LwGr6LDemMfRbEhC+GnVgXyV4ieXMvMdGt00sCzcCr8gzIRTNKm/5J+l0h88WceUBKEEMr71C6gwstFOl9mJyeSqags5ryHR/jYRgoMCxkju7ilINLUAlzeLEfQ85Fa/1OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K+X8Pp+x; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K+X8Pp+x"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2166651f752so59165775ad.3;
        Fri, 07 Feb 2025 15:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738969920; x=1739574720; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9xzwGP71iBtkAnKWv/v4nhquoUa3DKrGdnwtB4xMVLo=;
        b=K+X8Pp+xBzJ8+yqC/8BiHQ8AxFzDD7c3yA1OCgmQuSA0eMmsqE9VQBDD7kqnw1QTEu
         4bD1ObgFkIeSFRHQt7+awKc047GHPr8V/sk9pZmMVbBE2PiSAE/QaKdGBY8Moq0BjhsJ
         sJQMD2XZljuyBMOIzOMB1My4dkucPY0bup1aYZhosaifD4PIrTttzzfQ36BcCoM+LSOy
         SWHgWb7PHGLgk4jYstT6KoipNNxkUKNyCGNqnl+dFOgxj2b/TSnLkDkERd3RB1pswmfS
         TuSqleCMO/WEBcOKepefg7UyVF/59cmstW6PdYQdqibnJWC6o6P6LKPoY6vHF2weruJe
         o8Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738969920; x=1739574720;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9xzwGP71iBtkAnKWv/v4nhquoUa3DKrGdnwtB4xMVLo=;
        b=A55tk+q1WZU9M0K1pJX/aU9hTkeXtvmOsl+GPoSiTjyi+rm6XxbKsMsnaHzgpjHJFv
         N8fZZ8JbGknMEdbj2GH3cGgXBhMGeoS4y7/wbbNY90RCaOWyQVpfud8chMuHfKNs8++p
         yQMNksPoPADLtN9BGcn2wBTES5Og3vErhWu/fVPk7v5NH7TIU9W7ZEztC/yWgRZRNwe2
         VXmRH6h6wI6o+nEKRO2x75VDfggCeVoJrrIdPymFY8y7UJ3H/NSYBLPK3uE9qEfqPHnB
         /hRaKppcSeE9Wga3FKfnE2J5kSJOiFN3rM0r/5UqPMs9fPcpME5fW0Scbb5HaPf0sejx
         3cUg==
X-Forwarded-Encrypted: i=1; AJvYcCUVd2ZVPe61BZGPi3IPOS8aBp1cyGUpoLlKvY6Em8K/4MOfgboIR/i0EcoLBq/MPkx9f5JmvbU8rdD/X0z0@vger.kernel.org, AJvYcCUgV9erx9fDn3LKgBjN3f/RHCHsbAkV79GNN6cmRhYa5IKhFo0/iFJ0F8SlFN3KmZQAEg6E6EPiSOAEnA==@vger.kernel.org, AJvYcCWTtHqHWRwYQPummElo6nCYGGLq/APj2gXjiPebpnCobMK7N5WQucM5n+ug16OZQavUohkak8KiiFLY8RGQ2rk=@vger.kernel.org, AJvYcCXO4mWMvPG/lo4sFfBI5sfphQit7IHRjyvvxHTZeyUnqWTrHtuI6cpEP6wfuKvbc4YpL0a9hvh3@vger.kernel.org
X-Gm-Message-State: AOJu0YwfXAMYILKHSUtXx5IEXHzcHRB+5AuhPKurxi5jo+PWRqcCrPLd
	fUWHsTIU/Nko+FjelQ/p2ULpaFdw8zo3Plw7olI9yG87Zfq8jwEV
X-Gm-Gg: ASbGnctI1hKGS3yExFO8DviDI8QrDuTjTXRM+bYohGITbTXjp6PaYbP2AXDtMmpr172
	bVk0pwUAX50DrI8zfrH0l3RhOCC72zxTNsUQs0BgG31ZX8G00skbsqmVEbkVPq/YV7RnYH1OIFR
	1JdXUhlSfYrDrSmbNyy9U1N+Mc2MbmFy05YIlNDcoIFdbuoskk9r5+XL9att73kEhnqPcW4f8QS
	tzOB//Obm2HmrNcrRRruBgbu8mzq/P87zhB0HFGtuDu2IP63r8F9OHlNW/PfOkYhzHN+mj6d/tY
	1YQZmdOlOr8g5p1wmOcdyngZEAL57emQbkdbXwnsqEFfdh5/Ew==
X-Google-Smtp-Source: AGHT+IEtQgrERIkEeRV6qfsbPPyEM8kqZoR0ydnZ9VRmTggz4ArZtp3fbcDvsY1PAsDkvAGrPJtjCg==
X-Received: by 2002:a05:6a21:458a:b0:1e4:8fdd:8c77 with SMTP id adf61e73a8af0-1ee03a24353mr10015384637.8.1738969920503;
        Fri, 07 Feb 2025 15:12:00 -0800 (PST)
Received: from Cyndaquil. (203.sub-174-224-192.myvzw.com. [174.224.192.203])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad51af7811asm3703453a12.72.2025.02.07.15.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 15:11:59 -0800 (PST)
Message-ID: <67a6933f.630a0220.137520.f9b8@mx.google.com>
X-Google-Original-Message-ID: <Z6aTPscqJ5P9Bjsy@Cyndaquil.>
Date: Fri, 7 Feb 2025 15:11:58 -0800
From: Mitchell Levy <levymitchell0@gmail.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/2] rust: lockdep: Remove support for dynamically
 allocated LockClassKeys
References: <20250205-rust-lockdep-v3-0-5313e83a0bef@gmail.com>
 <20250205-rust-lockdep-v3-1-5313e83a0bef@gmail.com>
 <CANiq72kawfy3YYyo7ANYrKVjkh0n53Jt_d0=bHqHfirHCxe6_Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72kawfy3YYyo7ANYrKVjkh0n53Jt_d0=bHqHfirHCxe6_Q@mail.gmail.com>

On Fri, Feb 07, 2025 at 12:27:58AM +0100, Miguel Ojeda wrote:
> On Wed, Feb 5, 2025 at 8:59 PM Mitchell Levy <levymitchell0@gmail.com> wrote:
> >
> > Currently, dynamically allocated LockCLassKeys can be used from the Rust
> > side without having them registered. This is a soundness issue, so
> > remove them.
> >
> > Suggested-by: Alice Ryhl <aliceryhl@google.com>
> > Link: https://lore.kernel.org/rust-for-linux/20240815074519.2684107-3-nmi@metaspace.dk/
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Mitchell Levy <levymitchell0@gmail.com>
> 
> I imagine we should have:
> 
>     Fixes: 6ea5aa08857a ("rust: sync: introduce `LockClassKey`")
> 
> Is that right?

That's correct. Thank you for catching this! I will include this on a
resend.

Mitchell

> Thanks!
> 
> Cheers,
> Miguel
