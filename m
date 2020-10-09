Return-Path: <SRS0=NSF0=DQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 051B6C433E7
	for <linux-block@archiver.kernel.org>; Fri,  9 Oct 2020 09:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85EDE2225A
	for <linux-block@archiver.kernel.org>; Fri,  9 Oct 2020 09:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=permerror (0-bit key) header.d=wdc.com header.i=@wdc.com header.b="kwk+MOzY";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="voc6rTsK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733092AbgJIJeN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 9 Oct 2020 05:34:13 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:32834 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgJIJeM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 9 Oct 2020 05:34:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1602237016; x=1633773016;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=i73cQScyOXtQNhKCgBM0j0yco6YrKjuowVHgFUDbKic=;
  b=kwk+MOzYhOHmcP6KNFJYefQln1UMfKXVS+h+YoLxxbaZqw09MRK54GyS
   w8VDQx1k5yP9eBhzyKK7ZU1c/f6liTfkHIuVCHuowaLPYzK7MH5iI4oxB
   APO0mbXhFk5kAAIRmC7dTryqc8Iu6ezgBF9Kurula5oIhWFqk6gq/UOu6
   USEKAsj8Pj/dAchqRLBfTP6D9aRsIpf87AEQ8H+MCcPq8Kjs53fcFk7h5
   b8hUALYRHKxW7jsJipQ1JDVrrwCF7wDhJOexvxbLtfKknjzhOdc8aHDFG
   VcyZJubEZlij3YpAcrChN81kt9d2EdI9ZV7FUabjLc77eoMcKeTBY9Xta
   A==;
IronPort-SDR: geBgiqVNn3VmMvRYFf+fzTG3RUcSw8YEcJ6+1v92DrouvRYckeGmcq4IQMZ04T3htgStydrdGv
 sWmJ3HBYTp7oeMpaaudKkftUz3/AykZyVD6zTYPWtVyPUUuErxAIoliMDrZwYr7dxE5s2bE05x
 es+0Ul0ExzLuXq8s5abyAE5AH/UeKRCHTd/OtIgqfDG/yX4PrEKHBQajz/TzNz8kXi59FhTw4W
 tDloscvAgSkSgJIWDEvBdYUUQz0ZcyceQNUaURZvcE+7B0kd8TuKAvVyOlIQNEEbqLDNria/Xr
 xd8=
X-IronPort-AV: E=Sophos;i="5.77,354,1596470400"; 
   d="scan'208";a="252894242"
Received: from mail-bn7nam10lp2104.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.104])
  by ob1.hgst.iphmx.com with ESMTP; 09 Oct 2020 17:50:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E0MCx2PDkKF8/xHrraIeh0x758mVyOHtQKKD4p13E4txpo7wmt8wQq7qCNr0InoqQTrBPkHHTXnGCLdk56s+oCMtMdfPI04cRYF7RpY3X5v8gd2jvcPfeTDS+2CHDqTnoIqLYJOORNeLplfpLY3VcBkHJRH5jPFAGnDNBO6eoPHqns+qLb30eK46IoUCEkFha0sKS1vagdSAyy/BMW8LvsxqEOYcap7YwYKxowwH5MrzbruhjsIfqG8TP+Ei5qeh9O4iHSHxOkDK1AnpAcfWMbVT+NCq5Z/bx1x5HzpwrFUSx671bKo8qLmu/X8pM09Bo6lm3EWVkvKvLDWSYfredg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i73cQScyOXtQNhKCgBM0j0yco6YrKjuowVHgFUDbKic=;
 b=a0XcckriO4vhu5cAd6vGUIJRXa8fWfZsKaHelgZ0oEfdzfXf4WRVtYO9Lr0AqKKnVkMZ1uMIxxfQkITNkBhunTOYjwjyxlkV6/It32kBoqUSz7JGc0CK+z99dDuCcAnITs1is0mheHihPueU19e2tmZwGYub5ypkqGr9cwW7Yg99jYv7FRJdYA0agf0dN8aPB/5u5JZ4Gqml7WNQ6dejB5C6bfnODLQc3eu0fSkUah1R2yNjwBpG+T/JF4urOmy6pP/I+kgyv/il+OtDhTzMc3niFhjtRDSuGv2fR/duTeMfkXAfKxjJafaMFzKLl5yGUJZuyrAiKvZI/AN6NlUjRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i73cQScyOXtQNhKCgBM0j0yco6YrKjuowVHgFUDbKic=;
 b=voc6rTsKg2Lc8pslcrNlvVh+xMZvF1ikJ0m69pjMaQ00fFtFBhc1vM9VhK4ycJFFrHGbzrr2R+sXadKPI59gGL/gm+HW6X5VSUpDblzUtqTXtdLDyZosSKVXQhEObBoWUHRsfQTRwD8CxWHVeJctNgP5XZpcW4Ex35wNn6CAHGQ=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4239.namprd04.prod.outlook.com
 (2603:10b6:805:36::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.25; Fri, 9 Oct
 2020 09:34:09 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25%6]) with mapi id 15.20.3433.046; Fri, 9 Oct 2020
 09:34:09 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] block: fix uapi blkzoned.h comments
Thread-Topic: [PATCH] block: fix uapi blkzoned.h comments
Thread-Index: AQHWnhuewAKFP8latUS+zsh9WqKxtw==
Date:   Fri, 9 Oct 2020 09:34:08 +0000
Message-ID: <SN4PR0401MB3598D9D5FEE6FB83ECE34E089B080@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20201009090714.285968-1-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c977b2fa-c0e7-4c44-2056-08d86c367944
x-ms-traffictypediagnostic: SN6PR04MB4239:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB4239C375B7753D7745ACE95E9B080@SN6PR04MB4239.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fksp6UL8oc/JFvgEGMHeP3VYPD/AJ8+fY85iKc+MS6ZOfgiwLee3+ksb8nF7jxp3QhHqMKmVYlfTpJx/jEDwuLlYfyDx60HemYdkERZd6sHxUkx9aHj7HQyGnSGATM50NRcmq2Ah8vvjt6jpXHxaaOIvrReobRafrJpslMnE13XSG/ZujngjN7sFHh4lLQrH7l+Gq3ykdSG+jGplqSJl0XRPp23lg9b9lHcpiWR1c2I93Nu84ivIgTV0Ij2QWCU8AU9y4bn+xhI+XHsLN0vfNJ2udAPiSVKjbXM2GDCbZT7X08LzFiTBupDSM5ITQ3SETv2XQDuMtNC/Jr9eRRrT/Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(39860400002)(136003)(346002)(396003)(478600001)(8676002)(2906002)(33656002)(66946007)(71200400001)(19618925003)(7696005)(8936002)(316002)(5660300002)(558084003)(110136005)(6506007)(76116006)(91956017)(66446008)(9686003)(4270600006)(64756008)(66556008)(66476007)(52536014)(186003)(55016002)(86362001)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: di0JjRXxhh342Y+AK2o0o2xjtijL8NLNegn4PtXT1k5DHKbsbGVKchidWfVkpWwr4vIWD+bO8e7LfmoPfUUoG6HIK9Fm1piP2fjTLljpDnTfJEfhif6bOub1OlnGTzsKx122Xe5iOukptMo08cOtU+9mxX6jWrFyehBuixPjsvmV0VD9OcibFiYKQv+fvn1lnwZeJYUiYtBXi9ft6xll0p/j6oyjVB6cmqnRT6AzDZ33mOqmp2NyB/UOS49Q0HSRp+ecALWeH5HEAwYeN+JjBHYSE/jYUbND5EWVt52NuOI1x++1u5wNeoZQaVh5wMgLtqjCkkGhLNxvW7McDwcx40PlBZ5fC/LsrM9cm257iEFHNq2dIuNTPYbY7lR5Q3g0W7FJkA34VRsn/N8F9VjkWFC4kMv8r3690uHIGNRiZqZrpYB5dvuscTkoDjuGzXbxtKce4SPdSQYddFPhSPg+1wfI9vaMZ46VS9Z/HHUlTs9/ABFiJZSHd3gtYzzeWQlm2sxj5CNh/mnlsyVyK+yXB+ewkaCyeckbieE5BzOB1qV1DM1s/HhEcU45ZxMDMJnXyfJEi5D30emCGnXa47qgGosImTkaXZsGXF8IO8ik2rRf2uYjcg6q9ETRFhVnCrFp8L734dP7Qq7ud8cqAsk0zA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c977b2fa-c0e7-4c44-2056-08d86c367944
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2020 09:34:08.9817
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Jzmtzc3fqHWHYDl276B9Fvnoga56Hu4EetsMFcIzlHMbRj3ldkGyCBDIML0P2qON2vdpVmeQwlSAiYgKJe275J2LLSH4tn9B0iNz1Lc270=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4239
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
