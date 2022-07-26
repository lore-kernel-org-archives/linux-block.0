Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D76C43334
	for <linux-block@archiver.kernel.org>; Tue, 26 Jul 2022 10:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbiGZKpT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Jul 2022 06:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232707AbiGZKpS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Jul 2022 06:45:18 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07B35F60
        for <linux-block@vger.kernel.org>; Tue, 26 Jul 2022 03:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658832316; x=1690368316;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=RrbKP17BOjwMk9TP2HMRwp7qjl85hAnA2Qxm57orh/k=;
  b=J4YDqksFrKwyLCzmGqZPd0VGJYkhbpkpp5Ji70ClsBnAQLJkyamQTl9n
   tkOfCFewFCbtLa0m0znkhAIe1tH6+pm55/lUPTE/t7+U27cHXpjz9Po5m
   vAKYPdH7w0yHSAFnSoqzKGgN5ciQv6o59BHdOvD9tKN1YPnhX5teT4gB1
   /qlJiHgngtVXh9ZRbLvPJpnsI1QmzYZv+KpGP22szOZyz0WOjsMPtu8i/
   R43iOO/ltYSFlbYoEsNn5zALVCza5tXMdd2BAU0oChEsDdLTRSiNELpA8
   /CP1mMdZq+u7VL5lMFHfwUmLDzunrNOK3CfsDWG4bkgiyd09Paa7wa+QT
   A==;
X-IronPort-AV: E=Sophos;i="5.93,193,1654531200"; 
   d="scan'208";a="206919612"
Received: from mail-bn8nam12lp2177.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.177])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jul 2022 18:45:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lXeqDvjTnOzvZyGZNg7MvqoUh9UvQf15jBL8bBMegbNiorHlOfHVeVdgewkKuedLQ8iRoSFYOIBOJFQCX4o0I24p5i0L4+23IDjA/J2nju0ls9skTA/n4zqpddKBzWog+tq6jUpqY/yV0F3LqT5IB2fbS8ckk3P5m5L081fvooy6ewLxfWN4flKoDkoAVqVHbGhq0fmJnojLkb+s+o5j5Sbi1vwZLnWVdUx14hOi/7/kYZBgEa4lPIJW3Kdlu1v6ioX5KbIRsu52DQ+4BgW3qoJDh+Bw3PANsqqQ92IUjKrbHncy9+OvHOH4cHFA/TCDMvvXG7zLLBCNvUoqaiNotQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RrbKP17BOjwMk9TP2HMRwp7qjl85hAnA2Qxm57orh/k=;
 b=gR70gMsJvhp6qgFz6bBoIhc/xsdaeu8GX30zvwhJCv8hkPvdW5lFVR3ySElq4cR4lpJIA4syiI+GH+sDZLy57QWK6lwHzkOVgPlTl7o6dOxr3Y/9jDHOS2MpRufM8kK9mm8JcDHiJ65ZQ1Mba6h8zIUBH7Gx2sWHi5Ux28YJbFXAIskrOer2NVnZXi55GVSO7QtIZn8n01JNthL259ZQCt1AU7PAIewsFZJ1Woo77/70o/jahMZK5jXBzojQ9LI161hRwntEk6c9IIGNKNLiUJtUSbaWybhCw3TyuH8fPHn4Rn41YlsWP2dry2eu0wsh7SrLyrvu7Xv8qCwmmq2NNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RrbKP17BOjwMk9TP2HMRwp7qjl85hAnA2Qxm57orh/k=;
 b=sbTdoCs8+WaGXumKb7cN8yegWKWIB1qlvGr2KIcMTJYEmPdIsNm8HTrSJZ7d1ZICDhQqRkdsGmo2bGJyv7ryUNjn3Psy5wyeRgPvno3ndOJLrLO7cqRpQoaXtDN13RIcFhQX3yr1QMJXdvl2P+Xq1a4NCRi/9UAqA3kN+SEbXOc=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CO1PR04MB8283.namprd04.prod.outlook.com (2603:10b6:303:152::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Tue, 26 Jul
 2022 10:45:13 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::3cc7:ac84:d443:5833]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::3cc7:ac84:d443:5833%8]) with mapi id 15.20.5458.025; Tue, 26 Jul 2022
 10:45:13 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Yi Zhang <yi.zhang@redhat.com>
CC:     linux-block <linux-block@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH blktests v2] common/cpuhotplug: allow _offline_cpu() call
 in sub-shell
Thread-Topic: [PATCH blktests v2] common/cpuhotplug: allow _offline_cpu() call
 in sub-shell
Thread-Index: AQHYmxqR5/Sw+IEJgkKHkg74AO4wLq2QXpQAgAAkxwA=
Date:   Tue, 26 Jul 2022 10:45:12 +0000
Message-ID: <20220726104512.ciqjtkc3lfaqdvxf@shindev>
References: <20220719025216.1395353-1-shinichiro.kawasaki@wdc.com>
 <CAHj4cs_XGXhHZsipb-BA2O_acaeBjDXa-CDfY771=a_GfEaU6w@mail.gmail.com>
In-Reply-To: <CAHj4cs_XGXhHZsipb-BA2O_acaeBjDXa-CDfY771=a_GfEaU6w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6b44650c-44b1-455f-5188-08da6ef3eb56
x-ms-traffictypediagnostic: CO1PR04MB8283:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rExh4D/Bkpqa6LVr66U7F3vXDjTUmC+DmhT4+2FAImAEzmaiMjc60s3+okalOk2aTPNgYj5KuAljN+iu3QHVTldbYu/ArRb+m/XvECupEyF/Qz2Tt7ox+GOHpInqMNGK5WpfBGGN0dWBq72Gox+0V7BHQ2Z0xxNdni7fQcNulfmSAl92cH/gqTWpjiEEF8M2ftttnbaS4cGSdgpUl4zSBHmGqsKR1ttNBIVpACCCpFZ/ixdr8JgZGpDMsh/XT/nW1pT7BRr9GdqKCeY6gNLi4nKGAGBp9C1ARIqwYj8SXZ1Il3607Zm5o2wPQmJqqVeZzW8TvVUHhbzHkuOTTrglHxEMAs/7iW0wEkHiJl88yp+x31bBvqTvLm/W1Ltf51BgGNg0S+YFcfOFGqh4xPmOxZanSvrnuFX0xgf25I0ozAY8Bkca2oslv2TguogCJyMw4kB31UxGr+6vYrOgEfyxfZZhyygE8CS5fvkLBtHd2rXxce6P5JqYWRx4/0Cp/QfMJ9WrFI/T0VUah6E6ftYJsPDTnb8QxOmYPosmngWeg2rBMdhOtW3MxGM/+9dOeSanhj/ndigiUBDQkfcVdmYAkk7bnOWdnpx5ZiuyqNVtkyZ4Ikch2KA5KL2sIpAgnQLk+8uRTYaucQEq+OcYDk2bH4zLMuhQLw7Nca7YZ1dlWNQDPbdZgeUNpUHB9kMY1FRO0Gf2vUPa/bzS1+mg/MjfBT9rKh3dKxBBuW7HNDd3sHNULe4HZ0IcvlD2WGx8e1j+XTWNBRbNjYBLBGdV95QEJEVaqV0ymVeMdMu+6lEz3yqd5unku39MucsNtOwovjxb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(4636009)(366004)(396003)(136003)(39860400002)(376002)(346002)(41300700001)(186003)(26005)(2906002)(6506007)(9686003)(6512007)(1076003)(38100700002)(38070700005)(86362001)(82960400001)(83380400001)(76116006)(122000001)(33716001)(54906003)(6916009)(71200400001)(4744005)(66946007)(4326008)(8936002)(91956017)(66556008)(5660300002)(66476007)(66446008)(64756008)(44832011)(8676002)(6486002)(478600001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XAt3WKTHAvPWxUBq37tlKzI2uWVEbEsnb0yJ3Yq6oGwxzzk1+z5KtUsPQhrh?=
 =?us-ascii?Q?IBHDPeCBBjrHWArrBruBNem9+XspslOluVnG8qGAq9Kd3ujvcRQdiNbIE7u0?=
 =?us-ascii?Q?I87BKiIdn2CaaV+p+qotqsOBT5+WcRQehzQGPeieDM38eEGNTwtHu/d1fXqA?=
 =?us-ascii?Q?OrsiKHkPE4Mclydtx9ZQKcz9L6Ynx8xBziNBUZNqnVPDmyY5rnj89NFivlqA?=
 =?us-ascii?Q?OHWZi5Q3XYKVXpj9+RJGLD0iYLI2QCBC5zDPqT1zMMU0MBWYZr0KwjAlIsOM?=
 =?us-ascii?Q?64mdAia8VafxWDvbltMRy6YY88umf5ckrbRS30S5a4hfqigHQWmC6jQDrRyY?=
 =?us-ascii?Q?8uONoMDlWIA6BTAfmmpxSAiXkfnBmFAhDwdl2lZ/qnNxGgrPCsf/P8kyS3p+?=
 =?us-ascii?Q?qs6gVUhsUThbzpecjd7+aGI7hOSh2ofrC0GAZX6h35JFly5GkdftEbKN1X6M?=
 =?us-ascii?Q?hrQVVbpbpAkg5X9u17UDWNCe66S+eAE+KBySA9BxszMxGPmHUGCN0RX5woSa?=
 =?us-ascii?Q?hIqBhH5g/5gg67wzoAXf4DnIcB/ti1KCJ3rY3M60SiO9JHef1xpm7mMdzaHZ?=
 =?us-ascii?Q?Pr0VUlfvlCvSShMlH7harvRYarf9bvSv+bZWmB/5uCD56vLQLt3N0FZCMqJT?=
 =?us-ascii?Q?9PGdrlvgcVR35SrpTTVfv8SmgXk16Jgioyi7+8LIWtGbfbJGR65DO8uue26r?=
 =?us-ascii?Q?Fn2U0ZAUA1zhiEDFm4b1cvVETdgGCsMJeNxJC0ZOJzM07b8kok6QfVVRbHbi?=
 =?us-ascii?Q?tcgZbjOQfwT3ggOpxu+Z1rlRVQHjRrnrg1yH6Ie/i0PVMIbW5D7gX9oBff8E?=
 =?us-ascii?Q?rCA2I6n9PXVLrXcpCxDpdQAXiqC1+52v+eDA0xZxUCC93I1+OasQ5ZLzR8+V?=
 =?us-ascii?Q?fr40xJu8lbydwovByqJgBllszQwE9j1mcGXlRGbBAIHsgYfM/3hA5Ul1Sd3a?=
 =?us-ascii?Q?VmysWV+eOwzJXkQz4eDPg7prstUVnDVwIhWxZTRu/GB7P/2sGnMGiqAIhpF1?=
 =?us-ascii?Q?Y/kww9UTnH9LM0cEqr+FMbamvG9mjGzT8OUltid/fz92VMKhdlJ35VyMbnIv?=
 =?us-ascii?Q?xBdIS/Tq7KiiLzTLtD4XnrB1DiKmdjcl+qvtOf/eGjJkcAIUyfl/bSQr8l4E?=
 =?us-ascii?Q?3pjqgQWbfGfFZ2uAPzxMLkCMwjvIH5DXWTLb+/Zc6vMU0bE82aBXn7w+MDFz?=
 =?us-ascii?Q?5voAdpUuXo2OCO3gcwvWdcI6FFdgRhcCBGwQapzNMSzRse6ra3rBs4G7e5Uc?=
 =?us-ascii?Q?9O8XhDlBva9M81evW9q/+na3iSntTRKY7Ey11xrawu4hUMuofVbvnJ9znZdJ?=
 =?us-ascii?Q?PvYWozZBQlFRfkOFbfQLf3RY7MWLwcg7OViJpyvS1jFgziEXr58RsqfTaahl?=
 =?us-ascii?Q?3037LU135bOoLPBc+3HSLLprFxHnw8kePcvCIs30bRHrU7+WsSJv6U8AJ7nI?=
 =?us-ascii?Q?KqBY9u17kBNk9KVxwmXOBTsrWtmnUECW+lVstVpTtMotEN2ib6loFg3lzXYG?=
 =?us-ascii?Q?quo8Dx9vYWoeDlIdYb3LA/KNJqXt7v6abzLpOL1buGpdFoGqXAMbZIvRVhfb?=
 =?us-ascii?Q?WRVe6kMTyh7GJBcJ6nupdYGMZQOqW7A2y7v3dRBmUevha5h5vvUK5Me07+wO?=
 =?us-ascii?Q?RSAvK3foncye67/JPU2n96A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2646527DD6307744BE61875EF7A90682@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b44650c-44b1-455f-5188-08da6ef3eb56
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2022 10:45:13.0288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cub5cXjIf5huHi8h2O8sKNklFbWPhcbMOkxupm+xb37/ny5vtLogE191LwWxbxzYyGqI1zCY8DhVvDDy1NNfAFo1T/PvBWRoG19nnQ8Ds9s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR04MB8283
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Jul 26, 2022 / 16:33, Yi Zhang wrote:
> Hi Shin'ichiro
>=20
> This change introduced one new issue that the offline operation will
> be skipped when there are more than one test devs.

Yi, thanks for finding this. Then this v2 fix is not good. Tomorrow, I'll d=
o
some more confirmation and will revert v2 and apply v1 instead. v1 fix is a=
 bit
dirty, but should work well.

--=20
Shin'ichiro Kawasaki=
