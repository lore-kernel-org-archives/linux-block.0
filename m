Return-Path: <SRS0=Yhvv=DH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A350C4363D
	for <linux-block@archiver.kernel.org>; Wed, 30 Sep 2020 21:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C34DE20888
	for <linux-block@archiver.kernel.org>; Wed, 30 Sep 2020 21:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=micron.com header.i=@micron.com header.b="IeFPMJPA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730457AbgI3Vtj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Sep 2020 17:49:39 -0400
Received: from mail-dm6nam10on2046.outbound.protection.outlook.com ([40.107.93.46]:34560
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730442AbgI3Vtj (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Sep 2020 17:49:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iveozn/kZUPQm5Y2zBt1v/nsIQegan/+nqVn9cObLifINE3f2QU2uES2BtELdpriUyG5i2OvXqzu+F+QzpDIBTKZwC+kNLaSbbvFOoRp2aIMw5Rhje8x4mQxFkK71/6M2/v1IQKkQOYECVYb/PREqthJrDmyOH96cnP14reKVRBzV2tq/UbVD2ehep/1HJDOfk5jwtiCF6z7Rvl6hD1AmCqP7EkmyXWoU9W1MaQTiLmL0WKQcNV3tSK0Sg/GGzC5ElN6Mmm+Qqbq+pWAQeeUKQYviNsPLtHKd3C1KLae2t/uxYUYvvbFzbwWLX8Z0WSp/RjdebC9N9MHG1pnvehIYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XIW3Sk3LIBtMcrluAFKosVttI6l0Zi+KRFJq5MAIyaY=;
 b=J3rQQ7PbLKtIPA6lJWzpPW2LRa4XK2YpXy7khuIk62ozECwx4hagKBd19I+Skm79q6oW+KSgEcO0fUS9RqAfArZefpYp00cOuSfBHnCHFJJ8l4ISmWTj6NUPdy599E7v7vz5UAICIQd/W1rYVVlOFmffNPeC6buNk6lZtt0hhZq8WpmTen61zvVag5mEbJtxwDofDw3CmvZQUiSJafshWr2+0hzFnKKGwncFhrQg1cms/BUTd2ZsvAtnJFpWg3MwE6YBh96ZdJuJoTl+eU7OgiT1mJRxLRBRK3Yn7OOHmLF4zJthywoV4c6iIJbQaTUXeFHtxwoeL120okLmp9i5gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=micron.com; dmarc=pass action=none header.from=micron.com;
 dkim=pass header.d=micron.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XIW3Sk3LIBtMcrluAFKosVttI6l0Zi+KRFJq5MAIyaY=;
 b=IeFPMJPAmjgDFIOlReoUzWq49P7r+J5SSDQu2U7DfKCEBSJhPGFOfpXqDEtNErIV60fgqLovxWuki31FNJguYzJte0nAe3T9g1o+UPQdT0qnqM9lCMC5LWf7VGiupS5SpOUkPcFVCURc7EF2QEaxQn+OHfP8I6buIKd23B/zzI0=
Received: from SN6PR08MB4208.namprd08.prod.outlook.com (2603:10b6:805:3b::21)
 by SN2PR0801MB2144.namprd08.prod.outlook.com (2603:10b6:804:10::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.34; Wed, 30 Sep
 2020 21:49:36 +0000
Received: from SN6PR08MB4208.namprd08.prod.outlook.com
 ([fe80::f459:dd7f:5b2:effa]) by SN6PR08MB4208.namprd08.prod.outlook.com
 ([fe80::f459:dd7f:5b2:effa%7]) with mapi id 15.20.3433.035; Wed, 30 Sep 2020
 21:49:36 +0000
From:   "Nabeel Meeramohideen Mohamed (nmeeramohide)" 
        <nmeeramohide@micron.com>
To:     Hillf Danton <hdanton@sina.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Steve Moyer (smoyer)" <smoyer@micron.com>,
        "Greg Becker (gbecker)" <gbecker@micron.com>,
        "Pierre Labat (plabat)" <plabat@micron.com>,
        "John Groves (jgroves)" <jgroves@micron.com>
Subject: RE: [EXT] Re: [PATCH 01/22] mpool: add utility routines and ioctl
 definitions
Thread-Topic: [EXT] Re: [PATCH 01/22] mpool: add utility routines and ioctl
 definitions
Thread-Index: AQHWlbb9ZgKauLTm+0edDEOGPyMi1KmBDd2AgACq1EA=
Date:   Wed, 30 Sep 2020 21:49:36 +0000
Message-ID: <SN6PR08MB4208CA2400FC06C4939D54F9B3330@SN6PR08MB4208.namprd08.prod.outlook.com>
References: <20200928164534.48203-1-nmeeramohide@micron.com>
 <20200930112715.18532-1-hdanton@sina.com>
In-Reply-To: <20200930112715.18532-1-hdanton@sina.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: sina.com; dkim=none (message not signed)
 header.d=none;sina.com; dmarc=none action=none header.from=micron.com;
x-originating-ip: [104.129.198.89]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 60e8e3dd-867c-4a3d-9f5c-08d8658ab98a
x-ms-traffictypediagnostic: SN2PR0801MB2144:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN2PR0801MB21444A3F16ABA93C6D2BAC60B3330@SN2PR0801MB2144.namprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1227;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UMgOdkenBDGQl5tJHRoihhVc0jAAE6I2dplKx43fTaoidnxuFZaHWPqICeK2hRS7zsSBjLwitKEFUDQ+6AXSQh64Da0PffsdBBiu1AjlCB716EUyC+eEXFmpFn1Xm0IKk/K1X0HEr5UNzbYMAU5PF6h/7t5heQfIBsj7y4iexMcTrw1keocdlej+GvyVqDdgLY1qShSr12YrnJt4HAeh2j4YietyahZB5xg5wrmh81M33pvoYeLuRvilHSylS6Fiqvq/evTsTqP6BRO7PKMTyOFgT7oZR/7gKkhiH90kw13bXiWLD9YjSmFVfWxDJWP06jk1HuDA2qXK/EhwDnV/6g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR08MB4208.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(346002)(136003)(366004)(396003)(53546011)(55236004)(71200400001)(55016002)(5660300002)(8676002)(4326008)(6916009)(8936002)(83380400001)(478600001)(54906003)(107886003)(76116006)(33656002)(64756008)(66556008)(66476007)(66446008)(66946007)(316002)(86362001)(6506007)(52536014)(186003)(9686003)(4744005)(7696005)(2906002)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: ECsh3bHOhnI0sr1ttZQ9Kh0EQypF+9UkGDFXaZO5yuWe3FKyP7oo82JNWdpznGyX7pK6KecCKZop2PkAmk7hl3nXmqz3+95hLUna7c8MiQGbVDf7GnyDbHGcszLFy9H5oYN7Exks+pRkETZemQ90HjQvJqbE2JNC2dUXZ1K+mWtvdZv37sh06EPg/TkrYC2hf3WDl1yluvE5DPi2C+1r/ZjCGX/uZvfxhajGlBi7dAAyLODzuV+1vP0Wh2zobMx08B5m9TQoAGatjT0Uz3wKedpCreLQptKOPLU6/FeKz9esQD8ex6pjz5U7h06vS9rf3tr7nrdJXV6UBwj8oU5Dofcp2rCGY8RNajkuXsTBHZvyWcRM3JpKBMHUtJicKyl2ron/pUrHEWIMMfdF/+qZC38kVxBcZS37IKNlYp7fqAEIqhaxf7s6gduaSQaSnkWcSqnqxIEbrwqCjJygdmqyZit83IQFlt6Cbj7j2J2lvBI21dVtgCH9pRehWLvQL4caFjZofD4QARQfWqYlzEHs4Djq48Y5DBLBfl0KmRdmwXVmcFR2XML/lmRl9Gv87fcC5RS3jiAS0Qk7M68MjXlaRtK4hCDEpYCtiJz8XGSMnbUrOEbIvAUEed2GaD4zH2/r57OmpKF7K9f0w1H3WTDEng==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR08MB4208.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60e8e3dd-867c-4a3d-9f5c-08d8658ab98a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2020 21:49:36.4437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W+yBvS15ITvykTlWcCKm6YjB9L4rbE5OvDZeS/N9hRUPJPd/7+OG5EYKzry/dGns9tEnrBpXvwfVUZgwGYApXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR0801MB2144
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Hillf,

On Wednesday, September 30, 2020 5:27 AM, Hillf Danton <hdanton@sina.com> w=
rote:
> On Mon, 28 Sep 2020 11:45:13 -0500 Nabeel M Mohamed wrote:
> >
> > +/* Rate limited version of mp_pr_err(). */
> > +#define mp_pr_rl(_fmt, _err, ...)				\
> > +do {								\
> > +	static unsigned long mp_pr_rl_state;			\
>=20
> We do not need to declare a mp_pr_rl_state per use case of mp_pr_rl.

Agreed, will make it a global state to rate limit all messages vs. by call =
site.

>=20
> > +	uint dly =3D msecs_to_jiffies(333);			\
>=20
> printk_timed_ratelimit() needs msec as input instead of tick.

Nice catch, thanks!

Will address both your comments in v2.

Thanks,
Nabeel
