Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B038EB64DA
	for <linux-block@archiver.kernel.org>; Wed, 12 Jul 2023 23:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjGLXsE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Jul 2023 19:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232072AbjGLXsC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Jul 2023 19:48:02 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C908E65
        for <linux-block@vger.kernel.org>; Wed, 12 Jul 2023 16:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1689205681; x=1720741681;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=W7/R33v2WzT1ifG7GJtAknBoJQnlvLwuSpiB6HgGXOU=;
  b=BmLUb1LC706xTuaF1blbe7yzpFzvFsg9YOTwlLYWa3ePu5XmkrEKB9Ld
   My6jzVjM/28tEvR6/diSNrma6ILw75HFnO5iqO5YuoMKfQv+U7dtxNmjI
   LNf8YW+z8IWWSvFasFpMJv0msJTchzS9Jk+2NolfgQSA+jHNgJTQVe3sm
   MkCFxy3tZv+JLQHD0eE2G5/8NMczPh+jag61bkrpc3yRevWHYQjGZEb8Y
   KxIHmIvFZ7iy2U1kXoSCSZwWgODvuSnaAp8ZC5hOBAxRef/kg6mFcnWfR
   fDo5uUa0FtgBlc5McM3gmJv2omMkfzZknv+UZOpCXojzadS1IQvacg7Yn
   w==;
X-IronPort-AV: E=Sophos;i="6.01,200,1684771200"; 
   d="scan'208";a="238228998"
Received: from mail-bn8nam12lp2170.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.170])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jul 2023 07:47:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HzhSk3ket2y63uFU8/158LEeQNfamGgoDv7oOtInKUq4wCLnim/UsOMZ7EuRlfpVyVb4J3JLlj7IFMw10D76ZEL4tHMLAG2WkbvraUe5G6ZjP3wbLXFqiemSJ0rPbtBCToJOa1Bs4XYo/Wp5sKnnC+SP840VCP0UoCt+P2wu3gqf9UR8JYEDbcOgaeiWRFkNng9/BpzC8+j6mGxt3NRTC3fBbCnhlPnJflVr3WEvb63Id+0UYp3yKbM2P1e20KQ7khbCUFZ38AW++Pg93YkDcvtUyRfDa5rdteAmWVVC/2/kLqB5XnjspCl1tWU/WSkGPIlKb1Erdchirkb4664zdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7NruwJat9jxJB23wPZxDQqgWLpiSKFqG9sidi/Z9HPg=;
 b=JPzoc4TMposuVWOTPKl//SohSW+CXk2uP4fBQKqJ8J7dDYg8Fb1Wsvj+RtldzkOtdYcDOaRUeDG1COiKq2j1mVx5wlbHSOsqYIM12mMZX8EsbdSLsi3EnGQ+6JYf2tN4cmU34F3SO2kRSlOc6LIY3hjynnXI/JcZzoz87yMn0InhdxPSZzhWP2P9Uw2VdNM+zmp3ijjjXcDuwNF29rAsVDUPkVHlNChTxaJErW+x7Xr8nmHH9yQ9bqItD7BPjvnniLtxcj2jjN0Asq41wdK8sDVMA4Oh4GFKzvALwAdGVdATikvcRHZanDcSpLFIxdBH9Fx46G9RpC2Tfh3R33+eSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7NruwJat9jxJB23wPZxDQqgWLpiSKFqG9sidi/Z9HPg=;
 b=N396VY4tyO+YWzwWiVlVj3TX6ZU/uvHUi3+BUz8ZD1AJbmZd/sEHKDWufNYkHgbGp9VEGp9xdjSyAqr+imxUOcZlALj9cWopFUcLflWmQMHrjpebTx8jkycuTA10uaOp5dpm3hd78ucN3KgYylJ/65+rKstPPWmRx+3kbudEK/w=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM6PR04MB7115.namprd04.prod.outlook.com (2603:10b6:5:24c::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.20; Wed, 12 Jul 2023 23:47:56 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::bfa:d453:e7e9:8f98]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::bfa:d453:e7e9:8f98%7]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 23:47:56 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <dlemoal@kernel.org>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] block/mq-deadline: Fix a bug in deadline_from_pos()
Thread-Topic: [PATCH] block/mq-deadline: Fix a bug in deadline_from_pos()
Thread-Index: AQHZtOcLeoTV5W8SC06+Bp/ciEpbA6+2zKuA
Date:   Wed, 12 Jul 2023 23:47:55 +0000
Message-ID: <cra4fcy44mihrfcta2drzralkq45me4qjaugx5lsoklgj2jaff@hjvho5jfeomj>
References: <20230712173344.2994513-1-bvanassche@acm.org>
In-Reply-To: <20230712173344.2994513-1-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|DM6PR04MB7115:EE_
x-ms-office365-filtering-correlation-id: b118e52b-dbbc-41e5-b31a-08db83326a69
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h7Joj8Z/0GPWYCs9uxnggJljQ6kd8bMwfXnWCQcohFYBGDA63dkXlq8wUfQIPJRKL79BprsS04Rariiyhz9qRtrMpP1AAy5fiWfoKD5r6iAGN7YfJD0xdSOL2nxxZuiNi3V37u5NtoGZaI9crWnKj2WdEcNUEJQ93CId8wRSI39lXi6rT4OP4uQSzWahcq2SWH1pJ6Tf1PJ/6SXLkuKQIOiti7rfMAQhhevl2YhxHQTUkpW0EoiCFkme5+7BGsA+En3d02hWkVKyWlERF8HJgmXK7psI5eYom95WvEe5282teGEPHFsNiItgfasqClqUK2MBFGR8UQmaJnIbBH+rhcIPvdBG4/fRSQQ4LcNsMNPpO0zwTCfz2i/LPBcTEOyPiTSc/q5SSum8cP8cY26s+yatkm9HhaH+43+ezFwQget9kW+gitcUeBeKYvDRUjRRy/I8CBZzKW778NGap8hoSOUQZObWVL9FIdMMahC7trbF4y5qijqBD2V/homMdRPpjrCTWNWuPhMhvG5fvEgM2WwxP42PzR+kWbmVXpyRfInsEycw3thKFu3AVOvWPvrd7q+CcNtniDZwUIh1jLpqzdE5nWNm2qWrsHr48OnxgFE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(396003)(366004)(39860400002)(136003)(376002)(346002)(451199021)(33716001)(2906002)(54906003)(478600001)(66556008)(71200400001)(8676002)(44832011)(8936002)(4744005)(6486002)(66446008)(66476007)(4326008)(91956017)(64756008)(66946007)(41300700001)(6916009)(76116006)(316002)(83380400001)(122000001)(966005)(38100700002)(6512007)(82960400001)(5660300002)(86362001)(6506007)(38070700005)(9686003)(186003)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bj96mqVbEr9PwDjwObM9RsMBMXG4XSBA0qgxl/MO1j/ymec4pZ7/6ZYfMoqu?=
 =?us-ascii?Q?2YT+bACiDL64Y8C23lLmfzlplHcqNf5PsMo7VfFpjl5K3mxt/V5GuCeJ5JZn?=
 =?us-ascii?Q?qThLr2hAttPMKWNFhAKY4AkkT8olJHrcN3wo2XhwmB329flUNnHhm482iWYA?=
 =?us-ascii?Q?gar7X2wbv8Zm+MhmjJDtKsHxsMUbqX704IHP1K+gB34IHJ42C3uHF/g8x9u2?=
 =?us-ascii?Q?DGKHSYkkTxNStVwuv+Ezz/ND2xFEbWCmtimqgai2BgPab2chHQF347001UT9?=
 =?us-ascii?Q?et3BqLTCqis4awhkcP5Acj0AkcOtyz92ws2nXBm6sIa0ciz1oN9fxQ6yfvBK?=
 =?us-ascii?Q?6bVoNb5CU5Fhz/aJ++7je6PSaeB1wPi+Tely246KwG1xbCZopJx1LCTJyOu+?=
 =?us-ascii?Q?a+N45Rz2ZUj/tDk4XUXEZroeI2oZo/2PbmSGA5dJZDd0iW4A8sfNBP3ltbjX?=
 =?us-ascii?Q?n2DnmleVwudz8Jb4paSGsGPX4CHyCQnVx63vzfDIwET0p4bctuuBsd9V7RoZ?=
 =?us-ascii?Q?xlXp/g/DFATcnXpJJ6BO3qW6PSp09P+ATPKgI2xmmpBBCK9WRUY/q4bUeK4J?=
 =?us-ascii?Q?AMp4fhX8pbAs6aVrM3C/pQMfPJfdRe0hO4Icf0RzWAgJnyuTzl7oup+fbL/l?=
 =?us-ascii?Q?WGTgHbcGg+yOV4aF4xC5B/1lilZcFPCY+598S/SZ/RF7zp/khlCOX3XdZC2i?=
 =?us-ascii?Q?AFdqgV5y6Fd9peINSLLNPZ6W4SwVDUCYYmfsKc1q/TFpjHenwEQFmC+xXsrN?=
 =?us-ascii?Q?AAm4Ll9GALthda27MmR5ERuFqwbYIw95ZV1O1hS7lW/cLkKofnjpqLx/x4yo?=
 =?us-ascii?Q?1sH1guX+1kZbcu2DeCUWiS3+Y2VnjO3mWI31sXWf3wiU2URN4kdU1QGa4rE3?=
 =?us-ascii?Q?D5ZJ6HCCfTNvN3NVEpy9cl9aIfutAzgrjNqXB2ajBltG2RyGiilzaW7hRKSz?=
 =?us-ascii?Q?R6h6snBsRxhqD3gT7B0hKLIN/lN66OwpCoPYW9X/eUt8SwDI1CZwKMRvq88q?=
 =?us-ascii?Q?azoZiQG9TvmPL2Qb2vOimj/z67KzebAmVF6jpbXrjOd27U9Qjj02NPs5LTnE?=
 =?us-ascii?Q?dxR7Hj5Poxu4vqrhZbsZ1QB13Y2BH9PLrEfQE7ZjfENIrsGkBDGx1cyYzhj0?=
 =?us-ascii?Q?D8qB3CRD+UDWXZKz1HkArQTvsLGNB0P9pCh52qSdmLJc+/V2rJejNMYWmjK/?=
 =?us-ascii?Q?Qlmzw3rpv4YWiu7/lUNwoKGhR/ROtV3wbHZ/zkqNHLuKZMcVsQHKsJ+s1KAv?=
 =?us-ascii?Q?8X4xJlbD21p4TQV6db8P8jh7RBmGsnCAhj/vxOZPVdxbAlO/g+0iWM8cZnvv?=
 =?us-ascii?Q?n3CaR8eHcbNGxOFkyE3yeRKAiL9Cmi9SXBThqz8FmvJI3uY7zCClQJiYVP5n?=
 =?us-ascii?Q?i0p3RP9OfNh0b6ChUmT92E/9HkB6enucYeZx86C1mS8qDFIuBS0gyyBLybVj?=
 =?us-ascii?Q?4mxaa8KE4x6JNjpD2FNrTsi99qsCrvXePJoCSMbOmcmGL9KufDWxqD8r9+py?=
 =?us-ascii?Q?nc+EeH1pIhoctlopNqM2ZCcqiaQgsapggtobwMnFilOttDlBhesVL/9Vs+lU?=
 =?us-ascii?Q?k55y5szZbrizwkZvg2NP1cqZjyv/yc0lbc9GL5yI96HkVdL/rgvv0oxvdYLA?=
 =?us-ascii?Q?Cikg7jjr7iKhNjJobgsbrhU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D656C8F4A39A214882B7EC692534BF31@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: tLRi8BWra3chTmxaCL1gwDuAftM9Ea8EIuXctxi9RaXVF8DGJcNVCbjt5OzdxgAwcLke6AkUJRL+GK5Zc0hoR6D7fvWWLmQUivwEKcJMj0toED41pR8AOTXUb2DkZD9NaRNbkl3w9CupUY4jnxqF3RMB9x2Uq9ht0L+TpJ5wa8ywJWSB6ds4X3UKXvqzK1BQCO1h0JgvrWlagwmaWopV3DjqSJS8kRJIDmB9zl6gQLGvZYnrw7AjS4cmpm9bT/UCwK0kxzA/65GzhIHC7it3gumK6UHqKei4yDYRgW2QJwj6SB3bPr3+g+7K/cWqpyQmkP2vstGUD3lztay9Kr+XFYyj3M+ujuIQ18bWEPCHD9Ga42evLJF116+zfvQidpR/HZJHg3ARZLcfl6sx921B2tBx+JcmctcrNkfxZlrFsZ8hENjkueitEPX7QEcnwRNCpvDxU80xrbjodk23W053NVyXhHHkyqa/KZ9HOLhKUh5+fc78uJPq2XW1NbyT6TkzcODrGlVerSAIdOylzo2A5GRrg5uSITCJ1SjZmxlKdVOE7d/91/bnxzIKkFgS3TMQHmqd2q+a5CaydDbHr43HKWH8TQ1G5AT+eJQRJYpmcVAauogmeicGUAYMDT9EphStuE4vEgoie/lT/iDH07yPcKYyziLOtlJPpBsWaDuJbnSeHysc9KvsrM0une7QndTs02aIotnH+LVGhb8u16iTgkyqCT1TeTFU7fdgHS/SyTAipmPsYqz/bKaEg+K1D7QAwn0/2ODK6gev6Qr9z6oUGithCig23uEs/HkRsf+XV1GOn3YlNELJCJKfLfoYz0FOSwIGU6Ifx0E/eodvJBdK5eOlAaIEjxKn1b7DCJSgAbokHKVDcQDdGGnCBSNO+zOThvMWk2y/eXQCFTp1qaoowg==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b118e52b-dbbc-41e5-b31a-08db83326a69
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2023 23:47:55.9689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5KEtuQIqs2vwqrQ9aHioJcGWmqrcMtdQemE65d8yJcTvrHtP3UrPQNkXob5fgwjGOATkz+jBsgIsdcGcz4SjwE1FP9p1NS1U+X5VkJjtHt0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB7115
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Jul 12, 2023 / 10:33, Bart Van Assche wrote:
> A bug was introduced in deadline_from_pos() while implementing the
> suggestion to use round_down() in the following code:
>=20
> 	pos -=3D bdev_offset_from_zone_start(rq->q->disk->part0, pos);
>=20
> This patch makes deadline_from_pos() use round_down() such that 'pos' is
> rounded down.
>=20
> Reported-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Closes: https://lore.kernel.org/all/5zthzi3lppvcdp4nemum6qck4gpqbdhvgy4k3=
qwguhgzxc4quj@amulvgycq67h/
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Damien Le Moal <dlemoal@kernel.org>
> Fixes: 0effb390c4ba ("block: mq-deadline: Handle requeued requests correc=
tly")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Thanks for the fix. I confirmed that it avoids the I/O error using a zoned
null_blk device, a QEMU ZNS emulation device and a real ZNS drive.

Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>=
