Return-Path: <SRS0=89dG=QE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCAD3C282CD
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 17:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 895232147A
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 17:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AdsrBIWc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfA1Ri6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:38:58 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:39438 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729529AbfA1Pxt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 10:53:49 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0SFdGf1050941;
        Mon, 28 Jan 2019 15:53:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=kT+FnE432PBmlNs3kWkm18QbbbiHW1hKofG4QsQ2MYk=;
 b=AdsrBIWc5x79RPN0SB1RL0UtI0dzorN1yR5vSaQe7MpE9kS0m88hOSwW2hmZxusm5Cyf
 usYgCXVfM5j6g2ewEpxvhZ12DjmBgvOVsk+h25df0cO5CNN9kfyhZ+DVO3RHVk+CZKoZ
 601AgB8mOpAQ8Bbo6oKr/Z3TANk5sYDCgK9kOehj1Q5jFYCgr5LgPdQnoIJaxBxMdSks
 PYIXcOWBJ+NPQkykzFmeS5nLPNkh55Aq3H/fs6GuEgJM2a4FumRYg452vSVBioFWxki1
 BLtSZ0/yE7vYmmtMUtmw3R3QpPcqsh1UYMrE8wtwbqx1wda0RqYy0RWObm3w+00uEqDY nA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2q8eyu6y2s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Jan 2019 15:53:32 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0SFrP7s015450
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Jan 2019 15:53:26 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0SFrOUM007981;
        Mon, 28 Jan 2019 15:53:24 GMT
Received: from char.us.oracle.com (/10.152.32.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 28 Jan 2019 07:53:24 -0800
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id C0A276A0131; Mon, 28 Jan 2019 10:53:22 -0500 (EST)
Date:   Mon, 28 Jan 2019 10:53:22 -0500
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Jason Wang <jasowang@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, jfehlig@suse.com,
        jon.grimm@amd.com, brijesh.singh@amd.com, jroedel@suse.de
Subject: Re: [PATCH 0/5 v3] Fix virtio-blk issue with SWIOTLB
Message-ID: <20190128155322.GA32686@char.us.oracle.com>
References: <20190123163049.24863-1-joro@8bytes.org>
 <20190123135000-mutt-send-email-mst@kernel.org>
 <20190123211453.GA2474@char.us.oracle.com>
 <20190128101852-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128101852-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9150 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901280120
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 28, 2019 at 10:20:05AM -0500, Michael S. Tsirkin wrote:
> On Wed, Jan 23, 2019 at 04:14:53PM -0500, Konrad Rzeszutek Wilk wrote:
> > On Wed, Jan 23, 2019 at 01:51:29PM -0500, Michael S. Tsirkin wrote:
> > > On Wed, Jan 23, 2019 at 05:30:44PM +0100, Joerg Roedel wrote:
> > > > Hi,
> > > > 
> > > > here is the third version of this patch-set. Previous
> > > > versions can be found here:
> > > > 
> > > > 	V1: https://lore.kernel.org/lkml/20190110134433.15672-1-joro@8bytes.org/
> > > > 
> > > > 	V2: https://lore.kernel.org/lkml/20190115132257.6426-1-joro@8bytes.org/
> > > > 
> > > > The problem solved here is a limitation of the SWIOTLB implementation,
> > > > which does not support allocations larger than 256kb.  When the
> > > > virtio-blk driver tries to read/write a block larger than that, the
> > > > allocation of the dma-handle fails and an IO error is reported.
> > > 
> > > 
> > > OK looks good to me.
> > > I will park this in my tree for now this way it will get
> > > testing in linux-next.
> > > Can I get an ack from DMA maintainers on the DMA bits for
> > > merging this in 5.0?
> > 
> > You got mine (SWIOTBL is my area).
> 
> OK so
> 
> Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

Yes :-)
> 
> 
> 
> > > 
> > > > Changes to v2 are:
> > > > 
> > > > 	* Check if SWIOTLB is active before returning its limit in
> > > > 	  dma_direct_max_mapping_size()
> > > > 
> > > > 	* Only apply the maximum segment limit in virtio-blk when
> > > > 	  DMA-API is used for the vring
> > > > 
> > > > Please review.
> > > > 
> > > > Thanks,
> > > > 
> > > > 	Joerg
> > > > 
> > > > Joerg Roedel (5):
> > > >   swiotlb: Introduce swiotlb_max_mapping_size()
> > > >   swiotlb: Add is_swiotlb_active() function
> > > >   dma: Introduce dma_max_mapping_size()
> > > >   virtio: Introduce virtio_max_dma_size()
> > > >   virtio-blk: Consider virtio_max_dma_size() for maximum segment size
> > > > 
> > > >  drivers/block/virtio_blk.c   | 10 ++++++----
> > > >  drivers/virtio/virtio_ring.c | 10 ++++++++++
> > > >  include/linux/dma-mapping.h  | 16 ++++++++++++++++
> > > >  include/linux/swiotlb.h      | 11 +++++++++++
> > > >  include/linux/virtio.h       |  2 ++
> > > >  kernel/dma/direct.c          | 11 +++++++++++
> > > >  kernel/dma/swiotlb.c         | 10 ++++++++++
> > > >  7 files changed, 66 insertions(+), 4 deletions(-)
> > > > 
> > > > -- 
> > > > 2.17.1
