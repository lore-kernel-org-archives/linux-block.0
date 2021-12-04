Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E65C433EF
	for <linux-block@archiver.kernel.org>; Sat,  4 Dec 2021 01:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384001AbhLDBj2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Dec 2021 20:39:28 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:62625 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384008AbhLDBj1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Dec 2021 20:39:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1638581763; x=1670117763;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=xqQ5Tjmd65Fuffx2mqt1BYceC+4uPY5LI4AtXehrhcU=;
  b=o6a1JNillb8s2vklMnt41mP1BTOSDD/FuzaupiE+T8FqRZMuX03dDY0I
   uzoe9RGNxQZRX65Y2USKPD0L6djqU4rn71cUJPUdNIzR0gagGnXZ/wiAO
   C6IQN1/w3J9r84s5Y5o8JPnER29rhvT1eGGSJyPY7RaXUorVJHjZass0y
   h+u7eo55obaNbV/57nhTva2suVlaVo28tjAB8KsUlSbYs9qbjZuoCRVSv
   dM6LvenmhsGsOe5iYC0Gvwc8Jo4q6IWhGsmSEo52YWhkKuJb/BndKN2OZ
   mqOs97Lv/u/5+93WO82BN2wCFQq4puW+5khKbEH+xrgNknAy+hQaqqOsf
   w==;
X-IronPort-AV: E=Sophos;i="5.87,286,1631548800"; 
   d="scan'208";a="291398520"
Received: from mail-bn8nam12lp2168.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.168])
  by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2021 09:36:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ctCiTa791jg6YZpY6N77PUExIxmPNMja/KQnFKwQzXoYBwHvyPRPZnermJYnCKA+ucorFmlvXKa+F4ROzO6/+USQrFFhFv+B1ml0mRdkXMWmGCogUpGAlRdiQP5p9PylvxplgJ9Ffr2MEfMOFIj9XRFV6Cm371310a3e/2v94qcXVahfZ6/9W7hVr8oQwW8vGFb/5j3ffAjEfoX1M63/M0NYC8qYk/dX1JK+VE6RlHvLMsJImhrEFOboMrDS92voe1zWQynEaaieN67qsSHEBObwOZuc256xu7RjAtXerjqZyNR0Dq+St1+5AOzXz+n0ekpOnL9ELqGWSxX3DjoFag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xqQ5Tjmd65Fuffx2mqt1BYceC+4uPY5LI4AtXehrhcU=;
 b=gvEFRzZtTUvSa+xJxRWwf5ldbM0hEVVO1MMKl4Ds7NgcSfh0oFIPJg+Zi6hywPjGF5QbGMJrvgOBB6GzXMmXbYmM8UBkP229Nr/yf/ALJKvzje9BSzhH3bjMeZxEhA7DGY8FRAbLN3bcxqZjQHTZqlZt8bYBv9U2xtcjlAMNg7Bc6ilkQ150MXHH11Sdlvr/wYTpceRAr8vBiTVYgWITGWvlsI5p+D2/OgjfuOkbXO4EYyLUT/PhjAwlMCJMQJKRIL4a1Uud9WkiYWwUqZabwkgFfCV/iUI74UfQ20l2xy9j0Z3RsLWnGRAyRbwQM+8KsK9WU5/fuwJDuSkKs5CfWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xqQ5Tjmd65Fuffx2mqt1BYceC+4uPY5LI4AtXehrhcU=;
 b=L0mJgF2O9u1m0ce4J3Lrc5ITWLz5h72KiQ912PwpQ4ijs9OEo4VHEIXef1C2R8pMLxGSF41+/nHL54DjuWLENjNPaAqay2F0aggLRGirNyCnjD1ZwqD4alrZJUhkxSS79APZCS1qGz8ybGr/0Wu5vRfo3EpLWyDadf4HAdnTU7E=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM8PR04MB7989.namprd04.prod.outlook.com (2603:10b6:8:f::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.23; Sat, 4 Dec 2021 01:36:00 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::28ae:301e:551e:a62e]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::28ae:301e:551e:a62e%5]) with mapi id 15.20.4734.028; Sat, 4 Dec 2021
 01:36:00 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH V2] null_blk: allow zero poll queues
Thread-Topic: [PATCH V2] null_blk: allow zero poll queues
Thread-Index: AQHX6Eb7Cs5SXvZ3O0ieh809OWrnVKwhjgaA
Date:   Sat, 4 Dec 2021 01:35:59 +0000
Message-ID: <20211204013559.olzfnuhxdnza3agk@shindev>
References: <20211203130907.3667775-1-ming.lei@redhat.com>
In-Reply-To: <20211203130907.3667775-1-ming.lei@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 76219105-7e8f-4268-b8c3-08d9b6c66d32
x-ms-traffictypediagnostic: DM8PR04MB7989:
x-microsoft-antispam-prvs: <DM8PR04MB7989F8D38DD03FFBA795EB69ED6B9@DM8PR04MB7989.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vg3i6RkZTpxXlnZHGydhiC9QockhgiPuUH2aZ99DsQa9iVX033Zd0vPNf8UZWhlW+1FJxaNkv8z5zoCwcTtqoqwWdxEz7uidGnu+5HmTD9k6Sm5sVb98UIXGE9txDVJ+qIKKPHQpFektXZWxZqoH1dvGqK8uok8PD5lDI6aTGmDcQqD1PIsGa9j8c1iWxLc9yGha6E6hzyIAci5p52LOv4xE7ldjq0zXBSmYyNOfLnbTMpBlYT0NWC0/vu/ogQHT28ISZ4bpPV0iG2yuI2Yie+sZaeDMemlwksgDZEy2CegYQGP2FxYn880Vcr9QpRcKMDAyf0R+/tHbHqDQ2VfEMksYjDQpevh72dDGl5NX2c5gTPVOwGDJ+500e/cztMU0NT+xus0PmhnlW4cg5ciRhiBBmeNqcEKJA5/ADYPe/Z14Mr5gJHEhf5F2v9k/3JmcI7gsmZVWPfnwh0O4c/k/ZjYtJd7AaZP9GFSk3Gi6Y2OAofWFYfyvwKZKCHHtmAA5ZoW7MzSvM11xfdX5InCukpz5PJLI6gRBzv1z1MSiFs+T/DPJ96fzcmUoUyAuzseJqaE9I5WawaJnJ7mh6H46x4XLhuj32RSkaDRI9E8dHU083T7Tvh66h0dMV8nJbUrJXixIWJiamZzEtO8nH9kyySALSnK3gLqkOC7T7Cn30CeAtX9GAQF2IdNbRfSb/kN1PNlw3QARERdkZHOd9TpGPQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(366004)(66946007)(6512007)(6916009)(6506007)(54906003)(122000001)(66446008)(66476007)(76116006)(64756008)(71200400001)(6486002)(66556008)(2906002)(82960400001)(1076003)(4744005)(26005)(38100700002)(86362001)(5660300002)(9686003)(44832011)(186003)(508600001)(8936002)(4326008)(38070700005)(33716001)(91956017)(8676002)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oarWCSA8w5zrH6IJevDphi5DElBmvowHEmMhT2KazA48BOpxgptecTvXp96M?=
 =?us-ascii?Q?gpol44fVtngmKHoKzxl5PAMZgzze0YC1eJZAnJTJuDOTYsW2uXMUtbLYVC0a?=
 =?us-ascii?Q?oNPENDjnZD9KnIZzFR6p3pIO4S6iy9sUN1Hk7b9DJp03IrJRvlWTe+gE+CO9?=
 =?us-ascii?Q?bJ6Tmbpy0nVosYRbGykNemL+jnan/h/yo2mDXeKldnu/Yb9Iujt/B0glhQeZ?=
 =?us-ascii?Q?LbMY+7xEo17w2R3PVpEBa8Z3BE43De+xXtelcBG0G7zM3Oefmg69cyCarTHm?=
 =?us-ascii?Q?pGAgk8AiaaCs7kncQWwh9edMP5WMEPJeI7gDyK7C7EbLcmhhZYtA3d1lSjYb?=
 =?us-ascii?Q?yec5KsNbvMUuHXhGAVReSHBrgi6NalMAstKpShZsCCm6jFiXKCbjbdZfl++Q?=
 =?us-ascii?Q?G7N6Lot23fBfUKjRbVoVjhXskwOtEbuvNqlUDiGVIkcXuHg6NdNi+nxPm3P9?=
 =?us-ascii?Q?7owb4AfzXIll6T37l4Yp0lBZinTHjS0zwtF3nP/rTeq+tXQFWlSENWmmbXnM?=
 =?us-ascii?Q?o5v3isvmcOEv11kbhUVSQuWhp4tUXREiElCh9KyiwwyYB+sIiAzwocuiYjeC?=
 =?us-ascii?Q?wx1Dp8EcYUpGZJxeFviIs3kyTL6rA0Vuow+qgqqL8vl0ZyyTG2jfx8D9mV6A?=
 =?us-ascii?Q?trkzj8Xp5574eX3LvyhP9g6eirOA3cwf4OeltzoV4PtVNivdMOOmEdMt0EYN?=
 =?us-ascii?Q?GjDkAAJtTy6P2u2tEuWIrR6mc4Tr+/dnzM84Pmbb5btZYzevM5lsJX4PUdGH?=
 =?us-ascii?Q?d9Jxa89y1RfwzH4Ut8KzeiPx+HxspceAP+fl7+aRfs2B7Z5sirgiZQeXxKDb?=
 =?us-ascii?Q?qisXMdMcgopZRdeWimWEQk+hE4iAYWFFjIoxVX9fqVRsYyWW3bBMh8qMF7jw?=
 =?us-ascii?Q?Jx1KYzYBqG0us3y58GfaC1bkHu9PhWHQb7chJI2DzddB4GaHIKgMg1bzeVrF?=
 =?us-ascii?Q?qwE08qJXRtpw+K41usFbbE4Ur52k0tKZ8pXmwWAAleggDfn2P0IhYr0CFb7+?=
 =?us-ascii?Q?4OmshpLXzz+wEvfc3J+2HglYovtSepT3m6AFalD+mV13D+BVD1g0kn3q9pUV?=
 =?us-ascii?Q?IfZvRol4GzDt02v/y5rmuGWwEoQrEEg5+wiOZkAwoWAEpqAO/iP1G3gcN8h6?=
 =?us-ascii?Q?OnlUPJ7Vfd4+KsxAgt368cQhJv+BttEiXIdU4SeDwe5KY6M8B7qvFaMoH45C?=
 =?us-ascii?Q?EoKiKHv+d77MvHxGPo8sw1rIYs+rqL50oehNi91huS6+M2BKhzro9anvGtSo?=
 =?us-ascii?Q?nJGKyCVGXjitRVy3j+yz1LVfxvml/Ly0DBrl4sdPE3y8ppAqyS/kgptTYA3R?=
 =?us-ascii?Q?PXDWxfPa7i8Mo4C6uudSMD7SBjktUJoZD02lxqgMcO1vBZlgXjhHql3enHAS?=
 =?us-ascii?Q?3w6qDTZ+bu+v5URYSQWhwwEdkIhg9vtDHRUF++Vt/e6wdpiEfqQXhXjDvsQ7?=
 =?us-ascii?Q?296mjdHw9QzqNFXdibf6Gqzb0Yf9wp1eByCFH+Db1eY6PTsgrJJbslvBiz7o?=
 =?us-ascii?Q?Dp6WhNfMgGl9RFdQ3RquIEe+8AoSXTwcHIqb8TaLMYF4HzYpX5HcTzQpor5f?=
 =?us-ascii?Q?cMlWhagTNEEhCdeHVDjPgYU5fdJwp0vK2aGI8v8Hjqe/S2Wgv89QRNZQfLMW?=
 =?us-ascii?Q?xobqwThgKvX8133+jyzERzmd0YNW4zmM9JghEL0xV8DIavAM/Eoq82KBAm6H?=
 =?us-ascii?Q?RVFbsWXc+KAV0RyDJXHx3Q0Fh2c=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <41E3523FE2B82145833A038165E39C8F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76219105-7e8f-4268-b8c3-08d9b6c66d32
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2021 01:36:00.0301
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OPIvbdpHkb1c2MxKCL9DfS8gb7TKHm4mzbzL4PkU9lUCo+VpBFFT1ojmwXEs266HHx/oY4gyPoLXaFS/TGeUxm3dcBnux44CzmURjBnCYpY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB7989
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Dec 03, 2021 / 21:09, Ming Lei wrote:
> There isn't any reason to not allow zero poll queues from user
> viewpoint.
>=20
> Also sometimes we need to compare io poll between poll mode and irq
> mode, so not allowing poll queues is bad.
>=20
> Fixes: 15dfc662ef31 ("null_blk: Fix handling of submit_queues and poll_qu=
eues attributes")
> Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Thank you for the fix. Looks good to me.

Reviewed-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

--=20
Best Regards,
Shin'ichiro Kawasaki=
