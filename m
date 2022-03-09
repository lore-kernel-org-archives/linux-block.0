Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE57DC433EF
	for <linux-block@archiver.kernel.org>; Wed,  9 Mar 2022 13:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbiCINgY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Mar 2022 08:36:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233184AbiCINgX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Mar 2022 08:36:23 -0500
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CEDA13CA09
        for <linux-block@vger.kernel.org>; Wed,  9 Mar 2022 05:35:23 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220309133521euoutp02273eff26b38803bf5c57d71a0274f7fd~audEO-ndF1887118871euoutp02P
        for <linux-block@vger.kernel.org>; Wed,  9 Mar 2022 13:35:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220309133521euoutp02273eff26b38803bf5c57d71a0274f7fd~audEO-ndF1887118871euoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1646832921;
        bh=MOSRaIxNyC6CI9cICiCk1xaINheM8UiY5voih+W/W4Y=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=dbIoek1kfOzpswDZvFj3FZdYuV+815lp+IQQg4MHHroGzoF3aYp/V55EojDzldApL
         /OjFdqgt1KrgEzKk7n1fHYz6jAAzJnoBA4nB9Z7crF9FcnakkXcP/4zh56OcHzG4L/
         Iprn7eNgGyonevK1vtUgXerEcQ7yOQVj5E75wbEI=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220309133520eucas1p13405dad298a4241a36811212c217ee60~audDvoEHk2920429204eucas1p1M;
        Wed,  9 Mar 2022 13:35:20 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 32.C6.09887.81DA8226; Wed,  9
        Mar 2022 13:35:20 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220309133520eucas1p22d90a2003c4a3d2d16d4d6672e8fcb23~audDHSDQ11723517235eucas1p2P;
        Wed,  9 Mar 2022 13:35:20 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220309133520eusmtrp1b2428a7e0ea37f46d1c87d3a06744855~audDGLZ8Z1636516365eusmtrp1P;
        Wed,  9 Mar 2022 13:35:20 +0000 (GMT)
X-AuditID: cbfec7f4-45bff7000000269f-f0-6228ad189912
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E5.AA.09404.71DA8226; Wed,  9
        Mar 2022 13:35:20 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220309133519eusmtip1ee003e23dc854adaa68d0c110270d746~audC9IVpt0959709597eusmtip1G;
        Wed,  9 Mar 2022 13:35:19 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.212) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Wed, 9 Mar 2022 13:35:14 +0000
Message-ID: <df8dfb02-15d2-bfb4-df41-cde6fe850092@samsung.com>
Date:   Wed, 9 Mar 2022 14:35:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
        Thunderbird/91.5.0
Subject: Re: [PATCH 1/6] nvme: zns: Allow ZNS drives that have
 non-power_of_2 zone size
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>,
        kanchan Joshi <joshi.k@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        =?UTF-8?Q?Matias_Bj=c3=b8rling?= <matias.bjorling@wdc.com>,
        <jiangbo.365@bytedance.com>
CC:     Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshiiitr@gmail.com>,
        <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <06580b24-426c-77ef-a338-e5e97f5ebee1@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.212]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHKsWRmVeSWpSXmKPExsWy7djP87oSazWSDHo3a1msvtvPZvH77Hlm
        i5WrjzJZ9Bz4wGJx/u1hJotJh64xWuy9pW0xf9lTdosJbV+ZLW5MeMposebmUxaLda/fszjw
        ePw7sYbNY+esu+we5+9tZPG4fLbUY9OqTjaPzUvqPXbfbADKtd5n9fi8Sc6j/UA3UwBXFJdN
        SmpOZllqkb5dAlfGk88tzAWnuSs2vlvB1MC4jLOLkZNDQsBE4sqM14xdjFwcQgIrGCXmPemD
        cr4wSjyY+oINwvnMKLFz6Ut2mJa9TX9YIRLLGSWOdl1khKv6+GMjG0iVkMAuRokV9+tBbF4B
        O4mtJzaygNgsAioS6y+sZIWIC0qcnPkELC4qECHx8shfJhBbWCBSYvraPcwgNrOAuMStJ/OZ
        QBaICJxjlrjYMZkVIjGRUaJzl3kXIwcHm4CWRGMn2HWcAm4SM55/hOrVlGjd/psdwpaX2P52
        DjNIuYSAssTr9TYQz9RKrD12hh1kvITAKU6JTbc72CASLhJLzm+G+lhY4tXxLVC2jMTpyT0s
        EA39jBJTW/4wQTgzGCV6Dm9mgthgLdF3JgfCdJS4edAMwuSTuPFWEOIcPolJ26YzT2BUnYUU
        ErOQfDwLyQezkHywgJFlFaN4amlxbnpqsVFearlecWJucWleul5yfu4mRmCSO/3v+JcdjMtf
        fdQ7xMjEwXiIUYKDWUmEtylUI0mINyWxsiq1KD++qDQntfgQozQHi5I4b3LmhkQhgfTEktTs
        1NSC1CKYLBMHp1QD05qTv/5Pm3Pac9/1WfVhop6iX84cNvZzr95Zka40p+dAq7Nv0kb2uduT
        F2YKlZ1i64n5Of1T3OEMM+1Dk5IdtuyQf5jRNN1a5/jHq/dVWpoc9ml83NugnRa3Yua2NQor
        nnOlmUlYcXGbGl9X1ZRTe/jx6OGJE//dXhCzhfH3ZbZHE2WDO9+0dwSUsSv7cuyMdl22WPJS
        1TaFvI0vcvhDr9Q3nbTWtXu3KnR/uV7jufhpeXMfVvtc3Si2N/zfcmX9nA8dh3w076t+Tygy
        +58+WWCLy2FL3yV259csWcXg/fmWfyv3Qp4pv3ZemX7yr00I05Jd6YdLKvJ3nVRKdU/dYMx8
        dsee3iV2LRsXrpb+aazEUpyRaKjFXFScCAC6qQI14QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphleLIzCtJLcpLzFFi42I5/e/4XV2JtRpJBpMvMFqsvtvPZvH77Hlm
        i5WrjzJZ9Bz4wGJx/u1hJotJh64xWuy9pW0xf9lTdosJbV+ZLW5MeMposebmUxaLda/fszjw
        ePw7sYbNY+esu+we5+9tZPG4fLbUY9OqTjaPzUvqPXbfbADKtd5n9fi8Sc6j/UA3UwBXlJ5N
        UX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7Gk88tzAWn
        uSs2vlvB1MC4jLOLkZNDQsBEYm/TH9YuRi4OIYGljBJzHp9ggkjISHy68pEdwhaW+HOtiw2i
        6COjxNSJ2xghnF2MEuf3r2IFqeIVsJPYemIjC4jNIqAisf7CSqi4oMTJmU/A4qICERJty6Yw
        dzFycAgLRErMuukFEmYWEJe49WQ+E8hMEYFzzBIXOyaDncQs0M8osWTKD6j7fjNKfNu0gwWk
        m01AS6KxE+w8TgE3iRnPPzJDTNKUaN3+mx3ClpfY/nYO2DIJAWWJ1+ttIL6plXh1fzfjBEbR
        WUjOm4XkjllIJs1CMmkBI8sqRpHU0uLc9NxiI73ixNzi0rx0veT83E2MwOSw7djPLTsYV776
        qHeIkYmD8RCjBAezkghvU6hGkhBvSmJlVWpRfnxRaU5q8SFGU2AYTWSWEk3OB6anvJJ4QzMD
        U0MTM0sDU0szYyVxXs+CjkQhgfTEktTs1NSC1CKYPiYOTqkGJqMZv2v2R+2MySt6Xcnlq9hX
        uP+41IIgU66joaue7/H+JFIju0DvxsLmuk0u+u3Tj3aue33O5fjcIpGtgqJHDPIOOT28MJ/Z
        La3HuEStSdYpbiVfYW2/x9wrsyUkAhmKWzfdPMS7NV3zQeEtoX88R7JPV7zNTojavKn6moR9
        VJXaYv+XKlaxs6ZGW3L/UDM1DNlo1TT7Tuq+uXw8Wnmx1jZfZ+97VBWuuF7n9msliaoKU5U1
        wTFL334z/bOPb8nCR2YTI3bLc7L7PE5co37oo9fmk64zHCffDZjwNsHI4P42zZ87KjdmvVrz
        1rvDMOUH/7au9Zv+LnfJPhcZ2zNNWmal6BGWc8H3uxceEC7jV2Ipzkg01GIuKk4EAOk4SeCX
        AwAA
X-CMS-MailID: 20220309133520eucas1p22d90a2003c4a3d2d16d4d6672e8fcb23
X-Msg-Generator: CA
X-RootMTR: 20220308165421eucas1p20575444f59702cd5478cb35fce8b72cd
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220308165421eucas1p20575444f59702cd5478cb35fce8b72cd
References: <20220308165349.231320-1-p.raghav@samsung.com>
        <CGME20220308165421eucas1p20575444f59702cd5478cb35fce8b72cd@eucas1p2.samsung.com>
        <20220308165349.231320-2-p.raghav@samsung.com>
        <06580b24-426c-77ef-a338-e5e97f5ebee1@opensource.wdc.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2022-03-09 04:44, Damien Le Moal wrote:
> On 3/9/22 01:53, Pankaj Raghav wrote:
>>  
>>  	ns->zsze = nvme_lba_to_sect(ns, le64_to_cpu(id->lbafe[lbaf].zsze));
>> -	if (!is_power_of_2(ns->zsze)) {
>> -		dev_warn(ns->ctrl->device,
>> -			"invalid zone size:%llu for namespace:%u\n",
>> -			ns->zsze, ns->head->ns_id);
>> -		status = -ENODEV;
>> -		goto free_data;
>> -	}
> 
> Doing this will allow a non power of 2 zone sized device to be seen by
> the block layer. This will break functions such as blkdev_nr_zones() but
> this patch is not changing this functions, and other using bit shift
> calculations.
> The goal of this patchset was to emulate a po2 zone size for a npo2 device to the
block layer. If you see the `npo2_zone_setup` callback in the NVMe driver (patch 4/6),
we do the following:
```
+   ns->zsze_po2 = 1 << get_count_order_long(ns->zsze);
+   capacity = nr_zones * ns->zsze_po2;
+   set_capacity_and_notify(ns->disk, capacity);
```
So we adapt the capacity of the disk based on the po2 zone size. The chunk sectors
are also set to this new po2 zone size. Therefore, all the block layer functions will
continue to work as the block layer sees the zone size of the device to be ns->zsze_po2 and
not the actual device zone size which is ns->zsze.

Changing the functions such blkdev_nr_zones that uses po2 calculation will/should be dealt separately
if decide to relax the po2 constraint in the block layer.

-- 
Regards,
Pankaj
