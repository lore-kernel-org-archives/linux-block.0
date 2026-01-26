Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396F0221F24
	for <linux-block@vger.kernel.org>; Mon, 26 Jan 2026 05:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769404101; cv=pass; b=sw1/ixC/WjK8kUYdElSBPQrJ7z2yEniQW67xO4R6eTPrPE8+xFoj6qjtok58qXz3L91AIpxdSlHO0n5efyyBKh7xHpgrmDbmUbVuNXPkVkpmcpaLX5V9i9arZud6hichMcuBp6O73n46YDhutEUqfP2/vz6GMHrotQfVe2b2tMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769404101; c=relaxed/simple;
	bh=ZBsVD6kxKzurT7H7DtCLfcoGufza6/gI7cdcVlj4q0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FCMcHDxUuHya2oRNvS3gWURscMwGHN7+Zq7lHo8RNBwZotIKGSxq0LkC3zbEZblwZW90vkhQd3pUd1lQzUA9OCh1cQp1dRJUI1qydovtOIaxiskmwbrAiNGP3ZxYWq11mYbWClx6aaVIjYSI6lHMf2RYWqwlMnBf2yAhZW7pqAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k9kfJBC+; arc=pass smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k9kfJBC+"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2b71e7dab12so333105eec.1
        for <linux-block@vger.kernel.org>; Sun, 25 Jan 2026 21:08:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769404098; cv=none;
        d=google.com; s=arc-20240605;
        b=FKNKOR3qZMjPjopHcF0AoGC5rowCmWP18FhmNojspsPHxdGE3SV7Iy00+q90P9q0C7
         cA64e6bKqy126/dTnADNF8fXHSMNN3qDqOUcGdYQYDwY+ps6HqjNZQGoGbS6jFmFCQ/1
         G184usK+LcCN4yDkKfkBjzcK8atb7KvjL9n8h0J7G3/wZU951AhaiOlvNQKgjHTZXkWq
         xbHd+MX0g6rR1dFEmOjq7gjIEAoziXK6HRbXh64vFmOnxkmh1AAndKtZZ6XmV2tC2+4a
         CDPrHc33LuNWLtTlp31iGbMM8orNTPClOpqi6JzNCW/cJtjbt18VD4UmkPho+w8Kw4FV
         czCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bsbA3S4vvXnWg6PVwhDAv4/t5NunrqZ0yk7Z9wsyNZU=;
        fh=TT8pIbyIfIwnKwRXugABUX+6krP6QFoRU8EAQho9ZLI=;
        b=JnGdjENclAxRLCoeJXRVZxax1CS/QXSGuC4zlfbVqNvJTO7/JOOvFtAkas0fxR7sPh
         GBy+Rs0tKea/m/jtMikhgWRwJI/PLhfTLrsOZp29+TqkHGF4hko4ZR6NbwVM9lIbC8U0
         Rdq1a4PUASnj18Bb4nqh7ueyq2KJ3qcVr2nBmdBN19nGDPjehf96W+czaZ4aFi9q+fNc
         hLcgjQPda+I4zuNA0CfvX6CUfKshq8GOS9rwhLEDBXHzdWjY5yGi3dYvdCte30HGQBI/
         EEl58YZZ0GQSkfvfhc3Zszo1FTbTAAkUmPrmhlP/zqUpbMu28AyE552Tlu2VT4r72QxR
         f4+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769404098; x=1770008898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bsbA3S4vvXnWg6PVwhDAv4/t5NunrqZ0yk7Z9wsyNZU=;
        b=k9kfJBC+ldCHGEir2hpwOAhElO6egoRCIxzj0IKfTEqmro2/yY4nV/+ZWVpPnASaL2
         +mKMYxEvPEWQ3mA0MifDdWsjJxAV9WDFd60bga1tQmEuwjCMbcYXGnmdKnOy0gkl2ch2
         Mwj8Ks7ue/Tv0fi0t1I2FGHTzLLGzLT7EpWkOR1/bqd5u34W9Lgxxo6NypTHOKYsnB2Z
         KCh6L7ducVKh/8PXfUb+iHCyyPnIdAB5ON83DnVEVnBfpqvtvEurIJrSHBLvIkSub/iU
         dCIDy2cliqsDj+61/J2ss/bUZVs3zCGOy2Q26lc2sW5MOSWlOjMrzV8iWQUqiUi0YrGB
         4lrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769404098; x=1770008898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bsbA3S4vvXnWg6PVwhDAv4/t5NunrqZ0yk7Z9wsyNZU=;
        b=Cg2tb/RiPqMzd6txGwnb4KNlKG9jZ3CLOKR4ovyo1bXxPVhValq9sL60gyMs1x0Xxc
         uQMzOYiiruZTAcjEOWwWJxdQ/RqWRPEMh6fWZQJ97ZoNzA4W6iN1ls58B5W28mEzVHQu
         wZiy0YVVBP1osP7yUOJFEq6UNKHQ/8F2VM3FlX9zDnL+46lnfKAoW+q/EOHMRLwBmaiM
         elbZ+PmeWT7kyx5LSv21qW7788DbyJQ9bOcpJpd7/7eNkYYBMazJDbvyyMcY5XGe9TFb
         dBh4Svc97dqXh9graPro8bkXWiUEmgpvUwmneWgDdYq30h/7GqGPN9PcJ0jiEW98owi3
         edYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGKVh7l3tQk1XO/wBZ2P8aCBRt2syAJ3bMHWsmXJ60Vy1mwswfpc/CPLGdvyKHxBptVwVowAeW72qDXg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxav+zYglIZDhYNFaVDl6YPUCkWAdFmGHp98l9ITvNHsjy/hnrg
	/+8EqkDuVpvkcLP9917Ep2z8wTOxer29bGHxakBG/Tn63kyTPgo3K7nuvZmTkDZsZpm7Ii24v9Z
	KVVNX4kKD26FE5z+BNpW3cx4Z7i0ragw=
X-Gm-Gg: AZuq6aJbSnRGuNFruhsBxAgELYqMWPps1/lVv9N077sRI7HDF3E4L3SKkW13EC/xCOE
	k7W/cCmhFDkmupdMgw+5G7g9ATW/7L8EBGecud9VnTkHXQLZgiYe41QXApzik202oLOWfK9jlQn
	igwE+GVlhbmEEvDac+9dG6Py4ssHncjkrVSTUw5ovpNuAOSQQxxOjbdz3CKQvUGzqSLUDVfiS/H
	9AQmuyPZiuCnBvzPh0TeE0LDgYfIYf05vgvdpISqqoJYFDYWDuoN9VNGcPEtXxa5pZ9v1I76Vd6
	ZlHF7dgVlSJ+fxx81Fa8MumUaLGYBeAowecdwECDDgZ6EBoCqQ0sa1JddHDYT510B3ks3kBB4Cq
	zUMVxjWzXhxrQ
X-Received: by 2002:a05:7301:3d10:b0:2ae:5b8c:324a with SMTP id
 5a478bee46e88-2b7644f41dbmr855051eec.4.1769404098278; Sun, 25 Jan 2026
 21:08:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105-define-rust-helper-v2-0-51da5f454a67@google.com>
In-Reply-To: <20260105-define-rust-helper-v2-0-51da5f454a67@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 26 Jan 2026 06:08:03 +0100
X-Gm-Features: AZwV_QjC45jcqbNpvCzRgWaUDtcYZvulw1uksmCYv_NCU9WJD69mYzMDZ_yhpJo
Message-ID: <CANiq72m4hBinKM4jRrkpZ5nM_wraQ8FMsYtjgKRkNDmK5sS8dw@mail.gmail.com>
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
>       rust: bug: add __rust_helper to helpers
>       rust: err: add __rust_helper to helpers
>       rust: maple_tree: add __rust_helper to helpers
>       rust: mm: add __rust_helper to helpers
>       rust: of: add __rust_helper to helpers
>       rust: rbtree: add __rust_helper to helpers
>       rust: slab: add __rust_helper to helpers
>       rust: uaccess: add __rust_helper to helpers
>       rust: workqueue: add __rust_helper to helpers

Applied these to `rust-next` -- thanks everyone!

If someone did not intend for me to take it even if the Acked-by is
there (e.g. perhaps Andrew wanted to pick those nevertheless?), then
please shout.

With this, and if I didn't miss any message (plus looking at
linux-next where I see Greg picked usb), then only clk and jump_label
remain (plus any new incoming one).

Let's see if we can get them done next cycle then.

Cheers,
Miguel
