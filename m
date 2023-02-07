Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 710EAC636CC
	for <linux-block@archiver.kernel.org>; Tue,  7 Feb 2023 10:43:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbjBGKno (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Feb 2023 05:43:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbjBGKnj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Feb 2023 05:43:39 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99F63867B
        for <linux-block@vger.kernel.org>; Tue,  7 Feb 2023 02:43:17 -0800 (PST)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230207104313epoutp04e4f5d23a859ba266b51d202fe53e98ed~BhNatY_iW1157211572epoutp04p
        for <linux-block@vger.kernel.org>; Tue,  7 Feb 2023 10:43:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230207104313epoutp04e4f5d23a859ba266b51d202fe53e98ed~BhNatY_iW1157211572epoutp04p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1675766593;
        bh=lweFp9Pww97bIYY0DHmWYz/OYOVsYMzYNtBeBfeyzKo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fHAuNv3Dr6krn7WRxlfTSFaO0P5ey4OjjoUu4OxX+I2H7PmBzojt+a5WoW8KyDoEw
         Yux+AccBOGxdzGxHL4kvuD9Gwdf3G6FU1RAvyV+DlorhTwfHon7VpEFf2SWknOJgIi
         Tgvl6uwwPF0hxoyyLrT1jjnEwTHKbU+6rZNsX2wk=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20230207104313epcas5p4901ed578403416aaf71fe51f6b4d59a5~BhNaP3Wdc0172901729epcas5p4u;
        Tue,  7 Feb 2023 10:43:13 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4PB08b6CMfz4x9Pq; Tue,  7 Feb
        2023 10:43:11 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7F.2F.06765.F3B22E36; Tue,  7 Feb 2023 19:43:11 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20230207103212epcas5p41c50a45f9d892a53915e04b604a40149~BhDyWhe2C1201912019epcas5p4M;
        Tue,  7 Feb 2023 10:32:12 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230207103212epsmtrp2f9698a79952da27f631ad45a77670cd9~BhDyUZFxv1212512125epsmtrp2R;
        Tue,  7 Feb 2023 10:32:12 +0000 (GMT)
X-AuditID: b6c32a4b-20fff70000011a6d-7f-63e22b3f8b4b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        F5.04.17995.BA822E36; Tue,  7 Feb 2023 19:32:11 +0900 (KST)
Received: from green5 (unknown [107.110.206.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230207103209epsmtip23687863b7a9e7fcc325b92ffe72fb123~BhDv-BsVF0242602426epsmtip2W;
        Tue,  7 Feb 2023 10:32:09 +0000 (GMT)
Date:   Tue, 7 Feb 2023 16:01:41 +0530
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Hans Holmberg <Hans.Holmberg@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Matias =?iso-8859-1?Q?Bj=F8rling?= <Matias.Bjorling@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Dennis Maisenbacher <dennis.maisenbacher@wdc.com>,
        Ajay Joshi <Ajay.Joshi@wdc.com>,
        =?iso-8859-1?Q?J=F8rgen?= Hansen <Jorgen.Hansen@wdc.com>,
        "andreas@metaspace.dk" <andreas@metaspace.dk>,
        "javier@javigon.com" <javier@javigon.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "hans@owltronix.com" <hans@owltronix.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "guokuankuan@bytedance.com" <guokuankuan@bytedance.com>,
        "viacheslav.dubeyko@bytedance.com" <viacheslav.dubeyko@bytedance.com>,
        "hch@lst.de" <hch@lst.de>
Subject: Re: [LSF/MM/BPF BoF]: A host FTL for zoned block devices using UBLK
Message-ID: <20230207103141.GC27856@green5>
MIME-Version: 1.0
In-Reply-To: <Y+D3Sy8v3taelXvF@T590>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA01Tf0wTZxjOd1eOg61wIIQPdEpOFxAGtKPg4UA2JeYSNWMKfziz0Et7o0i5
        63rtUKaOCqwCiqASoTpW2RJ+TpCxyiAgFBkCS7ZIhmjQGSi6MAZbibBpgmu5svjf8z7P+7zv
        977f9+Fo4CwWhudwBlbPMVoS85XYBrdHxqRGT6tkfz+VUXXfRlCd/8xIqBLzMkJZh2ZRyvSb
        CaEq54e8qS+rW7yoppYhhCod+wWhKipnUOqCfQJQvQ+iqcovnqHUZOUsoOwXixDK2XkFoc60
        z4N3A+jVO60YPdA2L6GLrFMSuqO5FKN77hdi9A1bNaAHO+q96MW+XzF6qWMzbe4vR9J9P8xN
        1rCMmtWHs5yKV+dw2SnkvkNZe7ISEmXyGHkStYMM55g8NoVM258eszdH65qHDP+U0RpdVDoj
        CGTcrmQ9bzSw4RpeMKSQrE6t1Sl0sQKTJxi57FiONeyUy2RvJ7gSlbkax6S/bnnTsevlVVgh
        KA8pAz44JBRwYa4MlAFfPJDoAXCu4qoncAJYf3vZWwyWAPz53zvYuuX59EsvUegGsPN8CXAL
        gYQDQNPKWpKE2AaLJh653DiOEdFw7CXupoMIEj582LJWFCXKMbhod0rcwgZiP3zx1VlvN5a6
        8vueF2MiDoAjtY61HB9XzR8vOxE3Dia2wn7bMOIuBInfcVg32Ogtni4NXlvtRUW8Ac4Nd3r4
        MLi00OuZIB82XWrERHMxgJZ7FiAKqbBk9PyaGSU08GzNuKfQG7B69Doi8n7w3AsHIvJS2FW3
        jrfC1jarp0EonFgxeTANpxoWEHFdFwEc/WkcrQRbLK9MZ3mln4jfgtYeJ2ZxbQ8lNsKGVVyE
        22Fbd5wVeDWDUFYn5GWzQoIunmPz/79xFZ/XAdbee9S+LjD9+K9YO0BwYAcQR8kgaUL/Y1Wg
        VM0cL2D1fJbeqGUFO0hw3VYVGhas4l0fhjNkyRVJMkViYqIiKT5RToZII1JGVIFENmNgc1lW
        x+rXfQjuE1aIcDM9KVf4P65urvN/zXL3uxu3a5KjW99M44IOdyVlXrosCzrNpzY8gWccu0q7
        l8m8p4b3nZ9n+K7k+CxI809Ujyh/gEdOR4Qsfn9oGVeV0Z+cRHfe6s2wNhSfOjVRmvVkKnrT
        SVNZ2sBozIko82fvFcoLjOqp14Pb2yP4lka9MihVufudjrHCWkXNDu7R4Vv+2pEj5oFyJq5e
        6O7p3DM8lnn0z9ySBU1o1E3lQeRaV8aFJse5j/r81PcKev2sH3xssdHxAw805mNVtootByJt
        949uHIycHLkJ+saFbSt7D0aZZ5pwv9V2hij5mn+mtgXwtcZ2ZVH/5Dem4wcim3ffzRwjJYKG
        kUeheoH5D1HWJGp4BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGIsWRmVeSWpSXmKPExsWy7bCSvO5qjUfJBrcemFvMW6tuseXHYxaL
        1vZvTBYLjj5ltmi838hkMeHNUXaLuVNXs1qsXH2UyaLz9AUmi74Jj5ktJh26xmix95a2xYS2
        r8wWNyY8ZbQ4NLmZyeLTltlMFh0b3jA6CHr8O7GGzePg+jcsHs0L7rB4bFrVyeax+2YDm8fG
        bVMZPQ5vWsTq8X7fVTaPz5vkPNoPdDMFcEVx2aSk5mSWpRbp2yVwZWxctZK1YJtUxfKHn1kb
        GJ+IdDFyckgImEj8evSftYuRi0NIYAejxJ7LK1ghEpISy/4eYYawhSVW/nvODlH0iFHi6+wT
        bCAJFgEVieZr94ASHBxsAtoSp/9zgIRFBJQk7t5dDVbPLDCZTWL72XMsIAlhAR+J3/N72EFs
        XqD6fb9awOYICThKHH9/mgUiLihxcuYTMJtZQEvixr+XTCDzmQWkJZb/A5vPCbT22PRPTCC2
        qICyxIFtx5kmMArOQtI9C0n3LITuBYzMqxglUwuKc9Nziw0LjPJSy/WKE3OLS/PS9ZLzczcx
        gqNSS2sH455VH/QOMTJxMB5ilOBgVhLhNT3wIFmINyWxsiq1KD++qDQntfgQozQHi5I474Wu
        k/FCAumJJanZqakFqUUwWSYOTqkGpmUPAp/tjLNZqvMkPXW2yaZDOv84Hv7Q3/ZGlq3q8IbT
        c5XWWrFo88c1f9uQ8WHWYXab9Swqn/anHwxoNy2emHQw9+irJUvyr62bkPlDfQF/kX512R2B
        1PMz822bDhVw5j1r+lXIUnjyc7Xuy0ulexWrl+mtv3KuS2j6tWzeyoBiG7GvdvHb1J5qbptU
        djtO6sgvk9PMWxmPXzl+/LvKjBdNpYHOt86/kndqXub5f7eX9t1Vq0Mse12VqoTfrO8puCXe
        K39uuqvqAknPN7OFzR7vE+pmSq97cejwx/qsZ38mmK7x72GozTfgfNjn+NhGxeZsyBy+kEm2
        k/s2MrD3dzyoj3J89KfScPU2R6bw50osxRmJhlrMRcWJAIdKayg5AwAA
X-CMS-MailID: 20230207103212epcas5p41c50a45f9d892a53915e04b604a40149
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----VcNbGwukI.V.zRsR7h.iegc77RUJaRB20lfGRK.yLUyhK.7S=_44e57_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230207103212epcas5p41c50a45f9d892a53915e04b604a40149
References: <20230206100019.GA6704@gsv> <Y+D3Sy8v3taelXvF@T590>
        <CGME20230207103212epcas5p41c50a45f9d892a53915e04b604a40149@epcas5p4.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

------VcNbGwukI.V.zRsR7h.iegc77RUJaRB20lfGRK.yLUyhK.7S=_44e57_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Mon, Feb 06, 2023 at 08:49:15PM +0800, Ming Lei wrote:
> On Mon, Feb 06, 2023 at 10:00:20AM +0000, Hans Holmberg wrote:
> > I think we're missing a flexible way of routing random-ish
> > write workloads on to zoned storage devices. Implementing a UBLK
> > target for this would be a great way to provide zoned storage
> > benefits to a range of use cases. Creating UBLK target would
> > enable us experiment and move fast, and when we arrive
> > at a common, reasonably stable, solution we could move this into
> > the kernel.
> 
> Yeah, UBLK provides one easy way for fast prototype.
> 
> > 
> > We do have dm-zoned [3]in the kernel, but it requires a bounce
> > on conventional zones for non-sequential writes, resulting in a write
> > amplification of 2x (which is not optimal for flash).
> > 
> > Fully random workloads make little sense to store on ZBDs as a
> > host FTL could not be expected to do better than what conventional block
> > devices do today. Fully sequential writes are also well taken care of
> > by conventional block devices.
> > 
> > The interesting stuff is what lies in between those extremes.
> > 
> > I would like to discuss how we could use UBLK to implement a
> > common FTL with the right knobs to cater for a wide range of workloads
> > that utilize raw block devices. We had some knobs in  the now-dead pblk,
> > a FTL for open channel devices, but I think we could do way better than that.
> > 
> > Pblk did not require bouncing writes and had knobs for over-provisioning and
> > workload isolation which could be implemented. We could also add options
> > for different garbage collection policies. In userspace it would also 
> > be easy to support default block indirection sizes, reducing logical-physical
> > translation table memory overhead.
> > 
> > Use cases for such an FTL includes SSD caching stores such as Apache
> > traffic server [1] and CacheLib[2]. CacheLib's block cache and the apache
> > traffic server storage workloads are *almost* zone block device compatible
> > and would need little translation overhead to perform very well on e.g.
> > ZNS SSDs.
> > 
> > There are probably more use cases that would benefit.
> > 
> > It would also be a great research vehicle for academia. We've used dm-zap
> > for this [4] purpose the last couple of years, but that is not production-ready
> > and cumbersome to improve and maintain as it is implemented as a out-of-tree
> > device mapper.
> 
> Maybe it is one beginning for generic open-source userspace SSD FTL,
> which could be useful for people curious in SSD internal. I have
> google several times for such toolkit to see if it can be ported to
> UBLK easily. SSD simulator isn't great, which isn't disk and can't handle
> real data & workloads. With such project, SSD simulator could be less
> useful, IMO.
> 
> > 
> > ublk adds a bit of latency overhead, but I think this is acceptable at least
> > until we have a great, proven solution, which could be turned into
> > an in-kernel FTL.
> 
> We will keep improving ublk io path, and I am working on ublk
> copy. Once it is done, big chunk IO latency could be reduced a lot.
> 

Just curious, will this also involve running do_splice_direct*() in async style
like normal async read/write, instead of offloading to iowq context ?

Regards,
Nitesh Shetty

------VcNbGwukI.V.zRsR7h.iegc77RUJaRB20lfGRK.yLUyhK.7S=_44e57_
Content-Type: text/plain; charset="utf-8"


------VcNbGwukI.V.zRsR7h.iegc77RUJaRB20lfGRK.yLUyhK.7S=_44e57_--
