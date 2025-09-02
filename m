Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732924414;
	Tue,  2 Sep 2025 02:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756779513; cv=none; b=KFAld2ahQzSZce0k0rFCckP7BEtHZrIgJfDUX5L41n8jyGLWPW6tbqHbOP12maAuqtje+CnGSlyEXHg3uVkv+9qxjl1J2gByv53WBEJPy+ClJIQb2e8UmPfNZTbKLjDt4zWZnLo3scu4JMWBuzynvOmUPlWRTKeitFPeKkjEtic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756779513; c=relaxed/simple;
	bh=jWj77n90lpscowBKxGnKxCSWqltp4ZyNo+bBpxvz3sQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JvTLNH5Vl5OFHrSn+cYwyW0XZO1kreZ8xcdWIHazCe66iZiBHvxulRhx5XrWbI6yUBqJSakShmW91f9+5FiCz0rgKMtEje5Npjlt5rR+lRDUIc8JutJGMXWKtDYkemvinud3R2rrVDAh/viM7nBOEVqf+rZLDK67/LRtlviC08U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jdlHmDdd; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jdlHmDdd"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-70dfa0a9701so50934866d6.2;
        Mon, 01 Sep 2025 19:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756779511; x=1757384311; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UWBJ11Qq2wI4UtNYw2ns787DwY45sHPfRhY5E7/GIKg=;
        b=jdlHmDdd0pjGUuSFsUhb1Ff9PJZLkfybLQeBLUkaFHpyvt9FsfTC8WXIbk/OL20183
         He7QRLEBufHB6D5gPlVm0tWSQNaSWWMLKldXZdgxRIGVoxMrfs3PYhT21YbNHeAN68Wb
         +50FbeMxHl0TcVdE4S2HH5jtSgaUO12o3WuWTs/Ee4EdbSOqmulk6ZE74jBMUjD2QfKD
         MaPplKyQN7JUwcytTKizWrxS/96SjvELvhWHQuRx44XMWJUJ2apGJUS4keb5uwt4PSCY
         HrJI+bW+qyUN7uLJv5DlMSsYchagsjYAZlZQkMRqzti54839cATWmCRqymVRPfjpDrGe
         lwjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756779511; x=1757384311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UWBJ11Qq2wI4UtNYw2ns787DwY45sHPfRhY5E7/GIKg=;
        b=AOO8LK1/lMdwufp1GIO4UFMxlfc8BEeGbThasavDLRCqB9ovMSvzEWXe59y9e/4neb
         DpPO7OjgvyRLz5FNRTVKeXfH8HKH6pTHn7sadvjwbx893MiI5trUSFYw1AcbVxmGuJ4a
         NgDbHURBo994NksLERRuH3K9uy3h4omozZLFV4Xe1ELfk9OfMp5pwkjTaGuSuuymJjIE
         ZTZCDidGHiLhfndYA/aKCDh5Dj8DizgCdLrIH0CYhcxoaIkSdp1dwmWhMmBVsZToJ0CL
         k76jKtrCbp38dj5m1advdq9UbBivmUdcP05Q+lHHW2E3I38sQaCsJcwKNck7XyxUoKkj
         fTHA==
X-Forwarded-Encrypted: i=1; AJvYcCU301uqu1MdMLICjSc1kQYFmVuWQihBAFvAL0OtE8DAQ3anNG/JFZ/qZTvajjbBG0V6SKI6RRMhTiDDRtV6vCQ=@vger.kernel.org, AJvYcCUnbo+n0LNSQo+KyU/vzU3LUGHzrum6VaOyFeW1Ayn2mNuB3WMCPL6dFZk4D2YxWWsnyuiPS125J943sFq+@vger.kernel.org, AJvYcCXYPGEwijfcE6FyZ698F4oeaQ2aRbzUztSiLOzvr1ka802HofXbxnLfF0eDiBtbn0NoQUCCuOu3SHXubg==@vger.kernel.org
X-Gm-Message-State: AOJu0YymVVQM66HBo93YYNFF4Jn02s0q7Qokt0defF5W4nOhT04r7obL
	Gsp5dA7QbAguk6p0yccRHlhWIi/A2OPMJtXcOusE35fixBi+boaK5xYe
X-Gm-Gg: ASbGnctysCZ71dr3hM9bQgnTN7hTcZO6hNQr0VcJTyp4eQeLsBCxW80K9Z7BcdGsP53
	ef5RZImdX+tlo/4YQgP4gntYYeWXLAlG/w9yT4d0VzCkJHLbIbYyMayPsVcmhT13Q6hfk2SlEG2
	llQ3B5vEjO6zpyOfOLrGwFj8G7F0OYZxB4kIpywAfY0QA/9QB1VEhVXcC60euoMc4p4J/ctAPaf
	1EywSikweLTuJ9H7e6SQ4ix8xX75Olbs82ZZDUUXdJ95XM5Te65APdKQStrPUhQJ+svW9gQMiVz
	sT/YAXmveY+2XkUP5LElP2sKn7wxKKikWSP/IKjJS3WO2mQNjz0pIqBtO8AE7s/IGDWVV3AF9fb
	VPshaGPR77A7dT1K1Bvl80tN/GrX2v2/E+zGA5JVrPKeFYIB9IKmC6wgQmcx32/o/PC6d1owv3v
	9jcR8KPjebibpLEk2mRQYxegE=
X-Google-Smtp-Source: AGHT+IG6behPS/qlT6YHslNmsEgfGWxFdm9Wdo1jFvdwOEInGgJroYZc+1zppQUWObXRDWoWBR3kkQ==
X-Received: by 2002:a05:6214:c4f:b0:713:8ede:6143 with SMTP id 6a1803df08f44-7138ede838dmr82846946d6.39.1756779511019;
        Mon, 01 Sep 2025 19:18:31 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720ada83b25sm4354766d6.27.2025.09.01.19.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 19:18:30 -0700 (PDT)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id DAACAF40066;
	Mon,  1 Sep 2025 22:18:29 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 01 Sep 2025 22:18:29 -0400
X-ME-Sender: <xms:9VO2aEww9VI41cJQVBm7aX72hP0vx3zTOCKuu7wTz1Mxg8QJTIHI-w>
    <xme:9VO2aOv5oxMejQ0wU7QI-tHsP6xf_313EET_Nhsr9IAkZDLcm6V-uWCBynpmqxxeq
    FgA6-gT0MniimtGtg>
X-ME-Received: <xmr:9VO2aD0_DahIfT-FIbpPACdjcLEgVRqD_igdAByZbKhwse_iwMbhM8X1k_Puabh5PHR6xtZOY0YEiNan9BuvHagm4nGN0-4E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduleefkeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueevieduffei
    vdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvgdpnhgspghrtghpthhtohepvddupdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehlohhsshhinheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghgrrhihse
    hgrghrhihguhhordhnvghtpdhrtghpthhtohepghgrrhihsehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgi
    drghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsghjohhrnhefpghghhes
    phhrohhtohhnmhgrihhlrdgtohhmpdhrtghpthhtoheprgdrhhhinhgusghorhhgsehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopegrlhhitggvrhihhhhlsehgohhoghhlvgdrtgho
    mhdprhgtphhtthhopehtmhhgrhhoshhssehumhhitghhrdgvughu
X-ME-Proxy: <xmx:9VO2aK7IaiUmU6tIPyLw9Udp70s0onsFCmygs1-yJIxA8WfZRmDrvg>
    <xmx:9VO2aFN3_WAm99DwRrG_RwUY4WAVLUedsZ8_i0JldkC4ee_QC3p0zw>
    <xmx:9VO2aOFk05rsPrn33QqccGDD8t3Uwc_xOuRamn55BJbFRBjXQDT_pw>
    <xmx:9VO2aJ3By6C7U50F4sCStNGdvj5miFB0j-angsniLUubhUzlJFfidg>
    <xmx:9VO2aFEblm-SL7iYjIk3JSsRFU8PJngeVXxP_TCH2LiYwTMeuGb03vyE>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Sep 2025 22:18:29 -0400 (EDT)
Date: Mon, 1 Sep 2025 19:18:28 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Benno Lossin <lossin@kernel.org>
Cc: Gary Guo <gary@garyguo.net>, Gary Guo <gary@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Tamir Duberstein <tamird@gmail.com>,
	Francesco Zardi <frazar00@gmail.com>,
	Antonio Hickey <contact@antoniohickey.com>,
	rust-for-linux@vger.kernel.org, David Gow <davidgow@google.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/5] rust: block: convert `block::mq` to use `Refcount`
Message-ID: <aLZT9PQQyREAZuCm@tardis-2.local>
References: <20250723233312.3304339-1-gary@kernel.org>
 <20250723233312.3304339-5-gary@kernel.org>
 <DC0AUNNAKGJI.4KX0TW6LG83Y@kernel.org>
 <20250827205121.59e4cc32.gary@garyguo.net>
 <DCDVM56I5WPT.2L24NI3SBBIHU@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DCDVM56I5WPT.2L24NI3SBBIHU@kernel.org>

On Thu, Aug 28, 2025 at 09:18:40AM +0200, Benno Lossin wrote:
> On Wed Aug 27, 2025 at 9:51 PM CEST, Gary Guo wrote:
> > On Tue, 12 Aug 2025 10:17:44 +0200
> > "Benno Lossin" <lossin@kernel.org> wrote:
> >> On Thu Jul 24, 2025 at 1:32 AM CEST, Gary Guo wrote:
> >> > @@ -34,6 +36,18 @@ fn as_ptr(&self) -> *mut bindings::refcount_t {
> >> >          self.0.get()
> >> >      }
> >> >  
> >> > +    /// Get the underlying atomic counter that backs the refcount.
> >> > +    ///
> >> > +    /// NOTE: This will be changed to LKMM atomic in the future.  
> >> 
> >> Can we discourage using this function a bit more in the docs? At least
> >> point people to try other ways before reaching for this, since it allows
> >> overflowing & doesn't warn on saturate etc.
> >
> > Would this additional doc comment be good enough for you?
> >
> > /// NOTE: usage of this function is discouraged unless there is no way
> > /// to achieve the desired result using APIs in `refcount.h`. If an API
> > /// in `refcount.h` does not currently contain a binding, please
> > /// consider adding a binding for it instead.
> 
> I'd like to stress that the atomic doesn't have the same protections as
> the refcount type, how about:
> 
>     /// NOTE: usage of this function is discouraged as it can circumvent the protections offered by
>     /// `refcount.h`. If there is no way to achieve the result using APIs in `refcount.h`, then this
>     /// function can be used. Otherwise consider adding a binding for the required API.
> 

Looks good to me. I will apply this and some adjustment against my
atomic patchset, and queue this whole series for v6.18, thanks!

Regards,
Boqun

> ---
> Cheers,
> Benno
