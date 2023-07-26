Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBCD1C001DE
	for <linux-block@archiver.kernel.org>; Wed, 26 Jul 2023 23:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjGZXdu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jul 2023 19:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjGZXdt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jul 2023 19:33:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4AC41BC1
        for <linux-block@vger.kernel.org>; Wed, 26 Jul 2023 16:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690414380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NTp7hPOiEo8RsuNy0X/kowl3tsiOjf8HH084Hc7F5Q8=;
        b=hfQRXfW+hEwCw6N6MQH730qe9gfN5fmqqYXEVh5WrD92yeNfEtbgTzNTzHJ1HpyWoZtOb7
        Yq53DcOYDHGV162gUqHoZSMB2MO0rtR4oZoQNUdldLaSncgaxeYo5h29EOX04IdQE0aAFL
        XaSUzDplZB5qOsU8bsJ3wbNg7+WwoEY=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-1X__O9EUNO-taid66-HwwA-1; Wed, 26 Jul 2023 19:32:59 -0400
X-MC-Unique: 1X__O9EUNO-taid66-HwwA-1
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-443606cb7ecso80111137.0
        for <linux-block@vger.kernel.org>; Wed, 26 Jul 2023 16:32:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690414379; x=1691019179;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NTp7hPOiEo8RsuNy0X/kowl3tsiOjf8HH084Hc7F5Q8=;
        b=jG1HNeOZWcSCYlS8gbBHRwtsl+cy9eujJ4lhZTU3fjnvIJM7m+7Srb3Ka9iz+KEmS7
         fadyVbvFbK1MA2524iEqfWU7WILCMhSakI3aHvRtP5BHHiP4X8gT8i4/vnKQ4UDOD0KY
         3XhpGm3M7z/at9F0YHVlMRUqEBjnJYCJ6lwBcmz+WhYZQnHwrx9BlFinVYrO/nta+KnM
         EBwPgg7gpicaet1ZQ60UxNGeEjN+sbLD/VmLVW0wVypQo8iFI3A4RrkVLPpQ4VqdsBoe
         z9ik2d0NFjF5E77aHT/8dPe+7oicgo3iuJ8VQv4GeVVQj+dG5LJoK1qJMqaQBU+98JxS
         1FYg==
X-Gm-Message-State: ABy/qLaBtVLiKsvYAeZ0CU3gbAOsDcOC897CdBOkNXqS/5vYuQxO2rAh
        PoPSSknpuPHgbXevSChLMAocJtTNKOuAm7F8D4Ce3Tg7Z9RH1PXA3IGbW147b/IVYVrzLesg923
        mdGbU8vecnvo9U6rGRSQJvOo=
X-Received: by 2002:a67:ebda:0:b0:446:e948:ebd4 with SMTP id y26-20020a67ebda000000b00446e948ebd4mr288248vso.21.1690414379019;
        Wed, 26 Jul 2023 16:32:59 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEBWVn6oNGd3oafZjSwJyje7R1LaMoDnex87Y9R0nZDhsPnx78zVZxqLCqNQUhUZ02837TT9A==
X-Received: by 2002:a67:ebda:0:b0:446:e948:ebd4 with SMTP id y26-20020a67ebda000000b00446e948ebd4mr288240vso.21.1690414378735;
        Wed, 26 Jul 2023 16:32:58 -0700 (PDT)
Received: from crash ([66.187.232.65])
        by smtp.gmail.com with ESMTPSA id s25-20020a05620a16b900b00767ded911a3sm4703263qkj.116.2023.07.26.16.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 16:32:57 -0700 (PDT)
From:   Ken Raeburn <raeburn@redhat.com>
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        vdo-devel@redhat.com, tj@kernel.org, ebiggers@kernel.org
Subject: Re: [vdo-devel] [PATCH v2 00/39] Add the dm-vdo deduplication and
 compression device mapper target.
References: <20230523214539.226387-1-corwin@redhat.com>
        <ZLa086NuWiMkJKJE@redhat.com>
        <CAK1Ur396ThV5AAZx2336uAW3FqSY+bHiiwEPofHB_Kwwr4ag5A@mail.gmail.com>
Date:   Wed, 26 Jul 2023 19:32:56 -0400
In-Reply-To: <CAK1Ur396ThV5AAZx2336uAW3FqSY+bHiiwEPofHB_Kwwr4ag5A@mail.gmail.com>
        (Kenneth Raeburn's message of "Fri, 21 Jul 2023 21:59:05 -0400")
Message-ID: <87cz0e9rkn.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


An offline discussion suggested maybe I should've gone into a little
more detail about how VDO uses its work queues.

VDO is sufficiently work-intensive that we found long ago that doing all
the work in one thread wouldn't keep up.

Our multithreaded design started many years ago and grew out of our
existing design for UDS (VDO's central deduplication index), which,
somewhat akin to partitioning and sharding in databases, does scanning
of the in-memory part of the "database" of values in some number (fixed
at startup) of threads, with the data and work divided up based on
certain bits of the hash value being looked up, and performs its I/O and
callbacks from certain other threads. We aren't splitting work to
multiple machines as database systems sometimes do, but to multiple
threads and potentially multiple NUMA nodes.

We try to optimize for keeping the busy case fast, even if it means
light usage loads don't perform quite as well as they could be made to.
We try to reduce instances of contention between threads by avoiding
locks when we can, preferring a fast queueing mechanism or loose
synchronization between threads. (We haven't kept to it strictly, but
we've mostly tried to.)

In VDO, at the first level, the work is split according to the
collection of data structures to be updated (e.g., recovery journal vs
disk block allocation vs block address mapping management).

For some data structures, we split the structures further based on
values of relevant bit-strings for the data structure in question (block
addresses, hash values). Currently we can split the work N ways for many
small values of N but it's hard to change N without restarting. The
processing of a read or write operation generally doesn't need to touch
more than one "zone" in any of these sets (or two, in a certain write
case).

Giving one thread exclusive access to the data structures means we can
do away with the locking. Of course, with so many different threads
owning data structures, we get a lot of queueing in exchange, but we
depend on a fast, nearly-lock-free MPSC queueing mechanism to keep that
reasonably efficient.

There's a little more to it in places where we need to preserve the
order of processing of multiple VIOs in a couple different sections of
the write path. So we do make some higher-level use of the fact that
we're adding work to queues with certain behavior, and not just turning
loose a bunch of threads to contend for a just-released mutex.

Some other bits of work like computing the hash value don't update any
other data structures, and not only would be amenable to kernel
workqueue conversion with concurrency greater than 1, but such a
conversion might open up some interesting options, like hashing on the
CPU or NUMA node where the data block is likely to reside in cache. But
for now, using one work management mechanism has been easier than two.

The experiment I referred to in my earlier email with using kernel
workqueues in VDO kept the same model of protecting data structures by
making them exclusive to specific threads (or in this case,
concurrency-1 workqueues) to serialize all access and using message
passing; it didn't change everything over to using mutexes instead.

I hope some of this helps. I'm happy to answer further questions.

Ken

