Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A022C001B0
	for <linux-block@archiver.kernel.org>; Thu, 10 Aug 2023 13:10:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbjHJNKf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Aug 2023 09:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjHJNKe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Aug 2023 09:10:34 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31C191
        for <linux-block@vger.kernel.org>; Thu, 10 Aug 2023 06:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1691673034; x=1723209034;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=fs7e6Ic7kFccCUpomYua08TBv4Rg/pAch2JZqYv4lSY=;
  b=oBZXZ+3+trHY2AOlnUcLtdjltyrBBorUa2oJfSm9bCsvT5jSYxrdb+S2
   qTyB6/HPpA5WG4jcJPyFA+fc9hyo6C6q/qtGyorFqYGmwvqkklrBCPM8b
   TeIKdBAkE1n0XmnIjauJXH0tnn7HWMKUBR4doRZ6iUWUHtGIi4gegVzPs
   +B70AslLvAJngc8Pi7OLnt1F295YL/pmU2SLPJwCTA11sE6sH3ZwGVB4X
   7H6UwBaYQ+Sf1E6N7RrXIEqG2xa+FuB2wyoX9AtmbMHv68k0vHH62LVDv
   LZpZFZ6mrAciXqXtYh91SPkwLH0VmyE9fYTE7egnRDjgfPcpYqzai2aGR
   A==;
X-IronPort-AV: E=Sophos;i="6.01,162,1684771200"; 
   d="scan'208";a="240542049"
Received: from mail-bn8nam04lp2041.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.41])
  by ob1.hgst.iphmx.com with ESMTP; 10 Aug 2023 21:10:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cc+ULMgFP0BrcHs0n8slUqemK0S2INwQq2IeH8R10X15/H1iSnvBRWHwGP+jYZAGxHyLB7PwLVdyl+DZRZi1r0bljAET2b7Mc7UzpbzTV+et6fjlkb6UbfVaneBec7R3k8YOV+sBvQXPxDyqLre6HTDtN6znHPnBIi6J/1c1e0usPPOupMofLZdkqzsV95d89hbGPPm/hI1yShp9U09YE0/oSnAqtPY8ifxDiVEARi+EmoIJaPebgWzSTDe/2Hgxhki1E7dxJ2Vn34slk4CDIM5jD3ifxPpJcoRJiqfadAxKcMMGrxRY70ajcju1howP7Eni5VZqLqNO6X2l6WJ6xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n4wm9qXVcar3bE0clZFdEWMVvrtfhUz1A+uhGN49uBc=;
 b=K2yZRJJQ9e1SlzFw1MPrIdG/+0+PpSuHHyguJyXTx84VT137IZccLYhMucjoXyEdtmjUtDmb7g7plfA8g/qNNa6INR6ZqdfezF8Pyrdb20rpMW2IqQwEUFCkvhfILZoWG01nDr/SNTurnXRqKKd2ai1j6/UhfF104OeIQuMl0fJJpEa1Iez/8EdxwUr2JdG+4g7g5wuDFOF4QWTbCPN3pLZC/fQjMLs+uYBTWwNP+goTlKAoD0qXfKHxK98YX0ycoRR6t1D3lQhwV9plSnwub+z6UaFm14sWjxjpnVPX0frWp0o+zeXV2hEcLxsqBHGUYb99Ywm/J2aDNTVDXYxU+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n4wm9qXVcar3bE0clZFdEWMVvrtfhUz1A+uhGN49uBc=;
 b=So5ZdEHqaAqE8o0dIF4AC7kR0mkXtlHOzCvhjQn/ROQYjbbpWo5cJ28022zdJmtpJA2afGovovdylvNwEzkZYMDsz6Ab+vA5cZOzB10zdTCYCKVGV9IGdCqhycjX+I9WydHYfqLJVWqvk9ehA+3+UsW03eKHjYiLy9bAd+3fBD4=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by SA2PR04MB7626.namprd04.prod.outlook.com (2603:10b6:806:142::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 13:10:31 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::d093:80b3:59e5:c8a9]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::d093:80b3:59e5:c8a9%6]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 13:10:30 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Andreas Hindborg <a.hindborg@samsung.com>
Subject: Re: [PATCH V2] ublk: zoned: support REQ_OP_ZONE_RESET_ALL
Thread-Topic: [PATCH V2] ublk: zoned: support REQ_OP_ZONE_RESET_ALL
Thread-Index: AQHZy4hMzEohYWMWrE+MOG55GSQMF6/jgPsA
Date:   Thu, 10 Aug 2023 13:10:30 +0000
Message-ID: <ZNThwMBAqqVUGtek@x1-carbon>
References: <20230810124326.321472-1-ming.lei@redhat.com>
In-Reply-To: <20230810124326.321472-1-ming.lei@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|SA2PR04MB7626:EE_
x-ms-office365-filtering-correlation-id: 60c8134d-68fd-4f4e-b6b2-08db99a32c62
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FWFtLg2RSSC1kUBg1RYFXy294GOrJb2yrt/lRIl23Ci7X/7Bh0TPyDf7se/mCJRhVT5R9dKNJnuUUXc5HBcWZ2+2uKUyFA9K5cW218V2PJQadjrNRRxSgIxwvDVtffEQihg7TKzKS+gW6Rk11BzqK07eCpwH3So4ukR0J5YUd8oQYvkqdZnox14qS4/xiPnCv/ldqndDA0D427gwvqTsCjL8er/sbZlnYKlKU5sfJRGpK94O4PGWacQ8lAu06Fj41Fa/RYI0BN3oPmyP+sInMJu34ZoJx+MtlFj7Mar8/AOqiSsPcLo+GFbqHVkmTkyN+VGQ7ULj43bcwDzfD3ZKgdP/6WPPP4w9AlBorlhB1QADLLXCxycrBw2VEd9IM2BqwlECqN4q7dXbIiq+yjPX1BUjoqq3dJdHbytiDNYtK4ZQiOY1Y5OMXa8TWRihdLnw2+vtpKx/0iHsWtqIqX6lKvXnebzX0UmnBJ93GMCRkwWnjgBQ4mpM4qci5CFP8v3xfVDx8Ikl22tQgAN2/2k5L5TWsLDWuLg51pHDQVHknpWtvIpDr7npkWS+xKYNxPqYS0vk0Uw7Xz+ABye0gUWa8wCiCPCwKsRoLGg/YFfmY8laFgu+Fw/wVHHDLPipZ3dhESazVIckCceaJR02PsFIOg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(136003)(396003)(376002)(39860400002)(366004)(346002)(1800799006)(186006)(451199021)(54906003)(71200400001)(478600001)(91956017)(66946007)(6916009)(76116006)(26005)(66476007)(66446008)(64756008)(6506007)(66556008)(6512007)(6486002)(966005)(9686003)(4326008)(33716001)(2906002)(82960400001)(41300700001)(316002)(5660300002)(122000001)(8936002)(8676002)(38100700002)(38070700005)(86362001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fn7O1C5GQZE9IGDgQ81Lnt1XuivIf/WgtHAtlZxL3KkyHemLMIuq4fA5bChg?=
 =?us-ascii?Q?lFxpmHSeBLu9yrExuM7WzY6hVnept9KNNWSTlwmp8DRkU/Hj2UllYhKLeVPQ?=
 =?us-ascii?Q?17ANKL78lUs5Cd14/GQ2k1HTgITnrw69vC3zU/+VNJeuSL9aHO6KswLGATRw?=
 =?us-ascii?Q?3Q+3qAgueyd4beJlng/2l1eR8Uvmr/rPgr3WLYCMGG0YCrb7Jhys6Qb9MkaH?=
 =?us-ascii?Q?U+k/FI6wclT8LH7lPP6oNTaAQ8elHK1/ZL3CDcZJn5AtlO9E/VXSh/01c/77?=
 =?us-ascii?Q?M9exlnU78Ky+Uc+jxK17wPLSJ0NXlzaPCJAsK4hjz4wjlLjv9F2U1mRAb2ij?=
 =?us-ascii?Q?ktS8z70yM6YjMm7F5+08yPjOa/dOMevBz5NbX6Pwzs5w02K1eCBHMRwvfvCy?=
 =?us-ascii?Q?+PKr4uQ3vi6fkHVrfUm3HbIz+3KHQY3YYBZb3fb2f0+yt45wluiTOVHk5hlJ?=
 =?us-ascii?Q?bNqBZ4MSAjZRzMvWgusI4sYijoLSG4cbmun014eitxdfBCGXpWgEQIkZOtOI?=
 =?us-ascii?Q?lItPVg5SdLNOBQTZcgwmPycpQh6dTuftbPmgEeXrMuDo7+fyQxMLoXUMXD0x?=
 =?us-ascii?Q?8LOebCnHBwtLVfJGbI8JkC5h1Er+UZppWcRxeYaUs5RF/F442vJtF9uw/j9l?=
 =?us-ascii?Q?d3dfvfBNaevcxxCLXaCTeN8cTqR8U2oTh7Um/Pz7gtuE+b4q8dpqqotRcIXr?=
 =?us-ascii?Q?2qDUnV0Hm3V4pNgnNZJ3kB99AEFRCaz5g4efABzI9uDmOUE6wLMuQrejlTBi?=
 =?us-ascii?Q?z9GUSJyC8TM+peE/QjyYkU41NTx69EP/CP/t7B3RYJL9BrUUQ2s80s5d5G5S?=
 =?us-ascii?Q?2KIW7PRN/hjQfnJs0amfATX9A8W27D3m7vYT9KB9UfrCk6kXUp28YNUNK9T6?=
 =?us-ascii?Q?UL8wBjDwWCn8gxsd29fGnA7ubA4IVmB5K1Dj/CBNgvKKBZU0yM2uJ/7j6vGr?=
 =?us-ascii?Q?1dWNCqHa8fNl3w4MMD2u9PRVQlBfMPzZ0CUClHG7nQHYrZbwB/GObUz/wZf9?=
 =?us-ascii?Q?kA1PprxQKqy9REWM7nMWQA5RfO9UahtCdjCsG8WHHd17r5qa3Kjx0dltw1CT?=
 =?us-ascii?Q?9rycLbeenbAlSMrnRgT/2+xJQuB0ZR9Eu8ZoQA12YOjB7FHyH88yU6Qy7Kgx?=
 =?us-ascii?Q?J4AWofjhp9oFFRpFWiUQ56gPBOURP+Kv9nIlWhqNEXIcpYchs/M5HDvGMpLv?=
 =?us-ascii?Q?9aT5U0KqHZkc+T5FORTsjdXTDtKYK2j26C2VOHeuLMbt9k84HRi86z+VzfpF?=
 =?us-ascii?Q?Lh9fJnO4QMcE/WDaGhnfeTUwuMKc5zLuRpmfliTKtis19QIFs1HBTguCjMEF?=
 =?us-ascii?Q?tBpt8v2YHcwWSG9jn2lufyECpuFp2lnhFsjpJhYIYegE5WhtrXi42YET9YaL?=
 =?us-ascii?Q?6o1dJFmCaQCn2bcJDu8IiJWbOONP1tt5rXwJynqeT4+02YsafavB8/IXzBYo?=
 =?us-ascii?Q?RWHLepmVOV1HTLLBQUE6tFkxBgdiX8CYXSkJOk2Rt1iK14Cin0IzP0w8lIq7?=
 =?us-ascii?Q?sxB7yYXQdRgXZojaynV9AOzPVDru1zRi9WjiztHA03+iMnlzh0CjdS0f0qdu?=
 =?us-ascii?Q?QSJ2yN9alLsyY2skshuvrT9tRzx7OG/JjbMG/a1xFO3AiUkBjBasa5MmfvOG?=
 =?us-ascii?Q?ag=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1652FF535457074298240D223BC63141@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2mn85/UwxuzGYss/jin4OMv/OVrCB3S/vJy1nTaexxY2Pq6fkBMjdtU+tzs1VenAHkUvw60DU24+QuGfCpKv9hZ/UpMHrx+vwYxgJQWqkR2TZkKzYcU7lyRB5FKR7YZWTfBI5CHTtz82xpzOImvzWgNNibNb55PFLQcBaKmHvbMnBOKVElwqZlysj1wFNjfgXf7R1igixNqIyhIJkkZ7IlOMSBXjCG7o/laygPsSPOnK/tstZzJbf7wWzU3V1tr13dq3uFW2lXkSWI7ArU/scaV2eEgLgDGw1R46vCjvv571452y+OXBCvm/2MlEdBKXt+ppzXvtD71gBdmD5Ul9BYKo0drYeojVDBL5svw21bMzR+8e5TBCzkcg3TKuyzHyiewXsZPgPcrY9UzwCz3eF8NZIMqZk5RRyTk3G8WaNeOKXV+GtdX0zJ3TQtDkG+JyXoDIA/Ijosf/SAqWE1+2Nz+wtMq01TYHj6WH23cvap9evYZQrD4ndfqIeY2Dfu1M7CUkTOiOL7HeVhdZSKw4xNkkBnNoQblrnaVaqQimYKID6fr50x4dRxRk9FHsekGZpdrSAJvG2NeG8g6MWTvmzgkz1Fg3rG9+/hhobyCzrzgyoR1FtBNF7xPXOY0QzrFmVDvUL4FWyjyVP80tHtbp0fFa3Im85cMSlImJIO7aiwpVLqLyLpNHe+aMID67RqF1RlR047HPtEeSWsACKB9UdTNUT0lNIA2kmN7dlrUxkx+X/FRzM3fXty/6aBH9lo9l2UpLBQY2Z6sIFxr2rBoedOxXvgceAQeio9SY4Ck7UCVJayYUXz3po55wjDELs8vyQ0Qd1OHDLeEFFlD2jHclmlMYHPFW6EYTqdXkf8U7suK/+4xTprT92DJgP0qr3uiA+7diCRJAg7DMyTffdL4A8w==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60c8134d-68fd-4f4e-b6b2-08db99a32c62
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2023 13:10:30.6409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nQxAbceOFLikSW0B5jKlmTuQK89nAkBfwF7Ieo+e2am6A8m0Vf3nKhk9MDBnPGCBwpJqSFZodxKqOTiV+XRZsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7626
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Aug 10, 2023 at 08:43:26PM +0800, Ming Lei wrote:
> There isn't any reason to not support REQ_OP_ZONE_RESET_ALL given everyth=
ing
> is actually handled in userspace, not mention it is pretty easy to suppor=
t
> RESET_ALL.
>=20
> So enable REQ_OP_ZONE_RESET_ALL and let userspace handle it.
>=20
> Verified by 'tools/zbc_reset_zone -all /dev/ublkb0' in libzbc[1] with
> libublk-rs based ublk-zoned target prototype[2], follows command line
> for creating ublk-zoned:
>=20
> 	cargo run --example zoned -- add -1 1024	# add $dev_id $DEV_SIZE
>=20
> [1] https://github.com/westerndigitalcorporation/libzbc
> [2] https://github.com/ming1/libublk-rs/tree/zoned.v2
>=20
> Cc: Niklas Cassel <Niklas.Cassel@wdc.com>
> Cc: Damien Le Moal <dlemoal@kernel.org>
> Cc: Andreas Hindborg <a.hindborg@samsung.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
> V2:
> 	- update comment as reported by Niklas
>=20
>  drivers/block/ublk_drv.c      | 7 +++++--
>  include/uapi/linux/ublk_cmd.h | 1 +
>  2 files changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index b60394fe7be6..3650ef209344 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -251,6 +251,7 @@ static int ublk_dev_param_zoned_apply(struct ublk_dev=
ice *ub)
>  	const struct ublk_param_zoned *p =3D &ub->params.zoned;
> =20
>  	disk_set_zoned(ub->ub_disk, BLK_ZONED_HM);
> +	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, ub->ub_disk->queue);
>  	blk_queue_required_elevator_features(ub->ub_disk->queue,
>  					     ELEVATOR_F_ZBD_SEQ_WRITE);
>  	disk_set_max_active_zones(ub->ub_disk, p->max_active_zones);
> @@ -393,6 +394,9 @@ static blk_status_t ublk_setup_iod_zoned(struct ublk_=
queue *ubq,
>  	case REQ_OP_ZONE_APPEND:
>  		ublk_op =3D UBLK_IO_OP_ZONE_APPEND;
>  		break;
> +	case REQ_OP_ZONE_RESET_ALL:
> +		ublk_op =3D UBLK_IO_OP_ZONE_RESET_ALL;
> +		break;
>  	case REQ_OP_DRV_IN:
>  		ublk_op =3D pdu->operation;
>  		switch (ublk_op) {
> @@ -404,9 +408,8 @@ static blk_status_t ublk_setup_iod_zoned(struct ublk_=
queue *ubq,
>  		default:
>  			return BLK_STS_IOERR;
>  		}
> -	case REQ_OP_ZONE_RESET_ALL:
>  	case REQ_OP_DRV_OUT:
> -		/* We do not support reset_all and drv_out */
> +		/* We do not support drv_out */
>  		return BLK_STS_NOTSUPP;
>  	default:
>  		return BLK_STS_IOERR;
> diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.=
h
> index 2685e53e4752..b9cfc5c96268 100644
> --- a/include/uapi/linux/ublk_cmd.h
> +++ b/include/uapi/linux/ublk_cmd.h
> @@ -245,6 +245,7 @@ struct ublksrv_ctrl_dev_info {
>  #define		UBLK_IO_OP_ZONE_CLOSE		11
>  #define		UBLK_IO_OP_ZONE_FINISH		12
>  #define		UBLK_IO_OP_ZONE_APPEND		13
> +#define		UBLK_IO_OP_ZONE_RESET_ALL	14

For some reason, it seems like the UBLK_IO_OP_ZONE_* values
are identical to the REQ_OP_ZONE_* values in enum req_op:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/inc=
lude/linux/blk_types.h?h=3Dv6.5-rc5#n371

I don't see any obvious advantage of keeping them the same,
but if you want to keep this pattern, then perhaps you want
to define UBLK_IO_OP_ZONE_RESET_ALL to 17.


Kind regards,
Niklas=
