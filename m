Return-Path: <SRS0=nYW3=6I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D839AC54FD0
	for <linux-block@archiver.kernel.org>; Fri, 24 Apr 2020 22:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6B9720728
	for <linux-block@archiver.kernel.org>; Fri, 24 Apr 2020 22:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587767534;
	bh=yQKDeja61r9ngLgFFSy0chCy5Pk6jE0UhLS3yktaq50=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=evC93xDxliSu38kzDZDzwHWBemSkgoi/Mj/LKhFqlBCINfeK3iSxQjzCHONGHV7sA
	 3m3iZV1MYeyPH+V38C/PogvQTvx4g+b3O5fEGIr25MGlrb7qiNQ5E5QWr6vmBU8e2l
	 IwjQ8VPaBwTJ05jJaminKH6PSDdsSsA/HlmxrDZ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgDXWcO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Apr 2020 18:32:14 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:36362 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgDXWcN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Apr 2020 18:32:13 -0400
Received: by mail-pj1-f66.google.com with SMTP id a31so2591046pje.1;
        Fri, 24 Apr 2020 15:32:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CTYT7xL9yF3Xv9mhQIugx9s6BA/cd6XZnpJVcb1O0IU=;
        b=rWD6T33Qk7dnSk6RmE5v8uNZiVTWzdgHNsV/ZiQwY0P2pmtNik6qBuDDJjKhV54ArV
         r2D0g2TvVqcWbI8yVv3aLs0BJgrGjehwNFvM14dcE33WH7L5A4kC8SMDiw5NG2A4cMS+
         S0s73QpIBVIA2gaKB5iydw1d426q9/m/60i41mmO8tTLP2r9V7EScjBxGT/t6SVC+Poo
         9yqfVOIliNYqTnnjLqvTZTbXOFdSPx3sllBiHe1pod1zKSGtO3D1kHueIkHb4g203XhV
         XtFn5pR6fVwshkQRbxxdXZayztuv4q/g9W37kENnpGl7yHFJKO2XtxXoZ2ybkl/kKrR0
         wf9w==
X-Gm-Message-State: AGi0PuY0KiXjNfrlrUAanNUx+r18+Cc5heDGUR0H2G6FFMFG8uI7sso8
        ecWxYX6ocVeOZfO+1OYLCvI=
X-Google-Smtp-Source: APiQypLJjYsyYI1QN9XpzlSgOnj6dDuXwttt3S4K9LN5RuJFPGbuPhITsepw8rgF04Qmxl2GV3dlGA==
X-Received: by 2002:a17:902:c381:: with SMTP id g1mr11203988plg.135.1587767532903;
        Fri, 24 Apr 2020 15:32:12 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id j14sm5729725pjm.27.2020.04.24.15.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 15:32:11 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id E548F403AB; Fri, 24 Apr 2020 22:32:10 +0000 (UTC)
Date:   Fri, 24 Apr 2020 22:32:10 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org, mhocko@suse.com, yukuai3@huawei.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/10] block: put_device() if device_add() fails
Message-ID: <20200424223210.GD11244@42.do-not-panic.com>
References: <20200419194529.4872-1-mcgrof@kernel.org>
 <20200419194529.4872-11-mcgrof@kernel.org>
 <85a18bcf-4bd0-a529-6c3c-46fcd23a350e@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85a18bcf-4bd0-a529-6c3c-46fcd23a350e@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Apr 19, 2020 at 04:40:45PM -0700, Bart Van Assche wrote:
> On 4/19/20 12:45 PM, Luis Chamberlain wrote:
> > Through code inspection I've found that we don't put_device() if
> > device_add() fails, and this must be done to decrement its refcount.
> 
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>

Turns out this is wrong, as bdi needs it still, we have can only remove
it once all users are done, which should be at the disk_release() path.

I've found this while adding the errors paths missing.

  Luis
