Return-Path: <SRS0=aCNT=DS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4DACC433E7
	for <linux-block@archiver.kernel.org>; Sun, 11 Oct 2020 15:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A304E2222E
	for <linux-block@archiver.kernel.org>; Sun, 11 Oct 2020 15:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gtkcVwfX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388177AbgJKPcA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 11 Oct 2020 11:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388153AbgJKPcA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 11 Oct 2020 11:32:00 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF63C0613CE;
        Sun, 11 Oct 2020 08:32:00 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id q21so376125pgi.13;
        Sun, 11 Oct 2020 08:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tV+5GpsNqToqnCOxQczbib4Ix1QZL4pyiVZswc1zNmY=;
        b=gtkcVwfXSYZAO6NPh9g9WmwCFwgM/oFH7KCiujvPqgwkcJ5ayWdryzmnNsY6byiyeL
         cxC+drvrZrtqxB8QtIGcu7kKO7ePOwvYEwW2iAwngCidlo40i6eczOoJBIQMctKd6YxM
         eUaMz96YX4iC8ErPHG2DmONIdoc6BeSaPsVkF8M9btBS/Jw7ppPKp5331yKAjrCXuwTx
         HdvQNYdNU+6oaFiGHldO6DEeWBibxTj0JQDObwxzUl+UUwoF2d5ctLnPQHMRSCm+X+S3
         ov8fUkz7njagUUthRxwYYb9YkQJ+r93/mEdiZwGsA5d4POJZp+v8Ok7EjRwqA2/HurZ7
         WwGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tV+5GpsNqToqnCOxQczbib4Ix1QZL4pyiVZswc1zNmY=;
        b=ZhIbNlVEgmcb5wyqvWj7S+tdKS2GPPVhMTNgeRbHYJc+OGD6DpitPD6Oj3TAVu+x8h
         Qn7usJKVI47LuL2zxpGatYRD2PhRE1muMJYcfG3AXDoujcbhsdQ5LftvvUwaYMBA8Nek
         wA/T9L68c4d2qLJYoa55o5SewxYo1fxavUZ611EOfiSzFjb5oDPClW9wof4hqmYRamiz
         30SMdNnK7EsN4sicRq4MKYAH8jSumpna/dBOGT/z9LHmzbFgTBS5ulM6kQMCfpZu+sak
         CDJ1wwi6sc17OWMyNYE0wH91pkW2INdzkR04N4c79Yqmz48Vds2ymJDP9Hxm1BNIap7g
         LPGw==
X-Gm-Message-State: AOAM531UJlJ6sEWvt6tuBsK7qLuLTRMc+haoJXhx/5euxIDXAs/1v/Wh
        kLqpiuei7QrD1f4hSsqPmJ8=
X-Google-Smtp-Source: ABdhPJwugLkcnUlFDLEfQH3juQ22J68Ph+fbRc+CGW3xrPjyEQRjkSeMWEnNlVU3U6Ju57NjmJdbmw==
X-Received: by 2002:a63:2406:: with SMTP id k6mr10195695pgk.366.1602430319884;
        Sun, 11 Oct 2020 08:31:59 -0700 (PDT)
Received: from thinkpad (104.36.148.139.aurocloud.com. [104.36.148.139])
        by smtp.gmail.com with ESMTPSA id 137sm17529102pfu.149.2020.10.11.08.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2020 08:31:59 -0700 (PDT)
Date:   Sun, 11 Oct 2020 08:32:59 -0700
From:   Rustam Kovhaev <rkovhaev@gmail.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: switch to pr_warn() in __device_add_disk()
Message-ID: <20201011153259.GA637021@thinkpad>
References: <20201011130347.562264-1-rkovhaev@gmail.com>
 <745dd869-00ba-19fd-3643-27a92326f424@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <745dd869-00ba-19fd-3643-27a92326f424@suse.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Oct 11, 2020 at 04:53:22PM +0200, Hannes Reinecke wrote:
> On 10/11/20 3:03 PM, Rustam Kovhaev wrote:
> > syzbot triggered a warning while fuzzing with failslab fault injection
> > enabled
> > let's convert WARN_ON() to pr_warn()
> > 
> > Reported-and-tested-by: syzbot+f41893bb8c45cd18cf08@syzkaller.appspotmail.com
> > Link: https://syzkaller.appspot.com/bug?extid=f41893bb8c45cd18cf08
> > Signed-off-by: Rustam Kovhaev <rkovhaev@gmail.com>
> > ---
> >   block/genhd.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/block/genhd.c b/block/genhd.c
> > index 99c64641c314..be9ce35cf0fe 100644
> > --- a/block/genhd.c
> > +++ b/block/genhd.c
> > @@ -822,7 +822,8 @@ static void __device_add_disk(struct device *parent, struct gendisk *disk,
> >   		/* Register BDI before referencing it from bdev */
> >   		dev->devt = devt;
> >   		ret = bdi_register(bdi, "%u:%u", MAJOR(devt), MINOR(devt));
> > -		WARN_ON(ret);
> > +		if (ret)
> > +			pr_warn("%s: failed to register backing dev info\n", disk->disk_name);
> >   		bdi_set_owner(bdi, dev);
> >   		blk_register_region(disk_devt(disk), disk->minors, NULL,
> >   				    exact_match, exact_lock, disk);
> > 
> Please, don't. Where is the point in continuing here?
> I'd rather have it fixed up properly, either by having a return value to
> __device_add_disk() or by allowing the caller to check (eg by checking
> GENHD_FL_UP) if the call succeeded.
thank you for the review, it makes sense.

