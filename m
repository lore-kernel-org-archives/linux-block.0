Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B121EB64D9
	for <linux-block@archiver.kernel.org>; Thu, 15 Jun 2023 09:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240641AbjFOJZk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Jun 2023 05:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343596AbjFOJZX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Jun 2023 05:25:23 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326B0199D
        for <linux-block@vger.kernel.org>; Thu, 15 Jun 2023 02:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1686821122; x=1718357122;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=wRWJybOqAF/t0Yt8bI9JQ+GnOob+u+8MUTHbAEGzCrk=;
  b=PFssDuDTXkmOKLOU0sBEVr8pdKFSeOepklP8bnjulvzO55Pu5B9YF4wI
   pXhQYDPIDv8IqlrwzIkqdrOynQgGgNOf+luqG8zRLoEdsTzNwCPak4pAz
   YAGO2UYNC+6i2mWgE95+62WuEqlkaEF/Zhixj5/m///26L1LWRaKNM1G9
   DyOhHRqfA5jg9YdLJZ0lX2xyxDB3/fvQ6GCV2JGSbXBfEjlSHTzjUcxYQ
   gCYhBbMGip+vLgDWidBUn+CRwUsA5vlkS+jTz14jHhXiJW/MCz42sfRDx
   Epp48UWsqSjjCKcGGPn8Pt0BbmmUi16KIT+sk5ccdXMgwbs2FZ/O4xEYS
   Q==;
Received: from mail-dm6nam10lp2102.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.102])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jun 2023 17:25:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZzqYtsgjfijMk9Aln0EeY1YMdc3q4xErVt1+O/gzdaV/L6PLrm/JAHl1hubErUs4GzNjgAMADwakCYSREpSXkuC4qE1poL6Oh6gO9uZUjLrdFx/uBJ8sVvEoaxTEc5k0xSIfln8U/vWrYOQK5s/Gi+ndDXscbto62AOL5MP3z0E0SiLSAq/8k8AuNQpCGRYsdj1jMcbrHudESHNYnmL21N9bCXA5/SY3SGRX3Vn8h8TGkYunFwyOMpuszczJJG2g3U7eDckanSFd9/u4EwQtEzU0ic0txdwt/hZ2KlgNW/ECe2R/mohDO58uddcnDemTGeywIqbICoc+97irAbdWWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5bL6rnaW+7UGCbW0IYltXu2JolJ+cVVzmrnc/sXfyco=;
 b=KgBWP9z2Ttg8bgA9ji/L8mNw4WpKv3Cp+VGNdo9kky/ehBByiEupu3F0jAFgwDulAgJ3eA+b6/UqMRFFzBKe4Sw3fYveH+il+SHy9brkHWo7xp+9m3qCbH1g529Y/FFpvGz3S48Xlo4wWW1L0XvATQzvPYdAk3vnu8WnI2U+pTeYQdoU74t2MYADULWHvWxd8kp/VMClFdfigGEAjgugtH22X35XEgx47HBIS/0HQg5J2KMu/UUv4FwJndrOmMARLM86+ttzYHqzXJixfeOLOAjmTr0Ji4lcG2GWdGDjg78KzDtzEMt90Ip7afwLZRHhZWOgZ6JM3T/SjBksjY3NWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5bL6rnaW+7UGCbW0IYltXu2JolJ+cVVzmrnc/sXfyco=;
 b=h5blnOVpqzjbKkJUl9wRgz82SfLlr0B2hMczici/OO8nBy6aoMXSJE8aJtjxoghEzUExmaa40E9A/86iNbD5aGvVZfHedcIkt73d8wqSdhuVVfDjm6xh9U5rRGkx77hW5FSvh+NXkA7++ijqWr20yNCXJScl8l04HP8zKDVPeCw=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 PH0PR04MB7446.namprd04.prod.outlook.com (2603:10b6:510:18::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.27; Thu, 15 Jun 2023 09:25:18 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::bfa:d453:e7e9:8f98]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::bfa:d453:e7e9:8f98%7]) with mapi id 15.20.6500.026; Thu, 15 Jun 2023
 09:25:18 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Nitesh Shetty <nj.shetty@samsung.com>
CC:     "gost.dev@samsung.com" <gost.dev@samsung.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH v2 blktests] block/034: Test memory is released by
 null-blk driver with memory_backed=1
Thread-Topic: [PATCH v2 blktests] block/034: Test memory is released by
 null-blk driver with memory_backed=1
Thread-Index: AQHZnvbYlh+sKOY7h0eIud8dm0Enwa+LmKqA
Date:   Thu, 15 Jun 2023 09:25:18 +0000
Message-ID: <5drf4qbrvhabwd6dk327pcmftlhp2ssf4wkq6fckz6cyfnd3ia@ev6orakvuu4g>
References: <CGME20230614170954epcas5p33d4ddecf3bf2ff178068b073ff2e2a06@epcas5p3.samsung.com>
 <20230614170642.2115-1-nj.shetty@samsung.com>
In-Reply-To: <20230614170642.2115-1-nj.shetty@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|PH0PR04MB7446:EE_
x-ms-office365-filtering-correlation-id: 0e754c91-305e-4ebc-2805-08db6d826f8b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zSviUynrBa+vSGi0eSPxPjtFs/bNSe7cY+aTYm0DgyvTrgk+DchCFDWVlnJDNdyOAv/L/aLbixMo7OA5TPFNUXFbithWFXV6K4TneV8S1u02bjs6I/1c3ycPs7mp8fgfdsBY3eXQ2W1qweSUWREjX5r5gagjOLXlR0zoN/1OmQc6Vc2NhGhZd9lKYHecHqRM08MvTJK62zRWwGNndlNi9chi6NbFDlWikL+si5e1ct+vJnSHMzRmJHHa9za5262RQUZ68wmw/wPBi9XsgOtH2zAxWSBidBbF5lee4o2dEveDdGkMULPUMPPXn91u9B84EeGE82Tu8REVuREolHGN37HPgwBOiTZ5KoyfIscy6zdeEKT/rwTK31EUO3kkIqZ059swxmtaHS44oqdqmYcNDphkCmDVXnZWoRrGaEm7S5/sUdrwm7c0Eqos4NOyXMn79Bz7X+IcxLJTgWFV3EI+yljpA2lFMElG+OoIEp04cW0qxbLNcnLxj5tkTatFv1DbIUiG8KdfouD1ppp9fuJTj4ss09U/DrTwxIOLq26APhv7jYPWfeGro++0pvlV4EHPcaZYcU5SFlJ/OoPZzn2aal+02OsnBS76pstiGGLyQ06zs/41LYy5mKb+tqpUMhFB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(366004)(396003)(376002)(39860400002)(136003)(346002)(451199021)(54906003)(8676002)(41300700001)(86362001)(71200400001)(8936002)(33716001)(6486002)(66446008)(64756008)(66556008)(6916009)(66946007)(66476007)(316002)(76116006)(91956017)(4326008)(38070700005)(478600001)(26005)(6512007)(44832011)(9686003)(5660300002)(6506007)(186003)(2906002)(4744005)(38100700002)(82960400001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jg2PObhcv0Ce/yalgTSknvlay8joU9yoaDYtjxlNxpnpJmgD4quwRqGXa8ka?=
 =?us-ascii?Q?QaJro85N4uviKesMncPbCW8FPSF3wKyD5XmYosexmV2uFu1MPKx9vVF/StIS?=
 =?us-ascii?Q?IhN9S/Jo9M+IjmWxXbeHrwvrlxWkVLftVIO/DiJMnVEc3B/uIr2qEXv5xvLJ?=
 =?us-ascii?Q?K2KfovQnGpK3ve5iMoubjGUt0Xz11eksYfM/ekqs/ov+eidpbScnd7XusnFI?=
 =?us-ascii?Q?zmO0W5KbVhz36UiaKXTVxTNjPl4d0/7495pR0lWAPqDp52gIxDLWS/F6NhXR?=
 =?us-ascii?Q?6Q5DuXD6EeoLinFtF52wl38zLiTSDNp9x1/tej0GH+9OwG8ucivJm7xeommU?=
 =?us-ascii?Q?ngTsZ8m8x+aWM1Ax01UKucqYvTTEVL+JYs5lyLGJl/KS6/K9E9KeUc/QTsBQ?=
 =?us-ascii?Q?t3FLi1/fVfyObNdC43QJlSeSUocctTfOrjFrbZe1CafLujRE3oKtG55LNjFR?=
 =?us-ascii?Q?0nZTCqoFn0nD3gJEtNnEehIntJl8wOtX0O5QgsrPxdm6c7hgCIfDTfNLsgkX?=
 =?us-ascii?Q?0BnCHOsLsf+GHcKeD4B+ATPu26Drvsn0Lc2A7AuX3NqPK6w+VOeTR/czKypm?=
 =?us-ascii?Q?GPyUzORUuQoKxGA5LGLkkBlEi7gcSZBF2g/YRp54xMSwzqpC2NwPxNjcJE58?=
 =?us-ascii?Q?dsG9vdt29kaE+NKkN6scPM2ZiirTjV05BuCqKRI3msclh79wjVw9ylyp2ooU?=
 =?us-ascii?Q?hOGJb05pMzSpaOrPo2geP6s6yjTuiZM6/bk3WJoVJrIU3PQH9R3z7IbjJNC8?=
 =?us-ascii?Q?HEAiO7arpiMctcLCjY2dtsF6WiMF3+V7L+c99dtn1D1EMe07/yeqF4kd46J+?=
 =?us-ascii?Q?lJP0Tkhs1nwGaVjo+Bhz5cgSScLJYid2KWKV/Q4mpp/aarpARqAYWqyLToDq?=
 =?us-ascii?Q?h202ctY7k7ydClFCOpm6R1UPNO5ma7LLVlPd4BoxH43vg8zGOI77x4kFOk08?=
 =?us-ascii?Q?X1lI3w+xEGZC9GDTaq2gZlcLxVAmg5tCiqQKhd9CbYPN/6gGCdT7y66lfEsu?=
 =?us-ascii?Q?AphZkjrawVs5XIdbOnjSX/DB7W4gr+NyFM63SqbI6o8V/ignGFkykizm7kp8?=
 =?us-ascii?Q?H0lmVrBMgoe2VziioER1C1eSPrjynZxsxgI361VfFfi9zfuKJeYkDpmOoTiK?=
 =?us-ascii?Q?PRbbI88upzPwL8ad+DMoBVptj8eEZFGPKVEMgZTfyMKHQLxR/EIrRgvpCTJS?=
 =?us-ascii?Q?lovtdVcah/H8FkQmTtU15s/GRiQzK2wbf8rA+b0yjBHSExfPj0duHDkDNWkm?=
 =?us-ascii?Q?twQEn3YtYjhT9AvnhwOjqwzYlHhdln0Ydm2pVFvAZEdXG0j2Ef+w6mIShbce?=
 =?us-ascii?Q?Eag/+15DCwyb9K4R9d1ynpxfocL1RksMMr5JXeRe+MPmtvKIQ9rNnQcq2Kg2?=
 =?us-ascii?Q?PtQaeE0Ut9lkwzqMTlhtLd6XoQCnEVK6Jz/CKLQImpa1OjqHOLJDdUPlPPHb?=
 =?us-ascii?Q?STpOr31fqGm4In1NxEx5ukbGGkvtfTctOvQ2Y7iBTK70uty/K7hl902igq4w?=
 =?us-ascii?Q?H5jEDo5xb1KKl0LW4KdZBtjrDbdFc1dI75mXuHecfbSmBmKGFs9nvKzcJ8Us?=
 =?us-ascii?Q?X8ScAdmp7iiccZACKQ706IGmvwb4Uh2h3/6BK1YDj41f1L6BLb1RSY39B5D8?=
 =?us-ascii?Q?WOeDJ6HofGpz3mlo/VDRl88=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DA719BB75BDF1941BD4226E75861E5BA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0QW/mKBbLIfCWcz2WI9lWHD1b9VrbrDCSTMRIbCL1rq8CQrizb9Ujzytj3iyDDT4ykqhuboCcsKboSjoEqyps+2UXQl5/mY5DF34T5HTY8ZsjsJLmoT3shn2k2JpCK0Z1IgvjREQ+MHlCyj+lZCWO65ubeLJc6fK+KojLowUVT05BUPkzzL/+q57fnUznNcJIx1/RNRazanB7pFfaKV6T+YRs3dv8YL69qdmvXZu0zdzSZM9LuLwrjTF73FSNU4J+2hbpALct01TI5qcg6Ijsf5tZcPgfEVfWfLIeDAvk+3B2nLVYKJSvPLFJD4+Y5S0+MsF9+ZAW9Pr3hpunkgd2krkg4aY/as0LgaguUxYfyOkVOB/1MvxqmpfTDLpuKd1roIkjjK0JaFr4s+cKfjXhW5CkTXHWbGTo1cub2baTsmqN9wEZJ/jq1B9CzvUmULj9ujnTesujpocV3IIfBJ+xv+7pbmR/Ce0vSNm4Vwoaj8Jq0Ug3xcNt6kK4if6mdjF3dXCjghCkfiTDoaBn9I8jO1nsVReBva0EIppgv+vH/hHWBOeT6rYpS2zSchl5VH2aqJQ1qaefwJ0ArJ7b5WtCf0aqqCm/WqPXsAcN+7CHQu+oDkZbhVzD+JDnD3S7qJki/ZF4MRg37Jb5VdIZzBAkRjsl3fc3m4Q9DefXShOd3P+qY+zMSAqobDy7w9ke0+GwTZImgoLOwj1cduNUr5zWxh9FZN/S/phZVRSFxhfg6UDUhBvDdTkfunimFWYtcwx7T2txM/92G1fZSdJFVnNPk5jJlbQ2nrjvN8rw7oi77bmZnt0uL18oYeZvzaR8yhi
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e754c91-305e-4ebc-2805-08db6d826f8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2023 09:25:18.7209
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2RIeZnQeGj+xEUGfKq37YYlB6Qg0l3feeFUl6+jPPJGL5THPRVKOzZL8H/tf9rVC03khX+g/sexl95ENxH6UZdDhPt6jpC4XVGMvVU49/28=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7446
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Jun 14, 2023 / 22:36, Nitesh Shetty wrote:
> This tests memory leak, by loading/unloading nullblk driver.
> Steps:
> 	1. Load nullblk driver with memory_backed=3D1
> 	2. "dd" of 50M
> 	3. Unload null-blk driver
> We do it for 5 iterations to avoid any noise.
>=20
> Commit 8cfb98196cceec35416041c6b91212d2b99392e4 fixes issue in kernel

Applied, thanks!=
