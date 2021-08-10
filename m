Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90215C4338F
	for <linux-block@archiver.kernel.org>; Tue, 10 Aug 2021 13:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FB4360F38
	for <linux-block@archiver.kernel.org>; Tue, 10 Aug 2021 13:12:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238396AbhHJNM4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Aug 2021 09:12:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43697 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236764AbhHJNMz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Aug 2021 09:12:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628601153;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R4vBz2mMGvhkdtkFiw2NditsBGmKPW13//Cafaw3E4Y=;
        b=epmY/3HmsPWoyIHAzJPR+mu1pis0KiOiBuUHsyGrMcCq45isweK3o1w1/vNbW2jCMTH4Bn
        6ImHS9N9JyQil796RIlC3YezL0tYpDlzjTyI4bvPfkCS6sbqLwG8wLS3xfI5rBnHSTNWCH
        TGOB/j1QX4jPiB6eO4swq+WciD9CYa8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-595-SYWWofVrPjSKL4M1_CH16A-1; Tue, 10 Aug 2021 09:12:32 -0400
X-MC-Unique: SYWWofVrPjSKL4M1_CH16A-1
Received: by mail-wm1-f72.google.com with SMTP id u14-20020a7bcb0e0000b0290248831d46e4so996729wmj.6
        for <linux-block@vger.kernel.org>; Tue, 10 Aug 2021 06:12:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R4vBz2mMGvhkdtkFiw2NditsBGmKPW13//Cafaw3E4Y=;
        b=VcoklYV+x9DGoQqvDfFT8ng6XpahjaKPwaoaEyPumfr1eKSfRhXJT9tMLtQzbVCBb0
         xjXEDPsJb2zP8IJXKcd6kbAIs2BxtdbiDEiY5rwwMi7BdqkQoBjD2btj8AefLytQ+57H
         vRDA8ZWdiZu9kKQUeV0gd0mKoYtVe+ZvH2ZO+IEhNT8CuBVsjzqM7M32FCjqcLDbEZA2
         4/f0IaloLxUglTyfWlCfyz68q6qXxV3JopM3Eu0e7XP2Htv4rePP04u0p0tc4F8RIesb
         rvnG+wBz1UG6ez7QkEjdC1Wr39fn3ORM8Q8mwBhiGacqRjGpftJ03P924LgiFzB7fzQG
         wzlQ==
X-Gm-Message-State: AOAM533gem4rbNn5O3dYLbD1b1rDdrP9oD6L3gowOPcQxIKKa5BjsPeo
        tg/jlfjXKlK1DkFoHwB033zQL9aBYtqxyPOXIohBiBHa46072HiHx4xi8FIEYP7cPI7ULt1bG6v
        XzE+BmxUNTxkxmNjhwPua7YQ=
X-Received: by 2002:a05:600c:19cd:: with SMTP id u13mr716222wmq.143.1628601150974;
        Tue, 10 Aug 2021 06:12:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw8QSATE7swL8AuNZTG+EQ7iM068PEVg5iYNL8Kim1eedQZqEzh50p3XA1cUFN9ZRJ6UananQ==
X-Received: by 2002:a05:600c:19cd:: with SMTP id u13mr716192wmq.143.1628601150735;
        Tue, 10 Aug 2021 06:12:30 -0700 (PDT)
Received: from alatyr-rpi.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id d4sm8830733wrc.34.2021.08.10.06.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 06:12:30 -0700 (PDT)
Date:   Tue, 10 Aug 2021 15:12:27 +0200
From:   Peter Rajnoha <prajnoha@redhat.com>
To:     Alasdair G Kergon <agk@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Mike Snitzer <snitzer@redhat.com>, linux-block@vger.kernel.org,
        dm-devel@redhat.com
Subject: Re: [dm-devel] [PATCH 7/8] dm: delay registering the gendisk
Message-ID: <20210810131227.ofgfi62agal64nqd@alatyr-rpi.brq.redhat.com>
References: <20210804094147.459763-8-hch@lst.de>
 <20210809233143.GA101480@agk-cloud1.hosts.prod.upshift.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809233143.GA101480@agk-cloud1.hosts.prod.upshift.rdu2.redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue 10 Aug 2021 00:31, Alasdair G Kergon wrote:
> On Wed, Aug 04, 2021 at 11:41:46AM +0200, Christoph Hellwig wrote:
> > device mapper is currently the only outlier that tries to call
> > register_disk after add_disk, leading to fairly inconsistent state
> > of these block layer data structures.  
> 
> > Note that this introduces a user visible change: the dm kobject is
> > now only visible after the initial table has been loaded.
> 
> Indeed.  We should try to document the userspace implications of this
> change in a bit more detail.  While lvm2 and any other tools that
> followed our recommendations about how to use dm should be OK, there's
> always the chance that some other less robustly-written code will need
> to make adjustments.
> 
> Currently to make a dm device, 3 ioctls are called in sequence:
> 
> 1. DM_DEV_CREATE  - triggers 'add' uevents
> 2. DM_TABLE_LOAD
> 3. DM_SUSPEND     - triggers 'change' uevent
> 
> After this patch we have:
> 
> 1. DM_DEV_CREATE  
> 2. DM_TABLE_LOAD  - triggers 'add' uevents
> 3. DM_SUSPEND     - triggers 'change' uevent
> 
> The equivalent dmsetup commands for a simple test device are
> 0. udevadm monitor --kernel --env &   # View the uevents as they happen
> 1. dmsetup create dev1 --notable
> 2. dmsetup load --table "0 1 error" dev1
> 3. dmsetup resume dev1
> 
>   => Anyone with a udev rule that relies on 'add' needs to check if they
>      need to change their code.
> 
> The udev rules that lvm2 uses to synchronise what it is doing rely
> only on the 'change' event - which is not moving.  The 'add' event
> gets ignored.  
> 
> When loading tables, our tools also always refer to devices using
> the 'major:minor' format, which isn't affected, rather than using
> pathnames in /dev which might not exist now after this change if a table
> hasn't been loaded into a referenced device yet.  Previously this was
> permissible but we always recommended against it to avoid a pointless
> pathname lookup that's subject to races and delays.
> 
> So again, any tools that followed our recommendations ought to be
> unaffected.
> 
> Here's an example of poor code that previously worked but will fail now:
>   dmsetup create dev1 --notable
>   dmsetup create dev2 --notable
>   dmsetup ls  <-- get the minor number of dev1 (say it's 1 corresponding
> to dm-1)
>   dmsetup load dev2 --table '0 1 linear /dev/dm-1 0'
>   ...
> 
> Peter - have I missed anything?

It looks this is the only area affected, but as you say, this should be
well documented (including comments in our own udev rules) so there are
no false assumptions made by other non-lvm/non-libdm users.

(I'm not counting the very corner use case of
'dmsetup --addnodeoncreate --verifyudev' which now ends up with a dev node
in /dev that logically returns -ENODEV when accessed instead of zero-sized
device as it was before.)

-- 
Peter

