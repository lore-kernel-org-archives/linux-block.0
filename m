Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C80C2B9F8
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 06:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22C4B61417
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 06:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbhEYGQ5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 May 2021 02:16:57 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:15909 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbhEYGQ4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 May 2021 02:16:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621923327; x=1653459327;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=rnekrNWxEnDm9NJUjusRCgOWXpsTfEH+Kg6QRlXEnnE=;
  b=SoO4pEIW2xjiq04OEYCg0EszoearWHvy3RvtQnm9WbzjaoWU0DY/dgBn
   5xN1gqEnVytHUh9ZhAmdbdzWRrnqd7rwNEzEby8WeVnJ43utwiuT7N3JZ
   neeJjGyyFrBP8TYVY/MqxU/JDi2NrP+BzNm0xLCfs8guMk5IIV4PHAt6M
   R91oviB3ZeHMX7V9MlirAuKyTi9zqzq3obmWwU+z2f+f6OJ3F0wnaQf8O
   5nGZYoJkfXs6R6ofdsFDq9LyHwbuy/cvWy1FNdSsKB0mDn7se04QCZDGd
   Jth8b8T1BL1Mr/2cK5enAAK0huDwinEIb8jrJof+YvK4mbeF2DkHAnDqA
   g==;
IronPort-SDR: nBnUEcTa8WxE7NGQzN8paYuI9UTWCHFCemhiGK93wwUTHIIPXVrrYXwC6eA370bCwLy7+KFtCV
 CgQ7/g2O4cXQEa60gihoqucKJle3lHppSeUwkIaiyDtbMZ/8C+7cWPY+eCv1tsXvTSyWeY2WWf
 52Im4NDCPrZZumnpFZ22YqZUegyAu31oFaEjCE9fyjiiuYtw/FMXpv1+TlD9GWGA7VQ7lk938+
 x5yO7QkES5iknD0BoXMiJ8Ve0lH3nR0Siooq+W6uYkYQSDuxY1GQ4WlU4iFkbfU8LSru1A3ppM
 GIc=
X-IronPort-AV: E=Sophos;i="5.82,327,1613404800"; 
   d="scan'208";a="168633722"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
  by ob1.hgst.iphmx.com with ESMTP; 25 May 2021 14:15:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l32Z8hw8NmkRezNUuocbqaYYnLuQiSZrEBTf2VQG9k516wgacp4nWE8U/daMTO7alD0P2x3tvyangf363oaCxZcLGO3uXwmMNGaplgfqsNMJ1Is/Nlzn7hcGKNhZgUf8nh3a3Z62wfxRNCbmCNqG63G3eQAuT5ZHtQSKMWsKYrfqqyrh3jZiyuXcHVT+hDgChFnuwadBXbUaHQT9I4mxu+iNMsqj9Jyfg2cgQulBdOvLfwCiaYJyrwKmyDNPCTMXjNZ+hLkQJmPM2l4wfUM7WuJAJfila3YXD8/7Gtv+WQ84B8cTjoPO3NnkGr4xnZBns1MRTegVFK7/2UdNzjZCRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PoHHkfS7VFM4uY70Z7Msu83OH21kCgDPhX7PBc6ebb8=;
 b=ogAWZlzwSppp/Xv361zI5HOSG69USZh8/t81W9OIeL3OW1HkSpE3HVQ6UuFoE2NAImZ4QGbAZyHvdH81s7aB/EINa3yjmZc1Rea7KYFVszeeTJpSZwbC3y9TxPCCSwTHpa0k3sBKbfTHqj80zsql90W4hfWWJem6j6pifMm/xruxe71M3KbI5W5LoX3Ua6kzN3jWNlItoF3VXPALENp13dDgShZntwnX/Z74UJwSgm2VfJ7ZPMLTGCT3DYQPTJTfUdM5SKKRLfPF57B7Mpoy+wZIW6n2B6nZiOvOezbtD1xpdNlOHLCugJPq8JhG7F4ms7qYCBc15+au5hEaaTNB/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PoHHkfS7VFM4uY70Z7Msu83OH21kCgDPhX7PBc6ebb8=;
 b=Ofg15pMX4FNI02Mjdbt8IYet2f4Ycwxp0XUZuMwCpl55LTjG//37ceixmepI/I93YibvFSSXfqu4zAw5bHIqFYQia7BGdA0EQBS9UVLi6SUQ8M8S2+ZODzafzkbZfDEadXLjt43vbOlzEJiCRsU7wgUXX4trLa+FaWC8S+1SbfI=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (52.135.233.89) by
 SJ0PR04MB7456.namprd04.prod.outlook.com (20.181.254.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4150.27; Tue, 25 May 2021 06:15:26 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4150.027; Tue, 25 May 2021
 06:15:26 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v4 01/11] block: improve handling of all zones reset
 operation
Thread-Topic: [PATCH v4 01/11] block: improve handling of all zones reset
 operation
Thread-Index: AQHXUQ1F6jb1VNqY+kaEwGILkKYOng==
Date:   Tue, 25 May 2021 06:15:25 +0000
Message-ID: <BYAPR04MB4965719E20B551FF85B8E5D886259@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210525022539.119661-1-damien.lemoal@wdc.com>
 <20210525022539.119661-2-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [70.175.137.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a1625eaa-57ee-429e-377e-08d91f447ce2
x-ms-traffictypediagnostic: SJ0PR04MB7456:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR04MB7456ED9BBB2730072036EEBA86259@SJ0PR04MB7456.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BuRLs4TOiXNS4k/Fzr/yUKJ0QmgUenKKWg6ADRVW1Guj8xjLAxEKe9X779ItNvDM6jOV27Czo0ZiVFQwfms1Jl7MQG3n9X/tTwo4iKinjq3bsCjV4ogT2Z7oLx3dYyS3rdyMBj7cp/Hc/gqV/hGRmmGhdYKTqhFGdYJzdHWU2gPrb9cjNfiQW7/ikCAP0PDg3scMmGXtCCVxdNQMiAk45wxbT1qo9bNj3haDwCBiahnm23ECLkvGZfhzTHH9x3chjznFxcAojXVMYzkeH/Jse+wZ105Jw/OqtD7mAbBWM82TePAs1CJzLizf8Qe2GuP9xHEv/8ubdxkFaezjDfx1fIeHX7ZvlA64VhL3Ho2azCizT9ihUhIk39n5gS2+dFDTgM3N1F4YKoEfLp6HZg8zmS8FHUn4tDbs4POG2jdeXCp7mVMZVIfgkfhhPJFSp8p6roQCFOQmiZhEM7DEJDE2/Woz2s/WVlTFOHnTuY4NbrmKN6k6kWuBiXEG9VYlPiY6f4yWuwdtqyJqWVSUx76Nxmu6/JnGj4CLTgukb8dekogoTH4nZtKxHnSOrGRI+Kunn6zpgPzYhqXkvqcHhM7npoZF78DMvXR1TgjbLLgdF9E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(39850400004)(136003)(366004)(376002)(66476007)(76116006)(66446008)(66946007)(9686003)(8936002)(64756008)(66556008)(558084003)(71200400001)(86362001)(186003)(478600001)(110136005)(7696005)(6506007)(52536014)(8676002)(5660300002)(122000001)(38100700002)(2906002)(55016002)(26005)(33656002)(53546011)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?E+gIl1vlrclBt9+i/rkyWG4w8gVfsqjq5SlGUHXVUj/qZEXbCHABTw/oglD/?=
 =?us-ascii?Q?3TbJxU8663lzYdqCnW8XempZBInUheAH6hsIIfHiRSbOAFjSdO2PiTYt+gbo?=
 =?us-ascii?Q?8ia28LE6v08RemhwB+29qa0RPBqULw9v0d4bQ9rOiotmg8JZm4tDBd5ah/ZS?=
 =?us-ascii?Q?HUbywTNHbGoBOb7bmLpm1ZzMR/QeLxG2vJo6OtEgiG2Z7WU7csu1E8L4Uw28?=
 =?us-ascii?Q?W0N2TO245OQblCwbbgn8sAL9BeUJsFIEhf7BzpLEqvvRdrEJeilachnx4IO7?=
 =?us-ascii?Q?zA/iQ/AkXRHjFx8BINmyvEpepo3RvXpNVrLlKU1wwCkq/Pg8CLLVM6lacwB6?=
 =?us-ascii?Q?Qod/tmGxA8WrsFmgjS8Ht8wpK/UtFp08YHgv+dqSebEhiAz9KB4Xj3TWBKhi?=
 =?us-ascii?Q?3wI6VpF3ZpFKQY0JVZ5hEOq4lNkjK1avqQVZNrrAPehSP1RTD8Ap7pkK8jIJ?=
 =?us-ascii?Q?vYIbTCbjmjCJrcQ66jXOHwBvXTAXsAiW41wwg/tdGCS0KITcsKz7hPWcif/S?=
 =?us-ascii?Q?EyrAj/8v3ce19PCFG7DkhCOh5TzrY4+NzOrEYJF6iXokakP5I6ohe40jnJtw?=
 =?us-ascii?Q?U2X/XO6X+aFXSbw0ERHeTiOh5FGsuZuthjwXcJhPL2OrwOtDCN29pgfFuUr+?=
 =?us-ascii?Q?u6ocey4gQvRSBvocQkVZZ9DfzU4xzGXrko+XvxiQH8nZ1UoUAMcFPVro9fLZ?=
 =?us-ascii?Q?p9bw+5ZJphEBZXAhXMeQ1GZ+zUVToNc1xOfYZnFO8pqMAQRDqwmgU4XGybO2?=
 =?us-ascii?Q?XjIeUzO4ujLBqrOKc5DfhiALw/B13NmBS28fMwYMMNHU/MEgdYOyAgp3aA1I?=
 =?us-ascii?Q?i/3a5ZcRyW4G2vthsqh+LJ1hVko9VP2xPCmygopoTgsqrkflgxdEmTYOPsLZ?=
 =?us-ascii?Q?5R0b815RNwnrMdZQ062RPdrC2KJPT/Qh4GqAUkNmNTWb+dfQy4jVe4VbSzMx?=
 =?us-ascii?Q?tJLcNsaxqr0TFRCZ0N4TL5jj6rK/c8UbvkEZ253BzWfDQls7Tlqp0mZhG2Ri?=
 =?us-ascii?Q?2nWhDCW1yojvr6QPbFSV+OiimmlAiOiO8Ubnt88avtVZfiPNotjkzU2BRNaV?=
 =?us-ascii?Q?XcK5sFRzRREXFMYZs1CO8BZVyzBIsco3ZCyAsW/2SgaVHCsTC4HHTYUT31wB?=
 =?us-ascii?Q?GekDhmwcXDg+gwyLFA7k5fG1GSMZFFgUch2duPzJG0k2mpEUvxYiWTYo/5At?=
 =?us-ascii?Q?rs0geDXbL430qXopMfxHdhO9qr8glgzn4+jgfat+A3E06u8AFwHpxyw4Q5KV?=
 =?us-ascii?Q?9GoJ0waFMbS0CWF7eoUQPk3SYBm+Wmk2pNKSqWbeb67VhnwjABf0ubNWA2rr?=
 =?us-ascii?Q?jXDYNhepxtwE394SHFqOUAqvrj7wI33rNG0SlSljeZEhDg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1625eaa-57ee-429e-377e-08d91f447ce2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2021 06:15:26.0924
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qe7RfpY+4eI0HITtQwdJhf67KuXlSE2y62eSeLFGNHtOj0ZxGrgAjWEGVj8SDoto5dglS57PBJbqIiSRBwnyrNmTmCYC9hO6kUQmLT5gFIQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7456
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/24/21 7:25 PM, Damien Le Moal wrote:=0A=
> +	sector_t sector =3D  0;=0A=
=0A=
nit:- I think there is an extra space here after =3D .=0A=
=0A=
=0A=
