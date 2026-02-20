Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FC83126AB
	for <linux-block@vger.kernel.org>; Fri, 20 Feb 2026 17:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771608845; cv=pass; b=b1rX/JVrWblHzUbASVLpEDLbLUoriT0FjhQO/XfHO2xvCD5teytcEj2lSe6az3jYf+5QgS4OVEeCW+7aVhDReA1vrdzb+bGv23kz45gZ/+cko1e5pnwOuZEtphRJ5+fqcDi+FtfspjlIQ8u/lf01lXvQxpuX+MEwzANikCe7GDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771608845; c=relaxed/simple;
	bh=dW69iUku9IRFksYkhFKb49OwK2nuvLOXPied0JTmtvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HH1V0TmtfhafVvWeq14DE0MDgTVz2j4vf58XlqMw6bEurZOwUuM9WUOtjQCDnSlhsLeMeMG/KLLhSq3CkDcUHFfKWT0nMKPYjomc5YYPUchNVR8A/8+8PuRIRfHxg/2mWhpXCfzoO4gx1VI5VGR8cGU6FVpZ9ZRaZ006fVC+pZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GUmovhQZ; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GUmovhQZ"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-127148c2112so221439c88.3
        for <linux-block@vger.kernel.org>; Fri, 20 Feb 2026 09:34:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771608843; cv=none;
        d=google.com; s=arc-20240605;
        b=YAGVcsLt+U1h5vEyRUEcRiuxUqwnxZauA4u6ftF7j2ZZBF8p6i5cd0F3XPTmrjrDPY
         cNo48K3J/JChltXCYAOV41O4+zNT7e7V13yvPgoFRofM3oW256I6GiSLlNOC1jyONXo1
         bIZsm8h1/8pbX1RGy7idKGo6r4g4vFqQiZwe6OPTy8+EeCz6hp4x2yObXuFVym8HoYIq
         diJWOKjZ91NfovuQI9SqkI2CYQr91lWTE1Awf1QKn/zW6fPD9E7xdIfsB3uHsUq9xldN
         jLxddXMhA2LQehe1Rhoyn9pmRymuE4r03trlq7EKVrMl2VRfxqGpvcDTv8UcP4WNG310
         z5uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=B3RiLfffpu7Ffa96sGXtUyFTXMqhEfmtMEWOofkZHzs=;
        fh=TSaa+8eD+j7DYN9B+r3NNp67l9dQDeAM0fO+Nphz/nQ=;
        b=blasDHbHZTpOxGk3B0Ze/OgYY0uXMw5F6w2MCoNo7LvRqCbLh1dYCx3rlAYdqpY9xn
         FWUfWJq2JmIlwV9EyXu9zNlPpHaV/I41OXFZo7U27qGnevqcAAzhlANkbagR9rEYQCNy
         rPnjl7H+eAPEKQJRAciTi8A+38FhN0RncnYCfFY9ocUTDtKJt2KjaQdpkx0ulxi1mmCJ
         SZy9yH1Q0LUA2WkRHtEtqrCvo9xjU8qr5aGAGnCWNk4NewMAIPMR8kEEHGDW29/zD6WH
         djJxMWmjomI5m6aW1zspJmUUScDmQYNXgUnGpdpukpxVdvZ9WnXm09WEi0UCyueDpwpQ
         R3qw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771608843; x=1772213643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B3RiLfffpu7Ffa96sGXtUyFTXMqhEfmtMEWOofkZHzs=;
        b=GUmovhQZ0/gL6Csm9lB/oZvXQzoRbh+uVmBzc8YSv+cMKg9Uubues33H/9RyfdILfj
         k+zc557ufFVnuu02HgkHoFuAOrYPjf492rTJMSJs+Y14GZdZJ6vatA+cSh9f6oo963Io
         d0+6cjq3IXdboW94NV5+1nI2XbXJvpX520Bj2HNaDdIOD88O4E6cx87O+l9159ye1JVx
         z5ECFYUXaEaFv94IyKrGZwFgzAl9mjpRAIoxg2VDDG4MXRpqli7BRe0VZzFziNXygZdF
         C5HOej3GIe0ixLu5QAUeJFlzHR9sfGixz9LuDB31Pak32LJ1sCx/7snoqduumBjN/l3T
         gKng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771608843; x=1772213643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B3RiLfffpu7Ffa96sGXtUyFTXMqhEfmtMEWOofkZHzs=;
        b=qzV6dzmK3xqc+8HFP/qbLARFr1EHpykFsrBOIhzTomQiAUFdcJiIFWsWe8VQ0Q0Euz
         O/LZoqz5B5LSsokPepucUz6M/bV8hJ/YkUgTYREpODzvdzy+FeuRvZq2BO4T2OQ8kOxW
         jaCMLPU+Xbh6fCXYMnTfGAmYj7TT6zqrIGyRq82SAMyFCX/vjXuW79uLTqhv2vBck0uf
         LrJcoz9JTDWxKQzbbXSx6Ua/M2t91ZBZEvjsXCMVpcryaiBNmcWX3Xqlf7qxzTwN4QmW
         2HgZEEwmmrySpmBz+MrOw+iCP2UrPG1AD2134jPAvFn7jbq80kF7e576+J1tnwyS4a0p
         4mWg==
X-Forwarded-Encrypted: i=1; AJvYcCV8qJbJ1fYBfrWzs/DmhVc0nKa76k1TQpbFNy4OeWuLnj/APD2oj7mShPpaM4kYBbOF6Dz7kWr1gasIzw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwoOIH/XJZt3zU1jLNTpnR6/tk7l5X76ECX01HgzO4cSNYdTnxK
	g/Mnd3VV4gobfUKbPfe2qZm3tvyiPyEtQuHWVneizUokI56u50RsfFU/rSrLaqu8UQkRzOIKOyU
	xKgMTED8d7Kym9zeqAnQ4SZaHG3QVm0Y=
X-Gm-Gg: AZuq6aImgEFWI2lGCaNH2Lws1ni0WrZ3filsOf67jT9vIk5u4kA6lkrmGo9ZRdmvTfq
	4VYTqsMjEJYIZfeMd78p0dgIA3MNf1ncnDuwHAzdnDdjsnXNKmnG5GiQa+3TbtmNQ+ZSoHIcpVK
	Z4y5XR5bZ+lxg5PLghiTFz9yhgCjduofl9qnacVgt1MlrJAh0j1IiIGYfVTDuZcskF5KKwsI9Rc
	xUhyv6BL7rHlA1ipBYcv6ww0Boi3KcE+EMWOgagGJQlN2OrG2zhtWAz0VVlRHW+PzYT5GnPhWhQ
	S/Uf43sXmIu1ufvYVbx3DbIOL9037Vl5KQ5pdIBrf/sSwUBVMS4l+oA4SqKGjRsqfxbBe0U7CY9
	RSPhyOIetTGQ36/rz0PLBIGd2
X-Received: by 2002:a05:693c:2c17:b0:2ba:674a:dbe8 with SMTP id
 5a478bee46e88-2bd7bdbce7cmr74947eec.8.1771608842904; Fri, 20 Feb 2026
 09:34:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220-unique-ref-v15-0-893ed86b06cc@kernel.org> <20260220-unique-ref-v15-9-893ed86b06cc@kernel.org>
In-Reply-To: <20260220-unique-ref-v15-9-893ed86b06cc@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 20 Feb 2026 18:33:49 +0100
X-Gm-Features: AaiRm53lo0keI-FayfnRj4AYfVuM2jzmE06bNyAO-n4MO92LWSUkvblDHz_tCFM
Message-ID: <CANiq72myc+tCEHm0WtZspZHWwsSzvesxsmUvk31=GCdUN_zVNA@mail.gmail.com>
Subject: Re: [PATCH v15 9/9] rust: page: add `from_raw()`
To: Andreas Hindborg <a.hindborg@kernel.org>, Tamir Duberstein <tamird@kernel.org>, 
	Benno Lossin <lossin@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Igor Korotin <igor.korotin.linux@gmail.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-security-module@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-pm@vger.kernel.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 20, 2026 at 10:52=E2=80=AFAM Andreas Hindborg <a.hindborg@kerne=
l.org> wrote:
>
> +    /// Create a `&Page` from a raw `struct page` pointer

Please end sentences with a period.

> +        // SAFETY: By function safety requirements, ptr is not null and =
is

Please use Markdown in comments: `ptr`.

> +    /// `ptr` must be valid for use as a reference for the duration of `=
'a`.

Since we will likely try to starting introducing at least a subset of
the Safety Standard soon, we should try to use standard terms.

So I think this "valid for use as a reference" is not an established
one, no? Isn't "convertible to a shared reference" the official term?

  https://doc.rust-lang.org/std/ptr/index.html#pointer-to-reference-convers=
ion

In fact, I see `as_ref_unchecked()` and `as_mut_unchecked()` just got
stabilized for 1.95.0, so we should probably starting using those were
applicable as we bump the minimum, but we should probably use already
a similar wording as the standard library for the safety section and
the comment:

  "`ptr` must be [convertible to a reference](...)."

where the term is a link to that section. Cc'ing Benno.

I have created a (future) issue for that:

  https://github.com/Rust-for-Linux/linux/issues/1225

Cc'ing Tamir since this is close to the cast work, so it may interest
him as well.

Cheers,
Miguel
