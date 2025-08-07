Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60B021B9C0;
	Thu,  7 Aug 2025 10:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754561998; cv=none; b=j4jQvlg5A7F+m9qdUDLMLUjgWjQrN7oBdUIAtMwP0/TD2NOTY0v55AX3htx0447etfpHUtCRBVnLXIcs4BKtzvhfWZM1qTEYqFPt5PrnVkt8BOCQK9HrjXRJpAJ2MLSnoTW82r6vgif9lMlBe4+YXiJrazdLmO+pKhBRf7TNsvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754561998; c=relaxed/simple;
	bh=o57OTN8voB01Hp41OLxEq3ScLYkJIwrFSDKarCQu7Lw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=esoy7lv4x8rtYcOtpuHpWqBKzBlVpwpY0GR0LGEfW96DdU3Hm0XqgStm+O0nVPs2fVpyUxbTMWXSyxCZwpob3Slimz5DaCXLvmlEnXPxBH7I9WfRCjRH/U9JMMmiVgkZQ4RaA5/B1lfL7KnRwy9ddssx9UKAUlEAgur7qL45lDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RsWbMsVI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RsWbMsVI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B86E4C4CEEB;
	Thu,  7 Aug 2025 10:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754561997;
	bh=o57OTN8voB01Hp41OLxEq3ScLYkJIwrFSDKarCQu7Lw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=RsWbMsVIh3tfS4xxrmcLQqCRhOJMCOJ7AwoJ19vPjC0CiOMSQdHZQJtglDojxJ6yc
	 PfFymuYnorwHwo7RnTSNXr7oln5zhRM8T/e7fEGx3o8CQzZYnVZ6nVMFq08k1stxxK
	 EQtn4mTeHndEJyi+4/JxfyPygy+vVhY1XfXwSlsq6VAipRzYSF7kckePpq+IHL/rs/
	 iYAXqh4QOUFKArF+h2bgt1gROWytDBXXTMAWcOqPoB1QzVZD5xZt7PYPA6GXkve8Fp
	 +0Q2oxWJ0NsEG6WYlDexmpu+zDmPInMDjzJ8ExshSYJ6sMb1+jKscmtE4kxgTK/OWj
	 BISAJb1Ko9VLA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Alex
 Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy
 Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Trevor
 Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Jens Axboe
 <axboe@kernel.dk>, linux-block@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 12/16] rnull: enable configuration via `configfs`
In-Reply-To: <aHYjrSPttj0VQ7sg@google.com>
References: <20250711-rnull-up-v6-16-v3-0-3a262b4e2921@kernel.org>
 <20250711-rnull-up-v6-16-v3-12-3a262b4e2921@kernel.org>
 <N2Ih-wujcPdEPSMN_mzEqqmUTRQruN5KIEfIm7o2L7czU7sc2jBcv5vR5nHeHYg8nbWs8ViJcEvdS78Ccv2Euw==@protonmail.internalid>
 <aHYjrSPttj0VQ7sg@google.com>
Date: Thu, 07 Aug 2025 11:50:37 +0200
Message-ID: <87sei3795e.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Alice Ryhl" <aliceryhl@google.com> writes:

> On Fri, Jul 11, 2025 at 01:43:13PM +0200, Andreas Hindborg wrote:

..

>> +#[vtable]
>> +impl configfs::AttributeOperations<0> for DeviceConfig {
>> +    type Data =3D DeviceConfig;
>> +
>> +    fn show(this: &DeviceConfig, page: &mut [u8; PAGE_SIZE]) -> Result<=
usize> {
>> +        let mut writer =3D kernel::str::Formatter::new(page);
>> +
>> +        if this.data.lock().powered {
>> +            writer.write_fmt(fmt!("1\n"))?;
>> +        } else {
>> +            writer.write_fmt(fmt!("0\n"))?;
>
> I think these can just be
> writer.write_str("1\n")?;

Cool =F0=9F=91=8D

>
>> +        }
>> +
>> +        Ok(writer.bytes_written())
>> +    }
>> +
>> +    fn store(this: &DeviceConfig, page: &[u8]) -> Result {
>> +        let power_op: bool =3D core::str::from_utf8(page)?
>> +            .trim()
>> +            .parse::<u8>()
>> +            .map_err(|_| kernel::error::code::EINVAL)?
>> +            !=3D 0;
>
> So if I write 27, that's treated as true, but if I write 300, that's an
> EINVAL?

Yea. Let's do this instead:

        let power_op_str =3D core::str::from_utf8(page)?.trim();

        let power_op =3D match power_op_str {
            "0" =3D> Ok(false),
            "1" =3D> Ok(true),
            _ =3D> Err(EINVAL),
        }?;

It is closer to `kstrtobool`.


Best regards,
Andreas Hindborg


