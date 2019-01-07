Return-Path: <SRS0=Upb7=PP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CCDC43387
	for <linux-block@archiver.kernel.org>; Mon,  7 Jan 2019 15:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32A72206C0
	for <linux-block@archiver.kernel.org>; Mon,  7 Jan 2019 15:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbfAGP1w (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Jan 2019 10:27:52 -0500
Received: from smtp.eu.citrix.com ([185.25.65.24]:28403 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727418AbfAGP1w (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Jan 2019 10:27:52 -0500
X-IronPort-AV: E=Sophos;i="5.56,451,1539648000"; 
   d="scan'208";a="84232516"
Date:   Mon, 7 Jan 2019 16:27:08 +0100
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Dongli Zhang <dongli.zhang@oracle.com>
CC:     <Paul.Durrant@citrix.com>, <axboe@kernel.dk>,
        <konrad.wilk@oracle.com>, <linux-kernel@vger.kernel.org>,
        <linux-block@vger.kernel.org>, <xen-devel@lists.xenproject.org>
Subject: Re: [Xen-devel] [PATCH v4 2/2] xen/blkback: rework connect_ring() to
 avoid inconsistent xenstore 'ring-page-order' set by malicious blkfront
Message-ID: <20190107152708.z4mecdm2apfxz2rk@mac>
References: <1546839359-5478-1-git-send-email-dongli.zhang@oracle.com>
 <1546839359-5478-2-git-send-email-dongli.zhang@oracle.com>
 <20190107120107.euf7mrq7gk6bmibz@mac>
 <35c7d495-2d6c-5fec-abf8-c5aef55cf866@oracle.com>
 <56819579-def2-b045-f414-4de45188fe2e@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <56819579-def2-b045-f414-4de45188fe2e@oracle.com>
User-Agent: NeoMutt/20180716
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 07, 2019 at 10:07:34PM +0800, Dongli Zhang wrote:
> 
> 
> On 01/07/2019 10:05 PM, Dongli Zhang wrote:
> > 
> > 
> > On 01/07/2019 08:01 PM, Roger Pau Monné wrote:
> >> On Mon, Jan 07, 2019 at 01:35:59PM +0800, Dongli Zhang wrote:
> >>> The xenstore 'ring-page-order' is used globally for each blkback queue and
> >>> therefore should be read from xenstore only once. However, it is obtained
> >>> in read_per_ring_refs() which might be called multiple times during the
> >>> initialization of each blkback queue.
> >>>
> >>> If the blkfront is malicious and the 'ring-page-order' is set in different
> >>> value by blkfront every time before blkback reads it, this may end up at
> >>> the "WARN_ON(i != (XEN_BLKIF_REQS_PER_PAGE * blkif->nr_ring_pages));" in
> >>> xen_blkif_disconnect() when frontend is destroyed.
> >>>
> >>> This patch reworks connect_ring() to read xenstore 'ring-page-order' only
> >>> once.
> >>>
> >>> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> >>> ---
> >>> Changed since v1:
> >>>   * change the order of xenstore read in read_per_ring_refs
> >>>   * use xenbus_read_unsigned() in connect_ring()
> >>>
> >>> Changed since v2:
> >>>   * simplify the condition check as "(err != 1 && nr_grefs > 1)"
> >>>   * avoid setting err as -EINVAL to remove extra one line of code
> >>>
> >>> Changed since v3:
> >>>   * exit at the beginning if !nr_grefs
> >>>   * change the if statements to avoid test (err != 1) twice
> >>>   * initialize a 'blkif' stack variable (refer to PATCH 1/2)
> >>>
> >>>  drivers/block/xen-blkback/xenbus.c | 76 +++++++++++++++++++++-----------------
> >>>  1 file changed, 43 insertions(+), 33 deletions(-)
> >>>
> >>> diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
> >>> index a4aadac..a2acbc9 100644
> >>> --- a/drivers/block/xen-blkback/xenbus.c
> >>> +++ b/drivers/block/xen-blkback/xenbus.c
> >>> @@ -926,7 +926,7 @@ static int read_per_ring_refs(struct xen_blkif_ring *ring, const char *dir)
> >>>  	int err, i, j;
> >>>  	struct xen_blkif *blkif = ring->blkif;
> >>>  	struct xenbus_device *dev = blkif->be->dev;
> >>> -	unsigned int ring_page_order, nr_grefs, evtchn;
> >>> +	unsigned int nr_grefs, evtchn;
> >>>  
> >>>  	err = xenbus_scanf(XBT_NIL, dir, "event-channel", "%u",
> >>>  			  &evtchn);
> >>> @@ -936,43 +936,38 @@ static int read_per_ring_refs(struct xen_blkif_ring *ring, const char *dir)
> >>>  		return err;
> >>>  	}
> >>>  
> >>> -	err = xenbus_scanf(XBT_NIL, dev->otherend, "ring-page-order", "%u",
> >>> -			  &ring_page_order);
> >>> -	if (err != 1) {
> >>> -		err = xenbus_scanf(XBT_NIL, dir, "ring-ref", "%u", &ring_ref[0]);
> >>> +	nr_grefs = blkif->nr_ring_pages;
> >>> +
> >>> +	if (unlikely(!nr_grefs))
> >>> +		return -EINVAL;
> >>
> >> Is this even possible? AFAICT read_per_ring_refs will always be called
> >> with blkif->nr_ring_pages != 0?
> >>
> >> If so, I would consider turning this into a BUG_ON/WARN_ON.
> > 
> > It used to be "WARN_ON(!nr_grefs);" in the v3 of the patch.
> > 
> > I would turn it into WARN_ON if it is fine with both Paul and you.
> 
> To clarify, I would use WARN_ON() before exit with -EINVAL (when
> blkif->nr_ring_pages is 0).

Given that this function will never be called with nr_ring_pages == 0
I would be fine with just using a BUG_ON, getting here with
nr_ring_pages == 0 would imply memory corruption or some other severe
issue has happened, and there's no possible recovery.

If you want to instead keep the return, please use plain WARN instead
of WARN_ON.

Thanks, Roger.
