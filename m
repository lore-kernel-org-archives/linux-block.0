Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE61C636CA
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 19:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 966B46120A
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 19:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245007AbhGOTiz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Jul 2021 15:38:55 -0400
Received: from mail-pg1-f178.google.com ([209.85.215.178]:42701 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245710AbhGOThA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Jul 2021 15:37:00 -0400
Received: by mail-pg1-f178.google.com with SMTP id d12so7558831pgd.9;
        Thu, 15 Jul 2021 12:34:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zjxwp6orKMql7+9u1ifo9qLb9KJtenjBrmxBwEY+JMw=;
        b=qzgljO+BucRWGpUbkorz9naxtIIG7mcTJIWhS++L8v1rLh3qgak74ij2Z3LQENdejR
         Ss4MEr/QVzgPkd/+YnihrwnS7SbwfQtUl4uAIQMhQ5wJ4zOFsPRI2R4RByylcFUNLGUD
         g+DGbw9d+oAT3kMprSf1UNmvpU/MCeb6VR+O5aj68K4GlcI4LZLFH3qnH1OBSDEJOOvj
         /suAnpQrzpgH47eWkJLlvvHq/IjnwChWyjJy6mSajutX3nEoo/s1CN5cuua+mtXgruRc
         z6PHo36TOxABnKVBdy/eg0VJI+DPt44+d5r19K7gRmu94MGdU106JH+9H94aolf5p7Rn
         hgvQ==
X-Gm-Message-State: AOAM5324Kvyc/ctwU3I8qrZE7IFUM77uG8PPc0E8D/49qskHnp+OS/Of
        Zzfp+5U5aUGH52a3rrJKZdo=
X-Google-Smtp-Source: ABdhPJxY8NxgGVaQ84TXeW3HbjKH0JflzassnRhJ3CpoBi9BrNalbqNRIerP4lMAdXnIKdgPMPl8Rw==
X-Received: by 2002:a63:100e:: with SMTP id f14mr6213805pgl.95.1626377646832;
        Thu, 15 Jul 2021 12:34:06 -0700 (PDT)
Received: from garbanzo ([191.96.120.37])
        by smtp.gmail.com with ESMTPSA id l6sm7542802pff.74.2021.07.15.12.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 12:34:05 -0700 (PDT)
Date:   Thu, 15 Jul 2021 12:34:03 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     axboe@kernel.dk, hare@suse.de, bvanassche@acm.org,
        ming.lei@redhat.com, jack@suse.cz, osandov@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] block: add error handling for *add_disk*()
Message-ID: <20210715193403.qn6nlb27uf2daf65@garbanzo>
References: <20210715045531.420201-1-mcgrof@kernel.org>
 <YO/iVNCSTWy5EmoP@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YO/iVNCSTWy5EmoP@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 15, 2021 at 08:23:00AM +0100, Christoph Hellwig wrote:
> On Wed, Jul 14, 2021 at 09:55:25PM -0700, Luis Chamberlain wrote:
> > Although I've dropped driver conversion at this point I've
> > converted all drivers over, but that series is about 80
> > patches... and so should be dealt with after this basic core
> > work is reviewed and merged.
> 
> I think we need at least a few sample conversions to show how
> you intend this to be used.

I'll send a few out, but I'll send them as separate groups. There
are 5 groups of further changes as part of the driver conversion:

  1) trivial changes: requires a blk_cleanup_disk() on error added
  2) Fix uses of GENHD_FL_UP
  3) Fix uses of GENHD_FL_UP for del_gendisk() with a block helper
  4) make probe on blk_request_module() return an error, so to
     take advantage of the add_disk() on probe calls. Drivers which
     benefit:
     - ataflop
     - brd
     - floppy
     - loop
     - scsi/sd
  5) Once all drivers are converted, add __must_check() to add_disk()
     and friends

There are so many patches I think it makes sense to only post a few
for each group, except maybe the 4th group, that requires probe
change to go in one full sweep. I've only build tested what fits
in my architecture so far, waiting on 0-day complaints reports to
fix the rest. So only the first first group will go as PATCH form
for now.

  Luis
