Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38292C433F5
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 08:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 226426054E
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 08:51:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbhIOIxO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Sep 2021 04:53:14 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:31434 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhIOIxN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Sep 2021 04:53:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1631695915; x=1663231915;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=F3qdMur+SkulZLV3FeStFgn+ogWx18hsptknOGixRP7g0Xsa1NZuba7N
   FWdGpsaiTyX0b6pAPTwDEPEJ4OygHSybz6j67R/fy/RTydgKOVip7Gl33
   EvsCdyh3jqHVaqajETxwv6eMZeJrF4hlvVq0kHb5BjZZkvigZTJ5/3lbm
   HHuvdt/BeuToEIE6JDFE/1cRC0sZf0X/UehUczEdrv1NBx36xcy2dr/hb
   NgoahjKn1H9HXkWrc/RbvZse8B5B0j9414IWf0VEWbLaq0U3quC5jj47S
   pK9atvB7rnhYTbiKoujcW8iYg/Oe7gHNV2lq2+JG4W/5vo6JTPIbFQ+2e
   w==;
X-IronPort-AV: E=Sophos;i="5.85,294,1624291200"; 
   d="scan'208";a="283846709"
Received: from mail-dm6nam11lp2171.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.171])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2021 16:51:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BWs+VteFOcuwrhFD2rOY3MJ1e7sdZjq5WnhH4KU2F5e9RIQ9b1Bz04B5CTJYqaxXUTMyCkPtxdsl8E4eNdKAKtUKYHlb7EsgBHrF3zOuwdXy/uSS6LpZZPzJzOx6D9Cm4T42tAgiG97ps0I89Iir+Cwz2WTzVGTYf8yEyp5Gm4Cy9L7sYaUcYNnbh/0zvZYJpaEqXrhVP8tbozqmeV5Act6zZ+r3imsMKts9YI82NkbbvzSLbgaZ3jof2xmTq7FwdsZ0RJX2avc1gUQDrdqnzJGWo6Im7LYcZsGQWl7a2EYX4HGiNlpDuOygHfV4P4FpQ07N2IvmdjYgkE2DTq+VAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=MhSRWQ5de4HeNTyV+fn0qsUYoRjhxgjTwPhkfax0SnqknB9m30HRiwcnoZMHZtA5Pv65L33OmSti1bPKx1+Y2FHUUen2mxIgwmLsigg+cgbHCRxFpuo6mAd9fsmFRUDyhSfEPgP9pl0h8Ws5LbXJPGRBwH2/GNvQMSeCANhzDLTHwyA86WFFr4T56/6DttSpQ+bEXgqOrW/WUUXJCz1aiXeNyQwysylNGptTtfa8O3wmWGh1+KvD2Mbr/X3bu6Jr2NOu2HG8gYEGmArOneolPm8VP/Y3yAAc3YUyZfllGE4YpaC/NnYRpLOXIUMe3Guybkcq9alnKJi1Rpcs5PaiPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=S3+scfhvdpYVNBCBlO8bS5H828FVkdIxRE+SXBHqB1owXv1BNEpO83tgjoaB9XrgboQ2G+iV5yG7xAJurwE2W7FpHLCJuu/pE6HYgA2ufGDGiiJJowF572IMU166kOPwkVysr6eCe/oL+D0knEM9k8/171+R0rXzYJsjKDQVrSw=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7461.namprd04.prod.outlook.com (2603:10b6:510:15::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Wed, 15 Sep
 2021 08:51:52 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::5d0d:3d52:2041:885a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::5d0d:3d52:2041:885a%6]) with mapi id 15.20.4523.014; Wed, 15 Sep 2021
 08:51:52 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 04/17] mm: remove spurious blkdev.h includes
Thread-Topic: [PATCH 04/17] mm: remove spurious blkdev.h includes
Thread-Index: AQHXqf0+wgAD3rR9xEKgMN0A8nnIlA==
Date:   Wed, 15 Sep 2021 08:51:52 +0000
Message-ID: <PH0PR04MB741673C707C267B125EA83849BDB9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210915064044.950534-1-hch@lst.de>
 <20210915064044.950534-5-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 30707c19-8a2e-4a5a-5965-08d97826106b
x-ms-traffictypediagnostic: PH0PR04MB7461:
x-microsoft-antispam-prvs: <PH0PR04MB74613F3B5751CADA07E9A25C9BDB9@PH0PR04MB7461.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QMYzC6YRu/5jv2hpPgZAi89SBzU6sTwMM9IEacoTVictVnTfWDjbLTyl0/cols9TNCt6RpYjjxVrw3O/g8wXdbiq6TuUBU5PFNVgYcUaaF8bMKh440gDgGNU71WiXRQi1TyiZjQkfWpEOjW5IAuQJBSqRaCyENrP4vYhyXy4tvgpo/U/w7oxSTKqYEUuSchUfs3lNXgNpzF+bx3z72kWSmrbwSFF1My88dlgawdO0cfbWHp7vv82vCJAkzuc+DYP+enj1DQzG/IqW96/pW2YTLEu1a52nUv+ZQoJSk21tlj1B4TDWqwPZ1mbEfRsgKSXwInyVmuzQMqMI86eEhlPpAhxtT4AAK2+s30UjbZuG/+j4Qjew3WK/qza34t2JP5oEIkII73qiCz1nIJEdX8hzQF2n+rgrqj1uks4oceVmBqnpNZger0SXzUdBsnXw1k6lDBMKLoQROou9UKl529ieZumufKQ/BMmK4SmxdT6MjKAnu/eYMTnqQSqmucIhlhLabMD4WJE27C87f6xP1c3dabqUkRhQH+W6blCZL2JpTiq5EO8kLHuYtRzRDqcuzSynyKElNU0ZfSIB0D88O9DxzfUH9TFHrBeK+DPJyOtJN9TETyzCVfZvCZaWD2IgcIlT4K0CZqyNgZ2eR9F3YG9WT6FmaN7yN/3yYzEeigoX+U3wCLD2UmiF4QvBG4CEeEf8sxf+TfWURE7eUgxM7JNoA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(66476007)(316002)(8676002)(64756008)(4270600006)(55016002)(66556008)(558084003)(7696005)(66446008)(91956017)(6506007)(86362001)(54906003)(38070700005)(122000001)(8936002)(38100700002)(33656002)(9686003)(508600001)(76116006)(110136005)(4326008)(5660300002)(19618925003)(52536014)(2906002)(71200400001)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ghpC7KmC/REJ5jgiHtxSOTb+dKRCECCsvA7UnYEYZI2jQb21DmhrgKazdfMM?=
 =?us-ascii?Q?tH5Goju1tkBsOVNEH3oT5cGWIBambuxeLF6A3V9exbTTEE97Dd7h9XhYF9HM?=
 =?us-ascii?Q?TZ1CuErEjnQBQSHDUSvqVBJ2/2n0KAzWiVkS5gUiSChkq2dslBLlbJzxsgvu?=
 =?us-ascii?Q?yotE3y2dJttCdjBIDRerHxbrKST2LO9cMzulZmsugjoMoKuIjjEZsnobIRqF?=
 =?us-ascii?Q?2F65HALPyRk/n9+4mGyV1hUp7KGc25kc14yAzud1VMADPWF8cKDVb+peng6V?=
 =?us-ascii?Q?aSd38209ejnL0NafFQ5upJJRHCoWgmJS3aJXwvSfyx34vmzbdzohtqsWrN6d?=
 =?us-ascii?Q?P7YSfK9w0P2ABPUbr79NvcFUyUvqno9jKwlwpd4XxB+IpWxa+nEIJNH0VA+N?=
 =?us-ascii?Q?dWsSC6rLaX2g+hYUAKmu2NrBv5z9z99qBONEByACDIOJWla7tfjiP0dx30zN?=
 =?us-ascii?Q?9k/XuB5jncgrTz6rBeQQXjNq4r3L55cZyNkhKmTssQrIYtNppFVMcf/9srpX?=
 =?us-ascii?Q?xy3O2xBTovYIQZkR+ZxTcfRAB7AGETTN6+BjVI77+l3rqWuH/Nq2bF/0GYf9?=
 =?us-ascii?Q?YUhZovdzXsNhJD2HfHXA5Hag1++YeqQlNhMAPmsklDI8qcRwUbL5g5Rwwp2S?=
 =?us-ascii?Q?aoOjH6aXaHs/D56aLAF3+iUjddY66AIxWVzTZmSC1ikH4NvA8JQlQ+Jetuh2?=
 =?us-ascii?Q?SXFtslzNiUI6MixOPDa1X7ke2WfipfZW1VIA9EEgXNjekroif7DDNP+Hd+0h?=
 =?us-ascii?Q?ln9G7/iHPDPTxLYoKXs6ISSA6QOF2353ySS+CeLzRBUjYWsap4UUHgjGZet3?=
 =?us-ascii?Q?mPf6AmHqjA9IvOSlWOqbWfmjWuCyU/WBb6Iuo4AA3I5J1wFpNg0us8cEpB5e?=
 =?us-ascii?Q?cFH2zZUXS9ALCRA0eEDyBAk64qAUJctw/CVJkLWWGvAD3dxYl2LtzYqLdlZw?=
 =?us-ascii?Q?YfEb7lWPSTEY5EDhEhHcC5LyolQZwD3LYT/lcAlIyGqI925xksmpm49XgKaW?=
 =?us-ascii?Q?peKKvwnhrbumxKl4c4/smT1pjDPG4MWdARmlk1IBVOjrZY6sV5ISq9rHW3SK?=
 =?us-ascii?Q?NvPyZaNKeP/ZRW74H0Gfm5DGi9fCGknfEikmaO/FMiAQMwYbh97qxv41rRnY?=
 =?us-ascii?Q?6/GNpchuZn693eEtUyAu79R0CDNsg6I7UtFp75UIuQbuAV1rQy8HqZOUcAkb?=
 =?us-ascii?Q?JtYxhX5EdxwuCJ12lQHl9vsH0e8f7H047+QJ7p7orWulfCdzSqxmkjtD7If1?=
 =?us-ascii?Q?XVucZbYFdcAnaWVzYRF1i71n/VAKB3zQ1hyFT9w5ZKmXXomoSDNQuNqT/otS?=
 =?us-ascii?Q?p3C2sJnH028gn7fEhqfKFV+63xExYIuwKCr1sUhFJ4F0FpAE+q9sqMhM1ITH?=
 =?us-ascii?Q?kyBVR5+okKYOr3hMK4LVgDRAoZbaYIjNmBOSDnulb7jgZixnCw=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30707c19-8a2e-4a5a-5965-08d97826106b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2021 08:51:52.7613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SOamLVWjcl+ToKkaHgi5I+FQouUK0ENPWqzB+XNp/OFMNCS+w9RDanJookZAXNuqUjZzdg10ky9a7pRzB3Ct4p/7/tcGMzOgrv68o4Nl4G8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7461
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
