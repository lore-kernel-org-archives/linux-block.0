Return-Path: <SRS0=ECsc=UF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A839C04AB5
	for <linux-block@archiver.kernel.org>; Thu,  6 Jun 2019 08:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF91920673
	for <linux-block@archiver.kernel.org>; Thu,  6 Jun 2019 08:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="juo6kaza";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="OUnL/npo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbfFFIHe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Jun 2019 04:07:34 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:63323 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbfFFIHe (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Jun 2019 04:07:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1559808454; x=1591344454;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=yZ0i9pTHVUGKlLcG5jz0a512FmnObBbmLwFz/oVkfOA=;
  b=juo6kazav8bDRmaPKEony4F9rloYlaIlIorKufxoiYDVM7zExdKF2xm9
   xAkCfQlh27FtT2JL027i8RZkMD+IOvUe9370ho1uniNKbQwX9SBRMTubI
   qUTGpypZQElljla67M4JqQ3E2TSkDFe4hR+uE6YJ/9WFqQUl/aahbt2WP
   oaJcQcG4Jmp0Ed+i8l5pqauvNHG4yKYucU3lu8W1EiqBuNwpA9vU3m6Ah
   eNJbUYa6FxsthRGfaSzvgkxClwAyfCTWgS7/CnvkgP8/+AsRZ+TTnK2Si
   rUv/zFRZZmuBZplVFKJsIs+kbLXSbL0fHECorqXjPSv17Q3IGsEZKaYiT
   Q==;
X-IronPort-AV: E=Sophos;i="5.63,558,1557158400"; 
   d="scan'208";a="111208598"
Received: from mail-co1nam03lp2054.outbound.protection.outlook.com (HELO NAM03-CO1-obe.outbound.protection.outlook.com) ([104.47.40.54])
  by ob1.hgst.iphmx.com with ESMTP; 06 Jun 2019 16:07:33 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yZ0i9pTHVUGKlLcG5jz0a512FmnObBbmLwFz/oVkfOA=;
 b=OUnL/npocqBsTkW5803oMet0/lQJ4ZMvbe8Z+37jTqk1PnwBhnh8zC5sIHCuEXu3bc/EIoB1+a3l/LtX3JkU0axFJ+dX2E76vGjptY0nvRwGTgWQIafxfQv34+hn9/9DQ9LZREflf3was6cja+mnX5NDBfHS77zQyEQHZgy+A6M=
Received: from BN3PR04MB2257.namprd04.prod.outlook.com (10.166.73.148) by
 BN3PR04MB2371.namprd04.prod.outlook.com (10.166.73.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.14; Thu, 6 Jun 2019 08:07:32 +0000
Received: from BN3PR04MB2257.namprd04.prod.outlook.com
 ([fe80::45c:b93e:9f81:3339]) by BN3PR04MB2257.namprd04.prod.outlook.com
 ([fe80::45c:b93e:9f81:3339%7]) with mapi id 15.20.1943.018; Thu, 6 Jun 2019
 08:07:32 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Omar Sandoval <osandov@osandov.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@fb.com>,
        Masato Suzuki <masato.suzuki@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH blktests v2 1/2] zbd/rc: Introduce helper functions for
 zone mapping test
Thread-Topic: [PATCH blktests v2 1/2] zbd/rc: Introduce helper functions for
 zone mapping test
Thread-Index: AQHVF1R1TD40R7jYzkKGd94NFNsZTw==
Date:   Thu, 6 Jun 2019 08:07:32 +0000
Message-ID: <BN3PR04MB2257143BDA2FE73729985BCFED170@BN3PR04MB2257.namprd04.prod.outlook.com>
References: <20190531015913.5560-1-shinichiro.kawasaki@wdc.com>
 <20190531015913.5560-2-shinichiro.kawasaki@wdc.com>
 <20190605215247.GA21734@vader>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shinichiro.kawasaki@wdc.com; 
x-originating-ip: [199.255.47.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 25ac4359-3e9c-4065-1023-08d6ea5606df
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BN3PR04MB2371;
x-ms-traffictypediagnostic: BN3PR04MB2371:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BN3PR04MB23713F20593FF5307011E282ED170@BN3PR04MB2371.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 00603B7EEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(376002)(39860400002)(396003)(346002)(199004)(189003)(71200400001)(71190400001)(91956017)(76116006)(66066001)(66946007)(73956011)(66556008)(6246003)(66476007)(66446008)(76176011)(64756008)(229853002)(53936002)(53546011)(6506007)(256004)(5660300002)(52536014)(74316002)(102836004)(6116002)(3846002)(9686003)(55016002)(6436002)(6916009)(186003)(316002)(26005)(2906002)(99286004)(7736002)(305945005)(478600001)(4326008)(68736007)(44832011)(486006)(54906003)(8936002)(14454004)(7696005)(8676002)(446003)(476003)(33656002)(86362001)(25786009)(81156014)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:BN3PR04MB2371;H:BN3PR04MB2257.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wVTKVM7MZCIuezEpWeLQf1d/Ej2RjKwvzJuuJ7CBmA9V8OV117xdAkCsErdh/88la7RGm+PN55Nuo9eAnyzCvxXOn86A5RVVRb0tQtzdPaIWIO26nMwSg6knvffBKZWy0g2w6tNBXm/nYFxbyYkcHyVTnJzNe92JlObWxW1SMI6MikQRkfRYyn9jhCZwHgeo6lDsujg5DqnPvsvZU2buVuzqhkL1fMQ9uip5q4hqNaFpgnOGjdl0Q59Nnsh561UuBAP0bpOZnel220DJabR4pJjxuF/QQswwBvfiCWfBZ57YOw+5kosuxELibqfiJ27TwRsp9mQ9YyO3NYHPSS/7RLL/GXhSTwHM98ZIW+o+s0gMRGkYFJQYbY69fPNwgqAkl+I0mvoMyEXZuYln3N0NswZ7R73BMyaISPfWzO8+Mik=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25ac4359-3e9c-4065-1023-08d6ea5606df
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2019 08:07:32.0690
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: shinichiro.kawasaki@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR04MB2371
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/6/19 6:52 AM, Omar Sandoval wrote:=0A=
> On Fri, May 31, 2019 at 10:59:12AM +0900, Shin'ichiro Kawasaki wrote:=0A=
>> As a preparation for the zone mapping test case, add several helper=0A=
>> functions. _find_last_sequential_zone() and=0A=
>> _find_sequential_zone_in_middle() help to select test target zones.=0A=
>> _test_dev_is_logical() checks TEST_DEV is the valid test target.=0A=
>> _test_dev_has_dm_map() helps to check that the dm target is linear or=0A=
>> flakey. _get_dev_container_and_sector() helps to get the container devic=
e=0A=
>> and sector mappings.=0A=
> =0A=
> This has a few shellcheck warnings:=0A=
> =0A=
> tests/zbd/rc:221:4: error: Remove '$' or use '_=3D$((expr))' to avoid exe=
cuting output. [SC2084]=0A=
> tests/zbd/rc:223:4: error: Remove '$' or use '_=3D$((expr))' to avoid exe=
cuting output. [SC2084]=0A=
> tests/zbd/rc:225:3: error: Remove '$' or use '_=3D$((expr))' to avoid exe=
cuting output. [SC2084]=0A=
> =0A=
> And it's missing your Signed-off-by.=0A=
> =0A=
> Thanks!=0A=
=0A=
Thank you for the review and sorry about the mistakes. Will fix with v3 pat=
ch.=0A=
=0A=
-- =0A=
Best Regards,=0A=
Shin'ichiro Kawasaki=0A=
