Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB2E2C07E9D
	for <linux-block@archiver.kernel.org>; Tue, 20 Jul 2021 00:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F36761107
	for <linux-block@archiver.kernel.org>; Tue, 20 Jul 2021 00:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245217AbhGSXaw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Jul 2021 19:30:52 -0400
Received: from mail-pf1-f174.google.com ([209.85.210.174]:35807 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390741AbhGSV5n (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Jul 2021 17:57:43 -0400
Received: by mail-pf1-f174.google.com with SMTP id d12so17977029pfj.2;
        Mon, 19 Jul 2021 15:38:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JqFi5pJMaEGoSC9dEPpY+x76CPFJ4ZtDUn2ezmPVmGI=;
        b=rK5SEe/KH52zse+d2FaFslhJH0Mo6yE0cqjMCHb4JCcBvyU+u9vtcOo7MTjEklxAFd
         hCRKA7VeeNlylxdcjIxF8ag1BtmY49FNs7qiaW0IuoJzaOaX+W2H2kRY8Km68FsDipnr
         PUhhijBzpij5Yf1J36vVhBnIxloMaRhSQn9BuKybMdvktNCSJ2OVm7n6+Owc1R3GnDaK
         yOOS+mK6//EkpjQ4AdFq5pdECL7a2Ul5hI7vrdx3Ex6MX42+SyWbu6yYs7bwZ6/NIexx
         Nl88a2zWvnOzfEe/x7lUGPjlGezfoJkXIsFCYj/mbLBHgOw1DIozJNTRoW2KwPWj7iWW
         iQvw==
X-Gm-Message-State: AOAM530lkNnTC5QZrLTGNx2j34/4ZlLWlHcPB3OsyWs70UFHMXdMDkrC
        UQPGpuQhwhNPvib0O1nEeAs=
X-Google-Smtp-Source: ABdhPJx40eKuba0Npl9zrd7Bbu9gJFIOfI9Hx5NkiYMvKuHrIHVe+QYkYgYs1tC3eXW5qAJMiMiZnw==
X-Received: by 2002:aa7:921a:0:b029:2cf:b55b:9d52 with SMTP id 26-20020aa7921a0000b02902cfb55b9d52mr27517616pfo.35.1626734293380;
        Mon, 19 Jul 2021 15:38:13 -0700 (PDT)
Received: from garbanzo ([191.96.121.239])
        by smtp.gmail.com with ESMTPSA id k6sm4776847pgb.43.2021.07.19.15.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 15:38:12 -0700 (PDT)
Date:   Mon, 19 Jul 2021 15:38:10 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     axboe@kernel.dk, hare@suse.de, bvanassche@acm.org,
        ming.lei@redhat.com, jack@suse.cz, osandov@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 2/6] block: add flag for add_disk() completion notation
Message-ID: <20210719223810.5taulrnaupbxdmdv@garbanzo>
References: <20210715202341.2016612-1-mcgrof@kernel.org>
 <20210715202341.2016612-3-mcgrof@kernel.org>
 <YPVNRLgBtUOb1d17@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPVNRLgBtUOb1d17@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jul 19, 2021 at 11:00:36AM +0100, Christoph Hellwig wrote:
> >  {
> >  	might_sleep();
> >  
> > +	if (!blk_disk_registered(disk))
> > +		return;
> > +
> 
> Can't say I like this all that much.  Drivers should keep some
> basic sanity for their unregister path, and while blk_disk_registered
> can be useful, it's uses should be kept at a minimum.

This just means quite a bit of drivers have to invent some scheme to
keep tabs on if registration was completed or not on their own... I
can't see too much downfall for us to embrace this. Anyway I'll keep
it in the mix and respin it as proper patch as it seems you suggested
a respin of the series.

  Luis
