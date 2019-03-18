Return-Path: <SRS0=WbMh=RV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C9F0C43381
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 11:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C3CA2084F
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 11:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="BIOXQuV3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfCRL4H (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Mar 2019 07:56:07 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:36588 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbfCRL4H (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Mar 2019 07:56:07 -0400
Received: by mail-vs1-f66.google.com with SMTP id n4so158381vsm.3
        for <linux-block@vger.kernel.org>; Mon, 18 Mar 2019 04:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hwP9CmOfO6HY/R/Wgj00EInE+LO8JuUWUv0/yGV2EaQ=;
        b=BIOXQuV3AltW1ai1zCqSQEOgC9d23SQJe0bAWhjMdMmOI7qoZdasOeTjl0o2uftNF8
         1C3JBg7HkmOTQyKlSgtlsrgN3RFduB/JS7XalZIL0XNCyt5a3R5ev84agOgkx+3axqOV
         lEtmw+t8s0s3ztMYydGwxj9A71K7ZtleX4+VItAoxCDgcC0iOpAjZnLeJBdRlrz4nIFN
         k5DJQMQJW7F4bviak7F2pfvYzD5u04SkfcZ6PCrZEWjRn4eqLyYwy+0qLn0/OpcFAKNd
         JYNfbGHGPUpT5F11iiidInT4y0BYl3WqprPVNY/Xhuoosef0yeouH2iKsZPhJRzHkFtg
         ud7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hwP9CmOfO6HY/R/Wgj00EInE+LO8JuUWUv0/yGV2EaQ=;
        b=J3RbZIaml8yG0AyDDZU0utldiukkKMbNUsNH4gUbASPvtL3NhGPNFN1Kz6oLet7QKM
         RoWzkFX5Y+LAe0LMLJ1YpRvGzLgpst9ePnKjAIeVh0u+2uIzmeABPMT8q9v5Aph0yqsr
         niCJGJzhBXg5U8GYEcnh3tSBaVGgaEaxIwmLEarM8HHd40hTG+fVwsNfEqaGhjZP/uav
         gcLwDxAAc4lGnXCe9ONxAfKlhQ9CQloLVGiIEamBHdqeT1XWPw0iTP9LtobEkCp0+i+t
         l3Y/kEtr1xMl2t5E3fJmW2cEEkBaxuMU/xxzhzR9roaSH2uKjioXeixR/LG8oMA3e/wB
         DgUQ==
X-Gm-Message-State: APjAAAUITCY3MzESPXPJkiDaoH0aEyA9+je0v0kWIwzFpM7MMnNZpetw
        SjZy47ACLjx4ENSgueFbx9lVikVtkej4xArgaSWhUg==
X-Google-Smtp-Source: APXvYqy8v9Z2HTckk3TJHCNE87XU3XMFn49KNPN87j5fjKKpfELUFJCwxtT5TKh+adBVMaK05gLhm28W0yagTRZs5Dk=
X-Received: by 2002:a67:ce8f:: with SMTP id c15mr1139950vse.213.1552910166385;
 Mon, 18 Mar 2019 04:56:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190314160428.3559-1-igor.j.konopko@intel.com> <20190314160428.3559-9-igor.j.konopko@intel.com>
In-Reply-To: <20190314160428.3559-9-igor.j.konopko@intel.com>
From:   Hans Holmberg <hans@owltronix.com>
Date:   Mon, 18 Mar 2019 12:55:55 +0100
Message-ID: <CANr-nt21xrUO_hHMU89wFb3DmatPs1=j8P68Mj_T2t=rX=9YoA@mail.gmail.com>
Subject: Re: [PATCH 08/18] lightnvm: pblk: fix spin_unlock order
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

On Thu, Mar 14, 2019 at 5:08 PM Igor Konopko <igor.j.konopko@intel.com> wrote:
>
> In pblk_rb_tear_down_check() spin_unlock() functions are not
> called in proper order. This patch fixes that.

Can you add a Fixes: ?

Thanks.

Reviewed-by: Hans Holmberg <hans.holmberg@cnexlabs.com>

>
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> ---
>  drivers/lightnvm/pblk-rb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/lightnvm/pblk-rb.c b/drivers/lightnvm/pblk-rb.c
> index 03c241b..3555014 100644
> --- a/drivers/lightnvm/pblk-rb.c
> +++ b/drivers/lightnvm/pblk-rb.c
> @@ -799,8 +799,8 @@ int pblk_rb_tear_down_check(struct pblk_rb *rb)
>         }
>
>  out:
> -       spin_unlock(&rb->w_lock);
>         spin_unlock_irq(&rb->s_lock);
> +       spin_unlock(&rb->w_lock);
>
>         return ret;
>  }
> --
> 2.9.5
>
