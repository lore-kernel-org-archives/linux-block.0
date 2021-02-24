Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B51C433DB
	for <linux-block@archiver.kernel.org>; Wed, 24 Feb 2021 20:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A29C460202
	for <linux-block@archiver.kernel.org>; Wed, 24 Feb 2021 20:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235605AbhBXUbz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Feb 2021 15:31:55 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:40449 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235572AbhBXUbw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Feb 2021 15:31:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614199279; x=1645735279;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=kjqYif1L9+eBY8cVMhpeSWubBvTNoIhscmrxPCYeTz4=;
  b=VgbBHXEAIK4xprw4KuxV2Ohvn1hDHj/e1ZbISoHHm+e9nmKKDkfINE4r
   UMsbgi/JTDG8NDtmHGoeCnUKQn1bkh+6vXle/UmymzPVMwGEVaL5AsFz5
   BISRFVZGxPQVyErPYUkQ9sJtlc68bEC/M/A3QjlD2vXwM2KZ1TdjbKUYf
   fTrdSk3PDFijIIAuIpsBHSixf+yNTJhyJKOT9wrkNtak4V6xv63lZKqMF
   EloW5K0WRYymjm7Qy47sJ4Vuja7rHd08Ln8qBQetZoWjr4fofJOTRgY2p
   nfB5kEMvVInEA98J/h0aNDUTkMeHM8d9grqItxBC4fQtwHL3x+NPrGjkx
   g==;
IronPort-SDR: o9JVJB6rc4xADilMcLggpf4taBDCvFzFeDMryVO/KcCEWRkpLLhhXWd1CPeJD4yOIYTZV7JB2I
 C/euvkMYqkCsMbzldZlMqvc4OvDP7XGv6dKgGiTk5Pcf9shHooIW4mxGKiMK5RxekUg4hq4r0p
 zFlXpqmFLxd2cNEoH5kI63t57M+Wb1BmLKZJF/6plD9U8Og4R3X/Ssht5dqQojoc5bss1/bThq
 whAYdfyQiPS4Kpy25P0tzVS7XXHkittJ132GXAbRI/Tt/GHV5P8ROQ1q7/JxBkJLMIkhFGDcTG
 jrU=
X-IronPort-AV: E=Sophos;i="5.81,203,1610380800"; 
   d="scan'208";a="264938602"
Received: from mail-sn1nam02lp2053.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.53])
  by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2021 04:39:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T3rkFrf/iefU44mYChlWcPeBw/HEu70o1iYFdWkoQ73zuQhfczgcq5YrVggFkIARpG7CzxNJRX5Aa81scwWZIvQQzsy7KIo7yheHlNj+UfQcOQMlvyEm4SukQkuJkQeR2P0wM9EDumWlzZ1ujcYhCicdc2hQY58knwpnI+UOwliQpAbRWeXfDdHDAh1bzM2M9hYAyyErn42EP7bPuNS6j2z8wh8mV3JNR9z3ziLdVDAoM+Po/OBB+y7m5c9tMJ0W8lSskV9VClSEB3bafdNyva5onVddu3ujZFyVvi0/kIbu2sdlNmNLjqhrPOTdyx1+QWOCIyA9EwGvj++p5My5lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kjqYif1L9+eBY8cVMhpeSWubBvTNoIhscmrxPCYeTz4=;
 b=HyNRMoj143UuDCSEYQXkSejstctw0jUq5+Xb9qgnLFAs3nOb4AkQnovQKwIlysMESkZsf/OkibPHz5BV7QqFu9hfRSfIZ/Rlr182t1Y0VY5uR38sKmFnDec3lo24rOvrNARcsP8Althf7xOQ9Kz2p59oHm429PhufR5QH9Aii9M/CEF+PyJoH0s4KWYgXrrv2GQ5voV9RkpVilJ2NAG/TFt39wGoV9tF1kDtnQ9V6sP8KWQ/yFqfMfJTSzWHQCnuTMOXf4uAHCmyWY3HTTpP8BGIjq0KC/R80VMWos15YyyWgrj9fqxI2G2re4MyFIiDbBnTBM/YgaA9RBAgFcyx7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kjqYif1L9+eBY8cVMhpeSWubBvTNoIhscmrxPCYeTz4=;
 b=Y+bU7h0LtULs1WWqBGt1fVsrOTDz+gz3OeNbX3DtQAXw35h/hFwSG7GG2ODBvuP0W5KFa5eZ8LcHVR96Uv7ncYrNiIJCHgvWx/3lQ5zjkCuMt1WUQBkNPfqtE7CMYIMfwKj2Dd7L+k+3OPfLC/8frectdSk9fumN/PwdJDIGOpM=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by SJ0PR04MB7550.namprd04.prod.outlook.com (2603:10b6:a03:327::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.31; Wed, 24 Feb
 2021 20:30:43 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 20:30:43 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Jens Axboe <axboe@kernel.dk>, Satya Tangirala <satyat@google.com>,
        John Stultz <john.stultz@linaro.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 3/4] block: remove the gfp_mask argument to
 bounce_clone_bio
Thread-Topic: [PATCH 3/4] block: remove the gfp_mask argument to
 bounce_clone_bio
Thread-Index: AQHXCn7U48Nx50plU0ST9Pv0yidDRw==
Date:   Wed, 24 Feb 2021 20:30:43 +0000
Message-ID: <BYAPR04MB4965A09C5C57BDAE6B27C98E869F9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210224072407.46363-1-hch@lst.de>
 <20210224072407.46363-4-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a489f62f-fe01-4340-bdbd-08d8d9030f51
x-ms-traffictypediagnostic: SJ0PR04MB7550:
x-microsoft-antispam-prvs: <SJ0PR04MB75506EBB33EF4358164B0483869F9@SJ0PR04MB7550.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:510;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EFWYvpRLH6a6AVjOAkWMy2quNKX4G/qpMsxQUG3RWL4ghrOmE1PcjmPG/K87nOrLroGFxuWKxFrS+mvpV8KBgtno6ZnSEM2Oi/Ifm3HxX4/9H0Qp3ZcHxetagERu7x0BeHrFVJxB/0VLI+rPiwEnptwf1DoX9jmHyebJ9g17Xwa1RnviQYzVo2+taIXWk49sfIM8Maxg/f2o1h5bhcoczjQIJJNKfhCbzMvRtqYzHnEHMHBn9/KFp8403iVwJKDiuL5845ekbBXJrWr2cO+mlyTszX46GO2UdkNH6aOzCnCXTz9duHTfupwfot4Jd3kb2mdeew3kRPR+YN26FHfq+8ZijCSWZtdLtaVuaftmOXUTtMbQRoyxHxCKZbAb9KaS5ZWoafKHuxLcSQa4IVNpBxEI2TFLaOAQO/WVCwfgFcwnIzps7phOFyyBmSgy3Gule4RZWKof5aEfs62KgsP9j6qlXNpgrH5wBW+9D/l+lmiQ74qcCz3mnTUzrNftlB8tbrhrO3mGqAt1c6Q0Qw55Hg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(366004)(396003)(376002)(53546011)(86362001)(186003)(7696005)(4326008)(55016002)(9686003)(6916009)(8676002)(26005)(8936002)(478600001)(71200400001)(33656002)(2906002)(52536014)(66556008)(6506007)(66946007)(5660300002)(54906003)(316002)(66476007)(64756008)(76116006)(66446008)(558084003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?XjxlRHB5tUTA/v824j0E958yKO+759R9ctIDj9yYxPkrUVhu0ZKXpGKh27AW?=
 =?us-ascii?Q?0qN479cXILWywOuBgMA2zgvrrq9bj9KmGLRl0wMWNfBphtbDW8bSfUCWPLRS?=
 =?us-ascii?Q?9v4YBMj54o+C/r0srSsbRzZsU8lqoZe/+uMlGVlhqru9C1YyI5o4nEuWlO2v?=
 =?us-ascii?Q?JZ8xQTG8yMygzi+sNkNXG1500OkSAh79oEg0iCwCq0NaCr4vqRs3SEuV6dsX?=
 =?us-ascii?Q?02lwCJ2ciKxD/qJK9w/hqDJ5D7PsAi0/PyPY6e+xu9jU0McuwCKH3DOyJPzQ?=
 =?us-ascii?Q?1EMROjjByHtzSbTvYcNyOw1hDgFJFaY9jXGZTDFFXJCERjf1+IQ8Kc/g1c7/?=
 =?us-ascii?Q?ZRoTp/4RYciAqGw6l8I8hhKEbSavZd3iQ3wSA78lply2zhIfOIgueedgrLaW?=
 =?us-ascii?Q?KooVY1McPVAtN53/PKr8zcz2xYhsUCWb9hxLS0zRcsk/o98KezBTLvZM/zfl?=
 =?us-ascii?Q?/NuxIRdECwFMvzeDRZl+Oq8WkJXMHabbTlTStaJcDN40ok51k280eA0gX4Q8?=
 =?us-ascii?Q?lH0AXNXytSxfHi/F6FfNDCcOuiSiMhJpEfTYlevW5Eg+raPiIQde24KBD9Af?=
 =?us-ascii?Q?6HYKvIB6t3IpcoJm2tlU1FExzdQ+nIe9beOlv+f02tXmZA/6CtprAbGTXvao?=
 =?us-ascii?Q?LbU25r/SK8q3EZb+cTQX+SZKG9wWmnIKJbBbpOPakCDxs5vWGTNSmuCWjmkG?=
 =?us-ascii?Q?yVywomzX5hZd5GytEj69oj2s+7yUUMwu5sZTLbIzjB2C84KV/9UIy0r98dcR?=
 =?us-ascii?Q?k9RVzwrQj7x2Kc21zWkFluZhtXNUrXFmTY6MuxMnorvcLkerI/jHTe2BRq86?=
 =?us-ascii?Q?gy4/Y9Crtoedz5VATcUuPSdCcNP0MBPSsHFieTUy7zART9s1TUeqN+lBfH7b?=
 =?us-ascii?Q?fLulScSnSbmr+FvYbprvgSYOWyY1TYuzKKZwkNCe/IuUA6vHfhRlIlaTU3vy?=
 =?us-ascii?Q?+Az6xO0yBP+MVeM8rIoyS0X2n937wRCf7xT3ti3CGdhO07UaTAivFd2M6nLh?=
 =?us-ascii?Q?p7lHCIEZ7p8bQH8ymyo1CnboVqNxNQPY8ctFvzNwsfBorF3DEJvANe8UBjsw?=
 =?us-ascii?Q?KgU2osc9Anie59J4dbcOmH43FQ3XlVnYaMoHDWoVGA6tfsBiUY+gfPZtAMak?=
 =?us-ascii?Q?h8dB0T2DorQazX//8CFmAo9Jd4A5B00MEOWUfb9rWJixUR1i8O/V93L/LJ9g?=
 =?us-ascii?Q?c0EWQAFb9lOqnjc9n3WCaj4Cl5kFJWZdPxs+KMqyUrlfA2PL8lUiaoZgPI2k?=
 =?us-ascii?Q?CW+7GQkbHW8nqnClHLl8XXwmo3HkkE70n20jEZZR2K/e5hlGn+b0iXDpmNCZ?=
 =?us-ascii?Q?Top+Xa70N9ee9gJzTQQJ98fQ?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a489f62f-fe01-4340-bdbd-08d8d9030f51
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2021 20:30:43.6760
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mhksu1DjQk+PpzCPztG+ZGK8sxd/wKmRIMsMlV/a90gXODAYPYO5jmv86eQ90HBOzsvcIt41ZjQpl1seebmzQhHCmI7/f9IGh2D6Zd8fj/Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7550
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/23/21 23:29, Christoph Hellwig wrote:=0A=
> The only caller always passes GFP_NOIO.=0A=
>=0A=
> Signed-off-by: Christoph Hellwig <hch@lst.de>=0A=
Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
