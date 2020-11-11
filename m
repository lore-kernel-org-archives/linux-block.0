Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F853C388F9
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 08:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD1CD206E3
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 08:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lflA396f";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="l5ZTF35X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725870AbgKKIWI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Nov 2020 03:22:08 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:57019 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgKKIWH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Nov 2020 03:22:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605082927; x=1636618927;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=PyIX0/e9YhImzJhxQUWU13/XAutkoNytMwyNfuD+Sl0=;
  b=lflA396fOBKNQj6dGBVvAEv6ZP7eJ1tPucjizqkOnQskPC7EPCroa67m
   62y4RgwQ+AfQ9mak7WK9bFTMhwGF3JzGednn9ojxe/bLwiraUU5BMGpAi
   p9oVbbcJBEcviUI5S346K5AddX9NhkS4EnXhqBuYQboipGm1duH1yANvR
   Xay4uptXwM4lSG0qbo5CkuYkjaWakYhE6yOemD4rkaAhW3BBWChg60Cwx
   PqhiIbOYESC6ylpaYhfag5BP02T7IDwJrfIxqi1ss6LgBM2BNGfGGm2tr
   9Phag0jsJ+BSWcndJsmycG4qT4N254XGK8uTq2PK2vdFlzYMaNhfqmQWX
   g==;
IronPort-SDR: SnLaCEgt7yZclu+vFHf6+u4Y5GZVlInZZF52JHve4adi8jAyZlEMO6xwqRr3RB/o24FVr0b3ZH
 3PDaRMxR+P1MBJ/1svXNnbM1+cOM5zBl3YwMaxIY6r3FWdPC2lpKBNwlgOdo8tF5QoFqRUDZgs
 1TQuNgS2tHFQ9AkAVFY7cEKP1qKvYJ3CTP3Waa9lidUq90k3qnBupHURO/nNZy7HqNG2y6Z4xY
 g6sYWqAe7XyYWRmRQjS1HQkjBsiVREBrhh6xW/zQV0szKkMbphbnizt7hbQevhz/k49KOXEdgr
 GJc=
X-IronPort-AV: E=Sophos;i="5.77,468,1596470400"; 
   d="scan'208";a="262373685"
Received: from mail-dm6nam08lp2040.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.40])
  by ob1.hgst.iphmx.com with ESMTP; 11 Nov 2020 16:22:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gnxAVzZt2wjkmCGNprmXbjsV+JU4GEA8/hHxzrb/OxYf6xaHLHYrEBZUtDuuklA/EVu4D4U+O9oajmO+Z6zVHoJgQr5Kr/YvXmdJN9iu+UVGe1QwZZAuCKs6KWWnvzZnDT8PVDmXR/Ag1wwNukwucX9rP4iccQqg2MSVRysufDmAtPe8xQtyr/fVpoVI1CAEvwwaqiwMrngeMoYHSEK1PyaNSckQweRwJZNnLqhCoDi2pjLB2OBSAWsOLk9GdGwW5Zo/fPD0F9vs38b/UBLDmp9S9f22H7jw3yID7YEwrYMm6bJD2nusV6UMv1uxHqvNZO5McJRKtNZj/VWtNOdvVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PyIX0/e9YhImzJhxQUWU13/XAutkoNytMwyNfuD+Sl0=;
 b=hBx0BRYhUTQTUlWPzh9YaD2EB7fYA2Ztteg6ux2Yyv/ivVfG7ZDwadqKyMq8DT2Jj4fUZV7EJGJifiowU0gotqpJWpBYPslGMP6HXh7lQ/iECl//lt3s5LX80T05tqaxVXLRlNYhZ5mR8R9zC4IUoZwD3s0wY/eIG0MJhvxD0dsD8ye34j0Cgr/pT21vfbzx8mY1dPz+cDa9bMGFOp8oD3IXpSW7/u9q5p5BdeSiy9U+m1UJCCsxppv9LOEyuvy2lBRUzfZtX722RgoPbQnNynSf3szMb7ld9NYAD3+QlAak6W1dvHOg9tF6nyq9OxQhnylZNHWWm1EQX6kU52qM8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PyIX0/e9YhImzJhxQUWU13/XAutkoNytMwyNfuD+Sl0=;
 b=l5ZTF35X4sY4MBM5rYMtOMEuPuIxfHd7qlF4SFiTEK0yvHbau3ZqzEK3BlCvkYB4pRniFofn5UMtkdM6/QOUrjbpZNmycGM1WWUKbSFNxGpHH9xc/aOs74b/7i2wM/wR3q1aSjwINu1IDkXkLEzuBa6/1jAZD+0oz6n7BHtpJYQ=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB5165.namprd04.prod.outlook.com
 (2603:10b6:805:9b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Wed, 11 Nov
 2020 08:22:06 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25%6]) with mapi id 15.20.3541.025; Wed, 11 Nov 2020
 08:22:06 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2 8/9] null_blk: Allow controlling max_hw_sectors limit
Thread-Topic: [PATCH v2 8/9] null_blk: Allow controlling max_hw_sectors limit
Thread-Index: AQHWt+nlIaFwPd7WpE6n74j6HQWmOg==
Date:   Wed, 11 Nov 2020 08:22:06 +0000
Message-ID: <SN4PR0401MB359885017B4CDDE95E64C1A29BE80@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20201111051648.635300-1-damien.lemoal@wdc.com>
 <20201111051648.635300-9-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5ab40696-e7b5-48d9-4124-08d8861ae04b
x-ms-traffictypediagnostic: SN6PR04MB5165:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB5165E09D5CD0A6EF6ADDC30A9BE80@SN6PR04MB5165.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +y4QRGv4UsiLMYPoOIgLke+YJGlaR5e1bfKjkOSdHd61vjBDV+mxz7yzT8tTZ22i9NWI9CyU6E0G/6XNpvc3LxMqwZVeEA0le1z09MQkqMo/NXktfJKST8YdppJgMSxU20KZY0gLF2c2LpUxj5dPN3MPXftqTQRBande4i6HHxfkfSLmi5GudmJ+KYdvJpBxZkUWEkpVG6KtKaQXxxEVq66469i+u7ndb3hxmZU96fRpbSA3N570Pw/Q8bRmJ0P6FoDZwQfmX9KXiB3AmZzn2OYguO60Wc0alhFM6tUOb/BiWfYqNurIcGE8FiA9v+0u8qocNAn3ogkgEXSD1tyazA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(346002)(39860400002)(376002)(396003)(478600001)(26005)(186003)(110136005)(83380400001)(71200400001)(53546011)(6506007)(55016002)(33656002)(9686003)(8676002)(2906002)(52536014)(8936002)(86362001)(4744005)(7696005)(66476007)(66446008)(5660300002)(66946007)(66556008)(76116006)(91956017)(64756008)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: wc5DcfR8Z1ypLCoCRTeEUpyj+a6IM1g6NxiNQQkjFMtF9Xa5dUGAh9RGBIBoWL1ZhLnNboa8jQQORXOxkC/99s7Z5nOnzhDpMR3nsFv+62Cx69bR3l8IlfoUYP6eFdJWZbjjtBNLzcnPYVA8F8nUqN72Rjvi9CZagNdxItH5DntXX2PNk/ocukt9dGyV70fem9dnM59Q7fJ4UKh1tUDe/DtGiWtIvjXXabNosrtqraRh1HdJiewPPwerIDfor35RwAGXb0AJlJkcA7MmS9ZGNaWgwFWCEqkQHUOJ7nCbWYbjxVYPi8F/6y3qsOfbMYtWusIG8McAlh5RlIKHeVrrQtJlC3Ebr/wPtqve5hiP5rb/plRHUi7pAGU0GUfmlY7dCaws8SSRcQpNxIqUkrFl0jmhzz+gyQ1IHc37qhyAkO2h9v1jVZ5YhBHF57saIwPpfeMKCv+s0E6mirauESbhjx6YHeQUUHludc1SiAC/yUg1fiHELkPT6YDVQPIe5En6csCFue0h+MS+HcbObg94/T7AmEKq7J+zBYXyBGlTqWWlbTzBF8b6QFTc9dvTuzu/9iCF0+6qZlFTvyz5HfE8UvBRP5iOnzTMY6g8DZPemHLtMBJkKmQ2CQig0mAzzJUu63sA1HF7IiEE+t4ciQg4tg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ab40696-e7b5-48d9-4124-08d8861ae04b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2020 08:22:06.2651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7RFeQWuVKnJONaXG0mx6f9KqkySvNxabiS4P/Y5MkVjh3vOFBWAOBEp8Bb7J9MtKwJ1vuPulILMxoykicoH+I9NUChFQX6mP/CakBP2tGjk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5165
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/11/2020 06:17, Damien Le Moal wrote:=0A=
> Add the module option and configfs attribute max_sectors to allow=0A=
> configuring the maximum size of a command issued to a null_blk device.=0A=
> This allows exercising the block layer BIO splitting with different=0A=
> limits than the default BLK_SAFE_MAX_SECTORS. This is also useful for=0A=
> testing the zone append write path of file systems as the max_hw_sectors=
=0A=
> limit value is also used for the max_zone_append_sectors limit.=0A=
=0A=
Oh this sounds super useful for zonefs-tests and xfstests=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
