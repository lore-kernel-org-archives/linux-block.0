Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45559C7EE32
	for <linux-block@archiver.kernel.org>; Wed, 31 May 2023 07:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234500AbjEaHuk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 31 May 2023 03:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234836AbjEaHu0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 May 2023 03:50:26 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513A31BE
        for <linux-block@vger.kernel.org>; Wed, 31 May 2023 00:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685519418; x=1717055418;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0aQsdNd/qgIh7RvIqNzghq0bnde9nM9a9P1J/GPvv5w=;
  b=i+fpadLTNIEna7i4Tnk5dadbk7F5B9wm6Y+/zo35+6IEhFWD/mtcg1BJ
   pUrVwIphcKOF1WAvAfuub4WSy1nGE0/YZqAwA9g3UvbmlJFgOYlFGp+ej
   DEUrNk8oJww7fdBs0RlOmraPXCwwolVlXoYbzWwVzn/gl4WUvz8wAAjSS
   qCJf04Fhot0WuAN3/0A+Mc6VzjF0c1/5hadysIByyBPS/APtFZTJw/SVn
   8nllX9ziS74hcLX+i+6VeqYCdZzH1kVaoINJhwP/Jn7bmXRjj7eLKyC/R
   mykFkx/5N6VCPRNeF7rUemP4sywcJrAOKGjXf3FU8Sm3fgSGuIxcrGUYV
   A==;
X-IronPort-AV: E=Sophos;i="6.00,205,1681142400"; 
   d="scan'208";a="230192744"
Received: from mail-mw2nam10lp2107.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.107])
  by ob1.hgst.iphmx.com with ESMTP; 31 May 2023 15:50:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iKpSt2NwGbkIt/dJK7flG1PjM5E4qSB3/zVw3XysPgCSEAtLhUE5BxzzdmeYyRHH3Gsgwb8g2R5XwRuMrUtvpOUa4CgymL0HY2oiKS1tH+eo5jVDUApxz7tMd7pfOZ8uPc6cHeRGbJqJjfzcN5hBv5kYQGTZppg1safS8fVHD/WMYZ7IE/p/atsrlitFiGkUle9tBVQeOoOOlMBT/t9PNy0KMCK5jEZtOrggGJxXJWxMd1oqp+4jJVq9yV2IbM6vtNOS2Jw/TwbExeJiKeskjUw6cGD6Is0a80IGB3MXBfmiegTtqWzQI8H7+4wEJeIGg+gTSd+Xqqq+SlE5M24Q2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0aQsdNd/qgIh7RvIqNzghq0bnde9nM9a9P1J/GPvv5w=;
 b=HcED2bovHs+6j842Zr+sfwMQ7kOuY6vTtLXpvPbTGtZ5cF1kC+oq2qRdoeWgmjgu0Q+NgxVYvA90JuIwF6dSnmUGOxnpRbpq4g97Y1fW16WCLYtFgnxzcRh/MjfQUQt1/Y7rf8q/RUjsyFM0KGqG7apm2F58w2s5czJTAi5QpvzH1jujVJ4UNc74LS+VXp8HlzTyFJkQw7aCXz+Rujj9zymmsPauN+FEwDpFVM5R2lqcxvDxwBxs8VXnqlm30no91BldOyU5bLYn69WKUBeKKNt17BUtToNrzxHmJqXXVX6rXOjYlMGy2UiyoIJsTptofhwC7gaOQBVTqtCuk+CpzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0aQsdNd/qgIh7RvIqNzghq0bnde9nM9a9P1J/GPvv5w=;
 b=ODKNL+qJ/TZycZDXZpOMeYa2Csf1BOxCaZdQpehzK7w+jF8Z+/PCTtr22CnVUGekqjejwgrfpIwgAK1ujTyvUp0Rs3i4dC1uvW7DgwVBsuScJ6hRUahacO198qixWc9wlv9Vg6J7IcUcCogScMy07UP1zqyPZ0XFeXHwRZRTnKA=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 MW6PR04MB8869.namprd04.prod.outlook.com (2603:10b6:303:23f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Wed, 31 May
 2023 07:50:14 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb%7]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 07:50:14 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH blktests] nvme/{016,017}: use _check_genctr instead of
 _filter_discovery
Thread-Topic: [PATCH blktests] nvme/{016,017}: use _check_genctr instead of
 _filter_discovery
Thread-Index: AQHZk1w9J1fvV9jcWESv88AeU5E84q9z3PqAgAABIQCAACQ8gA==
Date:   Wed, 31 May 2023 07:50:14 +0000
Message-ID: <c7ufzjeewy2c3hmweq43wxmoufy5fydcsehc2ubr35bj4zuuzw@wysgibhy3b2c>
References: <1685495221-4598-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <6fbgjc5ykve3jyko4vlzudrnwueou4ehgn6n2dtihjko3qv7ww@sqlyuxx4ijt5>
 <46f93bc9-e657-4a14-4b0f-2588fec31a4a@fujitsu.com>
In-Reply-To: <46f93bc9-e657-4a14-4b0f-2588fec31a4a@fujitsu.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|MW6PR04MB8869:EE_
x-ms-office365-filtering-correlation-id: a8734edb-8285-4547-961f-08db61abab4e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OChRONj4ypMuC5ric4jhHMAWkRzX5xxuSggtM1QcqKDkQf8K1PhxehzkB4PvwXI0DyFYd76mKYVzcp64+pWe7m4zVkewq0cinD+e0B11klNn/AFzKSVhGuqgn4iQW42a6IEAVt5QAvcNvi0P/E0gXd1xybl2oa155YOOJBOTmZj7WOM+t8Y72DANKYxIBmKakiVFdG9fS9zyM28gQKbNhG0Tu2suiNnYhZZFEz8b99ZSiwXa049s+WSg4v3cUEjp4MSPxOIMYh2oOkjJzBrccM/h1Gv1I95jXltAo0jjBNls3ZdkHK2RBmuV7Vxe9k/5/oqxAc4X1xQTcejWKWkUu2S6p3o+x2C8wly7ms3iG/HBaeaRS7CXP8R9Az1zpb8Sbf665fqwbBmWGeGNp+RzaQGENlXUUkT9if5TI9E5c4OBTonxuL92K+KH5QIQ3gUG8oGHi/sd/UlhSxnudkEKtZu1jZVI/7Sqdh3jyAzRdlJd9DuKaGX7AEbAIDGPr+iEc8Kx3G3n9BZFK4nqNpsSNIb638i68NOQVkIQLuoQLd20mvw9wN4lYs2JOwdIJGfpMV80FizbluFhxUxSgIV6s17konX/UPCiby/VVRO8pEyj1KAHloXxzWLEG9qrdB1o
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(39860400002)(396003)(346002)(376002)(366004)(136003)(451199021)(82960400001)(122000001)(38100700002)(76116006)(66946007)(33716001)(66556008)(66476007)(64756008)(91956017)(66446008)(38070700005)(83380400001)(86362001)(4326008)(54906003)(6916009)(478600001)(4744005)(2906002)(71200400001)(6486002)(186003)(26005)(6512007)(316002)(9686003)(6506007)(41300700001)(44832011)(5660300002)(8676002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nDeMEW93IOF+EJGhCXqT9uZtT99qYYDA186KvgPr16PXirqbIJe4aaotdg1V?=
 =?us-ascii?Q?CeUo7ULP73Yiv/KejFPublMJ2xUkJPn4CkNhEzexau1TYpKQVDGO2iSaO1It?=
 =?us-ascii?Q?KkdH/mBg8cS0zSN1pOVlrMA5KopCvUJBzO+nou2Vp2VuitC4MCLM1rE58fB9?=
 =?us-ascii?Q?a4b/LRRj9G3/zkwSlxXCbhvvnW+IdfzQnL6lAsD1cgLrvPtR++vmeTrqcx9n?=
 =?us-ascii?Q?V7l+vm2kTsjTl4JFsw1uun95ZrDOvVRJytf1dGMEOV5/KQmvD9XUoQY6OdN+?=
 =?us-ascii?Q?KTN152+GGPXAqwH89Dn6Z1XAyehybIhY8bIk147YmSXvMxWIUKIbZACARbPz?=
 =?us-ascii?Q?sUrlP40RAoINsLd21FeqEZH8P2lxJRobAhylpovXYUs7S40xJXrBoyFC8QVv?=
 =?us-ascii?Q?HQDBo6GdHl33lIsFzPAPDlXSjfp4PqJhl2O57ggHW40q2pOal1RxQOVnD1Ua?=
 =?us-ascii?Q?1qBQhYv45/zsQe9iSDq8a3CH3NN438J4wb4BqoSpbf0Cwb0KuY8202uv01E/?=
 =?us-ascii?Q?bFCh24og47+/QWkKoG3vlL7tkRPsg3eaNEoE16bxtXb7jAPRcvwBPHTx2BS4?=
 =?us-ascii?Q?3riooMoDhmp5buugnn9gCbNfhPfQZoP6EnkNVYbZetgMVPjczGg5Xfl1Vg1X?=
 =?us-ascii?Q?p4ASZzoLzrGqAXXO+Mg1irzilFIfNMOzKefHiIaw5M7ibcOeUoEnQ8Bo0KLR?=
 =?us-ascii?Q?wOyEXGY42iEkY5i5S9wA8Gaw9OGX66Y+2IhUqXUnvsCC+zDO3vpDS6JPUYE7?=
 =?us-ascii?Q?xEmWePJcb9bFmPS6Xd/0BA/MMy2oYD2qd6mzk/yh8g+iS+upr41iyuJnp/xU?=
 =?us-ascii?Q?RtDkNRCgHLC88QCMT5sQ7vssBvfvLKplys6EH6PNeaUmMNy5mowgTtFehvkX?=
 =?us-ascii?Q?h81Ra/n8GhlGdfGZSN+5vwqGtqoSjN7N9Gs/iKUHIq8+0mrxKlT+L57+ba/C?=
 =?us-ascii?Q?EryPyJkDTdbHFIxqHokEM1hnUombP23aHQZiGjiLD4e4MhTwoemUS2ZkmIb/?=
 =?us-ascii?Q?rHMhKcywTiOSwzFV3pZu/C59hZFIgA+K1dq2LMN2zeQhvq+cjnSnQFKV1uoF?=
 =?us-ascii?Q?nromp2kHpPoePIuxPUHn5gmuElPcTTToMBVOfjRt8e2cEhGg1U480/CZWwOf?=
 =?us-ascii?Q?67u6EbgU4jdfAEjHx5+K7ckVxTs8uRTPYzdS4dJYzmRyvc6+JZcdShVtNGj4?=
 =?us-ascii?Q?Y33Er4y3EAxgWI0iWF4kyVnXzpR9lQW6VLG0tf927b/y+RdcUXQ3vqJ3a7u+?=
 =?us-ascii?Q?BAOQUg5qwWFed0Q3fGfzv+zu1xfnFBFUcnS3cXlvSP12+0p/Shdh+Uyh1p66?=
 =?us-ascii?Q?livAHIJgwD5hJqM5OsVyhXTx/XXcO+Pd6rxte638aiwpf6PVTS6Ib+OVs+Ff?=
 =?us-ascii?Q?W16mZ6drvKyxhsWNdCMZ/KW6j51+EzSYZmLCwM9m0SlOgDjbcCLXVqW7Ecmo?=
 =?us-ascii?Q?meR7vGdSWseAkG8ti5bco+87l8HKUyXd1o52Dy8Mmh7g0vFGLO4fZ8bo9nLP?=
 =?us-ascii?Q?Aga7SgPgz6o8dVe3Qw4gO2EE3BM/dwFKbGoj9VdmQ1lsx0TI41hNMICRgpH5?=
 =?us-ascii?Q?yuxo4aOvuWuOdaRDWL3e2b+a4REZWpan4JSKW/ngn8+FndgMafTe1O8COoUn?=
 =?us-ascii?Q?ZzzJBn9EEwi2R3qAsKjHCXM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F55531D599AC1744BDFCEDEBEDE7A049@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 3vz+npLrKt6dk50VyvMLa5tIMYHIM+aAJ8+Pj3C6i1qFw2t0ugCv1gH98/KM5Bl1BXrhCQmYX0p5e4kqJ+im0Hn6W5LFkCjP0h8S2o2YkNZfYd1C2KFQLId/Gtz74vvRaoGztGyb3SXIXEBs6YKcMN2YDN5OlvTp0qGP7Z6qmKQWzW5eibzC5rD0r1+OkpjmQrCwN6BKdDzE1LsEXoFdUIpfiP2kdRnqeERYvCMWcOtRrdoMQ4BXkzdwda3TBZ+oJMB8u4vJDcl1eu4RPX5yTYV+MznByZcpWsR/MFa50zP0ix9z0cj1kwgMxZqmPTcFulse2hNp9I+9C7x72HXRAg5+KAdVGROP9vdoqw7JQHSidCfwmCVzinndFK9KHTBg+H/vwgXKUKAX9BLiuqwDUVuupFm+6kzSC1l4vgJSAoMp+RWDwg8FA5AB4MdoUY2XDxTaOjavPesZAXihby2HdA4qFt6EfZVbn7t95i3AaHJjl6lmCXoZVrGRoAovwNQhU2Xx+OVVj4lKWQ6c3DD8JKIzX8Li41IZSx0ORacpRZGGxc/FhxReiusu4GkhvlMvg5JFBWshUZgcuFN4+qAaybM1zHr2l4el8YSChPUOE+OjuRQ2+F+2Jn75CVcTjmGxOPvUpY8PLGn4Qekxf6Dn+fvdTgMA25LBd65+9jHkSw8g4k1eK4RghKmCSEsDj8C6KQ3e2OqrYJfpugoQ7/XzArAyJlYW7jj6pyOQhm3sRRH08Z9fyVLFPRIMpTqTaIxEwk5Q/FRclbpMBOGdXOzLohwykAqToQgtUfWEO6GyGdwypCo1wNFmzMQkN7KPhUZEBolwfYZE7/XXQLvTyz40W5zx1oHonw2D5//zOosaTlU=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8734edb-8285-4547-961f-08db61abab4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2023 07:50:14.4329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JifOjf4Ev+xMzmEIkK0aSQz15bshDUwbXvYB4QL+L2iEMyNflVWqqGu7vtG2NlkGDz0BDPuL6Ruybe6BIkGBXvXL4OzuB+a1mYbqB21y3f4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR04MB8869
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On May 31, 2023 / 05:40, Yang Xu (Fujitsu) wrote:
>=20
>=20
> on 2023/05/31 13:36, Shinichiro Kawasaki wrote:
> > CC+: linux-nvme
> >=20
> > On May 31, 2023 / 09:07, Yang Xu wrote:
> >> Since commit 328943e3 ("Update tests for discovery log page changes"),
> >> blktests also include the discovery subsystem itself. But it
> >> will lead these cases fails on older nvme-cli system.
> >=20
> > Thanks for this report. What is the nvme-cli version with the issue?
>=20
> I used nvme-cli-1.16-7.el8.x86_64.

Thanks. I compiled nvme-cli version 1.16 on my test system, but it did not
recreate the failure of nvme/016 or nvme/017. I ran them on kernel v6.4-rc4=
 with
Fedora 37, so the failure may depend on not only nvme-cli version, but also
kernel version.

Anyway, let's wait for comments by nvme experts.
