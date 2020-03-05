Return-Path: <SRS0=t5UG=4W=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21DEBC3F2CD
	for <linux-block@archiver.kernel.org>; Thu,  5 Mar 2020 08:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF9E721556
	for <linux-block@archiver.kernel.org>; Thu,  5 Mar 2020 08:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1WVPPJn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbgCEIr7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Mar 2020 03:47:59 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39929 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbgCEIr7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Mar 2020 03:47:59 -0500
Received: by mail-wr1-f65.google.com with SMTP id y17so5929532wrn.6;
        Thu, 05 Mar 2020 00:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nHoooDzcvgLf3wA/4Y6elltfrU93wND/F+5GY/7SXsU=;
        b=O1WVPPJnWowWB92YgIjXmfothJbjvlguldeZhHFsERRGuVUKYAPlcj64gVzAsLkpft
         gOF1/ifekicBqUNPbNbYoWktBhd3Y7r6Id/JZLL8SG8V69egXV045S18m+XPI4ai55Nq
         MeWDPLq1UgU74a7j0piEmLId+wAKKeZ72XeTYKXsHuVhs2bZBg6ZPSIbGXyLLTwLXDHJ
         sbR/97zDVWuFWIaq4EH7TvwWC95s7Xyu0osCOzO8HR44l4XOtJHOQONfHlpiy4d4cE6C
         41eeIYEhWgW6JXwKcB6kvTEQwAclC9qF10qX0aOfi+uZDrkNi1tyXs6L56FS/wN7Gyww
         YQgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nHoooDzcvgLf3wA/4Y6elltfrU93wND/F+5GY/7SXsU=;
        b=O2eg99hz1O6ZAno2fZbkEDSLCqsTZSEkgC24x1fNIBEptqHh/9xpPygZp9rQ5C2xJ2
         lV6j32TvCeEuB8YRGxxoro9TZZ6vUy6AXZncBN/qgEnA25ts2w0gGHq/up5bdYTKfXg4
         utAr3hJBYD67tr0RibNtq19lTW0b8+7PQWNufZsIM0Tn5n4OUd/0U4fyWu9VWdrXeS4E
         n3Uab1/zIHl/smWCauUeYD0AnSedGttHoI4/CGQADm7B2MM/zp7t0VJyVQlufTKM9Qv7
         sfx4lSZcioZ+I6KmPriHu2/6xNM226mjQVStTnGHUZCrM86e6VTBaCu/sXemZk50Zp6X
         uCvA==
X-Gm-Message-State: ANhLgQ3Ys4lQQ7F2C8KMhoJY3OQvvc4izj3GCPHeROmQXtbQ3TvqEcJt
        2Icn8kfnKYdVOp9MdPmVqNzfPmzg/LJN1qSyz7SKs/pQ
X-Google-Smtp-Source: ADFU+vu0oIGU7UqAZgATTFYpNQhrOGcwfgrI+9b0TmG/qVc7O4x6ZZe6+R7ww7PQa0Khi6GKv1ggMyUPxlyrI6YeOqI=
X-Received: by 2002:adf:9501:: with SMTP id 1mr2832663wrs.426.1583398076809;
 Thu, 05 Mar 2020 00:47:56 -0800 (PST)
MIME-Version: 1.0
References: <20200304105818.11781-1-cengiz@kernel.wtf>
In-Reply-To: <20200304105818.11781-1-cengiz@kernel.wtf>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Thu, 5 Mar 2020 16:47:45 +0800
Message-ID: <CACVXFVOQLFb7doDSqPxyV-C3au3RfO5YacNzOWv9XOXm+4dE6A@mail.gmail.com>
Subject: Re: [PATCH v2] blktrace: fix dereference after null check
To:     Cengiz Can <cengiz@kernel.wtf>
Cc:     Jens Axboe <axboe@kernel.dk>, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 4, 2020 at 6:59 PM Cengiz Can <cengiz@kernel.wtf> wrote:
>
> There was a recent change in blktrace.c that added a RCU protection to
> `q->blk_trace` in order to fix a use-after-free issue during access.
>
> However the change missed an edge case that can lead to dereferencing of
> `bt` pointer even when it's NULL:
>
> Coverity static analyzer marked this as a FORWARD_NULL issue with CID
> 1460458.
>
> ```
> /kernel/trace/blktrace.c: 1904 in sysfs_blk_trace_attr_store()
> 1898            ret = 0;
> 1899            if (bt == NULL)
> 1900                    ret = blk_trace_setup_queue(q, bdev);
> 1901
> 1902            if (ret == 0) {
> 1903                    if (attr == &dev_attr_act_mask)
> >>>     CID 1460458:  Null pointer dereferences  (FORWARD_NULL)
> >>>     Dereferencing null pointer "bt".
> 1904                            bt->act_mask = value;
> 1905                    else if (attr == &dev_attr_pid)
> 1906                            bt->pid = value;
> 1907                    else if (attr == &dev_attr_start_lba)
> 1908                            bt->start_lba = value;
> 1909                    else if (attr == &dev_attr_end_lba)
> ```
>
> Added a reassignment with RCU annotation to fix the issue.
>
> Fixes: c780e86dd48 ("blktrace: Protect q->blk_trace with RCU")
>
> Signed-off-by: Cengiz Can <cengiz@kernel.wtf>
> ---
>
>     Patch Changelog
>     * v2: Added RCU annotation to assignment
>
>  kernel/trace/blktrace.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
> index 4560878f0bac..ca39dc3230cb 100644
> --- a/kernel/trace/blktrace.c
> +++ b/kernel/trace/blktrace.c
> @@ -1896,8 +1896,11 @@ static ssize_t sysfs_blk_trace_attr_store(struct device *dev,
>         }
>
>         ret = 0;
> -       if (bt == NULL)
> +       if (bt == NULL) {
>                 ret = blk_trace_setup_queue(q, bdev);
> +               bt = rcu_dereference_protected(q->blk_trace,
> +                               lockdep_is_held(&q->blk_trace_mutex));
> +       }
>
>         if (ret == 0) {
>                 if (attr == &dev_attr_act_mask)
> --
> 2.25.1
>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming Lei
