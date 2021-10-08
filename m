Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD070C433F5
	for <linux-block@archiver.kernel.org>; Fri,  8 Oct 2021 09:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C603660EC0
	for <linux-block@archiver.kernel.org>; Fri,  8 Oct 2021 09:17:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236145AbhJHJT2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Oct 2021 05:19:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54876 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229785AbhJHJT1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 8 Oct 2021 05:19:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633684652;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MjDZx1fQKjNQlKZbBeD82QrB0Ihe+5TQzyp1JtFq7hY=;
        b=R1lwqipdk6CR5+D2GNxdPxG5ZAHcbqev1RETOwnGo4ZArC3QZxsw2jPnAlV/FV0mEHMEAQ
        QBaWRNG3QfKhGMPCAfFH3QIYTZpP0bLZBTeuOeApe1y4P1I+x/KnEH5VS6wyJpE9afmyFc
        AXWla/F2rhcZxa9mKAS0YhMEM85WDbE=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-478-5dGGNUFnM_mH6FEFFVoW5g-1; Fri, 08 Oct 2021 05:17:31 -0400
X-MC-Unique: 5dGGNUFnM_mH6FEFFVoW5g-1
Received: by mail-pg1-f199.google.com with SMTP id s19-20020a63e813000000b00287d976d152so1294495pgh.3
        for <linux-block@vger.kernel.org>; Fri, 08 Oct 2021 02:17:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=MjDZx1fQKjNQlKZbBeD82QrB0Ihe+5TQzyp1JtFq7hY=;
        b=UPxXi0dMRoxGf2k2Q63Anofls741WYUBmC1z4ODCKRFjqfZlLDqbAiTs7/s3K9kSdY
         z5ElN1gYe0Fd9RKKK7zm5XeP0oOHctuo3+i9yGiNGVb2vAgnC2fY5lPjCX7w65qpUbfT
         6x3VQ7SzkH93AqbcwrWmNTUh4nuyqvSM0B2HVRjIX1GJpoZYyWEV/Gb5ljm+OBidGWlV
         c1BcLD+Zo7Lbeeu5Imd4/Yx42HRHgjQBTvfRUJ571mFXk5lu30kEDLrJEKqN2PydxmnB
         25pu47Yp+imzxIlXkLkkAmB3bhspOprOfwBvTa2bUCjA+XEV80kgHYBue93IDNZz3r4E
         qowg==
X-Gm-Message-State: AOAM5301Nzhp294EtzOiWmaViuIribwbWOFWMQ+bj18D1rN1ffQ6LGFI
        XtcWHGevlEgG1CSDKUBTalrFQG65oqxmADoncJfWkExu3XpkS8GaahoGkIWYv7WHps9ja6IFbUp
        hUjJl96rI4Xiacn2qI83kpNk=
X-Received: by 2002:a63:f5b:: with SMTP id 27mr3647345pgp.302.1633684649705;
        Fri, 08 Oct 2021 02:17:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyI5sORuIjy5pkP0wq4hXnm4U7ksEGByBSTpcKewsdRuT9q1hV4Sboi0B9e2oU0v3iuXloVFg==
X-Received: by 2002:a63:f5b:: with SMTP id 27mr3647317pgp.302.1633684649455;
        Fri, 08 Oct 2021 02:17:29 -0700 (PDT)
Received: from [10.72.12.176] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id lp9sm1953852pjb.35.2021.10.08.02.17.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Oct 2021 02:17:28 -0700 (PDT)
Subject: Re: nbd lifetimes fixes
To:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
References: <20210825163108.50713-1-hch@lst.de>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <a3d9e740-828a-6b4e-f1d6-b89fc905700c@redhat.com>
Date:   Fri, 8 Oct 2021 17:17:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210825163108.50713-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 8/26/21 12:31 AM, Christoph Hellwig wrote:
> Hi Josef and Jens,
>
> this series tries to deal with the fallout of the recent lock scope
> reduction as pointed out by Tetsuo and szybot and inspired by /
> reused from the catchall patch by Tetsuo.  One big change is that
> I finally decided to kill off the ->destroy_complete scheme entirely
> because I'm pretty sure it is not needed with the various fixes and
> we can just return an error for the tiny race condition where it
> matters.  Xiubo, can you double check this with your nbd-runner
> setup?  nbd-runner itself seems pretty generic and not directly
> reproduce anything here.
>
> Note that the syzbot reproduer still fails eventually, but in
> devtmpfsd in a way that does not look related to the loop code
> at all.
>
Sorry, I think I have missed this thread.

Test this and works well for me by using the nbd-runner.


