Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B5CC433F5
	for <linux-block@archiver.kernel.org>; Sat, 19 Feb 2022 13:04:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242324AbiBSNE5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 19 Feb 2022 08:04:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234438AbiBSNE5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 19 Feb 2022 08:04:57 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C22449F8E
        for <linux-block@vger.kernel.org>; Sat, 19 Feb 2022 05:04:37 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id gb39so21441834ejc.1
        for <linux-block@vger.kernel.org>; Sat, 19 Feb 2022 05:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mH91QnSgxvC4j5tu0SPLOYxEGaLIR81KrmQMR9S7wsg=;
        b=GFjCtYbL40cTtZhkRLv9Bl1jLjTTM36g7Wt3xQ0smUg5bGzLv9E1pwR4fAckTgHoqs
         8COpCaHy87WGC3yIAe54CvV7KRCJ0VtUazzfkDnKaHSyIDfspsA0GTOsYPyatHZ0iX9t
         lPoKXa9riR3D4fuQ77JqbCIzxiMUNSWEBIdd0U1/Br8n62Es9vXtsAP5w75XjP22Yj61
         0bEN3oHO9B3zR3z/O3gqVdvu2ZOoCZH0afVP1Cth+DXYJwmkEDLdCGnSXFTqSMXoqr+G
         8Pkz0ziPHqFarTPwkQnMqPlt2918aQQCnCH0z+tYwqkC5q76w0r2ohY3h+1QvSyoB/Xo
         ysZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mH91QnSgxvC4j5tu0SPLOYxEGaLIR81KrmQMR9S7wsg=;
        b=nlvYy3tjLl9WXmxHbWIWdY5QpNYGXkboa7Ni1aSHhVicqpAUHI2CsoxUZQjoqb+SgW
         uLyQ0tqqB3fpg/EfScEU1LTQ1l7aSjPalcdug3VIynSScF6iy8rhLtETP+NMi2NT7spA
         ANmGei+vZtHIk/8FGKeNCYqXxerfSwzTg2sIYP660cNqsu9alonC8/ewFNIaDUx/S6RL
         axrVAl1t+nd916g+0OO3r3Pdr6cVapQG/JrQBmnGfNn2YOUS3t8rgvRL6BnHRrLzGcSb
         kfuTcOh9wY2v0pF6LsqX1qUnohEyIWFK+KE+/kWnmC3Mb/lzLARojIOqZO7b9c/lJwAJ
         SyNw==
X-Gm-Message-State: AOAM530wBGU/reo+NShoBY97sObHtnplFCTqT9Yur1oLIXb3YKq1voMU
        ulGfNrp/rHcV3badVbu9YulhPdIRh9iOTuGLkAOu
X-Google-Smtp-Source: ABdhPJwYkmpv/EhorhkTuYLKx9EBKD276hUEjdkS5jrdu+Di08dfQayG61gRGyXD2ykmkvTRM7hpzIjgw2YHfNfLiVM=
X-Received: by 2002:a17:906:974e:b0:6bb:4f90:a6ae with SMTP id
 o14-20020a170906974e00b006bb4f90a6aemr10115442ejy.452.1645275875999; Sat, 19
 Feb 2022 05:04:35 -0800 (PST)
MIME-Version: 1.0
References: <20211227091241.103-1-xieyongji@bytedance.com> <Ycycda8w/zHWGw9c@infradead.org>
 <CACycT3usfTdzmK=gOsBf3=-0e8HZ3_0ZiBJqkWb_r7nki7xzYA@mail.gmail.com>
 <YdMgCS1RMcb5V2RJ@localhost.localdomain> <CACycT3vYt0XNV2GdjKjDS1iyWieY_OV4h=W1qqk_AAAahRZowA@mail.gmail.com>
 <YdSMqKXv0PUkAwfl@localhost.localdomain> <CACycT3tPZOSkCXPz-oYCXRJ_EOBs3dC0+Juv=FYsa6qRS0GVCw@mail.gmail.com>
 <CACycT3tTKBpS_B5vVJ8MZ1iuaF2bf-01=9+tAdxUddziF2DQ-g@mail.gmail.com>
 <CACycT3thVwb466u2JR-oDRHLY5j_uxAx5uXXGmaoCZL5vs__mQ@mail.gmail.com> <Yg+5Wytvc2eG8uLD@localhost.localdomain>
In-Reply-To: <Yg+5Wytvc2eG8uLD@localhost.localdomain>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Sat, 19 Feb 2022 21:04:25 +0800
Message-ID: <CACycT3umMYfwVZRXinEBM=Kh+kQPYH5GBN6eKrt9unZSM8W0qw@mail.gmail.com>
Subject: Re: [PATCH v2] nbd: Don't use workqueue to handle recv work
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Feb 18, 2022 at 11:21 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> On Tue, Feb 15, 2022 at 09:17:37PM +0800, Yongji Xie wrote:
> > Ping again.
> >
> > Hi Josef, could you take a look?
>
> Sorry Yongji this got lost.  Again in the reconnect case we're still setting up
> a long running thread, so it's not like it'll happen during a normal reclaim
> path thing, it'll be acted upon by userspace.  Thanks,
>

During creating this long running thread, we might trigger memory
reclaim since workqueue will use GFP_KERNEL allocation for it. Then a
deadlock can occur if the memory reclaim happens to hit the page cache
on this reconnecting nbd device.

Thanks,
Yongji
