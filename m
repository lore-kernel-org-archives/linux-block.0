Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5467C433F5
	for <linux-block@archiver.kernel.org>; Tue, 31 May 2022 12:21:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241614AbiEaMV0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 May 2022 08:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbiEaMVY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 May 2022 08:21:24 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2EF8149D
        for <linux-block@vger.kernel.org>; Tue, 31 May 2022 05:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1653999683; x=1685535683;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=yeVmRVIWtHmIHJwu3ADKQtZKNfbTRr5P5l1L8nRl6OI=;
  b=MeMitrVeytcjESsaRwuAX3E6Roxv5EfaG3exc59C/G4HGSLPgA7Ri1Hz
   rA+KrFIMJA/+TdZexkUfGIDBV9coyfo0SET3QSRTTR+oDf9jSsoHJt/zj
   jXdztXLu0fvRuSgQK814P5k5+5O8I83CvpjbkjoyalgLzMjiXAP3BEm38
   simxqjCfSXfV5CU4Ao4aEjtp1dv1zy69xL4aMMnagYKRAddpSiiVvkofb
   32WoCritiWVJV0Niv4qvywbCiYfdClVAp5iY1X66CUTTuSbUNnDdjTwma
   4iexk8foW2ArUKiHoG5AwHjDa2qWh84i0zL9sw5aSRgVIoVedRB0Ocnzz
   w==;
X-IronPort-AV: E=Sophos;i="5.91,265,1647273600"; 
   d="scan'208";a="313903970"
Received: from mail-bn8nam08lp2048.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.48])
  by ob1.hgst.iphmx.com with ESMTP; 31 May 2022 20:21:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fqhnhMn7VKLsHyrDsrKDMyN51Laiyw5ZSLsh2sHFNdRAoa0SQi5weSagWZglbsqSTjlIWLMIU6M5foOZJe+N5oS8/fqVjiBV7ZCpsAfFU1BOWvwB+bx8VNibIipVE/UntIz5MlpV6xKuQvgIgAJ4Udl5IIrbGkFJx7OvDvuVbQN/PF2DgBo8q+Ty1dWgNCpup6sMclTEPhHwQ2p49lFW1F6FCK6wkDv6g9e+19Po81RJyzRjeHgJBORZc/NaLBluuyN/Rw9uACz/cS7xRJkXGFxNCWCs78vPnuAV2IyHbo5Eopgqf5naSi0MBuA0SXATwjYhsQF2xqLVSIcT+05ULA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u8AYp/WazrWnWSlhXXBvEOXDaHhmMO4S5P6d8qa/igk=;
 b=WTtWheG6fLgzEqapiz4HXuUpRCPxRgo5Ba/kahxN0T2QDuYHk5VTp4KdoyyLYLrSg56JMtjbzUNWmAw3Dq9tvypCKGf2QtsWxGksrr27/+sxX7PZjdp/jbmS/4ooezPYshYBCkW3Sbvakfru8dLNxWhzinNiOxHG5GwCEp80HDBK1ym8zrFRsBx1CA8NcDDiwkKUw1Ii4QZ821G5BYZT+ZvRh4X+IET2NB2VhxEkQEnZVpPlUraXST1EgmhJHPUyFPuV/2pjlPrHNnrgrcJ65fA28AAYAA1pXZQ4zQCABC5pQb20ZDu3RE0zRITl87UvFcQtP5gnpft93Z/p0PgUMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u8AYp/WazrWnWSlhXXBvEOXDaHhmMO4S5P6d8qa/igk=;
 b=icUVkcBnLbuCKZfY/nqVH6dAQxz0clwC4EYYowKx6Dd+KRfKUdD7CdI+/mEjkRVHtl4L6ezzqYrTl3asXCC9ZxmWNzTJlBZVMPbN1vBbxZoIOr7rYGe38L12e2W04fReiRLc+KfF9V3IFExX/SldrM8JJeMk9gmnAE0uNdtzibw=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SA1PR04MB8238.namprd04.prod.outlook.com (2603:10b6:806:1e5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Tue, 31 May
 2022 12:21:19 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7%3]) with mapi id 15.20.5293.019; Tue, 31 May 2022
 12:21:18 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests 9/9] common: do not require scsi_debug support to
 be modular
Thread-Topic: [PATCH blktests 9/9] common: do not require scsi_debug support
 to be modular
Thread-Index: AQHYdCZjIbXE+Sj6HU6lvM3bVmbTw6046Y8A
Date:   Tue, 31 May 2022 12:21:18 +0000
Message-ID: <20220531122118.xrx2bwx4caywez7y@shindev>
References: <20220530130811.3006554-1-hch@lst.de>
 <20220530130811.3006554-10-hch@lst.de>
In-Reply-To: <20220530130811.3006554-10-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c15306a9-26d0-4ff7-d56c-08da430010f3
x-ms-traffictypediagnostic: SA1PR04MB8238:EE_
x-microsoft-antispam-prvs: <SA1PR04MB8238A5CBCA50A7F9A9F89555EDDC9@SA1PR04MB8238.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XFHkMDxTo/94Lc5M5LcprsqaV1bEa/mk+yyNGopIUktpnIa2Etj2oSrW4nAPrgA09VGJzB+a4uxxoaB0edzZbzmt6GKtnW6No7DMYoqKMQW9XnQT+fvLUIiY7fvTk8Fl8bUX/ZH35YVt1wv1CM/IcHL3MPwPG5pieHRG+RWomfxSskh8uesNKiLoKMJbEYCaWqlzhW2PBMItS3er34czvlAxUQv/HAWwFEnenWZwCyjT34Y9/YHfqoaxDsTudD15XdNwSLZGf+hGzKR8szOSCNT8X7ctOjLkmiAEnuI8CIsgpU584K86qXol8SK2oC4FAS5eevJ4keCXI0s30EUMFXinhKaPY5h9qxRThiBxg9rjJ+xDAl4TQACrxDlo5/SvIbNzC05LHo14FyuRDyKHYikC1AiQ7s7RmopXVhU6z3mQNwUaWnRJlc9UV6Z4Gzq6/A+J1bfsmpGrxRu5RfX9ThlRiatWZh9Nm8cccHc/GEzSLyVDg19F/sV6hm4M8CrqghjlW+puCnsDrGMLTZ4GR1WAKyHQVOvUffVxxPA2aRE67IGeIEYy5RhoqIGZfviDfLeeTs5lXTWH1+WWTEzLPlj56nTW34F2G+yUiZ1Is9wYTO7qC7t+JKPsoBSt7DcK7L7LB1XgOC4E+cnXzALkq360iTZIC98vhF/oo2ySki5rXzPF2n9PoUIbedkxFHTQiFmNsxPDT/fEOgGcpzS71g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(26005)(186003)(33716001)(9686003)(6512007)(6506007)(66556008)(66476007)(38070700005)(6916009)(82960400001)(316002)(8676002)(4326008)(64756008)(122000001)(71200400001)(76116006)(66946007)(91956017)(66446008)(8936002)(6486002)(38100700002)(5660300002)(508600001)(2906002)(86362001)(83380400001)(44832011)(1076003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Qq6c8sQo37CNuD1LNBOg8tJoomCFMr/ngtJnjwtfdOZSNpUY/onTTjuHmA7j?=
 =?us-ascii?Q?nDO4LZW0afyfm8Pw86roZ7UfhBN89o0xEtb/crq7ufgY8F9EpNpdGc8pFt3b?=
 =?us-ascii?Q?NQEzEC/dIAknUi6CMGTizQ7Yxzyh2YWN82dLEpA19HEklzzIY7OSsgo4gwmT?=
 =?us-ascii?Q?ZxIZhA7sq8JpX346S434yQ/AcFJD5aZqpQjAUKdnW7c09KKFMSYlzHNkUZSE?=
 =?us-ascii?Q?wdCpIYX6uZKwPSJlZEzcyFfe14kLmUUMn1aQVXHVz4JFiwI/RVKXyyik/aTI?=
 =?us-ascii?Q?gUelfN4mt+vYNErfd7ceReDJbHXQW1/EfjQcaSKkd0eXuwjW9rAUJ9PGKOGK?=
 =?us-ascii?Q?MuwdFSJCexj5WcuuEZUdsgXXZkCRTVUOfLADHbbzadgucWWwklFwAcbnb/Po?=
 =?us-ascii?Q?HAvMxOYwKR4v9QYy+fMXU0Yeog3NEHwKnTw6nKpySbVu3Q+NNdSZNOlZgo52?=
 =?us-ascii?Q?Z58gf/vF6yNpG+qXFQOZHtiS5D55gAdLEcnxdqCx5wb8PiPDyUXPGeyss7br?=
 =?us-ascii?Q?g10oiIa0SBJ/KBhTL8kw0rBeL6BNOHI00iYqejUG0n/8c0hpU+X/0Z0Z24uL?=
 =?us-ascii?Q?4SRdmWfUxpLV9uiCKe+yEMT4j7OCBApmErMT2tRPZhGuI4gup1yMlCK+ypmi?=
 =?us-ascii?Q?7idvpdN2RDjmeY+KDzmF3lssKi1WN5Bw/LAalcSVwSREes2KJOSElQ/yjPpL?=
 =?us-ascii?Q?/O4Kmr6DM4PDB1JnWKoTPDei20Z64WUosOsb5QyObnhGdGDmdfJn9DOs6EnI?=
 =?us-ascii?Q?qsBZc2sWVPCKhVF/1ua4lWZGXv6aNtCsMaJSw0XmO0SaREQLgbcwHe+5cEEw?=
 =?us-ascii?Q?lP1Umqbuhd0xxyq5UFQUuZ++qtxy2cmUfX4mJPZjQQ4ORrWPJJgjumXzeJe3?=
 =?us-ascii?Q?iIO9lbrFxzmEBHSaMr8HHCcEsAZ6+puCHrS6Sat9HgSiDhSTvTuBIpo9LrI4?=
 =?us-ascii?Q?g2zWDW9jli6MXenRG7aWnXRQmRga25tV8t27ijZ58nHLN5q5Zepbz9nP/ZEb?=
 =?us-ascii?Q?mj7JRg0h/grptlo7B0xj57s0OoJ8D0rMCz4xyX9Moh0FxWKvVytOevOJOJDu?=
 =?us-ascii?Q?30+tkheNlGdNLj01eR1nE7x/q4zrZ5dg7pn+JZv2tXy54eolz+q2UAg4d0Je?=
 =?us-ascii?Q?GkkDC4eG67bkPYRcbOqSygDbVR8MhcVqzY3kzHXk9YfcYcJsHFwdFVD9mXW+?=
 =?us-ascii?Q?1F6lhf4W2b8Os44oqpUg8L7fcZhrFIQt1OSlo6KYpmf3Mljsqk5XIDOKoa5Y?=
 =?us-ascii?Q?gsem+ZM0SvCc5sMADArW9YbQrRZy2CJEdbg25jSjqNe4tXBZhDCcK99XP1/c?=
 =?us-ascii?Q?1PXNnNw1NEYuWFHdULZKnmefcGD82mIqSyvSa/+iek93QNy1BeU1D5bwcZPN?=
 =?us-ascii?Q?JjsTseoXyyBZL8vhn1UFtkXfqKQ9ChX2OJoD0ko72M3VWuN5GOz4agaNKXVw?=
 =?us-ascii?Q?u2Cu0IdILAWtzy9ML+V8TtiRNqGhRkdlm9dxqWJR+b+8MCy1ejC0C8O5cc7/?=
 =?us-ascii?Q?BaTyuj5AU+dn9RRquAbU7umIO21nzXmEeoQ63FiRbp+ufRMgDdDre5Uq6obz?=
 =?us-ascii?Q?PGLVGJtHaUhFjhOccBMAPheAF8C8YzoqCFlEUDTQwGHxaXc25HRtt5p78rXf?=
 =?us-ascii?Q?xad69B0CrQhXUToGZUREnF4GcuR4r7UIQ4OZ/0bTnPqPAkFWL+4odFnb2FLq?=
 =?us-ascii?Q?LQgLIV9IkKy/xOvgFOMxlcrmA+Kj2awLJw3OjwAoMC85vhwDPSHEYLyRh3k8?=
 =?us-ascii?Q?VvT/FO2pjgm/GkD78I5X6RoXqPCRbY7d28HF/jG0LLKc9RV8vn8F?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <349FC7096610494983ADCFA356291E72@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c15306a9-26d0-4ff7-d56c-08da430010f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2022 12:21:18.9197
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zejWX86zkSuNOY3NVsiVVpe07sFN+H0J167lhWkEyKGAFANOYEjRUE0eATCI+kEBCRmEw52BdE+UeL1v2jZrP2YGlzlcnOqkex1/H7mgMx8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR04MB8238
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On May 30, 2022 / 15:08, Christoph Hellwig wrote:
> Use _have_driver instead of _have_modules in _have_scsi_debug for the
> basic scsi_debug check, and instead only require an actual module in
> _init_null_blk when specific module parameters are passed.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  common/scsi_debug | 14 ++++++++++----
>  tests/block/001   |  4 +++-
>  2 files changed, 13 insertions(+), 5 deletions(-)
>=20
> diff --git a/common/scsi_debug b/common/scsi_debug
> index 95da14e..e9161d3 100644
> --- a/common/scsi_debug
> +++ b/common/scsi_debug
> @@ -5,7 +5,7 @@
>  # scsi_debug helper functions.
> =20
>  _have_scsi_debug() {
> -	_have_modules scsi_debug
> +	_have_driver scsi_debug
>  }
> =20
>  _init_scsi_debug() {
> @@ -18,8 +18,14 @@ _init_scsi_debug() {
>  		args+=3D(zbc=3Dhost-managed zone_nr_conv=3D0)
>  	fi
> =20
> -	if ! modprobe -r scsi_debug || ! modprobe scsi_debug "${args[@]}"; then
> -		return 1
> +	if ((${#args[@]})); then
> +		if ! modprobe -qr scsi_debug; then
> +			exit 1
> +		fi
> +		if ! modprobe scsi_debug "${args[@]}"; then
> +			SKIP_REASON=3D"scsi_debug not modular"

I tried scsi_debug built-in kernel and observed that 'modprobe -qr scsi_deb=
ug'
command fails, and the script exits at the line of "exit 1". The SKIP_REASO=
N
comment above will not be printed. I think we need to check the scsi_debug =
is
not built-in. As I commented for _init_null_blk, _have_modules needs
modification to check if the module is not built-in. I guess it can be used=
 for
scsi_debug also.

--=20
Shin'ichiro Kawasaki=
