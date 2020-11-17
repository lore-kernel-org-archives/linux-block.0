Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E65A7C2D0E4
	for <linux-block@archiver.kernel.org>; Tue, 17 Nov 2020 05:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99C24246A6
	for <linux-block@archiver.kernel.org>; Tue, 17 Nov 2020 05:00:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s/5PWRS3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbgKQE77 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Nov 2020 23:59:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbgKQE77 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Nov 2020 23:59:59 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172DEC0613CF
        for <linux-block@vger.kernel.org>; Mon, 16 Nov 2020 20:59:58 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id m65so14806450qte.11
        for <linux-block@vger.kernel.org>; Mon, 16 Nov 2020 20:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jIZe3aqnqUW1D2RnLNt7mDnJkN6RBt9yKmzg8PymAYk=;
        b=s/5PWRS3hFbCrs2TZwdNjGJCrbHghWu3Zo8PjdUQBABq35bVytQQRSovIxzyknl8sO
         5it2cLYyGMzgN7Z33wsNII1wQormYZq1vhfHBbKsRDeyGCiPeEYGFkaYz0MsBJjewW2X
         1zSSKIU5zo4RUzHLjyuOfcfDF+vHOj0Z3fghMR1jsuhmCa9M4cBaxuCfmNgbAk5bFQmF
         JibZePt12+s6DR4XzEem6xOVXDDdaFbF/UlWXIKps1iz/9m1QFwg5m3Ne5fItWkhvOUd
         lUf7sziuWBm/sj9Rt1YwvggtjZ/c+FowlCSbo2nJUZf22dMF80poMc0kR2hWQMgeUmPE
         jgMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jIZe3aqnqUW1D2RnLNt7mDnJkN6RBt9yKmzg8PymAYk=;
        b=r7m+JJnbY1nJJit817Ty9AiKFb6QZXCYyyKx9LtuL5x9dpQh6Ej+cYJ8VzsV/9v69V
         e/15FhBOz9Cq+EwBqn/kWuSVoxLBSAbFlL6geRWS61FKLSjR1BpUZonDHF55vtIOXgxC
         ehm3mYnljxaTbZKYPiPRvDciHB8x+wwlOCWdlNNuUnv4X3P6yCl8/mgs3J4qAuS98L73
         i/itmnfaaKg6PXIKF8guzvB0ImivtLEU0rae2+vm+5kFzfMRIcNhMlwgE7TJi1J06a1+
         xZ0SH0nxQGyF4Gf1lXsE09qc5asSX5ELquiaL9UgGs/T9gqyYZyKdvdpUNfufgCAuIoG
         Jmmg==
X-Gm-Message-State: AOAM5310zI7QNSmwWQmMv791WUesInljKRsGSGhMIoLB8hA6vJKf8le7
        FOiYhgnWzG0sjaygqscCTyU48hV/htiwCIAB/6kVesJV
X-Google-Smtp-Source: ABdhPJwVQoISSYbN1NKBfweQLJEKV3Xs6kUQaO+4F+HnLnSWsCTGtTp8INHKTwO0PLPzYWnhRADB8lIYamT2mX/qKQg=
X-Received: by 2002:aed:2091:: with SMTP id 17mr17366908qtb.342.1605589197077;
 Mon, 16 Nov 2020 20:59:57 -0800 (PST)
MIME-Version: 1.0
References: <20201027045411.GA39796@192.168.3.9> <CAA70yB7bepwNPAMtxth8qJCE6sQM9vxr1A5sU8miFn3tSOSYQQ@mail.gmail.com>
 <CAA70yB6caVcKjJOTkEZa9ZBzZAHPgYrsr9nZWDgm-tfPMLGXHQ@mail.gmail.com> <20201117032756.GE56247@T590>
In-Reply-To: <20201117032756.GE56247@T590>
From:   Weiping Zhang <zwp10758@gmail.com>
Date:   Tue, 17 Nov 2020 12:59:46 +0800
Message-ID: <CAA70yB4G_1jHYRyVsf_mhHQA-_mGXzaZ6n4Bgtq9n-x1_Yz4rg@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] fix inaccurate io_ticks
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>,
        mpatocka@redhat.com, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 17, 2020 at 11:28 AM Ming Lei <ming.lei@redhat.com> wrote:
>
> On Tue, Nov 17, 2020 at 11:01:49AM +0800, Weiping Zhang wrote:
> > Hi Jens,
> >
> > Ping
>
> Hello Weiping,
>
> Not sure we have to fix this issue, and adding blk_mq_queue_inflight()
> back to IO path brings cost which turns out to be visible, and I did
> get soft lockup report on Azure NVMe because of this kind of cost.
>
Have you test v5, this patch is different from v1, the v1 gets
inflight for each IO,
v5 has changed to get inflight every jiffer.

If for v5, can we reproduce it on null_blk ?

> BTW, suppose the io accounting issue needs to be fixed, just wondering
> why not simply revert 5b18b5a73760 ("block: delete part_round_stats and
> switch to less precise counting"), and the original way had been worked
> for decades.
>
This patch is more better than before, it will break early when find there is
inflight io on any cpu, for the worst case(the io in running on the last cpu),
it iterates all cpus.
>
> Thanks,
> Ming
>
