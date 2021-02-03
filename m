Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C08C433E0
	for <linux-block@archiver.kernel.org>; Wed,  3 Feb 2021 03:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04F3764E29
	for <linux-block@archiver.kernel.org>; Wed,  3 Feb 2021 03:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbhBCDUq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Feb 2021 22:20:46 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:41956 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232553AbhBCDTV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Feb 2021 22:19:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612322403; x=1643858403;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=gdJQwA7+aePYlkEbGLSqq6gZsKndJ5GziS16JpPBdNQ=;
  b=q48cq8xp9Z7WS+zUi5+zog9nGln+NJpg6a8jnGQoScjXU12S5eve0tBq
   IYVcVjIopcN19HCCtP1Y7IwN9pu2hyZ5uTyUv8zQDJyzphmQHVrHPSh5C
   6Wu5bf954b+2QmDhd4J8x6c05Cd5Xo83DI8BnFxGn+QDS+ZNjAiZxwFt2
   xhEDK3PvKghFOqAtblUQ9MDGzQbxlJvlWM5sKgFF4KyPTJEkoHBv+cOij
   qN1pcK9XUY98+HnIZjvGWSJlsDhywUEzgBWyFpOwiIv7H/j1jSeeIYrYH
   vWcrQIgnEb++33upRpyIlZVwgKIMyYZTMPuZ1QPZsysyE2RDJmLuj4I4Z
   g==;
IronPort-SDR: 0Dwf4sDUqebxWLFD8yi/1OtPbFbf7xCwdPv9M6PoyIWztL4+AnTZGgda0tQ9tQoiJNFUtaWvdh
 QlNLtdwIjqYCzoiw2wQj+AuL+5Zj5zlIQeTX4EdWtigvZQHOCa9Po2JkGp+8pWU9aDlpYEWnZ7
 UPXHb6NdBLDkb/KW8BxKo7Ig/vZFXvqdi6JvTbPvloernJLcBTE16XnyUQz//r0Kl7+Qr4z3Nv
 JHiUzOMF0CFnQK1r4Jy6R5PEC/WXzV6DU7OUaXjsRKCZIDpjXEizbrlOPBq3Cbb06nEB9MPiol
 pYU=
X-IronPort-AV: E=Sophos;i="5.79,397,1602518400"; 
   d="scan'208";a="158984215"
Received: from mail-mw2nam10lp2106.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.106])
  by ob1.hgst.iphmx.com with ESMTP; 03 Feb 2021 11:18:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pa6GpK+U5SCrD3hcaX4KuLr+sx0MXUQZsL2GR4K729T003YqUaDydxM1ErbzreiCHK+BGs5HxTRiQy24fnrJaTMAV+d6MaGOLhspYT8Xli/CFLIOqCwc0dEMO9Q4Ltfe07qAlj46WPDFwy7M5cG5vpQXtzGD7MreLOrbqRlaIzw3WRihVVVHZPtR8sksJ8q4/GVPOpE2X9mb5Rh3FFwc0j+gVHTsaGM+x18YVm18tyF0FuYu5KZC9K12EzWO90fo0srEwWfbWi+ytBcma/puMaZMrg8EGRpLkUQtJfarIF7nGifzDgiLmNmklhaNc1LnslbAceZ06QxVKwxFWEjo4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YMQhKFtRtLqPjRV70p4EozidkO/ti34R32K5b8W4n40=;
 b=QVCXxVxdXxPWcaDz2mpaSzf2HJVco456puJNnLjv5C7yQaA+A4PirRTYSsCCT9NZybJB46DvulUZ/tedKqAwaQahBMjB6Qp7iu/CEiTsUl9viQ7CtxoY8mTr34lfzF+M2Z/nPf2XMQI+fW7cmuiboNBAcQQYF8DhzC1hunqgTXYBs9vcO9IDbOUtTlRk4pqWB4cwgLYwWu69iOlsfk5P0sNKfTTdUUcsWUg26H+tzIXdxIvjz6yEBGn4v1c5xoAW4yr+AD5ESVNGk7vsiq5R86qvAQK1lisxFKIkyebki8KBrYystdP+FYjmbIj/HmsXXdy4hUwvL3CIdsXUyWFAEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YMQhKFtRtLqPjRV70p4EozidkO/ti34R32K5b8W4n40=;
 b=C0amVrCr2X91XvlurfyvBKfWXuz44ccyN7jdT1aRaxTpOOu4NtP+wYzkt+vUcGOM3Z/Gyp6MXgrrEQ2bo6Ud4A86pseYIAfItpQD+bJJBvN6XAzuPfRY5b7ne8F7rTgAMnj/v4uvLQLljCGJbTmnU+wMrjPne9kIRS1cQKcnPS8=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4328.namprd04.prod.outlook.com (2603:10b6:a02:ef::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16; Wed, 3 Feb
 2021 03:18:48 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3805.024; Wed, 3 Feb 2021
 03:18:48 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>, David Jeffery <djeffery@redhat.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Laurence Oberman <loberman@redhat.com>
Subject: Re: [PATCH] block: recalculate segment count for multi-segment
 discard requests correctly
Thread-Topic: [PATCH] block: recalculate segment count for multi-segment
 discard requests correctly
Thread-Index: AQHW+LqCC5Q5kKmvR0+PLotT7t4iaw==
Date:   Wed, 3 Feb 2021 03:18:48 +0000
Message-ID: <BYAPR04MB4965B7146D107857EDCA9F5986B49@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210201164850.391332-1-djeffery@redhat.com>
 <20210202033343.GA165584@T590> <20210202204355.GA31803@redhat>
 <20210203023517.GA948998@T590>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 49c004f4-581e-4fe3-2dfc-08d8c7f26c49
x-ms-traffictypediagnostic: BYAPR04MB4328:
x-microsoft-antispam-prvs: <BYAPR04MB432865A697BD498775642DB186B49@BYAPR04MB4328.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SOfBH0bh0rQ3kBrmG9aiTEtQQo6QYmmv6a1SZQygBfRCYe8a5naPXbVeKzzGCmfsQyfWI8jprdzBqBCzyqwdA/sxm8jJvTHKZ27vhlLHiA8oYqowxI0HgCZUDIkC3s+M/y7fDDVO5Xlx3JxgYExG5Vg9RTrxv6DFNAO1dfd4dSdEcsQ8WtR81+F/Hg23ctTOLZFfJ3OKh+k91kRYoaYnqcO9ocOSMfQKjQXm72julz3IKzYz1TLWaqUkuHaTKOA/HIvSsFzRMdw/JW1EUQOCn5uRZLG+nnyrmjh5ZkTX4K5nebPtBfVSi6wC/qVYcUjvDQ736FcuYYAvGupZ+D4Wp1suQylsuZDUwFjGE7OLecCGGMgxWlDG4t06WTmhMYxH+zyS5AqTpBhn3Eveb2W+eG4WWRLmFe+/MvVSvQiPeq6Pkr3bI/kkhHQX8r/OyClp7Y4A1WwPsxOPgBBg0+FNqFtMmqGsyEn1VZm983jrCjWwEIcAKXTJpQExA1i/Hg88PHWKYzf5jBGB07WOfDZRnA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(39860400002)(136003)(376002)(346002)(8936002)(5660300002)(66556008)(55016002)(2906002)(110136005)(54906003)(52536014)(64756008)(66476007)(186003)(558084003)(478600001)(316002)(9686003)(71200400001)(66446008)(26005)(7696005)(83380400001)(66946007)(4326008)(8676002)(6506007)(86362001)(33656002)(53546011)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?uexuoMuK1fu2303Fq9CLeggn5XlQnjmIBpW88w3qcB9+G1mb+mjWCWKB3VfJ?=
 =?us-ascii?Q?JhR0Xdtjo3it20zQjJxdtaxJOtYIpu+2+2UGOX18371ITHZTvnb4SVi3/37I?=
 =?us-ascii?Q?LAfQc81mzOm2g9Hz774/qdFgj6oMA16C8UmR6s44Y9QzFbRcqRO0D06XzXWB?=
 =?us-ascii?Q?dGQPHglnnCTE6OV09SwgMUXPAOP8ZURzp37sPXIZjoMu7xKUGKOIMiTHRdms?=
 =?us-ascii?Q?AGQ5lXhlH/qgTzeHLn+OHNcjk0vrUuW8nX62OtCHz7Srs5+DZvnCFct3U5Wr?=
 =?us-ascii?Q?gaKHbqae7LVftnQu7HA5m4xMTsnDdTP1fDcAISGHq7oleyIH0x0BKQLbXJtr?=
 =?us-ascii?Q?jup294kQZWnpoolw0RAve8XGhlOYKvN48sfBh17NBvnNb/+3kbnSOd2MtNMA?=
 =?us-ascii?Q?3rp0/ZGQ36ayYjd8UAwfiHlS6abtV3rlP9/dp9pg2bpx1UJhEos+FEj9pRyv?=
 =?us-ascii?Q?TaQXdsQuwbjBZgyU5CUdeHXkUZwy7zIA7zuwImcmi4PVn7NBDst7CmRB8k0l?=
 =?us-ascii?Q?dvE4hPatQrAU7bS9lU42hQwl0ZPZGD0wxMm2y4cf5rb9G53mwTEMwAb4b70o?=
 =?us-ascii?Q?h3SAHWEuaONAbEGOmEBcR5SrKjUPt42y4ZiZ+fiZAxaVgyA5HCR+QBSVZpLr?=
 =?us-ascii?Q?wzQhXLbM5g2PWm+qw14ggCSlY7kOsNos/ArVIuGMOo8npj5vMTv7CIOp+SAx?=
 =?us-ascii?Q?SWGRzUhqylSgL2SWuBkRDsqpNAeCqU9ERjl5Mb8GBjc6jD8i+symchhFGpal?=
 =?us-ascii?Q?eSVKHgAT8g04sT6mLG5DLv/8ciCQ2PqEZB9eoquxL7ZZOpYAHRhX1YY7yhJR?=
 =?us-ascii?Q?hxpctgsPqPzJcQJKJ4ZOO8Gvj0PYnpkYArD0XFUIQ+yITU/bW5MTyMBfd8kQ?=
 =?us-ascii?Q?tzCI1DBGd0NPHJgZ0Lh2m9PoT+g+S0bPT6mW0IluEuMvaSWkvozZFw38yAVg?=
 =?us-ascii?Q?tOJXJugZ+MxIBitwZ/MfnoKeQGWgPdqWxjS4AsV0VZ48r1kdSBa8qfqc3hei?=
 =?us-ascii?Q?X+9hxSR8qqhfh7eLpgtZ9jm9SHax/7ajBbyvgCS3eoLcvfJH1oxmPNUGgkrf?=
 =?us-ascii?Q?XrW+VWbqyaA87g2OEuBbYPuiX1jYfA=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49c004f4-581e-4fe3-2dfc-08d8c7f26c49
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2021 03:18:48.4883
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VQ3hrzhm1xsvvgUDFIuGlJ/mSX8iik99w/bIG4GAaa4CGc4Gl+fxTjtZR9q5vRuXiAQg21kMXyo+G78lOtQSYwKt0+4iXo7nwoV/hNSXvX8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4328
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/2/21 18:39, Ming Lei wrote:=0A=
> +			struct bio *bio =3D rq->bio;=0A=
> +			for_each_bio(bio)=0A=
> +				nr_phys_segs++;=0A=
> +			return nr_phys_segs;=0A=
> +		}=0A=
Also, you need to add a new line after declaration of bio in the above=0A=
code block.=0A=
