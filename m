Return-Path: <SRS0=WbMh=RV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71BC0C43381
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 11:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 415132084F
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 11:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="nV5oUuv9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbfCRL6d (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Mar 2019 07:58:33 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:32839 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbfCRL6d (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Mar 2019 07:58:33 -0400
Received: by mail-vk1-f195.google.com with SMTP id r189so3701684vkb.0
        for <linux-block@vger.kernel.org>; Mon, 18 Mar 2019 04:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z1EMgDZrldSPaZJ1K6QiTR2DdQrearqJ0LdIc+hoWyk=;
        b=nV5oUuv95jYEe0LA7YEJm0QQZxDK3MFN/oOUvly7mxCWQ72A6KsSVoTmSrC8ezQ7pB
         7v+c8G6yZHslqYaYzel0nmp9J9FxE4ZD1doHzO2qia2Xwkv29t5YyRfZ+5ApR9SuE4VR
         KGxO/VBoLM1b/iwmv+BCTP9aZTUriS+YU/lRASrci3aJMTHOHV9YHJd1wMFu6I2xIZ/E
         AQerf1BjCUqK6md/qiaYVqdOly1csAul9HMdGPjlVCaRWRq/DOOStqXM5BgKoLaj/ldn
         DlukvhZStSvYoKEkx9ywPXwyYUeOKAxZRUYNuiXYBHr+p5e8UANhYy5eHsJxHMwrS2Cc
         PI0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z1EMgDZrldSPaZJ1K6QiTR2DdQrearqJ0LdIc+hoWyk=;
        b=lR2MFX71Kh6yeV+AMdtqf1lZ0UZrsOaYbZaKMsGnIg8NUH3YVDFSFETdnX2JIxarBK
         2UlGSXyz0/3PyYy1aoo1wx/6ML0wL3JUUGVbg9ssoFyBfLWgWbc6naLmqXMEEwqrCMBg
         jD4YvCFV+/QtiPIW0yrBo+6wQebNDwbMkZVlc6aV3Bf/lllu/je1OwVgArE0c5Dq/Kcd
         fSnSqxzYye+GYo4JRFpliKbo43sNv0TO5m/QlukX8s7ZygTMD83HClgc09C4xcYDJolh
         WjoFk+jBqHHL/kfChFdoHmP2RCurANmn+u2aGslvvWywUhPPC+sMHYhubmIs0xo0sUKV
         U4lQ==
X-Gm-Message-State: APjAAAVSv8tFZqLWOG8fu1qBn/ySRfSGeamydDqV7y1eWBI2nG3yZZGe
        BpReOYK+/Ce6DyscefXnVuS1T1AWIU9nnoO76gGhcw==
X-Google-Smtp-Source: APXvYqzfUbJ8cCZPAGIDrEZ5cs7B/A64+YIrF1GObgjUk0yeIjimdWakwwDe8eYUaMYNN+6s6WB8B0iD6SVTLrcJibk=
X-Received: by 2002:a1f:682:: with SMTP id 124mr9130925vkg.34.1552910312289;
 Mon, 18 Mar 2019 04:58:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190314160428.3559-1-igor.j.konopko@intel.com> <20190314160428.3559-10-igor.j.konopko@intel.com>
In-Reply-To: <20190314160428.3559-10-igor.j.konopko@intel.com>
From:   Hans Holmberg <hans@owltronix.com>
Date:   Mon, 18 Mar 2019 12:58:21 +0100
Message-ID: <CANr-nt2rzDmLsu5dheGE9jFvvVZDFqbSVKk4At+17gv6z2itPg@mail.gmail.com>
Subject: Re: [PATCH 09/18] lightnvm: pblk: kick writer on write recovery path
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
> In case of write recovery path, there is a chance that writer thread
> is not active, so for sanity it would be good to always kick it.

Makes sense.

Reviewed-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
>
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> ---
>  drivers/lightnvm/pblk-write.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
> index 6593dea..4e63f9b 100644
> --- a/drivers/lightnvm/pblk-write.c
> +++ b/drivers/lightnvm/pblk-write.c
> @@ -228,6 +228,7 @@ static void pblk_submit_rec(struct work_struct *work)
>         mempool_free(recovery, &pblk->rec_pool);
>
>         atomic_dec(&pblk->inflight_io);
> +       pblk_write_kick(pblk);
>  }
>
>
> --
> 2.9.5
>
