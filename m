Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41940C77B7F
	for <linux-block@archiver.kernel.org>; Fri, 12 May 2023 10:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240466AbjELKW6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 May 2023 06:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240633AbjELKWz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 May 2023 06:22:55 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA5D100E0
        for <linux-block@vger.kernel.org>; Fri, 12 May 2023 03:22:53 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230512102251euoutp01ca2e68707b800ece0f15be4ca8b4dcba~eXkd21-Ag1447014470euoutp01Y
        for <linux-block@vger.kernel.org>; Fri, 12 May 2023 10:22:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230512102251euoutp01ca2e68707b800ece0f15be4ca8b4dcba~eXkd21-Ag1447014470euoutp01Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1683886971;
        bh=/LfPImlblP+Z6TLjldwD/Mm7CvmcGfSDxjiv70V2QW4=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=NRy3Nd5FBkpcb5RPKL3RKxU7v0Wc3hLnhHnBhvH8Mf+x+RDWh4kVv/LNgfeFIHCiV
         xNPN3oIc7V2IOu4cr4ESeXcaOco6idQeJJZj9Ww/VACuThVURYWxFq/YeRdDvY2dIC
         t9Rd6IcuXgVLiaOlzA4SdosRXLMGAd5m0UUU1Boo=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230512102251eucas1p14270a0af1dbc2c3716558c762f9161be~eXkdkmfip2647526475eucas1p1H;
        Fri, 12 May 2023 10:22:51 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 3B.F1.37758.B731E546; Fri, 12
        May 2023 11:22:51 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230512102250eucas1p1c2182c9c5db664e53dd21241182d7a71~eXkdLN7X22646426464eucas1p1G;
        Fri, 12 May 2023 10:22:50 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230512102250eusmtrp1a1995fc73e002d66b2e29390f125d57b~eXkdGIG-60995409954eusmtrp1i;
        Fri, 12 May 2023 10:22:50 +0000 (GMT)
X-AuditID: cbfec7f5-7ffff7000002937e-a3-645e137bc16c
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E8.A9.14344.A731E546; Fri, 12
        May 2023 11:22:50 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230512102250eusmtip12adac3b4d98cf73453b674a36e06b997~eXkc4h5i91661316613eusmtip1c;
        Fri, 12 May 2023 10:22:50 +0000 (GMT)
Received: from [192.168.8.209] (106.210.248.191) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Fri, 12 May 2023 11:22:49 +0100
Message-ID: <5b505e45-8986-209d-25ea-f260835448e8@samsung.com>
Date:   Fri, 12 May 2023 12:22:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.10.0
Subject: Re: [PATCH] brd: use XArray instead of radix-tree to index backing
 pages
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC:     "gost.dev@samsung.com" <gost.dev@samsung.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>,
        "willy@infradead.org" <willy@infradead.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Content-Language: en-US
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <19a880f2-9c06-c096-9a76-a30552bfbc78@nvidia.com>
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.191]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsWy7djP87rVwnEpBu8ei1qsvtvPZvH+4GNW
        i5WrjzJZ7L2lbfH7xxw2B1aPzSu0PC6fLfXYfbOBzaO3+R2bx+dNcgGsUVw2Kak5mWWpRfp2
        CVwZTUuOMhZ08VQ8m+zewHiNvYuRk0NCwESi9UMrSxcjF4eQwApGiTkrH7BDOF8YJQ4vXcYK
        4XxmlJh3azsTTMuFBb8ZIRLLGSVuX3vABlf1omstVGY3o8TRBz/AWngF7CRe/5vPAmKzCKhK
        dH1bzwwRF5Q4OfMJWFxUIFpi8b4pYLawQLDEvVUHwHpFBPQkrt66AXYUs8BDRomv3zYzgiSY
        BcQlbj2ZD1TEwcEmoCXR2An2ESfQrverbrJBlMhLbH87hxnibGWJyZP/s0HYtRKnttxiApkp
        IfCGQ+Ln7xMsEAkXieOT/0HZwhKvjm+BBpOMxOnJPVDxaomnN34zQzS3MEr071zPBnKEhIC1
        RN+ZHBCTWUBTYv0ufYhyR4nrG1+wQ1TwSdx4KwhxGp/EpG3TmScwqs5CColZSB6bheSDWQhD
        FzCyrGIUTy0tzk1PLTbOSy3XK07MLS7NS9dLzs/dxAhMNaf/Hf+6g3HFq496hxiZOBgPMUpw
        MCuJ8L5dEp0ixJuSWFmVWpQfX1Sak1p8iFGag0VJnFfb9mSykEB6YklqdmpqQWoRTJaJg1Oq
        gWny5eN7mNSd3P+Iayxqjb4xvejgbf5Z2em/o5Y6uZ+9J9Dkoj/p3Zl7j1v2Hmz3/3W18bri
        23zrxIvXL/Uoy3yclZrttvnh9U0h8ovXL5jTk/RHIGi9r95c40OMzO7PTqx+XbVB3rlqx7uU
        R3/fOuZfXXBoEpPskYSdl9f3LznVp29U9jeH78i8UssrpnGRmuYTdxgEKZ1uCul6FX//oNaJ
        tznLJ1nNdZ57Vcj9rcIu3WfMjoVHr/IXl2ztfq3Us//6b+fqm1z1znly7+Y1Vxuy/PfzZHyw
        /J7JlpM7TUKuqi9RWCzVu4q9+93bD9sa/Z5OFb3wQEJWYUIS5xenSwzZr7YonWS9euXHm50q
        Z4vjlViKMxINtZiLihMB6o9udaQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsVy+t/xu7pVwnEpBv2v9CxW3+1ns3h/8DGr
        xcrVR5ks9t7Stvj9Yw6bA6vH5hVaHpfPlnrsvtnA5tHb/I7N4/MmuQDWKD2bovzSklSFjPzi
        ElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2MpiVHGQu6eCqeTXZvYLzG
        3sXIySEhYCJxYcFvxi5GLg4hgaWMEn03PzFBJGQkNn65ygphC0v8udbFBmILCXxklNi8XwCi
        YTejxO8v9xlBErwCdhKv/81nAbFZBFQlur6tZ4aIC0qcnPkELC4qEC1xY/k3sAXCAsES91Yd
        ALNFBPQkrt66wQ4ylFngIaPE12+boU5azSTxrGMSWDezgLjErSfzgTo4ONgEtCQaO8Fe4ARa
        /H7VTTaIEk2J1u2/2SFseYntb+cwQ3ygLDF58n82CLtW4vPfZ4wTGEVnIblvFpINs5CMmoVk
        1AJGllWMIqmlxbnpucVGesWJucWleel6yfm5mxiBMbrt2M8tOxhXvvqod4iRiYPxEKMEB7OS
        CO/bJdEpQrwpiZVVqUX58UWlOanFhxhNgYE0kVlKNDkfmCTySuINzQxMDU3MLA1MLc2MlcR5
        PQs6EoUE0hNLUrNTUwtSi2D6mDg4pRqYGt0uJzAzf+B1nfx193q99ezhQgXOR79bJecH3T76
        7tDs/FT9ym75JoY/T3jusPd4KSZdkt5X1/tZypR10TpL2/upe2ZIqd6qfNqq6OqSsDO7bMHd
        N5nnlwvMjhBft9bm6PzIWS8+uiUeZcja8oJlg0dL4LzM/mm/eNepam49cfp9nqzH3ozgF/zR
        P7wOdBX9D/fyP8P5rrHjq946D3udRe2sC3byr2p23KVstWuP1/dabQOBSbLTk27ern+1cnHW
        p/OHzEQ6bs+KZBU7yK+wvFHRaXdhzUOFiFN702c8n7dG/HGvkIZoovXd/d/We951mnvlb5Ua
        d+7T/Nd9jvP2XPuitarM7PPWkx+WrGA/p8RSnJFoqMVcVJwIAGxUHpNaAwAA
X-CMS-MailID: 20230512102250eucas1p1c2182c9c5db664e53dd21241182d7a71
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230511121547eucas1p17acca480b5e1d0e04c6595b70c1c92a1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230511121547eucas1p17acca480b5e1d0e04c6595b70c1c92a1
References: <CGME20230511121547eucas1p17acca480b5e1d0e04c6595b70c1c92a1@eucas1p1.samsung.com>
        <20230511121544.111648-1-p.raghav@samsung.com>
        <bf2daf76-ebfd-8ca2-0e40-362bcaecfc3f@nvidia.com>
        <b45b3578-857d-a13b-6fdc-6ceb178ddb84@samsung.com>
        <19a880f2-9c06-c096-9a76-a30552bfbc78@nvidia.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2023-05-12 10:34, Chaitanya Kulkarni wrote:
> On 5/12/23 01:17, Pankaj Raghav wrote:
>>>> [1] Performance in KIOPS:
>>>>
>>>>             |  radix-tree |    XArray  |   Diff
>>>>             |             |            |
>>>> write     |    315      |     313    |   -0.6%
>>>> randwrite |    286      |     290    |   +1.3%
>>>> read      |    330      |     335    |   +1.5%
>>>> randread  |    309      |     312    |   +0.9%
>>>>
>>> I've few concerns, can you please share the fio jobs that
>>> have used to gather this data ? I want to test it on my
>>> setup in order to provide tested-by tag.
>>>
>> That would be great. This is my fio job:
>>
>> $ modprobe brd rd_size=10485760 rd_nr=1
>> $ fio --name=brd  --rw=<type>  --size=10G --io_size=100G --cpus_allowed=1 --filename=/dev/ram0
>> --direct=1 --iodepth=64 --ioengine=io_uring --loop=8
>>
>> I ran the above job four times and averaged it as I noticed some variance. I ran the test in QEMU
>> as we were using a block device where the backing storage lives in RAM.
>>
> 
> Please also share the numbers on non-virtualized platform i.e. with not 
> QEMU.

I am running this on the next-20230512 in an Intel(R) Xeon(R) CPU E3-1240 v6 with 32GB RAM:

              |  radix-tree |    XArray  |   Diff
              |             |            |
    write     |    532      |     527    |   -0.9%
    randwrite |    456      |     452    |   -0.8%
    read      |    557      |     550    |   -1.2%
    randread  |    493      |     495    |   +0.4%
