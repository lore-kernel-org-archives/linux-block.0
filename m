Return-Path: <SRS0=tltz=RJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A94D7C43381
	for <linux-block@archiver.kernel.org>; Wed,  6 Mar 2019 14:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70E432133F
	for <linux-block@archiver.kernel.org>; Wed,  6 Mar 2019 14:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="2MCQV9U/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfCFO11 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Mar 2019 09:27:27 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:36925 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbfCFO11 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Mar 2019 09:27:27 -0500
Received: by mail-vk1-f196.google.com with SMTP id 17so2850440vkf.4
        for <linux-block@vger.kernel.org>; Wed, 06 Mar 2019 06:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PY/vKWbLevwZogXwbi3lp6htS+loCS1PHtxiEuiT51s=;
        b=2MCQV9U/qQiRBb9XNIYdaWfYh/4GsBqSr3YhXAWgvwi+Tt+xBM/OSyH04fcdlQz/ZZ
         zMm7nUIGT0oTCWxs+/2dfY6Tbhh1l3J2HlX/KTJnr9vwDcHNNR4w3+BYV+HMmzfRDoNP
         8D+Pw05mij74qL69ztqjDll/OjRtpRpJVjPG5MTdC3RrF3jXQkrs6CRYL+dPKMsFty4Q
         KR4uCVuKV8uoNz+hekZ6tUi4qAUaCWjV7FpFuIVWJsPIBadOoEtfm9/LsfyDYcSNBkCF
         AOXZRKcebCqf0doigjz6JFt3ifRWs7k7gmyqn99TuDPiVOjJxxnqOrZ+QtkDP8LSqVtT
         adrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PY/vKWbLevwZogXwbi3lp6htS+loCS1PHtxiEuiT51s=;
        b=s1qkoylCJjDocrHnJTsEtwGbiRponNqbbC0VE38MxCIkIx+ZwMgodOnCvOcsNn7Zhc
         jK1ajw/frkdKKQckn5zWx2JIClhDevdCk9f+3gITvm/3BC0HGwF7znoX5vMLzyeno7za
         Pr4XsXp6tDFU52yP+qysc2S4bWh5LV/4n8UkvPmFuA75iRe5ws/Xu2OCRYz9X/KXg7UQ
         bfXlfxvCc5QQNDlYcp7tPBdNDMaSx7LtnPmEFSekG3M/Q/gtbWECNSz4PXUnlKb5JRsl
         nhu3sH+EVVtTCsXDXBoUIBrhk3DCevxDPngnT4qaahPLAZjKz1sXyEVCil1nqJKbgiNK
         JJIw==
X-Gm-Message-State: APjAAAWCJeWZvIpZsQdW21nEm0+1VxmWKsxQF9gdfjAc1rD796MtaVlr
        Fgt9HDLa6JdAGPppwt9x96LHp/TbIIsU3xH3OgfkTQ==
X-Google-Smtp-Source: APXvYqx3YX2g+f1HJeFhBEcED6m/PIcvzNs+I7xni/50X5yuWF2xiH59aD42puSpcHCGlP4WLr0xooPFtGi86YfpC+c=
X-Received: by 2002:a1f:84c4:: with SMTP id g187mr3320766vkd.47.1551882446009;
 Wed, 06 Mar 2019 06:27:26 -0800 (PST)
MIME-Version: 1.0
References: <20190305135120.29284-1-igor.j.konopko@intel.com> <20190305135120.29284-8-igor.j.konopko@intel.com>
In-Reply-To: <20190305135120.29284-8-igor.j.konopko@intel.com>
From:   Hans Holmberg <hans@owltronix.com>
Date:   Wed, 6 Mar 2019 15:27:15 +0100
Message-ID: <CANr-nt2M_miemdqpEyGJFNhbRDwVhYJgiToJ_kb4DvEvLqpg2Q@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] lightnvm: pblk: warn about opened chunk on factory init
To:     Igor Konopko <igor.j.konopko@intel.com>
Cc:     Matias Bjorling <mb@lightnvm.io>,
        =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 5, 2019 at 2:54 PM Igor Konopko <igor.j.konopko@intel.com> wrote:
>
> When we creating pblk instance with factory flag, there is a
> possibility that some chunks are in open state, which does not allow
> to issue erase request to them directly, based on OCSSD 2.0 spec.
> Still most of the controllers allows for such a transition, but it is
> not guaranteed that the particular drive will do so. This patch adds
> the proper warning during pblk factory creation to let user know about
> number of chunks in such a state, which can potentially be a reason
> of erase failures.
>
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> ---
>  drivers/lightnvm/pblk-core.c | 14 ++++++++++++++
>  drivers/lightnvm/pblk-init.c | 14 +++++++++++---
>  drivers/lightnvm/pblk.h      |  1 +
>  3 files changed, 26 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
> index 64280e6..4f16596 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -161,6 +161,20 @@ struct nvm_chk_meta *pblk_chunk_get_off(struct pblk *pblk,
>         return meta + ch_off + lun_off + chk_off;
>  }
>
> +int pblk_count_opened_chunks(struct pblk *pblk, struct nvm_chk_meta *meta)
> +{
> +       struct nvm_tgt_dev *dev = pblk->dev;
> +       struct nvm_geo *geo = &dev->geo;
> +       int i, cnt = 0;
> +
> +       for (i = 0; i < geo->all_luns; i++) {

Shouldn't this be i < geo->all_chunks ?

Otherwise the patch looks good.

Thanks,
Hans

> +               if (meta[i].state == NVM_CHK_ST_OPEN)
> +                       cnt++;
> +       }
> +
> +       return cnt;
> +}
> +
>  void __pblk_map_invalidate(struct pblk *pblk, struct pblk_line *line,
>                            u64 paddr)
>  {
> diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
> index 97b4c6e..f590f62 100644
> --- a/drivers/lightnvm/pblk-init.c
> +++ b/drivers/lightnvm/pblk-init.c
> @@ -1028,12 +1028,12 @@ static int pblk_line_meta_init(struct pblk *pblk)
>         return 0;
>  }
>
> -static int pblk_lines_init(struct pblk *pblk)
> +static int pblk_lines_init(struct pblk *pblk, bool factory_init)
>  {
>         struct pblk_line_mgmt *l_mg = &pblk->l_mg;
>         struct pblk_line *line;
>         void *chunk_meta;
> -       int nr_free_chks = 0;
> +       int nr_free_chks = 0, nr_opened_chks;
>         int i, ret;
>
>         ret = pblk_line_meta_init(pblk);
> @@ -1054,6 +1054,14 @@ static int pblk_lines_init(struct pblk *pblk)
>                 goto fail_free_luns;
>         }
>
> +       if (factory_init) {
> +               nr_opened_chks = pblk_count_opened_chunks(pblk, chunk_meta);
> +               if (nr_opened_chks) {
> +                       pblk_warn(pblk, "There are %d opened chunks\n",
> +                                 nr_opened_chks);
> +               }
> +       }
> +
>         pblk->lines = kcalloc(l_mg->nr_lines, sizeof(struct pblk_line),
>                                                                 GFP_KERNEL);
>         if (!pblk->lines) {
> @@ -1245,7 +1253,7 @@ static void *pblk_init(struct nvm_tgt_dev *dev, struct gendisk *tdisk,
>                 goto fail;
>         }
>
> -       ret = pblk_lines_init(pblk);
> +       ret = pblk_lines_init(pblk, flags & NVM_TARGET_FACTORY);
>         if (ret) {
>                 pblk_err(pblk, "could not initialize lines\n");
>                 goto fail_free_core;
> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> index 6c82776..c2f07ec 100644
> --- a/drivers/lightnvm/pblk.h
> +++ b/drivers/lightnvm/pblk.h
> @@ -795,6 +795,7 @@ struct nvm_chk_meta *pblk_get_chunk_meta(struct pblk *pblk);
>  struct nvm_chk_meta *pblk_chunk_get_off(struct pblk *pblk,
>                                               struct nvm_chk_meta *lp,
>                                               struct ppa_addr ppa);
> +int pblk_count_opened_chunks(struct pblk *pblk, struct nvm_chk_meta *_meta);
>  void pblk_log_write_err(struct pblk *pblk, struct nvm_rq *rqd);
>  void pblk_log_read_err(struct pblk *pblk, struct nvm_rq *rqd);
>  int pblk_submit_io(struct pblk *pblk, struct nvm_rq *rqd);
> --
> 2.9.5
>
