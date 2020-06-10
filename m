Return-Path: <SRS0=qLys=7X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 978FFC433E0
	for <linux-block@archiver.kernel.org>; Wed, 10 Jun 2020 21:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68208206F7
	for <linux-block@archiver.kernel.org>; Wed, 10 Jun 2020 21:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RFeYAJ09";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="vdyrsWYC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbgFJV0w (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Jun 2020 17:26:52 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:4942 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbgFJV0v (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Jun 2020 17:26:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1591824413; x=1623360413;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Hl3AQI9DgIMm9b2y4nEqXoCBRL+hvIYz392vYmWTmGE=;
  b=RFeYAJ09MWQYsNFTCuDOWyLj6oGErvEtLAUwGxtus/gwhhuy+bPqSoG7
   PfcaUd/yJkn/NB2rjQYDKpzZUG6dNrzOIsPmt3Gw5Fql9KwTh10YxSxLu
   vbEj0BMuIBkWByjRr4WVpqCrnyr/jk+kAR51ANQHtdrlwuRCsKT2ksIhx
   lSbyJXXiDnAbGxo0M4s3JM3hqSZTeNQ/NXOExH1N0t+LRf9+4IeN2bxRE
   gll6prU+PiDIWd2MVJ9akGostsIq6LJeJ4kTvtJLnUVN5+oQl2g8/fI4P
   cI7fS5rNO4ZQVJErwKwoDvDfYuu22Wg1C6vBBl+bVtJEoA9Hwim+bGQLy
   g==;
IronPort-SDR: i8CIa00Sl69Zd+qn2jRbKGl1YtNDO9dEI2nl33A1B9rrbdvi2jvtJohU05Oip8PpOLLlxiLEII
 IOOEysSwHilzOrIPI6OrDydUU+j0/KmCTWcdciDB++ciUfYCJ47EVKSHvsRplfbg4wxCVRnOqD
 j8K6GWNzaCrb0ej6x1BPQGVLcXT0fleilX30VVubXomB22jNuTR0chI//oWkvElKJRU4qZsbR1
 LIwqytvYRpf9Zw6EZK/fsUzFFpq/cmXfbgWYX4g7ixE8Ljm6LYDUwcnZEpPOopXwkPJlCpeoZT
 Z64=
X-IronPort-AV: E=Sophos;i="5.73,497,1583164800"; 
   d="scan'208";a="242588143"
Received: from mail-bn8nam12lp2170.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.170])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jun 2020 05:26:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WIMlR9yKULnO6KnZe7KQdTSKgtWSkC1hO3Jns8samKsjGvE7Wou6PHQpAd76ToR47h+7NmK3Eyk2fT3fOuiGVw5pRYMfQiZcOBA41GKfoAXPIJscNgX5cN05bTMA5XvLXBKHK+3AhcbPz6yQjiLikelo9cFJ3Wq6q82LFPYwyc5gq/jWrZ6xsULtRDvxqDJoLiefaFbX++2+j/NxQZONKZYtgZSZddPPRxWTsftCnHlA2iUQD2dUT1SEihWaF2t1qVoI2c9iF5xLzJFyo2O0bSfIiHKKEOIgjaD204LuphxrIfbH6U+cSfcb+YBIjJaIp+5aB0W8/jjbqi+fPNQ8Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mU3n3xynAQWfQUgmpUz2BDIKpLGlvAG88bMYXezCB4g=;
 b=Nk4e6Y/JuQoj3Hy42o0FFrfq65o9HRFRRcyIMBGowMn3BA9mHvxBSCW/tf0ndDw3XtxyWDtj9O7ZS+/x2UVIJ+IN5ovFzZ9Ghu+dky6H9zLRvanp9sAsVmsexxvFM/aqX4SRDOFLO5gNkbckUrHEv37+6wi5sKJkaNUB46OkpThzmWep8+LrtFS3lIilgBAkeoDdqlfWqBjQnfu1Ey0rgM5/piVRp0guHPs8F7dDtG7b7JD0SRPM6STfUz9r2uSFKOxrej5KQAZG+fUh6pP+gWIbRyZfxpGUQlfZ0zVHiuEFpuWjvn2Kcxo5uyrixuFVPaq/N748LXqhMEsbvaPI/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mU3n3xynAQWfQUgmpUz2BDIKpLGlvAG88bMYXezCB4g=;
 b=vdyrsWYCKZoCtO/G9Ra14a3DmQ+X9LxZF5qj5xEfwibY4WHxxR+YOiwv+FZNpZACaFfjsM3hGDHCa+cYK4YXnZzwJ8Jh5jD+G7o3L5bnD+VY/j3ix86ZCq0Y4POM+1dhGV6DSLv733RFfP+uREKQ4Ayg31C+IVa+wlRRHa4bXaY=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5030.namprd04.prod.outlook.com (2603:10b6:a03:47::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Wed, 10 Jun
 2020 21:26:40 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3066.023; Wed, 10 Jun 2020
 21:26:39 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Omar Sandoval <osandov@fb.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests] Restore support for running tests without prior
 test results
Thread-Topic: [PATCH blktests] Restore support for running tests without prior
 test results
Thread-Index: AQHWLscbQEnadkGKnUSS0ehHw221EA==
Date:   Wed, 10 Jun 2020 21:26:39 +0000
Message-ID: <BYAPR04MB49659F4FA0DC57D49E8D97EE86830@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200520165241.24798-1-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ed0feb9f-ee1e-49b4-ad44-08d80d84f6c0
x-ms-traffictypediagnostic: BYAPR04MB5030:
x-microsoft-antispam-prvs: <BYAPR04MB503060EAC808F50E9E5D43B086830@BYAPR04MB5030.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 0430FA5CB7
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FLqUZTeqM6UIwpqiN6X3p0Hbz5kY7ox8ihznTaRfS99xDJprsQ+62HQJGE8OqSnWmNRsoVAF+usUqIQ7ckRhyS+hZon4KJ+BXwZmKWPSXCIDmjanpM1J7Ywsl56a8I5tTPeFi1mriAVJFK5Nvpdk5degbzDakxlzOavPaVz1qsS6RPjyS6ukthNE0K3fEq+jG7TXpTKy0SAIbHUTdZYah0dGyvornmnWvHKFCtM9kZnyPUKk+GPEW9J/g2THlam6CR6NB/zRWf5RmcrLnapJyVces35+vwvsU0yz7tNi+XVnXC/260/SuKEAAPz4RZOZZ1f8iIfaPV6D6JVgJyjiSQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(396003)(376002)(346002)(366004)(316002)(4326008)(186003)(55016002)(7696005)(9686003)(8936002)(52536014)(53546011)(26005)(6506007)(5660300002)(86362001)(66556008)(478600001)(33656002)(66446008)(2906002)(76116006)(66476007)(64756008)(71200400001)(66946007)(83380400001)(110136005)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: aXXsfUxg9ZkYi9rzAkNqLI3lkgoZpzcIiSY6rWKd0R4s0CsxjejWA7Z9ifQDatLf4JixEIp85MHF4OiKCFXav9u1XoBnWNOraOxw/gZYytOSXHRTZkHc4c3gTokde7zWY6UoGWeX915O/6hDAQ3w8O2N27MJjt+9c0cIsyc7LtygofcoX5rNxTNLSaJGy+noN4VSpfZ10FdPzparM3jRtI7fb2w4tTo2OBqQD/GDSn14XHljGuxtIxXYOwzWYkDbvJSCdtK46xIEXGyx0Y8FvsRmgTtMmD3D/gPV/WH1b8USQqVIWALBdg51/NENGzZGnEl+QS6GJsaBuB8R3jQqy4RiPzgzcivqzwQS5Kv2Mxs/xggMo6wdxqTLo3cUv8SbCjNb0tonmlkYyLSwqMDbDn8eb0I1tfbWgJHa7hC76pZ//OjtRCNheG84y4OQUtPWX04QGZv97pbv1lYzdYGUBVt1cMW2UjTi8O2iyRy30yI=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed0feb9f-ee1e-49b4-ad44-08d80d84f6c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2020 21:26:39.8012
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yDD9Wqf1G3AtVn/txUhADDoSxoqjEaI5bTdlUQ+Gi7qj8+S1P+S2On5/Zg4ZrOtEWf6xfpNDwvxdm1dGC5atfuquddC1TPkEUUBt+zEhQWE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5030
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/20/20 9:52 AM, Bart Van Assche wrote:=0A=
> This patch fixes the following runtime error:=0A=
> =0A=
> ./check: line 245: LAST_TEST_RUN: unbound variable=0A=
> =0A=
> Fixes: 203b5723a28e ("Show last run for skipped tests")=0A=
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>=0A=
> ---=0A=
>   check | 8 +++++++-=0A=
>   1 file changed, 7 insertions(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/check b/check=0A=
> index 0a4e539a5cd9..5151d01995ac 100755=0A=
> --- a/check=0A=
> +++ b/check=0A=
> @@ -240,9 +240,15 @@ _output_last_test_run() {=0A=
>   }=0A=
>   =0A=
>   _output_test_run() {=0A=
> +	local param_count=0A=
Is there any particular reason why new line is not added after variable =0A=
declaration ? (I see that check file is not strict about that, which it =0A=
should be to start with).=0A=
>   	if [[ -t 1 ]]; then=0A=
>   		# Move the cursor back up to the status.=0A=
> -		tput cuu $((${#LAST_TEST_RUN[@]} + 1))=0A=
> +		if [ -n "${LAST_TEST_RUN+set}" ]; then=0A=
> +			param_count=3D${#LAST_TEST_RUN[@]}=0A=
> +		else=0A=
> +			param_count=3D0 > +		fi=0A=
> +		tput cuu $((param_count + 1))=0A=
>   	fi=0A=
>   =0A=
>   	local status=3D${TEST_RUN["status"]}=0A=
> =0A=
Overall patch looks good, I've tested it with nvme group which works fine.=
=0A=
