Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF53C04A68
	for <linux-block@archiver.kernel.org>; Sat, 30 Jul 2022 08:02:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiG3IB7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 30 Jul 2022 04:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiG3IB7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 30 Jul 2022 04:01:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6B83AB4A8
        for <linux-block@vger.kernel.org>; Sat, 30 Jul 2022 01:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659168117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d1/Rg5JzsT2qfJaO6mb4Aa1SwtOjOUVp0IwqBYZxLCM=;
        b=NAoYOlfxHobUq7S1C/lke10qcbH/hFTipSblsoLvyD0QhQxUQNVdcZa/w3Kvxfg86SlHwf
        SM66PRfqtOlVLwaDPpQUi1HfTpr/lqx/Nd4yRP1HBDvloznjA/TRJ3xp66GxtKfwcy6Jr9
        5fFikhReM9gvCyejxM2V6ilZWVVAsFM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-154-bRqVgoCrPwm0QM_IhZxCDg-1; Sat, 30 Jul 2022 04:01:55 -0400
X-MC-Unique: bRqVgoCrPwm0QM_IhZxCDg-1
Received: by mail-ed1-f71.google.com with SMTP id v19-20020a056402349300b0043d42b7ddefso1052738edc.13
        for <linux-block@vger.kernel.org>; Sat, 30 Jul 2022 01:01:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d1/Rg5JzsT2qfJaO6mb4Aa1SwtOjOUVp0IwqBYZxLCM=;
        b=JZrif9cQMHH/Mz4Hi65BmC4dGfZZWzK01W5S0jZMCNwsrunxNcj26EJIy5MTtRqrd4
         ph1LAsmQv0oN34bmFPQF5IwkU8z9weABmfEgCiY1CoUGyK9fS28Pp1iRKiBSf/M6tNbe
         uAp6j4MYJCZIcVJVeafRpEfxKRlzoKvAIjF2SIVFKUkiRyirLP5/9li7Git4d3kIrZwi
         ikgfmYUSdtnMBcyMP1IVBfJyhu0sUePqKeHSdMKBuR2yt8TVr27LOQzcDHpfp5LZxhiO
         RQsFNaBfbKiGf8lpa1bnL3oo8M5SRApaGe9JNhWlYIfapsK+51fgAuDlUgp+clKvCDwK
         KS5w==
X-Gm-Message-State: AJIora/SnlY1W12rtYPHocbn5eb3DrKvI23NRbQhx3RMuKc7uryOaPRy
        66FB/+7N4Csg59V79bk537/4Z9KHYueyDNTDwGj1xvbaH0xHl6GLL//bE0xyvbwEUWlMblOJLWA
        pWMRWTJuKSSaIrAoeq3Ty+b6Vh40xfoK4tfUmgtA=
X-Received: by 2002:a17:907:8687:b0:72e:e524:1803 with SMTP id qa7-20020a170907868700b0072ee5241803mr5354747ejc.411.1659168114281;
        Sat, 30 Jul 2022 01:01:54 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v1T7SV+cquSWQwwrZ81DZ9UchF1GN4aIrO6FrN+421gS0ahQfiP5bQjHboz3h+gVQatwihexdOkin30Ocp3pg=
X-Received: by 2002:a17:907:8687:b0:72e:e524:1803 with SMTP id
 qa7-20020a170907868700b0072ee5241803mr5354738ejc.411.1659168114066; Sat, 30
 Jul 2022 01:01:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220729060411.162529-1-yi.zhang@redhat.com> <20220729132225.GA28468@lst.de>
In-Reply-To: <20220729132225.GA28468@lst.de>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Sat, 30 Jul 2022 16:01:42 +0800
Message-ID: <CAHj4cs_xjwKyeii=pNvzg6ZQ9x5CiOR-0LcrJOKm45X3OyC8XQ@mail.gmail.com>
Subject: Re: [PATCH blktests] block/002: remove debugfs check while blktests
 is running
To:     Christoph Hellwig <hch@lst.de>
Cc:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-block <linux-block@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jul 29, 2022 at 9:22 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Fri, Jul 29, 2022 at 02:04:11PM +0800, Yi Zhang wrote:
> > Seem commit: 99d055b4fd4b ("block: remove per-disk debugfs files in blk_unregister_queue")
>
> s/Seem/see/ ?
Yes, just send v2 for this patch, thanks for the review.

>
> But yes, this should go in.  I thought I already submitted that, but
> it seems like I didn't.
>


-- 
Best Regards,
  Yi Zhang

