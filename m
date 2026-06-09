Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C459C48C404
	for <linux-block@vger.kernel.org>; Tue,  9 Jun 2026 15:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781018149; cv=pass; b=lKUF7JBpBWS7yROJPIvKl9avwRgafc63jFBSYfXc5nuT44ILBG8yQxt2peHMS2Jactk4LoTfek1I9SuodPZW6OlP8K9qlP+scd5A9R+mQPNdi5I1Qs8Pa1dlq5CYWMEFF3AyXfUjQMlEcdxYr+khyI3+7Ino+BWlI/KQ8+ORH2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781018149; c=relaxed/simple;
	bh=XAGyGGRCa0i5p0EaF3Q9px7FiGrZLFso6DX4zKKzZD0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MlU7HCrdItFHO4fr+OiIRWoJWhdUlTXUraqNrGi4Vy1snPgjTow1esvFG7kzqMeDvUk+1CfReC3ZNK6CmZEpB1/UJYgFMUUNXfR1c/Uz5EgqoGc/RFU3M4Mn15epUYri1ZX2wGlCOhxWKZLhksswp0KKHkP8UbXSd3Ym/GDdbBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dPdXpHEJ; arc=pass smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPdXpHEJ"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-48673dc56a8so4774424b6e.3
        for <linux-block@vger.kernel.org>; Tue, 09 Jun 2026 08:15:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781018144; cv=none;
        d=google.com; s=arc-20240605;
        b=SYJ5x9UVlsBroBUgETzI9lAIwPT4NKcDxDtDL4lQBaS4ohfXQDYIhKdXgLUDmDTOqN
         FxRtbPbuAQHbEazXH3HP4tRJbt2zt/qu+LlpsnJHGmM5mdoW0h9gthFxvZDOuZi1eNI8
         lbdGNRuZBkee/dpdZmJbkpw0erL4vD9fkNpkf55mWhbyKPFWe6quCCBcrFhUak0pLy3c
         koqmwmWXhSm051h1Qd+q0lg+679hjdmLLzv0lfbLTEw6pQUO6schvk6BvUNyl6FNTufI
         vFJ4Qi6tOLixW8hf9WW3ByCVp93tAxSVtl4d91D/igtFeZOzXYMoA5P5X+HhLiO/oE1l
         nrZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Wt+3EeS6ijMa9x3r8w9B3P8FOrVy6t9nE/xiUFYUoJQ=;
        fh=hM9FRVlItW8/LqkaTd6P8AUDvhkxD4QqbSkducN/bfk=;
        b=Pz5QGpQYGOt7JtT63OtHcBNkvW3Ym04L9XwtRRy5e4vpFv0CYdJwWOJb6InyyQ4MYh
         rNX36OFoQEoaShw4gouP8eb6PQyq2abQqAAo2Q63j1xXy+bbnnTuQMAo9dxwqCqh0VLg
         M+BbvKhXulNC22PJVsmccSK/VY9x/yx3+qQRudU469pRipoB/KPzBQLJEWWndb8FSCcd
         riERQ2SeuDUwwNp444Llx1UKjd3GX/msFuXtmv1gcaCUmd4PO2YU3F74hnE47JjuFRw3
         gWJnMHF5iiWnZ1myJb+izxG7UVRb5dsZGcO/qgM/4LVF4e3+mS5gIWlg3Cay+hYXsgPf
         taKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781018144; x=1781622944; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wt+3EeS6ijMa9x3r8w9B3P8FOrVy6t9nE/xiUFYUoJQ=;
        b=dPdXpHEJCeybVRl2oQEFsBA/t7D0ImSg/33zrvhEW15m7LZAIeKssgC8XjlEogdGd6
         sjnCfI+WFYC4HWihYTyrVqZ398oF0ibFRODjaV+qZLdLc+AzVGKPjKEYiUEKTFwPH0ZJ
         NttS/WMLkNpx572r6OWMse4ct45kzsIm6oN89zg533jSazoxAF81vC3q6MizVFEF/M2a
         uxZ8j2w0/ILZF1J8f6EBzu8QvV0VrXJ54d/Xxv5o3ppPvlzLGHc959iCnp9fqFUZWOeV
         Bh18B6XSKXZBMM9HbVcfFwTRGfMAmVjIT7FCO3vB4zXM9zB0vYOmi7rrhP7TdRSL40xF
         /WuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781018144; x=1781622944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wt+3EeS6ijMa9x3r8w9B3P8FOrVy6t9nE/xiUFYUoJQ=;
        b=XT8uVMq+aNDG0WFjwSdF6AthvmScnlXxLZeUozp09aGAmz6V1hK6LpWnJS8RUCNLnT
         LJtR0M4EsCaa8+1fprj8AGZRo2FzM2uDbx70UEnTnw5T6+5tq1joLCCPijtm7p7QOk72
         eA2lBx5pyMXE5ER5FNzZhNI5fjHb6NxmuJhThjz9HHd/UBzZ5OarWgHdzhDpyMLwXc82
         ibrb0x6NNuox2nb6EBFBTyrsF1jd3XtIRRfrwvnQ1gaP01M+b8+9fZ66p+aMK4Egh1rx
         /nUgTr1dv1R6gcUmGXXcA726SrJtRXIui+ponBLAfTRauvqrLkDYmBzMCrKGAhRMfXiA
         GnIQ==
X-Forwarded-Encrypted: i=1; AFNElJ8GetPfDYhA8Ai2sSDDPLX2VuuiXoozdLVBypikT1mSNj6Qkh8mkIiOfJheFtDpATG1t2Ypk+MmAxsplw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzze7frEPN5vh3ULAMIiYzpF4UDddtYba6cNtiDseiGqG2SqrnI
	l/9dsX1CtAGBGcBOz7kH8DaV3vG+Va+x91lJsTSqpnyWpzFNQCkgwRvFy1mgBU4jAflAexGjg/B
	zWyoFlUjK2Tc0ie/AP8k0espHl94yA74=
X-Gm-Gg: Acq92OEWy6I4C95S6DCNiwTl40ckhAfvy69qV8/Pr0Y/K74FDoRqpbZ02qxBY9V8z2y
	Jn+JtJrIEuAQzpIe4MfyhKIsJ00teiY0fvXuwgiBCC4a0b0rXE3QoVbp+WVI9NaUaH0PAyMOQsU
	WedtD721ol3LJVBw3u3I1wz+GN6Sf8e27Elg0wIz32W+BM80W44gj5o0YhVC8km9bOfiuiYHhls
	wQbp0eUkaqomD0ax4zqNWbqsTi/iLa4fYOKDJOfG7QHx5oVRvjtP9qKGqTNU4g0xOOvcTkA2xv+
	2GDB1O4eP8tsbmQSDrrJ5RvFy8mXwK4v+B20lCXiZcscHR+Ei/h0
X-Received: by 2002:a05:6808:1454:b0:45e:f0af:5148 with SMTP id
 5614622812f47-4868de84142mr11623304b6e.30.1781018144395; Tue, 09 Jun 2026
 08:15:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1780492756.git.yukuai@fygo.io>
In-Reply-To: <cover.1780492756.git.yukuai@fygo.io>
From: Yizhou Tang <tangyeechou@gmail.com>
Date: Tue, 9 Jun 2026 23:15:33 +0800
X-Gm-Features: AVVi8CcSfWWILCDELm0SA7ZWJBSUn8yjiqxY_MLXcIuNwEr1ynVC6AyoN5wQ7zg
Message-ID: <CAOB9oOZ_PMGRmNOSJM=Nda0t2zfxZ4+h7N7tvv_scmJeFfUdiw@mail.gmail.com>
Subject: Re: [PATCH 0/5] blk-cgroup: fix blkg list and policy data races
To: Yu Kuai <yukuai@fygo.io>
Cc: Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	Ming Lei <tom.leiming@gmail.com>, Nilay Shroff <nilay@linux.ibm.com>, 
	Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 3, 2026 at 9:35=E2=80=AFPM Yu Kuai <yukuai@fygo.io> wrote:
>
> This small series fixes races between blkg destruction, q->blkg_list
> iteration, and blkcg policy activation.
>
> The first two patches serialize q->blkg_list walks in blkg_destroy_all()
> and BFQ writeback weight-raising teardown with blkcg_mutex. The next two
> patches close policy activation races with concurrent blkg destruction,
> including skipping blkgs that are already dying. The final patch factors
> the common policy data teardown loop.
>
> This uses blkcg_mutex rather than extending queue_lock coverage because
> the races are about blkg list visibility and policy-data lifetime, not
> request-queue dispatch state. blkg_free_workfn() already uses
> blkcg_mutex to serialize policy-data freeing with policy deactivation
> and removes blkgs from q->blkg_list only after that teardown. Taking the
> same mutex around the remaining q->blkg_list walkers gives one sleepable
> serialization point for blkg lifetime, avoids adding more queue_lock
> nesting, and prepares the follow-up conversion that removes queue_lock
> from blkcg list protection entirely.

LGTM.

I had noticed some time ago that blkcg_activate_policy() did not take
q->blkcg_mutex, and this patchset nicely resolves my concern.

Reviewed-by: Tang Yizhou <yizhou.tang@shopee.com>

Best regards,
Yi


>
> Yu Kuai (2):
>   blk-cgroup: protect q->blkg_list iteration in blkg_destroy_all() with
>     blkcg_mutex
>   bfq: protect q->blkg_list iteration in bfq_end_wr_async() with
>     blkcg_mutex
>
> Zheng Qixing (3):
>   blk-cgroup: fix race between policy activation and blkg destruction
>   blk-cgroup: skip dying blkg in blkcg_activate_policy()
>   blk-cgroup: factor policy pd teardown loop into helper
>
>  block/bfq-cgroup.c  |  3 ++-
>  block/bfq-iosched.c |  6 +++++
>  block/blk-cgroup.c  | 65 ++++++++++++++++++++++++---------------------
>  3 files changed, 43 insertions(+), 31 deletions(-)
>
> --
> 2.51.0
>
