Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE3DC433DB
	for <linux-block@archiver.kernel.org>; Thu, 11 Feb 2021 18:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99DD864D73
	for <linux-block@archiver.kernel.org>; Thu, 11 Feb 2021 18:11:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbhBKSDu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Feb 2021 13:03:50 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:65081 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232552AbhBKSBs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Feb 2021 13:01:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1613066508; x=1644602508;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=L5v5U0g3hoKsMhJSKutjbhnuUuQlzsM8WZ5k953ufXA=;
  b=WSLnrKTT2AVntBl40VOyY2CGaCHthy3mq8LhDc0NjJMY92HaMqrd8S3y
   lDKmV1MDfCos8my/SwZ1YmbHJxgCXbj8XecYdgpiaj9DQjFubxl405YuE
   ZCY63v4gNU15hLIoQabE/KeFEUXdiPRP4OxhSJj33OyxrR7+3FU9isG7H
   hwVxmZFv8lwjhrekSAB+7fEofs99yma54hT/tcn3qEHnLCHR8jubbsOOO
   OfFFaQLTxEmmMzqv6Rcp1N8yDaayyH2lB67CdCwOQOckUbeQucGMvMFut
   9cp+G5UjKAjcDJLSYCc/YVPP1OjO3yr0+taucAZO7Q1COW816+FDw8ROe
   w==;
IronPort-SDR: x5luGmNSc3fgjMj73HYjZcZpV+TUTzste1H/3wCUpeAwexuBiNLEF20A2D5uLb5lP9q9HDiFjh
 8bXxxlTHmVK+/JPjfu/ZDHO295HJ+esfV5bEMA8x6Eg+/9X+zoIIiWIY+mwbwPE7jgkaC72r2y
 tIWF0Sr+lOVSs4tS8eu23Nf7FCcztkr723acy2vVFth45oCnc067IfvhQORGnl/ZPkjOCx1rbC
 3nQ1g7oKeaSBBackhQ0Pn3Ir1aXtFshjQZZmRl+DR+DrnEsnG0EQyBJ/lqcVJpOOlhSefS6bF1
 fs4=
X-IronPort-AV: E=Sophos;i="5.81,171,1610380800"; 
   d="scan'208";a="160946162"
Received: from mail-dm6nam12lp2174.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.174])
  by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2021 02:00:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MSMZamQYG6LpiuA5+2cDHAceqrGLyA6eqVcIlPTR/pNZJCg4+HIqSRWW6ZBPHiH7wzVWVDr0+US+YW4mzq4mitNBfZoW3sF7DKYIpV4NyqHAjW9Nipd9S4/88tOWr9zjaBAXdNg4foaXGeJ68JUooi7qSIewHLBu6RDsYDVtI8lMcNTC8lkp5nMex5ZKv4NPhCGNBnikiwtH3vsH+rYdvb+i7TEWOcwzk0nXeIZLGqGQ6HMy/1+YbXEcgzb5esCkVgW6E3iBAurlyrHK0Oo89unl7WAD9qZ90bLduQEuPpQ/F4At2DB8ddP1gU5QR8au0aYmOqtNxf5lqmfNTuqiSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5v5U0g3hoKsMhJSKutjbhnuUuQlzsM8WZ5k953ufXA=;
 b=LBoANgCXbmm3PSZsoPOgjB88kPk5KuRN6TouQ/xgDEiEqQ9x8s2H1oMMJxSGxU8V1tZPswATrQo/kWjTvAs+fC0BiPGxJ8bmu4DFp4ACJrmdriE0KQqDHTYPZcellvZfJuKlADXJoXsgGsW6A3fUPRwKC6Y+UGs8w2eF5IZZsJ/ptf6ICNJW0gVmJjhlmxsqCvCR5ZuCvfcxEpDEyDsPlD8fcSWcUENDIaX8Qg/qvW9T6ify48pXRcsvXMsD62LC1GDLBKoA7BiXvem2p/00Rx4E/1QLfwgmQ93Ay611M+XIrBQnmv4X4y6IT/q0ZcoXkXGU6mbd+/ucuAWB7R05cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5v5U0g3hoKsMhJSKutjbhnuUuQlzsM8WZ5k953ufXA=;
 b=rxuXCNOOmrBYKa2owFimwFSJ7NY/Ornbq/eLtLrZK+v8M1rugZRaB3wLeNONnXcIbwoz02Nzy+lv35oSJxTbm6Gr/PjJWV8UYvfJ3/Qz8qBp8i72Doc3qg2cK0qH9qz5wNXHsxpLzzUqtEFAhv1rYM/HKpOyeDWpClIRdvqxtAc=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (52.135.233.89) by
 SJ0PR04MB7439.namprd04.prod.outlook.com (20.182.3.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3846.26; Thu, 11 Feb 2021 18:00:25 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3825.027; Thu, 11 Feb 2021
 18:00:25 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: pass bdev and op to blk_next_bio
Thread-Topic: [PATCH] block: pass bdev and op to blk_next_bio
Thread-Index: AQHXAFBIc+4PAxWFdkyVj1j+MFU8Dw==
Date:   Thu, 11 Feb 2021 18:00:24 +0000
Message-ID: <BYAPR04MB496500B96E8EC96D8E94FDF4868C9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210211082656.107505-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2600:8802:2703:6e00:a1e7:39ad:c095:f42c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a6e96ff3-aac2-47c1-d65a-08d8ceb6e859
x-ms-traffictypediagnostic: SJ0PR04MB7439:
x-microsoft-antispam-prvs: <SJ0PR04MB74396F439115DB66C0650913868C9@SJ0PR04MB7439.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:546;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GnzL+mCcuQs75BEGGm/Ljh04+H5snxnJUO9MeVqqlJAu3ijrXjemoWBkOqJHzV+GQtgvMUkSDYYwR+2qUXLbavB47jHAhGSVAyUQsimGOnQREjlc5V6+lf5HI4QNGpzrX0m7vRutJhxMkb1Yy2jsqTIB+m7jVBWNQ5wqt9EZOuFZvfiOywHFewECPJs25JgrN8leOpLv/RXEIORasjzhwPaFf6/c7+wqaYIHWdC5YUHt0d7OMAX06TD/jpwqnLzd62axEVTpDmQLr5jPktU247L1otULsXaiv/WZaDpgC+N1sVJ4CW2cgXB9Wh8Htoy/CRSzdoflsIZgOW5aJpC3pL89G2NA6oE8IPydejUjuU1aQTi4Dd9R7FrjYFznp71lqqTB0easy6ZpAqjBo0oaYT2vJXSQPE8URxyBTaVCwip2NfITJQssP37olGnG8jcwqdwgVaMSU0LOb0kudPFQPrKJLA1Su00yE4vRbEDjnLBNpSIV6zE6cdJG81ZbaminprZyBEvwV87Tk2JZs9ubj8/jO40Lmd4bq6O7bEoPSCtm2pYvppBmZd0j5tA94pi1CVY8D1Sg+Quoyq/qEUmtU1u7BKOiZy6/5wIqYQgt3kQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(376002)(346002)(366004)(7696005)(66556008)(66446008)(64756008)(316002)(8676002)(110136005)(55016002)(5660300002)(66946007)(76116006)(186003)(9686003)(66476007)(4744005)(71200400001)(86362001)(33656002)(2906002)(52536014)(4326008)(53546011)(478600001)(966005)(83380400001)(6506007)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?uK0mP/rPTMW1FNSOg4ObukQNAvYS3GptwIccJbbpon5e5n44rqDaTCiVMxvC?=
 =?us-ascii?Q?LXLJVnq0wg1957XR04bRxpM4pnXiet+1SWYu0RUpRYJbuD568ra8JqpQLaIX?=
 =?us-ascii?Q?gv+5aKG8ijGKxtLW9+ssN1WqUSd75bzxZHyH5zfaLHbSn5bcdCaLtgq8ehxj?=
 =?us-ascii?Q?w0mOrwNfp5f8CLc7gZrtudRWKxK20PgDQ9KRH+BeAWXPu0uLprqG8egEDErm?=
 =?us-ascii?Q?Ru2PgbHpRM5nYBw9S5CEMZj8e47XHNtBKGpMNfcBLURQj0RqGmTfBvGatv9n?=
 =?us-ascii?Q?05YsN+b9P5cy+EreQzfC1++BKLJvHWg/0WsXiKZaGuOI7+YXvHSulzCkGn6A?=
 =?us-ascii?Q?hcqatXBxJBFpP4KUqTGrpio56GLPrtqURSz7AUrcps95GqXMSj18wNXWKZJ4?=
 =?us-ascii?Q?6bNJOxaYev8eEEmsHEkAzPoR8aQJYslIVxhaNF9Nhi+f1FyRAlZpTToWKnU/?=
 =?us-ascii?Q?COQs2HupOHlLthGOatoSOA1sm0roLW0ddbimFI43GmIyC4cMsnn80igIoy40?=
 =?us-ascii?Q?3/w2Ac7zIxgsqjq3fkWAE9xzEIu/aBCg+Xl5ZC1cWQ0RSUroS7DI6lemwTzV?=
 =?us-ascii?Q?CiQSfLefdxFjHKEYhw7kC0SFWixHI5TXYO2sD6CuAR0Ct7cKW82/CuRM6ulo?=
 =?us-ascii?Q?L/sV1hIOzwXYT3m1OAZ6eH5FS26aLpJNN16PyDfo852IUiFXEmo5OpShfbtq?=
 =?us-ascii?Q?9HX80bBl8NFibG5NdYNX2UpOvDl/VWFySGhvZsGt5Or65XfbFjOOPwgpf+/Q?=
 =?us-ascii?Q?PXVmyypVDajXOp1C9BZg3KfafZm7NIGX81sbJ0Dml9KG5yC7p1EkdT+Hen7P?=
 =?us-ascii?Q?G7JQsBU0vOa9XVxRez8za6GEee2QbqjsBXFUt0jfgBxJBRHbbxGz6/4OMCxs?=
 =?us-ascii?Q?+kbUOYQoOnZEb1aISlJwMppgYV7A7ixxk4Hld+rwT62YG3ugy39/JcrdAsnI?=
 =?us-ascii?Q?aD2MY7x6aDBAbpZ1K+JKbMi6N4cBnLxC6FpvlCeFrJUGLdTdg2IhzCWwTS6/?=
 =?us-ascii?Q?oKhwa98XkEUVfv7ahgmS8Ait4zQj7Gt7CmEACFr0+39K5EZShUElj48YDG6d?=
 =?us-ascii?Q?z6arxX5CNNbhjVKIaIoK0AtX3qNKLZOQj08Ic6kzK354WihW+IbJ+eTNKkGB?=
 =?us-ascii?Q?mUUqJXUBiGpsQ6dppiO/dXMXZzIB8sBL3WLd6T34Ntj/4ySaH2xa6AA1TZc5?=
 =?us-ascii?Q?hhA1KA75YDRAkppqj/4aq8bOvDrH6mrR1Eg2KtX8vutpKS0Zprm5FI8E6zBv?=
 =?us-ascii?Q?3n/5mnmQHEPxvT1RHcKiIW431uwuahh+dZD018ClONO77gln8/ERo9abWbQK?=
 =?us-ascii?Q?6Qf09TRolL1doj+6+phrnzbo4q4Tpwrsqg193WblrI1a8IAlWqQkxu9V0yqn?=
 =?us-ascii?Q?9dXcUHcYp0vg6YFXeuUK7H11UIMTxktbykSnbgq2jqHpQ+cjAw=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6e96ff3-aac2-47c1-d65a-08d8ceb6e859
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2021 18:00:24.9327
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sX1RNNLw9PPoqpX6ZJtYoDxbvGaAEyOSx1TIuob7fQ046clVMnUBsoLhSMgDIJ7kDhrtaDobsiKkDe2KT/02ohu51pHbmM/jLM1YYstuAcE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7439
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/11/21 12:31 AM, Christoph Hellwig wrote:=0A=
> Make blk_next_bio a little more useful by setting up two more common bio=
=0A=
> parameters.=0A=
>=0A=
> Signed-off-by: Christoph Hellwig <hch@lst.de>=0A=
>=0A=
=0A=
I have sent this patch in bio new helper series which is posted earlier :- =
=0A=
=0A=
https://www.spinics.net/lists/target-devel/msg19723.html=0A=
<https://www.spinics.net/lists/target-devel/msg19723.html>=0A=
=0A=
[RFC PATCH 01/34] block: move common code into blk_next_bio()=0A=
=0A=
If this is needed should I send it isolated version from that series ?=0A=
=0A=
