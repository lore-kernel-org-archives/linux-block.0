Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D235C64ED6
	for <linux-block@archiver.kernel.org>; Tue, 28 Feb 2023 09:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjB1J0G (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Feb 2023 04:26:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjB1J0F (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Feb 2023 04:26:05 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB8E244A9
        for <linux-block@vger.kernel.org>; Tue, 28 Feb 2023 01:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677576343; x=1709112343;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=nPgBJ+py2pYEKBaTL5FVv1VvDpljAuJPR3pC5BN7ok8=;
  b=pxqwbODrK+CzB5amD+TpUmc6/ix8Pp20ikjJEvuCGzsyzsjpqmECS071
   nEPqiQlvi5QyXdvRtqSlaJpCTt3osbcCKXWtScxck6btvwkhsaeDPQ8ww
   8WPc+2hDnVvyHZQkPPxBfPthyEW/B+CCNiCAACHVuV6zr+iBhchfUZ/Zw
   jXq+lvZc5UuFezxDZK628Pf63P6xWGH5rfPaawQ54LbepWQRocEj0Azwk
   yOGuo3y1tPeHQlvNEUqhUO6fCdOVhbS52utDFo0gjdEL8KJ7jL6VTEZod
   fgyFXbFH1ta4+zHfC1CUP9Hcp++yz6KhPmGNco35krGSq5T0m1ZCU1Pp8
   g==;
X-IronPort-AV: E=Sophos;i="5.98,221,1673884800"; 
   d="scan'208";a="328722915"
Received: from mail-mw2nam10lp2100.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.100])
  by ob1.hgst.iphmx.com with ESMTP; 28 Feb 2023 17:25:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EN22dGyY1am5tPbK5DzH0bbCWU/7Ta2SH8Me00rCUX7RZ5uuQcgLE1RYjfwpsgEptlv1HYlZuYVlDS8W+RjL+gtkdGM0M+w6gXOg3GDsEikYzZGEjRDodFXieIr2zk8xbHqdXi4TyE3BotFGKYLR23PWp9/yWUgZGCqYeuhb8SpVNGzKtY9lF0kuCdh93hAi4kUAfkvWvtT7VS8FuUFb5hX6frrgqS3RlszUGL0l8wtA1oQvc6rbBZHuIC2XN+dJxGLEoHH6NCqOWl9X2ZYINXUSt172Ry0w/zfi8JD66Y7E5j3ITTClsJhH5fsRAShEw/iVUkxLmJEQC+6RRb4N0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nPgBJ+py2pYEKBaTL5FVv1VvDpljAuJPR3pC5BN7ok8=;
 b=g3cMs5yfgYclqPVc+trnqjojMcVWla4OjghsmMfO0ZGZLCL915KlIToczcIvIU3MXTReO8Iv23JdXd/Z/A9RbL5BrBiPkJJB/tuywMGPwSRlGNqgPlKEmf1flizO0qwiRx0uqTPpnNdlpZkuzX+wTE/7Iu19c1qmek+ws7Kr35x7Cr7gRAjan+BKKZvqhcnvomeiuDO0yhAvzzUgVpvu8rdnN1IVaP/DD6vXOuo2Y1avRKx5diGJx0Xpd8tUwMnfL2+rOHskn9V9/aA7um6pa/0C2hPbNfqzA6Ff1GOd5HcrTT2FVVT/To04w6UAQG+PVJvGwvIY3Yqa5wQTHaAdeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nPgBJ+py2pYEKBaTL5FVv1VvDpljAuJPR3pC5BN7ok8=;
 b=rtj3y1scan7/+WVDAXGAADe7j5cqOrM570amoyHbITzf3pyu1vKM0nS6KOIpjmy4nOeRdF27TrbOU1LCHMIceL75cbk04XfX1SMh2H/wAxWsERVfTRNUtbhl2e4k92kpKNv/pqsxWDoadoTNCNlEkbqxu48p6HoMNWsJQckTlKo=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CY4PR04MB0855.namprd04.prod.outlook.com (2603:10b6:903:e4::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.29; Tue, 28 Feb 2023 09:25:38 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::1b90:14dd:1cae:8529]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::1b90:14dd:1cae:8529%7]) with mapi id 15.20.6134.029; Tue, 28 Feb 2023
 09:25:38 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
CC:     Ming Lei <ming.lei@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests v3 1/2] src: add mini ublk source code
Thread-Topic: [PATCH blktests v3 1/2] src: add mini ublk source code
Thread-Index: AQHZRN4GILFJJ+eZuUC9lhofX/G5Ya7dwCUAgAAKEICAADYNAIAEJJqAgAAtsACAAAf3AIAByPyA
Date:   Tue, 28 Feb 2023 09:25:37 +0000
Message-ID: <20230228092537.aehmwlqsdacg5eyd@shindev>
References: <20230220034649.1522978-1-ming.lei@redhat.com>
 <20230220034649.1522978-2-ming.lei@redhat.com>
 <a20a449a-73c1-c7dd-b100-89e346c35828@linux.alibaba.com>
 <Y/h1LQbf+brRw1mo@T590> <20230224114156.yxul4qb323pswteq@shindev>
 <f20ad4c4-fc74-0bea-a07d-8f6c8a028754@linux.alibaba.com>
 <20230227054130.eygpm5e22yejug6t@shindev>
 <cfccc895-5a9b-f45b-5851-74c94219d743@linux.alibaba.com>
In-Reply-To: <cfccc895-5a9b-f45b-5851-74c94219d743@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CY4PR04MB0855:EE_
x-ms-office365-filtering-correlation-id: 8ed636d3-f3fb-45e1-b626-08db196dc0d8
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /7WbfOWtpYSavOOhSq70fOqcKbf9tvLlerDU0svjNs/pe8kY4pWsSC4sRHoiBJ64Na3vrWcxw4/wgPZmTU8V5r/jyriLtKOJCMneAYMx01l/lJKGkMfwWG/5rOk7KnMTAeSSz0C1XLguSiK3Vn8ip1OUldMxpfkRzX2hN4V4P385Y1ShWmqWdpnubxP0ddOtfjq7vEESVkWcDH+d78iTWpQaYp8lYkGBHa2SGJhuf0X1BOt3MhlfwCfgU2GEOBipDFIe9IauAxrbnjmnCwB7PlkjTOxz6C7JQD7L2x6rNtGi5OBo+APUwCTQqG3p1Y7ycUrdPA6Ku8JrJ/QBYvTtv9BRZ4FfqZDzOwD5ooFJSe6jU5A/kvtOBWAa/6FuURCNHrDQ9XmPV52b9RhdjqoodzZyfr6/liLjydAlK78ec6WQYoskuktIYAjXY4HrQCrZBRTtVQDuuHC5hRNylVY+YapU0d0QHhU01fVY4Ytp/PifaWMMDNspqxi1h5dOkp0Di2xNAX6GoGv8JC3Uf/90pvRwdW7YBiQCqWZ0cg7am0Jp809Z3issfc46Zgo1y9GLu2sIUnFIg9j/9If8R/bPD2DhhYYfZ34kzPYa/4IlS1W9j3jVgHbqPiSXu7mbSbF9c+yUCpyaHCa2d14lkClzJvZ3hbCACrzRzY4gftsgwP4bgZcx/FXPnPVNCJdU8XCZw8Z6bKgHWb4X8WRw3uqMhA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(7916004)(376002)(39860400002)(396003)(136003)(366004)(346002)(451199018)(33716001)(478600001)(558084003)(54906003)(4326008)(122000001)(6916009)(66476007)(8676002)(66446008)(91956017)(38100700002)(64756008)(71200400001)(6506007)(316002)(186003)(6512007)(9686003)(26005)(6486002)(82960400001)(1076003)(5660300002)(76116006)(66556008)(66946007)(44832011)(8936002)(86362001)(2906002)(41300700001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Fv3zzG2qECC5VSnxV+RT7pm5wy3XEHT1hKmb5JngZTs2lSXZnT9RgT+ypgqx?=
 =?us-ascii?Q?TlqfbMgGXD3L5Ax2YnQ8CzwTTEKkCaIbLrCY0hwu722hlawCZsdN0NIzBpSU?=
 =?us-ascii?Q?/mrwIsFWtxQzsPxA3C6KEAGmBIpQO/9PVSWB0htsX3rBVadHLgfmj8hWyZHZ?=
 =?us-ascii?Q?gxLgKg9itq+YNwDXC6h6FDC/1qmASptJoZS9THExDXqBU7AJJV2I6zoE7Wly?=
 =?us-ascii?Q?10rKr/On6M8ccgSv5se2VEfsZH5p2zjKbn6cEnWKVRK5HupU6ya2QajUPFSq?=
 =?us-ascii?Q?a9JFtlDzMpoS84oPLDgZavR/X6Qp36Dg3dkx+7PmDIxwZIZKdQHkqipaF5sZ?=
 =?us-ascii?Q?O2X0+3Y8AcPjsMg8K+UY4f/hXTeMk7Rh4BYV78cftBHgeIEIdVqEt1D2twpm?=
 =?us-ascii?Q?QiuVDbve7dm6pQauKCqqDzsue9IlGwkzo704xTBWNzDEijfo41s/iO6Tl//y?=
 =?us-ascii?Q?+9fYY75bgIspQs/y/U17BwWrIBhxedBUDAyCP890c3UjddbuWffkkhFaQ7su?=
 =?us-ascii?Q?g2FTLxorSwupYOMDrBdU3NqvkXfJCPVmW/6Ntc9HnJd3q+Zc32aj1TXNRwQO?=
 =?us-ascii?Q?fAKc98GyEF8+xdyCoDpU0bI5vt6cGFbY2E9ZJREJyRpleHmbaKmVS+CuHlet?=
 =?us-ascii?Q?TbhN1hH70WQewbpZ/IVEim2QFVTxViy/WC4N0Aqvz80Ap+MNndJV89GKs28C?=
 =?us-ascii?Q?5ttoH8BXtFJ5VRgpfc31SmzMXVd8XKBnktMJgrxXnan66Tii5nb+N8ZH+XHp?=
 =?us-ascii?Q?FA+Uupso3Lq7hQBnVB03g96kccAg+EKbL5hwvg30vkSrHx1w6qHBtXoGC3Ed?=
 =?us-ascii?Q?Qqj2uleO3qKrRpJR5/ci3UtUHLM9MGv3ywswVI0BI7O3u91VT0PiAH0mbs2U?=
 =?us-ascii?Q?qtdMML7rupR9/yj731lXT3SZzV9yTmShnaJUlQf8iWKFHSNC33jwWtIdWv1b?=
 =?us-ascii?Q?YXVaD7W0xX2O1/Dk4sl/UkE4Yt7XX9sZiNfcaoU5RLOmeFUZ/NcoaLWrMmNT?=
 =?us-ascii?Q?8nuLX5/MHn3iGF+96+FOJ8aky3QfZ6tSKuuNhWNevGJT9S0Fjn5jwxCBmfb2?=
 =?us-ascii?Q?qikZRb7XpjZDz4XcUJ+ez2LQ+6jix+j6HvhXI3uat4W8lYEoxXu1L85u/FT4?=
 =?us-ascii?Q?ZPk8iYpCa5vZub7mNew8Tx1O20i+7zDdGIeJwutm9TqsWWR8CO97aaZsf9L9?=
 =?us-ascii?Q?NYeonCScEBtsRSuLKZypP8ssULMYcJhMn1mX6GDaWpijEhe1g2sSU3F+1H0N?=
 =?us-ascii?Q?EQOFvoU8qmSUAvpAXM5s5heWiHK7i6AIp+JE0YJGSAL/prB+JBtqfaDpNjzH?=
 =?us-ascii?Q?RoZDIvNheMmTA/8vF2BQLFDzD+8uRqRVKMCytsLb/yYqNUIdCBAn69cc3Z1I?=
 =?us-ascii?Q?5OJMWt2MypwOGr6DIdPBmIGa98Af4VSBngd/4yVWJIP9VRw7kCamgzSKWHh8?=
 =?us-ascii?Q?XhhOdr+JQ84+WhDG78YaLoLlVPSjZKuP0xZ8RvFmyMgoGPi/yMNKxuSj4WrC?=
 =?us-ascii?Q?HRwDATWxK3vg/strCCYUjrf+DZcWiztzwXRNgRTeXsdpskMz82YNKvnj44Qa?=
 =?us-ascii?Q?z0oaQxUlL9dnzX2rKapdoFw9rUF6YJ7RTqmFAD9U3KLuzogDqsVUT6/O3Exi?=
 =?us-ascii?Q?fMWcyR/dTjkkOdeTmyEPDpU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5F37E7E8D00A4E4D963A9951CE1E47C2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Qfo9IMjQBhQ34PHtEkRaWayb/FaWmP6HUi4Rmxu+6OqoNXwGjPMeTGYpAsRY5zgzpGVfeDI6JJSXnuDClDIIiGexSVv01UqnF+WKdtuCyPfQiH5I2lXQWldv/QV8Rz3FT5efW13lMhqtb3CgRCjHX3OefxFXG0+Au61PI96wlMrR/8SYjfbC8G6/NzCwwj8ITmWSIP8W754QOW5jSFbdc1GOQxOPRAxeDolOB3A583eU/NHATwmAx/9T3FkPvxmESWzv/UoW1t3Zh43Gx9CBCFipw8pfZt5XnM4Zh29G1PrZi1IFGXMAi3wMqc4yLyc0Inip3M2YBaHhnnuSs2Z4vXcw+orZeWWIpBgHMfl7am9zDcWwmHCgfPFo3Ge/dC8kbABxZfcpxjKKFzuS/OAca7BdISgr2HO2vchb8yo1GJTQllL8mf9Wj09pXOWrd7ejjVXKXX4aDbFHm7qdEPI/X4D3GpGCxQV6+F1IErrfGzRPc4ZLTF8zrbqoOm4sz3sXF99KTBcSNF2jsMADxKvcSlsdwSyhPOGuE0CFoiMtV7ddvVkRcXY1lbimgS16SyNYA5Z1KtXNrxDPb4RDzeCRiDm61TmYOeGGOZ/pWS+b4vRr9UVLDyyM7NU2JUOv/vOtBo9izzRJh9lqQiJv54difgGDtA4TByH3EL/X3LnesvHI/tOoP5mmCVFGsWwBDqmvHtZ+VBN/IaEtMc5d0HFJQYCmohfpgm4Q2Am67vMrxkMd0jLU0M62d0yPCp9SMakJoHHQpk3avL+XFJ3p0kVP3A1GCIKim3DdDNOGFG3S6brX9EA1ZuhUvKK0FoTVPFnjcuC11UEjIWnnI7ivG1ytN0Qe9QnQ6ngkcTqcqR3Z2DU=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ed636d3-f3fb-45e1-b626-08db196dc0d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2023 09:25:37.9989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sBAyNPZ3NzFUsADlBoefLnEoqqlh751ZNPKT3hN2TwF+ZmnbBajQFAC2dwJ8licomEjG/ToRcAA0/isHy+zUHoDF88kTiE2iQawqRhAAEe4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0855
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Feb 27, 2023 / 14:10, Ziyang Zhang wrote:
[...]

> My make version is 4.2.1, and your fix works! Thanks, Shinichiro.

Thanks Ziyang. Based on thix fix, I will prepare a follow-up patch for Ming=
's
series.

--=20
Shin'ichiro Kawasaki=
