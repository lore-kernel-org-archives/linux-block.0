Return-Path: <SRS0=KbiG=A7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65479C433E0
	for <linux-block@archiver.kernel.org>; Mon, 20 Jul 2020 06:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E7EC22BEF
	for <linux-block@archiver.kernel.org>; Mon, 20 Jul 2020 06:45:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lArOBtJM";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="LBgf6NDj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725845AbgGTGp2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Jul 2020 02:45:28 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:3869 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgGTGp2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Jul 2020 02:45:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1595227537; x=1626763537;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=vi03ikakhELEhgcrLmdQjTWlKQaj1/HX1zvWYMQKgkw=;
  b=lArOBtJM0J7/aj1+TOhF4d4BWunEYGrNXlPgNcHA4lEN8lZmFuPodwM3
   g/FAWKFC9cIGbIz5Q5XjogwVSZNsOJfILhov9PTE6nbUANuLUEoDwpcqr
   wcNXXDZRi4E5Cvsyu79fmP4ej9ZpGKy+6Uz5b0VmRBEbKO8PT6eV5oabl
   JmP3GTgsMuJUQNaNIWlJyRuDrCTnBmWoyGzYaHVPrAQJRp62uADbNsDqn
   ufJL5ltRE8gVq0StjcKvheGzcMjGq6dpU7P7s3pbBD1rlQFY2nb3QtDo8
   VbhiQkeBLKK6uAmtensc8w8ZSlgGuPIbO4OdufFli3lOZk/N0w4JfX4Wt
   g==;
IronPort-SDR: XZFb0YYshGCcl3Qb6k47eCmhMKbGrqnQYmTrpqc89Cj6uOX1LXAnO89Gc730eltIpMovJn5gNJ
 hEOkW9Q7Lh0D2757Soba4E0NCfnfhau27sIL+wfN+zO00sHY1OamaDF9sN4lx/f6xjxSulmEgz
 UAUFwvqRemUNghOB12+M92qTN/BesCtJ4JrlqkFhOfAMSuf5DZEKQPAC0u/kQc2yY1jfL8frXp
 ohvsuisFtoJII3OGeT4D2Xl6kRioQRYaItH+8whHgEN33WwotRGnHGalfFwvlYiUxZa57KyaNk
 C9o=
X-IronPort-AV: E=Sophos;i="5.75,374,1589212800"; 
   d="scan'208";a="245927121"
Received: from mail-dm6nam11lp2177.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.177])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jul 2020 14:45:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c5deHCaI4Ia/NbsRsCaE/FOUzAM9hZ20VktTWCGScNB1XNCR2cmOAYld8wXu4uDKv/ZWG9/b2+MGfCcs+RTysoMgfZI0cGw/mKiNKDRuyvknVzgMvBKbmsZ7OoAyhtm4hAPeIKblXpXfqQw7X/YUM0AOgg1s5qlYiXu9sB5dbA2tv9zJZkYIElHxiHL/YPsnvRfBT6K4Xv/65QdRGiPTz4d0JHGI1mMn1vfhT30gsTmgAbEOXkmqsZ5xk4y229IJC2cYn0VYyibkxKLXqUUTmMtIovLti7gDRwMIK9VfSwoNnSBe0m9rOkgUxRwhFXx1NxAnK0whkyGIZ1buzckL/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JUyTYusNZA8mNf9Pgv0fLlclPQbXJeFf4DOdeE18CjM=;
 b=afVY4m0HWsQvgIfNVDWPP6KmCPRyLXCS33VoptUdLs3TZwutNYQTBpJQ8hguPl2gegREKv8ry5msZ6k4PAclDNcyJ9+Wa3x1qgdPw+qRtEuosb9FtxRGFGR6x2yCDycZl20uG2UxFOQ743r0MiBTraCUaFHD11+/vVwff35v+XzM9PokFw1T1MxRa8wiciI9rfDqGL/PdQSX84KzeWJLZmfKBWmK117hryXSz2z5abV6YzniUhMtbAam9wCZ0abgNZfQG8SF9it++mdmUpAuHODAubeRGXUX8V6IJQtCQsLnlIxsaN+5Wa6TThoSK6toOIUOsnZrRkiW27BJkSBIZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JUyTYusNZA8mNf9Pgv0fLlclPQbXJeFf4DOdeE18CjM=;
 b=LBgf6NDj4vxAF+AKjgf1sy9Hh0gdiP6NPv2yl+SneBOSHEx2Yhbk5VoJUoQ+VtKdX0lbQakcyTnh2vxRwVeypoifTI8fMuzWmuCvN/GE64wktyyN6TWqqJsycJ8frhq8SorrYYL6mYlKAma4Ne0VEP7U0Ea2wDr6UpyB+Jvhhpo=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4688.namprd04.prod.outlook.com
 (2603:10b6:805:ab::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.25; Mon, 20 Jul
 2020 06:45:24 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 06:45:24 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>
Subject: Re: [PATCH 1/3] block: inherit the zoned characteristics in
 blk_stack_limits
Thread-Topic: [PATCH 1/3] block: inherit the zoned characteristics in
 blk_stack_limits
Thread-Index: AQHWXlzTaXAJlznby0qGepPx4bGhoQ==
Date:   Mon, 20 Jul 2020 06:45:24 +0000
Message-ID: <SN4PR0401MB35983F8986A949FCEB79A3829B7B0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200720061251.652457-1-hch@lst.de>
 <20200720061251.652457-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8791f423-e514-49ee-3b36-08d82c787afe
x-ms-traffictypediagnostic: SN6PR04MB4688:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB4688858CD766868232465B229B7B0@SN6PR04MB4688.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gEYEcGcAuMQfRDQF3WmXNSXfkIfJF9dw3FUXLY6pScGIHl95UD3dl3XnTZCyyICkOGVrVB3p2H+kRTFkBDKA0i+1OcUqvB/HtLUvF/FrRyuxDj2CokTZatbjpgLdCmP1qyd/43YHEkQBfo8DElnNLt8VNQIrD8bGgsdZZ8qHTXE7WFmVU2KshcwgpEkQ8npvTjzgJyBz25HnS2JFbn4Y/jSuLT3QRxyM1tQ6IouRTn8KSdoV02G6K5qaZIIy0iv+OYv/m4OwabGVs9n+atxDb47kYSN6Uoni+AE/ikyaJ2b1zYwRa7qljt/eX5HksdOis12pJfhmbxLfqmc6DXc2AA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(39860400002)(346002)(396003)(366004)(136003)(55016002)(9686003)(7696005)(4744005)(83380400001)(52536014)(2906002)(478600001)(8676002)(33656002)(91956017)(71200400001)(110136005)(54906003)(316002)(5660300002)(86362001)(8936002)(66946007)(66476007)(66446008)(53546011)(6506007)(76116006)(4326008)(26005)(186003)(66556008)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: oGXxLKMsZEQVk1EQWWYMBnZhnXzlEG4A9/YXEEtefrXnzyK3/XWtCN5yvEDrocGGUr9tehDBzrvzczilKRYYfU//k6DkQno3snqAQQDdoG0ZlMjFePOV35qpigdpqJMRxbjnZ0DVMtsjQA/Ox04LW5Rvee658D19TWh0JP5g1g9ObVCFWReW0P8NCuCqe+A/BlzU9ZDiGpKUdzOMv05rnIu+9cFenWxDmvtpJQ8QS9ZVItrRbgEWY4XPcs3LWih4F+wkc9BZivakJnTqIfr2hXTPLma/OlsMol7UJ7+AljJlwPzAQ879ALH1Qfn+4OoFmJhJJy8Q+jVkZcsExyT5hRpal8oI5/R9Vo+Ix0JtJurv1iQ4soMI7LJxkc4mrgtW8mOjf42gQN/5P77u6WPqGh6RGXvoYA3C7LI+iLpXwF/aeJtqxz8ODk7ZI1F375RyA3/ukJ6Ij7yqgsAxJrjCIoc3+bSLb7UUN/M1OQjUs8VUmfNVCHRnWJvT3/Kejgqf
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8791f423-e514-49ee-3b36-08d82c787afe
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2020 06:45:24.2705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hbv6FPzo9+LWIRaepatEZF7y8bEK22IXguDSqKOrqGuBTC2GWcKENmax7mLKBQbfIcIxaxR9fHrB0V0UwKE0pzLNKx/e/4M5ZZvhIQm/rKU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4688
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 20/07/2020 08:13, Christoph Hellwig wrote:=0A=
>  /*=0A=
>   * Zoned block device models (zoned limit).=0A=
> + *=0A=
> + * Note: This needs to be ordered from the least to the most severe=0A=
> + * restrictions for the inheritance in blk_stack_limits() to work.=0A=
>   */=0A=
>  enum blk_zoned_model {=0A=
> -	BLK_ZONED_NONE,	/* Regular block device */=0A=
> -	BLK_ZONED_HA,	/* Host-aware zoned block device */=0A=
> -	BLK_ZONED_HM,	/* Host-managed zoned block device */=0A=
> +	BLK_ZONED_NONE =3D 0,	/* Regular block device */=0A=
=0A=
The initialization to 0 for the first value is not needed.=0A=
=0A=
Apart from that,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
