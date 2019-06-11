Return-Path: <SRS0=2dDp=UK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A26ACC31E44
	for <linux-block@archiver.kernel.org>; Tue, 11 Jun 2019 21:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D5332080A
	for <linux-block@archiver.kernel.org>; Tue, 11 Jun 2019 21:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560287845;
	bh=P+mP+Sn3Gp/n6UKGhRT6iCMqsCsU2UKY1pndxRNBWwM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Qcfq4wpGjMFZG17yMsvsZ5fS32xqMGAdiKHN5xb7NRZbK57OLjbSob/u2LgR1zenz
	 kjMaeDoxj2C/rgPxEbb2U4L05o+qSpg5l3TNijUrLzeTKJpJGaeFJvJLdee38VocUZ
	 zbun7i2WDg1EuZyfmg2BFYQmEuHeAc1VqrjkUthc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406935AbfFKVRZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Jun 2019 17:17:25 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39548 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406712AbfFKVRY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Jun 2019 17:17:24 -0400
Received: by mail-pg1-f196.google.com with SMTP id 196so7658830pgc.6
        for <linux-block@vger.kernel.org>; Tue, 11 Jun 2019 14:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w7fvtoWTYMGWcS8TbwJ3KQSZw6usnftOHgzrdu0xPRM=;
        b=Et237YLYWbVwG/ox4ddSiMg8YZJeq/T2bPND6p8D9FLf8464lrRQApesZTyRK44edI
         TTyWRQO6ucsETj5trnTt4hmaHB4YDOV5tZQIu9D+YoZmN/mGfiBJLO30ex4echZ+j+w8
         V5Xluk09MWtJeCPDFEzMC1bl96W9GwfMJVbEC7QSF+nSw82ey06fWnJilgHRq+IzPLtA
         LycGHnHjnRSmKgz4TUSFLHD17FjKomx5+Zss/oUqB4KGaduNCy32ShRNAAg1zCz8E+VR
         xYB7g456tSqEXpt7OPvqeZ+/wRxF22AEKnlKvRpRgxe5ml6Xm6IDiwarZT3ri9bMRP4X
         +m2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=w7fvtoWTYMGWcS8TbwJ3KQSZw6usnftOHgzrdu0xPRM=;
        b=TtzymLokNPaLDJx/tUSHLHoJkM7djGA9VEKdL7mamW8Nl8BopYplItxYx8y33fQtqw
         z62YRtRFxvxLDCh4Oo/3uo96GWhL4HUicR++NW7ZRIXiUZJx+u+Fd2u0CUOmFkr9eLVc
         2yA057xhiQuyKI4hz2HSY5/J26GS0sWGmQ2gQ2tozsmJ3bJHJo6zazVuZgo67PIa1ebh
         qP4LTQ58EgnFaVAj26qA53XSBMVN2G5zEbaqtlOWjQ4dGGEeNnlWgj0ptdmc15lt2GKw
         f/2fk1E488c1s0LmcpZkFYCCbJaDbQiHXk90IJcv/EhOVyrC/ujRqrcudyJ8edEVy/oI
         N/wg==
X-Gm-Message-State: APjAAAVZmIc3MAc3GloHZeV1dlr5SAd5QfHmMT/wOkxrYpuIKrMigLct
        3StkmN4lYpi5IYtZTKfQm18=
X-Google-Smtp-Source: APXvYqwMA7xgtUlzampq99Zuhs54Ek/W1wNSyGZ2eyOJJo95M4zv8iBd+BW86+mSphknWQeQnF0Vbg==
X-Received: by 2002:aa7:8394:: with SMTP id u20mr70880877pfm.252.1560287843831;
        Tue, 11 Jun 2019 14:17:23 -0700 (PDT)
Received: from localhost ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id r9sm13256110pgv.24.2019.06.11.14.17.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 14:17:22 -0700 (PDT)
Date:   Tue, 11 Jun 2019 14:17:18 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Paolo Valente <paolo.valente@linaro.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH block/for-5.2-fixes] bfq: use io.weight interface file
 instead of io.bfq.weight
Message-ID: <20190611211718.GM3341036@devbig004.ftw2.facebook.com>
References: <4f801c9b-4ab6-9a11-536c-ff509df8aa56@kernel.dk>
 <CAHk-=whXfPjCtc5+471x83WApJxvxzvSfdzj_9hrdkj-iamA=g@mail.gmail.com>
 <52daccae-3228-13a1-c609-157ab7e30564@kernel.dk>
 <CAHk-=whca9riMqYn6WoQpuq9ehQ5KfBvBb4iVZ314JSfvcgy9Q@mail.gmail.com>
 <ebfb27a3-23e2-3ad5-a6b3-5f8262fb9ecb@kernel.dk>
 <90A8C242-E45A-4D6E-8797-598893F86393@linaro.org>
 <20190610154820.GA3341036@devbig004.ftw2.facebook.com>
 <20190611194959.GJ3341036@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611194959.GJ3341036@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 11, 2019 at 12:49:59PM -0700, Tejun Heo wrote:
> (Description mostly stolen from 19e9da9e86c4 ("block, bfq: add weight
> symlink to the bfq.weight cgroup parameter")
> 
> Many userspace tools and services use the proportional-share policy of
> the blkio/io cgroups controller. The CFQ I/O scheduler implemented
> this policy for the legacy block layer. To modify the weight of a
> group in case CFQ was in charge, the 'weight' parameter of the group
> must be modified. On the other hand, the BFQ I/O scheduler implements
> the same policy in blk-mq, but, with BFQ, the parameter to modify has
> a different name: bfq.weight (forced choice until legacy block was
> present, because two different policies cannot share a common
> parameter in cgroups).

Sorry, please don't apply this patch.  The cgroup interface currently
implemented by bfq doesn't follow the io.weight interface spec.  It's
different from cfq interface and symlinking to or renaming it won't do
anybody any good.

For now, the only thing we can do looks like keeping it as-is.

Thanks.

-- 
tejun
