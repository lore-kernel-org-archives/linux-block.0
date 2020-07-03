Return-Path: <SRS0=jyL6=AO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C84C433DF
	for <linux-block@archiver.kernel.org>; Fri,  3 Jul 2020 06:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 088E720772
	for <linux-block@archiver.kernel.org>; Fri,  3 Jul 2020 06:23:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="PBkD/F97"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725891AbgGCGXz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Jul 2020 02:23:55 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:43626 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbgGCGXz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Jul 2020 02:23:55 -0400
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200703062353epoutp0241a09c43e88e687a5228e23461a45b93~eKfD3TXQh2523525235epoutp02-
        for <linux-block@vger.kernel.org>; Fri,  3 Jul 2020 06:23:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200703062353epoutp0241a09c43e88e687a5228e23461a45b93~eKfD3TXQh2523525235epoutp02-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593757433;
        bh=wf+fydZyBcX1y3wQWBM/V8mRpwY1GdNat8dvYrhiqAQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PBkD/F97m2A4l2lIIPz8RiaaLJZi07Rmo6G1BaCNJuDdrShUo3l1chv+UjgaL0Fs2
         X819Nwyyu7E7ciyi/3Pwgroz7KM/Jti/QNx7iZruxtETtFBV510Ucf9ehINKqBIJvF
         0smpzmtIb+LL+aFb1PG5KNBLStsbqvt+ecowrcIQ=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20200703062352epcas5p25738828f4392f22d6038f378461d3048~eKfDaJNDR1329713297epcas5p2c;
        Fri,  3 Jul 2020 06:23:52 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        25.99.09703.8FECEFE5; Fri,  3 Jul 2020 15:23:52 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20200703062352epcas5p18d1fdaa1c52e3607dee464b6bdd8240f~eKfC-QTa60667506675epcas5p1D;
        Fri,  3 Jul 2020 06:23:52 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200703062352epsmtrp10b72ed0e345ed0f533408f527e7a7f67~eKfC_n0pw2823328233epsmtrp1l;
        Fri,  3 Jul 2020 06:23:52 +0000 (GMT)
X-AuditID: b6c32a4a-4cbff700000025e7-e9-5efecef81535
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        36.03.08303.7FECEFE5; Fri,  3 Jul 2020 15:23:51 +0900 (KST)
Received: from test-zns (unknown [107.110.206.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200703062350epsmtip26f4e374480b820059f7862f038499f0d~eKfBoKnIg2126121261epsmtip2m;
        Fri,  3 Jul 2020 06:23:50 +0000 (GMT)
Date:   Fri, 3 Jul 2020 11:50:55 +0530
From:   Kanchan Joshi <joshi.k@samsung.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>, Selvakumar S <selvakuma.s1@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>,
        Javier Gonzalez <javier.gonz@samsung.com>
Subject: Re: [PATCH 1/2] block: fix error code for zone-append
Message-ID: <20200703062055.GA26058@test-zns>
MIME-Version: 1.0
In-Reply-To: <CY4PR04MB3751B8037BE65D573667A6D5E76A0@CY4PR04MB3751.namprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTcRTH+9273d0Jy9tMPCmtWlls0tTUuEUvqGiI9qCH9Foud/M915Zm
        L1hFqVkamqKjzGBZPrJaNkpT7IoNNUOxp5U500VlYQq1Flpt16D/Pud8zzlfvj9+JC4u5/uT
        idoDjF6rTpESXjxri0y20PlkQhXSYQmgq9/mE/SprO8YXVnditHv34wJ6AL2OaIbe4PonvqL
        BG39dRmnPzvbiFVCZU9nutJSlUMoG14ZCWVeXRVSjlkkyqzmXGwjscNrmYZJScxg9MErYr0S
        HGUFhG7IO7Pvjg0Z0SXRGSQkgQqHyis1vDPIixRTDQhuVHfjXDGK4HnJaz5XjCFw2L79VUjP
        yiPzFq5fjyDr7U+MKxwI8mxm5B7iUfPAmYO5kaBk0FWY7nabTsmhoumr5yZODWNw6qEVdws+
        1AooHijz3BdRC4GtOeRui6hp0FY6yHOzkNoNX66V8t3sS82FZqvNYwtUEQlGy28BF2cNFFd2
        T7IPfLLVTbI/fMw/PckGcL1pxbnlbAQvjKU8TlgJ3Q/GMTfjVAK0/2AFHE+Fc78GMS68CLJP
        i7nxOdBXMMTn2A/sJeZJVsKofYDg3sSMQX9NO/88kpj+C2T6z4LjpZAzcoJv+muBUwFwbYLk
        UAY364PLEb8KzWB0htR4xhChW6RlDioM6lRDujZeEZeWakGeTySPvIfs/SMKFmEkYhGQuHS6
        KDZwQiUWadSHDjP6tD369BTGwKIAkif1E0mdj1ViKl59gElmGB2j/6dipNDfiJ2vlzwNKhwp
        3l3UmBQWma07tsC8ZNa8H8SrcQt+POKB3L/DtHRR6jft4uFdXVf3kXWKrJfh9qG216udrmDi
        LovlCnjfcTrm7mKVKzGpfKcudvaUoqrI0tqxTsnmgRL6XtlwRmZQSK450PvnpqEb7Z8GVWvD
        XbdsaR9NvjOjrifej12iKE8jMjdIwhwRe56Ndj07/r4wZyDJr/ZxnlFU8SVas73B5GBP8qOb
        jfm2vfvLPsevz2gObKvoiumUfYhJttGbBEdCrE3ysz3CNYWaVnsvW5B5tYgYv3CpcWryNtfR
        I726UJ+tOxK++q7TRMbINvhFhbUsFzTF1S6YP/jusPdtKc+QoA6V43qD+g+7dlekswMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRmVeSWpSXmKPExsWy7bCSvO73c//iDI7ft7FYfbefzaK1/RuT
        xcrVR5ksHt/5zG4x6dA1Rou9t7QtLu+aw2ax7fd8ZovXP06yOXB6XD5b6rFpVSebx+6bDWwe
        fVtWMXp83iTn0X6gmymALYrLJiU1J7MstUjfLoErY1bPZbaC6bwVS8+9ZWpgfMnVxcjBISFg
        InFsSUgXIxeHkMAORokFT7ezdDFyAsXFJZqv/WCHsIUlVv57DmYLCTxhlGh7xw7SyyKgIvGj
        kwnEZBPQlLgwuRSkQkRAS2LZvnesICOZBd4xSVxfeIAJJCEsYCcx7dE8ZpB6XgFdiUNrKiEm
        LmGSWNRmDWLzCghKnJz5BOwCZgEziXmbH4KVMwtISyz/xwES5hSIlXi7fCYriC0qoCxxYNtx
        pgmMgrOQdM9C0j0LoXsBI/MqRsnUguLc9NxiwwKjvNRyveLE3OLSvHS95PzcTYzgqNDS2sG4
        Z9UHvUOMTByMhxglOJiVRHgTVP/FCfGmJFZWpRblxxeV5qQWH2KU5mBREuf9OmthnJBAemJJ
        anZqakFqEUyWiYNTqoFpKYeRg5O12eUttXO23IpY3CW32tR3zawHpRa3LvGpyW7aFD0zcetB
        qYV9TkGcU74FyvE+/eCxK0Zjlev17rvhloxRJ07c+XRAtWFq0cm1nrwlPmkKOms59gfp/5Sp
        5ri94cPyVX3CpmcElxuLFZmeVfxcv+wu87fd87hyu/+t32Eyr+j3S9OCZ5EtLX6b2Y1OdQdl
        3RLv/L2DR+DpRe72OcbrFeN2+x1a83nO8jNTOT5umPO9W6BV51lYlnh/0MoZk7yXz2bicKq1
        Sru4SGHdlYSusoPJb55EOQsb8LJ/O/hqmfkW/xkbmbvmd/tvyLF8cf+ajs8p86z2aSFf0/64
        uDFMfJ/kYHmo89mF+Z9ilViKMxINtZiLihMBMhlxePkCAAA=
X-CMS-MailID: 20200703062352epcas5p18d1fdaa1c52e3607dee464b6bdd8240f
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----FBC7EIImzEv-3WQrgwRbJYn4xAlwhlhWWV1zALX9mq8rjZSB=_c4a69_"
CMS-TYPE: 105P
X-CMS-RootMailID: 20200702154208epcas5p39fe202f642a9d5c8dde9b911645c594c
References: <1593704330-11540-1-git-send-email-joshi.k@samsung.com>
        <CGME20200702154208epcas5p39fe202f642a9d5c8dde9b911645c594c@epcas5p3.samsung.com>
        <1593704330-11540-2-git-send-email-joshi.k@samsung.com>
        <CY4PR04MB3751B8037BE65D573667A6D5E76A0@CY4PR04MB3751.namprd04.prod.outlook.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

------FBC7EIImzEv-3WQrgwRbJYn4xAlwhlhWWV1zALX9mq8rjZSB=_c4a69_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Fri, Jul 03, 2020 at 05:29:50AM +0000, Damien Le Moal wrote:
>On 2020/07/03 0:42, Kanchan Joshi wrote:
>> avoid returning success when it should report failure, preventing
>> odd behavior in caller.
>
>You can be more precise here: the odd behavior is an infinite loop in
>bio_iov_iter_get_pages() whcih is is the only user of __bio_iov_append_get_pages().
Sure. Kept that in cover letter, but missed here.
>>
>> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
>> Signed-off-by: Selvakumar S <selvakuma.s1@samsung.com>
>> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
>> Signed-off-by: Javier Gonzalez <javier.gonz@samsung.com>
>> ---
>>  block/bio.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/block/bio.c b/block/bio.c
>> index a7366c0..0cecdbc 100644
>> --- a/block/bio.c
>> +++ b/block/bio.c
>> @@ -1044,7 +1044,7 @@ static int __bio_iov_append_get_pages(struct bio *bio, struct iov_iter *iter)
>>  	size_t offset;
>>
>>  	if (WARN_ON_ONCE(!max_append_sectors))
>> -		return 0;
>> +		return -EINVAL;
>>
>>  	/*
>>  	 * Move page array up in the allocated memory for the bio vecs as far as
>>
>
>Note: the odd behavior mentioned in the commit message cannot currently be
>triggered since only zonefs issues REQ_OP_ZONE_APPEND BIOs so we are guaranteed
>that max_append_sectors is not 0 in that case. But this fix certainly makes
>things more solid. So:
Yes, zonefs will not run into this. Future users of zone-append may. I
encountered this endless loop while testing user zone-append path.
>Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
>
>-- 
>Damien Le Moal
>Western Digital Research
>

------FBC7EIImzEv-3WQrgwRbJYn4xAlwhlhWWV1zALX9mq8rjZSB=_c4a69_
Content-Type: text/plain; charset="utf-8"


------FBC7EIImzEv-3WQrgwRbJYn4xAlwhlhWWV1zALX9mq8rjZSB=_c4a69_--
