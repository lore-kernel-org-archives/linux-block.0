Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3E1245014
	for <linux-block@vger.kernel.org>; Mon, 29 Sep 2025 19:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759175864; cv=none; b=EN2H8e6QwdnLuy0xHEgYWCVaJTSREtZwGVQAV/pPNZTO7jEitsPpEcepPJnHUor/KdP/Njmpi9FOIiGHlB3rOI+/9SR5RCOJ8YcN1lcJsHm9NTq9Bio8CWLvGIJrzzZLfKOC51G99ps//wteSMqta8JOrUXDoVnMhmd3KYv8UuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759175864; c=relaxed/simple;
	bh=ILAe+VRfX0Fc+b5qLvaJzfBUJ4qz7jOpbJP92apYs7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WQMGpaVXlabeFR1oYqUaQLh5XVI1d4V0eK2CMFZj/xn+jUa1b6iiFe++vfVqWGl13mxtUlp5d/sWDszmp9zEPUOWQ1NuBFOkV4hhmGujV3t7WpQdjNkpQPxHLQDh+TDmIbSHAliyjEPzatLRv5UgWsRXGp7GbaQx5sltI60RKVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U5RB08Jd; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U5RB08Jd"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2680ee37b21so9800645ad.0
        for <linux-block@vger.kernel.org>; Mon, 29 Sep 2025 12:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759175862; x=1759780662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ILAe+VRfX0Fc+b5qLvaJzfBUJ4qz7jOpbJP92apYs7g=;
        b=U5RB08Jdp+02qM+f5Mp+vuiVmfSvgvAx9OiS9eb/dfT+moX3pfMb+UYBBkKAocEnWD
         lb08aQk8t3PnXYbC6FKFPEpeNN+0C3ZK5K8O+tVbR+xM/l1tcssKZVmm03IKwOTCHEle
         otJ3pGwplRt2pfEJJEZvwsiu9yLStl62IrDFTM2XX7CeRRpwmQk921H0CmTYR3OS71XF
         NekIyiGHf8khHUgEJ7/Wg2ZlzVBCZ0wFeOg6ADpKhHUA9qnm0NL23qr46rSElBRBhtmX
         ruanjoQ1J/SgQ4bkiNZDbqTlMP5Xkn+l9J62YsWvCV6Vi6j5khk+VeQK0XuWqSD6UIog
         WvXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759175862; x=1759780662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ILAe+VRfX0Fc+b5qLvaJzfBUJ4qz7jOpbJP92apYs7g=;
        b=oJKD1sus75Cil/9qVaCsKlgdUx8xW8n6X8/qNS/0EiFCzan9wrJws5AMnb894lYoW6
         dzcEJy6zCaZ0O3BQc+8HSgqiQhPH0DeANr6qZitryVGqkp281rCJLKmKJs62LQwedIrA
         e0W6BP1iQsfV4y4QlCRsVX1XX/0B5qvE/4vVjgRjnTTGaO8kgmU3oQYV4jKt5j6ijgzt
         vN6OfjXvfzn8b4KeT0p7w3Sa8pxKaq8jluVzUbR2lJO7PR8J54qPEB9lv/o6Vvugs6X+
         23msO5z3hhhB6PXMkjXTarcgAR5Ytyjy4riwldsEy6xjWCuan6uvmyTMlnzUU+x5aBAZ
         cDOw==
X-Forwarded-Encrypted: i=1; AJvYcCU4Ly+lEYawcifs5f+KOTTvUBb8uatbbffI0WxUSCMfi3gGkFbFQ7WH4hWbaTyPULW0KvLvtZ990XbnUQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwgY8CZbKOJLV2SkumDOS1VrXW2RuTYKEARRvKepFNmplCcHcMH
	eXhSkXpK1hRNwKRb5fVF5cj1f+ZHgqEScZbaes4dc+VPUNVr8/m9zPZcbLjH+bq7VniArtRdAie
	wt/oAaf/9y91leDNlXfKqby6F440uk+w=
X-Gm-Gg: ASbGnctGyL9CWiagTSbSacQFdGCM6q5y6ADHr/qZKjXLiQES4LxQ9r+9uk1wHIPKZuH
	QAWGH6iO3nPGShTigdJASVPASAq8abf3BvewOEgC+gjm0KwvepPFQrfWDk4ZH3rfYG2sXali/PP
	yx3LAUFexGGB0Bob1na8SQpyCgXiVP+1MypF6FBrKMb7I3ST1ff9NQ8j8qlc1qNhOUGio5aBI5j
	ZjQvwL/CEB0BbAb/PBkKy+Fr5FOQ78u5M7OckvNB0Fyh8cbqqtxZJZ9oM4hhIyVr6g045SONHPS
	qzsrR9VvwTkSDRkxFrfOcWvXlaxrO6I+awl9
X-Google-Smtp-Source: AGHT+IGYfATe7mmNTC4A+jEkwD5MzSelb1z0lWF68kS0t/NWgoEWKg6nD9jI4X3FoSNWbDyeH2i7qWWFajxt0X+1x5w=
X-Received: by 2002:a17:902:d501:b0:277:c230:bfc7 with SMTP id
 d9443c01a7336-27ed4a5d82bmr113039375ad.11.1759175862141; Mon, 29 Sep 2025
 12:57:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925-core-cstr-cstrings-v2-0-78e0aaace1cd@gmail.com>
In-Reply-To: <20250925-core-cstr-cstrings-v2-0-78e0aaace1cd@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 29 Sep 2025 21:57:28 +0200
X-Gm-Features: AS18NWCM9kbfT7mylXQdGB8ZyL_b6RmUa1M3XR6zo5RoraO0TPm_DutHWVTmZ7c
Message-ID: <CANiq72m=TJMWFZhHSSU_-A3+tr5h8vA+X+oKb9TcieXQ6gHyJg@mail.gmail.com>
Subject: Re: [PATCH v2 00/19] rust: replace `kernel::c_str!` with C-Strings
To: Tamir Duberstein <tamird@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Breno Leitao <leitao@debian.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
	Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Alexandre Courbot <acourbot@nvidia.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, nouveau@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 3:54=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> Changes in v2:

For future reference, this is v3.

Cheers,
Miguel
