Return-Path: <SRS0=/PDd=CJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C89E7C43461
	for <linux-block@archiver.kernel.org>; Mon, 31 Aug 2020 18:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB2C12083E
	for <linux-block@archiver.kernel.org>; Mon, 31 Aug 2020 18:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729282AbgHaSDn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:03:43 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:33998 "EHLO
        mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728651AbgHaSDm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Aug 2020 14:03:42 -0400
X-Greylist: delayed 596 seconds by postgrey-1.27 at vger.kernel.org; Mon, 31 Aug 2020 14:03:41 EDT
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id 8A25D1B44DF;
        Tue,  1 Sep 2020 02:53:43 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.15.2/8.15.2/Debian-20) with ESMTPS id 07VHrgIn366747
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 1 Sep 2020 02:53:43 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.15.2/8.15.2/Debian-20) with ESMTPS id 07VHrgsO3468084
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 1 Sep 2020 02:53:42 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.15.2/8.15.2/Submit) id 07VHrgCs3468083;
        Tue, 1 Sep 2020 02:53:42 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] block: ensure bdi->io_pages is always initialized
References: <346e5bf5-b08e-84e8-7b0e-c6cb0c814f96@kernel.dk>
Date:   Tue, 01 Sep 2020 02:53:41 +0900
In-Reply-To: <346e5bf5-b08e-84e8-7b0e-c6cb0c814f96@kernel.dk> (Jens Axboe's
        message of "Mon, 31 Aug 2020 11:23:32 -0600")
Message-ID: <878sdu66sa.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jens Axboe <axboe@kernel.dk> writes:

> If a driver leaves the limit settings as the defaults, then we don't
> initialize bdi->io_pages. This means that file systems may need to
> work around bdi->io_pages == 0, which is somewhat messy.
>
> Initialize the default value just like we do for ->ra_pages.
>
> Cc: stable@vger.kernel.org
> Reported-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

When queued to submit, please let us know to drop fatfs workaround
"fat-avoid-oops-when-bdi-io_pages==0.patch" in akpm series.

Thanks.

> ---
>
> diff --git a/block/blk-core.c b/block/blk-core.c
> index d9d632639bd1..10c08ac50697 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -539,6 +539,7 @@ struct request_queue *blk_alloc_queue(int node_id)
>  		goto fail_stats;
>  
>  	q->backing_dev_info->ra_pages = VM_READAHEAD_PAGES;
> +	q->backing_dev_info->io_pages = VM_READAHEAD_PAGES;
>  	q->backing_dev_info->capabilities = BDI_CAP_CGROUP_WRITEBACK;
>  	q->node = node_id;

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
