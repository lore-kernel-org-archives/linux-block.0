Return-Path: <SRS0=Mrne=CG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9CCDC433E2
	for <linux-block@archiver.kernel.org>; Fri, 28 Aug 2020 10:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 737E12078A
	for <linux-block@archiver.kernel.org>; Fri, 28 Aug 2020 10:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gG7x+/dJ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="d4VheTDK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbgH1KHS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Aug 2020 06:07:18 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:5452 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728016AbgH1KHP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Aug 2020 06:07:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1598609234; x=1630145234;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=tCJZZ1tHj3nYBqaWVLkT2715SEqYLMlE3E0T01uJdPs=;
  b=gG7x+/dJeONNDmkHuUXcN/zW07QQpOGPKAhgCleHuOfBf/FSHRVPJofs
   /0RAr0ylijjnSyOeYiWJuJgy3jeGB3ZvlAWe5fF13mygDxL1AFnfwW+fT
   kB8DS3AbsN+HgSHtFwTEm2in9gX6TBQDeSS6g6gvpPInCoOqvPeC3ydJI
   7XpOXFh3YYZ5wLa65BDUG5coRkV+U4bK+5zDPOvHMnj4qp/bvVkKELIBJ
   7hute1LEQQoa7Qammhcb214c+AJaGU+LpbrSqchrKGt78jsvB8Or+A6ex
   ZZiI/Zf78w03ToU0Jh4Dw5U2NPEmiOVMyN+asYGWAkJRUFpidA4s7BLny
   Q==;
IronPort-SDR: yNPY6jZyFfpNSS4zOMBUrmhTRql6gtivY1nqHOKKhBzjoT5EBNvHJRJsF6EdPS/Yeg3iJ8VVMS
 X297P6MjuYXEuBizcmxerGpFMH6CMYVjChjplE8TpoWZfpAuB2EWeMb8nPmMJd2wppB3GJUcMs
 rI+OVLKwzUN/jaX/SRqJYFgj+qHH8Lh9Qc/1vMLVUlWi5IvsLTv6dB/eHC66A04qGvdzq1yPjT
 aFOMKliYwGm2GwqWihac2VqmOr5fOOJ3zNnlTKIkp8bzgcBbB9P85LVcPbpKHM6IY3bc/JTI6I
 tZk=
X-IronPort-AV: E=Sophos;i="5.76,363,1592841600"; 
   d="scan'208";a="145991959"
Received: from mail-mw2nam10lp2108.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.108])
  by ob1.hgst.iphmx.com with ESMTP; 28 Aug 2020 18:06:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N6ZDwQg1r1nEfJfROV/qH4oQlj8+16yH1Ohcgjtr6ZnsMTOVVj2G7uLKecAAdiQt/kBg4Qdx4CJV1FgQ2nFj1CWXW8J/KhfSU1glFvva225GTP96oeCl0mSse6Euf4thwE36HFHi9doJYAY9dzcxP36phNRsia36L9NYK/M7L+OyAJnlJeFXHMj8pKIkV5BWERyGy3EGZcMktnCNroc6ZiI3uxu4ATFwUyjXXg8VEIaXVGYHHoMoyzDlb6rS8W4zWdp1DXPXxdbA72NMWXPtFccb2Vd85YewjCqnIc1ydUwilPDUtJRlXSAp+p7eGScgmKa6xzsAr73Agiq5CiwvBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tCJZZ1tHj3nYBqaWVLkT2715SEqYLMlE3E0T01uJdPs=;
 b=dHoG3qcDAblsm7w03BymBsZozA2ms3h0J4amS0Uwk213HKJ2oO6kX5eTZ4v6LhgTzAea3V84JYnZUbnunFdTHSjmuA8O1uPJZcCdV8xiXoTuWQCmxa+T/1n4ihAp8zrtIvKoPlp23ttvMQGCpQMG1CgTnRrFaH7jCtdMSRwoZ7PzZUucfMrgEjVf0aKNXnfLV3vIpfwHuVVt/D8mH3Qtuo+QpzUT0GDZEoxQo5d5QglNOijFUmwueHld6ExAzl4NHzkO7ujvfH5t1tS6hswlOgAwQme5x6V6NphDgI7I4x1OLt3D5iL7QNEftBA7ko0/nfl008cBW2GlumuR5NC6nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tCJZZ1tHj3nYBqaWVLkT2715SEqYLMlE3E0T01uJdPs=;
 b=d4VheTDKZPtQjtlkR8vIkRQLXIKeMwF+jesPm1mFuovc6td4W1C7CESaYbgABK8YHKNf0dPjkRiKUb8JG4oYUwyGHB/xARGmR68npOYzwnda67Ospoa0VWIuyXpNna5Nb82utZ2FjqbLBSgPdj++i5BuJsdaQCdXuuK6x/l6asA=
Received: from BN6PR04MB0724.namprd04.prod.outlook.com (2603:10b6:404:ce::23)
 by BN7PR04MB5204.namprd04.prod.outlook.com (2603:10b6:408:b::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Fri, 28 Aug
 2020 10:06:57 +0000
Received: from BN6PR04MB0724.namprd04.prod.outlook.com
 ([fe80::cd08:5da9:34ed:4ec4]) by BN6PR04MB0724.namprd04.prod.outlook.com
 ([fe80::cd08:5da9:34ed:4ec4%2]) with mapi id 15.20.3305.032; Fri, 28 Aug 2020
 10:06:57 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
CC:     Jens Axboe <axboe@kernel.dk>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] null_blk: add support for max open/active zone limit
 for zoned devices
Thread-Topic: [PATCH v2] null_blk: add support for max open/active zone limit
 for zoned devices
Thread-Index: AQHWfHkHEFD/cWRr30CMhGnYnEiy+6lNTPiA
Date:   Fri, 28 Aug 2020 10:06:57 +0000
Message-ID: <20200828100655.GA71979@localhost.localdomain>
References: <20200827135018.63644-1-niklas.cassel@wdc.com>
 <CY4PR04MB3751526DC5833902749EBE48E7520@CY4PR04MB3751.namprd04.prod.outlook.com>
In-Reply-To: <CY4PR04MB3751526DC5833902749EBE48E7520@CY4PR04MB3751.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [85.224.200.150]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 257178c7-0ac9-482e-03a3-08d84b3a1960
x-ms-traffictypediagnostic: BN7PR04MB5204:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR04MB5204599C116378AF19BB25E9F2520@BN7PR04MB5204.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V2N6JLCnFTdhNw5f8rGS4QfP1vpbeY99C1nGVgKHtWvqXTFuW293df726NGjSpiFGfPcLjjGLSUF+rkMpYiM/9CIeIGaz7HMCZgVLqqkLTpFrI9uq4yUILHsFEkmuEcHzNrlJdI9Pc7QgyHe9IOmboBADIV3zw8fiqRB078QJRlQCzBwOzXWcos18Qdaq7QzXGXFc9Lrd/vvzgg6R/jut3zRtIRivU42e+4EMQSrgnB+U+4C+EavtiIUrr7I2qCj+54CNxWUAkeIl0a5c5mbirlm2QadQsTqOFiS9533cu1frs+vTixP2QzQepbR3pyg5F+il4LJ7chLhEFHkIs6Ww==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0724.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(39860400002)(136003)(366004)(376002)(54906003)(66556008)(6862004)(64756008)(4326008)(26005)(5660300002)(66946007)(2906002)(6486002)(66476007)(91956017)(76116006)(53546011)(66446008)(6512007)(6506007)(478600001)(83380400001)(316002)(8936002)(9686003)(186003)(33656002)(8676002)(86362001)(6636002)(71200400001)(1076003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: h/AghRQq19sBHwaz7F9wblE8Pa5brdG0vxwMr1o8c5OazIpENeZjaa4AWGT1TPiDBY5dZ1yEQ49OHJYZlRylNFA+KzSukU9VEa4sWhRU68m7VAcmAtDbwzSgS/5tfZoeTOODGoKsnL8cntCJDwbF/c5uz5+5Lx048/W8nqdBc5nZjy7c7+FqmUDKt8dgq78fZfe7B9/mK1IvZ+78y/hGpAMhC9IkoNV5NmXVrJRQhJ/Pxwal4InphdqKofedQB/yE+wg4RI7YBIdYKjtRfwRBZHWVPVekJgWIm5PIxJ6ih6Jgf78gM2UfzHdhkPwwAUrKkmZVIEiwcm4H+UrxL+LhNTcW+1YFbnyu6XIkFa2kqwKQ2dBrBLN1qR3y6/Q3gbmPQ380KypV0BxvKwmAlbeXUBQf/EMeewlbg7o1Py7a5ePMcTK/zGtj+IA60HBZB7QC/MUzWamYJZvxVpUmXLqlqXdYGH3uDJZyRz+fiA0NQpbNj5tPqOL41cWaIGV228zbDBogwchNLCm7L6BXQSJQIYr8CpWAP96OaSare2lCEYQjH/8RkV2B9un0zKwNPczOoKkp4ppFBEqBce8jw2oaImrv3aR85MCjMZoLAQZ1vUcywiAdnfGQ/AO5Xpjj3kusElwYimpszrr1ekn9QwMkw==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2E471980F2C600478E566C98E3404385@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR04MB0724.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 257178c7-0ac9-482e-03a3-08d84b3a1960
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2020 10:06:57.6415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +BMPKpL5LUp04GzNbeItN7tSaR5ynWEDetDux6adzSrd7kh5VrDyhApkCMWrVKWCZcoOcFFhNzUbUROOGiAHtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR04MB5204
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Aug 28, 2020 at 07:06:26AM +0000, Damien Le Moal wrote:
> On 2020/08/27 22:50, Niklas Cassel wrote:
> > Add support for user space to set a max open zone and a max active zone
> > limit via configfs. By default, the default values are 0 =3D=3D no limi=
t.
> >=20
> > Call the block layer API functions used for exposing the configured
> > limits to sysfs.
> >=20
> > Add accounting in null_blk_zoned so that these new limits are respected=
.
> > Performing an operating that would exceed these limits results in a
>=20
> Performing a write operation that would result in exceeding these...
>=20
> > standard I/O error.
> >=20

It is not only a write operation, also e.g. open zone operation.
However I will s/Performing an operating/Performing an operation/

> > +/*
> > + * This function matches the manage open zone resources function in th=
e ZBC standard,
> > + * with the addition of max active zones support (added in the ZNS sta=
ndard).
> > + *
> > + * The function determines if a zone can transition to implicit open o=
r explicit open,
> > + * while maintaining the max open zone (and max active zone) limit(s).=
 It may close an
> > + * implicit open zone in order to make additional zone resources avail=
able.
> > + *
> > + * ZBC states that an implicit open zone shall be closed only if there=
 is not
> > + * room within the open limit. However, with the addition of an active=
 limit,
> > + * it is not certain that closing an implicit open zone will allow a n=
ew zone
> > + * to be opened, since we might already be at the active limit capacit=
y.
> > + */
> > +static bool null_manage_zone_resources(struct nullb_device *dev, struc=
t blk_zone *zone)
>=20
> I still do not like the name. Since this return a bool, what about
> null_has_zone_resources() ?

I also don't like the name :)

However, since the ZBC spec, in the descriptions of "Write operation, Finis=
h
operation, and Open operation", says that the "manage open zone resources"
function must be called before each of these operations are performed,
and that there is a section that defines how the "manage open zone resource=
s"
is defined, I was thinking that having a similar name would be of value.

And I agree that it is weird that it returns a bool, but that is how it is
defined in the standard.

Perhaps it should have exactly the same name as the standard, i.e.
null_manage_open_zone_resources() ?

However, if you don't think that there is any point of trying to have
a similar name to the function in ZBC, then I will happily rename it :)


Kind regards,
Niklas=
