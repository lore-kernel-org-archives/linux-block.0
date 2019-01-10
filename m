Return-Path: <SRS0=tdSH=PS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A217C43387
	for <linux-block@archiver.kernel.org>; Thu, 10 Jan 2019 17:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C95AC20685
	for <linux-block@archiver.kernel.org>; Thu, 10 Jan 2019 17:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mx3G+nBq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbfAJRC3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Jan 2019 12:02:29 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:49128 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727836AbfAJRC2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Jan 2019 12:02:28 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0AGxTLh179520;
        Thu, 10 Jan 2019 17:02:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=jnCKMZoBc1lLvLQ8sW1g6t1cZ7Wd/SFilvKOlPJEmag=;
 b=mx3G+nBqOr0JDGW/7kptr3FQzgsNCuSesb4LdwjoI1v2B9t/McMmpbCpCt10UjhBp9+h
 0Gh4bQp68MQElFuBqfRKlooy1a/B6c+Q5I+z9LTjDxRAsfnS5XPVcDwehl2+v1zvmhMU
 OsuDzRdLeopTkrmOVogRdntuo/KbWeng7ZLoKDHyHq2cFVHhMyL3NxbLeIiFqVCn20vZ
 3i5uQmJXaBfhi/NKc4sesipxHAx/4o+rQG8S0BQj0b9MXWgrcMIMS/XxkL0VIxgOtCao
 mnZOKpkZzs+juVmhixXF+1bg1IyE36uiXl+fxVGFO2n8JpcKeTBBxnRFMkuBEWRArcjv GQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2ptj3e8nad-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Jan 2019 17:02:09 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0AH28OL029311
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Jan 2019 17:02:08 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0AH27jl002612;
        Thu, 10 Jan 2019 17:02:07 GMT
Received: from char.us.oracle.com (/10.152.32.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 10 Jan 2019 09:02:07 -0800
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id B9DC56A0126; Thu, 10 Jan 2019 12:02:05 -0500 (EST)
Date:   Thu, 10 Jan 2019 12:02:05 -0500
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, jfehlig@suse.com,
        jon.grimm@amd.com, brijesh.singh@amd.com, hch@lst.de,
        Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH 1/3] swiotlb: Export maximum allocation size
Message-ID: <20190110170205.GB27546@char.us.oracle.com>
References: <20190110134433.15672-1-joro@8bytes.org>
 <20190110134433.15672-2-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110134433.15672-2-joro@8bytes.org>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9131 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901100133
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 10, 2019 at 02:44:31PM +0100, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> The SWIOTLB implementation has a maximum size it can
> allocate dma-handles for. This needs to be exported so that
> device drivers don't try to allocate larger chunks.
> 
> This is especially important for block device drivers like
> virtio-blk, that might do DMA through SWIOTLB.

Why not use swiotlb_nr_tbl ? That is how drivers/gpu/drm use to figure if they
need to limit the size of pages.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  include/linux/swiotlb.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index 7c007ed7505f..0bcc80a97036 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -72,6 +72,11 @@ static inline bool is_swiotlb_buffer(phys_addr_t paddr)
>  	return paddr >= io_tlb_start && paddr < io_tlb_end;
>  }
>  
> +static inline size_t swiotlb_max_alloc_size(void)
> +{
> +	return ((1UL << IO_TLB_SHIFT) * IO_TLB_SEGSIZE);
> +}
> +
>  bool swiotlb_map(struct device *dev, phys_addr_t *phys, dma_addr_t *dma_addr,
>  		size_t size, enum dma_data_direction dir, unsigned long attrs);
>  void __init swiotlb_exit(void);
> @@ -95,6 +100,13 @@ static inline unsigned int swiotlb_max_segment(void)
>  {
>  	return 0;
>  }
> +
> +static inline size_t swiotlb_max_alloc_size(void)
> +{
> +	/* There is no limit when SWIOTLB isn't used */
> +	return ~0UL;
> +}
> +
>  #endif /* CONFIG_SWIOTLB */
>  
>  extern void swiotlb_print_info(void);
> -- 
> 2.17.1
> 
