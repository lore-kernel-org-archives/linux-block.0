Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBCBC47097
	for <linux-block@archiver.kernel.org>; Thu,  3 Jun 2021 12:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85437613E6
	for <linux-block@archiver.kernel.org>; Thu,  3 Jun 2021 12:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbhFCMBo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Jun 2021 08:01:44 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:32537 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbhFCMBn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Jun 2021 08:01:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1622721598; x=1654257598;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=aA7MzJS89CXdR7S2zT+WDxaJrxsnLrxhQGqCFumOq0E=;
  b=FwcsT4dm5CSBVv9EqO47X3dJOL/CpWmjpllv7gosM2GDiCQh22ij1+nA
   tdC3r4YMCF+idI8l9O7M9fXjVbyOM7Gxd93nirXeORSxT/+1LjszVYd4C
   XOQQMakbxHMw6S232UHNEvvXTwtG2K8WloxnJiFLAzK2aVwGH/cbIyn01
   lQRh9kYSaehrCeZAdvcuk2P5LW7YfMuwZXzT/1IlS7sMgn3qfryjy5T/o
   4NMCo3hGDqzb9njy/Weh1D7PYi0kdxTdX8fhZGvnNrbn9CcfeQUgrNXdO
   pq1VKor0Ia/JC5itOFNKCiOYVNz6GUoWfK776xnv+QuDGYQWXazRaU9hn
   w==;
IronPort-SDR: iAWUoYi/cPNikzvVoxL6cy441Bq+jISv8D5DCAq3oIcRCwqKU4FFm95Bc6zmKTPl3Qfpa9pcuf
 PKKAh3buVrG5pCoJHVXSYCWcBu/m7O26j04RTFmn1/I2FBrKPm7C/iKcG+EspghW4Ix1QkqSwB
 +ds9axfC7N9BZsErKD1QupqX4Wr9H1C361djdq2D05lk5zisEKxCvFAI4jymarSmx7u8Boxy8Q
 3yUef1TpY0i22t8T4pN7BF4W6EdbwXq3FCE6JDDqfIu/TFESjsA6+D6NqWtBkxWojAzxZI3qZW
 dKQ=
X-IronPort-AV: E=Sophos;i="5.83,244,1616428800"; 
   d="scan'208";a="175305256"
Received: from mail-bn8nam11lp2175.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.175])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jun 2021 19:59:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CX/ZdiGaNbsN6HHcAdcZ7GbZXuq69BIMj+wKQiET6NCqtE+8td0ZmFoXI3zaGXwLs/rwzBB5RDeTDboRPzwcH3kELHOJ5cYilcaEQ0IH1SQstZrPSqZ5K8yQ1QUrNjqwtsj2lM58L93xwY1kT6giV1EKq8NMG5O2de+oFkpnCD5cElvFoQ9cQeXYm6ao3RCPOnZ4IWjzq3CHXDuK/VwrQmqElHFYnd9uiEHcDl8bvOMZmhFoRklHgNb1Bu2eCvWlpDOC+eOvnl9x9Yi6RQ7KcGDNRcOCMU2V7ZBoyyCofEkghHx7/oGMkzk7Ec5vDA1/daOMYr+TZECM9n9pQxkC6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aA7MzJS89CXdR7S2zT+WDxaJrxsnLrxhQGqCFumOq0E=;
 b=ntjZcHrHH1Yl+lBslpnm4BJQDO+tn3fDVRX46zhBucep3XkQ1LHw2ag5VYjAdKg3sBjyjVhsO6dRCCUnFpnECqyCXMqrR8nkkA6wrhbi7ABYD9budkmfJNlTw8j5lswVhWLJN1AVjTPnIjfBa5L1GS+/ZpwIuSgOGbr0FooT8nbSGm0Oi6Rd+wkJMnQlebhmBzKMaj5M+npEme3pArEfmngTkqFsnOh7/Xq1PSLJvv9NBM396wDKycbVacTCN9PyxUR6+nbDkzNGls/3kb7Z0mxct8YR0fB1xQTC2p3u7/BSnJhwEULo2NtfyauKwYYzrdXLh1Pp4tAdh14Jmt0WNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aA7MzJS89CXdR7S2zT+WDxaJrxsnLrxhQGqCFumOq0E=;
 b=AUgshT9g943y7V7hfitZlHNr1CZUCaWFFpfC7VX0EH8TOFn4AUVXylRjmFTQEHWO/JA6XL6OBHAClMxVrHvgQhL3HnHHDLXNYacekf3fyLN48HE+tE2POFHY0SZfLzeCKd2Op+n0VlI7MJcCnzE2Yt3oARJO55WE8aO/r4xUmPA=
Received: from PH0PR04MB7158.namprd04.prod.outlook.com (2603:10b6:510:8::18)
 by PH0PR04MB7733.namprd04.prod.outlook.com (2603:10b6:510:55::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Thu, 3 Jun
 2021 11:59:53 +0000
Received: from PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::45d7:388e:5cbb:ae1e]) by PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::45d7:388e:5cbb:ae1e%6]) with mapi id 15.20.4195.023; Thu, 3 Jun 2021
 11:59:53 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
CC:     "dsterba@suse.cz" <dsterba@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] blk-zoned: allow BLKREPORTZONE without CAP_SYS_ADMIN
Thread-Topic: [PATCH 2/2] blk-zoned: allow BLKREPORTZONE without CAP_SYS_ADMIN
Thread-Index: AQHXViSH/N9K56jFnkyIxAVcrCvP9asCM6IA
Date:   Thu, 3 Jun 2021 11:59:53 +0000
Message-ID: <YLjEOMaxk8/8GOex@x1-carbon>
References: <20210531135444.122018-1-Niklas.Cassel@wdc.com>
 <20210531135444.122018-3-Niklas.Cassel@wdc.com>
 <20210603095117.GU31483@twin.jikos.cz>
 <DM6PR04MB7081B69E31BB7ADDF02E2D9BE73C9@DM6PR04MB7081.namprd04.prod.outlook.com>
 <20210603100436.GV31483@twin.jikos.cz>
 <DM6PR04MB708127C72BDC03B446997DACE73C9@DM6PR04MB7081.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB708127C72BDC03B446997DACE73C9@DM6PR04MB7081.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [85.226.244.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a021abab-9796-4783-86bd-08d926871935
x-ms-traffictypediagnostic: PH0PR04MB7733:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB773394FBABDFB4510FCDA4BEF23C9@PH0PR04MB7733.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nsuoFKP9+t1liBdmP7/YuU2dOIG3fzr6uzXmlbgRjrE+7HZgnWG5THWQvbJ7ed0iwWD1ERLbjOsMIXhc2VZ7MfFevXJLMvbajcCnQjSqMc9sqMF2i0hZXj4ZY9nrOBpNIIq/sdiR3NTLrVTiDi8XcVd7fQrEnYVLDG0IGI0iveLWfGqQ+BwzVzp0FymxS4iQj4OIdtkBd9bIwkYAyqXSgL8Jc51YK3IMU883V6nv48vaj4zLERi0yTVbTzoF7BjNROMVvCSbPYsbrzsJRns4yDGNXkFeYC984wZavAI9VBCjGGi1EsqFLxSdM79gx4sdLF1PkiIXUtuWarHml/K3t9VcxNjymMhqR9+ou4HWLtO/YI5uQpv/8dpeatwmFxdCv3N/ogzeoCbLaC9qIJnX97Kbf+vC0Pk2aBeeb0qObqWuRcA2+MHtqOi2uVqeLq4mxaPx19EXCV70EBNp6Ry6Dc57RmgBFrJa1jFfUMpcJeHGKoC5U0BF8O3Hrb6BZb2y9HD+2NaWJ6dGZCzdfvkR5MGSneQ+SHooIEGDkcuMXCj7XfJ6qrohjd+uaiPjuemiodQZJ7WSI/8Y4xzvg9IFeawQ4EBtTGcEm2P1Ho/WzxM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7158.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(346002)(136003)(366004)(376002)(39860400002)(396003)(6486002)(33716001)(6512007)(8676002)(9686003)(2906002)(6862004)(478600001)(6636002)(186003)(54906003)(26005)(71200400001)(316002)(6506007)(66446008)(122000001)(4326008)(66946007)(64756008)(91956017)(66476007)(66556008)(76116006)(5660300002)(83380400001)(38100700002)(8936002)(53546011)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?BqiUEom2fLrG1XO+gjZuuK2KW1V98xOhYNhPET73AnSAuSXEqMaor7KYbnuN?=
 =?us-ascii?Q?7ESwYaCOi3V2GSsvaMYwQwzdRXi1VK2DqQzlsQ7UJax9eQ8dFjA00e4bFkO6?=
 =?us-ascii?Q?3Xq263ARdvtTedM9rYycDsRorOMqINQysXX6gRMBhFLVYQvX1qmJsprYOdKG?=
 =?us-ascii?Q?Fh0bLzO6LtVgwdDts285ZVEnQxamjy8GNBk0uqy3EypGubPMcFJ1/NzR7XOm?=
 =?us-ascii?Q?mOh4geCzV9K8avJv1q4ufR1oHiKbiYCb2o6HZcm9QJPhTAPPquRI8XvDvgUW?=
 =?us-ascii?Q?NL3vKbCx64ds6hkMZrZYDO9NcfK6e4L0QsQVomqleC2uOnM/z3BStzMp8sCx?=
 =?us-ascii?Q?LiOyKsr5r/3m/H0IiPiRaw3ytaZWgEiA/BmDliDHoGkHg087jBa/WT4a/7jk?=
 =?us-ascii?Q?P/sSAApsANTPobrM3DoETc2jwnFuzNbQbIPOrnJyDZ4r2tQm9YVvYJNTD4ha?=
 =?us-ascii?Q?m3vSuT+Cs1Qa3xYnx5JQBuqX30OCayhY1geBLAuv/nqEZRPa8S4fZpK8LWSA?=
 =?us-ascii?Q?eyjGt6mAdFll2YRjaD9U7XocBf4W9SlgxPXjlAfe00Dxsiu5ax1aCbY5n+Vr?=
 =?us-ascii?Q?VA9zsrP1zzgQa2EwpBq2Wvy3HF5kvU21Ijnln86uhsL45b/eKHg10ogHAeyN?=
 =?us-ascii?Q?pscrVpzqtVNrykPC6D7ToRzZ52i30YwxJjy9Q/g+rg6HP0YujTZHdJKY0BBN?=
 =?us-ascii?Q?0dUPEeg9lsR2plSx22NVmw7RIcybUD0pwrEaXKRbKvLjHkYRSi5oBayCDH+b?=
 =?us-ascii?Q?TVJzozhCzzil4X1x+XFYz6qG1/8H6t4zlNuo1yaauYVTN3tRMiqwdcJhQTzz?=
 =?us-ascii?Q?Nd8reX8ZqUqtIwDNP7n6PIasN+BW3jvWU/OJbbOKhT4tQTL5hrQmP/QJlR/Z?=
 =?us-ascii?Q?Oq1zKWXv8OkDtbnur8ppijh0ZCOjt1zF6NBv952OoX36VUbe5YBwQfniTQbS?=
 =?us-ascii?Q?S3jkAFfjeu6AZ2vYcZLgXDYjxhg8FYLgigvOilsTPKurmat6al50H2jJ19PM?=
 =?us-ascii?Q?9arCeQHkcKqmDrF60FyAMVCXGpJxVr9Nz8BAy99at4z/d+KFy0Vbm037T7aF?=
 =?us-ascii?Q?6P6rFMYd+0ARiMGgKdQCmDNux25BqrywOKcgrAOiVNvrwUZo8dN+Bjz38LI9?=
 =?us-ascii?Q?WHaCpOQJJutFHKVRdzokzaPuOE0U3+WspfCMxXeCjCFb3501Ft3wHK7mHugs?=
 =?us-ascii?Q?Av1D+D8ljj9spef2Xoa7Oc3MLHXZu4i2KknnJKOwEJGm57onmb2fGDYApVmV?=
 =?us-ascii?Q?4H926REcP0Khbttkm0eXXJn9ihfyOQ8v76qwkOqDuz60SMuxs8jTTzWZay91?=
 =?us-ascii?Q?Z6rRHy3dgY50YMpTNjdc/cmO?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <860A9E52A96BE54C8AA69B4BC30A70DE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7158.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a021abab-9796-4783-86bd-08d926871935
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2021 11:59:53.3640
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h3+bAl47gS1bHuv5WyxNMY1jY13MOJ1bCX0yr9EjaIX7rQhRqcOGl1nXTHkB/hSz1hYkCGhlFlam4MW8C4wj+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7733
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 03, 2021 at 11:20:33AM +0000, Damien Le Moal wrote:
> On 2021/06/03 19:07, David Sterba wrote:
> > On Thu, Jun 03, 2021 at 10:00:08AM +0000, Damien Le Moal wrote:
> >> On 2021/06/03 18:54, David Sterba wrote:
> >>> On Mon, May 31, 2021 at 01:54:53PM +0000, Niklas Cassel wrote:
> >>>> From: Niklas Cassel <niklas.cassel@wdc.com>
> >>>>
> >>>> Performing a BLKREPORTZONE operation should be allowed under the sam=
e
> >>>> permissions as read(). (read() does not require CAP_SYS_ADMIN).
> >>>>
> >>>> Remove the CAP_SYS_ADMIN requirement, and instead check that the fd =
was
> >>>> successfully opened with FMODE_READ. This way BLKREPORTZONE will mat=
ch
> >>>> the access control requirement of read().
> >>>
> >>> Does this mean that a process that does not have read nor write acces=
s
> >>> to the device itself (blocks) is capable of reading the zone
> >>> information? Eg. some monitoring tool.
> >>
> >> With this change, to do a report zones, the process will only need to =
have read
> >> access to the device. And if it has read access, it also means that it=
 can read
> >> the zones content.
> >=20
> > Ok, so this is a bit restricting. The zone information is like block
> > device metadata, comparing it to a file that has permissionx 0600 I can
> > see the all the stat info (name, tiemstamps) but can't read the data.
> >=20
> > But as the ioctl work, it needs a file descriptor and there's probably
> > no way to separate the permissions to read blocks and just the metadata=
.
> > For a monitoring/reporting tool this would be useful. Eg. for btrfs it
> > could be part of filesystem status overview regarding full or near-full
> > zones and emitting an early warning or poking some service to start the
> > reclaim.
>=20
> You lost me... the change is less restrictive than before because the pro=
cess
> does not need SYS_CAP_ADMIN anymore. The block device file open is untouc=
hed, no
> change. So whatever process could open it before, will still be able to d=
o so as
> is. More processes will be able to do report zones with the change. That =
is all
> really that changes, so I do not see what potentially breaks, nor how thi=
s may
> prevent writing some monitoring tool. Whoever can open the block device f=
ile has
> FMODE_READ rights, no ? Am I missing something here ?

What David is saying is that for e.g. stat(), you can get metadata when you
don't even have read permission for a device, since stat() takes a pathname=
.

An ioctl requires you to first do an open(), which will will check permissi=
ons,
so implementing the same is not really possible for an ioctl like BLKREPORT=
ZONE.

However, I think the current ioctl is fine.
The amount of data that is transferred from a zoned block device for the zo=
ne
report is more than the data that is transferred when someone does a stat()=
,
so in one way getting the zone report is more like a read.

Doing what David suggests would, as far as I can tell, require another solu=
tion
than the existing ioctl method, which this patch changes.

We can think about his suggestion, but it would need to be addressed is a
separate patch series. (If his suggestion is something that we want to purs=
ue.)


Kind regards,
Niklas
