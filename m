Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:49933 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751810AbdIULOZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Sep 2017 07:14:25 -0400
Received: by mail-wm0-f52.google.com with SMTP id r74so775280wme.4
        for <linux-block@vger.kernel.org>; Thu, 21 Sep 2017 04:14:25 -0700 (PDT)
Subject: Re: [PATCH] lightnvm: remove already calculated nr_chnls
To: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <m@bjorling.me>,
        Javier Gonzalez <jg@lightnvm.io>
Cc: Rakesh Pandit <rakesh@tuxera.com>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
References: <20170917210412.GA2879@hercules.tuxera.com>
 <C22FF934-D7A2-4B1F-8172-011E596A5EE8@lightnvm.io>
 <CAOu_J6nFO1iqGvZgDQxPdgoAKhoOAvgR6e7gSeKhS9yq=orZqg@mail.gmail.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <8daba9d7-30a3-2c92-764c-a01b6d85572c@lightnvm.io>
Date: Thu, 21 Sep 2017 13:14:23 +0200
MIME-Version: 1.0
In-Reply-To: <CAOu_J6nFO1iqGvZgDQxPdgoAKhoOAvgR6e7gSeKhS9yq=orZqg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 09/18/2017 12:56 PM, Matias Bjørling wrote:
> 
> 
> Den 18. sep. 2017 09.56 skrev "Javier González" <jg@lightnvm.io 
> <mailto:jg@lightnvm.io>>:
> 
>      > On 17 Sep 2017, at 23.04, Rakesh Pandit <rakesh@tuxera.com
>     <mailto:rakesh@tuxera.com>> wrote:
>      >
>      > Remove repeated calculation for number of channels while creating a
>      > target device.
>      >
>      > Signed-off-by: Rakesh Pandit <rakesh@tuxera.com
>     <mailto:rakesh@tuxera.com>>
>      > ---
>      >
>      > This is also a trivial change I found while investigating/working on
>      > other issue.
>      >
>      > drivers/lightnvm/core.c | 1 -
>      > 1 file changed, 1 deletion(-)
>      >
>      > diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
>      > index 1b8338d..01536b8 100644
>      > --- a/drivers/lightnvm/core.c
>      > +++ b/drivers/lightnvm/core.c
>      > @@ -139,7 +139,6 @@ static struct nvm_tgt_dev
>     *nvm_create_tgt_dev(struct nvm_dev *dev,
>      >       int prev_nr_luns;
>      >       int i, j;
>      >
>      > -     nr_chnls = nr_luns / dev->geo.luns_per_chnl;
>      >       nr_chnls = (nr_chnls_mod == 0) ? nr_chnls : nr_chnls + 1;
>      >
>      >       dev_map = kmalloc(sizeof(struct nvm_dev_map), GFP_KERNEL);
>      > --
>      > 2.7.4
> 
>     We wanted to make sure that nr_chnls was really, really set :)
> 
>     Reviewed-by: Javier González <javier@cnexlabs.com
>     <mailto:javier@cnexlabs.com>>
> 
> What the hell... must have been a patch or merge that went wrong.

Thanks Rakesh. I pulled it in for 4.15.
