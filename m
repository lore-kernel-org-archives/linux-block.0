Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A404968EF
	for <linux-block@vger.kernel.org>; Tue,  8 Sep 2026 21:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788904287; cv=none; b=YjPH5eQ71MvUPuVT2NlW8GuKt/Js6gP9wFvERRIlR2pZS2GwTspw0XD1RVaBY3Gbcb2K3B7+tSA++CZA1UmJmEFvDxoiajtMyyF+8Yvrn9jHno8x4NK1A3c+d6GWDwlVvFHs5OrV6PE88txN0CZBTHYL/IUGkX8/ot3/OCJ/W4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788904287; c=relaxed/simple;
	bh=J8NIUXH235BjHLdmjd1TPd6d3XKJDwKt+tj4mysuc1Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l4HM63j2qa2YB+jO9gnNt616gyWgFtqcNV0f4ewR8J774VuiY7XrfHZB8EX15kCgPgpjd628d0YkXRP42eomhO0rCpGBzZN51XIljWAjhYTKNegjkCn/oBc251T1HH7FUmfh+VuBy4NeJvlAtDWpNPzZXsP4jtXz62vLsYUB5H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iNyKB8pY; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iNyKB8pY"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd6185db7so9286235e9.1
        for <linux-block@vger.kernel.org>; Tue, 08 Sep 2026 14:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788904284; x=1789509084; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b61jzSC7TNpiw78jrl/y8kGZd3ujJNaiMpDuuM/2xN8=;
        b=iNyKB8pYA4qn16iO43rzF0/jqDsRE/Zi6oZFa+N59/V1MhOrnYr6Ho3ysi1qzeZnnp
         v2XgV7fa8SoFiYcuCqMqzaa9/roRoncAefQewJG1pcV1IgwenRQDGeW+jwZu1uKabDHh
         mEQcJeklCoypHXVUSy990gnQgV8xaPTFbroEz4+gtxQfu8AHAppWJo+a6o5euCMWTObD
         nIm5T7bT7bQ6h96TVSjgFexnCN5HNMG/ChIFMxC9tSLt4Nk7f6mVeHPz5uVOdctgKcwq
         7xPUvk3P2wBxbwE8+BhKlLjc6Dm/gZoHjTIl9bve6ywbmQnYiK6kbAyPpN3Iu8HHCKTJ
         0/jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788904284; x=1789509084;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b61jzSC7TNpiw78jrl/y8kGZd3ujJNaiMpDuuM/2xN8=;
        b=kNfnUGjlVRTDj/EOGNQSMjfUclsxkMidXw7aZyuZ6XlDk/0HQc73hkuwxs3QMEn8qA
         CyMD54+OproWqyAYi6WDuedOm84AIDfjJIAMJNpzmpAtfnRocu0ZJ6p2lqju4QwqG/xv
         NLmIMQexeqwrCHQUDrV2xsnIa2YAo6xm7b7JYq7CWqU5h9/kv+69D8WOQlUi/kXhHpEN
         JMfIrDqET2VQf4nshhHeQZkGhVzfcPkpnjM5eR5sjN61C5NBMZiYem72jorQZZ8iDjNX
         8FPnaR1hFnlpE+7vE99jMzyH2VAZii7XQ3RNZvLrGcfNlWnkBqiROCLDASEgGvZrVE7Q
         5bfw==
X-Forwarded-Encrypted: i=1; AKwUvBxdnmoakUkyfqjlFj0XBJLyVKiIrLegwJJSfR/ycMHgFCtd1h29LlYkPV9FQJuN0KB1Dlq5kQAMxBgfFA==@vger.kernel.org
X-Gm-Message-State: AFuF++na9Gf3NwzpLMbi5+7he8pl1dsXYzBEABhkGdNsMYPdHhvtmY8z
	v4FfETT6eZbCizyQK63A2Um4DnbDA8BSS8J3RVhCa3IowxaXD9BQVPvo
X-Gm-Gg: AYBFou0XH0ilXslw5xYDZ+ticPcQn7700tImI+Dan5SR1kiIPFpg5+vAkrkkYQtx3eY
	VHwuhqnmmnJKWxXSKgpEimDoWLwUcB1NnpGZk6WtXyR7Fp4mUd9IXN4wX1zWRR2jJMIqukoWWOe
	8NgKYXiPeBpIq46KsN2GhwPMd7Wq71vVJi5zBx+HYvug1pCQlshL51yM2MZ3b9hw8/dPtFiLdaW
	XUd7v1nOrb0Ly5EhqCTT3wQupT18L3IuUHJtyRB216TICYdYfchIl9wzXvuuh/zFxY1ftBC7+jA
	ZZJybkODGNzm08tF0fTclf/QhmPLSaiLnZYOIKED2S2h2cIIQFgwSZ3L3KImlR7norsfinAjPdC
	tGHGKUlYS6ezAUY0N0N7MZ0lLynCvsFn6ukcED54hgMaZg20P9TyvuFw6F/Wd2IK+T75vE5/DX/
	QAWhgf8RbJca240PsK4lyz5xLLBoOkBuylt1JlMKYtsYMZN5suvpES3D7j3GqmMRAXl3+e9bkyP
	tXnmNy/Dal5wMJAxcAKXO16CyTfxhs=
X-Received: by 2002:a05:600c:3145:b0:49c:f13e:e4c with SMTP id 5b1f17b1804b1-49d1757294bmr102701575e9.9.1788904284216;
        Tue, 08 Sep 2026 14:51:24 -0700 (PDT)
Received: from Abds-MacBook-Air.local ([2a02:3037:27d:11c4:a848:3f82:cb1b:ffe0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf772692dsm496596665e9.10.2026.09.08.14.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 14:51:23 -0700 (PDT)
From: Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>
To: Jinpu Wang <jinpu.wang@cloud.ionos.com>, Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-raid <linux-raid@vger.kernel.org>, linux-block
 <linux-block@vger.kernel.org>, Song Liu <song@kernel.org>, Jens Axboe
 <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Damien Le Moal
 <dlemoal@kernel.org>, Yu Kuai <yukuai@fygo.io>, tom.leiming@gmail.com
Subject: Re: [PATCH 0/6] md: don't wait for q->limits_lock while md holds
 back I/O
In-Reply-To: <m2bja7612z.fsf@gmail.com>
References: <20260907133929.1081540-1-jinpu.wang@ionos.com>
 <e6ad5b61-0ba2-49fa-96c7-e821defe45a7@linux.ibm.com>
 <CAMGffEmKrqcxYAtdTxg6GnwwFjJJg50wxpTfBobps-_QwQAoGg@mail.gmail.com>
 <m2bja7612z.fsf@gmail.com>
Date: Tue, 08 Sep 2026 23:51:20 +0200
Message-ID: <m28q5b5s4n.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 08, 2026 at 20:37 +0200, Abd-Alrhman Masalkhi wrote:
> Hi Jack and Nilay,
>
> On Tue, Sep 08, 2026 at 14:09 +0200, Jinpu Wang wrote:
>> On Tue, Sep 8, 2026 at 1:16=E2=80=AFPM Nilay Shroff <nilay@linux.ibm.com=
> wrote:
>>>
>>> On 9/7/26 7:09 PM, Jack Wang wrote:
>>> > From: Jack Wang<jinpu.wang@cloud.ionos.com>
>>> >
>>> > Writing to a queue limits attribute of an md array while a spare is
>>> > being re-added deadlocks the array.  I reported this earlier here:
>>> >
>>> >    https://lore.kernel.org/linux-raid/CAMGffE=3DheGA3y8FjQ0Sm1jj-kd-=
=3DH9Y54WozKASSEZhc9UNKjA@mail.gmail.com/
>>> >
>>> > Four tasks, one array:
>>> >
>>> >    udev-worker    queue_attr_store() holds q->limits_lock, waits in
>>> >                   blk_mq_freeze_queue() for q_usage_counter to drain
>>> >    fio            holds a q_usage_counter reference, parked in
>>> >                   md_handle_request()'s is_suspended() loop
>>> >    mdadm          suspended the array, waits for reconfig_mutex
>>> >    md_start_sync  holds reconfig_mutex, waits for q->limits_lock
>>> >
>>> > The last leg is mddev_stack_new_rdev() from ->hot_add_disk().  Since
>>> > commit c99f66e4084a ("block: fix queue freeze vs limits lock order in
>>> > sysfs store methods") the sysfs store holds q->limits_lock across the
>>> > freeze, so md must not block on that lock while it is holding back the
>>> > I/O the freeze waits for.  That is the same hazard mddev_suspend()
>>> > already documents for reconfig_mutex.
>>> >
>>> > The rule this series applies is that q->limits_lock nests outside both
>>> > reconfig_mutex and the suspend.  Where md cannot arrange that, because
>>> > it is called with reconfig_mutex already held or from the sync thread,
>>> > it takes the update with a trylock and does without one on a contended
>>> > pass.
>>> >
>>> > Patches 1, 2 and 4 are plumbing with no functional change.  Patches 3
>>> > and 5 convert the two callers that cannot own an update.  Patch 6 does
>>> > the hoists, all in one patch because a mix of the two lock orders is =
an
>>> > ABBA.
>>> >
>>> > Two callers still take q->limits_lock inside reconfig_mutex, both with
>>> > the array suspended, and patch 6 says why: ->start_reshape() from
>>> > action_store(), which suspends before flushing sync_work, and
>>> > raid*_run() -> queue_limits_set() from level_store(), which already
>>> > hangs on its own because it freezes the queue while suspended.  Both
>>> > need more restructuring than belongs here.
>>> >
>>> > The patches are based on v7.3-rc2.
>>> >
>>> > Tested there with a raid1 of two ram devices, fio in flight and a loop
>>> > writing queue/max_sectors_kb: 20 fail/remove/add cycles complete,
>>> > where the same test wedges the array before the series.  Every patch
>>> > builds on its own.  A reshape and a level change are not covered by t=
hat
>>> > test.
>>>
>>> Overall, I think the direction looks good. With this series, we now hav=
e the
>>> locking order where q->limits_lock is acquired before the suspend and
>>> reconfig_mutex.
>>>
>>> However, when I ran these changes through blktests, I hit the lockdep s=
plat[1],
>>> which exposes an ABBA dependency between disk->open_mutex and q->limits=
_lock.
>>>
>>> Looking at the existing dependency chain, disk->open_mutex is expected =
to
>>> be acquired before q->limits_lock. However, with this change, md_ioctl()
>>> acquires q->limits_lock first and subsequently reaches md_import_device=
(),
>>> which acquires disk->open_mutex. This reverses the existing lock orderi=
ng
>>> and introduces the ABBA dependency, so I think this needs to be address=
ed.
>>>
>>
>> Thanks for running this through blktests.
>>
>> You are right, and it is worse than the one path you hit.  The import is
>> not the only offender: everything in the mddev->pers branch of
>> md_add_new_disk() that opens or closes a component device runs with
>> q->limits_lock held.  Besides md_import_device() there are four
>> export_rdev() calls and one md_kick_rdev_from_array(), and export_rdev()
>> ends in fput(rdev->bdev_file), so it takes disk->open_mutex too.
>> rdev_attr_store() looks like a second instance: it starts the update for
>> every state_store() write, and "remove" reaches
>> md_kick_rdev_from_array().
>>
>> So the rule needs to be stronger than what I wrote: q->limits_lock nests
>> outside reconfig_mutex and the suspend, and must not be held across any
>> component device open or close.
>>
>> Two ways to get there, and I would rather hear which you prefer before
>> respinning:
>>
>> 1) Keep the lock outermost, move the open and close out from under it.
>>    md_ioctl() imports before taking q->limits_lock and releases after
>>    committing and unlocking; md_add_new_disk() hands the rdev back
>>    instead of exporting it.  The import then runs without
>>    reconfig_mutex, so the superblock format fields need a snapshot and a
>>    recheck under the lock.  Only the mddev->pers branch needs this, the
>>    other two never reach add_bound_rdev().
>>
>> 2) Drop the hoist for ADD_NEW_DISK and stack the leg after resume, with
>>    q->limits_lock on its own.  Much smaller, but the leg is live before
>>    its limits are stacked and the integrity rejection lands after the
>>    add rather than before it.
>>
> I am thinking about changeing the order of reconfig_mutex and the
> suspention. we would suspend the array inside raid1_add_disk()
> and raid1_remove_disk() when we add/remove the rdev from raid1 conf.
>

Sorry, changing the order would complicate it and result in a deadlock.
In those cases, normal I/O can be waiting for a superblock update which
needs to acquire the reconfig_mutex. At the same time, the task adding
the new rdev would be holding the reconfig_mutex while waiting for that
exact I/O to drain.

>> Is there a better option?  If ->hot_add_disk() is meant to be callable
>> with an update already in flight, that limits how far the open and close
>> can move.
>>
>> Thanks,
>> Jack
>
> --=20
> Best Regards,
> Abd-Alrhman

--=20
Best Regards,
Abd-Alrhman
