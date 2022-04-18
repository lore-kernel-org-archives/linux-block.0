Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C9F6C433F5
	for <linux-block@archiver.kernel.org>; Mon, 18 Apr 2022 22:02:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbiDRWFA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Apr 2022 18:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbiDRWE7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Apr 2022 18:04:59 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFBD2183A
        for <linux-block@vger.kernel.org>; Mon, 18 Apr 2022 15:02:19 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id h83so5452313iof.8
        for <linux-block@vger.kernel.org>; Mon, 18 Apr 2022 15:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XmzT5AAYhmnvqS/eMGD8VYGjtoMwIFGHIUevGJUShhU=;
        b=G777KR7pyKZxMS/rwgIHf2BPs63JG71jxWdsTwjODlEDCC8igcx13Mwo4hQ1soxHFc
         G8OEzlE/XIsRuR7MNi+uQxepftoXCVq70N+CvAaSjygHbITpuUS2p3IzExY8Hygi3kkr
         RqBUFY8FMmA0PliJBSqplZrL8bZ+ndT6zqF3Nr4hY46udQjiqovNyxSwCyAHb5Vhl3F/
         ox3tvf1wElw5xqZCDUjJlS6ZosAnLKsNHjiT3HDKQRUdzIPMVMV0lV+YFByNYbYEB1FZ
         MISqgeuShkxNoKGSug5Ubb9Qt8OLmbV+zOduyp7A1pQXFyNr8Rh8oV1CGLIhrWT0Y3Jg
         d+MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XmzT5AAYhmnvqS/eMGD8VYGjtoMwIFGHIUevGJUShhU=;
        b=6fExbyASFZcncc+g+n3Blo2B6q2R8U4gipmWLEVisNh8oqWGwSQ++PQcSJd/mMXbJR
         vnoJRuJhrmUkITiIzmu49vbXbh5AquJpOHiGMCAar2hWvJrwDvdNkJkmQr3ryDsZcECz
         qE7aqW0BcqCaPI5w/ZpL7cT1GU1vZBUBvg1Yc9JYowpizV4qNbqy3i7lfVMdq6rFePjP
         irO6/Hy2f4sNl38EhUCZJtqu2AnopAT2oSHXkCBxw2w5KHqEwZMnt+boai4jtyjKIab/
         91PK/Etug9A4V0IudJpOjpD+E6wYl8aBb7ub1ez572AKS4yeFndX4jpPleJXFEQEjHpO
         DX1Q==
X-Gm-Message-State: AOAM53120CEqzNKXILLsFLUQQmb5Bp6iIx3+/c7xfpCHR3/jWhWvA1er
        k1JAnnop8x7/1W316m6wzqle6Ige2IhZivx+UQtESQ==
X-Google-Smtp-Source: ABdhPJxIWUh3JHhLR1ia3XH5dWxdh70zva4OH8lVebFS8OL4qlX83jJ/NNxnIWkRxYQE7qLX0R5dWj0MUHRrOAMcMFQ=
X-Received: by 2002:a05:6602:14c7:b0:646:3bfb:7555 with SMTP id
 b7-20020a05660214c700b006463bfb7555mr5345702iow.83.1650319338887; Mon, 18 Apr
 2022 15:02:18 -0700 (PDT)
MIME-Version: 1.0
References: <Yl3aQQtPQvkskXcP@localhost.localdomain> <c7f02531-8637-89a2-d8b7-1da03240db73@nvidia.com>
In-Reply-To: <c7f02531-8637-89a2-d8b7-1da03240db73@nvidia.com>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Mon, 18 Apr 2022 18:02:08 -0400
Message-ID: <CAEzrpqeHrrqqn7056Le8nmf+VbUugxXV2QjZeQTraW1dwJHviA@mail.gmail.com>
Subject: Re: Nullblk configfs oddities
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "bvanassche@acm.org" <bvanassche@acm.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 18, 2022 at 5:54 PM Chaitanya Kulkarni
<chaitanyak@nvidia.com> wrote:
>
> On 4/18/22 14:38, Josef Bacik wrote:
> > Hello,
> >
> > I'm trying to add a test to fsperf and it requires the use of nullblk.  I'm
> > trying to use the configfs thing, and it's doing some odd things.  My basic
> > reproducer is
> >
> > modprobe null_blk
> > mkdir /sys/kernel/config/nullb/nullb0
> > echo some shit into the config
> > echo 1 > /sys/kernel/config/nullb/nullb0/power
> >
> > Now null_blk apparently defaults to nr_devices == 1, so it creates nullb0 on
> > modprobe.  But this doesn't show up in the configfs directory.  There's no way
> > to find this out until when I try to mkfs my nullb0 and it doesn't work.  The
> > above steps gets my device created at /dev/nullb1, but there's no actual way to
> > figure out that's what happened.  If I do something like
> > /sys/kernel/config/nullb/nullbfsperf I still just get nullb<number>, I don't get
> > my fancy name.
> >
>
> when you load module with default module parameter it will create a
> default device with no memory backed mode, that will not be visible in
> the configfs.
>
> So you need to load the module with nr_devices=0 that will prevent the
> null_blk to create the default device which is not memory backed and not
> present in the configfs:-
>

Yup I know what it's doing, I'm raising this as it's weird and took me
a bit to work out what was happening, and it annoyed me.  It's not
anything I can't work around, but the UX kinda sucks.  Thanks,

Josef
