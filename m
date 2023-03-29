Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C96F6C74A5B
	for <linux-block@archiver.kernel.org>; Wed, 29 Mar 2023 19:22:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjC2TWr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Mar 2023 15:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbjC2TWm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Mar 2023 15:22:42 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC77059DE
        for <linux-block@vger.kernel.org>; Wed, 29 Mar 2023 12:22:37 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-54606036bb3so146589837b3.6
        for <linux-block@vger.kernel.org>; Wed, 29 Mar 2023 12:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680117757;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MD5vx/bj0saF4TqNG1nIF/YU28Jg42gUeejN+X2NCpY=;
        b=jT/j7PjxyG20P2CKl37aHA/z29PlP5r8hnouR7V1cEBZfIyQle/ffgyZ7SeY8TFDTN
         LriKUchyJMzRZTZfx2Ra1tFVLAY+IMhcDrjzjdXPhFcyX9wQ7Iq+ch1Lp8XCUn+PP+XT
         mDo99xFXTYufeJOx6O5lkcrR1KnrVe7fdgkK5wdj2U9WZ56B4j+7MKNJrYUu3YvPOJMS
         ddD10ubhfVeY9zNjMGsO05U3lUzlkLtHm4GWbA1tvIzVEXeRefinLhNUJ5Dyd+qyBevy
         Xp/QTExSKgMNuwRvOPQ7LHvWnn4acK885eIH7mW88e7D4Z3v4p2DeFo9+nXpGm8NXh8t
         I/VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680117757;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MD5vx/bj0saF4TqNG1nIF/YU28Jg42gUeejN+X2NCpY=;
        b=QwT3WRL1Bvo3ca6pIiJ47aSvNLS8WQXg5UdRUUIHZOrljhDkrXzu4XuNySCTH8m/og
         h5NHpXMEHL5QgpwxlX2xsMMoqicQRzj03JkqlQc+CmxsdYOwUlZBaZDn/VT9gMwSsS0D
         nK6KPBcxyOoT/IZuL2cdDZbZWmFXWei8ImRekJ53QgXoaaQq7sQn6K8PzUzrju/qxiU/
         GWQPDBXLG1Xa5nHlg7O1crhFWRwpYSs7+Ww2sGuup2x7O6HaO+FOYh1RRvU2PLz+W0AP
         J6vZcYFDOMoMzVnWWFCyKQRbnVchv8Il8iZgzG5Nh4gqGD2nJJm8pWuwAoun4cZ3MqN/
         TVEw==
X-Gm-Message-State: AAQBX9fMo4Ju+aq3AsUlezjs/tMTlviW8W1sWySa4+Ah7s/10J/JCFD5
        uF7nns4SuLn0BdJjibnDPZ3l/A==
X-Google-Smtp-Source: AKy350aGXqku0wFHBwnbv0ayIqkfKZQbDVwnxlDtv6ud72FCuk4s6YtJqZ1NSL1cWoc/4AVWoTxyWQ==
X-Received: by 2002:a81:920c:0:b0:52e:e095:3a00 with SMTP id j12-20020a81920c000000b0052ee0953a00mr21208691ywg.25.1680117756881;
        Wed, 29 Mar 2023 12:22:36 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id d8-20020a81d808000000b00545a08184dcsm3092357ywj.108.2023.03.29.12.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 12:22:35 -0700 (PDT)
Date:   Wed, 29 Mar 2023 12:22:24 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Tejun Heo <tj@kernel.org>
cc:     Yosry Ahmed <yosryahmed@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Josef Bacik <josef@toxicpanda.com>,
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
Subject: Re: [RFC PATCH 1/7] cgroup: rstat: only disable interrupts for the
 percpu lock
In-Reply-To: <ZCSJDpPPOVvBYfOy@slm.duckdns.org>
Message-ID: <f9b6410-ee17-635f-a35d-559fa0191dc3@google.com>
References: <20230323040037.2389095-1-yosryahmed@google.com> <20230323040037.2389095-2-yosryahmed@google.com> <ZBz/V5a7/6PZeM7S@slm.duckdns.org> <CAJD7tkYNZeEytm_Px9_73Y-AYJfHAxaoTmmnO71HW5hd1B5tPg@mail.gmail.com> <ZB5UalkjGngcBDEJ@slm.duckdns.org>
 <CAJD7tkYhyMkD8SFf8b8L1W9QUrLOdw-HJ2NUbENjw5dgFnH3Aw@mail.gmail.com> <CALvZod6rF0D21hcV7xnqD+oRkn=x5NLi5GOkPpyaPa859uDH+Q@mail.gmail.com> <CAJD7tkY_ESpMYMw72bsATpp6tPphv8qS6VbfEUjpKZW6vUqQSQ@mail.gmail.com> <CALvZod41ecuCKmuFBNtAjoKJjQgWYzoe4_B8zRK37HYk-rYDkA@mail.gmail.com>
 <CAJD7tkZrp=4zWvjE9_010TAG1T_crCbf9P64UzJABspgcrGPKg@mail.gmail.com> <ZCSJDpPPOVvBYfOy@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Tejun,

On Wed, 29 Mar 2023, Tejun Heo wrote:
> On Mon, Mar 27, 2023 at 04:23:13PM -0700, Yosry Ahmed wrote:
> > Tejun, if having the lock be non-irq is a non-starter for you, I can
> 
> This is an actual hazard. We see in prod these unprotected locks causing
> very big spikes in tail latencies and they can be tricky to root cause too
> and given the way rstat lock is used it's highly likely to be involved in
> those scenarios with the proposed change, so it's gonna be a nack from my
> end.

Butting in here, I'm fascinated.  This is certainly not my area, I know
nothing about rstat, but this is the first time I ever heard someone
arguing for more disabling of interrupts rather than less.

An interrupt coming in while holding a contended resource can certainly
add to latencies, that I accept of course.  But until now, I thought it
was agreed best practice to disable irqs only regretfully, when strictly
necessary.

If that has changed, I for one want to know about it.  How should we
now judge which spinlocks should disable interrupts and which should not?
Page table locks are currently my main interest - should those be changed?

Thanks,
Hugh
