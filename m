Return-Path: <SRS0=Ef4g=6A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD6FFC2BA19
	for <linux-block@archiver.kernel.org>; Thu, 16 Apr 2020 00:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 969AD208E0
	for <linux-block@archiver.kernel.org>; Thu, 16 Apr 2020 00:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586998620;
	bh=D1cdmZrrpBRbgmrLVaVBeOswtpdvqTyzIt0hgqZ/xq4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nsqVXmgJfTj+lL5n3bwx0CJTYdMTR+oJSBMom43mBlZlmKq6iDE8/Me2EdmLeTqXz
	 a/Xy/R0XVmaIvuYydVMUJvVLoQGy1mL/Kh6H32TkqMU0/aBv/qpQc+/pyidD+TGpJQ
	 cRCKyjmrxuPiMHssZgla5wB/rGyuzlw30tVyE27A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405986AbgDPA4y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Apr 2020 20:56:54 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:35020 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730956AbgDPA4j (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Apr 2020 20:56:39 -0400
Received: by mail-pj1-f68.google.com with SMTP id mn19so633005pjb.0;
        Wed, 15 Apr 2020 17:56:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eO9sNPLfM7z72dEgAo+/qu9o3q8PbtexT1d+8SrfwsA=;
        b=JGh+lJxesRqdgeJtFbGZGz14pDNgxiidkKGncb3l9ppgkSKTBj3Fu2FdnBsHIM3a/I
         buzrXL/LyEC5BTpTB2rvsnyxBmmbJ64ngdj7Z5logaFtTa7FRRfhXlgVFpIoT3h7PrMa
         pdPfaNe0s/bC8cr77YKDsFnKYOrZajbtS0OqPpIV0In0wxzct4OoGGZr2t8n5zlP9AGm
         wMSYVacKJIfzSBEdOFvphsqxzX6Z845TWt743HAwT6aRdnSEyR5opplk4ASbIbLsbNW0
         H3VNdhUSk06VejV+fEO3QWGZfGlng+/zB5sRF5PjOYFed8RkIyt6y9FWHLkS1Xk7BpJh
         /x3g==
X-Gm-Message-State: AGi0PubcF15xm3TaWnXt5HJ6WDWhIjr+kQeGW7Vrvgog+TIisRv1aY0i
        RM32Hc2sCFPNUhx8SDRSA6Q=
X-Google-Smtp-Source: APiQypLTnLjPDNnNSqH+28hBHDSVc+roLpy3QPduruGp0bWr41DL6u4FpH1sWq/opGKxLvN3EFlJxw==
X-Received: by 2002:a17:90a:276a:: with SMTP id o97mr2095369pje.194.1586998598514;
        Wed, 15 Apr 2020 17:56:38 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id p11sm12753364pff.173.2020.04.15.17.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 17:56:37 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 7781640277; Thu, 16 Apr 2020 00:56:36 +0000 (UTC)
Date:   Thu, 16 Apr 2020 00:56:36 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Eric Sandeen <sandeen@sandeen.net>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org, mhocko@suse.com, yukuai3@huawei.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>,
        syzbot+603294af2d01acfdd6da@syzkaller.appspotmail.com
Subject: Re: [PATCH 2/5] blktrace: fix debugfs use after free
Message-ID: <20200416005636.GA11244@42.do-not-panic.com>
References: <20200414041902.16769-1-mcgrof@kernel.org>
 <20200414041902.16769-3-mcgrof@kernel.org>
 <55401e02-f61c-25eb-271c-3ec7baf35e28@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55401e02-f61c-25eb-271c-3ec7baf35e28@sandeen.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 15, 2020 at 12:38:26PM -0500, Eric Sandeen wrote:
> On 4/13/20 11:18 PM, Luis Chamberlain wrote:
> > On commit 6ac93117ab00 ("blktrace: use existing disk debugfs directory")
> > merged on v4.12 Omar fixed the original blktrace code for request-based
> > drivers (multiqueue). This however left in place a possible crash, if you
> > happen to abuse blktrace in a way it was not intended.
> > 
> > Namely, if you loop adding a device, setup the blktrace with BLKTRACESETUP,
> > forget to BLKTRACETEARDOWN, and then just remove the device you end up
> > with a panic:
> 
> I think this patch makes this all cleaner anyway, but - without the apparent
> loop bug mentioned by Bart which allows removal of the loop device while blktrace
> is active (if I read that right), can this still happen?

I have not tested that, but some modifications of the break-blktrace
program could enable us to test that, however I don't think the race
would be possible after patch 3/5 "blktrace: refcount the request_queue
during ioctl" is merged, as removal then a pending blktrace would
refcount the request_queue and the removal would have to wait until
the refcount is decremeneted, until after the blktrace ioctl.

  Luis
