Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69ADF2D6402
	for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 09:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752572523; cv=none; b=mU/PAW/z9Y0QbzcccRbmFLbDzzRvhXOck9YDYZEyq8dh984TYKjQOsHChf8mhpwrKSfMgkfgMC6e7/j4tURKqaWXzy30q05/48HQWBd1F19u5wvTU4xBhi7rwpdbJTeFTgOSkKWANGoPqRgnTAKe3/+rVUiFOH51l4lamtrxKyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752572523; c=relaxed/simple;
	bh=6mX6v1XN0y1wLhISjnxbGn87YAYAdv0A15KUv5tWqng=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IaRzUH5VshLSKflVbHt6opkuwwlogc1TT5ngIBjoHlrwqbmn0KWL1QrG7vTINU6WyjoygzjQsHJRx2qIRHnzcp2oNA4v4HlaJm/rhRgu1/k008voHZ0QUI5SmBIxc4z7lyChKAoOcABL47/b/QLRvhvvEK9M5pC1JEzjosAuxjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jsX+7q3D; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jsX+7q3D"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-456175dba68so16610695e9.2
        for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 02:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752572520; x=1753177320; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vCOcsV4QMbyLyBjdT/exfCsj0/SbOguasr+nXCYSr+8=;
        b=jsX+7q3DA1hYgdn8RBNkRV6UunniTfvubCvqtD93fkqbuwoYSEV/AWEP92zk4XbASO
         A6O2ryZ4Q5s1m0VKDvhgGFW2Xuz4TWqovH0S0tkKS8GP4yfY9HWOyuMvt9t2meboPyxs
         23YxOvOxfB2GI59EeeTg0YCP6z3G2T+Grpb7qRq/9XLVK5iOF6+s+G9yGOoXCe25ldjK
         skxXRumh6Pp3Lc+gwN35lEE03edEvSQvFdQ4KYatkPZ5ixDGUzwp3lF+k3LCAQAaJyy7
         22aeLyh8rF89TVxAAdL8XCVi4YJWIk9G3m8XlIQFtgj7wemcvAq2rFBdL121CXaN1TSW
         +PNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752572520; x=1753177320;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vCOcsV4QMbyLyBjdT/exfCsj0/SbOguasr+nXCYSr+8=;
        b=S/5p7AkQOBN2/uTesT6yW6OwLvBZ0VyDHeuWqddhCOg/t0TxmHDPuYVsYwiZh4ZVP5
         DQwhj3Zfsjc4qvUAXrdpn80w3JyIdKtpB2Mjc0VFiRSH6bib2L3o62Fz4JOpsiyAeNXR
         R7cDMmRztsenC9A1jcevBKyPKtdqA/avoShKeoBcsgayJ0IRaNCMLZasBtAU4X4/+Muf
         wxYnDqsZjTQn9jcjpZq6PfTIYbcIoXXsi8uFJ4MoJN9rlHXa7OvP2aezac+0p2iEeZCc
         50Dh+BDOM+W9KJQ3jUmgQPEAvB7NisTyw7Rh/w7e1HJG8BgqbTLso88Ql0fIJN4XkneJ
         f5Bw==
X-Forwarded-Encrypted: i=1; AJvYcCWimn6yNPAMW5Kq3rysK2u65Cfq+CU/OorusOWeL70Klncni9rNDL4rwA3b1M0kciZ0ZMKqgx59qsUMsA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxfdJak/eRpXD64ZAntlPBXtuyoCt24wFOYS6yZuuxPFtSvQCKk
	wbLIhwmCvDe1x9lN7rTdoVRf8hUgOEEjMrnrHO9k871oofPOZNoWpFH49gOEIrOTLHtev9XVlOM
	zclqCEBU/tPK4qKffmA==
X-Google-Smtp-Source: AGHT+IH2a0YqGnJWrezL8ePmfjVywiZ3GRN/W9elnPRe6l1D5qfddWIDH5vOoagpaiyTIcxLU6bHGSZIomcAJDM=
X-Received: from wmbds6.prod.google.com ([2002:a05:600c:6286:b0:456:fa0:e0ba])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3f0c:b0:456:dc0:7d4e with SMTP id 5b1f17b1804b1-4560dc08725mr100420025e9.18.1752572519803;
 Tue, 15 Jul 2025 02:41:59 -0700 (PDT)
Date: Tue, 15 Jul 2025 09:41:58 +0000
In-Reply-To: <20250711-rnull-up-v6-16-v3-7-3a262b4e2921@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250711-rnull-up-v6-16-v3-0-3a262b4e2921@kernel.org> <20250711-rnull-up-v6-16-v3-7-3a262b4e2921@kernel.org>
Message-ID: <aHYiZtzAwvIDuJFD@google.com>
Subject: Re: [PATCH v3 07/16] rust: block: use `NullTerminatedFormatter`
From: Alice Ryhl <aliceryhl@google.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, Jul 11, 2025 at 01:43:08PM +0200, Andreas Hindborg wrote:
> Use the new `NullTerminatedFormatter` to write the name of a `GenDisk` to
> the name buffer. This new formatter automatically adds a trailing null
> marker after the written characters, so we don't need to append that at the
> call site any longer.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
