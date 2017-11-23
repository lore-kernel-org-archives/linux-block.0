Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:33978 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753304AbdKWSNL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Nov 2017 13:13:11 -0500
Received: by mail-io0-f193.google.com with SMTP id q101so27316801ioi.1
        for <linux-block@vger.kernel.org>; Thu, 23 Nov 2017 10:13:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1511271770-3444-5-git-send-email-adrian.hunter@intel.com>
References: <1511271770-3444-1-git-send-email-adrian.hunter@intel.com> <1511271770-3444-5-git-send-email-adrian.hunter@intel.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 23 Nov 2017 19:13:09 +0100
Message-ID: <CAPDyKFpGG2mFH7xDmZjK8DSvDiEBSvuUv+fYhHpYvc-WXQO7_w@mail.gmail.com>
Subject: Re: [PATCH V14 04/24] mmc: block: Ensure that debugfs files are removed
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
> The card is not necessarily being removed, but the debugfs files must be
> removed when the driver is removed, otherwise they will continue to exist
> after unbinding the card from the driver. e.g.
>
>   # echo "mmc1:0001" > /sys/bus/mmc/drivers/mmcblk/unbind
>   # cat /sys/kernel/debug/mmc1/mmc1\:0001/ext_csd
>   [  173.634584] BUG: unable to handle kernel NULL pointer dereference at 0000000000000050
>   [  173.643356] IP: mmc_ext_csd_open+0x5e/0x170
>
> A complication is that the debugfs_root may have already been removed, so
> check for that too.
>
> Fixes: 627c3ccfb46a ("mmc: debugfs: Move block debugfs into block module")
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks, applied for fixes and added a stable tag!

Kind regards
Uffe

> ---
>  drivers/mmc/core/block.c   | 44 +++++++++++++++++++++++++++++++++++++-------
>  drivers/mmc/core/debugfs.c |  1 +
>  2 files changed, 38 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 4a319ddbd956..ccfa98af1dd3 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -122,6 +122,10 @@ struct mmc_blk_data {
>         struct device_attribute force_ro;
>         struct device_attribute power_ro_lock;
>         int     area_type;
> +
> +       /* debugfs files (only in main mmc_blk_data) */
> +       struct dentry *status_dentry;
> +       struct dentry *ext_csd_dentry;
>  };
>
>  /* Device type for RPMB character devices */
> @@ -2653,7 +2657,7 @@ static int mmc_ext_csd_release(struct inode *inode, struct file *file)
>         .llseek         = default_llseek,
>  };
>
> -static int mmc_blk_add_debugfs(struct mmc_card *card)
> +static int mmc_blk_add_debugfs(struct mmc_card *card, struct mmc_blk_data *md)
>  {
>         struct dentry *root;
>
> @@ -2663,28 +2667,53 @@ static int mmc_blk_add_debugfs(struct mmc_card *card)
>         root = card->debugfs_root;
>
>         if (mmc_card_mmc(card) || mmc_card_sd(card)) {
> -               if (!debugfs_create_file("status", S_IRUSR, root, card,
> -                                        &mmc_dbg_card_status_fops))
> +               md->status_dentry =
> +                       debugfs_create_file("status", S_IRUSR, root, card,
> +                                           &mmc_dbg_card_status_fops);
> +               if (!md->status_dentry)
>                         return -EIO;
>         }
>
>         if (mmc_card_mmc(card)) {
> -               if (!debugfs_create_file("ext_csd", S_IRUSR, root, card,
> -                                        &mmc_dbg_ext_csd_fops))
> +               md->ext_csd_dentry =
> +                       debugfs_create_file("ext_csd", S_IRUSR, root, card,
> +                                           &mmc_dbg_ext_csd_fops);
> +               if (!md->ext_csd_dentry)
>                         return -EIO;
>         }
>
>         return 0;
>  }
>
> +static void mmc_blk_remove_debugfs(struct mmc_card *card,
> +                                  struct mmc_blk_data *md)
> +{
> +       if (!card->debugfs_root)
> +               return;
> +
> +       if (!IS_ERR_OR_NULL(md->status_dentry)) {
> +               debugfs_remove(md->status_dentry);
> +               md->status_dentry = NULL;
> +       }
> +
> +       if (!IS_ERR_OR_NULL(md->ext_csd_dentry)) {
> +               debugfs_remove(md->ext_csd_dentry);
> +               md->ext_csd_dentry = NULL;
> +       }
> +}
>
>  #else
>
> -static int mmc_blk_add_debugfs(struct mmc_card *card)
> +static int mmc_blk_add_debugfs(struct mmc_card *card, struct mmc_blk_data *md)
>  {
>         return 0;
>  }
>
> +static void mmc_blk_remove_debugfs(struct mmc_card *card,
> +                                  struct mmc_blk_data *md)
> +{
> +}
> +
>  #endif /* CONFIG_DEBUG_FS */
>
>  static int mmc_blk_probe(struct mmc_card *card)
> @@ -2724,7 +2753,7 @@ static int mmc_blk_probe(struct mmc_card *card)
>         }
>
>         /* Add two debugfs entries */
> -       mmc_blk_add_debugfs(card);
> +       mmc_blk_add_debugfs(card, md);
>
>         pm_runtime_set_autosuspend_delay(&card->dev, 3000);
>         pm_runtime_use_autosuspend(&card->dev);
> @@ -2750,6 +2779,7 @@ static void mmc_blk_remove(struct mmc_card *card)
>  {
>         struct mmc_blk_data *md = dev_get_drvdata(&card->dev);
>
> +       mmc_blk_remove_debugfs(card, md);
>         mmc_blk_remove_parts(card, md);
>         pm_runtime_get_sync(&card->dev);
>         mmc_claim_host(card->host);
> diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
> index 01e459a34f33..0f4a7d7b2626 100644
> --- a/drivers/mmc/core/debugfs.c
> +++ b/drivers/mmc/core/debugfs.c
> @@ -314,4 +314,5 @@ void mmc_add_card_debugfs(struct mmc_card *card)
>  void mmc_remove_card_debugfs(struct mmc_card *card)
>  {
>         debugfs_remove_recursive(card->debugfs_root);
> +       card->debugfs_root = NULL;
>  }
> --
> 1.9.1
>
