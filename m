Return-Path: <SRS0=X6jZ=2B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E76C43603
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 13:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8C6A214D8
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 13:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="gXCCmURF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729511AbfLKNzp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Dec 2019 08:55:45 -0500
Received: from esa2.hc3370-68.iphmx.com ([216.71.145.153]:34948 "EHLO
        esa2.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbfLKNzp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Dec 2019 08:55:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1576072544;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=m6R/VVoQ+gbtGku3qSSn8lR/7efTsyljc6KkleafnFc=;
  b=gXCCmURFNgUXUl1t8lYwEKOMJy03AqyqJ+JUkD3gekgjB45+1eom6T26
   SsRw5Q+PIb5Ect47BgTH0Ye/Tp6V4OpRcKO89TPsvpvqWq6Kpt0IOov08
   XBhF9KJ3/IpjpF336b0J9PNmWF2vx+3SySf56Vc8e5M+s4T9K1ZjT5TH3
   c=;
Authentication-Results: esa2.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none; spf=None smtp.pra=roger.pau@citrix.com; spf=Pass smtp.mailfrom=roger.pau@citrix.com; spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa2.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  roger.pau@citrix.com) identity=pra; client-ip=162.221.158.21;
  receiver=esa2.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="roger.pau@citrix.com";
  x-conformance=sidf_compatible
Received-SPF: Pass (esa2.hc3370-68.iphmx.com: domain of
  roger.pau@citrix.com designates 162.221.158.21 as permitted
  sender) identity=mailfrom; client-ip=162.221.158.21;
  receiver=esa2.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="roger.pau@citrix.com";
  x-conformance=sidf_compatible; x-record-type="v=spf1";
  x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
  ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
  ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
  ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
  ip4:168.245.78.127 ~all"
Received-SPF: None (esa2.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@mail.citrix.com) identity=helo;
  client-ip=162.221.158.21; receiver=esa2.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="postmaster@mail.citrix.com";
  x-conformance=sidf_compatible
IronPort-SDR: Re26XLu4wVkXUyQDl8HBVkOhLeyFLmQmgQTYX/F9xkWTCyCe72gIZikKm6tF3tt6LGPzXB7BMB
 OZrpVZVwrxPp+9dIKp8TmrhWU15IKf+Rxd8GXKNkzkbmmCaTtwW02zr+1AlI7hpua044e9Fk3J
 K0YNEqd4y/MEPLJgiCtuz501SpJJQm2a5pEorJKjlJJFmJs0CHTGcyq7C5/ig0Ie0XfWATCVpJ
 vy/KvmibcHM5BzacenYFyom3Vv5LKDcRs02GwOHtVkttOwWEUp5BuchIQTaYAmxDTT1B/X9YMH
 eaY=
X-SBRS: 2.7
X-MesageID: 9529409
X-Ironport-Server: esa2.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.69,301,1571716800"; 
   d="scan'208";a="9529409"
Date:   Wed, 11 Dec 2019 14:55:23 +0100
From:   Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
To:     "Durrant, Paul" <pdurrant@amazon.com>,
        Juergen Gross <jgross@suse.com>
CC:     "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] xen-blkback: prevent premature module unload
Message-ID: <20191211135523.GP980@Air-de-Roger>
References: <20191210145305.6605-1-pdurrant@amazon.com>
 <20191211112754.GM980@Air-de-Roger>
 <14a01d62046c48ee9b2486917370b5f5@EX13D32EUC003.ant.amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <14a01d62046c48ee9b2486917370b5f5@EX13D32EUC003.ant.amazon.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL03.citrite.net (10.69.22.127)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 11, 2019 at 01:27:42PM +0000, Durrant, Paul wrote:
> > -----Original Message-----
> > From: Roger Pau Monné <roger.pau@citrix.com>
> > Sent: 11 December 2019 11:29
> > To: Durrant, Paul <pdurrant@amazon.com>
> > Cc: xen-devel@lists.xenproject.org; linux-block@vger.kernel.org; linux-
> > kernel@vger.kernel.org; Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>;
> > Jens Axboe <axboe@kernel.dk>
> > Subject: Re: [PATCH] xen-blkback: prevent premature module unload
> > 
> > On Tue, Dec 10, 2019 at 02:53:05PM +0000, Paul Durrant wrote:
> > > Objects allocated by xen_blkif_alloc come from the 'blkif_cache' kmem
> > > cache. This cache is destoyed when xen-blkif is unloaded so it is
> > > necessary to wait for the deferred free routine used for such objects to
> > > complete. This necessity was missed in commit 14855954f636 "xen-blkback:
> > > allow module to be cleanly unloaded". This patch fixes the problem by
> > > taking/releasing extra module references in xen_blkif_alloc/free()
> > > respectively.
> > >
> > > Signed-off-by: Paul Durrant <pdurrant@amazon.com>
> > 
> > Reviewed-by: Roger Pau Monné <roger.pau@citrix.com>
> > 
> > One nit below.
> > 
> > > ---
> > > Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> > > Cc: "Roger Pau Monné" <roger.pau@citrix.com>
> > > Cc: Jens Axboe <axboe@kernel.dk>
> > > ---
> > >  drivers/block/xen-blkback/xenbus.c | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > >
> > > diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-
> > blkback/xenbus.c
> > > index e8c5c54e1d26..59d576d27ca7 100644
> > > --- a/drivers/block/xen-blkback/xenbus.c
> > > +++ b/drivers/block/xen-blkback/xenbus.c
> > > @@ -171,6 +171,15 @@ static struct xen_blkif *xen_blkif_alloc(domid_t
> > domid)
> > >  	blkif->domid = domid;
> > >  	atomic_set(&blkif->refcnt, 1);
> > >  	init_completion(&blkif->drain_complete);
> > > +
> > > +	/*
> > > +	 * Because freeing back to the cache may be deferred, it is not
> > > +	 * safe to unload the module (and hence destroy the cache) until
> > > +	 * this has completed. To prevent premature unloading, take an
> > > +	 * extra module reference here and release only when the object
> > > +	 * has been free back to the cache.
> >                     ^ freed
> 
> Oh yes. Can this be done on commit, or would you like me to send a v2?

Adjusting on commit would be fine for me, but it's up to Juergen since
he is the one that will pick this up. IIRC the module unload patches
didn't go through the block subsystem.

Thanks, Roger.
