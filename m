Return-Path: <SRS0=SfBO=36=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF328C352A4
	for <linux-block@archiver.kernel.org>; Mon, 10 Feb 2020 22:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B7062051A
	for <linux-block@archiver.kernel.org>; Mon, 10 Feb 2020 22:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VA9YfqAy";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="BpDlbilK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbgBJW5G (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Feb 2020 17:57:06 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:54797 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbgBJW5G (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Feb 2020 17:57:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581375472; x=1612911472;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=lDkPt4BW7aCJkfKfgLYy0mYmhXcz9AGTnyimkQ/YDNQ=;
  b=VA9YfqAytojVES/H6VVyAtTZwRiJ3yq9crc734ISS/B1aN9NGMA6Lb9Y
   u2BGj1pDqlXfUK4DjwqlJK6MUW0XizWYwGgCvL3Kp6cGKMz+cRcN7VoK9
   3UvHSQ2KEF6futz6DyXXAFX8K5D7UrS5qbhvko6V1FwDCRH6YFXSxaRXj
   uEjGyI1442ksxUvMNOzJ17JCbEq+KJRBJP8XSshuqPlnjCAnwxv5djra1
   F0uqfndVobVHZyg9p10wkXWdluTxjSDAPNm7gkwIP2sjQRJDAyp3PD0nF
   abN2jHSjVycuI0EurqueLF7GmSE6606FWs4/tpQaT7+PDvBL83ycUavwS
   w==;
IronPort-SDR: cTtKoYAZHhmVO7d/nsIs3hfxiFuk+UMpJxGFoR4hUuMrMmYyLVxR6X47ZB+ej/2H5ThAK64FDD
 O1bRdXzLRe7vK03nNy8/8mgi7fdun8+7M9oNioxwdisHqOPcIlqUnGOv3UkQzIkueU6axn2k/b
 OzKjhgPBbVXMBbOrJ+Q7bT9GJvTBMdUrG/60iKbo0DSW3lyNm63aCNsdpSn22hzA0ayLftFt9K
 m4TMf1eKX42l1hoXU1j/NbLfyPMPTpS+FXzTdrgx/EV5u0Y8zfuN3IUqrXV7IlCX2nCmy1l5g2
 XbA=
X-IronPort-AV: E=Sophos;i="5.70,426,1574092800"; 
   d="scan'208";a="231326449"
Received: from mail-dm6nam10lp2103.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.103])
  by ob1.hgst.iphmx.com with ESMTP; 11 Feb 2020 06:57:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=geQTUluvwi5pbe/ix9bD8DkJO2KSF2H5SFOaZt6edE+rnNvVdZlQI+W8E4VFzN0rrYO3DWLzW15QwPNTkM/NLEaP4crXBB2XFYiIZ/idwqbC64+PM1ejssZW37XJbnXpfLak91tluss9nkdcpoIATMzISV0AsON7giUoJ03qyckp6bx3uoNRXz39IV693KQuVkjMvZaHsu0D2VyfaPFB/VUabROrZz8zstlbNLExw7qjCcCjTpEuN+lWv/EvFgDWTKgMb5fqOv8VOLwQQ3ERHhJfKyg3EIoTXnJgErUg5zaez1YP1QtV9xdBe7l6ox6G3Wd6WZPlht8IYC9+agfBGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=okhlQHGrhT6AQbLd8yyXQPg3c0ZVhbWJQErxqH1esr4=;
 b=HapMn/hOH7BMCgHhcirW07u/HFy8Zvn68X1omUj1BmfC/yuxpxw8XYa1jmAMkL7s6lJDL3/YZugyPjMv3s6l8i+eTTVna6h2tFynqKcezSLZv6Iq+h4uKQRX4qR3gw6obm181PW5D3hAWgwEyfx0kD6D8LWbxMdof+DVHNZ5rbWIPdfxG6O/163OSuNus7dnaoE4oHqSfh6MrwXlFB90dKMYucR7xpZP4tbTLJ7Nok52MuM+f9WWJBpYEAPm9zImf4kVMbtEtIaIns3FdtCL+LS2e91YDxnmzQoeM6qoj/BX483wjOmPMHdflVcl0H6ac+sNKyo9W2+KWHeXefnvaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=okhlQHGrhT6AQbLd8yyXQPg3c0ZVhbWJQErxqH1esr4=;
 b=BpDlbilKIDzb9Z2auJGOJe6UizeOAxoAXqwVRt0q6/Rxq8zHblbLeHSGWE0KKz+O5D0aOp6ZClxv7+wUNeMc7sfJCVjMrPG0WSgKztis8bZTDvj3q3TSuEaB5O+1lRpj6UHjpzksp24xmbXGaNkivGAFGi6c+bmOsFem0wTYeOo=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.59.16) by
 BYAPR04MB3847.namprd04.prod.outlook.com (52.135.215.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.26; Mon, 10 Feb 2020 22:57:03 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61%5]) with mapi id 15.20.2707.030; Mon, 10 Feb 2020
 22:57:03 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH v2] block: support arbitrary zone size
Thread-Topic: [PATCH v2] block: support arbitrary zone size
Thread-Index: AQHV4GBb7iHpS588lEStNx+mSa2OfA==
Date:   Mon, 10 Feb 2020 22:57:03 +0000
Message-ID: <BYAPR04MB58161D818ECE52AE4AB253E1E7190@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20200210220816.GA7769@avx2> <20200210222045.GA1495@avx2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [2400:2411:43c0:6000:d4b4:4f80:d46e:1312]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b375e546-32af-4479-92cc-08d7ae7c8bb9
x-ms-traffictypediagnostic: BYAPR04MB3847:
x-microsoft-antispam-prvs: <BYAPR04MB384752BF82B64A2C9A4F416DE7190@BYAPR04MB3847.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 03094A4065
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(136003)(39860400002)(366004)(376002)(396003)(189003)(199004)(316002)(33656002)(110136005)(86362001)(7696005)(186003)(71200400001)(6506007)(53546011)(2906002)(9686003)(55016002)(64756008)(76116006)(66556008)(66446008)(66946007)(66476007)(4326008)(52536014)(5660300002)(8676002)(8936002)(478600001)(81156014)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB3847;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 80hmRcCdlVEJhMlFpYmt0J3j8TxNJxXW61qDWqvXehLh15bzsEZ2VAXwMA02xscJtqRxWejgqrOovWDd2aBCbrQ5S7D5IF6lO9F+AA9tZW8MXDDs8odVGwwzbIJsSR9pIycQR6esGuyLOdbttrXHxiYyd67VBNSbsrsqQty07z1NVHLrxqxCzIcM4c8MeLnO2sP+nYnwphVR+xu7QsDF8mvNvEGzHqK+lvM40kK6lIvplmOUYpt72RzY45zjdkj/YWxsvYIfCS+8TmJE6UoAlv5Q8FkegRG3ruLHa8KFmVrcCxIPuFIjap+jK4SuD3oDSSW4Uy/sF6Pw00qixwrAvFnEqnkiMmd5/swskQmP9u/l72h9REBTqGQxt2QCtasG/4qfmPUgYPKgdsUOSynyll5n7jwv2fyEnjEESTGtn/KCLsqvqdWdAPGvNIfnTV4s
x-ms-exchange-antispam-messagedata: 0cr3XVOT1E1kRDgJft1+CcEbU+dtfaWUOdxVlnL0YBgaMnGyxKm7We0dw0r3aOswwgzmdsRRGc4m7ZSh7JWAHz7hLVinW2G4S/LBEz7oovwNSCp8mCXnIarDFu4dfDflcVY/Db+nJ7VyjfpF+3ifqIluIVJEHpvx0a6YPTjsqJnY1yzW5PzQmas8b1d/+ykP4siXP6191LTfyk9hT8nzQQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b375e546-32af-4479-92cc-08d7ae7c8bb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2020 22:57:03.8267
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hO6EirLapL+9nouElFksCQc9JiBXaRUyq1KWJQXA+kBQ64ef4UBBv75pxa3Php9nXQQiuKjtzgKPNWReeTPu+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3847
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/02/11 7:20, Alexey Dobriyan wrote:=0A=
> SK hynix is going to ship ZNS device with zone size not being power of 2.=
=0A=
> =0A=
> Signed-off-by: Alexey Dobriyan (SK hynix) <adobriyan@gmail.com>=0A=
=0A=
In addition to Bart and Keith comments, I will add a clear NACK on this, at=
=0A=
least for this patch as is. Details below inline.=0A=
=0A=
> ---=0A=
> =0A=
> 	v2: fixup one ">>ilog2"/div conversion :-/=0A=
> =0A=
>  block/blk-settings.c           |    4 +---=0A=
>  block/blk-zoned.c              |   10 +++++-----=0A=
>  drivers/block/null_blk_main.c  |   11 ++++++-----=0A=
>  drivers/block/null_blk_zoned.c |   10 ++--------=0A=
>  4 files changed, 14 insertions(+), 21 deletions(-)=0A=
> =0A=
> --- a/block/blk-settings.c=0A=
> +++ b/block/blk-settings.c=0A=
> @@ -206,15 +206,13 @@ EXPORT_SYMBOL(blk_queue_max_hw_sectors);=0A=
>   *=0A=
>   * Description:=0A=
>   *    If a driver doesn't want IOs to cross a given chunk size, it can s=
et=0A=
> - *    this limit and prevent merging across chunks. Note that the chunk =
size=0A=
> - *    must currently be a power-of-2 in sectors. Also note that the bloc=
k=0A=
> + *    this limit and prevent merging across chunks. Note that the block=
=0A=
>   *    layer must accept a page worth of data at any offset. So if the=0A=
>   *    crossing of chunks is a hard limitation in the driver, it must sti=
ll be=0A=
>   *    prepared to split single page bios.=0A=
>   **/=0A=
>  void blk_queue_chunk_sectors(struct request_queue *q, unsigned int chunk=
_sectors)=0A=
>  {=0A=
> -	BUG_ON(!is_power_of_2(chunk_sectors));=0A=
>  	q->limits.chunk_sectors =3D chunk_sectors;=0A=
>  }=0A=
>  EXPORT_SYMBOL(blk_queue_chunk_sectors);=0A=
=0A=
Chunk sectors is used by the entire bio/request merging and splitting code.=
=0A=
For zoned devices, this ensures that requests do not cross over zones=0A=
boundaries due to merges. All that code relies on power of 2 arithmetics=0A=
(bit shifts), so allowing a non power of 2 value would mean changing all of=
=0A=
that. That is the hot path ! adding multiplications and divisions will slow=
=0A=
down all devices, including non zoned ones.=0A=
=0A=
Furthermore, chunk sectors is also used to indicate the stripe size of=0A=
software or hardware raid arrays for use by file systems and device mappers=
=0A=
to do optimizations and also avoid merging of bios/request accross device=
=0A=
stripe boundaries. Not enforcing a power of 2 here also potentially breaks=
=0A=
all of that.=0A=
=0A=
=0A=
> --- a/block/blk-zoned.c=0A=
> +++ b/block/blk-zoned.c=0A=
> @@ -83,7 +83,7 @@ unsigned int blkdev_nr_zones(struct gendisk *disk)=0A=
>  =0A=
>  	if (!blk_queue_is_zoned(disk->queue))=0A=
>  		return 0;=0A=
> -	return (get_capacity(disk) + zone_sectors - 1) >> ilog2(zone_sectors);=
=0A=
> +	return div64_u64(get_capacity(disk) + zone_sectors - 1, zone_sectors);=
=0A=
>  }=0A=
>  EXPORT_SYMBOL_GPL(blkdev_nr_zones);=0A=
=0A=
Sure, and this is the kind of modification that will be needed all over the=
=0A=
hot path for bio/request merging checks. Not nice at all. Slow down for=0A=
everything.=0A=
=0A=
>  =0A=
> @@ -363,14 +363,14 @@ static int blk_revalidate_zone_cb(struct blk_zone *=
zone, unsigned int idx,=0A=
>  	 * smaller last zone.=0A=
>  	 */=0A=
>  	if (zone->start =3D=3D 0) {=0A=
> -		if (zone->len =3D=3D 0 || !is_power_of_2(zone->len)) {=0A=
> -			pr_warn("%s: Invalid zoned device with non power of two zone size (%l=
lu)\n",=0A=
> -				disk->disk_name, zone->len);=0A=
> +		if (zone->len =3D=3D 0) {=0A=
> +			pr_warn("%s: Invalid zoned device with length 0\n",=0A=
> +				disk->disk_name);=0A=
>  			return -ENODEV;=0A=
>  		}=0A=
>  =0A=
>  		args->zone_sectors =3D zone->len;=0A=
> -		args->nr_zones =3D (capacity + zone->len - 1) >> ilog2(zone->len);=0A=
> +		args->nr_zones =3D div64_u64(capacity + zone->len - 1, zone->len);=0A=
>  	} else if (zone->start + args->zone_sectors < capacity) {=0A=
>  		if (zone->len !=3D args->zone_sectors) {=0A=
>  			pr_warn("%s: Invalid zoned device with non constant zone size\n",=0A=
=0A=
You only have these 2 changes for the generic block layer part, but there=
=0A=
are a lot more to add. Anything that has ilog2(chunk_sectors) (e.g.=0A=
blk_queue_zone_no()) needs to be changed. mq-deadline and zone write=0A=
locking handling, and all bio/request split & merge checks handling. And=0A=
again, even with such changes, allowing chunk_sectors to not be a power of=
=0A=
2 will cause problems for non-zoned use cases such as RAID and in all file=
=0A=
systems relying on that value to be a power of 2.=0A=
=0A=
> --- a/drivers/block/null_blk_main.c=0A=
> +++ b/drivers/block/null_blk_main.c=0A=
> @@ -187,7 +187,7 @@ MODULE_PARM_DESC(zoned, "Make device as a host-manage=
d zoned block device. Defau=0A=
>  =0A=
>  static unsigned long g_zone_size =3D 256;=0A=
>  module_param_named(zone_size, g_zone_size, ulong, S_IRUGO);=0A=
> -MODULE_PARM_DESC(zone_size, "Zone size in MB when block device is zoned.=
 Must be power-of-two: Default: 256");=0A=
> +MODULE_PARM_DESC(zone_size, "Zone size in MB when block device is zoned.=
 Default: 256");=0A=
>  =0A=
>  static unsigned int g_zone_nr_conv;=0A=
>  module_param_named(zone_nr_conv, g_zone_nr_conv, uint, 0444);=0A=
> @@ -1641,10 +1641,11 @@ static int null_validate_conf(struct nullb_device=
 *dev)=0A=
>  	if (dev->queue_mode =3D=3D NULL_Q_BIO)=0A=
>  		dev->mbps =3D 0;=0A=
>  =0A=
> -	if (dev->zoned &&=0A=
> -	    (!dev->zone_size || !is_power_of_2(dev->zone_size))) {=0A=
> -		pr_err("zone_size must be power-of-two\n");=0A=
> -		return -EINVAL;=0A=
> +	if (dev->zoned) {=0A=
> +		if (dev->zone_size =3D=3D 0) {=0A=
> +			pr_err("zone_size must be positive\n");=0A=
> +			return -EINVAL;=0A=
> +		}=0A=
>  	}=0A=
>  =0A=
>  	return 0;=0A=
> --- a/drivers/block/null_blk_zoned.c=0A=
> +++ b/drivers/block/null_blk_zoned.c=0A=
> @@ -7,7 +7,7 @@=0A=
>  =0A=
>  static inline unsigned int null_zone_no(struct nullb_device *dev, sector=
_t sect)=0A=
>  {=0A=
> -	return sect >> ilog2(dev->zone_size_sects);=0A=
> +	return div64_u64(sect, dev->zone_size_sects);=0A=
>  }=0A=
>  =0A=
>  int null_zone_init(struct nullb_device *dev)=0A=
> @@ -16,14 +16,8 @@ int null_zone_init(struct nullb_device *dev)=0A=
>  	sector_t sector =3D 0;=0A=
>  	unsigned int i;=0A=
>  =0A=
> -	if (!is_power_of_2(dev->zone_size)) {=0A=
> -		pr_err("zone_size must be power-of-two\n");=0A=
> -		return -EINVAL;=0A=
> -	}=0A=
> -=0A=
>  	dev->zone_size_sects =3D dev->zone_size << ZONE_SIZE_SHIFT;=0A=
> -	dev->nr_zones =3D dev_size >>=0A=
> -				(SECTOR_SHIFT + ilog2(dev->zone_size_sects));=0A=
> +	dev->nr_zones =3D div64_u64(dev_size, dev->zone_size_sects * SECTOR_SIZ=
E);=0A=
>  	dev->zones =3D kvmalloc_array(dev->nr_zones, sizeof(struct blk_zone),=
=0A=
>  			GFP_KERNEL | __GFP_ZERO);=0A=
>  	if (!dev->zones)=0A=
> =0A=
=0A=
And beyond null_blk, other drivers are affected:=0A=
* DM core, dm-linear, dm-flakey and dm-zoned=0A=
* f2fs and zonefs file systems will not work as is on such drive. Ongoing=
=0A=
brtfs work is affected too.=0A=
* probably some things get broken in the scsi stack too.=0A=
* And user space will suffer badly too, at the very least all user space=0A=
tools associated with file systems and DM format/check and sys-utils.=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
