Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 091F9C4332F
	for <linux-block@archiver.kernel.org>; Mon,  2 May 2022 16:22:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242050AbiEBQZj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 May 2022 12:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242427AbiEBQYp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 May 2022 12:24:45 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8AF1614A
        for <linux-block@vger.kernel.org>; Mon,  2 May 2022 09:21:16 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-e93ff05b23so14731311fac.9
        for <linux-block@vger.kernel.org>; Mon, 02 May 2022 09:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tmUOg+kFZu6V3os/XnKKe6b+2ICxNe8aNy9d0lUeH84=;
        b=w0ZAguUthWlHhD8qWa50Y2+6hFzqAt/DyB8nkCNrAFDKqjRI46Iz5i916Bh2X0nHI1
         /MZ1TOik7xkb6UfZBOXPN5Hv4+0R64lELQuG/76pb2lYD8ek1gJIE1VDRj5h0sfZAZ6x
         fwlo5IK4/3sd1ATVQ3ywXL7fafI7/C2vMbGb6EFGCJ18ORi0yGXxdib8Mtk6VPt6R/49
         7NHb08a7vChz4O1zCtx1Nxhk6zGmWJ8bq/TdHRaj1LWNMUeQigcwt9aW4LfQh+sofOt2
         ugHUlkqLgHzbmsegWbnuXy/XVKzz/1LDfdtKXP6D0egSvNULful9SzygHPxmWu9j9bo2
         x70Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tmUOg+kFZu6V3os/XnKKe6b+2ICxNe8aNy9d0lUeH84=;
        b=ig78iGlCVh8DVgngmPRbW/tDSH4c21dIpmG8cdYvQOmDjDpHN6+jp/ZimVMRmPaLsF
         1kpS+DzTgAytR5E3wFLPagfU86EeQcpC80yuvCh6neXHIkIXJxC54nf27OPRjqEtFQad
         3GqAPpQlzNTiXGeXYGCfJ+BVUaj2XIpEis/hWMB73Lcr3/qv8/e0T0+xY9zr4usBaN2R
         1XI1r2Kp1RPaeqLkr+CSuuvqw5udBHsjQcgK75fC4lhdRJUXio+3ZmFNphlGrBeGlx8O
         uZjSSm+Bt7mC7Z5QqrOSk5qh13fo3dZuy2K2JUkZyBNS+CCXNzv/z2cAQoYUhHNdAbvN
         6IDQ==
X-Gm-Message-State: AOAM5300i4F513CHRZK7Rw4f9PYjZt0Jtv2DiPqiUwQO9VpOjoe3S6J/
        awSewmU7FRr27phG1I+nw5PN8AA7daRJ4A==
X-Google-Smtp-Source: ABdhPJw0MmmX8gAVyhli8VM9R3UNReFuiK3wTTEUeX2P6ZrLLrW9b6q0A2efXbAa1DjmAwECIai4fA==
X-Received: by 2002:a05:6870:3381:b0:e9:7c30:ae12 with SMTP id w1-20020a056870338100b000e97c30ae12mr4938829oae.91.1651508475958;
        Mon, 02 May 2022 09:21:15 -0700 (PDT)
Received: from relinquished.localdomain ([8.34.116.185])
        by smtp.gmail.com with ESMTPSA id l2-20020a4ad9c2000000b0035eb4e5a6b7sm3981998oou.13.2022.05.02.09.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 09:21:15 -0700 (PDT)
Date:   Mon, 2 May 2022 09:21:13 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Omar Sandoval <osandov@fb.com>,
        Christian Brauner <christian.brauner@microsoft.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>
Subject: Re: [LSF TOPIC] block namespaces
Message-ID: <YnAE+WQnJNI079Xs@relinquished.localdomain>
References: <7dca874a-b8ef-59bf-a368-595d0ed2838f@suse.de>
 <YnACIcvUBH8/eKdC@relinquished.localdomain>
 <44814263-1546-a450-e799-5039aa991ca6@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44814263-1546-a450-e799-5039aa991ca6@suse.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 02, 2022 at 09:17:04AM -0700, Hannes Reinecke wrote:
> On 5/2/22 09:09, Omar Sandoval wrote:
> > On Mon, May 02, 2022 at 01:14:48AM +0200, Hannes Reinecke wrote:
> > > Hi Omar,
> > > 
> > > here's a late topic for the I/O Track: Block namespaces
> > > 
> > > We already proposed it for the (canceled) LSF last year, and now I found
> > > that Christian Brauner is actually present here at LSF.
> > > 
> > > What this is about: Similarly to network namespaces we'd like to explore the
> > > possibility of block namespaces.
> > > Canonical use-case here is iscsi sessions within containers: if one
> > > container starts up an iscsi session, why should this session be visible to
> > > the other containers?
> > > The discussion should be about general design and possible use-cases.
> > 
> > Hey, Hannes,
> > 
> > How much does this overlap with Chris Leech's "network storage
> > transports managed within a container" topic?
> 
> Hmm. Good question; I don't really know. But yeah, I guess there is some.
> So we could lump both of them together I think.

I added a slot for it right after Chris's topic. We can adapt based on
how much we cover in the first topic.
