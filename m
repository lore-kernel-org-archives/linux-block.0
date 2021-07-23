Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2BCBC4338F
	for <linux-block@archiver.kernel.org>; Fri, 23 Jul 2021 16:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8F1C60E8B
	for <linux-block@archiver.kernel.org>; Fri, 23 Jul 2021 16:19:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbhGWPjJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Jul 2021 11:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhGWPjJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Jul 2021 11:39:09 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3E6C061575
        for <linux-block@vger.kernel.org>; Fri, 23 Jul 2021 09:19:41 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id c3so2084205ilh.3
        for <linux-block@vger.kernel.org>; Fri, 23 Jul 2021 09:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=30vpAefHG/JNasZeyk2sXioBuZ/6M9niR2X4wSDQYNE=;
        b=v3q5e6FLkZKQHexSTV+74IjfyqJ8wM48H06jLke8tDLufoYX7LDWftZrzsn+VzNtFa
         qJajGO3FTJ5SCxuAVyENmmt3mheRXlEN4shxlxI8KOhfhd3FypnzMo3JoME4CwrJMJae
         m5+qUN0gzVWdVTL8X7Lqutn7lRM+X0pE/Co+S9ZagqF0Qh4X1YMCt1G8rND0QUs2u78r
         3jiElZgFJEfolLXEFTYdFavmwROuOj+8Q68K+XdU3jdfSBjCZxYS995cFKZ2XpP2iILr
         mfabypVvOoqtOYZnCVPbXkA2hSvzRMnmhh2VbS8REIW11ij8PPM033WnQxczP/lp110N
         p2eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=30vpAefHG/JNasZeyk2sXioBuZ/6M9niR2X4wSDQYNE=;
        b=Cbjc5rJnSzvL3M30aUD6SN0ay+GtZ0jJ3E+N51xEpVByCFGddaVCfA8x74Hih+6pHh
         tVeOk4x38CAeUWICGp1sbcMwAW0IWu/XPG9S3oiZT0HbyK8OK8EETQWV6X9mJGOW5o3x
         t1SiRokeW+naPm/FtfVibGHjEIM3KwpEgcrxhMrg+ZWM1mMjW5965Tvzi8StHkcMqNHe
         YGS202yS49KVytHn30rjLgyuCMP3FKC96LcftyN8vDjMBiNtoKhzgPAqPkaTy1NhggH4
         GuQ33+EtgU3ywQcKQxI4NHhZ47O7AAQm/XA1fn6OgTvF5EJtXmSvW1kb/Ra/3ATZFobQ
         /Y0g==
X-Gm-Message-State: AOAM530yjwHhHLCwZJqW24uZoHTd59jmehJftBb5by2aNYEmFuQaqF8f
        9ndTg6kvs//NgKPDwlii7laZEJApuWc7gmSg
X-Google-Smtp-Source: ABdhPJzrBB+b7tsiR2ocGDbdlJWR2cyhd5JiidAgoPISOUuZFBLkNdDCDeK1H4Cjg863/9ZuRrBBVg==
X-Received: by 2002:a92:cac5:: with SMTP id m5mr4028044ilq.112.1627057180649;
        Fri, 23 Jul 2021 09:19:40 -0700 (PDT)
Received: from [192.168.1.10] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id j4sm17715572iom.28.2021.07.23.09.19.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jul 2021 09:19:40 -0700 (PDT)
Subject: Re: [PATCH v3] loop: reintroduce global lock for safe
 loop_validate_file() traversal
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Christoph Hellwig <hch@lst.de>
Cc:     Petr Vorel <pvorel@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        linux-block@vger.kernel.org
References: <20210702153036.8089-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <288edd89-a33f-2561-cee9-613704c3da20@i-love.sakura.ne.jp>
 <20210706054622.GE17027@lst.de>
 <6049597b-693e-e3df-d4f0-f2cb43381b84@i-love.sakura.ne.jp>
 <521eb103-db46-3f34-e878-0cdd585ee8bd@i-love.sakura.ne.jp>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8031a79f-5f32-3306-821d-6c783bb73413@kernel.dk>
Date:   Fri, 23 Jul 2021 10:19:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <521eb103-db46-3f34-e878-0cdd585ee8bd@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/6/21 8:40 AM, Tetsuo Handa wrote:
> Commit 6cc8e7430801fa23 ("loop: scale loop device by introducing per
> device lock") re-opened a race window for NULL pointer dereference at
> loop_validate_file() where commit 310ca162d779efee ("block/loop: Use
> global lock for ioctl() operation.") has closed.
> 
> Although we need to guarantee that other loop devices will not change
> during traversal, we can't take remote "struct loop_device"->lo_mutex
> inside loop_validate_file() in order to avoid AB-BA deadlock. Therefore,
> introduce a global lock dedicated for loop_validate_file() which is
> conditionally taken before local "struct loop_device"->lo_mutex is taken.

I'll queue this up for next weeks merging. Christoph, are you happy with
it at this point? Can't say it's a thing of beauty, but the problem does
seem real.

-- 
Jens Axboe

