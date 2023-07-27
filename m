Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D7E0C0015E
	for <linux-block@archiver.kernel.org>; Thu, 27 Jul 2023 09:01:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234081AbjG0JB5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jul 2023 05:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233622AbjG0JBa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jul 2023 05:01:30 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8409C35B8
        for <linux-block@vger.kernel.org>; Thu, 27 Jul 2023 01:41:26 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230727083200euoutp01329715058577caa0e6505328e4382848~1rFX7CZb00864908649euoutp01h
        for <linux-block@vger.kernel.org>; Thu, 27 Jul 2023 08:32:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230727083200euoutp01329715058577caa0e6505328e4382848~1rFX7CZb00864908649euoutp01h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690446720;
        bh=drqDU0d+zTKrPFYiRH4fyPA8JCseJZMl2OUsEsVduro=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=O1KDSjqd2fvZrV5HVTmjQ/piIaucx/Z9i/+ZJZOQTQwT4BH/ZY5/T+kc13Rr0AIb2
         11wUY2N9D0MgTlHgcRrHwthd3v5dHzS/iqKup3Wfl3K+C1g3rr3lZQ5PJde/0EWORD
         5XZwFREN96UN3emwgrzAQZulnSJ0ZtnMBLn1DwQM=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230727083159eucas1p12b0c9d238b89fc99992f5f74f9aebb27~1rFXchSfL1134011340eucas1p1C;
        Thu, 27 Jul 2023 08:31:59 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id B4.06.11320.F7B22C46; Thu, 27
        Jul 2023 09:31:59 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230727083159eucas1p1c4b907caac8371200bbd465143ac39fd~1rFXISnX_1354313543eucas1p1B;
        Thu, 27 Jul 2023 08:31:59 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230727083159eusmtrp270c1b619cbb9039bbd8feb871bf5b707~1rFXHQEps3117831178eusmtrp2c;
        Thu, 27 Jul 2023 08:31:59 +0000 (GMT)
X-AuditID: cbfec7f4-97dff70000022c38-bb-64c22b7f0d75
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 11.90.14344.F7B22C46; Thu, 27
        Jul 2023 09:31:59 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230727083159eusmtip237bb64cadc6f664c6e935e57884236a5~1rFW8dfCs1851918519eusmtip2y;
        Thu, 27 Jul 2023 08:31:59 +0000 (GMT)
Received: from localhost (106.110.32.140) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Thu, 27 Jul 2023 09:31:58 +0100
Date:   Thu, 27 Jul 2023 10:31:57 +0200
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     Mikulas Patocka <mpatocka@redhat.com>
CC:     Jens Axboe <axboe@kernel.dk>, Li Nan <linan666@huaweicloud.com>,
        Zdenek Kabelac <zkabelac@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        <linux-block@vger.kernel.org>, <dm-devel@redhat.com>,
        <p.raghav@samsung.com>
Subject: Re: [PATCH v2 1/3] brd: extend the rcu regions to cover read and
 write
Message-ID: <20230727083157.bwtndptv6rvoyezs@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7d99fa-9c13-ab2a-acde-1f8bbc63bf3@redhat.com>
X-Originating-IP: [106.110.32.140]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBKsWRmVeSWpSXmKPExsWy7djP87r12odSDH61G1qsvtvPZvH+4GNW
        i73vZrNanJ6wiMniyvlZ7BZ7b2lbTOy4ymRx6d0yZgcOjy87+xk9Nq/Q8rh8ttSjt/kdm8f7
        fVfZPD5vkgtgi+KySUnNySxLLdK3S+DKWPfmFXvBHM6K6Y1n2BsYt7B3MXJySAiYSJyY+o6l
        i5GLQ0hgBaPE+6+9jBDOF0aJnx9WglUJCXxmlLhwOQemY9+2i0wQRcsZJeZs2QTlABUt6D/O
        BuFsYZRoXnuUDaSFRUBVoqP5KlAVBwebgJZEYyfYVBEBTYlLc96wgtQzC0xgkvj8eg0LSEJY
        IFBi2YIpjCA2r4C5xNm9vWwQtqDEyZlPwGqYBXQkFuz+xAYyk1lAWmL5Pw6QMKeAtcSvH+1Q
        vylJNGw+wwJh10qc2nIL7FAJgQ8cEosWNzFCJFwkpm97xgphC0u8Og4LGBmJ/zvnM0HY1RJP
        b/xmhmhuYZTo37kebLEE0La+M9BgcZSY2DWDGSLMJ3HjrSDEmXwSk7ZNhwrzSnS0CUFUq0ms
        vveGZQKj8iwkj81C8tgshMcWMDKvYhRPLS3OTU8tNspLLdcrTswtLs1L10vOz93ECEw8p/8d
        /7KDcfmrj3qHGJk4GA8xSnAwK4nwGsbsSxHiTUmsrEotyo8vKs1JLT7EKM3BoiTOq217MllI
        ID2xJDU7NbUgtQgmy8TBKdXAVHti872C5l9TT/FEbbo1aWU23+n6KU4sXjHd8dNf7rwUrfN0
        7pbYX2dSO5PfTms+KlJnvDLY1D3p67524T/3doTlNb08eel61O5zd6MmTj14UVc11YutIfPT
        lQ1bXmdt+Vv7Z1Giat/3dat+LLGds/Ph9zbWzR7rfs5IrQxNiuE3YPqmWfzv7WvJgBupLu9t
        TVlvFRbNCzn6ZnbNvDt3vimovT3yte3+t67d611mhoYudEkO1Wp1fbmsXbZ0iduX0vLWk1Uz
        RJc6qD42alfOfuNuKRRtFTTD69ST5+1/2382WeZuvvFvL8/Zj2bBGa5cLZM/yd+UYV64LPRa
        zteMqXIr833m3Jlqt0vu8fde7z1KLMUZiYZazEXFiQBEE+doqwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKIsWRmVeSWpSXmKPExsVy+t/xe7r12odSDGZukbNYfbefzeL9wces
        FnvfzWa1OD1hEZPFlfOz2C323tK2mNhxlcni0rtlzA4cHl929jN6bF6h5XH5bKlHb/M7No/3
        +66yeXzeJBfAFqVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mW
        WqRvl6CXse7NK/aCOZwV0xvPsDcwbmHvYuTkkBAwkdi37SJTFyMXh5DAUkaJphu9TBAJGYmN
        X66yQtjCEn+udbFBFH1klNgx+TErhLOFUeLOki/MIFUsAqoSHc1Xgbo5ONgEtCQaO8E2iAho
        Slya8wasnllgApPE9C8nwBLCAoESyxZMYQSxeQXMJc7u7WUD6RUSsJKY/zAGIiwocXLmExYQ
        m1lAR2LB7k9gJcwC0hLL/3GAhDkFrCV+/WiHekZJomHzGRYIu1bi899njBMYhWchmTQLyaRZ
        CJMWMDKvYhRJLS3OTc8tNtIrTswtLs1L10vOz93ECIy/bcd+btnBuPLVR71DjEwcjIcYJTiY
        lUR4DWP2pQjxpiRWVqUW5ccXleakFh9iNAUGxERmKdHkfGACyCuJNzQzMDU0MbM0MLU0M1YS
        5/Us6EgUEkhPLEnNTk0tSC2C6WPi4JRqYNrad+CqglToVbfUZTGMVsEvz+7YKrdcqSBCfmmw
        +64Fl+zLf6snxX15Mls3S/ee5YVrYrdkOZflTlu6snuZo61gbfvey2d+9j/+GLVl4tXwf7b3
        FruwnC5VzJ3JU+Me/iv57S5R3rhbRdsY1ucyJ+poXFlsZPJ6ZZD52ZxtvJF7VScdiDo6b7lJ
        3b3y9H8rVFd6PFZcv/mUvYX5K876A/mT2fPe8kYtuvzm+bHDf6Nqck96TZuQsS3FboLj/Esx
        3SzOl+/oPPldVCZ59JpOo03Ldf2VE0pqZ8+uunqw8paIv/KnL3PPvSnQDWGemRGQr9jMve/h
        5hs7XZffmVOyaNuePw2vfL2NFu37Iii+/eUDJZbijERDLeai4kQAXxJwzkgDAAA=
X-CMS-MailID: 20230727083159eucas1p1c4b907caac8371200bbd465143ac39fd
X-Msg-Generator: CA
X-RootMTR: 20230727083159eucas1p1c4b907caac8371200bbd465143ac39fd
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230727083159eucas1p1c4b907caac8371200bbd465143ac39fd
References: <7d99fa-9c13-ab2a-acde-1f8bbc63bf3@redhat.com>
        <CGME20230727083159eucas1p1c4b907caac8371200bbd465143ac39fd@eucas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> Index: linux-2.6/drivers/block/brd.c
> ===================================================================
> --- linux-2.6.orig/drivers/block/brd.c
> +++ linux-2.6/drivers/block/brd.c
> @@ -150,23 +150,27 @@ static void copy_to_brd(struct brd_devic
>  	size_t copy;
>  
>  	copy = min_t(size_t, n, PAGE_SIZE - offset);
> +	rcu_read_lock();
>  	page = brd_lookup_page(brd, sector);

xa_load() inside brd_lookup_page() also calls rcu read lock. Instead of
nesting rcu locks, could we modify the brd_lookup_page to use:

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 970bd6ff38c4..acc37bfdd181 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -55,7 +55,9 @@ static struct page *brd_lookup_page(struct brd_device *brd, sector_t sector)
        struct page *page;
 
        idx = sector >> PAGE_SECTORS_SHIFT; /* sector to page index */
-       page = xa_load(&brd->brd_pages, idx);
+
+       XA_STATE(xas, &brd->brd_pages, idx);
+       page = xas_load(&xas);
 
        BUG_ON(page && page->index != idx);

>  	BUG_ON(!page);
>  
>  	dst = kmap_atomic(page);
>  	memcpy(dst + offset, src, copy);
>  	kunmap_atomic(dst);
