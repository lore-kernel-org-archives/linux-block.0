Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:37472 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754966AbdK1LVA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Nov 2017 06:21:00 -0500
Received: by mail-it0-f65.google.com with SMTP id m191so545427itg.2
        for <linux-block@vger.kernel.org>; Tue, 28 Nov 2017 03:21:00 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1511271770-3444-15-git-send-email-adrian.hunter@intel.com>
References: <1511271770-3444-1-git-send-email-adrian.hunter@intel.com> <1511271770-3444-15-git-send-email-adrian.hunter@intel.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 28 Nov 2017 12:20:58 +0100
Message-ID: <CAPDyKFpHawL2UNUNC_pWE-7Su_nhJkTNUpJf9yyNJygGhi-uPw@mail.gmail.com>
Subject: Re: [PATCH V14 14/24] mmc: block: Add CQE support
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Bough Chen <haibo.chen@nxp.com>,
        Alex Lemberg <alex.lemberg@sandisk.com>,
        Mateusz Nowak <mateusz.nowak@intel.com>,
        Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Dong Aisheng <dongas86@gmail.com>,
        Das Asutosh <asutoshd@codeaurora.org>,
        Zhangfei Gao <zhangfei.gao@gmail.com>,
        Sahitya Tummala <stummala@codeaurora.org>,
        Harjani Ritesh <riteshh@codeaurora.org>,
        Venu Byravarasu <vbyravarasu@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 21 November 2017 at 14:42, Adrian Hunter <adrian.hunter@intel.com> wrote:
> Add CQE support to the block driver, including:
>     - optionally using DCMD for flush requests
>     - "manually" issuing discard requests
>     - issuing read / write requests to the CQE
>     - supporting block-layer timeouts
>     - handling recovery
>     - supporting re-tuning
>
> CQE offers 25% - 50% better random multi-threaded I/O.  There is a slight
> (e.g. 2%) drop in sequential read speed but no observable change to sequential
> write.
>
> CQE automatically sends the commands to complete requests.  However it only
> supports reads / writes and so-called "direct commands" (DCMD).  Furthermore
> DCMD is limited to one command at a time, but discards require 3 commands.
> That makes issuing discards through CQE very awkward, but some CQE's don't
> support DCMD anyway.  So for discards, the existing non-CQE approach is
> taken, where the mmc core code issues the 3 commands one at a time i.e.
> mmc_erase(). Where DCMD is used, is for issuing flushes.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

This looks good to me!

I only have one, very minor comment.

[...]

> @@ -370,10 +514,14 @@ static int mmc_mq_init_queue(struct mmc_queue *mq, int q_depth,
>  static int mmc_mq_init(struct mmc_queue *mq, struct mmc_card *card,
>                          spinlock_t *lock)
>  {
> +       struct mmc_host *host = card->host;
>         int q_depth;
>         int ret;
>
> -       q_depth = MMC_QUEUE_DEPTH;
> +       if (mq->use_cqe)
> +               q_depth = min_t(int, card->ext_csd.cmdq_depth, host->cqe_qdepth);

To make it clear why this is needed, could you please add some comment
in the code?

As I was trying to point out in the other reply about queue depth, for
patch 13, this is weird to me.
This may mean that we end up using queue_depth being less than
MMC_QUEUE_DEPTH (64) for the CQE case. While in fact, in the CQE case
the HW actually supports a bigger queue depth, comparing when not
using CQE.

Anyway, it seems like that will have to be a separate topic to discuss
with the blkmq experts.

> +       else
> +               q_depth = MMC_QUEUE_DEPTH;
>

[...]

Kind regards
Uffe
