Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34620 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752770AbdHWAKk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Aug 2017 20:10:40 -0400
MIME-Version: 1.0
In-Reply-To: <20170822230043.9968-2-bart.vanassche@wdc.com>
References: <20170822230043.9968-1-bart.vanassche@wdc.com> <20170822230043.9968-2-bart.vanassche@wdc.com>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Wed, 23 Aug 2017 09:10:19 +0900
Message-ID: <CAC5umyh5r-nmKisg7bavbm320Gd1puZmPOv7q+q0yonYbzr+ZA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] fault-inject: Restore support for task-independent
 fault injection
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        linux-block@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Michal Hocko <mhocko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

2017-08-23 8:00 GMT+09:00 Bart Van Assche <bart.vanassche@wdc.com>:
> Certain faults should be injected independent of the context
> in which these occur. Commit e41d58185f14 made it impossible to
> inject faults independent of their context. Restore support for
> task-independent fault injection by adding the attribute 'global'.

There was a the problem reported by fail-make-request user and the
problem is introduced by the follow-up patches for systematic
fault injection.

Please check the commit 9eeb52ae712e ("fault-inject: fix wrong
should_fail() decision in task context") and see if the problem
you reported is identical to the commit.

> References: commit e41d58185f14 ("fault-inject: support systematic fault injection")
> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Akinobu Mita <akinobu.mita@gmail.com>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>  include/linux/fault-inject.h | 11 +++++++++--
>  lib/fault-inject.c           |  4 +++-
>  2 files changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/fault-inject.h b/include/linux/fault-inject.h
> index 728d4e0292aa..88dae2f21881 100644
> --- a/include/linux/fault-inject.h
> +++ b/include/linux/fault-inject.h
> @@ -18,6 +18,7 @@ struct fault_attr {
>         atomic_t times;
>         atomic_t space;
>         unsigned long verbose;
> +       bool global;
>         bool task_filter;
>         unsigned long stacktrace_depth;
>         unsigned long require_start;
> @@ -30,17 +31,23 @@ struct fault_attr {
>         struct dentry *dname;
>  };
>
> -#define FAULT_ATTR_INITIALIZER {                                       \
> +#define __FAULT_ATTR_INITIALIZER(__global) {                           \
>                 .interval = 1,                                          \
>                 .times = ATOMIC_INIT(1),                                \
>                 .require_end = ULONG_MAX,                               \
> +               .global = (__global),                                   \
>                 .stacktrace_depth = 32,                                 \
>                 .ratelimit_state = RATELIMIT_STATE_INIT_DISABLED,       \
>                 .verbose = 2,                                           \
>                 .dname = NULL,                                          \
>         }
>
> -#define DECLARE_FAULT_ATTR(name) struct fault_attr name = FAULT_ATTR_INITIALIZER
> +#define FAULT_ATTR_INITIALIZER __FAULT_ATTR_INITIALIZER(false)
> +
> +#define DECLARE_FAULT_ATTR(name)                               \
> +       struct fault_attr name = __FAULT_ATTR_INITIALIZER(false)
> +#define DECLARE_GLOBAL_FAULT_ATTR(name)                                \
> +       struct fault_attr name = __FAULT_ATTR_INITIALIZER(true)
>  int setup_fault_attr(struct fault_attr *attr, char *str);
>  bool should_fail(struct fault_attr *attr, ssize_t size);
>
> diff --git a/lib/fault-inject.c b/lib/fault-inject.c
> index 7d315fdb9f13..c8f6ef5df3c6 100644
> --- a/lib/fault-inject.c
> +++ b/lib/fault-inject.c
> @@ -107,7 +107,7 @@ static inline bool fail_stacktrace(struct fault_attr *attr)
>
>  bool should_fail(struct fault_attr *attr, ssize_t size)
>  {
> -       if (in_task()) {
> +       if (!attr->global && in_task()) {
>                 unsigned int fail_nth = READ_ONCE(current->fail_nth);
>
>                 if (fail_nth && !WRITE_ONCE(current->fail_nth, fail_nth - 1))
> @@ -224,6 +224,8 @@ struct dentry *fault_create_debugfs_attr(const char *name,
>         if (!debugfs_create_u32("verbose_ratelimit_burst", mode, dir,
>                                 &attr->ratelimit_state.burst))
>                 goto fail;
> +       if (!debugfs_create_bool("global", mode, dir, &attr->global))
> +               goto fail;
>         if (!debugfs_create_bool("task-filter", mode, dir, &attr->task_filter))
>                 goto fail;
>
> --
> 2.14.0
>
