Return-Path: <SRS0=cAVD=QH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A2ABC169C4
	for <linux-block@archiver.kernel.org>; Thu, 31 Jan 2019 21:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2FB62082C
	for <linux-block@archiver.kernel.org>; Thu, 31 Jan 2019 21:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtQ1i6oq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725855AbfAaVVC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 31 Jan 2019 16:21:02 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41736 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfAaVVC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Jan 2019 16:21:02 -0500
Received: by mail-qk1-f195.google.com with SMTP id 189so2791911qkj.8
        for <linux-block@vger.kernel.org>; Thu, 31 Jan 2019 13:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5g16FN1CiLKKhVQZ/I1EKlHuZ+SK1dJlxdB/khUFP8c=;
        b=BtQ1i6oqDgCIlMFCXtBaC/siijJWQb34PnGxq6yXhi6whVjf+7bzLFK85JkugCrspA
         K/XqmMs+8HmY2K5FwYdzHIkoGqJPT5jPIzfKzc1pc5RiKU9PwrEPXchsj6VYI/X+/9RT
         7Lomr9uWh90noDM7eZbTsqv3fLsyyt/UGr37pIcRdr84qvtbEhWuWJ6KmOzyyTWkCWXZ
         cK69hGt0q3qiwBT6JwjlsBx41TKYXAD1SyMZEDhcd6BOlNF0X5byikW52YcSSOGUx9wh
         pE6M8k4Hq8zb7fzNRhH1h7u9gbIAf0aabVdY1nDbqsd7LCNo3d7zoAn2JwJbbAw5VsdE
         R5cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5g16FN1CiLKKhVQZ/I1EKlHuZ+SK1dJlxdB/khUFP8c=;
        b=CQjijEOoe9GOZGe3VX7OXg0bCFBEJHdkPc764BP513gjQSaobVxHoTmh54qVs/U5ka
         0hLn5HKU/Qe1QM2qw52KiH1x6nacoIUkobQqjAQ2gZsvVaiv5pAqaPPEKEEVJthZT3r0
         DV+GgIZtiEh0miC7EzALyEnQUDbbRz+lTVh1/n86r7+XIkdEaCMk1dFG9j1q4XXP4URz
         eIhhgYbn4fsOsj6JrVCEkke+F1K7WZ7aP382QCiubWgEpEZkt+JMFTyLxJaSBpDwiegX
         dlehRfsqiUTYYD4AB1wI5VBY1Q/FoguyWetmIereb3uwW7oMBVtydtYSjaJnQZZQCBMN
         E12w==
X-Gm-Message-State: AJcUukeKPmpaWwAh9FhV6pigrPAVELO51AjI0kltmGcvFq05CWe6j/Gz
        vjNrUV42RXvozDJ8Y2DEBDC9mujsPm6MjC4i7jA=
X-Google-Smtp-Source: ALg8bN52rMI/XkxtlV+sm8o3nTWPEfUw7XN48CXJPwniX0ASHT4yWveeMoNXwRp3ZEVFeo+R9HyjlooLxkHqHPC1MXo=
X-Received: by 2002:a37:5c43:: with SMTP id q64mr32195297qkb.329.1548969660601;
 Thu, 31 Jan 2019 13:21:00 -0800 (PST)
MIME-Version: 1.0
References: <20181228115148.26474-1-xiaoguang.wang@linux.alibaba.com>
 <9d722c67-dfae-2ee4-74ef-504164fed0bf@linux.alibaba.com> <20190131092625.GB19222@quack2.suse.cz>
 <fa2083f1-058b-c365-338d-a9513d0f8ead@kernel.dk>
In-Reply-To: <fa2083f1-058b-c365-338d-a9513d0f8ead@kernel.dk>
From:   Liu Bo <obuil.liubo@gmail.com>
Date:   Thu, 31 Jan 2019 13:20:49 -0800
Message-ID: <CANQeFDAtw0rn2NtpF_kJtc=eXbcRmhxZewhwFT7XGBt84rzQDw@mail.gmail.com>
Subject: Re: [PATCH] blk-throttle: limit bios to fix amount of pages entering
 writeback prematurely
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jan Kara <jack@suse.cz>,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 31, 2019 at 5:50 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 1/31/19 2:26 AM, Jan Kara wrote:
> > Hi!
> >
> > On Thu 31-01-19 10:03:34, Xiaoguang Wang wrote:
> >>> Currently in blk_throtl_bio(), if one bio exceeds its throtl_grp's bps
> >>> or iops limit, this bio will be queued throtl_grp's throtl_service_queue,
> >>> then obviously mm subsys will submit more pages, even underlying device
> >>> can not handle these io requests, also this will make large amount of pages
> >>> entering writeback prematurely, later if some process writes some of these
> >>> pages, it will wait for long time.
> >>>
> >>> I have done some tests: one process does buffered writes on a 1GB file,
> >>> and make this process's blkcg max bps limit be 10MB/s, I observe this:
> >>>     #cat /proc/meminfo  | grep -i back
> >>>     Writeback:        900024 kB
> >>>     WritebackTmp:          0 kB
> >>>
> >>> I think this Writeback value is just too big, indeed many bios have been
> >>> queued in throtl_grp's throtl_service_queue, if one process try to write
> >>> the last bio's page in this queue, it will call wait_on_page_writeback(page),
> >>> which must wait the previous bios to finish and will take long time, we
> >>> have also see 120s hung task warning in our server.
> >>>
> >>> To fix this issue, we can simply limit throtl_service_queue's max queued
> >>> bios, currently we limit it to throtl_grp's bps_limit or iops limit, if it
> >>> still exteeds, we just sleep for a while.
> >> Ping :)
> >>
> >> The fix method in this patch is not good, I had written a new patch that
> >> uses wait queue, but do you think this is a blk-throttle design issue and
> >> needs fixing? thanks.
> >
> > Well, essentially this is a priority inversion issue where low-priority
> > process submits writes and higher priority process blocks on those, isn't
> > it? I think the blk-wbt throttling was meant to address these issues by
> > throttling the process already when submitting bios (i.e. something similar
> > to what you propose in your patch). I'll defer to Jens as a maintainer
> > whether he wants to redirect users to blk-wbt or whether improving
> > blk-throttle to avoid similar issues is desirable. Jens?
>
> I think that blk-throttle usage should be phased out and we can
> hopefully remove it at some point. I also don't think that there's a
> large use base of it, which is good, but does seem active on the Alibaba
> front.
>

The concept of blk-throttle is attractive, but it doesn't make too
much sense to applications' qos in practice because both latency and
throughput are important and blk-throttle are a bit coarse-grained on
this.
So we're not going to stick with it forever.

Now that blk-iolatency has been there, in theory it should help a bit.
However, another thing that what we're expecting is a proportional
setting on IO resource shares.

"Outstanding IO" or "queue depth" based solution sounds like a good
direction, but unlike blk-sq where there's only one queue and queue
depth is fixed, with blk-mq, the problem is that it's difficult to
assign an accurate depth for a weight.

thanks,
liubo
