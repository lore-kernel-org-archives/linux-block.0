Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE24C433F5
	for <linux-block@archiver.kernel.org>; Mon, 25 Apr 2022 11:20:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbiDYLXb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Apr 2022 07:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233082AbiDYLX0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Apr 2022 07:23:26 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B504E2AC4E
        for <linux-block@vger.kernel.org>; Mon, 25 Apr 2022 04:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650885622; x=1682421622;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VwxgDF6KxJ/vYHJLtUtghe4K2L20v2/aSUHkS2d3AT8=;
  b=Qp0KLOWkLfai1a75rxr6GrKv+If6LW3s00ZnclrAM/IsHgf3LFiRHFvd
   xLfDzr8fAXqPZzXtNUjRY0Tvc99mUjqpp0HCIwgqUYh2id4K3UguhbiwX
   NjyNy8iN/v9joIkJTYBJ4ndTT0lvbFqHDTB47kal6/eGkK/S0x0sxqxCc
   6nSpVw0zfPndbkSBDSVEdGSvmHJC2a/uYnnT0UEGxbTaVgv092fAkaqkr
   Yd0GTa1b24DKSKuBwe2ZvoKiKy6OD1QEStVAOuW58mSipGJ7ffiHhj+Rz
   zmP4/dFstgYcR2Jzy1Ly2Kibusd/IbF+TA55GxJHuTZ3tbwKadpmNjtNM
   g==;
X-IronPort-AV: E=Sophos;i="5.90,288,1643644800"; 
   d="scan'208";a="198749678"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 25 Apr 2022 19:20:20 +0800
IronPort-SDR: Lj0Hd/1wChq2MyiAToiYNBHdqFddLUSS616OnQdp2Fhk8kd36OyIf2AmeJ3rA0hsYRJUPOpHD4
 MvNY9xcVgjVDSxBF07SXlwIDFMmOwQskLE1OrWdCU4icpVfPerDeEh5k4ZkuONkBmnSXzMXH67
 fWcjArlVZiRjqqm4SeYRYipFuNu7EaFfiSDWn1FLrTh1aM18gTFcR4lpTCT6F+OwMl1jusVRoS
 WR2p/L6DolG3IYRxhzX9eBYmNXDzZFtVluuzZhtLQIjcBOJfnsTQZpWSjGM0e+z1YCrH53ZQgg
 A6VCiKZO+jY+IuSkhp2+2JMJ
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Apr 2022 03:50:32 -0700
IronPort-SDR: mkcXXGjOP64cYjpecFEfzWWPfF0SUtVT4jXGRJWcpiAeTB8i39wtRd0eNZzCwhnpYDyFUbwD63
 BA0sTYpYX9Rcaq7+8vD9jCKg8B7mO05vgHuuoaGr7h/3kWyzaNPl2csRCRGUnDvLHyY+DNT0we
 bOhTxoKvt1fDCxx2vMpVZArEmoQVHE9PUTR5zxF8XdOZgFfTkAfhsa9qSoJLYLWv5e43g1pA02
 kXeJZHbbVk20+8UEtuk9aUwMj8SbYPG6l/56/aXEgZQ4bOJ+AY59p9vT2d6sTzQnBRLFadQC6P
 kE8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Apr 2022 04:20:20 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Kn2cM6W27z1SVp4
        for <linux-block@vger.kernel.org>; Mon, 25 Apr 2022 04:20:19 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1650885619; x=1653477620; bh=VwxgDF6KxJ/vYHJLtUtghe4K2L20v2/aSUH
        kS2d3AT8=; b=qH0/Jr7Ul7wHJSYwSOE/me6+L25/Xc5Fg0rvh3HX/TQPERG0w4R
        QJxEmrGL8zr/5X1N1ZzbF1gS1JRpFNCyX0GuOhW4PqqhmzmKeFWc2vQ/n9Lek/Ur
        XzJnjE449ihVDSo9B9lnZR6sPqBpNtf/oKoB2ybSx3FwJ+NN68fsVzySHuXbWKxH
        I290j1IvT+Q6lHHEbhh1a0ntgpuOxHQOgtEtARpOwFJuGzNWOQnt4PWWY7PIs3tU
        Iv6hC5oKuxl7LE/P4EBw5p+QXwhNLIW9SJoSFrLRl6Fp785zQWdWa4EXn6Tzvc4k
        rhXcT0OORn91ft3kwZSCXWeDU/4+vE/hESA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id XtHZlI_QofIU for <linux-block@vger.kernel.org>;
        Mon, 25 Apr 2022 04:20:19 -0700 (PDT)
Received: from [10.225.163.24] (unknown [10.225.163.24])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Kn2cK1hVdz1Rvlx;
        Mon, 25 Apr 2022 04:20:17 -0700 (PDT)
Message-ID: <88d9e8f4-cc5a-4897-f511-8f5b7d9a0acd@opensource.wdc.com>
Date:   Mon, 25 Apr 2022 20:20:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH -next RFC v3 0/8] improve tag allocation under heavy load
Content-Language: en-US
To:     "yukuai (C)" <yukuai3@huawei.com>, axboe@kernel.dk,
        bvanassche@acm.org, andriy.shevchenko@linux.intel.com,
        john.garry@huawei.com, ming.lei@redhat.com, qiulaibin@huawei.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
References: <20220415101053.554495-1-yukuai3@huawei.com>
 <dc800086-43c6-1ff2-659e-258cb75649dd@huawei.com>
 <3fbadd9f-11dd-9043-11cf-f0839dcf30e1@opensource.wdc.com>
 <63e84f2a-2487-a0c3-cab2-7d2011bc2db4@huawei.com>
 <55e8b04f-0d2f-2ce1-6514-5abd0b67fd48@opensource.wdc.com>
 <6957af40-8720-d74b-5be7-6bcdd9aa1089@huawei.com>
 <237a43f0-3b09-46d0-e73c-57ef51e39590@opensource.wdc.com>
 <c11ebf9e-a232-4a5d-d539-f95f584f220e@huawei.com>
 <2e7969ea-68d0-964a-808e-ee8943de70e3@opensource.wdc.com>
 <35f18afa-0db1-b423-5824-4d5631b0422f@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <35f18afa-0db1-b423-5824-4d5631b0422f@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/25/22 16:28, yukuai (C) wrote:
> =E5=9C=A8 2022/04/25 15:06, Damien Le Moal =E5=86=99=E9=81=93:
>=20
>>>> By the way, did you check that doing something like:
>>>>
>>>> echo 2048 > /sys/block/sdX/queue/nr_requests
>>>>
>>>> improves performance for your high number of jobs test case ?
>>>
>>> Yes, performance will not degrade when numjobs is not greater than 25=
6
>>> in this case.
>>
>> That is my thinking as well. I am asking if did check that (did you ru=
n it ?).
>=20
> Hi,
>=20
> I'm sure I ran it with 256 jobs before.
>=20
> However, I didn't run it with 512 jobs. And following is the result I
> just tested:

What was nr_requests ? The default 64 ?
If you increase that number, do you see better throughput/more requests
being sequential ?


>=20
> ratio of sequential io: 49.1%
>=20
> Read|Write seek=20
>=20
> cnt 99338, zero cnt 48753=20
>=20
>      >=3D(KB) .. <(KB)     : count       ratio |distribution=20
>               |
>           0 .. 1         : 48753       49.1%=20
> |########################################|
>           1 .. 2         : 0            0.0% |=20
>               |
>           2 .. 4         : 0            0.0% |=20
>               |
>           4 .. 8         : 0            0.0% |=20
>               |
>           8 .. 16        : 0            0.0% |=20
>               |
>          16 .. 32        : 0            0.0% |=20
>               |
>          32 .. 64        : 0            0.0% |=20
>               |
>          64 .. 128       : 4975         5.0% |#####=20
>               |
>         128 .. 256       : 4439         4.5% |####=20
>               |
>         256 .. 512       : 2615         2.6% |###=20
>               |
>         512 .. 1024      : 967          1.0% |#=20
>               |
>        1024 .. 2048      : 213          0.2% |#=20
>               |
>        2048 .. 4096      : 375          0.4% |#=20
>               |
>        4096 .. 8192      : 723          0.7% |#=20
>               |
>        8192 .. 16384     : 1436         1.4% |##=20
>               |
>       16384 .. 32768     : 2626         2.6% |###=20
>               |
>       32768 .. 65536     : 4197         4.2% |####=20
>               |
>       65536 .. 131072    : 6431         6.5% |######=20
>               |
>      131072 .. 262144    : 7590         7.6% |#######=20
>               |
>      262144 .. 524288    : 6433         6.5% |######=20
>               |
>      524288 .. 1048576   : 4583         4.6% |####=20
>               |
>     1048576 .. 2097152   : 2237         2.3% |##=20
>               |
>     2097152 .. 4194304   : 489          0.5% |#=20
>               |
>     4194304 .. 8388608   : 83           0.1% |#=20
>               |
>     8388608 .. 16777216  : 36           0.0% |#=20
>               |
>    16777216 .. 33554432  : 0            0.0% |=20
>               |
>    33554432 .. 67108864  : 0            0.0% |=20
>               |
>    67108864 .. 134217728 : 137          0.1% |#=20
>               |


--=20
Damien Le Moal
Western Digital Research
