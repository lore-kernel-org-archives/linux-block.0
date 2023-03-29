Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE9DC6FD18
	for <linux-block@archiver.kernel.org>; Wed, 29 Mar 2023 16:11:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbjC2QLm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Mar 2023 12:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjC2QLk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Mar 2023 12:11:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 300B45B86
        for <linux-block@vger.kernel.org>; Wed, 29 Mar 2023 09:11:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 614EA61D9A
        for <linux-block@vger.kernel.org>; Wed, 29 Mar 2023 16:11:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08632C433EF;
        Wed, 29 Mar 2023 16:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680106269;
        bh=9DcUxntLnab5cJ/+8zw/KFyM3GJUThn6mt1RVFym3OI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BtX1GYrz6I3x76GBwPYUCSl7Yy75ev4djW4jtGV4pHaxqr3LLYGR3bbSAqz807zVr
         CwpfFioDelLfPz2SMrHlcoDzGEiTfZ3kv3NusnwkudId1FTIXZEsDNOhiZqmILEUdz
         /a3EwveV9Ukq9wPy9eUKQnlamQv9jNs7wqT8hLmQ6YHehZLeAo8oz098VGQoJiay8+
         vl5KYtZAVeR7SY/trbx3XTrdiu21/jb3v/Cgk5mo+5tE2CJFWX0k+8UexkoNAVFN5P
         WtZCtQjnnahO6OtSOVA7+HxVORaESzwZhsVOxNSXvXNBNp5Z+jFZJhAR3pVsC3/8AL
         RoV0XHd91IuWQ==
Date:   Wed, 29 Mar 2023 10:11:06 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Kanchan Joshi <joshi.k@samsung.com>
Cc:     Kanchan Joshi <joshiiitr@gmail.com>, Keith Busch <kbusch@meta.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        axboe@kernel.dk, hch@lst.de
Subject: Re: [PATCH 2/2] nvme: use blk-mq polling for uring commands
Message-ID: <ZCRjGmPCeLvi2m39@kbusch-mbp.dhcp.thefacebook.com>
References: <20230324212803.1837554-1-kbusch@meta.com>
 <CGME20230324213124epcas5p331ea3c2e2a05ec6a6825e719e47d2427@epcas5p3.samsung.com>
 <20230324212803.1837554-2-kbusch@meta.com>
 <20230327135810.GA8405@green5>
 <ZCG0O6RdlA/sUd7C@kbusch-mbp.dhcp.thefacebook.com>
 <CA+1E3rK2h9gyy26v1NmwTFtUsCwMkc1DgkDsCFME+HjZJPn5Hg@mail.gmail.com>
 <ZCI5XopTr7nJvVF1@kbusch-mbp.dhcp.thefacebook.com>
 <20230328074939.GA2800@green5>
 <ZCL/RTHoflUVCMyw@kbusch-mbp.dhcp.thefacebook.com>
 <20230329084618.GB2800@green5>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329084618.GB2800@green5>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 29, 2023 at 02:16:18PM +0530, Kanchan Joshi wrote:
> On Tue, Mar 28, 2023 at 08:52:53AM -0600, Keith Busch wrote:
> > > > +	else if (issue_flags & IO_URING_F_IOPOLL)
> > > > +		ioucmd->flags |= IORING_URING_CMD_NOPOLL;
> > > 
> > > If IO_URING_F_IOPOLL would have come here as part of "ioucmd->flags", we
> > > could have just cleared that here. That would avoid the need of NOPOLL flag.
> > > That said, I don't feel strongly about new flag too. You decide.
> > 
> > IO_URING_F_IOPOLL, while named in an enum that sounds suspiciouly like it is
> > part of ioucmd->flags, is actually ctx flags, so a little confusing. And we
> > need to be a litle careful here: the existing ioucmd->flags is used with uapi
> > flags.
> 
> Indeed. If this is getting crufty, series can just enable polling on
> no-payload requests. Reducing nvme handlers - for another day.

Well something needs to be done about multipath since it's broken today: if the
path changes between submission and poll, we'll consult the wrong queue for
polling enabled. This could cause a missed polling opprotunity, polling a
pointer that isn't a bio, or poll an irq enabled cq. All are bad.
