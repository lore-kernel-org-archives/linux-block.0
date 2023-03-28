Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D84E9C76196
	for <linux-block@archiver.kernel.org>; Tue, 28 Mar 2023 15:12:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbjC1PMf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Mar 2023 11:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232398AbjC1PM1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Mar 2023 11:12:27 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456D3E3AC
        for <linux-block@vger.kernel.org>; Tue, 28 Mar 2023 08:12:05 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id p15so15447154ybl.9
        for <linux-block@vger.kernel.org>; Tue, 28 Mar 2023 08:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680016194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g+YmdZ2KifzhfvJEdg7p7f3TJNPgCoNZqPs2Cx2ndxo=;
        b=QxwODGEreqDxcIBzupdiBDMaDhVMLLzdv5CfZ77spG0lhFRud2y5nLrWzzAe/C6t7j
         ZOeI1MwZhgbHKufRmNFroSj3WemqRteMnB4I3zgWlrAqlMt2LkDL2uFa+Q4rzDU1486c
         dNNfXBmijmlYD705lBNf01BTyrCyDOrSF9RzPetnYAB3AYPpNLJYWV3MaUX8PnUEt/zX
         ZWmL0MYGGLpvauhUzo75H6kPcjwi3fp70mN3e4rJpmVhTv/25ZngEpNST6bZiJzZmjXl
         eT2y5J/uzC+53+JC7JZ5kq/eruzL0a+NXlhHEm6lqmXJr8zdho9ORG1Eq0Et9AmoG2T8
         Vnpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680016194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g+YmdZ2KifzhfvJEdg7p7f3TJNPgCoNZqPs2Cx2ndxo=;
        b=bZHWquspYruV3Vjluxh4dNIwLw1LXW4PetCRuol9XzRMZk2F8AAfE48Vm3wV3MxF1+
         LkT+24glIt4lbz84jVWKK+7AwodW2HcW+HVpQT+KJJtHjNxfrV62MPKyfA64q8ETOrhA
         JI1akq8f4lIDCApfhKdzmhhRlmAhTNAje6eJzJrwNWJhSmNRfIfxtTW9j2lQyZV2xYlc
         AtKCu6M8LaVQE5uynDMslw8CXTejoVhAaoeCM3lmMCYlo7V50nXwsRE12HykYO65m6b+
         qd/NLGCUvCaSBN6r2ADgs7Cv9b7ewUoY/2yn1SEnAQiQqyyw40DTNC93JS33vB9R+7o4
         6t9A==
X-Gm-Message-State: AAQBX9csWIUKpRrf9hCbobp5S00YdltdozcCKxh78I6Heq4IMd6pTE0i
        pgM3hKIN1SZzMTh9KWY+TN9z10XHsLQEFOkdqmcdTQ==
X-Google-Smtp-Source: AKy350Zye7Uz+A9wXvm0bc/VbyhY+/GQhhowJbGOvGnmquTK5nbpQG/LFKJZLvFUfYERcKgtllJiz9XGHkAhkgNpcPs=
X-Received: by 2002:a25:2749:0:b0:a99:de9d:d504 with SMTP id
 n70-20020a252749000000b00a99de9dd504mr10160590ybn.12.1680016193782; Tue, 28
 Mar 2023 08:09:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230328061638.203420-1-yosryahmed@google.com> <20230328061638.203420-7-yosryahmed@google.com>
In-Reply-To: <20230328061638.203420-7-yosryahmed@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 28 Mar 2023 08:09:43 -0700
Message-ID: <CALvZod7ekQD-ygrv2M-QZzDFVTj7O-v7iCYOHKp3iqG6c-Rt1g@mail.gmail.com>
Subject: Re: [PATCH v1 6/9] memcg: sleep during flushing stats in safe contexts
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 27, 2023 at 11:16=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>
> Currently, all contexts that flush memcg stats do so with sleeping not
> allowed. Some of these contexts are perfectly safe to sleep in, such as
> reading cgroup files from userspace or the background periodic flusher.
>
> Refactor the code to make mem_cgroup_flush_stats() non-atomic (aka
> sleepable), and provide a separate atomic version. The atomic version is
> used in reclaim, refault, writeback, and in mem_cgroup_usage(). All
> other code paths are left to use the non-atomic version. This includes
> callbacks for userspace reads and the periodic flusher.
>
> Since refault is the only caller of mem_cgroup_flush_stats_ratelimited(),
> this function is changed to call the atomic version of
> mem_cgroup_flush_stats(). Reclaim and refault code paths are modified
> to do non-atomic flushing in separate later patches -- so
> mem_cgroup_flush_stats_ratelimited() will eventually become non-atomic.
>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Acked-by: Shakeel Butt <shakeelb@google.com>
