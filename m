Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32BD7C4708F
	for <linux-block@archiver.kernel.org>; Wed,  2 Jun 2021 18:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DC8460FF1
	for <linux-block@archiver.kernel.org>; Wed,  2 Jun 2021 18:34:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbhFBSfm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Jun 2021 14:35:42 -0400
Received: from mail-qk1-f172.google.com ([209.85.222.172]:33660 "EHLO
        mail-qk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229467AbhFBSfl (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Jun 2021 14:35:41 -0400
Received: by mail-qk1-f172.google.com with SMTP id k4so3457786qkd.0
        for <linux-block@vger.kernel.org>; Wed, 02 Jun 2021 11:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OZfWnyGhrXM/HiypV9I9vq0r6H69jPBHbzJN6dXGJH8=;
        b=tg3BjgxNsV9jZLFQQzTFD3EP2MP7rwV0R4oLTfjh2ajnOHbyprecNsb0n/f81T0ZB+
         UJD7F1DoooInIpnd5bhRD0o0woGOjFf179lbJqN8frsiJckt7KdT5/Q+Rn9hzmAIafXq
         dn2gzt6TUTEc59JGxmUYEBS/lFhtG5KMD9Qvv9JYmul2GBggtmoV3ryk3xLuonG2xKvB
         L3lBWMYvRyByiAqakXY6dLOXAgbHL9vYqNlyzi3CJNbHq5ZQJVLamNcIIg3P8zVTdojd
         TGFxymkgz7X9fAUtuaYUIOWG5iBNA5GQqK0E4j8fww1aGENMXvCKWsYPwhOnn2sH7nev
         DkEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=OZfWnyGhrXM/HiypV9I9vq0r6H69jPBHbzJN6dXGJH8=;
        b=t9jEKeTL1+xbIhZetIiKqluy+DfzngOqdTRLV47VwWNlW+j4ISpY7kDNkj7p967FB3
         hFhUJUaf/XusYvqHz5XZe5YFMQOJhid5YQJLZBh5Kll8SRvY7qLo72ZHuDs+jSXfpWHm
         DcJn+Q1+nS1Oe6QkjjLQmkujfJlxN+9Fh8u9Ry3XQDcsFXVO0+XdpCOga7d2wIoSDh1b
         IL62PgFSMdkgy9Ba+b1x03Y8Z35VCF09Ay+VLWf3yxb3JHXvY+G8y2bwEDEXFu/BZnas
         llW4Zr3BcsOGrEDOaI/M68FhRhdnrpHgEtbbIBgKQpnze7XtLDzXYaM4HuyYaIUChLWP
         01Dg==
X-Gm-Message-State: AOAM5330gjrtc1OSLttW7fmjX+Vw7uK8hgffWUPfReiNbccdcpDKVstP
        xoG05CB95Cg6Yv97MmgmRGw=
X-Google-Smtp-Source: ABdhPJzzM6kheOdfWXSbb1PAabbfizCNSV+LWnIC08jGDEnphrDSjkBmy6+qhDfsG8T7sHT+13Lnrg==
X-Received: by 2002:ae9:e706:: with SMTP id m6mr29510020qka.74.1622658777897;
        Wed, 02 Jun 2021 11:32:57 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id y19sm357953qki.15.2021.06.02.11.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 11:32:57 -0700 (PDT)
Sender: Mike Snitzer <snitzer@gmail.com>
Date:   Wed, 2 Jun 2021 14:32:55 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v5 00/11] dm: Improve zoned block device support
Message-ID: <YLfO168QXfAWJ9dn@redhat.com>
References: <20210525212501.226888-1-damien.lemoal@wdc.com>
 <DM6PR04MB708146E418BF65FC2F7847E3E73E9@DM6PR04MB7081.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR04MB708146E418BF65FC2F7847E3E73E9@DM6PR04MB7081.namprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 01 2021 at  6:57P -0400,
Damien Le Moal <Damien.LeMoal@wdc.com> wrote:

> On 2021/05/26 6:25, Damien Le Moal wrote:
> > This series improve device mapper support for zoned block devices and
> > of targets exposing a zoned device.
> 
> Mike, Jens,
> 
> Any feedback regarding this series ?
> 
> > 
> > The first patch improve support for user requests to reset all zones of
> > the target device. With the fix, such operation behave similarly to
> > physical block devices implementation based on the single zone reset
> > command with the ALL bit set.
> > 
> > The following 2 patches are preparatory block layer patches.
> > 
> > Patch 4 and 5 are 2 small fixes to DM core zoned block device support.
> > 
> > Patch 6 reorganizes DM core code, moving conditionally defined zoned
> > block device code into the new dm-zone.c file. This avoids sprinkly DM
> > with zone related code defined under an #ifdef CONFIG_BLK_DEV_ZONED.
> > 
> > Patch 7 improves DM zone report helper functions for target drivers.
> > 
> > Patch 8 fixes a potential problem with BIO requeue on zoned target.
> > 
> > Finally, patch 9 to 11 implement zone append emulation using regular
> > writes for target drivers that cannot natively support this BIO type.
> > The only target currently needing this emulation is dm-crypt. With this
> > change, a zoned dm-crypt device behaves exactly like a regular zoned
> > block device, correctly executing user zone append BIOs.
> > 
> > This series passes the following tests:
> > 1) zonefs tests on top of dm-crypt with a zoned nullblk device
> > 2) zonefs tests on top of dm-crypt+dm-linear with an SMR HDD
> > 3) btrfs fstests on top of dm-crypt with zoned nullblk devices.
> > 
> > Comments are as always welcome.

I've picked up DM patches 4-8 because they didn't depend on the first
3 block patches.

But I'm fine with picking up 1-3 if Jens provides his Acked-by.
And then I can pickup the remaining DM patches 9-11.

Thanks,
Mike
