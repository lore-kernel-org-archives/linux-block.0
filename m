Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 264D5C433B4
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 08:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7BBE613BE
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 08:26:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234429AbhDFI0Y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Apr 2021 04:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233333AbhDFI0U (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Apr 2021 04:26:20 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75076C06174A
        for <linux-block@vger.kernel.org>; Tue,  6 Apr 2021 01:26:13 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id w3so20536394ejc.4
        for <linux-block@vger.kernel.org>; Tue, 06 Apr 2021 01:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ahi/D8bf8CpBOvALvKxRw7lvvFdMQkT7+2MN/XWfTKM=;
        b=Cv79ims9QHjo8Nxb4Dj/si7IGo6FqIFZozqePjtOKFMQ2LYXBHHRIK1bJFatR5TS5G
         itE06G3XusaN+sVPp6oiilbl7cc+a1G8ZdSSF9ldlUP9YMa2xUB/FCFY3h0SeIOId7Rs
         ZTmQAEOhduXcGjANS+/DaW6tipH0JxLen7UiGIk/8gL3lGpiWwH6JMl5DPmn2X7ts7ii
         imQfq044GkMIc58w/awL7DGMaE7/jJ0ztiEBiOGh6QjQKA8DJ6ERX9xvDyaKcXUvc6Jc
         mc3X5LR6hDqOL58u+vB5yz8pI/pVaKHzWhmdZiV5/V4ZBh35KutQmfM0iXBu0U+Wohrw
         X8GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ahi/D8bf8CpBOvALvKxRw7lvvFdMQkT7+2MN/XWfTKM=;
        b=Z3iJC8o1rlyOK1GKIqs+joNuo8My8R/b/VQrIa5pvKq1YMUh7A07XBFWLJQjBW/Dnj
         3Vng7j4zAu++glcN0kAaiC+QaYyw5okzsE8f7ebIX3W2rMoQHZN45FuUrqvzvIjZL5MR
         UVAbBExRUwc6oHaw+Vx1A/o7U6y0R0MxFYvtDoyuCgwigInTfrg79yxS7IYMOB3jYHXB
         eFmokbnqfn0c/8/NZKN94wH7H6UwWuDnwW5QnLgALnHUqjG3mXXESf1hPAeI2/yAZwIs
         AalI4GY0fOzn1SbGT0S82OQrkDpxFK8WPQfYFojfqJszWu1wBVESXWf4u6qPGamVZVtX
         zQqw==
X-Gm-Message-State: AOAM533bdwhpkiXkszGntdgWdkRuJ7YgmWEdujvr1U8CmbWEGwTDONem
        pEXIhU3dkklngIb7u/iQqnq/t3IWpsQV1W6qEEz7NZ8hZci4GBZV
X-Google-Smtp-Source: ABdhPJwIJ0IYWZUmFrOT7dbiZ9Nr/Y4h+KsMo48XsQmIS0xNFocApbhlakJZgWLOPNMMUkv89i/pVsGZVxHVaWePwSw=
X-Received: by 2002:a17:906:4a98:: with SMTP id x24mr8774214eju.238.1617697572147;
 Tue, 06 Apr 2021 01:26:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210406070716.168541-1-gi-oh.kim@ionos.com> <20210406070716.168541-19-gi-oh.kim@ionos.com>
In-Reply-To: <20210406070716.168541-19-gi-oh.kim@ionos.com>
From:   Gioh Kim <gi-oh.kim@ionos.com>
Date:   Tue, 6 Apr 2021 10:25:36 +0200
Message-ID: <CAJX1YtaA=RccBa=JT9=Bf9+bh3K2A4o_YWFUkMWqz6PEvdGP5A@mail.gmail.com>
Subject: Re: [PATCHv3 for-next 18/19] block/rnbd-clt-sysfs: Remove copy buffer
 overlap in rnbd_clt_get_path_name
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, Haris Iqbal <haris.iqbal@ionos.com>,
        Jinpu Wang <jinpu.wang@ionos.com>,
        Dima Stepanov <dmitrii.stepanov@cloud.ionos.com>,
        Dima Stepanov <dmitrii.stepanov@ionos.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 6, 2021 at 9:07 AM Gioh Kim <gi-oh.kim@ionos.com> wrote:
>
> From: Dima Stepanov <dmitrii.stepanov@cloud.ionos.com>
>
> cppcheck report the following error:
>   rnbd/rnbd-clt-sysfs.c:522:36: error: The variable 'buf' is used both
>   as a parameter and as destination in snprintf(). The origin and
>   destination buffers overlap. Quote from glibc (C-library)
>   documentation
>   (http://www.gnu.org/software/libc/manual/html_mono/libc.html#Formatted-Output-Functions):
>   "If copying takes place between objects that overlap as a result of a
>   call to sprintf() or snprintf(), the results are undefined."
>   [sprintfOverlappingData]
> Fix it by initializing the buf variable in the first snprintf call.
>
> Fixes: 91f4acb2801c ("block/rnbd-clt: support mapping two devices")
> Signed-off-by: Dima Stepanov <dmitrii.stepanov@ionos.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
+ Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
