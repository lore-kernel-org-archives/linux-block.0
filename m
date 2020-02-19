Return-Path: <SRS0=ya0H=4H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A22C34031
	for <linux-block@archiver.kernel.org>; Wed, 19 Feb 2020 02:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F4DA207FD
	for <linux-block@archiver.kernel.org>; Wed, 19 Feb 2020 02:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fvVdWSQ/";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="c6Cl9J1I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgBSCNY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Feb 2020 21:13:24 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:44364 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbgBSCNY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Feb 2020 21:13:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582078404; x=1613614404;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=1ZgHwzWvXOsy7CJI0bZ7BcHRut4duvQEGQMeJZd+3bg=;
  b=fvVdWSQ/XVRgrixzUULBsaJYhD4suJb/TrJEovYHgiiud/EOqmC3lX1e
   KzRcYHFUPtGAH091F9x8+EJ+l8JGZiVHNc9MvT+xJbMrMun7/oQkY9Lfm
   Ui35XgQ0W/9+DeynDLmHdUn5dWqZiG9U5YvGWdgaD9GPZtyjsKF1xogj3
   UegvDDH6y5/d1yqZ/HPp08bqntPuUlqdRj/zNGr1MPnGnVgP4OXyye7GZ
   CJlLseQtt8N3t66rSHRHHT9ZQ7u8wyY7QKeQIOoY2KqE7VUkGfeZkDHRw
   dvG44ilM5uaWxbLJBU+Zg2MH8cdCRmgKl5QlUgkx71sOnJMOxOiUcMQhn
   Q==;
IronPort-SDR: 8TZvO/t+0qiEKhaoRUDutVzWjcH/lq41e8A0E0EyqtHliUogTdLtT3JvbslVSbaS6kKhfsJHv4
 q6pvwNJcXgXBbNeoTgCgL0rLnkua33rzS1UEVSf8brB0RYGaurr8GJhoEG1kZNvZpegNqiCQh0
 13wCprF/a2YGFdvYcZg6NIqF/I1zZrQ5lTMdYqZdTVDyCAfamjmyABlRj6aHgVoZD7IgUsFa85
 awxwMPmEaIPepqKK5nPJ+diRZZYGq+91QTY8oTOpqdvryDNx6VFEzCX9uOAHP8Ad3QKucf7+a9
 ziU=
X-IronPort-AV: E=Sophos;i="5.70,458,1574092800"; 
   d="scan'208";a="131588415"
Received: from mail-dm6nam11lp2169.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.169])
  by ob1.hgst.iphmx.com with ESMTP; 19 Feb 2020 10:13:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gpxgGDkvG0FymT5ayaZ9JJVZGR5fTYYMDPB5Zo8Wr4ca2FJcxD4IplH0cf5/+VxmJM2eA2L6dgPyHSiZT/RENlSv27rVFz5dOuk0M/tJ0X8/3WQVasQndvHBFCTk9CEd+OyM/O9jgx49JbDXEZPkq/KGc9itCInTQoSstgxSBtStsWQYAPNo2G9fmbLZMy7FyiIAlUbg+oEEFCZ3RwWhk3N8m0uixeN6rExsRo7VcCK3iS4gD2CEvC8LnjpyeeLCq8M2bBXyr1vCkj9eFeKrcfEKeSnjgyBrwYu3Rw1Y035RgseP+8p4O+vNdthEDYhpWLB6wHY/ADlE5Fgwi4uu6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ZgHwzWvXOsy7CJI0bZ7BcHRut4duvQEGQMeJZd+3bg=;
 b=N2kCm1kTVXbqskD8dYJYq4n4qS6syP67OlMNcDsES4AGaa7ncVrOcPydmBM+sRe5C4mVzmoNe9Z/iIsLH/qjES+Zh6kRTGHh+XNq+oCvcHbp0QigsxpiBbyvbmS167GzsYInv9QHMftv2IREjjI27MoyTQBJhSh1bxyHqQ6IKbwgMjXViZKiUH+HJLHzjnn9ci+SZ5pN/kuN0kaL/750Vyl+gIF0C9v3hm948qBLACMImHtn8yo4UxQvLQokTBW7nMpHZM7RseYefHBGWo3wmVb7ALW8mnz0nFeT50jduHoOByGYWhSn9/ps35smcYhZ3eJhYp6jO0RR5e/dI3sbgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ZgHwzWvXOsy7CJI0bZ7BcHRut4duvQEGQMeJZd+3bg=;
 b=c6Cl9J1IJecqR/IzOc+hEVMqX4OwdmKn5LCkxuMqX+ttN5XWAKV0KxYS+rWiB9Dd5AamJWHYnoV8AZBbPlVlajGES61B9kbNlRM3FwuMx9Op3gUAG4KuWUEkx4wR2vt+vlgkyifvR9SdphJOeXuqjKHylmCfoV9gpcYBIuP0bkg=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB3879.namprd04.prod.outlook.com (52.135.214.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.31; Wed, 19 Feb 2020 02:13:22 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fdf8:bd6f:b33d:c2df]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fdf8:bd6f:b33d:c2df%3]) with mapi id 15.20.2750.016; Wed, 19 Feb 2020
 02:13:21 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH V2 0/3] null_blk: add tracnepoints for zoned mode
Thread-Topic: [PATCH V2 0/3] null_blk: add tracnepoints for zoned mode
Thread-Index: AQHV5oDlsjqP0gJg0kWUTukh7pHHxQ==
Date:   Wed, 19 Feb 2020 02:13:21 +0000
Message-ID: <BYAPR04MB5749E7BB18E784DA5B0E5F4086100@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20200218172840.4097-1-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b38490c8-3924-4814-d636-08d7b4e14ae8
x-ms-traffictypediagnostic: BYAPR04MB3879:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB3879D5A07356EC9C38B87BEC86100@BYAPR04MB3879.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0318501FAE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(376002)(39860400002)(396003)(136003)(346002)(199004)(189003)(64756008)(81156014)(33656002)(81166006)(66446008)(8676002)(52536014)(76116006)(66946007)(66556008)(8936002)(66476007)(5660300002)(26005)(186003)(2906002)(478600001)(4744005)(110136005)(71200400001)(7696005)(9686003)(4326008)(6506007)(86362001)(53546011)(55016002)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB3879;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a7AMoLWerGMsng6iR6ALjO7l780d+QnOCjeKHoPpDnwzIBXcF2+g0NoTwduqfKh6baHPPALfqhjjYyPxE/8cqgr+jCg7giP2+p8mzhNSIT32t1QPQkg752u28vxNp+zBRKwwW106GStYowEgSZP6/2oPvuDiityzmgmBYZ3ErsZiazjcwpEm/N65/LVVcRxUa/rZ0YE9jK12ramchUWizEY6ip4yHkqqWsecNwO6/HvBw+YmBQGyYlMXUDm3POMzC+R8ObINbqckO0kN2CPPxzRXSDEoIa7qse7UcyMc+cdLyAnkGtladlX7aq8kb5pZXemQYecoCCMINRgtAAKXmtAMZSxRp3aNr0HQDl3caZhOfFMhhCl8aLmEZ9XKJlJaYkytfPrRpzy388rJbeo5tkL5n/+4tayW7+1eQY7T9352F1s+wwpwbXSJibPi14Cs
x-ms-exchange-antispam-messagedata: LUtC72K2LuSfKJgybhn+PPqquseiL6up/CY0/EOQq/a1LUHn8m9p0P1ar1I+w48kV27P5ksERvXs6XH0mLpuztFaKOeb6Co0JbTz/qXhe+sAfwFnaW3gQFsdaVPRFEdbk9e/g7kOofTYZvLhqVPEAA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b38490c8-3924-4814-d636-08d7b4e14ae8
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2020 02:13:21.2129
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K53i5gHQWZ94OVjM7nwKT7gmE0PxU9wHj29Jq8Ae3s0P3I2Uer4xVUvxs8SrIAaZyGxlHwUHl3qb2BKRHHfkrKvOMJj+/55FzobV363u/Uc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3879
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jens please ignore this, I'll send a new one.=0A=
=0A=
On 02/18/2020 09:28 AM, Chaitanya Kulkarni wrote:=0A=
> Hi,=0A=
>=0A=
> Recently we've added several new operations for zoned block devices=0A=
> blk-zone.c ZBD). These operations have a direct effect on the=0A=
> zone-state machine present in the null_blk_zoned.c.=0A=
>=0A=
> This will allow us to add new testcases in blktests in order to verify=0A=
> the correct operations on the driver side.=0A=
>=0A=
> This is a small patch series which adds tracepoints for the null_blk=0A=
> block driver when configured in a zoned mode (with command line=0A=
> parameter zoned=3D1).=0A=
>=0A=
> The first patch is a prep patch that adds a helper to stringify zone=0A=
> conditions which we use in the trace, the second patch adds new=0A=
> tracepoint definitions and the third patch allows null_blk_zoned to=0A=
> trace operations.=0A=
>=0A=
> Please have a look at the end for sample output.=0A=
>=0A=
> The change-log is present in the respective patches.=0A=
>=0A=
> Regards,=0A=
> Chaitanya=0A=
=0A=
