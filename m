Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ABF5C05027
	for <linux-block@archiver.kernel.org>; Mon,  6 Feb 2023 16:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbjBFQLC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Feb 2023 11:11:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231718AbjBFQKz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Feb 2023 11:10:55 -0500
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8196252BB
        for <linux-block@vger.kernel.org>; Mon,  6 Feb 2023 08:10:33 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230206161029euoutp0299a40c15c26deb66505b4bb4ae9118a4~BSB3ewj5k2289522895euoutp02m
        for <linux-block@vger.kernel.org>; Mon,  6 Feb 2023 16:10:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230206161029euoutp0299a40c15c26deb66505b4bb4ae9118a4~BSB3ewj5k2289522895euoutp02m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1675699829;
        bh=KwqIfnaMCdcPNNA877/cf4Jb1KTTKgjFLq02LqKcLLs=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=loKuK9g09c1RVKd+cUfTh8QOKGOzPKziugSN5E6ZkZh8eVPTelm7RqkGt8h5lZyyU
         Rr1PJs5Ohl/aTk/uwZrJ9d6kCENUuDK+lsZ73W/Z1CD2O2ChArmFUj3ZijChbbiH/n
         VcujQju+bAez80biH6+3wiTiJsWS8e6dcgKsbGMo=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230206161028eucas1p183b87b561bb7b75e3ca4b5683f79b1de~BSB2X_sho0830308303eucas1p12;
        Mon,  6 Feb 2023 16:10:28 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 81.FE.13597.47621E36; Mon,  6
        Feb 2023 16:10:28 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230206161027eucas1p2fb014bbe7b69f3bf4ec1ff4b9edc64ba~BSB2EAUIb0105301053eucas1p20;
        Mon,  6 Feb 2023 16:10:27 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230206161027eusmtrp28b1854f87e136fe15fb2a0ac52a21237~BSB2BO0rV0805208052eusmtrp2H;
        Mon,  6 Feb 2023 16:10:27 +0000 (GMT)
X-AuditID: cbfec7f4-207ff7000000351d-7d-63e126741118
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 15.9E.02722.37621E36; Mon,  6
        Feb 2023 16:10:27 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230206161027eusmtip2524d03efdec77f9169817980fbfa4ec4~BSB14n0PX2791827918eusmtip20;
        Mon,  6 Feb 2023 16:10:27 +0000 (GMT)
Received: from [192.168.1.19] (106.210.248.242) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Mon, 6 Feb 2023 16:10:25 +0000
Message-ID: <62f6beda-a946-638b-950a-444a5705dcce@samsung.com>
Date:   Mon, 6 Feb 2023 21:40:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.4.2
Subject: Re: [PATCH] brd: improve performance with blk-mq
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
CC:     <axboe@kernel.dk>, <mcgrof@kernel.org>, <gost.dev@samsung.com>,
        <linux-block@vger.kernel.org>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <20230206155048.GA13392@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.242]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjleLIzCtJLcpLzFFi42LZduznOd0StYfJBp+O81usvtvPZrFy9VEm
        i723tC1uTHjK6MDicflsqcemVZ1sHrtvNrB5fN4kF8ASxWWTkpqTWZZapG+XwJXx6fIdpoIP
        HBXvZn1mbGDsYO9i5OSQEDCRmLfwMQuILSSwglHixeLCLkYuIPsLo8SDs8tYIJzPjBJTdp1m
        gum49PYEG0THckaJRzs84Io+b+tnhHB2MkrMadzPCFLFK2AncfvAOWYQm0VAReLssbcsEHFB
        iZMzn4DZogJREk0XfoLZwgKWEouOHgWrZxYQl7j1ZD7YZhEBJYmnr84yQsSTJZ6/vwF0BQcH
        m4CWRGMn2DucAjoSu1q/skCUaEq0bv/NDmHLS2x/O4cZ4gFliS+f3kDZtRKnttxiArlZQuAO
        h8TGp0uZQWZKCLhI3HutDlEjLPHq+BZocMlI/N85HxoQ1RJPb/xmhuhtYZTo37meDaLXWqLv
        TA6E6SjRsU0bwuSTuPFWEOIaPolJ26YzT2BUnYUUDrOQ/DsLyQOzkDywgJFlFaN4amlxbnpq
        sVFearlecWJucWleul5yfu4mRmBSOf3v+JcdjMtffdQ7xMjEwXiIUYKDWUmE1/TAg2Qh3pTE
        yqrUovz4otKc1OJDjNIcLErivNq2J5OFBNITS1KzU1MLUotgskwcnFINTHHnWlvV/U7lT1jN
        diyn4Idd6gr96pcNr49X7Jf8Pv1SteGb2mrx+9tcz01eb1DF5RCRH9h8OviqdIq1iezU2Re6
        sqq2P6vu9z94J1O+KFTX6eL9quU9b24uZl9k8/JWS2N/4jGrXfGz5Rb+XD7F/Br7Z+9lYirF
        cS4HtX6bsz/9/PP1EXbWlvMFij9aHhUGn79hxsGwXXs68/5rKpJZfWqH+I6eu3Q8P3xh8T7n
        0iOZD196TT6/R/uZ+b2DHi8/TpZc29Iq+3Opps+P/EcXmHuMyjRWLOxItuh7aLxGTqrr6odj
        HmuXcZkrNtxVFmwX0dPME4o53nV7jvCRzOmZiTGzZk1zj1CPPduttWzWLSWW4oxEQy3mouJE
        ANYpBK6ZAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHIsWRmVeSWpSXmKPExsVy+t/xe7rFag+TDe5fNbVYfbefzWLl6qNM
        FntvaVvcmPCU0YHF4/LZUo9NqzrZPHbfbGDz+LxJLoAlSs+mKL+0JFUhI7+4xFYp2tDCSM/Q
        0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS/j0+U7TAUfOCrezfrM2MDYwd7FyMkhIWAi
        centCbYuRi4OIYGljBKfb15ihkjISHy68hGqSFjiz7UuNhBbSOAjo8S3+1kQDTsZJaYuvMwI
        kuAVsJO4feAcWDOLgIrE2WNvWSDighInZz4Bs0UFoiRunn/IBGILC1hKLDp6FKyeWUBc4taT
        +WBxEQEliaevzjJCxJMlnr+/AXXdXUaJq78XABVxcLAJaEk0doIdxymgI7Gr9SsLRL2mROv2
        3+wQtrzE9rdzoJ5Rlvjy6Q2UXSvx+e8zxgmMorOQnDcLyRmzkIyahWTUAkaWVYwiqaXFuem5
        xYZ6xYm5xaV56XrJ+bmbGIERue3Yz807GOe9+qh3iJGJg/EQowQHs5IIr+mBB8lCvCmJlVWp
        RfnxRaU5qcWHGE2BYTSRWUo0OR+YEvJK4g3NDEwNTcwsDUwtzYyVxHk9CzoShQTSE0tSs1NT
        C1KLYPqYODilGpicVwVtu7nWbmKFmbv2ypM33umGM7uXrOGPC1g35cNWm8tFs1KYjPObOGUa
        WQ5Hbf7dd4L7rfGyX2z/DrF1v5zyw/6Sz9TnqmpNNeUF5f+f+n9+xjs5Zffi+YUdt5IObe0U
        n+V+52D//vW+F3cabP8SZbh9Y+l9D97jFTaCmg0nFvsc6btV+33djnb/lpdz+wr1BRZ2ylWU
        Zro/fzrzWbezHmuvbu7ENU2sEeZKjFOiIzts9tmc+x3fJ5m1uHHSa9XlemzGs213OHc/Stmc
        bnYtLtvi99dN8RK6exMeOnqnu8qExtYX8Kke27jPrfDTwyDO72o7Ls9/Y76D5U7An32fG3ur
        jtxrurP/+aWlcuVKLMUZiYZazEXFiQBb9laqUQMAAA==
X-CMS-MailID: 20230206161027eucas1p2fb014bbe7b69f3bf4ec1ff4b9edc64ba
X-Msg-Generator: CA
X-RootMTR: 20230203103127eucas1p293a9fa97366fc89c62f18053be6aca1f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230203103127eucas1p293a9fa97366fc89c62f18053be6aca1f
References: <20230203103005.31290-1-p.raghav@samsung.com>
        <CGME20230203103127eucas1p293a9fa97366fc89c62f18053be6aca1f@eucas1p2.samsung.com>
        <20230203103005.31290-2-p.raghav@samsung.com>
        <20230206155048.GA13392@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2023-02-06 21:20, Christoph Hellwig wrote:
> On Fri, Feb 03, 2023 at 04:00:06PM +0530, Pankaj Raghav wrote:
>> move to blk-mq based request processing as brd is one of the few drivers
>> that still uses submit_bio interface. The changes are pretty trivial
>> to start using blk-mq. The performance increases up to 125% for direct IO
>> read workloads. There is a slight dip in performance for direct IO write
>> workload but considering the general performance gain with blk-mq
>> support, it is not a lot.
> 
> Can you find out why writes regress, and what improves for reads?
> 
Definitely. I tried to do similar experiments in null blk with submit_bio
& blk-mq backend and noticed a similar pattern in performance. I will look
into it next week as I am OOO rest of the week.

> In general blk-mq is doing a lot more work for better batching, but much
> of that batching should not matter for a simple ramdisk.  So the results
> look a little odd to me, and extra numbers and explanations would
> really help.

Let me know if you think I am missing something in the code that can cause
this behavior! Thanks.
