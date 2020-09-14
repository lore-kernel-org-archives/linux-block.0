Return-Path: <SRS0=j3P0=CX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C6D2C433E2
	for <linux-block@archiver.kernel.org>; Mon, 14 Sep 2020 00:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F4F6207EA
	for <linux-block@archiver.kernel.org>; Mon, 14 Sep 2020 00:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qaPgLfE/";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Pq/sErJO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725978AbgINAzt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 13 Sep 2020 20:55:49 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:31912 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbgINAzr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 13 Sep 2020 20:55:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1600044948; x=1631580948;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Onbv3gnDvEFCi7BMCCwmzup02tbCDADAe45ozXAP59A=;
  b=qaPgLfE/4htdxCuyFq2ER8TFVMlQDRzuRN1+Vc+KXVu5mgjL2dFoEILS
   Mca0V3X6hrcIL4AZ3e+S8hFwaFewzOvBRE/uDDe0yv2dTba5TEExuAohO
   SfF8eZ1EH637xExX1Oi5DObW1KPGOUpWAr6HeE59jNLuMIf+xQpChKPJL
   iOk816XUz9GP9eEPksBPcpeHF6wA1qGY04FIw+mFZH612i+pNMpMp0L3w
   bf2CSHqzaza9OLaq225exHekHaYFKEBFCfy9ag70nlpquoztj6T/Na2Gd
   AL6FNQ9rADU6fTVL41z+nBc975UmST9+2S/ZS1gVGCHG7zbYDZIIrkJ2o
   w==;
IronPort-SDR: gHgUHrOih9ysw4rUHJBftDPQM99A447ZwLbgbkEvtjLqkMO4E4RfoBnShPwZNiM2kVmQAszJF4
 8Qw/Mq2mpJ7LtVXVJ6yd/rpi6c5rFg2JVs5rn36rjiEp5UwsOcnhmWT8e65TA4WCfhsppcAgtb
 nND3JZChbYaVRFs4XHapqaDD32/HGJHka4sUmj1cBtm/dTl5ndZPiWProPHOoHCTfGguS7Hu7/
 wb3fSCRdYWeki2SAFd5404f/WEFqvV9a/UuRH41AZ0XdF4DabX4L2X8xejUyzdSBjIdzar9EY3
 O+U=
X-IronPort-AV: E=Sophos;i="5.76,424,1592841600"; 
   d="scan'208";a="151625261"
Received: from mail-sn1nam02lp2057.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.57])
  by ob1.hgst.iphmx.com with ESMTP; 14 Sep 2020 08:55:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cMBxtkYQUVaNAU56O7QwCL6sxMgr6ytGC7hOCeiWVL2gXU9/NYC9ZRtu8Fp0bpADXa6BnSgV/SKNbhw1EGwsiCHCza+XlAt+ZKB0j0CVwjj/4Bf082Xq76/kpAOdOzkxOoveO+7GWY8VtgfhaNzXwZPrhef/TytehUq1uB1ujbLuZ+PwLZCJ/PG4gJwI981BUUX4JDtK5ktRPUhqT41xkwF4eA7rzeqUi9EuNrrltmrHFiFhaX2floCtJKbbDa8fI8HcnNurB52MGcOkXwxiCt4upvD2kdPif3kJYB5asib+RUxDOa30sMyum9qyv9uHgINGxd8nuOtXUB76Rw3Phw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W2AQCly1gZ2XPBhqPoDxaeFScB4h0Mm9Ad9zzDyLgec=;
 b=TIAG6MzyB3lRnM8dh/gN7bgR4C4AFNye0JGz2rKqG2Yph0QlSvtoJJKiE4d23XE9hguUg+p4js6xuoVaJ1dMxZ8Dh+rcR0UeIgK5idLGRY7hCE8kBkwNt0rNwi8f7RNNmPR5Xz5HcEeRHTXqfPvDTgqgv9sQn+bv0Or24XOC4xQrgRReSh4du1HzKyfya/gzkCz3WNOB/LPEgnk+M1PtO93vN7DIXcUvfCiNaUi12SshCE8pKdNHWxEBCRU0M6meWbW5MCikp/kVj8iTVjvSImpGTD+Byye4NJ8UWHWsGmIsrTTPK7atUawLeSpmdwjySiEzt6zjNTVkBgXxYso/GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W2AQCly1gZ2XPBhqPoDxaeFScB4h0Mm9Ad9zzDyLgec=;
 b=Pq/sErJOlgTNFZFBfuKHXPClPIcnhWq0JgXFbq13kg0JSfZRhrzPiyZQ5RGFM+qToKbnr5tK+8szRLmFje9yfVAC8Zt/5airn5pDYdk8aHlpk4TW23buHn0HdS6VPewW1PtqQpsBuxAmD8KJkM1JdUwTjX9PV8lSXIpBIAidD4Q=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR0401MB3586.namprd04.prod.outlook.com (2603:10b6:910:8e::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.18; Mon, 14 Sep
 2020 00:55:43 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7%12]) with mapi id 15.20.3370.019; Mon, 14 Sep 2020
 00:55:43 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Mike Snitzer <snitzer@redhat.com>, Ming Lei <ming.lei@redhat.com>
CC:     Vijayendra Suman <vijayendra.suman@oracle.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 3/3] block: allow 'chunk_sectors' to be non-power-of-2
Thread-Topic: [PATCH 3/3] block: allow 'chunk_sectors' to be non-power-of-2
Thread-Index: AQHWiIYOYez7hWogSk6+KVMC1NA11A==
Date:   Mon, 14 Sep 2020 00:55:43 +0000
Message-ID: <CY4PR04MB37516E15A40D808D4810D26BE7230@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200911215338.44805-1-snitzer@redhat.com>
 <20200911215338.44805-4-snitzer@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:f58c:fb44:b59e:e65e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1adcd303-0a66-45ad-d147-08d85848e8ad
x-ms-traffictypediagnostic: CY4PR0401MB3586:
x-microsoft-antispam-prvs: <CY4PR0401MB35867E66ADD97A3B72A1F780E7230@CY4PR0401MB3586.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aEdaVv9YYUL753J9E/znrpTjRZHSyZW8o8kZVQEy4leqa/glfgZA+ypXL5BovEsPu9nNWaelpfMQBK76ozRafosNKUIDMJakGTXY9c26ORUapQ0aiU6cfnBZa3KW2+/y5TJW+Ynqn2PXLtVc/b5cP7lUfCI0S1QHvra+9+oEBvY9KaTjL5OBnKBhflrNGQw4KSKWGF61ZArilvdnbjWopPpQLQbT+zj9WpIodN06Uwl2NzQPKSV5YUSxfT0R+ffoqt69QNnQyMBbx0Mkc7E5I++lPTky+OK+qC4iNfHqioUxUxOQ+pxHHwT6CAIe8sUA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(76116006)(91956017)(66476007)(66556008)(66446008)(33656002)(2906002)(5660300002)(52536014)(186003)(66946007)(316002)(71200400001)(64756008)(53546011)(6506007)(478600001)(7696005)(8676002)(83380400001)(54906003)(110136005)(9686003)(86362001)(55016002)(8936002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: FbJaqGf9Sxgsa99rJ6rkImC184ueOCMBY8L3z21VDjhhXABQvJu+ahSPOiubL00LCTwi6TCHMWsr+Gw/1lkjQHcZ6fi3gyHqPVjNhjzDG/psyi1e8fQ83fkqyqu6I3XLHjzHyBVcp1zBS0I+eYaVe8PIPpkcbXEZC9L9JM1GkvWKOneTiz/wwRXeOwmpebI4kTsyatIqPv6aAp/C1V2/xOxxZwX+V52nKC7H/riE+Z8KgigEyXdJ6h77JnwBTr/01b1IOGhOEnRC/LYpaRoROIGk+aJzznF2J3Ix2haVr9YtRyGMA8TzEq4a9fRgNgtnOTuoDpM6OmUGcFgddAVrl8sFZ46gedkrdbwhHuXCtnH7ewkj1IhK4wz3+xFIQzlZ+O9zJIjTIP7fjdZY6kua0dvTkJ2ORnduHsDlHoR9MmuXS1CpuuIcnWHIYbUmvrQN+IVJWXd2QCqDDwIrtzQDw9QZjYF01GVTwZAtMaFkHaQXHLQyIrT50XYrCG5tsK/3CaNUh3z0XOz3czSwHlUO/DbeWaLT59f2vGxOjUKFrEyDAb2gxqsCVFYuYKHmwuXWXu1TjHCZAsJFNt4DDEY+NSmY1JdMwnY4yUpPt8aXFFf+Iz65MfDJsFOhBaZIUANxbDyzhfWYIJdzverybSEXMkkjOo/SofabA0ge2nUHCH8+IyRsE1cgyLynmKSAOFCt5ll3tlsampTyjNYy/TEb6w==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1adcd303-0a66-45ad-d147-08d85848e8ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2020 00:55:43.6570
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zdc1M9/W+R+Nd0EFM2j5Cu5LHsnA+hIyjfc9ZkFT7O3MeYVq91DbGq1BU3HA4APbjAeoXmAO0ahElaIUBswGFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0401MB3586
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/09/12 6:53, Mike Snitzer wrote:=0A=
> It is possible for a block device to use a non power-of-2 for chunk=0A=
> size which results in a full-stripe size that is also a non=0A=
> power-of-2.=0A=
> =0A=
> Update blk_queue_chunk_sectors() and blk_max_size_offset() to=0A=
> accommodate drivers that need a non power-of-2 chunk_sectors.=0A=
> =0A=
> Signed-off-by: Mike Snitzer <snitzer@redhat.com>=0A=
> ---=0A=
>  block/blk-settings.c   | 10 ++++------=0A=
>  include/linux/blkdev.h | 12 +++++++++---=0A=
>  2 files changed, 13 insertions(+), 9 deletions(-)=0A=
> =0A=
> diff --git a/block/blk-settings.c b/block/blk-settings.c=0A=
> index b09642d5f15e..e40a162cc946 100644=0A=
> --- a/block/blk-settings.c=0A=
> +++ b/block/blk-settings.c=0A=
> @@ -172,15 +172,13 @@ EXPORT_SYMBOL(blk_queue_max_hw_sectors);=0A=
>   *=0A=
>   * Description:=0A=
>   *    If a driver doesn't want IOs to cross a given chunk size, it can s=
et=0A=
> - *    this limit and prevent merging across chunks. Note that the chunk =
size=0A=
> - *    must currently be a power-of-2 in sectors. Also note that the bloc=
k=0A=
> - *    layer must accept a page worth of data at any offset. So if the=0A=
> - *    crossing of chunks is a hard limitation in the driver, it must sti=
ll be=0A=
> - *    prepared to split single page bios.=0A=
> + *    this limit and prevent merging across chunks. Note that the block =
layer=0A=
> + *    must accept a page worth of data at any offset. So if the crossing=
 of=0A=
> + *    chunks is a hard limitation in the driver, it must still be prepar=
ed=0A=
> + *    to split single page bios.=0A=
>   **/=0A=
>  void blk_queue_chunk_sectors(struct request_queue *q, unsigned int chunk=
_sectors)=0A=
>  {=0A=
> -	BUG_ON(!is_power_of_2(chunk_sectors));=0A=
>  	q->limits.chunk_sectors =3D chunk_sectors;=0A=
>  }=0A=
>  EXPORT_SYMBOL(blk_queue_chunk_sectors);=0A=
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h=0A=
> index 453a3d735d66..e72bcce22143 100644=0A=
> --- a/include/linux/blkdev.h=0A=
> +++ b/include/linux/blkdev.h=0A=
> @@ -1059,11 +1059,17 @@ static inline unsigned int blk_queue_get_max_sect=
ors(struct request_queue *q,=0A=
>  static inline unsigned int blk_max_size_offset(struct request_queue *q,=
=0A=
>  					       sector_t offset)=0A=
>  {=0A=
> -	if (!q->limits.chunk_sectors)=0A=
> +	unsigned int chunk_sectors =3D q->limits.chunk_sectors;=0A=
> +=0A=
> +	if (!chunk_sectors)=0A=
>  		return q->limits.max_sectors;=0A=
>  =0A=
> -	return min(q->limits.max_sectors, (unsigned int)(q->limits.chunk_sector=
s -=0A=
> -			(offset & (q->limits.chunk_sectors - 1))));=0A=
> +	if (is_power_of_2(chunk_sectors))=0A=
> +		chunk_sectors -=3D (offset & (chunk_sectors - 1));=0A=
=0A=
I do not think you need the outer parenthesis here.=0A=
=0A=
> +	else=0A=
> +		chunk_sectors -=3D sector_div(offset, chunk_sectors);=0A=
> +=0A=
> +	return min(q->limits.max_sectors, chunk_sectors);=0A=
>  }=0A=
>  =0A=
>  static inline unsigned int blk_rq_get_max_sectors(struct request *rq,=0A=
> =0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
