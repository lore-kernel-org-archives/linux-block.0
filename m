Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76AEAC433EF
	for <linux-block@archiver.kernel.org>; Fri,  3 Dec 2021 13:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236989AbhLCOBM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Dec 2021 09:01:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357669AbhLCOBM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Dec 2021 09:01:12 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CB9C06173E
        for <linux-block@vger.kernel.org>; Fri,  3 Dec 2021 05:57:48 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id o14so2165658plg.5
        for <linux-block@vger.kernel.org>; Fri, 03 Dec 2021 05:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UoZWC68WXb6mazC3pqenH9WxgAly43t6xWEqxWg7z3o=;
        b=d9MZjXXoH5BjkL7ioUEAHPO5yEsxSDlxb0l3O/UxBt4KxXpde6bZw0V6kLGKWNbHyk
         nqIM5MUJTZpe5DMtQ2ZKi4lTf/0VF6QhdLf6ZvsVCGThy2XDXsYpA8l1lyTAtq93Pval
         gdoOYZtyVg9fSHdltCT3B4qsZtpvPEnVZidRDhIAgdeivVW7o/BAbngp6IpoT2y40NJB
         NihUKdEdb3J2azCOrjWt2S0T6BYmPq0sDQZzgY/8McWixQiuhknYp1Ci2pldmFrk9RWj
         Yv2D7R5sUQIka3uUn8VBpxDKQwQ+1tlmIjwsitjQCLs/ZJtu/NqfL8tdK+GlYviVSB/H
         od+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UoZWC68WXb6mazC3pqenH9WxgAly43t6xWEqxWg7z3o=;
        b=rI1qgFRi2/pyKuR88+cmrlXaIFjRiY41reeFOKHE2enhtq/LjJ3wOrGh8tOt+jechy
         JI7llds6G383BdCiJk4kr4FMgjOTQd6Pp4XugrGCVAshheVw4bnthnnEoXJW31I+CCT1
         lyc8yd9z1+79L1YanbZsI5Z6YQGekXXn5/92anOQI9brlBX5oFjvnJ5KpSAnomj07vu/
         cL1LX7QqUD6Rk0zKAZZAR1uE4uF/eg6tBQndSjdf7MMvUiVWXPK+JgMS1GO4Q2QIQh2O
         psivGDQlQJEKJT0klG6wf3GakM53/MZLiH28gwJBDuAkbkfAJQGIJ908+OSZwYlaNxq0
         79PA==
X-Gm-Message-State: AOAM530Q/Y2owXLnYL0BsD1KbHKo6jR3dZIzRdUGbOP8DVjYffFQ4g7+
        5AGxUN3dh39J4y0Ljw7zMh0q9U92e+sUBsc3
X-Google-Smtp-Source: ABdhPJxvhQAd2SDcP6DQE4v2muj980pYIGDgF8Gxhm741DPK2sEKljn7peUo3mUxZjB+0Y3E/HSiUg==
X-Received: by 2002:a17:90b:11c1:: with SMTP id gv1mr14163725pjb.208.1638539867493;
        Fri, 03 Dec 2021 05:57:47 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id p124sm3407409pfg.110.2021.12.03.05.57.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Dec 2021 05:57:47 -0800 (PST)
Subject: Re: [PATCH 0/4] blk-mq: improve dispatch lock & quiesce
 implementation
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org
References: <20211203131534.3668411-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ba10d6b2-3274-0dec-c726-da3fe99b9e68@kernel.dk>
Date:   Fri, 3 Dec 2021 06:57:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211203131534.3668411-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/3/21 6:15 AM, Ming Lei wrote:
> Hello,
> 
> The 1st patch replaces hctx_lock/hctx_unlock with
> blk_mq_run_dispatch_ops(), so that the fast dispatch code path gets
> optimized a bit.
> 
> The 2nd patch moves srcu from hctx into request queue.
> 
> The last two patches call blk_mq_run_dispatch_ops once in case of
> issuing directly from list.

Looks good, and makes it easier to do the list issue on top of as well.
I'll take a closer look, thanks.

-- 
Jens Axboe

