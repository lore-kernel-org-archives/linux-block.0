Received: from mail-qv2-f41.google.com (mail-qv2-f41.google.com [74.125.230.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D5351A14F
	for <linux-block@vger.kernel.org>; Tue, 29 Sep 2026 13:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790687253; cv=none; b=A2ovw/EfFq5gkeUnlmemRh771KJJ0UTII42sTrsGX09JrTWBmETRTLQ5/7KQ2ZeYu0Qiq7mUb4AcmamldvJvDy993nKPo8I0otxYoldL4u9ymYK6jfnohnXjdFi928iaVoEY7wSkes13GYgYdhf0rU5LiHpRUKbIrCNQ04nuFmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790687253; c=relaxed/simple;
	bh=PUrN0XLKKmcY4+BzdqcUirV+08xJH2NYk9oyUJnLOKY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MLRsPpH9Mg1+0yeF9+1P2E+4z8z1SQAxlineV62ymvm5Fv4JZJXgKmRVJTN13+x97ua+8wMkARg+ZeDzRLEP7/F8zwXji/O4ElQuIqbaSVVThXBx5yqaHPYsccFQ7VfllOu2f6v9uiAa8jONsg9GJKWUkUD9oiXmvJpcrwnBgBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=sGoAyW/c; arc=none smtp.client-ip=74.125.230.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="sGoAyW/c"
Received: by mail-qv2-f41.google.com with SMTP id 6a1803df08f44-91784fbb60dso9837256d6.1
        for <linux-block@vger.kernel.org>; Tue, 29 Sep 2026 06:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1790687247; x=1791292047; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=s2+9C75fPvA5g6i7G+PRMeW8ilNW2Hk9NJmcPsE1jGE=;
        b=sGoAyW/cBDUOjNP/dhva8ysA7RPUsTwMJ8xLzsDjxnrHpZ8NwtRL8fvltqg6ECe6uk
         4bSH/ClMNhb5xWEM48s783LJiRt6RHjWDUZLjJTTSOJnJYKhL/YuPXQkC7g2xGL+ha9X
         eap9ibADGLP/UaXukTYZfE7vg7NOClXT2SgcR3xekoUB+3eJFaOISd4mlCfpA+kPLcx4
         jAt+oDTYPvPUHlWadsoosVfKAuDRA/O1LvlgL1idYqQNiSmq2wYGHhP+fYfdjkaOTssm
         a8O5jRbN1JVD3+bX6NCG8XOzg/cQULYHziQOTmEP+dRSGQ1yD+q05MWpiHqn877tFCej
         5AiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790687247; x=1791292047;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:subject:cc:to:from:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s2+9C75fPvA5g6i7G+PRMeW8ilNW2Hk9NJmcPsE1jGE=;
        b=NmdVHPVTfIHNl0JiwaVLsEzBQV0GRWG5nGVr2ODN8S2rcILp2t/rkNM6IjZQbF+w7j
         4PjrHGB8A2xsV9V2wXz4LXxO5Wmwzfw3Dl6xhKGXZfzGRgwwfWXFQHHrH+3VJuOU4AbC
         TyXAJkXA23KuIvgcdNIK9Zv+5WgOuZ1OptOgaBhgOf8IH/G3YXxZTdRBLyzPttJvKLH9
         3u6ExPvxS4K8MfWF+g+WinMHwGMaH3HSYxuvNSOc0EjZAvM8YdwtVkNr2HExKZjA/nrP
         wwpekgvL2CqQoB314QsHtWwIJGp5Km3TSedI3/QUhoSjttT2X8riOZq8gHDkEqxyR9V9
         4+tQ==
X-Forwarded-Encrypted: i=1; AKwUvBxMfL7c0hV35MLW/ERwQNrmNew6bIq+i5jt7+/oz87XIlY88yAigaP8iTjJWfXncuTSj3fKvb5GCWEbsA==@vger.kernel.org
X-Gm-Message-State: AFuF++k/ZeOuqAQw1LvRC/zreNn6wjSpjNkiqexXIUKTAZREiOaHmUlh
	QdOoCD183E6Xi50cmyuVg+5vSzw/u1uHxCY/QCNagKMQOo53IDI80HxOhbeMZvMc+6g=
X-Gm-Gg: AYBFou3XFh4hIcPW5EvnnDhzThHCWzdnEPa4oBUQe94dq1K28mqesGEEAVqGgBG8LIW
	F6g0GktUYeiR15YiWmRCWez5jaWQbuMpP0NTYjQpRZa/iFFvqU8rp3UmOulOu9bZtZ5PjqPOvXg
	jVXmAl+pSdga54BbXf8ZmPBnLj/g40FSKT8W+JtXTnXAOewk/41pa0SgEWtcu+j6BNyiUqtKQxg
	ZUY+SOLx+Jj/8a3hop0ht0ST+NwURLrhblMgUDSh7N3v9n4h5EM38q+HTootU1LMiGdUYhYwg0P
	b0AplzN9TSJP/h3NCOVuF7YBEOn4HORoOr3YY2KZC8tptvx/3opPVp+Ty6vSd4loIVDJCXu/sYK
	fRmGr87idL/i18WQjby2Rk55/sMDDGVcaeL8XOUKK9sYLZPJgY/8subsuV2N4QTHS/UWKhycqlK
	oCDydU8Q+DU2x2GfGBWqoZ44ScmT27rrs9YWEu1kfSKDjgJnfzGPwd90FxKRncxelXpH1ugYhPo
	uUltIqB1PTnyzM=
X-Received: by 2002:a05:6214:2f8b:b0:913:ffb2:e8d9 with SMTP id 6a1803df08f44-9142f93e820mr258725566d6.40.1790687246832;
        Tue, 29 Sep 2026 06:07:26 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.255])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9178d1bcfabsm9993486d6.2.2026.09.29.06.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 06:07:26 -0700 (PDT)
Date: Tue, 29 Sep 2026 13:06:49 +0000
Message-ID: <f3880ecc0f95cc12f0b8fbb019f7efef.josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Ming Lei <tom.leiming@gmail.com>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 3/9] ublk: publish io->cmd under io->lock in the commit paths
In-Reply-To: <CADUfDZqDZEM4=uw+By6RnxvLqXbc-iPf8RCUQtQB5_Z_Di84Aw@mail.gmail.com>
References: <20260928-b4-ublk-cancel-stop-v1-0-4a4360232a46@toxicpanda.com> <20260928-b4-ublk-cancel-stop-v1-3-4a4360232a46@toxicpanda.com> <CADUfDZqDZEM4=uw+By6RnxvLqXbc-iPf8RCUQtQB5_Z_Di84Aw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, Sep 28, 2026 at 10:53:38AM -0700, Caleb Sander Mateos wrote:
> On Mon, Sep 28, 2026 at 9:03 AM Josef Bacik <josef@toxicpanda.com> wrote:
> > +               ublk_io_lock(io);
> >                 req = ublk_fill_io_cmd(io, cmd);
> > +               ublk_io_unlock(io);
>
> Taking a spinlock for every ublk I/O completion will be very
> expensive. Is it not possible all paths calling ublk_cancel_dev() to
> wait for all tags to go idle?

I measured it on a c6id.metal (Xeon 8375C) under KVM: an 8 vCPU guest,
kublk null target with 4 queues, fio 4k randread with 4 jobs at iodepth
32, ten interleaved rounds of three kernels: for-next, this series, and
this series with io->lock taken back out of the commit path. That last
one also drops the second lock/unlock pair patch 5 adds after
ublk_prep_cancel(), so it isolates both. The guests weren't pinned and
landed at two throughput levels about 15% apart, so I compared within a
level.

Series against the no-lock kernel, IOPS / CPU time per I/O:

  plain      -0.04% / +0.7%  (high level)   -0.7% / +0.7%  (low level)
  zero copy  -0.6%  / +1.1%                 +1.5% / -1.2%

Batch mode, which runs the same per-I/O code on both kernels, differs by
-0.03% / +1.2% and +0.4% / +0.5%, so the lock is inside the noise of
this setup, which is under 1% of about 3.5us per I/O. Against for-next
the series is +0.4% IOPS / +1.0% CPU per I/O in plain mode at the high
level. I'm rerunning with pinned guests to tighten that and will follow
up if it moves.

It's one lock per io that only the task committing that io takes, so
it's uncontended, which fits those numbers.

Waiting for the tags to go idle doesn't close the race this is for,
though. The control path claims io->cmd while the server can still
commit on the same io, and what matters is ordering the claim against
the commit switching the io from the request to the new command. Idle
doesn't give you that: a tag can be idle when you look and be re-armed
by a COMMIT_AND_FETCH right after. That's the QUIESCE_DEV hang on
for-next today, its cancel pass skips a tag whose request is with the
server, the server commits and re-arms it, and nothing ever completes
that command.

Also, ublk_wait_for_idle_io() can't actually wait as it is.
blk_mq_tagset_busy_iter() only visits started requests and
ublk_count_busy_req() only counts requests that aren't started, so the
count is always 0. I'll send a fix for that separately with the
QUIESCE_DEV work.

If the numbers show a real cost I'd rather find a way to keep the lock
off the fast path than lose the ordering, so I'm open to ideas.

Thanks,
Josef
