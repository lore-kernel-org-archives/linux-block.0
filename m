Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF50C001DE
	for <linux-block@archiver.kernel.org>; Fri, 28 Jul 2023 08:31:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235027AbjG1Ibs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Jul 2023 04:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233378AbjG1IbT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Jul 2023 04:31:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9246E3C28
        for <linux-block@vger.kernel.org>; Fri, 28 Jul 2023 01:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690532936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=leIkqAudEGz78/ipkbxeymQs0lqhSaqKZ/Eo5h7Uujg=;
        b=CNm+Cr3ET/HUZ9OIy9niT0q1Kt7x1FGWdAUaI6I9Ky9gwhRqBrE77E2luG5LYTuKyYF7kL
        j58sPf5rz0RPZNCuHMuWXa4dvD8g5RNmryxMEryo0xt7DLewcHjoDolJCQrVRpIBbqFwpz
        VdAkJGyTfT9CcLqEZgIGHxlwwVlKHbs=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-386-U6SlPeYjNLKzYQ-kEcpwng-1; Fri, 28 Jul 2023 04:28:55 -0400
X-MC-Unique: U6SlPeYjNLKzYQ-kEcpwng-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7656c94fc4eso217585585a.2
        for <linux-block@vger.kernel.org>; Fri, 28 Jul 2023 01:28:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690532934; x=1691137734;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=leIkqAudEGz78/ipkbxeymQs0lqhSaqKZ/Eo5h7Uujg=;
        b=FS5btd2A55+kLLzN07UQyL/Izr9U1X1oOyp5tELS663MXeTt8MVVVeyo59jHYQtgju
         YIA9PdMBPa90MfHEbIeirh3Ag7pP9kywd2r8In5JinPYpNPZuJlMv3ihsEkw04ludANI
         iaMlfH/q0HIEpBl6BWH1RFcMYkMzbewa5urVmu3Unaa8tXRe3yFMfB7ibN+WH/OEj8cZ
         K3U0SbUFWl6vHlUVPWVE6ZkDDfMfYHsH7IptxXe8JTNdsrbGoP7/6sn5Q56W5Pr+0Eqk
         dw79uno/fmhYc5nAYXWbYo+EWQjSDjNOIav0o8Wx93NWNmtWQy6txIIHG95djf41g2t6
         5zag==
X-Gm-Message-State: ABy/qLbFkeLEv06wn97UPEwE1fVddfkrHqULHiP9rcj6Nx+ggSThow5j
        glECVoxPU75m7CFeLXOOZpsgumCqNV+eNMMVlKWCjyAzRAz+vxqZNRzLP7Pfp9MNAdeZR4uhvR5
        KWkiYYcO6ZUl/k7/j2p2zT0+7DRryeTRswQ==
X-Received: by 2002:a05:620a:4586:b0:767:f1f5:9986 with SMTP id bp6-20020a05620a458600b00767f1f59986mr2165212qkb.24.1690532934365;
        Fri, 28 Jul 2023 01:28:54 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFJx/es0sujNTznp15UzhUi8RG+M8r9OGkm9Esn3oXJml0Fbp/KxtFMXuuT+zYZDctWoQQU4Q==
X-Received: by 2002:a05:620a:4586:b0:767:f1f5:9986 with SMTP id bp6-20020a05620a458600b00767f1f59986mr2165199qkb.24.1690532934021;
        Fri, 28 Jul 2023 01:28:54 -0700 (PDT)
Received: from crash (c-24-218-80-208.hsd1.ma.comcast.net. [24.218.80.208])
        by smtp.gmail.com with ESMTPSA id 27-20020a05620a079b00b00767da9b6ae9sm975473qka.11.2023.07.28.01.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 01:28:53 -0700 (PDT)
From:   Ken Raeburn <raeburn@redhat.com>
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        vdo-devel@redhat.com, tj@kernel.org, ebiggers@kernel.org
Subject: Re: [PATCH v2 00/39] Add the dm-vdo deduplication and compression
 device mapper target.
References: <20230523214539.226387-1-corwin@redhat.com>
        <ZLa086NuWiMkJKJE@redhat.com>
        <CAK1Ur396ThV5AAZx2336uAW3FqSY+bHiiwEPofHB_Kwwr4ag5A@mail.gmail.com>
        <87cz0e9rkn.fsf@redhat.com> <ZMKF24poWyKdeRHO@redhat.com>
Date:   Fri, 28 Jul 2023 04:28:52 -0400
In-Reply-To: <ZMKF24poWyKdeRHO@redhat.com> (Mike Snitzer's message of "Thu, 27
        Jul 2023 10:57:31 -0400")
Message-ID: <874jloa18b.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Mike Snitzer <snitzer@kernel.org> writes:
> Thanks for the extra context, but a _big_ elephant in the room for
> this line of discussion is that: the Linux workqueue code has
> basically always been only available for use by GPL'd code.  Given
> VDO's historic non-GPL origins, it seems _to me_ that an alternative
> to Linux's workqueues had to be created to allow VDO to drive its
> work.  While understandable, I gave guidance 6 years ago that VDO
> engineering should work to definitively reconcile if using Linux
> workqueues viable now that VDO has been GPL'd.

Yes, initially that was a significant reason.

More recently, when we've tried switching, the performance loss made it
appear not worth the change. Especially since we also needed to ship a
usable version at the same time.

> But it appears there wasn't much in the way of serious effort put to
> completely converting to using Linux workqueues. That is a problem
> because all of the work item strategy deployed by VDO is quite
> bespoke.  I don't think the code lends itself to being properly
> maintained by more than a 1 or 2 engineers (if we're lucky at this
> point).

By "work item strategy" are you referring to the lower level handling of
queueing and executing the work items? Because I've done that. Well, the
first 90%, by making the VDO work queues function as a shim on top of
the kernel ones instead of creating their own threads. It would also
need the kernel workqueues modified to support the SYSFS and ORDERED
options together, because on NUMA systems the VDO performance really
tanks without tweaking CPU affinity, and one or two other small
additions. If we were to actually commit to that version there might be
additional work like tweaking some data structures and eliding some shim
functions if appropriate, but given the performance loss, we decided to
stop there.

Or do you mean the use of executing all actions affecting a data
structure in a single thread/queue via message passing to serialize
access to data structures instead of having a thread serially lock,
modify, and unlock the various different data structures on behalf of a
single I/O request, while another thread does the same for another I/O
request? The model we use can certainly make things more difficult to
follow. It reads like continuation-passing style code, not the
straight-line code many of us are more accustomed to.

"Converting to using Linux workqueues" really doesn't say the latter to
me, it says the former. But I thought I'd already mentioned I'd tried
the former out. (Perhaps not very clearly?)

> I would like to see a patch crafted that allows branching between the
> use of Linux and VDO workqueues. Initially have a dm-vdo modparam
> (e.g. use_vdo_wq or vice-versa: use_linux_wq).  And have a wrapping
> interface and associated data struct(s) that can bridge between work
> being driven/coordinated by either (depending on disposition of
> modparam).

If we're talking about the lower level handling, I don't think it would
be terribly hard.

> This work isn't trivial, I get that. But it serves to clearly showcase
> shortcomings, areas for improvement, while pivoting to more standard
> Linux interfaces that really should've been used from VDO's inception.
>
> Is this work that you feel you could focus on with urgency?
>
> Thanks,
> Mike

I think so, once we're clear on exactly what we're talking about...

Ken

