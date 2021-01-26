Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57DC2C4332D
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 14:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1510722D58
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 14:36:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391731AbhAZOZ2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Jan 2021 09:25:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392070AbhAZOYI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Jan 2021 09:24:08 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D631EC0611C2
        for <linux-block@vger.kernel.org>; Tue, 26 Jan 2021 06:23:25 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id n6so19930243edt.10
        for <linux-block@vger.kernel.org>; Tue, 26 Jan 2021 06:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1czbBZLLxHwEsDj/a0a94VF0yBz3u23rkRDZfhlmeos=;
        b=nyCAT2ReufMhKUDlIx0rQQya1EhvNd3CAXYn6nE2QL4Vmc6395uy5mK+D+jGDLbH8z
         YBTHMXZ5OTYvLZQCey/ax2VfTRjckHrVObU3ETyQjToqgDfw4if7zzGcu1bFvjVsLdLT
         F4gzk6kKy+eZ2ZD6f+6CMfR+xgdho8L/8V2tlsFkR6eehlqnDN5KeIm2DzPp7oGr46TA
         I1QpUnH2hx6ubfWT7ZKBTQ13Ru+n+hkvKoz317kqYa32yGBC2jDOOm4nFn9neiUgZb6E
         n4mwe9IXjh/CKhqAes1aQMDcP5JYr8mrKYekaWRrWhxbJQXU9qlhVaUOoSQLVgeLluAG
         GjNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1czbBZLLxHwEsDj/a0a94VF0yBz3u23rkRDZfhlmeos=;
        b=IsvoJLxs5zfvzhHHiUyE6yxjeOaosm/MNNxkOv8X0ZQmasxVja++2YbUKRMn/0ld16
         xRuGh/IhedBNvY8Fc9bzP5U35o8tJBSsjAYA/qoH5XAK30VjO1TgFuwgYMT3R5AJnDpo
         ohTNGB1/T4g+B6ctIwMCOEy/irbYQIoOqHC7Tl/kEb7Cr2FP87ctliVhsMAd0ncZ8KJw
         i4NauXaMm8B1/maC80WdDx3F5aJVR9SGzfr03KwYACh9TReLOMnt+5Uum6Uay80H8Rnz
         Wt98ylGRODDqKmdOdS1eFo4DhgvKieK/bJBo9lHvi8a1DZdO2u2ekYL5mQnIQeE+/i1m
         cEWg==
X-Gm-Message-State: AOAM533C1Ags3pEZYQba5g3gLazMS30+6SOhRC8PgGo6+9bL8O7x8ljx
        34zQODGtGlm7o1iCZzRH/VxRQ4ru4/OI9K9tzDoQFQ==
X-Google-Smtp-Source: ABdhPJxP3v2LeM908ihblFdyCJ83JaTf4lsLhbskKLoinjZa37ZibxDpo5jfrONK2pUpfuITkUtYiA+FbDR8mmfbk/0=
X-Received: by 2002:a05:6402:3508:: with SMTP id b8mr4815634edd.341.1611671004588;
 Tue, 26 Jan 2021 06:23:24 -0800 (PST)
MIME-Version: 1.0
References: <20210125201156.1330164-1-pasha.tatashin@soleen.com>
 <20210125201156.1330164-2-pasha.tatashin@soleen.com> <YA/fwFU+Wg6+jr85@pevik>
In-Reply-To: <YA/fwFU+Wg6+jr85@pevik>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Tue, 26 Jan 2021 09:22:48 -0500
Message-ID: <CA+CK2bBVdVOP6TmJED4Wndovxf+dGbcbw=0LQ8neAGL_2=TEwA@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] loop: scale loop device by introducing per device lock
To:     Petr Vorel <pvorel@suse.cz>
Cc:     Tyler Hicks <tyhicks@linux.microsoft.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        James Morris <jmorris@namei.org>, lukas.bulwahn@gmail.com,
        hch@lst.de, ming.lei@redhat.com, mzxreary@0pointer.de,
        mcgrof@kernel.org, zhengbin13@huawei.com, maco@android.com,
        Colin King <colin.king@canonical.com>, evgreen@chromium.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 26, 2021 at 4:24 AM Petr Vorel <pvorel@suse.cz> wrote:
>
> Hi,
>
> > Currently, loop device has only one global lock:
> > loop_ctl_mutex.
>
> > This becomes hot in scenarios where many loop devices are used.
>
> > Scale it by introducing per-device lock: lo_mutex that protects the
> > fields in struct loop_device. Keep loop_ctl_mutex to protect global
> > data such as loop_index_idr, loop_lookup, loop_add.
>
> > Lock ordering: loop_ctl_mutex > lo_mutex.
>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>

Thank you for reviewing this patch.

Pasha
