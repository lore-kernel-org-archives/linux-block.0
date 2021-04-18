Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B1FC433B4
	for <linux-block@archiver.kernel.org>; Sun, 18 Apr 2021 04:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E61F61352
	for <linux-block@archiver.kernel.org>; Sun, 18 Apr 2021 04:49:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbhDREuF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 18 Apr 2021 00:50:05 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:30669 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbhDREuF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Apr 2021 00:50:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618721377; x=1650257377;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=TwJh6cNpegw8wkBCra20nyUF+qhtHJ6iw11phtNOo1A=;
  b=fBlVUyxs9U9EV+61BG1usQUqYpN1/h+fojxXw8cA2kTdVnW6DCz1SwhK
   uqCzeFxAn5jOmZWVwti552k1k1bUWy9qo9my/kLgSfe/vhyJkMsGJV5ub
   oFO4olbURE2s1uROTBdTWJFhL+BMnEs8gEM4MlqQqsIJrQriCHFTMxASo
   V98Ud8MqbaX1RVghFz1GBW8evzJpNcZFHJDshRx5XeVKibHnoKnp8bbP+
   aTLkc+qG+cU1Ay7xoqM43GLGhS+V3WyKriTLWMJDNv3H/g0uMwb1W4MGf
   OmHgz7KRr0Y8iCRnFk99HUCNwJS7q3VqbUf7zHp/RlDsxhjxorBSHvDLJ
   w==;
IronPort-SDR: bipNP1urK8NpySqAGtmntTxmAXMna08fbxFew+MMzKva56e7lYkKDEk5pU1wS0xr0u/B9y0i5U
 hicLSOM+ZGLsXb2XyHHSx0xfLs65PngyIxjZonCl1NDPv1zMo37D5Gi22rEE2oQ6ZaXudeGvr+
 klzcTFY9DnVt6IpaSiURet12hFuA+VbGYKsuLLQTE5J4R8ULPQ+KN/CSTrxqNHK5gL/kgZZsx9
 9GXeg5BmgKnO3sNmRJJjG5FfmX4OSB83LXaGz5hYVubG4Ak+iQmscaX67RpN7ExFFeV/Ecgtfw
 Bm8=
X-IronPort-AV: E=Sophos;i="5.82,231,1613404800"; 
   d="scan'208";a="169856838"
Received: from mail-mw2nam12lp2042.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.42])
  by ob1.hgst.iphmx.com with ESMTP; 18 Apr 2021 12:49:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D6Vnl76Bzjy9yBxQohRBpoogbNZqgToYRxOl2l6EYr043YMbpwXlcgrw3trAaxstC29/6KBIyEfhvICAVvTqd/2iFfcPDqMSseSPVDBiq+UUSmFoxIgsQKt3MNleQXztq7SCmpLQwUexs9bVk2jENkyW0GBIC3jjnz+kmXnYK73MYD6Ru1zkQMe/hgfahDb7+5hXcNvAaElem0T//FPAkrpJG061PhiA79e2rTOdmJLyQvtwUJbW9n0BTtmzyxQkGxiwU1EquSj83Qvfc/ErOY4vlsvYCe+I72T1Eho343+xQul/2zYDLYdiLbcwOm+IjGpLZ+w04dxRvfybSMWK0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SbyzyM6C7UFn4SnLwAAthb4MLgRZf8OB7In6mt0rNP0=;
 b=HvFBufmOp7jOSsopKiH8NYY20lqqUzX/SNFgpNfxw5YEuolxfPjhZE+XMVe5Wcppp0uSwp4sujK+LMR+y4R7JOjb48uRlwLeUxIdUsBTEeszmq9+GMyIGnzWLFfMQwH4oqg6XNWvA8w8qLKco27ojytNtfRYc1QC22QxDTUWMrVQZNpY72a2ngKDB/z2/Pe+NNuRQErsCPk4bfo5I/ApNzjtFceLhcgngYsj6fOAlEMouXsx3zFPPK8SN1JWb87qIRjuRvJxD1r00ZP1b3hH5xKrx+47xbYcfRDrnwz2Az9fb98v+4sMTLJy/nDlBbe/uhtznigrZxslvAS8Ggeh1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SbyzyM6C7UFn4SnLwAAthb4MLgRZf8OB7In6mt0rNP0=;
 b=PplVXVfstGgGh8VM7AO8mrkmqqNibLSgf1Lbg8Fve+P7aCf4ysFTmxRGSW1C9nBGjUJQweLqK4fsdErjxg0sAqTA5reXJhKwI7jumvz1X+uNZxDqQCWrQKeczG5ms0FSnBmdj+7mJZniZUDaofK6+UQSFEVq+hPaii+W3tVySUY=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4325.namprd04.prod.outlook.com (2603:10b6:a02:fe::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.21; Sun, 18 Apr
 2021 04:49:36 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.4042.019; Sun, 18 Apr 2021
 04:49:36 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] null_blk: poll queue support
Thread-Topic: [PATCH] null_blk: poll queue support
Thread-Index: AQHXM56KmL6kCanFwEqXUyQ/m0BBrQ==
Date:   Sun, 18 Apr 2021 04:49:36 +0000
Message-ID: <BYAPR04MB49654A1D4AC52FA3A8110240864A9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <baca710d-0f2a-16e2-60bd-b105b854e0ae@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 891f05af-ce84-41ab-3542-08d902255e41
x-ms-traffictypediagnostic: BYAPR04MB4325:
x-microsoft-antispam-prvs: <BYAPR04MB4325309549A3A4415ED7F1A2864A9@BYAPR04MB4325.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6wL91ORPz7ooYsC0wVckWRPrh8G/DkoLEgDTNKgBk8ZbbYoemHtkAeFzWpSf1hKWNctR2/tPIsZjQ30BLlPp1/8oHxYsdm4AfjB8+QFNX0JM/vdQ4s5V9LkxZh/GFQbI4uJbbhQ2RGQqLCIp4/3zi9/f+sQa2hCFl1F7NqwniSIuPgzbcoeNNUjBDJxn4CsAh09HR8M+Ftxe//5N3Aco9fhsPkYp/hNu9I6ENWigN7jsOL5p6slEwQ1C/RCYiZ9DJUuOoMhGTxgX76/tyZsN+5RJGgBHuenW8rffcU/XKtwxqzxynxY0Qtz15eWA47Yc513QYpyDn/8m/W584/Fgc97I/phZKjHWrks4ISUoXt4Kmex+2w3uXvL30ULKDglYiKHqUKi2gTrVWR++mC/sytnQRCsl5OssDLSzp8AUW8iTEU38ZiXYL/mgjp7KCXGOp2BDTH8zx/y9Xz8lQCLyaXji5Z5PfXdZAnpfFiVknCOSVuzAeQPqmDovW7lgEUT1cg5NIqRRIgdtvfiKs5Kij6gUdq7tcoCeTFsb9f4BkYeU8YJBjhOIKu72ZQvKUd5n1O6gKvjJv/TyU4O2TT3AbU8i6vUEQ60FWP0qN+6CqRo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(26005)(186003)(38100700002)(122000001)(6916009)(86362001)(66946007)(7696005)(66556008)(66476007)(33656002)(76116006)(2906002)(6506007)(53546011)(66446008)(316002)(64756008)(478600001)(71200400001)(55016002)(8936002)(4326008)(9686003)(8676002)(5660300002)(52536014)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?pEPJW0VF/2aaHqYpdmVj1bL9f5V1zavv/3MF3gZ4rlY2FBwU41nD0+zVsIMD?=
 =?us-ascii?Q?RtjLo+N05KU51FLUvkn7PILmh7SjwJQnY0ewXqnAAXuI5sQdB1bf8+3SEhZg?=
 =?us-ascii?Q?gIyJX5es77hYeOW4ioOIfzhWvlOdahxQUQFmkDPtuzk2WVTU5iXmF1H4RjuQ?=
 =?us-ascii?Q?EPsGDgJo3Pw6zINXfrhynb6EyC6Ewx+J8UbD+GBI/MNxXUeR1mpUfHlwdj5U?=
 =?us-ascii?Q?Kx/IgzkBEGcc4ILvnkS2ojJqPHK0+l5SyJoQAMrZUP/2WFEp3xZdfI/fc3B+?=
 =?us-ascii?Q?hH6W0lioR04V9TGr0/qjQD6YwM9aw2E8XPvwxDvZFW5XSMNaGcvzcp/mOI0F?=
 =?us-ascii?Q?xFHjmS3TXgaP/acYJ6W7oYCU0MPuE/YmoTCEC6uiOwRP9L9iWVJZEUEAXOdx?=
 =?us-ascii?Q?44oRuIEKCSvXz02sVlM5CBW4fIhxC+TMulldGrOOIMibC2ZLUEfbQgpsG0TP?=
 =?us-ascii?Q?fz/zm1WHv+w/AqnEfG9/NNCNq73eV/6XQMIy5zIZN9zEjO6msTVis9uZU+On?=
 =?us-ascii?Q?3RZq1bExkvPVYoohy6WnAX0BqmV296L2k/KiunBo5DkiRUwAJHw50Z9bGujn?=
 =?us-ascii?Q?rqKXkhgoxqEskL2w0v7BJeNVMMCJszRyohRJ2APFWv4gUzDVQYTj81312/j3?=
 =?us-ascii?Q?N7/0419YwSrG0MA+AofghP+QRDNukf+mi1tZOnpkMjDtbBwl8hbahEwolwHG?=
 =?us-ascii?Q?eUvtACyxCbdpBgsHwTuZslLTkOAIEZGy9GYD/FHmytwGyZmQIgZPnaz2DzUs?=
 =?us-ascii?Q?2Zdk8J8khDzjORTLEZgxkIe3MDc0CoFz8fNru+D0wwSDIbiVlFdhktpgMLZg?=
 =?us-ascii?Q?0XuyCDwcRbhgmMh0uQVQaG/GeKC+g06Bizdd9Yr27qCd4/Iars2fj0zuxipb?=
 =?us-ascii?Q?fU6w9BOyrm5ScIpy1EHeJiS9H81cVQJqPFVT1zhSIFjfItEta9gxivG63wMO?=
 =?us-ascii?Q?OE1B3kj+qjpdLyPFrvcpCwJOpaiA4LhptDWNErahl2KdotXgVv7CaZqZGUlJ?=
 =?us-ascii?Q?E/4fCbejan+Vg7puHZlKzDt/Ysd7vGa1sDUxbL1ymcA1YMIrBWwjnkyHxA5o?=
 =?us-ascii?Q?xH98eSvsb+WiD+KwtuG7tsnA0K4Pcd7CPFwtl+K+17H1klqOIUcowitnY9O2?=
 =?us-ascii?Q?68PnALfBZM2tIPx95uesrXGy2Tp/whOd11HizPmvAfP3o992gc4X/PqO8mpQ?=
 =?us-ascii?Q?rehTHUy1iBEu0zIDfDelVQqhV74hGYTsdA+AgLB7UsepW5L9E3ODhBifVDJw?=
 =?us-ascii?Q?DUnOAVR/Jsv87r6sCxEyfSLBIa4StAupPxLHKnriOt/j4UxkeE2IrZ0DYQGl?=
 =?us-ascii?Q?PQJ6xY5iDptdaYHiqT7twYVL?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 891f05af-ce84-41ab-3542-08d902255e41
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2021 04:49:36.6703
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hIHcJWjYVrUz+A7B/lFs//90UuAvJn64LHj9WxSVDvcleF6deuQybX5XLX+jqeXLk+cQP5pgYhGOD0TT727LBlbBDRXSEdsZd4qYfu56evI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4325
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/17/21 08:30, Jens Axboe wrote:=0A=
> +		cmd->error =3D null_process_cmd(cmd, req_op(req), blk_rq_pos(req),=0A=
> +						blk_rq_sectors(req));=0A=
=0A=
How about following on the top of this patch ?=0A=
=0A=
diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c=
=0A=
index 8efaf21cc053..4c27e37ccc51 100644=0A=
--- a/drivers/block/null_blk/main.c=0A=
+++ b/drivers/block/null_blk/main.c=0A=
@@ -1496,6 +1496,7 @@ static int null_map_queues(struct blk_mq_tag_set *set=
)=0A=
 static int null_poll(struct blk_mq_hw_ctx *hctx)=0A=
 {=0A=
        struct nullb_queue *nq =3D hctx->driver_data;=0A=
+       blk_status_t sts;=0A=
        LIST_HEAD(list);=0A=
        int nr =3D 0;=0A=
 =0A=
@@ -1510,8 +1511,16 @@ static int null_poll(struct blk_mq_hw_ctx *hctx)=0A=
                req =3D list_first_entry(&list, struct request, queuelist);=
=0A=
                list_del_init(&req->queuelist);=0A=
                cmd =3D blk_mq_rq_to_pdu(req);=0A=
-               cmd->error =3D null_process_cmd(cmd, req_op(req),=0A=
blk_rq_pos(req),=0A=
-                                               blk_rq_sectors(req));=0A=
+               if (cmd->nq->dev->zoned)=0A=
+                       sts =3D null_process_zoned_cmd(cmd, req_op(req),=0A=
+                                                    blk_rq_pos(req),=0A=
+                                                    blk_rq_sectors(req));=
=0A=
+               else=0A=
+                       sts =3D null_process_cmd(cmd, req_op(req),=0A=
blk_rq_pos(req),=0A=
+                                              blk_rq_sectors(req));=0A=
+=0A=
+               cmd->error =3D sts;=0A=
+=0A=
                nullb_complete_cmd(cmd);=0A=
                nr++;=0A=
        }=0A=
=0A=
If you are okay I can send a well tested patch with little bit code=0A=
cleanup once this is in the tree.=0A=
=0A=
=0A=
