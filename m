Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D1C1E8FDC7
	for <linux-block@archiver.kernel.org>; Wed,  4 Oct 2023 04:14:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbjJDEOk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Oct 2023 00:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbjJDEOj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Oct 2023 00:14:39 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC3CAC
        for <linux-block@vger.kernel.org>; Tue,  3 Oct 2023 21:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1696392876; x=1727928876;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FzqXqHh16Y9Gek6m77MeaPWCAU40Z29EGA4z3Owwb5A=;
  b=Mf/o1GA1QqP5UQygLaDKEDizHDD3/3iZISFAMWZb1sukj0FOoDv/2bnw
   bGCPVlt1+z37vRTrScjkLNSOaAumbM7RgmpZVfFyyh3VlwHmBSHF1q2YP
   oUQV/7cuom/I20Pkb2tnSpAg0pya7et03P6MhUlXMfPzx4qpIQhYTb2Fw
   EQ/tnM8/6nlExuK7GzMCsbM7s3dPZXxixgf8MYMY45bsPmvhrLmQB6XC8
   vdDXqjs2l1M4GZDijMkGupYGCJyhVEI8b1vMv/aVzOe1qMZ43rfSL0yTr
   zKmIIxtJ85r44qmzdY/yjlcs/5fqBsqRUAAjBfvSdsd8+VRo9AyCbu00f
   w==;
X-CSE-ConnectionGUID: tuVDT9mFSIWIoVm8q7JOXw==
X-CSE-MsgGUID: 4s//PkgxSZ++FWs8fZ6e3g==
X-IronPort-AV: E=Sophos;i="6.03,199,1694707200"; 
   d="scan'208";a="250113642"
Received: from mail-dm6nam11lp2172.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.172])
  by ob1.hgst.iphmx.com with ESMTP; 04 Oct 2023 12:14:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HV2QwkfkTuXkklJ9FFUz7ch5Wl+6hy0LkuOyPMYss0taUedhs24+nXCivG2kPQSRpDfGd3SO0vCxE9Z74Ygex++ixQR3DNcQHCBxCoUCIzPSzOm6it8zq6Kv0xPVfM+m832oZIbuSAK5m6ZphD388NKo7reBkcgLUpxhh1v8c195n2YrMIy6LY0rDLPiZmd/B1JtORTzT9TNXjNP6cwBDsFHSULEc9u48gacIFjaSUhtlKYGp/6CpXo9AjZeFmxCWKzXQVd3wT6kzhPbwm2ovgPgww2Yr/sYvbcGGr8ClbXglljc0j0e0PyyRxsAyn8mkSNPIa5LDnHzXgHMdiyOgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S+aiAPVw1S3hc9E8CcXUho4vo8AoKzpcGLvM0X3u1r0=;
 b=gtA1YhLzvXpUjPnx3MzMCM0VvfwnGgpX6oh9c2eJRq16DAu9PFz8XdOQWsyCNPyBLWN2KBjWp9vdmFycwf+p+fNEhB6VVbiWva5HIwi4O5cESTGYmCprSbC/JtuGHfQoWOz5zcqGibq0BAZ0FYyG4zUeGivs5K8ILAwMaMcL114TWWI4lnFOQfWvt4MZ2+EPVCQeLysvcd/tJbj1fp+jnl0Vu6IgJMzBkqDA+5PKcXuyQfzqlPXN16Sq9lsdaT3OksRX33/wTehjb4WDkTLwdNPQZli3bm6/SG/MTQ0U1CDd8OWAbzLkGaftWIQRdAhsR3aOWCO9cCdLyii7pDcLaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S+aiAPVw1S3hc9E8CcXUho4vo8AoKzpcGLvM0X3u1r0=;
 b=tXlF0Udi9iiJkPSdkQiKmnr+ozkhRdgXZ9LPStvvZwOGl6BAFvjHBugz6huS5Hpuxjss75bvdBZfxTVMCRJLTapFgZTW/o+mW4S5ifzfmEmtKZ0Wf4Uf4bj2DcGDUOEcXjGwcTTe047uQFt8xuNpGGhqh3fzw5CaGynRQ2HADVM=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CO6PR04MB7553.namprd04.prod.outlook.com (2603:10b6:303:a8::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.26; Wed, 4 Oct 2023 04:14:32 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::2256:4ad2:cd2b:dc9e]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::2256:4ad2:cd2b:dc9e%3]) with mapi id 15.20.6838.016; Wed, 4 Oct 2023
 04:14:32 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>, "w@uter.be" <w@uter.be>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "nbd@other.debian.org" <nbd@other.debian.org>,
        Samuel Holland <samuel.holland@sifive.com>
Subject: Re: [PATCH] nbd: don't call blk_mark_disk_dead nbd_clear_sock_ioctl
Thread-Topic: [PATCH] nbd: don't call blk_mark_disk_dead nbd_clear_sock_ioctl
Thread-Index: AQHZ9g7AD4GEgDylmkOu8OcgCM5ol7A5BlmA
Date:   Wed, 4 Oct 2023 04:14:32 +0000
Message-ID: <myjcjf3o6tqdpsfvyt6qfahmhkbjovxbnmzst3y5m5pquyaeux@benu45qv3xpr>
References: <20231003153106.1331363-1-hch@lst.de>
In-Reply-To: <20231003153106.1331363-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CO6PR04MB7553:EE_
x-ms-office365-filtering-correlation-id: d2237760-6855-4588-e727-08dbc4906949
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jUGTSIO4zijtyCSI1Joj3wqagI1TxVktdXS6xtdkcaOytAesmtHm+wgJ71tQ2D5mfY81dHpelmoaVZDr4azoRg62S9JaCRksgRniRmSHhdeZiJNlS6wAWU6K2Dc5Vc0OeR/WqgF/Uvgn/49apnRD4soQF4c+jANI5ntOTB5VnPpWH4rH6Evap+ftD1A8EuTfOVr+zcvMXgMhlxn2dWz/bPGQGQsLO0OoVpNd+on5BL8ak24nel2kR6plC9gfJyF26sW9sF6J1N3odF0fBQ78sQNFM6hFaw4vdsff2ZziUIB2jDd8rQRa1MZbCu4zlv5f2rQGi7JjR4V8aQR2nY7ag88+NZggmTsA7JLckPIaxMxB/lPZQ9WkyzXefr1x51Za9DNWJMDsC8mBIsrpOFI3QlpobRoUVZWFN1ALLrYtpP2WxLiPO+OBBG1YU+2pnPOhG8Dy3Ez4nz2Gx6QAhtI0iNlQqzXD9VUJGxog7czcs/yhZ5vwchAYEm7ICAlx1vjqDa/jGIJXuUmXgOfVneGWWefGU1deOLzKCVXtwyFqVSxo/7TNyvWbtdCV15pLn1d8Ki37DAQue8G+Lj96vkV7rGt9fWFxf24v+f6grIdHFCez2S4BjWEYw0hj1bidP8E9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(396003)(376002)(366004)(136003)(346002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(26005)(122000001)(6512007)(4326008)(6506007)(8936002)(6486002)(41300700001)(5660300002)(66476007)(8676002)(316002)(76116006)(54906003)(91956017)(66446008)(64756008)(478600001)(66556008)(9686003)(6916009)(44832011)(66946007)(86362001)(38070700005)(71200400001)(38100700002)(4744005)(2906002)(83380400001)(82960400001)(33716001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Qv5KLMslwU8v/0+4OQuuROKy8FixNP7ZfkrBQH04Zp5VeucgmUesWFOU+P86?=
 =?us-ascii?Q?ep6y832iusqr91mrChBDkDT6xakO9qYKjxM4HthenYytJrfqGbTbI994ieGi?=
 =?us-ascii?Q?XFeTN09XMe00z2UgDPnl5ekZK9pWimviLUCCw9JvFXdSag8wKrwrcX+wShtb?=
 =?us-ascii?Q?41cbOlXPd3lyIJE8hhKmBL8anIwuvfbCLIKG6cNMGgIUsmX90o8fcungrDem?=
 =?us-ascii?Q?2k/AOO+IHUJmLKtzvEcEhLuL1X/afaZZTkLGjKMquwq08ZKMEPHkuQQtmaec?=
 =?us-ascii?Q?IAx8bMA634/UxsThdj0DU5X3GJyR6CTegPYmZqA93wo3niuA7AAi6DpQWJqS?=
 =?us-ascii?Q?SY3RtRZZRaGyj6dwLgtQ2/OHvUFPnCZF5tpuX+TKwBkuGBF0fC5a5rLvGd2/?=
 =?us-ascii?Q?OIjA3NLA+WLdbFmhy2zwGRn/Fe/b8hgtvS7sP0BJvcgQkHHmNarF+hMBk2qP?=
 =?us-ascii?Q?ErTIDDehKhfHSW/ICQ03+8rbRaaKFnYX0ggioa8nhGGDzxaVYrLYO57Zk8Xl?=
 =?us-ascii?Q?1LEX5SbCvozCYdlkCAtZ2CLTOlKgNOOxmLmzxi3RLswnrZQGmU+t3MZzNUS0?=
 =?us-ascii?Q?QNv9lc7k5r9k0n8/RZwapZjDY76/H2jjDpOHGGwcXYlAxmAPqQTgY+M0vXei?=
 =?us-ascii?Q?WvIl5bDE1jIyAVwv2XYzlpxnv8dgfn+KuTRoEsXJziJNNnaFXYE7incgPt5J?=
 =?us-ascii?Q?4djn7Bbd85kkHtrfaZJTy7nRXyAce30loBHHgxRPrJueyj8+zjuJuDUnEtNI?=
 =?us-ascii?Q?oKMuB9TYSw/2NyDfQLEyqCeI+G+GEdTVjsKkKnx52fwlAdtGLXLdW/fgK7Tv?=
 =?us-ascii?Q?McEL/FVjjfQB5xgDpZfSKCGikGQlMTlB5MPCkA+AwmeAl01EIP/dTg31mX/6?=
 =?us-ascii?Q?kFsT/KD1RkT9mHvP9lW0/6Xi9PQJbC0h1ASX5DvF7a5K29Q7lzAF58ZyXCjc?=
 =?us-ascii?Q?KPcsT7WGhTOZhD8esMLISlQH8+9RMDawl0/ZXekHKaXsXtCnc/EYO9+JSrkr?=
 =?us-ascii?Q?1Ck8G5sIITP2WKivVjsgNY5wfvcie6qsiUtSDiR9941jn0OmIv5gXWf32RBI?=
 =?us-ascii?Q?GMkHg/iUGOLi27/woegnxChXKlkHWuy1wULrZAMT12Cmy6xmrW4WfpeFxfj2?=
 =?us-ascii?Q?8tioeSX3enJ/vtP11AbHE2siMxM8/BSByCeO5jf/nzEqaTq3qZjT5cFDLzs3?=
 =?us-ascii?Q?hcJRW4xD0dn0QnqrgAdgIIXpomio3YkdZ8bGVynirvFR+S7M/SixqH6uIY5g?=
 =?us-ascii?Q?tko6bYw4ggA3fXJ/A4W9z2lu8X2zhThbl1HQGcnEwZiUavY09LCfK6I1kH/0?=
 =?us-ascii?Q?IiXwvp+xwQAfhiHvMEKHIxcccdeHmfUihc9ffZXeRkCK8Zx5IZjvAdhvvTjR?=
 =?us-ascii?Q?4Dutl/+tuEMs4vxOKXvnh0Tf3IEiXJXFgznCwfULJa2sp06mTVca+BenWYzi?=
 =?us-ascii?Q?bq6ZchRS5roA3IycHvJXidH8F/Iy13vrP6IcPjnNNg4nvAyZH55DmtYfbfb2?=
 =?us-ascii?Q?NCBz5S9nFKZzxfSHCNIXJtRn7gQTDaCc9rWL1X+0sISX5WnRnzioXV2ISrXL?=
 =?us-ascii?Q?HLZ6jIG9ieu5/rbMf6YUe4OPzSIpm6mG3OOXr60yVRcNhhyVxr2zoqdUCFNS?=
 =?us-ascii?Q?/EWF3Pjifay8VaoZI4qekI0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AED5AB2230668842BB5E0A0EF6BD6C9D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?C1U0rnjvXx9l6A2AQCS4KwNKvhjgiNafTq5VzaRklY9jNNsFFvUnqI8z5A1U?=
 =?us-ascii?Q?6DU/PX3cMCIMXqlujHSDrvAZqKyqDdPp1UZMO3f6Z2QFeu3f+1K++hgvakuy?=
 =?us-ascii?Q?+/tlMXbpdHT2vhyprCSoVKpuV+1SKf7US6Y2AO9S7DGYdugrZx4/tWxkX6o4?=
 =?us-ascii?Q?pjC1ftGQff3yPQH1idFVxQEkXJkW6+PV9N4fP8Sh1hox0fYDhDAv7FkiuiQE?=
 =?us-ascii?Q?F0KxC4q4v+sfulK+P1eLg/T/yuX8TKv7rkgN5TH4pXC3E2UcJvrpwLSBvWk7?=
 =?us-ascii?Q?tQBJ0uYKSeeRExE0UgOlLHBNK40tGYgeddl0QEXK6W4aNwnfVwxQgBlxqGXZ?=
 =?us-ascii?Q?osz8u/QOr9+cErhy/EHAGyLHTCPGuAhJUZbLhT4v8u0tFsoFtv0OgFqHQNdq?=
 =?us-ascii?Q?2z0cUN5zsC86B5KTjQLOG55m2bjUlLSs4Sx/8iH6vKQGa+v1pdZAh3lejfMY?=
 =?us-ascii?Q?D//nGxcX/7LnJhjU8RlEA6EB+u2diaz4P4/YAOxbFZBkyhz9Gk/bAts5cMTG?=
 =?us-ascii?Q?O1lbatBnVGDmVH+fksD6DprJiwRhJxKoAtN+nCpM0Lk5v1j2t16Lvfx4w3Rq?=
 =?us-ascii?Q?6m3ugYSU/ZJg7VsCM+R0gyxlV/bGiFeOJWim9PHLB/eWwnOvpuk+ogaY9RSS?=
 =?us-ascii?Q?dgZs2/weHWbWvK7PQr8C3EuqczbQ2VTWruLE/FSGGUJJBoNC2/ZYkLDMZctY?=
 =?us-ascii?Q?hgt/pwCWG7FczL5hYwGpZIcnUEd3o8pDXlYwZbFAF4/TdfkokvmB/q81OXOg?=
 =?us-ascii?Q?R2bWUPmYZtWHv4v9iL2AJrinTUImbzxAn30JuPwfl5LXFwIzL2t3Izduzmf2?=
 =?us-ascii?Q?1vCZH5nkOo81i8YkmMELxFqK5PhsBZEWCVuBNtrH7KoCNQFD8RkMC6PRJMem?=
 =?us-ascii?Q?kHPGTslpd79JhAvnS156TG2Ftr8FAPgbkEA/y4CnvceaCqtgl5cFtfA/GYF9?=
 =?us-ascii?Q?n5x92avx/X9oWjxN5qcqrg=3D=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2237760-6855-4588-e727-08dbc4906949
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2023 04:14:32.3488
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NiTtLGZFln2alqmjllCdGkRtH1WHjpxzwtv0YkSdzQE0NWf2SCRzaT9bAcRTJkMQ+0jJDCIvh9fCQI0qczXLIWvQrcQwPCYb2xy4hSXUs3Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7553
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Oct 03, 2023 / 17:31, Christoph Hellwig wrote:
> blk_mark_disk_dead is the proper interface to shut down a block
> device, but it also makes the disk unusable forever.
>=20
> nbd_clear_sock_ioctl on the other hand wants to shut down the file
> system, but allow the block device to be used again when when connected
> to another socket.  Switch nbd to use disk_force_media_change and
> nbd_bdev_reset to go back to a behavior of the old __invalidate_device
> call, with the added benefit of incrementing the device generation
> as there is no guarantee the old content comes back when the device
> is reconnected.
>=20
> Reported-by: Samuel Holland <samuel.holland@sifive.com>
> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Fixes: 0c1c9a27ce90 ("nbd: call blk_mark_disk_dead in nbd_clear_sock_ioct=
l")
> Signed-off-by: Christoph Hellwig <hch@lst.de>

I also confirmed this patch fixes the issue that Samuel and I reported. Tha=
nks!=
