Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 603D4C77B7C
	for <linux-block@archiver.kernel.org>; Fri,  5 May 2023 08:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbjEEISK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 May 2023 04:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbjEEISJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 May 2023 04:18:09 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DE11637D
        for <linux-block@vger.kernel.org>; Fri,  5 May 2023 01:18:07 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230505081803epoutp0496dde13d9fae889ef48e8ac90f0aff8f~cMWfz9OkK1606116061epoutp04B
        for <linux-block@vger.kernel.org>; Fri,  5 May 2023 08:18:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230505081803epoutp0496dde13d9fae889ef48e8ac90f0aff8f~cMWfz9OkK1606116061epoutp04B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1683274683;
        bh=CRCS6oh6m3XpNSm3tsvDKuxXQ498wrUZ/rFSXXr91MM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HtJEJXHx6C8zVhcCHYP9UmKB+kSn5fOKmbyvec1yP/WqoP2xZDlJwn1yDeW/HR5KF
         yqTtZZRwTyEaESX/rJIqVuJLxg3w816e4X2E53ePijv8KFwDf1/rVvSri19nNnkoWj
         12HQkQkaA5H/Iwnz4W67KK9Nc/wbuoCmE5MzSQtg=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20230505081802epcas5p3323fc5e42c162df7ebd2d9c457f2b0da~cMWfAXd202710927109epcas5p3p;
        Fri,  5 May 2023 08:18:02 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4QCNpx1QVHz4x9Pv; Fri,  5 May
        2023 08:18:01 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B4.B1.55646.8BBB4546; Fri,  5 May 2023 17:18:00 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20230505081759epcas5p3dbc99c12e5566cfcad06b44f20009c40~cMWcOnQ8h1757117571epcas5p3z;
        Fri,  5 May 2023 08:17:59 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230505081759epsmtrp1ad557e1a916d7a2ae3df7201c63edb4e~cMWcN9eoV1537415374epsmtrp1a;
        Fri,  5 May 2023 08:17:59 +0000 (GMT)
X-AuditID: b6c32a4b-b71fa7000001d95e-c8-6454bbb81856
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        FF.74.27706.7BBB4546; Fri,  5 May 2023 17:17:59 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230505081758epsmtip14c58fdd32739b6a452e999c37f411e04~cMWbJlD350194301943epsmtip19;
        Fri,  5 May 2023 08:17:58 +0000 (GMT)
Date:   Fri, 5 May 2023 13:44:55 +0530
From:   Kanchan Joshi <joshi.k@samsung.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
        xiaoguang.wang@linux.alibaba.com
Subject: Re: [RFC 0/3] nvme uring passthrough diet
Message-ID: <20230505081455.GA32732@green245>
MIME-Version: 1.0
In-Reply-To: <ZFJ7pAuTY6ESCVgp@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIJsWRmVeSWpSXmKPExsWy7bCmpu6O3SEpBn0LOC1W3+1ns1i5+iiT
        xaRD1xgtzlxdyGKx95a2xfxlT9ktNv09yeTA7nH5bKnHplWdbB47H1p6bF5S77H7ZgObx7mL
        FR6fN8kFsEdl22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6
        ZeYA3aKkUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJKTAp0CtOzC0uzUvXy0stsTI0
        MDAyBSpMyM64fO0cY8E+mYqjj6oaGCeIdzFyckgImEj0zprL3MXIxSEksJtRYsXsM6wQzidG
        if9bv7CAVAkJfGOU+HzME6bj0sqzUEV7GSXWzZvGAuE8Y5TYc38pUxcjBweLgIrE2z+OICab
        gKbEhcmlIL0iAsoSd+fPBOtlFlgItODPF1aQhLCAkcTJhj3MIPW8AroSf44Vg4R5BQQlTs58
        AnYDp4C9xKbv05hAbFGgOQe2HWcCmSMh0MkhcXbJf0aI41wkbj25wARhC0u8Or6FHcKWknjZ
        3wZlJ0tcmnkOqqZE4vGeg1C2vUTrqX5mEJtZIENi0u52KJtPovf3E7C3JAR4JTrahCDKFSXu
        TXrKCmGLSzycsQTK9pDYd2MzOyRIHjBKLGxcxziBUW4Wkn9mIVkBYVtJdH5oYp0FtIJZQFpi
        +T8OCFNTYv0u/QWMrKsYJVMLinPTU4tNC4zzUsvhMZycn7uJEZw2tbx3MD568EHvECMTB+Mh
        RgkOZiUR3g+FfilCvCmJlVWpRfnxRaU5qcWHGE2BsTORWUo0OR+YuPNK4g1NLA1MzMzMTCyN
        zQyVxHnVbU8mCwmkJ5akZqemFqQWwfQxcXBKNTAd23zR+9a0BxUmR3h1X8eemKEVxx45RWPa
        JGdmlpy9U2LP72zmny4zzSj1bU2s23KTmF0J3B7Hnl2zYSt4JqkvqCwbf2jxm9op4pmFaU5i
        axOk7Q8miSvUz7e++WzPklXsN5Uf7vGduE1ry69Ola8fE21mbcsy/7xIKOJ903FZ1o7au1e0
        ROYnfZ4rpO/0/rTbL/mHF44YJkgy2Hrua5UyfVuTUKKw0fTcfn4zhRs/lmxK92g9z2nf3nYu
        8aWeuO2NFfGr5a48Vbe/Hl3LrS67NPuPcVHHu5y/7a5rkn+IvppyOs0/bfLkeie9drX6qqc2
        dgELOuw8PkocflolXm9qMp/pMN/Pw/sm2x5oea/EUpyRaKjFXFScCACZKb0uJAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrALMWRmVeSWpSXmKPExsWy7bCSnO723SEpBt0/RCxW3+1ns1i5+iiT
        xaRD1xgtzlxdyGKx95a2xfxlT9ktNv09yeTA7nH5bKnHplWdbB47H1p6bF5S77H7ZgObx7mL
        FR6fN8kFsEdx2aSk5mSWpRbp2yVwZfxf+5Sl4INkxdFmiQbGOyJdjJwcEgImEpdWnmXtYuTi
        EBLYzShx58IHRoiEuETztR/sELawxMp/z9khip4wSsx7/R6oiIODRUBF4u0fRxCTTUBT4sLk
        UpByEQFlibvzZ4LNZBZYyCjx/88XVpCEsICRxMmGPcwg9bwCuhJ/jhVDjHzEKHGrfzEzSA2v
        gKDEyZlPWEBsZgEziXmbH4LVMwtISyz/xwES5hSwl9j0fRoTiC0KtOvAtuNMExgFZyHpnoWk
        exZC9wJG5lWMkqkFxbnpucWGBYZ5qeV6xYm5xaV56XrJ+bmbGMGRoKW5g3H7qg96hxiZOBgP
        MUpwMCuJ8H4o9EsR4k1JrKxKLcqPLyrNSS0+xCjNwaIkznuh62S8kEB6YklqdmpqQWoRTJaJ
        g1Oqgcl0q2gix4TfjNIdgq1LbjxJ3VtYLmLHwxR55vW+Myv+WJyPNHhQ1BJjwHfKYv7JzvMn
        +w8qWD7e++7azLa5x/YEL7j11YRl13vxiQfi/i3STmvZ721UWBK+fln5w9/Brk/qL1+3PLPx
        4MI/nEtttk2ZYaOqLhtUJKnVbP+tl1uT+z3rjVfJ73Pk+7jnXPoZ8/ZhYX/pgpWKG0ULj18+
        fvxe7YZtEyvk6gID1+V3n+lrW/x097Hev2oxhu2Lwjlv2V+ROn/8V//Dc2EMgnw+qefvX9uT
        nxF69CX/1MCD/+ass7f4P+8Pj/i1LrVvcnxht/cK5dRVfTkl5P9X/ejv/f43X24yf2Gvdn/q
        pvedVtqKSizFGYmGWsxFxYkAkrsrevMCAAA=
X-CMS-MailID: 20230505081759epcas5p3dbc99c12e5566cfcad06b44f20009c40
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----PdhGkLDwNmEstpipWwkisvJIpjwP47YWkcBE-d9KzOb1cur7=_6c09c_"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230501154403epcas5p388c607114ad6f9d20dfd3ec958d88947
References: <CGME20230501154403epcas5p388c607114ad6f9d20dfd3ec958d88947@epcas5p3.samsung.com>
        <20230501153306.537124-1-kbusch@meta.com> <20230503072625.GA18487@green245>
        <ZFJ7pAuTY6ESCVgp@kbusch-mbp.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

------PdhGkLDwNmEstpipWwkisvJIpjwP47YWkcBE-d9KzOb1cur7=_6c09c_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Wed, May 03, 2023 at 09:20:04AM -0600, Keith Busch wrote:
>On Wed, May 03, 2023 at 12:57:17PM +0530, Kanchan Joshi wrote:
>> On Mon, May 01, 2023 at 08:33:03AM -0700, Keith Busch wrote:
>> > From: Keith Busch <kbusch@kernel.org>
>> >
>> > When you disable all the optional features in your kernel config and
>> > request queue, it looks like the normal request dispatching is just as
>> > fast as any attempts to bypass it. So let's do that instead of
>> > reinventing everything.
>> >
>> > This doesn't require additional queues or user setup. It continues to
>> > work with multiple threads and processes, and relies on the well tested
>> > queueing mechanisms that track timeouts, handle tag exhuastion, and sync
>> > with controller state needed for reset control, hotplug events, and
>> > other error handling.
>>
>> I agree with your point that there are some functional holes in
>> the complete-bypass approach. Yet the work was needed to be done
>> to figure out the gain (of approach) and see whether the effort to fill
>> these holes is worth.
>>
>> On your specific points
>> - requiring additional queues: not a showstopper IMO.
>>  If queues are lying unused with HW, we can reap more performance by
>>  giving those to application. If not, we fall back to the existing path.
>>  No disruption as such.
>
>The current way we're reserving special queues is bad and should
>try to not extend it futher. It applies to the whole module and
>would steal resources from some devices that don't want poll queues.
>If you have a mix of device types in your system, the low end ones
>don't want to split their resources this way.
>
>NVMe has no problem creating new queues on the fly. Queue allocation
>doesn't have to be an initialization thing, but you would need to
>reserve the QID's ahead of time.

Totally in agreement with that. Jens also mentioned this point.
And I had added preallocation in my to-be-killed list. Thanks for
expanding.
Related to that, I think one-qid-per-ring also need to be lifted.
That should allow to do io on two/more devices with the single ring
and see how well that scales.

>> - tag exhaustion: that is not missing, a retry will be made. I actually
>>  wanted to do single command-id management at the io_uring level itself,
>>  and that would have cleaned things up. But it did not fit in
>>  because of submission/completion lifetime differences.
>> - timeout and other bits you mentioned: yes, those need more work.
>>
>> Now with the alternate proposed in this series, I doubt whether similar
>> gains are possible. Happy to be wrong if that happens.
>
>One other thing: the pure-bypass does appear better at low queue
>depths, but utilizing the plug for aggregated sq doorbell writes
>is a real win at higher queue depths from this series. Batching
>submissions at 4 deep is the tipping point on my test box; this
>series outperforms pure bypass at any higher batch count.

I see. 
I hit 5M cliff without plug/batching primarily because pure-bypass
is reducing the code to do the IO. But plug/batching is needed to get
better at this.
If we create space for a pointer in io_uring_cmd, that can get added in
the plug list (in place of struct request). That will be one way to sort
out the plugging.

------PdhGkLDwNmEstpipWwkisvJIpjwP47YWkcBE-d9KzOb1cur7=_6c09c_
Content-Type: text/plain; charset="utf-8"


------PdhGkLDwNmEstpipWwkisvJIpjwP47YWkcBE-d9KzOb1cur7=_6c09c_--
