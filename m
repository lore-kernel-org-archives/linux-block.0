Return-Path: <SRS0=Iyu6=4D=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01886C352A3
	for <linux-block@archiver.kernel.org>; Sat, 15 Feb 2020 03:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0CE72084E
	for <linux-block@archiver.kernel.org>; Sat, 15 Feb 2020 03:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LoQ/oLWO";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Tj9dh2Y8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbgBODUg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Feb 2020 22:20:36 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:52643 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727705AbgBODUf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Feb 2020 22:20:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581736835; x=1613272835;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=7UVso2nmBdQ5BMulq/+ush68v3dJaGI99IMpEhTsXoQ=;
  b=LoQ/oLWOXQeXisZoP8Cfk8GiXo1f0RBTkVzPkNJxpiflbvzcwT0E+p7c
   SOLM81YbfCIQsvA9A4Q7iwj0FY4gPygWYgxAMnxKKZF34iUji7ycHrgWn
   neyaU38kjGO+itMk9ym4a/QnR1/ZUtJFqNAYyTi/vkFDTZhN/p8T0+WnG
   RVmq0rFSHP5pmb5G7WEIiWQNB2D6jLBHq5UC7+o58OjP7+MLWme4DXOni
   PXX+tix94ofWHfA6Z8JSGy3/tfGqfbdp/Ji6XsiNE8GPgSwB550XjcPys
   4PfLior0pPmUeQYeXvoACyiCfxTGpP96cjY8zBMaNbA2JJ1/qIIh5HZDw
   A==;
IronPort-SDR: IMmBf1EchhVKPv5+pgisOOhlBtnB8Z7vT4r3gqV77UJH9fp6yd6SAzrhPbbJmu/sr84+Z4L4zG
 sZGKQB4BhgxknewdLwQoKuRXYc/pSapxyzJTeARAAI/6sP3mLZ7mZl3uNlxaL303p2HwsTFHXR
 m99Pd5YiY+YnvIvnPypcalz3gtzqYF7ZkftYdabA7GZ7l9/bBbAX8FiL7u4Mqo6wVAqbOVnQ3h
 PegbFrbYJLJN6hS3V6prG86mn2KTbHleGoUP/f9mteW+d+ttToO6p86f4S0fOMt4uZ+3mDIa30
 ZjM=
X-IronPort-AV: E=Sophos;i="5.70,443,1574092800"; 
   d="scan'208";a="134268463"
Received: from mail-mw2nam10lp2105.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.105])
  by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2020 11:20:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lmEfJojsq9esBL7i7ckW0M/1cWcUoKBUrMxgbKUKk8KObH/q7TvRIgGXkaXvcposLIOFeI6t5I8f+Tdr2vmW9QXwCO2CPZhbuXqAo8beJpSNusVyj/6kPjwpCXi7vpyYAVDGImvy2oN1CPs8KbuZVXLEuAg5yKd0hQB7XMH1cB0qLbKe80MRMq2P5uxqfc7OQ9S/FewQ0MtJiKOlsrvcPDtTs3s0I81/XvS88RxTesOo62L1382R0PLec0c3w1f3AsKg89ZUaxeRk7CAtc5HywWP59WOaB1ZtFXZg8rC8YnI4JSYMe09C1Oi5pK8P2W7Vv7W26tL8CgLbpjIE1f0Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SNNqlCz862tjMb86LopTK59oDlgmd3G+Yljkhp12bXI=;
 b=YrRT9ipwRSfDlwkNTk+5UidSLFoufy/DpKk6cWZwdXOr9wePw5d+YY7tqMrWlMx6snOB/QTIZUQwsjIOsZ/F1KftgX/asz2ah5J+ob0oZE1IsGzKeS+l/XUpGovqmhC6sREAS9tfrstWxVSC+t5yIqQNSUQYWb8H9zpItYcQJ64yxGlnsVHQWeSwFA4QfOZx1ssEzo2kQPh6mQYsFwKNw3ybjQdhZU3DGqG8/SoZ45AmCpwmkG65o8ARFmoH9L8Obh3aeUdA09ZhSNIW0L3HZQjM3kXKXQ/eNwdyjMJ15qmycgHZnhPZBTgc6XI2ajZEOu4IY4PDvd7xSXARJQzxNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SNNqlCz862tjMb86LopTK59oDlgmd3G+Yljkhp12bXI=;
 b=Tj9dh2Y8oXL8zR0Q/euIJlDH1xp/C/7h7ZF59na2r9X4Oibicde+z6+gGXgDOe2zv4qsSP0wciDzeOUlsrzdPcEJMTZ9voGNL8bLYH73W46wAxsX1myZDBm36gWJ8TauUon7lX9hTuK6ZUh0Tespz98sG9ev1/IaTc0Q/85XozI=
Received: from DM6PR04MB5754.namprd04.prod.outlook.com (20.179.51.24) by
 DM6PR04MB4828.namprd04.prod.outlook.com (20.176.106.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Sat, 15 Feb 2020 03:20:33 +0000
Received: from DM6PR04MB5754.namprd04.prod.outlook.com
 ([fe80::c0fb:7c35:bcd2:fd28]) by DM6PR04MB5754.namprd04.prod.outlook.com
 ([fe80::c0fb:7c35:bcd2:fd28%2]) with mapi id 15.20.2729.025; Sat, 15 Feb 2020
 03:20:32 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] null_blk: fix spurious IO errors after failed past-wp
 access
Thread-Topic: [PATCH] null_blk: fix spurious IO errors after failed past-wp
 access
Thread-Index: AQHV4eJLw22qyEV6Fk6EkV++6gr6jw==
Date:   Sat, 15 Feb 2020 03:20:32 +0000
Message-ID: <DM6PR04MB5754FA61DFF5CA3C6912775886140@DM6PR04MB5754.namprd04.prod.outlook.com>
References: <20200212202320.GA2704@avx2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0d2f3503-f4c0-4b93-677b-08d7b1c6044b
x-ms-traffictypediagnostic: DM6PR04MB4828:
x-microsoft-antispam-prvs: <DM6PR04MB4828700CF508F69BBB1AED7A86140@DM6PR04MB4828.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 03142412E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(39860400002)(396003)(136003)(376002)(346002)(189003)(199004)(478600001)(71200400001)(64756008)(66556008)(66446008)(33656002)(55016002)(86362001)(53546011)(76116006)(6506007)(66946007)(26005)(91956017)(4326008)(4744005)(186003)(9686003)(66476007)(2906002)(316002)(110136005)(81156014)(52536014)(8676002)(8936002)(5660300002)(81166006)(7696005);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR04MB4828;H:DM6PR04MB5754.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JwsNYPnabJpyH5hqLg3LL2375a7rccDMnfOz8sjSfWZapyHKZgnmhl17FZllWk3JrxDBVWdf5ZF3MK902RtdODT4ouNdfI/zxdjvHRWsnOG6o8fBz9qYNYKk/WdRDgpemeFo9gWEdZmdZj7Du5VfY7bNXmyxmYDrsgdEYCKHpc9GL+HgQciW7O/TAG2qogtAbgfLhir/MoBjqUU6BCi728CIfIr7uoOgFnoi4j/YeMvYdA4Sy0qaJmMdhgc2yxvtW5Ri9ZY83D9O240Ft9FN7F5ETASpjAw2IenlyfZF/vZtl0SjV4IpSTasyU8rwXm4zqBowwJKRBKfsc0ZcAc7XNSGKojlp/b8HavLICOGwtI7gRz18tZPNbI37GUzxYoUAbrlyhp/xvMVkOTYodkyUdLH+Ev2o6gsIR9dubn5w1qNc0LkY0jfAr/NPIh+DT/y
x-ms-exchange-antispam-messagedata: 7Hko6//ECk7vW4Aby04sSR1w+iahmHIJnqRoFSbVpAdOOpcpYD9lw1xO8SBW7ybRkdgl4y0sr9+6xcO411cilKcloFGU0FgFj2um6re41iAjANIVoMAXclISfK180Rt2VppIr3woBxANNxfmE14AGQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d2f3503-f4c0-4b93-677b-08d7b1c6044b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2020 03:20:32.6797
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FZTqUubC4uyCYuhty1qysc1G/8DR3IWCGYSEcIKNnpgZy9qGBrDaDZpeZU7+ZfbbXwXNS9rTxLx6JE1r2IfogDFcVS4/U6Hy0in0cLM/CiY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4828
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Alexey, thanks for the patch however the description is=0A=
not simple to understand.=0A=
=0A=
I just sent a patch with a description and the test result.=0A=
=0A=
On 02/12/2020 12:23 PM, Alexey Dobriyan wrote:=0A=
> Steps to reproduce:=0A=
>=0A=
> 	BLKRESETZONE zone 0=0A=
>=0A=
> 	// force EIO=0A=
> 	pwrite(fd, buf, 4096, 4096);=0A=
>=0A=
> 	[issue more IO including zone ioctls]=0A=
>=0A=
> It will start failing randomly including IO to unrelated zones because of=
=0A=
> ->error "reuse". Trigger can be partition detection as well if test is no=
t=0A=
> run immediately which is even more entertaining.=0A=
>=0A=
> The fix is of course to clear ->error where necessary.=0A=
>=0A=
> Signed-off-by: Alexey Dobriyan (SK hynix)<adobriyan@gmail.com>=0A=
> ---=0A=
>=0A=
>   drivers/block/null_blk_main.c |    2 ++=0A=
=0A=
