Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68517C47096
	for <linux-block@archiver.kernel.org>; Thu,  3 Jun 2021 22:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 468E161401
	for <linux-block@archiver.kernel.org>; Thu,  3 Jun 2021 22:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbhFCWSt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Jun 2021 18:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFCWSt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Jun 2021 18:18:49 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6788AC06174A
        for <linux-block@vger.kernel.org>; Thu,  3 Jun 2021 15:16:48 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id i12so5581376qtr.7
        for <linux-block@vger.kernel.org>; Thu, 03 Jun 2021 15:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qFuN6eT5h+wbstMj3EMiehBJecwbG0rCxSK9QUGY3Xc=;
        b=M6memYjOO4/zF3tsB5gsqgtvjIHEcAx0Zm9oKh3CEo7aGjU7LCbwyE9fUzPbEA25m4
         45SYtqbZwTbNnTwSn+iZO70v4wz0YMD2fjvHG0M9eHJ59L66xIG5PL6v30p9WA4hQcmi
         AeWpa430iyr4K69w0I2CGJBUIJF/fLwdzFvTas7RL000FrY4oHpzSePonntPXYQx6Dd8
         tXdFQCDe/7hcNbp70Sezm06gktAqU2WavxSKEwOOewbdve8xi7T1eyO9nk+I8R/Q1/Qc
         DEKxzqx3Q1AhPqZmuY62sahtQI13l4twaL6ulyaSsppCx85iZBSOanA4ZqsxX+uL6dKO
         XlmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=qFuN6eT5h+wbstMj3EMiehBJecwbG0rCxSK9QUGY3Xc=;
        b=ebPDejue3J4wDVDcj4XHAULqxXOolepip3vDJDdH7cajHUh/tWUVK3uU+BWDWGjP9J
         yvpXYml2cKx6bXgtcac2m74I/ZucHopB9rHwoM69xoda+/MMjKlHt40M/EbAZZtP6Ptv
         8WhfkgpesEYSLwPsDTEThAPRnHazXwnuVVwmDFfP4NcHScW/OpTTKwXe6KHTLjpOCClE
         FEjyGQwMQ0joX2sXnF27jL1+5pCqlprfO+dyqCKqNlFvjqldh8ZA9eBL8Vo9kcQ5H2TA
         4tqUfwyRZwDj5uXaEY3bojYE/ryi044xEvANhukPzrbge0XZ7PSrXKb7FXiwr18z85fq
         FvCQ==
X-Gm-Message-State: AOAM530M+qsobe8An/HJpZzIsnKMcsudZkf7yblS7CYwo1259xzQIbet
        S2jhPKkQRaETkGlJgI4Zacs=
X-Google-Smtp-Source: ABdhPJwR5/TuuHiL4TwOD3rkiC3n62bwV8WOdWoergRrm2VJMeWiCuki4Zq5ELxlMZJOw5tYNtoMrA==
X-Received: by 2002:ac8:47c2:: with SMTP id d2mr180902qtr.128.1622758607537;
        Thu, 03 Jun 2021 15:16:47 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id 137sm1926418qko.29.2021.06.03.15.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 15:16:46 -0700 (PDT)
Sender: Mike Snitzer <snitzer@gmail.com>
Date:   Thu, 3 Jun 2021 18:16:45 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH v5 00/11] dm: Improve zoned block device support
Message-ID: <YLlUzX18P0V2lAek@redhat.com>
References: <20210525212501.226888-1-damien.lemoal@wdc.com>
 <DM6PR04MB708146E418BF65FC2F7847E3E73E9@DM6PR04MB7081.namprd04.prod.outlook.com>
 <YLfO168QXfAWJ9dn@redhat.com>
 <a972018e-781b-c0f8-d18a-168c3d1fe963@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a972018e-781b-c0f8-d18a-168c3d1fe963@kernel.dk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 03 2021 at  1:46P -0400,
Jens Axboe <axboe@kernel.dk> wrote:

> On 6/2/21 12:32 PM, Mike Snitzer wrote:
> > On Tue, Jun 01 2021 at  6:57P -0400,
> > Damien Le Moal <Damien.LeMoal@wdc.com> wrote:
> > 
> >> On 2021/05/26 6:25, Damien Le Moal wrote:
> >>> This series improve device mapper support for zoned block devices and
> >>> of targets exposing a zoned device.
> >>
> >> Mike, Jens,
> >>
> >> Any feedback regarding this series ?
> >>
> >>>
> >>> The first patch improve support for user requests to reset all zones of
> >>> the target device. With the fix, such operation behave similarly to
> >>> physical block devices implementation based on the single zone reset
> >>> command with the ALL bit set.
> >>>
> >>> The following 2 patches are preparatory block layer patches.
> >>>
> >>> Patch 4 and 5 are 2 small fixes to DM core zoned block device support.
> >>>
> >>> Patch 6 reorganizes DM core code, moving conditionally defined zoned
> >>> block device code into the new dm-zone.c file. This avoids sprinkly DM
> >>> with zone related code defined under an #ifdef CONFIG_BLK_DEV_ZONED.
> >>>
> >>> Patch 7 improves DM zone report helper functions for target drivers.
> >>>
> >>> Patch 8 fixes a potential problem with BIO requeue on zoned target.
> >>>
> >>> Finally, patch 9 to 11 implement zone append emulation using regular
> >>> writes for target drivers that cannot natively support this BIO type.
> >>> The only target currently needing this emulation is dm-crypt. With this
> >>> change, a zoned dm-crypt device behaves exactly like a regular zoned
> >>> block device, correctly executing user zone append BIOs.
> >>>
> >>> This series passes the following tests:
> >>> 1) zonefs tests on top of dm-crypt with a zoned nullblk device
> >>> 2) zonefs tests on top of dm-crypt+dm-linear with an SMR HDD
> >>> 3) btrfs fstests on top of dm-crypt with zoned nullblk devices.
> >>>
> >>> Comments are as always welcome.
> > 
> > I've picked up DM patches 4-8 because they didn't depend on the first
> > 3 block patches.
> > 
> > But I'm fine with picking up 1-3 if Jens provides his Acked-by.
> > And then I can pickup the remaining DM patches 9-11.
> 
> I'm fine with 1-3, you can add my Acked-by to those.

Thanks, did so.

Damien: I've staged this patchset in linux-next via the dm-5.14 branch of linux-dm.git

Might look at optimizing the fast-path of __map_bio further, e.g. this
leaves something to be desired considering how niche this all is:

        /*
         * Check if the IO needs a special mapping due to zone append emulation
         * on zoned target. In this case, dm_zone_map_bio() calls the target
         * map operation.
         */
        if (dm_emulate_zone_append(io->md))
                r = dm_zone_map_bio(tio);
        else
                r = ti->type->map(ti, clone);

Does it make sense to split out a new CONFIG_ that encapsulates legacy
zoned devices?
