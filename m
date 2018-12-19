Return-Path: <SRS0=7Y8O=O4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 854E6C43387
	for <linux-block@archiver.kernel.org>; Wed, 19 Dec 2018 09:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E3C620874
	for <linux-block@archiver.kernel.org>; Wed, 19 Dec 2018 09:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbeLSJJP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Dec 2018 04:09:15 -0500
Received: from smtp.eu.citrix.com ([185.25.65.24]:55326 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728282AbeLSJJP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Dec 2018 04:09:15 -0500
X-IronPort-AV: E=Sophos;i="5.56,372,1539648000"; 
   d="scan'208";a="83540675"
Date:   Wed, 19 Dec 2018 10:09:06 +0100
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Dongli Zhang <dongli.zhang@oracle.com>
CC:     <axboe@kernel.dk>, <konrad.wilk@oracle.com>,
        <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <paul.durrant@citrix.com>, <xen-devel@lists.xenproject.org>
Subject: Re: [Xen-devel] [PATCH v2 1/1] xen/blkback: rework connect_ring() to
 avoid inconsistent xenstore 'ring-page-order' set by malicious blkfront
Message-ID: <20181219090906.y4ouwhroydie7zk5@mac>
References: <1545094538-31426-1-git-send-email-dongli.zhang@oracle.com>
 <20181218093300.qfslnloxooqnu2im@mac>
 <51ea8086-e5fd-b1db-f935-101160ca9359@oracle.com>
 <20181218151331.iwkq3roqwigf3e2r@mac>
 <c3e3919c-3f82-2db5-23cf-c548bc8731ea@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c3e3919c-3f82-2db5-23cf-c548bc8731ea@oracle.com>
User-Agent: NeoMutt/20180716
X-ClientProxiedBy: AMSPEX02CAS01.citrite.net (10.69.22.112) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 18, 2018 at 11:29:16PM +0800, Dongli Zhang wrote:
> 
> 
> On 12/18/2018 11:13 PM, Roger Pau Monné wrote:
> > On Tue, Dec 18, 2018 at 07:31:59PM +0800, Dongli Zhang wrote:
> >> Hi Roger,
> >>
> >> On 12/18/2018 05:33 PM, Roger Pau Monné wrote:
> >>> On Tue, Dec 18, 2018 at 08:55:38AM +0800, Dongli Zhang wrote:
> >>>> The xenstore 'ring-page-order' is used globally for each blkback queue and
> >>>> therefore should be read from xenstore only once. However, it is obtained
> >>>> in read_per_ring_refs() which might be called multiple times during the
> >>>> initialization of each blkback queue.
> >>>>
> >>>> If the blkfront is malicious and the 'ring-page-order' is set in different
> >>>> value by blkfront every time before blkback reads it, this may end up at
> >>>> the "WARN_ON(i != (XEN_BLKIF_REQS_PER_PAGE * blkif->nr_ring_pages));" in
> >>>> xen_blkif_disconnect() when frontend is destroyed.
> >>>>
> >>>> This patch reworks connect_ring() to read xenstore 'ring-page-order' only
> >>>> once.
> >>>>
> >>>> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> >>>> ---
> >>>> Changed since v1:
> >>>>   * change the order of xenstore read in read_per_ring_refs(suggested by Roger Pau Monne)
> >>>>   * use xenbus_read_unsigned() in connect_ring() (suggested by Roger Pau Monne)
> >>>>
> >>>>  drivers/block/xen-blkback/xenbus.c | 70 ++++++++++++++++++++++----------------
> >>>>  1 file changed, 40 insertions(+), 30 deletions(-)
> >>>>
> >>>> diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
> >>>> index a4bc74e..7178f0f 100644
> >>>> --- a/drivers/block/xen-blkback/xenbus.c
> >>>> +++ b/drivers/block/xen-blkback/xenbus.c
> >>>> @@ -926,7 +926,7 @@ static int read_per_ring_refs(struct xen_blkif_ring *ring, const char *dir)
> >>>>  	int err, i, j;
> >>>>  	struct xen_blkif *blkif = ring->blkif;
> >>>>  	struct xenbus_device *dev = blkif->be->dev;
> >>>> -	unsigned int ring_page_order, nr_grefs, evtchn;
> >>>> +	unsigned int nr_grefs, evtchn;
> >>>>  
> >>>>  	err = xenbus_scanf(XBT_NIL, dir, "event-channel", "%u",
> >>>>  			  &evtchn);
> >>>> @@ -936,43 +936,38 @@ static int read_per_ring_refs(struct xen_blkif_ring *ring, const char *dir)
> >>>>  		return err;
> >>>>  	}
> >>>>  
> >>>> -	err = xenbus_scanf(XBT_NIL, dev->otherend, "ring-page-order", "%u",
> >>>> -			  &ring_page_order);
> >>>> -	if (err != 1) {
> >>>> -		err = xenbus_scanf(XBT_NIL, dir, "ring-ref", "%u", &ring_ref[0]);
> >>>> -		if (err != 1) {
> >>>> +	nr_grefs = blkif->nr_ring_pages;
> >>>> +	WARN_ON(!nr_grefs);
> >>>> +
> >>>> +	for (i = 0; i < nr_grefs; i++) {
> >>>> +		char ring_ref_name[RINGREF_NAME_LEN];
> >>>> +
> >>>> +		snprintf(ring_ref_name, RINGREF_NAME_LEN, "ring-ref%u", i);
> >>>> +		err = xenbus_scanf(XBT_NIL, dir, ring_ref_name,
> >>>> +				   "%u", &ring_ref[i]);
> >>>> +
> >>>> +		if (err != 1 && (i || (!i && nr_grefs > 1))) {
> >>>
> >>> AFAICT the above condition can be simplified as "err != 1 &&
> >>> nr_grefs".
> >>>
> >>>>  			err = -EINVAL;
> >>>
> >>> There's no point in setting err here...
> >>>
> >>>> -			xenbus_dev_fatal(dev, err, "reading %s/ring-ref", dir);
> >>>> +			xenbus_dev_fatal(dev, err, "reading %s/%s",
> >>>> +					 dir, ring_ref_name);
> >>>>  			return err;
> >>>
> >>> ...since you can just return -EINVAL (same applies to the other
> >>> instance below).
> >>
> >> I would like to confirm if I would keep the err = -EINVAL in below because most
> >> of the below code is copied from original implementation without modification.
> >>
> >> There is no err set by xenbus_read_unsigned().
> > 
> > Right, but instead of doing:
> > 
> > err = -EINVAL;
> > return err;
> > 
> > You can just do:
> > 
> > return -EINVAL;
> > 
> > Which is one line shorter :).
> 
> However, for the "ring-page-order" case, the err used in xenbus_dev_fatal() is
> not set as xenbus_read_unsigned() does not return any err?
> 
> For "ring-page-order", I would still need to set err = -EINVAL with extra one
> line of code?

Given this, I don't have a strong opinion, so do as you please.

Thanks, Roger.
