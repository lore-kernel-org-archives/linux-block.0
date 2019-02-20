Return-Path: <SRS0=4lGM=Q3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AAB6C43381
	for <linux-block@archiver.kernel.org>; Wed, 20 Feb 2019 17:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E09C42083E
	for <linux-block@archiver.kernel.org>; Wed, 20 Feb 2019 17:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QY4bhRsY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbfBTRTI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Feb 2019 12:19:08 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40628 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfBTRTI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Feb 2019 12:19:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bC6pS3j8UW8GudgjKyKfkdkz6KXDOgyObG2XTOWM/OQ=; b=QY4bhRsYDzRNTOM1qq9a4tMnb
        z+0X098AK3YnufVjQMCwey7R6j1W+CTt3824QpW6LaHOEpwzZJ8Ob973TkZqMoi7yqTFk1HE/OseQ
        XWIYmYs587b+iiDGR0AdgED+b0YkGoZ+lbjStxohN233IpOAna2ILerpnjrpf9T8gHPhfjM2DCIHG
        b+2iZACa3SWhmjX45MlhaBpYThg+WsbaQ3q96O97PqXzxaDJOGxdOtxeMSDybxRhPjqOO1oovGqhZ
        yke4Cxr9odjig2+9nqu3ZdXfOc5cTsgOfsNhXWsFtSx5vvOa3tEVEc5GV9jlVvUnnumBWC1eeni2f
        rDHaAHkBQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gwVWT-0007Wd-95; Wed, 20 Feb 2019 17:19:05 +0000
Date:   Wed, 20 Feb 2019 09:19:05 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Keith Busch <keith.busch@intel.com>
Cc:     William Kucharski <william.kucharski@oracle.com>,
        lsf-pc@lists.linux-foundation.org, Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Subject: Re: Read-only Mapping of Program Text using Large THP Pages
Message-ID: <20190220171905.GJ12668@bombadil.infradead.org>
References: <379F21DD-006F-4E33-9BD5-F81F9BA75C10@oracle.com>
 <20190220134454.GF12668@bombadil.infradead.org>
 <07B3B085-C844-4A13-96B1-3DB0F1AF26F5@oracle.com>
 <20190220144345.GG12668@bombadil.infradead.org>
 <20190220163921.GA4451@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220163921.GA4451@localhost.localdomain>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 20, 2019 at 09:39:22AM -0700, Keith Busch wrote:
> On Wed, Feb 20, 2019 at 06:43:46AM -0800, Matthew Wilcox wrote:
> > What NVMe doesn't have is a way for the host to tell the controller
> > "Here's a 2MB sized I/O; bytes 40960 to 45056 are most important to
> > me; please give me a completion event once those bytes are valid and
> > then another completion event once the entire I/O is finished".
> > 
> > I have no idea if hardware designers would be interested in adding that
> > kind of complexity, but this is why we also have I/O people at the same
> > meeting, so we can get these kinds of whole-stack discussions going.
> 
> We have two unused PRP bits, so I guess there's room to define something
> like a "me first" flag. I am skeptical we'd get committee approval for
> that or partial completion events, though.
> 
> I think the host should just split the more important part of the transfer
> into a separate command. The only hardware support we have to prioritize
> that command ahead of others is with weighted priority queues, but we're
> missing driver support for that at the moment.

Yes, on reflection, NVMe is probably an example where we'd want to send
three commands (one for the critical page, one for the part before and one
for the part after); it has low per-command overhead so it should be fine.

Thinking about William's example of a 1GB page, with a x4 link running
at 8Gbps, a 1GB transfer would take approximately a quarter of a second.
If we do end up wanting to support 1GB pages, I think we'll want that
low-priority queue support ... and to qualify drives which actually have
the ability to handle multiple commands in parallel.
