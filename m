Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA33C54EBE
	for <linux-block@archiver.kernel.org>; Tue, 10 Jan 2023 09:16:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbjAJJQx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Jan 2023 04:16:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238096AbjAJJQl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Jan 2023 04:16:41 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD39D287
        for <linux-block@vger.kernel.org>; Tue, 10 Jan 2023 01:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673342200; x=1704878200;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JVyGrQP5kbzTQeSWxj0rpxdq7sSEGN1PASKAKIGCVXw=;
  b=ehgiuICWdgXBWFk3Qj9tH4Qfa9YJYRh+2ru3H2GhJzWF4oGUdhc51wZS
   p8NbSH0lNqaw3j8a4EQORAHEaT4ZY2DOaDMfN1lc4NxsgiWgc8o92Mrdt
   ux8bfX2C8+lwwifFYmI9rXjgNgwrpr2X0mIO99gQWs16ihleAqzhn018p
   f4WJ0yU985oUs5HOzCy1Fq+Jq2CUIMunMjJaKBo+IrFF5tJ1XaTzQ958N
   masiHrRYejrnBr0m0WLBJlSIFe98gPgzoXW9B7frmAXBdFB4SaPWBUaga
   6sn6b7WwOmTFR3LtSaoOti54R/WZijca2wyD7rlRh+MxTNPU0FHgt8dF4
   A==;
X-IronPort-AV: E=Sophos;i="5.96,314,1665417600"; 
   d="scan'208";a="220543497"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jan 2023 17:16:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jrGShvF+ztvGP3WALTJ/xXqWaEpQld4tIDdiali28dsGTzHgdesZbmspb5GPEggi6ivAd67kAEoxTzb+rLlhkinHhRl1kF4NTQA0Jmv2T554H9j/V7NI6dT22H83ExTlryVTYtfIItQ4WhcBJR/lhcRw9U3oAX4Znd/hqXbLcKq3bvIt0ttBUve7tqyZcycUiDy0OFUoQDU19pQMHA3bWWPVLDOuJbLaGiZdsgIO/lxQibYjrfVj+bS1I204ksALgpITmpPWCbABVBrE39pktfbuaUebUmb+BydQ8uVeVEZFFVbDZnVSlQ2GfUiM6VT/f4Hpy6Dyf/eISw7XTSJ6pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S8yKL+1hKqHeqDVh+G0roF74+2erfynMmXeSsbx+hO4=;
 b=SzxM6EIaNl2omVa0FeCnmV5WXQYgdTfVpRkQhw6NVNPW1Pxv8P8t03slP0yXEU23RctwGtAE1vOoCZYe0u9Ac537dQCJrEHEqHLYgkYD1PfmzccOUylwQ0u+oIIYn1UxzgeS1WEOtZbgoiB9oZ4x6MFzT4fDCEbzm6REfIw/srC3R/6SJ0y6fXuuBlH/LgJdF8XtRdWZf3EhB6Uw6RVuBNvgjqUQ0H+hNUJ25FvOBZbAkKBGvBScM0FzCZx7NGRyFajFhV1IN1mVba0Vj1NZGmBdhjIC+fuNGuFoawNom9WaYM7Ylk6mXFjPjJTTR/58lij/X6cz3/wg/DnCdx87nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S8yKL+1hKqHeqDVh+G0roF74+2erfynMmXeSsbx+hO4=;
 b=vji7gSYXKdmbxkFYv59/9AsFZeI/uIsEwbApsuyaYKNnuqMQ5nH0JLdXr+De+ieQnjCn7/iqx4HIZkJEZ7kvipifnYT74Jwy7UsXSzDXxuczaGsG5kIx50l45vb9rmIQEcj/bVi2jaj2EXv1FaLpMn72NBJnpLjaXMmRulIsKto=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 BYAPR04MB5239.namprd04.prod.outlook.com (2603:10b6:a03:c1::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.18; Tue, 10 Jan 2023 09:16:36 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::ee92:8a0e:803f:4244]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::ee92:8a0e:803f:4244%7]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 09:16:35 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: RE: [PATCH 8/8] scsi: ufs: Enable zoned write pipelining
Thread-Topic: [PATCH 8/8] scsi: ufs: Enable zoned write pipelining
Thread-Index: AQHZJIIIY80q38OvEEqSuQOtz+ZYUq6XXt/A
Date:   Tue, 10 Jan 2023 09:16:35 +0000
Message-ID: <DM6PR04MB65758465088561BC2632D91AFCFF9@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20230109232738.169886-1-bvanassche@acm.org>
 <20230109232738.169886-9-bvanassche@acm.org>
In-Reply-To: <20230109232738.169886-9-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|BYAPR04MB5239:EE_
x-ms-office365-filtering-correlation-id: 88992fd8-f6a8-49c1-b017-08daf2eb5f73
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fq1t7ez8MiDa6n6tVbD3qVZxbQMqf2pbsh/YHhAWnoOkE2zu+k2VMq62Pb+54LH+mJsCgDSofZVOxU7IcFtGIT81UpVFwTRGboyrVkCwB6R5KK1UeKx9bCsSkJ9wl6y3SAWFmP29LypN68vIaDjiCFrWkKsnivGQ7bTo+euuVk/FJSuhqyHQIiEJx4ehA2b33uetfMhnDr1oCd4yUArrQpIzcaY6Jpi9k2Azd0a6Hmo+/5uNXhRbPZTRysUpkytOKWVR2ffpFnhz2a8G2wni/DvzT5LCrft5VsctHiAh+tdYljeOYMBUfP6KcygpX3drgOyvsL6hM8TGQRuOaNzTVKXNXHDuJmO10whGJkBa6OC1tk4mddMntdMDuKd/syjOvImX5xsJbDqMAGipH6Y4qjtPgTBQWq80Hzu5mkV8Jg0ktV26hgRXF91nrIemVQl8nH0rEJXH0RsiI3CQgQ7vAfRxARvG1gKDB6LET3/SmYyP81P7rr/wqXa9HCwqsF6sXKTgTMXA1KUrl1cZqJ05a0jjRHnYtwHTmQo8QA/XDTg1QU/j3xGl7J5YLgxh1GLTN4A/zxmVDVr4a8Ys9SyVYs7Svowq0r7Ip1p2foDz6Hor4BNZnBSU9SQ/Gyp8VZNmwcV2nEPrUJHvjm7gaKAIC+ZeEomzoBvXOYH7j2Eu9S1mVf/UQC5v/8XdKiqE920JFdZt5EgWWIMI9LEUI+M3dw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(376002)(136003)(396003)(39860400002)(451199015)(66556008)(86362001)(8676002)(54906003)(110136005)(41300700001)(66476007)(76116006)(66946007)(66446008)(83380400001)(4326008)(64756008)(82960400001)(38100700002)(122000001)(33656002)(38070700005)(7696005)(6506007)(186003)(71200400001)(26005)(478600001)(316002)(52536014)(8936002)(2906002)(55016003)(5660300002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RW4JaUdUoe8U/NDvSsokC1FSE/NvgwbcPyyuaw/QcAd5SvhFMlsdPbgSYK1b?=
 =?us-ascii?Q?QU3CKS3y97GjciB0kuvwmrC7TOBkWtZXS4wXLbzDMTNXis4vVZC4mv0qRM/d?=
 =?us-ascii?Q?d6bLhx/mEONGxQ7V4t6uKqR2NFaYIrkTlMF9MzjvAS7sEPc8tg9PgURjybcK?=
 =?us-ascii?Q?JpmVmEWr/Or5Vqo3JeCcQT/rZELSX5ANtE9I/xpw3EuVxHxbbAZXEEUxQn0w?=
 =?us-ascii?Q?CpBcLFia06Om99+BhoRyyMW+pGdV0Bp/KZI4jTdujqAanxAz2IadxUyuzRtj?=
 =?us-ascii?Q?bYuJ8ZGB2I82ap7HNtdoVVJG5jZUwKvie46eeHeoLEFf2kwPfgDy6qs1GX3u?=
 =?us-ascii?Q?YDVJiQCOW7z5rJHgW5yDh7ROJMcF6VMZ/PRApJ7ZV84VcPoKbXDSDNAfU/oT?=
 =?us-ascii?Q?u+2U4UMjimbGJRTHsaP8M8vDa2nFRaaxwMViIPrKgy20YwjCrL9oIIRytLdj?=
 =?us-ascii?Q?5V7U/6waWx1UL22vQnzzAe1P5ILI4Lq3A0jT0qHS8RA7O3N3tAjXXjm8EZDg?=
 =?us-ascii?Q?ITy8TenfvMFQo1ZrKRV1JGrSq+XDlsQBFB4Ouc3/kO8HRMuIp7EFMFmyDdKz?=
 =?us-ascii?Q?SaWClYD3S6OjHT8K7xMX/tedZ6rrH333DZxsJvI1qcyJ2LDVA/iGaIMfeqr3?=
 =?us-ascii?Q?6Rz7SkpfnM56HfVMC8yOyZCgb4Cb6Vq8cSN18CB8WZu4bNhYlh/t2edSkBZO?=
 =?us-ascii?Q?UrCQ1Eo99LkTn9XFUl2ghSfusYexwDkYUoa43KVwojWzxO/9m4pRJk1Jx8Cm?=
 =?us-ascii?Q?FIwyRDGoLqvVpFsdAyiUEp+7Co5SSG5KJ3tTtqVEpTfsuj8RE6/2KlgNZO9Q?=
 =?us-ascii?Q?fyhhG7L1pyQbqzlzTJIXsUQnotsoB6sd/c9zGuUF+gV43WPbK/1iJov8WBHN?=
 =?us-ascii?Q?Ib1hkJMUvvO6YosLxnenpU5yRoh5vp4YdZpj117vo5b50Wcz1EdbWPkNmCie?=
 =?us-ascii?Q?YK7NYlV6H1Lced457rdHCO73VVXsC6QNNhTkHxLW1KoYZXuDcQZG5xgUnifR?=
 =?us-ascii?Q?xleYo8uFFBwN8wj9HTL1GA34ALwhtCDErieKSB4A1wqjfBc4BvY3eKFVQHC8?=
 =?us-ascii?Q?OxcwOWvjEZHJ75oZ6hOa8cxPtZiypVjlpHo6ifjcpXR5w8ARcrC4Y013/kkH?=
 =?us-ascii?Q?VcSnUE2/D5w1E6MePVYsepN/Wv7VFsKBuOsmzvGD0F3+Er6U992A+DTOssEu?=
 =?us-ascii?Q?A/Q25v2dfo5/hzckD+koWoquYv70XVPymhTOYNQwChfzQouJErOXpcUTvwwh?=
 =?us-ascii?Q?+Hqg6FwIFCEB/7tJNFgmDZn9PvD3wyJoh+YUsqYORTwzfpQo2ieiqimxcYxG?=
 =?us-ascii?Q?tZoDmgrb3QLgl0baGgxM3yw5EqBBBmDmLRgB/HZCw7VRo4hvPlGmkDMW5CsD?=
 =?us-ascii?Q?b2jHQxbBezpv/3F7nuFxn3LZDt7qMBvJLXy8pYdoOurwhuxkwkMSQlGx0/rx?=
 =?us-ascii?Q?DcTOBkTuD60vUJhMjTJNCUq93vL5yffKyDysLd0PsHwDBmkcIR/x2Y+eBnza?=
 =?us-ascii?Q?GGuYFneR+DKlEAhsCAnMk75mg83CnXN8wpg40m6rZXwVd0QcI9MM5hpGlguq?=
 =?us-ascii?Q?69kv117EuG52uYfHl4E278SpfSZMgVKtj6io3NVg?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: hpUy+DhN5wYJI6qbBTgOC10qTlonJ/EHHPwJAsq4o74RcC6WNwn7+PcfSWnlUH0NnzeTjtD9AqcYr4syQTz1DI0dCXkKqrH4g75VLoh6WJx4V/O0zKNo5FyUOMFNHq0JMliskRzhUmfDq+UdClfm0rNXDn4882y/qkhDnujzMor2H2llfqJCseb9DYcBr9zB3ss/txKzkr5EHmMgW6R5ClEVkm7gZHcFri1cmHbEDA1hhDXeAgMeftf3IO+LkRXUemq1h8H3VlgYxnzxoxHV5RE0u9LWega9gYXRrLBN7LZ0OeEm8IjebIg5EqfyL1wOyc9hybvTNnKKMQY6qUz5kabNJNSA8n3AFytW3vEVatzJf5Y+KnWIZiR91lVBdD+pxQaNCDFq7exPDvx9m58QSfIqL6dt3OWsT7MAyutsb0noY2p4ZGU/ltZ+5m38X0iC2nqt2cgjgENfyPBVs/jFIZhHENF+tRkV1jAn1LUHMv0KlUyraLqZyHo5luyI7+8I7UkB8QTIjP643IGYSjVdvhNVlr/SGY8p5v5TUKqRd4FHCwlo1OXCa01UlcIx/CvZBQR95RGfl1MuIzwsjzkEkYYG7+dQrXqwFv5Lyzq6FDViN43KfNkwGH5i3kdmuenxhdTSzq/b/6YV7HweW7ukU6Xn15j/7nyE2ovVUZgKY0jLFtz9lqLpk3V0V5mVrs+Ld0hHj5xjHx3rxbAYFZ6+zC9XIckWi8LfLH0/iRc9M9s3K/9oCyB53/7oR7XDA1Nmb5uKr5FxinWp2xrPUOyfbiXf/qxXiT3td1hHIUL60iKRJtY9jRZKccFk75odSggoVtQjD2gnajBTqk3W9fOAj05hL5Y47o/8xd3YQ7Uwsr66i5pjzA2ZciQLOnxtua/2
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88992fd8-f6a8-49c1-b017-08daf2eb5f73
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2023 09:16:35.8530
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ixX+/Mthu2YKk7V4xt8I6FZkobEkqIYb73L4Y6fg5soq+eDSY2H2KvG7SJJI2oieNHDPf1bsujg8VQwY4hAjhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5239
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Please include scsi lkml as well to allow ufs stakeholders to be aware and =
comment.

Thanks,
Avri

> From the UFSHCI 4.0 specification, about the legacy (single queue) mode:
> "The host controller always process transfer requests in-order according
> to the order submitted to the list. In case of multiple commands with
> single doorbell register ringing (batch mode), The dispatch order for
> these transfer requests by host controller will base on their index in
> the List. A transfer request with lower index value will be executed
> before a transfer request with higher index value."
>=20
> From the UFSHCI 4.0 specification, about the MCQ mode:
> "Command Submission
> 1. Host SW writes an Entry to SQ
> 2. Host SW updates SQ doorbell tail pointer
>=20
> Command Processing
> 3. After fetching the Entry, Host Controller updates SQ doorbell head
>    pointer
> 4. Host controller sends COMMAND UPIU to UFS device"
>=20
> In other words, for both legacy and MCQ mode, UFS controllers are
> required to forward commands to the UFS device in the order these
> commands have been received from the host.
>=20
> Note: for legacy mode this is only correct if the host submits one
> command at a time. The UFS driver does this.
>=20
> Cc: Martin K. Petersen <martin.petersen@oracle.com>
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Cc: Avri Altman <avri.altman@wdc.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/ufs/core/ufshcd.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index e18c9f4463ec..9198505e953b 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -5031,6 +5031,7 @@ static int ufshcd_slave_configure(struct scsi_devic=
e
> *sdev)
>=20
>         ufshcd_hpb_configure(hba, sdev);
>=20
> +       blk_queue_flag_set(QUEUE_FLAG_PIPELINE_ZONED_WRITES, q);
>         blk_queue_update_dma_pad(q, PRDT_DATA_BYTE_COUNT_PAD - 1);
>         if (hba->quirks & UFSHCD_QUIRK_ALIGN_SG_WITH_PAGE_SIZE)
>                 blk_queue_update_dma_alignment(q, PAGE_SIZE - 1);
