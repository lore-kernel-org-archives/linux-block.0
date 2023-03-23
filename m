Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6C7C6FD1C
	for <linux-block@archiver.kernel.org>; Thu, 23 Mar 2023 19:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbjCWTKQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Mar 2023 15:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbjCWTKE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Mar 2023 15:10:04 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD52B463
        for <linux-block@vger.kernel.org>; Thu, 23 Mar 2023 12:09:46 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id j7so26095611ybg.4
        for <linux-block@vger.kernel.org>; Thu, 23 Mar 2023 12:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679598585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vLtQVw9Q3r/EIfGHaHQqJXqtgGhueRqlggc/xqxY+5U=;
        b=iWmN5qdQNSjpgISH3j2kib5cc+h8AoBaK9c2AaVVVURUW5rI9o8n06FvmV1M+bBFfX
         YNubq65NBM6w9TNZeohFGxGQHBSYpmJ2MVCGqXlkjI0pG66JFFF6zyIvXaCtVFAsMNFh
         hXEcIALahsRpm5ULADGvB6dWEK8Cco4UeMk/PeV198/yaHKWNMbjOkpRw/jOeaVEUa88
         WYew6Gts30zeIuE6WLRNasfDpPaC4wq9Q+TgniIJZLVp7q+T9A9NqwNBf4mhube6dHtB
         lKvNpdpZCmdXI0XAsx+tbsEVIpm8bgaFMld59t1NK22AG0oMOtTQgmguJ9Zy1dAlKVSJ
         vknQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679598585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vLtQVw9Q3r/EIfGHaHQqJXqtgGhueRqlggc/xqxY+5U=;
        b=xB5S4PsPRzGDI8w6l/tqGbNPSje+aJIh0D8yhgUFaNbmhwgApBNdyhmimddx1Mv8Lp
         Ak8+G/fDJcMFAtu7n9ZHc0rQ3D/DFoMpZaCyiT5O2FR2dxfEiK2JSWOu4dWjqyeQ9lWx
         2r9P3Fenmn1OydCoKHVVx24OOjzTB+BBiMFbI4MjpChvo7VA3fFM06Oci0PJEkTnaq6c
         jfRas7Eo+tz474uYlqZMR3ENeeawYZzTY1r0xBc0sBfmpSuiMDf42VStq1A12YY4rIwb
         p3LA8n7M4lvuZ9pj4TsGtyfltoqphm6yN/zv7TDtTFg6ImEw+HTtHGFY85S42eM5vh6p
         c54w==
X-Gm-Message-State: AAQBX9ejnfK5ftOyYj4Ao4pqTlYHTRusD2s6obJNB1uDbB1bnhG1x1yn
        BGCRnY+GjVHXif751w6PfZI4TdoSMVTPzTUeyrQNYg==
X-Google-Smtp-Source: AKy350akUM/9iIf8a3thcZVFCFca2DEXgqBqR2kjsnCDm5WKBJDwjnFCzpyD3JyTXxOLuZxXO5ARoUIWjEn4MKy8lr8=
X-Received: by 2002:a25:a28f:0:b0:a99:de9d:d504 with SMTP id
 c15-20020a25a28f000000b00a99de9dd504mr2809088ybi.12.1679598584842; Thu, 23
 Mar 2023 12:09:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230323040037.2389095-1-yosryahmed@google.com>
 <20230323040037.2389095-2-yosryahmed@google.com> <CALvZod7e7dMmkhKtXPAxmXjXQoTyeBf3Bht8HJC8AtWW93As3g@mail.gmail.com>
 <CAJD7tkbziGh+6hnMysHkoNr_HGBKU+s1rSGj=gZLki0ALT-jLg@mail.gmail.com>
 <CALvZod5GT=bZsLXsG500pNkEJpMB1o2KJau4=r0eHB-c8US53A@mail.gmail.com>
 <CAJD7tkY6Wf2OWja+f-JeFM5DdMCyLzbXxZ8KF0MjcYOKri-vtA@mail.gmail.com>
 <CALvZod5mJBAQ5adym7UNEruL-tOOOi+Y_ZiKsfOYqXPmGVPUEA@mail.gmail.com>
 <CAJD7tkYWo_aB7a4SHXNQDHwcaTELonOk_Vd8q0=x8vwGy2VkYg@mail.gmail.com>
 <CALvZod7f9Rejb_WrZ+Ajegz-NsQ7iPQegRDMdk5Ya0a0w=40kg@mail.gmail.com>
 <CALvZod7-6F84POkNetA2XJB-24wms=5q_s495NEthO8b63rL4A@mail.gmail.com>
 <CAJD7tkbGCgk9VkGdec0=AdHErds4XQs1LzJMhqVryXdjY5PVAg@mail.gmail.com>
 <CALvZod7saq910u4JxnuY4C7EwiK5vgNF=-Bv+236RprUOQdkjw@mail.gmail.com>
 <CAJD7tkb8oHoK5RW96tEXjY9iyJpMXfGAvnFw1rG-5Sr+Mpubdg@mail.gmail.com>
 <CALvZod5USCtNtnPuYRbRv_psBCNytQWWQ592TFsJLfrLpyLJmw@mail.gmail.com> <CAJD7tkad5NbqjXZ1qLaNx1g-FYsrv-BVLcNinycFStG_Bu0_zw@mail.gmail.com>
In-Reply-To: <CAJD7tkad5NbqjXZ1qLaNx1g-FYsrv-BVLcNinycFStG_Bu0_zw@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 23 Mar 2023 12:09:33 -0700
Message-ID: <CALvZod4n+_zo7fkn=NfRSKeShHbarUPWL3D=uScZmg9aiKkP-w@mail.gmail.com>
Subject: Re: [RFC PATCH 1/7] cgroup: rstat: only disable interrupts for the
 percpu lock
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

On Thu, Mar 23, 2023 at 9:52=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
[...]
>
> Sure, I can do that in the next version. I will include a patch that
> adds an in_task() check to mem_cgroup_usage() before this one. Since
> BUG_ON() is discouraged and VM_BUG_ON() is mm specific, I guess we are
> left with WARN_ON_ONCE() for the rstat core code, right?
>
> Thanks Shakeel. Any other thoughts I should address for the next version?

This is all for now (at least for this patch).
