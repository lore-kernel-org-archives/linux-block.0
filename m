Return-Path: <SRS0=Zyuh=RU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B37C43381
	for <linux-block@archiver.kernel.org>; Sun, 17 Mar 2019 06:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 576C121738
	for <linux-block@archiver.kernel.org>; Sun, 17 Mar 2019 06:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j772X62a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbfCQGOV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 17 Mar 2019 02:14:21 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55386 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbfCQGOV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 17 Mar 2019 02:14:21 -0400
Received: by mail-wm1-f67.google.com with SMTP id 4so9934818wmf.5;
        Sat, 16 Mar 2019 23:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OsmxGvxHwRSGZ+/emJfD/r6bzJZ56d0CKBLKDddlMoo=;
        b=j772X62alTSLQMGqgME+WRNrSnmScpMqcpuj3MsYKw9/b0KyLtcMGR7RJFjebJvQZM
         ZypMsTI9omWNFIq+IzVjR7XYhElKE5pkav9XCXnZ84/nXCxHmsLLqBRG2FkpPAsF4GGK
         O5j0eo4EZ1CQ4OyhZ81ce4yy+/vmT3v2Se9HuIXHw1pE1tmZQPM69UOFcgkoR2wEGgCs
         0/7xaBTiFyELxhNeqQxz5NWcx5ZfHYrtn35P7vWO8kKUZX+gwPtycYR1zfr7/GSrjKy8
         XY7lAMSUq8IG2nmpAtsgah2xuYKiEpwooQ69SXJkdQLyFiKoxS4aEq75Ob/xRcQYQ0Mk
         hKjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OsmxGvxHwRSGZ+/emJfD/r6bzJZ56d0CKBLKDddlMoo=;
        b=fNRZWbv1fxq/QigeamQGWa5HgrOz6XABzAB6YbS8G6WJ8slltGwyLaE+lUjJGOqf7h
         WmtCRbY8Zi/zgaHo6Qyc7d/mnWWkmdfkVNilkCwFXgWNm4QeV5OeZg88DSR8z4bg45/N
         GZwhMDlpHeSgfpWGraF1HNLbLKMU5sixEPFDMD88m4qaHAZTY98NrtT7eV8ljMrr3TO6
         LkGBhKImg+SXCL2o1+4r6nFT2dIcGBJoh6o4TH/8KWEyloEqlFSstHX9B5yY0eoaYrST
         WpUNUidIApKpl+Z6BetWXqqMz59+WyvtZwx+zy61vXZgpMLWl4vN0fIkVLXPQuW9Wog9
         /KhQ==
X-Gm-Message-State: APjAAAV0d55XL+sY6ISna7ZtIBP92gam0Y5s67jf7HgIsRdtHcB1xVbZ
        5KtUToowBsT/rqvcJp/bE/H3uzoKfaU/GOiWde8=
X-Google-Smtp-Source: APXvYqyZ7HNiymKXZ7P8zYBk1bMR2cD5oswloxcGcnsM9PZDxNCZEJVY4Au9nFcWhIN8SQPyL2JMYT2PBCTnjUUfmbc=
X-Received: by 2002:a1c:ef1a:: with SMTP id n26mr7354603wmh.67.1552803259678;
 Sat, 16 Mar 2019 23:14:19 -0700 (PDT)
MIME-Version: 1.0
References: <1552640264-26101-1-git-send-email-jianchao.w.wang@oracle.com> <1552640264-26101-2-git-send-email-jianchao.w.wang@oracle.com>
In-Reply-To: <1552640264-26101-2-git-send-email-jianchao.w.wang@oracle.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Sun, 17 Mar 2019 14:14:06 +0800
Message-ID: <CACVXFVOa25+NWdb1RG0sWuLYyoZeYTcUupNryABfQfEvO7FiUA@mail.gmail.com>
Subject: Re: [PATCH 1/8] blk-mq: get rid of the synchronize_rcu in __blk_mq_update_nr_hw_queues
To:     Jianchao Wang <jianchao.w.wang@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.de>,
        Josef Bacik <josef@toxicpanda.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <keith.busch@intel.com>, jsmart2021@gmail.com,
        linux-block <linux-block@vger.kernel.org>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 15, 2019 at 5:07 PM Jianchao Wang
<jianchao.w.wang@oracle.com> wrote:
>
> In commit 530ca2c (blk-mq: Allow blocking queue tag iter callbacks),
> we try to get a non-zero q_usage_counter to avoid access hctxs that
> being modified. So the synchronize_rcu is useless and should be
> removed.
>
> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
> ---
>  block/blk-mq-tag.c | 4 +---
>  block/blk-mq.c     | 4 ----
>  2 files changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index 2089c6c..b792537 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -384,9 +384,7 @@ void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
>         /*
>          * __blk_mq_update_nr_hw_queues() updates nr_hw_queues and queue_hw_ctx
>          * while the queue is frozen. So we can use q_usage_counter to avoid
> -        * racing with it. __blk_mq_update_nr_hw_queues() uses
> -        * synchronize_rcu() to ensure this function left the critical section
> -        * below.
> +        * racing with it.
>          */
>         if (!percpu_ref_tryget(&q->q_usage_counter))
>                 return;
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 9437a5e..07584a9 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -3208,10 +3208,6 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>         list_for_each_entry(q, &set->tag_list, tag_set_list)
>                 blk_mq_freeze_queue(q);
>         /*
> -        * Sync with blk_mq_queue_tag_busy_iter.
> -        */
> -       synchronize_rcu();
> -       /*
>          * Switch IO scheduler to 'none', cleaning up the data associated
>          * with the previous scheduler. We will switch back once we are done
>          * updating the new sw to hw queue mappings.
> --
> 2.7.4
>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming Lei
