Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A24C433E9
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 09:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF0EA64F63
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 09:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbhBBJKk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Feb 2021 04:10:40 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:36189 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbhBBJHn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Feb 2021 04:07:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612256861; x=1643792861;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=0/oL9w5y948NrI5bOM17U2h7KGkeYoXqhTnJfDbnpdM=;
  b=CULOOm+2FfA6mRN5LUN1lbJf7sLYJ2pXAgGhkuxFqIIXbMkxRs6dfS9y
   9ncNwq0FX+jR5ohBPo3pLN2n0bvb0YcWBVIb0qUrSbxvFGlciyqi9vDjl
   xadWnmz0yISu39YBJOFmepfHtli77PnOCGU3ZjBL/HzbOV7d31vq5J4hY
   1NGT/xJg92MHDHLNgfwApPJGT+x16RXN2IYxx6hbFWXFtp4z9mXJwYwys
   1umq10eihp5m2px3G7X7inQufUPcnpOTM7aeRxJMAoXc7DbgiZlmXr4db
   rD9zWE+WSg1e+xRueGfd/pS8vACMOtVeJOwuqH6+/SVn5l0VRBExmQgYT
   g==;
IronPort-SDR: r97kAgd3G3AjxewNCQY/bvMIMdDNCpD+dLoZTNhonK1Rk73jv66dF63Zm9tPHXnw7BpAPsWQL0
 /6zwrXu7/ru1K+eY6RsG77i+ALwBxu+LEc2gIIEMPcIfCABJcaFeW7fbCRCIitGo1AdO8/91zy
 pgiORgz8Aw9sw0UwbjuRH5H1eMcHDAadW2OfbLR0aooq5+JWLqyR7qwZN5EnWyn/aUlPbTuCiD
 uYUU+/gK5mft8do6JZAkhw5Fcjbz6X46Y8se/H2Wu8+BZHQc5qdx34QV24UbONO+/ofqz0lMcX
 Kms=
X-IronPort-AV: E=Sophos;i="5.79,394,1602518400"; 
   d="scan'208";a="163350834"
Received: from mail-dm6nam12lp2175.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.175])
  by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2021 17:05:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E2WLkyJKEMXfJANtrGTGMCzLy06xdzL8v+DjTtgiuA+Br0hgH6xn7gHEHqKAytlzdjHHYayBkOftH9eMFHGR8VVksIhE2W8DMzbsmpqOZA8H6ccZs8e4ZCFXdCbrghEzaWpHlK+viTf/LlsPa5spRLju+ZFeDGLU/L6FKD3H0eTmCa7gnDlb/AAendOyCkCUfirpofCLkuXF5M2f35+JeOlKw73wcmP2gg4DVKs7DyCWp+qtitJetcNMF3q58da/g2wNNF5BT7kSzyGMEBVLPyTIRNxNg2AEAbD31zML192v9sDSfM9n/vKkv3INwPq+the0oY4rYTfSwjfFUhEBlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=30nqTUXBFnKl0cIWZ0TL/krVX1A1cskcWuf5fi96OPM=;
 b=A9CarFOC4eh7+JsOI0zYeCEJXYrxSM9RNvF/cuYJqBWmf8ZzkI+z/cxPkMlVNHj20f/bUC9HWPFm4SsbxBd0JUQfomzoPIayFr5zy2uSQm8d3AD7YGc4rS380IoxGmrNQraPJa/8JLyT1qJv/uA7P103nIcyy7fG/6uLWpgA8VnigP0+qQSw9nXR7bO+JCSDRj7BmUCA+43ziojVO9Ftap/rtKPVTxhmDiGSZNzCXVm5UIUg4/rKQ9ifeXyIMSnqLp/Rl4sOW6DBJIc+M5EJMiSxEwhTXdkZxyYQtpTleoug8tDqSIbFXpnDI7db6p0UBop7X18YzK8BIoo6OeCr3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=30nqTUXBFnKl0cIWZ0TL/krVX1A1cskcWuf5fi96OPM=;
 b=jD0wBayP1tAtsXugV6PvWwbDU5qXCTdlUU4kOaJchnYDkypAb7h9qhVUJh/SUDv4O0/CjwH31IeFx5JVDrv7pudxr59mIPhTCSn+FD7V1ql1xoNRjICjz6JD/HOlRiMr7hPeoDRMPNRWlmW5vZSH53pjOpGPUDWfqA3RgwXkPZo=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB4641.namprd04.prod.outlook.com (2603:10b6:208:26::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Tue, 2 Feb
 2021 09:05:20 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d%8]) with mapi id 15.20.3805.024; Tue, 2 Feb 2021
 09:05:20 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "paolo.valente@linaro.org" <paolo.valente@linaro.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "dongli.zhang@oracle.com" <dongli.zhang@oracle.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        "joshi.k@samsung.com" <joshi.k@samsung.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        "hare@suse.de" <hare@suse.de>, "colyli@suse.de" <colyli@suse.de>,
        "tj@kernel.org" <tj@kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "jack@suse.cz" <jack@suse.cz>, "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH 4/7] blktrace: fix blk_rq_merge documentation
Thread-Topic: [PATCH 4/7] blktrace: fix blk_rq_merge documentation
Thread-Index: AQHW+SP3GlLojmsYK0Wmu+6f0rdLvg==
Date:   Tue, 2 Feb 2021 09:05:20 +0000
Message-ID: <BL0PR04MB65140D197BC902DB365AB6E3E7B59@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210202052544.4108-1-chaitanya.kulkarni@wdc.com>
 <20210202052544.4108-5-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:38be:e4f3:6636:91ce]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b9cfcdd5-357d-4791-85fe-08d8c759aafa
x-ms-traffictypediagnostic: BL0PR04MB4641:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR04MB4641801CBE81BF5B8FD20A19E7B59@BL0PR04MB4641.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:419;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m6LcYr6C7WYnhrMpLpPK4Ozc9Mcqli+qni/GCaiuDxL4a/ybK3Jm0JPEGPbleDhgIumoOkHsXYPqB9r69ieQ4VX/TJjOBLc9LxuWp5sbV484eRp0URkwRMc4/RjL2EREImOUTyo8qo6LJtGLrHSYmJSNoMOixq5vER9935S+OY+4zQUZMFOfjaHMwDPaqvP05En0lKrN2nOQ2w7FZG6dhsMokn/AvAAFoDMbPwiJ1cWsPAIBWk/01OcmjBCi2d6vilp8rJRhs7NJFsSkpTJFu8PMbXiVCOjmvl43st4bAZbDK7YNGPTZQI+YahJQxOOq6I19FtjNCFirDsyvUutIcpARo++OOWhjtPl9u0H04TKRn4ebazvoRdLwq4+KjDzylOmr4SE9NXFugNE2Jr8DhTsU6a/L6o4EgMv1Yf43MfIA0yKPnmUj7yezGqLX2GcjAwKb3zeCGSY3vKEBfJtty98yplkdSKB2JD4IdIIlA/2qnrghvekYCoK/JN42z23CeXIXlR8JwKzHjZ2VwdgbMA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(376002)(396003)(39860400002)(346002)(316002)(8936002)(7416002)(5660300002)(54906003)(71200400001)(7696005)(33656002)(110136005)(9686003)(83380400001)(86362001)(4326008)(53546011)(2906002)(6506007)(52536014)(66946007)(66476007)(8676002)(66446008)(66556008)(91956017)(55016002)(186003)(64756008)(478600001)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?g9IqSfJBZfo3wqD+v56NLHK+qh1Lz/n5slTsN9oMJwb2BSp4z3tgiJ+YAenj?=
 =?us-ascii?Q?kMJ9ZHXlLeQrpl1h4G7Dxl2ggBJ2DSv28YohWIsGbHGhdblkbdoOs77XJQg9?=
 =?us-ascii?Q?ekLEezLFitnpBZ+DP4itkzcRO3NjRVow/Du+bI1X8XWBJ1EAh3BvaVjUI/Qr?=
 =?us-ascii?Q?cX1juc6pFD3rBvafb1HZW5C7FVtxXPytiqBMApHUaJkaJKGfwiy5929f94/j?=
 =?us-ascii?Q?4SciFVP0z5ihvchHZvOzBI5l8h4Zx2Yv5DQ7wIlL65Vc7fHjFhBSdgZUJmaq?=
 =?us-ascii?Q?EfUmCQvntl07z3pr6IOmBhEFnbKvNQJT2BP5WqhofMPohQ2tUbfgCvkcTXNN?=
 =?us-ascii?Q?rM+cnbugRHbnxchVyKR/m79KlHYitHrcL1TLuItcaJzLSGP3f2xcCfVSNm6f?=
 =?us-ascii?Q?nVpZmN12vmKpsx35KfmIIlub5mrNL5cJ0FzAFUk2akDckgD6mitI7pBWVwjK?=
 =?us-ascii?Q?kAqBwk4/Kpe/xtp+oF3+O7Fc8Zb4yfafacgdUXbqpfooV1nFBgrRI5eajvpm?=
 =?us-ascii?Q?Ds0ZNdYvT8Frn2qGFfsrqJDPNm6gU1iMprDiqEyPn+6wzB5N4kU79B1jTqR2?=
 =?us-ascii?Q?gJyDrOFzAx2HjpiBDf7DXCDeuq03nO52PQjYiSkTxQtRKW0s7IPIJ1lNaIU7?=
 =?us-ascii?Q?/7u2Sij+bi46g4H9mJ7jpcwSMOsYDmobV+QvI8Vrz6jHeXP1frHP18LIR62w?=
 =?us-ascii?Q?ZfOY2f84d0dXK1urLyp6oyVcIGJKzHjMXiNJRLUU8kaIseKq3EJ/UA6kb0xx?=
 =?us-ascii?Q?rlZQ1/4lQ0BdBC3Ds0dcYz82z4sC+aIXWLetXsIBDm2SInLKoB8IZFyPB02I?=
 =?us-ascii?Q?k6wyLChYCkesq7IokYz6IaFGo7/O945+iAM6MKhNrQ/068Gn67c+XGKW0N+o?=
 =?us-ascii?Q?l0vnYzgfsQsRtjc0tpJqaaTRaPMMCJOCj4cNGU4xzs0IglXZbQu8yKlvathM?=
 =?us-ascii?Q?gjwzbCogC0zbanm7yHtKMFLvmyVTxA7uNDyIXhMUxE2SOm7VBPqD6jA6XPRh?=
 =?us-ascii?Q?//hH67f8H+ticw0DhmJyCQOJT2Ai6dOecH+AgDbgQtnYQIwzaI3+uI2yKPhC?=
 =?us-ascii?Q?IzSyh6siVM5P40sfHTmNZ4CU6652q3Up1kjRtlE5ut5tGhek82l/7cvs4l6t?=
 =?us-ascii?Q?mLAYRucfi4BM5Ds/2YcsV9Cjdg6C4X66Dw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9cfcdd5-357d-4791-85fe-08d8c759aafa
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2021 09:05:20.6809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1KJoWHu88v0lJBg61uvQjK/yWKJQyu0Pn27Ty9NZDnsX0QkbUWqA7qhcZNkFzQBG5wSpUY1FPlV5LDv7G5CarQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4641
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/02/02 14:26, Chaitanya Kulkarni wrote:=0A=
> The commit f3bdc62fd82e ("blktrace: Provide event for request merging")=
=0A=
> added the comment for blk_rq_merge() tracepoint. Remove the duplicate=0A=
> word from the tracepoint documentation.=0A=
> =0A=
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
Fixes tag ?=0A=
=0A=
> ---=0A=
>  include/trace/events/block.h | 2 +-=0A=
>  1 file changed, 1 insertion(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/include/trace/events/block.h b/include/trace/events/block.h=
=0A=
> index 004cfe34ef37..cc5ab96a7471 100644=0A=
> --- a/include/trace/events/block.h=0A=
> +++ b/include/trace/events/block.h=0A=
> @@ -210,7 +210,7 @@ DEFINE_EVENT(block_rq, block_rq_issue,=0A=
>  =0A=
>  /**=0A=
>   * block_rq_merge - merge request with another one in the elevator=0A=
> - * @rq: block IO operation operation request=0A=
> + * @rq: block IO operation request=0A=
>   *=0A=
>   * Called when block operation request @rq from queue @q is merged to an=
other=0A=
>   * request queued in the elevator.=0A=
> =0A=
=0A=
Otherwise looks good.=0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
