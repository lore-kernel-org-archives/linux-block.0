Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760BBC4338F
	for <linux-block@archiver.kernel.org>; Mon, 26 Jul 2021 19:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CD2160F11
	for <linux-block@archiver.kernel.org>; Mon, 26 Jul 2021 19:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbhGZSWB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Jul 2021 14:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbhGZSWA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Jul 2021 14:22:00 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49750C061757
        for <linux-block@vger.kernel.org>; Mon, 26 Jul 2021 12:02:29 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id mt6so14262473pjb.1
        for <linux-block@vger.kernel.org>; Mon, 26 Jul 2021 12:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oIZ9pdo2+5OpdZQpx9ZlAKftbuTis/k6Y9QzdC2OCF0=;
        b=TOqWzBMBvAvBP5ZJ/YvVVNGJ1P7PyBJvF04uepFI7c3aMLnvkJ+XaLVfcLnhRQIE1w
         6wM93Atbrz95Xoh/wmyw5LXQCS8jCEJFwNecKgLKOmyyhUC7wEoXM49iX9cYoIYp8dDq
         PAdFvGt2sw7+ele0JcsNpY4t6B46Ylf0BDSEf9QuinqD4aZTHtXUzq2ASdrb6XTdcF6I
         6Qa8abvIT2My+O+Y3EkC6D7TGBiXkPxEWq+SfYaiTiYu8N33BIQMJSvdijXPXwIUcy3X
         cTgaymZWaBK1yXJcKTL53jdZGjj+Uur9BsGJNBaJsdsghiYdAdDY4c8/WLDGEWAdM3gy
         ojig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oIZ9pdo2+5OpdZQpx9ZlAKftbuTis/k6Y9QzdC2OCF0=;
        b=EDhWWRbeVWvPlRIt3K4jHSgKcv4/qqkgebHa3Xe7TTqoLvYesi83mf7JlAPAm1WG5O
         DTULCaQsrk6iuM+kfP4+dE34lRJpCxyKcwBvAuLUomUGTcJYAObkeRSjOElP6Du8m6A4
         2ZUB/JQxDpaZH2uOzwyuM7G7btGccQG8uvQihcwvQtFvyA34HsOK30TNsPuK8Ex9nx6W
         eyvPBF/IIHIwIgBCwuBcBJaEkNJQYEMocOxbHx4DVpyVNTqigaAgbmQBEfb3hUpTv2wK
         D8GZOfHuxN9QHrEXj3TathcePgQGpsfA+zNIs7AJSyoeYnLAXfsklJSoIDTwZKtAre09
         7+UA==
X-Gm-Message-State: AOAM533NH4gFmiaF1catkzjFmGdwZNeVgFRFk7hGuektVZMX3hOlYtDH
        K10X/yXUkvHGOw8/zKzkRn8yBg==
X-Google-Smtp-Source: ABdhPJyl/PKPM61AWdtCCdVmH92Ret+f2NB7iRnPe/CZTd0nNiu96ZlhLc1Su0/mm/iAdtNVmaiO2g==
X-Received: by 2002:a05:6a00:139e:b029:337:1895:b702 with SMTP id t30-20020a056a00139eb02903371895b702mr19046618pfg.39.1627326148693;
        Mon, 26 Jul 2021 12:02:28 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:3bd7])
        by smtp.gmail.com with ESMTPSA id bg8sm413782pjb.4.2021.07.26.12.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 12:02:28 -0700 (PDT)
Date:   Mon, 26 Jul 2021 12:02:26 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH blktests 0/2] zbd: Support dm-crypt
Message-ID: <YP8GwrYGzv+Q/CQR@relinquished.localdomain>
References: <20210713101239.269789-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210713101239.269789-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 13, 2021 at 07:12:37PM +0900, Shin'ichiro Kawasaki wrote:
> Linux kernel 5.9 added zoned block device support to dm-crypt. With this zoned
> dm-crypt device, zbd group test cases pass except zbd/007. This series makes
> required changes to allow the test case zbd/007 pass with zoned dm-cyrpt
> devices. The first patch adds dm-crypt support to the helper function
> _get_dev_container_and_sector(). The second patch wipes out broken data on the
> dm-crypt devices which was left after the test case run.
> 
> Shin'ichiro Kawasaki (2):
>   zbd/rc: Support dm-crypt
>   zbd/007: Reset test target zones at test end
> 
>  tests/zbd/007 |  7 +++++++
>  tests/zbd/rc  | 20 ++++++++++++++------
>  2 files changed, 21 insertions(+), 6 deletions(-)

The patches look reasonable. Could you provide instructions on how to
run with zoned dm-crypt so I can run the tests?
