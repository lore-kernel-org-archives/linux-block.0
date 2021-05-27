Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50AF7C47089
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 02:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 236E4610C7
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 02:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232996AbhE0Ccc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 May 2021 22:32:32 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:33606 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbhE0Ccc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 May 2021 22:32:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1622082660; x=1653618660;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=YYlQqo6ZO73msWyV7VAElydX2DoK4OkyX1Tt03eXsdY=;
  b=dSExXcUxw/5rMSuP/Rmax0qpgl7sulzWkyIpYTV/fzol0oiUI9TYFC8b
   wn39GbpHvk+OLEf5/ve3j687G+mECCFhYyF+4LcWNuyY0zbLgn8ut8uKY
   ff0GWvAlsj407k0sT+X8kaiB2GxxaqKt5T75eVppXnMHfRIlXlOlXlQ69
   6CKkAGdTD3nhrjHyd8Y4jzSQ0JCRojcZTzfcemQsKEdPkHAyIoifYzM6B
   R4dX/G49TMMelK7E2r/0NwQ+pYKT+SR5hLxhgdBK16UKt/2JFcozzeWaY
   zw+RUI15enpFYMZ+aBr1WQCjDYDIUYTS1rr1cH+ZOtTmLI+ayl8O2KojV
   Q==;
IronPort-SDR: xBEAjMOB9OARrcsnaYB06PSuip8AGoN1NmmJEQWdwNcri/gycNtNoW6uuRRgO1vQ17NC1Rs1Q8
 HStFLfJ1p5rI0VZXT4XSwQ9zJSx2VNwixWuqF7pSIrMbLLG9DZ5rJXYT+7APQL4TC6MurNd8ip
 iTsPOWwCWv9kK38T8I3RPCMI42ZJFdNWo96BW2NEjcAjx/KSKUtO7N80mlGGW7ZsusIFfp7E24
 pTCasClGsDLGFEkGZ7alRvKqM8SDPCwBtLF5PlLARBMnPgAyljEMUIfRDdylIT5/Alo4hyoYM8
 csg=
X-IronPort-AV: E=Sophos;i="5.82,333,1613404800"; 
   d="scan'208";a="280897111"
Received: from mail-dm3nam07lp2048.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.48])
  by ob1.hgst.iphmx.com with ESMTP; 27 May 2021 10:30:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k7ibWpqxXoHsM6gxw2qF68hmbd68IfEM29fgMgGJ75X/oSHvLw6hHLW9Z8+hY+O/srIbaVLPHGIK8qp7VvC42h/8VpZbOnJ4ysxgmj3NokS5ckUlnYT+adhyl4mpmFLWGyLvj23xUu5LdKrif9LL/M8Y5it5s0ZJ1ZHWyXabtA5hTc+N2Zet0NLGTq6DTYuphRXGfVe56h8lGlxyAnlo5FQyWikNhkWPMAw+Jk/lxllcKLgdYT1YrqXqM2Tgho99tkmTVK5T1HghSMSbETp/SU/EGYpLgBVc1essPUjM+LirAVH62OQqARLIWyA1HBykCMBBtkwdoaVrQ97UJLhVKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R0jmrwx3214uNE8JKAPcDOUt42bfzHTMrNJwqxQjHho=;
 b=fQO/JPC8fhU+cZa7R9SHcmZOlNYaIwfuUoTPqNbc0qFdedQvuCeuNNutH3VpuNpXbb4r2fCM+C0JrZDpRkOfuHxs6j3BJUtZJeuj0DFkZYlpHmUbgXICZBP51PivcpVsWdkcvWdHaqk8mXSX/5BP1yKneJAgZVJWhQHzumgvsd4SdAGc6Zx1LgGDmo/DsvRmfx2EnWG2Tr0Tj7t+DZxt9C0Xvf4I+xMjyViq4F2AYAVhlMobjWjayZsdP3+zFq3NEmPngJpNpyx0YHeEBcJtQFl+KdjlyxNzy6WS7KWeF1x5UUB4hjtD7IpPXw8xc2VL1SBWoaNYr4gTJH+REPu3ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R0jmrwx3214uNE8JKAPcDOUt42bfzHTMrNJwqxQjHho=;
 b=ReMxsy1vo7ToU/QfyzVmDkRbhGL01wrc18gsVbnWB/va7/F3tWMMjUCGVyKA4ulz9ADHGH8ON3fqsU04N/eq+nC+JHMZJLBSeARyEB7HNZn0nF8J9NOkxCgSqv+cpPK9yV11qpO9nT0jRz7FttFq2ILRjoqK+0M0BDGbkSaArrU=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB3781.namprd04.prod.outlook.com (2603:10b6:a02:ab::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27; Thu, 27 May
 2021 02:30:58 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4150.027; Thu, 27 May 2021
 02:30:58 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adam Manzanares <Adam.Manzanares@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 6/9] block/mq-deadline: Reduce the read expiry time for
 non-rotational media
Thread-Topic: [PATCH 6/9] block/mq-deadline: Reduce the read expiry time for
 non-rotational media
Thread-Index: AQHXUpP1fV6vkjik6k20DfGUmcU73Q==
Date:   Thu, 27 May 2021 02:30:58 +0000
Message-ID: <BYAPR04MB4965E919B8768C955EE99F8F86239@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210527010134.32448-1-bvanassche@acm.org>
 <20210527010134.32448-7-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0520ce72-7dd4-468a-bafb-08d920b77638
x-ms-traffictypediagnostic: BYAPR04MB3781:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB3781E81421517E382B375FB086239@BYAPR04MB3781.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zuiqpKH/OyQPkBTHWr67gkfeVElKgGbUBWXZXzX8NoWh0/EOXJSSFIMfErvfzNEyiiJypEdEYxXLzrgig43n/P300fdKs+bRt9q2bMthbee199Qc8yO79RhmIh/N6saBNL4kNks3TPXlm44DesNpYVfaE5c0VDhldkxQO6MbqK64EfIeo/eppePU2hj7MZi37eCxIq378wrqeUSG/UGyjtWQeHNDopUyPiP/RKQyKaHRSQB/c5zP04VJ/bwYxOgspTWaJhBI/jgoyQ4C8JwhAKVukxJl9yAuhsbYRO7RTNbWVuYk6LeYcGzooLFDkhVeLlszwZXQmcrikg19mVD7l0srFDsP+tKz2Kdc5SmjXdsWQex/B6QwqVFzXSE0pPXeT8dgNb6FC15ht4DqFVki0dqcp8L89ECPiQYl9A6fIThMzBrWqvOHW2UeJHBGnoIxVP9Wq6a1eM0Uwf09+K5cLxzuK6yCv75ateI+C5csQIX8lrtwYfTqI/lFTQd+u9yLgL9K6NT6pIou9fQEyksEhrE57tjNTCr8FC3RGu92SA/Y7RppqNkJyEPsQPAa5aY3p+RaPq/K1oJT65owAGEDAoCrOwucUEqum4dxMNnbxc8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(376002)(346002)(396003)(136003)(66446008)(64756008)(83380400001)(66556008)(55016002)(9686003)(66476007)(38100700002)(66946007)(76116006)(91956017)(52536014)(33656002)(8936002)(6506007)(478600001)(26005)(8676002)(186003)(558084003)(7696005)(53546011)(86362001)(71200400001)(2906002)(54906003)(316002)(122000001)(5660300002)(110136005)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?H+br7SQ+Cq4JZu/4eDCgwZB661pX/LEn14E9H/044JlPlSFlECpXJe4R5XCN?=
 =?us-ascii?Q?xJgEfYzO/ZSfbJ37rMzxnxf8zMQR5J+qd2Il/RSmi7C6WTCMhW1tavA5l2dz?=
 =?us-ascii?Q?CqtLfNJw9a9492yH0AQ6Lqm4iPPZ9JmZnstHGuPLd71DKwUolCWpGjUvR4Dw?=
 =?us-ascii?Q?VazgnY0QRjkDKwtO9W5buNCyhGIctGjg7KLLngm1ya2CuQkgCArPCdri97jx?=
 =?us-ascii?Q?FmBK0c43kiVMwZxqWecDSr1I71jqJrbVnlgtqyQaVplU/Opi51AVdeYMIkZa?=
 =?us-ascii?Q?bqdK6vIbzKtenmahEr8gCUbBjgvySChuJyEZePvZgrhpLoHa4hr/py7KQVHK?=
 =?us-ascii?Q?cV4/ewUasmx0X0pB64mwx3TBR5wJ48b/+bq3YrGWbm7y67L83/t6To2uvCP4?=
 =?us-ascii?Q?KomBnbjv34zX34J/3wsO1nJF3tmus9G2zTyIoiKq7Nd5qc6VVOYHw9Hc/OxT?=
 =?us-ascii?Q?nI8Bss6fTrWEDhnBwhDXqyrmJuIDrIFtEMZ9wUOnQkhE2YqJA5emtjN7B/Tl?=
 =?us-ascii?Q?f+Sz6zLe4OQ2e981DGs4WT6WgXw/ogtkghI980ldi4SoD6c91HlADNCKZ9MI?=
 =?us-ascii?Q?2Ew4tauTZfiEzpk0mHT5oz3VRzi8aPO1qypanuBlQvaYPVm2hcGkSILyPGRb?=
 =?us-ascii?Q?1jzwhbRsrpQGFIpOMglwxLAfxVbIFoag2YU0nEMRes9rcHhSr5mXxvA1ERYD?=
 =?us-ascii?Q?RV04UuY5EByM8FHfJEIH9oncIJAf7y7CqyyMFYj+tVIGBtATj4xDEuiuC9A0?=
 =?us-ascii?Q?vuWSWXT1ylhRmUfo60U/5xaGXXiU9x+RyjD+QeAzZ06TeOxyYyj7uWkz3lte?=
 =?us-ascii?Q?yiov3dxmkY3ECKt4NE3AfJLkzCGUjwzNx93i4ar7rPGKhRavPIuZm0o5VBdS?=
 =?us-ascii?Q?OWC2mDSpdbruTA1uqEtvcdHnqjEwGmBUM0QHnEj5rklKuelL4lj+ZwxieFY2?=
 =?us-ascii?Q?bTnBgyA+GyOKkexKV4yqfo3zHn1RYh/b7mh5FsrE9bzSegQ5z12x2o46PhuW?=
 =?us-ascii?Q?FJ62lEuXwiCgRZQ0kggZhMnNkXiYrKUaTWuFru18AsTGOLKYr5+vM7vE4itW?=
 =?us-ascii?Q?7Lq62c0Ylm3wDk9fm/WuEcba6LUMPXFgb+N+EdhovYr7F4J6jb6RuH2wAJ2B?=
 =?us-ascii?Q?bJYINF3mA906R5j1Y5VoOdUeagS1pIU2SmBKJ0R35Xcd2gTb17uxu25yRdv3?=
 =?us-ascii?Q?zunkoGOVsE7DmqdoSUkWHuZUKfBRzf9+lbFiB3yl3qS6hGlFwoRMUhwenDMb?=
 =?us-ascii?Q?7KgHFIcl0gxVrVZKPvID8fxD8fR8ibpcxl/ng8z3UHS4B5i3pS9zAoiK+DK/?=
 =?us-ascii?Q?NBdpxERn26nre1qJfkdbe93b?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0520ce72-7dd4-468a-bafb-08d920b77638
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2021 02:30:58.2330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HekEukm3n9BgNDRiU3piq81kgV2HTtVj10LhHj/1Q0KBe7ai5N6TsTPB6crKQMdi2C+srByILfOD6KE0vuQZBpaa9TbIatk7Fkv6IgMdRec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3781
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/26/21 18:02, Bart Van Assche wrote:=0A=
> -	dd->fifo_expire[DD_READ] =3D read_expire;=0A=
> +	dd->fifo_expire[DD_READ] =3D blk_queue_nonrot(q) ? read_expire_nonrot :=
=0A=
> +		read_expire_rot;=0A=
=0A=
I've got comments about not using  ?:.=0A=
=0A=
Apart from that looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
=0A=
