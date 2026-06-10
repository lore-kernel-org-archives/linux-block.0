Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638161D6BB;
	Wed, 10 Jun 2026 09:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781082052; cv=none; b=fhxmte3QUU8ZjwvtUiiqOdULvL8haW6+ZWQqcrmaFMi5yP9l0E0tinuN5rifO3kpQF4IbxVIyS9NpkO4fuOTcho1GOyQvrG9YxjzgDIN9/tLYa1HAf+I2qBZFA/ULprJAgF0Erny8vOVfI1Pnmhs+GINSSH5mpGcY51X/XngjGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781082052; c=relaxed/simple;
	bh=tiOydzZ3dGouBDJ5gNoI3WoKFWG5GSSkN9FaLALzY1E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZIZC7Lh26xHtt/3hiGDGj+wWXVsuxHBJyfjaZnmQt7Eft2m3Y1d0NTwF0JgNbcJ2ZNGrQKKn1WGxhJKPEV08IdAfVEO5/94QsmZegn9h7bPOLvZs/AbFgLzZKFqDuPgENGhbt7csRSci96Fuym7FQsyxq8IqweSS5o7DcJvUz38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oOrtrCec; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oOrtrCec"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93AD31F00893;
	Wed, 10 Jun 2026 09:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781082051;
	bh=tiOydzZ3dGouBDJ5gNoI3WoKFWG5GSSkN9FaLALzY1E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=oOrtrCecZ1/1S/jm0lzpOyrLHHWmGV4pfQC7Asj81mRDFXy48a1f/rBtiLJk4WPpf
	 g1eCPvVJ9DJMgC7WFpzHOeA2uvz415UEJiQY/rHi8pUm/RJBeRn8RMecGR8g1bO3yV
	 eZwyZG92FRvD5X9r14yhr/SW6IyBBuG1E4GVPX2qrQfmK71uP0Jt9lTBtxRH6d53Ec
	 P3+5gT1ya6f3i9Pu5Ulyi+19+wTV6bcQ9T+MwU+q/e4RqONNVDrYDXE0d3rzQtiwfp
	 BsTM8LTK0r0d28/qEvIE6Zv1naanu9TWae+dpRiwVSeeO1qHpQXxcLPIreviq1Jw0N
	 FZ4oyEYIrEzmg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Yuan Tan <ytan089@ucr.edu>
Cc: "Liam R. Howlett" <liam@infradead.org>, Alice Ryhl
 <aliceryhl@google.com>, Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Benno Lossin <lossin@kernel.org>, =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>, Boqun Feng <boqun@kernel.org>, Danilo
 Krummrich <dakr@kernel.org>, FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>, Gary Guo <gary@garyguo.net>,
 Jens Axboe <axboe@kernel.dk>, John Stultz <jstultz@google.com>, Lorenzo
 Stoakes <ljs@kernel.org>, Lyude Paul <lyude@redhat.com>, Miguel Ojeda
 <ojeda@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Thomas Gleixner
 <tglx@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, rust-for-linux@vger.kernel.org, Priya Bala Govindasamy
 <pgovind2@uci.edu>, Dylan Zueck <dzueck@uci.edu>, Yuan Tan
 <ytan089@ucr.edu>
Subject: Re: [PATCH v2 01/83] block: rust: fix `Send` bound for `GenDisk`
In-Reply-To: <CABrc2FU9HuRp4tVEU_R1RdMMRkkS=tM4Uv70WG3UBTeho_C42Q@mail.gmail.com>
References: <20260609-rnull-v6-19-rc5-send-v2-0-82c7404542e2@kernel.org>
 <20260609-rnull-v6-19-rc5-send-v2-1-82c7404542e2@kernel.org>
 <CABrc2FU9HuRp4tVEU_R1RdMMRkkS=tM4Uv70WG3UBTeho_C42Q@mail.gmail.com>
Date: Wed, 10 Jun 2026 11:00:37 +0200
Message-ID: <877bo6hiru.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Yuan Tan <ytan089@ucr.edu> writes:

> On Tue, Jun 9, 2026 at 12:13=E2=80=AFPM Andreas Hindborg <a.hindborg@kern=
el.org> wrote:
>>
>> The `Send` implementation for `GenDisk<T>` was conditioned on `T: Send`.
>> This constrains the wrong type. `T` is the `Operations` implementation,
>> which is typically a zero-sized marker type that carries no data, so `T:
>> Send` says nothing about whether the data a `GenDisk` actually owns can =
be
>> moved to another thread.
>>
>> A `GenDisk<T>` owns the queue data `T::QueueData` (stored as the
>> `gendisk`'s `queuedata` and dropped when the `GenDisk` is dropped) and an
>> `Arc<TagSet<T>>`. These are the values transferred when a `GenDisk` is s=
ent
>> across a thread boundary, so the `Send` bound must constrain exactly the=
m.
>> Bound `T::QueueData: Send` and `Arc<TagSet<T>>: Send` instead.
>>
>> Fixes: 3253aba3408a ("rust: block: introduce `kernel::block::mq` module")
>> Suggested-by: Yuan Tan <ytan089@ucr.edu>
>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>> ---
>>
>> Please take patch from Yuan instead of this one, if they send a fixed
>> version [1].
>>
>> [1] https://lore.kernel.org/r/8839ddc5ff54bf454d508cde91d27d00fc3e2dd8.1=
780633578.git.ytan089@ucr.edu
>
> My last email mistakenly enabled html. So I am here to resend it. Hope
> it doesn't disturb anyone.
>
> Sorry, I've been busy with other things and haven't had the chance to
> send the fixed version.
>
> Thank you very much for reviewing the patch and for preparing the v2 vers=
ion.
>
> Could you please add the following when applying this patch?
> Reported-by: Priya Bala Govindasamy <pgovind2@uci.edu>
> Reported-by: Dylan Zueck <dzueck@uci.edu>
>
> I didn't discover this issue myself. I just helped write the patch and
> I don't want them to lose their credit for it.
>
> Please let me know if you would prefer that I send a v3 instead.

I would absolutely encourage you to send a v3 so we can pick that one.

Your emails are not arriving in my inbox though. I only see this one on
the list. Please check your setup for outgoing email.

Best regards,
Andreas Hindborg


