Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FE9330B30
	for <linux-block@vger.kernel.org>; Fri, 31 Jul 2026 06:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785479405; cv=pass; b=T+0+eg7vm+YkR7Zr+rwU6Ht60PVHPPMMlFm/1T1N0S1cJ+B61IF3iOnYpt7x6zKlNLR3IkAblZ/o5cd0btQhryY1xpT5gEQ7oI9ga41Ganhl7brrfgP8FWl2x0lTdwpuhlSOygYuAG0ipaQiGxk3PfVgtA/fqyWW0LZ6O+ukclk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785479405; c=relaxed/simple;
	bh=plYqvJikpm2phA6sJTWH2hDra12ZFHqZ7KqSsbbbx3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uL8kNlFe/7kANx7N4BNJfUU+si4YsR6d+spJGz+nTaAW6NL6Dl7GJDZi8+vtPjm+OXN5ZM3Z0oDNU9U3u/dBtiOQVzfogSmEAm5K9HYfTsrLy4J3ncyAlnmR1oM0Bt3hRSz3HESk1y1RUTUJhJoMHcAOZ0JRkWMbQsfH2q5WF6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NWCaNt6d; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWCaNt6d"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ceeee8c46bso1190485ad.2
        for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 23:30:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785479403; cv=none;
        d=google.com; s=arc-20260327;
        b=DP8rblRYVEpeyZp9DfyPJNsSmrd2QqiuiFCbYv9eAPV14xspezMwdwIkKABBuohAgn
         pcLrWLoUONsiPn3LmIqoZj1c15vjkdZicUwxtevblbyzsg9GwXuysu+HjoXNU8W+XsHh
         DQXIfKpuNOAMlIf9mNW21CglWWWYveQRzizmsXQy+ziTi+qDVRJTnYIf2WM9lwj+mPzd
         hr0xB/BvFi+MRZXiywQ2/zB5nbyz4d/+7zFAc4RpySPnYvhR7lXnlpZWw2zjptFCeQ4C
         y3dZDkFKcOHXjKerSDK9GRrmAqugfzr0LlnttYOApTTcU4q9iebJlIp8hYwJeprtC71O
         eLDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=plYqvJikpm2phA6sJTWH2hDra12ZFHqZ7KqSsbbbx3E=;
        fh=yLh9nvgZBIbWStajG+9067G2GIZoG4uI7OVBCC92dsQ=;
        b=d0zWa7x50vS19P8GczC13ahAbnIxS90YMH+xvUngz4nPREfUbVadUS1SRAcTmop5ek
         y9vBIE/51gTPy9KJsfjqPnfyLfaS1tjrg8U9Dc8OzxMYRH4/+1ojj1Aq8eydrpbxTRmC
         Eoxg5HUeSGHVuZj4kymh9DyIWJjE3bcMUvgkXFlYzAZnhkfVNuzvMzuFUx5qOZ0EYz5J
         EQ1NOmLuSaa7csj0RLS0qQBbBj7LylhEIe499Cw3Z93opEGinyN+IJJbk4vGNtnrnb/k
         FwVZkMefmlDlB264A0lnciixS97UKl7aMNEqELhrVlmuaMQFEv9EbVY+tCjHSDkbKTlY
         XONw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785479403; x=1786084203; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=plYqvJikpm2phA6sJTWH2hDra12ZFHqZ7KqSsbbbx3E=;
        b=NWCaNt6dNgAGARtRG0i87Zg/4MX5m8mmYfHmRZodmPVVojtjaNus2ym6gJYtL1Pd/L
         AOv8wQRegNwG+GTWDMU06KuMRMWo9BXgtNKT0WdD02cXI6YUfx3v6sR0VOs9hagIJ4w4
         vnKyIIdeB+5YOvum8D393ArHcLC4LBT79fBcIgbLi5vihAt4TNMsu4hXeFugfhN4ySHC
         W5nQEtPsoLJ884H3F4mK4Qtrrd1jUgKr9KCr4ehF1xIV8/txfgWipTUtPYDapxLJ/34I
         F6/4LcrSYzE7iSczVrekyvtA/Ww6xZ6wYo3NFEDB9G7amXtbcR2IB4gYc02nSfWbY2eZ
         DKpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785479403; x=1786084203;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=plYqvJikpm2phA6sJTWH2hDra12ZFHqZ7KqSsbbbx3E=;
        b=FrtbaVHr19BS2il2R8g34O9kpULoA0ZPy8IdPLc8HYzxdlQP5bw0Ae4+GxnEVws3wD
         6PvoDqtOlE90G7JFelwaPrnM29lA/GD2vug4wTjFK3NOdJHStgNOvVzC9DGNt5PElkPH
         jBCcdP10C3fetB3lgM161FRu8ZuAQvqA422zSwHvmMEGfs6sEu/iK+5KeNuneR65VDPM
         3UifMjreAaBu92V9ULJ2b/TJ5UYJVjptNOGS2uGlSKkj2NvHbZr+uCM3cP5ghmWpjRA5
         v434HoDzJqLqlAIvoZdhRqxiAb0//haSWY/kAFdZh+c3ppmthrLukNsX0ajmizvaxsmy
         hCVw==
X-Forwarded-Encrypted: i=1; AHgh+RqRTDGBFWJnD2kG9yO3aECjFU9gShqoLrfsBxg7NmeFtuN3nOK3Z8zHzkDs6Y1KF1KewseG8/u8BijLpw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzpwcEggJryWIi5tUKhE3Yv/JBVAhKW42WRev0s41O1drbjPq6H
	stoITOTdoAS1UjYF3PXw57MOqZnqC2VdeXf3LgSLHilDo1j0y+HP5st01XO4T0Ese87xvKlR/oH
	Ida7ujGNVEYMmipi3uZuhgvIn+27F7yE=
X-Gm-Gg: AR+sD11eNfCtZn07OGuvZCw4hXkBpgWjTjrIENtDGLvh6Pt9yiXHxG2s2TR6nmYU+rB
	3eHpb3qgXYW9bEZikjRd5vFzx7lOEURmEGIJ0IGcscV3DepLCdsPbyDegAOOihnKwbHprFpWYtw
	7uSqSBUtnz2mucPgK2ptQeQUcgmrDHkDKxOWQbZKCAkDEbZYOA60nF5cetCcxR15Hlxm1fBtaLX
	FL3kWlrZd/A61S35xNWHGknqHK5wUROuZRmTFkIOLu3KYKIMFvMLZ/4U6mJBSSh5aucPIBBtXyG
	a7AYlZ1GYPsYKGCl7AI0skStN4HxrH+XEm0LOGBo6Lmb9KwERJ6b2FxfMXJVA1Zez8LXD9z4koe
	uqTKCNILCp3eOYCMn6sNdRX6wfE1J68h62dmCXvpEL5F8EIlPH29PZPxzM+y6
X-Received: by 2002:a17:902:ceca:b0:2c4:397:dd7a with SMTP id
 d9443c01a7336-2d046ef0048mr13066585ad.4.1785479403240; Thu, 30 Jul 2026
 23:30:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723-fix-fops-owner-v9-0-c1c3af7f7bcb@linux.dev> <a9dde63a-5f2d-494b-95dd-7567879de38d@linux.dev>
In-Reply-To: <a9dde63a-5f2d-494b-95dd-7567879de38d@linux.dev>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 31 Jul 2026 08:29:50 +0200
X-Gm-Features: AUfX_mxTwoRg7YuTGPUdUHKCs3gSMN4l-jXSn1vTLDoexparxESqmVPaSYuvKs8
Message-ID: <CANiq72kkuKsRAF-r+2OyZbjjgvC+jvqMSXR=LgmqTNRaWQZ-nw@mail.gmail.com>
Subject: Re: [PATCH v9 00/10] Fix missing fops.owner in Rust DRM/misc abstractions
To: Alvin Sun <alvin.sun@linux.dev>
Cc: Miguel Ojeda <ojeda@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-modules@vger.kernel.org, driver-core@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, nova-gpu@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-pci@vger.kernel.org, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Arnd Bergmann <arnd@arndb.de>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, 
	Rae Moar <raemoar63@gmail.com>, Breno Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>, 
	Dave Ertman <david.m.ertman@intel.com>, Leon Romanovsky <leon@kernel.org>, 
	Igor Korotin <igor.korotin@linux.dev>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 10:39=E2=80=AFAM Alvin Sun <alvin.sun@linux.dev> wr=
ote:
>
> Back in v3, Gary suggested this series go via the rust tree.
> Would you be happy with that, or would you prefer a different
> path? If so, is there anything else needed from my side?

That is fine with me, but let's see what the modules maintainers think...

Luis, Petr, Daniel, Sami: what would you like to do? This touches your
entry, so it would be nice to know what your thoughts are /
Acked-by's.

Thanks!

Cheers,
Miguel
