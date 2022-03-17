Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ADFDC4332F
	for <linux-block@archiver.kernel.org>; Thu, 17 Mar 2022 14:38:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235158AbiCQOj3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Mar 2022 10:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235176AbiCQOj2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Mar 2022 10:39:28 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C8F1D7
        for <linux-block@vger.kernel.org>; Thu, 17 Mar 2022 07:38:10 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id kk16so4336452qvb.5
        for <linux-block@vger.kernel.org>; Thu, 17 Mar 2022 07:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yP0GEERmg+gekJvxp+uB8AUa2onLOGM0vbCk2TqKeRk=;
        b=VAlfwx0nipniBukz5DvmaYOZ4aO9n8lZDOf1TB++McFoV+terV+pr9ObG0wk4DgqO3
         +E4vds/udbOWySSzaoBbZ2XboMNejXk4kn1ENoaJgSuiFTMAHkN50LHiUWewcg51+n1L
         YUlO1ucIeN8DFiQH8XXqFJZs5pIfJIaYJQgEVgO4prhy1JO9C/4fLjbdnsCo19KtO3dP
         3g5LwxOs2ZLBMDwhg5EhEuTBTBq1Ry/uOjDL0HQCJPdjKIrYPjKoUN8PVqtrITpx4UzF
         VNOzteAUKbC1O6kHgT9ThP12nrfL48cY84k79y1lqjQlQIOc8EsqJ8W0Dhdj7AsjTpTs
         GKmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yP0GEERmg+gekJvxp+uB8AUa2onLOGM0vbCk2TqKeRk=;
        b=zrqLorc++f4P0USOG3qpmnmk035QXz3lxUAPUCYlsM/TVI1+4vXrdYAVfT3Ga/MN2X
         WWICLcVslSHHkoW8omQ5PmnuaFVye27ANLI03az3CPsw4t0cMgl6yloBmEvdgD35P6X2
         7mJmLYq8iLWFHJ9NjQNqJU0eIKYyn57TMTW5FzRWMVm1CLLRcPZj6BgS7Z3EHmiR/77d
         Cvg1I6PP4ayAvLSjHPyicTimM2BivrB4JACB0qYuKu7C3xQjqtE/8TrOXOCH3QBs6bEw
         KjoWcVDb3Yk0NRLbyDebo9WwfhQJ7GG6SBGYhYmYH04B/H0EESEuCu/6Kwu6OE/NGlZP
         EiwA==
X-Gm-Message-State: AOAM533sgZuUNJiuH8YIUqDV0IxV1RmXhSeTGs8m2Ybjx9XBp67yJ7Ev
        biERmHYJjRgNXKHEjsEglUI=
X-Google-Smtp-Source: ABdhPJxodFdiC3m373ic6h4qlwUlBCBekqRhqWw5k7SoJHRMRtWpJpMjIYZYHeDjpCfGugoXD3vwEQ==
X-Received: by 2002:a05:6214:508b:b0:440:cd70:2789 with SMTP id kk11-20020a056214508b00b00440cd702789mr3848075qvb.21.1647527889436;
        Thu, 17 Mar 2022 07:38:09 -0700 (PDT)
Received: from dschatzberg-fedora-PC0Y6AEN.dhcp.thefacebook.com ([2620:10d:c091:500::38ca])
        by smtp.gmail.com with ESMTPSA id 11-20020ac8590b000000b002e1e5c5c866sm3921743qty.42.2022.03.17.07.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 07:38:08 -0700 (PDT)
Date:   Thu, 17 Mar 2022 10:38:07 -0400
From:   Dan Schatzberg <schatzberg.dan@gmail.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: [PATCH] loop: add WQ_MEM_RECLAIM flag to per device workqueue
Message-ID: <YjNHzyTFHjh9v6k4@dschatzberg-fedora-PC0Y6AEN.dhcp.thefacebook.com>
References: <e0a0bc94-e6de-b0e5-ee46-a76cd1570ea6@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0a0bc94-e6de-b0e5-ee46-a76cd1570ea6@I-love.SAKURA.ne.jp>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 17, 2022 at 11:08:04PM +0900, Tetsuo Handa wrote:
> Commit 87579e9b7d8dc36e ("loop: use worker per cgroup instead of kworker")
> again started using per device workqueue
> 
> -       lo->worker_task = kthread_run(loop_kthread_worker_fn,
> -                       &lo->worker, "loop%d", lo->lo_number);
> +       lo->workqueue = alloc_workqueue("loop%d",
> +                                       WQ_UNBOUND | WQ_FREEZABLE,
> +                                       0,
> +                                       lo->lo_number);
> 
> but forgot to restore WQ_MEM_RECLAIM flag.

Early versions of the patch did have WQ_MEM_RECLAIM but it was
removed. I looked up my notes and found this:

Changes since V11:

* Removed WQ_MEM_RECLAIM flag from loop workqueue. Technically, this
  can be driven by writeback, but this was causing a warning in xfs
  and likely other filesystems aren't equipped to be driven by reclaim
  at the VFS layer.

I don't know if this is still the case. Can you test it?

> I don't know why WQ_FREEZABLE flag was added

My memory here is hazy and I don't have it in my notes but the same is
done in block/blk-cgroup.c which is conceptually quite similar.
