Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A779C433EF
	for <linux-block@archiver.kernel.org>; Tue,  5 Oct 2021 16:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8411B61269
	for <linux-block@archiver.kernel.org>; Tue,  5 Oct 2021 16:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234405AbhJEQIX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Oct 2021 12:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236312AbhJEQIQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Oct 2021 12:08:16 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5EAEC061749
        for <linux-block@vger.kernel.org>; Tue,  5 Oct 2021 09:06:25 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id na16-20020a17090b4c1000b0019f5bb661f9so2918374pjb.0
        for <linux-block@vger.kernel.org>; Tue, 05 Oct 2021 09:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7q+IhaM1kknSDq25hxz8jvzEHq3QVocRklugewWTNLI=;
        b=QNbfHEuFuUsvzpIlWn02KOAD+LflR3Wtt3lrC3Es4cPOl9YkMBxEggNdtgkaHQU6oC
         QeB9tVKFun16W8zRwS3Nhd72FbmMyTHpPQULXUdntz21Oz5GI/yDOH6sTJH3SEYO34M1
         cw49j0wVnOZ0PVyeupIMbkJGCbqml61lqOQFOtMJjSK/W1LtTtv2GPZaMi/AkKqJbLvU
         ZbLoIFdW+DLLQe6kBCbSZBGqv5cxEAB5+LFL+Yspub9usIU5D2408zR7mPRBFKfGbzjl
         o4MbhqOA/+4PFQB20h3Ssf0+ci9Q/5spr0CMyFuljQDNjfPrfvDP5F7rOaMkMRY1VQUn
         cinA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=7q+IhaM1kknSDq25hxz8jvzEHq3QVocRklugewWTNLI=;
        b=KCrH9M57MUVs/D32xfqV+z13mK35FxzBxaA+yGk9C3GWLNv5RRGIXD0HbO+1zKQArC
         BEVuOxZqcrqDZm+WQ4r72TefnW7WRAYe8Xp+w5jDl79P511J6RjJtDlR7NslA43Z14n3
         I+XV0NpxOFlwJjfBmJ5OJjuaDOCXOp7utGn8sTV60DAN2ek0y94WEdouoD5k4NpSRaVd
         90v/M9ah8XtCufGHfnTF10Kk2JmL6aWORaueVrFaIeaQKUDEaNWZ9ynbMOCbRTbnVhFx
         JXf/g9zuwBRkkgNYofO9CobizC+6nDlRXFpBAgqjiDWqvn53VKhNysxEVDpy3BKoi7Uq
         9RaA==
X-Gm-Message-State: AOAM532yc8TzF5koVlmVyyWzkIjyS/cYLPbOFViWdi3HiGOHWowI9Y3L
        M53XCm9Y7rgZ5Idz8uFGiBmapNVwPYE=
X-Google-Smtp-Source: ABdhPJz/HhfvZ5m3n99Vd0qw4StthChFinI9rUpYxOlgT6OAn3fi6+QU4JhC7g5440uNaeRkDJAuXw==
X-Received: by 2002:a17:90a:12:: with SMTP id 18mr4818642pja.104.1633449985205;
        Tue, 05 Oct 2021 09:06:25 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id w185sm15095260pfd.113.2021.10.05.09.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 09:06:24 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 5 Oct 2021 06:06:23 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCHSET 0/2] Reduce overhead of CONFIG_BLK_CGROUP
Message-ID: <YVx3/0FqXqjd1/xx@slm.duckdns.org>
References: <20211005152922.57326-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211005152922.57326-1-axboe@kernel.dk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 05, 2021 at 09:29:20AM -0600, Jens Axboe wrote:
> Hi,
> 
> As some are probably aware, I've been doing efficiency chasing for
> block devices using io_uring. Currently we can do about 5.1M IOPS using
> a single logical core of a single physical core, but that's with a kernel
> config that's shaved down. Enabling BLK_CGROUP and performance drops to
> ~3.6M for the same test.
> 
> These two patches bring us to 3.9M, which is a nice improvement. More
> work to be done here.

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
