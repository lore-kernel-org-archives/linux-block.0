Return-Path: <SRS0=+obT=ZO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B373AC432C0
	for <linux-block@archiver.kernel.org>; Fri, 22 Nov 2019 13:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82DE120718
	for <linux-block@archiver.kernel.org>; Fri, 22 Nov 2019 13:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nA5YGCJv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbfKVNUA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Nov 2019 08:20:00 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43241 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727436AbfKVNUA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Nov 2019 08:20:00 -0500
Received: by mail-lj1-f195.google.com with SMTP id y23so7306429ljh.10
        for <linux-block@vger.kernel.org>; Fri, 22 Nov 2019 05:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ky4ZxywYAc+Y33e81VVZxLUui9CmXsPpxMd7CkRfNgs=;
        b=nA5YGCJv7mfGExcfpgFDbA51hzmZP8EaXOT8OIj85jOGLkm0sKOfjCpHKhWfCRX69w
         Utvi1zv9EQCtFN2AQG8xmomFl81pCO8P8g8CU1Pv4On5nxehd9L6F431xv6DCnjFhZc1
         zQd+gkPVR1pBH8hk1+YSPQeTZ/gqWTmPuq5GfDTABnrjLYfrG0ftjeZELZm2MMlG9A0y
         QBdtF3gt4BUc7app399ydHOGAV/cz5f+zb25BiH4OYagOAeVkSnqXfvKYikMQ49lHfAP
         TWHj/xZDFI9LBF265eoybrPJt9nBL2orV+H/yvBzr7UE8xxYxWQVylGR8Ho2p0OKLUR4
         vXXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ky4ZxywYAc+Y33e81VVZxLUui9CmXsPpxMd7CkRfNgs=;
        b=NZGUtB8O5iFzK2gwmBctNkE6mYrqqFq0ZS1Txtmd3ouhKFn2PxvDtT7XTQshGNmCjD
         8ShoVCVJypZZaJCUDSXQRXUVgtoOkPBKXMidw5DK6/oETbpBmFE9IygM/v6wAqUrbw/Z
         L8ryQNgqTpUVpcXAkaSCSLzyxgnVZ+2r44Yrae54MDxMAbp+OgafVm+yFZS752W1T3rN
         mZlBeGVrfENe0N/NKYuAjOA81yuECt72wYCs+ZusQjfl9dSOU6CJFamjnFsTrM2omquB
         TMpp9rETBfpzQ/PlUxessHX8zW9vk5WcJuhrQ/0A53EnoknECWGH4PiT+CpkF4Xe0bO0
         6yDw==
X-Gm-Message-State: APjAAAXCJ68v9qLrtqCuhmwTeYoYVuuKjhSr5VY6P63dG6ZyYNIB/8rq
        qUrPSr73cr4Ty6O4WaN2S/aKX8QEqyrBq6ssuDoyKQ==
X-Google-Smtp-Source: APXvYqzsXRJ0uHFXWFY2JziwYUuhBbAM6FTAlyCIQvNWywzWDx3C30LPctoTeZgyo6clI/qIvp12Yv4j+nKffbYsfl0=
X-Received: by 2002:a2e:161b:: with SMTP id w27mr12308656ljd.183.1574428796307;
 Fri, 22 Nov 2019 05:19:56 -0800 (PST)
MIME-Version: 1.0
References: <cover.1573456283.git.baolin.wang@linaro.org> <CAK8P3a1we9D5C2NOBww=cW-4L1PT3t0NnDRmknLwiLm652TmKg@mail.gmail.com>
 <CAMz4kuK9HEuGdhNqHO_qoy9jD=ccsPPhD_dKYwNRgQyWyYwqRA@mail.gmail.com>
 <CAK8P3a0rNhyxmUWLUV1js3FsuAESDOPX3E4b8ActtL4GRT4uTA@mail.gmail.com>
 <CADBw62pzV+5ZXBEbFvTQJ9essAd4cd7Xkz5j9AXB5rAQy0wLqA@mail.gmail.com>
 <CAMz4kuK_3q4JY1vNXe6zGHDNF8Ep-SkcUq6Z25r790VSz4+Bjw@mail.gmail.com> <CAK8P3a11vJb1riYseqPnF_5SuJA+YnYuGwC0XWx6_rk+eQ0Bmw@mail.gmail.com>
In-Reply-To: <CAK8P3a11vJb1riYseqPnF_5SuJA+YnYuGwC0XWx6_rk+eQ0Bmw@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 22 Nov 2019 14:19:44 +0100
Message-ID: <CACRpkdbzN8_YFT0Di88Oi1j+TTMT-VJLSbv6J8jxP+AsA3j1Dg@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] Add MMC software queue support
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "(Exiting) Baolin Wang" <baolin.wang@linaro.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.com>,
        linux-block <linux-block@vger.kernel.org>,
        Paolo Valente <paolo.valente@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 22, 2019 at 10:50 AM Arnd Bergmann <arnd@arndb.de> wrote:

> I suppose to make the submission non-blocking, all operations that
> currently block in the submission path may have to be changed first.
>
> For the case of a partition switch (same for retune), I suppose
> something like this can be done:
>
> - in queue_rq() check whether a partition switch is needed. If not,
>   submit the current rq
> - if a partition switch is needed, submit the partition switch cmd
>   instead, and return busy status
> - when the completion arrives for the partition switch, call back into
>   blk_mq to have it call queue_rq again.
>
> Or possibly even (this might not be possible without signifcant
> restructuring):
>
> - when preparing a request that would require a partition switch,
>   insert another meta-request to switch the partition ahead of it.
>
> I do realize that this is a significant departure from how it was done
> in the past, but it seems cleaner that way to me.

This partition business really need a proper overhaul.

I outlined the work elsewhere but the problem is that the
eMMC "partitions" such as boot partitions and the usecase-defined
"general" partition (notice SD cards do not have this problem)
are badly integrated with the Linux partition manager.

Instead of mapping these partitions 1:1 to the Linux
partitions they are separate block devices with their own
block queue while still having a name that suggest they
are just a partition of the device. Which they are. The
only thing peculiar with them is that the firmware in the
card are aware of them, I think the partitions that are
not primary may trade update correctness for speed,
such that e.g. boot partitions may have extra redundant
pages in the device so that they never become corrupted.
But card vendors would have to comment.

This has peculiar side effects yielding weird user experiences
such that
dd if=/dev/mmcblk0 of=my-mmc-backup.img
will actually NOT make a backup of the whole device,
only the primary partition.

This should be fixed. My preferred solution would be to just
catenate the logical blocks for these partitions beyond those
of the primary partition, stash these offsets away somewhere
and when they are accessed, insert special partition switch
commands into the block scheduler just like you said.

Right now the MMC core is trying to coordinate the uses of
different partitions by arbitrating different requests from
typically 4 different block devices instead which isn't very
good to say the least.

Also each block device eats memory
and it should really just be one block device.

Yours,
Linus Walleij
