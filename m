Return-Path: <SRS0=G4H8=2H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC3DC43603
	for <linux-block@archiver.kernel.org>; Tue, 17 Dec 2019 11:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 238512064B
	for <linux-block@archiver.kernel.org>; Tue, 17 Dec 2019 11:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="MO5Uy8yp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbfLQLjc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Dec 2019 06:39:32 -0500
Received: from esa2.hc3370-68.iphmx.com ([216.71.145.153]:40876 "EHLO
        esa2.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfLQLjc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Dec 2019 06:39:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1576582772;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=DrETHrqzGMzEL4BEkIo0gX1VPtHC9KB35ii7Mt8tG0k=;
  b=MO5Uy8ypo3E9w4KIkWkDKD1aprfsSYECYeOuH4Zi43b9tHpJKSxGxBXA
   iIVi5QqnGKpKyiHmyuJq8Bv6EngYcmyW/bOTniB8Ax/Oe1zJ4f6z/yxue
   pJM3j1+HoYNvYU3wS7jzoWN6J2DacLsR1dxllfKppDSxjtLH0c9MCyGAP
   k=;
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
IronPort-SDR: Z/ZGRfUadPPOQQqodAIwIuWjXR4ihVrif6lFloAqm0obWVZYFdqOomu6rManPicIAeLcGX192k
 AmHWxSx74okB6fy/ym0Ky82Y/EUFaOjoGqw1jD5d2rsRmK59xCdt0JO8BpUbnnTkzGpmEzTnlr
 w7Svsm9tvNzGHxthFEpCCOZaKj96vsjjhuhe1mZIefdpZK+tyg6+z4CC3OEZOYC4D7kR6Nwm9N
 Z8Ru/gXwtexwwVcUcpXgiVr6w9ORpAUTI+Xy/cEADmS8Cm6BJ4pzmjHmQZQMj1xxnFPHZLIMgp
 hkQ=
X-SBRS: 2.7
X-MesageID: 9807525
X-Ironport-Server: esa2.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.69,325,1571716800"; 
   d="scan'208";a="9807525"
Date:   Tue, 17 Dec 2019 12:39:15 +0100
From:   Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
To:     SeongJae Park <sj38.park@gmail.com>
CC:     <jgross@suse.com>, <axboe@kernel.dk>, <konrad.wilk@oracle.com>,
        <linux-block@vger.kernel.org>, <xen-devel@lists.xenproject.org>,
        <pdurrant@amazon.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Re: [Xen-devel] [PATCH v10 2/4] xen/blkback: Squeeze page pools
 if a memory pressure is detected
Message-ID: <20191217113915.GS11756@Air-de-Roger>
References: <2ad62cc8-ae78-6087-f277-923dc076383a@suse.com>
 <20191216194803.6294-1-sj38.park@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191216194803.6294-1-sj38.park@gmail.com>
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL03.citrite.net (10.69.22.127)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Dec 16, 2019 at 08:48:03PM +0100, SeongJae Park wrote:
> On on, 16 Dec 2019 17:23:44 +0100, Jürgen Groß wrote:
> 
> > On 16.12.19 17:15, SeongJae Park wrote:
> > > On Mon, 16 Dec 2019 15:37:20 +0100 SeongJae Park <sjpark@amazon.com> wrote:
> > > 
> > >> On Mon, 16 Dec 2019 13:45:25 +0100 SeongJae Park <sjpark@amazon.com> wrote:
> > >>
> > >>> From: SeongJae Park <sjpark@amazon.de>
> > >>>
> > > [...]
> > >>> --- a/drivers/block/xen-blkback/xenbus.c
> > >>> +++ b/drivers/block/xen-blkback/xenbus.c
> > >>> @@ -824,6 +824,24 @@ static void frontend_changed(struct xenbus_device *dev,
> > >>>   }
> > >>>   
> > >>>   
> > >>> +/* Once a memory pressure is detected, squeeze free page pools for a while. */
> > >>> +static unsigned int buffer_squeeze_duration_ms = 10;
> > >>> +module_param_named(buffer_squeeze_duration_ms,
> > >>> +		buffer_squeeze_duration_ms, int, 0644);
> > >>> +MODULE_PARM_DESC(buffer_squeeze_duration_ms,
> > >>> +"Duration in ms to squeeze pages buffer when a memory pressure is detected");
> > >>> +
> > >>> +/*
> > >>> + * Callback received when the memory pressure is detected.
> > >>> + */
> > >>> +static void reclaim_memory(struct xenbus_device *dev)
> > >>> +{
> > >>> +	struct backend_info *be = dev_get_drvdata(&dev->dev);
> > >>> +
> > >>> +	be->blkif->buffer_squeeze_end = jiffies +
> > >>> +		msecs_to_jiffies(buffer_squeeze_duration_ms);
> > >>
> > >> This callback might race with 'xen_blkbk_probe()'.  The race could result in
> > >> __NULL dereferencing__, as 'xen_blkbk_probe()' sets '->blkif' after it links
> > >> 'be' to the 'dev'.  Please _don't merge_ this patch now!
> > >>
> > >> I will do more test and share results.  Meanwhile, if you have any opinion,
> > >> please let me know.
> 
> I reduced system memory and attached bunch of devices in short time so that
> memory pressure occurs while device attachments are ongoing.  Under this
> circumstance, I was able to see the race.
> 
> > > 
> > > Not only '->blkif', but 'be' itself also coule be a NULL.  As similar
> > > concurrency issues could be in other drivers in their way, I suggest to change
> > > the reclaim callback ('->reclaim_memory') to be called for each driver instead
> > > of each device.  Then, each driver could be able to deal with its concurrency
> > > issues by itself.
> > 
> > Hmm, I don't like that. This would need to be changed back in case we
> > add per-guest quota.
> 
> Extending this callback in that way would be still not too hard.  We could use
> the argument to the callback.  I would keep the argument of the callback to
> 'struct device *' as is, and will add a comment saying 'NULL' value of the
> argument means every devices.  As an example, xenbus would pass NULL-ending
> array of the device pointers that need to free its resources.
> 
> After seeing this race, I am now also thinking it could be better to delegate
> detailed control of each device to its driver, as some drivers have some
> complicated and unique relation with its devices.
> 
> > 
> > Wouldn't a get_device() before calling the callback and a put_device()
> > afterwards avoid that problem?
> 
> I didn't used the reference count manipulation operations because other similar
> parts also didn't.  But, if there is no implicit reference count guarantee, it
> seems those operations are indeed necessary.
> 
> That said, as get/put operations only adjust the reference count, those will
> not make the callback to wait until the linking of the 'backend' and 'blkif' to
> the device (xen_blkbk_probe()) is finished.  Thus, the race could still happen.
> Or, am I missing something?

I would expect the device is not added to the list of backend devices
until the probe hook has finished with a non-error return code. Ie:
bus_for_each_dev should _not_ iterate over devices for which the probe
function hasn't been run to competition without errors.

The same way I would expect the remove hook to first remove the device
from the list of backend devices and then run the remove hook.

blkback uses an ad-hoc reference counting mechanism, but if the above
assumptions are true I think it would be enough to take an extra
reference in xen_blkbk_probe and drop it in xen_blkbk_remove.

Additionally it might be interesting to switch the ad-hoc reference
counting to use get_device/put_device (in a separate patch), but I'm
not sure how feasible that is.

Roger.
