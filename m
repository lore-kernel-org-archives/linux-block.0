Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E85B8C43334
	for <linux-block@archiver.kernel.org>; Tue, 19 Jul 2022 07:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235287AbiGSHco (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Jul 2022 03:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236498AbiGSHcX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Jul 2022 03:32:23 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD17233A28
        for <linux-block@vger.kernel.org>; Tue, 19 Jul 2022 00:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658215941; x=1689751941;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=bZJT9YjfdzYCO9uepwEUtZ0PPCcaaW5kBObTZkiLfXWXBPxhjeazsZ46
   6UgHN0T83exQI8zOMuhgNuatWBiM56M4tOh7gWUw9QJ5xmoo9kUl8nKua
   mitZh3LJinr9wxBo/sGquKpkRLvlgMZvSrBcIwvNnD03LTGkIQq2Jx7qW
   IBXi21gLvSee1/YCo/qDIK+BIpxvLXNOkJZv5XHy/vNZ2ofHejaGCClqg
   FtPmhdMsOrBxFgaWlja2m+PflacXlJ7txJdo1ljKpavdQr5DmIfMaQUQu
   LaTRgxq/ITvqs26DmIp7sbNogYotI3GX2KpuuOdQAXAWiU0DuqskugIyF
   w==;
X-IronPort-AV: E=Sophos;i="5.92,283,1650902400"; 
   d="scan'208";a="206961469"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jul 2022 15:32:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WqQmer9C5kCWFL2Wrwb8AUMbu4QNc1F5f9mdH/C8ekP6aVM9OTp/gDHmtPQnnwhrZKTjL9f9ObxHg46ZGeNN4b5jfVSBaCpnL/Jbt+OyW7YwSTSqpGSOk7xhmpfLNhCq+iNiqTxHH27FWuIo8fn/PPYVr9e5L4R0RoKv6/rzWIyhHZmiuCPbKEXx9/jfk230McZLzrvTfDRGXpbIkU1j8cR8mIRwNArgAZMECe6pmkqUaE7U009fl/8EO0t1FBU88KN6+2bu11IHXOTG69uLmWTpLeOKPY2ydrSJXErv+55d3fYDA3detb9WC8Jk/RPOK6fCb5Emp1jSfWIskSdx4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=UnqiSlh2M83PIYcUAB+GTqvGWkRS/2nwuC0cX9lINh+0INfqTn/d1Pu7UfeccE6hw6XyBXYNxTy7y21LiErEy9oAlT9GaU68RdD0Fh8tBANB7I3VG7Hw6VmW7b0VBHtvTLgxJTi4GQpD43CZCl5ePGs6yRz3GNPQ5fy+OBwUMe8WOfLgcfC1eOlugOUQp0c7bCPn+KAd6oP0MB5HLo40mnmeb+Edd9bmLm2sDb4rSJYw5DvuyWdsMuiVPe+7Bg8bUUksJiMQSjv2WP7rQMehL6EY6T++hZW7YKYEdXspVZDaNN7IVtfAcl1EAA78zzOlpvrIilp0r28e/XCXsiuOSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=NdChkGyiBgP4Xz5dClXh3NTljQDQBSvOBUJDL9Qee7/WW+hEJfapiDOyDK96Ay++gdjNniDpK3sVPYrG7C0iGvr+364QnteDG644cnd7NHmJi1yxxiB8PUBsxAJTFuAYyODHkjSoBHydipuADW/sLDlzzMsRkPJG4V5gW/YSnS8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BYAPR04MB4712.namprd04.prod.outlook.com (2603:10b6:a03:5d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.13; Tue, 19 Jul
 2022 07:32:17 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ccb9:68a4:d8c4:89f5]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ccb9:68a4:d8c4:89f5%7]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 07:32:17 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests] new: fix test case addition to new test group
Thread-Topic: [PATCH blktests] new: fix test case addition to new test group
Thread-Index: AQHYmx0jxTDEM3A6C0aM5oMraWaZzA==
Date:   Tue, 19 Jul 2022 07:32:17 +0000
Message-ID: <PH0PR04MB7416B1B87A59FF111CE33C579B8F9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220719031036.1395823-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cf94e83a-689a-41cd-5e2d-08da6958cea5
x-ms-traffictypediagnostic: BYAPR04MB4712:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VHmMeBlB9QcDyotuAMt40jtDcNX36NsXZzEAh2622tr3HTNUu5SnniYUkHqzCK/lW+8cxhGxy1X37IfR4BBPlDfzyrPpOyK3UGMIrJcmHJ9hUtYgBhl9IME1uNlZgy22I3qfBRgw/FvI3c87+YadE79ZooYZlp/gRmTehQ6DrIUetzH5aFez4mQN2roPC1qhkAO0JIN8nHmelqOnc3P6E84H77THX8FeGKNvaaZi1cQ/eJQQa6s0KXswts01ygO1gAoVZH7RmjgKbR+hLQlL+RVvYCJ5WZOFLKiVFF8ZL/z6JGdGW1JSRCr00jIJWcU28w9FWHxeWQ1SLOOgrqQ0LzvXJNIBnjoWeAJ9+hHAMBxafYBjiKagbG7K0TFzFOr4QaDnU1qWJ0XmS9DYl1kNZWRP6Kky/dDoCr/G9HCDKIoPk5tliBcmkSq51gGNW9XjBA6Pj12eMwq1d7FewQxkE5aBLup29bSDS+uWJIz9TigWPJijEby0PqFvOhvqvjJprl9LMSZzAXmDr32GpoLf1p3E9TkfRfubk9OOntI+G00PnMkNFCx3785KLpB5q93eos2hVKPlUH/HiEHFOEuoJJdJpbPAJVfNFffGV0AnxIwZIsuQOlDIbAIG0Vvg/t3xJtiJRf2wyLXr30k2dvgFV9t+OjK8bLR5UUYBbn6TC/Fp34NXAtIcX7R8Jgs2DCtCiG9HS5WkPLaIZwS++WlqBEt/PkA+8y4/Ur0lAsb/2FyuXB452/GnPLvumqBAAd2lEuppJYVzfbNFXwX24MoXfHccMSADhlT/k0hLSq18rrk5nIGZbCaSykNXFbAhA7n4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(366004)(39860400002)(346002)(376002)(9686003)(2906002)(19618925003)(4270600006)(558084003)(186003)(33656002)(41300700001)(478600001)(7696005)(86362001)(6506007)(38100700002)(5660300002)(8936002)(52536014)(110136005)(316002)(76116006)(122000001)(66556008)(38070700005)(64756008)(82960400001)(71200400001)(66946007)(91956017)(8676002)(66446008)(55016003)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6YO4eRJMuFA583o819qnWWKFshWc1ATN/7njdR/tG/UTQXXdfQpTOSmmg8A6?=
 =?us-ascii?Q?V3FmobxRz6sjkCOuJbJ/HJA3Tb2Tp/AVsyR38ybilJwRXxOeQxwd920D4wOB?=
 =?us-ascii?Q?2TcVHhjCL+AMyv+SBbNoJu65Q8lTgvwoEkeBhPyODo+9GSWZziCkj1TxHWa3?=
 =?us-ascii?Q?Ag7i+FZlxbOMemUNL6h1H59RCWuPHaHZiUvlEYX28e2+DmLMqxQ+EkSgwWFa?=
 =?us-ascii?Q?68oymjJepGBL/E8A9n+ilVrG5Q7AsDVRQo6yOmizCGDtWbgwaEfoFYDyR26l?=
 =?us-ascii?Q?ukBMgl1CFxGJMLlqZbW/9TgGzUYHzj9ZVPOdvlKB6zHr1CCa2kWCPGodIUgn?=
 =?us-ascii?Q?dhxE23/R2aGmKQbxr9YCXoliHEtnKJd27AYnw4M8yvU6OazYOHkulmXTZvv8?=
 =?us-ascii?Q?CEypBUR/VmXRMXqWub65lAQshXyJM9zPakHQMsmKJd0H7Bv9ovo2va4C5oDI?=
 =?us-ascii?Q?tq7nTAoLQY8zUrBAbBoOI5r2MHqppKyneR/kcFq1sSrZ+sn26o8G4Mvsc0CF?=
 =?us-ascii?Q?xMgKrq+w6ueqsLNvX4upJPdZkc/41aIs19Z5JO2x779qvY0waEX1tWCovIfH?=
 =?us-ascii?Q?i3FAIikD1B/bOydf9Ml/uzyMc7vlNdqgqBeZWHFuSwYYziA9KVKegO6Bil3m?=
 =?us-ascii?Q?WLsiIdktPp+2HItexqPW35hh+qTHLmcyVaGlMUPWXZ43MaQKwE3yxog9yqxg?=
 =?us-ascii?Q?XqJGanTMo0awq5BLM+uMGGk4ijVNaZLF8AnfU3ZIGzcSbhFFAHnbBdJgd7gS?=
 =?us-ascii?Q?UpWxD+WjUa6Kcz09iMZn7NZd/6WP2vSOLQ91dRpDYZHISycFjocIdfPZ1hqB?=
 =?us-ascii?Q?A2JTkfTf46i3zwHJhudFzHXY0QOX3CjDFgB2javaWQ2UjhbmfNmYQ0xenEvs?=
 =?us-ascii?Q?oFbXRvKDkxsfGOqvn3N8BHLQvzGMv0R+9vdvmp7+JM21k4Lx91nBUcS3Qarc?=
 =?us-ascii?Q?726ICb8wl03pTOXI3Zn9powYKxz3161IydiZy5QeNjakHBTYdi6sjKNMHI5P?=
 =?us-ascii?Q?lLjPDuBVSeDW36fNeLuPDIpdYQVxd6dadX8IqC9Iq27ONS/i1ZIaYS0/8MpN?=
 =?us-ascii?Q?4XCfW/ieOt/Q24k2YJrOi7OfJ/ae1SxXSPazpXucRlQJ5Tjz9Wf9H0rC/MEK?=
 =?us-ascii?Q?fYO1I1ZWncYS1XOwKcB7VoMQP9FOzTRr2HqXwX3EFdxvRM64MDVPp7QE7LEo?=
 =?us-ascii?Q?r4sk+j4d/T3ogCl1/QueAMukxwGfU3nXfVDH7btf0X1HxOtTHBkDSNi8Mc1P?=
 =?us-ascii?Q?fZ/BP6uLhEWHarqPPF4lIrnowDi77iXyGst/cT03k+sDeaYmzyeUj+jwSN5w?=
 =?us-ascii?Q?Ot6PpaqMX40q/abNREUV4WIBzKzrbiv3BRaPbMAluDaO/0EGYeo1gVaBQbl3?=
 =?us-ascii?Q?RDHoV0FGGWS1AYsQ0IF7P1L0wRcczvdeQ7fDIMqrr9Xs3OZ1mqRYwKvNLtPp?=
 =?us-ascii?Q?yuteMtnBar9SQLe3X7JLLBZCVEfGkqMDUSVnw/MXh2eYOa9M6aEKi8uITWrp?=
 =?us-ascii?Q?zUn1ttNvBnQnngfjBZY09eNiu0YcWIFahzXITrm0VX53/MVO9n++Ax0tkBYp?=
 =?us-ascii?Q?Ie+995Q6ymQrZVGn0iCIxp3sSDyEuWoUAed65zEeyeLaDz0q2zRvg+EbAFvU?=
 =?us-ascii?Q?sUAW9ldevxlKlM7m80sOMHqbXkxBIF2pHNoEemCmbbbP/KdQze0yO8XdCkVN?=
 =?us-ascii?Q?9UVGQ9u4VZnIbEeGpPVoFigYPkM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf94e83a-689a-41cd-5e2d-08da6958cea5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2022 07:32:17.0860
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F6U6aZ8n2jp8rbpWtHd4Abuc9EwXriT3Mn7QPNwMF0nKM7Y6FzoSmLROAfbvs6FqmIc3JPm8uIrmT6k3x+BIzvmlI7jsDkanN61Ndxe2vYE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4712
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
