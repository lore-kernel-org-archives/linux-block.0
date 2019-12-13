Return-Path: <SRS0=J0ZO=2D=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E87C2D0BF
	for <linux-block@archiver.kernel.org>; Fri, 13 Dec 2019 09:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 429B02465B
	for <linux-block@archiver.kernel.org>; Fri, 13 Dec 2019 09:27:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="T0u2UpOs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfLMJ1v (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Dec 2019 04:27:51 -0500
Received: from esa2.hc3370-68.iphmx.com ([216.71.145.153]:31428 "EHLO
        esa2.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbfLMJ1u (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Dec 2019 04:27:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1576229270;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=f+X38mKQSNA9F1owN4qTfTPlaJCpeqkXKbc60h1txgQ=;
  b=T0u2UpOsUku1+QCS++Ob9qG0Jh+4fOKSunJyjUVIKR4pneK1xOTsgUD/
   ZDlMwwSQv2Nbfh6kQSyQgeS766qNKfa3AcLgaGGwNY3OgDg7CKV5QI2F2
   g5yQWQgYWNpGF+wBU2g1Kx8GkBpdJ4wAtPeiW+2ZXDsOHXCmcVGSpTxEc
   o=;
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
IronPort-SDR: mRR8mxiHNJiuEO4mhyjRrklq/JYbq60/KLbQGZxNas5+v41gcVCNPwnUWSx37kMe6XxeDxBJLB
 +b7DZQS14dbbgTZga8rDngFmMC3FmOFUSjo8Ceeq4m19Ciu0oKXgOpcmhdbWv5QIPvE4PL7up2
 xfuJRI0M3Wc8+Zg8T++qnNXev8hurdbeOQZhIn/Ex9zNkhnu8Ii05q0sCf6YgJXCVuhi7iUqGv
 Rd+j9O/c1P0YhRlJtMJGzgEuDaGNwhmdOzK+F4eT//M2Zu8t0Q2PsbB32PtRZ8N2n5WnULvX7/
 1Iw=
X-SBRS: 2.7
X-MesageID: 9639731
X-Ironport-Server: esa2.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.69,309,1571716800"; 
   d="scan'208";a="9639731"
Date:   Fri, 13 Dec 2019 10:27:42 +0100
From:   Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
To:     SeongJae Park <sj38.park@gmail.com>
CC:     <jgross@suse.com>, <axboe@kernel.dk>, <sjpark@amazon.com>,
        <konrad.wilk@oracle.com>, <pdurrant@amazon.com>,
        SeongJae Park <sjpark@amazon.de>,
        <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <xen-devel@lists.xenproject.org>
Subject: Re: Re: [Xen-devel] [PATCH v7 2/3] xen/blkback: Squeeze page pools
 if a memory pressure is detected
Message-ID: <20191213092742.GG11756@Air-de-Roger>
References: <20191212152757.GF11756@Air-de-Roger>
 <20191212160658.10466-1-sj38.park@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191212160658.10466-1-sj38.park@gmail.com>
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL03.citrite.net (10.69.22.127)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Dec 12, 2019 at 05:06:58PM +0100, SeongJae Park wrote:
> On Thu, 12 Dec 2019 16:27:57 +0100 "Roger Pau Monné" <roger.pau@citrix.com> wrote:
> 
> > > diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
> > > index fd1e19f1a49f..98823d150905 100644
> > > --- a/drivers/block/xen-blkback/blkback.c
> > > +++ b/drivers/block/xen-blkback/blkback.c
> > > @@ -142,6 +142,21 @@ static inline bool persistent_gnt_timeout(struct persistent_gnt *persistent_gnt)
> > >  		HZ * xen_blkif_pgrant_timeout);
> > >  }
> > >  
> > > +/* Once a memory pressure is detected, squeeze free page pools for a while. */
> > > +static unsigned int buffer_squeeze_duration_ms = 10;
> > > +module_param_named(buffer_squeeze_duration_ms,
> > > +		buffer_squeeze_duration_ms, int, 0644);
> > > +MODULE_PARM_DESC(buffer_squeeze_duration_ms,
> > > +"Duration in ms to squeeze pages buffer when a memory pressure is detected");
> > > +
> > > +static unsigned long buffer_squeeze_end;
> > > +
> > > +void xen_blkbk_reclaim_memory(struct xenbus_device *dev)
> > > +{
> > > +	buffer_squeeze_end = jiffies +
> > > +		msecs_to_jiffies(buffer_squeeze_duration_ms);
> > 
> > I'm not sure this is fully correct. This function will be called for
> > each blkback instance, but the timeout is stored in a global variable
> > that's shared between all blkback instances. Shouldn't this timeout be
> > stored in xen_blkif so each instance has it's own local variable?
> > 
> > Or else in the case you have 1k blkback instances the timeout is
> > certainly going to be longer than expected, because each call to
> > xen_blkbk_reclaim_memory will move it forward.
> 
> Agreed that.  I think the extended timeout would not make a visible
> performance, though, because the time that 1k-loop take would be short enough
> to be ignored compared to the millisecond-scope duration.
> 
> I took this way because I wanted to minimize such structural changes as far as
> I can, as this is just a point-fix rather than ultimate solution.  That said,
> it is not fully correct and very confusing.  My another colleague also pointed
> out it in internal review.  Correct solution would be to adding a variable in
> the struct as you suggested or avoiding duplicated update of the variable by
> initializing the variable once the squeezing duration passes.  I would prefer
> the later way, as it is more straightforward and still not introducing
> structural change.  For example, it might be like below:
> 
> diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
> index f41c698dd854..6856c8ef88de 100644
> --- a/drivers/block/xen-blkback/blkback.c
> +++ b/drivers/block/xen-blkback/blkback.c
> @@ -152,8 +152,9 @@ static unsigned long buffer_squeeze_end;
>  
>  void xen_blkbk_reclaim_memory(struct xenbus_device *dev)
>  {
> -       buffer_squeeze_end = jiffies +
> -               msecs_to_jiffies(buffer_squeeze_duration_ms);
> +       if (!buffer_squeeze_end)
> +               buffer_squeeze_end = jiffies +
> +                       msecs_to_jiffies(buffer_squeeze_duration_ms);
>  }
>  
>  static inline int get_free_page(struct xen_blkif_ring *ring, struct page **page)
> @@ -669,10 +670,13 @@ int xen_blkif_schedule(void *arg)
>                 }
>  
>                 /* Shrink the free pages pool if it is too large. */
> -               if (time_before(jiffies, buffer_squeeze_end))
> +               if (time_before(jiffies, buffer_squeeze_end)) {
>                         shrink_free_pagepool(ring, 0);
> -               else
> +               } else {
> +                       if (unlikely(buffer_squeeze_end))
> +                               buffer_squeeze_end = 0;
>                         shrink_free_pagepool(ring, max_buffer_pages);
> +               }
>  
>                 if (log_stats && time_after(jiffies, ring->st_print))
>                         print_stats(ring);
> 
> May I ask you what way would you prefer?

I'm not particularly found of this approach, as I think it's racy. Ie:
you would have to add some kind of lock to make sure the contents of
buffer_squeeze_end stay unmodified during the read and set cycle, or
else xen_blkif_schedule will race with xen_blkbk_reclaim_memory.

This is likely not a big deal ATM since the code will work as
expected in most cases AFAICT, but I would still prefer to have a
per-instance buffer_squeeze_end added to xen_blkif, given that the
callback is per-instance. I wouldn't call it a structural change, it's
just adding a variable to a struct instead of having a shared one, but
the code is almost the same as the current version.

Thanks, Roger.
