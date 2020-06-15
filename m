Return-Path: <SRS0=pdd5=74=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6895C433DF
	for <linux-block@archiver.kernel.org>; Mon, 15 Jun 2020 23:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1E9D2068E
	for <linux-block@archiver.kernel.org>; Mon, 15 Jun 2020 23:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="N6hAKR9M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbgFOXRI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Jun 2020 19:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbgFOXRH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Jun 2020 19:17:07 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2056EC061A0E
        for <linux-block@vger.kernel.org>; Mon, 15 Jun 2020 16:17:07 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id b201so8565983pfb.0
        for <linux-block@vger.kernel.org>; Mon, 15 Jun 2020 16:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UQfJR4e4lJk8Aovco38H0tfVhq45T+0NvAYnlNqk/s4=;
        b=N6hAKR9McpUQ5vfsZRr/aVkzcTd8qe0WAVBLwE0bzJ1UnlDVCfJlSxNH2qPlctQ+rO
         PpJo3FuHaHAAvbVQ+2TVNe21cHwiQlWR59zVrafBDh4XqB6jSNtJbhGHTAfExIod2j/C
         11dIaFr4vJ4aFyo0BNIK0wGvZlnAPSTZv6s3iiz4ntAp79wUuXix18aWTRk3XVUCax6H
         OgH/SHqOyfhdOq2/8X+BxBf0lYeTRfVpNaoAdmP0Nqi1xlHAE10DhY4kjWJdeFQNyeUe
         wkdK4JE6ggsU5NsamYGOIlRElZbdMvyR7Q8zjWU2b99Bd1CwzZOHG0YOuGmXC3DHUwrr
         CWLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UQfJR4e4lJk8Aovco38H0tfVhq45T+0NvAYnlNqk/s4=;
        b=YxJYk0EJ9llEHnet2c6Ec+g2tIWaYWbv3M6gvdfqTMzXiVxNTlZ8RFIeIms61qttMO
         LX5iq290+FSv7PqNnytaP/anseu9YeizxEPQFGA3QmVOMOJoW+EOdDdnu7REa+y/IYyu
         QJCSpgQ/Wg1ar2zkGK1olk2Lwk7q/y7DB7jAQChaueJKbI4Mgfu4wxxjSxbYXPS0k499
         cGgPRciIS7FsWQPYwtYueYyi8FUBFZbamlU0q+4qCRIM76pkgkmWBC4VHAOzlIyyEPvH
         KXJq/8njMxoAzFEKqjV39Dqr+VQZD8tKrjWbjn2ePt1ISaBm+vLR4dFTPaqhyOoxUgwd
         84qA==
X-Gm-Message-State: AOAM5318yzcFn3fmpJZGKh5SESdQIwH6YbpDRGS7vLuoYAfQb48KBDtd
        QsDiMGXerdY5Cmt1WyJu/ksZy8SUAMM=
X-Google-Smtp-Source: ABdhPJy2kEY+otjQK72aMr0KIzS3xsAXba0O5Iflg/eEcfep1XUkSaB1XAzv6Rv6QeOFFLZeWWr+Nw==
X-Received: by 2002:aa7:9d01:: with SMTP id k1mr14873pfp.6.1592263026478;
        Mon, 15 Jun 2020 16:17:06 -0700 (PDT)
Received: from vader ([2620:10d:c090:400::5:4fd2])
        by smtp.gmail.com with ESMTPSA id u17sm13063190pgo.90.2020.06.15.16.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 16:17:05 -0700 (PDT)
Date:   Mon, 15 Jun 2020 16:17:04 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH blktests] zbd/007: Add --force option to blkzone reset
Message-ID: <20200615231704.GB2642892@vader>
References: <20200608024458.881519-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200608024458.881519-1-shinichiro.kawasaki@wdc.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 08, 2020 at 11:44:58AM +0900, Shin'ichiro Kawasaki wrote:
> The test case zbd/007 utilizes blkzone command from util-linux project
> to reset zones of test target devices. Recently, blkzone was modified to
> report EBUSY error when it was called to change zone status of devices
> used by the system. This avoids unintended zone status change by mistake
> and good for most of use cases.
> 
> However this change triggered failure of the test case zbd/007 with the
> EBUSY error. The test case executes blkzone to reset zones of block devices
> which the system maps to container devices such as dm-linear.
> 
> To avoid this failure, modify zbd/007 to check if blkzone supports --force
> option. And if it is supported, add it to blkzone command line. This option
> was introduced to blkzone to allow zone status change of devices even when
> the system use them.
> 
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
>  tests/zbd/007 | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Thanks, applied.
