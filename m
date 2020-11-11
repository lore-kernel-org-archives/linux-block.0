Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 219F0C388F9
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 08:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D106206CA
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 08:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=permerror (0-bit key) header.d=wdc.com header.i=@wdc.com header.b="kv2RsJPb";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Nzb2GVjn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725859AbgKKIVA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Nov 2020 03:21:00 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:57539 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgKKIVA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Nov 2020 03:21:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605083856; x=1636619856;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=O3USCbQGKnoHRSc0hhIEj2VqcFfsTTogD8AE+ZwdYRk=;
  b=kv2RsJPbUTMnXhcpdpoK+URR2tMCU/DxqRgidArC178KI7DoRXXABQEB
   t0zWj29n2TyYVjXoUILVPqnF4yR4CjYzpgx5VUGM5SS1JyNuAjv6vR1Tu
   3TTjOWUS0dVWiDVITLqxnwl9InTkWxzKI2ZHtXNyQdkAAUs8mwlGAdoRw
   RChaYulUSShzE6rosBHoS09UI0a3u0Zzl8PBQf81GudZAnnERlSaMC+0I
   qYl6tqg1q5gRCTs7s97pR6aJLBnbez7WWESGNRdzWEzhpwDoWTMjlu0U6
   7TzQhtyQqu9A+4x8+KpaZl1B+Jv0bXhx4dB0XPdNX3EcL8q6OvVZ4FGCD
   A==;
IronPort-SDR: E2LzIOtlo5ZOk8CMSsejqV7BkF9CXXX6KjRSb2yGG5CGUpyoNXV0AvrBiO5pnzhTNFALdRTfOs
 MGLAsx8d36tjWiKEyqpBZGAvtfFcSOHSQjVMOqkG+9kPmzS8l1wdMZDG8D0t+0U0/GBJsshS98
 /FEs/KKsc+y7RtG0AaapW3AcS3D3bW28111U6jNSHH9Wyzv0U2snNTBBZkg2oXfAsWgjFZmtlH
 sAUWOBs1rnjrMnPhRcodILd+V0Y65KZmMaM7l5fnH0aJMmKoltwUiCGAHr9SYxXt315wDaUPi4
 acY=
X-IronPort-AV: E=Sophos;i="5.77,468,1596470400"; 
   d="scan'208";a="255928352"
Received: from mail-mw2nam10lp2103.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.103])
  by ob1.hgst.iphmx.com with ESMTP; 11 Nov 2020 16:37:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EmU5WtBDygJ3d6DCIiW91hhzAjknbjml9P5jUCK3zf6cwf7+1QJgO7OD33EI1cqEdcjhcb0brBC6GH4sHbsd3oWk937Wjf6nU9vr16T7Dos5R3hJh4e9R7pmMLjH8wIuCpJZJtd33GO8XbCjdzfcfHTXIKsC/EAmy14mMvRxJ0gctyEjzMZqOrh+bZKVunCX48myCiFNcpjYeRYSynsFpa1zQqAQ+cJCznsnL9uIqdO+iAZbP9vWfnoA7mhomEZ3iSpXtUu36ot051zoxiCxzxfol33KJSu0LTDeshvPu5hv4mYYa5FZXul/wuhm9/xQawxZeTIDfZxO6/eGd/I7gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0FIX5aS6bDctlywdDzQFdQZQgNzIGsrw+KNVopTYTRw=;
 b=N83y2kkuvnaT2XV/BNBsjZ+PZwrXp8sXio37ImqVEVeffWKNdr7MA6hzVj8LrD5whYZui5mc4D1FyCj9X66HeOxOoMoOx6/a67fvYP2j5jFFUu7Kil+4R+3XtkvYzS2Ez+HER5I5m5J47ombYkoFj7DgjvWN3UMhFcv0QMWx4EfAtciO//JQrBxTyTeh0S9Ndd6h4cOmjv/V9e9vl0yUmju7QLn09mbeRFfrZlKCWZugz+1/kqAk/gBf61Abo+J0W3oqYYSdc+6Q7VYSLdkFywJkSdsUEh7j7TKbjds78erzJ/jeA1UlQ6Ug/ws4JcjoWauIQl535kxELIz0hOYceg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0FIX5aS6bDctlywdDzQFdQZQgNzIGsrw+KNVopTYTRw=;
 b=Nzb2GVjnNHaNfjQn++2Jj3ypo11uE5YoV1F/7+dIQkiuVTNo49OUH2FI7SfhFB6UIWTdUEgRG5lOmANO5eiVoFU0crPxrqRDosBAQp7jOmKWC9H6eb7Fhp3bS7/hgfDwm7hQXY0nf2yPn5osWZxS+QBQxnthrKaFEUh6tPeFvhI=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by MN2PR04MB6351.namprd04.prod.outlook.com (2603:10b6:208:1a3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Wed, 11 Nov
 2020 08:20:57 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::4c3e:2b29:1dc5:1a85]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::4c3e:2b29:1dc5:1a85%7]) with mapi id 15.20.3499.032; Wed, 11 Nov 2020
 08:20:57 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2 4/9] null_blk: improve zone locking
Thread-Topic: [PATCH v2 4/9] null_blk: improve zone locking
Thread-Index: AQHWt+niF0LNjmprYUaIhZl9II2VHA==
Date:   Wed, 11 Nov 2020 08:20:57 +0000
Message-ID: <BL0PR04MB65141FFF6EA30FBA882B4B3AE7E80@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20201111051648.635300-1-damien.lemoal@wdc.com>
 <20201111051648.635300-5-damien.lemoal@wdc.com>
 <20201111081147.GD23360@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:c005:87c5:ced7:ce31]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d00584ba-dc4c-41fa-1ccf-08d8861ab708
x-ms-traffictypediagnostic: MN2PR04MB6351:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-microsoft-antispam-prvs: <MN2PR04MB635137B2C0DDCB3792936C4BE7E80@MN2PR04MB6351.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8sKen3rHXCUJk4277AP/qaqB9ZFnBVR2e6+ce1JTaOgiU9mMFAumGW/MlTUGVUW8WqXJc2TEAfJrHJs0uhl9nRBSKbC6q+BPAxNu9WkLiA+A9EXVOz15mT/v3h4MEyYmvgpfhmlJ4DDSJ35hNs5pWr3RFW6jXOgaewvHUdFg2erh6sguSgAgHUIAGBfiOYxVq7TprWN+gGT9UUR6vkqF+VJmAjxELMic25iv3vv+yyl810hqJTT/PlR4SacsaM2FeAiUqXL2KQClankpVNCiaLWKUC0hk3KxI68PaFoNIqyi98SdLKAxSIVQO11N9a3MVbrdCx4syMRy1rqirEQifA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(136003)(346002)(39860400002)(366004)(66446008)(9686003)(478600001)(6916009)(33656002)(53546011)(4326008)(54906003)(86362001)(316002)(52536014)(71200400001)(186003)(4744005)(5660300002)(91956017)(83380400001)(66946007)(64756008)(8936002)(66556008)(66476007)(8676002)(76116006)(55016002)(2906002)(7696005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: erdtPgqVJ78ImKxScvSQSumPMVqcsLfwxNPI1QnnUhVLbW2VjNCsNIlV7egOPugtjxF1vBrYqDzzR5zVI6/fZTt9g1Suv2KtPJXwp0BvD+y0udbmFmKaZVXvkeYnH8Kgn4YXrsmozdcVtk2yL+BiYFYl9uWhiAZ19yptOv8Vt8n1okU7v307wCCoroy7okuEhW2BMRlurfWXTZxfC6nllGLznMq0MXT0VLYi4mDI1bCEq8N6PZZ5HObl/QbYUBoTi8XSxPm75LHLW9D2mHqkF4N8KL0oT52ci/oXMLszVksnniAg91dMo6IjgcprzB6m3QSdXvQ5MLLvXpdws8i+KYHawccOqGqH7rC7UCxy/l5Ocro/KE/TG32f+w5sZE4Url/xZqsLrJU6ye4CkLRGcf6I+/MSaYjiCztSS7QUDCcZLCnFJK8Zd9nvTzHK7/pFaVHWHUlTCVEzTdrVhgag4hMvU0ozS6RHlmbVYqAwJn5KCGwq4sK/n2+CsWU8AxJwi2D27xX5u//1N1tyXSwvK91jfdKHgKZyOWz74eYkct1woquUTsGrG3AIfg6GosVHNXGWxjUNU1Z3cWl5gkldHoYdkM6fLs/5IFzYeSnKEodlALR22+mZUVqfA+HLgG08Z20+urA2nRmoxvXvyjvP2lrIIk6Vql/sEtH5aUatAHGkjI3LUj7eEdp8DOxUDyZ0/wo10ex33g1ldCH0rU16LA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d00584ba-dc4c-41fa-1ccf-08d8861ab708
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2020 08:20:57.0167
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k9QkzHLJQRafirmUxlY5yLFFfwP4iE7tUP5tD267K/lqjjy6yxw4pHR2Dc9s5Xo8HFmAJJVY+UD/aQj/KresHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6351
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/11/11 17:11, Christoph Hellwig wrote:=0A=
>> +	spin_lock_init(&dev->zone_res_lock);=0A=
>> +	if (dev->memory_backed)=0A=
>>  		dev->zone_locks =3D bitmap_zalloc(dev->nr_zones, GFP_KERNEL);=0A=
>> +	else=0A=
>> +		dev->zone_locks =3D kmalloc_array(dev->nr_zones,=0A=
>> +						sizeof(spinlock_t), GFP_KERNEL);=0A=
>> +	if (!dev->zone_locks) {=0A=
> =0A=
> Using the same pointer for different types is pretty horrible.  At very=
=0A=
> least we should use a union.=0A=
> =0A=
> But I think we'd end up with less contention if we add a new=0A=
> =0A=
> struct nullb_zone=0A=
> =0A=
> that contains the fields of blk_zone that we actuall care about plus:=0A=
> =0A=
> 	union {=0A=
> 		spinlock_t	spinlock;=0A=
> 		mutex_t		mutex;=0A=
> 	}=0A=
> =0A=
> and then use the proper lock primitive also for the memory backed case.=
=0A=
=0A=
OK. Cooking V3 with that.=0A=
=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
