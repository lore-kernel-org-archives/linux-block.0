Return-Path: <SRS0=OuBg=6W=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E3A5C38A2A
	for <linux-block@archiver.kernel.org>; Fri,  8 May 2020 21:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78BD4218AC
	for <linux-block@archiver.kernel.org>; Fri,  8 May 2020 21:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kkxf6Z4Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgEHVJi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 May 2020 17:09:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36485 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727831AbgEHVJi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 May 2020 17:09:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588972177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ka2ojiff94GElb3NPeRaHeusoC7yZHWsNo9GvCA7fLU=;
        b=Kkxf6Z4QS4OGFBpEzxNjMtFWZuIU1w+pUpD5m3Rfy4DkqXfaGwqSJxrgMKjG511J543JKr
        PEq8260IA+LU/N+VzZho8ythLG3DkK5RkL8yYRsWwXJVw89G04r/0cxq+slQgpvo5r6qX8
        wdF9h3NyPS7JXIkbDRhmV2kxrBdLoFY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-L3t-0JcLMZKxMs6oLdCK8A-1; Fri, 08 May 2020 17:09:33 -0400
X-MC-Unique: L3t-0JcLMZKxMs6oLdCK8A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 848F2107ACCA;
        Fri,  8 May 2020 21:09:31 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 981B560BE1;
        Fri,  8 May 2020 21:09:27 +0000 (UTC)
Date:   Fri, 8 May 2020 17:09:26 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     kj@orbekk.com
Cc:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Alasdair G Kergon <agk@redhat.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "harshads@google.com" <harshads@google.com>,
        Khazhismel Kumykov <khazhy@google.com>
Subject: Re: dm: track io errors per mapped device
Message-ID: <20200508210926.GB19773@redhat.com>
References: <20200507230532.5733-1-kj@orbekk.com>
 <DM6PR04MB49726E28257263F5A1C643B386A20@DM6PR04MB4972.namprd04.prod.outlook.com>
 <dd7b8b91-776b-4458-a83a-18ab4953d2f4@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd7b8b91-776b-4458-a83a-18ab4953d2f4@www.fastmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 08 2020 at  3:22pm -0400,
kj@orbekk.com <kj@orbekk.com> wrote:

> On Thu, May 7, 2020, at 21:12, Chaitanya Kulkarni wrote:
> > On 05/07/2020 04:06 PM, Kjetil Orbekk wrote:
> > > +		if (tio->error)
> > > +			atomic_inc(&md->ioerr_cnt);
> > 
> > Given that there are so many errors how would user know what
> > kind of error is generated and how many times?
> 
> The intended use case is to provide an easy way to check if errors
> have occurred at all, and then the user needs to investigate using
> other means. I replied with more detail to Alasdair's email.

But most operations initiated by the user that fail will be felt by the
upper layer that the user is interfacing with.

Only exception that springs to mind is dm-writecache's writeback that
occurs after writes have already been acknowledged back to the upper
layers -- in that case dm-writecache provides an error flag that is
exposed via writecache_status.

Anyway, just not seeing why you need a upper-layer use-case agnostic
flag to know an error occurred in DM.  That layers that interface with
the DM device will have been notified of all errors.

And why just for DM devices?  Why not all block devices (in which case
DM would get this feature "for free")?

Mike

