Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF57F20ADD2;
	Fri, 10 Jan 2025 10:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736505923; cv=none; b=P5FrQbxbruqqtqNxYRVt99v7UK+3OMi5kNikYZxvXH5hvz773uaWJhagZ/oyGGayKPiP8w0IRBCNxsWnsTZbBjlJzaqCepmfpyMbCwjn4vb0Iy76jH9plZWK2VhmeUaiexSMw9eOAx/O0Y85sa7yYodHE0BMYF+Z9WQM5Se5kyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736505923; c=relaxed/simple;
	bh=9kmYfii9RX2U7mMEGMR8zK90qGYxJcZFz6B28Hi5jJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OYDOLJoUzXQ9QEQd+7axqSG/v4wK8u9bwqGS8PgjFP4s7l8kQ3sx555AXudjIokBEioyoopG07APFBY4TPhBh/ecmNISjtcNOkgDcbc0CD8vuYO6CVP8rn7fogVPjhzFKhHRs6DOGXjwU4ML9bLz13Z0PFDDJ39Wkg3strif52A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DxDwQAsI; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DxDwQAsI"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ef7733a1dcso389613a91.3;
        Fri, 10 Jan 2025 02:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736505921; x=1737110721; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QjFG9eoF5KoeJh58XhHidOIUaimWWCKxV+cQnJw0138=;
        b=DxDwQAsILNCLbVvIbYxtdXsqLtDtowIr0cAmYDExl12AmJd6tPi92tQ9dgELheXeAf
         1GnXQqEBJ4tR1hOYrxfL9uniuL0yjh4EBWAKM0WmQdFYtFuqubFinZKKjKyytDpzU4wJ
         NoSOnC6PjdMXwWQ5sm9ckWFAXZeXdGSxXdkpZ68eEswSaW6zVKl2gCo0wh5fUroqIQCT
         6gDLrxj5w6LTVjX3k/6OjxB/V1qAqVGAFu0Hd0OIeV+c7npgZst9swsC/LmuTKVUC+++
         Aj/f6e/8QS7EvbdAIoTfe4leUR6aDgNG+42qJFCHQ8TQekdM0hx7Yf7XYnZxbyv+EgvZ
         0HEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736505921; x=1737110721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QjFG9eoF5KoeJh58XhHidOIUaimWWCKxV+cQnJw0138=;
        b=CRBnHXj7lggNkfZOrKttTL8etSYMztzO0iISx36CjjgWbdzIKlcQnjjfXXG8NtnXJM
         cT+ImUg4r3x1F5AzHRMbfuw2XYxoV0PQ+hBeEm1C/gU9+QLh/j0NQ/vIXrnqoW/O2ohZ
         RCPGPwaLsSmU8RjYEOnvK3fZ2awvrB/z9Usp9tNg2j1sHGy254PXyT0e6idOknUvWdVA
         XZuwMRDOnPMmzFP1fwAMl44VtvHu6LUiwaBgYZhJttoJObqtZlptFCua+U/cXSSWWK1c
         aX7yf7HClGPX5JHpZBYr/dRvvVSHPSoSuyhXoUsQZdUktw4itYsFJxjzsO5i8lwJYFEs
         MnIw==
X-Forwarded-Encrypted: i=1; AJvYcCV0h1jcMyAY2Jr4xS0TbtK8otz3b30wBykDFRLmGHT5y/Pgds/9uMFtzFSb12ytB232+kk/w6J8@vger.kernel.org, AJvYcCVbl8rHisHi0tlIwjHmWb1c9SxjHmmLJanD+PfijvHTb13nHf72Ees9YmGDKDJfZcj3yyhw8HR6JJ8cml4jOcE=@vger.kernel.org, AJvYcCWH3FNl8gKS7h6m7XcflmfgmNzxeuyd3J+Nuf0S94Qk1WrcLLMWCNw2vjA4RFnmD/LD08a0k95dkiiSgA==@vger.kernel.org, AJvYcCXIOFoapCiUjLVCbTdE5denVIBDpowP8nF82CQiSLzHV6NN3jSvJ2B6CLHux1bX5Q0Tndp5uABDGzN/rBg+@vger.kernel.org
X-Gm-Message-State: AOJu0Yxna76dqAkzHRI8JTuZ5opGnNSc3xvRzX1uzJOyaKt16NBT0RHn
	XOYeoqlg7ZBJCHjMPb1roany+ZiVjT9OPdAzgT4Iz5HbJsx2DaPWK86YU5+iTHVgs/EMACP3BZm
	XpQbACrbOLIPGk2KMUQLGBXZK/aM=
X-Gm-Gg: ASbGncvDUxqiPxlnBdY0arF2nSssKGjD2gbjqXjL9F22W24gWNUTBbguuHEpbtf8eFz
	XYGMBTjui9VetSCx8mQyZS+jqXxGEZbkfb8Km1Q==
X-Google-Smtp-Source: AGHT+IGMqTSbQeiJP5ZxmSGgreQgKMlq5CZc1deiIvS0mo/5zzhBWsmj6KMc0f4dmwZgLHdcVVT0SKUHCIx5vu56FtM=
X-Received: by 2002:a17:90b:538f:b0:2ea:5e0c:2851 with SMTP id
 98e67ed59e1d1-2f548e3c0c8mr5826873a91.0.1736505921125; Fri, 10 Jan 2025
 02:45:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241123222849.350287-1-ojeda@kernel.org>
In-Reply-To: <20241123222849.350287-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 10 Jan 2025 11:45:09 +0100
X-Gm-Features: AbW1kvYKyt0J3KBBxnO0-hQyqaIGvxvx9voYhQxR0V5H00LzwkT1P9Fk3OFi2aw
Message-ID: <CANiq72=cYdFW-SM=G2ajqTscwpti5CB-eEc3fb3=tLy7ahg6oA@mail.gmail.com>
Subject: Re: [PATCH 1/3] rust: use the `build_error!` macro, not the hidden function
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, netdev@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 23, 2024 at 11:29=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wr=
ote:
>
> Code and some examples were using the function, rather than the macro. Th=
e
> macro is what is documented.
>
> Thus move users to the macro.
>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Applied series to `rust-next` -- thanks!

    [ Applied the change to the new miscdevice cases. - Miguel ]

    [ Applied the change to the new miscdevice cases. - Miguel ]

Cheers,
Miguel
