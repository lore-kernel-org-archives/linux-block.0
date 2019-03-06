Return-Path: <SRS0=tltz=RJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F61C43381
	for <linux-block@archiver.kernel.org>; Wed,  6 Mar 2019 02:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CB6920675
	for <linux-block@archiver.kernel.org>; Wed,  6 Mar 2019 02:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BEMJh310";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="iw9bf3sK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbfCFCZV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Mar 2019 21:25:21 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:52719 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbfCFCZV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Mar 2019 21:25:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1551839122; x=1583375122;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Qk7ZrHakRrGvUEZmGOIVAkp1f7v8VFHzv8Nzlk2nMIs=;
  b=BEMJh310IkUnuTajFZNOFJ5XSBLb0jeA+jFS3MhJ0wK4PCcF1SGzo6Qn
   ffLA2X33W/gwYLZH2w7s48734QM7dhO0W49blnfpRFSzduDTNrllR5cu7
   6sf2mCJAjXD7pQzxHkzPCka7QAo2ULLpULoRvxr65Nh7lQYC17kna3IUu
   1bGEiFcMbqn1IJTk6uTWs5h1C4LSw9rjcbsl2Cl7BJ6DdxbuQ9ID6SdZY
   hWq5I5Uvb5eG5zzFZbM3jzBtGlyt2XyNWGgasy1ZLU8K6pbghaZeLJqR2
   9Wp/E8kv1rQka72Qdmk3GkUFIa5R2dia/PWxAfRU2QEAjL0nCrLKUH1qS
   g==;
X-IronPort-AV: E=Sophos;i="5.58,446,1544457600"; 
   d="scan'208";a="104128759"
Received: from mail-bl2nam02lp2054.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.54])
  by ob1.hgst.iphmx.com with ESMTP; 06 Mar 2019 10:25:21 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eM7+2q1Z4jMNjRVDH1kfpmE56hQiuQ6q+yv5DrD5zDY=;
 b=iw9bf3sKPnSQYdgfTFkekWYYhtllUYKW8X4ogkrSxk5kDDlqtOrbApuE8IFCIynFzO0iw8k8PDcc6uvYXICQTnOibwEwuoGXpg1R+SraePGuGXDEIJNlGgiCNw7yjNNkfA5Iw0aCAjnNOOz3zxXa72T3QutHEgaD9g0vUhQ5qTc=
Received: from CY1PR04MB2268.namprd04.prod.outlook.com (10.167.9.7) by
 CY1PR04MB2122.namprd04.prod.outlook.com (10.166.191.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.16; Wed, 6 Mar 2019 02:25:19 +0000
Received: from CY1PR04MB2268.namprd04.prod.outlook.com
 ([fe80::8589:671:2c8:5f7a]) by CY1PR04MB2268.namprd04.prod.outlook.com
 ([fe80::8589:671:2c8:5f7a%11]) with mapi id 15.20.1665.021; Wed, 6 Mar 2019
 02:25:19 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Yi Zhang <yi.zhang@redhat.com>, "osandov@fb.com" <osandov@fb.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests] Fix the failure case which will exit with 0
Thread-Topic: [PATCH blktests] Fix the failure case which will exit with 0
Thread-Index: AQHU0wQ4LlPqSjaLL0eRw/TFm5kt8Q==
Date:   Wed, 6 Mar 2019 02:25:18 +0000
Message-ID: <CY1PR04MB226890ADCF8445974A514A7AED730@CY1PR04MB2268.namprd04.prod.outlook.com>
References: <20190305033319.6825-1-yi.zhang@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shinichiro.kawasaki@wdc.com; 
x-originating-ip: [199.255.47.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 78db3b3a-ae49-463e-43b2-08d6a1dafa2a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:CY1PR04MB2122;
x-ms-traffictypediagnostic: CY1PR04MB2122:
wdcipoutbound: EOP-TRUE
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;CY1PR04MB2122;23:uKtzsIjRpHNfSzuQBRDsGE0C2n3p2F0oC6DN1b15l?=
 =?us-ascii?Q?3FmiEspQmOKlrI/Wq5ngb442PLGPgKgyipJwB7kobO7XVCIc8bnc2YSbV48n?=
 =?us-ascii?Q?JqyCG2kF9v4T6983oEp25kv7fCAnXzymc0yKD3hfuKUmkqnRp5hv6QrQvNaD?=
 =?us-ascii?Q?hMbK1aIqj8lvhap5ldzsm8n0BEYgHWj5xXal2ZntzZOFD74LBfGZ6rd+/gqL?=
 =?us-ascii?Q?EvuXQlM3r+xR36G7htqOCkNo1JAmD4hykcN0IH+fLllUntteTe6777PcrTRq?=
 =?us-ascii?Q?OgPFPr6ucutscL0R20r6jkGDNCFatAFHO/eMmX2bKIjSgoUFSywsaiWJIFYF?=
 =?us-ascii?Q?WhjBlJRPT9nxU+wG/SYBTzcuq2ou/ZRpPkI4bsfjlNdLb1iTBSMu4wQjNO8m?=
 =?us-ascii?Q?e4hWF3g1kRIvX4p/R5bPqEGFSHc0bG78fsz2aq7m8PpjB4S29GmGuDysOZ4r?=
 =?us-ascii?Q?7b3S5E07F+ALSEnpxT5D9hxJni9YN5ndbsrHxmcikVMbsyye93Tr5FlLW6+s?=
 =?us-ascii?Q?NwrqqoItgtg/Nr59d12ppAde8dHZiEgxGhlilhpyaZ03f2ECrHpYO51cFObl?=
 =?us-ascii?Q?WgdoHZhSQjjrr4b6lhgwoW5wyhcRZHxrQBLMpir72OjAJtzuydq47pNIKjKt?=
 =?us-ascii?Q?QyhUVp/yu8ZB7YDMRPM4ykG6VlNsOUoCqhaRVM6VoWxsdOzJoVtQst4NBy/G?=
 =?us-ascii?Q?D1gQOpNWWSAD7vY2gxtNQMN2AZ0vgUc3BqsWs5/V4HRM9ngIA0o7KcCy4/OU?=
 =?us-ascii?Q?Up7nkgJbJALzCruDnvpi4YF9xOto4q2QsiwoetPVxfjaAw+YjdzzthQ5elv/?=
 =?us-ascii?Q?TZ20mEaleUOI9TkxdX9DCalyWVU6yRng1ZpmYGtKsadLlbGsDrWXjrt8uuIF?=
 =?us-ascii?Q?0DmDKk8/oE9OqJgrGmVnzDfdm9KwTuQPBm3gFMiUYywVM/GJ2Dridq6HcZj5?=
 =?us-ascii?Q?n0QhfhsGLEvJB8p2lKBM1Q6klYqI5knbGPRh9EttweHYNgJFleDRQ6LNURMn?=
 =?us-ascii?Q?CNZ7OTD2Ce0e3sF1x6itXIN2wftXHJxBYyNYelKedPPyw0lV9zLznFbX/bnv?=
 =?us-ascii?Q?k066KIiFmyPeNChmU4/Kd5izRf4zy3FJoG/NA3vBSILVccZRsrHfZPDcnqpx?=
 =?us-ascii?Q?ucT0z+FKtZTalXiEUpb7rFT+PLqxHwKNjiXW1fMxeUpgsVKIhfk00OaiATQN?=
 =?us-ascii?Q?VlF9PhYiGC1ezZY/kz1ryOkDGE6SUJFE2JwLYwi2HdXuJAJqf0PCYbgxpt+c?=
 =?us-ascii?Q?OMvCf5x8cJLtaZJ4bE=3D?=
x-microsoft-antispam-prvs: <CY1PR04MB212216FDD3B2B28445B1E6FFED730@CY1PR04MB2122.namprd04.prod.outlook.com>
x-forefront-prvs: 0968D37274
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(366004)(376002)(396003)(39860400002)(199004)(189003)(76176011)(5660300002)(53936002)(4744005)(478600001)(8676002)(86362001)(6116002)(9686003)(3846002)(97736004)(6436002)(25786009)(229853002)(110136005)(55016002)(2906002)(81156014)(2501003)(106356001)(26005)(52536013)(68736007)(14454004)(186003)(446003)(81166006)(6246003)(102836004)(7736002)(6506007)(476003)(44832011)(316002)(305945005)(8936002)(99286004)(486006)(74316002)(53546011)(105586002)(4326008)(7696005)(71200400001)(71190400001)(66066001)(256004)(33656002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR04MB2122;H:CY1PR04MB2268.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: N2m/QtAx33FuunjVjmc7v4j6XgxTjacYSyi4aw39ud+V+wScoHTqzm15WQtwfVtq+r1ZF3GZhJaCl0T59NPqwHYQk9qYa4L7QHT3KKuo0PAoWCq/AveaDQmIBvynE48+9duG4mDCawGERRuXCnORQ/qr6Gq3vKCqrxxlyJhg8lpWqnpXw76McYQRCCBETP9So0hzW4ZnqT2POc7+BtpzBrnoizFWp9xRwEaJOPSqty854DnfnOHIV6Nobtzqcbte6T+WTjDF8d/t1a3zV3goYMO1USZS8Z4LFGHzWj7t/jjLtCsGxbr5+8BDEvyazpbkQEbJV2kws9SaRqZBx2EnXA+pM8tSJauTI6b1YbxaZR8ysyF3c8qkAxUtw9D3zuaJ27K8G4b65rniSGZDbXW7nLFirlnYS35naHsUM6XSbsk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78db3b3a-ae49-463e-43b2-08d6a1dafa2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2019 02:25:19.0128
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR04MB2122
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/5/19 12:33 PM, Yi Zhang wrote:=0A=
> The return value of a failing test was masked by the zoned test check.=0A=
> Make sure to return either the original or zoned run failed value.=0A=
> =0A=
> Fixes: e840e15 ("config: Introduce RUN_ZONED_TESTS variable and=0A=
> CAN_BE_ZONED flag")=0A=
> Signed-off-by: Yi Zhang <yi.zhang@redhat.com>=0A=
> ---=0A=
>   check | 3 +++=0A=
>   1 file changed, 3 insertions(+)=0A=
> =0A=
> diff --git a/check b/check=0A=
> index 819d8f3..c65270e 100755=0A=
> --- a/check=0A=
> +++ b/check=0A=
> @@ -431,11 +431,14 @@ _run_test() {=0A=
>   =0A=
>   		RESULTS_DIR=3D"$OUTPUT/nodev"=0A=
>   		_call_test test=0A=
> +		local ret=3D$?=0A=
>   		if (( RUN_ZONED_TESTS && CAN_BE_ZONED )); then=0A=
>   			RESULTS_DIR=3D"$OUTPUT/nodev_zoned"=0A=
>   			RUN_FOR_ZONED=3D1=0A=
>   			_call_test test=0A=
> +			ret=3D$(( ret || $? ))=0A=
>   		fi=0A=
> +		return $ret=0A=
>   	else=0A=
>   		if [[ ${#TEST_DEVS[@]} -eq 0 ]] && \=0A=
>   			declare -fF fallback_device >/dev/null; then=0A=
=0A=
Hi Yi Zhang, thank you for the fix for commit e840e15.=0A=
The change is required, and looks good to me.=0A=
=0A=
Reviewed-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>=0A=
=0A=
-- =0A=
Best Regards,=0A=
Shin'ichiro Kawasaki=0A=
