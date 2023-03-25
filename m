Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A789C6FD1C
	for <linux-block@archiver.kernel.org>; Sat, 25 Mar 2023 04:31:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbjCYEbI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 25 Mar 2023 00:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjCYEbH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 25 Mar 2023 00:31:07 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E191A96A
        for <linux-block@vger.kernel.org>; Fri, 24 Mar 2023 21:31:02 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-544b959a971so70201837b3.3
        for <linux-block@vger.kernel.org>; Fri, 24 Mar 2023 21:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679718661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hGXkNVqKc7W3NTjCcHQcK32QEBD4ibnmet17kfhhRaI=;
        b=PHAZU2Rd9Fp65snbdneP5IXYTtAFunJK2mfV2/pfOyuB8dkyTMfzLLe7Dl3igKadFa
         9se6SnVK1wDMGZrmKj4em9x05vBVwT9dWKvwg8pfB+2xddz8jQLLd8c3dXTvTi5HoOEM
         2GmUtVmBPiPdjr12BNA1afc7hYkVEBk1ABclJR45XULgq8DAuovm6lEt8UxThY/ahIWw
         /3+c8DXYKZwbijUtJPP5HW0j6XNHzjMvdaTMuYjuMYSA5o4nA0vJqIFNgoPtwVjvftrU
         rmoy1A9rEEka+aR2qVX1FnFd+1ObOumqDzWfDhM4lQCmdSGzsAXwwcTSY0Qcql8kFfYk
         X7yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679718661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hGXkNVqKc7W3NTjCcHQcK32QEBD4ibnmet17kfhhRaI=;
        b=HhJU7h33idR2IGCLau0qGff5KJIFMvEpmsNVRcu8ymc89iLY6LpoJIi7cnlGUuOiih
         I6oYKIWupCGGj59udtoNKkaQFQluPeo9TEc40XyGq31diqCr56b0j2kKzZ2ytG1JTOXu
         ldMlbKlkzQJc51g5osMHN/OspDpdcG9oK0icC5q1TejoW25OHqxKtn7u2aOTnI+5StH7
         bgPMZgM91Jh77HMOXHbcNq5yqXrG+JLmE5ZjJf79wObcC1NvVbKfYRrbfkvykv68Vay9
         v4hL9jSF1ESz79DIDnnUG7YNu+FWqVaYE6FsZ7hAVGidKRzJc34w4qQneh92juyjG7KM
         B7ag==
X-Gm-Message-State: AAQBX9fe+e8zhSJfiUhLcrWfn2hY1rzDUw9gA/fxqy+a/Sxi+ZAYAnXi
        aiuqunhtzvqtPCE5pbiAQJXkaQTtuewPba8ndFzIXg==
X-Google-Smtp-Source: AKy350ZELBPdnNH9RPXKXKnO784dLdfbc+FayCnRhRX2loqVW8hP2461hi+p6RkMJbrBPkX0+F1XATk0SQY/rmWNXHA=
X-Received: by 2002:a81:4517:0:b0:545:343b:ecba with SMTP id
 s23-20020a814517000000b00545343becbamr1799325ywa.0.1679718661454; Fri, 24 Mar
 2023 21:31:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230323040037.2389095-1-yosryahmed@google.com>
 <20230323040037.2389095-2-yosryahmed@google.com> <ZBz/V5a7/6PZeM7S@slm.duckdns.org>
 <CAJD7tkYNZeEytm_Px9_73Y-AYJfHAxaoTmmnO71HW5hd1B5tPg@mail.gmail.com>
 <ZB5UalkjGngcBDEJ@slm.duckdns.org> <CAJD7tkYhyMkD8SFf8b8L1W9QUrLOdw-HJ2NUbENjw5dgFnH3Aw@mail.gmail.com>
In-Reply-To: <CAJD7tkYhyMkD8SFf8b8L1W9QUrLOdw-HJ2NUbENjw5dgFnH3Aw@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 24 Mar 2023 21:30:49 -0700
Message-ID: <CALvZod6rF0D21hcV7xnqD+oRkn=x5NLi5GOkPpyaPa859uDH+Q@mail.gmail.com>
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

On Fri, Mar 24, 2023 at 7:18=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
[...]
> Any ideas here are welcome!
>

Let's move forward. It seems like we are not going to reach an
agreement on making cgroup_rstat_lock a non-irq lock. However there is
agreement on the memcg code of not flushing in irq context and the
cleanup Johannes has requested. Let's proceed with those for now. We
can come back to cgroup_rstat_lock later if we still see issues in
production.

Tejun, do you have any concerns on adding WARN_ON_ONCE(!in_task()) in
the rstat flushing code?
