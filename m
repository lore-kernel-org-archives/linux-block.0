Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEB6285C8F;
	Thu, 28 Aug 2025 07:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756365526; cv=none; b=WtvOIalSdLr4EusTzxtmJoQ83Wg5G38Gs9QG7R553shhRW8y4G6wFHoU4N5PkM+wYHGbVp3CH7Bnp1B12iNZBdwOPU59gLt9Arn5bmQDS4eTBEzuu6+4OJnq1aNCyPjdbGdsINIDSY+jB77UsTfkcWkbxyJoLdPn0bVnGFGfDNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756365526; c=relaxed/simple;
	bh=cA5MEAXP03zgaSoPxfhsQEUE2K98DB+Y39M3JJff4ZE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=SmuZn4O9ScyIPqcCXqyPO4V3VFELplF0pKJjVTBS/UbNUOZ0oykIqjrmxYAk11cMPUrPmmlADvbJakCp5tK+pDK9SUA2BtKFoxc+0RTFUdmFVhpUb8MCmK6oY3EkUphLM9l/dB0adwGkTpA/qab6t7AEF/ItTYUvkjgTyiQL5jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nRN/lRAy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nRN/lRAy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 206CFC4CEF4;
	Thu, 28 Aug 2025 07:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756365525;
	bh=cA5MEAXP03zgaSoPxfhsQEUE2K98DB+Y39M3JJff4ZE=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=nRN/lRAyvpRJH454PxRYY42feW1jFX7UY6o9HXLD3ibezaBcrl7ViwrsPZySLqk1q
	 jSDVpUv7F3QCGFGjQyZsPZwshYrFkfDBN/CP99fx3eTc/kJP2hVThBF+JQtShFeaf1
	 TM8FM/qu426/8PAZtk2prUMcl4R2rmhS9O0EK2jPtyELmrq9iDuu4NMCtYqBp67mnn
	 INi9cRwtl0/zwqwRWdXgX98UhuLSEvqzIz619FN1Cjma8+GVd3zKpFzwBRE05ahzDG
	 876/psvv67SgRkv4TQEJX9VkhlqrV04Mizhrh9jfPVzXKpv/ukczRAT/B2QrEDmdqh
	 /Ti2rXxvLqE3Q==
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 28 Aug 2025 09:18:40 +0200
Message-Id: <DCDVM56I5WPT.2L24NI3SBBIHU@kernel.org>
Subject: Re: [PATCH v5 4/5] rust: block: convert `block::mq` to use
 `Refcount`
From: "Benno Lossin" <lossin@kernel.org>
To: "Gary Guo" <gary@garyguo.net>
Cc: "Gary Guo" <gary@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex
 Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Will Deacon" <will@kernel.org>, "Peter Zijlstra" <peterz@infradead.org>,
 "Mark Rutland" <mark.rutland@arm.com>, "Tamir Duberstein"
 <tamird@gmail.com>, "Francesco Zardi" <frazar00@gmail.com>, "Antonio
 Hickey" <contact@antoniohickey.com>, <rust-for-linux@vger.kernel.org>,
 "David Gow" <davidgow@google.com>, <linux-block@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20250723233312.3304339-1-gary@kernel.org>
 <20250723233312.3304339-5-gary@kernel.org>
 <DC0AUNNAKGJI.4KX0TW6LG83Y@kernel.org>
 <20250827205121.59e4cc32.gary@garyguo.net>
In-Reply-To: <20250827205121.59e4cc32.gary@garyguo.net>

On Wed Aug 27, 2025 at 9:51 PM CEST, Gary Guo wrote:
> On Tue, 12 Aug 2025 10:17:44 +0200
> "Benno Lossin" <lossin@kernel.org> wrote:
>> On Thu Jul 24, 2025 at 1:32 AM CEST, Gary Guo wrote:
>> > @@ -34,6 +36,18 @@ fn as_ptr(&self) -> *mut bindings::refcount_t {
>> >          self.0.get()
>> >      }
>> > =20
>> > +    /// Get the underlying atomic counter that backs the refcount.
>> > +    ///
>> > +    /// NOTE: This will be changed to LKMM atomic in the future. =20
>>=20
>> Can we discourage using this function a bit more in the docs? At least
>> point people to try other ways before reaching for this, since it allows
>> overflowing & doesn't warn on saturate etc.
>
> Would this additional doc comment be good enough for you?
>
> /// NOTE: usage of this function is discouraged unless there is no way
> /// to achieve the desired result using APIs in `refcount.h`. If an API
> /// in `refcount.h` does not currently contain a binding, please
> /// consider adding a binding for it instead.

I'd like to stress that the atomic doesn't have the same protections as
the refcount type, how about:

    /// NOTE: usage of this function is discouraged as it can circumvent th=
e protections offered by
    /// `refcount.h`. If there is no way to achieve the result using APIs i=
n `refcount.h`, then this
    /// function can be used. Otherwise consider adding a binding for the r=
equired API.

---
Cheers,
Benno
