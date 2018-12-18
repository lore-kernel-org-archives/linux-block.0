Return-Path: <SRS0=v1Da=O3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E87C43387
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 15:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA344218A2
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 15:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbeLRPRo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Dec 2018 10:17:44 -0500
Received: from smtp.ctxuk.citrix.com ([185.25.65.24]:35891 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbeLRPRo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Dec 2018 10:17:44 -0500
X-IronPort-AV: E=Sophos;i="5.56,368,1539648000"; 
   d="scan'208";a="83498840"
Date:   Tue, 18 Dec 2018 16:13:31 +0100
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Dongli Zhang <dongli.zhang@oracle.com>
CC:     <axboe@kernel.dk>, <konrad.wilk@oracle.com>,
        <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <paul.durrant@citrix.com>, <xen-devel@lists.xenproject.org>
Subject: Re: [Xen-devel] [PATCH v2 1/1] xen/blkback: rework connect_ring() to
 avoid inconsistent xenstore 'ring-page-order' set by malicious blkfront
Message-ID: <20181218151331.iwkq3roqwigf3e2r@mac>
References: <1545094538-31426-1-git-send-email-dongli.zhang@oracle.com>
 <20181218093300.qfslnloxooqnu2im@mac>
 <51ea8086-e5fd-b1db-f935-101160ca9359@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <51ea8086-e5fd-b1db-f935-101160ca9359@oracle.com>
User-Agent: NeoMutt/20180716
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL01.citrite.net (10.69.22.125)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 18, 2018 at 07:31:59PM +0800, Dongli Zhang wrote:
> Hi Roger,
> 
> On 12/18/2018 05:33 PM, Roger Pau Monné wrote:
> > On Tue, Dec 18, 2018 at 08:55:38AM +0800, Dongli Zhang wrote:
> >> The xenstore 'ring-page-order' is used globally for each blkback queue and
> >> therefore should be read from xenstore only once. However, it is obtained
> >> in read_per_ring_refs() which might be called multiple times during the
> >> initialization of each blkback queue.
> >>
> >> If the blkfront is malicious and the 'ring-page-order' is set in different
> >> value by blkfront every time before blkback reads it, this may end up at
> >> the "WARN_ON(i != (XEN_BLKIF_REQS_PER_PAGE * blkif->nr_ring_pages));" in
> >> xen_blkif_disconnect() when frontend is destroyed.
> >>
> >> This patch reworks connect_ring() to read xenstore 'ring-page-order' only
> >> once.
> >>
> >> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> >> ---
> >> Changed since v1:
> >>   * change the order of xenstore read in read_per_ring_refs(suggested by Roger Pau Monne)
> >>   * use xenbus_read_unsigned() in connect_ring() (suggested by Roger Pau Monne)
> >>
> >>  drivers/block/xen-blkback/xenbus.c | 70 ++++++++++++++++++++++----------------
> >>  1 file changed, 40 insertions(+), 30 deletions(-)
> >>
> >> diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
> >> index a4bc74e..7178f0f 100644
> >> --- a/drivers/block/xen-blkback/xenbus.c
> >> +++ b/drivers/block/xen-blkback/xenbus.c
> >> @@ -926,7 +926,7 @@ static int read_per_ring_refs(struct xen_blkif_ring *ring, const char *dir)
> >>  	int err, i, j;
> >>  	struct xen_blkif *blkif = ring->blkif;
> >>  	struct xenbus_device *dev = blkif->be->dev;
> >> -	unsigned int ring_page_order, nr_grefs, evtchn;
> >> +	unsigned int nr_grefs, evtchn;
> >>  
> >>  	err = xenbus_scanf(XBT_NIL, dir, "event-channel", "%u",
> >>  			  &evtchn);
> >> @@ -936,43 +936,38 @@ static int read_per_ring_refs(struct xen_blkif_ring *ring, const char *dir)
> >>  		return err;
> >>  	}
> >>  
> >> -	err = xenbus_scanf(XBT_NIL, dev->otherend, "ring-page-order", "%u",
> >> -			  &ring_page_order);
> >> -	if (err != 1) {
> >> -		err = xenbus_scanf(XBT_NIL, dir, "ring-ref", "%u", &ring_ref[0]);
> >> -		if (err != 1) {
> >> +	nr_grefs = blkif->nr_ring_pages;
> >> +	WARN_ON(!nr_grefs);
> >> +
> >> +	for (i = 0; i < nr_grefs; i++) {
> >> +		char ring_ref_name[RINGREF_NAME_LEN];
> >> +
> >> +		snprintf(ring_ref_name, RINGREF_NAME_LEN, "ring-ref%u", i);
> >> +		err = xenbus_scanf(XBT_NIL, dir, ring_ref_name,
> >> +				   "%u", &ring_ref[i]);
> >> +
> >> +		if (err != 1 && (i || (!i && nr_grefs > 1))) {
> > 
> > AFAICT the above condition can be simplified as "err != 1 &&
> > nr_grefs".
> > 
> >>  			err = -EINVAL;
> > 
> > There's no point in setting err here...
> > 
> >> -			xenbus_dev_fatal(dev, err, "reading %s/ring-ref", dir);
> >> +			xenbus_dev_fatal(dev, err, "reading %s/%s",
> >> +					 dir, ring_ref_name);
> >>  			return err;
> > 
> > ...since you can just return -EINVAL (same applies to the other
> > instance below).
> 
> I would like to confirm if I would keep the err = -EINVAL in below because most
> of the below code is copied from original implementation without modification.
> 
> There is no err set by xenbus_read_unsigned().

Right, but instead of doing:

err = -EINVAL;
return err;

You can just do:

return -EINVAL;

Which is one line shorter :).

> +       ring_page_order = xenbus_read_unsigned(dev->otherend,
> +                                              "ring-page-order", 0);
> +
> +       if (ring_page_order > xen_blkif_max_ring_order) {
> +               err = -EINVAL;
> +               xenbus_dev_fatal(dev, err,
> +                                "requested ring page order %d exceed max:%d",
> +                                ring_page_order,
> +                                xen_blkif_max_ring_order);
> +               return err;
> +       }
> +
> +       be->blkif->nr_ring_pages = 1 << ring_page_order;
> 
> 
> For the rest, I would do something like:
> 
> +               err = xenbus_scanf(XBT_NIL, dir, ring_ref_name,
> +                                  "%u", &ring_ref[i]);
> +
> +               if (err != 1 && nr_grefs > 1) {
> +                       xenbus_dev_fatal(dev, err, "reading %s/%s",
> +                                        dir, ring_ref_name);
> +                       return -EINVAL;
> +               }
> 
> 
> Thank you very much!

Thanks!
