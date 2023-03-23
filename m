Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D40EDC7619A
	for <linux-block@archiver.kernel.org>; Thu, 23 Mar 2023 04:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjCWEKg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Mar 2023 00:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjCWEKf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Mar 2023 00:10:35 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137C730D3
        for <linux-block@vger.kernel.org>; Wed, 22 Mar 2023 21:10:33 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id p203so23378257ybb.13
        for <linux-block@vger.kernel.org>; Wed, 22 Mar 2023 21:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679544632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7lcSWN3GyBfovXV1vZTMtcIYaPrkreWXQ9n4Cq5J+k0=;
        b=rsH6Q3RSuOVN3v4OApWCK2fKM+hkdBWgfdvhHyQzW5Pw+plPTNi9t2m+UBHsGzWBhv
         Pk3rTZw8S6erq7968367WPneS5lOiBB263QMPQIVZosoB7XgLrX5yK+4fD9eP3bHitsO
         uvxzf7qEvXAmJrFSpdvQ60LIHlUll8cmFnmqKpFZ1USUIBElYfXVEPUVMOIKgSNihg2n
         nslvhDFRmKyaFgWa0Y1XYP6jxLvfUtJtMY/+Q2dg//gD1t2dlL7SklCJpgAJluQNrVEh
         IC06YYalM2n8mMSw7nA8J/qZlHYoX/dOLHyJZPURTxp1XDJGlwr9WTpY2AlVLpaX4gxi
         gAsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679544632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7lcSWN3GyBfovXV1vZTMtcIYaPrkreWXQ9n4Cq5J+k0=;
        b=XMMADJW8h9FW8vAm/hGGEM5PwKgDc2TpBZS7ofsSAPFhZppm/y9N98YaqOLMrZu4YH
         iY6BZIREQgzIQccwMyIr6DoDAn2gO1evXKBJExBDR5H/InYopxhHFBZ6cpjpkNtQqlud
         pM4hUsi4hSwofnDi3Den7KkQE5CkwpbMPGBAzZF9eyx5BUPjWzz+cRtDGi745uNr3EB3
         b7CHXwjrIeAUPqzP768Qhxldbi7JTWxFZnVOL3wlTT0YsOu/waGFAw6o8EdHsejM2Z9R
         Jo4o1yyLZcS3327y+wR/0qoroaJHbCVIMruC3qfQmh2oDdNA/f6DHxWc512DsRruIiN0
         Z5Cw==
X-Gm-Message-State: AAQBX9dY2PbKVJc3Yu+woCaJkxJmFK53lNUX4vE1ZvHVed4N5eWg3kVy
        /JAO0z6VJScuduurqwGVxh+1Tv3SD3uoZENK4J0Vag==
X-Google-Smtp-Source: AKy350aqC2PVmbH/EfzdkoR2G9mhoQxC8Y2WiV+NG8rw6zMdlkFRbTKRx4Laq0LGQE/avEssQ3AobpebGV9qYqZK2AM=
X-Received: by 2002:a25:800d:0:b0:b3b:6576:b22b with SMTP id
 m13-20020a25800d000000b00b3b6576b22bmr1346202ybk.12.1679544632180; Wed, 22
 Mar 2023 21:10:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230323040037.2389095-1-yosryahmed@google.com>
In-Reply-To: <20230323040037.2389095-1-yosryahmed@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 22 Mar 2023 21:10:21 -0700
Message-ID: <CALvZod5uyZRsvA5ntw0jSBXUNa1_HzB9zOabsGKsndyA5KCYnQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] Make rstat flushing IRQ and sleep friendly
To:     Yosry Ahmed <yosryahmed@google.com>
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

On Wed, Mar 22, 2023 at 9:00=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> Currently, if rstat flushing is invoked using the irqsafe variant
> cgroup_rstat_flush_irqsafe(), we keep interrupts disabled and do not
> sleep for the entire flush operation, which is O(# cpus * # cgroups).
> This can be rather dangerous.
>
> Not all contexts that use cgroup_rstat_flush_irqsafe() actually cannot
> sleep, and among those that cannot sleep, not all contexts require
> interrupts to be disabled.

Too many negations in the above sentence is making it very confusing.
