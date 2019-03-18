Return-Path: <SRS0=WbMh=RV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADE6C43381
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 11:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DC1120449
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 11:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="Ux84M31U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfCRLyR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Mar 2019 07:54:17 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:43750 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbfCRLyR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Mar 2019 07:54:17 -0400
Received: by mail-ua1-f65.google.com with SMTP id g1so5162596uae.10
        for <linux-block@vger.kernel.org>; Mon, 18 Mar 2019 04:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UWIgtaBTx/cGkZxRdCsvJktUAeoApAS04db/lUrIZc8=;
        b=Ux84M31UMQiq0zWlbe7D6c8SiTG5Buf7fivSipGefo8vUoTqSEXl7HMVijKe0LXLjz
         uWkFkKtc/NJTD2U8VHI6CsSgaRPjB7GYbPknIl8PjL8P67O0c4Fdsa8X/DyY0sGGkc4U
         7XHxf4sB1tvyDPEmCHS/XB3HvAmd21W/vNbk+g1OXUJxcFl7b4poulOTsbS8/xZraV4g
         DcUAnB6f7NiPbPRlnqt6vyOz0/M0aICCdrft0Qly+YLUDHS2zz6bek544r4sQroiz/ZP
         x2/97MSS9M/3QA0wJVLKf+HEbr2zVljNsBqhTnzsHFjUwiAO3uD1VFXpBz0TmxRmvsl9
         ewUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UWIgtaBTx/cGkZxRdCsvJktUAeoApAS04db/lUrIZc8=;
        b=sLOVsyNA8J+9NkctMWfWkpgAdGrh9xXwNjr1rZJlREzqBd9capyEimZzVn3ABPykcw
         pUWtb/mgE3a0zsp+HE1ObjQ8gHtDXJgr51Rg2vPPrrSFsvZ6223varQLzCTBiC4l0D4B
         2jl+OeLGWxSR8RzoC0+I6W1M9oBr1yT3nR45tn4NIO1CPmNZbGTaCXseAQrq4jP9XK3w
         xOz53ucnKwa61oN20Cju03frgoz7IisM4IoBa1Etjl0puwYPxlxLLO8v7V2r5Ana2H9U
         VoN/QvVGdrmgiJSAgBTJMJ/aAQxjWfZeoZGoETK1ilQqp77fzJp2sgUrLjiWqMIG14jI
         hynA==
X-Gm-Message-State: APjAAAWdc6g9oc6ElsaXFf3BEDLQnxeG/D+uhLEj5nCoT7tFtIq4s+Ak
        QwwTEtiZ5WDunj8nW29yaqoxa8d+lIJ3JNJ/WQVP0A==
X-Google-Smtp-Source: APXvYqxm4vfXewSLJRBVq+VYEWXb0snOEVsDAqv+/KLXStwIJfvw1Gvt4w8fwW7QwISWPTZm6xFRC0qICMT2GV0oHJc=
X-Received: by 2002:ab0:2885:: with SMTP id s5mr4753027uap.39.1552910055926;
 Mon, 18 Mar 2019 04:54:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190314160428.3559-1-igor.j.konopko@intel.com> <20190314160428.3559-6-igor.j.konopko@intel.com>
In-Reply-To: <20190314160428.3559-6-igor.j.konopko@intel.com>
From:   Hans Holmberg <hans@owltronix.com>
Date:   Mon, 18 Mar 2019 12:54:05 +0100
Message-ID: <CANr-nt0528Kkmtg3ssT0xOY59_SwQboQaMQvN=+OdvpGhLKf7w@mail.gmail.com>
Subject: Re: [PATCH 05/18] lightnvm: pblk: propagate errors when reading meta
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

Nice!

Reviewed-by: Hans Holmberg <hans.holmberg@cnexlabs.com>

On Thu, Mar 14, 2019 at 5:07 PM Igor Konopko <igor.j.konopko@intel.com> wrote:
>
> Currently when smeta/emeta/oob is read errors are not always propagated
> correctly. This patch changes that behaviour and propagates all the
> error codes except of high ecc read warning status.
>
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> ---
>  drivers/lightnvm/pblk-core.c     | 9 +++++++--
>  drivers/lightnvm/pblk-recovery.c | 2 +-
>  2 files changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
> index 39280c1..38e26fe 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -761,8 +761,10 @@ int pblk_line_smeta_read(struct pblk *pblk, struct pblk_line *line)
>
>         atomic_dec(&pblk->inflight_io);
>
> -       if (rqd.error)
> +       if (rqd.error && rqd.error != NVM_RSP_WARN_HIGHECC) {
>                 pblk_log_read_err(pblk, &rqd);
> +               ret = -EIO;
> +       }
>
>  clear_rqd:
>         pblk_free_rqd_meta(pblk, &rqd);
> @@ -916,8 +918,11 @@ int pblk_line_emeta_read(struct pblk *pblk, struct pblk_line *line,
>
>         atomic_dec(&pblk->inflight_io);
>
> -       if (rqd.error)
> +       if (rqd.error && rqd.error != NVM_RSP_WARN_HIGHECC) {
>                 pblk_log_read_err(pblk, &rqd);
> +               ret = -EIO;
> +               goto free_rqd_dma;
> +       }
>
>         emeta_buf += rq_len;
>         left_ppas -= rq_ppas;
> diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
> index bcd3633..688fdeb 100644
> --- a/drivers/lightnvm/pblk-recovery.c
> +++ b/drivers/lightnvm/pblk-recovery.c
> @@ -450,7 +450,7 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
>         atomic_dec(&pblk->inflight_io);
>
>         /* If a read fails, do a best effort by padding the line and retrying */
> -       if (rqd->error) {
> +       if (rqd->error && rqd->error != NVM_RSP_WARN_HIGHECC) {
>                 int pad_distance, ret;
>
>                 if (padded) {
> --
> 2.9.5
>
