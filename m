Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F007AC433F5
	for <linux-block@archiver.kernel.org>; Tue, 23 Nov 2021 02:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbhKWCgN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Nov 2021 21:36:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbhKWCgM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Nov 2021 21:36:12 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9973C061574
        for <linux-block@vger.kernel.org>; Mon, 22 Nov 2021 18:33:05 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id z6so17869002pfe.7
        for <linux-block@vger.kernel.org>; Mon, 22 Nov 2021 18:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=GT3BrIp6Sqi+pjtinYwRjvxYhrTrniHs38/R3fS0FLs=;
        b=Qry/75aSljjgrGN1yVlRgSqSvXMfElL+COWC7VlAblzwIZLeKyjp/dOoJFf3rV1FK1
         /Bc5MG6LHLIKSbLAHydtvDQZyAn6ckLxeBcSkIqXfGp1GiZRSbhgqgaqHbIPHSKMtR3V
         I5Mexf4OB+NWb6je/jCapVvahW2Clx/6TnhmPy+BOAWbrfL2+V+Mf3V3tO0rqNj/sAmn
         EAR8gM7py5M/l2692W36rNBBxkbuYj6ZgDYo72J0RRu9mpxONExxKP3aJBbk7dFlrafO
         BbKAbYUBQjp+mB7k53oLYH/PWK9/bdUYhqBu+u6ygy7156iyCfl3qgQjKZUdQgIG9IM9
         79iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=GT3BrIp6Sqi+pjtinYwRjvxYhrTrniHs38/R3fS0FLs=;
        b=weMllCm5tMUwq/EY2LY6RJuT8r3XAwcnr0V45k5IckC2GbRtt9VFlVX5XdFcuw3JAJ
         nQNUsv84BA9vBdjuKSQnH7cwjs5j2nU5Af8CYUeOgaGjOBR7uOLgPEIXPJFpICCwCpUw
         XK3MPTi1wcRj/Isu1+tCdslhlpSaL9Hfd6K7wpyvCHWXelv7wvs6XZfQ3Ef+tYbmB27L
         PXHk2G9EGT1Zs9sSfJXQAnmW4/K3ETkjVWRIjIoIFUHaHTzRCpphPTGAB4r1/d7Vqs3r
         XsHvtDt9Gjfiz1XkprTFLEuQkOlh4JEzSFSV4AFFeg6/VBw/Y06AAvMoUpF2xjKq3CmW
         MKaw==
X-Gm-Message-State: AOAM530pcj4ld0hfjRXwKFRJXpudXlkiGbO21xvjl/mdkomCRpeSxBAU
        jJlVzmsGPpeIypL7+Umhd859HQ==
X-Google-Smtp-Source: ABdhPJyYfknlzLLnTVYa1LcvLYrzEzpqFrseXhzA8m/vzfNmnL6pnL7M4lJNquEBpnELhcYi8cbELw==
X-Received: by 2002:a63:2a97:: with SMTP id q145mr1303696pgq.217.1637634785210;
        Mon, 22 Nov 2021 18:33:05 -0800 (PST)
Received: from [127.0.1.1] ([2620:10d:c090:400::5:684])
        by smtp.gmail.com with ESMTPSA id pi17sm21672987pjb.34.2021.11.22.18.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 18:33:04 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     czhong@redhat.com, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org
In-Reply-To: <20211111020343.316126-1-ming.lei@redhat.com>
References: <20211111020343.316126-1-ming.lei@redhat.com>
Subject: Re: [PATCH V2 1/1] block: avoid to touch unloaded module instance when opening bdev
Message-Id: <163763478264.306783.15055872737165970743.b4-ty@kernel.dk>
Date:   Mon, 22 Nov 2021 19:33:02 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 11 Nov 2021 10:03:43 +0800, Ming Lei wrote:
> disk->fops->owner is grabbed in blkdev_get_no_open() after the disk
> kobject refcount is increased. This way can't make sure that
> disk->fops->owner is still alive since del_gendisk() still can move
> on if the kobject refcount of disk is grabbed by open() and
> disk->fops->open() isn't called yet.
> 
> Fixes the issue by moving try_module_get() into blkdev_get_by_dev()
> with ->open_mutex() held, then we can drain the in-progress open()
> in del_gendisk(). Meantime new open() won't succeed because disk
> becomes not alive.
> 
> [...]

Applied, thanks!

[1/1] block: avoid to touch unloaded module instance when opening bdev
      (no commit info)

Best regards,
-- 
Jens Axboe


