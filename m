Return-Path: <SRS0=2u2q=5S=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE072C2D0F3
	for <linux-block@archiver.kernel.org>; Thu,  2 Apr 2020 16:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2DC82080C
	for <linux-block@archiver.kernel.org>; Thu,  2 Apr 2020 16:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585844051;
	bh=YWCwFuRxlfQZCnQduX7beJeIGMvcM5FqEGUtc2q6GPY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LxRHpT797FGR42wDMR0+ptyOUwEB62pRxwCppd8jNhUvYFiZQUb+3P2i5o750s25k
	 itkwemN8mrBfcCJ1TK6Deomgkr1/ISnN5LrCnGoO1G2GGjVijpqdqZtco1bybydaIh
	 0OXfZYjj9q4zaHiVGeG/tW4LLze3efuKNZkH4Ns0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389747AbgDBQOI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Apr 2020 12:14:08 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44245 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389718AbgDBQOI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Apr 2020 12:14:08 -0400
Received: by mail-pf1-f194.google.com with SMTP id b72so1951435pfb.11;
        Thu, 02 Apr 2020 09:14:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=P7i2URrTnDx5tzzyJk7AR5qnVc+j04ViOkgAKhpw3Sk=;
        b=OtG07gGLTkOjTZK/AqxMXL1OE+3P7C6TAqu44Gb16LJYXWkegE5apmBbCEvHQmWFkD
         DGP8Nnvrjfy3edVn88azm2ApreAoRbyhRU3+gkpqsGoNeO6lfSkvZi1JgtDkuok4nFil
         tArhKXe83a4UGgxGVmt6/2ULbiUSuzBdZX5F+Sh94kRefJqGL6Mbm9a8dzDkIjEUycjQ
         j88TavbxwWaeB9kWu/NxWJMhkS4IpuGYllP6NkWO+GE2BMeVhy3+v6+3gsdu60CX+ZyM
         fw6azSq8UJUAP9Hgrfu568L7IPlauT1spzFkGQfx4i6Jz9Dybk1w5/JzSP4YrENFatbb
         KxhQ==
X-Gm-Message-State: AGi0Pua14+9eeQAX8tNMaAYm+Ooa0Kxm1O1mAVyOJAREQiC2sDlwWToi
        7sa36cx7744suN9gTtLclJM=
X-Google-Smtp-Source: APiQypJ7nVgA8DvXN3x5K29X+h7zJol60u/kBlCNRDKrdex9FBSNttqYuXzqAeEmfrTTFVIQ8cZrNA==
X-Received: by 2002:aa7:990e:: with SMTP id z14mr4016427pff.274.1585844046496;
        Thu, 02 Apr 2020 09:14:06 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id t188sm4068670pfb.102.2020.04.02.09.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 09:14:04 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 1BDD040254; Thu,  2 Apr 2020 16:14:04 +0000 (UTC)
Date:   Thu, 2 Apr 2020 16:14:04 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Eric Sandeen <sandeen@sandeen.net>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        mhocko@suse.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>,
        syzbot+603294af2d01acfdd6da@syzkaller.appspotmail.com
Subject: Re: [RFC 2/3] blktrace: fix debugfs use after free
Message-ID: <20200402161404.GD11244@42.do-not-panic.com>
References: <20200402000002.7442-1-mcgrof@kernel.org>
 <20200402000002.7442-3-mcgrof@kernel.org>
 <9a6576cf-b89d-d1af-2d74-652878cb78c8@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a6576cf-b89d-d1af-2d74-652878cb78c8@sandeen.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 01, 2020 at 08:57:42PM -0500, Eric Sandeen wrote:
> On 4/1/20 7:00 PM, Luis Chamberlain wrote:
> > On commit 6ac93117ab00 ("blktrace: use existing disk debugfs directory")
> > Omar fixed the original blktrace code for multiqueue use. This however
> > left in place a possible crash, if you happen to abuse blktrace in a way
> > it was not intended.
> > 
> > Namely, if you loop adding a device, setup the blktrace with BLKTRACESETUP,
> > forget to BLKTRACETEARDOWN, and then just remove the device you end up
> > with a panic:
> 
> Weird, I swear I tested that and didn't hit it, but ...

The real issue was also the dangling block device, a loop device proves
easy to test that. I'll note that another way to test this as well would
be to have a virtual machine with a block devices that goes in and out
via whatever virsh shenanigans to make a block device appear / disappear.

> > This issue can be reproduced with break-blktrace [2] using:
> > 
> >   break-blktrace -c 10 -d
> 
> + -s, right?

Yeap, sorry about that.

> > This patch fixes this issue. Note that there is also another
> > respective UAF but from the ioctl path [3], this should also fix
> > that issue.
> > 
> > This patch then also contends the severity of CVE-2019-19770 as
> > this issue is only possible using root to shoot yourself in the
> > foot by also misuing blktrace.
> > 
> > [0] https://bugzilla.kernel.org/show_bug.cgi?id=205713
> > [1] https://nvd.nist.gov/vuln/detail/CVE-2019-19770
> > [2] https://github.com/mcgrof/break-blktrace
> 
> I verified that this does reproduce the exact same KASAN splat on
> kernel 4.19.83 as reported in the original bug, thanks!

I just codified what Nicolai suspected, we should thank him :)

  Luis
