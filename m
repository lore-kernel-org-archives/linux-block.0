Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4654C4708C
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 08:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 874A2613CC
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 08:49:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235788AbhE0IvK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 May 2021 04:51:10 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:30904 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235804AbhE0Iuq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 May 2021 04:50:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1622105354; x=1653641354;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Qr+xJ2rZkF+9S1nYwrNrdTE22OP86qP2Y1rKon6IaFQ=;
  b=oyUZSJVM+h0+KulmtCG9gPbhPxY9D1lEthiADak4HaXc3+5/wF68lh5c
   4X3qsNOfM4mbo9AOPm5PccD1wI5D6zX3/se0TnlhzFXGZKUKUodBuuvMC
   gp3CnkMpjNDxy9hAeD0iYpOEAbT2ew51iRY8N1FWFwaX6Rq8QPbbOU+Xi
   J8RyvNFvtBlA8b8Dy2qsbp0ePixDigYHWzAyeO/a2kYJrUE5EX0/Dhb6I
   ctXqy2YJFA7XHjY6MrEuzhBYlGuKXYi1zrcckN6GKaO/t8fg4MdW85ufb
   NN37UmSJkRgU5itU0HQIfkOjd1xNxCahKO+1SM7OGWhVydzZZK9BsR2dJ
   A==;
IronPort-SDR: uAD+p3HyX6DtT5DQBwCPymG0V7V2Xv5YJlAmteiz5A50d1/zEVC1j02A3r80tT4yNTJ+2P892k
 MB6fX0syAVLyx83eGnGE+HDy9dle3W+rrBcoRh2gFIEEUrcO4IyPEUCAkYQHjGEaNCQAaBiJOA
 fiJ7k9yc72sS1vE/fw/9Q+tAgHPg86vHgdI2X3cd7C8qsAWD42pirLiQSOZU2gllAaY+9Qe0lR
 1sPxNxxX1QGnkmhLj3Scui2i/HB6GcZ+qT1vvLbJJc3jRFGM9qWzTlzxSJXEsR3QtSncQBYCZx
 lt4=
X-IronPort-AV: E=Sophos;i="5.82,334,1613404800"; 
   d="scan'208";a="280943086"
Received: from mail-dm6nam11lp2175.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.175])
  by ob1.hgst.iphmx.com with ESMTP; 27 May 2021 16:49:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BpRZIZHMAf7o0rs+/ZvN4WK5/2+rtA00SRVds08B/QCfPr/UOF/VTuTV8e/iLJrOqsrmhaY0PbVhgKoKyQuU11ml1XI/TcL/SrT/Etwjoe8j7UunUzxeWuhnxC0Kug6gz9GTQfoEgYNC7GB1aYpOUJ4N9MSJ6avE1c66+yWkmLX0Kl7yP7Y7EAzl0Px9RJynjYWYNt2OIy2wPdWX6Yhbn5sGL+b842bueJcpO7MVmYXEFOXqp60aZ3W72s63+zkVw9JrNd4wsDEwZ1tdOQo2VhCVR8SOHJEYwt2y/qapgHUj5IixuiFCUNVgphK5uDxZeTtNQoZhjR2FrFHwPeLqHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/fXtH2JukdUIX9Vhaeo+AkBh8XTEQNbWmxbWbBIONiM=;
 b=HSXEMpebKEf5xGjIAu6J9aJSuf0AUse/umby50rFe/WQ16LXahyIW1rcbslG5n6BJotiNf9weZ7nBubQ4oBkZoC2yAxuPvyUaDh9j+8DF32D52j6GyDRaIp67JEjlBtlZCCQ5pZ/n7izu0vYioc1nTrRGtEw5SVYB9W47NXon0IhRlsRJ/DxHyDYzRs/UvF0ZwIOQuBIHFXKqdWHM63d4CiNgVRMhQAVOwg5wvHLiEjpZzNnNKe9ZuUDMfPge+TGYgYLmITdTi1Ku3/Jdr4wJPcjP6iIyuGV5hU1lmoaefdmk7m4A51kXNkG3qGFFYu9SCRCGqwkp5n46v2NSqPuWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/fXtH2JukdUIX9Vhaeo+AkBh8XTEQNbWmxbWbBIONiM=;
 b=E4C942qNtyvn0ghi6axTeXJ9KuB7fur0gZIRzAcsj1wxftM3mrm4oWv9nSd6CPSy28dYzyL0AfhwbdDjMdM5jZftY09R0yoSBNlRpPLhd1eMDpVmtFCWKhpFlX8Qn157QADpHawdmHMO/Y5iOfZT7mxS4xM/aiMJsk4uY5mh2ok=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7191.namprd04.prod.outlook.com (2603:10b6:510:1c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Thu, 27 May
 2021 08:49:08 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4150.027; Thu, 27 May 2021
 08:49:08 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adam Manzanares <Adam.Manzanares@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 5/9] block/mq-deadline: Improve compile-time argument
 checking
Thread-Topic: [PATCH 5/9] block/mq-deadline: Improve compile-time argument
 checking
Thread-Index: AQHXUpPnLP2GbFJdRkyUvTFCc3fDbA==
Date:   Thu, 27 May 2021 08:49:08 +0000
Message-ID: <PH0PR04MB74160E7CAEA613AFD7334BEF9B239@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210527010134.32448-1-bvanassche@acm.org>
 <20210527010134.32448-6-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 703498b1-44bf-4f2c-5130-08d920ec4a8e
x-ms-traffictypediagnostic: PH0PR04MB7191:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB7191FA468276B8D8C328B02D9B239@PH0PR04MB7191.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mNNwkxy6vWPS/MlN3rzg9UpIB61J19Hre4mUZzR4hg+4E9PW3TD2hcxHViInwkwIovZFP79636MVcKkU9nLk+IyCWqtJ7tC3+Pew0t42AFAsIU96vabjUKingeRXOleE/gyQEV9EYaZvoAQ6LrhFqPpMsQGXY0GUooJFrEcb9MzW538yjVsqnXAXVQmQiNmMg05YtCn95efNhGSsd1on+FEgMgIvmO2KmwksTJi8jGWULxawlvoYwQbAH5amFyvaGINzFID+HPKjwOwbftM++y9nEOTIan6+pJBgkHau712VmAvAn1fFXoxjx5rBqRvWRL/9bUfiMhif9pLeU4Tm4Tov5t7qGGowmFMYmk2uFCviU0RRvR5DjfeB1p9R5EwuEwSDgEWRj4MiR5zixD/gg73uERQIshRM1Zg3shdEJ7Voo8075Zqc0hO9R5Wz1sUWSvb4DGtNT//fijE0Etqwjpe0oeNzyzIqJCw/erg6aIZDU0NaOatBOXXmeZBYNNUogXXraIZGtuJscDFm9Qv7gMulgXBDHBIgA0I5yuT7OKGCzBfzKMi9ZDAiBnYEUanTiXSvQr2W9YkylAaqpCZMpGZo/ndSQyscjm5Y6TkvKWQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(39860400002)(366004)(136003)(478600001)(53546011)(558084003)(186003)(6506007)(33656002)(316002)(26005)(4326008)(110136005)(9686003)(2906002)(122000001)(8676002)(54906003)(38100700002)(52536014)(8936002)(55016002)(66446008)(66556008)(64756008)(76116006)(66476007)(66946007)(71200400001)(86362001)(7696005)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?x39nT8wxgTmcM4ecd/czD0Ix3FLtkrTa3qMMYwR27lUnE6tNVWJCK2ne5j85?=
 =?us-ascii?Q?imIHJwlAdBD545XtFAIbNKVojKgW6HO4PzQRYkai2fAQQnT0SzL3reUrzfFk?=
 =?us-ascii?Q?OuJqPMdaHvxrxGQG46sCWhfPdQgt2zgc1X7ZeYcb+jnibdCSaWxqHq02+BPL?=
 =?us-ascii?Q?ppiirx5ezYciGiVHuRWLoyA3nr2NpFCBu6zhRA7nsaNxEfRL5yhqbf79Sr6S?=
 =?us-ascii?Q?KCtOlwf8Vbg+noX3vopsehCFe/D4daUtGvTfF80y5GjcRKRmBMx2ArNeUeEE?=
 =?us-ascii?Q?cpJnumf+fGYUlvA27UYLz52K2QTBDc0wZhfgov5vzvWY5dzqFa2EkRMR4IVw?=
 =?us-ascii?Q?h7B/WhVoV0SBk2ro/Qpr/y4+i3eboh2/gl8bYZayBaGLhOV5cHjfpjOpsX0E?=
 =?us-ascii?Q?H92BhRi2A6Sl3A2OTJ3KEGjqwKL/jxw2TW904jJsLJn5tJL1szVLxQW3OhEA?=
 =?us-ascii?Q?IEPi1ojQekAJaC6LRJ+xDuL0KbAiIpokP7fl8D7EgRJPV9KioAtiNrZ/7U3k?=
 =?us-ascii?Q?mubK0pA0AqzSEJen2KnZN+CKHWGql2Y+Enytoj8WnjtMlaeYyOQV6XhrLS1u?=
 =?us-ascii?Q?XYqjPeSvlfQQ8vaoVYMthsckM1PauaoajDHcr9W7LSLEqVHUKggmegRATffj?=
 =?us-ascii?Q?02v2/GOUTyAD0SK+yAy8NmryqRBpGhoGQv+jTveONXINoL9PIZCWNSsXeKmW?=
 =?us-ascii?Q?truvlcvuGrpx99pCDEFhlqTZ2EFhqjZY5AmnHgQJsvcRjGK0ONpFwnQ0q4PZ?=
 =?us-ascii?Q?MAdQiI8xTVoU9ZrpKnUYeRfdpnXNL9+fpX0zrFA+bj0fECchojrbLPb/doZ+?=
 =?us-ascii?Q?pTxZCzo7fTHgfbvtAKHbnlQeWw2t//k5uwQ995O9L9eNcbYTZlGJ4y+TPtdZ?=
 =?us-ascii?Q?Qw5VCJM5sr05rYc5bHezlawXo1S4IVpq5s7qmfmYh0aAPBRFj0vZm20ZuMWE?=
 =?us-ascii?Q?iNZjk7gjvhyoLWmyuB5QTozbYh2jgXXRN87BBFlqOb3RWN28pK12FLquJar9?=
 =?us-ascii?Q?NQ1HKPUBzQ0kM11VdwmbfthYK9g9ZLwaLB4BA2hq0eYW08oqJcTNcdOKC8Pl?=
 =?us-ascii?Q?mu9WVGxBZqeZZlHimfBAFwS1LZPFOUOpfut5Ektq8czETHwK97L0sIB7VJEs?=
 =?us-ascii?Q?oQbTAALJSU9hjxRwtF93MMnRcBCTV4Ca0BX0BZwY1Td8gOICd6AHTT2FWvco?=
 =?us-ascii?Q?4hQkftsiNd+7BypZOU7DuXmLVQgG2l8CZGnQggV87J1wjsOt4k7WKn6/WraH?=
 =?us-ascii?Q?v9gy6DMrQWTFHyES6kMCo6ks5+Q55oT4KJPo2nJ8lw0OJXJFC4X+sXDfwAIf?=
 =?us-ascii?Q?BsCJzDjqyOKDOFpgswF9yTTpXPWtJ9ker73iLiybmKa/Zw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 703498b1-44bf-4f2c-5130-08d920ec4a8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2021 08:49:08.3324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PjSEfPAy7C0cmH1PIihPOREmK3QOou0d12YLSyyqAWDzymYGmyaCNZ75o33EoaC63Bm+1p4UVYNfAz6fbnycBGBh+E72HknIfGEmDgE8eg0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7191
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 27/05/2021 03:02, Bart Van Assche wrote:=0A=
> +enum dd_data_dir {=0A=
> +	DD_READ		=3D READ,=0A=
> +	DD_WRITE	=3D WRITE,=0A=
> +} __packed;=0A=
=0A=
=0A=
I don't think packing the enum is of any value here.=0A=
=0A=
Otherwise=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
