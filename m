Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E4D4C4332F
	for <linux-block@archiver.kernel.org>; Wed, 16 Mar 2022 16:18:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357472AbiCPQTv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Mar 2022 12:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357481AbiCPQTu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Mar 2022 12:19:50 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F706D4CC
        for <linux-block@vger.kernel.org>; Wed, 16 Mar 2022 09:18:26 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220316161821euoutp0190eb8583f99b1f2dc134d87d8bdbe3ad~c6MYWE4Ks0531005310euoutp01_
        for <linux-block@vger.kernel.org>; Wed, 16 Mar 2022 16:18:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220316161821euoutp0190eb8583f99b1f2dc134d87d8bdbe3ad~c6MYWE4Ks0531005310euoutp01_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1647447501;
        bh=T+UtmiGdcgaLpZluJiSNB4ORUTJKW/THr8Hju3nQJ4Q=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=WVr5VeuzB2MhwcKWF7JJnYIB82BGUHI7FOuHW15SyU/hdl/9Rs8BQAfL3yNKNswX3
         6lfPaeyUFbopJm9n4+eWWKffCXsH2Hp8gRdLn4YsiYfGTrC7reCTtJpEZ999qiiP7a
         ayNz3Brqfw3VxPKKwdH6ro/K1SlvBEiAV/gZ3m10=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220316161820eucas1p2b4d9deb72586f6ec190a7ef4d4b3d05d~c6MYCjyLg2046820468eucas1p2P;
        Wed, 16 Mar 2022 16:18:20 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 1A.D6.09887.CCD02326; Wed, 16
        Mar 2022 16:18:20 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220316161820eucas1p129b794d92db5a8dbc1f0f1ff668ab27e~c6MXjnFok1732017320eucas1p1L;
        Wed, 16 Mar 2022 16:18:20 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220316161820eusmtrp2c52bba8a4eba6a3ec8a6825410254d1c~c6MXiJRVK1536615366eusmtrp2p;
        Wed, 16 Mar 2022 16:18:20 +0000 (GMT)
X-AuditID: cbfec7f4-471ff7000000269f-65-62320dcc3896
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 52.19.09404.CCD02326; Wed, 16
        Mar 2022 16:18:20 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220316161820eusmtip11fd2c433926a321cafbdd0f1e7eeafbc~c6MXYXkhW0522805228eusmtip1V;
        Wed, 16 Mar 2022 16:18:20 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.179) by CAMSVWEXC01.scsc.local
        (106.1.227.71) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 16 Mar
        2022 16:18:14 +0000
Message-ID: <553f91df-d546-64a3-0c87-23b98aefc97e@samsung.com>
Date:   Wed, 16 Mar 2022 17:18:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
        Thunderbird/91.5.0
Subject: Re: [PATCH 0/6] power_of_2 emulation support for NVMe ZNS devices
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>,
        =?UTF-8?Q?Matias_Bj=c3=b8rling?= <Matias.Bjorling@wdc.com>
CC:     Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "jiangbo.365@bytedance.com" <jiangbo.365@bytedance.com>,
        kanchan Joshi <joshi.k@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshiiitr@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <fcb4f608-970c-56d3-fe3d-b344fab8baf7@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.179]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (106.1.227.71) To
        CAMSVWEXC01.scsc.local (106.1.227.71)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFKsWRmVeSWpSXmKPExsWy7djP87pneI2SDPY1G1isvtvPZvH77Hlm
        i5WrjzJZdJ6+wGTRc+ADi8X5t4eZLCYdusZosfeWtsX8ZU/ZLSa0fWW2uDHhKaPFmptPWSzW
        vX7P4sDr8e/EGjaPnbPusnucv7eRxaN5wR0Wj8tnSz02repk89i8pN5j980GoILW+6wenzfJ
        ebQf6GYK4I7isklJzcksSy3St0vgylg7fydrQQtbxeqPSg2M11m6GDk5JARMJB5M/sjUxcjF
        ISSwglFi75Jl7BDOF0aJ/7sfsEE4nxkleiYtYoJpmfHjEitEYjmjxMW7n5jhqu737oBy1jFK
        /Jl8gxWkhVfATmLnjDdgNouAqkTDqutMEHFBiZMzn4BdIioQIfHyyF+wuLCAl0TH27XsIDaz
        gLjErSfzwS4UEVjDKLGg8QfYbmaBbhaJGZ0rgNZxcLAJaEk0doI1cAq4Sfzf2swI0awp0br9
        N9QgeYntb+cwQ/ygLNF59RETSKuEQLLEhplhICMlBK5xSrz51MoOUeMi8ffuTihbWOLV8S1Q
        tozE/50QB0kI9DNKTG35A+XMAIbS4c1QU60l+s7kQDQ4Ssz4vJsFIswnceOtIMQ9fBKTtk1n
        nsCoOgspLGYh+XkWkhdmIXlhASPLKkbx1NLi3PTUYqO81HK94sTc4tK8dL3k/NxNjMDkd/rf
        8S87GJe/+qh3iJGJg/EQowQHs5II75kX+klCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeZMzNyQK
        CaQnlqRmp6YWpBbBZJk4OKUamLw7P0xuEY3NWnHQ7/8V/Z9tygVrpzQXCt9b0/bly/u/N9+w
        BGxsUs7dfDXIY+NZpm3GjzinPeg6vmDNgmtCSV9br69tc2oTXJqsLvkgeMZF5fv3dO4azku6
        2vXinEy7t7hP0SE/L+8DTZvnb15/U8W3bnf0pF/af4Jyd4o/5f+c9fZUsNS5pRYc7PbH73/m
        /3H34On9da2iX+PWil0843O3fXf5Im6n6P/XY+5wbdN2mN9YeGbezrTpCX2+0tNW3+LNyb/D
        Gj7jT+/nb+U+CYnKBxJPyVZMnDv9eF559aE/J21S/4sqLRDrkhBee+dzk3dKxal5BQwhMSuN
        Xp+svHjp0PSW7Fu338lKTZh66VKxEktxRqKhFnNRcSIARzNvu+0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjleLIzCtJLcpLzFFi42I5/e/4Xd0zvEZJBttu81msvtvPZvH77Hlm
        i5WrjzJZdJ6+wGTRc+ADi8X5t4eZLCYdusZosfeWtsX8ZU/ZLSa0fWW2uDHhKaPFmptPWSzW
        vX7P4sDr8e/EGjaPnbPusnucv7eRxaN5wR0Wj8tnSz02repk89i8pN5j980GoILW+6wenzfJ
        ebQf6GYK4I7SsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3S
        t0vQy1g7fydrQQtbxeqPSg2M11m6GDk5JARMJGb8uMTaxcjFISSwlFFi7cpGdoiEjMSnKx+h
        bGGJP9e62CCKPjJKTDuzgwXCWccocWL5ITaQKl4BO4mdM96wgtgsAqoSDauuM0HEBSVOznwC
        tk5UIEKibdkUZhBbWMBLouPtWrANzALiEreezGcCGSoisIZRYkHjD7CbmAW6WSRmdK5ghljX
        wSbRuecB0DoODjYBLYnGTrBuTgE3if9bmxkhJmlKtG7/DTVVXmL72znMED8oS3RefcQE0ioh
        kCzx91b4BEbRWUjum4XkjllIJs1CMmkBI8sqRpHU0uLc9NxiI73ixNzi0rx0veT83E2MwISx
        7djPLTsYV776qHeIkYmD8RCjBAezkgjvmRf6SUK8KYmVValF+fFFpTmpxYcYTYGBNJFZSjQ5
        H5iy8kriDc0MTA1NzCwNTC3NjJXEeT0LOhKFBNITS1KzU1MLUotg+pg4OKUamJb4TLkt7Nw9
        /aw0/5oftW9ZnnxZPiloWlB80/dauwTLf7rv1fdLzWbYYuVetkLNzkPyjNjEGDW+D//3z/WN
        fpg0K+NIk7H9zTb7qcKugsdMos78Fp4U3+dx+uyWDAVF7cuxTO5XyzvlGms63mYUp0rETC/M
        6isof/3sf6Z0q17W0/0b/BjkSjI0E9cYi9zRctZ9PKutOHV+cvg1E/lJiq8L3T8ujRWs+xHT
        Ilq1tK6mJNbA/3OUaGrHUf5ktktrfhm5Ht3S53SK8cFaleRIOZ5ZJ76fzDRekBe4Zk0T80q1
        t/wzP8u2a635fUE7yOMSw6NrkSxGbZcr15oJcGp0nItyV5G3DayZwehvvlyJpTgj0VCLuag4
        EQDwX1pRoQMAAA==
X-CMS-MailID: 20220316161820eucas1p129b794d92db5a8dbc1f0f1ff668ab27e
X-Msg-Generator: CA
X-RootMTR: 20220316000043eucas1p230730e4215075e0881c690fffc6ad8aa
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220316000043eucas1p230730e4215075e0881c690fffc6ad8aa
References: <Yiu5YzxU/PjxLiUL@bombadil.infradead.org>
        <20220311213102.GA2309@dhcp-10-100-145-180.wdc.com>
        <YivMBj7+j/EZcMVV@bombadil.infradead.org>
        <bc0e53a9-f623-c69f-002e-d62e697a43d1@opensource.wdc.com>
        <20220314073537.GA4204@lst.de>
        <05a1fde2-12bd-1059-6177-2291307dbd8d@opensource.wdc.com>
        <20220314104938.hv26bf5vah4x32c2@ArmHalley.local>
        <BYAPR04MB49682B9263F21EE67070A4B1F10F9@BYAPR04MB4968.namprd04.prod.outlook.com>
        <20220314195551.sbwkksv33ylhlyx2@ArmHalley.local>
        <BYAPR04MB49688BD817284E5C317DD5D8F1109@BYAPR04MB4968.namprd04.prod.outlook.com>
        <20220315130501.q7fjpqzutadadfu3@ArmHalley.localdomain>
        <CGME20220316000043eucas1p230730e4215075e0881c690fffc6ad8aa@eucas1p2.samsung.com>
        <fcb4f608-970c-56d3-fe3d-b344fab8baf7@opensource.wdc.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Hi Damien,

On 2022-03-16 01:00, Damien Le Moal wrote:
>> As for F2FS and dm-zoned, I do not think these are targets at the 
>> moment. If this is the path we follow, these will bail out at mkfs
>> time.
> 
> And what makes you think that this is acceptable ? What guarantees do
> you have that this will not be a problem for users out there ?
> 
As you know, the architecture of F2FS ATM requires PO2 segments,
therefore, it might not be possible support nonPO2 ZNS drives.

So we could continue supporting PO2 ZNS drives for F2FS and bail out if
it is a Non PO2 ZNS drive during mkfs time (This is the current behavior
as well). This way we are not really breaking any ZNS drives that have
already been deployed for F2FS users.

-- 
Regards,
Pankaj
