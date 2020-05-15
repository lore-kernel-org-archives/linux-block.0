Return-Path: <SRS0=qX1g=65=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9707C433E0
	for <linux-block@archiver.kernel.org>; Fri, 15 May 2020 04:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FADC206F1
	for <linux-block@archiver.kernel.org>; Fri, 15 May 2020 04:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ksbOXM2X";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="q9bKJKtN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725957AbgEOEwa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 May 2020 00:52:30 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:18557 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbgEOEwa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 May 2020 00:52:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1589518350; x=1621054350;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=aGYs+Z9S8wxQX5SsZLjGvxH2DYJudCQXz2RzEGGPRvI=;
  b=ksbOXM2XxTBoNZ7lKq+da+iXXlQ81YQoyE1STBiJdmcnU9CvUpmyPxdp
   U8yhLhQ7YCVDUApSnIfRzGsLhWohZa9OWe8AhjJqk9lL2F6FUXeAvrK07
   0h/AEc7XZtghRR+HNum4LO8TrwL4/2jsCOf8n3o1kZMy7HD9InF5TkZ9p
   0Q1mhln+wbLYiwxeUP1yVX/KrqNSJtBNrzErgAkqYF35ShbIMl9AG7w71
   COE7aPAO9OVJ45nYs4aJnx992d0ihV9yZY3rp8p4BSGAPsMKmKIJmgWfC
   8n+lg6rXAvD63WSy13SdN1PIjBIAL6ustMGM37ur9klWD5DNUQkzhHTFM
   g==;
IronPort-SDR: JH840WBkG7L9qZD/xhk2xuRRc1nmRL850kNUKTW3wiBXdLfSeZlvVl0vTCqJuyE+ss2Oa/xEZF
 MyuzK22kIB95RnGRkxTR+fR6GUftVJQeFjqnFuk4MHb8qKH32ZFx0Lb19EExz6Ky2l7TGRfuYy
 VRvHUYiCo6QlqO5rEkTFndQy6Ad66lIe2YqmwVoGaOWqZvaAr18u1PNoYqkPpwu3faZns0F44c
 TgmDQoHBSWlQ70zxUoe9KJ7EQYO/wlJDSwRXJmlz57igXj1dWNsLuKv10WvQ7HHcoV2rqV07C8
 rYU=
X-IronPort-AV: E=Sophos;i="5.73,394,1583164800"; 
   d="scan'208";a="142091321"
Received: from mail-dm6nam10lp2105.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.105])
  by ob1.hgst.iphmx.com with ESMTP; 15 May 2020 12:52:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EeaendFRYs/IA3uC5hI8b4P7XD8UTuepqlT0w/HmBgKoRtUaNQkySEkvvPXjp1JAbnaxOEslmEpy0rEi45+M4WeL/pcnWRYx3cyYeRwpJxjJ8Rv7WCdQ6MNCAnF5jfy+3U78qiqP7gV9EHY5zukhUT0BH0Qn5EcanP9vc2B/JgjWVmYXqBY5CXLupSGtsHwHMAAVhGYqAueaNO05LM1jLTqqDISbuTCoRStkPuLNcZNrWfGAEDydKy/zZenCFM/FgfxMihvuodIzXQcetBPLscYGqZ04cm3cPkdrQaz5TUjOeve+fGNzBfQDVHdCGnSnzcDpgK/lbzajbJXAxJk6Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IxZgPxQ5ApbsvvkVtzo/7GA3czP9NsfPz35Kx1lOly8=;
 b=kl9zQzQSdOrdX3mgKZ8Vvfy5aR7xMZCPodYVSOW1jq/vdiO5TNW+koq37evPrJGU/rh6jQMO3pgMPPAlO6pmLWEb7iXGPZ71cnxo0QQPMx9/P4V3HOeXuW4i6YFJA27Fa2tpQik4Vzp0mLox9FzFgvOuwgUqtZiRjP/728MP6VI4P3RUDz5dkN/a7i2Ph1CgIQgGw8a/9zIZAu4hpc/P4vMUiKwWGR8yzcds5/FyAOm7EqWCumKfz3SLBlUyuGO3vDLj5jkYO9ZBiGczhPh3nPD3dyV4lVtpuvLl1EK2JbldM6ZGpnNoSRsyG1ifNn4HGEFa0rCL56EKR4Mhuk+7jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IxZgPxQ5ApbsvvkVtzo/7GA3czP9NsfPz35Kx1lOly8=;
 b=q9bKJKtNYhMRhyb9N5r8wyFqZCcZu2T+U57OFJTpbuPRvH6ZL/Y/7o60DeBfE/nZJCaC2L3nD2vdTJsPlDIB8QMpk1rkYIyN7/9iX09aLw/4BrfGlj3LEDwBcruHUcStO4L9fF3urciFAYVF4p+uF+LpJJfSAIAt2Hwy4QYNFmI=
Received: from BY5PR04MB6900.namprd04.prod.outlook.com (2603:10b6:a03:229::20)
 by BY5PR04MB6753.namprd04.prod.outlook.com (2603:10b6:a03:221::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20; Fri, 15 May
 2020 04:52:27 +0000
Received: from BY5PR04MB6900.namprd04.prod.outlook.com
 ([fe80::b574:3071:da2f:7606]) by BY5PR04MB6900.namprd04.prod.outlook.com
 ([fe80::b574:3071:da2f:7606%6]) with mapi id 15.20.3000.016; Fri, 15 May 2020
 04:52:27 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>
CC:     "linux-block @ vger . kernel . org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Coly Li <colyli@suse.de>
Subject: Re: [PATCH] block: deny zone management ioctl on mounted fs
Thread-Topic: [PATCH] block: deny zone management ioctl on mounted fs
Thread-Index: AQHWKgx58zbe4Ia6T0+rduO1YoE04A==
Date:   Fri, 15 May 2020 04:52:27 +0000
Message-ID: <BY5PR04MB69006DE86D1050620B5EDAA4E7BD0@BY5PR04MB6900.namprd04.prod.outlook.com>
References: <20200514162643.11880-1-johannes.thumshirn@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bad4f28b-d7c6-4200-c33a-08d7f88bc491
x-ms-traffictypediagnostic: BY5PR04MB6753:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR04MB6753D15F4DF7DA30D7CB2DE2E7BD0@BY5PR04MB6753.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-forefront-prvs: 04041A2886
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZLyOcDKABZGxftI8SZnqASHiFsFuaTxOexNzUrwQnEe+hZN3l3i7NQAX34KlHra7cabjmdwXwFueqJzp7oSVZZl2Vt3/otEU7YR6Epu+NwMrzh+r2k/NsT0GwXHnB2J7HLKbSeOyuYvCgESa7WPd/llgKmh5H2efeRe2l7GPw4db8tNvOYOSVohSlGyrwSz9anK7nqa6FeDJSfIDQm8mP33f5Nk5BwVbUPssXMdKcKtBZ2ZM0CITe8M80b3zvGZrRqse8XnpIo8R6vzOKBDuBYtwsJ/2R3DhV9dz+f9BWL5CeuKg4rcGLRiBRAx78lthqOtVbSm1Kmf5Rj5onBnq7IvtIkwa4ciU/NaxK+V9EwlK63PJxEL1UGF6yoFdyTja2BTHHGcr3u3iKhyTXKr6KRDsyiOzR8//SYj3joa5mW5dwSwyYS0M8RZW3Sattf2q
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6900.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(366004)(396003)(136003)(39860400002)(186003)(5660300002)(86362001)(2906002)(110136005)(55016002)(76116006)(316002)(66946007)(66476007)(66556008)(64756008)(8676002)(6506007)(478600001)(8936002)(7696005)(4326008)(26005)(71200400001)(66446008)(9686003)(54906003)(52536014)(33656002)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: wV1ckeUxN0+Vjg/5mnHRlVjnaQV9A5RiaTa9vAIVMx5smY9DxDUEx5ZcMujtqlzoyTlwt4iQSS1pyuZXh3prGcrKYuvz5cg7Gmzs/lMQy/wAtTaELF/Hfn3fisdvGW2/NRAiQ+z0JDpS2IADaf+m70BsKN1M8TSXKnneLRCBKj/y03myCjLOcXE/8GdgerurFhXhgm/hgTOw3/dxYO7GoR8E7TFjlvLottRewal1Y1lK58I1yceXnCjxCpYjxYWfkcTbFkSle4xzVGgSGuWDNjVYpRqHlmHf8WHrGWYXB55gBgYZlwS8SJw+8bCHR6U1z21TIxN3I/nXlbEuWKzcbe76yx/Ckv0mcWBko6C2bQxHnhSDgNq2UcubBKIkoSuTMZAqqVr5FDFk8xnU9uWFsHQmxH7b8TG8ZYp3MF22RCk1ZPxkD2KLbZrcMs8WlFTHnIX4goOnH/lmgNxwzBY/LO3Y1/+Fi3TPwhaXY5WmME/c69SrJ8+xsVLI2tJ4nWPs
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bad4f28b-d7c6-4200-c33a-08d7f88bc491
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2020 04:52:27.6860
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ogjgeaZ3DHOq/yxfgkQRDqHXHUPaNpSEmh4oLl+uZAOHpIfV5O3xtrQo1f1oJhW4iptVsqLsuVHmUKj+DbcoPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6753
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/05/15 1:26, Johannes Thumshirn wrote:=0A=
> If a user submits a zone management ioctl from user-space, like a zone=0A=
> reset and a file-system (like zonefs or f2fs) is mounted on the zoned=0A=
> block device, the zone will get reset and the file-system's cached value=
=0A=
> of the zone's write-pointer becomes invalid.=0A=
> =0A=
> Subsequent writes to this zone from the file-system will result in=0A=
> unaligned writes and the drive will error out.=0A=
> =0A=
> Deny zone management ioctls when a super_block is found on the block=0A=
> device.=0A=
=0A=
Zone management ioctls can only be executed by users that have SYS_CAP_ADMI=
N=0A=
capabilities. If these start doing stupid things, the system is probably in=
 for=0A=
a lot of troubles beyond what this patch is trying to prevent.=0A=
=0A=
In addition, there are so many other ways that a mounted zoned block device=
 can=0A=
be corrupted beyond these ioctls that I am not sure this patch is very usef=
ul.=0A=
E.g. any raw block device write in a zone would also cause the FS to see=0A=
unaligned writes, and any other raw block device access is also possible fo=
r=0A=
SYS_CAP_ADMIN users. Preventing only these ioctls does not really improve=
=0A=
anything I think. That may even be harmful has that would prevent things li=
ke=0A=
inline file system check utilities to run.=0A=
=0A=
=0A=
> =0A=
> Reported-by: Coly Li <colyli@suse.de>=0A=
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
> ---=0A=
> =0A=
> Is there a better way to check for a mounted FS than get_super()/drop_sup=
er()?=0A=
> =0A=
>  block/blk-zoned.c | 7 +++++++=0A=
>  1 file changed, 7 insertions(+)=0A=
> =0A=
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c=0A=
> index 23831fa8701d..6923695ec414 100644=0A=
> --- a/block/blk-zoned.c=0A=
> +++ b/block/blk-zoned.c=0A=
> @@ -325,6 +325,7 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev,=
 fmode_t mode,=0A=
>  			   unsigned int cmd, unsigned long arg)=0A=
>  {=0A=
>  	void __user *argp =3D (void __user *)arg;=0A=
> +	struct super_block *sb;=0A=
>  	struct request_queue *q;=0A=
>  	struct blk_zone_range zrange;=0A=
>  	enum req_opf op;=0A=
> @@ -345,6 +346,12 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev=
, fmode_t mode,=0A=
>  	if (!(mode & FMODE_WRITE))=0A=
>  		return -EBADF;=0A=
>  =0A=
> +	sb =3D get_super(bdev);=0A=
> +	if (sb) {=0A=
> +		drop_super(sb);=0A=
> +		return -EINVAL;=0A=
> +	}=0A=
> +=0A=
>  	if (copy_from_user(&zrange, argp, sizeof(struct blk_zone_range)))=0A=
>  		return -EFAULT;=0A=
>  =0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
