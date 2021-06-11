Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 864F0C48BDF
	for <linux-block@archiver.kernel.org>; Fri, 11 Jun 2021 01:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63C6161376
	for <linux-block@archiver.kernel.org>; Fri, 11 Jun 2021 01:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbhFKB7H (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Jun 2021 21:59:07 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:33231 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbhFKB7G (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Jun 2021 21:59:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1623376628; x=1654912628;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=EOAeRHhAtuM/yzuALJnAL4MvcmFekuPaJ2IpSiZs+pg=;
  b=LVW7Vu3jvm0Us9cMtSrzw5kuFWwEaAG56UMyfBxYE48f3or+H0iyhY7D
   5IWfD453hkOcrVNQlOPMvcAtlgQvTEZyW9F29QVThROGCS5i/Hg4AaTTt
   uETt9KrIndyxhOr4R/blKklMrUbuDZQv9fmJ02iWrAUQMdq5m4L/2iddR
   7DllUYTOHQ+UJW6l0ereduOLekm+vgb07jZrQ0pe4Q5Xnme/FFRfwQxrM
   HIx0KMJ8yB0UYSkvhioLlzqG+3ehFpVFC7lcBd2k8eg20kIUO1a03zkJ3
   CsbdNu4khf/BZmSF4ZIqX/WZd/Cozt6X44K42PQlhsHeQJ6pXbqKqSWZU
   w==;
IronPort-SDR: v1eft8YMktwd4zIiHg/0+BMaHteEaQDFUuNs5qW8vT+6oH+De183lYFWorCUht5JNh+2jT2Ysk
 JwB4spKBkOZPMK2e+SUDmMrUwGEcRfwHcTQC6LU1Iu8PRfSc3tc3vGQLV5F9LB3zw2L6ZG2zxP
 F17f5Qk4wOu4IkrzTe1Yg8p1IWPm5su5UsZupRNCwACdC9Bzz1SV8TJdve5lJG4CCKCJz74+KG
 ks6DH47a2GNyNxG7Ceed0trpGi+fwY3YZLohOIiXv33biYx8BfLrvcwLwD0WW70anGp6Ax/XoZ
 s0c=
X-IronPort-AV: E=Sophos;i="5.83,265,1616428800"; 
   d="scan'208";a="171536332"
Received: from mail-dm3nam07lp2047.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.47])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jun 2021 09:57:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aIenSeeU3fr5MBlnjX6gS8HWRfqOwO3Ibx9mLvVZM9R1tpOqgpF2INiCMtcRo+4QwTqJJWAG44jMpZ/toQPnAVOF77AY9sqkPgk/c+a6B3CkswM597eqb6GwhdgjBMMBd759nNLJ2PcnGvgvXXjWoL3vrxjxCZPQTdkD7RI8UAcJZVuJrsmc5v6zcYaLyIqRUKkR1PH+q7wfSO5r/1gwuC3S5Gl7Zb9GR13V8pg06Ps9vDMx3434OHyantH+rjvzA2z0hgOJOHFeiIs6ygcTuFcTFduxDcReoHETtkKTCd4u95wpVQ/NThmZ33KePPT5Il1b4vx5TPx6bSorc2TQfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EOAeRHhAtuM/yzuALJnAL4MvcmFekuPaJ2IpSiZs+pg=;
 b=TVURojcSoUK+Smf60ApHfcLoVdzlyNye+IWA1vnF756WhpCf4N0izSRZSyjRrpaQxgxoPRjfeVCjJO/jS+wUmfNwyNxIQ9gnTQZYdQHet7nbbN9biC0I0LwdXZxCxpyPx+RIVjaYdx9abgLgTJ1sTqartOneBFturnZXNROnwBcePNwT1YPeXbASlitp71cf8GepjqWt4fWIG6gQ3Xpe11tLEpAD9IeWP/r0QqCE8E7zZT8aDSc93nqJ13890j9htH6taiRQb+FmH3U1Cv7oB/HypLerFjyrWatSzRRHslmp4pKw8VaWQ/VxDdvGS1KcG9gOpGq3aX7zoQ81dujVMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EOAeRHhAtuM/yzuALJnAL4MvcmFekuPaJ2IpSiZs+pg=;
 b=Oc3rXvzbdxMN1isbuuJX6dOBkbzK1Fbs2vQeChOo5SNKXLX52v57Q7kB9syvArwT18FrIZwi7occJ+42yWEANXBZIn/McEMTOMgfpZscVdyL2ttoOFpgFHAp2Bc8pgKe1MskFtjxH4kHR87ELfNQGvvFbQwdqJBufi4yc+fgi18=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5333.namprd04.prod.outlook.com (2603:10b6:a03:c2::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Fri, 11 Jun
 2021 01:57:07 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4219.021; Fri, 11 Jun 2021
 01:57:07 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Keith Busch <kbusch@kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        Yuanyuan Zhong <yzhong@purestorage.com>,
        Casey Chen <cachen@purestorage.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCHv4 3/4] block: return errors from blk_execute_rq()
Thread-Topic: [PATCHv4 3/4] block: return errors from blk_execute_rq()
Thread-Index: AQHXXkHquF6i+4121UqODU0nvv3UVQ==
Date:   Fri, 11 Jun 2021 01:57:07 +0000
Message-ID: <BYAPR04MB49656B80D8290D909B29074186349@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210610214437.641245-1-kbusch@kernel.org>
 <20210610214437.641245-4-kbusch@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 20edb741-d185-4e5d-5e20-08d92c7c37c3
x-ms-traffictypediagnostic: BYAPR04MB5333:
x-microsoft-antispam-prvs: <BYAPR04MB5333A93F2BFFAABDE11068C686349@BYAPR04MB5333.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7VJ1NIrUFtqaKAX3UhgqWGhUBcXaR5MRcjMteWMaldVEXKlR946dI75V0tg9pVCLls276jmfO1Hao92rZVYpI5DEdqf5/sjmVWLoe1JEHgDuhM4P17WYrtAucO/QcZb9Fq9GmljEp7Q7DSb5cLnuqNQ8jeGpZmNoCWlx7QRQeNmktbETUj7Bx4nbjzSrcLCC/wJM6M3bILM8Tw7ax+4ly9aZ3X/v0QsVFwFBDJA9bLMESe8Tw2im4gFOHsvTZcb/+q0oleeAlKdlnIsA1nncVyI1iGToXPkDVWqtRB+9Fw9IcXUweWnfn59fENtNRBzmMfXl+9+Hx+g+28BYKikhzfrKODfZRUlYgFvQmFTdF/n/Ggg2j2kK/FODG1au0yEMKDOtJ2NpIcM66Xc1vVgUW4OX/gu3UxoakSdXhdkBU6iyBT0wfFpbknR/yyNqWxYXMJN557co7cbyD2wGiEdyUqYR4xFR2zb8vBS0JvBxxPyIyxPtMGSl9VIwwtjCv9ji0sH5NbYdjgrZjGBKhLyHMTOHR3Fy26xmScp/7KH51GLCG+vHZQfQFN2hYiufEqF2cBbsBajfez3Tg+wLYy6LghtfzF38Rh4gYuczeq/ZD9w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(136003)(396003)(366004)(8676002)(53546011)(478600001)(54906003)(316002)(4326008)(86362001)(7696005)(76116006)(8936002)(9686003)(6506007)(66446008)(4744005)(66556008)(66476007)(5660300002)(186003)(64756008)(66946007)(83380400001)(52536014)(122000001)(55016002)(38100700002)(26005)(110136005)(2906002)(71200400001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0CnC2JWsNL4NewHhS9Np1jOIZF1znba0cwecstnUwvX+bPg7aKQ7l97NEq1J?=
 =?us-ascii?Q?1q2yNjbsZm7eIK2x9xbbzZott4f1xvpORa5GntFpw5j+TK8nTG/WtO51CVln?=
 =?us-ascii?Q?gvR3JXtFHlsBkccoqTF3pY2RV6SHIWU45QvK4lhW4RwliWb1rF98iyPHKCSt?=
 =?us-ascii?Q?5C19tCZyF1SVk/r5BkqjN7dluUS9LLn6zOFUHNW1mLqkjL2ItPb4Gj2Q6R6W?=
 =?us-ascii?Q?0Zwc4cYoInJX26ED+neCvQGtzD2iIXc9ZyLoLtfvQAD3PezaCLKt4NRytNMW?=
 =?us-ascii?Q?mazy4i0sap26DU/lMQ7ynjU5miZG+BH9SAiwsmyfFlz0yNrCPy/7GXHvtRBu?=
 =?us-ascii?Q?HLeflDAC3SQ0lqBiDV3MD8/NZUqtnPsW5pbmTVG1p/k26l7WNAvrRorq3w1Q?=
 =?us-ascii?Q?Rksqb6VpUosqnKmDqKOPyNWoTqSAYsxJDwVgWx/f5FAQ8gfrXOIfu7ClIGJx?=
 =?us-ascii?Q?jgQMjH1d2CZWpQ2QYFuINSHgZXjNICu+yK2vXcWdI3gxucHy2KR0nv4txHNr?=
 =?us-ascii?Q?cCZdCWTgQcbldcq67cqH8GDpp6HcGZ5UW5kzJJo34d6cRvecoSwu5qndaPBa?=
 =?us-ascii?Q?15ARGF1XB4uvZ8/LENSXQHhZ+RnTkwWxFELDFnDg1k6nwVvhU066iXgvPp7L?=
 =?us-ascii?Q?K0OT/1euuFuEfGlXXRljR4xreApK29kkplPPyEghwdiWU3j8kVvw3J36xiUq?=
 =?us-ascii?Q?eevxT4gxnEt/e4GdLc1J7KswDu0L0hedS7JGu+rOrExF34kYBdfznnP0455o?=
 =?us-ascii?Q?eiPKGzm5DEtp/rXw8W2UVQuRigyCuHcmIgKHdKGn4TmOX4ZDvkjJCun4kHFX?=
 =?us-ascii?Q?Snqf/UJT67mBcRGPX+CsCo9MyjLHD0yKNG1OpjKZDrVXmW+TonWqZZkSahi9?=
 =?us-ascii?Q?1pKQPbLGDmGg91CVIk5U9KuQkrwpbxWqQr1w1B/auCUDYWjEdqp+3bz38DyF?=
 =?us-ascii?Q?Uj04LnFOboQC7O4pOgh91NbAIqIVD9JqAC/vmlDGPEV0onLoOT0dldOXfwqT?=
 =?us-ascii?Q?EglyS056CodB25aW2VpBmqKrxlFm35q/DRo2VRDnYekvSVqU2BkmaCRerqdg?=
 =?us-ascii?Q?Nol9Tgwfk2ASjp1DMdGZHRoMnl20M1v409RikpCC5lrYq0CtSvJkOamXmGtM?=
 =?us-ascii?Q?kR1/gBC5cKxL7TIfKj9UXH6E9CiiuSiJOi7NLxGIxWOqkW/Ba0RfYSAolkk1?=
 =?us-ascii?Q?RAq89fWkqnCo6RWT3QmRwqdyYq+/7d5wM7GQpZjsjs01Ti38ZAui3madtFlt?=
 =?us-ascii?Q?UORfaL51KESSxYcGtqIHB/Zswg7TcP0I0SUNFTpmH8SIsD/DMwRgnFCYLjSA?=
 =?us-ascii?Q?N7NcliTFVLQghFg+Fa7Zi0cn?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20edb741-d185-4e5d-5e20-08d92c7c37c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2021 01:57:07.0393
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kuG8OEmhOIlndGfCIo+prGRggr8PNpzmNmiezSxSrdhj8GaHRWSnxK40el444xlZmNbPGZ2WOArig7ehv3skhAUOF6k0PD+GO/+Bn964fMw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5333
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/10/21 14:45, Keith Busch wrote:=0A=
> The synchronous blk_execute_rq() had not provided a way for its callers=
=0A=
> to know if its request was successful or not. Return the blk_status_t=0A=
> result of the request.=0A=
>=0A=
> Reviewed-by: Christoph Hellwig <hch@lst.de>=0A=
> Reviewed-by: Ming Lei <ming.lei@redhat.com>=0A=
> Signed-off-by: Keith Busch <kbusch@kernel.org>=0A=
=0A=
Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
=0A=
