Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58378C64E7C
	for <linux-block@archiver.kernel.org>; Wed,  2 Dec 2020 06:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6D6822206
	for <linux-block@archiver.kernel.org>; Wed,  2 Dec 2020 06:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbgLBG1M (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Dec 2020 01:27:12 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:9609 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728392AbgLBG1M (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Dec 2020 01:27:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606891165; x=1638427165;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Ew9788z/nBsJGzS+61yRC6b5ftV3Fn0UHMavnZ1ifpw=;
  b=qgb8sQT/t85pgDn3UmuCWYGRDBS6kMSjSoUoa+vg1eVMDBiN0YRgKtNd
   TSw3POVkrxPmtbwEf1ZWD2XzhHJMudm5oMF4Vvy2no8fk9tNkZ/cy5oQ8
   z4pQ048sv3zw+MGtYBlNSKV6QVrhpV5uJamuXv/bvyYbK6HsNWEnT5VOi
   3rfFlC+PuG9seIZVIA8KmqzHmxzEeYb/7S/tvjIc5dXPyp/NjyJpoaww+
   wsdcMkP0rqIILgRvFcfWm3pBDkxRPW0mlRE4Y35mWUMWLN4cMXf1F3rTo
   KakT8q9wGrJEAp9tGGXah+njkCXYMjzB8Qi4V5dkybXeqNbYJ+uhTLtYQ
   w==;
IronPort-SDR: gQqld4WIgJ2KbdwSmlvNCLmgGQ20NwtQC0xejsI7JtnxHjiOjoFmL23CM87k2DfOOidzhgo7hi
 3GbPVhXnS69CuRXH/mAKGk5VUYVskcL4QOrer/Zqn+VQl+0rDZlHcYN5AqD7tjjBafMiR6YRUI
 DnnI8FA/o2qfHzuhLmr/vD586N7fGyDdjsH4BafsHsOzmul9yqZNHQiWofCe8l+GID915wYaSC
 iosWvalR6OmPaycak5aifck73LY1iC6qWsBehj0MC0+ms478KYlK9oQiYQ+25IiKcWj8EazgMV
 Rfg=
X-IronPort-AV: E=Sophos;i="5.78,385,1599494400"; 
   d="scan'208";a="257684318"
Received: from mail-dm6nam11lp2176.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.176])
  by ob1.hgst.iphmx.com with ESMTP; 02 Dec 2020 14:37:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aCDowHMASyN3EqnN8o9sEcus7K6Jo+p512n3cALZDcVWbC39IxaPqFblTWKZHmOyR245/LXzINP33nxbJrgJty4p/oJ/vq0zK7CL/dsAxZrP1bCVj7MfYYIStagGAMJ6FEQ8JWSTChRvGnouoKcD7hEkMtBgZeDkI8X7aPO2AwnCvtkB4LnjYRUyntbkB7vzYyuetILKOebvUnYmy6meHgvAr8DK6SHKOegYKr0l/j4D7XwZJjYtdWJSjeEho6+/97zDlTU6PvPyC0QEw9djnBvoPN4wHxRR+j3pZDiJkDFXgyIt+w7TyWeFbVOmBQK+ILX0Rddzc9R/i3KTl4NVtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ew9788z/nBsJGzS+61yRC6b5ftV3Fn0UHMavnZ1ifpw=;
 b=NE1GtY3Jx3fII1UZHz9Rr57g+ORVoUsjSmtLJ3t52WUp6qtQu2zE4P73vJtY6YZMNeyTRDNHxQHkdXkC1NA0VzU53f03huw8/8WFyvJLKKe6EeYJA7KcLNTxmB2xtfOFVZ0YAiO22R2Vnih/jOiK187uRVKevUGWd+aOIGJIGkoi189ebxDDTB9A9RK7P5CUNZRKJwWsTRAp1E0eY7Uwwo6/zUcROs2xRKxG9pYx16Jd7Mf4dkdjfeyYqkctn2Wifwk9xCD1F0BBdC45tfes+fG9lIJ5sx40c/eKm0BmZHeVmzs4zzuU44r4BhYVsDIKounYeo3IaluD1D6G78CcUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ew9788z/nBsJGzS+61yRC6b5ftV3Fn0UHMavnZ1ifpw=;
 b=FZuulrSDrJvqqP5DdsAxltPGU08EyPLmdt1vvXiBERlbN+/hG/96ksttoyxKhRK5uT8l6zsM0EcXJuqAoocKqYEJJTzsbSaQ/zV5pQiV/Usa+gqnvZFy9jrdsMdvjvjXJ5//v+psBNS0P0GbhO+Tc5LbiEHg2bLe8m1R4fLkp+E=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6552.namprd04.prod.outlook.com (2603:10b6:a03:1d8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20; Wed, 2 Dec
 2020 06:26:04 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4%7]) with mapi id 15.20.3611.031; Wed, 2 Dec 2020
 06:26:04 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH V3 0/9] nvmet: add ZBD backend support
Thread-Topic: [PATCH V3 0/9] nvmet: add ZBD backend support
Thread-Index: AQHWx5hxEAbfrfG/GUqQyO0qzymqDg==
Date:   Wed, 2 Dec 2020 06:26:04 +0000
Message-ID: <BYAPR04MB4965A797CFE6FE2E03522C1886F30@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20201201041416.16293-1-chaitanya.kulkarni@wdc.com>
 <CH2PR04MB6522A2943EFDF118FEBA264EE7F40@CH2PR04MB6522.namprd04.prod.outlook.com>
 <BYAPR04MB49651C09824B2C82E44DB79C86F40@BYAPR04MB4965.namprd04.prod.outlook.com>
 <CH2PR04MB6522AD27DCACDEBC04EF6A00E7F30@CH2PR04MB6522.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bd810bae-36ee-419e-4662-08d8968b2569
x-ms-traffictypediagnostic: BY5PR04MB6552:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR04MB65524F0CEA0A78CBA8441A1D86F30@BY5PR04MB6552.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zDa5VmD+Vx2TlBLKL0C04nAbbxwXD/wMVlEnN/xCuBV+hyO6vNdXiX6dmGekKbkbWaPBKAl72BOLuOMJaug27sntxqXEBb+3QKx0BH1I5WofJgsFTO0PI0+099HHUG2E/a7WQ8WGZhR8YyOgBOZOpg1v+pQfrZIV5zNq7MOKa+zkQ/YjW6rhwMjZKaX+tOoWr78C6Oj0nWaMZLdgsp92D8wl9U1x1gPNofuaVaJtl0Z9prKrCZ7UcUkfZ7DnmSKF3WCds1/QqDmlzRUeF7/IZaUmPtz7wscNQ+dveFopMbl8sG23UyCRR7zpHGOOvTEt
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(316002)(55016002)(33656002)(2906002)(9686003)(558084003)(8936002)(8676002)(5660300002)(26005)(4326008)(76116006)(54906003)(110136005)(6506007)(64756008)(66556008)(71200400001)(52536014)(7696005)(186003)(66476007)(53546011)(478600001)(86362001)(66946007)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?F1qtg64kgXzDXhFAuGpAW96CZ7VqEduG/g0wV9u3rIibzM4axXperkinExCG?=
 =?us-ascii?Q?+feFu60atMRYSMBScZ8myZiyrOqqtgz43hIwGHZFNMAvnXh/GJkXR/4rwWPr?=
 =?us-ascii?Q?jag/v8j1u/ra5WyvEcyumBtClLKkJpYJtGBL7/ReQc6CtwT+UV5O1lfuLclg?=
 =?us-ascii?Q?BCvuucVCeChubbkPlGFKw5JV0/9z+vkEKaWW+1qdUtYihlV1HAYKDaubi/1p?=
 =?us-ascii?Q?5Bhr8PF2lXT3CBqcHa82BE/mZjWU4BPV95mTrJTlRqaUQEbbt5i2AJdeFSc7?=
 =?us-ascii?Q?Dx2GKYUaYXSpLnhm6pj+m5+xL1tyWJyhf/ir+cyjffvtbK9MchBU4/ecRNmE?=
 =?us-ascii?Q?mi06JLK6wCw1yboL0jSrDr6YvXkoLtvQCGe8lDPfUbV59trvAhjjpAJnEOeZ?=
 =?us-ascii?Q?ZOSVdfAg+uw+duVhITVmKzzm0xe5ZE5ngfxQ2/yKOvNZG6HvlTiPYUd7BIpy?=
 =?us-ascii?Q?/IutfGtzwRx2WVswGdAU/IrRpMe3QkJKxbQHk0ieRuvNUw0GY36z9YAEj5xz?=
 =?us-ascii?Q?hban3K4OLZWeaKqcnoTjIbfyRbTyN3p0SKv/I7A0D6vzCyYpwgJ0dNZXrx1W?=
 =?us-ascii?Q?cs1Smuz8mvaccYQPsoJqsJEPQX0e+7O2vPxxT64g+S17blsuMBTULJ78GIAP?=
 =?us-ascii?Q?Fvy/nccFCR8I5C68+K7teTiLy+E5NICcrHx7oUL+RYlS3gPM9gSwtD0XApj7?=
 =?us-ascii?Q?5IRdd6qQ0ZJdFU2D7BgyUcNFNkPMnxvUHKJ7x2y3WdjZZ+F9aJ1EpzOWDV4U?=
 =?us-ascii?Q?tVW3/h5GEbvtMXxtJfKJ7s5taIKCeyRQhgdJ7iqFvEGkMfBcciz4BrQY5sbG?=
 =?us-ascii?Q?6uxg1BlxJgnyNZlrRzlDIkUE8Vl3kmoT5glOhkCq9Aztj0NxWHD/lQYEgcki?=
 =?us-ascii?Q?anCp78k3kHCC20CCO2j5+HV6fQ12WFcJcIiuvVYHdTSwH042gClFMuiXl/r5?=
 =?us-ascii?Q?6m77VK1UbBI99ijObBI63wPpDZRGHiyh2BOOv16y+tfl2kWl+7BuipmoNaEF?=
 =?us-ascii?Q?hrI0?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd810bae-36ee-419e-4662-08d8968b2569
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2020 06:26:04.4372
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K3nhrxscNJA7IlmY7OpOkjsFk/k5pXVljIcNrKXsbYpkf4YiLIkIbgIUI8VvMF2S7qEWW3OyWkLm//cpHro8j4gx+z+9SJBTn8t0JPk3vJs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6552
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/1/20 20:17, Damien Le Moal wrote:=0A=
>> bio checks as per your comments and I'll look into this.=0A=
> I pushed in zonefs test fix for this. Please try again, it should pass no=
w.=0A=
=0A=
All the testcases are passing, thanks see v4 log.=0A=
=0A=
