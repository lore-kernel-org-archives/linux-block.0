Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97AE1C433FE
	for <linux-block@archiver.kernel.org>; Mon, 13 Sep 2021 13:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B43260E9B
	for <linux-block@archiver.kernel.org>; Mon, 13 Sep 2021 13:08:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbhIMNJc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Sep 2021 09:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240549AbhIMNIZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Sep 2021 09:08:25 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E651C0613E3
        for <linux-block@vger.kernel.org>; Mon, 13 Sep 2021 06:04:25 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id g8so14265627edt.7
        for <linux-block@vger.kernel.org>; Mon, 13 Sep 2021 06:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RdZIbAXToH2hKnMoOgcNJetW3sB4TakM6/Gu+YymAek=;
        b=izZyz2feW7dGhCXYTMMF4aZ3jsrOSm9wZoPL4GYBVpH0iqzNDTBI6QonCQndXTo8B1
         G6nQMUCTup9+QxJDfo+X/ouparDGBcwr1VLaVWNd7+K7XDdDZZIeOlPzGhiy2h6q4nay
         /I2jEbXQI9NT6c+FEo/4LGSAo4eWPCsg4fsOGkysVqBC94KGXhC0gAY98vKhZK64WJj7
         knrN7UwBw6uAwRfnZZ/MpvhKy5R414BYs7DubqVHLTsHatfn/Cm2mWC2b6qR5loTAPnM
         G63mNfTzu9Wfj+fUzIDrV3IaiWKevCQ3NY/zC77sld87++CljjvKFoScqUwOgCOtszgm
         FWFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RdZIbAXToH2hKnMoOgcNJetW3sB4TakM6/Gu+YymAek=;
        b=EVemGJBMKc74+V2tOUs3H3OjO6PIed+xAhJzaQcuoKGJBy9pfhv7ArdRz59mo0kuix
         p425pNw/6QCOnGGoeN5rGyT+rKKZpxQak1bDy/3rcZJcJywqyX/LLshySiyuMSJiZ51E
         61RnHLf04JjwjqMJ++58x6g+wpTkg22T0tEYhYlU7auKv8GI1CKzdGMxuP1kF8EXwO3m
         Hm9cv7iUnMJD+YSny5e+6AEoy4BQcZOpqVmnqdZF4uMr64VyfkaIc6vA+qPPkLMK/tfd
         h1p7Bc4n21LrRsydr39DUzopUrg+u9CbpHM1+PhZtgSLE23QQ3KHxBiWKriHF2FWCVf9
         wmHg==
X-Gm-Message-State: AOAM531xiKSmpJmQ7R4fFlaMUTox9HZnTbJ0fPLz6Q1vZK2ptMzpTuI0
        Z6DsJr4A2eBEGLxKqgxyGP7B7yJttwsxBYcb0n5g
X-Google-Smtp-Source: ABdhPJxOPGkgUMqV406W6cTQRA3871Dh3U5yHZzeFHo/tYTiO+Qb4cIm7gKZb5H41heGhAFw+wvjdi8+TobrjHA2l2g=
X-Received: by 2002:a05:6402:2048:: with SMTP id bc8mr13154783edb.114.1631538264046;
 Mon, 13 Sep 2021 06:04:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210913112557.191-1-xieyongji@bytedance.com> <20210913112557.191-4-xieyongji@bytedance.com>
 <YT9HFOTnBFWMUE74@infradead.org>
In-Reply-To: <YT9HFOTnBFWMUE74@infradead.org>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Mon, 13 Sep 2021 21:04:12 +0800
Message-ID: <CACycT3uo6GqLx8i=rtn9P2kaSGHjnNnamX3KR0Xgq_5QEhWWUA@mail.gmail.com>
Subject: Re: [PATCH 3/3] nbd: Use invalidate_gendisk() helper on disconnect
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        yixingchen@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Sep 13, 2021 at 8:43 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, Sep 13, 2021 at 07:25:57PM +0800, Xie Yongji wrote:
> > +             invalidate_gendisk(nbd->disk);
> > +             if (nbd->config->bytesize)
> > +                     kobject_uevent(&nbd_to_dev(nbd)->kobj, KOBJ_CHANGE);
>
> I wonder if the invalidate helper should just use
> set_capacity_and_notify to take care of the notification in the proper
> way.  This adds an uevent to loop, and adds the RESIZE=1 argument to
> nbd, but it feels like the right thing to do.

Looks like set_capacity_and_notify() would not do notification if we
set capacity to zero. How about calling kobject_uevent() directly in
the helper?

Thanks,
Yongji
