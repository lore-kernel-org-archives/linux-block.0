Return-Path: <SRS0=89dG=QE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A706AC282C8
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 10:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 632AA2148E
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 10:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SYh7cQ25";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="c2pbaiCH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfA1Kym (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 05:54:42 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:20367 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726611AbfA1Kym (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 05:54:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1548672883; x=1580208883;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Ud7TG3ef/gqUZ7ZBGpYwFhUZePA7WDkgyQ/PtcbZL5w=;
  b=SYh7cQ252Wu7KGMps69efK1t80Ucksu7s1tsRgu9c1S4KoZk5ioPYiID
   KygUct2BZgL+kJngWwDp7KReaA9VgNay4Puv7hU/ulzpg8J1VYgfMNxsS
   yFpWQAngk5bJej5aihMrzh0JBNC8q0q9K1rVa6QC2j8eWIRPC5oRF0VOI
   K8NFYDoT8haWU9tLKzKisZAn2E4cfggtOr5lSIpM1jeBHceuZTxf2Ecz6
   VWp4UMV10NiTeTVBSAW0i/YCHDRZOGRhCRx3VejO3h4ZXxG6pzB6mr8gy
   D0Z3iTk2tYYsI32VbnmJGWFDmVpBJmyuoOZxShEaJbQpO5wKjhXAf/HVN
   g==;
X-IronPort-AV: E=Sophos;i="5.56,533,1539619200"; 
   d="scan'208";a="99934808"
Received: from mail-sn1nam04lp2056.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.56])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2019 18:54:42 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rqeKny/ymYu3VRmjNnJCe/yuUY8WvqFXgXbeuF508oE=;
 b=c2pbaiCHApiuvfovdxKE51o7aj8yyQ3Ze2T6xOqJNzZLYHrErNlx9BVPvrCsBRZPArk6448zj6FZqvAxLblxp7ElknPfP8usxWKP032cUVlcloLiUCOGy9UvRLPv+9AK5onrYen1ROCX9QF7R1qSloPGPDKM37R5gt8Rw7hA9OA=
Received: from CY1PR04MB2268.namprd04.prod.outlook.com (10.167.9.7) by
 CY1PR04MB2330.namprd04.prod.outlook.com (10.167.9.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.17; Mon, 28 Jan 2019 10:54:39 +0000
Received: from CY1PR04MB2268.namprd04.prod.outlook.com
 ([fe80::9431:bb6e:5c5f:ca67]) by CY1PR04MB2268.namprd04.prod.outlook.com
 ([fe80::9431:bb6e:5c5f:ca67%6]) with mapi id 15.20.1558.023; Mon, 28 Jan 2019
 10:54:39 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Omar Sandoval <osandov@osandov.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@fb.com>,
        Masato Suzuki <masato.suzuki@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Mike Snitzer <snitzer@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH blktests v3 05/13] check: Introduce fallback_device() and
 cleanup_fallback_device()
Thread-Topic: [PATCH blktests v3 05/13] check: Introduce fallback_device() and
 cleanup_fallback_device()
Thread-Index: AQHUrxKOmRiu8u6XIUyrQXRkEeFunw==
Date:   Mon, 28 Jan 2019 10:54:39 +0000
Message-ID: <CY1PR04MB226816BADD703F49533F557AED960@CY1PR04MB2268.namprd04.prod.outlook.com>
References: <20190118094453.13773-1-shinichiro.kawasaki@wdc.com>
 <20190118094453.13773-6-shinichiro.kawasaki@wdc.com>
 <20190125211401.GD26739@vader>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shinichiro.kawasaki@wdc.com; 
x-originating-ip: [199.255.47.11]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY1PR04MB2330;6:oEPPRC4Z9Bo7BW1IoxCV8vBI08UAi9P7nRwv6sYZXUknLQGazY/Z3+j+Wo95XamPOwHC1LVlDgin+9gqSbyOWj4hlpwCzUKTC+jzA4/ZZU1iYYp33pOV77hbDhZn8/Zhfb7qRnRPgY6j54KtaRsHxkEiKstHP+NU3G84/pBPssNQDpLLw2/MG8i57UAJK2jq+fAqY3F4AMyr5NEH2bVjDdN0eSghKU2aP2TQXwgFA2OITOuTN+Mnvnf3OwUgbBSw9CLFefYEB3UkaPkwNIi8WV3MGBW0ytHT7I8Rh5KX0SUVJaBg2vT0hvAX+9JsveA2NisJZPiCXRtxlSSn45QTodbHoQVQ3GzXk2vctmn4vi/MbEzp7efbsZ6XOJOd6u5rwdtXbpILOyIuVm78tYSH5/GG8GsLapHy5iWQNTaOyeQ0KN2HyWSNQmsHhGWIEOYJQq/G/kjM3tqtB0QP3lJUVA==;5:oky+ZcgH8T9q0pJ+oFlnE437t1GbaN/8eMf8NArJmUdQ5j7q4ueDSniDDMfDfB0AaCe8bIEbJchGClfd05eQKttm+g09ZwE5sZgCcHNV/N3aTCsZvJiu2YIzTYoF8aj48AymcvFZ4m3pdENpTYqSw+gOz6pbTtIqKhsRe1FE4UcbbaU8oEUYSjtPvrKbYVY0HzhMkkfnYfLm5QsYv67kqg==;7:mn5iV7QrSUDpb8R3NbE13xLipqRWEGnJosuq6Q7byiZlVWhtsBtlzFqYa/W1ddR/FxLBZEE6j9im+IEmCj1/G9oKJxAMhLLl8iKcf/jjWfj3n9H3nhVuQKE8lnVC37jAwTTi1Ne7puwIAz7CH+IomA==
x-ms-office365-filtering-correlation-id: 5059aff9-6bac-40c8-a08e-08d6850f0034
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:CY1PR04MB2330;
x-ms-traffictypediagnostic: CY1PR04MB2330:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <CY1PR04MB233045496C88B5D9F94E103EED960@CY1PR04MB2330.namprd04.prod.outlook.com>
x-forefront-prvs: 0931CB1479
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(366004)(39860400002)(396003)(376002)(199004)(189003)(74316002)(305945005)(229853002)(97736004)(6506007)(53546011)(68736007)(316002)(102836004)(81166006)(53936002)(44832011)(81156014)(486006)(6436002)(256004)(7736002)(66066001)(8676002)(9686003)(446003)(4326008)(54906003)(476003)(6246003)(55016002)(25786009)(71190400001)(7696005)(186003)(2906002)(86362001)(71200400001)(8936002)(6916009)(478600001)(105586002)(14454004)(6116002)(3846002)(99286004)(33656002)(26005)(76176011)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR04MB2330;H:CY1PR04MB2268.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: F3p+1cEMHYNv6ykc2cFX1BFXXnlXkLJUlKazH2kVq2HcGtL7n4r5JhkebrjAks2RJCw+XUQ/L/A3PYO5lRzjeNoHsIMctHeD0npG2WvelrIXqbLHR7HUP+FTgBIg+ray7/LKLXN482jGbSs//ZfqLC+GD0kowoNd6i9eW/rnkwPagTQ1H16c3zSS3beFag8woBKFOJ73Gaaxs8zZd4H/IkwNJSz9WpnLChSZzecEZYOW3il2qYAp6h3915f7XEgYGP485Ni/1a1FOJh/uqk0C970d8JU3P6Rr073ORLivEwy/6MMPPn2IJEMXU/4Uhfk4Fy3Sibv6BXNjnJ69e3lEbxKYwNAZvJMIIOQ6MxlrnXSC3E+1T606jjTDGfrI/VBoDsDtvJWhogLhagEm57C4Vd5JXsZe2UGxJfSCoLssCQ=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5059aff9-6bac-40c8-a08e-08d6850f0034
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2019 10:54:39.3105
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR04MB2330
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/26/19 6:14 AM, Omar Sandoval wrote:=0A=
> On Fri, Jan 18, 2019 at 06:44:45PM +0900, Shin'ichiro Kawasaki wrote:=0A=
>> These optional functions can be defined by a test case script. When=0A=
>> defined and TEST_DEVS is empty, the fallback_device() is executed before=
=0A=
>> runing the test case. The fallback_device() function intializes a virtua=
l=0A=
>> device to run the test case and return the device to be set in TEST_DEVS=
.=0A=
>> After running the test case, cleanup_fallback_device() is executed to=0A=
>> clean up the device.=0A=
>>=0A=
>> This feature allows to run test cases with test_device() function even i=
f=0A=
>> TEST_DEVS is not set in the config, using virtaul devices such as null_b=
lk.=0A=
>>=0A=
>> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>=0A=
>> ---=0A=
>>   check | 25 +++++++++++++++++++++++++=0A=
>>   1 file changed, 25 insertions(+)=0A=
>>=0A=
>> diff --git a/check b/check=0A=
>> index 4563d62..4b66995 100755=0A=
>> --- a/check=0A=
>> +++ b/check=0A=
>> @@ -407,6 +407,7 @@ _run_test() {=0A=
>>   	CHECK_DMESG=3D1=0A=
>>   	DMESG_FILTER=3D"cat"=0A=
>>   	RUN_FOR_ZONED=3D0=0A=
>> +	FALLBACK_DEVICE=3D0=0A=
>>   =0A=
>>   	# shellcheck disable=3DSC1090=0A=
>>   	. "tests/${TEST_NAME}"=0A=
>> @@ -425,6 +426,23 @@ _run_test() {=0A=
>>   			_call_test test=0A=
>>   		fi=0A=
>>   	else=0A=
>> +		if [[ ${#TEST_DEVS[@]} -eq 0 ]] && \=0A=
>> +			declare -fF fallback_device >/dev/null && \=0A=
>> +			declare -fF cleanup_fallback_device >/dev/null; then=0A=
> =0A=
> We should check in _found_test that cleanup_fallback_device is defined=0A=
> if fallback_device is defined, and vice versa. Then, we can just check=0A=
> for fallback_device here.=0A=
=0A=
Thanks. Will change the patch as suggested. I noticed that fallback_device =
and =0A=
cleanup_fallback_device should be unset at the beginning of _found_test. Wi=
ll =0A=
add it also.=0A=
=0A=
-- =0A=
Best Regards,=0A=
Shin'ichiro Kawasaki=0A=
