Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E96C07E99
	for <linux-block@archiver.kernel.org>; Mon,  5 Jul 2021 11:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06798613D8
	for <linux-block@archiver.kernel.org>; Mon,  5 Jul 2021 11:27:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbhGEL3h (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 5 Jul 2021 07:29:37 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:52599 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbhGEL3h (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Jul 2021 07:29:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1625484419; x=1657020419;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=c3lQ8j6nNTlDdeqHpquvIS0nWk1GuLRVt9VursybDV0=;
  b=Q0CKfjtoLTmwZw3rmK90xhw/NMid0e+V8tJIr2fEzwgscRKHGTqY8gcF
   9h/ogPtHzQrDNebd7gpY4MKEkBshQgFqwFxn8fV1v0mnhOtEfPR7qdCxR
   XTb0jqJIXpEwE7uTyVStb6rSuvcYxTLHP3dXNXkYxTgYeWMvdEPG2vjgI
   fb0LRK/Q61Aa68nxuHjMQL/UeKyUne/37TWL25vxJv1RuO6bNUATAfDHA
   3FB+3+c2OSp1BbD8iL8exvD5n+N85rdE3a5nYtsZpWbub5cpDhT8f6kka
   Ag4vNoTSbduypTp+uxLrWMUwLq/mgfW8WnqwXC84xWvYFLO/LPZAspMtH
   Q==;
IronPort-SDR: n1LOQip4dBypxwGW5BdHUgC+bcSri2icY4HYruPdWmjfLatGufKiYs4GUpEe3TGjWgkJ8JzLh5
 Yv+8JjO/WGQhrmro1I3rn1R2jnoKiawCagXnk3ZMNcQwbSVk3mJaIyNWiwdIOdUIpLMVonJQ2s
 emlcC3gnTQwoKCxj+Jeor+f7W8g2T6DOyMbakwGdLJNHwQoutFnC39KubsqRUgoIuqZcepLO0Y
 tz2Vrnp/fx7wmzxUuCVGv85fvGZAExScNPM1aMPAjuTdJMEuYuLvSoudv/gCllJyLIOUhkkuXo
 570=
X-IronPort-AV: E=Sophos;i="5.83,325,1616428800"; 
   d="scan'208";a="173729532"
Received: from mail-mw2nam12lp2049.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.49])
  by ob1.hgst.iphmx.com with ESMTP; 05 Jul 2021 19:26:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gBlgNy/7BochTxkIoNfoTAti8pqTZZjHi20LYh2LiPQ7j7HL7mAH1aVkKIQ7nZRwPV07qnpCZx7r2C/UtxdoQXoVhZASkD/nHDdVpmrnFCG7JdCA/Zb4lR7o4qQnkjvhO5rRhbDWhWgXoGwGhE4aADJUb4W4ZP3cjh42E35ZAxS8yjA5wrB6M3G0p1/I/qTEQqvZqDGVsq7fgsiA9rzHZAblm85LvPsXpSqTNhoFhmVdqqWxC+jEEaN/hsMlhU5SYlWLrGMHpGEREREjtI7XXTrTVpWe4pkrn/yB8ovIxmKRT055gXh9nYcno4x4q6In+5OTb4lf53KsljfGB6BAvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZjmJGcXDaeaTiDH3PlcBMSSgBf81jnv1CgTYfRx7Ezk=;
 b=iiBUJLGqsN5+LIazJXrups1C4ZcalQyq+9lD0C8Yh2+P7FNzBiKvGWX4oWxi9HHr47MFT2sHWDUPP/N1VNpxYYLqnas+B6pJc9dMMeTm4uMdb/9yyeLogLuS6y068P5f5umYGTf0aULcrLom5n53Qha/qeZkpqpzIOUCaRzbJ4D9IgQvqLKK/rG27JTirWyYxaPaKMblwTvehmRZyfirLMPjYl9rSiBm/FtP8IryK1jDZ52JPGBb80HYwWnyTVSTr/Y330Pb3200k/rJ/zr6yObMoz2mJDgSXFy7+9uALe5LwhGCTiplhJh7zkXJTSzni5kKVMzykoZ57b2qLye7LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZjmJGcXDaeaTiDH3PlcBMSSgBf81jnv1CgTYfRx7Ezk=;
 b=hh+y/m09qcBYYxWYlkW8o/kcG6ThmsGHGCNhJLkBJsQ5AbBPIh/YKqimA2P4LpXe0nyyplDCEVcVaOeEunKVHyE3VIpQaCr00Q4VPWMOF5U7Axx5Eyn/8XfLy1MCUJSqkE/2eaHrRMXH5Z3IgQziR6bSdzL3LxyWttw3ZK2qJqc=
Received: from PH0PR04MB7158.namprd04.prod.outlook.com (2603:10b6:510:8::18)
 by PH0PR04MB7206.namprd04.prod.outlook.com (2603:10b6:510:1b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Mon, 5 Jul
 2021 11:26:57 +0000
Received: from PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::e88b:8b03:d4cf:fdec]) by PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::e88b:8b03:d4cf:fdec%5]) with mapi id 15.20.4287.033; Mon, 5 Jul 2021
 11:26:57 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, Jens Axboe <axboe@fb.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/2] allow blk-zoned ioctls without CAP_SYS_ADMIN
Thread-Topic: [PATCH v3 0/2] allow blk-zoned ioctls without CAP_SYS_ADMIN
Thread-Index: AQHXYRgPtP8+uBs1gU68gsGoV+YyFqspGeKAgAtFQAA=
Date:   Mon, 5 Jul 2021 11:26:57 +0000
Message-ID: <YOLsgFzIBlg/H/ba@x1-carbon.lan>
References: <20210614122303.154378-1-Niklas.Cassel@wdc.com>
 <YNl4LXUKOftl15M9@x1-carbon.lan>
In-Reply-To: <YNl4LXUKOftl15M9@x1-carbon.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [85.226.244.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b45d7716-6228-4483-bc7d-08d93fa7ccc4
x-ms-traffictypediagnostic: PH0PR04MB7206:
x-microsoft-antispam-prvs: <PH0PR04MB720624512060AB0712A290CCF21C9@PH0PR04MB7206.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WTbhErMee/PxPT+pYA00ivJiph5/C6cGEWYOpFG1ExP5meihwDYzAhNi0LPFhM+8tV30mnrE2+UVyqK4B6/kDUJd8Buh8E3eir9Flpt2gn2aw1UBsf7JF7k02gHbG4VsmGUr+Yp/tUkXNz/sssTpkbrRgpgkWf/2ZP0ne7Q/4UQc1Usxi0YAdxBvDpN9XVXWSB8xHiLIpjxEgZ2NnVIGsdc0RhIAIuUWiLyh5KKrAv+rVOiQgBfbNb9/WKmlhUjtebr3uiTZvS64zem/Q0EccHGb1VMEdXMBOikxad2su24sdAORAhBCsMRmiIkhqDvEPtGSkpOpsA1nIDRhXjuChJ8TjJmlYeVTdexl6lHUsYvU3mOaTm8ejp011r7DyOZcu5boIYWCugIxlRqPkaJaMmbJOMwbPSkZrh4V0APSH74w0cd1BUNpIHaQvUw2YipaAsKErWjpCsCo3DAOT0By+mz4c+GHGaUc8d9qVFD+7fE0Cvadiv9kRiUeLzFqmGBnHG2ugFpitFbKKvENa7ex0DTAw2SK/IIkOcf/ajGZ3UwzPqp5wf2ee2MxNWMM4j5huo2ETq+jobXi3gMx78+nPtSm8Kq6mvlgDH8McBHIoTnjJeYHrIe+c1JZi6KnjnRJjqhfwY36CC+F3AaSdB/YYQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7158.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(39860400002)(396003)(346002)(136003)(478600001)(110136005)(316002)(54906003)(2906002)(66556008)(64756008)(66476007)(66446008)(76116006)(6486002)(83380400001)(91956017)(71200400001)(4326008)(66946007)(8936002)(5660300002)(9686003)(8676002)(186003)(122000001)(38100700002)(36756003)(26005)(6506007)(86362001)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?W4TdHC4f8PiZZse0F/sE+llXz5ZcWIVc5wFZwZXfR3bgQsDs4ecZt/n0xrEX?=
 =?us-ascii?Q?0p43GvJ0JPVVjOrR0n074nTHK0IPYcJPW34wK81Lw9kKl2GfBayhxayPagsi?=
 =?us-ascii?Q?4pIvw3xLbHlGMyrfUKhO3q4+VMHQOUF/LhMzymeTzjDoTYWhSBS/29lEOwME?=
 =?us-ascii?Q?iwZja4VE77CAuonO38xMk6uupB8r0QM1FXSr1uuyuf6S6uVjkkHlfhs1BEBc?=
 =?us-ascii?Q?nR2Nf1jpBOiinYxyraifGW3p0CjfGY+zMHHiLCnN+3x2cWyuvYkRrhH54rQQ?=
 =?us-ascii?Q?tb3UC9akenkOlrTuagZ4x0YAx60bIPbH7nY208dxokqCv9v8Tl3vUr+EJM5W?=
 =?us-ascii?Q?0gAz1GS+JYyii51e/wzY2guWBftEi6BIHbtcBNHMjjT/t8meYDYH5+fDmzbB?=
 =?us-ascii?Q?M4qh0lNJrvAs0uGHL0hIt+Akmpw4t+nw8IY7uvDtlV5JFq7rh5/JSBibONtu?=
 =?us-ascii?Q?AivlIVEx+jiD/X0sQlfgmLlOcaFe6307SAUBHlV8whMT8jVsDDP3XwV3pGUE?=
 =?us-ascii?Q?5fnRkw7NWmpGl/rFLf9MU/7Ms6ivn3icc5z6rfWC1LKueB21Zv/tWCa7cORz?=
 =?us-ascii?Q?WiN5KNZAaD/jTI7dzVyANl/S+3/V61wL8KsgPUqJ9voAWRMrzsysbzfQzXvX?=
 =?us-ascii?Q?OUC7proud3GiqEs/Tp9LxZMqwPJqSHhmBVKAG6ijYD+/WnMZL6PoX0Ht2yL2?=
 =?us-ascii?Q?txHHCUrRsQjhvI6ECbzAV0a0xYwUMrn0yAnWuVd4phhiasfSQKqYcxWXcJ8O?=
 =?us-ascii?Q?FbC+wUuCK/1EJobg8ECO0YGiB9J0R+6Thrwz/tDoADdXfS+vgjImWhTE0NIc?=
 =?us-ascii?Q?Ysu3YMpZS5nCGcbpcoy31RYQMvZtwIYOrpxQ/TuKepp+TcL2CVB5waeqiFup?=
 =?us-ascii?Q?sandD5LTFDIRMpUf6TIoNokw4M9VZXBV/4mvm2xtu317V39PcFZ/s8y4y1oP?=
 =?us-ascii?Q?ktsZLG48P6oZ0ELBTOHTAffaCc3qY1mM9juq0p+eNUTWaEjtUcAM4ephmBHX?=
 =?us-ascii?Q?RxGmFvZcZi64HcTH2R4mYrdIRzHRwHdvBF7Hv0laD/EPdJzmR5T1U4W6juxX?=
 =?us-ascii?Q?UYl7xmKJUz2qfyY3kiOxSbuuygpjUOpsQkPBnor0rctMl4JbRGKaLlcUz/Ss?=
 =?us-ascii?Q?T9rV6gQNGuvIZ+LQjPOsUzt3bnZ6bfhqGq7xqGn26FaO2hZ+VhA/ZoYxh8vl?=
 =?us-ascii?Q?39+CRF/23kmo62NrJ+DzgW1ko6qfJaViloUam2iX9QHLx1fGppWbd6EWnPir?=
 =?us-ascii?Q?DcY7T2daKzZ1Adz9mOGlLEgNFdgRWhW0jCVt6EYUyAGjUqJO9IP/nZgyVc62?=
 =?us-ascii?Q?AcP2cuv0DAX1xsiAgBKfPQEl?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C26826195C8A354FB35F3132B649D0D5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7158.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b45d7716-6228-4483-bc7d-08d93fa7ccc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2021 11:26:57.6193
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ++tTNESfz59NV+ZUya6E+TYeCvO56RDW2v0zSjjstWqmo78niWvQZwT0m5VHJB58rLaF7+ltmIZ4WZzc3EXYUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7206
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 28, 2021 at 09:20:15AM +0200, Niklas Cassel wrote:
> On Mon, Jun 14, 2021 at 12:23:19PM +0000, Niklas Cassel wrote:
> > From: Niklas Cassel <niklas.cassel@wdc.com>
> >=20
> > Allow the following blk-zoned ioctls: BLKREPORTZONE, BLKRESETZONE,
> > BLKOPENZONE, BLKCLOSEZONE, and BLKFINISHZONE to be performed without
> > CAP_SYS_ADMIN.
> >=20
> > Neither read() nor write() requires CAP_SYS_ADMIN, and considering
> > the close relationship between read()/write() and these ioctls, there
> > is no reason to require CAP_SYS_ADMIN for these ioctls either.
> >=20
> > Changes since v2:
> > -Drop the FMODE_READ check from patch 2/2.
> > Right now it is possible to open() the device with O_WRONLY
> > and get the zone report from that fd. Therefore adding a
> > FMODE_READ check on BLKREPORTZONE would break existing applications.
> > Instead, just remove the existing CAP_SYS_ADMIN check.
> >=20
> >=20
> > Niklas Cassel (2):
> >   blk-zoned: allow zone management send operations without CAP_SYS_ADMI=
N
> >   blk-zoned: allow BLKREPORTZONE without CAP_SYS_ADMIN
> >=20
> >  block/blk-zoned.c | 6 ------
> >  1 file changed, 6 deletions(-)
> >=20
> > --=20
> > 2.31.1
>=20
> Hello Jens,
>=20
>=20
> A gentle ping on this series.
>=20
> I think it has sufficient Reviewed-by tags by now.
>=20
>=20
> Kind regards,
> Niklas

Hello again Jens,


any chance of this series being picked up?


Kind regards,
Niklas=
