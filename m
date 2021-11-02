Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0612BC433EF
	for <linux-block@archiver.kernel.org>; Tue,  2 Nov 2021 02:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E290360EBC
	for <linux-block@archiver.kernel.org>; Tue,  2 Nov 2021 02:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbhKBCYz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Nov 2021 22:24:55 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:35393 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232607AbhKBCYx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Nov 2021 22:24:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1635819739; x=1667355739;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8yEJzFUSZrNiSsiAcx/OYeIoHmYqck+66kmOT1WJX3I=;
  b=jmT8qwP11WMnuGhb9BPgthp54s5AnkkyYK4VqCYSn7sdR1beauzhG77v
   vqbfI0UMKnkQqrsKWNtUhB5fjKnbCPurmQ/wfg3ae3xEKTqgJJzJsZUxZ
   OnlG9JgpNyE8ZH7ob6UF5QuLcye5hBgG3t5lNyQs1M2lNyZjLLioD8sUE
   dnW0lWKSttzwbaKxjM0e7onuqzsfWWR6I8mrCNdKXKocOtUkZmreFRYZh
   qLd9p0pc++Wb3mulAlS2rMvj1EuryPMWZ7pqPjHv8efnws9MRldBgYeCq
   yo6eT4IIT9EKwBSCRih20YJSDLs884BbUjSzoNAfyjjJm48L/w6fGeV3J
   w==;
X-IronPort-AV: E=Sophos;i="5.87,201,1631548800"; 
   d="scan'208";a="296205400"
Received: from mail-bn7nam10lp2108.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.108])
  by ob1.hgst.iphmx.com with ESMTP; 02 Nov 2021 10:22:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dZOTPRoq5osQc44IpY/nMoc4yBiKD5uUa5Huwj1OMxJsQZixvvB9OIxuPMKTANdIQTvWsYMJqNRPxez3RDQFGzc1E3URili0vxjGKvmNTdDbsfPTriAKll2vBS9TECm1icESER+7fkiZ7njJLQ1B/SH+bbLWEVxPolFROz2OATQhkeKn8JKXSV8Dgl4U3d74z4ZGDr9GszJEIRWHBNng5TggWoyNWNB+bV8ob64BvnGt8AmXI/qbWLOWV3HxMq+Y1llRNHgbdAQJFZzij2DVWepSaaGazNonGIj0lZKxrnxGDvjJtwgH1+lMYTaz13AWHC2gMZY+HnYhfofzbBF91Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8yEJzFUSZrNiSsiAcx/OYeIoHmYqck+66kmOT1WJX3I=;
 b=gnHRbeb2/DurQz5XumgaS+PgdPO/9+3gW3VixMC+HJRQUY8C1x3COXo3t414VWoC4Se0RoxPBsA2eGvMmP5NjnkV6RzYF3YTFYKKj9+kLLUls2PMxYof8Eal1+O2RSPmYr/xAn0w4Ze8ANSdewTM53xXx0n+uVY4u3iKMp2w+McFiKTIIJMgGtVPCPRVMLfo5hdbhT3yETJPFRQsYJdfkEVt+zlTcZtCN+36Q+AhL7t3QtIqMHW8M/bjKGGm+Yp3bh4hfvAOoI4iVQ7PE6yo0lJN9Wg585xReO3GVJ0k6r3mqppxXhnKdia6zOEMZarBmt+/zLF703bcHJ/ibwqxZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8yEJzFUSZrNiSsiAcx/OYeIoHmYqck+66kmOT1WJX3I=;
 b=QjxMADFvMOzkvSimrnQJm/PVL0cG9WLPZqHE1Ki7OkSAFmqMmzEMydbv/4lXVwMLseNJm9Mj7bOv1mP+7Ka8ZxUCBDDGncDW7cWGKkLAogd7IY4MYlLV5QQPxe2MrFvTtdyAqVHlxnOrvEY0lS+5lG8+02U0UrGVk8P9UkTS2Vs=
Received: from SJ0PR04MB7184.namprd04.prod.outlook.com (2603:10b6:a03:291::7)
 by BYAPR04MB4390.namprd04.prod.outlook.com (2603:10b6:a02:f2::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Tue, 2 Nov
 2021 02:22:15 +0000
Received: from SJ0PR04MB7184.namprd04.prod.outlook.com
 ([fe80::49e:8e59:823a:fb61]) by SJ0PR04MB7184.namprd04.prod.outlook.com
 ([fe80::49e:8e59:823a:fb61%3]) with mapi id 15.20.4649.020; Tue, 2 Nov 2021
 02:22:15 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [bug report] block/005 hangs with NVMe device and
 linux-block/for-next
Thread-Topic: [bug report] block/005 hangs with NVMe device and
 linux-block/for-next
Thread-Index: AQHXzvtCAnSg404Q90iJ/hTDak5dVqvunZKAgACtRQCAADgYAA==
Date:   Tue, 2 Nov 2021 02:22:15 +0000
Message-ID: <20211102022214.7hetxsg4z2yqafyd@shindev>
References: <20211101083417.fcttizyxpahrcgov@shindev>
 <30d7ccec-c798-3936-67bd-e66ae59c318b@kernel.dk>
 <f56c7b71-cef4-10be-7804-b171929cfb76@kernel.dk>
In-Reply-To: <f56c7b71-cef4-10be-7804-b171929cfb76@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8d9604be-37e7-4f36-3436-08d99da79679
x-ms-traffictypediagnostic: BYAPR04MB4390:
x-microsoft-antispam-prvs: <BYAPR04MB43901DC8D23D286DCBDA2B4DED8B9@BYAPR04MB4390.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YWxk3w6N/JuUbt/+BQbG9xI6Z3dObaD1XEtndQsCEebs5MTmpHvOHgFcU5+zOq5LaiT45JUtWHh/KQU0j7/4bi/VDB+HnHVzGirbXhgPDVRt831ExxRcq2VvFHGijQclIpyhFvU8uHI0LP27XIuuA48sZ3gdij9qBx5oPihw4xL31VybJB8RKPMj7jBBUnrsB94x0ZDilk51D8eBYVlmygRIKAoMT3i3aRIVan98SPASMGwi//ZyvMfyBd/5TpPQIMTJlFOBzZW0w29b02XeGwea3uY9FP3xCZscWjLlLXY7ThP5Sl1cSVnpK12YcIo5VhB2HjMyLhgNCp3qreg5NtVGrKBxyBO+3p0HP0RosCY3vAz55NsfF1KOcsYhYVqfeeNsagvCKeXQAwfxC3Vc7fpuBlJBakVHyIacYdnVArbrNyb7hKZoF3VZxvA1wS6PIpenSdWc74VjJpi8VmO+qOlCcoMV5cshOocnmBgbkK+MKPx+eGdSKmPXaMb9BvF0iqev2F7gLWPlbhe/7IMH7yd/LlWwukrYMaRILbF6fvS2HAoPTGaN5DUsD7XcVR/L5qfKsu5fmhkY5LyX+iqp+tBIRMYp7eZ+xTjM9gF1hmIZzEefACLUKzODJzKtFJiTi0/AO0qgekPh/EsMy4IHiejqvIvG9nXhDwZEcsxSmwMf8wsuwOh/RB5vMkQrhCOfepNG5wieJlrM8gYyb2CeXYhs/PnbPk7umDb4FgU5pQehbMRY9VZOlrIj35QYKshW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7184.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(366004)(53546011)(1076003)(9686003)(8936002)(54906003)(6506007)(33716001)(186003)(38070700005)(5660300002)(316002)(2906002)(6486002)(86362001)(71200400001)(4326008)(8676002)(508600001)(66446008)(76116006)(66476007)(38100700002)(44832011)(26005)(82960400001)(122000001)(64756008)(91956017)(6512007)(83380400001)(66556008)(66946007)(6916009)(458404002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3n2IgaP/4I/NVGipzQLKTk0e8zoHa21Gr9SxN9PyTfUfOwvdGQx7vFpXtHg1?=
 =?us-ascii?Q?7qZ/H5UIHrk/9OlPOOdVZoH+KS2yg0MIq9ei/wZFxKGto3Ssao3N6MXNv3hD?=
 =?us-ascii?Q?/+AJQY0RFTlsImSf3SlVmrtzgMYi0gY/sd/4co6V5Mkyfp20uQxUdzr/u/jq?=
 =?us-ascii?Q?MoYZzwma35SrtvYUx2/Xbwzv6d5qhFNnSvEWoqBHXnrLWyiQdSb7N7GYyQGB?=
 =?us-ascii?Q?VKDHrNsRRX/wnWkwWzKkcG5ZK6Iae27WSwxdW2owtoOWk+/4Md7DkhUHmuxx?=
 =?us-ascii?Q?BluS0dmNjuNQeFS7iHMSdjOMXBXhZToD/FKIqOv++U+A3NnMhMkbsBurJCWD?=
 =?us-ascii?Q?xTYVZPOmixZMX88N3giwJwXmRXLTYf+sLrDEPJBsg9O97a+MpsLKU4y4uFSK?=
 =?us-ascii?Q?hLTa9ywoqCHiEPsROX6OG4e7qqXB8n7UBsDmTcXGoV7FZ1oSnQ2f7G6woZOT?=
 =?us-ascii?Q?5g7TlxfigjMJ7FvMQYhgFINkvlWFCShBpopi60qId9TQVEjCzlQhFv08Dq/i?=
 =?us-ascii?Q?OK0WavTNeyQnfUJpAHY3IC+a0hxPULiRQMKDv+ieNcEKHzcxuwbTaG1wsiFY?=
 =?us-ascii?Q?WqKVoj7MzpoIcPC+uzo8G6P4DIBJpyblnE48yANWxvqLlzQRCPrv1ou95ZSZ?=
 =?us-ascii?Q?AUBnlOlPlFSiIJY3Juhz+Myfn01elF3+nVcQuMAdLpR2sjUq0hdzqZR5bZ27?=
 =?us-ascii?Q?TOSNZewLR5/yOJOASPo3NftKlFSVUJtuKedhC5QzT2Dj1gp51RGEOCcTgxvi?=
 =?us-ascii?Q?1XKsycGhFeC3Y4t/Ts4pk6MXZykARz65vGUyErkXEYHA3P7aiSam3W+uz4XB?=
 =?us-ascii?Q?d9z/FdqCF5m7twhY7wjj1tFFO+7wVZ8utLc+q0Q97IPoEQk3Nh67QqXszV0i?=
 =?us-ascii?Q?qbeNLgzdYLpxJF2rK6iQeJvWSjf9ME4SyoMV7iDcg8rO+NksztbyE/eBaNo4?=
 =?us-ascii?Q?rufM9nEFmiGzfPkhgrxrUomegAPh/hFfd8bWnXbG6Dezwar6owMlTj1gfu3h?=
 =?us-ascii?Q?dDaLt/yZCqUfKvB7yvxmG3M/NBiGJ3ipoaDK1xvL4U+MCVHai2Xe/wgoiGSD?=
 =?us-ascii?Q?ulIkTxzMc6EfEChs0+zKlRoCm3snLicp4BMx8AesTeS5Zq7ZUxEwMfnuWTsM?=
 =?us-ascii?Q?xIU/ysgaLC44YvytYzCpZf5np2sXMGA1yeBEFryrEzJpCasayQgaaOzVDRx8?=
 =?us-ascii?Q?t+kpeuGx9EqLDfTVae3Dq0a9CRviJJ/gUzEvHWkt/GiEmf598FOmhntihlD7?=
 =?us-ascii?Q?6qlSwqzVY0Tvqd2I3mLoq8rTMpSAJv8b1vOfVlb9+1vfYk/+STubfa3c4Tzp?=
 =?us-ascii?Q?suADr3OaJO/JEjwiqnR7M7BqDMuq1Bt0Wiz8IwSPPeet/YhvaL827Yg1EO12?=
 =?us-ascii?Q?bYxAu2w3Va93nfOVAVlMs6c1hfwF6yYuIXEX9tJGQsYwCjLK0LqknjKQacOv?=
 =?us-ascii?Q?4qzyCwDxWKH/agP5DzBRGOzvCVgIg+7lSJHJemtpgpZpfZ7kLnfgQk6HIh/d?=
 =?us-ascii?Q?k5Uax98r6YZhq96vLw8vs9R/z4zFWQ/5aFSdntB+fBFCOq7vpz2saCWWvsOp?=
 =?us-ascii?Q?xsFysVGPkmKDyDly8cLVPrVqGiw3SdvXyVlXxq7oCJh6YrzvKi/sLtpX4ToQ?=
 =?us-ascii?Q?SHzjRKf8EJ0tVuZtT89XQk0Grfu0FcAZQrV3zIJP794ubBsOJkKSFoyeAhmi?=
 =?us-ascii?Q?PYfi1fbZ5i2qVtHwpQjPf/ZdOts=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D7A8F9BA1194C843873FFBCE067C6BF4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7184.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d9604be-37e7-4f36-3436-08d99da79679
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2021 02:22:15.7428
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p4I3M2nJNkHd1o5jSAb01BMOTjueQvzJ4t2i+wVFGEbDmwWEDOzRT/6jHxNr3iyGOpPFmFXIMKChfVHWwRLmzbS+UROJ7hVj7iFb0XuA/7g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4390
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Nov 01, 2021 / 17:01, Jens Axboe wrote:
> On 11/1/21 6:41 AM, Jens Axboe wrote:
> > On 11/1/21 2:34 AM, Shinichiro Kawasaki wrote:
> >> I tried the latest linux-block/for-next branch tip (git hash b43fadb66=
31f and
> >> observed a process hang during blktests block/005 run on a NVMe device=
.
> >> Kernel message reported "INFO: task check:1224 blocked for more than 1=
22
> >> seconds." with call trace [1]. So far, the hang is 100% reproducible w=
ith my
> >> system. This hang is not observed with HDDs or null_blk devices.
> >>
> >> I bisected and found the commit 4f5022453acd ("nvme: wire up completio=
n batching
> >> for the IRQ path") triggers the hang. When I revert this commit from t=
he
> >> for-next branch tip, the hang disappears. The block/005 test case does=
 IO
> >> scheduler switch during IO, and the completion path change by the comm=
it looks
> >> affecting the scheduler switch. Comments for solution will be apprecia=
ted.
> >=20
> > I'll take a look at this.
>=20
> I've tried running various things most of the day, and I cannot
> reproduce this issue nor do I see what it could be. Even if requests are
> split between batched completion and one-by-one completion, it works
> just fine for me. No special care needs to be taken for put_many() on
> the queue reference, as the wake_up() happens for the ref going to zero.
>=20
> Tell me more about your setup. What does the runtimes of the test look
> like? Do you have all schedulers enabled? What kind of NVMe device is
> this?

Thank you for spending your precious time. With the kernel without the hang=
,
the test case completes around 20 seconds. When the hang happens, the check
script process stops at blk_mq_freeze_queue_wait() at scheduler change, and=
 fio
workload processes stop at __blkdev_direct_IO_simple(). The test case does =
not
end, so I need to reboot the system for the next trial. While waiting the t=
est
case completion, the kernel repeats the same INFO message every 2 minutes.

Regarding the scheduler, I compiled the kernel with mq-deadline and kyber.

The NVMe device I use is a U.2 NVMe ZNS SSD. It has a zoned name space and
a regular name space, and the hang is observed with both name spaces. I hav=
e
not yet tried other NVME devices, so I will try them.

>=20
> FWIW, this is upstream now, so testing with Linus -git would be
> preferable.

I see. I have switched from linux-block for-next branch to the upstream bra=
nch
of Linus. At git hash 879dbe9ffebc, and still the hang is observed.

--=20
Best Regards,
Shin'ichiro Kawasaki=
