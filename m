Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A02C433E0
	for <linux-block@archiver.kernel.org>; Tue, 19 Jan 2021 05:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD089223DB
	for <linux-block@archiver.kernel.org>; Tue, 19 Jan 2021 05:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387746AbhASEyR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Jan 2021 23:54:17 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:43796 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389104AbhASEua (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Jan 2021 23:50:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611031919; x=1642567919;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Sn5JhhUZM4XbOWJVLILjBpmExdohtmJn9o/3Z9KlR0E=;
  b=i9aRUMMf5w8ZmGMCDnGmNA/6zi7COIlUo4le0hxUikSd3BXxvUVs4T+w
   2t/pKrFtexIgPgjijgEhn8ehRVr4egvLQs/r6Qmg3hHekVzp6LgN80jGh
   vyxwp3DGR77Sj2fFYDJurvzqzp+DAT09n7jzUS6LBhiaij4wLsovSjXKt
   Xok52oqKFFbhGIGf9XE2R3R3puIT5UNwbhtoOxpHUlfFpmrdeBGF4FUQr
   aoiq2K6suHvSr/CSI5+EilGW6vR6vvBWNU2+CuaMgAkE3+ClFOFhxFXDI
   9+gVb52RrXfC++EaO/6UbQp5zTLUE1zQddMja8Mss6L7dC0PgNcu/698p
   w==;
IronPort-SDR: pQ1KCuCjSTbwavgXvbPc/0T2RuMgLxaClWa8yNawtjT/kFADsOPOn6wP1f0l3dWMThLHv2+S6D
 ilN9x4dkk7cyTVg26lhtX+MOaSqdg62Y1kKz2h+p+B91Z/QeDYHNUmg+iYp73RgkRdFFt/ZSCb
 rAivyQQjvi/ZSXI/u4V95T7L438j7q3eGcax85JvEMUGy5AeH/eroqjP2wPD2WUHeFM4AvJM7N
 0sNApfSkp2zHQ5xJlxhiQVhaKTIyd2MMbCwzAc+82m2/BB0qUCqk8jpsEPm7JuBjeERACkGFV1
 KbY=
X-IronPort-AV: E=Sophos;i="5.79,357,1602518400"; 
   d="scan'208";a="261720804"
Received: from mail-sn1nam02lp2056.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.56])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jan 2021 12:49:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NR3rNHs6AaYL2vsI3Q+SDmRofRvSUziOc2glV5q3TzUFarEe2HZaMZBRv/51R9aBM6ylN0gmWlM6V6IOTuAGuhXRMRhF71BUWRTSt/v7rKfxWCrEdNomtbura+8MZi6BMxFbBZEjxA1XDS/x97AfAFYRrCUx7ugB6wxridt75cz3gLfy8qTVGFlFcGQ7QIfTqg3snaCqYAs3L9KTMumSyS7AQyrLQEqJ1Z9qjTrmMi8q74Ll3iZLh0Verq3n47ApXriO7wLnf+gSagYq1L3lJdecfCQPtvaJ//VuD+zigSFIw4Uw2Y8WiBf/NLSpcR+GCYphpwZgcjqAGPIEERJL2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sn5JhhUZM4XbOWJVLILjBpmExdohtmJn9o/3Z9KlR0E=;
 b=ZiDyizBE8GWXIOqaFwiGi7pi7nQ3Pb6v2T/FlfU55X1ts8ejhzG29xCpZ7TiOb4Uw9VUg3ZiiOCSv7C3Z6wIEohZoqP2KrXT3Xaen03PmWV5e2e/rEqkhHi2ledAsfzBhLYyDnxDUjJ92HWs0p+y1uJdSOuryEDnhTe/qE+AQRMjzwtfYaMRwLQrJFwozbn/Wchij3PsJd6uAqxhgZGL6kBedgWgqJ+3jSGbPLzwqacWtrpydECChJ+m7NuoCcYeicJfG/zdfJy5hi5SGvrnK9qz9Cnc3HeiVrPFLlOswe9ADEKOXWy4Yc8FADLus3ar3PPAjP/LLObhgJHXoRR0HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sn5JhhUZM4XbOWJVLILjBpmExdohtmJn9o/3Z9KlR0E=;
 b=WCUNw/0+apBqCMQkV6w1jZNN7ks7sfFnccgNefsKMATy0Mfc128MDVal3meJiSKxyAOwkEgleEpK81Vgs7I+m1GS2elv9Y2vQ9jA1XfevSSW5vU+elop0uaEKuVsQndRdI1hJZWJKDvDFtUARPmKeypOomZ6lmsEA0Nj/6Eztf0=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5829.namprd04.prod.outlook.com (2603:10b6:a03:10c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11; Tue, 19 Jan
 2021 04:48:57 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::716c:4e0c:c6d1:298a]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::716c:4e0c:c6d1:298a%6]) with mapi id 15.20.3742.012; Tue, 19 Jan 2021
 04:48:57 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>, "kjlu@umn.edu" <kjlu@umn.edu>
CC:     Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [v3] block: Fix an error handling in add_partition
Thread-Topic: [PATCH] [v3] block: Fix an error handling in add_partition
Thread-Index: AQHW7K84VzezNApbiEGsIL4FbeezFQ==
Date:   Tue, 19 Jan 2021 04:48:57 +0000
Message-ID: <BYAPR04MB496588C4D380E0E08A76B2EC86A30@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210117085346.25095-1-dinghao.liu@zju.edu.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: zju.edu.cn; dkim=none (message not signed)
 header.d=none;zju.edu.cn; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2600:1700:31ee:290:eccb:a9ff:3ff5:aa06]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a6175c90-8453-4ddb-32d1-08d8bc358848
x-ms-traffictypediagnostic: BYAPR04MB5829:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB582901EAF110EC35D582DF8586A30@BYAPR04MB5829.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:514;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f+/3Zvlut/NP0W2pegfJfjkFGyqmqeNWzax23yUQwmQV2PSm89e7ls9R+MahW1iyM1ndZt5kDHCsfQR1y0B0B9S3owRvG63l21VBqtl3/vlqW0AwN5sOrQiCkTwFXZ7vANiftgoOiDKTp2m/mO3PRX1d5zsh9xCV7qtaIF7VHDDQk2w4lWrzuPYqMXKrOa6EnKKyppvtj1R2jblB5vjFQznJet6SYjz3Uo4o7q5TtQyaWOu9OIszURoRKvm0TTobeuJbJZD6HAz6vPR+vaS+lhM4AtR8rFiC4qeaWovz63S6Vu/zGNKVLQa/XYPiVZiychO+ykX7vjWi3Q7Faazn6XLAlQvhGtQMmU3MIML8Tm1zPKpLREX8dPoJ6u+gZojx4SoktaPfGpHRO4p7/BZITw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(39860400002)(346002)(136003)(366004)(86362001)(7696005)(54906003)(558084003)(52536014)(66446008)(66556008)(110136005)(66946007)(33656002)(5660300002)(8936002)(64756008)(66476007)(76116006)(316002)(71200400001)(83380400001)(478600001)(6506007)(53546011)(186003)(4326008)(8676002)(55016002)(2906002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?PZqPWz4G7qp7b10JqGLFI22N7ho/x3lTtlBY8TwI769z9q1e0Qb56S3cDZJD?=
 =?us-ascii?Q?dt+uaU8quyDx4xjXyTR729QCWD9cWI/9SE4gTWf/Af6RJYP5G49EMPZEGl1f?=
 =?us-ascii?Q?pU34F7+nGl7AQ9I+Qp0NCZ/n6gmWVXnYLZWq6bQpDFeU0QdxbtCthOjJ8rSO?=
 =?us-ascii?Q?mAEI4xeunvTEUYag/6pgX3/RiQh62XsmhVwvX/bFuC4Gf6eHwoD437VX3BdB?=
 =?us-ascii?Q?9s/TxPGv9gNP7O3Sm5q9/RxECQsi8+E6RPS/OpsiMQD/IDdrn1vLb/HqLCbg?=
 =?us-ascii?Q?bTKVRRSEXbWTLSBn8muOT9Y1M7O6Xz3eSVkSespST9xuLkSHbKhFtJbFMVMn?=
 =?us-ascii?Q?exs28zBKEKz60+NWutnD9vLOGeMNOloovUEAX+OnJ8uEptLznw3CAApsApb+?=
 =?us-ascii?Q?MbbQgvzLqjKGL40VC3twrFql5WeZmQPGUN5GnAvEJ9/o6rqRAq9fI5Q+SlJn?=
 =?us-ascii?Q?378Xo+dVQAAImJD/RU77bmyXDU5X0V/ALlTqjgv21NKwv9fn44pHeiCbPT86?=
 =?us-ascii?Q?dYvX546rhfkXK0MpNGOqOH30pVhPyGmQGTYKbQVEk9G3bTdy/P8pLzpKME/8?=
 =?us-ascii?Q?2Ydcygv+bY2FPcJn/K+Ts2enFQ0u8uY1RfPSgmzwLnK4+54jA0NZoO5ZL8Za?=
 =?us-ascii?Q?BupPjxJ5aLuMt+d5+JqAnqfoXHhs9MOwH/jZ0BtLfGNwTeE/vYa1RUrrmuph?=
 =?us-ascii?Q?sIR/XH9CgFDJ/gKH+fU0ugrywX+f2snwrDmNJLtS6El7W6XJdmYrO7KBmPFZ?=
 =?us-ascii?Q?SmKbQmtAs1SHmT6AwvBeLvIxQ3ilW1aVB/L8RJ2n6V+RYU0x1GeA6ex1wrvg?=
 =?us-ascii?Q?xQ64MAKVhxSgu0xZaHzOYJXRcrMoZ9YPOwz2ovE67kVUXBo0aoHSVp6vfvnM?=
 =?us-ascii?Q?eNZG63cg9jWsZJBR5GCexyOW8m5Sr7A8S1cJew4coLNp2Dsa6fUQrviDugly?=
 =?us-ascii?Q?Lmj38na0rbTmANTKvakKE4cNJt2CfRmiaRm9+jJ1jk5VZYLkkUnlAkvZDCjH?=
 =?us-ascii?Q?HJXkZzEhcAk4S2dXv/Vct5Ofyx6GsXI2vNmiSU54nzLq/C3Mev4KtLuSM/jz?=
 =?us-ascii?Q?n0C04kJn?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6175c90-8453-4ddb-32d1-08d8bc358848
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2021 04:48:57.6685
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nPfupRBndESNvPYincoO8DsnDO2UZ1RD+kdz19WOaWOR2zy7Sg7/pAtlOBS/rXOKSYtEB6UduDdw0oz4U8kFSnmDUdGEqY/8Bb/okTLeZQ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5829
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/17/21 1:00 AM, Dinghao Liu wrote:=0A=
> Once we have called device_initialize(), we should use put_device() to=0A=
> give up the reference on error, just like what we have done on failure=0A=
> of device_add().=0A=
>=0A=
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>=0A=
Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
