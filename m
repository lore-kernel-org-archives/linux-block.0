Return-Path: <SRS0=CgA1=3M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AAE3C32771
	for <linux-block@archiver.kernel.org>; Thu, 23 Jan 2020 01:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1602724673
	for <linux-block@archiver.kernel.org>; Thu, 23 Jan 2020 01:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BmLthYi7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbgAWBkw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Jan 2020 20:40:52 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33973 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgAWBkw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Jan 2020 20:40:52 -0500
Received: by mail-wm1-f66.google.com with SMTP id s144so763431wme.1;
        Wed, 22 Jan 2020 17:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dxERX3Z6knme8mbg8LLRPMLRshct8bmUqfHIkVOFyXY=;
        b=BmLthYi7yXkfQqaQ/Yu82ME78VMEz+g2Svn8AFdCwzluDqcrVEoyEk9kGRn2RdO+lI
         d+uRAQ+iRqo1cgq1fb6tHIk1rQVRy4suxQVKjRzcKyEP+2RfTxHP9L6wWfmoay+UH3Ji
         sAalggte4whNe9wzmJvrkRwmjAuQyLbp1TQcI1WHqWkpZb55JrhlHVOzFVavrSHoJL/Y
         PJ/D2XPtRsLkWuc4IG2DP9MhD44oL60DB3+ggjXEX9mJz7c4ChZ45ZG2Nn6vZ3R9/JXA
         BwNLTFcDSMdVwHH0hraSI8SCD1D3ZqHuztdTcJmQFRzdDmfhdzHbfa+e4sJA2Lg16+RS
         t5Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dxERX3Z6knme8mbg8LLRPMLRshct8bmUqfHIkVOFyXY=;
        b=KFy7CqcoTcEu1+ORbD/i/LJfAUnserpccSoyp0AhWQ+QeWxfPlGM6hUJMSrUljPD7s
         qTrFONDsk45q6+29YnjA8adEchrXrS2tqj3zKGGC8DfC3m5UntzMt+xH7ZHPtILexw+7
         QB5SlIc/1Y6wl3EWGdoUosLxuU2wXywdvAr4krelTr65ZKI2/9FAuUtq8nf7Y4ZaDWaM
         wJvszQOkPaJTqdDp61jju0FJLc0vetDa7ftLgMe7ij0WZ7d52Rsq3yLvKuzVegoNRdpp
         hIXmejdF3QLGArRxrFnMjskIDCVapuT7ZixSh8mca596duE6P0hbqRWkl47qzf8TaTx2
         2Zfw==
X-Gm-Message-State: APjAAAXdG1TNqDnmNVec7qv/EHNUNOYLtVDmHTaAmmzqhTQBKbiTAozR
        FdRyYZOUM4GylgpKoqip5kMR0VtCFIcam95ROHgQE0N3a70CdQ==
X-Google-Smtp-Source: APXvYqx/VfVrGYkRjQq9xgDLNm+4N559pc8TMzBq3MRYjQ9MPzm7WfGRD0wnnSNjXNWIlKNYioVh0v1DAm/m1PHswuc=
X-Received: by 2002:a1c:cc06:: with SMTP id h6mr1148278wmb.118.1579743649711;
 Wed, 22 Jan 2020 17:40:49 -0800 (PST)
MIME-Version: 1.0
References: <DM6PR04MB5754D8E261B4200AA62D442D860D0@DM6PR04MB5754.namprd04.prod.outlook.com>
 <20200121201014.52345-1-muraliraja.muniraju@rubrik.com>
In-Reply-To: <20200121201014.52345-1-muraliraja.muniraju@rubrik.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Thu, 23 Jan 2020 09:40:38 +0800
Message-ID: <CACVXFVN2QteGv=mWpVimZ9y2yzLZOOthB9muFsxTG3LkWWpwfA@mail.gmail.com>
Subject: Re: Re [PATCH] Adding multiple workers to the loop device.
To:     "muraliraja.muniraju" <muraliraja.muniraju@rubrik.com>
Cc:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 22, 2020 at 4:11 AM muraliraja.muniraju
<muraliraja.muniraju@rubrik.com> wrote:
>
> Below is the dd results that I ran with the worker and without the worker changes.
> Enhanced Loop has the changes and ran with 1,2,3,4 workers with 4 dds running on the same loop device.
> Normal Loop is 1 worker(the existing code) with 4 dd's running on the same loop device.
> Enhanced loop
> 1 - READ: io=21981MB, aggrb=187558KB/s, minb=187558KB/s, maxb=187558KB/s, mint=120008msec, maxt=120008msec
> 2 - READ: io=41109MB, aggrb=350785KB/s, minb=350785KB/s, maxb=350785KB/s, mint=120004msec, maxt=120004msec
> 3 - READ: io=45927MB, aggrb=391802KB/s, minb=391802KB/s, maxb=391802KB/s, mint=120033msec, maxt=120033msec
> 4 - READ: io=45771MB, aggrb=390543KB/s, minb=390543KB/s, maxb=390543KB/s, mint=120011msec, maxt=120011msec
> Normal loop
> 1 - READ: io=18432MB, aggrb=157201KB/s, minb=157201KB/s, maxb=157201KB/s, mint=120065msec, maxt=120065msec
> 2 - READ: io=18762MB, aggrb=160035KB/s, minb=160035KB/s, maxb=160035KB/s, mint=120050msec, maxt=120050msec
> 3 - READ: io=18174MB, aggrb=155058KB/s, minb=155058KB/s, maxb=155058KB/s, mint=120020msec, maxt=120020msec
> 4 - READ: io=20559MB, aggrb=175407KB/s, minb=175407KB/s, maxb=175407KB/s, mint=120020msec, maxt=120020msec

Could you share your exact test command?

Multiple jobs may hurt performance in case of sequential IOs on HDD backend.
Also the 1st version of the loop dio patch uses normal wq, I remembered that
random IOperformance isn't improved much, meantime sequential IO perf drops
with normal wq, whentesting SSD backend.

So I took kthread worker.

Thanks,
Ming Lei
