Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B6CBC433EF
	for <linux-block@archiver.kernel.org>; Tue, 24 May 2022 07:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbiEXHLw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 May 2022 03:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234893AbiEXHLD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 May 2022 03:11:03 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7221D8FFBB
        for <linux-block@vger.kernel.org>; Tue, 24 May 2022 00:10:59 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220524071057euoutp02e60ebb68c9821e8a3d9a92aec0a04616~x_PI2Z7L42355523555euoutp02f
        for <linux-block@vger.kernel.org>; Tue, 24 May 2022 07:10:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220524071057euoutp02e60ebb68c9821e8a3d9a92aec0a04616~x_PI2Z7L42355523555euoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1653376257;
        bh=M6Q16BfKCIzyTPg6hPOvIiMvm5i/d35FqYIBmnk7lQ4=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=KECRc2HdAM5LLjvfLQcZ8xjRSiyk/SUFgahMn15QA9TZiqUTqSYw5hXQ/tTlT4bM9
         EQjZk/XoxcwnwmouaVkEdZCHdQ2jmR1GsKfSn9e12rZT4grjH1a6PNJPkPipil+P1L
         F65O9u2lKu0EDwA6CrPUr0puOxOCf55w8cF3E8OA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220524071057eucas1p1855d95118ad4a2d9cc6b3eb43d9db154~x_PIlUqWT0268302683eucas1p1u;
        Tue, 24 May 2022 07:10:57 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 45.5C.09887.0058C826; Tue, 24
        May 2022 08:10:57 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220524071056eucas1p1fe9ca64e7d7910c9cf81eb952420a35a~x_PH8Sjm30651106511eucas1p1w;
        Tue, 24 May 2022 07:10:56 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220524071056eusmtrp19475774e768b4fc9b274dcfc332f4ab0~x_PH58txD0167801678eusmtrp1K;
        Tue, 24 May 2022 07:10:56 +0000 (GMT)
X-AuditID: cbfec7f4-471ff7000000269f-c2-628c8500b490
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id FD.22.09404.0058C826; Tue, 24
        May 2022 08:10:56 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220524071056eusmtip202bd84c83b9ad12b546a1192a494994e~x_PHu3Og71582015820eusmtip2C;
        Tue, 24 May 2022 07:10:56 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.20) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Tue, 24 May 2022 08:10:54 +0100
Message-ID: <214e0c82-ce20-ba0f-77bd-21f3b83fd1f1@samsung.com>
Date:   Tue, 24 May 2022 09:10:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
        Thunderbird/91.9.1
Subject: Re: [PATCH v5 2/7] block: allow blk-zoned devices to have
 non-power-of-2 zone size
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>, <axboe@kernel.dk>, <hch@lst.de>,
        <snitzer@redhat.com>, <damien.lemoal@opensource.wdc.com>,
        <Johannes.Thumshirn@wdc.com>
CC:     <linux-nvme@lists.infradead.org>, <dm-devel@redhat.com>,
        <dsterba@suse.com>, <jiangbo.365@bytedance.com>,
        <linux-kernel@vger.kernel.org>, <gost.dev@samsung.com>,
        <linux-block@vger.kernel.org>, <jaegeuk@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <a7a409dc-4cf3-7096-50f6-7f794d4a0b9b@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [106.210.248.20]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDKsWRmVeSWpSXmKPExsWy7djPc7qMrT1JBic+MFqsvtvPZvH77Hlm
        i73vZrNaXPjRyGSxZ9EkJouVq48yWTxZP4vZoufABxaLv133mCz23tK2uLxrDpvF/GVP2S1u
        THjKaNG28SujA5/HvxNr2Dwuny312LSqk81j85J6j903G9g8drbeZ/V4v+8qm8f6LVdZPDaf
        rvb4vEnOo/1AN1MAdxSXTUpqTmZZapG+XQJXxs+px9gKjgtUND7bwNjAuI+3i5GTQ0LARKJn
        0xzGLkYuDiGBFYwSE28fZ4FwvjBKLNz3kR3C+cwoMeFmKwtMy6onC5lBbCGB5YwSZy7xwRXd
        mDAJqmMXo8T8eUvAOngF7CRWnO8Bs1kEVCXa/uxih4gLSpyc+QQsLioQIbGy9Q2YLSwQK/Fq
        wgowm1lAXOLWk/lMIENFBOYzSsw4sRJsA7NAO5NE6+KfQHdwcLAJaEk0drKDmJwC1hJnHsRD
        9GpKtG7/zQ5hy0s0b50NVi0hoCSx7ZcJxDO1EmuPnQGbKCFwj1Pi4cyXbBAJF4mGaWsYIWxh
        iVfHt7BD2DISpyf3QEOiWuLpjd/MEM0tjBL9O9ezQSywlug7kwNR4yjxc+M7qDCfxI23ghDn
        8ElM2jadeQKj6iykkJiF5ONZSD6YheSDBYwsqxjFU0uLc9NTi43yUsv1ihNzi0vz0vWS83M3
        MQIT4Ol/x7/sYFz+6qPeIUYmDsZDjBIczEoivClhPUlCvCmJlVWpRfnxRaU5qcWHGKU5WJTE
        eZMzNyQKCaQnlqRmp6YWpBbBZJk4OKUamCTOF3x4wfz728Sa2p1uDyfd+NAQ8XM+q6x0eEzw
        6jI1ZtdE9Vax2Ac9ZVaXhU+oRl/eGDnjdO6X9q/Jkz+K1/vMO2394f9nvqy29Bl9KnOtX00X
        j7EwNLsUl+/9ffLFnAn5s8+xTkrYoaEt+G2K56XlAu4ORReTPGXPGGyuyFqm+NUj3Nz597MT
        Wp/e5p3i6Swq3qC8OGh96E+ttl5LZ/X/H7+73rxwfovnl38zC5d8t8t7u+Xl1NLwYtPEWTwF
        Hi9SJl509Il0UggPENv38u3X7eddozaK7AzbqiaSqfwsc1JY7uX1xp++VyxL2819U841Iq9v
        78uvduuvJN4QFfyxMPLy3mmlbHZbtq7Pc1NiKc5INNRiLipOBADcL3RV7wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEKsWRmVeSWpSXmKPExsVy+t/xe7oMrT1JBjs6hCxW3+1ns/h99jyz
        xd53s1ktLvxoZLLYs2gSk8XK1UeZLJ6sn8Vs0XPgA4vF3657TBZ7b2lbXN41h81i/rKn7BY3
        JjxltGjb+JXRgc/j34k1bB6Xz5Z6bFrVyeaxeUm9x+6bDWweO1vvs3q833eVzWP9lqssHptP
        V3t83iTn0X6gmymAO0rPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/OJiU1
        J7MstUjfLkEv4+fUY2wFxwUqGp9tYGxg3MfbxcjJISFgIrHqyULmLkYuDiGBpYwS15o/MEMk
        ZCQ+XfnIDmELS/y51sUGUfSRUWLn+T1MEM4uRolfBw4wglTxCthJrDjfwwJiswioSrT92cUO
        EReUODnzCVhcVCBC4tOyCawgtrBArMSrCSvA4swC4hK3nswHGyoiMJ9RYsaJlewgDrNAO5NE
        6+KfUAe+Y5ToWrEVKMPBwSagJdHYCWZyClhLnHkQDzFIU6J1+292CFteonnrbGaQEgkBJYlt
        v0wgvqmVeHV/N+MERtFZSM6bheSMWUgmzUIyaQEjyypGkdTS4tz03GIjveLE3OLSvHS95Pzc
        TYzAxLHt2M8tOxhXvvqod4iRiYPxEKMEB7OSCG9KWE+SEG9KYmVValF+fFFpTmrxIUZTYBhN
        ZJYSTc4Hpq68knhDMwNTQxMzSwNTSzNjJXFez4KORCGB9MSS1OzU1ILUIpg+Jg5OqQYmBZHY
        wxmCfN4tV4oyqn5+Zu7O+mEZ/vLH/UKL1B8nThS7topVfZ5t/OXIujMMpX2fLRNeHCsyPbpA
        kMctnvHHe+34g+s2JPW2Wwebx37ufNXqYMP50c/D/3/dXP3e4l2TTvMtj3LdcuLX9kdr779d
        dzPZPH2iQG1QrF9+ft/WZ9WCPuH1BxquTjNfXhrBJ9Fx6/uvurkKE/zD8nNTFuYlrRblVefh
        XMMtMcmQdb3826tXb2+Sfd/CZr4p8+Q6uYsJS10nGL+W//VzUnSZ5Kn/d/YJTPvkF3H+yPUM
        uzWqO3RDMqQXfc74zNXGMPXSue8HZ003mu59/PWU/6KsJ5dJs8/1f3XKd17a2qnnbN+/VWIp
        zkg01GIuKk4EAPABXj+lAwAA
X-CMS-MailID: 20220524071056eucas1p1fe9ca64e7d7910c9cf81eb952420a35a
X-Msg-Generator: CA
X-RootMTR: 20220523161606eucas1p2676c4d47f9fcb145f69b29db1f04fe6e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220523161606eucas1p2676c4d47f9fcb145f69b29db1f04fe6e
References: <20220523161601.58078-1-p.raghav@samsung.com>
        <CGME20220523161606eucas1p2676c4d47f9fcb145f69b29db1f04fe6e@eucas1p2.samsung.com>
        <20220523161601.58078-3-p.raghav@samsung.com>
        <a7a409dc-4cf3-7096-50f6-7f794d4a0b9b@suse.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/24/22 07:19, Hannes Reinecke wrote:

>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>> index c4e4c7071b7b..f5c7a41032ba 100644
>> --- a/include/linux/blkdev.h
>> +++ b/include/linux/blkdev.h
>> @@ -676,6 +676,21 @@ static inline unsigned int
>> blk_queue_zone_no(struct request_queue *q,
>>       return div64_u64(sector, zone_sectors);
>>   }
>>   +static inline bool blk_queue_is_zone_start(struct request_queue *q,
>> sector_t sec)
>> +{
>> +    sector_t zone_sectors = blk_queue_zone_sectors(q);
>> +    u64 remainder = 0;
>> +
>> +    if (!blk_queue_is_zoned(q))
>> +        return false;
>> +
> 
> Not sure if we need this here; surely blk_queue_zone_sectors() will
> already barf, and none of the callers did this check.
> 
I totally agree with you but all the other blk_queue_* functions had
this defensive check and I didn't want to break that pattern:

static inline unsigned int blk_queue_zone_no(struct request_queue *q,
					     sector_t sector)
{
	....
	if (!blk_queue_is_zoned(q))
		return 0;
        ....
}


>> +    if (is_power_of_2(zone_sectors))
>> +        return IS_ALIGNED(sec, zone_sectors);
>> +
And, if the chunk sectors is 0, then we will do the npo2 calculation
resulting in a divide by zero even though chances of that happening is
very very low as you pointed out.
>> +    div64_u64_rem(sec, zone_sectors, &remainder);
>> +    return remainder == 0;
>> +}
>> +
>>   static inline bool blk_queue_zone_is_seq(struct request_queue *q,
>>                        sector_t sector)
>>   {
>> @@ -722,6 +737,12 @@ static inline unsigned int
>> blk_queue_zone_no(struct request_queue *q,
>>   {
>>       return 0;
>>   }
>> +
>> +static inline bool blk_queue_is_zone_start(struct request_queue *q,
>> sector_t sec)
>> +{
>> +    return false;
>> +}
>> +
>>   static inline unsigned int queue_max_open_zones(const struct
>> request_queue *q)
>>   {
>>       return 0;
> Otherwise looks good.
> 
Thanks!
> Cheers,
> 
> Hannes
