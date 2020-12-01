Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3AB9C71155
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 03:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 620CD20796
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 03:50:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="aPm7wdKO";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="OjQ6BMWt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbgLADuJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Nov 2020 22:50:09 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:59384 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727593AbgLADuJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Nov 2020 22:50:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606794608; x=1638330608;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=1mfug4ugQClnQC7vnpGZZ8tBMJ3XJe+8b+j3mfaDj1E=;
  b=aPm7wdKOZcjqOiKVucXzyy1qY2xeMppBMeLjktwyzdkfNqT+afbKxzMR
   jlEoFQecizFMepncUgFtt3usFdO1uhU49JIXokug1JxtJs+4DCVyPhP/u
   o23Z2gPtZ+U/JWhCXutFzB+ChfdowZO1MUl9DU0aB/HceHuqzUcuyjysI
   xk7fvWUNQD1yDwukZA8VmFNjUnQSZyEc4EvOPTBUN9w3cfmwQqC+ox1DD
   21EAOx/B/0JBxEoO+OE5TpDDtnm7+88jpqrDtHOOzTgMXhpwSiF+6pQLR
   vDUeS9us69vjlCeLn5aA+fNUXs9cyo2xuHjiX3hnw7D5HJLNC+0sbbvgk
   A==;
IronPort-SDR: Fea4mWhTDHz3zVRZEaJtrKGV/1SidINE04Da4eN7ey6py11XK0MBAp+IRJvyWqQPERcqFb62Yt
 4KfWTuKooq0MO65ItMrgyKHnQ3mNlE+XtzU5pryXW7bJleIMpdiRo8hmcSIBuO1qIDurC03jbH
 hz1c/qfRWWOU3szJ5N5QN/5xYLuQbFtyzODcBc67Vazodt8CcgCAoLGJSStrfKK/Vq4gjgU7WF
 zn4UKDupQ1KjYSrV9VVwreLDIOAPIbzBxL6hYNRK2xMA+DZDVrGrMPw/E/n3GSr/hg81vdodcd
 x84=
X-IronPort-AV: E=Sophos;i="5.78,382,1599494400"; 
   d="scan'208";a="153812730"
Received: from mail-bn7nam10lp2109.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.109])
  by ob1.hgst.iphmx.com with ESMTP; 01 Dec 2020 11:49:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=McHTrP4J8sweovDxZZw8PDfdAtrn3UFbkUfZt2MHBLuqXP1PCIiy3/OkWKmYEBe0IAJmNrjdPT3wCCglyEgo5FWiW31AKZXX1LmD5mgUWSziaeEKFUfGK2xQj5mjZJs4PMTbyYkjer7Od8GAO0ssIKQ5ybSzEP0dnHdV/ogsqo4iEn2SPZ7QYwuK0xD564lFiwPNK5oyBNNhG1SO7V8tsh8sWR3SkmtB9IymVLlwTaeQje7CJ6wEM7cVjIqccREH8lLiAohgFwWUpxXrr1Na377DDq9GqI5SWO5O7PMcNuAH/7a8zs21CT3shn+E1THT/ZJ18fLFZGTdS71jVTOY+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XVIjm5pnySHAnn8jYJ4jfYZQo2lnMJwEjpEYwbHKEgI=;
 b=VyldksfOjvfRsE289/5JfXOc4RQvrfuWG5TvRydw09uhdGt/py7dsp6cPDcr8JGVFxp6p00d2oTsW1bKUND0Q6UVEpKzsvbsPAjKIvvSDtnN2KnioD1WtqXfS6FhoudXGUX3pYga9T/HyRIoimdl+TVHmWqGsYtAxRAFpIWvKrtzV7Qg40bS9SNSUxnPs5XtaTkAsLnXfnbMvwF6g5p82yoLQQiCBUuDcJJ9KUwLPDDc6s/+9nYuo4xbHveNMOmDMYdH5JHw2Hz1OVnumA3zSL73blEj3KaBBChUcphCfa17zXqjwcpvVPUFwvME7wdRUGgBjQWspLm/2gtr30rphQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XVIjm5pnySHAnn8jYJ4jfYZQo2lnMJwEjpEYwbHKEgI=;
 b=OjQ6BMWt2lNFhlbVRvL8cKOmOPOAVYKHhNNDsgPWXAw2GGYRlCI+5Gf1WxOJLHn+gozZKvSkOz//AjXaAZN5O1/o7NMI8gg2c0E4u+2FfgTj4llj8U39lIY+qfO2U1m+OsB8aNutQUqm4a1yRDTQKZrwMrYGkbTPzpD0KS0rb+Q=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by SJ0PR04MB7152.namprd04.prod.outlook.com (2603:10b6:a03:29f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.21; Tue, 1 Dec
 2020 03:49:01 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4%7]) with mapi id 15.20.3611.031; Tue, 1 Dec 2020
 03:49:01 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH V2 2/9] nvmet: add ZNS support for bdev-ns
Thread-Topic: [PATCH V2 2/9] nvmet: add ZNS support for bdev-ns
Thread-Index: AQHWxskIz83/zqf400uhEmx/aulqvg==
Date:   Tue, 1 Dec 2020 03:49:00 +0000
Message-ID: <BYAPR04MB49656FC8CD2E8762C734122A86F40@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20201130032909.40638-1-chaitanya.kulkarni@wdc.com>
 <20201130032909.40638-3-chaitanya.kulkarni@wdc.com>
 <SN4PR0401MB35989F591B47F3A8AD3E2AEA9BF50@SN4PR0401MB3598.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1194a703-d7be-47b7-5451-08d895ac0a32
x-ms-traffictypediagnostic: SJ0PR04MB7152:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR04MB7152D5B2C129F03951111ED286F40@SJ0PR04MB7152.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dK86bf/iESqLipFcnO4uw/z14McSa9IuMwxWqVL9N3Zktaa+I7LkdLUhIPfanXvfBJyXtAwCExkrBIjegPkLWdSHGirDAWsh3BUus02mx8UvJzozRz7mX8JedonPzNa7jnRaiumL+tNxeRBSZQ7GrDSHk6VbSfsLT3DYXV7bfMfA/Gvj7hSyG6FFlfm4uW6pQVPErqwdATHLeMEQYHo39D21HQMyP3RhJNpwNi/i8roK7NkssWA+yN/u54+V8U6RlUqB4oefA7UN54ouD31seWNLRnqQDR8RLCJKxFKP594k1bcEKB8PpAWdK1pYZx8+FgIeRl8BzcJtAab/T6p54w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(376002)(39860400002)(136003)(396003)(33656002)(66946007)(5660300002)(8676002)(8936002)(76116006)(4326008)(186003)(66476007)(83380400001)(2906002)(52536014)(66556008)(64756008)(86362001)(66446008)(71200400001)(55016002)(7696005)(54906003)(110136005)(26005)(316002)(53546011)(6506007)(4744005)(9686003)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?povUQUs/OjxGPWrfTUpELbIKdBZWTLehg+KXqzLU01ktVY1r4YHNT50YecvQ?=
 =?us-ascii?Q?gJa35oWWWHlJvbb9VJ41GlYLK4bfmVLIICzbV+m4SIS3bqVpmVJ0YdEnK4oT?=
 =?us-ascii?Q?AkdueLkBzPcgELgB0e4OMe8ipxeEL1o7vvi1ksnDxeJNWb77yQXXI8LFhQsG?=
 =?us-ascii?Q?tFkzytkRwG6l+cvE4cSKrHEJ0DTQ/qmB7RMIuNG7kZgSKrHDqfSPrf1qNDHU?=
 =?us-ascii?Q?mh/a5Z07YzexZStWxxTbUehPzSU7o2zqTzZXJCc3KJFU7ao3hDMzBwItu98Z?=
 =?us-ascii?Q?j956NoVPilHWWmgKxwRyh/xiNQuLSD7ZLJyS5vL+5bw5wh0sByriRGWDBN8L?=
 =?us-ascii?Q?a0D03i2C6KjKls3oclYhUNzno4+Z0APhWUDZx3q22Yw1uJn9eLPG7WmrDVrn?=
 =?us-ascii?Q?UxMUmEGnbOnXUiX071ulRFnFePZYnMNn/BOJqFZUtTFHmDMnKd6L5yQLEpX3?=
 =?us-ascii?Q?nGpF/GJgLMyGHWw/O7dT5uVA4/sURq+e+8Y0MAZVp+Rt20iSQ9GTDMtZt7X0?=
 =?us-ascii?Q?0mbGots3R9L2M2McmbkNhLi/w8FYNlLbY5UP80XlcTwfkliiD+kzJKr/+Nvp?=
 =?us-ascii?Q?1MtDE6QCrsbaMc7vR1ygjBm+GyjfAXgRhc3+2Oebfl/5qMPN7U3ug7lk4but?=
 =?us-ascii?Q?WocUr0VeoCTXst1cwwbnBNxlTpahhLhitop6308CWePovm5WosiWwPPIRepW?=
 =?us-ascii?Q?RfDFgvDuWRVJYXZ8OqMAafwKyGmAnz0ui8orfdMZkqTmdVivwEa6TjTJ9V3r?=
 =?us-ascii?Q?ksN/yMXdi1jsZ5tz2sWSMko5tvEaldT1t8Jee49p/vtys2A7f2KSz6/79IrQ?=
 =?us-ascii?Q?dhmhm3rUF2UlE9Rq+mNB6f3Q9PzRpv2x/gxyJm/LM2tySPwcg2rbG1NOwh3o?=
 =?us-ascii?Q?UoXmKvb/S7TVDu5Cw0Qds3g8hhKIwhPd3r5hDJ7F/hB/SOebW1dB67pfuxCp?=
 =?us-ascii?Q?HpVrlTGaUG1lEW8XuOXhLSNXilCaRjb8g7BmCby0f/c6nS0Bpkh5qDdEJGRF?=
 =?us-ascii?Q?tcsS?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1194a703-d7be-47b7-5451-08d895ac0a32
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2020 03:49:00.9979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b/iI2NkrlKtpdxKhB7puFbNp6FMFfx4pmF+XTz9VMn9Dpkx9vd02xQgiBWpKsW1BGiCZEyBUgydlASSzfM1xz135MeM3gFVXU3VJjfJX+MM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7152
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/30/20 04:29, Johannes Thumshirn wrote:=0A=
> On 30/11/2020 04:32, Chaitanya Kulkarni wrote:=0A=
>> +	ret =3D  __bio_iov_append_get_pages(bio, &from);=0A=
> Can't you just use bio_iov_iter_get_pages() here?=0A=
>=0A=
> It does have a =0A=
>=0A=
> if (WARN_ON_ONCE(is_bvec))=0A=
> 	return -EINVAL;=0A=
>=0A=
> in it but I think that can be deleted.=0A=
>=0A=
That was my initial patch but it adds an extra function call to the=0A=
=0A=
fast patch for NVMeOF. We don't need any of the generic functionality from=
=0A=
=0A=
bio_iov_iter_get_pages() anyway.=0A=
=0A=
=0A=
Why add an extra function call overhead in the hot path for each I/O ?=0A=
=0A=
