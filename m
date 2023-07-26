Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 032C5C001DE
	for <linux-block@archiver.kernel.org>; Wed, 26 Jul 2023 23:34:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjGZXex (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jul 2023 19:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjGZXew (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jul 2023 19:34:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249AF2704
        for <linux-block@vger.kernel.org>; Wed, 26 Jul 2023 16:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690414444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JyD6brWfay5Kmnzh8GFewzS67t7xdwsyLUWArEuoir8=;
        b=Y8N0ahgbU07XSxBHlKYf2oS0ySkjzbbXDSYCbV0MdPE9lG9l/IuDcfjGcs5U5TDpKR6kev
        uFwGeyYrmn7FTAYO33yuMvzSFI2AvsLyNHgDX7KZJ5KD9DT7CaS/EDzTJHW9umKgif5yIH
        wqJMGi9G698pQwAVDdZBE+k5gzCYX8Q=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-CCJ5TkMRPMeENuESYBDkZA-1; Wed, 26 Jul 2023 19:34:02 -0400
X-MC-Unique: CCJ5TkMRPMeENuESYBDkZA-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-76752bc38bcso45988785a.2
        for <linux-block@vger.kernel.org>; Wed, 26 Jul 2023 16:34:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690414441; x=1691019241;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JyD6brWfay5Kmnzh8GFewzS67t7xdwsyLUWArEuoir8=;
        b=R9bsWf4BnnfUv0ywJkHqbs9s2pctXiSJKTI5ZN9my4pDOBRuPlX6hHgq55Ag30HyYl
         /Qq5lTXWAG7CfeatOy5wR/75Zio5IZG/l7RK0zyiMNRpCJ+7cjhFUwZPCgAja99rezKA
         8w36V4PMocOovHqXKD6w8cerR22YH66WcdpDZr7E2uUefqYdxehrnjj7G8cmNv6J4Bh6
         Vy5s9ey0flZbUxm5e6nLOBE6HLN7JguyKBMEQZbzNIUroKX80a9vPrlBJVCJ3uB9NSzd
         1y/pmiEzx0CeSZmb/C6OMpr47O2liMO9gNksLoOGWx3M73RyOrLdrhaEFyis56udgCgk
         drAQ==
X-Gm-Message-State: ABy/qLYrdNplbck340U+TUoLGRy8JYfqjwULAxuixauRszpPihLKj8Cq
        H+j21uSX6IwU58HbiUPgIUZrmawZ5jmA+ryabBAbUBnW1CORgwK3PnQdPXys6Y5lFH9TRVTvEVH
        5KYzrco7n/+PIRI9+f8T85lkl6BOfrk7y3Q==
X-Received: by 2002:a0c:b30c:0:b0:5f4:5af6:1304 with SMTP id s12-20020a0cb30c000000b005f45af61304mr2936966qve.16.1690414441705;
        Wed, 26 Jul 2023 16:34:01 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHonF7eBvYZRAZL1IaNans/eUBaueHJOyyYpEdyvlAkALF78WyY3NVe/g4RFEr5upDuwwY0Fw==
X-Received: by 2002:a0c:b30c:0:b0:5f4:5af6:1304 with SMTP id s12-20020a0cb30c000000b005f45af61304mr2936960qve.16.1690414441482;
        Wed, 26 Jul 2023 16:34:01 -0700 (PDT)
Received: from crash ([66.187.232.65])
        by smtp.gmail.com with ESMTPSA id c23-20020a05620a11b700b00767303dc070sm13060qkk.8.2023.07.26.16.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 16:34:00 -0700 (PDT)
From:   Ken Raeburn <raeburn@redhat.com>
To:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc:     Mike Snitzer <snitzer@kernel.org>, linux-block@vger.kernel.org,
        vdo-devel@redhat.com, dm-devel@redhat.com, ebiggers@kernel.org,
        tj@kernel.org
Subject: Re: [vdo-devel] [PATCH v2 00/39] Add the dm-vdo deduplication and
 compression device mapper target.
References: <20230523214539.226387-1-corwin@redhat.com>
        <ZLa086NuWiMkJKJE@redhat.com>
        <CAK1Ur396ThV5AAZx2336uAW3FqSY+bHiiwEPofHB_Kwwr4ag5A@mail.gmail.com>
        <509f4916-a95f-216e-b0ab-7b7a108a48a0@dorminy.me>
Date:   Wed, 26 Jul 2023 19:33:59 -0400
In-Reply-To: <509f4916-a95f-216e-b0ab-7b7a108a48a0@dorminy.me> (Sweet Tea
        Dorminy's message of "Sun, 23 Jul 2023 02:24:32 -0400")
Message-ID: <87bkfy9riw.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Sweet Tea Dorminy <sweettea-kernel@dorminy.me> writes:

>  There seems a natural duality between
> work items passing between threads, each exclusively owning a
> structure, vs structures passing between threads, each exclusively
> owning a work item. In the first, the threads are grabbing a notional
> 'lock' on each item in turn to deal with their structure, as VDO does
> now; in the second, the threads are grabbing locks on each structure
> in turn to deal with their item.

Yes.

> If kernel workqueues have higher overhead per item for the lightweight
> work VDO currently does in each step, perhaps the dual of the current
> scheme would let more work get done per fixed queuing overhead, and
> thus perform better? VIOs could take locks on sections of structures,
> and operate on multiple structures before requeueing.

Can you suggest a little more specifically what the "dual" is you're
picturing?

[...]
> On the other hand, I played around with switching messagepassing to
> structurelocking in VDO a number of years ago for fun on the side,
> just extremely naively replacing each message passing with releasing a
> mutex on the current set of structures and (trying to) take a mutex on
> the next set of structures, and ran into some complexity around
> certain ordering requirements. I think they were around recovery
> journal entries going into the slab journal and the block map in the
> same order; and also around the use of different priorities for some
> different items. I don't have that code anymore, unfortunately, so I
> don't know how hard it would be to try that experiment again.

Yes, we do have certain ordering requirements in one or two places,
which sort of breaks the mental model of independently processed VIOs.
There are also occasionally non-VIO objects which get queued to invoke
actions on various threads, which I expect might further complicate the
experiment.

Ken

