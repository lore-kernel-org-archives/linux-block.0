Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B85C433F5
	for <linux-block@archiver.kernel.org>; Mon,  7 Mar 2022 13:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240853AbiCGNnv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Mar 2022 08:43:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234617AbiCGNnu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Mar 2022 08:43:50 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B823191B
        for <linux-block@vger.kernel.org>; Mon,  7 Mar 2022 05:42:56 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id z4so13574068pgh.12
        for <linux-block@vger.kernel.org>; Mon, 07 Mar 2022 05:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=dO6x0urderFyV2KEmYHOZGi+h8qzVo3thAZZhX59WVI=;
        b=5ivy39D4HyOHzg3oXUga22rP3KTFbBIawIRKB8iyjtZt6Z58pqc4Vql+X/c079mPEJ
         f46YzW+GeFbCYLaUqhF8sKcWOG7kD0I6IAOSSvNUN25urxnis6OsYxY004mMcZ7s8Ot6
         Cv40ygftIN8yDAI7xlnfg/uCigTwKBqyuwZcEuTsz996r2SqMANbP8/hilAuT89IyDnb
         WDuKNZ/1/Ni+EBzc2RTEpBTQosuTWCnL43mmiICwJHjHdRofOxPPziZaIADND/ymXIH7
         tzcUUP6N+Xo2Ct9hWPxVf5lBpRv8YJIceX/H68gQoUM3KU1za/aPz5aLYjJdmyuMB5mY
         FICA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=dO6x0urderFyV2KEmYHOZGi+h8qzVo3thAZZhX59WVI=;
        b=iZxWIrEJciHCqsZSwk4/nnczjKIYcWUs6/4LsvNBlEOATcDSkZOqSICJ44CKYYII/t
         3Hiq7G8tsXYzrSqxb5hvsnRCNdnLNDvpqmk3vitsn1RlbUH5A2TChE3y5Z+L/A5GYJKI
         ZGNnIoknFDhJVTWTg8/E8UxhItYSBuCGLZjQ1BFqY4bKBYCnX8D3qbKX+fGAjIOd4fvn
         G38FhQtsLi5PIH6PmKtTyYkMNdXBr5II2Jg6fRamIBN+LB5sR711rjCMZwZLA1nYQmkM
         4VpZDluDcy0BnLHMKquBjmS/U8WA5fZuQeWkVaOrJ4qdyFdHrfdP8ZEhHamxH/OOGgoO
         qsyw==
X-Gm-Message-State: AOAM532M6rIVEuq2teL9JVkj4tIMMp1epSuOnQbUmPFxN6aIFPWPnLuR
        vBDtMLCMfruLoNjtxE1aa4Eo1w==
X-Google-Smtp-Source: ABdhPJw5/FtlFVkWiR7cSvl2rHTtKJ6vmy5dszUzno3/VlrXoUuSSW3LtUf6Iv+dMHFIDtyxNHJnyA==
X-Received: by 2002:a63:6908:0:b0:372:d919:82ed with SMTP id e8-20020a636908000000b00372d91982edmr10020149pgc.104.1646660575327;
        Mon, 07 Mar 2022 05:42:55 -0800 (PST)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 78-20020a621451000000b004f6e8a033b5sm6745253pfu.142.2022.03.07.05.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 05:42:54 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-raid@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>, Song Liu <song@kernel.org>
In-Reply-To: <20220304180105.409765-1-hch@lst.de>
References: <20220304180105.409765-1-hch@lst.de>
Subject: Re: remove bio_devname
Message-Id: <164666057398.15541.7415780807920631127.b4-ty@kernel.dk>
Date:   Mon, 07 Mar 2022 06:42:53 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 4 Mar 2022 19:00:55 +0100, Christoph Hellwig wrote:
> this series removes the bio_devname helper and just switches all users
> to use the %pg format string directly.
> 
> Diffstat
>  block/bio.c               |    6 ------
>  block/blk-core.c          |   25 +++++++------------------
>  drivers/block/pktcdvd.c   |    9 +--------
>  drivers/md/dm-crypt.c     |   10 ++++------
>  drivers/md/dm-integrity.c |    5 ++---
>  drivers/md/md-multipath.c |    9 ++++-----
>  drivers/md/raid1.c        |    5 ++---
>  drivers/md/raid5-ppl.c    |   13 ++++---------
>  fs/ext4/page-io.c         |    5 ++---
>  include/linux/bio.h       |    2 --
>  10 files changed, 26 insertions(+), 63 deletions(-)
> 
> [...]

Applied, thanks!

[01/10] block: fix and cleanup bio_check_ro
        commit: 57e95e4670d1126c103305bcf34a9442f49f6d6a
[02/10] block: remove handle_bad_sector
        commit: ad740780bbc2fe37856f944dbbaff07aac9db9e3
[03/10] pktcdvd: remove a pointless debug check in pkt_submit_bio
        commit: 47c426d5241795cfcd9be748c44d1b2e2987ce70
[04/10] dm-crypt: stop using bio_devname
        commit: 66671719650085f92fd460d2a356c33f9198dd35
[05/10] dm-integrity: stop using bio_devname
        commit: 0a806cfde82fcd1fb856864e33d17c68d1b51dee
[06/10] md-multipath: stop using bio_devname
        commit: ee1925bd834418218c782c94e889f826d40b14d5
[07/10] raid1: stop using bio_devname
        commit: ac483eb375fa4a815a515945a5456086c197430e
[08/10] raid5-ppl: stop using bio_devname
        commit: c7dec4623c9cde20dad8de319d177ed6aa382aaa
[09/10] ext4: stop using bio_devname
        commit: 734294e47a2ec48fd25dcf2d96cdf2c6c6740c00
[10/10] block: remove bio_devname
        commit: 97939610b893de068c82c347d06319cd231a4602

Best regards,
-- 
Jens Axboe


