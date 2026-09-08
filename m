Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF62534451
	for <linux-block@vger.kernel.org>; Tue,  8 Sep 2026 12:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788869414; cv=pass; b=n2zS3b7cTqfepSuJaWYdCQ30PQCWobm0Mm3bSs6T1cg7ufYLarlwpX61CHkCjHcQ97QDxzm4srvh7wPhqc3+NXRsG6CRnrSHVpVkmNY+6pjDaptlyX8KnOoitIrCj+ZfyKMXPxh5WEpKsh9QmoVlCXFGvlQBBKUt5Q9eZ9IftQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788869414; c=relaxed/simple;
	bh=GEVAY0aYWgjuxhScoKiGB2At23mpfNnhTAwPqvP6qjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SQ9FS0LfoPGh9Vye5Ilm0aYNPyTKWxJcA0f9hKGlx6B2AOuWWDzUyimZARGAk6d3ohIrP0wA2rt7zs33SeQ934x7LXhkw+ji8jpWCIJ94FOvscC2S3M63lXzroixWtWHnAfwYteF43jhu2MMjxq+sh8UcIiLCDbayTxs8y70GYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cloud.ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b=Qt+hoKfq; arc=pass smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cloud.ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="Qt+hoKfq"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b4a0b3ca7bso441951e87.3
        for <linux-block@vger.kernel.org>; Tue, 08 Sep 2026 05:09:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788869385; cv=none;
        d=google.com; s=arc-20260327;
        b=WGfjGb+/ljxQRsFZxuH/KuOK1/gx7b2FV0Mvm1027kUKpdwcscN2nxXZbdWMgCI59n
         VN0rTRaLQo6ENE1b3zNLqhNPMx5myHrwAKMry158OW2u12c+CLrDeokbeM9ood201xh0
         xFnKsoC0GtomJhM1TypmywsNTNw08fxPxcz7dA2ltsSkr7cXGkc/LzMfYqjEvAMnA4c+
         VEjVi2WrSB5/nEAwbSDcakJ1MsbF99G1TC9dw4PIdUieI5Zb7uH8B5VAnDj6Jb8702n/
         2VnlaUtioSnZUYzJKu3aGEfMyAYKu5p1Dpe5BqbfquRfB+828SqsIztZNCiDChnnDpXX
         id+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PefKymn7jgC5WY6NyYQ0JmmpZCQ7mukFjWFiljDO8jU=;
        fh=UAG9iPOrFBgKDZ25z4rvNyKp9oMgxjrrZ55d/Pi96tA=;
        b=Wk2L0Cf5+7gcTtYpMwChJhMu/IN8d5enEHPu7jnbAe3kG9jnXSyBV2kSj+7ACV5x3v
         El8I0bD8KUIu6Y5jyx9x++ejiA0vcJPD70MEWi1bZcWsD4rlPXuAj6191WIy61XLo6Wj
         E9LZSz9F8vAbI8TGB3eARPjw09HmRv6WgGrkMB5okdaxcUv+mSYwq2qhhUAn7pohDWEN
         PrxG78IFz+2mpa1g0U9as5lA1iAtZ9ya6lWSpEMzsbJ6vUwyWM9ZCNNmrLASYxpOjav4
         FvFbzpD63lMBErKt+paYjtQ5I2pTubTtKEH3S3xFaasMKE8Ssdyh1XHZ2/nJ2xrMYb+M
         1auQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google; t=1788869385; x=1789474185; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PefKymn7jgC5WY6NyYQ0JmmpZCQ7mukFjWFiljDO8jU=;
        b=Qt+hoKfqcoQtx84nbOTksra6lZPCcOzZnan9r37ov2z3uKwSmuxbsK7YXoxcpQC4vi
         Shi50g2roGJZvVdT3ZiaJpB5jjtIDNdw4/1RoIDDs1gg/HfCA2vKNHPgoNhM0IGD8Qzw
         kA13K+uXTcStb4dYmdE1w2vzkvkZzadm5dZi2lE6g8jAcbX4R92L/wnT+vWri6eUZ2Hw
         3Mn9P90maJKcJvvkCNZ82V8xcRRsxwtJ77oYB+Vcf+zXv3pQmlv6FfOo5l8tnBje6Nwa
         PtYAuja6ydUVGXCEHwce2y8Xxzaup9NuaXZXyNU+zUf4n8nQ7R5OCWY18fw11h2zc8DF
         btLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788869385; x=1789474185;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PefKymn7jgC5WY6NyYQ0JmmpZCQ7mukFjWFiljDO8jU=;
        b=BhuKaqfBhEqbJf6NhX34BCanlzSPykqvTy56Rlap6fksKvcS6A+NMo96iLbLQhRBvv
         AvGA8ErLmN8YhHiKYTuD3bt6USkaeeoWyxQYxh4WZF4WA3GKbtL6xVSleLkTo8KwVB+Y
         62bqJY66g5IC4894ydDIBtvahTywjO2s6uSKqng3H7hSVEt9NkNt8cPkaq8twiPYYmyH
         4jvY+67RR42RTziB5GVyhUEhXIVOPw+zBU3qnFuKhhvSlNyHZp6PyEZd+DjiWkqtiEW8
         bHxBZF88EcEbnxaDmV1OYppROo4K24MSOmWxUWOjGEJOmmOUdXL19B5zXfo6RJJ06TZP
         83Hw==
X-Forwarded-Encrypted: i=1; AKwUvBwxIP2frQbPwOc8ukUCIUixJyDRwTOaa8gkjNuWOMAeWt9hccTLVzlLxSd+5Syjltz/SkvAyGqhFz/Uqw==@vger.kernel.org
X-Gm-Message-State: AFuF++mJ8q732cTO0wC32f3EAjUnE7EBNWVC9/KAVVeTUjs44aaNUFWI
	H6oF0lGZ1qgCbeLY/rt9500pEoh8WojeokyxMehqucWpwfO4AmvS4oUc9+nTNN+XpB6P6yBks6o
	2BIlu9OYURr2/ZAiXnFOQSWDXNDKII7ozaklNXyljbA==
X-Gm-Gg: AYBFou2aoEmQZjZMLLd2wpR2+Gvb+LFnfM440gxtifX5rAfWb8Vi2quPrrA6Exa/yxQ
	oh0W/tdYIOsokggBludTYeO2kM1oUTHT9IHVLGjwrpqyHgcENT+bUBbz58/eRhQy7KuALwk5Fot
	7ZCiEa3QKgMH7mE7vTLZl1SJ17kU/+ujX4VNvk9Qro1BLeo6IUvCYCmnPX6Rvb/bfXC1fjvLfUT
	YTtElf/N7mhC2ZcaBDYgPq+CuYasINFwoppmwJF7+flaz8I3yBTvhQ5TL4kVAtay3/8xwKFep0F
	PeAs7Xx8kPwb7PbMvMi+uOtwPGD180jBT5HqloDxeCWMxQ7aJnK49kV7mIZUQNUfhEE3hMXZ5JV
	8yw==
X-Received: by 2002:a05:6512:685:b0:5b1:5b9e:8de7 with SMTP id
 2adb3069b0e04-5b74d4a1e12mr3482883e87.2.1788869385271; Tue, 08 Sep 2026
 05:09:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907133929.1081540-1-jinpu.wang@ionos.com> <e6ad5b61-0ba2-49fa-96c7-e821defe45a7@linux.ibm.com>
In-Reply-To: <e6ad5b61-0ba2-49fa-96c7-e821defe45a7@linux.ibm.com>
From: Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date: Tue, 8 Sep 2026 14:09:34 +0200
X-Gm-Features: AcwNN1U2iOQYTURcbTVr1V8rB1u1VFRTDYmlDknJP-KrtCTYHpaGssRgF2ookTE
Message-ID: <CAMGffEmKrqcxYAtdTxg6GnwwFjJJg50wxpTfBobps-_QwQAoGg@mail.gmail.com>
Subject: Re: [PATCH 0/6] md: don't wait for q->limits_lock while md holds back I/O
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: abd.masalkhi@gmail.com, linux-raid <linux-raid@vger.kernel.org>, 
	linux-block <linux-block@vger.kernel.org>, Song Liu <song@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>, 
	Yu Kuai <yukuai@fygo.io>, tom.leiming@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 1:16=E2=80=AFPM Nilay Shroff <nilay@linux.ibm.com> w=
rote:
>
> On 9/7/26 7:09 PM, Jack Wang wrote:
> > From: Jack Wang<jinpu.wang@cloud.ionos.com>
> >
> > Writing to a queue limits attribute of an md array while a spare is
> > being re-added deadlocks the array.  I reported this earlier here:
> >
> >    https://lore.kernel.org/linux-raid/CAMGffE=3DheGA3y8FjQ0Sm1jj-kd-=3D=
H9Y54WozKASSEZhc9UNKjA@mail.gmail.com/
> >
> > Four tasks, one array:
> >
> >    udev-worker    queue_attr_store() holds q->limits_lock, waits in
> >                   blk_mq_freeze_queue() for q_usage_counter to drain
> >    fio            holds a q_usage_counter reference, parked in
> >                   md_handle_request()'s is_suspended() loop
> >    mdadm          suspended the array, waits for reconfig_mutex
> >    md_start_sync  holds reconfig_mutex, waits for q->limits_lock
> >
> > The last leg is mddev_stack_new_rdev() from ->hot_add_disk().  Since
> > commit c99f66e4084a ("block: fix queue freeze vs limits lock order in
> > sysfs store methods") the sysfs store holds q->limits_lock across the
> > freeze, so md must not block on that lock while it is holding back the
> > I/O the freeze waits for.  That is the same hazard mddev_suspend()
> > already documents for reconfig_mutex.
> >
> > The rule this series applies is that q->limits_lock nests outside both
> > reconfig_mutex and the suspend.  Where md cannot arrange that, because
> > it is called with reconfig_mutex already held or from the sync thread,
> > it takes the update with a trylock and does without one on a contended
> > pass.
> >
> > Patches 1, 2 and 4 are plumbing with no functional change.  Patches 3
> > and 5 convert the two callers that cannot own an update.  Patch 6 does
> > the hoists, all in one patch because a mix of the two lock orders is an
> > ABBA.
> >
> > Two callers still take q->limits_lock inside reconfig_mutex, both with
> > the array suspended, and patch 6 says why: ->start_reshape() from
> > action_store(), which suspends before flushing sync_work, and
> > raid*_run() -> queue_limits_set() from level_store(), which already
> > hangs on its own because it freezes the queue while suspended.  Both
> > need more restructuring than belongs here.
> >
> > The patches are based on v7.3-rc2.
> >
> > Tested there with a raid1 of two ram devices, fio in flight and a loop
> > writing queue/max_sectors_kb: 20 fail/remove/add cycles complete,
> > where the same test wedges the array before the series.  Every patch
> > builds on its own.  A reshape and a level change are not covered by tha=
t
> > test.
>
> Overall, I think the direction looks good. With this series, we now have =
the
> locking order where q->limits_lock is acquired before the suspend and
> reconfig_mutex.
>
> However, when I ran these changes through blktests, I hit the lockdep spl=
at[1],
> which exposes an ABBA dependency between disk->open_mutex and q->limits_l=
ock.
>
> Looking at the existing dependency chain, disk->open_mutex is expected to
> be acquired before q->limits_lock. However, with this change, md_ioctl()
> acquires q->limits_lock first and subsequently reaches md_import_device()=
,
> which acquires disk->open_mutex. This reverses the existing lock ordering
> and introduces the ABBA dependency, so I think this needs to be addressed=
.
>

Thanks for running this through blktests.

You are right, and it is worse than the one path you hit.  The import is
not the only offender: everything in the mddev->pers branch of
md_add_new_disk() that opens or closes a component device runs with
q->limits_lock held.  Besides md_import_device() there are four
export_rdev() calls and one md_kick_rdev_from_array(), and export_rdev()
ends in fput(rdev->bdev_file), so it takes disk->open_mutex too.
rdev_attr_store() looks like a second instance: it starts the update for
every state_store() write, and "remove" reaches
md_kick_rdev_from_array().

So the rule needs to be stronger than what I wrote: q->limits_lock nests
outside reconfig_mutex and the suspend, and must not be held across any
component device open or close.

Two ways to get there, and I would rather hear which you prefer before
respinning:

1) Keep the lock outermost, move the open and close out from under it.
   md_ioctl() imports before taking q->limits_lock and releases after
   committing and unlocking; md_add_new_disk() hands the rdev back
   instead of exporting it.  The import then runs without
   reconfig_mutex, so the superblock format fields need a snapshot and a
   recheck under the lock.  Only the mddev->pers branch needs this, the
   other two never reach add_bound_rdev().

2) Drop the hoist for ADD_NEW_DISK and stack the leg after resume, with
   q->limits_lock on its own.  Much smaller, but the leg is live before
   its limits are stacked and the integrity rejection lands after the
   add rather than before it.

Is there a better option?  If ->hot_add_disk() is meant to be callable
with an update already in flight, that limits how far the open and close
can move.

Thanks,
Jack
