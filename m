Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792779676;
	b=b1xCl+8MQUWcrnO1DLjzv/iB1NOFznENZQL36nup1Cq34j4Xaih/s3FDw1dfXORg+EEx
	 QKk5vQ6NtuNkloEZtAB9u8r604uQUREaN02trEPL3IWfEks7+ZHA8kZ3i7mTKwkU6gQDv
	 5+DKLcJyRB6y4wHTjCFgmssSUl34D9LVoKapI/piRrush2xytc4wmAc8kSfJe2ZpR/J5M
	 U6Aoq6kY21QwFRbY7Yi85VGU6cQztj5+KbOyQk0kI/Mp0jInFV6qxc9iZEliEYif67dgk
	 GqXFifAakXWwrxNBGroowCMvqY8Euq23QBbEB7dfUsqyiTA0263G+jxRLdwsfBpe6QA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792779676;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=JPXYTcb2GVIpXeWLwsxVi5QbrL0t2UUrrpmBeD3Y8TQ=;
	b=mQVS3RiYIw25pBlz9bc8t6cKzws+kx0o0qF2HcSUK2EyPULwJHLGgN1dVtRNlaPrC5ns
	 G7xHbDB21UzM3ck10dO9OZ4/smlgiGnzeEiWAiX7wMijrzNaZhaPfMH1A/CzolVLVKYdS
	 MgKFJ6JOD2foei8dLupUxUql+IVjPKaxHk4FfUCCkNGAPPVdbjTWfLVccKY7WVRrqPo8o
	 PHmHp9FzsfmT6/wvLIWmZ+ygNhnPyRwV934Sv0RdseAZU8yqW3CwxsOiCSNKbBs9HD70F
	 TYUJ8DRFu8L6LdEWe9mNLZEJOWa8heyyVUFDyTnLgYi1S/Tbi3XuGEkzyOqedtPJwzw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloud.ionos.com;
	spf=pass smtp.mailfrom=ionos.com;
	dkim=pass header.d=cloud.ionos.com header.i=@cloud.ionos.com header.a=rsa-sha256 header.s=google header.b=jPVbTySp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.44
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B004D606A325
	for <linux-block@vger.kernel.org>; Fri, 23 Oct 2026 18:21:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B004D606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cloud.ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.a=rsa-sha256 header.s=google header.b=jPVbTySp
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c3fae9338f0so15457866b.2
        for <linux-block@vger.kernel.org>; Fri, 23 Oct 2026 11:21:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792779674; cv=none;
        d=google.com; s=arc-20260327;
        b=pt8NCk28XWMtqaFo/LNEXwnF8Xgilqpgdhx54KxvawQQJghGHtS1qTjB6WHOG+XGoN
         DgnUVXGx0+XE5OVlUIz64PjhTOnzlxPXUBb/fujCF5jTu4H7MKuyQw4WRo9CCQ6CnuzY
         v3CIo079Y/+SMeMaMnWUW4hk7+UhbuhQ8qGyn5GikRHp12wy+ds4nOKXRBftud7Wil/t
         gLlZoWZp3nPV03azFYJ9h8l7NarNsWtw1LbD2N/CBXrttPzdA021LYtQk83W9M64CkmY
         swBbRu5WBu+fJ9TOF5PACxiSa0Jr0CbhmM55nxAAzawFJBCMk52Vei4wFM+S82ecnvEa
         Jbmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JPXYTcb2GVIpXeWLwsxVi5QbrL0t2UUrrpmBeD3Y8TQ=;
        fh=I/IJ9mf4bIEWB174LeitmmPe/CGIhkeOr3W21wM4/pQ=;
        b=AJ0YXfktZsQkYkeHxlNGsfZV2C9M0zqvENKOyWP757XGYQp+l627vWJoBbmCpKCP6t
         SQNBh9/pTxVNwHV5bWYnSVsVQFSPvatKmJ5A/hTTOXOyrRvBhvFlnaz3lxyoywXcJQcX
         FD1iV27VXz6JWEGjfuUGO3Rwzkgv64qANRXUUuYpIpVI+hvalYzdqV1vo/Yo6CRdw1Pt
         hAS5tMJJs7oMTuvOkf0eeAHBw2nki/WHzyZIts9bymQaNDQchKW66V2heh9BJCvdhSDO
         g+p6TgZOwywKHeUc6xJRT28U4fcyOye3oXcfOGGDfuCFHSFhFhVs/oDPhSLlTxuRDCaq
         Y3Eg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google; t=1792779674; x=1793384474; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JPXYTcb2GVIpXeWLwsxVi5QbrL0t2UUrrpmBeD3Y8TQ=;
        b=jPVbTySpKu9bZwpJjjiHg6fWlvq4ipOGD42e9huBV/TtiWterg17v+cdPrZn3MRa7T
         GwwYEbO4nFeltQ9kAj0QDov6NtWoR1H4CmtvcGP7qz5XwCGvsBLsEUo0vI+80p6AOWJY
         xojMxYAmpVyO6EPl59ZMkh6oteNu4blWQTCqH32R+JykOQSJwJHb9AlZMt49GKljBcgy
         5kgQc9pj7uTGSqN60A3M2VpP7CJsUH4N5r1TuHN0R2KDy5mC23gAWIzkHg+2C7HpPGbl
         Ei2eqaznzgYMGG5B9fXLf5srIPoENLvio3e7y8rILDgzMvMRoKgRn5Wmf+Mu9OsMgCgL
         HoHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792779674; x=1793384474;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JPXYTcb2GVIpXeWLwsxVi5QbrL0t2UUrrpmBeD3Y8TQ=;
        b=Vvvi3gLvwNukCx+OXfwvT3+2caTs7lb5UbdeGWIQVVYZi0LI8mRvM5hie8NI+eeeO4
         d9gXFIxn7LCsodSfRZy8y9GRB1sQLXGlNpsTRWn0bvwnbL1IqC3TWCQqkcm1+wuimw8p
         rwZhuFHQMzCHH+EDSNpWLI+AQ6iORAE7uB7Hy6KJ5ox9MT+80iAstCksVW6HkjMEhi6h
         rTZxtEPkbyEqbaPJKmwNU0JPFp+oDVnihu3o/0842aLEwQ+auxre6h+G0djWKvv//J7G
         pR3IZyOdOEW8sFlaaxqVtSBP6NJcb5gKVqiV7IAj7ThpC2KupQKo7QGpKmyYlHAhR+Tv
         KTAQ==
X-Forwarded-Encrypted: i=1; AKwUvBzGOfpX75jX0+xPRUbx3huhkxe2z4HTtp6fg+WgaA4rTo59VE3+m1D9MttxJGYL3lyHaJO/WCEv8pXkQg==@vger.kernel.org
X-Gm-Message-State: AFq9FYIcasv/fWBqY2ir04bA7Gwq/50BLiGXzeMV05ztxkh5wRiOLqKN
	nHA/7wkNppAdymcXpiny26PEgxf+XZklT3rcfBia+A7TJ8N8PHLhfy1Dsc332PTVl065t40zIa3
	ZC/BuwlMqIdHWMOU6dvU2Lkab5wlXuvKuRdD4CR/bVw==
X-Gm-Gg: AYBFou2ZUIf2OdCWk61INLBLfH8MaX9/kJbux7yqwLeE8Grmwj241PVWtj3HzKYK9bj
	v+w2FuyqGdjMJNP7A7UUyowok4OQT72lrdEFJei5m0+pohL49isr0oE9VJwN7PiyF9Qbub52SP1
	FapUi0GLKmoStRp+SzwM9aFtPjQaBtxq/D0ra/n7uaWSn1K1dXe1OTK2lkl+ro/TLwGZVaMyvuf
	a6gnnS2h+sr4LYfhVTE0zi0o1VhkT5Nkea+2MbFK2VLPVvdIeh41eZ4xx+FA368LAx2wKf+gAMw
	kNG/+3uZOz+vYEe7ca1ZwmnXCBkYj0EqmSbzAlF1GxbSW8OTuFkJQV5QNRnNVf8ROCRVq3fkBd0
	XvqpaN10SIJvZPUQyzhfOuB4m5ntkjylCEsQ1MJhi52XIkn5lPzKS7wfks7u+dq1MxDa4Wg==
X-Received: by 2002:a17:906:560d:b0:c25:2ded:ad36 with SMTP id
 a640c23a62f3a-c46a8e5e8famr381988966b.0.1792779674049; Fri, 23 Oct 2026
 11:21:14 -0700 (PDT)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260910081114.1605746-1-jinpu.wang@ionos.com> <e2c36f31-d198-40a7-a18d-156e1fd6fbb2@fygo.io>
In-Reply-To: <e2c36f31-d198-40a7-a18d-156e1fd6fbb2@fygo.io>
From: Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date: Fri, 23 Oct 2026 20:21:00 +0200
X-Gm-Features: AclHuK95vt0fwIpK5hKjjmZvyy0BYIwu-sPwB35kyz_hWeMoZZCxGN2pFtQZ1y8
Message-ID: <CAMGffE=LF4o0to7teb_k1i7H1FhhvfEs5ntDG8JfumS0fWPQRw@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] md: don't wait for q->limits_lock while md holds
 back I/O
To: yukuai@fygo.io
Cc: Song Liu <song@kernel.org>, linux-raid@vger.kernel.org, 
	Nilay Shroff <nilay@linux.ibm.com>, abd.masalkhi@gmail.com, linux-block@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>, 
	Ming Lei <tom.leiming@gmail.com>, Xiao Ni <xiao@kernel.org>, 
	Li Nan <magiclinan@didiglobal.com>, Mike Snitzer <snitzer@kernel.org>, 
	Mikulas Patocka <mpatocka@redhat.com>, dm-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kuai,

On Tue, Oct 20, 2026 at 8:57=E2=80=AFAM yu kuai <yukuai@fygo.io> wrote:
>
> Hi,
>
> =E5=9C=A8 2026/9/10 16:11, Jack Wang =E5=86=99=E9=81=93:
> > From: Jack Wang <jinpu.wang@cloud.ionos.com>
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
>
> Sorry for the delay, usually blk_mq_freeze_queue() is useless for bio-bas=
ed
> disks, because it can't guarantee inflight BIOs to drain. So this looks l=
ike
> a long term problem since queue_attr_store() can still update limits whil=
e
> there can still be bios inflight.
>
> >    fio            holds a q_usage_counter reference, parked in
> >                   md_handle_request()'s is_suspended() loop
> >    mdadm          suspended the array, waits for reconfig_mutex
> >    md_start_sync  holds reconfig_mutex, waits for q->limits_lock
>
> And this deadlock looks related to blk_mq_freeze_queue() concurrent with
> mddev_suspend(), hence there can be bio blocked between. So I think there
> can be a simpler solution for this deadlock.
>
> 1) either remove the blk_mq_freeze_queue() from limits update for mdraid,=
 or
> 2) also add blk_mq_freeze_queue() to mddev_suspend().
>
> If this is a mdraid specific problem, I'll suggest 2). If there are other
> bio-based drivers have the same problem, we might what to replace
> blk_mq_freeze_queue() with driver's bio suspend to fix that limits can
> update with inflight bios as well.
Thanks for the suggestion, will look into it back from vacation. Yes,
it's a MDraid specific problem.
>
> >
> > The last leg is mddev_stack_new_rdev() from ->hot_add_disk().  Since
> > commit c99f66e4084a ("block: fix queue freeze vs limits lock order in
> > sysfs store methods") the sysfs store holds q->limits_lock across the
> > freeze, so md must not block on that lock while it is holding back the
> > I/O the freeze waits for.  That is the same hazard mddev_suspend()
> > already documents for reconfig_mutex.
> >
> > v1 kept q->limits_lock outermost where it could and used a trylock
> > everywhere else.  Christoph asked for the lock ordering to be fixed
> > instead, so v2 drops the trylock and the block patch that added it.
> >
> > The rule v2 applies is that q->limits_lock nests outside reconfig_mutex
> > and the suspend everywhere, with no exceptions to paper over.  The two
> > callers that cannot own an update do not need one: check_sb_changes()
> > and md_check_recovery() only ever re-add a device that is already a
> > member, so its limits are stacked and the update is a refresh, and they
> > now take the no-stack path unconditionally.  mddev_update_io_opt() is
> > not an add and does need the update, so patch 4 defers it to a work
> > item that takes the lock with nothing held.
> >
> > Making the hoists unconditional exposed a second cycle that the trylock
> > had been hiding, which Nilay hit with lockdep on v1:
> >
> >    q->limits_lock -> reconfig_mutex        added by this series
> >    reconfig_mutex -> disk->open_mutex      pre-existing, md opens legs
> >                                            under reconfig_mutex
> >    disk->open_mutex -> q->limits_lock      pre-existing, sd_open() ->
> >                                            sd_revalidate_disk()
> >
> > Only the middle edge can go, so legs are now opened before any md lock
> > is taken.  Patch 7 does the opens and patch 8 the holder links, which
> > take disk->open_mutex too and were easy to miss because the release
> > side only takes blk_holder_mutex.  Opening without reconfig_mutex means
> > the superblock format fields have to be snapshotted and rechecked once
> > the array is locked.
> >
> > Patches 1, 3 and 6 are plumbing with no functional change.
> >
> > Two callers still take q->limits_lock inside reconfig_mutex, both with
> > the array suspended, and patch 5 says why: ->start_reshape() from
> > action_store(), which suspends before flushing sync_work, and
> > raid*_run() -> queue_limits_set() from level_store(), which already
> > hangs on its own because it freezes the queue while suspended.  Both
> > need more restructuring than belongs here.
> >
> > The patches are based on v7.3-rc2.
> >
> > v1: https://lore.kernel.org/linux-raid/20260909063029.GC29874@lst.de/T/=
#t
> >
> > Changes since v1:
> >   - Drop the trylock and the block patch adding
> >     queue_limits_start_update_trylock(), per Christoph.
> >   - check_sb_changes() and md_check_recovery() take the no-stack path
> >     unconditionally instead of trying the lock first.
> >   - Defer the io_opt update to a work item rather than skipping it on a
> >     contended pass (patch 4, was "md: don't wait for q->limits_lock in
> >     mddev_update_io_opt()").
> >   - New patches 6-8 to close the reconfig_mutex -> disk->open_mutex
> >     edge that lockdep reported on v1: pass a queue_limits through
> >     ->run(), open new legs before locking the array, and link their
> >     holders there too.
> >   - Rebased on v7.3-rc2.
> >
> > Testing, on v7.3-rc2 with lockdep (PROVE_LOCKING, DEBUG_LOCK_ALLOC):
> >
> >   - the reproducer below, 20 fail/remove/add cycles with fio in flight
> >     and a loop writing queue/max_sectors_kb, where the same test wedges
> >     the array before the series
> >   - array start at raid0, raid1, raid5, raid10 and linear, spare add,
> >     fail and remove, the rdev sysfs stores, ADD_NEW_DISK, array_state
> >     transitions, a level change and a raid5 3 -> 4 reshape to
> >     completion, which is what exercises patch 4's work item: io_opt
> >     goes from 1048576 to 1572864 once end_reshape() runs
> >   - HOT_ADD_DISK of an undersized leg, so bind_rdev_to_array() fails
> >     and patch 8's release path runs
> >
> > No lockdep reports, and debug_locks stayed 1 throughout.  Every patch
> > builds on its own.
> >
> > A blktests case covering this deadlock will be sent separately.
> >
> > The reproducer, for anyone who wants it:
> >
> >    mdadm -C /dev/md111 --force -e 1.2 --assume-clean -l 1 \
> >          --bitmap=3Dinternal -n 2 /dev/ram0 /dev/ram1
> >
> >    fio --direct=3D1 --rw=3Drandrw --ioengine=3Dlibaio --iodepth=3D32 --=
numjobs=3D4 \
> >        --time_based=3D1 --runtime=3D180 --filename=3D/dev/md111 --name=
=3Drepro &
> >
> >    while :; do
> >        echo 128 > /sys/block/md111/queue/max_sectors_kb 2>/dev/null
> >    done &
> >
> >    for i in $(seq 20); do
> >        mdadm /dev/md111 --fail /dev/ram0
> >        mdadm /dev/md111 --remove /dev/ram0
> >        mdadm /dev/md111 --add /dev/ram0
> >        mdadm --wait /dev/md111
> >    done
> >
> > Jack Wang (8):
> >    md: pass a queue_limits down to ->hot_add_disk()
> >    md: don't wait for q->limits_lock in check_sb_changes()
> >    md: pass a queue_limits through the rdev sysfs stores
> >    md: defer the io_opt update out of the sync thread
> >    md: take q->limits_lock before locking and suspending the array
> >    md: pass a queue_limits through ->run()
> >    md: open new legs before locking the array
> >    md: link a new leg's holder before locking the array
> >
> >   drivers/md/dm-raid.c       |   4 +-
> >   drivers/md/md-autodetect.c |  38 ++-
> >   drivers/md/md-linear.c     |  30 +-
> >   drivers/md/md.c            | 661 +++++++++++++++++++++++++++++-------=
-
> >   drivers/md/md.h            |  56 +++-
> >   drivers/md/raid0.c         |  16 +-
> >   drivers/md/raid1.c         |  26 +-
> >   drivers/md/raid10.c        |  37 ++-
> >   drivers/md/raid5.c         |  54 ++-
> >   9 files changed, 741 insertions(+), 181 deletions(-)
> >
> --
> Thanks,
> Kuai
