Return-Path: <SRS0=/Row=77=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C5AC433DF
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 17:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCD4F208C3
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 17:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dKvbrKaC";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="gebS8sVa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729519AbgFRRbn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Jun 2020 13:31:43 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:18458 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727805AbgFRRbm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Jun 2020 13:31:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592501502; x=1624037502;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=F+vLgXRoVQEPZ6z2LjwClqzyEPtTNF3mQFO/zvWF2c4=;
  b=dKvbrKaCB4H4I3GERivJcIAi8lOaZhrMdwoBpc6G7RFCH3NzwLtJUNQ6
   kqHoTw6Il7W6jg/mFacuMm+V7I+Jludx667ac+kmKSpMiViGb6J/emtna
   4oBcj3br8RepTBoyMy0r4LS1rM1FGa7uDo+m03s5r41CM1X7maS92haQB
   sna1naXwXB0flC7OC1czQnrkweNA1PIyTXyIOYqREW/L4Xv7omyKLTwpV
   ckmDfnjN7pa3H3i5PByvcUrxM/kC5c/BuhIHeP5pst/wJ1mz7fp48NCvu
   lrkjqfn2Fb9qZvVHWfl6ODLtapFt5UXjyG81YpPysAqzMfuUBl21boGlB
   g==;
IronPort-SDR: rWfZmAD8JfwSgvoQjVufs76jlfGdREcH6NZzaHRJQ/wXMZjCoLfejnJzRFCt5JccWIgUZa8wrV
 9zbGLZJT8+OU8oFhZskCzBXbij++KUkY0rgSEEn6iJj3hCQE06dT7OO2KZBURXwtEPOb3jFzYn
 RgSZeCPZOKRPIWlCNTmoS9q7iNHBQKKJSpAactLD+OUN7zu1/XUyDSWv28gzY3ahdmcIm4YeZL
 8C07ZnKwNXLWE+tILJZvPcFT4ESK2Huaa0Im8dRGAiYU34Xb1VOJwKPdqsKN5YYE3FuGgzM1iu
 kl0=
X-IronPort-AV: E=Sophos;i="5.75,251,1589212800"; 
   d="scan'208";a="140340975"
Received: from mail-dm6nam12lp2177.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.177])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jun 2020 01:31:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K2Qdvv5hlPWLJ5YaaY4y6oFPFMZat6LLICqTuIdOYCm2p3QnuJiQrGeYUQETCHQL2OPBIx5/ya5fTsxDJOBayQcd03pQ9ofOagf/tcvs29S1jx3Xh1n01e5JRVSjCE1eiepqgk/QLvFhbkV6M0iLK4JJMVmAObgnGnXNue0+kym5Yyujoau2Cp9byjK427eWKgc7RuS673JCi1LJpj/MSzrNmWjEF6My/ZY/WvxkxBSkxWpBcx1A8LaUp62g+TN8JCcgLkUAp+Bk6npicoc06jsyv0oG+Bax+5MIC4w9RAl5KOqFX2E4qTFEd+ti9LyWnS4IamRhv8xKksMlf6qtOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TNIy+4oYBDbcnWjYaIEpe8U7T4jQBnWcdiWhE/c8kWQ=;
 b=Ko1v3Nd22eaWUGx9FbXYxBvaLLQAIsvjvmxcAWsCB6mo5TiWBjeaj2WSb8cddU7He7sYUJ/jBL/HhK5Hd6wHUU/BdZZgEFl89bMcKxuUzm8DFEKKCxZl08lzkd+Mgj1uw2Ea9XAAYE/7noPlQ9ABex8LtL7rrw0Tj5585prUIWVstoSWJLSAbeuKz9lR3OMgTLWggP7WOT8sPEOxqxTwghMGK1yuMbVZtTwKJIQwM+yOGwrv9pHasYniOQ7xl7uUb5AcnY/kTJ2pssN760GaidHrL5yv22qPKHa2XrS3VAdpD8/VUswUzAysCfIoiXBcHc8IAAzLtDeu0h0Dr4BGHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TNIy+4oYBDbcnWjYaIEpe8U7T4jQBnWcdiWhE/c8kWQ=;
 b=gebS8sVa5MPLqaV9JQuTA97KeDk2JwOq5L070f4Vjl+N+VkCLL8FyDdgytNkzwHcYOgxyLgyt4wM5rSym+5yId3UEviCsZtlw3uAaByE8ffbs6tpDbrPKTwj/yyRxIRIHyXMiY24c0ZJDkHV6lCmLxZdM0K7eflJaKVVII2xHVY=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5032.namprd04.prod.outlook.com (2603:10b6:a03:44::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Thu, 18 Jun
 2020 17:31:40 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3109.023; Thu, 18 Jun 2020
 17:31:40 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Jan Kara <jack@suse.cz>, "hch@infradead.org" <hch@infradead.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: Re: [PATCH] blktrace: Provide event for request merging
Thread-Topic: [PATCH] blktrace: Provide event for request merging
Thread-Index: AQHWRLAMNttH7JUaU0CGzcROGKdTgw==
Date:   Thu, 18 Jun 2020 17:31:39 +0000
Message-ID: <BYAPR04MB4965D21B363957DF36372151869B0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200617135823.980-1-jack@suse.cz>
 <20200618065359.GA24943@infradead.org> <20200618161331.GD9664@quack2.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c09d9846-4701-47c6-0068-08d813ad75e2
x-ms-traffictypediagnostic: BYAPR04MB5032:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-microsoft-antispam-prvs: <BYAPR04MB5032F33B3BFD1AB6554559E5869B0@BYAPR04MB5032.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:883;
x-forefront-prvs: 0438F90F17
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G0flERolmNEVM6SCANKnGcCwGaG+M7kCjHN6lKtyex/os5emnR4N4N+RZv61dEAYHNdQCs/SW5uH6AKm90GgMj2O8VjbXI4oYxb5j8pxKIGynkDDO9I/zQwzXgA0OqR8/bjhFp7ZChB8I5rk7YExEH4DRmFAlawiiEC+r1CZa4zYk5R3YyU/KCxhBzgTCY1LCTszVecG5LVCBK4DHjFQWeqx1W0ALz55Vb/OTr0kh1jm2ae0Zus9ONUgAblMX12BGjliTgwM5EuP5/AhWOHj/KXmtVYLM8hlFSBbMDiyVEqvOnJeC7bGLrf4bRiDL+CloZ4GIhvnVEWobGrUO93FIQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(366004)(396003)(39860400002)(136003)(376002)(64756008)(76116006)(66446008)(66946007)(66476007)(66556008)(54906003)(110136005)(478600001)(9686003)(316002)(55016002)(6506007)(53546011)(52536014)(4326008)(86362001)(8936002)(186003)(5660300002)(2906002)(71200400001)(4744005)(33656002)(83380400001)(7696005)(8676002)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: a9W7DONtOJ/h6ZCbEIRYbzFk03IBIEXtLHaBVdFK9x1qgagluYfRrm70Dou25MIVZqB8bis5n3BO1/QnzwGMYtU9jb8qurzxCYRMVcgKdjzpK9RFlsqRpQzrAtHLDORVP8oQR9C6fmBEsaMBu+Y0op+uHy/s6j97JA+RQJOTh8CWs/39uak/6GxPoBcttuwkI5eg7pqSYbOJoc22HI2m2Q8SBY67bdQFKeuDtSMsflddwI+/V1+31yJZPNuhah1ZB2dW6owtMkd3THHD1y36KcgxgMJoPz2VlRq9fE8GMdA++f9fFml3SREYgZ3EVXe3p2nnjsYIk2WZfJsguXAHZU0Tt69MDtmMYzJlqN1auXss/DDnFhsP/tdsYTO088jYyyCyh4rv4a1VI68ltlDQ4/yXmAAeWikBZUyFr+n1/gyctJqm0I7Nafk3zEN94t8+qK/vKrFbdbInAbTv2zuBidqIJgGh9etXVHFdlTMj8oY=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c09d9846-4701-47c6-0068-08d813ad75e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2020 17:31:39.9401
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lRHPx9RmvZNvB7eUUBBZG73dmodopddGLWBia8cH/Om/bRF4xMtrxiXDmT63ChCBJULDeMUfzq2ZGKcoedXPVCXaEPBs0Okp/oP/Y983flI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5032
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/18/20 9:13 AM, Jan Kara wrote:=0A=
> On Wed 17-06-20 23:53:59, Christoph Hellwig wrote:=0A=
>> On Wed, Jun 17, 2020 at 03:58:23PM +0200, Jan Kara wrote:=0A=
>>>   	blk_account_io_merge_request(next);=0A=
>>>   =0A=
>>> +	trace_block_rq_merge(q, next);=0A=
>> q can be derived from next, no need to explicitly pass it.  And yes,=0A=
>> I know a lot of existing tracepoints do so, but I plan to fix that up=0A=
>> as well.=0A=
> I had a look into it now and I could do this but that would mean that=0A=
> block_rq_merge trace event would now differ from all other similar events=
=0A=
> and we couldn't use block_rq event class and have to define our own and s=
o=0A=
> overall it would IMO make future conversion to get rid of 'q' argument mo=
re=0A=
> difficult, not simpler. So I can do this but are you really sure?=0A=
> =0A=
> 								Honza=0A=
> -- Jan Kara <jack@suse.com> SUSE Labs, CR=0A=
=0A=
If you guys are okay then I can look into this and send out a patch and=0A=
we can keep this patch separate.=0A=
