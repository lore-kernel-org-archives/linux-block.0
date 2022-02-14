Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB8BC433FE
	for <linux-block@archiver.kernel.org>; Mon, 14 Feb 2022 07:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241537AbiBNH7w (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Feb 2022 02:59:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbiBNH7v (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Feb 2022 02:59:51 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52985BD24
        for <linux-block@vger.kernel.org>; Sun, 13 Feb 2022 23:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644825582; x=1676361582;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=vE7WoMCgLq27boTw33JzbH+NC0ujRTgFE44VzaN8Chs=;
  b=Qnq8DOyC9b8/EmxzLuAWXijgWHvtE/el2dISlU0DEAIw9uJaCqv4Ev3B
   JzxZiLSxNu95PYinSqBvAuMwo+L65mLALd76bRuPvzE/CJpn9NYxRIG3c
   dYQJbQA+bU9s02bnrsqDi5TpQHjYkEdMxWRDwQ9nsUTgPRtNqUuDUIdg5
   /CCyQ114VGZDAu7Spe4SJLSFWrN8CNwEK5MjJh3nEV3unBg7qj5JQfFvd
   6Qzz8RznYl86zBzea1bX2bMuyZQGox6AdvdVasqB6dGgm0Nn/nvZyrI0z
   m6kBYyAwyCI/bS5Ja+9VRKO63OeLYBW727jzdudKLjukOxOMpjMjfp4pV
   w==;
X-IronPort-AV: E=Sophos;i="5.88,367,1635177600"; 
   d="scan'208";a="197665969"
Received: from mail-bn7nam10lp2104.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.104])
  by ob1.hgst.iphmx.com with ESMTP; 14 Feb 2022 15:59:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W1gncLMI+FHO+B4bEGDsEzCteMaviMn5evDzhV7rTgrdX9BfiDXg/adtVlxmfJ4fHRhu1VHI/oIx18mtSTgcGHAnCpojxkH5dlifzp6ANl/BmNIN6o4B1fO6MGb+E48dFb6q4S7mj2543EtzcuK+aMWAFUzm9FFawysMQypnGIVM8J8FiSFK6P3yISFV+zQ7OhFi/CxiL5QpscCq0DsG6k6TCnk1xmqqIy4MhxGlpoRb/CXq7/Pn6Cd8QlZyJZd3hcHwdeuf7wcXUq0ZR+Gw2CaXqWk9XvhugTa2kfSfQYEo42l+SI9zixfu4mtDB/n1+7B11gZShjy0jVsfbbEYuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cA0i2oLXFNG+bqVkBAjCCq8HfLKPZedRPDS/hWoGsu0=;
 b=efst5DBCSUjuNsRH40WmjzSj+iYGl8xWaj3gwtF3CMPoQv+Q+miP9ERzQo4NQ7yK/lx/ppqeUoGCihvt9BLVNI393lq9etmITCHIthNyqgknUsyeYU0zMWcj3FpBtxR0HkkPoW/afssrZBypJ9uisN1LyKkoN81ihjU3DWiTua2dRSYTzECdyGqh7+MuWNsWp52uW1qW5pCuV2QHqGgkgOEvj9gnL+J/utwP6YSlR9B+RLZi3AY4JmaLu7/8eBAdxCD5AAcVrLwjXYCNPKembCuTkNqQ3ILAk8CuYhsowZY2+PIMN50os+gEvrqLqLevxGa8r+pht0TuXsJ2YFxrqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cA0i2oLXFNG+bqVkBAjCCq8HfLKPZedRPDS/hWoGsu0=;
 b=OjHjD65YbcwtJbTTYrGOiqXoI9h47s4hEboIVcxHYiuiTyDkFwjA0+S1+nARdzB4z9c/CeIIqTQ8ljb6l8PJf9y3tKBR/hgX3PrVgI+WtvJGpSAwCHUUT6+xIkhjHZvP0hwpgT5wa0zChr7SOlUzFb1twuwbgRktc0uvT0xOzSo=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN7PR04MB5202.namprd04.prod.outlook.com (2603:10b6:408:3a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Mon, 14 Feb
 2022 07:59:40 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8d9e:d733:bca6:bc0f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8d9e:d733:bca6:bc0f%5]) with mapi id 15.20.4975.019; Mon, 14 Feb 2022
 07:59:40 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     Pankaj Raghav <p.raghav@samsung.com>, Jens Axboe <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Pankaj Raghav <pankydev8@gmail.com>,
        =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier.gonz@samsung.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH v1 1/1] block: Add handling for zone append command in
 blk_complete_request
Thread-Topic: [PATCH v1 1/1] block: Add handling for zone append command in
 blk_complete_request
Thread-Index: AQHYHyuwDs0xN4PpMEadJthhR/vcZw==
Date:   Mon, 14 Feb 2022 07:59:39 +0000
Message-ID: <PH0PR04MB74167D0AC2894C3656A4BF929B339@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220211093425.43262-1-p.raghav@samsung.com>
 <CGME20220211093602eucas1p1fe39e931232162a686b2feb06ea1f314@eucas1p1.samsung.com>
 <20220211093425.43262-2-p.raghav@samsung.com>
 <PH0PR04MB7416B842B185ECF0F52AF0949B309@PH0PR04MB7416.namprd04.prod.outlook.com>
 <YgaMGbtYHgscxfxZ@bombadil.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2da0cc7e-aabc-43da-648b-08d9ef8ff3e3
x-ms-traffictypediagnostic: BN7PR04MB5202:EE_
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-microsoft-antispam-prvs: <BN7PR04MB52027D35A619A000883AEFF89B339@BN7PR04MB5202.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6kj9N46QJUBG2whli4os6ESskPppPOrvE0lRlkdOdwnv+kGXIXO3nwrYH+sI8dcfoTxpu7ru9nMUTq8jb/Ns+g2Golgll71sYGt6jns1Hm8MmNzvthf40K1aF6OnTC7+kTgfLW6QWTZAs9mWJussIaQPADfK0LUClLbh7SgtDC6O1+VVnpfELjkH9i7cVIkXk2Z2C4J+kOD1M6cm+ih0Bfn4wNhuRZp5njFf42jgGRfOy5NhwFG9rWWHFlpzf3EJ2FWBBgwraARDuyqZLmqxszOyzwut5W+GC5kMs1omfJV3oH7obfrWLa9NutAZsSlIoGnE1dUAoqKAASTuUzveVk85avC1+3H5HQAnH5AN1mtX1Vy1WAjjiFKKxUH2jrP4pb65u5+70qLdnO2j3ZDxFd6nJBe8eAFF2x/OJ7UUMqKJIhu1aMJCtbmipQGkcFBIzA0y4Uc/VMZdNEsDWOzjgAMjDyVsWZCckvzNCED+jrqLvug5iRHiowypsrV9+1y8/ZM5vbrd/LTKT+WHfqvIMq+R094FAepRO6k0Oc3U4jBjvAl9T8BgeWZY7H3ClPnZ7L/uh18zdWaUNPUK72OaH/VNaYm9hBM3xVoJx4kUuqfcakoy266QzeTObR2AYnI+dpCDA3s8v+0y/7h0r3fL1o1kZRMTj+Z+00lM3r+qAxPzr59Zi5tNCi6xn/pNsfkIgaxYdPTOQTbZg37zqSkUBw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(9686003)(6506007)(122000001)(71200400001)(38100700002)(82960400001)(33656002)(508600001)(8936002)(2906002)(53546011)(52536014)(5660300002)(7696005)(38070700005)(54906003)(6916009)(64756008)(8676002)(4326008)(83380400001)(316002)(66946007)(86362001)(66556008)(66476007)(66446008)(76116006)(91956017)(55016003)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Ct326tl05iZoFjFnYDcK9z7HCdi8TlHv/FJgfDgA+BgvpQwCBje+kGhOCy?=
 =?iso-8859-1?Q?p64jyBeeWOFNL77lHTKqu9Ncx10mwE8vLbulrV78wgg130g2003nOSJiTc?=
 =?iso-8859-1?Q?4IfLmNeHTqDmrwBLbDEeDlMNGYzLgDfMOwAO1zuPaaPmz36fVrQilKRT2o?=
 =?iso-8859-1?Q?qr5whh/by49GnrbLMwzpAPIHt3NtDsey/L8oKf3LyJuS2mVkKdRST+alSg?=
 =?iso-8859-1?Q?Rbe8u+2rExVh4960k2ean+ynFg0qK/NWtV8Z/k8RMfmbOYImemeHET28b5?=
 =?iso-8859-1?Q?rAkIWs539cmeIm/orwOF+IXGZMLJoZ9dXd7upXxUYL6ytfqKiw7DX9hbyw?=
 =?iso-8859-1?Q?sFo1ZQmBqCoiNu+4THY/xVZXRG4y+SH1K1ZnpfMMFltiXciXw7sQ9eQMJ1?=
 =?iso-8859-1?Q?+5k45X+LtyrX3N8AGlYV6KJep1QNlparZhq03UtPPQhNzZWp1M3zbEA9sY?=
 =?iso-8859-1?Q?bSlTe6sLEqByOOBZKwiIeqWxCtRVXuTk9V4eiEsqO7qmltjnDr1g3aSI+O?=
 =?iso-8859-1?Q?IM2ozmfv87DMQOHDSYbYbyBvp9FljMrz6Iad6kjL6v6uLmMOuiIqf8JRqu?=
 =?iso-8859-1?Q?WsHFrJSu2uBTSPzfHu1Daynp1yFwidn2ibtWwbKSAKoAYPTL7nYKtr4JeE?=
 =?iso-8859-1?Q?h8y4NqGsh0LvEEJmUcQQz2Xt5YulKpGu0xn9mdB1Kf3Wab2PnlxLLNQyxy?=
 =?iso-8859-1?Q?uFxL2kwduWGUYGCf3No2gJ+cqEEX5HZhA9BYAryZJyGViNcok/h8ftIL7e?=
 =?iso-8859-1?Q?VppsayWCK+nA/04GnVnPM3EP3HL/UMpk/bY3tmlnwqAecYd52dMux8tPep?=
 =?iso-8859-1?Q?BtUODdisHR3rSCBm6a8Em6KuHRee4ZLULrGVqVHhyRSoY2tvJeTrcPbaCU?=
 =?iso-8859-1?Q?TPqLxrql9t1GBQ6zsJV/Alzky3kCXDrHEej3CUR99HgFINpLxRJlng43Wq?=
 =?iso-8859-1?Q?y3jDNbU73CYobuxSDLpbDk6s1jEOKR4BOiEO4yHIQCefanFtNy+HBZr92l?=
 =?iso-8859-1?Q?dgplRDzDzhWrh1iRAQ1AN6aznqDQztM9tAq1wyFpPcpRM6A9JC/IgK5Twt?=
 =?iso-8859-1?Q?xQCfaQ7k8sjWQroNuG+9W7UvMVzqQ9UnAcoS0kTVE88oJMIU6q7fYR89Al?=
 =?iso-8859-1?Q?J9vprzbCZLAGPnMBf5CKQMS2K5zVbnC2b9OD9MwuXyQTIVBcKX3Hdq6tR7?=
 =?iso-8859-1?Q?kAQQskthiRsmfY+URx2oC0el5GYyY1TUEQ+0Xz/HKjuaQ5cb77JfydymYV?=
 =?iso-8859-1?Q?x69dcxqx/vaTgFLBSvCYJ4bbX8T8ISWx0otvJC6Hr8OYd0ckWNBk/8sjAF?=
 =?iso-8859-1?Q?KAiCVdQUaGc4BraqvVJYb9MD7GIwLN7xUjsU9OBGiIrl28nkrRSiXrDiFR?=
 =?iso-8859-1?Q?YfUV4qnBUe2ckwRIUIg5x/JgFRJYQ/2FjED6BufFE3Gir5W4J6oyLCvP7w?=
 =?iso-8859-1?Q?eLRZ5YsSEer28czA6RHN8ac74FK9D1yQAXfPnP6SkGIbbILveTEhqhKy+e?=
 =?iso-8859-1?Q?E/2FmSPcWEUvDc8SgKwFmmu12RJHH4+/75SHJyZF/UMfWBJajBTHcbuck8?=
 =?iso-8859-1?Q?DpX/0kq8lcJlJwQF0/VyINDMJob6riDtT733143w2u37oOHA0BT4qOnZiQ?=
 =?iso-8859-1?Q?CeQXzSRCzXdqSawfB97SB3X8X+/6QjVidafPTU3p4yyRLOHy3c8nmTb9TA?=
 =?iso-8859-1?Q?ETMHASeMp6ZL93u5pXGql8/tXzfZIV5zMg3uKXMiX3AuhWwf7kB6vCjnGE?=
 =?iso-8859-1?Q?V+br84d7CS5/wO2El8CnzLqSk3g6fXNfzNsHLrcCN0qvPz1vNGoPmN754O?=
 =?iso-8859-1?Q?Fw/zXon+7aHsloBdJ//Ii3xz5Fp8de0=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2da0cc7e-aabc-43da-648b-08d9ef8ff3e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2022 07:59:39.9513
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KPlf15omQilxkAimoLBTsyW8IBS4QUlyBrWxyNQNhN/OD6enp7s81B1unIfve673EhyHN1w4fPS1qaeBDPYhbKvmFhV9xWAxnlVLhufzAIU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR04MB5202
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/02/2022 17:17, Luis Chamberlain wrote:=0A=
> On Fri, Feb 11, 2022 at 10:02:26AM +0000, Johannes Thumshirn wrote:=0A=
>> On 11/02/2022 10:42, Pankaj Raghav wrote:=0A=
>>> Zone append command needs special handling to update the bi_sector=0A=
>>> field in the bio struct with the actual position of the data in the=0A=
>>> device. It is stored in __sector field of the request struct.=0A=
>>>=0A=
>>> Fixes: 5581a5ddfe8d ("block: add completion handler for fast path")=0A=
>>> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>=0A=
>>=0A=
>> I would've preferred if you had put the trace and steps to reproduce =0A=
>> in the changelog instead of the cover letter but, maybe Jens can update=
=0A=
>> it when he applies the patch.=0A=
> =0A=
> That would be wonderful. And a new fstests :)=0A=
> =0A=
> I'm surprised no one caught this earlier... does this mean... no fstests=
=0A=
> yet covers this? If a test does... then does that mean...=0A=
> =0A=
>   No one is testing zone btrfs... since... around December=0A=
>   (5581a5ddfe8d) or January (merge commit to Linus)?=0A=
=0A=
Ahm no. Please be sure we do test zoned btrfs. But yes, I'm at the=0A=
moment not testing on ZNS drives, so I haven't caught the bug earlier.=0A=
=0A=
