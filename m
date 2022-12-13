Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C719FC10F1B
	for <linux-block@archiver.kernel.org>; Tue, 13 Dec 2022 16:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235405AbiLMQrA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Dec 2022 11:47:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236254AbiLMQqU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Dec 2022 11:46:20 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5BB61262E;
        Tue, 13 Dec 2022 08:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=wrJUFpTSTEZ6dU+1aP5FM2CWsqDDx9F0OdDQskoYMMw=; b=AbQmTCqPqGgn89AQLOTH/xKspj
        HscMOAfb6Qt5RWJWLwTkILx2ECA78VGgKffnzQ0r4IRmHdXOlKcGpXTdC/aY7h5GcmRbcAesMr6SA
        lOUfaYv8FHDRDdNQOJSfO7Cxvc23SziIz3tl3ZMHCMmbm2SIzDgvvGtjzbKBk7yb0JMEPP1/bbDf9
        QPh3tCphI7AN8nAuTx9ejvYsZ8bufxlNUF0daumhX3lg6SfG0MLMO9dGSxn5j4f5HpKVhIX5GZCXj
        77CRtMF/VSYN53Pah745n7NB7JQM80UmU5YDa3JhinSd7oggFf8Q8nsEBHc/pdgy7FojZPBl0UuEK
        XRwXuSWA==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p58Pa-0032jW-9r; Tue, 13 Dec 2022 16:45:46 +0000
Message-ID: <aae11fd8-03c0-7996-67ca-7b528a6fec15@infradead.org>
Date:   Tue, 13 Dec 2022 08:45:44 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [RFC PATCH 2/2] block: add uImage.FIT block partition driver
Content-Language: en-US
To:     Daniel Golle <daniel@makrotopia.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christoph Hellwig <hch@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
References: <Y5h0C4iKoeCJgRCb@makrotopia.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <Y5h0C4iKoeCJgRCb@makrotopia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 12/13/22 04:46, Daniel Golle wrote:
> diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
> index a41145d52de9..f8618bc869b2 100644
> --- a/drivers/block/Kconfig
> +++ b/drivers/block/Kconfig
> @@ -383,6 +383,17 @@ config VIRTIO_BLK
>  	  This is the virtual block driver for virtio.  It can be used with
>            QEMU based VMMs (like KVM or Xen).  Say Y or M.
>  
> +config UIMAGE_FIT_BLK
> +	bool "uImage.FIT block driver"
> +	help
> +	  This is driver allows using filesystems contained in uImage.FIT images

	  This driver allows

> +	  by mapping them as block devices.
> +
> +	  This driver can currently not be built as a module.
> +
> +	  Say Y if you want to mount filesystems sub-images of a uImage.FIT
> +	  stored in a block device partition, mtdblock or ubiblock device.

-- 
~Randy
