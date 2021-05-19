Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 733F4C433ED
	for <linux-block@archiver.kernel.org>; Wed, 19 May 2021 07:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D3B561353
	for <linux-block@archiver.kernel.org>; Wed, 19 May 2021 07:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240099AbhESHia (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 May 2021 03:38:30 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:47878 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbhESHia (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 May 2021 03:38:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621409844; x=1652945844;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=i73cQScyOXtQNhKCgBM0j0yco6YrKjuowVHgFUDbKic=;
  b=h8yb33VBMsaQKjITlXqF/gw2eDw0cLPGmcA2FgIbfpzMLfS85IHh204f
   c1hg/BU0p/S8NgPNk11uagzpBhspafdJ3qXj/1cO+Wivt38Ql0nL70yzj
   TYRmkRjwcFNh8vFzn1yKoNH/pD5kMO6p8CGx+g0Wq766s6kks1Yu9jpye
   S9HmkHdOLGMPpLikylZ8lpZhO6q1mbuVL0hfnxltd7jEdjqDm184ct2ea
   7qf5mnz1+bodCoDmenVGmDJIRYZbCaSk1yJrUgajNi5sZo6NHaGWFFzAo
   XVzxGObae5WCturY4X5a2bQVmwNmlz8tk11EI6ugCfS+VwWgCsmEweYF5
   A==;
IronPort-SDR: gwUu7oYxS2oA0o5VD+pBu28qFy1Q/2V+B7Ni+XqoXtgrRpe+NR333GDEDxNAJWbpvNLleaBOGM
 Qw3HXAD1Asmf5fiwXgPu0qQW8Qe3PTIkQKO75mEbDmyoDeyJFlB/cFOwseriKjET3JBK+A+s9w
 TZgwr8Rua9FMZwj7dVKPV6ljrKNsuZhS8kKUxW1srfXVVLF75m6hTr5leoJlZW4WT/D+JNg6yF
 Fg397lGekqYxPkqxuSPlPSDpkK9xUfx8da5T5C5kSlewgHSc+IEAZgYzxzKywPznWAQUHP/YqL
 xhA=
X-IronPort-AV: E=Sophos;i="5.82,312,1613404800"; 
   d="scan'208";a="272618306"
Received: from mail-dm6nam12lp2170.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.170])
  by ob1.hgst.iphmx.com with ESMTP; 19 May 2021 15:37:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XjH/oUgQD32Z7PdvwAS6T8ipi1leZuCQruNzTfBELUnIwTmDBQ1o4qOTk3VekdkcVerQp+nxQTJXxKFxcU2HFPuqXRjPtY7J/k8CjvGRY9SqaoxeQFGQntmLjtDZWvFzq691j0ksenw9g7kKBup5aVNQhNNUunGtQWNyEbae/dW4+stBhXQTtFn1tFjC/rUuroNHunAj/e7zPclJohT41FKEFD1hmg+ldhgxvhZL8S4pZcz9/aUMzgR6KpeBnUdu46xcFgWwhdGnq4F6Gxz1eaaXl8A93fHub9A/Seub8sjyIHZyu1lB0dhScR/U9MR9H8sW+5LtOTaqW3a+UFJLhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i73cQScyOXtQNhKCgBM0j0yco6YrKjuowVHgFUDbKic=;
 b=d4XU1khMS7typWlO2tQcLcsXUeY9pLSNmM335B2atw04DsITOO4we5DNwtTpXqdGMxZYQUSc0eTtFDTUDp81lC3ZYU2jBYYMCLacbJL28QHj5ZGeUOjjw8xb3BekbkJ2OtRB/e66e7bwaJZ5hK6YSikav7FfZhCcRK0kvqAHeuOsnVT4vRY94M+RdP3AxWFgQLrbdoxenabxusomQD1vbfscJxnhP4znAQc35YE/1U1WIREJj1YiCjJXFM/GvUkGG2TKfa4qYZRKQOJ7V2UopM1j6v7ZbMnEaX2YZaOylDBMlA/Td9i96KtkHUsroPpGpuu5mrVH5bG3pExiFdZASg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i73cQScyOXtQNhKCgBM0j0yco6YrKjuowVHgFUDbKic=;
 b=xGa8+HsrTJFHBep3L6tda6qgz+iM8tKQn38GkcGDRtNf6S3wPQLLhqf2otxPLPYb8oTbxpkPVmomftkm9mt64FGIQ4f76IaCTR2ewe1DfbNyFOOA9RJAW93mh4QRvpZK8Eo2VSRt2WUa+MfTdzMswgmdnEfj6XqfFMEApIVUg5g=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7608.namprd04.prod.outlook.com (2603:10b6:510:53::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.27; Wed, 19 May
 2021 07:37:06 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4129.033; Wed, 19 May 2021
 07:37:06 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 04/11] dm: Fix dm_accept_partial_bio()
Thread-Topic: [PATCH 04/11] dm: Fix dm_accept_partial_bio()
Thread-Index: AQHXTFqBI7R+p1e8XEaDRzyOjNXBNQ==
Date:   Wed, 19 May 2021 07:37:06 +0000
Message-ID: <PH0PR04MB74168B8BB05002AC0445C6FA9B2B9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210519025529.707897-1-damien.lemoal@wdc.com>
 <20210519025529.707897-5-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:152f:cc01:95b:718f:422f:1ec2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 069d437c-8c73-4383-f7a1-08d91a98e70e
x-ms-traffictypediagnostic: PH0PR04MB7608:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB760814F4380C6B8338E88B159B2B9@PH0PR04MB7608.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ixCQxuYM6glNg0Imem0DTUUtQlYH0a6++meLdwimMjBd7dAQAWSPEA9ZKbJ26dm31XMPSy/wbzP0DA18vFk+l69cYDwsgE/MdPJdI1xTw8kv2kWM9H5ACacPGl21ZdlFGim5tCF8xzw9COleIyLBZ1j8yJ7udyArU6j2xKqsXD+BRWsr5q/HP4z4jzd1iT0FaMNUtMh6pQzEhQDaofE8IOpzKwpnAIBHJqyC9qgnIm+OPtt2ttNLu9Y8RRM39O11Q/lhBgHLQDkvTxdjN8Cq47UBcQD47TZHoMjyslWCirJOm84mTgUJo+7wR2QLXIXjDPHYg3K2oBoZqbFTTdHK9e054Oiqwcd9/lM1o7/htL2aiqhIsooMU4z6rp0hDvpmYsSC6DTfBgDp5vqANPPKbyxEQJZgsWnygImQnev+sZAqBO0Ppey9pWvKpy4JdlJYfYRPbpi8qtIh0i9VSlhZLS52jY2V1r0cF4LkFBOm8z/xCrH0oqNtkMjH9J/tPEpEX1Qrpun1r+aV0rkOvNzd5QhzaVVzD8Ce+BumfxU4DFnD6Q2FSnjTUdUm/ztv23dK8dMem0qUWU3gaUw0pbL8zHmXwCcEMjwphViy2N7m2dY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(136003)(346002)(39850400004)(376002)(66946007)(52536014)(66476007)(5660300002)(19618925003)(316002)(55016002)(76116006)(91956017)(64756008)(66556008)(66446008)(7696005)(186003)(86362001)(9686003)(558084003)(122000001)(38100700002)(33656002)(6506007)(8936002)(478600001)(110136005)(71200400001)(8676002)(2906002)(4270600006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?fRBuW7YwdJ9KITnICCK43LAby6jbSIwhZdrck4KSRUv3LgGy+6xpnMYORNfr?=
 =?us-ascii?Q?nIWng6RFifObWjEiWLzALgVVsN9/gcYMbV3wAkCeui56SHtNs0zHx2uwL52v?=
 =?us-ascii?Q?nL0UQNdfSp7GSw/eZLHE21/kwxlAN7dAuZRS6jjsqXVulYGBvKdXygbWZMmv?=
 =?us-ascii?Q?3oIZxr9WPdIbJdQ277j3zBVWweAZMnbICqqMWbSu9ElfDlU9xHyGDy6ACaPC?=
 =?us-ascii?Q?us4TRtMSs6FasJI9IZZ/8uIP0c/je35Sm9uOnGujkW4ggY2Pnil0W7kt6edJ?=
 =?us-ascii?Q?ZZGRLWVDzPhXNszdXlrrxc7+nBtbPHXDN6sh69thso5dn4TYl50nT60QkpmY?=
 =?us-ascii?Q?CIKUkgK+eGnqoQpewVNzkKqEaC7+xHifOcdHTL9i/2owNVy8xpeyOye+ikNs?=
 =?us-ascii?Q?WhcGPh+PH6wi28/sscErGGc0YYdX1TotWxaKDy4t5/IIWbxFEovStzGbPvT+?=
 =?us-ascii?Q?7yZaJ8qCyy5YzGBfD86FvHZAX4Xyj5sF6UF/f0RTn2Avyzi3lev0K3V2L7xi?=
 =?us-ascii?Q?iO1D6TUJ/s/Hl2bRXV18cIrTBEQY+s/4rRFp/pdcPEGmQMCCENXoxVSMSy8H?=
 =?us-ascii?Q?8Nvsvgq7MslIXb2qBM9hFknxH5r7u/n8ViyRHpfV0cpIX9f+iaUHKnLi+muF?=
 =?us-ascii?Q?p9WfeJySMhg4wDYO54WuCfw588OVP+V3j/ZxhXODqsPTE9m1HYSIMa+uU11w?=
 =?us-ascii?Q?1sKODNYkb2ioZJB6rOEm5wBe1xxv6cax/ZPflKYrGG73ZEXlKcEtGw/qwzS1?=
 =?us-ascii?Q?1wAPn2Q2HIvdzsetq/KNy7rvomuPb7d+d5R+kxmTv7+vpC/weB2G19sPyU4N?=
 =?us-ascii?Q?l5GTn06aRgk+eJ/2idnVxH4UwKUKDhGkcbtcRfdEqAwi0AEnqdmagrIM8tiP?=
 =?us-ascii?Q?tLLYEtoqtIMLXyFeekI/WL/M4ewa06ejvP8lq4ATu5ThXewgf1aBuA6y2u08?=
 =?us-ascii?Q?CJwuSPFUrZPQ6jXTRXZcgEysc6uq9nUCBzpLpgfICL+pX3ZtbqSk9XTaGBCV?=
 =?us-ascii?Q?XHhI2Y1Npbq9cUkESg1c21OlGPyUvkniqowVBzhHjwkzXt+HXm2c+Y5kgmgW?=
 =?us-ascii?Q?9hTLQ+tWhx2w3JxmuwQ423ge0Fp6i6J4J9X0VQKKydNFWtOEX7+6VMGWlyoN?=
 =?us-ascii?Q?zMe4kwBtbm8MmUhwtWO0N9l7sBqjmgs67UvnH7bFuuYfqKWYBorw4xYQkcO5?=
 =?us-ascii?Q?1Q8ned1gaYKknVGxcpgpwAV/iZj7dzOAIXqB/ry+PMOFbxrDFumdkZRAdgUY?=
 =?us-ascii?Q?IIuGGND7TFclUGdrGm+TM1xvVg5Nguvqq0Gu2qf4Fw7hA25g/gQlHJZXoamo?=
 =?us-ascii?Q?YnjgvqLIxhapjQd3HsM38u2pnXH3rZnXxKMnwhiEQ3Wd0PXad1/KnHWfTuYL?=
 =?us-ascii?Q?ceIxqQ7Eyzx9xU9N2EL3y17P64HvmeaEmptnGO2Sq3yo3ldMug=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 069d437c-8c73-4383-f7a1-08d91a98e70e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2021 07:37:06.1911
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LJmMABwpMnN3mOy9RhU0H8l00BDCZ1Hno4SBwgkaSFq+/2Fnoyiaj0jTns8rANitD9abV6HRsykDsPnN4S0ESnbsbtKDOf+3uWJ1cwi2GOU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7608
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
