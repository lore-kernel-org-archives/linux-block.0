Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4915C3783CB
	for <linux-block@vger.kernel.org>; Mon, 11 May 2026 06:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778479307; cv=pass; b=WohKEXMQDpQ6/1hYulM5K55O9QJbla/4yq9BMpK1AzdIKfV8g9fOLDlrh20VatnUM1MC+QUZNWRiiVKs66T2kIHcPHTymRPKbvL+uD+Vx2iHH66sKUIEiVOgZUtyCORVNmxMYoL2mCTuweADCauotV3AZot9SWaiFQ3WKbufBl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778479307; c=relaxed/simple;
	bh=eVbQYh+j9LHSOXYULz42HAZfUtSMczgFM+UguZ9iVlM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NmTGMLH+AebLRreAqt7baX37LBx1RhtrF+dFjMMnvrsx/aFsJ1GAjJreBie/aL2ZGKWsIOyC/GgmJppdWxj9IjxVkM94fE4m4xWsDygik5QHbh97ZrceWfGqEVUpK3RRL/OYn9HotnSheKCVV460iH8LtybxWShT2KGy5gycHyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gr2MT7wv; arc=pass smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gr2MT7wv"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1329fc4bf77so2837032c88.1
        for <linux-block@vger.kernel.org>; Sun, 10 May 2026 23:01:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778479305; cv=none;
        d=google.com; s=arc-20240605;
        b=NZZ0KJcVWbjpSNmM0KNw0z1dpWM8VLyj5dbdjGikiRrnw7aCQYV81nxrs1g3cpkTtr
         kk9xv0huuiNzl4hM8RmnFkA4+ApJDkj/+FnBvSQfUHwYidxkAaPHqgZi1Cf7jgcp8YmO
         O9R5LJvaY4p+Ja3BLIQa/XPNa4FFK+rJZ6zzYAICO76ioEurvzDOCsL37WyUC4ZaOtBY
         VYQyASpH+33wBIJZ/xlACyNlmjSIy37uJyzisYSAwfNqQP+pdTkmO25wDaWxlpMM3Vuv
         6+S5L0KsIuWuoh/0sLbs4oyF2cvMKiIvX03z35OgCKPdHIij7UuXHjR9UEODDaeRy8xY
         /cfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=eVbQYh+j9LHSOXYULz42HAZfUtSMczgFM+UguZ9iVlM=;
        fh=E8k9KvRtSUF16U075R1oU/oHv/B6chlYw1TXzLhNqmU=;
        b=fsE/N/+UVi9c4oNVubatUFBW88dytn7hXLKLm1quTRwDXZ8wfBI546N+pKXnU28GXj
         cLKv5iw0DTbR7MJ+ECEBYrey3GRjPAQZ1lCFxRNqn2sviExQ1schG/TXVARUIuNHbHrk
         5x7VIJ0GnbSANei3nbH3+yq9QT0KrJtINiQcGAfuTIoMpv5s/cZn1Gr2bs6voY4I0wCd
         i2lxviRAxRWb2MzdkDCbxb92gWvR+atC2hrPrH82Zj9jWJIRvR+mKGstDbq5h/20b3Ci
         wA3WhDK9IQcLEMAQFzNqhTEGzfS84hpNmoHw6/nmmcNcmnRzR49e8lHg+cxh8MskYbJC
         eOlQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778479305; x=1779084105; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eVbQYh+j9LHSOXYULz42HAZfUtSMczgFM+UguZ9iVlM=;
        b=gr2MT7wvnlj+U57SdrwydXpQ5NrvkqKOam+PSlL9//p3ABCjLOFMN+4g3ieaTy5kOd
         9YQMyXKBrXJtSiWngtZI7+mxqhoALe1RcUwvdi2mIgBJUJ4O941aVVo5i9IqCTubdRGf
         auPlj/jvEhOR06RzuF7EdE3cgvzVy3SR7bZfZz/wGD0J8QQttHaKrw0HnXBhJuzmc2Df
         RvJqnW5nPVUP7E+LJtpxxPQg32RyjkCEenY3ETTQcHIFpWjhRLQbWCiHpRDTZPa92XbD
         1Vf6uRdq5n/ZebxpFz9S9O/y/UMiLdtPUAweY8vol4fjDoxwJZP3+v2wZak6rdCiL325
         CtWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778479305; x=1779084105;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eVbQYh+j9LHSOXYULz42HAZfUtSMczgFM+UguZ9iVlM=;
        b=cEwCa0aVGds2TLKflUJi9lQopvam0Doju0bwJPPUwBLu+g4vjnzNxDRc6dRjlP39nv
         8avPk+WUJ5s3JJ2YP6le0SjG9FLvuoZhe5YXFor2fjCes/ZIDhHfHiWidAtAsYD2OZ5G
         jCwCTGt7sK+9HikXP8hsZStA7bVVBNVpPo39eq3haWggkfqntloM6BLpFQslx4UG3ZNV
         nY4Spl+rXhiU2ZYeA2Hizfad/ihT2SFn3gnhGDdYDAqDjjbzXZV254uMRnxQWwyuN0CY
         blPJEfRtxCtWePKctHhMYuQB0lsTc6ZK/LGGRB8tJOBaUk0JJLQHmtoZHqplmsLjXlwa
         LZHQ==
X-Forwarded-Encrypted: i=1; AFNElJ/h0uiVDRiFWQuGTBfAWOUYfZ4Y4JF109rzbofeqgbA5hv2i/RllRrR2Wm1V0eWtOmtAHuq2dkNyHnTyg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwHjDrHgh5GYS2Fp4lbgCSzwzbb+y2FLEH/LnJxckOLPnHWuMpd
	b+g7sFd9id3p/PAmdM7B1n3s81DbyJFaYwXUr6RFz/BNf0tVe/A6Lu0h4NnkAiYglLpd3iksNhb
	5SDB9Cuutk31xd5T6z3HJvEeq5usJk4yWCMRZ2zNf
X-Gm-Gg: Acq92OHhu8D9rRB5t/FnW/cYngl6hcTqI0hnDBnv/FgldNsUYblUZ2R+Rn4T3hOYcn5
	Cm5AzacFr5wHU5wRPy4UClbdeBzFLFUiDGx1OSyLhMVy+fKbeYs9cgbxg/mEIK2Tu+Ux1AJ5uBt
	e7Bt/dWp6KS1vqFLU8oLEIqcnoWFCQsW4zc7Bb936oDAhPLsjn8wT8msUHPsAMHbcAR0q5eA2is
	o9wYaIsYbW60nu7GhaTaDyFbmDtYDul/n7wVby+CKkTfe96NAAQsb1+PzyomGUnrnBvxKMt4Eqi
	70f/plhV6fz7oiF15Mli+jy6pTVlRCuck/fYTCA76YaKzvFl
X-Received: by 2002:a05:7022:e981:b0:12d:de3e:cbfe with SMTP id
 a92af1059eb24-1318eb57b9dmr12037179c88.37.1778479304709; Sun, 10 May 2026
 23:01:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402183950.3626956-1-bvanassche@acm.org> <20260402183950.3626956-3-bvanassche@acm.org>
 <20260409064221.GA8378@lst.de> <CANpmjNMUv5n2VrWGPBOzGg7-r6gf3hH6ZoJYtRsrntY8+_=fQg@mail.gmail.com>
 <2e09806a-d5fe-4581-8024-906be7dca4de@acm.org> <CANpmjNPJPz7qruFw8S=4qoF32snPW-RYrd_BZK6skR_y86CUZg@mail.gmail.com>
 <08078df0-d3e6-4860-b22b-937035d45857@acm.org> <CANpmjNONpHgSzavkbqdbM2N0oCtt2_2+UqBCMWjMaWEcWrCy4w@mail.gmail.com>
 <2a2c46fb-c934-4ecc-b3cb-4e4114a6d6bf@acm.org> <CANpmjNPzuCUKRPFXZ8ckiCE01kc85xzOiMB05Y9OC9J4Lwi61w@mail.gmail.com>
In-Reply-To: <CANpmjNPzuCUKRPFXZ8ckiCE01kc85xzOiMB05Y9OC9J4Lwi61w@mail.gmail.com>
From: Marco Elver <elver@google.com>
Date: Mon, 11 May 2026 08:00:00 +0200
X-Gm-Features: AVHnY4L1ZFDMKsJfsrOKoc4K6lBsfe1-EkI50q_2amrbh6edn4il5I8Gb5Q8zPQ
Message-ID: <CANpmjNM6nERjfhNBE=D93E+HMaQtJWyi9s2qHmLWrmtBFt05vg@mail.gmail.com>
Subject: Re: [PATCH v3 02/12] block/bdev: Annotate the blk_holder_ops callback invocations
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Damien Le Moal <dlemoal@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 13 Apr 2026 at 22:03, Marco Elver <elver@google.com> wrote:
[...]
> I already sent the patch to bump min. Clang to 23 for Context
> Analysis: https://lore.kernel.org/all/acqELlVC6vEeEF-W@elver.google.com/
> [1]
>
> While for 1-2 new features we might be fine with more macros (as I
> initially tried for the multi-arg guarded_by), I think that doesn't
> scale if we need to support more versions and even more features. I
> think that's also what Peter suggested, and last I checked he's just
> waiting for the dev version of Clang 23 to be new enough to take the
> above patch [1].
>
> I hope the function pointer support will land in Clang 23 as well
> (when it will be released in ~August). So once the function pointer
> support lands, we should definitely bump min. Clang version.

Clang 23 will have function pointer support:
https://github.com/llvm/llvm-project/commit/d1e84bb9ad3b6a844cd902cf70e2764cb8126979
