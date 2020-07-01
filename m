Return-Path: <SRS0=s14/=AM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D87C433E0
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 18:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C2AB20760
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 18:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="W/PGlhEA";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="VhX9ci5J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725875AbgGASpq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Jul 2020 14:45:46 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:20385 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgGASpp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Jul 2020 14:45:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593629144; x=1625165144;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=oqYQDSzXpgelKKCWiRCPMd1zLj8/PBy7ggmINwbfIec=;
  b=W/PGlhEAH2WOwLQYTeO+praudm9Bs2MxwjJsmsJYPLrGvf78LDArEWDN
   xD/SfxYIIKVOrpNzS4YDsuAVSE5U35expoMNWwbtnoCEGa0LR11MVTQJT
   Gi2oHYgs+zAN4W3n/KhiPE2krdvHefnPRs2T25noujLASqSfGHSutvSUX
   hGPbuCvW6+hovk7j1SXb6RmvLCCaKVfgztGmyLjW1K0HAseJhglr5S7rZ
   tO+/rTZ10oa1r4k8Fx7mk/qW62E8Z6cUmim3cV8JTJXEEnDvV0RAJmEUM
   3vF+2/lQkO+H0PAh5qeBX9TzGKgk3CrS30dsohAoau/CHdUNjXtfjcLjN
   A==;
IronPort-SDR: uCJ9hCCHWewDnONMwwK8w7CQaXt13Q7lbJ9bP0AhZnOCo27KRKsHtxWb0stLGWNS48hLMHN6HN
 hcjOhna4TNw+j1mTe1zj7Q7t/fLzCyRC809bJ43D122PihdJfdg98P0V2g353ZwNWIvzkxlHDC
 MDdV7z/GFhxuAcPBMQfywDnXIZjYsrtPXIqvG1nk2BGPB0dQ+tZmVPckk5AN7X0Kc/mvN4hnXJ
 OSmbWQwplabuVUw3cAGJLuWoWQonzf4T+LARZbxXKxouiG1vhQ4jeyDy09f2DaXHMCQT1dBTfx
 9vs=
X-IronPort-AV: E=Sophos;i="5.75,301,1589212800"; 
   d="scan'208";a="141405842"
Received: from mail-dm6nam12lp2169.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.169])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jul 2020 02:45:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fQ2Zam7cloOZFuLAYgr7PNa5uFFqt15W6fl+cbwA7vMBibQz+rdYlX+5y7oKreMNileORu8WFqn3Ic+zRL51Qr2C2W1AR+1HYN8OuFpBCzX5FbGFddhBW3/CUQ/R9gzu7k3mENCZzxkx1kfzghu+KUq7EaQSkmgw5ghpyN1vis8PYMU2eHJNvBapTaUGvn5WxgyiJbGAf1xz0Ei59qzM+tTiTr7mGzQDfZ7jrNAvyefl4Ly8tPZgZ6PCKNK72InFoNt9OW/E+wE5wIc8gh6c0j4ekeff0PXVhshHIst3Wlyq+UXFQCPfvFWxIiW0iKOOTPdli3588eliQgOu+BTZBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oqYQDSzXpgelKKCWiRCPMd1zLj8/PBy7ggmINwbfIec=;
 b=ARl6yX6ezZN9NmuAK8GzlhvvNMqu7ue4s5sFgdr0e3udQox+IefvIDRF3Kfb8xlhv10cQI3cvtAbPpqrxaX1p1UOv1yb/gLfVcVQhqCEvrsprfI0Oeo5jWG8zcfQPJ5YpLqiXBPoj5B8Y9bjXsbNfk1UIHXBxdPLb3zPmlrm73MuxWr/CfmshtnRt9pX1BqJpu2j1Wn0Vb6HHh+0bQEjKC5ve5KdkeP/7Yn2PjS4qDExtACx9t7obcw9zIPSDlCpHR5AaN5mqZnfvA/9bZJMtpCF+aFUVhoc6SRhmgxisdtSXjGpsu+jimkvmX496aP0JoC5EeXs6GRhuWO+gz3OWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oqYQDSzXpgelKKCWiRCPMd1zLj8/PBy7ggmINwbfIec=;
 b=VhX9ci5Johgvy+jPmGE/81QbU82fVd4D1oZdw7MHO4mif0xG3D1l5Medd+Gb1VF+ZIkSfTu44LYgxkV5vUYKJSNYJMWhmv4vMOyOtygGS+SG1Uz0N1RqOScsxt81shHrHosf5Sp1iAPlDdVAxrFeidB/ixagSQ7GoMyfHlbTXYY=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5032.namprd04.prod.outlook.com (2603:10b6:a03:44::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23; Wed, 1 Jul
 2020 18:45:43 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3131.027; Wed, 1 Jul 2020
 18:45:43 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     "axboe@kernel.dk" <axboe@kernel.dk>
CC:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] null_blk: add helper for deleting the nullb_list
Thread-Topic: [PATCH] null_blk: add helper for deleting the nullb_list
Thread-Index: AQHWT1/biaZTnaGKVkig3mq80wjSXw==
Date:   Wed, 1 Jul 2020 18:45:42 +0000
Message-ID: <BYAPR04MB49657173EED97FAE92FEE156866C0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200701042653.26207-1-chaitanya.kulkarni@wdc.com>
 <SN4PR0401MB3598CBDDC91C894992996DA29B6C0@SN4PR0401MB3598.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 618e15e3-c43d-4365-c1a8-08d81deef576
x-ms-traffictypediagnostic: BYAPR04MB5032:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB5032129E4B49A99F6879A8CC866C0@BYAPR04MB5032.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:758;
x-forefront-prvs: 04519BA941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lKPRL1bTpZ5SLUu7zk3YCfOl8m2YwnmMJ5kSXZrfzOPM2NRTzPZRCtMYwCnhWi5apiUAJT9Y5NourmqxO1Ziki++CX18V13L7Wsm9wfysj7pt+BB115T8z2973n38BK+oL+uhLHgRBKbMS+ZGh/QxVxUfm1m13xJ0WLS5uB+cyBoj+/qso+SWwtW/ZZXAuAWWu0gXSAfHQW9F8svG49wsGDcvCC9q46YzxA9WZTKOXz3fScenE1D0l3Vs0qmleA07g8r6Y+3SDSuzJEBW5Ef2E2rioldikCxKCReCN+wpXGTCuUMoE0JZ4YYMvZUZnWwQNbbUfYSB01AwD0w7VkpMA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(8936002)(33656002)(26005)(6916009)(86362001)(8676002)(71200400001)(7696005)(558084003)(6506007)(53546011)(76116006)(4326008)(66946007)(66476007)(64756008)(498600001)(66556008)(66446008)(9686003)(55016002)(186003)(52536014)(54906003)(5660300002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: n9hmPUmKXB2GutcRnJfsR1NxW+Z5DwxuLVm+EUji+TcBfJtZLx1d+1YXu4lc0gq9D+L1azwSb6lTX6lTIvYLWtYS9ewjH8fMIuXXatRmZdPDliA6vk8cQG+LHZValDAqxfsUPgDAEzckYOySE7wyja1YpBEQtCQvTvr8XAP1KxB74md2aqDay32rk9tarVuLg9OJXtxXJNtsnuOZIE21Z9ivmAOqMJbghC7jo3TCO3T7l8/niujvt9GuRZ3D/VI9XrIdSSw2q1PHcYTxYgNhoZrlAxyGIj2LISkfvJgtiRYTi9k+oX/yHt+T4IJL2Va9+QBBr6HqclEHpekhQ/0fjj5oAPOSQI/OQRnHI0sQBMn/T4RjJAwmTFueGgzJZqf514Wt/hOq5MObDGAp+H+SctH37c4OG93ecfH1GHZRi9K5KyukKbOZS6Ufcj6Uo1AowHw3G1D5JplxG0yc8vZqhMbEyWg1TUQoqnTPca81q1FHmfCdUIxXmkrg+legj3b0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 618e15e3-c43d-4365-c1a8-08d81deef576
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2020 18:45:42.9188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rBZA+pnQvlHUxFF5yZhvr2mYc1P5R4lhIGK9EOuPfdmuMx2EeaboACZh6wYLTIIQMRn1ncoxnPYJ97sv3FaHBZjJEdpK7nBcoavXni84TSc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5032
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jens,=0A=
=0A=
On 7/1/20 12:26 AM, Johannes Thumshirn wrote:=0A=
> Looks good=0A=
> Reviewed-by: Johannes Thumshirn<johannes.thumshirn@wdc.com>=0A=
> =0A=
Can we add this ?=0A=
