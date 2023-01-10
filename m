Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A4B7C54EBE
	for <linux-block@archiver.kernel.org>; Tue, 10 Jan 2023 09:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjAJJwu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Jan 2023 04:52:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238256AbjAJJwT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Jan 2023 04:52:19 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8BE120A7
        for <linux-block@vger.kernel.org>; Tue, 10 Jan 2023 01:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673344338; x=1704880338;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=fmG8DUTy7qlL3i74a/tLGWSB4hXQyEi+0Q6ZamHAPf8=;
  b=jhsPMwOd0WMKdFNN4bMwu3IjQ3lClk7OHHu3lazWQJ0BCqJurV/rl8mE
   +BMDkPiMAkwlI2ObKgMt5XR6C45krSK1JZyssNFgCuHn0XfVLN9IuWGFr
   HpJL6tyS//xCKdWoxxhK35R0KKuP5UYOIzpeTWEgCDhqFkoJXSRXh/WEP
   Us27CStK47q0jNvRfuLpC3RK2WwZcBetnWBqWVSkGt3aVG+tmPNdvbZy6
   W0Hir5o87XclirKycPxVxju8Kf2CH2mxx2ZWuCaPGccoocNnXVMkCUKI8
   AMJru7fRSTx2XndFtpdmMEybAqLlzttLZLI20a9KXo0LebJ/h0e6IlfQ1
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,314,1665417600"; 
   d="scan'208";a="332437121"
Received: from mail-mw2nam04lp2173.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.173])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jan 2023 17:52:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hywYt+i8enWNKr1MMyS9XMtc9gTaUk+zYN5F8M3rYt/AMLpqvQR817ScR1iJGLqwvb7+gqsOWpLCH22B8+c+02MpgozlXpPSVmxSfR1H3REXKLwbaNpmkdni+62I/MnJgNC20VKG9+bl+BP4qVrEcAn9XUCx81IBxscoBJ157/MVns4mAj85ROMWMHa0LpPT/yOvEHYb3oIJbxDtweUr6E37Ket5CAS7qCl1rBHX4AvUwx9GStAS8rAMLWINAzfSvIHdM4YMAGoOVK2JE5DS5HtoSZU8usCSgmu0LzwZQCsbsp4RfFVDsDG79A/jPjLmmM5gO5Aw97YJcpZ9do93aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WmU8gjb9IWWoZ8omQUNWcReGSYT7GpAmCrT3Az4KZb0=;
 b=PpDqKPe4eLXg3lR1Rgqp4pPyy9+BNPMOe6SxKXE11M4CBkTxT+U4/6qCkG75MQQQljkMNiC/KVaT7stTcBKSNKL0rCnMq8cqGty4+w1HqKQ2q51vW/hh5wZkFTZAm9AnjtExe4yVe4nXKC+CV+cCkNiuR0RNKnLeCz4yT+Z7zwEYbG2wM3YC8tQ7F8kxduzlFWlwww/NXK2f4c2YjixEB1ny9eGJk/AgAuccV0O6E96MUjMirk2R3rB3DCRiEy7F4g4wBut/a3kZQM1+oZJZnfysmzAyl1+0sEFxElhSEW+Ap8DC2dBmItURTKs9SLUtbuRjREsaLi9Dp4FAk2QY1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WmU8gjb9IWWoZ8omQUNWcReGSYT7GpAmCrT3Az4KZb0=;
 b=DX6WVzJt3PGFkJQClXnXpU9Zvlv9itUY4FD0yWgKh0k/co/PP2DlLFAHcwwaVpLtSpweSVtenq8XXRKqmonuGTeLcRNWyOgM9K1NuUdw+rtHCSCLJMP5CoQXMYJ1MxCZzIlXwF7eqm44y8bzjp0TiBmAeIjeLbJucuGee4J6vMU=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by CY4PR04MB1144.namprd04.prod.outlook.com (2603:10b6:903:b4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 09:52:14 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::a65a:f2ad:4c7b:3164]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::a65a:f2ad:4c7b:3164%4]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 09:52:14 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Avri Altman <Avri.Altman@wdc.com>
Subject: Re: [PATCH 2/8] block: Introduce the blk_rq_is_seq_zone_write()
 function
Thread-Topic: [PATCH 2/8] block: Introduce the blk_rq_is_seq_zone_write()
 function
Thread-Index: AQHZJNk3XHj60bP93USrHT1itP8JUg==
Date:   Tue, 10 Jan 2023 09:52:14 +0000
Message-ID: <Y701TJtNyj86G1QV@x1-carbon>
References: <20230109232738.169886-1-bvanassche@acm.org>
 <20230109232738.169886-3-bvanassche@acm.org>
 <7b90e9e6-4a32-eb0d-bb42-8cd0a75159f9@opensource.wdc.com>
 <22912d92-dd0f-8fc9-8dc5-10a81866e4ee@acm.org>
In-Reply-To: <22912d92-dd0f-8fc9-8dc5-10a81866e4ee@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|CY4PR04MB1144:EE_
x-ms-office365-filtering-correlation-id: e7cd171f-5439-4495-c2d3-08daf2f059e5
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TzP6fH6sHSnbwt8eOrhVxtq5GvXUGmTQirlODywxxln0NsNopfZv2ZFfmFmk8nwP/8462yOEZsp+1nJFuaZFhExHQdSunoZHPzdXh/CX0xrSwS37MEMjM9cXM3ZlJQT5ICLbqIelHM6W2PbUTOKme2yV6x/JekeqHJ33Ool/xD44a0gLOcake4JLsWSss9CydeftdbWrfCSvnBxY+LvSni6yFKr7IfAwvA0wFmLci6249EL5b0gP8LQAnsXl4aEu6eQAkLQoT+VEyWVv0jbffZnZHHXTYXrvATtiN7iKngqUoVPE0AUHb3aCgsp5NqlTbqorac9Lky21cWQqU+DyzgpZxRVpdc9n5VOh+Mhk3P1/nx842MH46/Z4wgjjcCZrf58lYEs243dKYMDgdY4m41DQRotiodbvImaANqQ9MUIuRNvFG0YpL5lUSATDbQ9/oF4ap77FSTGhYeLFz1NTuyzhqgu+B9/lgSW3pPnBRO42AuYdVtUAiiobvOcbIUqoRpMwtYnqOZg6sVZmfQ4hUHxuBu1sh5WeujWLRGc/wjh2zahDXQVbMcRh0vUhcFaO2apyQkI365Y288teBgjkGXYInspcc2s1tSoSi3CagVUHJa1fiqiZ9SiPKEMobspLnUUq26lID1JPYVlB4SY9xi7Ws3f1yhorxUP6gnOl6B4/cKc8ikFygvweXm0rIRTx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(39860400002)(376002)(366004)(136003)(346002)(396003)(451199015)(5660300002)(316002)(33716001)(71200400001)(26005)(9686003)(6512007)(186003)(478600001)(6486002)(41300700001)(91956017)(66946007)(6916009)(76116006)(54906003)(4326008)(66446008)(66556008)(66476007)(8676002)(64756008)(8936002)(38070700005)(83380400001)(86362001)(53546011)(6506007)(122000001)(38100700002)(82960400001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VQeL0iI3rhqQN0Tf9KYxaFQ7PZ6CnfMb5OWZre9+71a6C7JjgK4YbaGKpTml?=
 =?us-ascii?Q?btr14tAgx766i8qRJFkxRjmA6dV8HF9zjIiUh1Ch7oAQqSwFiuu1fY4L1o6P?=
 =?us-ascii?Q?i+mZEQvzenGxK0v8etbb4blss+JTZkRRFcvOTTam4fKD2Ljn2NGloxludWQt?=
 =?us-ascii?Q?8LC3IsIwFVwTHKXzsykEuc1Kdeux6iT3fuJ5GxN6Ui+BRGjLKQUNSabBd46/?=
 =?us-ascii?Q?iY3Hetv3zY/lPOY1/9SQs8fWoOd6nMZeAOOITxbtPFvtGfHe7Hd6MP/uU+Tq?=
 =?us-ascii?Q?A5UH2bdqJSAC1CiaJ201RT7wP4HlZTXTqQ6onpmGOLNTcnoDZn2T6uj4Umjk?=
 =?us-ascii?Q?IwRCKhgOhXQcYEEI1/Ki9DdkvesCz4R6tRhCRiTnqAnbtOkGMEhnd66eJT3Y?=
 =?us-ascii?Q?Js+MosirK0r9UMkXQPBT8K2BJJI45XHigrlbHDlElNOXm045GdmZ7rrWTRpX?=
 =?us-ascii?Q?WicUcPvPj5YjMC8l6bTf3I9MHVzuag/Eg6gZG4WxMYoyPTXYOnbORu0rehjW?=
 =?us-ascii?Q?FasO3HRUM5j7KjGZf+gKLVn5ack8P7ghaF6cBr8BSec9Qm1egkzQz2ks9xsa?=
 =?us-ascii?Q?3NazJ8mbZPpbNJea3fEy24o9DuGXTOpxEAw0ecec5Ahc91HAizXMyhJ2nEPw?=
 =?us-ascii?Q?wEHT8c+QooXOS9Ek+1oPWs7nCHglBaV4jnkveguaVvlAqY3pfIYC7z8lrX7X?=
 =?us-ascii?Q?R2mMXWo4gYE4TlUDwMd5IZXhjT6eIhmu988JVrH8g4J0pHtj4tXs2gKqtf0w?=
 =?us-ascii?Q?Al/qIsxYG6MEqh/C6WVCDdGWHxLST8Lq99daTloUkj1X7jBeVa/nCJseMXPZ?=
 =?us-ascii?Q?c+rOwnlfBoYNBqg0EhM1k1GRnxgOv63zybZIhEZRN70j59DlTzVSknqTpxX2?=
 =?us-ascii?Q?7O2Ht1XimvkzFF/Il4ihzK9cM+ivtiB/B/G5aMpnU0CcgS9cYLdsWFJiQXVG?=
 =?us-ascii?Q?5w8A2MqXrARmgjFHeupWBQJH3L4d0FhAcMmFGKVGdj8Ec3ergs9Ga6dTw0Xc?=
 =?us-ascii?Q?m95y5RtxrBWfWBMQRJ3AgA6201HxpO3/XGp15sh4VVCZWXDYv+jNTvO5L9Nv?=
 =?us-ascii?Q?j9myFDzhbBk2EFoCxMGGE7wUHQoVZ/1elTSVPz9NinTm0Sr7Ai5YhPDtzLVz?=
 =?us-ascii?Q?fbhJlxnG7oAKgJ9RK9U39VP6alh49Tk0fsRXFb4z8szZOxEySo8SPmTNZL12?=
 =?us-ascii?Q?/ad/SQkhh/lZ+iwS4hJXerRdTWjm7Aw7/DWzWus/AJLHdRiYhEeMZshfkbrw?=
 =?us-ascii?Q?MPqYYWAOUH0HRbRdW1eyeoCK8c9ZrYd/Gn8rAmeDAez8HFk19fCe1IzvG9b2?=
 =?us-ascii?Q?CI3uwzhYSxHkffjjIveL7dn7BvS81p3Px4PMysYPlvLrs2qpq2RWUc72QrmH?=
 =?us-ascii?Q?v2Y83cRGRQ5ywBwXZkPpld/qhrjttYtI27d1gFsdWzlWgTuRI+k8apQ8SV3W?=
 =?us-ascii?Q?QxWl2lpdLQJ2IafZjpBR/Yv1Rots4V5w+0LS2naDjRC3/NLrGb2uzIlA5w5H?=
 =?us-ascii?Q?wxkFNtMExqrgVyYUg5S2L+aFbR9AT/ZQTRSewSdMqodUXgZMnfL0mWMo4bhZ?=
 =?us-ascii?Q?04D8igJpSGjZpy4b3wQrSnzvsHJRAX+N+iCxlb8Z+osheiK5R/hBGZQcpr77?=
 =?us-ascii?Q?hw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A3A17900D85A0D4E82005B0D53FC9445@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: u8rlJUzTFUEGdOih/vKgHjtOzyiwMTyVlRrHSbgk7PFEe129AKWRiGK3hAuw3rDXFNCcvk0RqfF4G76YtUkZ14Ltv1+vfbfj6F8PJ+axdTBGhNAmxWgmFYCvR6coq48fCcgUQh0QdvZvH04VdgGxCEcilO+anV9MIc+epSAkrIVpIua6U3qjCQ/6kQ3P9GyOyWJGv3Vcx3Pv71d6EQDqepk2wwnJhzBwx2z3sQhsUWXdSfW9po63m4K68ceshAuGpJc7z0AoQcK1nicDk1470zJqhTvI5nLGOrs7fuZClSOuvwBehC1RJdGb/bfDuC17yTpYKUX9+6ua6+6y4Dd8PpTgQHwNjSUz+ekmG/AlSo6rxJtLdoG/Yv0Rx7spXWL1kL3vSYf6C5VGCQmUGxIhfDStMnsq7zodWGdZ5soJcQlp/MJ/8WrQ2o0BKmmYA9eM+DEPHGD1aOXui4Q22S5pcfkdNE69qoR0iHKMprX97oXRUXRcmPXTt+wXG94KI93xuY1inlwyWaaF1EdjDbCgrGhwqQoGFTMEEcPIyF35NGTdjw4rlkDYvg33Al87BVUlOje2L9sWXmYus8Em4K1PR+zmUyVwxuADz/ImXbH3c2xq0aTbfW2C/SjW4mufV8v0DTEAkh23Oxn70AvuuC4yyGPfkL9sPuh/nz4jZFt2BPo5Ip0EIyotOr2Dn87C+NhpByJKJEoeONo7g6gn0LzxOAOT3n8y3vEI/XWaLFWm1mBR/a1hO3op16Ey7v9GNuO+VOoVD+JNMZBNWpHOM6fJXjUbFA/w1MWOxn/5GtAZaMy0PHXTLZR5c/0f9itz/Jq1MYHXDDlWmmUZDkGbeHdnrxRy1OZFaCkn23CNwapcwEo=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7cd171f-5439-4495-c2d3-08daf2f059e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2023 09:52:14.0336
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SdY+T4RI1MeiipMUDkQYGQJ7wfiZEJpve0g2FI0dBpNYqWA3Vph+uDjbNUs3gfP7+coC52Q9dFtUQQUfw9KUkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB1144
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 09, 2023 at 03:52:23PM -0800, Bart Van Assche wrote:
> On 1/9/23 15:38, Damien Le Moal wrote:
> > On 1/10/23 08:27, Bart Van Assche wrote:
> > > +static inline bool blk_rq_is_seq_zone_write(struct request *rq)
> > > +{
> > > +	switch (req_op(rq)) {
> > > +	case REQ_OP_WRITE:
> > > +	case REQ_OP_WRITE_ZEROES:
> >=20
> > REQ_OP_ZONE_APPEND ?
>=20
> I will add REQ_OP_ZONE_APPEND.
>=20

Hello Bart, Damien,

+       if (blk_queue_pipeline_zoned_writes(rq->q) &&
+           blk_rq_is_seq_zone_write(rq))
+               cmd->allowed +=3D rq->q->nr_requests;

Considering that this function, blk_rq_is_seq_zone_write(), only seems to
be used to determine if a request should be allowed to be retried, I think
that it is incorrect to add REQ_OP_ZONE_APPEND, since a zone append
operation will never result in a ILLEGAL REQUEST/UNALIGNED WRITE COMMAND.

(If this instead was a function that said which operations that needed to
be held back, then you would probably need to include REQ_OP_ZONE_APPEND,
as otherwise the reordered+retried write would never be able to succeed.)


Kind regards,
Niklas=
