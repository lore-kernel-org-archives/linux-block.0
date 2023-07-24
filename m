Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3DE8C001B0
	for <linux-block@archiver.kernel.org>; Mon, 24 Jul 2023 18:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjGXSEh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Jul 2023 14:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjGXSEh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Jul 2023 14:04:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF7293
        for <linux-block@vger.kernel.org>; Mon, 24 Jul 2023 11:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690221830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h1iA/74VQWfwLwNThFZsLp7nijUvl29CDijMQU67cx0=;
        b=JtgySdGtvJzvAl/8XlQ0oRwxq6e2Vs5MnTa5SA4LeSDkZYiZA6R5mIUyE2htQhaXypf8mn
        pX4jbf5Vh+UIrGjOX5oNqVdrgJySfTEvnp/+4as9d5AVVjL+Bh7VZ8W1vEhbWHJsPSetNh
        T/s1N49EB055xieYo+Uixaz5l4lQaXs=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-d2a4geNEPx-PxnfBeXESNg-1; Mon, 24 Jul 2023 14:03:48 -0400
X-MC-Unique: d2a4geNEPx-PxnfBeXESNg-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-63cfe46bbb6so17162226d6.2
        for <linux-block@vger.kernel.org>; Mon, 24 Jul 2023 11:03:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690221828; x=1690826628;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h1iA/74VQWfwLwNThFZsLp7nijUvl29CDijMQU67cx0=;
        b=hAnvBke8BBImWF+wB2HMqHV+9lwfVJibM3Hu+Bgi75oCP+aC+gxttn30YevBTf25/P
         K3rwyu/SL+gV0YwgCx8ShOUGmi1D9FjNAb3/+tYH3kyz5QzO03spqE3ijjMjJaFv0XyO
         /idh0vsZNGxAqneAQA+d3Mt3NvTqVksuGnOZqmvxtX4oRtALqYArJV1gH7mLPkp3baqw
         iKLjGInvn0nEtp03lDaWBfr2Gn4/dKZ45DKxMoagqmn0bnejk9LJVG56UjKD3JGqtQAO
         ZKFBh1nwBh+VySnzdqE2Xm47bNq1PgnIi8J40BW6nbC3VUL99KUj0qUEOmM5xp2xlxs1
         Jz+A==
X-Gm-Message-State: ABy/qLb9nzsDNIwLJDANDjrHE5ioljZPQVppsb5kwtiZ9Gh4lR8E0lRH
        FLztViXb2oFqPZ6rnkNsSQSa7O647f+ndVCo8InFhBzOKKHg+FhaiheVaZ/iT2nI1uZrobjzULl
        0YiBtLu/oUIu4N3nH9V7IIEk=
X-Received: by 2002:a0c:c541:0:b0:63c:7459:b24c with SMTP id y1-20020a0cc541000000b0063c7459b24cmr486057qvi.1.1690221827703;
        Mon, 24 Jul 2023 11:03:47 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGDoVlS3FFXlpjdmnCPWfX8LPgwXcskuVzu4G58Z3n/2etCM1/Y+5M6HfC8yhSVC2CdnaBipg==
X-Received: by 2002:a0c:c541:0:b0:63c:7459:b24c with SMTP id y1-20020a0cc541000000b0063c7459b24cmr486039qvi.1.1690221827407;
        Mon, 24 Jul 2023 11:03:47 -0700 (PDT)
Received: from crash (c-24-218-80-208.hsd1.ma.comcast.net. [24.218.80.208])
        by smtp.gmail.com with ESMTPSA id f8-20020ac84708000000b00403ff38d855sm3500178qtp.4.2023.07.24.11.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 11:03:46 -0700 (PDT)
From:   Ken Raeburn <raeburn@redhat.com>
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        vdo-devel@redhat.com, tj@kernel.org, ebiggers@kernel.org
Subject: Re: [vdo-devel] [PATCH v2 00/39] Add the dm-vdo deduplication and
 compression device mapper target.
References: <20230523214539.226387-1-corwin@redhat.com>
        <ZLa086NuWiMkJKJE@redhat.com>
Date:   Mon, 24 Jul 2023 14:03:45 -0400
In-Reply-To: <ZLa086NuWiMkJKJE@redhat.com> (Mike Snitzer's message of "Tue, 18
        Jul 2023 11:51:15 -0400")
Message-ID: <87mszl9ofy.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


(Apologies for the re-send ... I neglected to turn of HTML and so
linux-block bounced the email as spam.)

On Tue, Jul 18, 2023 at 11:51=E2=80=AFAM Mike Snitzer <snitzer@kernel.org> =
wrote:

 But the long-standing dependency on VDO's work-queue data
 struct is still lingering (drivers/md/dm-vdo/work-queue.c). At a
 minimum we need to work toward pinning down _exactly_ why that is, and
 I think the best way to answer that is by simply converting the VDO
 code over to using Linux's workqueues.  If doing so causes serious
 inherent performance (or functionality) loss then we need to
 understand why -- and fix Linux's workqueue code accordingly. (I've
 cc'd Tejun so he is aware).

We tried this experiment and did indeed see some significant
performance differences. Nearly a 7x slowdown in some cases.

VDO can be pretty CPU-intensive. In addition to hashing and
compression, it scans some big in-memory data structures as part of
the deduplication process. Some data structures are split across one
or more "zones" to enable concurrency (usually split based on bits of
an address or something like that), but some are not, and a couple of
those threads can sometimes exceed 50% CPU utilization, even 90%
depending on the system and test data configuration. (Usually this is
while pushing over 1GB/s through the deduplication and compression
processing on a system with fast storage. On a slow VM with spinning
storage, the CPU load is much smaller.)

We use a sort of message-passing arrangement where a worker thread is
responsible for updating certain data structures as needed for the
I/Os in progress, rather than having the processing of each I/O
contend for locks on the data structures. It gives us some good
throughput under load but it does mean upwards of a dozen handoffs per
4kB write, depending on compressibility, whether the block is a
duplicate, and various other factors. So processing 1 GB/s means
handling over 3M messages per second, though each step of processing
is generally lightweight. For our dedicated worker threads, it's not
unusual for a thread to wake up and process a few tens or even
hundreds of updates to its data structures (likely benefiting from CPU
caching of the data structures) before running out of available work
and going back to sleep.

The experiment I ran was to create an ordered workqueue instead of
each dedicated thread where we need serialization, and unordered
workqueues when concurrency is allowed. On our slower test systems (>
10y old Supermicro Xeon E5-1650 v2, RAID-0 storage using SSDs or
HDDs), the slowdown was less significant (under 2x), but on our faster
system (4-5? year old Supermicro 1029P-WTR, 2x Xeon Gold 6128 =3D 12
cores, NVMe storage) we got nearly a 7x slowdown overall. I haven't
yet dug deeply into _why_ the kernel work queues are slower in this
sort of setup. I did run "perf top" briefly during one test with
kernel work queues, and the largest single use of CPU cycles was in
spin lock acquisition, but I didn't get call graphs.

(This was with Fedora 37 6.2.12-200 and 6.2.15-200 kernels, without
the latest submissions from Tejun, which look interesting. Though I
suspect we care more about cache locality for some of our
thread-specific data structures than for accessing the I/O
structures.)

Ken

