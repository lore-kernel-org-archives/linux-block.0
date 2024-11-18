Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413AE14D2B7;
	Mon, 18 Nov 2024 20:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731960617; cv=none; b=n69576/wyQNwJmfrjqGTfp/VTb0YtEen+Y8NFtULBDrkT3m189qbAk1OHYwzU8sO8FDiX0uYSBZCrPOrruwLucgOkIepiVtDwvEY8VInCSKhSrXm1FmXjcnIc/ppFCwYbyE9N2mrQhoU+bBK+pdwUYnuEbOIUI6NATVP5dgV97o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731960617; c=relaxed/simple;
	bh=bHBXpZXBAjoQnfNOBBIrqLz9ubBLFDnaeaQVAe+inHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EumemAq0oJJkG+8cZQxjhtLYDUVT/awhjb25nRG4niSIA9Hbxkx42ww7Pl1hq4uA1aPvHkNHdWK9BCq+SHUv8pMdzOVv3M1JHfbu3fqImWDTxucwBnoj9dl5D1k97BaQKiDt/eNZ4ts+/Ly8Tu211JagCnFR18HU/uX0hQRFX+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RH18qS6k; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RH18qS6k"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-460af1a1154so23424991cf.0;
        Mon, 18 Nov 2024 12:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731960614; x=1732565414; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aStUmJGWcEVU2U4ZG/1PNyEw0LtVjfqAOBMh9J6hhz0=;
        b=RH18qS6kSFuz35EJaQJ+9C7W5XLaYJTyMCMQPQI2FRxygEBUQ+EtoWPbJWVfhNvk2C
         NAi7oN/Ik7HPpU2QU/4n4KRMsWGnyGhEIxFvHUG5H7kTStTOr3Sf1J5UmaPVUgyQqmgA
         m5nnghwmk9dQO3Iqt4lhmzrhPKrBzng/E9SL2j+IrYf1ktl9A5/YMbKnvc+I7L0Bvm8j
         nSBNVA87Y7tEMptPSEKq4apAxQRQguOY7fEBrYbIBmCEgtihC7nrFH7qfMy4763c80ZF
         jtlBHqqhI1le0gFYWJVTxkQBkGp+90jjUUc6YxSPj1WXDYyM4BI1sXBvLyi294XCjZeS
         yovA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731960614; x=1732565414;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aStUmJGWcEVU2U4ZG/1PNyEw0LtVjfqAOBMh9J6hhz0=;
        b=Lks+rHkcRZ/vEpcQRwXjKEXFY41+9ZDLmaOZnlf50zzlhZMD6MuW3jQQ6qEpsc5Aa5
         0LBu023arvKK7uFHQQO8XP4tBu4MvTY3FRCHPsfYocgjtagWCb8iJi0IglVqvBFjjhPy
         9OqegCAjP/uJO/VbDrhfNbAvXlwIRlKX1882B7BsWPo7Jm2yWzFlcr8irkPG1sDg48Y7
         KurFedphuyPOWHhW8+vyLFFfiQRzFNBnQXhK7Hc6YZLf0XGLl1Fjc2L0vhOi3th1DAjg
         u3Uzy+uNQI7h22oB9QqVCyoYqvjSDC9+KUeaYclMyv84p25ZbMiwhtJKGX5UEiM7RyT7
         xRGA==
X-Forwarded-Encrypted: i=1; AJvYcCUkHXEnGEsPFDopQbIkFm87gCA8/DBDV1hwABsqDk6JqH2v9VY5C/zx5I8Z0jTFOAXjTn2gtkzNh9DOBg==@vger.kernel.org, AJvYcCVOjHgNJYkBw7hf11Tb/pErgR5EVtnZHKGcEqYe9sd0kIBGN2RfvBca4+3wcaXzlBEaXGtTs/BRAliebLiQ@vger.kernel.org, AJvYcCWsTOZCWF8bq1X9UW4raqnfLvXwLW7m3K3bTTdqky20wCAzldWkOrx++4oIBSyFzHnRfdJ5Gd2Kn52NIQBIc6U=@vger.kernel.org, AJvYcCXsFil88bW+qd+lgQXZkfgFFuTv55z7U2rq2svRDwRfc1ogB9/5dF1G9MeTSbNGQuqsKDfq8Oyh@vger.kernel.org
X-Gm-Message-State: AOJu0YxYVtHOB5yKxTBgoKs3G+saCbKvmJvWcgkLMYJfuQZvCLhY52lA
	QBUnIBz2hL7RSNNETT829XY14Ss6jxrw32k5paGz4Krz9hzG7zD/
X-Google-Smtp-Source: AGHT+IGLeWkbonbMABjzKBD7EcO31d28MccNrsXLLqKWclvwDRhkuxdDuO9H19GAnDo5YYZ5W1ATtA==
X-Received: by 2002:a05:622a:453:b0:461:2526:964 with SMTP id d75a77b69052e-46363edf815mr222751701cf.56.1731960612556;
        Mon, 18 Nov 2024 12:10:12 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46392c1a24fsm2346661cf.56.2024.11.18.12.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 12:10:11 -0800 (PST)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id BF463120007A;
	Mon, 18 Nov 2024 15:10:10 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 18 Nov 2024 15:10:10 -0500
X-ME-Sender: <xms:Ip87ZwU7Uxvz8Pd3jjqDrnxYYq380LpsOuTbF0_MA4rrlz9KQgepDg>
    <xme:Ip87Z0m7CHD5Is2jMFowjqnxRFd0cRfV_z08qpPpkXN7OdHoAiircY_mnG3d6ae1T
    lC7X_8Y4cr1KA2IXw>
X-ME-Received: <xmr:Ip87Z0asp3jut0ttwCWJj6VhPUwFn04PC-V3ine3kJjXAR0d8OYgt9RJbFZztA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfedtgddufedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpefftdeihfeigedtvdeuueffieetvedtgeejuefh
    hffgudfgfeeggfeftdeigeehvdenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdo
    mhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejke
    ehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgr
    mhgvpdhnsggprhgtphhtthhopedvgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epmhgrnhgrshdukedvgeegsehiihhithgurdgrtgdrihhnpdhrtghpthhtohepfhhujhhi
    thgrrdhtohhmohhnohhrihesghhmrghilhdrtghomhdprhgtphhtthhopehtmhhgrhhosh
    hssehumhhitghhrdgvughupdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhr
    tghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtoheplh
    hinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopegurghvvghmsegu
    rghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvg
    drtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Ip87Z_Wpls1Rzk-f_Ar7IVRoiPYMK6wUdkjUrPrh7QsErTgMPUWNgA>
    <xmx:Ip87Z6k_-EUZOWO_xVz4JtqnGga8n8fjPMHjRxqsHd3RlhVH0gLRjg>
    <xmx:Ip87Z0eNl5Lxq_KXArmQ2OnOV3WVkiakJTpp22iNKNrNVTM_-Med6w>
    <xmx:Ip87Z8GChtXsZtf5H0iduTWyoqDAqZl1mnW5wcF5elZcrPGf6_BFZA>
    <xmx:Ip87ZwnfW7RpGQusSyIlKaYulzjZaeSwAxYI5eXYmY7a7XxIClmeS5lX>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Nov 2024 15:10:10 -0500 (EST)
Date: Mon, 18 Nov 2024 12:10:08 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: manas18244@iiitd.ac.in
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Trevor Gross <tmgross@umich.edu>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Anup Sharma <anupnewsmail@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH v3 2/3] rust: uaccess: simplify Result<()> in
 bytes_add_one return
Message-ID: <ZzufIPTmbvLzSIb0@tardis.local>
References: <20241118-simplify-result-v3-0-6b1566a77eab@iiitd.ac.in>
 <20241118-simplify-result-v3-2-6b1566a77eab@iiitd.ac.in>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118-simplify-result-v3-2-6b1566a77eab@iiitd.ac.in>

Hi Manas,

On Mon, Nov 18, 2024 at 08:06:59PM +0530, Manas via B4 Relay wrote:
> From: Manas <manas18244@iiitd.ac.in>
> 
> bytes_add_one returns `Result<()>`, a result over unit type. This can be

This is a bit nitpicking from my side, but usually when referring to the
name of a function, I would suggest adding the parentheses, i.e.
"bytes_add_one()". In this way, it's more clear that it's a function
(instead of a variable or something else).

> simplified to `Result` as default type parameters are unit `()` and
> `Error` types. Thus keep the usage of `Result` consistent throughout
> codebase.
> 
> Suggested-by: Miguel Ojeda <ojeda@kernel.org>
> Link: https://github.com/Rust-for-Linux/linux/issues/1128
> Signed-off-by: Manas <manas18244@iiitd.ac.in>

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> ---
>  rust/kernel/uaccess.rs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
> index 05b0b8d13b10da731af62be03e1c2c13ced3f706..7c21304344ccd943816e38119a5be2ccf8d8e154 100644
> --- a/rust/kernel/uaccess.rs
> +++ b/rust/kernel/uaccess.rs
> @@ -49,7 +49,7 @@
>  /// use kernel::error::Result;
>  /// use kernel::uaccess::{UserPtr, UserSlice};
>  ///
> -/// fn bytes_add_one(uptr: UserPtr, len: usize) -> Result<()> {
> +/// fn bytes_add_one(uptr: UserPtr, len: usize) -> Result {
>  ///     let (read, mut write) = UserSlice::new(uptr, len).reader_writer();
>  ///
>  ///     let mut buf = KVec::new();
> 
> -- 
> 2.47.0
> 
> 
