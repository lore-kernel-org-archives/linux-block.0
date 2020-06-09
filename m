Return-Path: <SRS0=iQ6z=7W=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4228C433DF
	for <linux-block@archiver.kernel.org>; Tue,  9 Jun 2020 17:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A56C920801
	for <linux-block@archiver.kernel.org>; Tue,  9 Jun 2020 17:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591725251;
	bh=XqQiaFHrsQiVBWa9z6v2XCVeqMzgZZiT7qjQk9hlmk0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pNPaqV8JKNPrdrDQ2Qv68YNphJyhizVzP9bRF8Bylcbp1EtHhuWxkx7aYxw0GnTHw
	 3a4kjmFfSmgVYTeaCMV0dP9ibKLlAh8awoHNaFpPuqosaVXT2u5t0zmSbAwsu69Xjv
	 D/C8kdYU0QZqgx0jILw1aoT/5CCgDNd7vapOjHpY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731855AbgFIRyG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Jun 2020 13:54:06 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:53469 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728829AbgFIRyD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Jun 2020 13:54:03 -0400
Received: by mail-pj1-f67.google.com with SMTP id i12so1709348pju.3;
        Tue, 09 Jun 2020 10:54:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l535t0gtEMhwRmJuEGpot34AcMJTeoyuOmb6/SPxdIo=;
        b=B5DgajjKiI9YxNKx3abMttvo0hbyCx/XRBLHlugEJpi/G2A/cO0I3u5Zr2SnmTxHjE
         g072HopjEFjGy03WlGK9aPdmASfcPh1podyiYdgqXTDoPWVQgNVV8ERPtibQQfQrafNg
         AJb5BSEYLfsi7hdZQdrjFXYbRukuh0zuUmfFcYGa4pVBmhds4rw7WoMek0R0FrPeIJX1
         WEPkJkirttW0EU7/l2Quh9j4xVNfeidQY4w2zNksYG+tXq4rVrGpRjc3JylJQiBsv6na
         3YGcNQsJ2HbDhv/hUX0+GHVG22CAvON2xvB9KJYaZshONiroRieWKJKA4VR1tkwBA3Oo
         Uz+A==
X-Gm-Message-State: AOAM5329nLo6KWzv2i2WgScI5WdIwpGHz5jz/3QEmaHp/Hz5Z9PGpZVB
        JTUM+XwFKdJb+0x+il05znU=
X-Google-Smtp-Source: ABdhPJy/NmjQ3jEGM1rDQ6v1rJGJ2kfZGaht+oE0SOlu7pxqvuGtyZmIoYsQQ37mHn9Ym+N88QSF5w==
X-Received: by 2002:a17:902:ee93:: with SMTP id a19mr4432067pld.144.1591725241302;
        Tue, 09 Jun 2020 10:54:01 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id x77sm10745875pfc.4.2020.06.09.10.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 10:54:00 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id A13B6403AB; Tue,  9 Jun 2020 17:53:59 +0000 (UTC)
Date:   Tue, 9 Jun 2020 17:53:59 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, axboe@kernel.dk, viro@zeniv.linux.org.uk,
        bvanassche@acm.org, gregkh@linuxfoundation.org,
        rostedt@goodmis.org, mingo@redhat.com, ming.lei@redhat.com,
        nstange@suse.de, akpm@linux-foundation.org, mhocko@suse.com,
        yukuai3@huawei.com, martin.petersen@oracle.com, jejb@linux.ibm.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>,
        syzbot+603294af2d01acfdd6da@syzkaller.appspotmail.com
Subject: Re: [PATCH v6 6/6] blktrace: fix debugfs use after free
Message-ID: <20200609175359.GR11244@42.do-not-panic.com>
References: <20200608170127.20419-1-mcgrof@kernel.org>
 <20200608170127.20419-7-mcgrof@kernel.org>
 <20200609150602.GA7111@infradead.org>
 <20200609172922.GP11244@42.do-not-panic.com>
 <20200609173218.GA7968@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200609173218.GA7968@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 09, 2020 at 10:32:18AM -0700, Christoph Hellwig wrote:
> On Tue, Jun 09, 2020 at 05:29:22PM +0000, Luis Chamberlain wrote:
> > Is scsi-generic is the only unwanted ugly child blktrace has to deal
> > with? For some reason I thought drivers/md/md.c was one but it seems
> > like it is not. Do we have an easy way to search for these? I think
> > this would just affect how we express the comment only.
> 
> grep for blk_trace_setup.  For all blk devices that setup comes in
> through the block device ioctl path, and that relies on having a
> struct block_device and queue.  sg on the other hand calls
> blk_trace_setup directly with a NULL bdev argument.

Alright, then we should be good.

> > >  		 */
> > > -		dir = q->sg_debugfs_dir;
> > > +		dir = debugfs_create_dir(buts->name, blk_debugfs_root);
> > > +		bt->dir = dir;
> > 
> > The other chicken and egg problem to consider at least in the comments
> > is that the debugfs directory for these types of devices *have* an
> > exposed path, but the data structure is rather opaque to the device and
> > even blktrace.  Fortunately given the recent set of changes around the
> > q->blk_trace and clarifications around its use we have made it clear now
> > that so long as hold the q->blk_trace_mutex *and* check q->blk_trace we
> > *should* not race against two separate creations of debugfs directories,
> > so I think this is safe, so long as these indpendent drivers don't end
> > up re-using the same path for some other things later in the future, and
> > since we have control over what goes under debugfsroot block / I think
> > we should be good.
> > 
> > But I think that the concern for race on names may still be worth
> > explaining a bit here.
> 
> Feel free to add more comments, but please try to keep them short
> and crisp.  At the some point long comments really distract from what
> is going on.

Sure.

Come to think of it, given the above, I think we can also do way with
the the partition stuff too, and rely on the buts->name too. I'll try
this out, and test it.

  Luis
