Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF66277035
	for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 10:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773658401; cv=none; b=OezHTSulyeUNfUOM6mIa+VPNGDT8CxRFbID5rlgoUN08o4HtieZKf2eeVd8qtcf2UK+S3lvZlbTdMUyKh6CBUeHWHW7IzaBjMiva/AOyeW5APqJsLyzT/1x25h3ABnoc+1N1RTwakheMZk93U3/ov5ryzcZ47wVIRAYCQ0e4Jqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773658401; c=relaxed/simple;
	bh=XXldl4Gmz0I6nXnDLC6BfRsmDRyiK+QCcDXuThk0Y0U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oMo77U8ydGhBBTLaD1uPlbUOLaNm2KjWAk9yN+L9ufFiL5mb1i7n1eaDq3gQ5kqKdPnyEoJhCr992VooxwEjDmyKMeuW2vOrr4/5NYweSToKyM9JCEzJjxF93+/p6L0ikdbwnKPNuHSir26Oz+iVsf0Q3HJuImfC1gN5J9yMeCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MV4wIkqR; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MV4wIkqR"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4853553944fso46312135e9.0
        for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 03:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773658398; x=1774263198; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=g33pdxtpEHFf1UDlvSO++aA1e6glAPf5ZJ+Ik3YLW6k=;
        b=MV4wIkqRyu9jqbGSPDe2C4+WOK7Z662lly7t9XbIerpAKjRH8U09t3T4osDCicSd6Q
         gjIpFYzzqgM09BfHVTDKJgJj+aoCIPj60JxWttkDvcaq4EplSh7ee3t+qhHR+KsWVgoC
         pZrI++e4D2YNlO+iMSSEF1b+QSZeNaovp+UqmyHAcDRcKCofXmaTXo4kAvRLNvpOXoF7
         BZeemGfwuuwly595h+KLW8fl+aQWTYpm3cP3zO9vH5U1FYPvtzJqidTzvhAbyvPSGTxv
         5L+0RP4r01YpXVZgyRymWtPWF34YDmFTPWVL2bado5U1fqcDrYaykaeks9oEtEB3Dmrz
         kEcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773658398; x=1774263198;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g33pdxtpEHFf1UDlvSO++aA1e6glAPf5ZJ+Ik3YLW6k=;
        b=hjLiRSEBKvE77mB0MYYCcm9G5+BFp3ts91CekcU5//+GqhjX1wiQl5wvt1Ktz5+ADc
         Lvfk2A7uIWdI4KZmxFocsTMlIC5PpWYZB/+riciSUygpphHHOtok2qhF7Vuk+0rJVO3x
         nxBfx4lUH3LbJm3/4iISajlPb5+SKzX3GkTTMsYD5sIYLC3xh6vXbQt2KMRBjMNCqqjb
         CoVGvMaGTMpts/30GMKJO1I+1Z6nRcv/pL21IgyBTiN/AB6lgvxrETbos2+xHoA9X6VI
         jpP43C7lloDzvlpXJ4h4EOt/NUkBKFxPDuSkK/WFujfiBxtG8tPmIE6WRorbfoABPAHI
         nVRA==
X-Forwarded-Encrypted: i=1; AJvYcCVJixNn/ZxLQN5exeCWROEqdvy+URkwI9hXUi18b+cK/dYzGQMPrsF0uHMvAznZFYFunT5ncPF914j1ZA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl0wuEC+hU72yeI1KRczu02tPXYeIeZR6D6236R15iabZwAt0G
	qDs40+nuIsnjSCZKGpVkVcbVLQAVKlq+ASrVSU6BaFMBonahEcyKMGfaBovN+rOv4eZrGNAzn2u
	MQV/rkaxaLWajDc5Tuw==
X-Received: from wmfu16.prod.google.com ([2002:a05:600c:1390:b0:485:2e9a:31b4])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4752:b0:485:38f1:5cec with SMTP id 5b1f17b1804b1-48555ac714fmr203380975e9.7.1773658398201;
 Mon, 16 Mar 2026 03:53:18 -0700 (PDT)
Date: Mon, 16 Mar 2026 10:53:17 +0000
In-Reply-To: <20260216-rnull-v6-19-rc5-send-v1-21-de9a7af4b469@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260216-rnull-v6-19-rc5-send-v1-0-de9a7af4b469@kernel.org> <20260216-rnull-v6-19-rc5-send-v1-21-de9a7af4b469@kernel.org>
Message-ID: <abfhHQmMmEErFYb6@google.com>
Subject: Re: [PATCH 21/79] block: rust: add `NoDefaultScheduler` flag for `TagSet`
From: Alice Ryhl <aliceryhl@google.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
	Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Lyude Paul <lyude@redhat.com>, Thomas Gleixner <tglx@kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, John Stultz <jstultz@google.com>, 
	Stephen Boyd <sboyd@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-block@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="utf-8"

On Mon, Feb 16, 2026 at 12:35:08AM +0100, Andreas Hindborg wrote:
> Add a flag that maps to the BLK_MQ_F_NO_SCHED_BY_DEFAULT. This flag selects
> the 'none' scheduler during queue registration in case of a single hwq or
> shared hwqs instead of 'mq-deadline'.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Can be squashed into next patch.
