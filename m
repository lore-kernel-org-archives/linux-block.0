Return-Path: <SRS0=kmcw=XN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB55FC4CEC4
	for <linux-block@archiver.kernel.org>; Wed, 18 Sep 2019 21:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6720820665
	for <linux-block@archiver.kernel.org>; Wed, 18 Sep 2019 21:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="aZsKAXm+";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="beukHbs+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387877AbfIRVF4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Sep 2019 17:05:56 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:30012 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387661AbfIRVF4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Sep 2019 17:05:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1568840754; x=1600376754;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=4vEquAIW5Y+AfLOjUcEL5jrE61OpYJNiGoXJ+TjBU4I=;
  b=aZsKAXm+cuyP5+IfrJYevIaNCpFgQI+GLY3h/13Cu+lgOuOBHm7aT2BG
   3bdjcHkD0szUceRhjJbUpHuEt3yxzlbFhQxX84Yev4VVLtUt77O7bFyw9
   8Y1YANUNIEELjlTvyNTS7VubqUB7lIGQ9KMD3/e96cNbdM1AovxxWe0px
   YNsu3KCKOklQTR1mXWUUfIOsKB9xYyIefXuYOJoFk43y0wx8UO1gn/Qcg
   +ZhlQG1ChBfbHB76vfQQtxkpIa+YFXHDnKsyr2CnsXoTbKiPWiqfTKVnU
   oHSjtYRhKzVkgW9xToPqKSgvTKRfWz4hPfWsCaVmtll0jl6VsrNmZSApM
   w==;
IronPort-SDR: iMWbdm4AbSLL6DumkaT33jJlTNja7S9JzcxMYwoT5Ib37auSTjR0RdhytrLEMlPkx1/si5f1ow
 jmzzRy2MtMxMPVbG2rVKpxST4jHXNAMFfnE9h8TPbl8Dp2RzAy4Y2QNqQkaOwlnzRYRYtOEo/O
 ucrUF5v8O8qZlnB+KnnLD7P7cpcDOsU78YxLKjve0RLvAfa+wHMYoatOmxxt72s9yX8nrhzfjm
 GpvWjo3fgoL3DbrejRRbuVfHIPtqWaSxL+fylNDN1ij7LnXsV8sOImPAUHNzLHmbrIRZ3NMGpY
 JYw=
X-IronPort-AV: E=Sophos;i="5.64,522,1559491200"; 
   d="scan'208";a="123050989"
Received: from mail-sn1nam01lp2055.outbound.protection.outlook.com (HELO NAM01-SN1-obe.outbound.protection.outlook.com) ([104.47.32.55])
  by ob1.hgst.iphmx.com with ESMTP; 19 Sep 2019 05:05:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R3cTT/glk8SQQgxKvK4hvteie05YE7nOSkUgutA1hgfFdPiq+yfG1HPIBNgokg7APn+rVZlIzE8lxsY/teZ/DO4nITQlR8BCnD6sBqYuhaSR78zknkY9cKpVASlSgAA9fFEnoqp1/1OI8KyMNd68vMwcjc9dEEu12zOKgN7DlRepb/6zuuwElqjZbG7cUS8BwCQQOVxKdPuf3KVIVhPnQCDibKgHOjkDmuhveQuQvQR1SXFADDTtJuzEp3TfrFHLH6DXXEOkNsN+v0XwYOl2ZmzAAOj5kSdhXVhDibLrIL3Kv4IRWvPbU2DbBJqtWTEb3gihAUnZEh0SlPs8XGlGIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4vEquAIW5Y+AfLOjUcEL5jrE61OpYJNiGoXJ+TjBU4I=;
 b=hAQIciaOObZrQSGjGFnXnHoBhue3tb18tGb9YQpwAnOCtNxscQtVE3I/DAg6osh7HZfYDN2FvDeKTZvl6G6SIaWoU4ZAOMZfuOtD+d3CFCsNgvpa5uf0P+dlOWj9dIodOMcUTGtNPBLp4QHdIgEAn+tLIJcFAFghTsAnWO2X7j4Y076n9qd4Q19XERSUngBjNtzgSQBBt8BA+tqWNfw+9a0MIxwghoWt4Z9bJ5gL1PETo6p/TSXwIzlzPh0jW00YnEfwrR/OwA13GzEAfXKRpoOn2SKBrHI3038aSpvVIbYv0NZXz++je0B4kHh1rgO/fuTXgF7GOqfH2As2lcG30w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4vEquAIW5Y+AfLOjUcEL5jrE61OpYJNiGoXJ+TjBU4I=;
 b=beukHbs+9e9bM8L3BlGYoAJ1zBkua09kE4QZ50WF0CEb2WjjETE/z8kxnQzBryU7HrnkYnwOec8M/CIMNiYjvhSQ1Gu6X1t0XTfUkcEo8K8ATh8vD19QfKc9h/DMXUC4bmyeyOdkRxGhuD3P9XjXxvc7RVEiO1a02wMXYtlXxHY=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB5750.namprd04.prod.outlook.com (20.179.58.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.15; Wed, 18 Sep 2019 21:05:51 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6169:680:44fc:965d]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6169:680:44fc:965d%6]) with mapi id 15.20.2263.023; Wed, 18 Sep 2019
 21:05:51 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "osandov@fb.com" <osandov@fb.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>
Subject: Re: [PATCH V2 0/2] block: track per requests type merged count
Thread-Topic: [PATCH V2 0/2] block: track per requests type merged count
Thread-Index: AQHVbbu3jcrUtbDbWk+hQetm7bQSVQ==
Date:   Wed, 18 Sep 2019 21:05:51 +0000
Message-ID: <BYAPR04MB57498738C7B6982C202FC674868E0@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190918005454.6872-1-chaitanya.kulkarni@wdc.com>
 <369ecccb-06ca-68d0-1474-34abdc2e8851@kernel.dk>
 <BYAPR04MB57494B7D18A17A97A09C6661868E0@BYAPR04MB5749.namprd04.prod.outlook.com>
 <c7488e6b-01db-b0e9-3116-6c96374c3639@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.170]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6960753a-2725-4af6-3bee-08d73c7bfca3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR04MB5750;
x-ms-traffictypediagnostic: BYAPR04MB5750:
x-microsoft-antispam-prvs: <BYAPR04MB57505CA952940A39D50B6212868E0@BYAPR04MB5750.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 01644DCF4A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(376002)(366004)(136003)(39860400002)(346002)(51914003)(189003)(199004)(14444005)(74316002)(4326008)(33656002)(71200400001)(256004)(66066001)(66946007)(64756008)(66476007)(14454004)(102836004)(25786009)(7696005)(476003)(2501003)(66446008)(71190400001)(66556008)(76176011)(110136005)(54906003)(6506007)(53546011)(186003)(5660300002)(486006)(99286004)(316002)(6436002)(7736002)(26005)(76116006)(3846002)(478600001)(86362001)(6246003)(4744005)(305945005)(55016002)(52536014)(2906002)(8936002)(6116002)(229853002)(8676002)(446003)(81156014)(81166006)(9686003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5750;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lkp5HAyPLndvRJPYLxZreh3CYSQ/InqTkFMPT8T5sVWxP91Y9b6J4FdNeIgzpM7iiTEnUQ4+mpD5F1C6Xzna1jUV9oy7BMhG0q4IRlEQpq0Z62bmAueVy9+W4WmKHTGcgHsAYnrMg55PXGNI611/uVFkxN3tSWIEE5/FseuVY8k62FfV4t0kPFZ+kvPC0fQ/sU6SUrrGOQIpvTVTE09eZu7mdouNAGlGJQYSALxc75K1LuIUH+ZzmZ9OEkQzzrcRh+AMTMcmOoF5Vhci6IIGo1m0xe5weMysxtePvTeFtwseIi6mtO5NDMG3G0ivIMKIcCgsRQ6gGrhFTuY7gidxTiWlP3PgBVRp01BTh3W2OlI0PjjgZZKqCkvLZ8ixlFYWR5rqvRNnYtTvCKJJDknb/pVoZHLO3jtGP6sLYqEvdqI=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6960753a-2725-4af6-3bee-08d73c7bfca3
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2019 21:05:51.0776
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HzY/g31NxENyBij1dpo0Yvwm/JW09M6Vx5yhk6VvN/9fYqVSHb1Wz943mYArsR+qiP7Bo6kK5h0J18TDGC6KTMaJggQ8wJ9eWofHtTtt5G4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5750
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 09/18/2019 12:49 PM, Jens Axboe wrote:=0A=
> What is this new request type that supports merging?=0A=
>=0A=
> My point is that adding stats like this isn't free, it's a runtime cost.=
=0A=
> And if it's just for debugging, there better be a damn good reason for=0A=
> why we'd want to pay this cost the 99.999% of the time where nobody is=0A=
> looking at those counters.=0A=
>=0A=
> So why isn't the iostat stuff good enough? There's also the option of=0A=
> having blktrace tell you this information, it would not be hard to add a=
=0A=
> blktrace-stats type of tool that'll just give you the last second of=0A=
> stats so you wouldn't have to store the data, for example.=0A=
>=0A=
> What I'm asking for is justification for adding these stats, so far I=0A=
> don't see any outside of perhaps convenience, it's easier to just add=0A=
> them to blk-mq and retrieve them through debugfs.=0A=
=0A=
Thanks for the explanation, make sense to drop these patches and rely=0A=
on other tools.=0A=
