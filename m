Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B25C5C0015E
	for <linux-block@archiver.kernel.org>; Thu, 27 Jul 2023 13:05:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjG0NFz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jul 2023 09:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjG0NFy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jul 2023 09:05:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83CB4211C
        for <linux-block@vger.kernel.org>; Thu, 27 Jul 2023 06:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690463107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rJciskHTxK0ZrvHGsPhNObCRY/8YOJmMewzdjuqbfag=;
        b=S/olyTSg2vavvrNGQKbuPg2hy66JuQiwLD4wpKugcsts4hla3KljLH6oIopyNJwpGbvoaV
        5ygl3KVR6XcHeb7FQvU8Qy2C0pYWGNeq3cRKTkVHr/7CSV1wfllPSRwX2Rns0u3JAemt6G
        RIeOuDL740ufxd/KMtxS18OpE39V4Fk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-CmgRYjhFMQyT-yAYxaTtOg-1; Thu, 27 Jul 2023 09:05:06 -0400
X-MC-Unique: CmgRYjhFMQyT-yAYxaTtOg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3fb40ec952bso5387945e9.0
        for <linux-block@vger.kernel.org>; Thu, 27 Jul 2023 06:05:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690463104; x=1691067904;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rJciskHTxK0ZrvHGsPhNObCRY/8YOJmMewzdjuqbfag=;
        b=SWTaYxo3NHAdkDcetSKb+3FWrF/ynx/Var+5lE8knQTUFwgAecTf1E0Hgczdx779xe
         fs136UM5VsLHsJF5ndVzVIkLJdtVi1m2Weiqx+JKqtqClQkDBRy1sloQVEEPVouzbfLG
         pKeUmgL3taeodt8gE95nrbEalok0AxvKiM9XnceCVCx+2Yqi8APmKOqNlugSj1M6YqAI
         sFG6v7azIunqC72c6Mn40Fu8kd0isiTr8ldHdtN2UQ1G164uCF1GUyrLJ1VDOEdY21Uk
         cWMSN26kN+VTstCgwUnqD1YYkNCt72hlwM1jZejTU2TXzX+dMwre85jpJxbfLZ2iDFRt
         tHMw==
X-Gm-Message-State: ABy/qLYUKaOuwjWqgB/tE5mqHqh/FOWrD5JgBurqvjANDqqD+tEGn3Ie
        2nRSpl1KFyVa3RimDQrHOfNHv/y7yi5V+4d/IAFejhezTBBLm5sz92fmQdhS2UUEJm0gbTZnHGe
        D3QUFiSbI1qErG0gEJGIqxS/4agO4dHY=
X-Received: by 2002:a05:600c:255:b0:3fb:adc0:609b with SMTP id 21-20020a05600c025500b003fbadc0609bmr1862422wmj.13.1690463104606;
        Thu, 27 Jul 2023 06:05:04 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHftt7ssrGG7RcP04/dXRWzo1IPiMO0jFr73Gh8RmDTsJYibQC997JrTgfWybpkn/pOQ87A+Q==
X-Received: by 2002:a05:600c:255:b0:3fb:adc0:609b with SMTP id 21-20020a05600c025500b003fbadc0609bmr1862406wmj.13.1690463104244;
        Thu, 27 Jul 2023 06:05:04 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.170.163])
        by smtp.gmail.com with ESMTPSA id q10-20020a1cf30a000000b003fbb618f7adsm1816254wmq.15.2023.07.27.06.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 06:05:03 -0700 (PDT)
Date:   Thu, 27 Jul 2023 15:05:01 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        German Maglione <gmaglione@redhat.com>
Subject: Re: [PATCH V2 3/3] ublk: return -EINTR if breaking from waiting for
 existed users in DEL_DEV
Message-ID: <l4nqfjbb6o2koql4du64ara5nirsop4bysjsa6p44kc53fnnfx@zalrqud5qy7y>
References: <20230726144502.566785-1-ming.lei@redhat.com>
 <20230726144502.566785-4-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230726144502.566785-4-ming.lei@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 26, 2023 at 10:45:02PM +0800, Ming Lei wrote:
>If user interrupts wait_event_interruptible() in ublk_ctrl_del_dev(),
>return -EINTR and let user know what happens.
>
>Fixes: 0abe39dec065 ("block: ublk: improve handling device deletion")
>Reported-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Ming Lei <ming.lei@redhat.com>
>---
> drivers/block/ublk_drv.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
>index 9fcba3834e8d..21d2e71c5514 100644
>--- a/drivers/block/ublk_drv.c
>+++ b/drivers/block/ublk_drv.c
>@@ -2126,8 +2126,8 @@ static int ublk_ctrl_del_dev(struct ublk_device **p_ub)
> 	 * - the device number is freed already, we will not find this
> 	 *   device via ublk_get_device_from_id()
> 	 */
>-	wait_event_interruptible(ublk_idr_wq, ublk_idr_freed(idx));
>-
>+	if (wait_event_interruptible(ublk_idr_wq, ublk_idr_freed(idx)))
>+		return -EINTR;
> 	return 0;
> }
>
>-- 
>2.40.1
>

