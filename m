Return-Path: <SRS0=rtTj=QG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11175C282D8
	for <linux-block@archiver.kernel.org>; Wed, 30 Jan 2019 18:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBD7C20869
	for <linux-block@archiver.kernel.org>; Wed, 30 Jan 2019 18:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="4Bxx/y76"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733036AbfA3Sff (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Jan 2019 13:35:35 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:60862 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733050AbfA3Sff (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Jan 2019 13:35:35 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0UIT0lt075111;
        Wed, 30 Jan 2019 18:35:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=ACWEh6HzBHmJZCdYbSI2j5nHsH2aiDUTZoXaRxS6Trs=;
 b=4Bxx/y76EXVwScZPSGQuTfKPiJKcfDZEtUUGcw62nQW3uR8mo9khoF3bRuOCzjkWMKoi
 +MauwVUxNx29FZJBOEKtP7ns8zjJxbYLtYyXQl9gRFT4V4tKJMwaumt4K2N6v7hqYGoE
 jmyXlzx7poziEP1aCjQth13xJ/8yXp6xhTSR66HYJDnOt51KeqZ9aME1WpDi4Y5+V4Ar
 BuPh81crZLSH3ZM8sGv1dmhFqx535Xv0eV3GETNZ4Db5U3gD7prWsnndshLi6AlHbSvq
 6wslai1g9cVx+BtPaSbFIf2bIifkK3VEYrjfT3Nkyepvfavc7xcz/vKlJpP9LILdTcOa mg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2q8g6rc908-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Jan 2019 18:35:17 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0UIZGQh005864
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Jan 2019 18:35:16 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x0UIZGQe026214;
        Wed, 30 Jan 2019 18:35:16 GMT
Received: from char.us.oracle.com (/10.152.32.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 30 Jan 2019 10:35:15 -0800
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id E8DB66A05F7; Wed, 30 Jan 2019 13:35:13 -0500 (EST)
Date:   Wed, 30 Jan 2019 13:35:13 -0500
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, jfehlig@suse.com,
        jon.grimm@amd.com, brijesh.singh@amd.com, jroedel@suse.de,
        Thomas.Lendacky@amd.com
Subject: Re: [PATCH 0/5 v5] Fix virtio-blk issue with SWIOTLB
Message-ID: <20190130183513.GB27284@char.us.oracle.com>
References: <20190130164007.26497-1-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190130164007.26497-1-joro@8bytes.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9152 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1901300140
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 30, 2019 at 05:40:02PM +0100, Joerg Roedel wrote:
> Hi,
> 
> here is the next version of this patch-set. Previous
> versions can be found here:
> 
> 	V1: https://lore.kernel.org/lkml/20190110134433.15672-1-joro@8bytes.org/
> 
> 	V2: https://lore.kernel.org/lkml/20190115132257.6426-1-joro@8bytes.org/
> 
> 	V3: https://lore.kernel.org/lkml/20190123163049.24863-1-joro@8bytes.org/
> 
> 	V4: https://lore.kernel.org/lkml/20190129084342.26030-1-joro@8bytes.org/
> 
> The problem solved here is a limitation of the SWIOTLB implementation,
> which does not support allocations larger than 256kb.  When the
> virtio-blk driver tries to read/write a block larger than that, the
> allocation of the dma-handle fails and an IO error is reported.
> 
> Changes to v4 are:
> 
> 	- Added Reviewed-by tags from Christoph
> 
> 	- Added missing EXPORT_SYMBOL(_GPL) lines
> 
> Please review.

I can put it in my tree and send it to Linus .. unless folks want
to do it through a different tree?


> 
> Thanks,
> 
> 	Joerg
> Joerg Roedel (5):
>   swiotlb: Introduce swiotlb_max_mapping_size()
>   swiotlb: Add is_swiotlb_active() function
>   dma: Introduce dma_max_mapping_size()
>   virtio: Introduce virtio_max_dma_size()
>   virtio-blk: Consider virtio_max_dma_size() for maximum segment size
> 
>  Documentation/DMA-API.txt    |  8 ++++++++
>  drivers/block/virtio_blk.c   | 10 ++++++----
>  drivers/virtio/virtio_ring.c | 11 +++++++++++
>  include/linux/dma-mapping.h  | 16 ++++++++++++++++
>  include/linux/swiotlb.h      | 11 +++++++++++
>  include/linux/virtio.h       |  2 ++
>  kernel/dma/direct.c          | 12 ++++++++++++
>  kernel/dma/swiotlb.c         | 14 ++++++++++++++
>  8 files changed, 80 insertions(+), 4 deletions(-)
> 
> -- 
> 2.17.1
> 
