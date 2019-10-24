Return-Path: <SRS0=pYcy=YR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A8CDCA9EAF
	for <linux-block@archiver.kernel.org>; Thu, 24 Oct 2019 09:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E06D021872
	for <linux-block@archiver.kernel.org>; Thu, 24 Oct 2019 09:28:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zocy02oj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732786AbfJXJ22 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Oct 2019 05:28:28 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39058 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732234AbfJXJ22 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Oct 2019 05:28:28 -0400
Received: by mail-wr1-f68.google.com with SMTP id a11so9145951wra.6
        for <linux-block@vger.kernel.org>; Thu, 24 Oct 2019 02:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8UA9rvBXKqzunt9YvPW223KWbJI/xdtMxdehDNDRk4U=;
        b=Zocy02ojPk+XCIRAewnP4XdWFDUmZCh+BQvC3jqY11AEkrfOVZsYHO4C/Ho9fIJq/K
         vyZr2TYZELHqTOYppGTg8r7n7gYwIeFwHIJ+59QO0ty5MC1lfIxFAxAD0NwtoPjjxzAi
         tvQxwqqbOA3CseTbNjiyHpSDNXoOn3NxEXx8hdA+b74nyAef+OE6e4dfHraXCWXxOhIA
         V+l5nM/XtdpLttJwD+TuVUtE4klFY5/s26RgnybFPxIRZtlPhhiW9L5BLT3ZwYNa9Vmu
         pX8VV9qdNoJ0bOxQ/UiS8MJ5rbVK1Lfm/KzLhvJ8KlsrZ3zuto1aohWkgqOfHqKam7lt
         AZfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8UA9rvBXKqzunt9YvPW223KWbJI/xdtMxdehDNDRk4U=;
        b=dcgAU1Ag0mNp03mMsG7Oucdto28no7qYR9IYEj5MmJ34yVRiNbIhcSXcaCvoh3phBf
         oyrqSfhKyoWUjKIRJdLrA70FCxkBWpiTS44Ov/t/9r8+ngnV9ZMAjUfOdMn4riTMJNSi
         6e4y1H0JxHQhe5e8Cw5Hjhp77Qx70CeHryjn600wz8z+ZO9JzbkLPkJByI2lutFO1rJD
         HArmaqsomQPEHm7fIorZhzoB9JsMn2rAzpJqSS7bhPgP5Ex3DA2YwjArs4n7KMw/7M5A
         AN3wngn0WV2u3HK85NkPnr8lYmOecP63NT14yi1ETF5EdP/eBdCqzvDAd3ktBF87AcqR
         WIlg==
X-Gm-Message-State: APjAAAVMhODB7Cd+zj366fc3vj/EEdCf3SFhkZkYKKfB2lRs3h4tActQ
        SE4H9d87QGAw4Od14G12Or6+e81cjdQs2x6VcUM=
X-Google-Smtp-Source: APXvYqx9E2SPSx77YmEhrnoGHF+IYG+kXgd6HANTB3nwXcoeAXlyv9DF2hO18FaRqNW0kJn5Z920UqGbo84Hnk3QUsA=
X-Received: by 2002:adf:fc4c:: with SMTP id e12mr2638107wrs.179.1571909306354;
 Thu, 24 Oct 2019 02:28:26 -0700 (PDT)
MIME-Version: 1.0
References: <20191023175700.18615-1-jsmart2021@gmail.com>
In-Reply-To: <20191023175700.18615-1-jsmart2021@gmail.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Thu, 24 Oct 2019 17:28:14 +0800
Message-ID: <CACVXFVN+xXL9EJbrCPC50vOD0sG1pX1npUFSNZSNGBLyutLh0w@mail.gmail.com>
Subject: Re: [PATCH] blk-mq: Fix cpu indexing error in blk_mq_alloc_request_hctx()
To:     James Smart <jsmart2021@gmail.com>
Cc:     linux-block <linux-block@vger.kernel.org>,
        Shagun Agrawal <shagun.agrawal@broadcom.com>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Oct 24, 2019 at 4:53 PM James Smart <jsmart2021@gmail.com> wrote:
>
> During the following test scenario:
> - Offline a cpu
> - load lpfc driver, which auto-discovers NVMe devices. For a new
>   nvme device, the lpfc/nvme_fc transport can request up to
>   num_online_cpus() worth of nr_hw_queues. The target in
>   this case allowed at least that many of nvme queues.
> The system encountered the following crash:
>
>  BUG: unable to handle kernel paging request at 00003659d33953a8
>  ...
>  Workqueue: nvme-wq nvme_fc_connect_ctrl_work [nvme_fc]
>  RIP: 0010:blk_mq_get_request+0x21d/0x3c0
>  ...
>  Blk_mq_alloc_request_hctx+0xef/0x140
>  Nvme_alloc_request+0x32/0x80 [nvme_core]
>  __nvme_submit_sync_cmd+0x4a/0x1c0 [nvme_core]
>  Nvmf_connect_io_queue+0x130/0x1a0 [nvme_fabrics]
>  Nvme_fc_connect_io_queues+0x285/0x2b0 [nvme_fc]
>  Nvme_fc_create_association+0x0x8ea/0x9c0 [nvme_fc]
>  Nvme_fc_connect_ctrl_work+0x19/0x50 [nvme_fc]
>  ...
>
> There was a commit a while ago to simplify queue mapping which
> replaced the use of cpumask_first() by cpumask_first_and().
> The issue is if cpumask_first_and() does not find any _intersecting_ cpus,
> it return's nr_cpu_id. nr_cpu_id isn't valid for the per_cpu_ptr index
> which is done in __blk_mq_get_ctx().
>
> Considered reverting back to cpumask_first(), but instead followed
> logic in blk_mq_first_mapped_cpu() to check for nr_cpu_id before
> calling cpumask_first().
>
> Fixes: 20e4d8139319 ("blk-mq: simplify queue mapping & schedule with each possisble CPU")
> Signed-off-by: Shagun Agrawal <shagun.agrawal@broadcom.com>
> Signed-off-by: James Smart <jsmart2021@gmail.com>
> CC: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-mq.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 8538dc415499..0b06b4ea57f1 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -461,6 +461,8 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
>                 return ERR_PTR(-EXDEV);
>         }
>         cpu = cpumask_first_and(alloc_data.hctx->cpumask, cpu_online_mask);
> +       if (cpu >= nr_cpu_ids)
> +               cpu = cpumask_first(alloc_data.hctx->cpumask);

The first cpu may be offline too, then kernel warning or timeout may
be triggered later
when this allocated request is dispatched.

To be honest, blk_mq_alloc_request_hctx() is really a weird interface,
given the hctx may become
dead just when calling into blk_mq_alloc_request_hctx().

Given only NVMe FC/RDMA uses this interface, could you provide some
background about
this kind of usage?

The normal usage is that user doesn't specify the hctx for allocating
request from, since blk-mq
can figure out which hctx is used for allocation via queue mapping.
Just wondering why NVMe
FC/RDMA can't do that way?


Thanks,
Ming Lei
