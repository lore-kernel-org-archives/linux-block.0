Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5181BECAAD8
	for <linux-block@archiver.kernel.org>; Wed, 21 Sep 2022 06:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbiIUGtS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Sep 2022 02:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbiIUGtQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Sep 2022 02:49:16 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196BD80F60
        for <linux-block@vger.kernel.org>; Tue, 20 Sep 2022 23:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663742951; x=1695278951;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=IGJ6AccGpnhw5dXwqcyFSD4XoIt549AL+fF1sx4Ujbrh/SAPNKq6YxOp
   uz5Rm6sbiwYxfOXgiBJTVfoqxNqCAc8jjppGE9hCjqNP/+DC/EO5FuYXx
   dAjy8bTFGTDRfkZXh0shs6M7rE0KATZYzLnuQkA/a6UQ2DIOtPwhX1aRZ
   UwcXYL/l7pGNlhb/z4yL075cDAyhqHdXauSJzYhFN1++DzgLhRnTYbHoc
   8dD91x1tcx7RhNU/FYavubgS3NioXqyOQhGM2ox03G1Mecy4/bd+H9tP1
   cY/oHA9a6r3hdQwk+Jh0v0UHMNiHcQpoKH8ddbE6m/49+fjF0sZ56EIcj
   w==;
X-IronPort-AV: E=Sophos;i="5.93,332,1654531200"; 
   d="scan'208";a="217062547"
Received: from mail-dm6nam12lp2172.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.172])
  by ob1.hgst.iphmx.com with ESMTP; 21 Sep 2022 14:49:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QEC+GdlgX6ndRd3FxD4MwyHcjSSVtYeUrwKLnWCR7Tx3wTQN81u0MckBRSlLbSHMm2duelj43jSGoSyuEa2VuxGtHZyCjMGekEfsJ8q5Zv2eset5WkhwF5hOxMbIs61p9HNOdtlCnXS2w+Za4YE1OBK5I62MZ/1WCPIO40PLa9dhoYzIhQSE0QTPSin2wffitplVMF0EAMDBLislPvrhk5PPv3zF0Rpzf2LazY4ZTBMrfqv3/+8gzh4Kl/XO/WpeO0FHGtX1ON+7PwtOt9pUDHsqGgZY2wI+o68YBmKAnsu7Q8Rmx2HpRxFfUd9bKs1NSjEJXFBYuUQRQF5Fm4/zlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=I/nISYC8Spo4roZLikCnSTgwHVPZNDiUgaHKR6ZyUoyeoIsB6KvLQ8KOjjrge3+pd7Hn8O3IVAYgyzs6Se4zEoAv0XxJXT0M0nn5MohQsTWy6nQ9i8Dtq192J1tGTS3ek6SRu/6gFM4y2CLVcHFnr2ZJCOvfsUiYFUogoKlDlXlAAR8PZ770wznIDBaFvs0NcmZpI2f9//27Xf7JjXTpQiO0xd44IOSiJ7eCQZSBWUkjn1OzWCeFLwMAaoDHIsN+rXlJJlBo6aqPyUbJJcPIMmyX1Tte+VqkbWGxqsMuG5R7tnpUaCmxZeUWqHOpOj0x9RnolVepCUTPUO3EfKOTkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=QPYmJKv4gCVKS80obWHfsLXQIWXaKO28ko7FKOYoc66XEIT+uvWd1igGDEKA7NMjIVfifZNJmYUaAJYbava5atuScdqrpNfgBBdkarOHxSZioHOEYxSWr22/7XBPhLJQxe1itZb3xeXJ5XKWDXltgtcMocr0pkCcxw33OGUH+s0=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB5610.namprd04.prod.outlook.com (2603:10b6:5:16a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Wed, 21 Sep
 2022 06:49:05 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c%6]) with mapi id 15.20.5654.016; Wed, 21 Sep 2022
 06:49:05 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH] block: Fix the enum blk_eh_timer_return documentation
Thread-Topic: [PATCH] block: Fix the enum blk_eh_timer_return documentation
Thread-Index: AQHYzSyFzZVMskMDnEOWzI8Ra0vLnA==
Date:   Wed, 21 Sep 2022 06:49:05 +0000
Message-ID: <PH0PR04MB74168BC5B65511D063E530439B4F9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220920200626.3422296-1-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB5610:EE_
x-ms-office365-filtering-correlation-id: 016419e1-219c-43b4-c05a-08da9b9d6017
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 00lkIoFW+ycATRcejymcUxlTW+EHTmvIc1i8FKdS9IE34eoVvGoMJBKXqJJ5JMXStP7dnSDwP8Bv61ov1u0QV1vKxe+oy+LIm9lV1zvyUO62NMgDQFPId6jSrnNgDv1FXfbMKR4Wt+jKCOja9vJVmsVbi2a4R8hYrAd9Gtah6pV/rva0/06G9A9buI357+j3Z1eYPAAMKuucYSbjWfqlXusEAjezb5lis+Gsq1gTku4WavKlujOxz69J7N0uZLEQj499+azXr0H5wc+ic2PNXdMIHV+TUOLnEftLmdTN9w93pLNc5K/j8humwMLihoxJOp0SIEiy88uIY+h9Fz7EhCsIKjAuFKqYeZ8of3sSo9DVj4tStj/Lp52en702EgWI8EGpqVvvcSXr15MHVpTiecpp9RCzJltpuqi3dHn6g/gi+giOEYVdltMcriZRkEQABcnodD4oAz0dy7FhlqRATw5OjK79zOskOic/FNuWAs1LHXfZUNvP4wmJuWSRjh/hhGDFKrOv4ELrEUlkSC2Gam9S88zniq8yK0rKTcUYFFHBSirYNRGrfAfVq7i06PisHBHcEtbMoJ/8gFuCzeFtLw6yATmMI4kmx7f5oSpG0mJYVVRDe5eDsw5IFZNX/ppyEcrjjNtorHBgWogEXRMnWlldhm0B+tfGR2grDALccyBISEgfY2SnwuYE0HkPBec+mta1Uv0TN+cDZmG2QqtPmuJ9MVuUnmVKvviMqazL4qifDuECrnaYB2onFN2Tmde+2PO1Mg26ZGzN3bB3z8uUTw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(39860400002)(346002)(136003)(396003)(451199015)(122000001)(38100700002)(38070700005)(33656002)(2906002)(19618925003)(478600001)(71200400001)(8676002)(8936002)(66946007)(66476007)(66556008)(64756008)(66446008)(4326008)(91956017)(76116006)(54906003)(110136005)(316002)(52536014)(5660300002)(82960400001)(9686003)(55016003)(41300700001)(6506007)(7696005)(4270600006)(558084003)(186003)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/uBX18Tn5abH3VW/1sXvd10j5LLYsn0y4RccIUV5Cdj81xFlD2bNCC/hqzcR?=
 =?us-ascii?Q?Ql0U82sAgIXduoR7X0IzTLQYimZr/y5f6x8B+zEBSNzC/h2Nw9l3TJX+p67g?=
 =?us-ascii?Q?UiA0QIGL631qbcr8GppaX9lyFdaVD95GIISnu7kLHrKfY3uk6ZurQdCJuyB6?=
 =?us-ascii?Q?w81HzFxSFz9fvxOAREPLaEm1CV34TqF9qrg1KFYv/BflqDFyGSKi8peTxUv2?=
 =?us-ascii?Q?LQMg77AymYCRaPak1AG1+fckye/fH5seePafPcEV27ND/RAqqqu5Ahu7pC5u?=
 =?us-ascii?Q?dTpulB1AqpPp0QzLXfv87ampyOKZw0kWIR9KThczn48KZyEcJRCB9m33Obio?=
 =?us-ascii?Q?ffkNsbgBZmEhaZDWXlJwMm1FxPxji+zCCJpRdpeiuHHLif4vAlpsBYEcVT90?=
 =?us-ascii?Q?9GKbUWMXPnoHXoJJGn75M0iVtFSc5TOQOF+7mhYqoj9THroKpjyZXLOKyEwq?=
 =?us-ascii?Q?F6xd7g3/f+iXIW0XEHBtgShe9jHNIbfOW7EJM9G50ISjBYn2+IrwiW/stDYT?=
 =?us-ascii?Q?MZ3yKFQrh8uCmhwV3NYVPl2hU/4zf/dQXaHDpBgovQ/uNS2v44O0jXzDn/+0?=
 =?us-ascii?Q?BobgmZZPsq9lZOtON1T0SL1Vpvc6dXZgCd5EALZZdA3GQYwycfWleQLRm94t?=
 =?us-ascii?Q?oCcngWvIWhSTTnDFwly3YZeCjMVHh3o6kXbQ9XbJSgnAiiEAdKRiO36chxR2?=
 =?us-ascii?Q?ODU1/nHtpuza3bzP8PoPCvIxwukNIF5hmqncmu6dmn/aRbaO67UTuduult0M?=
 =?us-ascii?Q?6OLoko42l46TjOvPNB9l++3uwgTHh7JhIfSOnC2hPYqfgcbBpTtJJ7sbxLk+?=
 =?us-ascii?Q?Y+FA9XgOSo9Pyzxr3GOWViW+X1Q1BQwzIo4SVIuHFUWclb0lfwSD5qq6r1VC?=
 =?us-ascii?Q?TK/gekAv10NPfZqlRHl85eo4zZJJ1Lb0F7haIvapp4QfQP9bGNL/4bv66nLD?=
 =?us-ascii?Q?BVeNrqEWC8I7rsvVeURL0JoJzEIFpVgZ8VyIG/Z/mM789lsbEw1CzFz1a6Az?=
 =?us-ascii?Q?BkfA11RfIby8vS6oMlfB7ObK20RDArcK7PZXC0uRiVdtqa9k5umuqnTcU/S0?=
 =?us-ascii?Q?WthPzTLM0EEAYrvOosYLEd4vzgiE2q/T2eXoEAE3lWGooXPHcowvpzaIotok?=
 =?us-ascii?Q?96MrMSoeAyaf8RK8ssAPscg//Jpf7FWb0/QY1XO38/nYfYDyP/D6yIDKylz/?=
 =?us-ascii?Q?KHkEKDWB25Lqj206lWv28SlYJw7pxiGpD8stN8Tu57aXdLjIefOO1tKaLHbV?=
 =?us-ascii?Q?qCu6fRW/58UxQ4FhGMzO9d1mDZI+Wm7qkFlK46M5ZHZRBmLk8kGqiMPQWtF/?=
 =?us-ascii?Q?MOnWNk55ZJGM24JGQTLv3GVptW2izlbFzjtIWZ7UjYzKlx/2+3BGj+62YTi/?=
 =?us-ascii?Q?9rihXcWFbHTwqNx2kumXF0ZBGm2jy0JW/DVoXHKsh9QZJ0sj1+rBLIi9olhB?=
 =?us-ascii?Q?XJPXHNYmo626J/KAG5kWV+lHbxPqOKqeRP+r+EflFUD/mvhf09ePwHIyyYIz?=
 =?us-ascii?Q?tLuwlm7/21D2WaIgDkIuF5OOkG5KCOsSZNneXZRWhYm9eetMEdb3N6vw+BfW?=
 =?us-ascii?Q?/+s4snCiyBU1trXZuPe80JNZT52y+jX6B9vbfYD0PcS/K0+BtE5XHNhSdw5d?=
 =?us-ascii?Q?LHharJsEedYUiweYywNuYq3QBJBK0loO4GkZHXQC/Rb9oDQqySjFiu0d6uuu?=
 =?us-ascii?Q?NxmbN0H89Tpxti5SXvq9k4GzZfk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 016419e1-219c-43b4-c05a-08da9b9d6017
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2022 06:49:05.0217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YVwMkbZJTBv2A93EyWActFaHrp5sZCI3Asof+t6J9liBEy06o4Gjdj4ukSnZOnhkU21f27uW27F7D4vY1JeIz4gEOx7SmNhZuXPKpMgUP3E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5610
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
