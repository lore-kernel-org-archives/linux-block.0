Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D33B9ECAAD1
	for <linux-block@archiver.kernel.org>; Tue, 30 Aug 2022 04:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbiH3Eqj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Aug 2022 00:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiH3Eqi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Aug 2022 00:46:38 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A71ABD6B
        for <linux-block@vger.kernel.org>; Mon, 29 Aug 2022 21:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1661834795; x=1693370795;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2gVycdny7But8DiYB10s8h36SJ5TpFOdUXppdHICH8w=;
  b=nla7FMchTIG3WyM0xSZhO8dLTunp1XwfRUQ3tPhXDjk4SvQTGcJx58OG
   qpKCDfVUl9xMBMJai2RFppXSjUiPD/wOygYiieIk18YTCH6VKLYp5O7hx
   /2u9L/IITkc6a0eQqyvL9KRamOqbaQ/8szwR04psqRMWTzkiBFn/j/zJb
   b9E/i102e6nbc5Lzwd7g9R/BHKxj+3TwuwEABkle2DGBwNeWH+YLgCbuC
   wEtInpJB29z1GONojRzugbDbdVmQXOsGWC5YUR1hOPpfRrOlDsMlhomn8
   AK4oOjGJCPBvbxvAvXZOAk13H7U1/p1n4v27wtwJ2l7BJnVnTsN5idFaJ
   A==;
X-IronPort-AV: E=Sophos;i="5.93,274,1654531200"; 
   d="scan'208";a="209989365"
Received: from mail-co1nam11lp2171.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.171])
  by ob1.hgst.iphmx.com with ESMTP; 30 Aug 2022 12:46:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=akiqgKDToinlzT1pK470UY8JVT4aXfLTfoZ/KiTnEBlWnpLXyU9Yeb+6Oo5+gzac1KUFqQnlyttzNIebYgR3HLKf5rh81b5qO3fPpoTdwZmxTslUr3055F/C+Jvj6j9AwuHFdX1C/6DAUzulbUUqDcsxX3RteuTFzk4QL5HQQX6V9o+b85N8DNE1/rMWoGAI56e9Jy8l0V2+ocUwDHXmbQKtB1ZcMJntSNl6l/jscFXgxh0H1ZBZRXeBStmlYu8oMwk0F16xmnIAqANR6OHLRMn1Isd+97W7sW2YUzFvd7rvnRBeWy32kQGhlFfqNqcRTVMaSdAj3hPGWZG6++Sy1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3d0oUEhrwGH1X0nSRgnQqKr9yU6trHucUr+y/c7eaiE=;
 b=LG7cSpZzy3UYJMF/yrsNkjkdTmn3q4922Ex7Hjb1qsvrXU+ydBudrz8v7Ri785iUVGDtKRKbdocSjyL2LxlJIcNMFmYH1vNGLW6JNGn0EQp214Qj9efeWyAiO9ZE1z2l8YYGBATJ5V4A8IyyQP8F6vcf89FEG5v/W1bJw9kgDQgRZvA6J0aNjte+2F2cRKwlYkfeNqErSYBDc7PQpE5CiXs9v7Ol2pt6i8Wlq4xv0C8Jsc1YKPFIiSoQJVB7HQu9m0WU6lppR2B4k5LSX98X/XGr/nZXgMgMY+Mx7W3gkERBQr4ba5P/pFOuXupy8JwJeeYfykWkNj3lifAgYbFUsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3d0oUEhrwGH1X0nSRgnQqKr9yU6trHucUr+y/c7eaiE=;
 b=fwfcdeSWPZI77tXl0CixC91Jp046VKU2VZl+FXFfz/smcf/1mC+LqE4PFo+50GVChGTNv9TP+slLRlPTPfqM/bzRapAsPkXwujwhmieFUJ4PmRazS7YARj9EcY+jjjob/CpdDRjI8eN8nMO4WsfoqPGdTpF9OWRhfT/j+Gmul8w=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 MWHPR04MB0560.namprd04.prod.outlook.com (2603:10b6:300:73::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.21; Tue, 30 Aug 2022 04:46:33 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c7e:a51:e59a:d633]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c7e:a51:e59a:d633%8]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 04:46:33 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Sagi Grimberg <sagi@grimberg.me>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests] nvme: add dh module requirement for tests that
 involve dh groups
Thread-Topic: [PATCH blktests] nvme: add dh module requirement for tests that
 involve dh groups
Thread-Index: AQHYu4JqMzYWLRy0pU+II16FtTMMiK3G3+4A
Date:   Tue, 30 Aug 2022 04:46:33 +0000
Message-ID: <20220830044632.j7k45lhdlyvksrxh@shindev>
References: <20220829083614.874878-1-sagi@grimberg.me>
In-Reply-To: <20220829083614.874878-1-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 223ac872-3c3d-4dd0-8bb0-08da8a429d28
x-ms-traffictypediagnostic: MWHPR04MB0560:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NWsKNphcemaHczOzibtdrsHzTMYWjiWdY5qQuVA5O7gqcB5ce+z7DLwScTuGPzJ0nmXevwZevEPW9S9qaYp7TOzsLgONzlGH8f3J3+nYg5XuumfuhX2lGJPb8MqBnzKlKXFV1EL91IQmclb+2fCxHkpncAZAFY39Og+3JOEL02959lcFNmKd6cD9oY28/9hTdAEafSmeBr0RVW00M7ItovTd1VqDoE2F4z9JPb9N1kHBgeVpEnT92lHB+nRoReOq9RBoXSbDGB/tPNDU6bSMswKiIZS8mCTs+mjv3vOIpUCoJ61WEVWAEmx8vohKjw1aM2CG9k9P47C5FQ6xz/slMq8vc9DeSFJL0O3g7pSOJWLK8GyMXoWTIqb/08Dpg6rKI7XC1JSfVsuJPhcDxOxkq/9/MsiXuUzvtj+AEpPk0O51RgTToyYvgx3QJ1zYPuU5E9mH9zzM4bdkKJGfoul9YnrxSJJOyqP6AuM3bHEuGlZNGmpSMLRo6mwI22wbLnyAn1w+7IWMbyvP4sJEEt9EbM4SAAFPEeLfmh+RR3q9MwgTT9H9kZZgoNG79kCH30tdKEbji4dIJpaRFR+3f/h/o6N4Uh3FY0avUYj7SKtaAeblxn14ahZt5q+my7xYjv5DB5RrhnDgmaYj2Ta1CeG5eH3tKt3urgzfkaVraOJyV6ssbL+5gTGkDziNmCxkkMsQsFWGOY/643rLegfVBtyGF3V3Qg/qWvVO+C7L54ImYL7n92jeFdWfXmjfezddfnFWwvs2BvrToZfCRr3573q1sQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(4636009)(396003)(346002)(376002)(136003)(39860400002)(366004)(76116006)(8676002)(66556008)(64756008)(66446008)(66476007)(4326008)(71200400001)(91956017)(478600001)(316002)(54906003)(33716001)(66946007)(6916009)(6486002)(44832011)(8936002)(82960400001)(38070700005)(2906002)(5660300002)(6506007)(122000001)(38100700002)(26005)(6512007)(186003)(1076003)(41300700001)(86362001)(83380400001)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iGRWzTsp7aacQ82QYKteWPD5Ft3Gk3gX1dC3uPqzD8fHS0hH3qoStPjuFaKP?=
 =?us-ascii?Q?/N/0GIJ+uZ1kLNV9CK7JtfHx6TjFl0Ewxacl5rwwUq+UA568iYG+iuydJUwY?=
 =?us-ascii?Q?l6Pz/rPblEoHa1rQdwszRooq1MykKMsDgtz2lfMZ5XWsZD7y3kRF6OyKjWJe?=
 =?us-ascii?Q?074zzK+fWRSr8b+jO4eoQWIkUY0NibKnXNSUm281huqkXGXm2aIweA5LhRO8?=
 =?us-ascii?Q?Ga/EENoq8oAKsg67GI7JVP4g7md1O4IBbUAZXz+FwTP57NSjSZTLVllKmR4b?=
 =?us-ascii?Q?XGSmNxipCiEw83vjN/tcRd+ah3WZHOQzSYCywQ715vbTUTwK8/J5Dm//w68e?=
 =?us-ascii?Q?7MIkorYowZWJe9iephECt+FhPc4Gnu+l+UUplp6FOJHUG2DGfZ2K3+GsRxo0?=
 =?us-ascii?Q?1XBlEHeJjTGTeeKu5GkRAylYrQruY68lqbpkepMLDxG6giKP3jD4ryLgBgrT?=
 =?us-ascii?Q?cMsABnJ0reBbQPWHV1ec1BTeyOl2yGAJD8HNPmqPS633f3Xoks6ifvuhQMGQ?=
 =?us-ascii?Q?XpUgeHLPXKr2ysCHaBZRRDG30YyJUSdnpiSvKMifnCICWDAJj8MoZ82G6t/Z?=
 =?us-ascii?Q?P86aT4CaZzCz7gx86J1pAdqsmREBlVk89Oinc6zs/rV7/LEUyT0k0GkA2IVD?=
 =?us-ascii?Q?a7+AmMrXy2uVzaJvp/IKjA25ROFyFOQOZrHzR+L0zzfoPtztAIc1xCWAar+C?=
 =?us-ascii?Q?D3gqkJoq8oCon8GxH3+RcJkxKjeRbCXqSWx0vc0NpB0a6simARi5CJxC0Zfx?=
 =?us-ascii?Q?m45fL06hjVvVwzbXLuEafW/6v+q0u4hWc1ejUO3hIGzD3DX9m6nP+sohA2Qc?=
 =?us-ascii?Q?VmtwYZAAHKZ4v+CKAs2LEEtlGs3yBlEAAD5NgUKISDRLLuPCSrRbIeCIs/gG?=
 =?us-ascii?Q?V5A/C9r+c8CQJEGKCMWXMJyPINMm0cKlmWlBqpLtWtnSqjaiKzrJrEf8b4T/?=
 =?us-ascii?Q?+EAP0MyLZ5fhA6ci6hDySrbsDq3coILm0bBfpc+L/HjoUa8RZYoUOusZcbVI?=
 =?us-ascii?Q?7WfGounJKymnwPzPBHhCFnQ4A77Bs9VkEG8AdVhDtUitNn8vOMvXe8y7iyDr?=
 =?us-ascii?Q?fy0RzTuoAMtUVS9M/MEgbD9vjCo8MjIaqg/0bBld3N8IYoBIqR18631WWcuL?=
 =?us-ascii?Q?/9IPD1BCC3gY4trWGeDltikSyNg/q5Uur/sJUXqoi++zNWKvJxsQyI3QyeD9?=
 =?us-ascii?Q?G0Ci4nOfWmSSBoosep/LWkU4IixxsaDyhV+ZKVKlK7E98AoxexZoL1wEE5zl?=
 =?us-ascii?Q?pMLRSki7i1vqUOTsH5f0tsV4rxw2KnyQBA2ELVFTFkjy6DPgr0U30yVLhSsC?=
 =?us-ascii?Q?4V73e/axwi7LAbUL63c+G0CDWHcx6ZPXtcPD2JD+ufO4/s3ueX/sAnu4fT/M?=
 =?us-ascii?Q?v79u9bULgVz+4Qcx5DNYtBAUxEdpSYZr/iMnJFYTSroQKCSeiEMEvBa7j+2m?=
 =?us-ascii?Q?+3j8oovIuyypd2LMSSTiE5FIOHuJ/hMKgVkN8HoPxB6fQtEADd9SS6/wWX9U?=
 =?us-ascii?Q?lz3RzYqihiWyQ2UbobOIk6kaB5DyR+DI6I30uw/LNEzIA3afJF/zqQDhJuHW?=
 =?us-ascii?Q?r4raJZgvHxjYYxHsIJ+hbEQtlVUMTXSlPOyCUNjLfr9H6zNIqFMxFbrwjQ1I?=
 =?us-ascii?Q?1l0fkRycuXPl9wGeXIR75Fc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1B718CD5B9C01F48A2DD464B8066AC78@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 223ac872-3c3d-4dd0-8bb0-08da8a429d28
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2022 04:46:33.4876
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mDwlypXQ25tbJwUX63JGwLxGpwY7UBZQPFQ8LliqCHJV64YLJRJxD9+s7HpDh9Rk6vptLU6VHF/MNlsg8AJuE6UL5N4nAONvb5ts34aGD54=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0560
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Sagi,

On Aug 29, 2022 / 11:36, Sagi Grimberg wrote:
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  tests/nvme/043 | 1 +
>  tests/nvme/044 | 1 +
>  tests/nvme/045 | 1 +
>  3 files changed, 3 insertions(+)
>=20
> diff --git a/tests/nvme/043 b/tests/nvme/043
> index 381ae755f140..87273e5b414d 100755
> --- a/tests/nvme/043
> +++ b/tests/nvme/043
> @@ -16,6 +16,7 @@ requires() {
>  	_have_kernel_option NVME_TARGET_AUTH
>  	_require_nvme_trtype_is_fabrics
>  	_require_nvme_cli_auth
> +	_have_driver dh_generic
>  }

Do you see failure without this check? As far as I understand, this new che=
ck is
equivalent to '_have_kernel_option CRYPTO_DH'. This test case already requi=
res
'_have_kernel_option NVME_AUTH' and CONFIG_NVME_AUTH selects CONFIG_CRYPTO_=
DH.
So, the new check does not look required assuming dh_generic.ko is built an=
d
installed correctly.

> =20
> =20
> diff --git a/tests/nvme/044 b/tests/nvme/044
> index 046553198ce3..13019659b951 100755
> --- a/tests/nvme/044
> +++ b/tests/nvme/044
> @@ -16,6 +16,7 @@ requires() {
>  	_have_kernel_option NVME_TARGET_AUTH
>  	_require_nvme_trtype_is_fabrics
>  	_require_nvme_cli_auth
> +	_have_driver dh_generic
>  }
> =20
> =20
> diff --git a/tests/nvme/045 b/tests/nvme/045
> index b60f18fc9f87..264f21053921 100755
> --- a/tests/nvme/045
> +++ b/tests/nvme/045
> @@ -16,6 +16,7 @@ requires() {
>  	_have_kernel_option NVME_TARGET_AUTH
>  	_require_nvme_trtype_is_fabrics
>  	_require_nvme_cli_auth
> +	_have_driver dh_generic
>  }
> =20
> =20
> --=20
> 2.34.1
>=20

--=20
Shin'ichiro Kawasaki=
