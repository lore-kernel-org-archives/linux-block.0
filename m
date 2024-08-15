Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3F214EC6E;
	Thu, 15 Aug 2024 21:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723757793; cv=none; b=d1r/YClMnYlLWJqgNWsY2knfjIqtGxkchCo6JnIWEiCHU5/ppwu4QQdyhpWdjNqrN5E3lw9vMal81HkNsf7D9K2fkC1bRyU0Gq7wIMXwOflSA2E4ZkAgw6xy7bDgdOzyJV2BHk3hyxpDPk7sBX9u0nm4i/tqCK2y8fpcuHHLHcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723757793; c=relaxed/simple;
	bh=ZCcc9HqDPOzn45zNAgvp3hsz2gD+XHy9B3j9ffwJRp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UPdi7zz/z0iSVFcjMj7a1qH5AXtGHz1jsusU1Mn2nrs86orEiySNbJNuF4Mv5X4B95BruoRYk5guClgs9v1cE/wOmb3luD+/6tIDfnMZd5rLqUJV+ggJM/zFwSUSvLa68+IKSjTXylI9qR38iunfio8auwkRxpmw+JZXWmAYfYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lHbQ1/uM; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHbQ1/uM"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3db145c8010so857492b6e.3;
        Thu, 15 Aug 2024 14:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723757791; x=1724362591; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=boY978HFCv0Axv89OgNUkRO86F3ZJlrIJAY5GpXOUpE=;
        b=lHbQ1/uMDAuLsonBhyz2nWLJMl42cFStlh9Qob+AceXFnOOFrulCZesB/OThT8mkYa
         8BODgvF6I4aCXQxCry5UVN/D+0k3Em+SwtFgrIRFD50v5j4TXIDiLEH1/uSjMSerwzfP
         s2n/YVKmXjlxPM0hGVHcm27yXo3BjMfP7my2aylbeM3YCR0Ea+Z9yFU9Il/ir7APpowT
         3zU8zoavOW7AN7HLn/cZ9VLqqusssqqakKpBdf7GVH3gcfx0O/LiTWwZV36uxjgGItrH
         fw5ePs/3+WTpLyr8fHpBOG92WbBmQMgqDljM7zcebgW7UcK+lLDtSb2VxrILrhHvThXd
         RSpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723757791; x=1724362591;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=boY978HFCv0Axv89OgNUkRO86F3ZJlrIJAY5GpXOUpE=;
        b=L9MZtilolDorsuSpLpwKk2M781q1fGvWJz3xCt2e6vf4WPtjT7GXbGmOmawywdRxP7
         9XTMG6FOZrbPhMPkQ3VbxeRy5UETZsKQyDwjtM0BhoPtKTaYmiwkqpx3bHSioYdFY4zH
         VdnJgxBao9kPFR9gUPbbWKF5H3KLqpaXhLfrZ++RXkFHgUq+FmJDo172uA7Clt41kzq9
         l7O3eQVkFLITDMU5CditVcoeqsCpL45BBoCNDY/2H5YgNZ27F4CpJxBnLc2AjcjNzSTB
         NSKliAADTWx+uiqhgRAqvwgz61P9k70N6gfcYwhV1x/NpMn1CAmCASSR6jjnvW8xxQFy
         77RQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmHGReelh2Jo5Qko2Z1MG3FCMYpGPv67hwh3Us9Cp8xVQC6lbMBwQP8Q0Krt5CW0/bpKDWQvMBBIQwGcDjk2+g0192CJ6Mjs8IHtRARLxdUY1EkvxV6PNkJEuXkokj5paFHUnl85yKJXCdB1r+BQ63CoAh5aKZVXjcU04rl7itWRyD+QTqw6NmqQ==
X-Gm-Message-State: AOJu0YxXPI1wp5WtspCV3cbps3CR8uvn7D9jBwcJGUZZgsjNRXnDkOdf
	Wo8nrpBLPD102lYCYviG3Twbff611KHefrseS7h6BQRSJ19wg+Jx
X-Google-Smtp-Source: AGHT+IGbhxYMBCHqihTCooTG4du3cUopb5vduPPerg+ffjGVv6XPT3/iDHDtos+Da8vlG8UNXZJC+w==
X-Received: by 2002:a05:6808:1820:b0:3db:15ed:2a21 with SMTP id 5614622812f47-3dd3acfa64cmr1034563b6e.16.1723757791103;
        Thu, 15 Aug 2024 14:36:31 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4536a072683sm9473611cf.85.2024.08.15.14.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 14:36:30 -0700 (PDT)
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 5A9331200068;
	Thu, 15 Aug 2024 17:36:30 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 15 Aug 2024 17:36:30 -0400
X-ME-Sender: <xms:3nS-Zh97Rn47S3nNlIMTGYPHjGjNXMr8VvTVZqY1uRgg0MLlirRNXw>
    <xme:3nS-ZltiKsGowxoHuMsn1zs3iTOa0Ye93A5f7C_f2I-Q1Um7AhGU3c3jsoM6_3N8w
    ThZQ1-h9Jl98kR6lQ>
X-ME-Received: <xmr:3nS-ZvD6reDnZBPwYnax44rGohxmR8uD9DbrBezYSH9e0kBp719IDuVHeSC47w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtjedgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhephfdvveevkeektefhheejgfefhedtkeetieeh
    tdeufeduheffteeffeejheetfefhnecuffhomhgrihhnpeiiuhhlihhptghhrghtrdgtoh
    hmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsgho
    qhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqd
    dujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihm
    vgdrnhgrmhgvpdhnsggprhgtphhtthhopeduhedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepsggvnhhnohdrlhhoshhsihhnsehprhhothhonhdrmhgvpdhrtghpthhtohep
    rghlihgtvghrhihhlhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepnhhmihesmhgvth
    grshhprggtvgdrughkpdhrtghpthhtoheprgigsghovgeskhgvrhhnvghlrdgukhdprhgt
    phhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgidrgh
    grhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepfigvughsohhnrghfsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtoheprgdrhhhinhgusghorhhgsehsrghmshhunhhgrdgtoh
    hmpdhrtghpthhtohepughirhhkrdgsvghhmhgvseguvgdrsghoshgthhdrtghomh
X-ME-Proxy: <xmx:3nS-ZlfkqrNaOvWi4oAKNEjASFLSMC2-g1wyGsy2GiJD2a2WiTCXjg>
    <xmx:3nS-ZmMnYTdLhMQTVikRoFqIhCjJ1ySV2CouDGsQqOBU4Cs7U3ffRA>
    <xmx:3nS-ZnlT64cKgfhWWvn-V5O6Gj2om1aWEWzGP7ypo8ROILP5OYItrw>
    <xmx:3nS-ZgvSWqA1DMwlRmmS9A5-O5Ks6ftrcGZuVkXyfK-t_XzFplmTBQ>
    <xmx:3nS-ZosdNhQK2cBj6S8_11HVCromYbVQT9w4Y4vIF9l098gTfloBLpw5>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Aug 2024 17:36:29 -0400 (EDT)
Date: Thu, 15 Aug 2024 14:34:59 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Alice Ryhl <aliceryhl@google.com>, Andreas Hindborg <nmi@metaspace.dk>,
	Jens Axboe <axboe@kernel.dk>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	"Behme Dirk (XC-CP/ESB5)" <Dirk.Behme@de.bosch.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] rust: block: fix wrong usage of lockdep API
Message-ID: <Zr50gxz8oH-mcuMq@boqun-archlinux>
References: <20240815074519.2684107-1-nmi@metaspace.dk>
 <20240815074519.2684107-3-nmi@metaspace.dk>
 <CAH5fLgih1QtO-ACyoifNsgqd=VtJimoGV+aD=3iHG0wb+iDGyw@mail.gmail.com>
 <10ae8a5a-5dbc-4d6a-8f86-30236dacc5b3@proton.me>
 <5b251842-564c-4b7a-8d4d-d7fc2b1b857c@proton.me>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5b251842-564c-4b7a-8d4d-d7fc2b1b857c@proton.me>

On Thu, Aug 15, 2024 at 07:15:43PM +0000, Benno Lossin wrote:
> On 15.08.24 21:05, Benno Lossin wrote:
> > On 15.08.24 10:04, Alice Ryhl wrote:
> >> On Thu, Aug 15, 2024 at 9:49 AM Andreas Hindborg <nmi@metaspace.dk> wrote:
> >>>
> >>> From: Andreas Hindborg <a.hindborg@samsung.com>
> >>>
> >>> When allocating `struct gendisk`, `GenDiskBuilder` is using a dynamic lock
> >>> class key without registering the key. This is incorrect use of the API,
> >>> which causes a `WARN` trace. This patch fixes the issue by using a static
> >>> lock class key, which is more appropriate for the situation anyway.
> >>>
> >>> Fixes: 3253aba3408a ("rust: block: introduce `kernel::block::mq` module")
> >>> Reported-by: "Behme Dirk (XC-CP/ESB5)" <Dirk.Behme@de.bosch.com>
> >>> Closes: https://rust-for-linux.zulipchat.com/#narrow/stream/288089-General/topic/6.2E11.2E0-rc1.3A.20rust.2Fkernel.2Fblock.2Fmq.2Ers.3A.20doctest.20lock.20warning
> >>> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
> >>
> >> LGTM. This makes me wonder if there's some design mistake in how we
> >> handle lock classes in Rust.
> > 
> > So `LockClassKey::new` doesn't initialize the `lock_class_key` and is
> > also movable. I think in this case we either just overlooked it or
> > thought that the C side would initialize it.
> > 
> > For those people that know about this, are there APIs that initialize
> > `lock_class_key` themselves? (ie not a function to initialize a lock
> > class key, but rather an API like `__blk_mq_alloc_disk`)
> > Because if it is usually expected that the class key is already
> > initialized, then I think we should change our abstraction.
> 
> Sorry, I got confused, this has nothing to do with initialization.
> 

For static allocated key, no initialization is needed, for dynamic
allocated key, lockdep_register_key() will need to be called before
using the key.

Regards,
Boqun

> ---
> Cheers,
> Benno
> 
> > Additionally, I think that it needs to be pinned, since it contains an
> > `struct hlist_node` (I might be wrong on this, but that looks and sounds
> > like an intrusive linked list).
> > 
> > Also the `new` function is probably prone for misuse, since it will
> > create a new lock class key every time it is run. But as I learned in
> > [1], the more common use-case is a single lock class key for several
> > locks. Therefore it might be a good idea to at least rename it to
> > `new_dynamic` or similar and add appropriate documentation pointing to
> > `static_lock_class!`.
> > 
> > [1]: https://rust-for-linux.zulipchat.com/#narrow/stream/288089-General/topic/.E2.9C.94.206.2E11.2E0-rc1.3A.20rust.2Fkernel.2Fblock.2Fmq.2Ers.3A.20doctest.20lock.20warning/near/460074755
> > 
> > ---
> > Cheers,
> > Benno
> > 
> > 
> 
