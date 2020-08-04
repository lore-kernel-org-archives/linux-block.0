Return-Path: <SRS0=uCqz=BO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9FFC433E1
	for <linux-block@archiver.kernel.org>; Tue,  4 Aug 2020 10:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9108622C9F
	for <linux-block@archiver.kernel.org>; Tue,  4 Aug 2020 10:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Jf44Ldk9";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="tdFd463U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgHDKRR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Aug 2020 06:17:17 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:34152 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726450AbgHDKRQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Aug 2020 06:17:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1596536250; x=1628072250;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=F0A/iC8jwEWHi/mOltmeYWNLa9SlJhb6sQPP4YQ+btY=;
  b=Jf44Ldk9M9QgGOwWAEh9KVNNEt1wX38p1BwR1yWXRedhEeMlb5jNhASy
   4SMzANiuCZ8iSEvbOnNHIiQIb3m7KNiCKRCVfT3oTIK7ATHxRC29BDxjU
   5/uWKJgyIyDuNouW/PhurvmcpWF5Bgfu2g3tGGmrqTQG2GiO9WzO7ZdDv
   NsRoHjh7Z+DUHN3rVRsMqRB3DtbwU5jJ2bpqLWsszFJlWkrP41HWkjE6i
   dM2duiqzQRCzzjBdEsuwFNYXEMvmRmJC1J/W+kOnGEIBk2xkxNuNjXQRd
   pOwROPsaILuE2dBswOAX+JgYBKLdoWEtAtR+lgHw6sCvvINcNgx80NhuU
   g==;
IronPort-SDR: 9qST+b6EWv8iNFXlx9Ls7MGYT2Obbf1xw5WNznja83BNpR9oLwrSmMtw38+EeYEa4PIyhOCcBz
 abY16zQDKvbryZy13KbGzDnM6KJNHejcIRNRTT7mNRnU3yzPA69J3jQ/415JF/pjoygSxDp9ru
 /QH6P+/jczzBiaYL3lgLF5GhOBQJ3+7G82QfmZHLFxQDNRMT+cf0PYKU1LHW3/JGFiIJsh4W07
 nI7TCVun0+fsDGL0ajKEvgHpGn8x/idtjoqdoAbTPFo+V1ByGR/Or9fRsBx3PK8BvKCrSVnqjd
 csE=
X-IronPort-AV: E=Sophos;i="5.75,433,1589212800"; 
   d="scan'208";a="247197328"
Received: from mail-dm6nam11lp2170.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.170])
  by ob1.hgst.iphmx.com with ESMTP; 04 Aug 2020 18:17:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NrzpDPelyjdVS6+7WdYsGL7ExJ33kE5DAQt13iNXc5lC2Wj/SDNkwLwqQbiy9vek+5sdpUXkZF4T/4WOEtb4iJbOoTTyYiQRDQALyIKBbgVoP72DLufm+njdZyaJJHtMdQZmucQLA6baeKoWOlpG0rZoPbMrmrvIPvUdpX3Lz2Ytmss77FXDL/Sa+tE0d7iHP0qZ04q6FTctsHKaE2X9cEklY44t/vQsIjtHwkFKZGIi70t59f9NoX6bqvTGtk3TuBNWIUnvzLVwUIcf3z0JP5lhzyXoOUy7CHaAwUkmYhXgwTKOtDdfiKynD4TifrxifNQ7p9r5fIEem5hV17G11w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=83LbDRfO41twgBpf+0AeAIp+AZKVauRmRI0oSU2V9EU=;
 b=T+ql4vodQauPKgz1Vivw2p6pE+2gp44GKSRos28La0EIps6NpD5nQ7rwbbSjJjxtQVA4jbxA+G1GHn+e4WJfemil53UaC0elwZ0a6jNvZSgfmiIAlmk0bXHTPCQyP3bWipTdWOrXYmlhQ15iXnsZd1G/6V1Jl3VC2xv1LNVZ6wyQ9gsm2rhRERT9j7TVdC5km1wE/cbYWdfdRDvSZ3jsHJyT6mEPMcQ8mQw/XrylzirBWLxxQMv3i2bdDfGh4F215zDR4wMqREMAbfMPJsf5zoERTbV4cEfe/ASeEwjv07ngCJo586Eh7bfzrRkF+/X2Dw/ppURZfZq0zDhXUUkF+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=83LbDRfO41twgBpf+0AeAIp+AZKVauRmRI0oSU2V9EU=;
 b=tdFd463UFYCkLoq2bmdaxhovd4KZ4hesg8m81qN5eCV/rxKT/xDl/8u7+3ej2s+kFCZl1Ef2gmUZR41TZ6tJPtDjRNPg/betfJSTjVoZzpQlqr8VdTof27x++excQ/tIXf5xrJfFoQlxnD/8DK9Edfo63EmykhNdVkFUd6x3fZk=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR0401MB3585.namprd04.prod.outlook.com (2603:10b6:910:8a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.21; Tue, 4 Aug
 2020 10:17:14 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::7d15:9936:4b3b:f8a2]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::7d15:9936:4b3b:f8a2%12]) with mapi id 15.20.3239.021; Tue, 4 Aug 2020
 10:17:14 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Mike Snitzer <snitzer@redhat.com>
CC:     "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH] dm: don't call report zones for more than the user
 requested
Thread-Topic: [PATCH] dm: don't call report zones for more than the user
 requested
Thread-Index: AQHWakEnDK0PwnclYUCJoRsBiHaPCQ==
Date:   Tue, 4 Aug 2020 10:17:14 +0000
Message-ID: <CY4PR04MB3751EB538B7F29FBDBB4EBA4E74A0@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200804092501.7938-1-johannes.thumshirn@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [60.117.181.124]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 18aea11c-18fd-4ad2-f1a7-08d8385f8f10
x-ms-traffictypediagnostic: CY4PR0401MB3585:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR0401MB3585A8C16D4AD92E8970B9E9E74A0@CY4PR0401MB3585.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d9LsQY01wMG3gtJ+gfhBjSOrhP0XnO95aNjTvHYYhAqPuL70sQwOW0Hcb1CKox6KYddlWv44E+83i9D0aioL5uZwHLKtOrkNGRu+3GVQeKQZqzypPQ+HSkxbEmaBC04Ptm0YCW4lABCkCIfVof3+Scc5aXNy9QQutfjRzdnFiEi3vu2Yh3nX1a2Ztmy0bAUNwxl2Ve2WbJMJl3mljA7pn1ZJOoqNu1qbgZWSFb5SlWFkyZXmJ6PR7KGu6+qqpL0252BlkIpn51gnRrEoiwd98vt+O9fXSXo4sUfEucmVt4SI2ovB/NNjzArkmTKAEmZ6/r52xkdJatDAzUekmYWhLg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(39860400002)(396003)(366004)(136003)(346002)(64756008)(66946007)(66476007)(316002)(110136005)(76116006)(186003)(71200400001)(8936002)(4326008)(91956017)(66556008)(66446008)(8676002)(54906003)(53546011)(26005)(6506007)(5660300002)(55016002)(83380400001)(33656002)(2906002)(86362001)(478600001)(9686003)(52536014)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: M2eydkx7QvLXrRGvVop0u20FEC5S6OQ1Mh+wWcE4Qa9UixUS9eOxYhoHqFhpLuUQfwkr+pLvJU5xYaZ1sm69rOdgrTUdqHur+U628B1dBBf2ezEjFCrn+pBW2yRaFgAtgpJ2sOsd1hce1ZYfHwFB3Bzb5Ez6vqUYObFq0OcUQHrOewFMPVG7vLWzIEOZrEbdfancpbVQlIoVq2t1JywZqymGe+g8Heis01q7jfMy74nNMOUNZKlXpS75+VxiicMeA1I0w1fc9Bna0+y2zs27it2iZkXoYWmAJ1isrFRjkNxAFrm4UORyAXaoW1tJzoPEKEEHITMi8Zg5c7AOXmgrcnfPHybeeeyewxZdiZQ9gjEfFfBESGUVi7J7WE06grYECaqwWMNCtLd2X8LvFPGuCKvA7rqg/lo9COZY9QdqQzhxK+0xCtjCg6Z0yoNf4beEuSUqtMrpTlUHM8gArgTWwbNsIr6eP2q/9BSV3OkGosgkeG7B6i//7KyND2JhY+5TOOC3+IPszpKWLwAaTVkCmIIo8jdkn5L2czcVBijeAXScAXwnC5wImJzHNY3uVwnKT2M3v2x/UcSHcrt1CItTLD5FSZjDrWuHA3lLnNg8wR+GWXS/CRlgYPPNigzDLaJAs07HtY+py94B+kgqLlvZew==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18aea11c-18fd-4ad2-f1a7-08d8385f8f10
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2020 10:17:14.5336
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AJZf8nyrDKOchwhErRoigfF/ANFgmHVZHCMsm9VZyZ4fA34rZCvFcEwJTyjvl7Zew06jtJUHGofQJHCGQWBRhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0401MB3585
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/08/04 18:25, Johannes Thumshirn wrote:=0A=
> Don't call report zones for more zones than the user actually requested,=
=0A=
> otherwise this can lead to out-of-bounds accesses in the callback=0A=
> functions.=0A=
> =0A=
> Such a situation can happen if the target's ->report_zones() callback=0A=
> function returns 0 because we've reached the end of the target and then=
=0A=
> restart the report zones on the second target.=0A=
> =0A=
> We're again calling into ->report_zones() and ultimately into the user=0A=
> supplied callback function but when we're not subtracting the number of=
=0A=
> zones already processed this may lead to out-of-bounds accesses in the=0A=
> user callbacks.=0A=
> =0A=
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
> ---=0A=
>  drivers/md/dm.c | 3 ++-=0A=
>  1 file changed, 2 insertions(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c=0A=
> index 5b9de2f71bb0..88b391ff9bea 100644=0A=
> --- a/drivers/md/dm.c=0A=
> +++ b/drivers/md/dm.c=0A=
> @@ -504,7 +504,8 @@ static int dm_blk_report_zones(struct gendisk *disk, =
sector_t sector,=0A=
>  		}=0A=
>  =0A=
>  		args.tgt =3D tgt;=0A=
> -		ret =3D tgt->type->report_zones(tgt, &args, nr_zones);=0A=
> +		ret =3D tgt->type->report_zones(tgt, &args,=0A=
> +					      nr_zones - args.zone_idx);=0A=
>  		if (ret < 0)=0A=
>  			goto out;=0A=
>  	} while (args.zone_idx < nr_zones &&=0A=
> =0A=
=0A=
Looks good. I think this needs a Cc: stable.=0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
