Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 987F5C678D4
	for <linux-block@archiver.kernel.org>; Tue,  7 Mar 2023 07:15:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjCGHPB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Mar 2023 02:15:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjCGHPA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Mar 2023 02:15:00 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4AFA3E62C
        for <linux-block@vger.kernel.org>; Mon,  6 Mar 2023 23:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678173298; x=1709709298;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=G6OVILTYHiOS0+ZpeROky7cCKR72r8xHzAFkDmp+1bw=;
  b=XtFgGEXgCKC9TYYuw7PNNgeYdnlrCYQM1NyKVCrpqbE5qEM6JxyjWrqs
   Bi5hNOj1EUzW/oVTLu6cZqQ+feKRTEafYy1rdap9LnvwGRtM0lGHx+oYR
   ZPzd7bvH69e36PYBVM2z65nhZbbHGUBe7dSVNLajlLAU0fC7adJs6puG0
   lplYBYFDf1YcDnyrmqO9tIjIQAD9MvarGfF3zH4A/v6B31s6wApX7boqO
   w27FXJDye29w1ilafMngENMy+wV8Zg2oyzRbWDhlou5et71cj0OLfdtdu
   wxajShBQToIOhpd+GDjZ8gqMikVwKc+eE3O4p7tRYEA7mXRjastZ5m8+Q
   w==;
X-IronPort-AV: E=Sophos;i="5.98,240,1673884800"; 
   d="scan'208";a="229940170"
Received: from mail-bn7nam10lp2102.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.102])
  by ob1.hgst.iphmx.com with ESMTP; 07 Mar 2023 15:14:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JVyLVonEd74vmlrFUI0YUb1OT9TZc5en9m9oN+edI1XL/XH+1ct4ew3K8X8PNphuOfNR0Borj/zykqVs3BCG8fwjg8OFhwPdvIqN/QlR7tbVIwqIX8iljCP/MFa+C35eWb2RdWEgd3JmEhMxw36HxsSAPgOtsde/MG+fo1iHuNTAs7oCsgERKe5gQ76+5XJDNMpqqfzFljciRzyxr6z/YOgtVnG7iWrBB94G/H8U7/liMjHAUmpOWP4v6ZA0uwXybJ6DvAKuRIrZsxeyCB9w12+WNeJ+/dO2QfypPIaIff3hrvJj8+4FhGMXzfOrD/HzLyAOIH8QCK+DseQtUi2Bsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jOn0H5+nBoAZ6w5+qzmjKj8zJktJSsOBvY5uAFqqEdw=;
 b=XXN4FihyW328Gve4Gzx05imAnUJD8/ZYOjoDsasdPLmeM9VsGc4WIGameI/6eg8C5vSNa67hLZnbZwxl4OpT9Uzdcy9jFAJwt6HWTvfiuUVo62tSYyddQkSi9/c55UsLAIzVjtcFom7c30/7e3ZyfHuewenTK48FPEf9ZHawjZUzg0mF4ox9asWnAmYeYhemoVOT1VmcZAF7xw6TPGXJ1kT3Q/ZjWccIPMOI5VPEjNtk7iESQrcR3OQFGNz7vtII6Iwddv1rbjcCjvJ1s68KyBYB1F/wujEGsYxlccePRHQ38r/pHnq7JMkFwX1b18n8gSFXG6YSlAUZdMfwTBAt7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jOn0H5+nBoAZ6w5+qzmjKj8zJktJSsOBvY5uAFqqEdw=;
 b=CRs18Uab6180ck64XTkkB1yJk6GwgrX1Fd+Vg+NYsuR7Pg/vIIgjzu7ARsz/KshpuRLkk926d6h1LTW8pZD6OVu0ZfMFYTxlM18fbDhqBWIf9EwMveLMh24uEciiyX8v293ARBy49coCPfGRTqQo7coLwvVufPy36/0k4bfPyrQ=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BL0PR04MB4900.namprd04.prod.outlook.com (2603:10b6:208:54::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.28; Tue, 7 Mar 2023 07:14:49 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::1b90:14dd:1cae:8529]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::1b90:14dd:1cae:8529%9]) with mapi id 15.20.6156.028; Tue, 7 Mar 2023
 07:14:49 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     Gabriele Felici <felicigb@gmail.com>,
        Gianmarco Lusvardi <glusvardi@posteo.net>,
        Giulio Barabino <giuliobarabino99@gmail.com>,
        Emiliano Maccaferri <inbox@emilianomaccaferri.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: [bug report] BUG: KASAN: slab-use-after-free in bfq_setup_cooperator
Thread-Topic: [bug report] BUG: KASAN: slab-use-after-free in
 bfq_setup_cooperator
Thread-Index: AQHZUMSAZFA8a8YrAESPLW4VjNB6JQ==
Date:   Tue, 7 Mar 2023 07:14:48 +0000
Message-ID: <20230307071448.rzihxbm4jhbf5krj@shindev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BL0PR04MB4900:EE_
x-ms-office365-filtering-correlation-id: 28d43cf9-d39c-4479-75f4-08db1edba359
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pT9ZJXDxKaaUxsY7UuoltrQuffafouy/V3BhksxLioOL7J60OSuQBOqb016EKUg/7eki+qzdqqnl1zwnHfwMAOuWGDcqiRmT8Q/d4sLYSgPxfyv0Svoz2dEobOaXvpjjDvsgRGaIRWNL6Psa//vqhuduTyP/q3Eip/3pWbZp+thvhCNtiZ+NYW23SytIWi6tUC9wnd561/4IfU7cwI5WYjKcr24sdEZISc7k5sxD78JtLvdlf2Bv9l1IO3x6HKWAQ/CZuvkadPO2C+kqi/C65htT06iphLhtr59igWLclxdvogqaM54lRNX2YLkhFmf0GsMy6AinlyLh2SSYqKkuE7BcmQilmBfP2CSW7mDYNwQnVawZy2V40aYCCrMOmOQRVZg6kxflNWtS06cxOilV3BeIQnUhemYF1Kwk5E8jev9pO5gbbz65k4n+dURsIkZSE0/GMruFZ243EetWlIc/oEXHvyqBAFELF+9dWuXgYATmZ4N+J/GHE8e7Om4BiB78jWv8w7BkLisXh1WWPlgtnkLpxHGJV5PbWEzn5PV8dDTyhI/SRr4xOxZVHk+Y0qd6oCWBjcO4GmuI0suPOOKqqwWkBE44WLqcrRWmMZATRbo7a3hzEid6ZtjFx0LpAitI97hBRrSvGyI7XJovr83yZjGOmHHe9/Fpw0sRUCfWCD313eT6gtq4sLP6MEsKtBLP93C8xQzuf40/1OWRSJ3wsQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(4636009)(376002)(396003)(366004)(136003)(39860400002)(346002)(451199018)(6506007)(1076003)(26005)(6512007)(6486002)(83380400001)(38070700005)(82960400001)(122000001)(86362001)(38100700002)(9686003)(186003)(33716001)(41300700001)(66946007)(91956017)(66556008)(76116006)(66476007)(6916009)(64756008)(66446008)(4326008)(8676002)(2906002)(44832011)(8936002)(5660300002)(478600001)(71200400001)(316002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Uh5CCDoJ+U0AO61FUzkQh+6mfm0jFcEdI8WioqpcxGITNV2qPR0CVNDslOyP?=
 =?us-ascii?Q?zqMwMoFXvu4LyIxz4kUDV3crD1XTC7hY7cRptO9BCFbDUmH+/DGwptLvrU8n?=
 =?us-ascii?Q?lFUumEAPtocH3v5pKOx++83lPFlyMF2IYkWURapd4968A3XM/BDqDjxSt3kX?=
 =?us-ascii?Q?jLdNmHt2CnStZMJRv+I2tx2nobl6hpxkN+BTx5mLeFJr1dR3LTHgd4UCocrv?=
 =?us-ascii?Q?dx9lrQeRv4BOOxSq1B85RzcCG8zgpTSgJIdznVurroMGxBok/b+7AwNiFztr?=
 =?us-ascii?Q?Ic1YyZSJ4KlF09Grb2UuHYpHwX0DU+dW0LcA2YC0lTD1BtLRHvjbjx1CNcSp?=
 =?us-ascii?Q?CTJiNOqeDmL2aW4uzDmSXl9dScJvJVfn+bcgqCeh1WRM+ruUsVasIt4Dm27D?=
 =?us-ascii?Q?CwsXiE8GktwD7ZEgv6s+BOUKatB98sLD+Fk3Ztyx4/67CwVPpz3hQmCxxKmG?=
 =?us-ascii?Q?Os3P0vtbQnC7ddzVaBmWJD2JUcioN91Ykgnh3aDLIH7ceS0QUOP1DtCktmWX?=
 =?us-ascii?Q?n9/KvQDh/p6zaW4xdCEFHPXzZWmGYtyGkt5E76ShNgPQqo8GSrZD9ei/4PFm?=
 =?us-ascii?Q?mSWyx0+l4MxdDMUmUnOTfd8J3hg2O89AZ61Sj1s3ASvXBV7WdB1uXyigfqlI?=
 =?us-ascii?Q?B+kQc9lz2F14DmbPHRLuBCJg0t00ivEYK19wanyYLEKP/qTDfx73o3DqDuJM?=
 =?us-ascii?Q?WpRurWLdZtAmiHyaFE+fJDY/yflIId9Wc4dpI1LXpJA0yqgYb6j52z8RkHTP?=
 =?us-ascii?Q?7Mw4BLDDScor4bEu5iD+ThMXyIz7iiOdGOTYYvsQRbhnnD5J7dF+Q/KwZ2z0?=
 =?us-ascii?Q?0yYys4NpSRA0crThimjH6MDLsyLsn7lZEYqn9XnWZKATyCcXTVgxaUzQcpZg?=
 =?us-ascii?Q?HWnCnrDJg7/unLmp3gQ7Cg3ud9x2jNtaBaY5OIy9KSw8N2E6Op88XQV+YuPi?=
 =?us-ascii?Q?bD1uR7dNfb0KU0YS5uv0M6mOMsyHhDOh+1TLHWHev9i+i65dtYR27sKo9Bpy?=
 =?us-ascii?Q?zpm2GuvJJ3rvm69sC7MWf/mHH5pznqzHLDieG3KE6x4Gf76fdmdJXhSqcJ2/?=
 =?us-ascii?Q?nqIjkhLFOm62k2zL2kQR37VrQRX+kl5pxVF0RU9B8lCPT9LqbTp6mffc5m6i?=
 =?us-ascii?Q?0sBpu/mtg6mVc8Dz/pJtmb1xEUXyRTTg3FYTVRJwfU5Gr1bGsJ0NLZ+2MYml?=
 =?us-ascii?Q?d25v5I/u3po+JT30g29OCPbCc2x4czHJznQPnehwqF6LqV4PSIouoias5K2H?=
 =?us-ascii?Q?GVtoaEE7QCHi0fuLB7AfubWeM5bKZWRsQnhqKhD27PMo02C0yG8pB3pQu3RX?=
 =?us-ascii?Q?h3Wo1GTDLVoIV49D4yrFaZoINm8u4Lozbyckuj0aNfzPj12gGRZjNr4G+T78?=
 =?us-ascii?Q?qNMwYZF+C4lCQNvqD/Th9BaxJqa8cXgE+3V2FvTNtMJ5dlmj6O5Kr6LKJ/73?=
 =?us-ascii?Q?KRLBFkxaN6Qc6j6QUDqW5w7yy9/+hLXJus851ru0xSQPybUocbXSUumvS/fX?=
 =?us-ascii?Q?D+URe1OoCDKt7GpguKpshutJPp1ReOgjwfs8BbevkJbCnipogMa+l34Tg0tE?=
 =?us-ascii?Q?/Lvkc43WUqRK6p+QGc1GF1FJZgoh098dNrzpvcEOFTGWMjzntkT3NJfxB/JB?=
 =?us-ascii?Q?rcloxRLOuOdEwh3gUE4owvw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2913B16C235AC64DACE02492BC0FC7E2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: AsCl4Ft95xV7HktBbBsJ949zdT4CDDY1r3t3WZq8VDyV9GC581O+ds1ej+MS2rv3mkXM0Ew2zhKnv7XLhUhloE5RBpZLwJkcxey78UguMVWTpxj+Cvekk1V/rfbp4s+59pf1CAgIlXGQBEg8cmtMN75AY+wlr2Ys1cBW3R7VHW/u0hcH8p78jSKi/LWr50VzmckG00FswgQrABZfitAYIkVaE9Xs4mAi6S7QKvRjWJZ83x+Sri1CF5Gve3QHDscLBMU8nK8BBUcrVC3L7+nQUsGXF4UrUYb5SuLoiANfja47wpsGQYfDRKbaaSjv4pStKBUP6fs9lQZ9d39gk5N9+lTG6cCr9pMSaD85SPNIWCeLTrj0UsYs9btbk1RS6SbIOWy0sHEPVzUqCeCPPjyzCh3OD3/9l8PhHOvtcs7s6R+QIn7qDvxEcDzaTv1VzaUT0WYv8AmVHcaYJkYPQJ/fHHei7fRLanrZKtS8YPsA8ClehclKyFuyZjZbwP6zZjjZ4UOooj6XzpQ4omtwEhEOv/qos3POqkBig8NqpgN7vw5lZCu8ySwLy7GWwKPmsir9RllLOMEENOEsiw0DGBsgrjxWQ/+IvjPXDhwbS0LXzC2cDS9XRhckHyGBbJBfBqM/RA5Eglp6/bFOcuQb3Dct8rzqAhftDVANPnizDk6gbA87ULDPmwNEYFVEvTitkUzXNZeF9EBFt/GomztZONoOIKVhErYd+UZjK7Vkunejg+xibzzhexCox+md+wTb+Z4WCYOXN5HayF4e8xzGZn+QM6AQ8uYEhGVNZyNywZTtMXKLDEJ+gsBPrwNO5IEL1zxgJExgZVIHbPP3I5TzSdvnvyln9h3VZuSlBTeWiKABr+FRp+nDvuzbZEZWjkIH6PaYUCVuFXvDOJYT2X2anWfMUBaszItkqPhWbtcl9b7irR4=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28d43cf9-d39c-4479-75f4-08db1edba359
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2023 07:14:49.0121
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OkxRCh+u3OWyWRxfqaLT3yrMpTIWm6fCSjHMa3YmQdiJyF7aeIUkIXryavJ+SJELHh+MmWUSMRDhOf/996Bv8g99mL0ddMX4iIG5wpqUJq0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4900
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I observe the KASAN BUG message with kernel v6.3-rc1 during my system boot =
[1].
The BUG is reliably recreated. I bisected and found that the trigger commit=
 is
fd571df0ac5b ("block, bfq: turn bfqq_data into an array in bfq_io_cq"). I
reverted the commit from v6.3-rc1, and observed the BUG disappears. Action =
for
fix will be appreciated. I can take actions on my system if it helps.

[1]

...
[   49.534400] NET: Registered PF_QIPCRTR protocol family
[   51.420663] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   51.422452] BUG: KASAN: slab-use-after-free in bfq_setup_cooperator+0x12=
0b/0x1650
[   51.423576] Read of size 4 at addr ffff88811a8bd600 by task NetworkManag=
er/724

[   51.425032] CPU: 3 PID: 724 Comm: NetworkManager Not tainted 6.3.0-rc1-k=
ts #1
[   51.426105] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.16.1-0-g3208b098f51a-prebuilt.qemu.org 04/01/2014
[   51.427647] Call Trace:
[   51.428103]  <TASK>
[   51.428472]  dump_stack_lvl+0x57/0x90
[   51.429042]  print_report+0xcf/0x630
[   51.429642]  ? bfq_setup_cooperator+0x120b/0x1650
[   51.430296]  kasan_report+0xbb/0xf0
[   51.430843]  ? bfq_setup_cooperator+0x120b/0x1650
[   51.431487]  bfq_setup_cooperator+0x120b/0x1650
[   51.432175]  ? __pfx_lock_release+0x10/0x10
[   51.432769]  ? __pfx_bfq_setup_cooperator+0x10/0x10
[   51.433442]  ? lock_is_held_type+0xe3/0x140
[   51.434046]  bfq_insert_requests+0xdfc/0x9360
[   51.434622]  ? __pfx___lock_acquire+0x10/0x10
[   51.435248]  ? set_operstate+0x193/0x1f0
[   51.435778]  ? __pfx_bfq_insert_requests+0x10/0x10
[   51.436440]  ? blk_mq_sched_insert_requests+0xba/0x880
[   51.437091]  ? __pfx_lock_release+0x10/0x10
[   51.437700]  blk_mq_sched_insert_requests+0x16b/0x880
[   51.438356]  blk_mq_flush_plug_list+0x341/0xdb0
[   51.438930]  ? __pfx_blk_mq_flush_plug_list+0x10/0x10
[   51.439600]  __blk_flush_plug+0x28d/0x450
[   51.440117]  ? __pfx___blk_flush_plug+0x10/0x10
[   51.440734]  blk_finish_plug+0x4b/0xa0
[   51.441199]  read_pages+0x50a/0xb90
[   51.441627]  ? __pfx_read_pages+0x10/0x10
[   51.442147]  ? free_unref_page_commit+0x243/0x500
[   51.442698]  ? _raw_spin_unlock+0x29/0x50
[   51.443176]  ? free_unref_page+0x2f2/0x400
[   51.443687]  page_cache_ra_order+0x617/0x870
[   51.444198]  filemap_fault+0xe45/0x1eb0
[   51.444714]  ? __pfx_filemap_fault+0x10/0x10
[   51.445221]  ? lock_is_held_type+0xe3/0x140
[   51.445711]  ? lock_is_held_type+0xe3/0x140
[   51.446238]  __xfs_filemap_fault+0x141/0x7d0 [xfs]
[   51.447406]  ? __pfx___xfs_filemap_fault+0x10/0x10 [xfs]
[   51.448302]  ? xfs_filemap_map_pages+0x9d/0xd0 [xfs]
[   51.449200]  ? __pfx_xfs_filemap_map_pages+0x10/0x10 [xfs]
[   51.450073]  ? __pfx_xfs_filemap_map_pages+0x10/0x10 [xfs]
[   51.450953]  __do_fault+0xef/0x5b0
[   51.451357]  ? __pfx_xfs_filemap_map_pages+0x10/0x10 [xfs]
[   51.452236]  do_fault+0x4c1/0xec0
[   51.452619]  ? __pfx_pmd_page_vaddr+0x10/0x10
[   51.453139]  __handle_mm_fault+0xc40/0x2410
[   51.453605]  ? lock_is_held_type+0xe3/0x140
[   51.454063]  ? __pfx___handle_mm_fault+0x10/0x10
[   51.454617]  ? count_memcg_events.constprop.0+0x40/0x50
[   51.455171]  handle_mm_fault+0x21f/0x7a0
[   51.455616]  do_user_addr_fault+0x344/0xed0
[   51.456130]  exc_page_fault+0x65/0x100
[   51.456555]  asm_exc_page_fault+0x22/0x30
[   51.456999] RIP: 0033:0x562259a3da00
[   51.457472] Code: Unable to access opcode bytes at 0x562259a3d9d6.
[   51.458109] RSP: 002b:00007ffcd8f6c5d8 EFLAGS: 00010287
[   51.458718] RAX: 0000562259a3da00 RBX: 0000000000000000 RCX: 00000000000=
00000
[   51.459449] RDX: 00007f07c1ce9310 RSI: 000056225a0bb6f0 RDI: 000056225a0=
7d8f0
[   51.460224] RBP: 0000000000000002 R08: 0000000000000000 R09: 00000000000=
00001
[   51.460919] R10: 0000000000000001 R11: 00007f07c1b58c80 R12: 000056225a0=
7d8f0
[   51.461669] R13: 0000000000000000 R14: 000056225a0c43d0 R15: 00007ffcd8f=
6c780
[   51.462382]  </TASK>

[   51.462907] Allocated by task 723:
[   51.463287]  kasan_save_stack+0x1c/0x40
[   51.463705]  kasan_set_track+0x21/0x30
[   51.464163]  __kasan_slab_alloc+0x85/0x90
[   51.464602]  kmem_cache_alloc_node+0x16a/0x330
[   51.465068]  bfq_get_queue+0x1fc/0x1420
[   51.465537]  bfq_get_bfqq_handle_split+0x11a/0x510
[   51.466029]  bfq_insert_requests+0x731/0x9360
[   51.466492]  blk_mq_sched_insert_requests+0x16b/0x880
[   51.467068]  blk_mq_flush_plug_list+0x341/0xdb0
[   51.513146]  __blk_flush_plug+0x28d/0x450
[   51.743436]  blk_finish_plug+0x4b/0xa0
[   51.800072]  _xfs_buf_ioapply+0x68c/0xab0 [xfs]
[   51.800884]  __xfs_buf_submit+0x1e8/0x7b0 [xfs]
[   51.801677]  xfs_buf_read_map+0x301/0xad0 [xfs]
[   51.802521]  xfs_trans_read_buf_map+0x280/0x7c0 [xfs]
[   51.803368]  xfs_imap_to_bp+0xe6/0x140 [xfs]
[   51.804164]  xfs_iget+0x780/0x2a60 [xfs]
[   51.804909]  xfs_lookup+0x234/0x390 [xfs]
[   51.805669]  xfs_vn_lookup+0x108/0x150 [xfs]
[   51.806442]  lookup_open.isra.0+0x7e8/0x1280
[   51.806965]  path_openat+0x829/0x25d0
[   51.807388]  do_filp_open+0x19f/0x3b0
[   51.807803]  do_open_execat+0xa8/0x570
[   51.808282]  bprm_execve+0x3da/0x15e0
[   51.808698]  do_execveat_common.isra.0+0x4d6/0x6c0
[   51.809213]  __x64_sys_execve+0x88/0xb0
[   51.809678]  do_syscall_64+0x37/0x90
[   51.810084]  entry_SYSCALL_64_after_hwframe+0x72/0xdc

[   51.810895] Freed by task 724:
[   51.811256]  kasan_save_stack+0x1c/0x40
[   51.811688]  kasan_set_track+0x21/0x30
[   51.812161]  kasan_save_free_info+0x2a/0x50
[   51.812627]  ____kasan_slab_free+0x169/0x1c0
[   51.813096]  slab_free_freelist_hook+0xdb/0x1b0
[   51.813642]  kmem_cache_free+0xdb/0x390
[   51.814071]  bfq_put_queue+0x439/0x950
[   51.814497]  bfq_setup_cooperator+0xa41/0x1650
[   51.815030]  bfq_insert_requests+0xdfc/0x9360
[   51.815503]  blk_mq_sched_insert_requests+0x16b/0x880
[   51.816042]  blk_mq_flush_plug_list+0x341/0xdb0
[   51.816583]  __blk_flush_plug+0x28d/0x450
[   51.817027]  blk_finish_plug+0x4b/0xa0
[   51.817451]  read_pages+0x50a/0xb90
[   51.817897]  page_cache_ra_order+0x617/0x870
[   51.818368]  filemap_fault+0xe45/0x1eb0
[   51.818801]  __xfs_filemap_fault+0x141/0x7d0 [xfs]
[   51.819622]  __do_fault+0xef/0x5b0
[   51.820011]  do_fault+0x4c1/0xec0
[   51.820448]  __handle_mm_fault+0xc40/0x2410
[   51.820910]  handle_mm_fault+0x21f/0x7a0
[   51.821352]  do_user_addr_fault+0x344/0xed0
[   51.821864]  exc_page_fault+0x65/0x100
[   51.822289]  asm_exc_page_fault+0x22/0x30

[   51.822956] The buggy address belongs to the object at ffff88811a8bd600
                which belongs to the cache bfq_queue of size 576
[   51.824269] The buggy address is located 0 bytes inside of
                freed 576-byte region [ffff88811a8bd600, ffff88811a8bd840)

[   51.825761] The buggy address belongs to the physical page:
[   51.826393] page:00000000e11d915c refcount:1 mapcount:0 mapping:00000000=
00000000 index:0xffff88811a8bc2c0 pfn:0x11a8bc
[   51.827462] head:00000000e11d915c order:2 entire_mapcount:0 nr_pages_map=
ped:0 pincount:0
[   51.828247] flags: 0x17ffffc0010200(slab|head|node=3D0|zone=3D2|lastcpup=
id=3D0x1fffff)
[   51.829021] raw: 0017ffffc0010200 ffff888100a95cc0 dead000000000122 0000=
000000000000
[   51.829779] raw: ffff88811a8bc2c0 0000000080170011 00000001ffffffff 0000=
000000000000
[   51.830581] page dumped because: kasan: bad access detected

[   51.831358] Memory state around the buggy address:
[   51.831907]  ffff88811a8bd500: fc fc fc fc fc fc fc fc fc fc fc fc fc fc=
 fc fc
[   51.832615]  ffff88811a8bd580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc=
 fc fc
[   51.833371] >ffff88811a8bd600: fa fb fb fb fb fb fb fb fb fb fb fb fb fb=
 fb fb
[   51.834077]                    ^
[   51.834496]  ffff88811a8bd680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb=
 fb fb
[   51.835228]  ffff88811a8bd700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb=
 fb fb
[   51.836009] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   51.836739] Disabling lock debugging due to kernel taint
[   51.999350] e1000: ens3 NIC Link is Up 1000 Mbps Full Duplex, Flow Contr=
ol: RX
...


--=20
Shin'ichiro Kawasaki=
