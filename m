Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C8939D6D5
	for <linux-block@vger.kernel.org>; Fri, 14 Aug 2026 15:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786721556; cv=pass; b=WbLpAgfzPCMrWEEGmaaI9TBGB35aqo+JZXExuKkAJ6eZ67Gl9lmI7yWKyYvi0gcVNd8pvaz2U7mI3AV7eTDpEi4w5aFKBmYQBMAJnvB9Z3PUPNsjGE6pyA4Cb3s5xFJeUqh3GMwyBvKL64YE1pwbeD1/88kuM29hNkPQ4JywRYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786721556; c=relaxed/simple;
	bh=TK7PQvHRhfO7d69vCikmlkkwgXEXe3Jt7PiHxltn8vg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dAH6LwL9s8XCR3HEdbgGO07Gx1rKYnma61mLsQQjrcJNNgHwhnhF3XPIqTSWhn4JB/Uq3ezy0KQHmuWX+pBWLKp7VGVAhhlCTU0iRtv28wL8EPCdg+JhY6gLlS/hX6Qhdku9r9IjOF8umf69O6JdgEv3zcq9sIc1ULc2eSgpBQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QWznMTT4; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWznMTT4"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5aeb59d54b1so1182070e87.1
        for <linux-block@vger.kernel.org>; Fri, 14 Aug 2026 08:32:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786721553; cv=none;
        d=google.com; s=arc-20260327;
        b=FF/18UG9d9dUUFhSSbsZQsOix7zB3pha4bCUeX4KBJf5stO8U+cuZ6AQzH71MCvmf3
         Fxt1/TIhYlpfaUTdwX6tOmD1WSQ6SK3okBVK+4yKlW8jfPkK4NgzcMOQbisbr+AOLW9W
         Ev7DuKauh3N4l+KMr6qQssWoFvFb0SzdF5C6vVunyDX6gC+yzQ7mFT1MMNxRH1OV1e0V
         W7QAj4N6XYDagTAR4Way58DvNBTJV1cV24pRL0kaIl5/FQK5amzM3y/AH3VEBcJU/IHp
         HyzJJ+1bxvxKsTQt1Me8Wc4UsQxRjIuc32WqUeGPavZB6YddSLi5sRYfYpEoHI3edLBq
         8oJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TK7PQvHRhfO7d69vCikmlkkwgXEXe3Jt7PiHxltn8vg=;
        fh=mITo7w2woVZxgwJgBiEIjjc3CuYxGL+SmaxRUY5+Sx4=;
        b=dPHMs75nJr3cFOLRXv4DdhAAcCYrUVv1QuU1ZAFpo5tJKpOIteH1o/awpnVDS9objd
         ie/20He80FeE1Hqe8IGRpi06V0oXiStjN7P6vqiVQUqpYhU3ZK3jzfRHd7d+uE0MB7LS
         TcjqolcaPFzeZRHD531K8kS9IHpJt9EHjM1CN+CF9YdbkhqEdVUzN5cppr+09AnQKg4E
         kIXz7yp8hAFUspdkcxasPxA6CEcZmBZ4fLtDTffGRvVNUDMExr4sKYPN51ImELW6eSsj
         bTbwKVPRuHR/QCX9e8umhcJElFYgZMbIQgll10xBoWvsyWvS4bmQ6hjwzunPQGkuybZ2
         UiCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786721553; x=1787326353; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TK7PQvHRhfO7d69vCikmlkkwgXEXe3Jt7PiHxltn8vg=;
        b=QWznMTT4c3t2Zh+1YWMgRXyJ1gqpDDuql2zC1f86z/QXJ+LDmyoYiCsgrHOWUMtrg6
         bNrJEd3Cx/hUkk0RLs3yPPOdPeX8oi3medfxZQDFon3L4VoD5hAmdBs9iLEjFa9hSRL7
         jnaLRWeWvD58X+4MPJCaZtCwyP3aaV7lddEZRc77gtb2A9q7MpNcyT5Hn/Y4jz6uEV8+
         hfvPGrZm1nrmVn55b02f+uSfFWFWd0fBFA4wYmbMucz1t3T7Sn1GsyCwevbcj5RcvaSm
         2ISKGREqo10apTu42M7VM8zPxXnfHz0fvQEZ1l0So2KL69wy19nmGQ8KLsaYUngr2yg1
         ssAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786721553; x=1787326353;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TK7PQvHRhfO7d69vCikmlkkwgXEXe3Jt7PiHxltn8vg=;
        b=jRPFSsmQHN/53AzZ6DWcH/2t4D48cODNDeTGS+9JCR0VynWhub2qCzDlRFyHkM/UWt
         3T/zlJvGEY6aq0b+PRkGbNMH82lR7FkK54yxoZLiHFWnXgI6s78CneJrTDnczK0ti0z+
         3HJApXtnqoKLnfK31ziDENdwn+0B4bgDYSR8ApW3NQ4HXvyYRTfowmq/dr5AZMauclym
         xhWqbYu9rhBJbFAyyEvTEC48aah9F0q8nfRih6fN5ALAjYJsb+Hb03itAg5AzbiYoacY
         giiEYcHqYZSCxxiw3R1YTpHD/nETEDRCP244WPApLh6vMzgB+1IQqUmCzg3oorLZmNtY
         fiJA==
X-Forwarded-Encrypted: i=1; AHgh+RqH0iR0VK0BAYlLONMO5PfOmrW0pqA8eW0sS3javGhBM9v4hbVU4fbWwsfMvs9VObksgPun9OoiQbq1nA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJwFJHy6NTHQLoCZomyxyGUiX1zWz+MI/PzofiHAnaKUCHOOIW
	HX6RtCLgHSL8SnD4+8w2eXgu6RZLv0+AazP+35RqPSvJcF3a1gpDl2oCWkyawbWDjLhWgW+8qrD
	3h17GxEK3xb2FGSA7yOZUGyNkZp5cKhk=
X-Gm-Gg: AR+sD13VZCrqTY3LQcbE2fmSgyRPvN8Gszae5mudrAlxChFDej/pgBpm8NBgk9HOyQ/
	KdnOUE5l2O5sGD1vvy29/BWGAmiEDTMa5IkYtW+59KQfrXfSt/AsMPBRc1YaWjegDNmsK/ltsDy
	zkjD75RGyyKAApM62Bkv7AWmwmFMnofUs7aB7VuZEAFv9HxPqQZUc+8tFFBFizMaq55errQMGNS
	YpjqCFSExeFXw9wzMTz322RwOYOdj1Jm6WZF+YzKdN1zXrNMNhpHZSG8QTszwzg58lSYBmU2W9P
	O2a+i8az9SYi2YuWsK1e0oPeUoaDob50XmbKPYflQqp+V5txcijwSHohutVjnshfco1DcDfssGD
	5lKyCH8a2vbaA+SExrZiwlC/Ksmc9JJDn/A==
X-Received: by 2002:a05:6512:3b11:b0:5ae:bbe5:2076 with SMTP id
 2adb3069b0e04-5b45914ab46mr1037748e87.52.1786721552817; Fri, 14 Aug 2026
 08:32:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806170108.2100312-1-daeho43@gmail.com> <ann0OPPglToV_hjs@infradead.org>
 <ff74edb1-43c7-485f-ab78-ec13b500a0bb@acm.org> <CACOAw_zqOS0vHdQV6WoUJyxnDf=kdDAz27pNGDLdQLUdUYOzBQ@mail.gmail.com>
 <an62BorNrc-IX228@infradead.org>
In-Reply-To: <an62BorNrc-IX228@infradead.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Fri, 14 Aug 2026 08:32:20 -0700
X-Gm-Features: AUfX_mx2Pto06m45d7F2_lptjs17kW4x65ZWOP5JIP6wMXsiPjstrC3FI6rq2kA
Message-ID: <CACOAw_zKnj-o_7OhEWcVGYeFy6m1GM1KCW3hhgBX+O=KTev1jQ@mail.gmail.com>
Subject: Re: [PATCH v2] f2fs: quiesce background threads during system suspend
 using PM notifier
To: Christoph Hellwig <hch@infradead.org>
Cc: Bart Van Assche <bvanassche@acm.org>, linux-kernel@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com, 
	Daeho Jeong <daehojeong@google.com>, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 11:30=E2=80=AFPM Christoph Hellwig <hch@infradead.o=
rg> wrote:
>
> On Mon, Aug 10, 2026 at 09:53:14AM -0700, Daeho Jeong wrote:
> > On Mon, Aug 10, 2026 at 9:34=E2=80=AFAM Bart Van Assche <bvanassche@acm=
.org> wrote:
> > > This information was shared earlier with Daeho
> > > (https://b.corp.google.com/issues/515470309#comment45): [ ... ]
>
> This does not seem to be information available to the public.
>
> > f2fs threads are already freezable: f2fs_gc and f2fs_discard are
> > already registered with set_freezable() and call try_to_freeze().
> > However, a race window exists: a thread checks freezing() (false),
> > calls submit_bio(), and gets trapped inside __bio_queue_enter().
> > Because it gets blocked before reaching try_to_freeze(), it triggers a
> > PM freezer timeout.
>
> This does sound very much like a block layer freezing issue.
>
> > Point taken. Aside from this f2fs patch, I agree that addressing this
> > at the block layer or PM subsystem level would be a much cleaner,
> > system-wide solution.
> > I=E2=80=99ll give more thought to how we can properly solve this race
> > condition for the entire system, and I'll loop in the relevant
> > PM/block maintainers if a viable generic approach emerges.
>
> Thanks, it would be great to fix this properly.

Now, I am considering modifying block/blk-core.c to introduce
freezer-aware error handling in __bio_queue_enter().

The idea is to have __bio_queue_enter() check whether task freezing is
active before it decides to block on mq_freeze_wq.

If the system is in the process of freezing, it would immediately
return an error instead of waiting indefinitely on a frozen pm_wq.

I would greatly appreciate your thoughts on this approach.

Thank you in advance for your time and insights.

>
