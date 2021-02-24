Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2AE9C433DB
	for <linux-block@archiver.kernel.org>; Wed, 24 Feb 2021 01:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 702CF64E79
	for <linux-block@archiver.kernel.org>; Wed, 24 Feb 2021 01:52:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbhBXBwv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Feb 2021 20:52:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbhBXBwv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Feb 2021 20:52:51 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B54DC061574
        for <linux-block@vger.kernel.org>; Tue, 23 Feb 2021 17:52:05 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id q20so251543pfu.8
        for <linux-block@vger.kernel.org>; Tue, 23 Feb 2021 17:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aFSoc7+uBVEQyUPT/S3u1+Bv3CVAu29rwDIUymtekp8=;
        b=YlJ6eLmO7Q9L9OqrgL9XU24Ir7OQhpSSEv3hItZHhyqVGhbs0VkGILXspFo0IYvu60
         mZZ8ImWX7n8RbRWPgtV2th3fZaFfqB/mHV+yuR4NpoA9faKjwG1ALanixO2yh6pihgzm
         r2W/tzz9KwI+EpE8GUXVz67DSnmN84mL4j/rzGgDgIePBGhLUFKJ/t/4xuXg2EF1LZnX
         ksROsYiEJvR+6jkTwJkl/8/lqD3HH5PvGC4GgzPN0ABL6L45hGhiZ0iULZfgzudkIKGS
         U9i5JqLCbRGgp3U1PgH1CSIS9kRiAQ9jftp2SM/Mzf2GCxGm09VCoIDc64T7hIstn2E9
         AnZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aFSoc7+uBVEQyUPT/S3u1+Bv3CVAu29rwDIUymtekp8=;
        b=jl5jBHwcKechRDYxD8szfgCh5jZYPL8B12xnem1ZbPPeN4jmyTRYHgxIkBLeLi8Lsu
         8+NBRJvIcIQ6If9nOKNvYX+Hvv+Y++M3eMBxvF2qIrCuRpbqt8qD9bpklTDZxUtJ3yl2
         5NfmLvXXJyGpmS40UrG6DoSn7+d4T1JWQgjDxK/6tysvJHiRi7s4HDYf03l9HzZVlVC+
         cNib0IEbcyxcQIiy9sB+aRQvf3GjF7ffS0TEYZ9w7kmAW06bI73ws+2rItiGqofLncdt
         2Hi2rJj7gtua+hrdvyL9iRnDH1LaGlMl25ooJLi0NLqXiTsVox9iDBCp+fRozLrS0m/k
         PajQ==
X-Gm-Message-State: AOAM531ku3NQWQh/FQrEuCVWnaaZ4jPUs9fTWhjBzomZ0C0TWgkMj1QF
        zdXqDBhWGDTSo8T1w7yY4RA=
X-Google-Smtp-Source: ABdhPJz7IUxHwchXrhx3/mOF29YIn2xuxPt9hy1173Phkr7JMxTkqkaXHWF0yb68KuJtWvC0dR6icg==
X-Received: by 2002:a62:d454:0:b029:1ed:a6d6:539d with SMTP id u20-20020a62d4540000b02901eda6d6539dmr4979963pfl.63.1614131525107;
        Tue, 23 Feb 2021 17:52:05 -0800 (PST)
Received: from localhost ([211.108.35.36])
        by smtp.gmail.com with ESMTPSA id g3sm489400pfo.90.2021.02.23.17.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 17:52:04 -0800 (PST)
Date:   Wed, 24 Feb 2021 10:52:02 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        Tom Seewald <tseewald@gmail.com>
Subject: Re: [PATCH] block: reopen the device in blkdev_reread_part
Message-ID: <20210224015202.GA2166@localhost.localdomain>
References: <20210223151822.399791-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210223151822.399791-1-hch@lst.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 21-02-23 16:18:22, Christoph Hellwig wrote:
> Historically the BLKRRPART ioctls called into the now defunct ->revalidate
> method, which caused the sd driver to check if any media is present.
> When the ->revalidate method was removed this revalidation was lost,
> leading to lots of I/O errors when using the eject command.  Fix this by
> reopening the device to rescan the partitions, and thus calling the
> revalidation logic in the sd driver.

It looks like a related issue that I've reported in [1].  And this looks
much better!

Reviewed-by: Minwoo Im <minwoo.im.dev@gmail.com>

[1] https://lore.kernel.org/linux-block/20210126002901.5533-2-minwoo.im.dev@gmail.com/
