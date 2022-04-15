Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E98C433F5
	for <linux-block@archiver.kernel.org>; Fri, 15 Apr 2022 05:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235365AbiDOFNX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Apr 2022 01:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242044AbiDOFM5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Apr 2022 01:12:57 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1C94969F
        for <linux-block@vger.kernel.org>; Thu, 14 Apr 2022 22:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1649999394; x=1681535394;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wC6/PVYH+J9es8aT7sK5ZaGwsGnDQHOFu7y4PW6r0NI=;
  b=GEyED5QgRyUIl0mw3LT0f0qnbYPAmmlViQFOknQRPfBDeD8qBAFZaRvI
   srqDexKA45n6UaIIjYiDfoHkFqHe7yBeBUvEPLP/67VBecj9m3W7/e9m6
   B4viaJECHJ08NSm9Y473nnfrawAHuUQ2H4m3DNKG+QDSspkbpISc6ognP
   4m67enWmj0ji/HXH+zSgCTD2eD+U92xuOQZNBGO1psKzbHhJpe3vi3WXh
   ALFVT2G5AksUv/DayiN0lZoK2kL2Fmi/foDkKcj5TUTJ/sn8U7cY5VDCU
   zGuUswYSJsyfVQv8MNHZIYueLWDqD5GDFX0/mLoTSEOYxwCQ2Fo5YKCa3
   A==;
X-IronPort-AV: E=Sophos;i="5.90,261,1643644800"; 
   d="scan'208";a="202830517"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Apr 2022 13:09:49 +0800
IronPort-SDR: s4gI+QN1tvt7WsvDo/ZGZkJ53otPP3qdDVBiPGgs2s+S0ZPSwAm7Xv8qD8JNaFDPbHkc+ndjLD
 InMSeVYOky70mQCcyO1+GuBgSiz8T2X10qx9mLCHcW4acpyTSJXs121d9aInmm27nJj8kGDD8O
 LNFFag/+2D+dWXGYAkGtX4+vSA8s0+Gs2bYyLXmkwi8gyEMNdFBu7LgwIBU3Kl7cHREY65ArSj
 0xEGb4PFNwZjcxUTinCzTKoNn+5Cu96s5oS+xOUgb0Xj9MHVa/xWkCk5oIY598OtVQ4EcQZToF
 3ZkYZ6sBz9YSfuWwgOG4Jg50
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Apr 2022 21:41:00 -0700
IronPort-SDR: EvYPh/ReXy0jdgdIK28E6ljEvL4TlwNnU9Eq7RTCOFdAfqKbD/AXQ4Kopzx/MX1QBwd4QFtm1P
 BP3smeYPtkIp14dktci/eQ1exQuEyEgEqBL9gyHZId8cdWSI007MIuDJvHFgjNQWahVC4OnRCI
 FWagwZxAxTp05CFkFRwelU8Dc203wLKmYLyI4QcD4fpbW5CgHDMt1fn4l4K1NYMjx4J21QVl9K
 mhwQJ+wpIAM9jYP1T0nz8S8Lqv0u0DTpouSx1pMEREhUw6nLiDl0bu9g4jlX5ml1ef3eKLxICa
 5QA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Apr 2022 22:09:49 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KfksS0nxSz1SVnx
        for <linux-block@vger.kernel.org>; Thu, 14 Apr 2022 22:09:48 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1649999387; x=1652591388; bh=wC6/PVYH+J9es8aT7sK5ZaGwsGnDQHOFu7y
        4PW6r0NI=; b=A2KBgHYSLIEiloAT36KBlSnrdHo/5oKL9FrIFynJT5WRtSMAWFY
        bOfFXbV9aPU/SW14KWhWGoxgvZNpDxlNmySfQsvY8YKVzB0GPsCqMriDKUnvzDGe
        gxI79wWgz9d4ps/B6Xlf+gQiJxT1WJ1ZvXg2qG+PSKztllpdqubmLYAwOO/nz5St
        h4S8KA8vLEE0CNTHJjAA8Hcfkt3KCfxgWm/synsXo5jFqWGlKXVMBpl0q6F/zUl8
        QMkInWk2S7O06U7jACfYKTCYPrMyVz97bbnYwKLXgej41iNgxlqjzLyt5sjDI1Lg
        BUEAK+PEVHrx0bfVbsoqkvKO8/sBQvwsP4Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4mKH6LbmBjCM for <linux-block@vger.kernel.org>;
        Thu, 14 Apr 2022 22:09:47 -0700 (PDT)
Received: from [10.225.163.9] (unknown [10.225.163.9])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KfksM3c9Fz1Rvlx;
        Thu, 14 Apr 2022 22:09:43 -0700 (PDT)
Message-ID: <62ebc311-e5ef-cea5-5236-0c83d1a3eb64@opensource.wdc.com>
Date:   Fri, 15 Apr 2022 14:09:42 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 10/27] mm: use bdev_is_zoned in claim_swapfile
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     dm-devel@redhat.com, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-um@lists.infradead.org,
        linux-block@vger.kernel.org, drbd-dev@lists.linbit.com,
        nbd@other.debian.org, ceph-devel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, jfs-discussion@lists.sourceforge.net,
        linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev,
        ocfs2-devel@oss.oracle.com, linux-mm@kvack.org
References: <20220415045258.199825-1-hch@lst.de>
 <20220415045258.199825-11-hch@lst.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220415045258.199825-11-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/15/22 13:52, Christoph Hellwig wrote:
> Use the bdev based helper instead of poking into the queue.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  mm/swapfile.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 63c61f8b26118..4c7537162af5e 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -2761,7 +2761,7 @@ static int claim_swapfile(struct swap_info_struct *p, struct inode *inode)
>  		 * write only restriction.  Hence zoned block devices are not
>  		 * suitable for swapping.  Disallow them here.
>  		 */
> -		if (blk_queue_is_zoned(p->bdev->bd_disk->queue))
> +		if (bdev_is_zoned(p->bdev))
>  			return -EINVAL;
>  		p->flags |= SWP_BLKDEV;
>  	} else if (S_ISREG(inode->i_mode)) {

Looks good.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research
