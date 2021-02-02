Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A9AC433E0
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 11:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F51F64EDA
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 11:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbhBBLwN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Feb 2021 06:52:13 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:48015 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbhBBLv7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Feb 2021 06:51:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612266718; x=1643802718;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=mxTrn+pu0pesUsDPpQcWItAcmDK4gw4bbI597D+9vS4ppmnFAk7cd8Gz
   /hIF1OgAA5cFOhDXIyGJIFKL0huhlj9xRoI6R7aWXmh0Rr43xKlM3ZDY2
   QDQv4LE3wDNXflI7T3m/sKWW8dGvuFYOr7p/+W4uwf796jvVhNzjssNlE
   OAOwwInd0lVt9yfuVqbLwve5PUbhm7RxvnRyh+x42Gk+IctaxwWOQxCmE
   kWxLTyuhMYiN+ADlCJnclV0aNu4Rj9huyp6lwpy8q0zj4juL0zD7evZ2f
   QCTz0W7GuEKpyY0vV8WG9+qW/ceSF4/K3/so643G1HGIh+M7b3zFq3l9i
   A==;
IronPort-SDR: Ty6UXA+F2Dpyx9Ilmi2J1H5QOtcM/2moK6HnGgDNp3rhGB+F58jDvgFasgrY2vhHY+SVO38zDd
 SkXq7WfopKR4gJXcIxnjKBwK/dUka7hcjn4SPHzVoUBucv+N0lycM6qvWns+OrVVKDjzVcCJpz
 nhFQ4sHE3OIQ8Em9VaYlGrJvqtxpe1y1Nu9pSp7SyRkxYj+23kRVwxtm9PyJi7uORobMlmZ8Do
 +2c4CLP7EHzB+I6GZ4zbd1inSaSjwiABsPPCLDnVF+tP9jc6CxaWvhLiebKCowDj3JqCzx6TO2
 K+o=
X-IronPort-AV: E=Sophos;i="5.79,394,1602518400"; 
   d="scan'208";a="163361456"
Received: from mail-co1nam11lp2176.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.176])
  by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2021 19:50:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K3rQOWWnYE/GT5Q0izC4CjHYt7vAX+Ui98/VacoqvSd7ywJStR67e/vg8rlnlI9ZqUDOfnKN+fINEJal+4H8YDDAXWHSI43nyH1zxTLRuCop/ZJaNacfReHVY67+JGIvgYzJ4kHjhs3Yga8bxrBzbyzEtUdsjMVtiJa851n243SPPY4ziVKAk+EV8FaYYy2ERDA0Qi+q9ZwzWyC6VAdbvsmckDs9tbZeuq/OROp9Jmd3FPYd2qdqhRLSE/eV/UJx1mpLfMSj1AGfv3LKpaPAYn9SpZoOk/bw2E72FpQT09BT+R4/0RVFEK8XfCP2lVk05JhMxew9O99AK3Q7q6a5ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=LjIhskYIQAXuuT8F2OjE0P+0P17/1gpgiLcq47DmW0/cPsaZfqWqyPmX1UOthuhbSD1wXGR/T19HtGJ/eq98WStvk3s8HJsp0I3VsZ/0mXv3SdDJBidACa7EDzyzNUnGwwVzjW+wsPg/DIIjOKMJoGkv9edfWq9AdWeow+7E8NWo3TBE1143j0FroG+TCZ+s9Ynd5PUXLdcmgDyjNjn4fvHGwye9RuqctfFJnDOomcenTD0lSHTlOCL2sHNE9vTK6IOZLs9YLfUkIueA9nFWStHQIoyGAWZxBa6VDuPbg9YDHDtkVphanKTaJ1z1SYoQIgg6Z2u2VcT7AOC+P85LCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=DVc+jstjjGMcJBEkmJv62ilWWriAl1kMRPIKAhzrXy1IWD13Ee3ZAj5EqTB6v6zLScBjm04Gl8XF3ATCMt801rbZIvg3wy62GfabBNco3n+CDGauBzLNbwy8h5/uUi7R79SpFOsiQAshu0ZYPcJXoYWS39HvS7hHl4jn+5lCMAk=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SA2PR04MB7593.namprd04.prod.outlook.com
 (2603:10b6:806:14b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.23; Tue, 2 Feb
 2021 11:50:52 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::c19b:805:20e0:6274]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::c19b:805:20e0:6274%7]) with mapi id 15.20.3805.024; Tue, 2 Feb 2021
 11:50:52 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [RFC PATCH 10/20] loop: remove extra variable in lo_req_flush
Thread-Topic: [RFC PATCH 10/20] loop: remove extra variable in lo_req_flush
Thread-Index: AQHW+SXS3N1iNCfxFU6qlpGRUpH3cQ==
Date:   Tue, 2 Feb 2021 11:50:52 +0000
Message-ID: <SN4PR0401MB3598599AA768A26CC95CBB7B9BB59@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20210202053552.4844-1-chaitanya.kulkarni@wdc.com>
 <20210202053552.4844-11-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1542:e101:7173:b327:67d3:fffc]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8768d83d-8531-42ea-1848-08d8c770cadb
x-ms-traffictypediagnostic: SA2PR04MB7593:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA2PR04MB7593C0F4123AE3B027175A0A9BB59@SA2PR04MB7593.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 03GH8MRbR/L1og/BHmFUuBn3QR3I+qpRKy/E9fIZ4ssTwU4k8dY7hUgst38WMywqcKuJGBhEXsCrlmO5Rf9SIIOKz3RClqiuas/8do4Ly2YUzW8/O6HJFddnVLXcw/KtQ0RvGpqr5+ukEUkkA78KzU64VQC4L2X2Ey+sTZeHbUGT8m1i67SzvuryiY/X9zjnBkyeDgXWDCzbsS2/tA+tg7GqafbpZXgH6QBoSpNa4ZfQiLX0SFx8YP44grOkyfFpsM5MxGY1WVj4hQ/Rg3F3UGqGEp9NLYksekt1rUe+7JkgjZrsXivn9QMKZtd7+pozxQ2g4swuM6rXRNc1myxdv4Hgk9elXW3HZLfVKwnMlxLhEj/vsX2PZZ4Q5TBBNY41Tv6DCtH8rLYHaTCveURXeYbE6zUFDFjVWRoLhkdWNc5PmWKrGLb19OlnUXOVeRMHGbfqoG35hClr4pbyixnB8wqVoag+8+7wW16t56WLp/n3OQO64EufqPRRJ7CA1/eNm7/+J8V6jTa86NGeAe06Og==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(136003)(376002)(396003)(366004)(76116006)(55016002)(71200400001)(6506007)(4270600006)(316002)(7696005)(478600001)(5660300002)(86362001)(110136005)(186003)(8676002)(91956017)(9686003)(4326008)(33656002)(2906002)(52536014)(558084003)(66946007)(8936002)(19618925003)(64756008)(66556008)(66446008)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?lMUBFGpBuvSaUgM5+XFROEQvZ3aK1QpZXjC9+vBbDViQVdW3xNnK6eKGZCSc?=
 =?us-ascii?Q?TwBHrmMvRxLQ5I9Wwtql4030H7KZr0yRKWc2Z5bKbJiAilYSqBmYnF1ZWmxh?=
 =?us-ascii?Q?rvDrZmy4AmzvBFgBBRSmWTXzrLIwOZTZRiNn1sH7SedvGRAq2W9Yolil0ZnN?=
 =?us-ascii?Q?Q7YpxHh822Ck2kQQXbpw54waUpGc68AobQ4tKTL0zQERWJLMS87nRjR4/F8I?=
 =?us-ascii?Q?XsKEbqe5a1PsfcQ0RlGbpCtf4YstwYrkYoNFhrJDybJ2z1OrE7UHMbImvyaN?=
 =?us-ascii?Q?BRJQnsLjM0fdoN64i8Re4IMX13vTfgNJub3i7oN+6HoO2vYT+TpjSmpxHjE5?=
 =?us-ascii?Q?ZAJmw5RfyYXlsAE5xh/3Hw9h7W+xAuGcbVtJZs/oh46YRa/DweMEDnbHSBIz?=
 =?us-ascii?Q?tSownoL8dhbPGC+vXe+bepP86PPweXdTICKB2RxTAUosuQcOsxlh90KVKMXD?=
 =?us-ascii?Q?hs+BzK/nh0gv3LOwo6MZDKI/JtpiQYGDKyHwevGnMy+IZqLD7aBHUAIkciE8?=
 =?us-ascii?Q?FITQkMqvC2EdolSPOwdbNmd6wa5i4uEjhxyJ4/yK/9Cwtj2C6BGUrXmyx4Xl?=
 =?us-ascii?Q?2uHFBEbD7zKk54aYOMiK88NiGKJHD0/eIVPCKmTXhe7u94WCbMA1ug9wWi/b?=
 =?us-ascii?Q?L2gtFcX+2KudzWLXCiIOQ2l16KEpwThGbJcgZ0Vq5JhLJEwG/1ZN+52/PRrx?=
 =?us-ascii?Q?Z/lWXWjEItOyp8XfwhGqkgo1htmXLb5nmZtNpUZBqZ7BeQoDelK3pSyUIeCK?=
 =?us-ascii?Q?nKjmKtxoA2yhtLa3DWd3VkRSd39jxZmjCGX6E7BT1R/sYkWv7q72Wa6H0MCN?=
 =?us-ascii?Q?V6NYyNJ+5GQAHz+QVNXQD8Ag9Q7YC5zXO5SS3KFhurLP2C1DgP2Zj6Oo88QU?=
 =?us-ascii?Q?UsQCWo5CmOBcfirs5DwZhni0m76VdUP07VZe4l5qyet90JCID9UdAwlIo7qT?=
 =?us-ascii?Q?bFMKkA0wTNQYsFU6sCL3sa/EbPO0N91XygZWolR8PBv/wRM4Z6bBpjFhBya7?=
 =?us-ascii?Q?cd3N1F3ChpfNXfW0VFlqvAA9PPC7IIeHAHqGxsZ+SkfYqvcO6P8jIwWFozuk?=
 =?us-ascii?Q?vcT+Pf+cbda3u6bmIw4EdT9A8ff8WioF0UiRYPNIJnJxjVYctzswuM398b4/?=
 =?us-ascii?Q?77T/RJpZE9MPEpCmpsdfCDLiQuSV0gRdBw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8768d83d-8531-42ea-1848-08d8c770cadb
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2021 11:50:52.5406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xh0RP+lkYyDxjzLEcboBl9f1WxDWZ2azWqfqn8Ll8oDhFkRC5dp9wz/7uADLVHGxFo7urGYK6lde3zq746DOHXER1oIEUCR7yvjQIkTJLnA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7593
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
