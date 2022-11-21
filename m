Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED30C4332F
	for <linux-block@archiver.kernel.org>; Mon, 21 Nov 2022 11:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiKULT4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Nov 2022 06:19:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiKULT2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Nov 2022 06:19:28 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B2E2E9E3
        for <linux-block@vger.kernel.org>; Mon, 21 Nov 2022 03:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1669029287; x=1700565287;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+eTLoEecoeOPZS+070303SyQmiW+hvJCLJSekB2pFK8=;
  b=lIYiczpwixuU4BY4mNZMLmNJWjIXGKtlPHSnDHSuKgziFBYd1ARP1uek
   VBgg6Hrr077F0n9q7RpUsmmgvAZ2LiuLB0ekx3bE/v4k9tej9W/5v/APQ
   ZPc+4Gk3OLE9aaDjUePq/mh5G56E8HDtCpSjiPML7g36vG7zazV2ehwPt
   StiiPq9WymBicW0nYy+ZpuULDSSgr8rd0eUOwPndlBxp9fiZWu0ckpAsN
   Ing3IkREw6AflwLdy9/SHpgZ1Zsy//S+AzZsU3P3hA0Y5kEggxrXQMbdx
   XI0M3qAmZdGnO0FJgHuUmTe1bo+Kp83FCFnLDFKW+rQgjH7p/0mZQzrz4
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,181,1665417600"; 
   d="scan'208";a="215035017"
Received: from mail-mw2nam10lp2100.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.100])
  by ob1.hgst.iphmx.com with ESMTP; 21 Nov 2022 19:14:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KMzbBbrgfah1lqYQIMEEVhkBrcTzgzU2ohYqIePej85MB9LnAhakLOFkRdph9TonlGxVwMGM0NsX9xlPhpOBlg7RUYwMCy6SPUOiz/MtLh9zSIBdelM98bh0CsRvFPEnCFd5NUiI37099WehU1v23aMTIJjwQ7B/GcM1JK5Hp6uJFwL6oDMXgt/FnpOKglLmvsXUq4PhPBmP+A55LBdkiOn1ItMbIY2rKakzDN/Cndu11qfMcGR69KcXX1DtzHcX/69fcjTnF0XjojhN+Ce/K0Gt5eajKxdL4I3bpuh1Z4BpcPdSszJ5eJpS+hZtlGC3029EDCgk3m5gqBs2H6bJ3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YKkALEQlaWCQMn6FMW5impGpqu3YAlAzs6vsKItekDU=;
 b=jrRnDk1l5bT+SkQgO9xXK5j6QT8GRikvkdhx+1VZ8BnREBnzm/Oirb3vODC4OIubOSZx6ie/75OgYZAaFNNiXWigCk4bApQIda8c9xSGqq8zYVB9pEtJyPVk+Nj/d9JuKZg9dSewHXDMvXZwBK32tLVxflBOiunvMRcJmQ9VBl9RvBcs4E5aGNZaRHfA4PFFQoiNgqe5P3bSxuEvh1E3iQ5LUnpcCFZJ8CTj12VA6/vOPNWQrRG60mLx4rrdV3M75RKoN3QM5oopsorWFtKYExRHcMzWTFp4abVJsZw6QHhHm6Yr+HpCEq5OlQp328a6kTBYRI3IT7OQKzKZ4nWJbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YKkALEQlaWCQMn6FMW5impGpqu3YAlAzs6vsKItekDU=;
 b=wVUQpZkHh/33b/XWDbxub9516Sg7xpYVOS4WMm+/xLETQXKjnUG17uxTWBCaPVavOmzXkfS0hNkP0aimp16RgaFaEMfWeDkcH1nck8CHZ76SaLtMT7crn/1mrsn2VzpYok8LtxOx016xUSY+cb9IKpXbbO73x6BX5uLihKH0/Vk=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM6PR04MB5610.namprd04.prod.outlook.com (2603:10b6:5:16a::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5834.15; Mon, 21 Nov 2022 11:14:44 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::d4b9:86e9:4fc8:d6e0]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::d4b9:86e9:4fc8:d6e0%5]) with mapi id 15.20.5834.015; Mon, 21 Nov 2022
 11:14:44 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "kch@nvidia.com" <kch@nvidia.com>
Subject: Re: [PATCH 2/2] blk-mq: simplify blk_mq_realloc_tag_set_tags
Thread-Topic: [PATCH 2/2] blk-mq: simplify blk_mq_realloc_tag_set_tags
Thread-Index: AQHY+1b7ftomuUpRfUWLZOgyWXnC3a5JB4iAgAA2sQA=
Date:   Mon, 21 Nov 2022 11:14:44 +0000
Message-ID: <20221121111442.qxyqtsac2bhzhyjd@shindev>
References: <20221109100811.2413423-1-hch@lst.de>
 <20221109100811.2413423-2-hch@lst.de>
 <20221118140640.featvt3fxktfquwh@shindev> <20221121075857.GA24878@lst.de>
In-Reply-To: <20221121075857.GA24878@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|DM6PR04MB5610:EE_
x-ms-office365-filtering-correlation-id: f473de1d-ec88-48bf-a51d-08dacbb197ee
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z2ynoPoilDtHMKkJv9EvIGpHHOPkm1Vy2Uabu9RBDIws+LZydEd+v028ZUo3/11pxIUHZnQxGV3QWsn0M0RpQfvls3FrOlaujpjB2RnnaCZCAE2epbTxZ4QWkafhe/5prH3yedF0bedywE4DOW/2OT3fyM5k4aqNoC+x8WjwpVutya0WxQT+Glenh1O2A1HUveoKPeLWozYUfNfVBM4dazJI2DWGFCl/pY4qMMRynZj7Br6ftHilZmAn56z0bWp17Nnw55AH9jX+xMaOT41Xc9qdN76RdRH4P5p7eDRnuqqZJX4vJrbbVX5uHwN2bkA8EwkUrNQ6CTw/2UWgnoGjSS6DbtvatmZn5fH3GqBOFLW2ibX6UNF2egnbaBw5FIo6MtuI7lszuM5Xv9VX6670qM5b4VwxoeBonRIhB0KY8iXu9EMJGS3KY75WCsWkMZUKfnd1hEIpqFoddqJ+0oTI3LRY3JqY+3+TAMk1GGCux8uWbAKz+kGjph2f/KdUFwyLZU5E5K/39H6OevYLc8hvHSaIuWjpncLnY5wDX3ltIiltSK58mt3u8RHNNZ+/Tp1YSGQPgauBz4+MP2pAsT1E9lP8JT3/BNo9dxafIRBUWA9pS2MK/lVFY+JjTAg6hI77b/+5lspqIgwDAh7Ut263S/cjD0rHFAx7505TCnUHSoYR6C3au0zOO3gbWi6bRQiXMUtWFsw2jPwVVpui5N1ovw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(396003)(366004)(346002)(136003)(39860400002)(376002)(451199015)(44832011)(5660300002)(1076003)(38070700005)(91956017)(86362001)(6512007)(8676002)(66446008)(6506007)(66946007)(66476007)(9686003)(66556008)(64756008)(26005)(54906003)(6916009)(76116006)(316002)(8936002)(186003)(41300700001)(4326008)(82960400001)(33716001)(38100700002)(122000001)(83380400001)(2906002)(71200400001)(478600001)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HOgD6eijf2/rHHcpP06CTwLNAQ6dO59XSYl/8KNPSfCyrc1ZcPSyfrfSOb8I?=
 =?us-ascii?Q?LxeTAQ5odVm/rZ57so9p1bZTc1djt/gF0srfsveIEgSPqXZqmepYc0riM011?=
 =?us-ascii?Q?DqdC/foC7hPHH9lTuyActHWxmyqKxya/gQDC+NL4kbjZkP1VLV4e+V3KPaDQ?=
 =?us-ascii?Q?oJGUJbjoZ6u7tzK3Y6A8+LG5a3TOszTbv0e4TRFy9ZJNR6umXRQEodKGv5+4?=
 =?us-ascii?Q?mTxL5khlkDsz+SHn9j/q423Ppl2GlztSdCO8WeUkWvSBWaYmc62diZu3/7pV?=
 =?us-ascii?Q?stkdsyEFnxepZuCKrYc7S5wu5R99ZpBTtzOVLnR6mDHm8GA6fpuuC1oKLhw1?=
 =?us-ascii?Q?3HGAIeWPmZgRL4UoDCjLVFRAONkJJxYycTT3cnYQbkWh9xR+uH907CvDYycE?=
 =?us-ascii?Q?jiAuUcifFluisvsBSZLbFSbMQD9bSmHh5Q/Oe63LI0F9XxR/1LzD3asYKjeJ?=
 =?us-ascii?Q?PqMFcdU3N2wGuXWFf49DGn+k8T9AvkEPxzJbEOUOyFaFD3qjq5tZGt2jWMLO?=
 =?us-ascii?Q?cG5KGv6qjGAYvybE6QgD4ufBFaNClhsSZEnYzmc9hfn0GEexhmvA4Pj9Z+oF?=
 =?us-ascii?Q?r+8hKGmPzAFCBdgIfWZZhdypjDw6OmoGn3Gj6zSi4ASUqt2V0GPkQU0FhHD+?=
 =?us-ascii?Q?2YXL724OcBpgHvfNTsJjalDswxruQ9RefYAHCyHKAxLmCzA/2kUEmgjYMgd5?=
 =?us-ascii?Q?byFvS6+iiQL8yUFHzDwbM7DIUXarcb6g9RCUOOhh0bRzJumClgWHi7/rCnh5?=
 =?us-ascii?Q?RAagWg06fllw9kuVcy2zGMOBPoAJ/XDrj6LXJCGQ2j2k4hn8n5CqS3uB6p/O?=
 =?us-ascii?Q?414yOP1724AKMmpaJajMYhPmhW/jd/KqsFwePAu5LEOJYgus1rHCdjLf0AtN?=
 =?us-ascii?Q?jCmAnO4Ujy0IDaVvm15OfpmMcuMGBrC+Kg0uIJ2Dk3IJjfk4fY/N8bNvZuXR?=
 =?us-ascii?Q?px4hvesEi1C8Qsv75tyksv0FRqCLM13dnmfdJ8VC1/lyQFIvAOSNqv5XGaZH?=
 =?us-ascii?Q?nNLLyQ+KdMuetgj+Qrk59cmuFpUlB+s62XQdbOGUCYyp9P5kPy8laZmGeOXX?=
 =?us-ascii?Q?iyqSZng3TNAGGbaBYNnqb/rZxgkxjgzXhy3ArVRV14sd78ddwg/reiDI6LYa?=
 =?us-ascii?Q?txkMp/lkj9nadotB3B41K4tti+EOU9JgvWQuhoFFMBlEJDs6mRDYaXwyCKSj?=
 =?us-ascii?Q?B3WSn0xLjU0GNYJ1lUOCFVd4iEfqluG9h81a2zV5vMgfgZEuN1vVafChOFN0?=
 =?us-ascii?Q?ACUoMEuVmAnARBUnZN0+/9wSxp2tEKxMktgKOTu0HFDNyHwL+4sisXwiLEVY?=
 =?us-ascii?Q?S5BOjG5koTmsETMjmvd9UD+6D7CEyxzEGh4FZMSq5yAD4OxffLIifUkLMzqV?=
 =?us-ascii?Q?ma5PcEGoiQPNo9wVJkxjdarZ+l/mt5uJIh32aav7kekF+5Gq7HFvAb8kWMM8?=
 =?us-ascii?Q?63SrJ0iRLGmMOV2x6h+fYRh6w9Nj8C6Z0dNA9cXO8Gr8lKJ+389DR2NeV1AI?=
 =?us-ascii?Q?6863ERWMx2ve+F7KNnsLY/ymBLDPaUGmIn+eZghfdiQ3/6GCbkEZ5ii5RLCD?=
 =?us-ascii?Q?q4VyLskObTTfcDrpk6J7AOSRyKq6VS2CXjWS0z6BPwxMR0Y2tqjOUQZqnwwV?=
 =?us-ascii?Q?c2PD6C3Z9jqUJ3g6Q2eASyc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BCDEFDD4643E804399939A5C1CBFA66E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: SANaeDM/vco0lq3AjZrSjer9GBQ3mJOyeB6j6Xw3wWRHHEXaXwCqpj285uq0uv4eYiHv3jzOHEGid3HS0oPZXezR/9nGarfUVSHUrb3hY0jonBPbrcCAEf6yzOJnoP78Aw7dF3R0A545g2aEPQeYK4WTxQEVaFICg1zVJ0nSvVaXBXCgh2KWc93Q66caEP/i/HnOGgNBaF1QXcuty9IElC8I8iaVioJt4tDzkC2mRqnL77gvu/nxGrKT4iv5ffZY32vErzD3CdsWgXwaWnjmmqQB0Z6RB/Vbci+kgeZ4ohlOiXuI3uF/lQ7WgT4BassFAtG6pRQ2hxNvyGmghntNlgwtvgI5E7wmbRIbCcRi1GN09Yyj1Hdhiw4RnPYVuOx9vWO2NRCUu+8+P2YNkdk+ZgtsXTzlfeRk9/xvVTil4OsuTj0QSWRpKApY7EBXHtDLhEIpKY4WMZkRnCg6+wecpO5hAg9/eqY9sHIVqn1cbe8n1yOwXycEJryYF+p82RJmQjSl9intnHaOrQ6lzknl9d3XPzQDdT9ZngXq6CBXZ7A7A3fvSzlA+vkPZ+Wsd1+XEhf5+Z1apxFP7cgwNeCo8GIL9MYkVUgItB6xClV8dd1iSKl2xVD/9LkFdNRsutEqSrWcp9P2Dlco7LzvqFBgP4w0+vgNErdVgPZkMwfqGJpYUXkBOhIjmHKeTQsZ0LGRF6U8MEjakYLCkqSSIOGHq88fc32EZpfKlTBnXyt9q3O1QaFm+hDYqNVGsJTnGgCvHaKEksFCaQrNtgquLEUS716G4eE4HESeoxA4GPm3ANKO3s3Qq3ZEPruHI17O1xm8ZRzlO1S0DmGVzOgJSfywOwv06rm9PNY5l0ZOvq8eKss=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f473de1d-ec88-48bf-a51d-08dacbb197ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2022 11:14:44.4370
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3T7sHu5A1Xg1iGDj+SrzM91Q2eOIBSZFU/BPmHhHU+uEa9v60IgyVGbfCiQRvRLorkC6/UiXXmjS8mEBaxaKa2aKwssiIqt1WhHCBnXvET0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5610
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Nov 21, 2022 / 08:58, Christoph Hellwig wrote:
> The fix looks good, but could be simplified a bit more:
>=20
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index ee16b4c34c6a5..cdd8efcec1916 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -4381,7 +4381,7 @@ static int blk_mq_realloc_tag_set_tags(struct blk_m=
q_tag_set *set,
>  	struct blk_mq_tags **new_tags;
> =20
>  	if (set->nr_hw_queues >=3D new_nr_hw_queues)
> -		return 0;
> +		goto done;
> =20
>  	new_tags =3D kcalloc_node(new_nr_hw_queues, sizeof(struct blk_mq_tags *=
),
>  				GFP_KERNEL, set->numa_node);
> @@ -4393,8 +4393,8 @@ static int blk_mq_realloc_tag_set_tags(struct blk_m=
q_tag_set *set,
>  		       sizeof(*set->tags));
>  	kfree(set->tags);
>  	set->tags =3D new_tags;
> +done:
>  	set->nr_hw_queues =3D new_nr_hw_queues;
> -
>  	return 0;
>  }

Thanks, this fix is the better. And I reconfirmed it avoids the block/029 a=
nd
block/030 failures.

I guess it is too late for Jens to fold-in this fix in the for-next branch.
Christoph, would you prepare a formal fix patch? Or if it helps, I can send=
 out
the patch with your authorship and SoB tag (with Co-developed-by tag of min=
e).

--=20
Shin'ichiro Kawasaki=
