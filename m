Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E9D7C64ED6
	for <linux-block@archiver.kernel.org>; Mon, 27 Feb 2023 14:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjB0OSq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Feb 2023 09:18:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjB0OSp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Feb 2023 09:18:45 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1795A24A
        for <linux-block@vger.kernel.org>; Mon, 27 Feb 2023 06:18:42 -0800 (PST)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230227141839epoutp0256a9ee37822e4bcdea90eb3ac983c4bb~HtDNuLp9g2746427464epoutp02c
        for <linux-block@vger.kernel.org>; Mon, 27 Feb 2023 14:18:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230227141839epoutp0256a9ee37822e4bcdea90eb3ac983c4bb~HtDNuLp9g2746427464epoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1677507519;
        bh=qMHOkyO+6fp1quQLZiJBBmHvWs5Nv6u0stgU73FDK2g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZdMmkpqxYLUUstb+bAOt2pT8uqdOF5FmVwYj+DJ5hxJwVO0Dll1W0DuME4SOaB5fG
         qHqGlJOhjQXKr943hSgKw2nmbOIOcDHAOVaHkrkdNAghJfCxerysarBO/ZG9v3EDNq
         pB38czcm4m+jCgR4dcmt0fhSsA9BtDDRCNi4T8Zc=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20230227141839epcas5p2baafd4e7347669a92b388db57386f67e~HtDNi6Jtb3099630996epcas5p2N;
        Mon, 27 Feb 2023 14:18:39 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4PQMzx23WTz4x9Pw; Mon, 27 Feb
        2023 14:18:37 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D9.16.55678.DBBBCF36; Mon, 27 Feb 2023 23:18:37 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20230227141836epcas5p1e1bcb4440572c28291faaf1f21354837~HtDK74K3I2793027930epcas5p16;
        Mon, 27 Feb 2023 14:18:36 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230227141836epsmtrp126690d1301f3f61bd7f20d10a5d2e4f8~HtDK7OU3E1492014920epsmtrp14;
        Mon, 27 Feb 2023 14:18:36 +0000 (GMT)
X-AuditID: b6c32a4a-6a3ff7000000d97e-1d-63fcbbbd9815
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        38.1B.17995.CBBBCF36; Mon, 27 Feb 2023 23:18:36 +0900 (KST)
Received: from green5 (unknown [107.110.206.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230227141835epsmtip134859d9acbd0acf48abbb15475613191~HtDKN1aPv0199601996epsmtip1U;
        Mon, 27 Feb 2023 14:18:35 +0000 (GMT)
Date:   Mon, 27 Feb 2023 19:48:02 +0530
From:   Kanchan Joshi <joshi.k@samsung.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH blktests v2 0/2] nvme: add test for unprivileged
 passthrough
Message-ID: <20230227141802.GA27506@green5>
MIME-Version: 1.0
In-Reply-To: <20230227112404.gzvugrzc7drqhomz@shindev>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGKsWRmVeSWpSXmKPExsWy7bCmhu7e3X+SDf4f4rNYufook8XeW9oW
        85c9ZbfYN8vTgcVj85J6j903G9g8Pm+S82g/0M0UwBKVbZORmpiSWqSQmpecn5KZl26r5B0c
        7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkDtE9JoSwxpxQoFJBYXKykb2dTlF9akqqQkV9c
        YquUWpCSU2BSoFecmFtcmpeul5daYmVoYGBkClSYkJ1xadNqpoIu3oqbE+eyNDDe4upi5OSQ
        EDCReDHpJlsXIxeHkMBuRon+7qnsEM4nRolVNyawQDifGSXad29ngmk5Pvk/K0RiF6PE7E+n
        oJwnjBLTdzSAVbEIqEo0bLkL1M7BwSagKXFhcilIWETAVOLJli1MIPXMAssYJbaf3MQIkhAW
        CJJY/W8yWC+vgLbE1Z7NLBC2oMTJmU/A5nAKmEnsXSUMEhYVUJY4sO042BwJgXvsEtduXmMG
        qZEQcJE4c6wc4lBhiVfHt7BD2FISL/vboOxkiUszz0E9UyLxeM9BKNteovVUPzOIzSyQIdFx
        5hILhM0n0fv7CRPEeF6JjjYhiHJFiXuTnrJC2OISD2csYYUo8ZBY+94EEiKPGCU2XjrBPIFR
        bhaSZ2Yh2QBhW0l0fmhinQXUziwgLbH8HweEqSmxfpf+AkbWVYySqQXFuempxaYFRnmp5fAo
        Ts7P3cQIToBaXjsYHz74oHeIkYmD8RCjBAezkgjvnZM/koV4UxIrq1KL8uOLSnNSiw8xmgIj
        ZyKzlGhyPjAF55XEG5pYGpiYmZmZWBqbGSqJ86rbnkwWEkhPLEnNTk0tSC2C6WPi4JRqYGpU
        6vZdoD/3fYvaM7cH71cbel1iq8n4cSPeiP/AxCRf+XMPFfKDbBdIC+04vsa6oGuZmEhwueym
        6S9dQh8LztpSvJshbONL/vKyYzt2e7iuL6yJ4SsTcFqg9TvMdHdcy7IZJ1KrPfXFfDcrZ8/i
        8/x0aNqnVocVSx3id3/cfd/hr0D48luqC/O+Pcw2bY24+vhI5yq56i2PvY0aDa6dnc2/IbJg
        664tOz5eY37emd92vEj9z5ldLHGTZpy9YinsLL3H0b/MvpYxuGqmseY3j7M/Fe96n+PLTJ+k
        71X+7G3k5J2u1lnecRusle31/58/2/KmLb/PY8UX2eWrN954taqS+zjHbP95V62Yha5P36jE
        UpyRaKjFXFScCABxgDoGCQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGLMWRmVeSWpSXmKPExsWy7bCSnO6e3X+SDTa9Y7dYufook8XeW9oW
        85c9ZbfYN8vTgcVj85J6j903G9g8Pm+S82g/0M0UwBLFZZOSmpNZllqkb5fAldH5vY29YA9X
        xazDs1gaGJdxdDFyckgImEgcn/yftYuRi0NIYAejxIzle9ghEuISzdd+QNnCEiv/PWeHKHrE
        KNF7dxkzSIJFQFWiYctdli5GDg42AU2JC5NLQcIiAqYST7ZsYQKpZxZYxiix5MQDsHphgSCJ
        1f8mM4HYvALaEld7NrNADH3CKDHp7BRmiISgxMmZT1hAbGYBM4l5mx8ygyxgFpCWWP6PA8Tk
        BArvXSUMUiEqoCxxYNtxpgmMgrOQNM9C0jwLoXkBI/MqRsnUguLc9NxiwwKjvNRyveLE3OLS
        vHS95PzcTYzgoNbS2sG4Z9UHvUOMTByMhxglOJiVRHjvnPyRLMSbklhZlVqUH19UmpNafIhR
        moNFSZz3QtfJeCGB9MSS1OzU1ILUIpgsEwenVANTyedyDcV/FmLx9scfMHQHLLadWd+pW3Rc
        OW2ClNu9Xb73TLnFTulO0mu72FiyJYFZdFr/3Rvef3c9q544sb504eGoh3c2eBpMnPjhUPYV
        1cTsbTUXBU5mNp1fxH//9Wae+inLpUvlt2Sk2q4VZqxjNn+1Lf7RuqLje0sbpfcmSAa/LH20
        JST1ybNcZ9tpMQvmFxmy1iZwTs/kPxYUfLV990wzj+Nmfj8nGVtz/Fp5p2Kvld/+/+eDtmZs
        2FmvwDPnZ4iz5l13tZar868WrW3O/r4zJEapuSXbNj5J19406ei8RXe/u8Su3mc04ZnFp85b
        L0//P94fUXPd+1r7y4m2sx/Kd1+RuLeOVb/qQGCkEktxRqKhFnNRcSIAABqmTNkCAAA=
X-CMS-MailID: 20230227141836epcas5p1e1bcb4440572c28291faaf1f21354837
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----KShBqqPo14.eBT3ESqKA1JUVW8Pp5OSRF8p2BdrChsSVkVya=_99622_"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230214044749epcas5p4ac6bf441e046e3642b1633fd9cf7a72b
References: <CGME20230214044749epcas5p4ac6bf441e046e3642b1633fd9cf7a72b@epcas5p4.samsung.com>
        <20230214044739.1903364-1-shinichiro.kawasaki@wdc.com>
        <20230227060547.GA25049@green5> <20230227112404.gzvugrzc7drqhomz@shindev>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

------KShBqqPo14.eBT3ESqKA1JUVW8Pp5OSRF8p2BdrChsSVkVya=_99622_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Mon, Feb 27, 2023 at 11:24:04AM +0000, Shinichiro Kawasaki wrote:
>On Feb 27, 2023 / 11:35, Kanchan Joshi wrote:
>> On Tue, Feb 14, 2023 at 01:47:37PM +0900, Shin'ichiro Kawasaki wrote:
>> > Per suggestion by Kanchan, add a new test case to test unprivileged passthrough
>> > of NVME character devices. The first patch adds a feature to run commands with
>> > normal user privilege. The second patch adds the test case using the feature.
>> >
>> > Changes from v2:
>> > * Added the first patch to add normal user privilege support to blktests
>> > * Adjusted the test case to the functions for normal user privilege support
>>
>> Thanks, this looks way better. And works fine in my setup.
>> If required,
>> Tested-by: Kanchan Joshi <joshi.k@samsung.com>
>
>Thanks for the confirmation. Sounds good.
>
>I found two more minor points to improve:
>
>1) tests/nvme/046 does not have executable mode bit. I will add it when I apply
>   the patch.
>
>2) I ran the test case with kernel version v6.1 and it failed. Does the test
>   case require kernel version 6.2 or higher? If that is the case, one more line
>   change will be required as follows. If you are ok with the change, I can fold
>   this change in when I apply the patches.

Yes, unprivileged passthrough exists from 6.2. Changes looks good.
Thanks.

------KShBqqPo14.eBT3ESqKA1JUVW8Pp5OSRF8p2BdrChsSVkVya=_99622_
Content-Type: text/plain; charset="utf-8"


------KShBqqPo14.eBT3ESqKA1JUVW8Pp5OSRF8p2BdrChsSVkVya=_99622_--
