Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63677C433F5
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 09:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CCA960FD8
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 09:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbhJSJyx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Oct 2021 05:54:53 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:46232 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234808AbhJSJyx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Oct 2021 05:54:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1634637160; x=1666173160;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=RoA8xIawJMYkqI0miBBeFEFPNJ3pyDgKESuMqpt2i+4=;
  b=I2Rc95AXwygrvpb9AiXiu7laKf5Br9F7bditUaw2sGKLkd/3HJO4saRT
   X90nBxbfQe+3VC/ht2xlOX+1FV7VlS64/pgESMNSVDnNwYGupZks8Wh6E
   kM/0lUnr572xj2sMbM9FnTJKk9+d/9JjrWFWjWVIFUGfBfhFbXoWzOR91
   4KUhr0gF09Xu2wdLKYPV/z09NScAh4ArzUAqyP8+ruDd5AL6flN1LGAK9
   dwsRIJY4mWdRpgRRSRFOpBhHKKjmxFBodka+bd6u1w332YZo+rUquIRD0
   AlXX7SfhnLeeWWbVI3U1jhUOuWZOq6cISEL3NaZ2RPx+Ltc8t3PFcWoD9
   w==;
X-IronPort-AV: E=Sophos;i="5.85,384,1624291200"; 
   d="scan'208";a="182309483"
Received: from mail-bn8nam11lp2177.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.177])
  by ob1.hgst.iphmx.com with ESMTP; 19 Oct 2021 17:52:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wk0D0qTJ9l52rqIIuuD6sQaUoax0oqmLeYXAdDl626nTRjSjs2oI3eSS71I0I+d0AM3hB/lJoECsMa6ynDl7kVpenvP4cChUtyhp3lIJ+LIhhyGsKBW1Mltf69/MXwX0NlIdfa3JXtC2y4t+siQij2hnbl3BCvLvUGCqoRv9VW+Vk8lTtGvOmbjK7jPpYRCcfmRuN9zkBIIAoYLOCX6hnbY0j9jPRZLlewX1FdPJNTuYjLHVgrx/DylelM9b9Bp1epE3YKzrBR/5SKtrBIv1hQA9Dt253Hfk4X56W2NbGNPMwjetdtfcXnLvyt8jBzXS/Be48ae3N/4sGRV8V4Vfrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xsoc/E7Jh0BUwCElXxMtXnLwsa291GfR060OSWFRNFg=;
 b=HM6y4ofIYnp2Dl0+lJzwDvRyItO9gl7lRpxRBOgHtl7wtGenF1t4lmqtCXs61C0eBAhlKNdOm52wERGzJtaCyz6qg5jM5E7tCGBPkYUDj+51x5EQdd0WdRVqKcIkxr5AV+E2vyzKeUA2UUnIjAySQGj14gvS5Q9rBbxSzxTafprSZaVbn12ai6LONMOhRYgkgdCF/M0pGsi0sh2l9U1dU4kMhTSXU2F19qOHWzkx2bS5iu37SAz7JSw4sEhn7hKQisL5BHKvvfnGuIRkSRWJJgXyyjQqTGCb0XCt+1JUcuDPo6Bf7TwqCyRdvs9qUNgq0m6AIY/sc9OFZpSAJLAMLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xsoc/E7Jh0BUwCElXxMtXnLwsa291GfR060OSWFRNFg=;
 b=OO9jOYN/ncJMP1hAZPZZt90aF0yERT5FXf7Cf4FKLikl3jtmeP+rA7IETT6Axb2YvGcDgdj+r/mfF7xAjXu+EqCXaNmlJPWb/+cMidnqC6aEQqmUHOhD5gWulig+eMb5E0N+mIjyllcd0+B51ltMRtZ6AQyVSGzDNmrm4ULZ1fQ=
Received: from SJ0PR04MB7184.namprd04.prod.outlook.com (2603:10b6:a03:291::7)
 by BYAPR04MB5846.namprd04.prod.outlook.com (2603:10b6:a03:10e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Tue, 19 Oct
 2021 09:52:38 +0000
Received: from SJ0PR04MB7184.namprd04.prod.outlook.com
 ([fe80::30f6:c28:984d:bd79]) by SJ0PR04MB7184.namprd04.prod.outlook.com
 ([fe80::30f6:c28:984d:bd79%5]) with mapi id 15.20.4608.018; Tue, 19 Oct 2021
 09:52:38 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     Christoph Hellwig <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH] block: Fix partition check for host-aware zoned block
 devices
Thread-Topic: [PATCH] block: Fix partition check for host-aware zoned block
 devices
Thread-Index: AQHXwWl0GeeFOFPXu0aKIwPL+z+ZR6vVC30AgAClQQCABGqHgA==
Date:   Tue, 19 Oct 2021 09:52:37 +0000
Message-ID: <20211019095237.ndbi3xarxkddmfut@shindev>
References: <20211015020740.506425-1-shinichiro.kawasaki@wdc.com>
 <20211016043450.GA27231@lst.de> <YWrhCiWGjfxqAca2@casper.infradead.org>
In-Reply-To: <YWrhCiWGjfxqAca2@casper.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 41fa6f92-b78c-4905-4577-08d992e62f1c
x-ms-traffictypediagnostic: BYAPR04MB5846:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB5846602481A1F722DD747BCDEDBD9@BYAPR04MB5846.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6e5QKrdZCAcvOeqxuHyDjym2pbXB0G9mGM88XT2o2Bsh/bQVVSZ9Gcr00y8V7NLhnc+jH8uaNffRppD+eRyL6HXAlUxj/HEbKeH3884N6JnIk6k2NVT2SnYuVNoLIoJMh1u70kYtDRNU0aLwIuB6izW1VDfLNC395zS5xo4wnoY7jGbbMaHvepDHuXzRNa9yeqjjNtfPpJ21mxIvRW1uuof2EC8Ttmwz6gY/hTzLshVaoJqbo9HmaaMvinJhXySflhGgo8wXbGcwM8AngivW0GSwuuhYG3S791mqgBkP9TRiaPA3MINRnnMBJ+7R9DIc8P5521SemRUhkk002D6hdiLh6YKsjLYgVIbRNNhWjVH9znWKAUvIyItIib4kF5EduhxaWwoVjQA9Zfsth8nBPGwZcb+hyL2BH5RCNvcWNGSdlShkpv/FRe/97sVpQAh4wkSs6zsVLpAtWBXGC85diOTSYYIx9h75alm7zyNUqWVx3ykDoKASWR7raUemOYbZaOdBgllyXqFz6fSiNAw10auGzOZ2v8n+QXaq9DXm/uLUHW6C+QHreSqCqrRwCSw2JNhPN+IT4+Rd7MxpQ+uNDJadoamkrkolZKAuP3Mx326WXFQMiWwTKwPzfIMBWOPd6V37Bj+4+0+5R106DHb+RgwJO6/s6GtealJQq6U0I+G3hDgq68JQyB2soSdreZVlZ9P+xBx4j1S2IkwPtLQu8g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7184.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(366004)(44832011)(1076003)(83380400001)(8676002)(26005)(38100700002)(2906002)(33716001)(186003)(71200400001)(6916009)(54906003)(8936002)(66946007)(66446008)(76116006)(91956017)(5660300002)(6486002)(122000001)(9686003)(66476007)(64756008)(82960400001)(66556008)(6506007)(38070700005)(4326008)(508600001)(6512007)(316002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rjp2mY2zdPEMgszYg8u1OSFmTKplN25yfIev/PxkQaEeL8TseUL2R9d0Fky/?=
 =?us-ascii?Q?laWW+RAOkNiaWEvdK2xVmEEXNXWFdFQayBEzod7Y0Sn8Ap+r7D5noEwwv9wM?=
 =?us-ascii?Q?PqSU8p9lO/wfpt2ru8tIBqRyV0kGC7EI99Dea6Q0TV2ErIUZuVU1+Syh2SFo?=
 =?us-ascii?Q?ZZMzpmL1SkSxESDP2Auxfl/76GxYPIIZq3Tmq40muUQtnWh5R0mcVbVy20f/?=
 =?us-ascii?Q?PJ2I8qte71zfB6MUcBBxAhp0K0cmf63WdqPyeSAacceF4rmLWGLK1b4YhIr4?=
 =?us-ascii?Q?MtXZGJmdA/S8IeulAODta6nQoWQx+t5zTPTVG0QsAsjor33Y7VZb7dpC4BDc?=
 =?us-ascii?Q?UON4SewSm02rcbQKNzu1WTgQbJuv+avj3GbKaBBJCKpORpU/YXUePccWVo2m?=
 =?us-ascii?Q?rBw/Hr/sDR3ek3Sjsl6E4PsNNoQqSwtlFcdQH5hR7o/vVa1Kk3TuVA+mX62D?=
 =?us-ascii?Q?4vJJNYGQlhNvqohyACypGozWgEz8lU6utmUjMwdfQSgoK7f3R49qlQUv5EP0?=
 =?us-ascii?Q?5+/pEOJW2fq5lpHmSMXZY82sHaxrw8Ilv3eJUDXesmQw1FppbijMXf2QQJx2?=
 =?us-ascii?Q?SZqSl0Ao8X1k4e/uKrLqzGwwwzWFMLgIRFO6OqWHyFGXwRrLm3z7CYzv3zes?=
 =?us-ascii?Q?02IM+43Md2Q4nG/ntTjPUy5gP/dFLD9PPVIjjoBJV1/i8GOW8rgIp59oDbj9?=
 =?us-ascii?Q?ICwAGnnatlByGgQszYejkKxmE/0zzoTHsSQFF1UZuiPvs2Jxe4kHb4Oplg1Z?=
 =?us-ascii?Q?fbrHzd05p/DnnwkwyXzph5bfibrQo53WBA7KjH2Lr9tqDwYLl/n50h9tw7cC?=
 =?us-ascii?Q?PpJkJFC4N5WkIWf2mEsW/gSZkRJpn+4whLG9uUZGVhZgMfLgPGEphKiTjAZR?=
 =?us-ascii?Q?RfhZmSa8W8iKkjwaK0CTdJd3Ga89tgoiOUjONwC4PVtUQyPW/Rv0iZnKsrvH?=
 =?us-ascii?Q?g03uaSy9/QOewL1cfh1ChYQKcQkw3DFEuW8aSA1ujxaBRyRBOs7AvtA53wtN?=
 =?us-ascii?Q?fLqI7vi2KGx9NWza6uSPEEnNTeeudzwZJd6qhS5nQceqBDkyL/DTYWRZlTdM?=
 =?us-ascii?Q?OBkpb7gSLkeCAs/9fUZ6EELZKH4jtucZvv33jhJ9GaJR94myhVjygDhwrGYj?=
 =?us-ascii?Q?m4RrBRI65No18k4tZahDsI+Z1wMWpG8OqkQ2GMhGHBczRvPo1osYgMesnhfL?=
 =?us-ascii?Q?uKSAFFg8nyjeD1tteM0LY0yxbf5pVlyVn3ZdqpdCVvqa9vRvOt3a0Iajtfnm?=
 =?us-ascii?Q?Q36tg+bAtIDnjcFyBezMsousWI0xM1sx1fH83QX0UQDcmH6tOyjXhtfyG+ix?=
 =?us-ascii?Q?BLf9exRcy6dBycqpUSwM3Ag/FHuYpu/rFJCT5lMk+bTdUw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9719CFB8644E874C92218D08EDCC1546@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7184.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41fa6f92-b78c-4905-4577-08d992e62f1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2021 09:52:37.8757
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +RUbgwUdO9zusdsYa7wqvJi5Dt0A3zTSNUuSn5cDccsSJSRlhxULFQyvofAcLXHZsd0PFCepltc2Ww2ZGb9qgPeZMulQgTcDY+5QikuFL6c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5846
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Oct 16, 2021 / 15:26, Matthew Wilcox wrote:
> On Sat, Oct 16, 2021 at 06:34:50AM +0200, Christoph Hellwig wrote:
> > On Fri, Oct 15, 2021 at 11:07:40AM +0900, Shin'ichiro Kawasaki wrote:
> > > To fix the issues, call the helper function disk_has_partitions() in
> > > place of disk->part_tbl empty check. Since the function was removed w=
ith
> > > the commit a33df75c6328, reimplement it to walk through entries in th=
e
> > > xarray disk->part_tbl.
> >=20
> > Looks good,
> >=20
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> >=20
> > Matthew,
> >=20
> > we talked about possiblig adding a xa_nr_entries helper a while ago.
> > This would be a good place for it, as we could just check
> > xa_nr_entries() > 1 for example.
>=20
> Do I understand the problem correctly, that you don't actually want to
> know whether there's more than one entry in the array, but rather that
> there's an entry at an index other than 0?
>=20
> If so, that's an easy question to answer, we just don't have a helper
> for it yet.  Something like this should do:
>=20
> static inline bool xa_is_trivial(const struct xarray *xa)
> {
> 	void *entry =3D READ_ONCE(xa->xa_head);
>=20
> 	return entry || !xa_is_node(entry);
> }
>=20
> Probably needs a better name than that.

Thanks for the discussion. Based on the code above, I tried following hunk
below, and confirmed the new helper function can be used to fix the issue I
found. Good. To make it work, I needed to change the logical operator in th=
e
function from OR to AND. As for the function name, my mere suggestion is
xa_has_single_entry(), but this may not be the best.

I would like to ask advice on the next action for the fix. If my original p=
atch
can go to upstream first, I think the changes for this new xarray helper ca=
n be
done later. This approach would be good if the new helper will not be propa=
gated
to the stable branches. Another approach is to do both of this new helper
introduction and the issue fix at this moment. Which approach is the better=
?


diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index a91e3d90df8a..7a31c9423d01 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -1238,6 +1238,20 @@ static inline unsigned long xa_to_sibling(const void=
 *entry)
 	return xa_to_internal(entry);
 }
=20
+/**
+ * xa_has_single_entry() - Does it have an entry at an index other than 0?
+ * @entry: XArray entry.
+ *
+ * Context: Any context.
+ * Return: %true if there is no entry at an index other than 0.
+ */
+static inline bool xa_has_single_entry(const struct xarray *xa)
+{
+	const void *entry =3D READ_ONCE(xa->xa_head);
+
+	return entry && !xa_is_node(entry);
+}
+
 /**
  * xa_is_sibling() - Is the entry a sibling entry?
  * @entry: Entry retrieved from the XArray


--=20
Best Regards,
Shin'ichiro Kawasaki=
