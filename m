Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEE74C33FB
	for <linux-block@vger.kernel.org>; Wed, 16 Sep 2026 16:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789577184; cv=none; b=mVrFUPUbRQk2ho+oPwQ9WhJt1iUXhVQ4CaAiPcAViaXCNq7sl6oINA3VwPA7cJYqiI+SpLM8cOw6WZFigrb2AWNqO0R0tGGkiE3l33p8vYxeQgFNZU9M50TdH9oIUgpM2oXdbm9/jV/IPyFLd3Nb2INXXf4cci3yUfa0Z4hXPx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789577184; c=relaxed/simple;
	bh=1fs5/9PJdlbuBhTs0ZxkDNW+v2WItpOPk3QzGFWOdbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jpu/vNOSbzqqr2mdd2toRyFkio5yA2jnBO/yCquqOvB6Lo/KAfNs3prw5bIq2Ar69Qia1+hwg+39z3Lb6gvjHMWcARWij31upUpoynbjyCel53ors4UvyEvur/xDKfqFWXVu6mj1EhPESiuAu+3C+blLZdTNyiBSI2zEhEWDdq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QMSLSCTc; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMSLSCTc"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccd66bb4so1082998a91.1
        for <linux-block@vger.kernel.org>; Wed, 16 Sep 2026 09:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789577171; x=1790181971; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1fs5/9PJdlbuBhTs0ZxkDNW+v2WItpOPk3QzGFWOdbk=;
        b=QMSLSCTcLtJ+AiMJ6XECO+C16YHQOAZXJqddh+1hwfr5SVCU4HFWiTSJa1dhNOAfge
         pfYOyTxgh+G7+nYzG29DcTK0mbanmL4Ki5CnnFA1nBDvUO6vmqKWePAB+FZ5FpUy7ybf
         NvpmQd8hmW1D58fLfNxQ2IO4hTT5eo54DBnXZzh2iajCO69bt2cf5NtANoLSgFqyO5/A
         9LEmXnDntVcj3+khqajRkChzL+EBb5PV7pHymXnMoVk6pz3eKRz4jysRegqRDLaw73Fi
         qXC75IwpNB6FudUN9Cqwzv40xMcW2rJfnS4fRbIUZsdSRYywhbx5SH4WUeYfZTSmmPUN
         0lKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789577171; x=1790181971;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1fs5/9PJdlbuBhTs0ZxkDNW+v2WItpOPk3QzGFWOdbk=;
        b=ERfeUtsvg7rtmZda1pt6LIFAf8qKQsWhk6eW6Ko4ighP2DpD64pwGZ8UdwpZ6jzHPQ
         bmtEUJW2GglpvTwVpRwWKu5rrmRA9L35S6vB5DK5hM4ZLtqeGvrSgUTOttrVHlMCKj/r
         G3xW8DAvMP4X8S6Fvt3CCXNyGC22efQha5qkWTvY1Mt0k+sfb4fDFaY3YhFjjuOJq4u6
         Ndd+wUNxPYKr0QpJxFVYC32kVVrDbrcoQmHk/IH5uwIgr1t4j5Q2u6Wol7e7KXO1GwZm
         kYb9KNeEJRSfd3ahNDX5h9Xf6kFzZKye3Yqm7fU0fnDTHoe0VnfRBaGrMAyyBQYVRI1L
         W9qQ==
X-Forwarded-Encrypted: i=1; AKwUvBwifHJVy76WCJJ1sdvCDs8c0aexl7dUkl10lvJzn6/ruSGux55l6lDyvrvzIsUkeLImS9Rzm0l5Twg8xQ==@vger.kernel.org
X-Gm-Message-State: AFuF++lfZn5CUpU9rSGlFU+UJuhzmATYkLNUNle87E9PH9VOXnYd+6GE
	U1HtFQDPKB6kS1/8BpAGv5L+vhLEyySyJ3AAoF6XHP9wDIwS2Pc9QM16
X-Gm-Gg: AYBFou1LqcqnM5oBh9waO58d5yaCFq5n95InhhA+9uunIIM4zPSmda9A+05qrPFOT6c
	yNLc6rW+lJaHCa7iUSK6YQ4vYpVCvMolguq85cKTJ9TiOeVrJIDy0DVdo6SS6xmxZP9yrnBjAbB
	CLzN5PMA7+s902Bd4c+mCqJoqohR9VOJEJSbdY2eghZGLxVIDCMl6Xn6RGbFG6po9eWbLlFwdcx
	DSC3xmpo4vB1Bkq0vksgk3jvPw1a4t0K5SCQ+MJogm3J17VjA9cxvgMpKqjDqXiBq6N3v2KU7hY
	LvrxnXmb/oujwO5TOlJtgNfi3Qd+wv+JN3Cfvrt1omxobGPDk5xN4senGyA1+kbKlu0D8Qqu+UZ
	/P/2Fwp+X7tNl2wqyBfMV+cdW2fMgdg1s/MtkwqZobpCjkiQ0tXJfoIrzegTGIkVXdgNlYboBrc
	hUftRhsN7X8qOGJvj75AOTHnkh+Uun95dDRkrMW9iMXvjomtACbJE4s1LhYWBfJ51/9w==
X-Received: by 2002:a17:90b:560d:b0:39b:3109:10ce with SMTP id 98e67ed59e1d1-39e1e45cbaemr7258907a91.16.1789577170531;
        Wed, 16 Sep 2026 09:46:10 -0700 (PDT)
Received: from jm-X870 ([2001:e60:20dd:7c28:de1c:fff7:d3a4:d8c7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e3617443asm292100a91.9.2026.09.16.09.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 09:46:09 -0700 (PDT)
From: Jaemyung Lee <ldc.jml@gmail.com>
X-Google-Original-From: Jaemyung Lee <jaemyung.lee@samsung.com>
To: Bean Huo <beanhuo@iokpp.de>
Cc: Jaemyung Lee <jaemyung.lee@samsung.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	bjorn3_gh@protonmail.com,
	Benno Lossin <lossin@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	work@onurozkan.dev,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH RFC] drivers/rufs: add Rust UFS host controller driver
Date: Thu, 17 Sep 2026 01:46:01 +0900
Message-ID: <20260916164601.2562349-1-jaemyung.lee@samsung.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <4c38f13af8f75020fefc35827463e9bc643b99f4.camel@iokpp.de>
References: <20260912-rufs-private-v1-1-716db733e655@samsung.com> <4c38f13af8f75020fefc35827463e9bc643b99f4.camel@iokpp.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 2026-09-11 at 23:44 +0200, Bean Huo wrote:
> You still use scsi everywhere in your implementation protocol/scsi.rs
> builds READ_10/16, WRITE_10/16, SYNCHRONIZE_CACHE and UNMAP CDB, so
> "decouple UFS from SCSI" really means "copy a small part of sd and the
> SCSI error handling into a UFS driver." while JEDEC defines the UFS
> application layer as SCSI, the SCSI work doesn't go away, you just move
> somewhere else, and it has to be written again.

I agree. By "decouple" I meant independence from the Linux SCSI mid-layer,
not removal of the SCSI command set from UFS.

The current RFC has CDB construction and only a small part of completion
disposition. It does not yet implement enough sense, retry, recovery, and
disk behavior to show that the complete UFS-specific version is smaller or
simpler. The cover letter stated that conclusion too early.

> The "friction" claim is weak. SCSI has already been changed to fit UFS.
> Two examples: UFS now uses SCSI simple copy, group number in scsi write
> command.
>
> I doubt how far this can go. do we really need to pay effort for a new
> RUST UFS driver, I am not very confident, unless SCSI is removed from the
> UFS spec and JEDEC defines native UFS commands, or we talk to the device
> directly with UPIU. please name the JEDEC feature that the SCSI midlayer
> really blocked, or that was historial issue which has been fixed.

Also fair. I cannot currently name a public JEDEC feature that was
shown to be impossible to implement because of the SCSI mid-layer.

One of my main motivations was the amount of cross-layer reasoning needed
for product EH and PM problems. In product work, I often had to follow UFS
state, generic SCSI recovery state, block queue state, and device-PM state
together. That experience is a reason to investigate another design, but
private product experience is not proof that the upstream architecture is
wrong.

> I would also like to see the heavy and hard parts, because they are the
> parts that decide if this design worrks:
>
> 1, error handling: abort, LU reset, retries with limits, sense decoding,
> this is the very hard part of UFS driver.
>
> 2, user-space tools interface: SG_IO and bsg (sg3_utils, ufs-utils, FFU
> with WRITE BUFFER), and the UFS sysfs tree..

I agree. These are architecture requirements, not small follow-up features.
Before claiming that standalone is useful, the design needs to cover
timeout, abort, LU and host recovery, bounded retries, sense and Unit
Attention, late completion, DMA safety, PM-aware recovery, and request
disposition.

I think the next step should be to document these responsibilities and
compare the standalone design with improving `ufshcd` before completing a
second implementation. If RUFS only reproduces the same behavior and
complexity, the standalone design would need to be reconsidered.

> Did any AI tool help write this code? If so, please add the Assisted-by:
> tag.

Yes. An LLM helped during reviewing, testing and preparation of the
submission. I will add the tag required by the current kernel documentation
in the next revision:

Assisted-by: LLM

Regards,
Jaemyung
