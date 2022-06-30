Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83CCCC43334
	for <linux-block@archiver.kernel.org>; Thu, 30 Jun 2022 02:05:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbiF3CFQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 22:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiF3CFP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 22:05:15 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2078.outbound.protection.outlook.com [40.107.114.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42C03B571
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 19:05:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O5YfS/LN3mYj/OooNOct63hDDcA3kub8fkWhizf1rUaLfRdUAtw+bP6jXaDDZ/H3DQ64B9lLs1F0ViMcD1TzySVrxY7sP+lI6GpXXTsMswRSkSuXFo81e6Y/250SZ5sP8exj5EHFXq6EZJ0xpERqDhWlS6A91M/e84o+fMUZO62fsl6neeuJBM8XvSCZoNzDEENhnCJuV9nWaozhXSIbcl8TfpPXlmBCzn9gdwK6QZgXXww9OaeaqlCfOnyeinx9wwU2JEGR4JFf3FMVYiivsdkwOTiATtNV1u/N//fcMC+9UAjvHqeoXuMNp6btT8DkC6CvaaAGedAuJehXDNbkLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0OvTRzk1QDutzdWu0zbr7N5ss0MfG4/CGD7AlI24f34=;
 b=klesZStKeJQw+GwcXJkbREHZoSdHnVQPp8c0YU1nrTrh1j0Y9GxJNZBslCGoDNW/3CfLQvt62fwRP4fs6GEBgRmJEnccZbSFV1v0auY6RgTpEGL9+nWqIQ3Czg01bPTSKE4EOBv30Xjf+wPLKpDHbddZxW8XohKohkh6KWE3PQjHVK0lMmY41ERWGO8zM3bhvLVopyADdsFZI1+2RDbnfkVAHkQ7xf3MJ9HCenJme48HxZ/uQlDLUWHqzDmMUdcmFymhn4Z811E9pkQksuyk+rVe1l89OLR8Z7969D/5YBZcKxm0RpL/qifNMZKrt4TStuqDC0ZXPXdnMF0ZWrkd1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0OvTRzk1QDutzdWu0zbr7N5ss0MfG4/CGD7AlI24f34=;
 b=md4E6OEmEiwzLroBJMmmLBgiOAEY/oYXdc0h9uOGYvhTqsDHpfPOjSzGUoGkCPbmVQPzE53qiuTnsuPaHRkQyCQLa967rNT3DHwaYHjjGz/PMprdu/36hga+hzrrg8mbUwLM6ZY64pk38aWqp0JSq6uP1iJEUmivEXWYmeFT1Ns=
Received: from TYCPR01MB6948.jpnprd01.prod.outlook.com (2603:1096:400:bb::13)
 by OS3PR01MB6536.jpnprd01.prod.outlook.com (2603:1096:604:102::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Thu, 30 Jun
 2022 02:05:12 +0000
Received: from TYCPR01MB6948.jpnprd01.prod.outlook.com
 ([fe80::41c1:d812:3e8b:87f9]) by TYCPR01MB6948.jpnprd01.prod.outlook.com
 ([fe80::41c1:d812:3e8b:87f9%6]) with mapi id 15.20.5395.014; Thu, 30 Jun 2022
 02:05:12 +0000
From:   =?iso-2022-jp?B?Tk9NVVJBIEpVTklDSEkoGyRCTG5CPCEhPV8wbBsoQik=?= 
        <junichi.nomura@nec.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Mike Snitzer <snitzer@kernel.org>
Subject: RE: [PATCH v2 10/63] blktrace: Trace remapped requests correctly
Thread-Topic: [PATCH v2 10/63] blktrace: Trace remapped requests correctly
Thread-Index: AQHYjBB4rE4KR6sGw06HxsG/wmPwWK1nJYnQ
Date:   Thu, 30 Jun 2022 02:05:12 +0000
Message-ID: <TYCPR01MB6948A4638DBA55684374AFFA83BA9@TYCPR01MB6948.jpnprd01.prod.outlook.com>
References: <20220629233145.2779494-1-bvanassche@acm.org>
 <20220629233145.2779494-11-bvanassche@acm.org>
In-Reply-To: <20220629233145.2779494-11-bvanassche@acm.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 673ff152-9029-4d54-145d-08da5a3cf7c4
x-ms-traffictypediagnostic: OS3PR01MB6536:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y0T3HkmlyoPWkryftyRhkQ/PyCvVtSgKTzoIiaYtjVVCAvTJAnfj081Y8qBIfwq2lp2S1a+7WJ4fnVdOsMgFg7bxa/t7FMfySLWRmuizfUmC+HGHjPGFHqGr+8e4rOukx1AOtn3tVt4J8+ojH6fOrhj1o245kSdnwmaRfxmLy6hxQ0OxajqbqYYIoDXrLm2I8gnJ7F+SvHDqmd0wMAwBE65V6Me9IDP2Asff0C5XhtYmGztyF4tZSL52h1Q4yLNJ97+d7fS4d0NijvwjI2Ek1+asdgWbjty2DyHw5Q3/+3DMkLWUDMw+yejm5GItUVBxrYP6mZqvV6NOmO9zysCJD3ULw4B/XGVjfmN8CrRBVV61o9UTPp9beLb66X9p0mhhLUQ4fVnFdAlAPIhp6omCui+gfo4qACCXPL0MN/7emH6f9irTZTZzgTA6htsBPrjo5ChDkhPS5zIPmEJATTautddd/01EX16iHahFuYHnTxZ09guPNfCt3SjOWsfTe8mq4GJjPynWsq5xMmb7sy8h7NMz4PrjUsxAdPRZAM21OQfb7O4r0jlDdls+Fs2WmDoHQUmG7QFhU1yY9EN2CprBiVfJwzQgiTqXCGDZ1qZQ/OlLroEZFjDvSyRBe95jI1dUsg1XuFMXYUgdYYogWkXMgVA7NWh+0yyCrGLveI0f/Bw4mlfLcmFSn99VNY8ZzYPUgewq2BRobPKLAzPwqLGDiKtQonS8atv/TrRDwzp9f5ouggTs0czu+p9Zuq4IQdZNYQjk1hc0x/fpsy40uxzWIYMZlK5J8NJKtsIeJJPlMpm+EBS+UHEBr2ZroTXnlcOl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB6948.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(136003)(366004)(376002)(39860400002)(4744005)(52536014)(9686003)(6506007)(26005)(7696005)(55236004)(8936002)(71200400001)(66556008)(66476007)(64756008)(8676002)(4326008)(66946007)(110136005)(76116006)(38070700005)(66446008)(316002)(54906003)(82960400001)(5660300002)(99936003)(478600001)(86362001)(122000001)(186003)(85182001)(55016003)(83380400001)(33656002)(38100700002)(2906002)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?VmtCQWJvcnFvbGU1aVhuZDBZdHV1Y0luTXB5M2RHZCtWNG9lWmZtZGl6?=
 =?iso-2022-jp?B?VUx4VWlaZjh0ZjRGaGhMU2dFcFNBbUh5U0tmOWhjR1FETUZaRlVIblJu?=
 =?iso-2022-jp?B?dGZNRG9Sb2Vsci9MaUx1SHc3dERWVVdUeS9IajhZSTFkRzNsQkNuYjJQ?=
 =?iso-2022-jp?B?Qm5tM0hPTVBSaFFteVlPMDFyQitJYmtuQ1lQMk45N1ZxUHVZOUFvN1cx?=
 =?iso-2022-jp?B?Y2hwb2drMTJ6akxYVlRXVWxxenNMekJuM0c2bWlxSFJ6d2FOR1V0dGpB?=
 =?iso-2022-jp?B?WnhjYmFLL2g3Ti93WUEwNVJwa2xGbWVtOTV2WE1wN1VGYzVhNHpEZDUy?=
 =?iso-2022-jp?B?emJ3ZFh1aWZ3SWNXZ3AySlE2cjJ1b3oybnlobmt5SFE0cTArREdvMUxQ?=
 =?iso-2022-jp?B?bVM4elMyT0pWMTNSZHNXMTdTZm9UVklycmFpS1hscVkxT3hOWWgrZ29I?=
 =?iso-2022-jp?B?ZnhCMTNITUk0Sjlreml2bGhDV2JMck9uOVltNkxPWFR0dFdIZllQdWlN?=
 =?iso-2022-jp?B?SDcwSnVPclNzNytoc0UwTDZOdHFmMi9VbnNEbUJoTFpuelNQZ0pnc1FJ?=
 =?iso-2022-jp?B?UXBmNEI5dEFmOTZ5empiVnFzc0JFTEI3YXBLZ1ZoNE1VeHA4NUF4OEpi?=
 =?iso-2022-jp?B?U3YyUk1qUVE1Wlh3NTdpMmpTbVNvZE81aEYwTE9GS0xmMEhIREpqL2Ns?=
 =?iso-2022-jp?B?SmEzSXVodldNSnFwU2ZlMjBoazFDSkNlQWxUdE55ZUV4ZTN2dVZNekt4?=
 =?iso-2022-jp?B?b1NHQnlnOVY3TzlhWGxOZTU4SjBkZHUxc3BzdXIxR0lNaTVwRDEvS21S?=
 =?iso-2022-jp?B?TmFBNU5Ud1VGSDJWbXlFZFFGcWJVY3JBRVp3aFR5VHpIQ2pOK1VQRGVy?=
 =?iso-2022-jp?B?WDh3SFVWWTZmdk9CT2J2QzdLdkVFdmU5cTFBb3NQY2x2YWUwRmVRU2Vq?=
 =?iso-2022-jp?B?QkxmOGlob1d3OWQ3RThBd3YxTXpXWnQyKzVLdkNGb09YZk9KUHVxcXlV?=
 =?iso-2022-jp?B?M1MvSUJSbUNCZnNGcDJJbUh4TFVwUFd6N0pNYUcvUkxBRmF0bCtqbVNM?=
 =?iso-2022-jp?B?L1dPQ252UlAvNUw0MGNLVkwvMldYU3ZzWVJEb0F3a2NUdmJ4c1VXMHBJ?=
 =?iso-2022-jp?B?S21JSER2cHhXZEhjd3ZkZVYzb3dsNUxYMmM4b0tQMHU3alNuR2tZOHRi?=
 =?iso-2022-jp?B?YWJhaXhxdFRRbXFxVWxXV3RKWWx2ci9EVmZpQVVZVWMvRnNYN1Z6YXhU?=
 =?iso-2022-jp?B?cGFEaWlKdGYvL2NxM3NPQ2JmbUg0VDVQMk5rRDdVM0NiOEhnQWpZbTM1?=
 =?iso-2022-jp?B?b1UrYXJqZUxBeDBmcC9HbmdNb1ZBL2VGeGtUbmpFSlBseDd4dVk2RlFm?=
 =?iso-2022-jp?B?SVZlT3VUVFlxandoQ0RiK0h6cnljSFUzK1gxbTkrMGFXakdGamI0ZGo4?=
 =?iso-2022-jp?B?dVZ3b3BjemZ2b0pwbEgxOElyZ0c2Q0drYy9tZlc4V2Fib2VucUo1RHJL?=
 =?iso-2022-jp?B?UXczRFlXUndRaElLSHcxdGladG9zQjJQNDlhSnJjK1dEZ3ZPNGVXQlhP?=
 =?iso-2022-jp?B?cHpXVzhEcWtrZ1BzbXlUd25uUFhjOHc1bGtQK2lYN3gwc2lYNkRsOVls?=
 =?iso-2022-jp?B?OVpkbVhLM04wZ1JHZmhGampxbUx6dWRjRm9Nc3dYOEl4L2xEbTU5bVNE?=
 =?iso-2022-jp?B?NXFISEtpMmo1OFNpb3h1amxYd0cyOWFkWFA0dFZ0aTlJM1QrQWpodnVp?=
 =?iso-2022-jp?B?YkJXVjMwVmpCQ0xKTzB1dTFUVml5UHZJcFlKcHNheWlwbE9oUUVTeHVu?=
 =?iso-2022-jp?B?UHkyQWs4aFhZSGFJQ0JqWnd4Z1grVjJIMDZPOWtQZ0FNeDBrNU5sZnM3?=
 =?iso-2022-jp?B?eUJyaSs0UlpIR0VacmcxUk1mRWFWczlVUGxGZElCTUUrdVNNR0R6R0ps?=
 =?iso-2022-jp?B?K3JjdVJHclU4TmIzbGFOYWJCcFAveUVpVlBoRytpRXhiaFNpWUhtVEl6?=
 =?iso-2022-jp?B?MEl4TzhIZ1VLeUU3MlpuNk5mWXNCSk8waGpFN05WUGc5N2xOM24xK1NS?=
 =?iso-2022-jp?B?QndYTkx2UHJQM2d4SWxpQUdFQ2lGOGNZeDdsU0x2NWtMWGNkSGpDempl?=
 =?iso-2022-jp?B?VVpLQ1lhZC92SjF1SWRqWXp4ajVESGpEaWRTdkRBYnlVeUx4THRMUUZ5?=
 =?iso-2022-jp?B?WFhxcjZDWEtyKzV4MU5laGE2M3FqWm9TY1o0RnExejB1cmJERi96Y3JR?=
 =?iso-2022-jp?B?WDlVTFJVOC9TdHd4bGcyTExWOFM3bXRmY0doM0gyOEszMTZQeVhpbER0?=
 =?iso-2022-jp?B?L2g4bQ==?=
Content-Type: multipart/signed;
        protocol="application/x-pkcs7-signature";
        micalg=SHA1;
        boundary="----=_NextPart_000_0087_01D88C71.4415EBB0"
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6948.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 673ff152-9029-4d54-145d-08da5a3cf7c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2022 02:05:12.7550
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JY6YcYf55UvzNC+IQk0ZCccUOf+yTrXSq7ME53yCLoRtSTrkEkjPCMBQf4ssc3O0etQyKYyggvyG6Axi6BMiEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6536
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

------=_NextPart_000_0087_01D88C71.4415EBB0
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit

From: Bart Van Assche <bvanassche@acm.org>
> Trace the remapped operation and its flags instead of only the data
> direction of remapped operations. This issue was detected by analyzing
> the warnings reported by sparse related to the new blk_opf_t type.
> 
> Cc: Mike Snitzer <snitzer@kernel.org>
> Cc: Jun'ichi Nomura <junichi.nomura@nec.com>
> Fixes: b0da3f0dada7 ("Add a tracepoint for block request remapping")
.. 
>  	__blk_add_trace(bt, blk_rq_pos(rq), blk_rq_bytes(rq),
> -			rq_data_dir(rq), 0, BLK_TA_REMAP, 0,
> +			req_op(rq), rq->cmd_flags, BLK_TA_REMAP, 0,
>  			sizeof(r), &r, blk_trace_request_get_cgid(rq));

Thank you.  I think the change is fine but what it really fixes is
1b9a9ab78b0a ("blktrace: use op accessors"), where arguments of
__blk_add_trace() was extended.

-- 
Jun'ichi Nomura, NEC Corporation / NEC Solution Innovators, Ltd.


------=_NextPart_000_0087_01D88C71.4415EBB0
Content-Type: application/pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIISxTCCA3Uw
ggJdoAMCAQICCwQAAAAAARVLWsOUMA0GCSqGSIb3DQEBBQUAMFcxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMRAwDgYDVQQLEwdSb290IENBMRswGQYDVQQDExJHbG9iYWxT
aWduIFJvb3QgQ0EwHhcNOTgwOTAxMTIwMDAwWhcNMjgwMTI4MTIwMDAwWjBXMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEQMA4GA1UECxMHUm9vdCBDQTEbMBkGA1UEAxMS
R2xvYmFsU2lnbiBSb290IENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA2g7mmY3O
o+NPin778YuDJWvqSB/xKrC5lREEvfBj0eJnZs8c3c8bSCvujYmOmq8pgGWr6cctEsurHExwB6E9
CjDNFY1P+N3UjFAVHO9Q7sQu9/zpUvKRfeBt1TUwjl5Dc/JB6dVq47KJOlY5OG8GPIhpWypNxadU
uGyJzJv5PMrl/Yn1EjySeJbW3HRuk0Rh0Y3HRrJ1DoboGYrVbWzVeBaVounICjjr8iQTT3NUkxOF
Ohu8HjS1iwWMuXeLsdsfIJGrCVNukM57N3S5cEeRIlFjFnmusa5BJgjIGSvRRqpI1mQq14M0/ywq
wWwZQ0oHhefTfPYhaO/q8lKff5OQzwIDAQABo0IwQDAOBgNVHQ8BAf8EBAMCAQYwDwYDVR0TAQH/
BAUwAwEB/zAdBgNVHQ4EFgQUYHtmGkUNl8qJUC99BM00qP/8/UswDQYJKoZIhvcNAQEFBQADggEB
ANZz53xPdtCNv+y6or40xSgytXz8bJwsK70JnlO/a16qEUi25Qijs8o9YU3TRgmzPsOg42NVG/K6
76054UO5OKPmL4omO++gUFb5xgr9OM3EC3BRlJeYBN/DX5TVFckUQZzEXXVkFQ3/VTDsho//De8s
uWNG9qr837xp/S4SSGSa4JXwpu8pjwGxFbUMHaX+aSxpJHges6cccWLuysiXrBddisL4R4ZuKsRW
MZXQZ4mFK/lspl1GnQyqguSZUd1wt9tWPWHkauFc1vb+Pd5BzAeuY1K/U1P0K+nH/bb3gl+F0kEY
24GzBBzFH6SAbxUgyd4MiAod1mZV4vxIySkmaeAwggROMIIDNqADAgECAg0B7l8Wnf+XNStkZdZq
MA0GCSqGSIb3DQEBCwUAMFcxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNh
MRAwDgYDVQQLEwdSb290IENBMRswGQYDVQQDExJHbG9iYWxTaWduIFJvb3QgQ0EwHhcNMTgwOTE5
MDAwMDAwWhcNMjgwMTI4MTIwMDAwWjBMMSAwHgYDVQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBS
MzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UEAxMKR2xvYmFsU2lnbjCCASIwDQYJKoZIhvcN
AQEBBQADggEPADCCAQoCggEBAMwldpB5BngiFvXAg7aEyiie/QV2EcWtiHL8RgJDx7KKnQRfJMsu
S+FggkbhUqsMgUdwbN1k0ev1LKMPgj0MK66X17YUhhB5uzsTgHeMCOFJ0mpiLx9e+pZo34knlTif
Btc+ycsmWQ1z3rDI6SYOgxXG71uL0gRgykmmKPZpO/bLyCiR5Z2KYVc3rHQU3HTgOu5yLy6c+9C7
v/U9AOEGM+iCK65TpjoWc4zdQQ4gOsC0p6Hpsk+QLjJg6VfLuQSSaGjlOCZgdbKfd/+RFO+uIEn8
rUAVSNECMWEZXriX7613t2Saer9fwRPvm2L7DWzgVGkWqQPabumDk3F2xmmFghcCAwEAAaOCASIw
ggEeMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDAfBgNVHSMEGDAWgBRge2YaRQ2XyolQL30EzTSo//z9SzA9BggrBgEFBQcBAQQx
MC8wLQYIKwYBBQUHMAGGIWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL3Jvb3RyMTAzBgNVHR8E
LDAqMCigJqAkhiJodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL3Jvb3QuY3JsMEcGA1UdIARAMD4w
PAYEVR0gADA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0
b3J5LzANBgkqhkiG9w0BAQsFAAOCAQEAI3Dpz+K+9VmulEJvxEMzqs0/OrlkF/JiBktI8UCIBheh
/qvRXzzGM/Lzjt0fHT7MGmCZggusx/x+mocqpX0PplfurDtqhdbevUBj+K2myIiwEvz2Qd8PCZce
OOpTn74F9D7q059QEna+CYvCC0h9Hi5R9o1T06sfQBuKju19+095VnBfDNOOG7OncA03K5eVq9rg
EmscQM7Fx37twmJY7HftcyLCivWGQ4it6hNu/dj+Qi+5fV6tGO+UkMo9J6smlJl1x8vTe/fKTNOv
USGSW4R9K58VP3TLUeiegw4WbxvnRs4jvfnkoovSOWuqeRyRLOJhJC2OKkhwkMQexejgcDCCBQ0w
ggP1oAMCAQICEHhKqRA/pb++3nUIsTSTHQAwDQYJKoZIhvcNAQELBQAwTDEgMB4GA1UECxMXR2xv
YmFsU2lnbiBSb290IENBIC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2Jh
bFNpZ24wHhcNMjAwOTE2MDAwMDAwWhcNMjgwOTE2MDAwMDAwWjBbMQswCQYDVQQGEwJCRTEZMBcG
A1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29u
YWxTaWduIDIgQ0EgMjAyMDCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAL2wplwnLG2f
2tH0SEDAcaeICZ58np3hWKRLTcna2WfhnikjHR4g4Fw9VJ0UiLnSqPpqEOmJQjruLa1VjvxIl32J
yu83qKduq8tUaSraIAe/ztdec7pbQM+uMnUGC3vmtXv3M5AC4N7IE3DjnBWU15N/HmqrF7IqaF9b
7Dbq6j7Zwtu01rAO6ZOLil7HBY5HlBPCWbvQQymrMGcoMQTjwUAcKwOfttFsZZOpNXuhCmmjWjWV
Mt9KtwKxH99GQ6V8nwrYl57qY0ivFlNnCuKrBLY9PSUuPpoYtAkwqwp1wM7pt7YHB3B0YNKa3Es8
xFA0FqBccrqsIsIR7t7D0DZhTjMCAwEAAaOCAdowggHWMA4GA1UdDwEB/wQEAwIBhjBgBgNVHSUE
WTBXBggrBgEFBQcDAgYIKwYBBQUHAwQGCisGAQQBgjcUAgIGCisGAQQBgjcKAwQGCSsGAQQBgjcV
BgYKKwYBBAGCNwoDDAYIKwYBBQUHAwcGCCsGAQUFBwMRMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYD
VR0OBBYEFJYz0eZYF1s0dYqBVmTVvkjeoY/PMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i
3Ru8MHoGCCsGAQUFBwEBBG4wbDAtBggrBgEFBQcwAYYhaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5j
b20vcm9vdHIzMDsGCCsGAQUFBzAChi9odHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2Vy
dC9yb290LXIzLmNydDA2BgNVHR8ELzAtMCugKaAnhiVodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29t
L3Jvb3QtcjMuY3JsMFoGA1UdIARTMFEwCwYJKwYBBAGgMgEoMEIGCisGAQQBoDIBKAowNDAyBggr
BgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wDQYJKoZIhvcN
AQELBQADggEBAHQF5P1wpw3gDnfZzRFL1j8W5TkP+aP6ujiHk2L6BL1FItqh1DrW34wRnU6bRbF1
3uEYI1RfW+g7os4GH8vnCC5r4uYX5NyKvDAGbILVvgP6LULCbytsEWrSxOtUW85F/PfzlxGdc0+7
f6tkYias6b1fDQocSI/j+1k7XqT5vQCI9CnrnvoEtqr8wGQGN+GWXkR4AO4OTuEzyf6E3fuK4IlP
vsCw5XGWHf7JRZGk98YOKlg3qRDI0+E9ahTkCC/oo1AK2EuKMKT4PTSEkymtaqiliYxaMprNHdBs
Dp4iCGwb4SNjCewUmPTGLVlU+YyTt7bFR8I+HKfdgkhbhsLpxTMwggXlMIIEzaADAgECAgwO+efB
Kgmslz77fEQwDQYJKoZIhvcNAQELBQAwWzELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNp
Z24gbnYtc2ExMTAvBgNVBAMTKEdsb2JhbFNpZ24gR0NDIFIzIFBlcnNvbmFsU2lnbiAyIENBIDIw
MjAwHhcNMjExMjA2MDUxNzI2WhcNMjIxMjA3MDUxNzI2WjCB7DELMAkGA1UEBhMCSlAxDTALBgNV
BEETBDExMEExGTAXBgNVBAwTEE5FQyBHcm91cCBNZW1iZXIxDjAMBgNVBAgTBVRva3lvMQ8wDQYD
VQQHEwZNaW5hdG8xGDAWBgNVBAoTD05FQyBDb3Jwb3JhdGlvbjEnMCUGA1UECxMeTkVDIEdyb3Vw
IFN0YW5kYXJkIENlcnRpZmljYXRlMSgwJgYDVQQDEx9DQy0yMTQ5MVAzMjEyMzAsIE5PTVVSQSBK
VU5JQ0hJMSUwIwYJKoZIhvcNAQkBFhZqdW5pY2hpLm5vbXVyYUBuZWMuY29tMIIBIjANBgkqhkiG
9w0BAQEFAAOCAQ8AMIIBCgKCAQEA4Xk01AQsJLT0nBNqyIrzkwP2bWrpCq74yoIHLzvyqQrgEU2C
VYazZwQR2dRDP6tLhz83LrgJpIke1INa49/BLUJp9FAfPVTCZb0j4kftbCj5R3O/JHFpDy//9Cx4
9osgejC+Y0HmP5onVmEe4tKxG3hBFoVhLyUU+LhusvQ7SRrjYU4Bj4qjv1rhUZLzAas69+B73ehF
dA0c+fBZ3V+eAWQILmGSkbWc3uXZWK5pR0cB2ZJxC2eLlMCMdWNVyZxbt+aTC2R4Sw0FQ/iuf/4F
Ar8qFoBevR4qmyZq11asIidufyscWOhplGshENi7+rzYTd1HioynChC67q+rL0K86QIDAQABo4IC
FTCCAhEwDgYDVR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0
cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIw
MjAuY3J0MEEGCCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVy
c29uYWxzaWduMmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYm
aHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8E
QjBAMD6gPKA6hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24y
Y2EyMDIwLmNybDBJBgNVHREEQjBAgRZqdW5pY2hpLm5vbXVyYUBuZWMuY29toCYGCisGAQQBgjcU
AgOgGAwWanVuaWNoaS5ub211cmFAbmVjLmNvbTApBgNVHSUEIjAgBggrBgEFBQcDAgYIKwYBBQUH
AwQGCisGAQQBgjcUAgIwHwYDVR0jBBgwFoAUljPR5lgXWzR1ioFWZNW+SN6hj88wHQYDVR0OBBYE
FLri8sCe/FVMIHLIr512r1mpmJmEMA0GCSqGSIb3DQEBCwUAA4IBAQCMiqvivcAx1ZHBbcdmA7/z
ZBddJ+hSWAmZE26ZTWksq+WvzX1get6KGMu+6f/KqrBcxCukH+ajNIkaFcJFh0uoJEkbhXzvyqY0
RbFVAF7OF6bC7kySTjLQUB3c1AzfAgl8/JyYf5s2kjNVqP3FqDUkW0zGa5+LOzXhfy9NBLy1ZciL
JAFB1rSkRfRiIBUZaQS0P7qwRSMu/8NckySUoGbE1Yi20dCdKRyUgAoGnhr3mVJ0MNSHwr9FTDPv
eaL3cOR0P6Qr9lE2qmHvfRJQWxW3ufPiaTeC9o0NWDW7tcLDVTrYjavXMMR0yaIr9R7XJka/hMCp
puI9qbISANymP36AMYIDgzCCA38CAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFs
U2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29uYWxTaWduIDIgQ0Eg
MjAyMAIMDvnnwSoJrJc++3xEMAkGBSsOAwIaBQCgggHtMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0B
BwEwHAYJKoZIhvcNAQkFMQ8XDTIyMDYzMDAyMDUxMFowIwYJKoZIhvcNAQkEMRYEFCpyvkY4W4Wr
xEctUACSQ9yTuam2MHoGCSsGAQQBgjcQBDFtMGswWzELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEds
b2JhbFNpZ24gbnYtc2ExMTAvBgNVBAMTKEdsb2JhbFNpZ24gR0NDIFIzIFBlcnNvbmFsU2lnbiAy
IENBIDIwMjACDA7558EqCayXPvt8RDB8BgsqhkiG9w0BCRACCzFtoGswWzELMAkGA1UEBhMCQkUx
GTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExMTAvBgNVBAMTKEdsb2JhbFNpZ24gR0NDIFIzIFBl
cnNvbmFsU2lnbiAyIENBIDIwMjACDA7558EqCayXPvt8RDCBkwYJKoZIhvcNAQkPMYGFMIGCMAsG
CWCGSAFlAwQBKjALBglghkgBZQMEARYwCgYIKoZIhvcNAwcwCwYJYIZIAWUDBAECMA4GCCqGSIb3
DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMCGjALBglghkgBZQMEAgMwCwYJYIZIAWUDBAIC
MAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCOrdd7WAIvgRfPSgkhDc1ySR6EF1EL7Y6V
hrhm/MRIwIXEc0TnTA5i2CNd/q3LTwhhyNV8PL+eMfCeJfRWYiUic20YYyPEsy6f86RSxBTAQ/pL
xyvtczvX+0tEzkZQDhQmz2xDLdtvQzcg0Z5uihgqKXDdnKB1+l4CVNgk6pw23o5Z9Kt1MkA/O4sU
NhI827UWYONO5uL+RaqXCbAF4XKoIra2Hur6uKxolAsEdE4EtZq4AXzR/cu4elioeKKaZzJgh7RK
5svdmlrbClzSF0niMvSiLwLYi70KLZE1MN5x8emA0y76j5T460FkbXFyWKhRzIks3ZLkjOJsKNPJ
75yXAAAAAAAA

------=_NextPart_000_0087_01D88C71.4415EBB0--
