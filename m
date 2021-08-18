Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D60EC432BE
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 21:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C97E610FD
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 21:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234121AbhHRVye (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Aug 2021 17:54:34 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:27614 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234009AbhHRVye (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Aug 2021 17:54:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1629323638; x=1660859638;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=CtK0GF8/VEBLPS3CjEAwT5eu6sFf5d7Y4pYLpk0ums4=;
  b=eEkGU5Pvfqx8cwNEB/8Xio451Oa4ja/8JEI2F9I3zShbpzp9iuCoobUc
   bv8PVTeJgA60px8rCeeC0elxmj2msQMYdADdshJhBytDcLb4U5E2Ue3v0
   gt+iUdI+CCzkUZBPgbCSsnpQr/K4EOgYMAhwOvHrwDsvMNvLaUSuIZDSh
   wRXFgu4SD+gIZ+65c6MjipoFUmlu6A/LOGKd9CpbqdoYV0aQ/zXan+vaX
   VfXygAs/QDjPqAMc80whnIN0On5/frHxAw84oqb4JS/boAxPwyraoyiKC
   P7uIladmq38CYPIOpfnye2adCTAVWsbYCQ75G/NMH3ShFc/mqMtO5i3l6
   g==;
X-IronPort-AV: E=Sophos;i="5.84,332,1620662400"; 
   d="scan'208";a="281510240"
Received: from mail-bn1nam07lp2044.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.44])
  by ob1.hgst.iphmx.com with ESMTP; 19 Aug 2021 05:53:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a1TFIldNS/MdYjiu5imbdMRdYPcAasjMhUyYbUXi9cFHKZ3cO+PYJr+n59nQjQkpAoWOPv/RMClCId6Cy4bwi2lC1sFjXRnSJI4FBc3IobRUNlR72fUNYmTgq/CAPNgoQ87Ct761GiPmsWFoZCryKHiKeTDjkc5Jw7MG1mZJUiD/lw+matztIzgE2qg5xdm5S1rX4VYeN02br4M6k/32Snn2twvExKN+j/iF2Ke4eJt8zKW/w6i1mv3HayQd99z/Mvta6HmIv3d3ORurnZBbj1QFxDM0Mc/DQBC23RjzxeQ23S/f1tJpAU2EoiixxuQH46T8r+JqeyqSs/2HaKjA/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CtK0GF8/VEBLPS3CjEAwT5eu6sFf5d7Y4pYLpk0ums4=;
 b=mNcuEi7BMwV+nuCIndD0KwTHEdErTGSEs1pwlA94seg4Zz5GjBX+EhALZ8l0CouMfTsAEXk3ffTcWIVJsbgL+rKcMykAFjYToRXmU3seHBOb48LkHkPR5xl3xTR+jBOpDaaOeLB2VmHVVL6ENVzYYdHfc9jWrlUVkA/QCUsJ0O6kVIN9yO+RGokEk2H71QGLugF/wIadQw6CJvAbyMzHeweemLgO1fz8aMTQirEwjfDKr1S/SoZBNc2DGTsbtkv1SGZt+pmTiS5+W6bx9AFbTApRKkY8gfm3y+xU7EFQhUkqdyA2CaZzWSEddJJL0oVWRLk0DhfTm3eLCpkoYiu1dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CtK0GF8/VEBLPS3CjEAwT5eu6sFf5d7Y4pYLpk0ums4=;
 b=ry5S/jrRwLK1Vutl83v+lFCobGPawzJWFUfDXBR0HtHH28LSxh+ZlY3hzItXsiHVZpWQMepN+QqWFgWxSK8wcmgQ1BhQATY8pIPsKsQuo/gq87JER5euiV5xDBjY2IcfFMML/Hn2anG+48GshaDLnCYg0zjP1zcw9w1dtXQXWjU=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM6PR04MB6826.namprd04.prod.outlook.com (2603:10b6:5:242::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Wed, 18 Aug
 2021 21:53:55 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::e521:352:1d70:31c]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::e521:352:1d70:31c%9]) with mapi id 15.20.4415.024; Wed, 18 Aug 2021
 21:53:55 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH v7 00/11] libata cleanups and improvements
Thread-Topic: [PATCH v7 00/11] libata cleanups and improvements
Thread-Index: AQHXkkBXWeg42l5KDEqQ7BjXTcXjqQ==
Date:   Wed, 18 Aug 2021 21:53:54 +0000
Message-ID: <DM6PR04MB708157194FE47BA249DBBA56E7FF9@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20210816014456.2191776-1-damien.lemoal@wdc.com>
 <18c2f2e2-b7b6-b8b8-35ef-89ee59001cac@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c6b3b268-e7b1-4b2e-eb23-08d96292aca2
x-ms-traffictypediagnostic: DM6PR04MB6826:
x-microsoft-antispam-prvs: <DM6PR04MB682660EF17B28979C0D17655E7FF9@DM6PR04MB6826.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9ji6krikkCipg7kN5q39X2HWXhXTY6La3apiYaI8YVyAtaDwQMmHvSXzGD2L7At620fEhFY8+Eqt48GrFUsfLKoSzqe6VkRYKfZ5PYw/VyahncpZQs6X08YWxpn3L5dppLJhxzH/qcHP2/bQBTlL8CmPkutmxPKGpQtg69uokgvl+HZQEp3Zxtp+3EoGlqEwijkmao8mtqtnk/7fE8tkAnWtzdzM3Jd8fQuMr5uUypr/MzxWmHYI0sEIqiv6/K7hJZRzcJZ5t3nigBGN32gAi4c2XxAsqBJqsQwom2FSThSVtNMN5lM3Z/lltI3NqBoxM8skeaeL+VVPws1l7i9GG0LOY2o3yfG2xNXstLLs4qaBwJbK9UJsWWKuCSD8ftxiWolU3Y9iW2we99gkXyyQIAOKkox7AXgJwojpJ+8PDpuAyGT6+A5iEFcHFfjWWdnq9LM2uieODYGTpdvvDWSGFAdTl+QsDRXeNC2ZNy6TwDFIDGWzOHToaHCiKGzJPLLMCDpC8AyK/cnZTc5DT2f+fx3ousbr/uH+X1dgH9bkLXlIWIrUk8V/S1iZw9PTfwDXAVruMfTpwjw3Yfe9jKh3o0NB5dZgNFtfc9x+O/ZaYm0ftsAfOk3P4cLtltkZo6tTF3pnBOXTd+36I09djZ5TpJWSGCf7oKAli7mqLu8DyhcV4iTL9ySfLvGy5ZTQv6bdqrB23ofxRIgpxdNbnULaPw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(366004)(39860400002)(396003)(66446008)(76116006)(53546011)(66476007)(91956017)(2906002)(110136005)(52536014)(7696005)(38070700005)(66556008)(71200400001)(66946007)(64756008)(83380400001)(5660300002)(8936002)(316002)(4744005)(86362001)(478600001)(38100700002)(55016002)(122000001)(4326008)(6506007)(186003)(9686003)(8676002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ssYBPoi1dt+ju9XZ3/n+tyWYho6xNRTfG5Zzw9vQ3MgmcS79YR42h1xENbUG?=
 =?us-ascii?Q?gWTM27Y+Em58vAd1kj9b7RMvFxS2CpEcEy9OnwCkDg8u8VW0njRGcogK0Dge?=
 =?us-ascii?Q?FkPtFDkvAqcli4LYiCk6DCuKFK9AjXJYP8uI9kBz7GaYsqSapMRE9mtc000w?=
 =?us-ascii?Q?70V3mG2q5pO6MAygjkL5EHK/Fv3U1+FwDkZB2OmCKxGKdqHQ6C7iMtnILgau?=
 =?us-ascii?Q?6vWRKVrUq4VzvdKI8GtpqtIwhRe04iaNHQHi/pHT+4jq+e0FUlImCuAd1rD6?=
 =?us-ascii?Q?R6gckXQVqzdgTNm0S5+A1s+7QpF4oOKxCt0S7QKm91qf9TDKfldorW1gv/Sc?=
 =?us-ascii?Q?YBy0vL+eO35bpXWQaHzHnqvN0MNvuRO2YAp1BhZorW5I/guXd9ixUoDwGulv?=
 =?us-ascii?Q?0t1dYg6u7ZPRkzC9grIyHYeXG55sRh7ni9zOBFo7wUXbBA1BH3C0+YvLrIrN?=
 =?us-ascii?Q?tgbKsuU0gUNC2R51PzrE/tmovVT/RMDox04axEVX2d7nb4BODBzkYBaRp534?=
 =?us-ascii?Q?a66kqc6SQe7cQL9SkOTVzOPyNoMeS1xznu7Jvhm41PKq3c+IYKPuCN1GA2Nz?=
 =?us-ascii?Q?FNFH8RE7hUucLXogCRmDkb773MRIoYmunueRn212YT53sWh7K8OBNaniRJbo?=
 =?us-ascii?Q?Wef9g7DpV1NXHiHXDGB290g5zvaw5NlUPKEtZsseZwmICPKgfOQ+k32xZOtE?=
 =?us-ascii?Q?5zcIsX+fiVNFcuvR94+sSzuH6LxdwWZccr3Y6xGQrUCmC3UcPaOIGySOLC7Q?=
 =?us-ascii?Q?OmJw5m25pRX/JQ0NSNU7B3p4lo0C96KtiAY8woEoWJj3BZg+GwjMltFSWBGV?=
 =?us-ascii?Q?gSzT2Elg4zRHfFLOP/tKAXJk7cD8T53BNR9Kh7in2ro56gESzWpxZPruURHi?=
 =?us-ascii?Q?57mEA+3UxtFAAEX7Xq3SN8+Vk4xv3KWxi7KlBE84XufrXvAMJIYjaWLGiey9?=
 =?us-ascii?Q?3YdbSwoi4TzgffwQEOoAM7EBD6tginYFjT5FhfUMB91SHV75TNX8CVU9CALc?=
 =?us-ascii?Q?iCHGW9JA7ZG7/bXu95x5aTak5OzSoKZ8/J4CBno4UPPjBXlxqlzHo6PsK7cv?=
 =?us-ascii?Q?bFaB1auhURpWPI+PeS7vJ9OwwlTdnx3d3YOdm/aWZBAGPDLytzKT1btYUH3v?=
 =?us-ascii?Q?MkCFQghKy5pdJcoS4WhA4z5EYwM1797+4xXvSqaSAW9pwQpMBZ1SeFHyi5aV?=
 =?us-ascii?Q?MmEwJ3ALs3bg5KoesH4OfqLmoks7XKDFApzBPmGqwQaYjRcjX3/YK1yXELYB?=
 =?us-ascii?Q?Kap8Gd5XhfnuypV6yfb3ePXR2pgKJmTTaFsBg+m1oRnoZhMboZeIrpKOHIiZ?=
 =?us-ascii?Q?925ioQhK1858J22PBQOIUOK5z37RMrSDsZvUrgXVlX4U5WBDnGGwzraygb6q?=
 =?us-ascii?Q?yRm6jko1gdvpqtJXhDaVIOGRb0Z8l/rBFUTbM1l81xGJ1KN3Dw=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6b3b268-e7b1-4b2e-eb23-08d96292aca2
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2021 21:53:54.9526
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yMNKL+K3HIwjPXY1gvqemKF7radHr3tXfHchpGjrV4kXptPCgsjzGq5vc0ovAnxYXq555jJueN1cMYxOwTdtMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6826
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/08/18 22:20, Jens Axboe wrote:=0A=
> On 8/15/21 7:44 PM, Damien Le Moal wrote:=0A=
>> The first three patches of this series fix sparse and kernel bot=0A=
>> warnings (potential NULL pointer dereference and locking imbalance).=0A=
>>=0A=
>> The following three patches cleanup libata-core code in the area of=0A=
>> device configuration (ata_dev_configure() function).=0A=
>>=0A=
>> Patch 7 improves ata_read_log_page() to avoid unnecessary warning=0A=
>> messages and patch 8 adds an informational message on device scan to=0A=
>> advertize the features supported by a device.=0A=
>>=0A=
>> Path 9 adds the new sysfs ahci device attribute ncq_prio_supported to=0A=
>> indicate that a disk supports NCQ priority.=0A=
>>=0A=
>> Patch 10 and 11 update the ABI user documentation files.=0A=
> =0A=
> Applied 2-11, thanks.=0A=
=0A=
Thank you.=0A=
Please note that this creates a small conflict with the libata patch from t=
he=0A=
crange series. Do you want me to rebase that patch on block/libata ?=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
