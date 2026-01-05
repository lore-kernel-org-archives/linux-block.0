Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B4E33EAEC
	for <linux-block@vger.kernel.org>; Mon,  5 Jan 2026 15:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767627680; cv=none; b=dD/jh94bGgluMnApzUJCip4ZE0nounXIGs3du2gxTTC9Cn9wwKCQN8J1uvtGk3F9cMquF5QCi9/pZ78zdLfdifOZFhorJCfSnshpJdSaDjwJKl3O5VJXyS06AS2AhJ53ntzNqU6XwaSqq+xDrm1ADGaB6zQq9e3zzg29DnkGwgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767627680; c=relaxed/simple;
	bh=7XOckaOqG/PMRqT76fU8qmeyL4hEz8+C+ksukJDZjK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=on51xBw8Qs94EtA+muMWc4S1YVA9JfTiIM84E39re0I4U7HNrtD7LiJ4exvczKYx63xr59IyFLO42Dt6Tepws2eBBkqq5dQ+zvivqkoSdFzd9H8EHnasD+N/bkufh7U1AJjwBaYWeJw6wIIeV1N230DgysHSEv1FcepGvgW+Klg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ANTOsH7t; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ANTOsH7t"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-88a347c424aso2366d6.0
        for <linux-block@vger.kernel.org>; Mon, 05 Jan 2026 07:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767627678; x=1768232478; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r6BA1g1a3pdykyjLkvUREMTVpM7/WCPoUOv36P4M2nY=;
        b=ANTOsH7tPDcPS8CmZzOHNm0S+V/mWI0bFCqEFpOAekO1YJgBqpiHZRaKgcbvfWofGS
         hkM8D+8SEd6n4+gGjSAsdsohNibziUL5avRF2LPZbvycxOZzY88dlebGTDgG5NJH4pvF
         KbbVPq3zkMqpLzgtJikFPIuttRZCac4SxO5QeTWzOo0UM8z3jhcgvaa3X/pNVaz1vfVe
         xJI28IlTfCVcObZZTJYscPtRojUpRuUhe2X5x6XpEUBNpLc+jSX9QB3fA7pMWfkRDOBL
         B9eaErOp+Z+JCIwR3VJVMkTYEWmNvKxg0m93Kv5ej+Wff+QC2UEJC81jHLGQ0NHq2xSQ
         hycQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767627678; x=1768232478;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r6BA1g1a3pdykyjLkvUREMTVpM7/WCPoUOv36P4M2nY=;
        b=q7ap598gatJzozuh1fKjMtVq4v9gheqydLP364rkk92n3Zg0CokYbqBzDv2rZ7vccs
         Os3yylKlxbNtOq1+w7FJHPsubPS9c/MuMyqJQNGYjMpVYUhpvxkuA5QvtKnKEJpd9lYF
         bl9eGvWtWhExdbOS8UJDf8VY4M26QZqmnzzx6wvS1M2YsyAzAV8pbvDLFXJCESz2+NHq
         CZsXvwBXv8UqQpOAoWRKaXU+g69b1nea370MbkYnpd7UHns8fQZ75aUOl2qzCqYvArVS
         b4wAc+DtvBNMS1o513YFJtJDVGOYipxtaZY4cspAh6yI9f8u1Qt8T8bJvLC6SDbI3Tyj
         tN2w==
X-Forwarded-Encrypted: i=1; AJvYcCWVMFRYL4Pi08KwBYthHc+hvvhiu6H95ZYyq3+wYQNwSfKY+yEJyO8cT8PDD3XGCtqZWG0ZrcLTQm5h7g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzdmsmmzNVE5hxUnzezxUcPDJ/9g2XDdzWTf+2rB5JDF+ENcX0y
	4gqM70zYV12iaT2IEKoirurMZAgyX6zjRpcdzkOmrCRpz9nXhZ6laTrE
X-Gm-Gg: AY/fxX6zxyH122+Ospxgxj2lYo9UpA5iUKIZcptlEVD2PVvuxTrJuIBYCWb8Pyzmtz7
	F62h/1TGq2iy1XDWpeQ3IdPiCuXKw2BmqYVKE54mcdsrAREHmxc37Tz2ke56rQc/Z9FjForUoau
	My/YAiE8RQL+fpCmJogeUYXEftZlZwiGJxrUW8zwiroA1SxYC9vqUNSraXfH+jHA+rTwVRi5SS/
	N/QExNYb71aNLXu/swMNJZ+Nf+gwB6RzFc7XGkXV2q4LcyDdwAfVOKo2qMC1YqjUa5xjEtw7bos
	5y2WKRWmB44cyzbfWa8hahsY/z5lw0kE+dVuAebbXfAuyc6PPY01Zaqv7pVCMbyO/2unyAGtNsl
	oAeIEoMixfkdFcoOTvjjAsYHFYVfEx1xc+V2mfYBvLRgsocYXKOFiiHyga0OBYAYtIReOZavA1K
	LOGroKqFpD/SXEe0ljnJwY+KUO4N32b2iIfP13edI6VJGxWRh2qowCV2zdZdeA4mpR53vALfmrB
	Bgn/LQefFrr1Lo=
X-Google-Smtp-Source: AGHT+IFcWhopwSaKjTCty9xmTi8J6nU5610w9dE8RcpeTOSxGCXk1EYPkRdikqmONExTL9dAEe+Esw==
X-Received: by 2002:a05:6214:1249:b0:890:4f86:495e with SMTP id 6a1803df08f44-8904f8649bamr161313626d6.39.1767627677769;
        Mon, 05 Jan 2026 07:41:17 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890753ef0f8sm1464776d6.14.2026.01.05.07.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 07:41:17 -0800 (PST)
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfauth.phl.internal (Postfix) with ESMTP id 8F0F5F40068;
	Mon,  5 Jan 2026 10:41:11 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 05 Jan 2026 10:41:11 -0500
X-ME-Sender: <xms:l9tbaQl8adq_q8oemVdp9py9aCB5rEYMUXGPUHOfxSENDh0M6SOSiw>
    <xme:l9tbaVrCyG7LEDf5sozj9kkhyLQ0sPqK87jUAC_qJfbekq6ICe_xe5QMuMoTjEKUA
    tB0zjAhiqSBWufmhb_KP365bDbxKmKQ-BUeRDG7AXs90zPIyqpX-w>
X-ME-Received: <xmr:l9tbaTuvJMNXCwyVLLEQxwAkDuZHya194bV4WrOdHwOVBYRN60UCxK-j>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeljeeilecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudffiedv
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqh
    hunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddu
    jeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvg
    drnhgrmhgvpdhnsggprhgtphhtthhopeehkedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtoheprghlihgtvghrhihhlhesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprhhush
    htqdhfohhrqdhlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    lhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epghgrrhihsehgrghrhihguhhordhnvghtpdhrtghpthhtohepphgvthgvrhiisehinhhf
    rhgruggvrggurdhorhhgpdhrtghpthhtohepvghllhgvseifvggrthhhvghrvgguqdhsth
    gvvghlrdguvghvpdhrtghpthhtoheprgdrhhhinhgusghorhhgsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehlihhnuhigqdgslhhotghksehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepfhhujhhithgrrdhtohhmohhnohhrihesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:l9tbabmkDu5goAML_Vw6wQks5sr1-oqWVGEVyl7SpncPG41qLq8PqQ>
    <xmx:l9tbaZEvXpCwph3gfl5iq-kHa4fsrJ-e6g21CjltgBbR441YOY405w>
    <xmx:l9tbaa8pxEfCJ2_idKerH3733Rocx35rGJlDBn4X7HlKs2MkaFUX5A>
    <xmx:l9tbaW7nR-qjUaIEByc4-kPNbC8tpKXp-OM_EvS1h_evQ7bx_68mJA>
    <xmx:l9tbaS4UkZJm3L0Tu3phQb3ItLU_OD6WXZGJ8xIIxpleNVBlr6HjnmTP>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Jan 2026 10:41:10 -0500 (EST)
Date: Mon, 5 Jan 2026 23:41:08 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	Gary Guo <gary@garyguo.net>, Peter Zijlstra <peterz@infradead.org>,
	Elle Rhumsaa <elle@weathered-steel.dev>,
	Andreas Hindborg <a.hindborg@kernel.org>,	linux-block@vger.kernel.org,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
	Benno Lossin <lossin@kernel.org>,	Danilo Krummrich <dakr@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,	Paul Moore <paul@paul-moore.com>,
 Serge Hallyn <sergeh@kernel.org>,	linux-security-module@vger.kernel.org,
	Josh Poimboeuf <jpoimboe@kernel.org>,	Jason Baron <jbaron@akamai.com>,
	Steven Rostedt <rostedt@goodmis.org>,	Ard Biesheuvel <ardb@kernel.org>,
	Andrew Ballance <andrewjballance@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	maple-tree@lists.infradead.org, linux-mm@kvack.org,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Vitaly Wool <vitaly.wool@konsulko.se>,	Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Michal Wilczynski <m.wilczynski@samsung.com>,	linux-pwm@vger.kernel.org,
 "Paul E. McKenney" <paulmck@kernel.org>,	rcu@vger.kernel.org,
 Will Deacon <will@kernel.org>,	Fiona Behrens <me@kloenk.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,	Ingo Molnar <mingo@redhat.com>,
 Waiman Long <longman@redhat.com>,
	Mitchell Levy <levymitchell0@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,	Lyude Paul <lyude@redhat.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	John Stultz <jstultz@google.com>, linux-usb@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Tamir Duberstein <tamird@gmail.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 00/27] Allow inlining C helpers into Rust when using
 LTO
Message-ID: <aVvblLp8sjFB7JvB@tardis-2.local>
References: <20260105-define-rust-helper-v2-0-51da5f454a67@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105-define-rust-helper-v2-0-51da5f454a67@google.com>

On Mon, Jan 05, 2026 at 12:42:13PM +0000, Alice Ryhl wrote:
> This patch series adds __rust_helper to every single rust helper. The
> patches do not depend on each other, so maintainers please go ahead and
> pick up any patches relevant to your subsystem! Or provide your Acked-by
> so that Miguel can pick them up.
> 

I queued the following into rust-sync:

       rust: barrier: add __rust_helper to helpers
       rust: blk: add __rust_helper to helpers
       rust: completion: add __rust_helper to helpers
       rust: cpu: add __rust_helper to helpers
       rust: processor: add __rust_helper to helpers
       rust: rcu: add __rust_helper to helpers
       rust: refcount: add __rust_helper to helpers
       rust: sync: add __rust_helper to helpers
       rust: task: add __rust_helper to helpers
       rust: time: add __rust_helper to helpers
       rust: wait: add __rust_helper to helpers

Thanks!

Regards,
Boqun

> These changes were generated by adding __rust_helper and running
> ClangFormat. Unrelated formatting changes were removed manually.
> 
[...]
