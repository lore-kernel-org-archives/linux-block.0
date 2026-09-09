Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0C42E1F0E
	for <linux-block@vger.kernel.org>; Wed,  9 Sep 2026 04:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788927932; cv=pass; b=lqRg62aVkOGYbAYJtJaHzo8qp+OBnlKaG9xV2Ef6DXWmRr1HDzMVD43DbOaMIATossd0BUWP4jGJYsL+UUrQSXqiSV305GQIUiRSPs6ct7FHngvbqmlPGaavdeKiPKmsHw3LgTdTK9A6lpUQM3xoI+MOevsGzNKPBCbhu7aGD6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788927932; c=relaxed/simple;
	bh=8LD5re1/e/VXhhIz4/uBoAjsbIt2rZOv6XNdD5YGmjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FcDL8KVbkJBHgUTJ9g6mOL7yl5kjOojlB2CJE8ST8Zi5WwZP/DXzWeXPJVbZ4yvMwLgvfwextsd17pTZ/AhHknvbAs613YH/zIaonqSCF77wVwZqZVUxKjHeHpl5FBaH0lDgBFWPg86jX0myRHhry1p73yKZeKmrW+l6TayZCn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cloud.ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b=cOc9FAa/; arc=pass smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cloud.ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="cOc9FAa/"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c255a6e63c0so75456466b.3
        for <linux-block@vger.kernel.org>; Tue, 08 Sep 2026 21:25:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788927928; cv=none;
        d=google.com; s=arc-20260327;
        b=KS5zwNcjYrOEZl+60E74LdvAWPYdl4bVezGLLHQXXxjaFDcJUVSqnDrGqXO6tYM4fO
         Rr0spKDYwQ8XLzbcijjNw2vnnvCXMr05fCl1Un+bDz6ncZGRr+NVeVv4WJjskL+YYSxQ
         ghlOb/CYJnUgUMfTqZWZE4lnkI4vsUxcBYPIWdvCTqdfL9lIMjfOfZTyOdaU10pXKbCF
         1NhWcbmBiKrrT7iT9yPYeiuIpa8RHSzCqmrM7kNPJEpRbcie50Aa6lSu/9EHBRXvWXGj
         ltsKbCbZIUIPMmwL138yHjqGYSWbx6jcBsq81SMLaZMEmV9CimQf0BO82SSYj76XIi2y
         f2yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pBR2zFcxFIaiYMBPMX5WHD5bjtSb/aPSMgyf/tdWhjE=;
        fh=+72teV7wvPm2/eXJ6WUFrl2FPS6QNKWaDtuWfeMu3Dw=;
        b=Sd4R2AIpQWZtZQremT50fU+4Mm2XApaEpADzrls/fD+NbNzytdN0M2vK4odRyW7CdE
         rjBi0ZWRi9q8c+Tl3xIe585kX4iA2a0+ZqwRCZZtOP9LtJ7GQm2ZX8YbmCss/0a4C+/L
         vYQm9eVrOIQN96QunHXlel0eAQpCodq4WEYQKCIV0kK6D5E5pFwOoVuKxnG+/zQDzyKW
         zZnYh0Dra06/doTkGrMcR6XAaLydIyVmmKuXduDt6ha/7OoEaHzI01x0VDJySCPUB7K7
         55wuKQSgoidSjWKq8qM4KM/9/IBtJgIBDlGTkUk0sqt+UtWOUVZIpSm98Oip0Qmcf914
         3RIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google; t=1788927928; x=1789532728; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pBR2zFcxFIaiYMBPMX5WHD5bjtSb/aPSMgyf/tdWhjE=;
        b=cOc9FAa/VGa32LFlIcXlnsp5XGVHEjropZklAC7D0hRjrRMymKA8fi1do9v0m83ks6
         TDQmK4PkjzDGrGJbAieyT3T5Tw4h+whRw629Ttwwh0KUwiZgfOk5dpTUCCtEyICexily
         2R8guAz2p902d2UTcooYyP0xnmrD2oV7lAiH1rgYI8TNUxHUdg/NHmSy0bGS2BvhXhRq
         GXCgkODXZsXNUoliYNd7Aru7zOYgUChBNJtTZepQ9LQPkvKTxW5Ntr3mmK7L5P1KmxgC
         n/HI+VQn4q39zIcp82WZT6bFb5tTmNm2uqe1rcZXjYYK4piQKTGBzb/SkDKoNWqY1qEv
         Airg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788927928; x=1789532728;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pBR2zFcxFIaiYMBPMX5WHD5bjtSb/aPSMgyf/tdWhjE=;
        b=kyrHY6eDqE8DUsGaM6BOGul9a0r4ootJMJF0hCUa6siFU1zys+mbWXy7ZmIpYuCFGh
         Ugl88vrb2r3z5H62Fr30ed/UixCj69x5u8dj+gURGeG5GqxH3cE9E8G/MGtuFM7ezR9m
         NcH0ouwzge+/enuEm7IttLE1m8klZIKqvlHLCAHVso0g+ZD/h2D8/eOzDZMGPh9kNtEN
         +3O/H9ngRPPgqPczbiKauqnXbS7Laf7y1qK+WuEwUEFwVI2AwCxdxxzqZ+mdwRVAdCGi
         3Aw4y1LHgH8WC/p8inXNkTtRL2hNNIs054UerQp1J50LNPlXC01bl2fBGNdJAX1D0EFh
         AKDA==
X-Forwarded-Encrypted: i=1; AKwUvBwrDST61AORQwyaTX2w9y+PPFjPBO0/u7ioem4kJtz9PY48Kmv96OfjW3FEyPPGd/au6s5GezZOlAs/fg==@vger.kernel.org
X-Gm-Message-State: AFuF++nFejLVYSyKiC5wr5il8627CYJyK5m7bPKqiOR6EFbRo0jc1fuJ
	UqWi9Aq8YMmMZkSLyBEjlQtLa2iHlkqiBGdvK6X99ZODZTlq0yH3o2XCDHXC/sZsZ7vTXFZeCIe
	m3bba6fTDtunlTWmpH6kvfx41Q81yOkuFCjO9mFhlng==
X-Gm-Gg: AYBFou1vjBY84M5HK85pRr13m/O860AikkTlflkT+agDZt8uUxYX1869iYzrT7bzHSn
	7QwJm1gNzQcNylBncA6gZWAaP0Fd2L45WZDu2SQs5wEUdtHLEEg6wOWTr6FiXwJomoYnNcpTVlm
	V1mmSavoQpRIr0NAbpuhH2g2i8lDfZWFAHg8lXyapjB+BlgMkTRDAQjFLyXmcMCNBdOecEH+ajD
	mcQgCzaEpjsnO+ovRATWQPz+B5OZOFf/Lqfwr+Ex9we7eP+o1UpSlHI5gc4VTebaiuaE0apnWfC
	BK/mHpLnKSYWIaTATOf/7UqMXVXLJPWYv+KUr052957oxvR4Pv6y60dfyGqAYq7RHvbRxG0hRkP
	DvEaikc/gp20=
X-Received: by 2002:a17:907:7209:b0:c16:604a:b2bd with SMTP id
 a640c23a62f3a-c261277db4fmr1206852466b.3.1788927927980; Tue, 08 Sep 2026
 21:25:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907133929.1081540-1-jinpu.wang@ionos.com>
 <e6ad5b61-0ba2-49fa-96c7-e821defe45a7@linux.ibm.com> <CAMGffEmKrqcxYAtdTxg6GnwwFjJJg50wxpTfBobps-_QwQAoGg@mail.gmail.com>
 <70108fa1-d290-44d9-966f-b50a220562cf@linux.ibm.com>
In-Reply-To: <70108fa1-d290-44d9-966f-b50a220562cf@linux.ibm.com>
From: Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date: Wed, 9 Sep 2026 06:25:17 +0200
X-Gm-Features: AcwNN1UZF2H9siDmY3Me-ZEVavX0EUJy-lBGXeIL8DJQ3YFPnsqKoDAsM1am024
Message-ID: <CAMGffEmvkxyczyPhBTSLkU1yB8_h2B=ytMDFpXOfzqMvN53EJA@mail.gmail.com>
Subject: Re: [PATCH 0/6] md: don't wait for q->limits_lock while md holds back I/O
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: abd.masalkhi@gmail.com, linux-raid <linux-raid@vger.kernel.org>, 
	linux-block <linux-block@vger.kernel.org>, Song Liu <song@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>, 
	Yu Kuai <yukuai@fygo.io>, tom.leiming@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 8:25=E2=80=AFPM Nilay Shroff <nilay@linux.ibm.com> w=
rote:
>
> On 9/8/26 5:39 PM, Jinpu Wang wrote:
> > On Tue, Sep 8, 2026 at 1:16=E2=80=AFPM Nilay Shroff <nilay@linux.ibm.co=
m> wrote:
> >>
> >> On 9/7/26 7:09 PM, Jack Wang wrote:
> >>> From: Jack Wang<jinpu.wang@cloud.ionos.com>
> >>>
> >>> Writing to a queue limits attribute of an md array while a spare is
> >>> being re-added deadlocks the array.  I reported this earlier here:
> >>>
> >>>     https://lore.kernel.org/linux-raid/CAMGffE=3DheGA3y8FjQ0Sm1jj-kd-=
=3DH9Y54WozKASSEZhc9UNKjA@mail.gmail.com/
> >>>
> >>> Four tasks, one array:
> >>>
> >>>     udev-worker    queue_attr_store() holds q->limits_lock, waits in
> >>>                    blk_mq_freeze_queue() for q_usage_counter to drain
> >>>     fio            holds a q_usage_counter reference, parked in
> >>>                    md_handle_request()'s is_suspended() loop
> >>>     mdadm          suspended the array, waits for reconfig_mutex
> >>>     md_start_sync  holds reconfig_mutex, waits for q->limits_lock
> >>>
> >>> The last leg is mddev_stack_new_rdev() from ->hot_add_disk().  Since
> >>> commit c99f66e4084a ("block: fix queue freeze vs limits lock order in
> >>> sysfs store methods") the sysfs store holds q->limits_lock across the
> >>> freeze, so md must not block on that lock while it is holding back th=
e
> >>> I/O the freeze waits for.  That is the same hazard mddev_suspend()
> >>> already documents for reconfig_mutex.
> >>>
> >>> The rule this series applies is that q->limits_lock nests outside bot=
h
> >>> reconfig_mutex and the suspend.  Where md cannot arrange that, becaus=
e
> >>> it is called with reconfig_mutex already held or from the sync thread=
,
> >>> it takes the update with a trylock and does without one on a contende=
d
> >>> pass.
> >>>
> >>> Patches 1, 2 and 4 are plumbing with no functional change.  Patches 3
> >>> and 5 convert the two callers that cannot own an update.  Patch 6 doe=
s
> >>> the hoists, all in one patch because a mix of the two lock orders is =
an
> >>> ABBA.
> >>>
> >>> Two callers still take q->limits_lock inside reconfig_mutex, both wit=
h
> >>> the array suspended, and patch 6 says why: ->start_reshape() from
> >>> action_store(), which suspends before flushing sync_work, and
> >>> raid*_run() -> queue_limits_set() from level_store(), which already
> >>> hangs on its own because it freezes the queue while suspended.  Both
> >>> need more restructuring than belongs here.
> >>>
> >>> The patches are based on v7.3-rc2.
> >>>
> >>> Tested there with a raid1 of two ram devices, fio in flight and a loo=
p
> >>> writing queue/max_sectors_kb: 20 fail/remove/add cycles complete,
> >>> where the same test wedges the array before the series.  Every patch
> >>> builds on its own.  A reshape and a level change are not covered by t=
hat
> >>> test.
> >>
> >> Overall, I think the direction looks good. With this series, we now ha=
ve the
> >> locking order where q->limits_lock is acquired before the suspend and
> >> reconfig_mutex.
> >>
> >> However, when I ran these changes through blktests, I hit the lockdep =
splat[1],
> >> which exposes an ABBA dependency between disk->open_mutex and q->limit=
s_lock.
> >>
> >> Looking at the existing dependency chain, disk->open_mutex is expected=
 to
> >> be acquired before q->limits_lock. However, with this change, md_ioctl=
()
> >> acquires q->limits_lock first and subsequently reaches md_import_devic=
e(),
> >> which acquires disk->open_mutex. This reverses the existing lock order=
ing
> >> and introduces the ABBA dependency, so I think this needs to be addres=
sed.
> >>
> >
> > Thanks for running this through blktests.
> >
> > You are right, and it is worse than the one path you hit.  The import i=
s
> > not the only offender: everything in the mddev->pers branch of
> > md_add_new_disk() that opens or closes a component device runs with
> > q->limits_lock held.  Besides md_import_device() there are four
> > export_rdev() calls and one md_kick_rdev_from_array(), and export_rdev(=
)
> > ends in fput(rdev->bdev_file), so it takes disk->open_mutex too.
> > rdev_attr_store() looks like a second instance: it starts the update fo=
r
> > every state_store() write, and "remove" reaches
> > md_kick_rdev_from_array().
> >
>
> I think fput() doesn't immediately release the blkdev, as the final __fpu=
t()
> is deferred through task work or delayed fput work. So that shouldn't be =
an
> issue here. Also, md_kick_rdev_from_array() defers the cleanup until
> mddev_unlock(). mddev_unlock() should be called after we release
> q->limits_lock, so this should not be an issue here.
Right. Both cases are not a real issue.
>
> > So the rule needs to be stronger than what I wrote: q->limits_lock nest=
s
> > outside reconfig_mutex and the suspend, and must not be held across any
> > component device open or close.
> >
> > Two ways to get there, and I would rather hear which you prefer before
> > respinning:
> >
> > 1) Keep the lock outermost, move the open and close out from under it.
> >     md_ioctl() imports before taking q->limits_lock and releases after
> >     committing and unlocking; md_add_new_disk() hands the rdev back
> >     instead of exporting it.  The import then runs without
> >     reconfig_mutex, so the superblock format fields need a snapshot and=
 a
> >     recheck under the lock.  Only the mddev->pers branch needs this, th=
e
> >     other two never reach add_bound_rdev().
> >
> > 2) Drop the hoist for ADD_NEW_DISK and stack the leg after resume, with
> >     q->limits_lock on its own.  Much smaller, but the leg is live befor=
e
> >     its limits are stacked and the integrity rejection lands after the
> >     add rather than before it.
> >
> > Is there a better option?  If ->hot_add_disk() is meant to be callable
> > with an update already in flight, that limits how far the open and clos=
e
> > can move.
>
> I think moving q->limits_lock after md_import_device() in the mddev->pers
> branch looks reasonable to me. This reduces code churn, and we can acquir=
e
> q->limits_lock after md_import_device() returns, before proceeding with
> the queue-limit update.
>
> We should also move the device suspend until after q->limits_lock is acqu=
ired
> for ADD_NEW_DISK, so that we maintain the intended ordering of q->limits_=
lock
> and suspend.
>
> This also ensures that q->limits_lock is not held across component-device
> open/import, avoiding the disk->open_mutex -> q->limits_lock dependency
> reversal reported by lockdep.
Will give it a try.
>
> Thanks,
> --Nilay
>
Thanks for the suggestion.
