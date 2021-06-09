Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF3E3C47095
	for <linux-block@archiver.kernel.org>; Wed,  9 Jun 2021 04:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C23E661278
	for <linux-block@archiver.kernel.org>; Wed,  9 Jun 2021 04:19:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbhFIEVm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Jun 2021 00:21:42 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:43275 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbhFIEVm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Jun 2021 00:21:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1623212388; x=1654748388;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=/bzn45YBqAsxRob2yBSB2Zr0wGscGmEDCMexw/d/TuI=;
  b=DhmNZI9fJg5TH5JLdYWlUtf69TcZOhV/0FPjEI9S9txmFTWXaHY9uCWs
   0zyGwAskkM8XCeAP9VIqWJldjYJiipmOpuEK+sC//1/p/LW47RpHb6NfX
   7zgUtOR+wWDv2oSKMVFbsWpeWe9R6GAUnkFYLDPfbuceA5U4/DmE+hK3/
   G02JYnPd/q4tyYkH6EYL5mVDX51ozpTBD9IWb7cAlmr/4C/QWSN5cuDR1
   oZnFl9JApPEhypZj3hQ9FsMxsfiGhmnAnPige4LsA9M2z67mcvmFwwhsF
   OqHI77v7jo6MvgT2nCo/do2dF6e1fXus4PPFgCYGSAmwUxAnWcobWfqLP
   A==;
IronPort-SDR: HbjOlYs4KJrw3J3c4AoR/cZh7OtDBc/WYfmkPD16AXFXDZWWY91GqirqYJvo4o+W37Gticy2jL
 +q4vF2nAqLtfMaZeeSo6GgbLlLHDqi8d6zwNUmKEscMPZs1cnenCyfwh/WfBm3TbCOqINuzNRD
 wE113nAtEHcKPBlYWZEWDB7rwXHjvE1FdciaNirCh+RliHqE2pgyFL1dd1hAOV3fzhkNCvaBit
 VlkfxKXlVcIwlH8IiJGv1nKHBBjiatG2M+ylmtJizqfHta6KshRRiFvC5ZqRaiat3CF8P4p6pz
 OX0=
X-IronPort-AV: E=Sophos;i="5.83,260,1616428800"; 
   d="scan'208";a="176011213"
Received: from mail-mw2nam10lp2100.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.100])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jun 2021 12:19:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EG+Y9+GFbH2/hOp2fOpvZC+f4P/fQ1Zb9Pn0Xlf/UlainafA4UO1nLMeMv0HTKQkcr4vo8fpIVQZVQnOsI7dNiepxId03PvtK93XYuriWGePQ94et7tv0gUhyYmEa5rZjfFlmgzxjjNAF89rn17L2OaahFLjNQIzWOrnxaSSK5TiVfn8Y11snkz3Ss+QnmqAG1kdnpkfQEebxj/Kr0X3aF9Tp5chHaiqgl304+Ax4ZjFk3d6jndso6FI598h8FLie/xVxmc97PqkEmSGZNltv+rc0Kz4FoZSwNqSmjAcpiJWiJ2GNj6iGMzdAXivs3jXtikoQ5okIuxppWYmv9ri7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0zUezXgvxLOtNFC/R6I8JcBTyT8k+IDWwO7IcFeLXw0=;
 b=HINWPtkK0jrNiEwtHhFVnR2mom9Etz8ehXgCAmwI6IioHdoZsXLvYpQbggpRjjmXZ7a98t6j0OX4/Dqanlf9rxGC+2G/mADlG+dQ+/1mEfpIr/KCpogEPe/+YbZqo1YG3r9R7u74b6euZnzP/uvMHyR0lxO2jxCT2TlLoyUrY2dRbElJxKjJm91aq5OMo8EvtgEo4D5qwQ4dVtp+BEal9ELihk90BkFdr5kVrhOodtnRUfN01W1qnrsuPVMgyQBSEmRJtytWjIXYNNuG19JKlcztYKThb5b2lZn8FOqYWP+eyHacDLLykMjrqNoAEjJYcpjOPOv4QWrKn5kgGivkTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0zUezXgvxLOtNFC/R6I8JcBTyT8k+IDWwO7IcFeLXw0=;
 b=bWREFlJX6673boZlfHSll+jM7PobFMdz8yM24SZYkyO9djvckHT/lsaefcqu11MME4kmh8qYS9Czcctg+JvOc0QHkLyGNxCrXNZNIu2FeMxJHHW3NYz3h5GBMB3e30EzVQOiR2RmrvRX1Cae16/S+KvN85/1T/RCsEu9GRIINXI=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM6PR04MB4828.namprd04.prod.outlook.com (2603:10b6:5:25::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Wed, 9 Jun
 2021 04:19:46 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806%9]) with mapi id 15.20.4195.030; Wed, 9 Jun 2021
 04:19:46 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Tejun Heo <tj@kernel.org>,
        Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [PATCH 02/14] block/blk-cgroup: Swap the blk_throtl_init() and
 blk_iolatency_init() calls
Thread-Topic: [PATCH 02/14] block/blk-cgroup: Swap the blk_throtl_init() and
 blk_iolatency_init() calls
Thread-Index: AQHXXLsITqDrQeeNmkG0iJ6Xbfm+lw==
Date:   Wed, 9 Jun 2021 04:19:46 +0000
Message-ID: <DM6PR04MB70810A46921E8A11A608C285E7369@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20210608230703.19510-1-bvanassche@acm.org>
 <20210608230703.19510-3-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:513e:a3fe:98aa:a7ae]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9f222fa2-7bd3-4589-0856-08d92afdd074
x-ms-traffictypediagnostic: DM6PR04MB4828:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB48281E43E20708ABC243D808E7369@DM6PR04MB4828.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e4CdqNghfFYJaG8I+sZaeqreIGUDE9+TbkP+XIo+MTQ+oENBaC4N2p3w/IwtboVT4MhEoxNIRiWd5Hu2gZiRMpq5S+l9ZaxFgZ998MwmRY1zWC6bCDsJI5zg7A5pkbmVgtBEIQ0UCXCHF1vb5jD2ouE6j0J+ULlCWZOoub3wHE2d1T6d89ZsbbX9SfJDt9RQCAAD0+eNfZ3M5FxD/YV+2PrZrKEP2y39y2ngAbfox3G11rfQrs0j2bGjnMM4NgFCRSJFaqFXj1bUpjM5Ka9Xwa3k+YDTWLCM4XZpBYarDTa7wMetokh+JJQeZyqC6Pwc0c+IBQ1VLtfE2wSmDzntqCqBnPU/G3uCRoWXvmwrzKp5Ppv2oe+WnNOXLMSBUqT+dpnq9UmyQOuU8XF6KY3ma6VAjTLxgxyvVdiuYhQlVOz9USrsM+x53ATv2gCiEdrHeaLNz9Xk0xeWwWA/Yjdpyq/DHadW7Bu2BQqgZzOULt6bIeW/3yjJtahIVAlPuzuJ2hD0hSKaiL9ulEdJ6hrWxDRNwbM245VWYxdRlczYMatDEwQdf61Nv+PW6lKnUNt2+u4wtFXF8IlgdNVBfA/fhv/ispT7nWDPdkj3mGNj2zk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(366004)(346002)(376002)(396003)(54906003)(110136005)(66446008)(38100700002)(91956017)(76116006)(122000001)(55016002)(478600001)(64756008)(316002)(66556008)(66946007)(66476007)(6506007)(7696005)(8936002)(8676002)(9686003)(5660300002)(2906002)(83380400001)(33656002)(71200400001)(186003)(4326008)(86362001)(52536014)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kY3tlSde7Bepj3HP3Zh3P2M3+GojBRJ8lE5TUpriKCmRcr+rgnrjIfv+AHl8?=
 =?us-ascii?Q?0tutOJapJGsrT8ZcIjKQPqEuI6Gov5cGmctLOufJYaBG7SpQSfzuxa+8MfVK?=
 =?us-ascii?Q?4S/fhzWXYDug1GUYi6kuZa92fvCz3W/jvHXO0X2HA0P2+m5tB41IAfSDuQp/?=
 =?us-ascii?Q?vLxFHtSKNMHIXzGVonhFaBMkTJL5HFmekQv7RN67kc+JrAWwG7w+ngzejrbc?=
 =?us-ascii?Q?0vRKGqaqfHAG/FCb5wccIF5pb3PHq6sY9RJOSD/FapQoj0iCnBWUVEoebQVK?=
 =?us-ascii?Q?uSgS3zbHtaSWBocKiWTwqrgvzvsYflUzmXGHv2lKny52zdKfxmtWxABTt6T0?=
 =?us-ascii?Q?8ycm/U03xnF7kvArPmxlviRyEAuNsW3mtDGsUchsZKYPMomoWhjGxrRUtUpq?=
 =?us-ascii?Q?W8AlmmR3XgDsC+y+MddPEKo9Rk4xhl8zE0lHCPifN1MTBBbvi1QRqyArbxxy?=
 =?us-ascii?Q?1ambONB7EIgUjoC5QhXiQ9pMIxCRWdmSoMkeA9SKVftqZmLreo3ynhLpGek/?=
 =?us-ascii?Q?RCa/pXvLBaXILvzBVMkXbAO8oVJ+744J788tcG0xqyYNBxmwg1q7bKJwO3qX?=
 =?us-ascii?Q?FZL8eO7l2vP4TBQbgXOzGoxMj1eBt7vNuJOQA9FyOn86FewVgouHPyUnlN38?=
 =?us-ascii?Q?8f1A3PiU1JVQ7nM/qDnq/+n9CdfU2usHZaWQHyep7nced4JR62Mgcs013WTs?=
 =?us-ascii?Q?d6Ti9ryKJwrg/5xeHZloyZbWm4oo+7rBzmURGLXue+LUgvntb/twDGexvkTw?=
 =?us-ascii?Q?uIhFH5KKdCCPDctYESP9C+yf5jBntmLeI4CiEdUgFEiy7W2ctG29T9spSWsO?=
 =?us-ascii?Q?Kd9KXn/YIYuVul2yXGSqL/uTWl0PkF3AInhb77MHGqpIj5VCuAiWoj8YICHW?=
 =?us-ascii?Q?vjsZwf55Z0FIOnXnWC91HU6Ubm3HwA/Fb0MqkBLFuYe94T+URtU+YjP1EsFi?=
 =?us-ascii?Q?crvTgzpewYnJUxBAVSHvFLUhqmLBwO72DlxpZABmhdgDV8Rm6dj5vHxx9n49?=
 =?us-ascii?Q?+fKoPRSnanZp8dv8YVzeMKuEh7Srvw+FAe+t7zFLD06PPDFqCAGUqUmFp+O3?=
 =?us-ascii?Q?1Az2nVsViZ9fSI6/Ne3H3HL87XMeR02pmpl34zVrzCmgQzqfrCuZu6lXLVWx?=
 =?us-ascii?Q?vmggzhSV6YSc3xxkso/ypRQacNiLvjgkt7rEKyvRJMKtRL9uUlYRph93tuOp?=
 =?us-ascii?Q?YiSftj98/UtTXh04n8tO7pznx3aDEiKmtCelSuSJTjCH+rYk5TSDHyH6I3LA?=
 =?us-ascii?Q?9KTJuMp8K+hEvN96/btrjPHLDKJC0Si2Q96zurF1idFfx4P3S+Vv0PqkIzjm?=
 =?us-ascii?Q?WEViJYGaKN3yACNl2IpJ/UYmOGEB9e6Vp8QbDfx0NUNI13zStcqOxaxr2TPU?=
 =?us-ascii?Q?QPS4T3aZL074F126Ry2SdEhEBtyzl7FXW6izk2U4K1sPgT4NjA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f222fa2-7bd3-4589-0856-08d92afdd074
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2021 04:19:46.0928
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zJ+xdNbn3X0FEuer5PlLB0qpIp3tLXFVsCIqi4LHmkJNrJmxefcgoO6vlY6q9D06t+Ch1JgWuu9QzAPxEk1Dfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4828
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/06/09 8:07, Bart Van Assche wrote:=0A=
> Before adding more calls in this function, simplify the error path.=0A=
> =0A=
> Cc: Tejun Heo <tj@kernel.org>=0A=
> Cc: Damien Le Moal <damien.lemoal@wdc.com>=0A=
> Cc: Hannes Reinecke <hare@suse.de>=0A=
> Cc: Christoph Hellwig <hch@lst.de>=0A=
> Cc: Ming Lei <ming.lei@redhat.com>=0A=
> Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
> Cc: Himanshu Madhani <himanshu.madhani@oracle.com>=0A=
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>=0A=
> ---=0A=
>  block/blk-cgroup.c | 9 ++++-----=0A=
>  1 file changed, 4 insertions(+), 5 deletions(-)=0A=
> =0A=
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c=0A=
> index d169e2055158..3b0f6efaa2b6 100644=0A=
> --- a/block/blk-cgroup.c=0A=
> +++ b/block/blk-cgroup.c=0A=
> @@ -1183,15 +1183,14 @@ int blkcg_init_queue(struct request_queue *q)=0A=
>  	if (preloaded)=0A=
>  		radix_tree_preload_end();=0A=
>  =0A=
> -	ret =3D blk_throtl_init(q);=0A=
> +	ret =3D blk_iolatency_init(q);=0A=
>  	if (ret)=0A=
>  		goto err_destroy_all;=0A=
>  =0A=
> -	ret =3D blk_iolatency_init(q);=0A=
> -	if (ret) {=0A=
> -		blk_throtl_exit(q);=0A=
> +	ret =3D blk_throtl_init(q);=0A=
> +	if (ret)=0A=
>  		goto err_destroy_all;=0A=
> -	}=0A=
> +=0A=
>  	return 0;=0A=
>  =0A=
>  err_destroy_all:=0A=
> =0A=
=0A=
Looks good.=0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
