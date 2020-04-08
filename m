Return-Path: <SRS0=kJV6=5Y=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29296C2D0F4
	for <linux-block@archiver.kernel.org>; Wed,  8 Apr 2020 21:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFBDC206C0
	for <linux-block@archiver.kernel.org>; Wed,  8 Apr 2020 21:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="NqFHqnY+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbgDHVmV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Apr 2020 17:42:21 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43968 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbgDHVmV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Apr 2020 17:42:21 -0400
Received: by mail-pl1-f193.google.com with SMTP id z6so1529649plk.10
        for <linux-block@vger.kernel.org>; Wed, 08 Apr 2020 14:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=y13uEv6Fgz9TaywtPdvBTbDFr+FurRWpRX9hajRnWSQ=;
        b=NqFHqnY+q1H3rPYhJubaOur0ns3gEVEXdNaaqxERauQ9CSNW1JoP3JrksLu7zezOlw
         UaQmvUuBoHarK2a5WEdgr6K1MV8ChQOSMtnY6Q6B6gOpvwK5uE3B14ghRDevp8jI82eR
         t8qRKGyz9RjrOu8xbhDa3L0wsDMsl7z7vSqRZ0ofngxlVG6hU3cCwwOHk6QFXqbkt5/G
         N16hBTAVyVapSYWUS7VHxhtpmjnKjB58vqxdEVgtG7iNWnYAy3HdTvUhrZ9pnhhSIs0m
         Whbk7AOL+cGVeIAEI2cBzg+8Tg89/YFwjr3IS54/rLmR+y06x+s+hNRggY3mIuvq2S8p
         ixRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=y13uEv6Fgz9TaywtPdvBTbDFr+FurRWpRX9hajRnWSQ=;
        b=s3hoaf1MVT8QZFT9CvVbytNgGlYJCU35xt+mhmfgGjQwIjrX1bSOkHBZCmMDzqAa0S
         qyI0NWr76JaaKzjD5MIGRjUSjXusajWXwlSTplLCp1rXNh1LREe5+LV2T7N23lyvir93
         30a9e7HlSuRsEgJFwSx5UkPU2j7QB832sBDXQCIY6VvgsuW+k+xXgn/wh/uOcV53E4Lv
         S1OdCHZR6eRrvakpYuAf5ppe4vdmnHQpYSDWlAcQq9qgR6wNUvNgo4aa8gT/le6inMWr
         KATpvN4mfZFHdXGNLgzUwYNvyz7SNU4H7VOCi5deaabG/g+5pY/9SPbTDizjnFTgWOKy
         EkBw==
X-Gm-Message-State: AGi0PuYvTbw8DNzEWTrkp0+qFTrpqntxmvuFBY81QySXlMJq04F/E2xy
        L0wRpYqcf/05HNN1EBoceSyMfrwDK/g=
X-Google-Smtp-Source: APiQypIl4lV0nAyGDmCbqJ0H3TUOj4HUo4emZCLmic3FqPTDL0go2edjHP3uXnTOq52aUL8nII5rsQ==
X-Received: by 2002:a17:90a:fd90:: with SMTP id cx16mr7781359pjb.41.1586382139541;
        Wed, 08 Apr 2020 14:42:19 -0700 (PDT)
Received: from vader ([2620:10d:c090:400::5:9008])
        by smtp.gmail.com with ESMTPSA id hg20sm454205pjb.3.2020.04.08.14.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 14:42:19 -0700 (PDT)
Date:   Wed, 8 Apr 2020 14:42:17 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     Weiping Zhang <zwp10758@gmail.com>,
        Weiping Zhang <zhangweiping@didiglobal.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktest] nvme/033: add test case for nvme update hardware
 queue count
Message-ID: <20200408214217.GB226277@vader>
References: <20200407141621.GA29060@192.168.3.9>
 <BYAPR04MB49657AC1B762EA5450AA178986C30@BYAPR04MB4965.namprd04.prod.outlook.com>
 <CAA70yB7Z8bkQAaPy+u8FPme4Y34O6CTw=YCXEJ+_W57M1CxzFg@mail.gmail.com>
 <SN6PR04MB49739887B3BFD2227648B5B186C00@SN6PR04MB4973.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SN6PR04MB49739887B3BFD2227648B5B186C00@SN6PR04MB4973.namprd04.prod.outlook.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 08, 2020 at 04:27:58PM +0000, Chaitanya Kulkarni wrote:
> On 04/08/2020 05:19 AM, Weiping Zhang wrote:
> > Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com> 于2020年4月7日周二 下午11:32写道：
> >>
> > Hi Chaitanya,
> > Thanks your review
> >
> >>> +     # backup old module parameter: write_queues
> >>> +     file=/sys/module/nvme/parameters/write_queues
> >>> +     if [[ ! -e "$file" ]]; then
> >>> +             echo "$file does not exist"
> >>> +             return 1
> >>> +     fi
> >> can we skip the test ? I think Omar added a feature to skip the test.
> >
> Please have a look this discussion :-
> https://www.spinics.net/lists/linux-block/msg50491.html
> > What feature can be used here, I don't see any rc file "set -e".
> >>> +     old_write_queues="$(cat $file)"
> >>> +
> >>> +     # get current hardware queue count
> >>> +     file="$sys_dev/queue_count"
> >>> +     if [[ ! -e "$file" ]]; then
> >>> +             echo "$file does not exist"
> >>> +             return 1
> >>> +     fi
> >> Same here.
> >>> +     cur_hw_io_queues="$(cat "$file")"
> >>> +     # minus admin queue
> >>> +     cur_hw_io_queues=$((cur_hw_io_queues - 1))
> >>> +
> >>> +     # set write queues count to increase more hardware queues
> >>> +     file=/sys/module/nvme/parameters/write_queues
> >>> +     echo "$cur_hw_io_queues" > "$file"
> >>> +
> >> Shouldn't we check if new queue count is set here by reading
> >> write_queues ?
> > Most of time, this parameter will not equal to io queue_count,
> > if really so, it will makes this test case be more complicated.
> >
> >>> +     # reset controller, make it effective
> >>> +     file="$sys_dev/reset_controller"
> >>> +     if [[ ! -e "$file" ]]; then
> >>> +             echo "$file does not exist"
> >>> +             return 1
> >>> +     fi
> >> I think we need to add a helper to verify all the files and skip the
> >> test required file doesn't exists. Also, please use different variables
> >> representing different files.
> > The reason why use same variable name $file, is that copy and paste
> > code(check file exist or not).
> >
> > If common/rc include "set -e", all these checks can be removed.
> >
> >>> +     echo 1 > "$file"
> >>> +
> >>> +     # wait nvme reinitialized
> >>> +     for ((m = 0; m < 10; m++)); do
> >>> +             if [[ -b "${TEST_DEV}" ]]; then
> >>> +                     break
> >>> +             fi
> >>> +             sleep 0.5
> >>> +     done
> >>> +     if (( m > 9 )); then
> >>> +             echo "nvme still not reinitialized after 5 seconds!"
> >>> +             return 1
> >>> +     fi
> >>> +
> >>> +     # read data from device (may kernel panic)
> >>> +     dd if="${TEST_DEV}" of=/dev/null bs=4096 count=1 status=none
> >>> +
> >> This should not lead to the kernel panic. Do you have a patch to fix
> >> the panic ? If not can you please provide information so that we can
> >> fix the panic and make test a test which will not result in panic ?
> >>
> > The patch is under the review, for more detail please visit:
> > https://patchwork.kernel.org/patch/11476409/
> 
> We need to wait for the patch to get in first before we add test with 
> fixes tag. I'm not sure is it a good idea to have a test which results
> in panic when patch in discussion is not in the tree, in that case are 
> testing the known failure.
> 
> We need to add a test to validate and pass the fix and make sure as
> development goes on fixed code is stable.
> 
> Tests in blktests should always pass based on the feature or a fix,
> unless further development adds a regression or has an indirect effect.
> 
> Omar any thoughts ?

Yeah, it's probably a good idea to wait to merge this until the commit
has hit mainline.
