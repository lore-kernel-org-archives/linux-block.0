Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CABC07E96
	for <linux-block@archiver.kernel.org>; Thu,  8 Jul 2021 14:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1152B61625
	for <linux-block@archiver.kernel.org>; Thu,  8 Jul 2021 14:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbhGHOoV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Jul 2021 10:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbhGHOoU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Jul 2021 10:44:20 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E34FC061574
        for <linux-block@vger.kernel.org>; Thu,  8 Jul 2021 07:41:38 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id v17so2890423qvw.12
        for <linux-block@vger.kernel.org>; Thu, 08 Jul 2021 07:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9OuGskVqA2qusAP0EWtWMxQD5LYCBw1WUf1Elc9qMZ0=;
        b=q9yEr1XkfLFq2WNWb//fqgYRseHjthIob6iCW5BLrBihWVxihn4suavcPiju0NvtcR
         BBvXE4CMvobC/U4bgkY47QW5odld6P9cjVncRWcO6+sonTGnDjrbMKxJXnTuvDBaIQJE
         SINXMexhzXc6KbzKLoi4iKmAoKgSxMDXYSImX47jlU0u/qTrbZ0kCyPuoi9zaavSE7nf
         xXdDbHXWbdJzRAETQkSceLj6W7e+oj94ZM5KhPpWDnCW6mvzlp2tBLFp0fDJ0cGdkvyo
         m4cCcfCLHLUXI1GISeSv8WqdRsuEofNYXeyyWAH9Zv1ZlqSOwa+1AwmaiFFtpvqE9LEj
         pXew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9OuGskVqA2qusAP0EWtWMxQD5LYCBw1WUf1Elc9qMZ0=;
        b=FH/RIAKtfYskjurIXZi7oHtTvdoNeCcK1uy7vNaMStI/uDkcRfS4E5B75kVdxKGZEz
         n7n9mLAhyBqcfwSMGx2uFZg/x64g6YZNaF4/eGDfy/asjDDcZI5/Jpmi/t2sEyFGrT8f
         Rd0dG6PztaskxKfT7IXwVk13b+rilDQvMfEw3ICbzoJDagCax9BVnaRvqJCX08+OeKs1
         KMEnaJDdnf/uT/i7pwRDmVMCNxwqGTMsYQFLFV5oCRbziTRBZI0e7hsolpm/1INemBDF
         2iWUQUyYkRJYOEnXO01PIerPNseUhZjgyR9+trz9NRYcOcSAlMufY85O6+a26NrDl2P1
         d+rg==
X-Gm-Message-State: AOAM532UrpEytQoH9X01ribCDtnoicJONfUOloT1dZp2r5jLSq+1mw9V
        wQSOgO0V9gkNJazgRWIxp3DICct06V0=
X-Google-Smtp-Source: ABdhPJxImlYJbXtn1Gzxkylzgpwmg1UUFdqldqJfPhVGKQJXOwnCEUun503NriWSZaNhl9LcGdJhYQ==
X-Received: by 2002:a0c:cb8f:: with SMTP id p15mr30828096qvk.13.1625755297290;
        Thu, 08 Jul 2021 07:41:37 -0700 (PDT)
Received: from dschatzberg-fedora-PC0Y6AEN ([2620:10d:c091:480::1:ee15])
        by smtp.gmail.com with ESMTPSA id p64sm1078876qka.114.2021.07.08.07.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 07:41:36 -0700 (PDT)
Date:   Thu, 8 Jul 2021 10:41:34 -0400
From:   Dan Schatzberg <schatzberg.dan@gmail.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Subject: Re: [PATCH 6/6] loop: don't add worker into idle list
Message-ID: <YOcOnlqMMX1K+heE@dschatzberg-fedora-PC0Y6AEN>
References: <20210705102607.127810-1-ming.lei@redhat.com>
 <20210705102607.127810-7-ming.lei@redhat.com>
 <YORg2KYF7X1ZYJPG@dschatzberg-fedora-PC0Y6AEN>
 <YOUdMjAzEw6JQjKG@T590>
 <YOWyVnrOTHvMB7A3@dschatzberg-fedora-PC0Y6AEN>
 <YOaiHLD74VG5I5cD@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YOaiHLD74VG5I5cD@T590>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 08, 2021 at 02:58:36PM +0800, Ming Lei wrote:
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 146eaa03629b..3cd51bddfec9 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -980,7 +980,6 @@ static struct loop_worker *loop_alloc_or_get_worker(struct loop_device *lo,
>  
>  static void loop_release_worker(struct loop_worker *worker)
>  {
> -	xa_erase(&worker->lo->workers, worker->blkcg_css->id);
>  	css_put(worker->blkcg_css);
>  	kfree(worker);

Another thought - do you need to change the kfree here to kfree_rcu?
I'm concerned about the scenario where loop_queue_work's xa_load finds
the worker and subsequently __loop_free_idle_workers erases and calls
loop_release_worker. If the worker is freed then the subsequent
refcount_inc_not_zero in loop_queue_work would be a use after free.
