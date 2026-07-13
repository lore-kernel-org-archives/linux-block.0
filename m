Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC793D5C0C
	for <linux-block@vger.kernel.org>; Mon, 13 Jul 2026 08:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783933076; cv=pass; b=h+nr/XKsgNaMkfK0loCgq5glS9QWAFuV38vLyMLJoL7udco9WC1OoHoGvutJi06mUqtR96DLWSLzv8heF3AcHAcS4fyp1aTlAtkjglJ8F3kHvUcxuOTN9unhoCPwVqQtXIQP81MGDMDkTwdNA6q9DcbC49STeF7S+R7Mu/fAuto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783933076; c=relaxed/simple;
	bh=zGXlgemVtM/fd1QacjWZsPwmu1tJ8IeGxyTqkvyGisI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k5LtOBHXRYvQd69ZjVETYMgTpFQtIkVuhMyC6HR8IW6fTbghRm0rEt1Bl/mN0sPsHhNVOQP1UhSopC/QqRyEELu9WimL+Phb6OqbVCocYjsqEk2cOk9h6S4tmKmNvl7ID2zoDORBt14bajIbDm2ycFV2HyNxUV5nfs5F3Sv2zzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bhZpWy9p; arc=pass smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bhZpWy9p"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4728c12ba97so1170070f8f.0
        for <linux-block@vger.kernel.org>; Mon, 13 Jul 2026 01:57:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783933071; cv=none;
        d=google.com; s=arc-20260327;
        b=RBw5DWG/WHshjWIMsTKLrAMEWJIKFaFiaPNKOzJbXPsaRVWCscwnSeJVT4hn+VO9bY
         1Q1asjrFxHHCJa7lslGCCg5aBWVEvfobUtvFr8rBzI2VpxwXO5pm/ebl8SiEaFP5+muq
         bEFXZHEp7w9hcnR2tUAbt3/CxFev6DrASvAYygzHHyMkQRnqwfenfRWNaJMxRgjt6Nzx
         aTjH5CJ4kW17tpnxpMNriLCZx+glQEH5KGHNgRIevD7duodvKm3HcXw+Ef7w8WTYyhma
         /yAWYAtACypFvxdVD4UcEb1rT5b3K78ZsbldZfyesWwa7C0IYMjv1Y9TSYYZ4kYiL8t0
         sl/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Niw6ma3uSQo4Oag5BSyj5O/UfANxhnZNo3KLkxIFV/I=;
        fh=H59ga766EngMEdNiaTBmiOMXHBisd7qqWEde+bojd0U=;
        b=ms+brjlLLVS6MqeQwQtHUJdmUZ65JY2TDeR+p2aAUpVbp8nBRRG1+1fBY+Q1h9iM8k
         UqLGd34z0j7zb21M0+4F62lOPknOpKQosUjNONk7JNs0kVJIy3QmlrAZ3v/xCI5leUjD
         uYVCPOs10HOVjQEc4eONfpGm4+Fj1N5W2DV3A7aLH7wcDBtrZBNZWPGF/C8ZxzAlLjf6
         +2Zw8ivr+J3t2vIemlIL0BTAum7Y3iqJZydZDuk0AeehoZfUJ1NQ3qnFFjqaXDuJvV7U
         DexEr4tYEnv0JFFVVhqEwUimolRFmY+zoQrFsMeyyJxUhBX3/feZRjR0X6HpeGVrancC
         87kQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783933071; x=1784537871; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Niw6ma3uSQo4Oag5BSyj5O/UfANxhnZNo3KLkxIFV/I=;
        b=bhZpWy9p92MsHXolXEEEzyqO6a8taUshJqNTLDakidqvhciCwPleXpZnFFjlWiYgu2
         PD4KtR4wi8mFviwOMoQsSLwoiUrgbFxzrfMzPSO3Sybm9n1+9I9aGIKm/8G9v52bT/Dy
         /ECgJDqbQXnj9gc2kOfy3eG3Oyas3PdEqt32qqoJCGj+tlRe2CTAPATVLVaT2ZBSLmFE
         6NLrPC6nlM9BaqCBTXA2N+qswyb64G3vtCx9kHyfA9GDzZl//f+Oby1N7yx4QVQbPtoh
         MUkxAek+4XmOD/fokqGCzy3ZmMRVg9nKjm32kMvJgFt/LiXZSc+ZvzDDjsD9s3OVP1/l
         B5sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783933071; x=1784537871;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Niw6ma3uSQo4Oag5BSyj5O/UfANxhnZNo3KLkxIFV/I=;
        b=XUhHRyhBp0lkQX2Exf6BCIjiUgKVdB463/JxhOs+6UustYvmzjnMq7dAZtVmVw7GJ/
         JlxV8QN+wf+mRIVOtFzObvP4H1+3WZ9Zm60ZPiRVXVoGN6GMQygJQu5/Ia957X/xCGSG
         8YAtbWRCkMvTJRzMpQtf/trlgDYuuj3nM8J/zITsEyeOTqaTcmFm+VCijR21ASENnRHT
         rag2uq1KbtgrgQdV1lq2DCobLNa+5UmhflwgN2uFWbqhtRVdFMQR5Nsh8XJQ7dwhp8LS
         Xo7q+b/T3cWrM1eGW1AZja3d97+8Dhc/yiaohTZh+mH7NJdmAGDSssRYwVmi/JytUtZL
         7nRw==
X-Forwarded-Encrypted: i=1; AHgh+Rq7W05Z0VVRl32fV5bUVqZsOsHrHrrnXD8d29cUMqenrM61wq4tcMVLIwM+2dTMIBOzJVq+PDc0khoUoA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwyX0tk6LOf1lUR3RR1pctP8TwiAHBbT8WNgADbyFI3DcRk8L/r
	j/P0gKbj/gOzSzWJKD2KUk0INAXdjojCM4aKMPMwdxuC7ItfPZze+x7YbefSHuofbUMRAUY4wrq
	v9aNxVmy3EKslk6bEvN1lOQgtVHF+f4XUtQcIoQ8T
X-Gm-Gg: AfdE7clzFBlKivKXv13PTK8XSS+iKjCfSnHhO/4Spj0E+JBXi6c5r1bkqOd3kZCMkNA
	ayZZy8Uo+SYcB58+l0D/H80lxxxlkbS+hZDJ4elduqA2mj1OavyriVjrPgVArMs5tKCGHuLg7Ui
	tgsUOGy8xlReIAExCkLz5QAWXfo+47f1xnLXihFsUmF6ySNHp6XTBs7reljhFFUtbMGn5qnXg1u
	tIRDE7kyNwyzXCYx/FMjjE7+BuTg1oBGQxZP/9OYh+qP78CZKwTztvR4hv0UvZe3G0jeTZA+QQU
	oT0Qojk/OM268xAlT+bwxvQ+U+0uu2HB8vbk2xOYLAdz3MdoRjRtcX4DvzK6Iv1N4u/XNg==
X-Received: by 2002:a5d:5850:0:b0:472:55a:ef9b with SMTP id
 ffacd0b85a97d-47f2dcac418mr8602513f8f.8.1783933070140; Mon, 13 Jul 2026
 01:57:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713-fix-fops-owner-v8-0-2495cfa82d47@linux.dev>
 <20260713-fix-fops-owner-v8-10-2495cfa82d47@linux.dev> <alSe6PsvdrSYP_Z0@google.com>
 <d7c1607f-ea74-442a-9700-7fc4f0c64b76@linux.dev>
In-Reply-To: <d7c1607f-ea74-442a-9700-7fc4f0c64b76@linux.dev>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 13 Jul 2026 10:57:37 +0200
X-Gm-Features: AUfX_mw1uUYgV4eMXkVflbUYoDKpPh-OOQHMx0yAVcG6yUMQsdEhmzk4SLg_fQ0
Message-ID: <CAH5fLggszOnUm7Rykt41V91de8h9YVaZt49wr52i3t5-QV84Xg@mail.gmail.com>
Subject: Re: [PATCH v8 10/10] rust: module: update MAINTAINERS to cover module.rs
To: Alvin Sun <alvin.sun@linux.dev>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Arnd Bergmann <arnd@arndb.de>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, 
	Rae Moar <raemoar63@gmail.com>, Breno Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>, 
	Dave Ertman <david.m.ertman@intel.com>, Leon Romanovsky <leon@kernel.org>, 
	Igor Korotin <igor.korotin@linux.dev>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, rust-for-linux@vger.kernel.org, 
	linux-modules@vger.kernel.org, driver-core@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, nova-gpu@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 13, 2026 at 10:48=E2=80=AFAM Alvin Sun <alvin.sun@linux.dev> wr=
ote:
>
>
> On 7/13/26 16:16, Alice Ryhl wrote:
> > On Mon, Jul 13, 2026 at 02:45:31PM +0800, Alvin Sun wrote:
> >> Module types now live in `rust/kernel/module.rs` alongside
> >> `rust/kernel/module_param.rs`. Update the MODULE SUPPORT file pattern
> >> from `rust/kernel/module_param.rs` to `rust/kernel/module*.rs` so both
> >> files are covered.
> >>
> >> Cc: Petr Pavlu <petr.pavlu@suse.com>
> >> Assisted-by: opencode:glm-5.2
> >> Link: https://lore.kernel.org/rust-for-linux/8ea21b29-9baf-4926-a16f-7=
d21c5a1a1b8@suse.com
> >> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
> >> ---
> >>   MAINTAINERS | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index e035a3be797c4..74733de3e41ee 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -17984,7 +17984,7 @@ F:   include/linux/module*.h
> >>   F: kernel/module/
> >>   F: lib/test_kmod.c
> >>   F: lib/tests/module/
> >> -F:  rust/kernel/module_param.rs
> >> +F:  rust/kernel/module*.rs
> >>   F: rust/macros/module.rs
> >>   F: scripts/module*
> >>   F: tools/testing/selftests/kmod/
> > Is there a reason why this is a separate commit from the commit that
> > introduces rust/kernel/module.rs file?
>
> Gary asked the same on v6; `git log` shows MAINTAINERS changes are
> conventionally
> standalone commits with a `MAINTAINERS: ` prefix, so I kept it separate.
> Gary agreed [1].
>
> [1]:
> https://lore.kernel.org/rust-for-linux/DJJ26195JBS9.D3DNLZPRJYO4@garyguo.=
net/

Ok, that's fine then.

Alice
