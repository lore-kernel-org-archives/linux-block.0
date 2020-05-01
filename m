Return-Path: <SRS0=jnOf=6P=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E41C47257
	for <linux-block@archiver.kernel.org>; Fri,  1 May 2020 15:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55C8420708
	for <linux-block@archiver.kernel.org>; Fri,  1 May 2020 15:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588346690;
	bh=6SWvTu/VEYFP0rGFICjtBRh0FLf8COFAflcT/LRMfOQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gD/EljUotLmOH6wnLxofMLwR7Gq1CKjFGVVsVu0u+oBNsapx8OITYMsx8sSCoExe8
	 OplEvKV/qWxukEhHDNank166wu+XCKbEoTCU4VljoDPYhHTR1Xe8szdrMhlZPu9yxL
	 MQ4Ghr6WP93O7LiFNTW4avvj3XpgxGC4le90iIDw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728771AbgEAPYt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 May 2020 11:24:49 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:55527 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728443AbgEAPYt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 May 2020 11:24:49 -0400
Received: by mail-pj1-f66.google.com with SMTP id a32so18295pje.5;
        Fri, 01 May 2020 08:24:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X20mKpRRVq/ark63BbLpoCynpLjPmjVnD3XcfxieJmo=;
        b=nxLBwiUyssNTIBTkfse5CKboAwAshhtDUb2MiZ4uTej8w+2Hp7VUFZr+RiLxxUjANg
         41i5Bn193Ai81hZUpbFSOIs/yWTn3f55Dd5nhrQehajf0UZBbKOQn1HPs32g87MxZ4aN
         aA69TRjwlhffllEZg3LToNIXn5AJEPJ7elNznjbdgCn86PXOo9GaDHPfCNMoHMb2eeaV
         efGcT1hMGtxFs7R9EgdgoRoqqDeal0KmSzOATx3kWGywGo0cC3SRFQlJ3KWPzFUVP6Y8
         Cj3gJSvSirnh8egzSkODjBzhP/JIFamm3wTv97F0hZux/wV7bABL/OXg+RCdBRZyyFfi
         OZAw==
X-Gm-Message-State: AGi0Pua5rXtk1NfvOsomIPaNSfCZWQWDABp2iWnK7mUSQACtNWL4++6f
        FhzDo4ZUL/U/xL4n0gXfUxI=
X-Google-Smtp-Source: APiQypIS4cJmDrisB6sfUSd9KAjmqSPPBVrVSde1HXQ1i+jak+p623AzeudhI/4PsYT0cfEmmyEQeA==
X-Received: by 2002:a17:902:a513:: with SMTP id s19mr5192257plq.84.1588346687212;
        Fri, 01 May 2020 08:24:47 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id a15sm11899pju.3.2020.05.01.08.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 08:24:45 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 5D8FD4046C; Fri,  1 May 2020 15:24:45 +0000 (UTC)
Date:   Fri, 1 May 2020 15:24:45 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>, axboe@kernel.dk,
        viro@zeniv.linux.org.uk, bvanassche@acm.org, rostedt@goodmis.org,
        mingo@redhat.com, jack@suse.cz, ming.lei@redhat.com,
        nstange@suse.de, akpm@linux-foundation.org, mhocko@suse.com,
        yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>,
        syzbot+603294af2d01acfdd6da@syzkaller.appspotmail.com
Subject: Re: [PATCH v3 4/6] blktrace: fix debugfs use after free
Message-ID: <20200501152445.GN11244@42.do-not-panic.com>
References: <20200429074627.5955-1-mcgrof@kernel.org>
 <20200429074627.5955-5-mcgrof@kernel.org>
 <20200429112637.GD21892@infradead.org>
 <20200429114542.GJ11244@42.do-not-panic.com>
 <20200429115051.GA27378@infradead.org>
 <20200429120230.GK11244@42.do-not-panic.com>
 <20200429120406.GA913@infradead.org>
 <20200429122152.GL11244@42.do-not-panic.com>
 <20200429125726.GA2123334@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429125726.GA2123334@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 29, 2020 at 02:57:26PM +0200, Greg KH wrote:
> On Wed, Apr 29, 2020 at 12:21:52PM +0000, Luis Chamberlain wrote:
> > On Wed, Apr 29, 2020 at 05:04:06AM -0700, Christoph Hellwig wrote:
> > > On Wed, Apr 29, 2020 at 12:02:30PM +0000, Luis Chamberlain wrote:
> > > > > Err, that function is static and has two callers.
> > > > 
> > > > Yes but that is to make it easier to look for who is creating the
> > > > debugfs_dir for either the request_queue or partition. I'll export
> > > > blk_debugfs_root and we'll open code all this.
> > > 
> > > No, please not.  exported variables are usually a bad idea.  Just
> > > skip the somewhat pointless trivial static function.
> > 
> > Alrighty. It has me thinking we might want to only export those symbols
> > to a specific namespace. Thoughts, preferences?
> > 
> > BLOCK_GENHD_PRIVATE ?
> 
> That's a nice add-on issue after this is fixed.  As Christoph and I
> pointed out, you have _less_ code in the file if you remove the static
> wrapper function.  Do that now and then worry about symbol namespaces
> please.

So it turns out that in the old implementation, it was implicit that the
request_queue directory was shared with the scsi drive. So, the
q->debugfs_dir *will* be set, and as we have it here', we'd silently be
overwriting the old q->debugfs_dir, as the queue is the same. To keep
things working as it used to, with both, we just need to use a symlink
here. With the old way, we'd *always* create the sg directory and re-use
that, however since we can only have one blktrace per request_queue, it
still had the same restriction, this was just implicit. Using a symlink
will make this much more obvious and upkeep the old functionality. We'll
need to only export one symbol. I'll roll this in.

  Luis
