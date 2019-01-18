Return-Path: <SRS0=kGct=P2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B23B6C43387
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 11:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A3F72087E
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 11:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7Ovutsp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfARLKM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Jan 2019 06:10:12 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33507 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbfARLKL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Jan 2019 06:10:11 -0500
Received: by mail-wr1-f66.google.com with SMTP id c14so14605263wrr.0;
        Fri, 18 Jan 2019 03:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=i9Jz6mADl+SAlcH6gEeO3JwA6zj1h7g3kXeXLvf3Qh4=;
        b=c7OvutspFyLKMOanYTqFOhtdpU7ojaNNVvJVsg4XAm+1GYeuC7XX9Xu+fKTrDD6Huu
         HJQC3lrph0tk/EsV0XUd1Uf2YVoCFHoBspiiB6qOnYfiJisjF8hdIXAyPe5z0IHOoERf
         d+ZVQ0rTBjEHLZ350xYAXGHdc5PO3yHvLCpmBlgXIoF5PgovBkJrD0JFOG83e9eW/pQo
         0UN0MNfCoR8n6vvDrnB2feSg8BPvSiNlewlZInoDo6eYsvbChrGuKDovg3aeWkKNVf2/
         g7lCxkVgPp/ab1W9Eygu/cE19L/uL89L1PKjNyjA2ytquXYqi+lv1HgVlHIxy9u+eEsx
         nYZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=i9Jz6mADl+SAlcH6gEeO3JwA6zj1h7g3kXeXLvf3Qh4=;
        b=MlUOETbAVi3c5ofXvwmaWp0ofaMdGFBlB29/etjtZF3+pApi0gXtLY5RmzJTD2yXPr
         7PjrVadXh3382dJLeCvV5YNrx1sdqLIvv/xSPrXqOlEHbkgedZ9ydA+u1S+jXas3le2u
         TONZhWp0bP5lQrxhSyFA0gmLVnRHaaWLX8PbRoXaLNmJlzmA+zuHOWD0QI4Eykh+CDGz
         KQs1gaHyUUoO3rtYmXlaK76OxC37I/Vm+uZhq1TB0A6PyUr5JCQ1SnT+ykvt/7IE1QAn
         EhNNMP2bAl7mHUYdJKqC4A0E0bMPFOjuBMXHCsK+Sxo4xtp7+Ay8mhXEqZF8VmaI14Lz
         cKTQ==
X-Gm-Message-State: AJcUukdF/d56bvffC8HizOjy+FonSMjpkIBtLzk6T8USeBwZOuQ9jw53
        DKPnklcpkYySGGLJddYL4g==
X-Google-Smtp-Source: ALg8bN5HmuGWHZrf/Pe4lq0wPDcQ3aonXuxeHvlAvYBG6K6PrZDkNJ4+rKgm/Ot09izhnvbvSEmNsg==
X-Received: by 2002:adf:dcd0:: with SMTP id x16mr15760897wrm.143.1547809809868;
        Fri, 18 Jan 2019 03:10:09 -0800 (PST)
Received: from localhost (host89-130-dynamic.43-79-r.retail.telecomitalia.it. [79.43.130.89])
        by smtp.gmail.com with ESMTPSA id o81sm69625423wmd.10.2019.01.18.03.10.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Jan 2019 03:10:09 -0800 (PST)
Date:   Fri, 18 Jan 2019 12:10:08 +0100
From:   Andrea Righi <righi.andrea@gmail.com>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jens Axboe <axboe@kernel.dk>, Vivek Goyal <vgoyal@redhat.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Dennis Zhou <dennis@kernel.org>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] cgroup: fsio throttle controller
Message-ID: <20190118111008.GA25335@xps-13>
References: <20190118103127.325-1-righi.andrea@gmail.com>
 <E5872191-EE96-442E-B668-DD148157E665@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E5872191-EE96-442E-B668-DD148157E665@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jan 18, 2019 at 12:04:17PM +0100, Paolo Valente wrote:
> 
> 
> > Il giorno 18 gen 2019, alle ore 11:31, Andrea Righi <righi.andrea@gmail.com> ha scritto:
> > 
> > This is a redesign of my old cgroup-io-throttle controller:
> > https://lwn.net/Articles/330531/
> > 
> > I'm resuming this old patch to point out a problem that I think is still
> > not solved completely.
> > 
> > = Problem =
> > 
> > The io.max controller works really well at limiting synchronous I/O
> > (READs), but a lot of I/O requests are initiated outside the context of
> > the process that is ultimately responsible for its creation (e.g.,
> > WRITEs).
> > 
> > Throttling at the block layer in some cases is too late and we may end
> > up slowing down processes that are not responsible for the I/O that
> > is being processed at that level.
> > 
> > = Proposed solution =
> > 
> > The main idea of this controller is to split I/O measurement and I/O
> > throttling: I/O is measured at the block layer for READS, at page cache
> > (dirty pages) for WRITEs, and processes are limited while they're
> > generating I/O at the VFS level, based on the measured I/O.
> > 
> 
> Hi Andrea,
> what the about the case where two processes are dirtying the same
> pages?  Which will be charged?
> 
> Thanks,
> Paolo

Hi Paolo,

in this case only the first one will be charged for the I/O activity
(the one that changes a page from clean to dirty). This is probably not
totally fair in some cases, but I think it's a good compromise, at the
end rewriting the same page over and over while it's already dirty
doesn't actually generate I/O activity, until the page is flushed back
to disk.

Obviously I'm open to other better ideas and suggestions.

Thanks!
-Andrea
