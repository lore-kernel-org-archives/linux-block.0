Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F69AC432BE
	for <linux-block@archiver.kernel.org>; Wed, 25 Aug 2021 20:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68273610CD
	for <linux-block@archiver.kernel.org>; Wed, 25 Aug 2021 20:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242566AbhHYUWV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Aug 2021 16:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234138AbhHYUWV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Aug 2021 16:22:21 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33330C061757
        for <linux-block@vger.kernel.org>; Wed, 25 Aug 2021 13:21:35 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id q3so676669iot.3
        for <linux-block@vger.kernel.org>; Wed, 25 Aug 2021 13:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ByOyhUtWzhjBtqjAbMyRHnsC1XBkJmGibznOhFVodjQ=;
        b=STLwbNOvBUT6OElfx0MMqOzLc0Z6e+Juz3Hl/SNRMclDeB9hR5HFzteUgDzZnvTOFN
         PXkVBV0oT9WFHp0cXs0FjOzkpDjsF/8c3ywsHGdHL/Cey90by8DFxNboPlc7J1OUP4Oq
         zGYv4we0JFR9jRgKtIVQMRqZTP+ZSMf9m/iQfoG+zoaF9bRAzohjlL1Seiug5e9fv7ci
         CJY+sAcxXTeEPhRBxsrt3IGrNJadmVZhLRKd4m31sumqgBnBY6bGV14zpW6HryMJCN7Z
         /OOCH93uMMZA/Ls+nEMpvitRfcXHL6QETvHNclFQu49h6ZtfM0ASPthfx7GtxOf217NG
         sdOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ByOyhUtWzhjBtqjAbMyRHnsC1XBkJmGibznOhFVodjQ=;
        b=JZe8VAnb6cVm8af+JeYZgrBtXuq6eCRSzFbIVySB70XxhaPEfG+i/sgsMbsHkoNb8w
         WgZRClFoU24QG16KX5ey/7RD/JumPy6T8B+GHaRw5Tg+y1EBPOvwr5oMWu4McSMhy1Hp
         3aEoZfvX2XZ6J0A0TU8lodocBt3uzFwYPW+ZJLDnQ7dGKrbiJFCW/7lJU7TvjOEKowfx
         iQlcWGKnn7mjsD5NFf57yNyAlSPp4+c2MMKM47DgILPN2uQ0U+GRL6KUKj/sOKINTZFY
         ZvjclyJmNIWZBh2jBHJQLz571YRrYERRqlJvVlHdCofiNcq3RI1gawrbX2jcyLblA5No
         yXBQ==
X-Gm-Message-State: AOAM531cdiDhtB+GFseUsTuRc2pAtvvsH6cuzBenLsKiYtS6o0tMwQxX
        MNtHDPVRrjma/VIPu5/bXo9geg==
X-Google-Smtp-Source: ABdhPJxNdlzdOg6WtlrwB2fVEosRADluWkG9zI52EqYG7JqNy7WXrMJ5xEwAm21vG+/KxZGILvX3pg==
X-Received: by 2002:a05:6638:5ae:: with SMTP id b14mr235823jar.80.1629922893805;
        Wed, 25 Aug 2021 13:21:33 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id b16sm519399ila.1.2021.08.25.13.21.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Aug 2021 13:21:33 -0700 (PDT)
Subject: Re: nbd lifetimes fixes
To:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        Xiubo Li <xiubli@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
References: <20210825163108.50713-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <aff4fedb-046d-0a91-0bf8-838a82a145c2@kernel.dk>
Date:   Wed, 25 Aug 2021 14:21:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210825163108.50713-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/25/21 10:31 AM, Christoph Hellwig wrote:
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

Applied, thanks.

-- 
Jens Axboe

