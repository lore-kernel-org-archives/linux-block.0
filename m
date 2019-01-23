Return-Path: <SRS0=btbQ=P7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94426C282C0
	for <linux-block@archiver.kernel.org>; Wed, 23 Jan 2019 17:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FA3D21873
	for <linux-block@archiver.kernel.org>; Wed, 23 Jan 2019 17:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="P3mexvda"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbfAWRKi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Jan 2019 12:10:38 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:45648 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfAWRKi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Jan 2019 12:10:38 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0NH8g5d070127;
        Wed, 23 Jan 2019 17:10:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=Wk9Y5AB2WM8DzEpEfDhRpp1UaspNuMG9QRK3o30gmcI=;
 b=P3mexvdaIdSbH6ShkwFCyC8xlF/rJxI1FHS8vL46hsuKsrC7XiN9R7LCHRSumq4I75Xn
 UW5WMjCY0han1JElaOJo7OvQ+ruw0ebbiGiCL3PNPEwCKrYXjbtdQmtQIQWpfQGN7IQl
 j3P31H/9IajJRTHS7TXvQb8J+iY2QA54yfmA0lsWNUz9y00+HcIMk5nyAXtY2wiN2vIZ
 D2W1foCLRFrbbtac+5flK7r3iBRtmC1RYmAqVTGyPpcMfkp3t75cJF5O41SEeDCyfmT1
 EsO8Nyw658LRn1gR7kuHY9xyYFuB0NBxG/94RmbIUDz6QDwmZpX+0ys4Eamtss+GfDX8 jw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2q3uauu7ny-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Jan 2019 17:10:16 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0NHAE1u029864
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Jan 2019 17:10:15 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0NHACY8031044;
        Wed, 23 Jan 2019 17:10:12 GMT
Received: from Konrads-MacBook-Pro.local (/75.104.64.133)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 23 Jan 2019 09:10:12 -0800
Date:   Wed, 23 Jan 2019 12:09:48 -0500
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, jfehlig@suse.com,
        jon.grimm@amd.com, brijesh.singh@amd.com, jroedel@suse.de
Subject: Re: [PATCH 0/5 v3] Fix virtio-blk issue with SWIOTLB
Message-ID: <20190123170946.GB22672@Konrads-MacBook-Pro.local>
References: <20190123163049.24863-1-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190123163049.24863-1-joro@8bytes.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9145 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901230126
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 23, 2019 at 05:30:44PM +0100, Joerg Roedel wrote:
> Hi,
> 
> here is the third version of this patch-set. Previous
> versions can be found here:
> 
> 	V1: https://lore.kernel.org/lkml/20190110134433.15672-1-joro@8bytes.org/
> 
> 	V2: https://lore.kernel.org/lkml/20190115132257.6426-1-joro@8bytes.org/
> 
> The problem solved here is a limitation of the SWIOTLB implementation,
> which does not support allocations larger than 256kb.  When the
> virtio-blk driver tries to read/write a block larger than that, the
> allocation of the dma-handle fails and an IO error is reported.
> 
> Changes to v2 are:
> 
> 	* Check if SWIOTLB is active before returning its limit in
> 	  dma_direct_max_mapping_size()
> 
> 	* Only apply the maximum segment limit in virtio-blk when
> 	  DMA-API is used for the vring
> 
> Please review.
> 
> Thanks,
> 
> 	Joerg
> 
> Joerg Roedel (5):
>   swiotlb: Introduce swiotlb_max_mapping_size()
>   swiotlb: Add is_swiotlb_active() function
>   dma: Introduce dma_max_mapping_size()
>   virtio: Introduce virtio_max_dma_size()
>   virtio-blk: Consider virtio_max_dma_size() for maximum segment size
> 
>  drivers/block/virtio_blk.c   | 10 ++++++----
>  drivers/virtio/virtio_ring.c | 10 ++++++++++

The kvm-devel mailing list should have been copied on those.

When you do can you please put 'Reviewed-by: Konrad Rzeszutek Wilk
<konrad.wilk@oracle.com>' on all of them?

Thank you!

P.S.
Christopher, I am assuming you are OK with this idea, if so - and once
the owners of 'virtio' Ack, do you want to put it in my tree?

Thanks!
>  include/linux/dma-mapping.h  | 16 ++++++++++++++++
>  include/linux/swiotlb.h      | 11 +++++++++++
>  include/linux/virtio.h       |  2 ++
>  kernel/dma/direct.c          | 11 +++++++++++
>  kernel/dma/swiotlb.c         | 10 ++++++++++
>  7 files changed, 66 insertions(+), 4 deletions(-)


> 
> -- 
> 2.17.1
> 
