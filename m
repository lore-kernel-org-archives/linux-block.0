Return-Path: <SRS0=t87n=EI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F2FC00A89
	for <linux-block@archiver.kernel.org>; Mon,  2 Nov 2020 17:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA0C720756
	for <linux-block@archiver.kernel.org>; Mon,  2 Nov 2020 17:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pqTjr0mG";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="WDby1EAm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgKBRK0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 Nov 2020 12:10:26 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:45858 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727200AbgKBRKZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 Nov 2020 12:10:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604337024; x=1635873024;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=QTg8WBJRUZRFTSoZtXIZIVmlRj3K8OEY5fseHRRbUO8=;
  b=pqTjr0mGlNJ9TLZTIRKGSzMN8Mut4b+pYeUP8+2fASoW5kDDoYlNhFIb
   xy7aO2PGzJ2cd6OXZDSsFddvYDO98LNoRBJkIVg9xnOKTFTFY0TLpbXyy
   NjaWZQCi4ihhR+mQrHoSUYQkXHaUPje41eXZrcAfSoz9WkdRpxPI2lQZW
   T4+etxvj2UWdy2LErV6I0Qm43OMeSMC7lph5jjs/4UwhYo7UOzS2IZLGc
   kpUGAxIdGivqVsmgM/eB+qm6lWU10zKslxZfXYRPvz8lb+tQyfoDPgr5D
   RPHlG1WHO7ON/Gjdrs5Wx44jcSE6nfMKRRiEm3drL594vUFcSV3AWkc1V
   A==;
IronPort-SDR: 7Fnm9cTFlb9uJzY1r5xNf+KUDokg50JJJt8voj2xtxzgu07INh/aks2692raYgdBNw8apta2nv
 yurLvi5PnkYeq7MH4rQqfQB4CKNu1oyxklCC2l7eAjJPdYfo4nagDpDSCQarMXrz5KiwGlCBRC
 lYuTD4+0HU9ctbvUEy24Kdijv5ve90t0Tj6jQZuCoNIurNlLLKLxyILtTXH2CNKIHGs62YtOp+
 bnPTLarDtJ6WTkCX9be0Vt9GIEQL1OX3JhWwzc3YTQzJn8B+o4cuAkH17ZlcV9QJzElGCnc7YD
 dlc=
X-IronPort-AV: E=Sophos;i="5.77,445,1596470400"; 
   d="scan'208";a="156007062"
Received: from mail-co1nam11lp2170.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.170])
  by ob1.hgst.iphmx.com with ESMTP; 03 Nov 2020 01:10:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AuYRo2De4EROsNMs+x/5fAx/fEsxXQutPJNWS0JguyHUB50dFMAQuzsW5hHcmTWgypXvbiVsZiaSNw3WEramw6yGDOiXTRLIVmfakYdgsoyCLUn7a1KBVKvGeoGnxl6of10tWZydqnjw/rqKHmDVfX1EQIe0o00WnaXGaY1xodfjqMBDmiTF+vJv7j9vbK2IBYcJqM0+MD78PpfnXR+D8rx9ISJ53kaF6pw0GdnntFxwE8nNqJoIHt2/swRnzpk054XXW6xM8II/PVfgkTD7zMzfSObEEQAMQ1a0zRNtbsKxNV7PcAh5oWPSJlKHk9yCIe6qJL2zzFUVZaCe8OU89A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ijxoXqjAsEI/9McZHp3G3pwwAMKp/hAS1afBj0wKcHE=;
 b=LbLqSMpcQVEzBq+aEdnem1GKe/a4nhE4QpduCgMxq9wOwfqJIq9SD0+saAEbS1WipeMxxmMBp/RJvLwfv0lYu4Rql7CFhszvNfdb08Fp0N3TxWUEI7kI8A3hk6Sc15Aqq2zT0xquc6wCxbAonws5UzRmKWHRE3Qw59airjgPJbMtarSpgnSFZVbLq6bZsl6hMNzU/YbpuNiRLRCuAAqSKwEs3NKIpHUqUYDakpK5hazcvEXrkXrai/A03TbwsT1X/VK1cLse+VGjPsfijuUVuUu3sAXHR0phuciOCi336KRRg+/CxvfK2k5FV9rlp5rIIikaBW1TApgNkk1OQpKJSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ijxoXqjAsEI/9McZHp3G3pwwAMKp/hAS1afBj0wKcHE=;
 b=WDby1EAmXjCIRI51GeWLI3B5fQ/Qupuudfh599mLm2JSicvqVrXnbDSbLtdKjRFdobCgGbg4fw4SIshRck8dGZhatvg8jaM+82Cz2hYbhBcIU9eGw5bJmFAyThhmdag1njHo6Svca/Vxq6C59fVhRuR4TDehowPbuqsJlLFnK3c=
Received: from DM6PR04MB5483.namprd04.prod.outlook.com (2603:10b6:5:126::20)
 by DM5PR04MB0956.namprd04.prod.outlook.com (2603:10b6:4:3d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Mon, 2 Nov
 2020 17:10:23 +0000
Received: from DM6PR04MB5483.namprd04.prod.outlook.com
 ([fe80::c8ee:62d1:5ed1:2ee]) by DM6PR04MB5483.namprd04.prod.outlook.com
 ([fe80::c8ee:62d1:5ed1:2ee%6]) with mapi id 15.20.3499.030; Mon, 2 Nov 2020
 17:10:23 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier@javigon.com>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "joshi.k@samsung.com" <joshi.k@samsung.com>,
        "k.jensen@samsung.com" <k.jensen@samsung.com>
Subject: Re: [PATCH] nvme: report capacity 0 for non supported ZNS SSDs
Thread-Topic: [PATCH] nvme: report capacity 0 for non supported ZNS SSDs
Thread-Index: AQHWrsllDye4hhD8gEKXDqYoAbLnLam0072AgABEx4A=
Date:   Mon, 2 Nov 2020 17:10:22 +0000
Message-ID: <20201102171021.GB203505@localhost.localdomain>
References: <20201029185753.14368-1-javier.gonz@samsung.com>
 <20201030143146.GA105238@localhost.localdomain>
 <20201102130411.2vqqrma6zetec543@MacBook-Pro.localdomain>
In-Reply-To: <20201102130411.2vqqrma6zetec543@MacBook-Pro.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: javigon.com; dkim=none (message not signed)
 header.d=none;javigon.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [85.226.244.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 371effd8-bf19-49fa-b289-08d87f522f61
x-ms-traffictypediagnostic: DM5PR04MB0956:
x-microsoft-antispam-prvs: <DM5PR04MB0956C267E200E92419BE348FF2100@DM5PR04MB0956.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f4JcUdoUruoqA1IfjCM15+J00bcISnKzA5oFiopoFvplGONV1N6VrByG+fhOivXK1am8xC4cViOlU0LanpEOOJF48jRgUVAAWLkYu6DkzyvttbTf+icFK/gyJ9SxtAMak9uOcYtBj2NB1E9DwhUY58JTKB6GOCYhxPat4P/XBj4xzrnrZqGCVmBXzihJvNBDgLPnpzq7rjwoJYh2NJZbGUeZ0+QTE3+WizbTn3NpDi9TO1AssLMKZfzZGONCA14xmcM7VRwgdoKo/AjVW/uwR60AAtm7NJxoKrKiSRAhVRdYEdpYU9vN5ggrzn1wdSlR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB5483.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(376002)(396003)(346002)(136003)(83380400001)(316002)(53546011)(91956017)(9686003)(6506007)(76116006)(66556008)(64756008)(66446008)(66946007)(66476007)(2906002)(66574015)(71200400001)(5660300002)(8676002)(6512007)(4326008)(8936002)(6486002)(54906003)(33656002)(186003)(1076003)(478600001)(86362001)(26005)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: xBJamj1aOSmOZbdN37SBnXvlFcpXf1MpL5PvbodA5u2f8WLe3ujrglWoILDXGC0KR6K1dK6WTFdCYsNXSDFbxrbSwZJDSCbRrufQSfK9R+dBOPDCh7Jzd5wyRwKdXXCJI6S+6JVtUcSizqjNkOz7Rp6Mc4jk4UScnsIkDUyRaNj61vwc+SCss4lnGDAURuoCLCbZKa/iaQqczraHhUifv6MXvdobMH/P2djbm6s8FOP78l6BV7tUXqr13YrRfK80B9rz6gJsfwpBkVnrZ4TQsPQIMo9XVsEcvzulh2TxdDfC+/UbhRi3PlKnK0P77+KQELvrVxqcvonRn4HN583PWFTgHv6ItJrBzVndyrqGWWVVZPTic1dS9Cp9pBM+Mane3Ziq/9ZREk9deAz6E9oZn9LSligJVfdCdQTsaqRSk0bYmFLnsBzZLhNyDLznfq27g+A3mN047EB6H/CJ/qmB47A3LU2xoQiqBd/8t7C/iIX7MYpYZpHR/YtiZe0H05O+KxkL2v+nLMW/4a8AZuCCEVE7MjVyR8V4qCrrJobY8S36YEMhSWykRYGdRn1n2k3H/v0YurXsVjCyzT8TaPPmoszQMbYHocmdmq76wNBZDnL+RfRZV+JAcY2YbkWUbMGQ9sO9HfNmYsS0asaDs8iimg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <1F49070EFC39CB4B9F7A00128C619CDF@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB5483.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 371effd8-bf19-49fa-b289-08d87f522f61
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2020 17:10:23.0933
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IZDB0LnXFwfO00msYCVs5sbp/ikpYjnWIWkbZRunl5ho7MiG+iSb0F+luuY1P/tbmv+v2kCH1WhTiGHZpbyU9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0956
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 02, 2020 at 02:04:11PM +0100, Javier Gonz=E1lez wrote:
> On 30.10.2020 14:31, Niklas Cassel wrote:
> > On Thu, Oct 29, 2020 at 07:57:53PM +0100, Javier Gonz=E1lez wrote:
> > > Allow ZNS SSDs to be presented to the host even when they implement
> > > features that are not supported by the kernel zoned block device.
> > >=20
> > > Instead of rejecting the SSD at the NVMe driver level, deal with this=
 in
> > > the block layer by setting capacity to 0, as we do with other things
> > > such as unsupported PI configurations. This allows to use standard
> > > management tools such as nvme-cli to choose a different format or
> > > firmware slot that is compatible with the Linux zoned block device.
> > >=20
> > > Signed-off-by: Javier Gonz=E1lez <javier.gonz@samsung.com>
> > > ---
> > >  drivers/nvme/host/core.c |  5 +++++
> > >  drivers/nvme/host/nvme.h |  1 +
> > >  drivers/nvme/host/zns.c  | 31 ++++++++++++++-----------------
> > >  3 files changed, 20 insertions(+), 17 deletions(-)
> > >=20
> > > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > > index c190c56bf702..9ca4f0a6ff2c 100644
> > > --- a/drivers/nvme/host/core.c
> > > +++ b/drivers/nvme/host/core.c

(snip)

> > > @@ -44,20 +44,23 @@ int nvme_update_zone_info(struct gendisk *disk, s=
truct nvme_ns *ns,
> > >  	struct nvme_id_ns_zns *id;
> > >  	int status;
> > >=20
> > > -	/* Driver requires zone append support */
> > > +	ns->zone_sup =3D true;
> >=20
> > I don't think it is wise to assign it to true here.
> > E.g. if kzalloc() failes, if nvme_submit_sync_cmd() fails,
> > or if nvme_set_max_append() fails, you have already set this to true,
> > but zoc or power of 2 checks were never performed.
>=20
> I do not think it will matter much as it is just an internal variable.
> If any of the checks you mention fail, then the namespace will not even
> be initialized.
>=20
> Is there anything I am missing?

We know that another function will perfom some operation (setting capacity
to 0), depending on ns->zone_sup. Therefore setting ns->zone_sup =3D true a=
nd
then later to false in the same function, introduces a theoretical race win=
dow.

IMHO, it just seems like a better coding practice to use a local variable,
so that the boolean is not true for a short while, for a ns that will be fa=
lse
at the end of the function.

Kind regards,
Niklas

>=20
> > Perhaps something like this would be more robust:
> >=20
> > @@ -53,18 +53,19 @@ int nvme_update_zone_info(struct nvme_ns *ns, unsig=
ned lbaf)
> >        struct nvme_command c =3D { };
> >        struct nvme_id_ns_zns *id;
> >        int status;
> > +       bool new_ns_supp =3D true;
> > +
> > +       /* default to NS not supported */
> > +       ns->zoned_ns_supp =3D false;
> >=20
> > -       /* Driver requires zone append support */
> >        if (!(le32_to_cpu(log->iocs[nvme_cmd_zone_append]) &
> >                        NVME_CMD_EFFECTS_CSUPP)) {
> >                dev_warn(ns->ctrl->device,
> >                        "append not supported for zoned namespace:%d\n",
> >                        ns->head->ns_id);
> > -               return -EINVAL;
> > -       }
> > -
> > -       /* Lazily query controller append limit for the first zoned nam=
espace */
> > -       if (!ns->ctrl->max_zone_append) {
> > +               new_ns_supp =3D false;
> > +       } else if (!ns->ctrl->max_zone_append) {
> > +               /* Lazily query controller append limit for the first z=
oned namespace */
> >                status =3D nvme_set_max_append(ns->ctrl);
> >                if (status)
> >                        return status;
> > @@ -80,19 +81,16 @@ int nvme_update_zone_info(struct nvme_ns *ns, unsig=
ned lbaf)
> >        c.identify.csi =3D NVME_CSI_ZNS;
> >=20
> >        status =3D nvme_submit_sync_cmd(ns->ctrl->admin_q, &c, id, sizeo=
f(*id));
> > -       if (status)
> > -               goto free_data;
> > +       if (status) {
> > +               kfree(id);
> > +               return status;
> > +       }
> >=20
> > -       /*
> > -        * We currently do not handle devices requiring any of the zone=
d
> > -        * operation characteristics.
> > -        */
> >        if (id->zoc) {
> >                dev_warn(ns->ctrl->device,
> >                        "zone operations:%x not supported for namespace:=
%u\n",
> >                        le16_to_cpu(id->zoc), ns->head->ns_id);
> > -               status =3D -EINVAL;
> > -               goto free_data;
> > +               new_ns_supp =3D false;
> >        }
> >=20
> >        ns->zsze =3D nvme_lba_to_sect(ns, le64_to_cpu(id->lbafe[lbaf].zs=
ze));
> > @@ -100,17 +98,14 @@ int nvme_update_zone_info(struct nvme_ns *ns, unsi=
gned lbaf)
> >                dev_warn(ns->ctrl->device,
> >                        "invalid zone size:%llu for namespace:%u\n",
> >                        ns->zsze, ns->head->ns_id);
> > -               status =3D -EINVAL;
> > -               goto free_data;
> > +               new_ns_supp =3D false;
> >        }
> >=20
> > +       ns->zoned_ns_supp =3D new_ns_supp;
> >        q->limits.zoned =3D BLK_ZONED_HM;
> >        blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
> >        blk_queue_max_open_zones(q, le32_to_cpu(id->mor) + 1);
> >        blk_queue_max_active_zones(q, le32_to_cpu(id->mar) + 1);
> > -free_data:
> > -       kfree(id);
> > -       return status;
> > }
> >=20
> > static void *nvme_zns_alloc_report_buffer(struct nvme_ns *ns,
> >=20
>=20
> Sure, we can use a local assignment as you suggest. I'll send a V2 with
> this.
>=20
> Javier
> =
