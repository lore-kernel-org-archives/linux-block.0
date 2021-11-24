Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B1AC433F5
	for <linux-block@archiver.kernel.org>; Wed, 24 Nov 2021 15:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241152AbhKXPgY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Nov 2021 10:36:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233084AbhKXPgX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Nov 2021 10:36:23 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4473C061574
        for <linux-block@vger.kernel.org>; Wed, 24 Nov 2021 07:33:13 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id m5so2820479ilh.11
        for <linux-block@vger.kernel.org>; Wed, 24 Nov 2021 07:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=BBtCmD2MQFTaWFeeEHSOlHt6RS4bbLfi7lLls7v1YUk=;
        b=8PZ1Or4eqfQ69TBJd3XFJhYUcRQRjM0Ls+0EsLk8TFO4tojlLZ5tlYZSyNt2vk4TBk
         pm5XgXarg+MMUxZLLSFRJywqKj+GBn+Vb1IfVd+jTl6CJScc9IR8cX9Xw+wx4mKmuTqb
         O8YDAxsS+l8DR0dH1cDUXfBbysne/6A1IA6kXUBjg4oHzQmtglp93gG+9o/paBJemXM6
         9uFdRhnCYOJU6FpLj55ZkE8Fk9a1BPXMzprTcR3M0s0h3qUK2ztARhhFzeI+6Mn23RXJ
         QU0CgzPQd84u9AUYpH4xsrTHJ6l4ds6JsaMlPiQXhvbZQKdJUAtjTwxR87A0c3SfW2Z7
         2zdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=BBtCmD2MQFTaWFeeEHSOlHt6RS4bbLfi7lLls7v1YUk=;
        b=vRGAvoktgH4b02LlnXoCq9qAh2AovbSyJgZ4hjlIOH9fkzfHPp4S54k5mizBRkJYYA
         rFDxayXdf2weRF+3cbGzaAhmvONgf9dQRQDPeKo0UpzkNjY92S8EMcV0DGKTfQ/45gKK
         Aj/emMK4i1/S2UhBFWlAitYibi9DhrIip6sSQTOi7KQCzdIMDaP+X1bRT9Udxk5Sg0BB
         r1baUJebWeEBt5GW2iWxY4OK/uA7LrFs3xl+cPGX905A7gAv5CMK1GOjFIOS7m+1Sfm3
         qt8tNrbMRzEL+Deqs6XyPIW4f9wfLvuTBbH387flnJbTOag2tKQX//MWtngMs9Ff83xD
         zgzw==
X-Gm-Message-State: AOAM530nz+zycWynjTmIAUlSTC8tSVyepbrL4wFbhqwxbhbpBL7BWNHw
        5capNBjCbGy2kaycsX1qPYd6X3V61MCs44Vm
X-Google-Smtp-Source: ABdhPJw6I4uIghnAFZccDkM+PqqJkjpgiU+WkmXVDk5e3fhydD2GNozl16hmTh3GV+ssK229pP5sEw==
X-Received: by 2002:a05:6e02:b45:: with SMTP id f5mr14683876ilu.118.1637767993096;
        Wed, 24 Nov 2021 07:33:13 -0800 (PST)
Received: from [127.0.1.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id w12sm90497ilu.45.2021.11.24.07.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 07:33:12 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
In-Reply-To: <20211123185312.1432157-1-hch@lst.de>
References: <20211123185312.1432157-1-hch@lst.de>
Subject: Re: decruft blk.h
Message-Id: <163776799226.460672.492936987391984746.b4-ty@kernel.dk>
Date:   Wed, 24 Nov 2021 08:33:12 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 23 Nov 2021 19:53:04 +0100, Christoph Hellwig wrote:
> this series cleans up blk.h by moving various bits that are not needed
> out of it.
> 
> Diffstat:
>  blk-cgroup.c     |    1 +
>  blk-core.c       |    2 ++
>  blk-flush.c      |    7 +++++++
>  blk-ioc.c        |    1 +
>  blk-merge.c      |    2 ++
>  blk-mq-debugfs.c |    1 +
>  blk-mq.c         |    1 +
>  blk-sysfs.c      |    3 ++-
>  blk-throttle.c   |    1 +
>  blk.h            |   22 +---------------------
>  elevator.c       |   10 +++++++---
>  genhd.c          |    2 ++
>  12 files changed, 28 insertions(+), 25 deletions(-)
> 
> [...]

Applied, thanks!

[1/8] block: move blk_get_flush_queue to blk-flush.c
      commit: b717f549c852e72ddf7c1140702da9e27ffaca7c
[2/8] block: remove elevator_exit
      commit: b4ef8cf4ee9cdf8d3f77f265028ddfcda7da47c0
[3/8] block: remove the e argument to elevator_exit
      commit: 9bd06db7f49c0c60b0368a21c8d25cd3f356c1b6
[4/8] block: don't include blk-mq-sched.h in blk.h
      commit: 10e69ae57a1d4a026de15a9c9058c79ecd47e287
[5/8] block: don't include blk-mq.h in blk.h
      commit: c6d21307452ddda76dd132d0a6aa99e8ebf0a9bb
[6/8] block: don't include <linux/blk-mq.h> in blk.h
      commit: 8ac269b7ebd5329c287fcd644f89508abf605d1f
[7/8] block: don't include <linux/idr.h> in blk.h
      commit: 65db5bdc941eab6e3d2adee483d1cb0ec70a39ad
[8/8] block: don't include <linux/part_stat.h> in blk.h
      commit: b1d1d48b8b3a90b4eb28fe3222ca57c6266e211c

Best regards,
-- 
Jens Axboe


