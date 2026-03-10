Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4210D3806B8
	for <linux-block@vger.kernel.org>; Tue, 10 Mar 2026 10:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773140196; cv=pass; b=ZBJwx3y965qDc5otFox7OuuqgsJuMMiFx5SUHosc1huUTsMkEdthCJm74jbAJ2ZDYyL7gn+nblK2EpCaJ/pYO/2FEJ+7iJS/kK6UVzvZTQ5BSBCnG/LVfl/WrfAukZvQK9kYrk+b50123p+elXVWjH7c2wkWvpGJC+df2g2AkTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773140196; c=relaxed/simple;
	bh=nL8Tve9qxXBojU4CG3EUAlYMJTfM1E+ZMJp6NeH7Zns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nzGjjgJttBBQMYUFotb8oqAIzUqRmn7FtaUCJ3bF8EEgLqswXqro7qzdf8X2arrzSQaT2x+6q+UTU7+AYryRoSLJncqtDYHMmP33FEra2Ot3IWPoBUaZN6XhUKjIR2rL6YhmGtn1Btf1QMrhBwCGDSR1JRtKACGED0+W8pNcf38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MBbGtEBR; arc=pass smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MBbGtEBR"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2b8095668ebso829445eec.2
        for <linux-block@vger.kernel.org>; Tue, 10 Mar 2026 03:56:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773140194; cv=none;
        d=google.com; s=arc-20240605;
        b=ehsrtuc6z2US/WyICX5hgj4Qro1KAYDNBYI8exZ4m0jC558MGfES65gXhNTVF/G0Pr
         wqnjmm6fpToUtto3kPm6PeHW397aLlbnoSBT249cRLJPFto82ZjpOhyxAKC4MaADWR06
         cgbmne6b4LQ1NMKdWfNVKFfbv/yTbeIo9f9gleSLgX9UfXebwBPzklhfEl+idz8QTa4M
         0771jmZKHCUMsNC4zHMvh+U3KbseDVAxwW5dsmy7v7GnyDHvHrrwCfT1HZB/09aNMPTW
         GWRkqhuDHgfhxUSvGlkZHvtqvpT0t8lbSxzRjh+xqB3cYwyDh/1RRxD+cIQxxPl1QBP8
         ULvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4qBpWaqAk74juZmeca9VRmKlmVoYIHqDYNOH37dt7g0=;
        fh=gNY9Evr5Nb1ZJSrrJTeN/UsibH39c5Dcvd6fLN8jEjw=;
        b=S4rZVWPFNh4cDh8imxZ9MKRjKix/vv8yd43G0gJGMt9o85lBG237iXLfHyWFtnD3rD
         ZCgp2PN37thQ51bHX6WNw1yfC+Ia/JdKElqZGeCfShPj4JEv0UdvuOZADDynbtMybT6s
         Dpqzxk4Gt/EQOsSBSdsMY+K9LOrlFyVcQrgv3AQ/CjmtqWaAISXYXeAnhf3Jc3/M7G3v
         6KfEyDCf0ANmlV3RiPZX8vSSKHfUMs16my90ZvdAg+ARg2MQ6eG/BimUzpB0CYpJ6XoE
         X6KxvIb2GByhmiJU58ZYgJUImwHOsv6jaDHvdhVUPDGZDaFgmAnNPWHFBOV93o/X2tRd
         dxiw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773140194; x=1773744994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4qBpWaqAk74juZmeca9VRmKlmVoYIHqDYNOH37dt7g0=;
        b=MBbGtEBRBoxPubDO7aR6dBNxnj1NeX5HfI/2iP8Lzp9seSiN+tybz+fCRUtGLW5x5H
         Dk4DqYa2NIr6W29OV7/5WrHN0FEJ0+ScFhbkZQJ4OBIDWeIUWzj5869zWBkvAx1laXES
         Udu4UtFP+aCcp5tqTGuMUR8kxmr0FTGzsSlplMqaY0hCenwPTPwkdVVfNjLo+2nmkSeb
         ZLZA0ovPwmjNnfImTXGvS4gMKe4x5tYPKrZqYjvhXgCHtOZOaqyl0J7nwehmYLSwCQiN
         4RvcjhTehRXfc9XMyLghddQw5UZF09s2CvUvSITa7ja7/9lOwh6jaZeNRFPG6ODik9Ho
         PR+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773140194; x=1773744994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4qBpWaqAk74juZmeca9VRmKlmVoYIHqDYNOH37dt7g0=;
        b=rOIy1s7h6kwqvsukVDZvkRtZrMZNZkm1wX/lpGNX3Y/H1nTSclC6j94PCVsldorRfb
         k6hxt5CFbcmlxJjbsPlGS4wDpUZPf54dSf5Th5CWOlorZaZAuj5sdSyn6CSa4M5OREFr
         lSl9faREaAVd2w4xPEuCqZI0BfIHENt+N2kacfZSyaRMXlfiFExLp/NTOgN3V80/qgyI
         jbS4IpVZMLwZIwO+PWgpyOXDS4oCV20dkNfYynDUvwaTxqAHd0mkPd6ih9TBl3M21jRZ
         G/Mwo3cXRmouL6ZAml43EBUQkl1/6jJ572P45BzE17NtWR0i74KgyuIccSa9roONFBEO
         WiUA==
X-Forwarded-Encrypted: i=1; AJvYcCVHaOkZC1eEBjF0icyiz4qQ06xM6t6xNtOrjxsUgAtJUP6m7tYzn98QlXXJge2nkwx4cG/TlqCj81cDpA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxPtDmbOiqu1cF3R87fUEZLv/v4+dPTLM3sTUyZG1o3uPOFI8MG
	Z6fyVOuAIN8it7zBSIHJfPAunlzFH1EaSGhvBz3rcF0B2Y8cJXjP7+dO9mRDsdKgQIpmbJgbdc1
	RU6s0LM5XSkyoVV3HQYa04x5t9D5sOC0=
X-Gm-Gg: ATEYQzyJgbGxBP0CSRKK1kbsrgF4E/tbe3kgh9qsXQXXG4vQBGalIq+FlHo29z5UZRr
	zd02Qa/ylKTdsF2U1YidH/pTT647DVVud9o/uu+eWScorjdAVNdCtoRERkCbboIhm0DW5MhikoF
	//UEMzJJBjLVJ5POiS7g9IMpoAWoSVZWo+oN/adD42Hr85loAhSBSpbjND1qXiVmFGJXuxWAwZs
	j66QbJxgg1lVwiG3f6KHu8t33uX9CkjOQZTUFyxoUwZsWKwi1IvFV3qHw8PFsgxdeq/tqp+j2ca
	L4z/SMCdpSWDJlhyJRgYH4syk5B+uUmFly1EAvN4qReBiBMFxHkBOuGEfkD6T1p7gkwUE0Wkie/
	aUzN9G/zgtHkUaGjYiMihanI=
X-Received: by 2002:a05:7300:ef97:b0:2bd:bc33:ca32 with SMTP id
 5a478bee46e88-2be4e09ebfdmr2731651eec.4.1773140194353; Tue, 10 Mar 2026
 03:56:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105-define-rust-helper-v2-0-51da5f454a67@google.com>
In-Reply-To: <20260105-define-rust-helper-v2-0-51da5f454a67@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 10 Mar 2026 11:56:22 +0100
X-Gm-Features: AaiRm523FMnYeZ1Cbp2n7uyCKjNSK8gDXCio5_BkegPeyUfSKYibfT47XJIo0_0
Message-ID: <CANiq72mT2-8m71NtnodVXVBRkhUSiK3Byq5OkBntEQpW9hbU6w@mail.gmail.com>
Subject: Re: [PATCH v2 00/27] Allow inlining C helpers into Rust when using LTO
To: Alice Ryhl <aliceryhl@google.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Peter Zijlstra <peterz@infradead.org>, Elle Rhumsaa <elle@weathered-steel.dev>, 
	Andreas Hindborg <a.hindborg@kernel.org>, linux-block@vger.kernel.org, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org, 
	Benno Lossin <lossin@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Paul Moore <paul@paul-moore.com>, 
	Serge Hallyn <sergeh@kernel.org>, linux-security-module@vger.kernel.org, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron <jbaron@akamai.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ard Biesheuvel <ardb@kernel.org>, 
	Andrew Ballance <andrewjballance@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, maple-tree@lists.infradead.org, 
	linux-mm@kvack.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Uladzislau Rezki <urezki@gmail.com>, Vitaly Wool <vitaly.wool@konsulko.se>, 
	Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
	Daniel Almeida <daniel.almeida@collabora.com>, Michal Wilczynski <m.wilczynski@samsung.com>, 
	linux-pwm@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org, 
	Will Deacon <will@kernel.org>, Fiona Behrens <me@kloenk.dev>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Waiman Long <longman@redhat.com>, Mitchell Levy <levymitchell0@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Lyude Paul <lyude@redhat.com>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, John Stultz <jstultz@google.com>, linux-usb@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, Tamir Duberstein <tamird@gmail.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 5, 2026 at 1:42=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> wr=
ote:
>
>       rust: clk: add __rust_helper to helpers
>       rust: jump_label: add __rust_helper to helpers

Applied these to `rust-next` -- thanks everyone!

With these, the series is complete.

Cheers,
Miguel
