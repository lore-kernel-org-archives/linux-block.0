Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C358CC4332F
	for <linux-block@archiver.kernel.org>; Tue, 22 Nov 2022 06:55:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbiKVGzA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Nov 2022 01:55:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiKVGy7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Nov 2022 01:54:59 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA9A21269
        for <linux-block@vger.kernel.org>; Mon, 21 Nov 2022 22:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1669100098; x=1700636098;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Cb1bz9+tmiErJn3eqvE1ddPlsBYw2c6h5yIKK9zNpCg=;
  b=mk2CyYOuThHifhwIwh7TWXtVW8M7mByFClKV2xZkzdqh6BPzApwvKKP9
   iU3wI4hCeRbjycgt3IpnBqfH6pqyKiF+syk1u1A+RWb0NX5ecJBXYre0V
   1N2C5iWrgmjxnCzgUgBG9FBDbeDTt1t6Ls5DrtcWxCRZczquPopZOuj0v
   xh+tWcb67XixcbvSNUFlV12powwd+22SlOtFUUAjYws+zHv6ENPg2W1jI
   +9I2wBuW9gWvg0dszNRef9oHIuArF6vCUjnR/ZHQR4FzC7FjbDgRYVPq1
   vGADcdXwnq8FtPAKLmtNlVTo7oBja8UdA2Rgs2t07qBE5aK5ZpmygXU2p
   w==;
X-IronPort-AV: E=Sophos;i="5.96,183,1665417600"; 
   d="scan'208";a="328968772"
Received: from mail-mw2nam12lp2042.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.42])
  by ob1.hgst.iphmx.com with ESMTP; 22 Nov 2022 14:54:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YQ5KGXJzMI/6SgWAJ5DyOujn+EiY7jAAQ8Z1KXIAZC87Rthr3sm4w6M/UmdVbMFaVpTpkrU4uHPSAF7pNXSlN3cHJfQ8pHAl0b2tsyI0F5AKjbJh4s+9RWwe8B0kmXnxyBTk+1ZJ6AMTLnvZditbhDqgOTS3bghfaMx6Xp8dMy0tX5XJF8w4WwuyngJpyH0xfHwVaDXdeN7EjzzA/PqPsKbiYPTKiCVg2fQNjHYnZkgtZOavp4YTQ3lF3J53iPhtek5u+LNFcivG3ioczbQF2axeDnOWLWLAo6OCT+dm/IXXySkvV2FPyozCHF0kwnBPbS5X+usAFX5rquO7C0fSgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TmMfHGDQr3/07OSQpMo13aVzMP1i0xZldXiVoETYkcw=;
 b=J92g3QrsmW5Q3ph1Bxw4Fl3jC1nMh9b+ISjivEpGmwK4RN8gAOmYT3zzX60+lUAHSZ51yUbWpPSsaVNeflayeYQQwEYWWE9k3Wex8HavM3bgVqc8HQPTDO8RKhq1SJwfgaj44PGeHvuj1OGYwMfzyCYFwifanxnhQkqbr4iEPadBVWeySjS7vS8xv7KBD8a1vuGb1GpwxFCXEHYm576BLOctg1GIHVA96rSNSCetHA8L9lK9BfpxcEvlr8XG6CaD8gcuThp3xwLlACjat13lguxebrEV5D6suEyD1gQg2ehxAYqthAVNJcz8TszMU7FNjqE68st4BvuCaaNNOTu3zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TmMfHGDQr3/07OSQpMo13aVzMP1i0xZldXiVoETYkcw=;
 b=vfx9pGnOIEUSeap/ZwtSQI3d4hEGTruKK3Rr6OfDoTDIkOpmB8TzvXUn8ZTfEPPnY+XB4vy6OVtgMUpdWKwmzatV+SMv1+CQZ3ZA0ePASK/Aul7yLS3Ktkb7DF0lMqb9L6yEqiopkRoTgq+Onrz4yMCD+vbToGHHnpVYFs1egks=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SJ0PR04MB7741.namprd04.prod.outlook.com (2603:10b6:a03:31b::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5834.15; Tue, 22 Nov 2022 06:54:56 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::d4b9:86e9:4fc8:d6e0]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::d4b9:86e9:4fc8:d6e0%5]) with mapi id 15.20.5834.015; Tue, 22 Nov 2022
 06:54:56 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "kch@nvidia.com" <kch@nvidia.com>
Subject: Re: [PATCH 2/2] blk-mq: simplify blk_mq_realloc_tag_set_tags
Thread-Topic: [PATCH 2/2] blk-mq: simplify blk_mq_realloc_tag_set_tags
Thread-Index: AQHY+1b7ftomuUpRfUWLZOgyWXnC3a5JB4iAgAA2sQCAACK/gIABJwAA
Date:   Tue, 22 Nov 2022 06:54:55 +0000
Message-ID: <20221122065454.6zapko7r54ng4xvi@shindev>
References: <20221109100811.2413423-1-hch@lst.de>
 <20221109100811.2413423-2-hch@lst.de>
 <20221118140640.featvt3fxktfquwh@shindev> <20221121075857.GA24878@lst.de>
 <20221121111442.qxyqtsac2bhzhyjd@shindev> <20221121131903.GA15981@lst.de>
In-Reply-To: <20221121131903.GA15981@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SJ0PR04MB7741:EE_
x-ms-office365-filtering-correlation-id: 25a84691-eaad-49a8-c3da-08dacc5676e1
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y0YQZGC/MFZJ5YEBECizG3QKML45YvJLawO8Zv5o4pUozs9FGos3P7CyTgnVXxiPDj4G86wY9999amKZy1NvnojXse5tPgzAklxW5nug7nAUZbbgFHdfZVbEO58FrPHfnYmTRZhAbPFuFBqk8UykRjNmzjcwEvwqboOnkTVbe5iBZ/vzuNpOFx3bpzggJCsSX3ujE+QF6yEo67sTH75u03X4qk1rBBBJQSt5P3lI35yLZMb724ehi7Ex/s0PINaz76bCm2ZZ7W5+H16xLg0eui2D0tkg4IuZmCapaWmZy1QU49UE85Doz0k1hYg61f9X8tldl6KT0bNMSZfRPBD8u/q5Pk1UuagdRtQGa8eixRVRKdTSndLy1O9BpYhPFrAIsq6j5VdjcSxczD0l0yEFqY9DnIo8gqmAU+nnqB9iQY9b8H96d4aTZMQn9j2V7dElDbDZdESBf3HJgB0DfZMSurGibPnColVKMthBkLA7dohunriufZLjntWO0c6XjVq7cP32LCS3TTQvwclLCks4GaquysZjeaFgibs/P8T5m/u31WXL/4ypaADFTS2yW0owYN8vkCJmNBQlVob0rf2epCQKKqVuCPcfEBZ6kGmg3AFDEVYTGtb2LJH73bVG+JoC/zGN3mYwD1btRhQr7d8yoMVzDGVK093BvkPyGnyQnoHfEwVQa8F+cm02hn5dzwfqRXzyGVeNaX4tJqLlufbcHw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(136003)(376002)(396003)(39860400002)(366004)(346002)(451199015)(122000001)(86362001)(38070700005)(2906002)(4326008)(8936002)(83380400001)(4744005)(82960400001)(38100700002)(316002)(54906003)(91956017)(66476007)(1076003)(76116006)(6916009)(6486002)(478600001)(186003)(8676002)(41300700001)(26005)(66446008)(66946007)(44832011)(5660300002)(33716001)(66556008)(64756008)(6506007)(71200400001)(6512007)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TPL9NEPoeAI1Suo30FZ4SZWmMuZud1/qpL8m1cFqhq2VNYyx0lcx+nYMHUyo?=
 =?us-ascii?Q?ZaMzdIf9envWqLko+KfBxh2XYiSeWOpcjKqxZmSPWC2HSQjl8z7C19Dl1QW/?=
 =?us-ascii?Q?IdhKoKdwyVp50GKe8Wg+24m00U2bavoZsllboGady2jqOuXWq0YyApZJ+5Hr?=
 =?us-ascii?Q?OGKiKr0ur+rJO63d4+taRuRN+3dvc32jfa7vx3ZAMmN5OM7KdjpmJZrYV6WE?=
 =?us-ascii?Q?aoZ8a2o1UgRHZGckroBmWfmHhk9Lo3dlpAr7tv6dqgGYrtYRcCFosaUiLddo?=
 =?us-ascii?Q?FiZODQZOE51njerYvXp8r8CsBD9e/75YsirKT9eZOAxgmigJ0LevikBRGGLY?=
 =?us-ascii?Q?BUsXgJ8GAu+WktaBMtApitJX8FDtgcLqMoTgnfRGYoWNaC9hsRNA9nDMyj+/?=
 =?us-ascii?Q?Dv5ELHILf5vnpL32rw+OeERS6FYUOFu/JZFd8b5jax+dDRFe7DIpCrwHJflw?=
 =?us-ascii?Q?EUhF+HyMC9GGNSu/1ghIe9FsJE9QYOoYzRZ4PDUgKwrTH/141DSZ29Va4+pd?=
 =?us-ascii?Q?TnYQWc952b7H1xR1yrN2Mz9huDnEWvpxCCgf1cmQAUSdjFwBy8XtJwGUZwYq?=
 =?us-ascii?Q?81VOIi1aWQKulw1BDrBjcCw4bXMUGelPJclS1rUn1Vet1X0wNPUmYks2chuA?=
 =?us-ascii?Q?OUzQHLE2TMV89AhDsyGWTjUpm1cVjsit6FdSYNMOOWYGntVBHknU5/kKwqdT?=
 =?us-ascii?Q?8h8oh45w+FEBZwDoHQCrQodK/QixHVIsx4s32xobIqwx8pcgk3G6z3LPZv1T?=
 =?us-ascii?Q?t5v7bNcHqYrLSwmHS8GU6+BOKb74vjeAkaDNxXSGCN4+Z6A6vRGtiggZLauz?=
 =?us-ascii?Q?beqPfE3CcMMuZqPsdjcj0FgjJQIAkta6i5DDZzZV3IWffUfPxMU1UbzAleKS?=
 =?us-ascii?Q?9QDtoSis3xllPNOsPwDWUKF6FliuJ2bnzlQXakb2U8NDtSPdWj3SU5p3W32f?=
 =?us-ascii?Q?RgEKEe0G1wTODCAHFPQ3Jvh0JdM3RkE7umhrtWSsx+RUbWTiltE7mHWhDhd3?=
 =?us-ascii?Q?po+nSUMk2k9zDzZ1pKK78lBfjOY827i37eloERdNY6j7XKD+mHm3AHkf9t/M?=
 =?us-ascii?Q?osbwl12Yaz26JYdaYZGTAApsYqW7gDEkZRE/NrAjkFLYwMd4QsDFrNgeKR6r?=
 =?us-ascii?Q?mN46/XeGc0QfpSkjkO5Mm6ZEPYBPTQAiLwBA4WMsa9C/vzAj+cdHo5dmebkg?=
 =?us-ascii?Q?831rYJJDPyYasuBJ9CUJMqSfWuIkJEWyZxjJiQzSwRLwqDu3lbDDc1degHgL?=
 =?us-ascii?Q?YM+jyqmGK8Ya53l0VMHQkXVXkSmEzkqiqX1CG0OuZk/peIvFPdGFKMCA/vth?=
 =?us-ascii?Q?0kbYuHTvIc5Fr4Cin4B8krzjnckfgQ45si1PQk3H0JqJTUDLZbU1Yv13yAzN?=
 =?us-ascii?Q?3LWCui+s07gbSWnzv0WzQ63BVPECRqwHTFdYwG8elycKdZ2bXpumwLBqE7tO?=
 =?us-ascii?Q?fLyWxsMcWIAZATMCsKgNMEmfr4va5EpSIu34SkzXC9clv8k9sSLYXgKHfpVt?=
 =?us-ascii?Q?npg80Fw5anxUKK6cS/tMP1QJlw6BEW5+AecoJ3ThQBQ3HZVfj9d9B1ECQBsP?=
 =?us-ascii?Q?+1DDRaLBSC2ysqVh722ObR2JSFoZNeRD+jZ4dXi7wGkTGsCUGVPdLOWZdtWX?=
 =?us-ascii?Q?fB9BIPTOkkWD7beqGPdUYPg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <49F122C73092684393F563F2B133BD25@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ArUlpE+T08/6nilkeLCwQbZjXeIWBLo7YlEI6olxHq1Z9bP3CrTTOKAqNnOCm7FVI5QHanddEFOh3SrrAZclYCI3IH90hUPS5AbQj4T+Eq7YUsLddvdZnuglgwj1KpNwJzSNrfBiLPbcchNb0LjeHkWWByArff0lndj//wY24AvmeDJcDYlpdxttsGuGGOSBV9CyqSy3o7l0KhaxeMYHxqqmSJU/+mHR2nq4zHLeLdRpvAGLhYosMeowmC7K/deXv4Z+czYtQN0u5iOWqkO8B5LT0mycrthDjgPj9yFMIsFu6l8n3Uv00/nEoMS5YAtlU9Uv53oRp9DFOf4+a+Es70fYKue0I1qdxOBGnPvRwgn6HAJl+cmLjQP9Av3Jod1RburfZ1cmIC/VUzDzvSqH3rXXx8sUVxrRJ/6i+H2Y7RCUzBvxjDoQT380n5XfjueVR/CvjpiEc34zPVkE/7tqmc+t0vJ72oJVnTt82B2HLghzz+N0TFLsUq77c+/kAvA4GZsagePPYtKkJbj9Tl9SvalKErbtp+KISfxDGgq7eV2RyNNPeFatmGsgsrld4AsLl3dX6/JqCpPiQ9uYsderpWXsCqZTRgvfF+ZeBcb5mb/vR3Vx6fkI3lgnoKVFw7aqRN0zcfzsWzQtNQiGZdJTZ3tNr2jk948EviFe2wAZrX3EunPmKIksbc9PWvYT79aGAy0yLSIF+OKYGZ4iTo7js0Oyh6K1Iz5JVBjIXU2Z6h4PMwE02KtyIZ473zoNGgl4ffW+ZuhFigfQHmWsnwEn9bMOyo/cvdwDoVM3a6u+kDfcEUXgxxzJvCbqugQultxDr/y42eq12WPSBncG/CFYZtUAtqbrgDO9S3mksRoDqfg=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25a84691-eaad-49a8-c3da-08dacc5676e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2022 06:54:55.9795
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gfs+WmXz52hk3EJDJ9bzF0kk/hME9bRxHQMzQVuMN64f3spRUi5XjfYhqCeqJKrV0gN52PFi94wGoHSw1WbUVpYA+tSnGCPVbPVz7E9PIsQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7741
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Nov 21, 2022 / 14:19, Christoph Hellwig wrote:
> On Mon, Nov 21, 2022 at 11:14:44AM +0000, Shinichiro Kawasaki wrote:
> > Thanks, this fix is the better. And I reconfirmed it avoids the block/0=
29 and
> > block/030 failures.
> >=20
> > I guess it is too late for Jens to fold-in this fix in the for-next bra=
nch.
> > Christoph, would you prepare a formal fix patch? Or if it helps, I can =
send out
> > the patch with your authorship and SoB tag (with Co-developed-by tag of=
 mine).
>=20
> I can send the patch.  But I'd also be perfectly happy with you
> sending it as the auther, as my version is just a tiny incremental
> cleanup.

Thanks. I'll post the fix patch.

--=20
Shin'ichiro Kawasaki=
