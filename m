Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE4EBC433C1
	for <linux-block@archiver.kernel.org>; Wed, 31 Mar 2021 06:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F947619C2
	for <linux-block@archiver.kernel.org>; Wed, 31 Mar 2021 06:33:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233723AbhCaGcy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 31 Mar 2021 02:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233781AbhCaGct (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 Mar 2021 02:32:49 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E99C061574
        for <linux-block@vger.kernel.org>; Tue, 30 Mar 2021 23:32:49 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id jy13so28374557ejc.2
        for <linux-block@vger.kernel.org>; Tue, 30 Mar 2021 23:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W2XujmNBmvhctoUjctUcryAGWNI+Vrj/s1ET8vRmS/E=;
        b=Wuw4ywKjUdfpcPVYseOeS7wAMbyuh2BnA9Ob0oUGVkUEvdNFplCQ6NktT8GXi3c3J9
         suDjC9wRgl4Wkf1Cmr8r4BJm6v1GreyDv0VFZ8wpcJAKxj0Ta4YAjzXRCO6gNw6fWm5w
         VpRMJZgM0Yw0TKwYhRQyFOrmmy3Ig2AZVbj7NtOGSuJuqt6zDhAC/KK7Q3PSnOuSEHU8
         6Y4qtm31p79BZDWLenxlyqlyPVdZ4sqj0ZlwMlJIV292NNmtNzSuspRytCDjfZFPxc5w
         RkxVFmLMwTG0gzTN3FXdc0PZ3J2IuSRtiElFi+azOL3DtW/aGEWUuRfcd5vjKZXb4PnZ
         8x3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W2XujmNBmvhctoUjctUcryAGWNI+Vrj/s1ET8vRmS/E=;
        b=S+s1wY2YuSrC7VrvuUJ47XafRUnq/+Z+KGuik9jnsBar0c61wtAQZG2fShJ+nytCZx
         uvzR7Y+g0S0ZnNWA5ZBD9M2km5hzCLyA6DzxsTmdHvcSOTPar4w35Pu3YyQxQhtUlOPM
         6XR14mooRJnbmvUm74NoJsa7plN/EiBsW2V7P103mBMJibDuHjrvcGSXCIXktG6IJx1c
         UJ2KSkupkww+kVRSVPgSIJhXAIaqEKOihsnAK/rqBPwNEVjKZU+ZFtQf4qUYF1XeHMrC
         84jU9YsrxEZs4eQ/SgkYPgOKtQ7Cgc3wJ3o2UBQ4blc8dZ1eIqKDo/zuCjaJu4YMKaYU
         Hlyw==
X-Gm-Message-State: AOAM533Jmvmc/hb3UTExmJzpzRpAyF4Edz6RFpyeMiJZHDaoyihjxgo4
        2nABGgXvOWvGz8Mxx749ZATURUvt4kimYUK2dEoK9Q==
X-Google-Smtp-Source: ABdhPJyvZppuyzR0NfuMBDYCl6frxEhnUSqtxMB4rCszHejLCiAqEDhSU5RaxRIpWQORETDRpWHSfl28d4AYYZpv2Us=
X-Received: by 2002:a17:906:b20b:: with SMTP id p11mr1928634ejz.0.1617172368332;
 Tue, 30 Mar 2021 23:32:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210330073752.1465613-1-gi-oh.kim@ionos.com> <20210330073752.1465613-11-gi-oh.kim@ionos.com>
 <BYAPR04MB4965E5103C577E2C2D2C5A8C867D9@BYAPR04MB4965.namprd04.prod.outlook.com>
In-Reply-To: <BYAPR04MB4965E5103C577E2C2D2C5A8C867D9@BYAPR04MB4965.namprd04.prod.outlook.com>
From:   Gioh Kim <gi-oh.kim@ionos.com>
Date:   Wed, 31 Mar 2021 08:32:12 +0200
Message-ID: <CAJX1YtbO+ceBnasZYDT+AvdT439R+GfN1m1_3+qrtoKqBHqZhA@mail.gmail.com>
Subject: Re: [PATCHv2 for-next 10/24] block/rnbd-clt: Move add_disk(dev->gd)
 to rnbd_clt_setup_gen_disk
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "haris.iqbal@ionos.com" <haris.iqbal@ionos.com>,
        "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
        Guoqing Jiang <guoqing.jiang@gmx.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 31, 2021 at 1:55 AM Chaitanya Kulkarni
<Chaitanya.Kulkarni@wdc.com> wrote:
>
> On 3/30/21 00:39, Gioh Kim wrote:
> > From: Guoqing Jiang <guoqing.jiang@gmx.com>
> >
> > It makes more sense to add gendisk in rnbd_clt_setup_gen_disk, instead
> > of do it in rnbd_clt_map_device.
> >
> > Signed-off-by: Guoqing Jiang <guoqing.jiang@gmx.com>
> > Reviewed-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
> > Signed-off-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
> > Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
>
> The add disk call seems to be out of the lock, I hope that will not
> result in any issues since this patch moves add_disk call when
> dev->lock is held.

I checked other modules and found that pktcdvd and mtd/ubi does add_disk
when holding mutex.
I hope so.

Thank you.

>
> Looks good.
>
> Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
>
>
