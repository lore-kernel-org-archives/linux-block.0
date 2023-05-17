Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA21C77B7A
	for <linux-block@archiver.kernel.org>; Wed, 17 May 2023 09:32:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjEQJcH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 May 2023 05:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjEQJcG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 May 2023 05:32:06 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E84D210C
        for <linux-block@vger.kernel.org>; Wed, 17 May 2023 02:32:01 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230517093159euoutp02adcbbc5c0352c5302cf6e363d5c1eb83~f5GeUNzqX1485214852euoutp025
        for <linux-block@vger.kernel.org>; Wed, 17 May 2023 09:31:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230517093159euoutp02adcbbc5c0352c5302cf6e363d5c1eb83~f5GeUNzqX1485214852euoutp025
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1684315919;
        bh=8fDeR/ScJoAsjmvNUK/OgD3oyFjVxqvjdALCkfjp87c=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=t9orh4n7wrtz+QFUVbm3RmvwvHbXPWpjRz7StOilNmfsTNIZzTfMTRYbWeCAvRMTz
         rDjPGkUg9dsyX+Wts+Ti297nA4FzXSVyWBH+tYvzuelPYCWgJjdfVZ6ox6uJKcDLJO
         6YcXvRbel4KDitPOEaYQ+TtsQ/cfKzWO3obV06cc=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230517093159eucas1p2f597bf5dde65a7e093d7629b7550caff~f5GeKfKza0982009820eucas1p2u;
        Wed, 17 May 2023 09:31:59 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 46.BA.35386.E0F94646; Wed, 17
        May 2023 10:31:58 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230517093158eucas1p2831fd21a6f66ae39c887ad91e098aa74~f5Gd0e1_c0766107661eucas1p2x;
        Wed, 17 May 2023 09:31:58 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230517093158eusmtrp14ce8ec9170fc0aeb24dac4d73d8791d3~f5GdzwnfU1753517535eusmtrp1r;
        Wed, 17 May 2023 09:31:58 +0000 (GMT)
X-AuditID: cbfec7f4-cc9ff70000028a3a-7b-64649f0e63f2
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 43.1A.10549.E0F94646; Wed, 17
        May 2023 10:31:58 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230517093158eusmtip1cc5bd25fb274302ebbffc21c3f258f49~f5GdokitB0247102471eusmtip19;
        Wed, 17 May 2023 09:31:58 +0000 (GMT)
Received: from localhost (106.110.32.140) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Wed, 17 May 2023 10:31:57 +0100
Date:   Wed, 17 May 2023 11:31:57 +0200
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     Hannes Reinecke <hare@suse.de>
CC:     Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Keith Busch <kbusch@kernel.org>, <p.raghav@samsung.com>
Subject: Re: [PATCH 5/5] brd: make logical sector size configurable
Message-ID: <20230517093157.er2fkuusfn5qciay@localhost>
MIME-Version: 1.0
In-Reply-To: <20230306120127.21375-6-hare@suse.de>
X-Originating-IP: [106.110.32.140]
X-ClientProxiedBy: CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRjG+Xbm2dlq6zhNX9cFWje8tMqMlt2sJFQqMoiof2q5k9Pmpc2V
        KZmiZTNRUypchkMxxVkrpyutma6LLbVooo5KcVEZVoRatJIubl+3/57neX/P+/HCRxHCi14i
        KiE5jVEly5Riksc2P/j6ZImgUi5f1t4fLjUMFpPS21WlLGmptR9JLc+CpY6S10g66aogI8go
        U11QVG+PJqqxXjtlujKjJhrn7vDay1srZ5QJRxjV0vX7eYrxc8Gp+mnproG7RDbK5hYgLgV0
        GNjvn2EVIB4lpOsQ5BqcJDafEDS13CGwmUBwvaiYU4AoT6W/NwjntQjKut+y/kL3HhVwsGlC
        UJVjJ92PsOmFUGEqIdxtkg6CHC3HHfvSYhjLt3p4gn6IYGRoku0e+NCb4ZbBgNw8n14FIy98
        3TGf9gZb+SsPwqVDwVBzkoNvEEO2qZuN9XGw5LZ7dgLtoMB8fgjhQSSUD7aRWPvAaGfT7/Js
        6Cor/F3OhNeOSQKX8xAUtxhJfPIaKOpWuiVBJ8DLPD+Mb4SK70YvTAjA8cHbHRNTstR8gcAx
        H06fEmJ6ERiG3rNxPBsejwtKkFj33126f+t1nj0hoL81TuJ4FtT+oLAMBGPrUj3yqkf+jEad
        FM+oQ5OZoxK1LEmtSY6XxKUkNaKp/9P1o/PTTVQ7OiaxIhaFrAgoQuzLjy2Kkwv5ctmxDEaV
        sk+lUTJqK5pFscX+/OB1tjghHS9LYw4xTCqj+jNlUVxRNmu3Y+ByWsjXBldR1tVrK7W7bE30
        8xuLFd/ztytsxifRNdUDm97KzfZVHemTcT+HpmtXd1rWWSIyFGdrCocZZsmHnMP1luHyvsr5
        kvSRltHeMtm7GU+3BV+6G26I2aCbXjgn7DEa3Ki/tmJBtVyXMjPWki9gwvqGI041jxwMCNHf
        O2bRb01dqBSL3ogaTJe1xtYTB+9/TJy5hSt1DvZ8yfuc1dGe6RIcN8bM1+7Z8O15xpUq5yN9
        D1diinQFBFa2BWS1psXYEp25O32m8SKd0Tvv+LU+eF/9Mr+vObbDaj+QzjGH2oRt58YOnRVt
        PvlsjV0zsbc3Orw90XVzq3fNvJbx82K2WiFbHkSo1LJfnoPrcq4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMIsWRmVeSWpSXmKPExsVy+t/xu7p881NSDGb1K1msvtvPZrFn0SQm
        i0mHrjFa7L2lbXFjwlNGi98/5rA5sHlsXqHlcflsqcemVZ1Azulqj8+b5AJYo/RsivJLS1IV
        MvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQyJr89w1Rwl6Oi498O
        1gbGa2xdjBwcEgImEtcua3UxcnEICSxllJj+8zNTFyMnUFxGYuOXq6wQtrDEn2tdbBBFHxkl
        bp9+CeVsYZS4fOoGWAeLgKrEnM0TmEGmsgloSTR2soOERQSUJD62H2IHqWcWOMEoMXniCbB6
        YQFnid2rVzOC1PMKmEs8vyMCYgoJREqc+WMOUsErIChxcuYTFhCbWUBHYsHuT2A3MwtISyz/
        xwES5hQwkli9tJUd4kwliYbNZ1gg7FqJzlen2SYwCs9CMmkWkkmzECYtYGRexSiSWlqcm55b
        bKhXnJhbXJqXrpecn7uJERhb24793LyDcd6rj3qHGJk4GA8xSnAwK4nwBvYlpwjxpiRWVqUW
        5ccXleakFh9iNAWGw0RmKdHkfGB055XEG5oZmBqamFkamFqaGSuJ83oWdCQKCaQnlqRmp6YW
        pBbB9DFxcEo1MLlxsVQVhU/emHW75swG/fmNemX12reeO7JJ7J7SYRw72SRqV0HgMhmX3vt8
        u1y/XpPaMac59cM0J6/rRzKv7fNdpx/w7UNH/UcN2dMpOXPm9mdFzj6lZGTAcv6txsn+JH7j
        +PliW7+tS1jjNn9K4yyTrisJknO4c4XYNiew5gldX+8qtvF+X3hrX1NaTPukCSwX+9dKds5/
        +9rC8krzgqPZ/98/LBPSFK5Ls74hf2hOgqfZVy4DhefatrxP3vvLHBX/U2G25Fu+npK7059t
        y82aBKVZW+4UbawLvrjyiMrJo5Yr+nOX8Vv9uP0x0Kiq9Fcmf0CJ4Y43vvOkJmaG3z3ySqDO
        NHirp113uL6qEktxRqKhFnNRcSIAuyPrzjYDAAA=
X-CMS-MailID: 20230517093158eucas1p2831fd21a6f66ae39c887ad91e098aa74
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----nt9vO67.b8K_looarrbd7-OVwn-OXfZhK5OxcWyp3fprDND4=_1baa81_"
X-RootMTR: 20230517093158eucas1p2831fd21a6f66ae39c887ad91e098aa74
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230517093158eucas1p2831fd21a6f66ae39c887ad91e098aa74
References: <20230306120127.21375-1-hare@suse.de>
        <20230306120127.21375-6-hare@suse.de>
        <CGME20230517093158eucas1p2831fd21a6f66ae39c887ad91e098aa74@eucas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

------nt9vO67.b8K_looarrbd7-OVwn-OXfZhK5OxcWyp3fprDND4=_1baa81_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

Hi Hannes,

> @@ -309,8 +311,8 @@ static void brd_submit_bio(struct bio *bio)
>  		int err;
I think you missed the conversion from "kernel" logical sectors to the
device logical sector here:
sector_t sector = bio->bi_iter.bi_sector >> 
                 (brd->brd_logical_sector_shift - SECTOR_SHIFT);

This fixes the issue when you try to do a fio with -verify on a 4k
logical and physical block size.
>  
>  		/* Don't support un-aligned buffer */
> -		WARN_ON_ONCE((iter.offset & (SECTOR_SIZE - 1)) ||
> -				(len & (SECTOR_SIZE - 1)));
> +		WARN_ON_ONCE((iter.offset & (brd->brd_logical_sector_size - 1)) ||
> +				(len & (brd->brd_logical_sector_size - 1)));
>  
>  		err = brd_do_folio(brd, iter.folio, len, iter.offset,
>  				   bio->bi_opf, sector);
> @@ -322,7 +324,7 @@ static void brd_submit_bio(struct bio *bio)
>  			bio_io_error(bio);
>  			return;
>  		}
> -		sector += len >> SECTOR_SHIFT;
> +		sector += len >> brd->brd_logical_sector_shift;
As you can see here, you divide the len with device logical block size
to go to the next sector.
>  	}
>  
>  	bio_endio(bio);

------nt9vO67.b8K_looarrbd7-OVwn-OXfZhK5OxcWyp3fprDND4=_1baa81_
Content-Type: text/plain; charset="utf-8"


------nt9vO67.b8K_looarrbd7-OVwn-OXfZhK5OxcWyp3fprDND4=_1baa81_--
