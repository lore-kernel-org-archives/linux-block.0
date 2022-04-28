Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4BFC433F5
	for <linux-block@archiver.kernel.org>; Thu, 28 Apr 2022 03:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiD1DyJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Apr 2022 23:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242586AbiD1Dx6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Apr 2022 23:53:58 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B297EA2A
        for <linux-block@vger.kernel.org>; Wed, 27 Apr 2022 20:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1651117846; x=1682653846;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=QR0ZBiqGeFuptxM4Oss2iC8DtOpjEQOva7tJX8xEXJ8=;
  b=NGptTR3ooROxTm2FO5MaCHp5sOf5eJuUZ70jg9rPOTzDfhb/xh8fs8+b
   oUMKAqRSvMQitjaH2TKrnhSfULKm6jv8qmPt8VnNWryZfMIZPKaknBE/9
   ezSE0VWCZgVuH35n4zLe0adT3WjGWEl04eG2MdAF4u+wPND8MO0hPUtEu
   v5REZHzN65navYjdX809iZFsWwL2qnwdvHXAZlF/sFz34FgskTn67t/HX
   FBUly8neiXI4DK2vbxU0k781P5txLpls3RZ73OReqZwJkRzjxSfbzfanB
   HHkVF830FK/cvXqqPsn7QrM1vzLB3hKagCQg0ZJ0neySwDzfrZ+KMQTiT
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,295,1643644800"; 
   d="scan'208";a="199910576"
Received: from mail-dm6nam12lp2169.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.169])
  by ob1.hgst.iphmx.com with ESMTP; 28 Apr 2022 11:50:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JuInqMWVxzKsf0Gv8Yh1KXsaAx8TJLGKYjTs+avB0qyF8se/bKGqFX3RAgfkF2vZEjWpj4/T+KCOxEjX/pl4+2ueHXhwmw4W1I3hsdBQbLt/6ndo+2AAfNcsdVXuVOb79Iyuhn53FStXOYWsPNxV2F14cU5wgL8tMk1nkCo5XIXTLfAUKn65X1rvhKM+FECGKeA661q1OMg8kEbcTpXFqI2GUIV50/eRgkFMSOgWIv0Iu34BUd/SB7YtYVRonKnHSDIUi9V86qVoYyLtirdI11nK2GEm6/FeIdYCByhm3jio1vwdpwt/HA+kMWV+RqrdJSuWa6XiIvSqg/Ty0yTPAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MU0tax5kswGWNORpPg9uzKvh9EgEwcItitfvvq5mdIo=;
 b=iywn/eSorlUNyBKKeT91LnCAT5WQvW4wYFuy6g4RflyJ7fN7IYbDp4ma5HewopLooYI1yRFLDBH7ke3deWulxacdZ75KIU481yTSKIQoHycZ34YLrrWWsKC602Cv3gdzOKRBva6/a65KBnq6SdhcJ+htvmso8UC4t5KxNZ2PE5MoIPUiZPjWIeZI/FzS5tm9y7tkiwBrxQmJe85JyIBT00nbolhTjK+yKnkuVC3h/oUCll1nxB+bgapiZwD1SUyxySXGyL0O8vDOtqJyE1dB2k0vLW/uQ0rZwoLeV9V68VThc3du1Z8RAjoRspYJGLKZ6i4QorpQpnFDPwM90soV7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MU0tax5kswGWNORpPg9uzKvh9EgEwcItitfvvq5mdIo=;
 b=fH36K5xNgduC3TncQKfbAFg7E9WYNxrFRIm5nANVWb8sc74P8Iwq1d8cSSrNyhY2+v/Rh0EIlfoXTd0yjvHUTQu+E+yzE5uVtQVfil8hoBQCEGvr8At1VVq2BiKrvE3X9MjttpqOBMlO7QxqIdxz2bCwdixcY7SsQnZhIabtqu0=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM6PR04MB4282.namprd04.prod.outlook.com (2603:10b6:5:97::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.14; Thu, 28 Apr 2022 03:50:43 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::2839:2ab4:7871:416e]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::2839:2ab4:7871:416e%8]) with mapi id 15.20.5186.021; Thu, 28 Apr 2022
 03:50:43 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     Omar Sandoval <osandov@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests 1/3] Introduce the io_schedulers() function
Thread-Topic: [PATCH blktests 1/3] Introduce the io_schedulers() function
Thread-Index: AQHYWrMiGZRhCweEv0aws4nBExWcNg==
Date:   Thu, 28 Apr 2022 03:50:43 +0000
Message-ID: <20220428035042.eqtokeaohmxerwu4@fedora>
References: <20220427213143.2490653-1-bvanassche@acm.org>
 <20220427213143.2490653-2-bvanassche@acm.org>
In-Reply-To: <20220427213143.2490653-2-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 17864ac1-f5b9-4b9d-5d09-08da28ca44f8
x-ms-traffictypediagnostic: DM6PR04MB4282:EE_
x-microsoft-antispam-prvs: <DM6PR04MB42820D543D6F361527BD6A56EDFD9@DM6PR04MB4282.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cPpV78SfVvKe5hQs14rVjc2Y6/F2e14jZmn9kye0L82KE8+DL5PTV5Gm7ubgnGv2iw0/IInRP8PREykbJwAc63ruigR3DEg4LRe0UZouMXRYj1OXnnCfGhwJIiC+WByzJkANarOvr8046Rm/Rs+HYg2bD4kbMu31QcqvBcQFADfXiPygFR39pCI+fUklA5dDjU0rSJJuxhQjxpA6bg6J65mSp+oMdd0sYmCcWmNv6dHdlZS/Uf7mwFWBe74X1Bt3TsD19HAeK8LcAxvmeK6yK7nUNhOMHUn3fedtUzrqxys6RM9YtUt1FLaWEiGcRDlIxTHXdn+vIKuqXWafP4hwy2fYYpFpmkqcIiIVEa0k1IwGcLg0XjzPWbkEgK37n9AFsajATlqOrsw6odjAIDtZVBjGC/Ab+IfEGmHHSiEY1amHlLrB3OBxpvJRU3Ub9KzOnX5YE+lUAtLmQ4q7JGhZMe/r5R9EXvaETAWalEP6sySfloog/yVjAu1FPBhgdoL6XTOJX/nCmp+W4WUWOYZSr3avqCx2NWAIQ5AunR/FfY7u0s93Z4SIwgIv1qgHq4WHLjask2RW7y730U3M+/k7nGNrj/+TlEFYa/gKoMGQdACYI8iyuiG1bwKclYLHYVCLOZ27xdp6+kkavw2nJ95Tiwrm36SYxGMtya4cMrzQSXgRiz5clKtuG4dC9BCewev6Wg1auF1wpP+RQUNrfXRlgg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(2906002)(38100700002)(86362001)(38070700005)(64756008)(508600001)(82960400001)(122000001)(5660300002)(33716001)(44832011)(6512007)(186003)(9686003)(1076003)(26005)(6916009)(6486002)(54906003)(8936002)(6506007)(66556008)(66476007)(66946007)(71200400001)(66446008)(76116006)(91956017)(8676002)(4326008)(316002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Xwokioj+oiCa7uWy8fR0HYTIsnaVU2zrI6UBwnDIhlr8A57o6sZTkJQx4K0d?=
 =?us-ascii?Q?FHYkR9NfGhYMK1MqBotO4TmNOXTO+ZUnkqmuHzd1qNiPkC/sPUlGYfUBCJtr?=
 =?us-ascii?Q?U4L2fF7Jk/snqKp/Fox08+m2kw7OyuoV6xTM1kc7ucRj2yCrFMpbw+uF9aI0?=
 =?us-ascii?Q?37+I16BH8/fsilhMrsR1QBy27BrFxYQScmZ4BEQlh3xF5MKJsQxPiDkYvjFm?=
 =?us-ascii?Q?HFjqJN/sOlcgBNQivJd3RNN3SiYSyBIleXR2XE+oGcVd/1hInc8DYCzqzSCJ?=
 =?us-ascii?Q?0vl4E2qCGuCb3HVkypErZABRDWtXDGjlMkbMf846kPJsEeO9i7kFdh0bWfz/?=
 =?us-ascii?Q?nSP/XuH6MUxHvnhJzHHWQIxtI/fHtR4/8qD0MZKyiMMOxqutDOMx+LmVAzht?=
 =?us-ascii?Q?rbSSAS2OIfPPu0vm9TqnckSEGSa9IU2jS8Luj8CoZQkq5kliwmuOMIEMX3Q3?=
 =?us-ascii?Q?7uMmtZvEea/85ahcbx9tpmEHqlDFvAm/adWiqxvrgW3+FFHaTfQNomB804Ou?=
 =?us-ascii?Q?ISHcGYQfU5sz72BFPWQiUB3UZJrmN5W3dd65Nemrf/aYpe4yaQKEHdqxG/Q6?=
 =?us-ascii?Q?3LjkOi9fFDnoLMK08lUEjsesrlBZpMNxex/d8xEpleXEq5D5QYsVR1vM7Z9F?=
 =?us-ascii?Q?sN7q2nBjRak2MahnaJZoJaM3qaeCnrkOlFfztujnj3OKS97HVNzF+xze05oC?=
 =?us-ascii?Q?6tvnDSXNZgBEB7MhbNl+6Yn/52JJMJL550qkZlsuYPfR6MULPOcEx+3MZmfy?=
 =?us-ascii?Q?NW0yCUj8MS1C4kXJNWisYtIsTJjyNI6AsIEm2H/W9QHUZTXSxM3HA+MxFFm9?=
 =?us-ascii?Q?g1DcYT6dn53V62X4iGneCq9F31uwNtWcJBqjlIMfSRVgfzD1ufNOoo0E1bcQ?=
 =?us-ascii?Q?i4uphwddOHlexIl8XIMWTjoZwJPYxyfJljNFJDU3PzZf6UP/8T1OK+TNLilI?=
 =?us-ascii?Q?YiR5PvTS7Ky6X3Ud+Vu5Y6mVGbusbpovfxaSfsai0pKA11D+Hp38fu+G5EUC?=
 =?us-ascii?Q?AjgKRIKDvoqv7XQ/1yytlY1Kki8V1VIy1L2Lq4tXtsILU+3aC0zoKtjzs/KZ?=
 =?us-ascii?Q?ZyuggCqEr5Qn3uQ3twKNitS8GpEI24MsbuPjMEELe2K0fdw9RxFHslkkPNRX?=
 =?us-ascii?Q?AgAa4u2oRgb2qoULB4Cufmg0ajxFusxjBfswxp8oZ0ZifABVylz8IOaw7afv?=
 =?us-ascii?Q?wjSLSgMvga45KtZPETVOJbXp0binePzPFW4V5SuXxaZ6mv0jXkdIsCEh+ahd?=
 =?us-ascii?Q?OU4uf6AcsTFkCZOmhyLWAK8T2E2sOZGPSl0Ddk3QiuERErhqwBFrn416MtSj?=
 =?us-ascii?Q?iiK2DL6/WAsb5+YGVg2ny1Y9C0OUc0QuDJ3BfaaS5i63wdAx1ja5wRDl5zfE?=
 =?us-ascii?Q?ToGz2jlEWK/O80vtdft1cjBNt8ZFdBW2x/viVXfblG1cW2qGsTTrcqdd8xFp?=
 =?us-ascii?Q?XJBz3iLAqL6Sv0mQJZqRlk+q6yhDxYM2ppo2w0LbvMjFL2604xw/vfPuBBtA?=
 =?us-ascii?Q?aP2WaV8Sg2XN6GDj2xy6+KaJl0ktKzG7immVx8KXlCbTU+wMYC1rHwilEzf4?=
 =?us-ascii?Q?VKRv/ZfeBt9S0m/1CDxpUBZRWD4ezCEPA7X2guKV+2fPi52PHMYXsoTUW8UL?=
 =?us-ascii?Q?E6YT3C6h0JeI7KODYbLVSPEKR3uS7jbxQFeOwGA4bqBbKJl9vPTGg+2wcYs3?=
 =?us-ascii?Q?XpXXMPqOjWWrUokCptTxL5HughySHonb40cnlUfbDHFv/EpxYaWF/6rKMiyC?=
 =?us-ascii?Q?u8ywMLKmiAkG/PNnuemJ+MzEiSottEyIrFUREeR0sm2Pldlc7Cxn?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <373F97856C3E794C9028B50AD6C6AD30@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17864ac1-f5b9-4b9d-5d09-08da28ca44f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2022 03:50:43.1822
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LHsjuoD3niwQ94EqU1ycj2rXDJs164IFbp3VJZ+xOdXBe4VvRP3JUZNlJzpd8OFtgbak61m2frk6tq41DQnfGSr08+hcxP3wHFxVxPpj6Rc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4282
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Apr 27, 2022 / 14:31, Bart Van Assche wrote:
> The functionality for retrieving the I/O schedulers supported by a reques=
t
> queue occurs multiple times. Hence introduce a function for retrieving th=
e
> supported I/O schedulers.
>=20
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

[...]

> diff --git a/tests/block/005 b/tests/block/005
> index 77b9e2f57203..383c8f5b7d2b 100755
> --- a/tests/block/005
> +++ b/tests/block/005
> @@ -5,6 +5,7 @@
>  # Threads doing IO to a device, while we switch schedulers
> =20
>  . tests/block/rc
> +. common/iosched
> =20
>  DESCRIPTION=3D"switch schedulers while doing IO"
>  TIMED=3D1
> @@ -17,9 +18,8 @@ requires() {
>  test_device() {
>  	echo "Running ${TEST_NAME}"
> =20
> -	local scheds
>  	# shellcheck disable=3DSC2207
> -	scheds=3D($(sed 's/[][]//g' "${TEST_DEV_SYSFS}/queue/scheduler"))
> +	local scheds=3D($(io_schedulers "${TEST_DEV_SYSFS}"))

I ran block/005 with this patch and observed it fails without failure messa=
ge.
To fix it, the line above should be:
        local scheds=3D($(io_schedulers "$(basename "${TEST_DEV}")"))

--=20
Best Regards,
Shin'ichiro Kawasaki=
