Return-Path: <SRS0=GE/Q=S5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C68DC43218
	for <linux-block@archiver.kernel.org>; Sat, 27 Apr 2019 03:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0203C206C1
	for <linux-block@archiver.kernel.org>; Sat, 27 Apr 2019 03:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbfD0Dbo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Apr 2019 23:31:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51204 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbfD0Dbo (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Apr 2019 23:31:44 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AB22DC0B78C4;
        Sat, 27 Apr 2019 03:29:51 +0000 (UTC)
Received: from ming.t460p (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1C13E1001DD9;
        Sat, 27 Apr 2019 03:29:44 +0000 (UTC)
Date:   Sat, 27 Apr 2019 11:29:39 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        linux-block@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] block/028: check if T10 verification fails
Message-ID: <20190427032938.GA825@ming.t460p>
References: <20190426023937.19584-1-ming.lei@redhat.com>
 <20190426145711.GA12338@infradead.org>
 <20190426221630.GB31470@ming.t460p>
 <20190427012449.GC178347@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190427012449.GC178347@magnolia>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Sat, 27 Apr 2019 03:29:51 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 26, 2019 at 06:24:49PM -0700, Darrick J. Wong wrote:
> On Sat, Apr 27, 2019 at 06:16:32AM +0800, Ming Lei wrote:
> > On Fri, Apr 26, 2019 at 07:57:11AM -0700, Christoph Hellwig wrote:
> > > On Fri, Apr 26, 2019 at 10:39:37AM +0800, Ming Lei wrote:
> > > > When T10 verification fails, the error code of BLK_STS_PROTECTION
> > > > may not be propagated to user space, see mpage_end_io().
> > > 
> > > Well, we should probably fix that instead of papering over it..
> > 
> > That might be a big change, and not sure when they can be fixed
> > completely.
> > 
> > This patch at least can expose the issue to user first.
> 
> I don't see a patch anywhere ... ?

It is one blktest patch, please see the following link:

https://lore.kernel.org/linux-block/20190427012449.GC178347@magnolia/T/#t

Thanks,
Ming
