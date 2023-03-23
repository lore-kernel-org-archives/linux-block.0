Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FDA7C6FD1D
	for <linux-block@archiver.kernel.org>; Thu, 23 Mar 2023 05:08:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbjCWFI3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Mar 2023 01:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjCWFI1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Mar 2023 01:08:27 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BAC018A95
        for <linux-block@vger.kernel.org>; Wed, 22 Mar 2023 22:08:24 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id h8so81648520ede.8
        for <linux-block@vger.kernel.org>; Wed, 22 Mar 2023 22:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679548103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=irOCu6qMS+se6H9bO0nEHf2Vgt336FUw4SAiYtLjT5U=;
        b=BqoBVzRuIH8J9krQGYDjW2lWJAbsyVIbf54oq0OxDs8xWSUXzKrPjJFi9K972u6e4Y
         y/WyGtS2YaZab2zyJzmpClXNAUt0Fvy5kT7BMkYWzvuydcQjU94k/Kwekd9E46Cjri/2
         O+AyFp7RSfLmAQ6+Lp71LY5X76waPqmxpGicoeDUt+pDLFmY/Qnz1EIa3j3xxaSs/JgT
         1M+WnK+NgenBX6Rz/kWFePDYEHcwxigsbxOboPo3tY+4Zxt0O6QI73Dbr/KwLnsWa9ut
         bng9scnddfnOejaHZOiUDLeyML3IeISce4O9Zwns1kdY8oue8KvKtY6wqq5uKRWDExoe
         6FrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679548103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=irOCu6qMS+se6H9bO0nEHf2Vgt336FUw4SAiYtLjT5U=;
        b=TEHY42bs31Y0xnxDtkPsCmzqQqkDGbw562u8b8LDQqvaPJfmDoV1rWiEV1S9HZxYIH
         r5TLXH24bX6FYlzC1ZShmVz6LuIcyuoEznJj8DjxfKhhrms4mWNbXcRNEyXKLBYjW5PC
         cGMCQhaVQxk0zc8wKoE8MUfIuo3/C0qmUFqac2GWxykEEODZxVcEpUhOktWseBX9BdT0
         LUrPTIIWFRCs30GN/2jdvggq7oqiWarxj1xkGqZlkzh5lv/xlXCDZt3cKDMdU3zP+MkC
         ayTKf206Mw0IRNWYVwat1o7TYuwAl5lqTpeIoRmQnQpgMx/WppBfTHuu7uqjDSYfN8eg
         /T0Q==
X-Gm-Message-State: AO0yUKVEuGot4mTFNlnAI2t0Gnuf++cjxrxATvzIVmrPrLwM3ISw31n4
        s5bGVT1/RQq0rPewTp40qYdYr8M2snHpf+CNKHS5gA==
X-Google-Smtp-Source: AK7set9L4/JEldbS+vem7o7GQfeNOXJxnDX3lhbvkFsjgECp0SgBx4+C1/jKHbRkNfpn4DaMdDatddiaW9yipF6aSKc=
X-Received: by 2002:a17:906:b28e:b0:935:3085:303b with SMTP id
 q14-20020a170906b28e00b009353085303bmr4270303ejz.15.1679548102936; Wed, 22
 Mar 2023 22:08:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230323040037.2389095-1-yosryahmed@google.com> <CALvZod5uyZRsvA5ntw0jSBXUNa1_HzB9zOabsGKsndyA5KCYnQ@mail.gmail.com>
In-Reply-To: <CALvZod5uyZRsvA5ntw0jSBXUNa1_HzB9zOabsGKsndyA5KCYnQ@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 22 Mar 2023 22:07:43 -0700
Message-ID: <CAJD7tkYYQjZyDpTc02WTGG_aW+wS8m2k407X3NhLrN8Y_5RKPA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] Make rstat flushing IRQ and sleep friendly
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vasily Averin <vasily.averin@linux.dev>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 22, 2023 at 9:10=E2=80=AFPM Shakeel Butt <shakeelb@google.com> =
wrote:
>
> On Wed, Mar 22, 2023 at 9:00=E2=80=AFPM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> > Currently, if rstat flushing is invoked using the irqsafe variant
> > cgroup_rstat_flush_irqsafe(), we keep interrupts disabled and do not
> > sleep for the entire flush operation, which is O(# cpus * # cgroups).
> > This can be rather dangerous.
> >
> > Not all contexts that use cgroup_rstat_flush_irqsafe() actually cannot
> > sleep, and among those that cannot sleep, not all contexts require
> > interrupts to be disabled.
>
> Too many negations in the above sentence is making it very confusing.

Sorry, this is indeed very confusing. I guess a better rephrasing is:

Multiple code paths use cgroup_rstat_flush_irqsafe(), but many of them
can sleep. Even among the code paths that actually cannot sleep,
multiple ones are interruptible.
