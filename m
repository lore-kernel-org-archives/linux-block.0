Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B4E6C433ED
	for <linux-block@archiver.kernel.org>; Sun, 11 Apr 2021 23:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20AD160230
	for <linux-block@archiver.kernel.org>; Sun, 11 Apr 2021 23:37:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235726AbhDKXhx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 11 Apr 2021 19:37:53 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:41710 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235466AbhDKXhw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 11 Apr 2021 19:37:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618184266; x=1649720266;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=PRUrjJ9hSuM2EgI53jXRnxWbh13BxSJ7PjFpHXaPB0I=;
  b=JTnKNk+THOZX8x7VkG6W3uCwyen0Z4UqXdFR3Pa4e3nM76KIRiipwjQY
   j18qG1CpKYfP7Nuc4W9/MXiPk+hGymch6zhhSSQ97yFtFibvALWtkX0JC
   JO6iMzfHyvdqGSGM0UPfDh5rpLYst8stEQnWmLtVVUvDBuOkAWEGkmtzJ
   CwaVmItYjathwST93xFd/2zJzGJj9SbrxkF83MEL6C4YaD5eEstL7F95A
   LbfFh1rQSx4exAc3ZIbqdJP7pQBaEpMlYgzZ/+Lj7K5+M1uah76DlVZtD
   p+Z+OcM+Bxxc5e9SWO5bA4/zCqSHLxHwWsB0+Jx480/pvqabkgbA+G8xS
   Q==;
IronPort-SDR: 9hkTZ+rb5jzhibT0Ns8sRhm0HPs+75AWOaU0XSYufKg520iwSoBjxpCBuA8PBSAr7TKey9ae65
 SNP/cE0wULouRjuPnOqKl0jlQ4PBM8GOIGlJI97l+VlSFe46c3C81S6HS7cRqNlWnaFDx5NL06
 oTteQXj6GomjlVW+a+zF3tyEe90ukNNQG6ar+wLiHhJBGBUG4PDbY3YGNZWb0SDKOphIvFwqxC
 ts+CZXYBfgRXSD/8vDaGXzRabHk3cDKyhhmBYr2xTHaqKmrH4+5aHzrCA4F7C665AlWAyp0IUm
 ccE=
X-IronPort-AV: E=Sophos;i="5.82,214,1613404800"; 
   d="scan'208";a="268702225"
Received: from mail-dm6nam08lp2049.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.49])
  by ob1.hgst.iphmx.com with ESMTP; 12 Apr 2021 07:36:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fN7WuZwJszWEMEbiG/WZ2/7bPvwsWEsMbS/nNq62vjhimfwI5uJhtM0lmNKmXp3xtfWjk/aJ6Fh9xmB0OzleLlXxLAYz+s9N6L+zxT/33oSS6farpu8/1ByZbP0NA7ACspZg35nYyoXqZABR/ZL/4Ms2JKDuNXLbC5TVYGQB8rJQJILpgeWNaNNkazOy83HSJku9eQZZzU6UVuiXV2u2SDqpIOLSFMjf/i4ytNBX2CWV4WMuMZY7dNuzA5xu1QebsC8wQb6sywbgO+bILoNDua+/Atj4X+YEa/8gKJft8MvrDAEy8tLYTxRTtTCboR2cP4Y71slVEk00P9/TaVSGEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SVc6LsYF7INp0cYgpSfTDOle7cClQeB3FEko8nZ0TCU=;
 b=eZJT9EKFZ9cPLh3CzOAkpGp/04Wx7OQzWt2AcCEhjvh58KSpNF1akfs7W2KbEzatclZZiQ1kv8sgy6Dz9sPR+TfjDNvpGrc89ydHu7OKvgnFUyKyaLGI5qRLQyo3QPtVXVUMR9eCu1NJzIhxdUwaGO5o0PIL4RQfBmZeK0EMd8nsMJMKxCOHPA70aPq3FU8Oo4TtJGvcxbg6IzjvUNPmvOUzOlG1UG/NAK68DxQ5wG7J7CYoD61CIXXSFWG075DJNcuI2Sllolt6hDBjCRHnOtIHaADFjqWQeE8VmXszjegbwGkAJj4BScFAGnwTGr34DU0iSlmxVp9Shg2oH9tYaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SVc6LsYF7INp0cYgpSfTDOle7cClQeB3FEko8nZ0TCU=;
 b=OEvW5LPs9zB7uR+TpYRDkBc5y4YIOc6dL1Gtdp5ZdBiFL1whvwCmV7hUkftiqyASDwGFBucNh8u5v8fJsuPPhqFpO6MPiiTTwpbszkG/C9JtnK6KL1UmUqbokyQMYMF7KkbtouyjXN557huJQnYZfFW9TOYZEGA70TsWRW0gK6A=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by MN2PR04MB7071.namprd04.prod.outlook.com (2603:10b6:208:1ec::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Sun, 11 Apr
 2021 23:36:46 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::8557:ab07:8b6b:da78]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::8557:ab07:8b6b:da78%3]) with mapi id 15.20.4020.022; Sun, 11 Apr 2021
 23:36:46 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Max Gurtovoy <mgurtovoy@nvidia.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "oren@nvidia.com" <oren@nvidia.com>,
        "idanb@nvidia.com" <idanb@nvidia.com>,
        "yossike@nvidia.com" <yossike@nvidia.com>
Subject: Re: [PATCH 1/1] null_blk: add option for managing virtual boundary
Thread-Topic: [PATCH 1/1] null_blk: add option for managing virtual boundary
Thread-Index: AQHXLu/rk/KcLC3fD0u7SRVgJvswXQ==
Date:   Sun, 11 Apr 2021 23:36:46 +0000
Message-ID: <BL0PR04MB6514EE852B9B75F2B3D73CECE7719@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210411162658.251456-1-mgurtovoy@nvidia.com>
 <BL0PR04MB65147B275F17A60AEA672651E7719@BL0PR04MB6514.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:1134:9421:2151:4ee3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b22062a0-f54f-4ac5-80a4-08d8fd42abca
x-ms-traffictypediagnostic: MN2PR04MB7071:
x-microsoft-antispam-prvs: <MN2PR04MB7071D5475DC2E74C626D2493E7719@MN2PR04MB7071.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1SdrjLS0PsqHEMPCISNXNVCp3MknGZqEskvqC4hHKdkj3zGrYoJRC+r6UPdlwvSqC0eFpukEnxitJQnTXCYH5CEkSYDullEcJnIVdpoJ5gl1aa2EXpPlVaFpy5HIhHYiSfie1OgMurlK4zdm9YH8BnY3u5bp4vqr7CQLF9Ac3fqrLhHIJ4WyS5ZkEust8xZo19zoKDsS74oHWzBvzdhdSOifSP03RbtT7ilrYJ6z7m5E/khon15lkbogIcbxXCYh8llQK0yE2ySp5+CHLJ1wM332hPj5arZtf6BZzI0laKgPmVEfI2IFlkKyPmjmsJvD34vzmsE1Ktutv8nA+PZJuoAClR+HPCTzV5esoggyqta/LWgjmw4sP01VqFuuw8+pTyU7hZT4mkTTrF58kXA9XjQNXyjUKNkaXvWPiDtr0GGCvKIwzNXYOUryFJ5DdG1vXTa1TBJiPuTvkm0n/W4ETc/4zyV7STmON8qCHK0ai7fxDYSIqsb2Bq+HIjs8THm66xteGEp/pPdee/RpqAlICwzrTPTvme1W64GSyUyIF5W39DLeFkkFj9SjbsE9VCNGGNOjaGVVy1fo1g9+YlhHGie59AsmEv6V/3FX3LwiEM0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(366004)(39860400002)(376002)(346002)(2906002)(6506007)(53546011)(7696005)(91956017)(76116006)(71200400001)(38100700002)(52536014)(66556008)(86362001)(66476007)(54906003)(64756008)(110136005)(316002)(33656002)(186003)(9686003)(55016002)(8936002)(8676002)(83380400001)(66946007)(66446008)(5660300002)(4326008)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?l9BZAThVTtFFwJkub16rlM1nqStDTnvWhhXdFEHNx1QolukgD1a5oqtYT0g9?=
 =?us-ascii?Q?l4Hp2/ROpatrt0vrfn6Mz0vHX3JSLkWDKai+ES5TGwwVQNLIS9E9iDopdWf/?=
 =?us-ascii?Q?aNW3yDXt/tp3U52/ASOxCZ3olRTq6XoMsMH1aroMQ1GA1hx1gnIK8xoyOLZ1?=
 =?us-ascii?Q?HwLdZhSJDjL8daTQXDCGAidJ5CqG6FR8/mbVr7wre1imGUu0Brc3oOw0cOso?=
 =?us-ascii?Q?+DEPnklZKoEwU4T9OEC4+maGnPwrzoz1pHDESGUw++Up5/jep9dvkNVN3OKA?=
 =?us-ascii?Q?trQnxvg1tdh6SSYnSzuNqz4xUviN6uUHn/T/Bs1uCEwd/UVd7WtGa3+up2vX?=
 =?us-ascii?Q?jVQ2ATf7tJjD14yC//VCd8OD+uh2cGgPNpf7HuylrsyD9aqnyzmMF8fDJvOG?=
 =?us-ascii?Q?NAzbJMlhqFsBsH7kif9LLVbTvuwTZhRh/gDI/+4LINtXlHulVJMlI8XoWmlw?=
 =?us-ascii?Q?BqEXYdbzJn1e5uX0E7+MWVlnbBADpuL5fJaYiyppwonfzTvYuMS7ydA3HU5o?=
 =?us-ascii?Q?VRQb9bu7LxeQv3wCX0mXtlOBfME44i3b9QsKzT6nr/WJRyWIfQHexXVPH7hB?=
 =?us-ascii?Q?ZnwjLMuz7JGotxpfLkkTpFgMElzqiQXn95K9ZXp2QnmIQQbVZnGz9ZXQTmnM?=
 =?us-ascii?Q?0OfWrITQeuE5fIG8tS4hALcPDtJw997LEUJg3KQ0tQ33sbCe5qHZeEzR6bYh?=
 =?us-ascii?Q?j/XGJ0CEPCME6ruLymBlFbjfbsMp8kRhE5cNh8PiAi6K4EJK2+oFhvqBpIEm?=
 =?us-ascii?Q?PL9O3UVvefbUZuODKtRVG+PCzy0musGGKa7Ve4hW9xB6Rd1Of8fwcxuxt9EW?=
 =?us-ascii?Q?89r0h5ZuDIYKIOCKM9S2iKVCt0lNivhwtOi8yTJfrjGNf2N6Nl6/2huy5EuQ?=
 =?us-ascii?Q?aAcfCmY4Ys1fZ0G0yfILpmNPRTzTBtXwVxGBikQkiw/IL2zC2ejRk0xyzhiZ?=
 =?us-ascii?Q?9I5EZ7uvPIDsJ2GuMnr81NXLVvQApATB5hgXAVL3uQi6gsfUNFnaOLVyG0wB?=
 =?us-ascii?Q?gr/PJCNDjwl7+n54DHjXZgpSqocSIdQVUzStyhLz736a3RxmyanhssfE1c5D?=
 =?us-ascii?Q?l+sEt6ZCvql6xtmAUBdQLsYKbtz8BA2L+fFXLnZdgDQRBmX+S8wSjl7fVUIU?=
 =?us-ascii?Q?i/IFTk9zYjt92uC12qh7uSV4J9TH1KLwrZVyt8luzhSJRfF9fbKOXoOKGnJz?=
 =?us-ascii?Q?47RLlGz6VSmcozs1RP0endw2SdkJz83HvWEvClzmGuCLqfHuykLVN/vVwSir?=
 =?us-ascii?Q?AuHvFDmxTBTR0ZQwhXzkB0M1kv0RCdLtMnDQ00tBCdNvQf6OfKt8Dq0EFOHQ?=
 =?us-ascii?Q?bgqIwZcvRv0Zpua1zS1JnI1fEZ00Uj+7w1JokJJzIxgk0K/rJs/80IcQ9jNn?=
 =?us-ascii?Q?mYU9ex37FxuwIdDT4oxRRmf+Nl4XXdfZuAvcNJ+DHpcERRWXZA=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b22062a0-f54f-4ac5-80a4-08d8fd42abca
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2021 23:36:46.2260
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o/7XWWFv511+WJ0ck/vR9u+ChuOkhrXjibHSu9/UUygb7pGPjoF7AwhtdYkE2k4Y3g9JBZEAkPWBS4KaluPcVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB7071
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/04/12 8:34, Damien Le Moal wrote:=0A=
> On 2021/04/12 1:30, Max Gurtovoy wrote:=0A=
>> This will enable changing the virtual boundary of null blk devices. For=
=0A=
>> now, null blk devices didn't have any restriction on the scatter/gather=
=0A=
>> elements received from the block layer. Add a module parameter that will=
=0A=
>> control the virtual boundary. This will enable testing the efficiency of=
=0A=
>> the block layer bounce buffer in case a suitable application will send=
=0A=
>> discontiguous IO to the given device.=0A=
>>=0A=
>> Initial testing with patched FIO showed the following results (64 jobs,=
=0A=
>> 128 iodepth):=0A=
>> IO size      READ (virt=3Dfalse)   READ (virt=3Dtrue)   Write (virt=3Dfa=
lse)  Write (virt=3Dtrue)=0A=
>> ----------  ------------------- -----------------  ------------------- -=
------------------=0A=
>>  1k            10.7M                8482k               10.8M           =
   8471k=0A=
>>  2k            10.4M                8266k               10.4M           =
   8271k=0A=
>>  4k            10.4M                8274k               10.3M           =
   8226k=0A=
>>  8k            10.2M                8131k               9800k           =
   7933k=0A=
>>  16k           9567k                7764k               8081k           =
   6828k=0A=
>>  32k           8865k                7309k               5570k           =
   5153k=0A=
>>  64k           7695k                6586k               2682k           =
   2617k=0A=
>>  128k          5346k                5489k               1320k           =
   1296k=0A=
>>=0A=
>> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>=0A=
>> ---=0A=
>>  drivers/block/null_blk/main.c | 7 +++++++=0A=
>>  1 file changed, 7 insertions(+)=0A=
>>=0A=
>> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main=
.c=0A=
>> index d6c821d48090..9ca80e38f7e5 100644=0A=
>> --- a/drivers/block/null_blk/main.c=0A=
>> +++ b/drivers/block/null_blk/main.c=0A=
>> @@ -84,6 +84,10 @@ enum {=0A=
>>  	NULL_Q_MQ		=3D 2,=0A=
>>  };=0A=
>>  =0A=
>> +static bool g_virt_boundary =3D false;=0A=
>> +module_param_named(virt_boundary, g_virt_boundary, bool, 0444);=0A=
>> +MODULE_PARM_DESC(virt_boundary, "Require a virtual boundary for the dev=
ice. Default: False");=0A=
>> +=0A=
>>  static int g_no_sched;=0A=
>>  module_param_named(no_sched, g_no_sched, int, 0444);=0A=
>>  MODULE_PARM_DESC(no_sched, "No io scheduler");=0A=
>> @@ -1880,6 +1884,9 @@ static int null_add_dev(struct nullb_device *dev)=
=0A=
>>  				 BLK_DEF_MAX_SECTORS);=0A=
>>  	blk_queue_max_hw_sectors(nullb->q, dev->max_sectors);=0A=
>>  =0A=
>> +	if (g_virt_boundary)=0A=
>> +		blk_queue_virt_boundary(nullb->q, PAGE_SIZE - 1);=0A=
>> +=0A=
>>  	null_config_discard(nullb);=0A=
>>  =0A=
>>  	sprintf(nullb->disk_name, "nullb%d", nullb->index);=0A=
>>=0A=
> =0A=
> Looks good to me, but could you also add the configfs equivalent setting =
?=0A=
=0A=
Oops. Chaitanya already had pointed this out... Sorry about the noise :)=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
