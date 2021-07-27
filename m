Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C06C432BE
	for <linux-block@archiver.kernel.org>; Tue, 27 Jul 2021 15:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1705E61B71
	for <linux-block@archiver.kernel.org>; Tue, 27 Jul 2021 15:58:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237099AbhG0P6y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Jul 2021 11:58:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39760 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229537AbhG0P6u (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Jul 2021 11:58:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627401529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=atmE5scVfb2O9aWWLb/VOIw6P8MjSrhPGuB4Ep/3fiI=;
        b=Hb5dYulTRjPVb3QmHy0BCO6YibIK/wcKeJ6388ejmf36ly1IVBDPkI4xMRK4em71HSXWpO
        6RkgUhaypu/TKhBto6w9U7nCL7OboODJGZQx/DDxDS8UC4x6LGpD+ifDm1frHxHduS2bzl
        8hYBurZ4dOyz67yJT1TNJbf1/gUyElI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-MtsjfMwzPXmIqD5Ixr2a4Q-1; Tue, 27 Jul 2021 11:58:48 -0400
X-MC-Unique: MtsjfMwzPXmIqD5Ixr2a4Q-1
Received: by mail-qk1-f200.google.com with SMTP id u22-20020ae9c0160000b02903b488f9d348so11867051qkk.20
        for <linux-block@vger.kernel.org>; Tue, 27 Jul 2021 08:58:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=atmE5scVfb2O9aWWLb/VOIw6P8MjSrhPGuB4Ep/3fiI=;
        b=ARel1QVeLtKV+NS11HZFrC6+86Z/f4R3OaPMDDmTwj2lXxyUnFsEBcomYoWl0DO+ui
         NuxT415th+YxnlwSFoJIuoPr/KVsQ+OQqMVQOMBzUvcTO+EWrxypmk/FNRzbUOGOv2hg
         txjfaghG6k8ZDpbQ9OmlMGIG80V+j9lVHWYMQ/IHeqpO/bkEdQGmGZb8BO67JNxIoJfp
         g2+RQm0kpY40EJHevk2WVpRGvF1CflgL2Dueg8Tq7qllLcHWMtq7PgmAjmAjzIiqy23M
         w8ecEpo8AzmKAcW2S3IeGCgPjEVjm7gczVPOelO4I/bbL7VZIy0wGnWpEE3XpYtxWB6/
         Ct8Q==
X-Gm-Message-State: AOAM533Lv25CPlWCAUokrmLfhun3FCZKpQIpax8clcaOpfcv8Wr3yGDp
        h1q6KpU144fnPQp2ioCQgfIzgwa3ICeEBWq1NfK9ooxWxTQI3YMp8f3J1VbMII40zJ+Eq2xPDXM
        DzqUa8vHRMWs7pBp+DuoqwA==
X-Received: by 2002:a05:620a:95c:: with SMTP id w28mr23175783qkw.52.1627401527837;
        Tue, 27 Jul 2021 08:58:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyOE+4SV5d1eT/qjDo6Wzbvz0u0RtU+A3LUlxu4pNXJTS+HBQn/7czeCezGlN5kKwEkzDmedg==
X-Received: by 2002:a05:620a:95c:: with SMTP id w28mr23175776qkw.52.1627401527661;
        Tue, 27 Jul 2021 08:58:47 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id x28sm1659779qtm.71.2021.07.27.08.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 08:58:47 -0700 (PDT)
Date:   Tue, 27 Jul 2021 11:58:46 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: Re: use regular gendisk registration in device mapper
Message-ID: <YQAtNkd8T1w/cSLc@redhat.com>
References: <20210725055458.29008-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210725055458.29008-1-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Jul 25 2021 at  1:54P -0400,
Christoph Hellwig <hch@lst.de> wrote:

> Hi all,
> 
> The device mapper code currently has a somewhat odd gendisk registration
> scheme where it calls add_disk early, but uses a special flag to skip the
> "queue registration", which is a major part of add_disk.  This series
> improves the block layer holder tracking to work on an entirely
> unregistered disk and thus allows device mapper to use the normal scheme
> of calling add_disk when it is ready to accept I/O.
> 
> Note that this leads to a user visible change - the sysfs attributes on
> the disk and the dm directory hanging off it are not only visible once
> the initial table is loaded.

s/not/now/

> This did not make a different to my testing
> using dmsetup and the lvm2 tools.

I'll try these changes running through the lvm2 testsuite.

