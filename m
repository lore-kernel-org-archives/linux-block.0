Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4802BC433EF
	for <linux-block@archiver.kernel.org>; Thu, 10 Feb 2022 17:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbiBJR7B (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Feb 2022 12:59:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245426AbiBJR7A (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Feb 2022 12:59:00 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACFB72D5
        for <linux-block@vger.kernel.org>; Thu, 10 Feb 2022 09:59:01 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id y22so5292358eju.9
        for <linux-block@vger.kernel.org>; Thu, 10 Feb 2022 09:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sECXErGkdA5AQY5nYN+swJSlC5kyNDhNurKnwALjcss=;
        b=S3+QKdIZT/n1tuFwsWq16I65CYe2cOgZSU7RzODHtH0S4CSyemd151bfuoQBun6Hef
         nPA+eNMbg+e1Pyr6xRY36gszEh2GuYAvZfRw8swg1iqtzZPh0dHei9TFwCKpHWcmoc5J
         mtI8gZIYTxmSh7+ai3kmgRuPWhyf8i9QL783gupDAl6/i5pXY16WjW1JPQntecceR8oo
         WtpovzckDYKRYiniNgBadRigw2zsU/1WyKbc8+A/c4S1ySLAELRS/zW98OJm9bgQsw8a
         tukjSBQehu8AHzNnXhrkp6IX66o3bQ3iuHRIXD69O1PdOU7jlFaehNVucI0Z3m/6uucY
         zxRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sECXErGkdA5AQY5nYN+swJSlC5kyNDhNurKnwALjcss=;
        b=nkYT7yDdgy7HlYKaBrebf07R/Mrue4oFktlHLOI3Ui47HmHdyzc06wUpu1tvP3bPzC
         +RzoxY9TRYHpRWsHSGPCtoTvgKLptzule/vZAam4T3HRICaVtTvVwbpoFoSxKs3jl9dH
         S2s7doQygHJLitRrjwq0AJBwnpykyL0cZOWM2pGHILLbY8v2ctj78C6BV0xNDyZv7q0K
         b9tgJzdlctthH4vZ2EvpVk8i6XKG9Yrt70AklHjnzMF0+zbwEgOMbGRpW3r7KUGdbbrs
         Kq41eXJDfDWGOOnNumDQJ0fhCReo3iwQ1Mj9a1dBwXVRRx9+VfrFaN9SKiTfLbWiNf+W
         n4Fw==
X-Gm-Message-State: AOAM530uqeLEHAZcYHz6JoOE+Yi3LWN1L26Dj6zHoNRbY2Fdh2c7GxUb
        3cRwdiX2gCJ6uTXsQN74whmCCcuTLj9F08uIl+oHykXj
X-Google-Smtp-Source: ABdhPJyA42y0veYiF/Kt0dhVlhAhFlLrfai6PciojJPlfsRkNUOE2aBXxgxjVOGXHFtJ/+6/nZnTJK4E3pMCOpwk+n8=
X-Received: by 2002:a17:906:7394:: with SMTP id f20mr7212489ejl.612.1644515940190;
 Thu, 10 Feb 2022 09:59:00 -0800 (PST)
MIME-Version: 1.0
References: <20220205091150.6105-1-chaitanyak@nvidia.com> <20220205091150.6105-2-chaitanyak@nvidia.com>
 <YgPaO0OtJ+NhpNwX@infradead.org>
In-Reply-To: <YgPaO0OtJ+NhpNwX@infradead.org>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 10 Feb 2022 09:58:48 -0800
Message-ID: <CAHbLzkr+ShBzeahNnMnhMaW8zDfHsNGd-ahGa00m4GCMtd6L3g@mail.gmail.com>
Subject: Re: [PATCH V7 1/2] block: create event class for rq completion
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 9, 2022 at 7:14 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> It seems a bit silly to add the even class without the second user.
>
> But I'm fine with this if we'd just merge them together.

OK, I will merge them together. Thanks.
