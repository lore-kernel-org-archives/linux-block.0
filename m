Return-Path: <SRS0=BuC1=RE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C7DCC43381
	for <linux-block@archiver.kernel.org>; Fri,  1 Mar 2019 13:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C9572084D
	for <linux-block@archiver.kernel.org>; Fri,  1 Mar 2019 13:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="vRlSxKu5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfCAN10 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Mar 2019 08:27:26 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:34131 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbfCAN10 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Mar 2019 08:27:26 -0500
Received: by mail-ua1-f67.google.com with SMTP id a42so22417913uad.1
        for <linux-block@vger.kernel.org>; Fri, 01 Mar 2019 05:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lC+nd+0o3HQjG4nBsKi2z+Hi4J67vMEEiN2Gpcw14t0=;
        b=vRlSxKu5Arc/tNmWdC/QWE/Mron9pjcnHGIcTYPK6+ueD00e379ZlMDA0p1Jo9jQfX
         uxb8CjaSL6GunB6B4nJQreUUDqUW31s1q5PgNp/JfSwa7nk6sb61gAYUgNkEMcoWi7i/
         TJ3v+sKQEoyQsOYH6sLm7XGdGJ/T8Gk/50HYOUkKIVYvJFBHpWVQ86cg1LL5AbL58n2U
         Tvjbl5KOt8fw+ziugLUjCfV2T//ln90fKhrjHqhmWO+TmbfjYI3Gzkh6gGsf9lk6GWkp
         rjn0fGwnPuxhq6tMBoY91RoAq4XvRKYjPo6x3Jw+4J0YeGpBdWNuy/3sx4EY2KIGVJ3F
         PNlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lC+nd+0o3HQjG4nBsKi2z+Hi4J67vMEEiN2Gpcw14t0=;
        b=a7zMMLq9cyQrdqwWfj5rQkBkLsRX9PWIWhiX/0ehqG6Jf8iS6iYqP9+s7jeZN9+rY8
         dcbEFXALnBpMNq5dlKZkjIbKLhisDRtloS3ViPS6MQscyvxcvMhVhFPiw5m+Jg4ehN8E
         Fzfq5e+Pm2llMPv3E+Z67bWK9Xc3Xr8bDCiI66aal1vm5cf4MSZF6absRkvjO46IQJp4
         /V0hl5WoLL3hPw1Lxx/zYtlbqdm2MZQ2jj63CnynMX8NTC73sDJRt/henhbzIvWO2/y8
         jysdfofe+ABcWejaMr8o5kBcWmRTNdSdL1WJGNl8PbrYhB7ThUpY7dDtCMlzJBSYnjh2
         jOeg==
X-Gm-Message-State: APjAAAWM7gp9aV0ZPeISHwIVpQ4Vqk5/JTmza9yYdJ6mNLT5KmUolSjO
        PnF64Wenb11diC8aQ1q7mLxQbBG2yuvkuCfhteUOBg==
X-Google-Smtp-Source: APXvYqwl4Xpl87+qm/3LJgMOFMXxqLZ5jENL5yLPuOUpCzptrogdgRtD+XbcuE8P5wcJX0ruHEEBnsus7iLWIrLGGNE=
X-Received: by 2002:a67:5fc7:: with SMTP id t190mr2432443vsb.184.1551446844930;
 Fri, 01 Mar 2019 05:27:24 -0800 (PST)
MIME-Version: 1.0
References: <20190227171442.11853-1-igor.j.konopko@intel.com> <20190227171442.11853-4-igor.j.konopko@intel.com>
In-Reply-To: <20190227171442.11853-4-igor.j.konopko@intel.com>
From:   Hans Holmberg <hans.ml.holmberg@owltronix.com>
Date:   Fri, 1 Mar 2019 14:27:14 +0100
Message-ID: <CANr-nt0=Mzvqi8Qt13L0d9GG1_RyZiQO3TZboP1==rkfuYjYLw@mail.gmail.com>
Subject: Re: [PATCH 03/13] lightnvm: pblk: Fix put line back behaviour
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

Looks good.

Reviewed-by: Hans Holmberg <hans.holmberg@cnexlabs.com>

On Wed, Feb 27, 2019 at 6:17 PM Igor Konopko <igor.j.konopko@intel.com> wrote:
>
> In current implementation of pblk_put_line_back behaviour
> there are two cases which are not handled.
>
> First one is the race condition with __pblk_map_invalidate in
> which function we check for line state, which might be closed,
> but still not added to any list and thus explode in list_move_tail.
> This is due to lack of locking both gc_lock and line lock
> in pblk_put_line_back current implementation.
>
> The second issue is that when we are in that function, line
> is not on any list and pblk_line_gc_list might hit the same
> gc group and thus not return any move_list. Then our line
> will stuck forever unassigned to any list. Simply resetting
> gc_list to none will fix that.
>
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> ---
>  drivers/lightnvm/pblk-gc.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/lightnvm/pblk-gc.c b/drivers/lightnvm/pblk-gc.c
> index 31fc1339faa8..511ed0d5333c 100644
> --- a/drivers/lightnvm/pblk-gc.c
> +++ b/drivers/lightnvm/pblk-gc.c
> @@ -64,19 +64,23 @@ static void pblk_put_line_back(struct pblk *pblk, struct pblk_line *line)
>         struct pblk_line_mgmt *l_mg = &pblk->l_mg;
>         struct list_head *move_list;
>
> +       spin_lock(&l_mg->gc_lock);
>         spin_lock(&line->lock);
>         WARN_ON(line->state != PBLK_LINESTATE_GC);
>         line->state = PBLK_LINESTATE_CLOSED;
>         trace_pblk_line_state(pblk_disk_name(pblk), line->id,
>                                         line->state);
> +
> +       /* We need to reset gc_group in order to ensure that
> +        * pblk_line_gc_list will return proper move_list
> +        * since right now current line is not on any of the
> +        * gc lists.
> +        */
> +       line->gc_group = PBLK_LINEGC_NONE;
>         move_list = pblk_line_gc_list(pblk, line);
>         spin_unlock(&line->lock);
> -
> -       if (move_list) {
> -               spin_lock(&l_mg->gc_lock);
> -               list_add_tail(&line->list, move_list);
> -               spin_unlock(&l_mg->gc_lock);
> -       }
> +       list_add_tail(&line->list, move_list);
> +       spin_unlock(&l_mg->gc_lock);
>  }
>
>  static void pblk_gc_line_ws(struct work_struct *work)
> --
> 2.17.1
>
