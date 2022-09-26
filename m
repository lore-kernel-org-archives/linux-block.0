Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63CBEC32771
	for <linux-block@archiver.kernel.org>; Mon, 26 Sep 2022 19:21:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiIZTVC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Sep 2022 15:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiIZTU5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Sep 2022 15:20:57 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6560153D1A
        for <linux-block@vger.kernel.org>; Mon, 26 Sep 2022 12:20:56 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220926192052euoutp0123f0d082abd88af94d4a39c4bfdaadfb~Yf1IRhSo72176021760euoutp01w
        for <linux-block@vger.kernel.org>; Mon, 26 Sep 2022 19:20:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220926192052euoutp0123f0d082abd88af94d4a39c4bfdaadfb~Yf1IRhSo72176021760euoutp01w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1664220052;
        bh=X++mE2ByEzokEDClLxup2f2vw6yQoBjtIgNUQh5MEXs=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=kj2ZmU97UGqG8NgFCzX3ydofR+WgnPMOd3CAdYQmdRQdz4IbPe3Wx1b1mogLpoX2M
         0o2hmdySkgXh+/YCDZwfWgJr7dSEk9jhXJRcpJgJu+/QQilQ6bebojE6APYSN62OF9
         JG+7boNmUU9d5+tdNqUUp7u1+4dct5AGj7fXLzMA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220926192051eucas1p13a54c0ebe76eacd0c4acbd40d471da75~Yf1HXhTnR1226712267eucas1p1m;
        Mon, 26 Sep 2022 19:20:51 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id A8.43.07817.39BF1336; Mon, 26
        Sep 2022 20:20:51 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220926192051eucas1p24a13d322a97347573619541cfc0d7452~Yf1Gqgwvw3118331183eucas1p2W;
        Mon, 26 Sep 2022 19:20:51 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220926192051eusmtrp260555975eaea56f23286ac9d0eb19b8f~Yf1Gp774y1242912429eusmtrp2M;
        Mon, 26 Sep 2022 19:20:51 +0000 (GMT)
X-AuditID: cbfec7f4-8abff70000011e89-e4-6331fb9328f1
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 24.A0.10862.29BF1336; Mon, 26
        Sep 2022 20:20:50 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220926192050eusmtip1ee5f24cbbb3c1875dfa119f1c597d11f~Yf1Ge9CHo1238212382eusmtip1g;
        Mon, 26 Sep 2022 19:20:50 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.168) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Mon, 26 Sep 2022 20:20:49 +0100
Message-ID: <a943acf8-f367-a1ba-0d57-2948a3ade6f4@samsung.com>
Date:   Mon, 26 Sep 2022 21:20:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
        Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] block: modify blk_mq_plug() to allow only reads for
 zoned block devices
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>
CC:     <linux-block@vger.kernel.org>, <damien.lemoal@opensource.wdc.com>,
        <gost.dev@samsung.com>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <2ee6a897-87e7-0592-2482-9928a9a63ff6@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.168]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjleLIzCtJLcpLzFFi42LZduzned3Jvw2TDRo3almsvtvPZvH77Hlm
        i9MTFjFZ7L2l7cDisXmFlsfls6UeO1vvs3p83iQXwBLFZZOSmpNZllqkb5fAlfHq9H32grm8
        FffOv2ZvYDzI1cXIySEhYCLRPeMhE4gtJLCCUWL17couRi4g+wujxLp17awQzmdGie/THrN1
        MXKAdXx8LQ4RX84o0TBjPSNc0aZf09khnN2MEtuP32MBmcsrYCexaeVdsB0sAqoSJx4+ZYeI
        C0qcnPkErEZUIFJize6zYHFhgSSJg3/Os4LYzALiEreezAfrFRFwl7h/4ARUPF5ib1M/E8hF
        bAJaEo2d7CAmp4CtROeNLIgKTYnW7b/ZIWx5ie1v5zBDfKwssfz0TCi7VmLtsTNgJ0sI3OGQ
        OH0C4gQJAReJS9sPQdnCEq+Ob4GyZST+74Q4R0KgWuLpjd/MEM0tjBL9O9dDQ8haou9MDkSN
        o8SZfwuYIcJ8EjfeCkLcwycxadt05gmMqrOQAmIWkodnIXlhFpIXFjCyrGIUTy0tzk1PLTbK
        Sy3XK07MLS7NS9dLzs/dxAhMKqf/Hf+yg3H5q496hxiZOBgPMUpwMCuJ8P4+apgsxJuSWFmV
        WpQfX1Sak1p8iFGag0VJnJdthlaykEB6YklqdmpqQWoRTJaJg1OqgWkx44dHk0/FTzmt2hNx
        KjbQVcHOtyFYPKZNZ8sWld7VLUfllm08/PnFL9kehSPunLe2x51n7l2S5876W5vvRbFH2pyH
        sfx5Rv297yWlmR8843xVnHvTJ8dW+CejzPGmzIwTzxsCOBjWfV1xJPKfebLo5rlH7yhcPvNl
        SkhLd0Ju3puzEw4ynIi4/l+FzzNY+LDoOp9T7g9uTf9WWKGUJckS822qReA+3pMJYu82/f8d
        +3LtvG3Wak/cHoaYcHdkFYrla0tJZWp0yX6OEdcrual7X+Nt/9mJq9bo3Fnxsc/34fmiyZ+v
        Tf45Uc4izYJ19Q6XvBPvhbNesnb+9DNQfCVT8vLVDHWzp5HbVL/qSiuxFGckGmoxFxUnAgCQ
        T26XmQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNIsWRmVeSWpSXmKPExsVy+t/xu7qTfhsmGzzvtLJYfbefzeL32fPM
        FqcnLGKy2HtL24HFY/MKLY/LZ0s9drbeZ/X4vEkugCVKz6Yov7QkVSEjv7jEVina0MJIz9DS
        Qs/IxFLP0Ng81srIVEnfziYlNSezLLVI3y5BL+PV6fvsBXN5K+6df83ewHiQq4uRg0NCwETi
        42vxLkZODiGBpYwSPV+4QWwJARmJT1c+skPYwhJ/rnWxdTFyAdV8ZJSY8/A+I4Szm1Hi3PqN
        LCBVvAJ2EptW3mUCsVkEVCVOPHzKDhEXlDg58wlYjahApMTDZU1gNcICSRIH/5xnBbGZBcQl
        bj2ZDxYXEXCXuH/gBFQ8XmJvUz8TxLLXTBL/Hn9mBbmaTUBLorGTHcTkFLCV6LyRBVGuKdG6
        /Tc7hC0vsf3tHGaIB5Qllp+eCWXXSry6v5txAqPoLCTXzUJyxSwko2YhGbWAkWUVo0hqaXFu
        em6xkV5xYm5xaV66XnJ+7iZGYCxuO/Zzyw7Gla8+6h1iZOJgPMQowcGsJML7+6hhshBvSmJl
        VWpRfnxRaU5q8SFGU2AQTWSWEk3OByaDvJJ4QzMDU0MTM0sDU0szYyVxXs+CjkQhgfTEktTs
        1NSC1CKYPiYOTqkGpvL+1X0Z2ttfL5/2vCPgB2d1/1HDU15uM3ZsKbNqNTv/O5L5ilzndE1u
        Vo5wzrfh3Dfks9bPePhz2orpnCsCklXt+SsvHwnWmi0fsF9cRDlpWuziDVMN9nh1yK9udYze
        f+4/O3/wvJj+5ot3jBp/HNFzYs2WnnugjsmyV/tB8tSFN8uFFm1j2Tvv6dF3bL5zRc5nHd3x
        PXWvs8irKLMbXgoPDfvusq+dKi0vtJr5tkpqg/DCT8WBMckpv35+bj2xzcTuVbFORcmXrqdz
        yw7NnDWf/ZYzf4JNWNSlt31fUj5o+x6Ot7taUq3Nqn7rZaGB6oQddYF1zDLC06/FVl7sPq56
        vr5Luf38Jqlv1nL3lFiKMxINtZiLihMBz5BkjE4DAAA=
X-CMS-MailID: 20220926192051eucas1p24a13d322a97347573619541cfc0d7452
X-Msg-Generator: CA
X-RootMTR: 20220925185350eucas1p1fc354429027a88de7e548a3a4529b4ef
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220925185350eucas1p1fc354429027a88de7e548a3a4529b4ef
References: <20220925185348.120964-1-p.raghav@samsung.com>
        <CGME20220925185350eucas1p1fc354429027a88de7e548a3a4529b4ef@eucas1p1.samsung.com>
        <20220925185348.120964-2-p.raghav@samsung.com>
        <YzG5RgmWSsH6rX08@infradead.org>
        <d5975b62-f2e9-dcde-e332-a73cca1f7fbf@kernel.dk>
        <YzG6fZdz6XBDbrVB@infradead.org>
        <2ee6a897-87e7-0592-2482-9928a9a63ff6@kernel.dk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022-09-26 18:32, Jens Axboe wrote:
> On 9/26/22 8:43 AM, Christoph Hellwig wrote:
>> On Mon, Sep 26, 2022 at 08:40:54AM -0600, Jens Axboe wrote:
>>> On 9/26/22 8:37 AM, Christoph Hellwig wrote:
>>>> On Sun, Sep 25, 2022 at 08:53:46PM +0200, Pankaj Raghav wrote:
>>>>> Modify blk_mq_plug() to allow plugging only for read operations in zoned
>>>>> block devices as there are alternative IO paths in the linux block
>>>>> layer which can end up doing a write via driver private requests in
>>>>> sequential write zones.
>>>>
>>>> We should be able to plug for all operations that are not
>>>> REQ_OP_ZONE_APPEND just fine.
>>>
>>> Agree, I think we just want to make this about someone doing a series
>>> of appends. If you mix-and-match with passthrough you will have a bad
>>> time anyway.
>>
>> Err, sorry - what I wrote about is compelte garbage.  I initially
>> wanted to say you can plug for REQ_OP_ZONE_APPEND just fine, and then
>> realized that we also want various other ones that have the write bit
>> set batched.  So I suspect we really want to explicitly check for
>> REQ_OP_WRITE here.
> 
> My memory was a bit hazy, since we have separate ops for the driver
> in/out, I think just checking for REQ_OP_WRITE is indeed the right
> choice. That's the single case we need to care about.
> 
Ah. You are right. I missed it as well. There is even a comment from Christoph:

 *   - if the least significant bit is set transfers are TO the device
 *   - if the least significant bit is not set transfers are FROM the device

I guess the second patch should be enough to apply plugging when applicable
for uring_cmd based nvme passthrough requests.

