Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 165C5C4708D
	for <linux-block@archiver.kernel.org>; Wed,  4 Jan 2023 16:53:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240091AbjADQxx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Jan 2023 11:53:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240093AbjADQxh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Jan 2023 11:53:37 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205C359D3E;
        Wed,  4 Jan 2023 08:49:30 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id v23so36677957pju.3;
        Wed, 04 Jan 2023 08:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HJHdWmCdPPN2RyEGwBVDj0U8BnKg57ySrkwiPnlykik=;
        b=VxoCu7wegDYxADC2LeBsfTT8mTk7pkYhPGdcRRyURqqqkbXuC7/9JCVEMB2UycbwKW
         IFmnhRxSZyF1NZ5lvywX8lVNa5qpsvxfgZ7cGKqY9x2M91/2YDC8dGS1IRFU2aYIlSpz
         wMYW50334GdGNt80kh9IsnCoHd/76FSNG6kiN5bXY0Xccm7wXz2c7bJHoGfUiGyWH6k+
         PxmgQbtGQzW4cLjbnioPRuVTfdBoWqDQVnSF9FtNBIL9TuKGe+QzHhXCp3iyxj66DwHj
         J666F/CkcmxY+n6IwQRCoBs1cy79fuMetWx/JzS5743lGyYteVZl+YWuVCKM4WeEZnik
         4AfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HJHdWmCdPPN2RyEGwBVDj0U8BnKg57ySrkwiPnlykik=;
        b=0RlswXo17SPAUrLbEA7DH0qbRehnoJIMm+kkqkZ05WE+zmno04bMeTefUk/0fit3T5
         AFHsZrCNRGMihPOr5taQcnwgJ3QGnCzgUEo2Gy4M9Il3Lp2T5H0G8tPuXn85PhFcaC5F
         uyY+NEUeSQ65o3qM48zKg3QlPSIIDtgEs9m1NwODSWwxp5JwyF9CI0oawJ/iGUIjytlT
         VSQmd4i9ZqiDp1ympTLiOGwMjyKEPhQJKtGTMwBjrWjCq2CDRr5luqhy/e29HyQ0v/HS
         KkzWXvM43xWk7UuN/sp/POcSjuheY3yQy4pO8LFctC8kZx4EmEzmrHf+yJgWjWJe8CSR
         O6XA==
X-Gm-Message-State: AFqh2kpRYdizaEYZ3c4aGNQFAigDGwe/TuRE29Gft3E/TKjp2pMFgBOI
        XtyO8WmAbxVoBvGJkr9MqyakhzdwVOQ=
X-Google-Smtp-Source: AMrXdXtSjS6StbSHzd7U0kstj7a0vyrwXOOvTT2LoycKqDp34gcD6yHNFMTapLZIYanePEWsRGalMw==
X-Received: by 2002:a05:6a20:66aa:b0:aa:23e1:f8ce with SMTP id o42-20020a056a2066aa00b000aa23e1f8cemr56464427pzh.59.1672850965508;
        Wed, 04 Jan 2023 08:49:25 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id j14-20020a170903024e00b001869079d083sm24491497plh.90.2023.01.04.08.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 08:49:24 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 4 Jan 2023 06:49:22 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
        Niklas Cassel <niklas.cassel@wdc.com>
Subject: Re: [PATCH v7 0/7] Improve libata support for FUA
Message-ID: <Y7WuEqMgySOCCTqy@slm.duckdns.org>
References: <20230103051924.233796-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230103051924.233796-1-damien.lemoal@opensource.wdc.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

On Tue, Jan 03, 2023 at 02:19:17PM +0900, Damien Le Moal wrote:
> Finally, patch 7 enables FUA support by default in libata for devices
> supporting this features.

These optional features tend to be broken in various and subtle ways,
especially the ones which don't show clear and notable advantages and thus
don't get used by everybody. I'm not necessarily against enabling it by
default but we should have better justifications as we might unnecessarily
cause a bunch of painful and subtle failures which can take a while to sort
out.

* Can the advantages of using FUA be demonstrated in a realistic way? IOW,
  are there workloads which clearly benefit from FUA? My memory is hazy but
  we only really use FUA from flush sequence to turn flush, write, flush
  sequence into flush, FUA-write. As all the heavy lifting is done in the
  first flush anyway, I couldn't find a case where that optimization made a
  meaningful difference but I didn't look very hard.

* Do we know how widely FUA is used now? IOW, is windows using FUA by
  default now? If so, do we know whether they have a blocklist?

Thanks.

-- 
tejun
