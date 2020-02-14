Return-Path: <SRS0=urI+=4C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9429DC352A3
	for <linux-block@archiver.kernel.org>; Fri, 14 Feb 2020 00:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AA4E2168B
	for <linux-block@archiver.kernel.org>; Fri, 14 Feb 2020 00:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OLTD98DP";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Rj1GV6+X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbgBNA6w (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Feb 2020 19:58:52 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:60871 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727604AbgBNA6w (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Feb 2020 19:58:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581641932; x=1613177932;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Cq640l6gseggOC9R5IjJ+DRKcn6oBDNglO47WWEoQz4=;
  b=OLTD98DPxYBoI9Vy0uIepm8Ewd2IcOpuuWhCKDZzQQxZYHIf0QRLXaRf
   4XpBGtNZEh4sKXApORmSJTz8pvclgAyWaoDtXrvse3T6qsc8kDjj/QAn1
   vKTu1mQl4TB8WoRIsNA66ij/56bVD2joMC513tglWtGVRS13WZ3LAmsjU
   FhWcJosjlKoSe+4WNBcn2uFrPNtI6EqfzpP463jvoYdwLWuM1k/sEn6qV
   pqMFCL2HNV8KGBbvcANJsr/5UAcZmxGkhawAsh1TqnhJb2vlp6wXs2z5K
   RT6xYXKF3rKeY12Dgf4k9nDONvL1VaoliCpvGQD6hbAE934XKAxLCswEz
   Q==;
IronPort-SDR: BoB/qT8g1vQIWa+2+Tco7JytLYcvwYPc3JDmbEjOskMn0prRBvw+Ju9gS5nQJer2xn69AFLTFN
 pjXs69KjdgVw8ZEFtL6XGMRG6BOM79K9izKj1Zs5kBzcO64Tqkms3bLFxQCy9CUweIG3mWopd4
 tIs8vlalB2LbJ1mLZLV1LfLnYg1n7I/5bojZa/PFR5Yr+opa/yTs0HCko1MrTPYjpJHdt5J0FH
 Ws1a6De9xrE9ypAmM1RxhSXfXD83GveoLDEVabNJRfmP/oNDmZhkfg0Mh4dZ2KFw3l7hClnloF
 z3g=
X-IronPort-AV: E=Sophos;i="5.70,438,1574092800"; 
   d="scan'208";a="131268686"
Received: from mail-dm6nam12lp2170.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.170])
  by ob1.hgst.iphmx.com with ESMTP; 14 Feb 2020 08:58:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WslNQj1+kQWAOBPKRSQiLthmeBlDlfJzJqqvS0mzKdtzia1bMME5LJrIZ9AeFEb6T4Y2s7Z9XyInUqbRxzL2IUgHTiSqjgm5m76JfbwocVQt4x09vx3BsRAE0BgGZQp6vZJMcnwEFSulqVGCINbg+gktCgvUMN08KRWQ+Se8dqDQFnZbsz9gFUd0G/CJZWYGeU9vXgSvGh5uphXeZWKtVyXB6ZkmTfG91vrBEMFIQ9F7xm+Qb7SvG41l53YjPWXmIhmKJX4z7/OCS4IAWspIcJoTXArU42pV0u9czaORXHz3RSsqOiR53fMW/xK6f7mdyQp/qfAaBx1y+089sKWvUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oTeByc2hZuIwKjgVFF+/Z/RbyXk2PzLEB57NQ0QCwd8=;
 b=SUiFsWbj2/N5jybIaJpDw503RpBagJ8/3P4mjQNACsZOfsVLhNUx/RMUAzsmdfWDui8pOCoT5Q1BZYMKqh8+rsakqjEBnP4yAbJqooNJrurTqUJux1IxHBo+CMiDhWPxRfyfKlMkEsMhUlVPGERo/9CFwMuO4lbWdphRe+WPbGdAGZQbeJaoM6Isa1Q+FoLOOrojdE7ZwTmd1RQIXHo7H7mHUPV3E1dEu43uVVUWoA2p/CtG3wJYZv56Z/LznpuyGgoaYH7+REx+NO2YKj2bmXz4KD6H8ipgYDjBNn9Gb421Mb85YAm9pHfo+iYB6HmVyeliwmWwvKqrTgHsnOQzHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oTeByc2hZuIwKjgVFF+/Z/RbyXk2PzLEB57NQ0QCwd8=;
 b=Rj1GV6+XcXvI3FL32dwq23kz2fMflaCWEMnpCTX7kwy8Q6FqVgp4A2ZzsFngMcn3KdjWh6enitoYwJlB7iTQoBbI4RSdInkjEyD2I/qPw/QEkxRMnQ/tb5LW6lFA3xrWRgC4nfMSjSkDjP3VZgIqtM+qxO8TsaERSVCK8V8cu9w=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB4728.namprd04.prod.outlook.com (52.135.239.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Fri, 14 Feb 2020 00:58:50 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::a8ea:4ba9:cb57:e90f]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::a8ea:4ba9:cb57:e90f%5]) with mapi id 15.20.2707.031; Fri, 14 Feb 2020
 00:58:49 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Omar Sandoval <osandov@osandov.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 3/5 blktests] nvme: allow target subsys set model
Thread-Topic: [PATCH 3/5 blktests] nvme: allow target subsys set model
Thread-Index: AQHV1vv4m7siuAMmZkO3eWJXbxBdSQ==
Date:   Fri, 14 Feb 2020 00:58:49 +0000
Message-ID: <BYAPR04MB57492F13DD0220006679DB7886150@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20200129232921.11771-1-chaitanya.kulkarni@wdc.com>
 <20200129232921.11771-4-chaitanya.kulkarni@wdc.com>
 <20200211220003.GD100751@vader>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2aa91952-caeb-4ec6-ef79-08d7b0e90daa
x-ms-traffictypediagnostic: BYAPR04MB4728:
x-microsoft-antispam-prvs: <BYAPR04MB4728B540B7DCEA2FADDF026786150@BYAPR04MB4728.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 03137AC81E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(136003)(396003)(39860400002)(366004)(346002)(199004)(189003)(76116006)(66476007)(26005)(66946007)(8936002)(66556008)(7696005)(66446008)(6506007)(64756008)(186003)(2906002)(53546011)(86362001)(316002)(8676002)(478600001)(52536014)(4744005)(54906003)(71200400001)(6916009)(4326008)(55016002)(81156014)(5660300002)(81166006)(33656002)(9686003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4728;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IMpIwXwZzqTVHQvxaADtAhVWFxDzP5Ee+Munu0dCsk9+28Ovk1jesTmAxW10Hpi1KSWZeruY0MkMHjJIYnAxyd0/EQSsfV46CRXXX5D92xQWOpmzAo42dOz/Wb794bieTFiw6RDmHWTCsdIihqfM3icemrUTc8E4f9ZBVZIxBVFworjA47vgMHXQv60LSmS7ZR+Tj5PVrvnmExKCpQ9Dk8obEz4WAWLOJiWC3RjjXqEYtS1HX4pMkqcXiUFr3SAEaaim+sNbRO7DIptgXiwM5lgvHghwnXDODlAsBiDPhxcgcmemOMyqrJ3GeICW84leaa6truBNU2/y4luWNuxC95vnHSseTDyaiLzYJGz2nPqmIeB3Ll8CnfhDy2ZUlUOfWuRhxzUTNyPj/vDqgOj3DjiYADE9fA7X0T3K5nTA42QWX9s9muTKiYXKfTQ29m2y
x-ms-exchange-antispam-messagedata: jdJW56ZXpEe6sz8KN78OV3RgfNzAgm2+bRxegnqIXR4Pa3qoImnpMwhPO53V75rcuxUGDcZRcUCD5S4B2SMxiam4qVKxKy6nBqY+6molnYRuMaspuYHj0Mfk9meIjDOgnr6+xoOa/qpRA04UFLZffQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aa91952-caeb-4ec6-ef79-08d7b0e90daa
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2020 00:58:49.7800
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZvA1nOfwv+xSJODzDaZWLO8lrtUceP6zRA8hAK7Em1sLDXVAaOC7lMzm3+eNWQuEUJ1XqtRwngWfQn8aanu4n/e90KMa25w2CpQYAY567M0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4728
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 02/11/2020 02:00 PM, Omar Sandoval wrote:=0A=
>>=0A=
>> >  	mkdir -p "${cfs_path}"=0A=
>> >@@ -133,6 +134,9 @@ _create_nvmet_subsystem() {=0A=
>> >  		echo ${cntlid_min} > ${cfs_path}/attr_cntlid_min=0A=
>> >  		echo ${cntlid_max} > ${cfs_path}/attr_cntlid_max=0A=
>> >  	fi=0A=
> It's not in the git diff context, but the line above is=0A=
>=0A=
> 	if [ $# -eq 5 ] && [ -f ${cfs_path}/attr_cntlid_min ]; then=0A=
>=0A=
> So if we pass 6 arguments, the cntlid arguments are ignored? These=0A=
> checks should probably be -ge=0A=
>=0A=
=0A=
Yes, -eq forces caller to test cntlid exclusive (without model),=0A=
that was the intent here to either test cntlid or model. In this=0A=
way caller can pass 0 or "" and that will be ignored. with -ge=0A=
then caller has to pass meaningful value and set it properly.=0A=
=0A=
Do we still want to make it to -ge ?=0A=
