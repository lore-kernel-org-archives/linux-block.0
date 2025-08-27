Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B51302760;
	Wed, 27 Aug 2025 13:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756299795; cv=pass; b=dZlM0VrWXZtz0hcy5SS10JprLqi3JaMZOTsPByenkSbamWOs77OLxrJjHo3HRjVwrEeRr/nlGgwvOz4psb4Q/egv646nr6wf9o/r/SdlT7WL+6SgBgV1jRImyzFRgF9D+tkWka9FDmzMyNTVPmWpovZ9r+/PvKqEDZ4rNZ4Q5xo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756299795; c=relaxed/simple;
	bh=cE6hyLFmrH6jjJyToAUXyVeW+z60z7Zgr6CnYsE7u0E=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=J5EREN6YW7Aq8+xywVa5WWtLIJJPHat29SI1iarszomWGkSRmuzsS/hsNj/LbajIl2PdKaJ/CMXUDtSOF8g1uQxYZkLo/w/FY4GmduklemBmRFB/PLtMY9bn2640Dv2pdRLzMHLdR6yHfotZbhVN7ctp/t5MBcboTDMf0L+qvBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=CslwVnhF; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="CslwVnhF"
ARC-Seal: i=1; a=rsa-sha256; t=1756299775; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=BExQClGzndmlQKTCBnyz+1S0/ZEzYWm/AJJod51VKiUhg1X+nkC/oluNU36oYkHwSAy/vxuw40F6k+fDQ5BJHxn5qMJqOel1TCNDhdCL9xPpWYbi5aN8DqeIwjA/q0v5moheWOj98+KzYvJ2Mu+KrkJGf+NwQhLaO6aj3T/DCbQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756299775; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=bF7pQBFY7CqIgY8f35aNdCRUmkVlp59evzsupE6bLEM=; 
	b=S48DMefZQ0TkOyLb/199DbWj8GB8vQ2raf75ZCoj6OulfgtfKtWFqLfLZ4Wm/pO3JFT3SONmV9VbvRsS/lnv8XkYiVSlBJvSC/5xnCOl7ts6DDCDxRboZYa/OhyYGWQFMW2742iLY/nwSODLiLTg3BuWBcvRRb9lQP0+OJKXl5w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756299775;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=bF7pQBFY7CqIgY8f35aNdCRUmkVlp59evzsupE6bLEM=;
	b=CslwVnhFWFsXgAlrEq2ctLnxCqzWKx6WJVr/6KzDS539x3UMYIOPjwMQHCKhtvuo
	k6QsUY2WMcPot2T+HHwwrghXvp7dcgmxwLjVFD5GoUHhC8EvsJvKJ9+M3hwDJtDyZnX
	9e0v57HXvXMU86x8s3k3orNpS2/4N3M+/akJPGLg=
Received: by mx.zohomail.com with SMTPS id 1756299774531372.8098676556684;
	Wed, 27 Aug 2025 06:02:54 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v6 04/18] rust: str: introduce `NullTerminatedFormatter`
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250822-rnull-up-v6-16-v6-4-ec65006e2f07@kernel.org>
Date: Wed, 27 Aug 2025 10:02:38 -0300
Cc: Boqun Feng <boqun.feng@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Jens Axboe <axboe@kernel.dk>,
 Breno Leitao <leitao@debian.org>,
 linux-block@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <2C9D54CC-F931-41C9-967C-14EA375F9F2A@collabora.com>
References: <20250822-rnull-up-v6-16-v6-0-ec65006e2f07@kernel.org>
 <20250822-rnull-up-v6-16-v6-4-ec65006e2f07@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External



> On 22 Aug 2025, at 09:14, Andreas Hindborg <a.hindborg@kernel.org> =
wrote:
>=20
> Add `NullTerminatedFormatter`, a formatter that writes a null =
terminated
> string to an array or slice buffer. Because this type needs to manage =
the
> trailing null marker, the existing formatters cannot be used to =
implement
> this type.
>=20
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
> rust/kernel/str.rs | 49 =
+++++++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 49 insertions(+)
>=20
> diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
> index 46cdc85dad63..d8326f7bc9c1 100644
> --- a/rust/kernel/str.rs
> +++ b/rust/kernel/str.rs
> @@ -871,6 +871,55 @@ fn write_str(&mut self, s: &str) -> fmt::Result {
>     }
> }
>=20
> +/// A mutable reference to a byte buffer where a string can be =
written into.
> +///
> +/// The buffer will be automatically null terminated after the last =
written character.
> +///
> +/// # Invariants
> +///
> +/// * The first byte of `buffer` is always zero.
> +/// * The length of `buffer` is at least 1.
> +pub(crate) struct NullTerminatedFormatter<'a> {
> +    buffer: &'a mut [u8],
> +}
> +
> +impl<'a> NullTerminatedFormatter<'a> {
> +    /// Create a new [`Self`] instance.
> +    #[expect(dead_code)]
> +    pub(crate) fn new(buffer: &'a mut [u8]) -> =
Option<NullTerminatedFormatter<'a>> {
> +        *(buffer.first_mut()?) =3D 0;
> +
> +        // INVARIANT:
> +        //  - We wrote zero to the first byte above.
> +        //  - If buffer was not at least length 1, =
`buffer.first_mut()` would return None.
> +        Some(Self { buffer })
> +    }
> +}
> +
> +impl Write for NullTerminatedFormatter<'_> {
> +    fn write_str(&mut self, s: &str) -> fmt::Result {
> +        let bytes =3D s.as_bytes();
> +        let len =3D bytes.len();
> +
> +        // We want space for a zero. By type invariant, buffer length =
is always at least 1, so no
> +        // underflow.
> +        if len > self.buffer.len() - 1 {
> +            return Err(fmt::Error);
> +        }
> +
> +        let buffer =3D core::mem::take(&mut self.buffer);
> +        // We break the zero start invariant for a short while.
> +        buffer[..len].copy_from_slice(bytes);
> +        // INVARIANT: We checked above that buffer will have size at =
least 1 after this assignment.
> +        self.buffer =3D &mut buffer[len..];
> +
> +        // INVARIANT: We write zero to the first byte of the buffer.
> +        self.buffer[0] =3D 0;
> +
> +        Ok(())
> +    }
> +}
> +
> /// An owned string that is guaranteed to have exactly one `NUL` byte, =
which is at the end.
> ///
> /// Used for interoperability with kernel APIs that take C strings.
>=20
> --=20
> 2.47.2
>=20
>=20
>=20


Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>

