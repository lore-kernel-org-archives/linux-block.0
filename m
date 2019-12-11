Return-Path: <SRS0=X6jZ=2B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1E3C43603
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 10:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94199206A5
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 10:51:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="EV/+ve2G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbfLKKvV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Dec 2019 05:51:21 -0500
Received: from esa6.hc3370-68.iphmx.com ([216.71.155.175]:10417 "EHLO
        esa6.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbfLKKvU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Dec 2019 05:51:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1576061480;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=J+PK3N2DJUzzO10QyyTksvnTB34xRI+UojvMhxm4WZ0=;
  b=EV/+ve2G/8QJeYLA7LaomTwiOj0IYAtOGAIBKGFg071X5xbVUgYBmx65
   shKvnZN+iup4/W8j7uTjraGKQJehgzifHUL6c7yisjlto71lW160pWKvI
   ExPZfqrvgrj63CzcCZG28I4DFpfQB6l3hGPiBcyUHezj44ZcoWIDXTvIG
   A=;
Authentication-Results: esa6.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none; spf=None smtp.pra=roger.pau@citrix.com; spf=Pass smtp.mailfrom=roger.pau@citrix.com; spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa6.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  roger.pau@citrix.com) identity=pra; client-ip=162.221.158.21;
  receiver=esa6.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="roger.pau@citrix.com";
  x-conformance=sidf_compatible
Received-SPF: Pass (esa6.hc3370-68.iphmx.com: domain of
  roger.pau@citrix.com designates 162.221.158.21 as permitted
  sender) identity=mailfrom; client-ip=162.221.158.21;
  receiver=esa6.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="roger.pau@citrix.com";
  x-conformance=sidf_compatible; x-record-type="v=spf1";
  x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
  ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
  ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
  ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
  ip4:168.245.78.127 ~all"
Received-SPF: None (esa6.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@mail.citrix.com) identity=helo;
  client-ip=162.221.158.21; receiver=esa6.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="postmaster@mail.citrix.com";
  x-conformance=sidf_compatible
IronPort-SDR: UaTPJrU6Egt4MzstMZP2BNtNuKuboOoXdnOUwOxPyxOAurYNp5lQ953Z2Mu2RNKwSKe73nbzFX
 lmMrDjwxQ39Fpbotfj0c5eI/3u7Z15FTP0oJIu6fNh/T7r/IExQqEBAn/Y1QBC8k9Cn71eqjfu
 6YfqGztP9OeKbVnz+E3HbbZwXhwW64CuY5eujohC6K69HYCCe7EdPaQx0A0Q9xMInzohlyKGuD
 d4R+vLHwYGZbKR76cXYf3UFbIKZvb2u/q5EM4F4s23eBIRej4lYIjTk3c2euOUYeo1TFPs+q3D
 0eU=
X-SBRS: 2.7
X-MesageID: 9925700
X-Ironport-Server: esa6.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.69,301,1571716800"; 
   d="scan'208";a="9925700"
Date:   Wed, 11 Dec 2019 11:51:12 +0100
From:   Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
To:     SeongJae Park <sj38.park@gmail.com>
CC:     <sjpark@amazon.com>, <axboe@kernel.dk>, <konrad.wilk@oracle.com>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <pdurrant@amazon.com>, <xen-devel@lists.xenproject.org>,
        SeongJae Park <sjpark@amazon.de>
Subject: Re: Re: [PATCH v5 1/2] xenbus/backend: Add memory pressure handler
 callback
Message-ID: <20191211105112.GK980@Air-de-Roger>
References: <20191210101635.GD980@Air-de-Roger>
 <20191211035058.11479-1-sj38.park@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191211035058.11479-1-sj38.park@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL03.citrite.net (10.69.22.127)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 11, 2019 at 04:50:58AM +0100, SeongJae Park wrote:
> On Tue, 10 Dec 2019 11:16:35 +0100 "Roger Pau Monné" <roger.pau@citrix.com> wrote:
> > > diff --git a/include/xen/xenbus.h b/include/xen/xenbus.h
> > > index 869c816d5f8c..cdb075e4182f 100644
> > > --- a/include/xen/xenbus.h
> > > +++ b/include/xen/xenbus.h
> > > @@ -104,6 +104,7 @@ struct xenbus_driver {
> > >  	struct device_driver driver;
> > >  	int (*read_otherend_details)(struct xenbus_device *dev);
> > >  	int (*is_ready)(struct xenbus_device *dev);
> > > +	unsigned (*reclaim)(struct xenbus_device *dev);
> > 
> > ... hence I wonder why it's returning an unsigned when it's just
> > ignored.
> > 
> > IMO it should return an int to signal errors, and the return should be
> > ignored.
> 
> I first thought similarly and set the callback to return something.  However,
> as this callback is called to simply notify the memory pressure and ask the
> driver to free its memory as many as possible, I couldn't easily imagine what
> kind of errors that need to be handled by its caller can occur in the callback,
> especially because current blkback's callback implementation has no such error.
> So, if you and others agree, I would like to simply set the return type to
> 'void' for now and defer the error handling to a future change.

Yes, I also wondered the same, but seeing you returned an integer I
assumed there was interest in returning some kind of value. If there's
nothing to return let's just make it void.

> > 
> > Also, I think it would preferable for this function to take an extra
> > parameter to describe the resource the driver should attempt to free
> > (ie: memory or interrupts for example). I'm however not able to find
> > any existing Linux type to describe such resources.
> 
> Yes, such extention would be the right direction.  However, because there is no
> existing Linux type to describe the type of resources to reclaim as you also
> mentioned, there could be many different opinions about its implementation
> detail.  In my opinion, it could be also possible to simply add another
> callback for another resource type.  That said, because currently we have an
> use case and an implementation for the memory pressure only, I would like to
> let it as is for now and defer the extension as a future work, if you and
> others have no objection.

Ack, can I please ask the callback to be named reclaim_memory or some
such then?

Thanks, Roger.
