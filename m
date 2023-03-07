Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8026CC678D4
	for <linux-block@archiver.kernel.org>; Tue,  7 Mar 2023 09:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbjCGJJj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Mar 2023 04:09:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjCGJJi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Mar 2023 04:09:38 -0500
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5AB51C9B
        for <linux-block@vger.kernel.org>; Tue,  7 Mar 2023 01:09:36 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230307090934euoutp02d7236353c3e10af8ff236162e942f8bb~KF-o05Rub3223632236euoutp02B
        for <linux-block@vger.kernel.org>; Tue,  7 Mar 2023 09:09:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230307090934euoutp02d7236353c3e10af8ff236162e942f8bb~KF-o05Rub3223632236euoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1678180174;
        bh=5PRTe8i6y6sYtq0d2bevDPGtcObALxi0aBj4ru1ld3Y=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=p2urhsvzS2An/wsKT8VKHtyVUPnWTJutCpBBHQpY4P6Y/L47GZsap0e+FLWQJtPMI
         u0AC4LB78B+HW2ReyzltD8ZQrAm9ol/5MnTBZgPllI08QFeQTjAAC3gyLU16BYY6RO
         vmTBZ7eWPioBkVqhJ2HeBPpXfMGFTaTSPKNjkLXk=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230307090934eucas1p141c52dd6c33ba8455f0e59206fb16be2~KF-or_nz31765317653eucas1p1r;
        Tue,  7 Mar 2023 09:09:34 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id D3.85.09966.E4FF6046; Tue,  7
        Mar 2023 09:09:34 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230307090934eucas1p28d92f3fd8c13edcba8e5d3fa7de6bcab~KF-oZvlWi3134131341eucas1p2x;
        Tue,  7 Mar 2023 09:09:34 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230307090934eusmtrp1ece107dc0446ce5d07910d7985647743~KF-oY-C2H2753327533eusmtrp1w;
        Tue,  7 Mar 2023 09:09:34 +0000 (GMT)
X-AuditID: cbfec7f4-d4fff700000026ee-72-6406ff4ea3bb
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 68.F4.09583.D4FF6046; Tue,  7
        Mar 2023 09:09:34 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230307090933eusmtip2645adec60e9c750ff07429b504d91e7c~KF-oPlqVR0309803098eusmtip2a;
        Tue,  7 Mar 2023 09:09:33 +0000 (GMT)
Received: from localhost (106.110.32.140) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Tue, 7 Mar 2023 09:09:33 +0000
Date:   Tue, 7 Mar 2023 10:01:22 +0100
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     Hannes Reinecke <hare@suse.de>
CC:     Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Keith Busch <kbusch@kernel.org>, <p.raghav@samsung.com>
Subject: Re: [PATCH 5/5] brd: make logical sector size configurable
Message-ID: <20230307090056.x3hpaxdwtlpytnf2@blixen>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230306120127.21375-6-hare@suse.de>
X-Originating-IP: [106.110.32.140]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgleLIzCtJLcpLzFFi42LZduznOV2//2wpBv03BS1W3+1ns9izaBKT
        xaRD1xgt9t7Strgx4Smjxe8fc9gc2Dw2r9DyuHy21GPTqk4g53S1x+dNcgGsUVw2Kak5mWWp
        Rfp2CVwZf3f+YilYLVRxdsUM9gbGPv4uRk4OCQETiYe3PjF1MXJxCAmsYJRY0XCNFcL5wiix
        7P5MZgjnM6PE9L0NzDAtRyd9YYdILGeU6Pi3jQ2uaum/h2BVQgKbGSV+v6kBsVkEVCTun1vJ
        2MXIwcEmoCXR2MkOEhYRUJL42H4IbBCzwAlGief3frOAJIQFnCV2r17NCGLzAm2bev0WG4Qt
        KHFy5hOwGmYBHYkFuz+xgcxkFpCWWP6PAyTMKWAksXppKzvEoUoSDZvPsEDYtRKnttwC+1NC
        4AaHROPtLqgiF4k/U3cxQtjCEq+Ob4GKy0icntwD1Vwt8fTGb2aI5hZGif6d68EWSwhYS/Sd
        yYGocZRYeX8vC0SYT+LGW0GIM/kkJm2bzgwR5pXoaBOCqFaT2NG0lXECo/IsJI/NQvLYLITH
        FjAyr2IUTy0tzk1PLTbKSy3XK07MLS7NS9dLzs/dxAhMLKf/Hf+yg3H5q496hxiZOBgPMUpw
        MCuJ8L59x5YixJuSWFmVWpQfX1Sak1p8iFGag0VJnFfb9mSykEB6YklqdmpqQWoRTJaJg1Oq
        gWmRhvlltugHpgFFLL8ul1uudu/OavyQ7iO/rtTTrp7ni0zFgU2vxI51Xpg063Tbav65E29e
        5bw3X7PmwImNuarltgbz361YUndlSe+GzZpP9s49YOzupMAa1NiT7a6xTrNOS1Po38bQo5e3
        7nmqtnL2nDvG7Wvb9nBt5Y3doyei++bVPtH5znN/tsxwLzh9V3n7fJEa6zcbn/x5xrf2mElV
        oKWPQdXS+fI3T345vmZL4q1t0cEC9ltVYpaKXElMahQS+Bkh3fmEy9+o927casOc4ODavs6N
        zb6bNvgxhG9/5autXeETl/y+5ND6tRZNW8vt+euWhW1q6o0qkvWcWrNGjGFCTZT1+ZPSXlk7
        TymxFGckGmoxFxUnAgA2TW48mwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCIsWRmVeSWpSXmKPExsVy+t/xe7p+/9lSDNZ2MFqsvtvPZrFn0SQm
        i0mHrjFa7L2lbXFjwlNGi98/5rA5sHlsXqHlcflsqcemVZ1Azulqj8+b5AJYo/RsivJLS1IV
        MvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQy/u78xVKwWqji7IoZ
        7A2MffxdjJwcEgImEkcnfWHvYuTiEBJYyijRc6GBDSIhI/Hpykd2CFtY4s+1LrC4kMBHRonn
        E/MhGjYzSizftg+siEVAReL+uZWMXYwcHGwCWhKNnWBhEQEliY/th8AWMAucYJSYPPEEE0hC
        WMBZYvfq1YwgNi/QFVOv32ID6RUSiJQ488ccIiwocXLmExYQm1lAR2LB7k9gJcwC0hLL/3GA
        hDkFjCRWL22FOlNJomHzGRYIu1bi899njBMYhWchmTQLyaRZCJMWMDKvYhRJLS3OTc8tNtIr
        TswtLs1L10vOz93ECIyubcd+btnBuPLVR71DjEwcjIcYJTiYlUR4375jSxHiTUmsrEotyo8v
        Ks1JLT7EaAoMiInMUqLJ+cD4ziuJNzQzMDU0MbM0MLU0M1YS5/Us6EgUEkhPLEnNTk0tSC2C
        6WPi4JRqYEpY6OKyo3vVFqGfi+Y+Otkn9/yI1tIdRz59OGXFzzSz5zyP9YRdxy/xeYnsOR5j
        lnpadu6Kn+Gxx7dev9MtYha4XT0l+Gv706iUppmtAeYJwbH+ZT2WNfsfVWdttGQoPF+h5XZa
        K0dgZ+v05/69D9+4GjuuDOs7HHBj7Uy5eY9O/XCKvRc2VYH/hWCyo4XYzf9l5bd+i6+Su3fm
        kKvcq9+ZZTf63i2YKDup8oDbzYYXuzVqmg4lenufT0vM5lVl/bfs+XHmQxdCzCbvrcvpTbzL
        WsxSLrDx8Dy/U4zvW4ofyIk1rr7x67mOreLjF6brtHbpRR1e4Ggqzq2wRHPirHdcp6QrLs2b
        emj999MfC64osRRnJBpqMRcVJwIAi8IxFzcDAAA=
X-CMS-MailID: 20230307090934eucas1p28d92f3fd8c13edcba8e5d3fa7de6bcab
X-Msg-Generator: CA
X-RootMTR: 20230307090934eucas1p28d92f3fd8c13edcba8e5d3fa7de6bcab
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230307090934eucas1p28d92f3fd8c13edcba8e5d3fa7de6bcab
References: <20230306120127.21375-1-hare@suse.de>
        <20230306120127.21375-6-hare@suse.de>
        <CGME20230307090934eucas1p28d92f3fd8c13edcba8e5d3fa7de6bcab@eucas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> @@ -57,7 +59,7 @@ static struct folio *brd_lookup_folio(struct brd_device *brd, sector_t sector)
>  {
>  	pgoff_t idx;
>  	struct folio *folio;
> -	unsigned int rd_sector_shift = brd->brd_sector_shift - SECTOR_SHIFT;
> +	unsigned int rd_sector_shift = brd->brd_sector_shift - brd->brd_logical_sector_shift;

Could we create a simple macro instead of repeating this everywhere?
#define RD_SECTOR_SHIFT(brd) (brd->brd_sector_shift - brd->brd_logical_sector_shift) 

>  
>  	/*
>  	 * The folio lifetime is protected by the fact that we have opened the
>  			bio_io_error(bio);
>  			return;
>  		}
> -		sector += len >> SECTOR_SHIFT;
> +		sector += len >> brd->brd_logical_sector_shift;
>  	}
>  
>  	bio_endio(bio);
> @@ -353,6 +355,10 @@ static unsigned int rd_blksize = PAGE_SIZE;
>  module_param(rd_blksize, uint, 0444);
>  MODULE_PARM_DESC(rd_blksize, "Blocksize of each RAM disk in bytes.");
>  
> +static unsigned int rd_logical_blksize = SECTOR_SIZE;
> +module_param(rd_logical_blksize, uint, 0444);
> +MODULE_PARM_DESC(rd_logical_blksize, "Logical blocksize of each RAM disk in bytes.");
> +
>  MODULE_LICENSE("GPL");
>  MODULE_ALIAS_BLOCKDEV_MAJOR(RAMDISK_MAJOR);
>  MODULE_ALIAS("rd");
> @@ -391,6 +397,8 @@ static int brd_alloc(int i)
>  	list_add_tail(&brd->brd_list, &brd_devices);
>  	brd->brd_sector_shift = ilog2(rd_blksize);
>  	brd->brd_sector_size = rd_blksize;
> +	brd->brd_logical_sector_shift = ilog2(rd_logical_blksize);
> +	brd->brd_logical_sector_size = rd_logical_blksize;

We should a check here to see if logical block > rd_blksize similar
to what is done in blk_queue_logical_block_size()?

// physical block size should not be less than the logical block size
if (rd_blksize < rd_logical_blksize) {
	brd->brd_logical_sector_shift = ilog2(rd_blksize);
	brd->brd_logical_sector_size = rd_blksize;
 }

>  
>  	spin_lock_init(&brd->brd_lock);
>  	INIT_RADIX_TREE(&brd->brd_folios, GFP_ATOMIC);
> @@ -418,6 +426,7 @@ static int brd_alloc(int i)
>  		goto out_cleanup_disk;
>  	}
>  	blk_queue_physical_block_size(disk->queue, rd_blksize);
> +	blk_queue_logical_block_size(disk->queue, rd_logical_blksize);
>  	blk_queue_max_hw_sectors(disk->queue, RD_MAX_SECTOR_SIZE);
>  
>  	/* Tell the block layer that this is not a rotational device */
> -- 
> 2.35.3
> 
