Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9686C48BCF
	for <linux-block@archiver.kernel.org>; Wed,  9 Jun 2021 04:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9678E60E0C
	for <linux-block@archiver.kernel.org>; Wed,  9 Jun 2021 04:40:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235928AbhFIEms (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Jun 2021 00:42:48 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:14672 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbhFIEms (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Jun 2021 00:42:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1623213655; x=1654749655;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=ZUaEp/ROWFwQCFLchLX5ivd5BEY60FujTAFYBDawpak=;
  b=rOEHIsQYMjlTRrjWw/f7nK70BmgOT45sXDVrP+VoA31CPTODChcNtXPA
   Wra8+IjeCWnzXiQjvOZAjzBoQBewUCi0Z2ASw/EcEUGwBLxiH41q11yRc
   cT20u2x9EvktJIiBYOdurlDusAA186nQuxvVvwms3j5NXNY57BqL0jyX3
   vFBRDYq3nZkBtJDSiVWrX50W7ED8rjNpfE+u6T2/zykqv2jFaJ0OSjHTe
   xiMdTJvyzITfKOg8jryD2trImfJ+oN2c6zdp7bneEp9WPntf6a9Sc4CoB
   sSPzdWWT7aHUSGD7Rpca7T9e0YIFTMQDIyFfLOyiiCRC966QZmQ7Z7X9H
   Q==;
IronPort-SDR: odz4I+BqriaYHnktWxPDZhfSpE5fPDcUqsHQZBKVuvxAS2+VPb3wvBhJOvJbtLAoNz/RMM7H/i
 xiusS3Ti0yI6yRBwxEOOLSu81FgaR9kIBtSdp8723tTSwIJjw9kqDWMV1wx2sPikHquxTni+Xa
 NjuwdNej8Jr3fnoUcj3eseuAg++THt0unpkZTVOMMCN+DMYdIe5TCxYwnIxKT/iGqb2l1AAOIP
 lLMDLYFA1CNJ4CxYCVg4qL7ZJbDloh62mcZaqI1t8Cz9W5wPlynahx32HdiCXMWLMCW8XVlvfZ
 wKw=
X-IronPort-AV: E=Sophos;i="5.83,260,1616428800"; 
   d="scan'208";a="171803108"
Received: from mail-bn8nam11lp2174.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.174])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jun 2021 12:40:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d/XvJHIciSBtnMiBQChM6oPHa137E/NBckygqW6d2FVNgTC9RCA2se+51PuVUE/HiuKPvZplwYTZK7HSZC1toseGmc5r+fpvE4EgRQ0jazOwOR8QICEbNhN5mqQiGiLw7nlWPQ4iIzsv8bGXPKTHJXeTv+EAkV5mQbyGSEJ462UKZPH+jD67BkNsgisMUicoGHURATS62gt7itX4qnxbphtRa9JPJ9yeEjjXvHgBR33BZrubN8v1lCBKJ4WKyEYQY+DgVBYmWdodsputf5ZNaKsK5+SvccZwMmSB2UZoYgdbg6OrkQUAlyjXCdSsb3/Pzgh4W5h1dk2Lk4gsVGgkBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wX947zC4TY7lJqcFVZFCCuGK/OU16VKt4dYTRZ1nqRU=;
 b=KKrW3/Lf/VZBrKRWoJm7L1Ezelqc/0ZMmL4LwYUCPRQG/6Dv6qjYYgvWoMYd+9mqrAzQi7Cl9oSj8UMnqXaANusWUogctI6vBniGbm4ljvOVq2PO6a75g0GYprPMlETj5+YQjUfRso0CjPrJOV50ZSCS0enK2hkMIL31NSJdE4NyZQhw1RaQo5xrpls3QjwIjUYX6qYXi9cetwaGJnmntzC1M8RBfZlmqZv7D/9CKrmHcDDsf2bmJxEeijm5VF21Y72CRjQFpIXoaUF5tk3TtpL8Bh8aw5akXJTUHmb5xvZHskGBFK0EjJByOy4UNv00h2mRJIKdUWIwvrVGZeUEhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wX947zC4TY7lJqcFVZFCCuGK/OU16VKt4dYTRZ1nqRU=;
 b=MecT8Z4WOS8F5nvpBTTkjDpmX/wmgvq2yaEVHc54OyRewBBxlJnXL8cjEhzVFQCfRB+kJ+5q1/oFafjquRPVAdmsI+ZfzhLc3bEs5ahMyxZ0Qm+4EgKwqRk5EGHOamoKM3skiOVKjtW1NmvpqCTg4Iah9Ts0K0lm5CL917keOgI=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM6PR04MB4012.namprd04.prod.outlook.com (2603:10b6:5:b4::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Wed, 9 Jun
 2021 04:40:51 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806%9]) with mapi id 15.20.4195.030; Wed, 9 Jun 2021
 04:40:51 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [PATCH 04/14] block: Introduce the ioprio rq-qos policy
Thread-Topic: [PATCH 04/14] block: Introduce the ioprio rq-qos policy
Thread-Index: AQHXXLsKSREg/Ans2U2BHuooV0bmLg==
Date:   Wed, 9 Jun 2021 04:40:51 +0000
Message-ID: <DM6PR04MB708135D0C71D2042E6674E23E7369@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20210608230703.19510-1-bvanassche@acm.org>
 <20210608230703.19510-5-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:513e:a3fe:98aa:a7ae]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d97c7271-e838-4e7b-a371-08d92b00c28a
x-ms-traffictypediagnostic: DM6PR04MB4012:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB4012383A932C385E6BAABF29E7369@DM6PR04MB4012.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9SrHF48+Mytof3dmGqtG85yqYp6bzvQxkAs9L48lwMoC70q1XoDDZzfWGfhx6uiL0m3/Nuzy+4cYn/nouad2pa55Rin+77bZpmik887//FxRdCKu/d/0ZgGis5n7suKFDa/pna9TgyDvn//k5GV2kYVXRhmG8jfM3G6HCJyhJchYT6YLW1eaYDXnnVBzrjlOqpS4viVffyZUyV9g3kekjTQuwIBO0UmJrlAZ8bkQN8VFKW6ZlBpxKVN/hXIqGvqodlf5XlgN/itvBAgUS/GtZPuAxH6DO6WmmAKOG2bDHigrl4heP6YXRe2gXKxcLTx+t1JJtvgbxRGHtGwVivDsU5Nw69Yz7UrLb/RvYxKPdAwSuYguNsNqJjdXA5NgLf/mC2h/3psqa89MC8t5xIkYLdimp1zkwnljokqsRS+a8txswRcr9yvxMUbYOeu4D4ml3Hl/q2EMMEqqXiuk6jvpmH9apcL1BXIBxDxyA5n23oaQxhopoleYptUFvnA9EdCeIZG90Q5stzUbwQH7H46JYlcS70cVYxLsAKfTQVXxNJa61LTmXFHKx+H/A2w00/5WAMG5f0XCumv8PA4M/EV6hhjFkDyUmQmfbkvglbQuy9g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(376002)(39860400002)(136003)(346002)(7696005)(8936002)(478600001)(33656002)(86362001)(5660300002)(53546011)(52536014)(76116006)(64756008)(8676002)(91956017)(66446008)(66556008)(9686003)(66946007)(66476007)(55016002)(83380400001)(4326008)(2906002)(71200400001)(54906003)(316002)(110136005)(6506007)(38100700002)(122000001)(186003)(30864003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2PjNdilwykvNDKoGUSNegCGK7SI+pxI7JWDkTekchvqvcHEsMmHwdEjXV/cp?=
 =?us-ascii?Q?5yst6uyROxtNFiVMctwlA+/TD7xjuU3XBTpNEKXKjN7cA5QaeO7I0VDPS0A9?=
 =?us-ascii?Q?5vDjSv3JX/ASdnoSJC+3cG8LWnMWz4vUENXN/XVSRTJHi2iLNR3LmjS89rVV?=
 =?us-ascii?Q?CwCz9qWCkXPPsUFdKQWjgWj1aK/bX1dYu19a3ZyUEzCVVGNvBBbfvOrkNmtp?=
 =?us-ascii?Q?TSXL5347fIhJcicjZL75ujU6Y90QInM/QpH8dzDwUxHFh+q3BoVr35wJG1oj?=
 =?us-ascii?Q?fO0KE/4g7E3vpbIZXOO8+KqyNKHvBB0y5S7H1toxuAbx9E/kHR0tp/w2TzlL?=
 =?us-ascii?Q?T6+kyg73IG9sV5PQjbNHeWD6otYi56GJxDkQz2LaaTYu3odICP+nUekt/E0s?=
 =?us-ascii?Q?lNKTYJ5iPszoKFVXd7O1G8BEtCTurflMVg94s5tI9EN62CLsXLea8d51YWh0?=
 =?us-ascii?Q?RlWJbq52BD0Kk6opcVkfrWLVndlTbTEDl/YbJj0PvHw629T6n+5O3bUuzDrl?=
 =?us-ascii?Q?6EF5rSSCUSdhBA6T6ocTTh6G8mcbK7PM/0y6m8U0YUu04epLRKHwg6h5Pevm?=
 =?us-ascii?Q?RucSSnAaC42Wl8CICbgg6dXsMf2WdGbtlVakUVBw2ckQi1YUgdMx3obQ4Rux?=
 =?us-ascii?Q?tPkuopS2j3EC0iNIx5YAL8C4+9P53rNokgo6v0hktLADmGMdRsck8Ah/vUGM?=
 =?us-ascii?Q?QAcBDnM6AgzK0Qg6fFvmrpicwiT5QFr/FYaAyDrgU6sU00TWWSO6YfN/04fr?=
 =?us-ascii?Q?p+qDY+PWdb9yRuOGvZ+dLut1xrwWs8YtAv9y1ErZXb8/ocm3EGoqmwpUdhwb?=
 =?us-ascii?Q?keEJgSO00PTyGqqzDtR03+XNSw4z5vPk2AFI7CM2X/9lTXZydG2BdMwgBrN2?=
 =?us-ascii?Q?jQAu3209e2423ypIXENGeRN1K0MFF6hrNHjcIRi/LRkPnD5VCwhDi3lRm9ac?=
 =?us-ascii?Q?afrkiHJHfjhNZIefkPMv9aG3Fo0Dh0WPGB/KNZoKME3qCaLu1qIzwKknB7eg?=
 =?us-ascii?Q?8HGK9WOgR4FOlQ/w0mzM7Y9X5IXH1FLcHT7q8NIGAkJJXttOFQWpbx7NRQdG?=
 =?us-ascii?Q?NIgQwG7faDahlnPw/2CrBKuAt6yUgpzY9YYj3cJ2nuJLdVv0FrdRpwb4DwAF?=
 =?us-ascii?Q?vWPdJGP8GEllwSG3/KEBKVvijruhwjwg38HLJRnraAm0fJY4E20cazF13QHi?=
 =?us-ascii?Q?ytO1Qtjd/9SD58NyJhcWLiXmRNsvmMU6PvkbjvtcdnDZdnMWgDMe8xTVuZUF?=
 =?us-ascii?Q?TKBMTM6Wp7+ryfQQXPkxUcrqwOhdQIX6hIfFvy0/rHbAu/m6v+wgwmEuEylG?=
 =?us-ascii?Q?Z8/PgX4WvcVKYscLR6XGsPjBwNwJ5gMd8pEEU/QMmEA9Ihjwzz7ksVlzDHmq?=
 =?us-ascii?Q?//AP0a8FaVD5badDilYFnQ73OomC9MDUvy2a59XrHo32ndIVZg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d97c7271-e838-4e7b-a371-08d92b00c28a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2021 04:40:51.2281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f704RZnpFfFcwtKfXbfGC/Upn1bE6y3wwLszKs2PZFJExjzYopRFnc8gXkKwsUtWKXk5yr77kWAWmMdHe9oS+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4012
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/06/09 8:07, Bart Van Assche wrote:=0A=
> Introduce an rq-qos policy that assigns an I/O priority to requests based=
=0A=
> on blk-cgroup configuration settings. This policy has the following=0A=
> advantages over the ioprio_set() system call:=0A=
> - This policy is cgroup based so it has all the advantages of cgroups.=0A=
> - While ioprio_set() does not affect page cache writeback I/O, this rq-qo=
s=0A=
>   controller affects page cache writeback I/O for filesystems that suppor=
t=0A=
>   assiociating a cgroup with writeback I/O. See also=0A=
>   Documentation/admin-guide/cgroup-v2.rst.=0A=
> =0A=
> Cc: Damien Le Moal <damien.lemoal@wdc.com>=0A=
> Cc: Hannes Reinecke <hare@suse.de>=0A=
> Cc: Christoph Hellwig <hch@lst.de>=0A=
> Cc: Ming Lei <ming.lei@redhat.com>=0A=
> Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
> Cc: Himanshu Madhani <himanshu.madhani@oracle.com>=0A=
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>=0A=
> ---=0A=
>  Documentation/admin-guide/cgroup-v2.rst |  26 +++=0A=
>  block/Kconfig                           |   9 +=0A=
>  block/Makefile                          |   1 +=0A=
>  block/blk-cgroup.c                      |   5 +=0A=
>  block/blk-ioprio.c                      | 236 ++++++++++++++++++++++++=
=0A=
>  block/blk-ioprio.h                      |  19 ++=0A=
>  block/blk-rq-qos.c                      |   2 +=0A=
>  block/blk-rq-qos.h                      |   1 +=0A=
>  8 files changed, 299 insertions(+)=0A=
>  create mode 100644 block/blk-ioprio.c=0A=
>  create mode 100644 block/blk-ioprio.h=0A=
> =0A=
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admi=
n-guide/cgroup-v2.rst=0A=
> index b1e81aa8598a..cf8c8073b474 100644=0A=
> --- a/Documentation/admin-guide/cgroup-v2.rst=0A=
> +++ b/Documentation/admin-guide/cgroup-v2.rst=0A=
> @@ -56,6 +56,7 @@ v1 is available under :ref:`Documentation/admin-guide/c=
group-v1/index.rst <cgrou=0A=
>         5-3-3. IO Latency=0A=
>           5-3-3-1. How IO Latency Throttling Works=0A=
>           5-3-3-2. IO Latency Interface Files=0A=
> +       5-3-4. IO Priority=0A=
>       5-4. PID=0A=
>         5-4-1. PID Interface Files=0A=
>       5-5. Cpuset=0A=
> @@ -1866,6 +1867,31 @@ IO Latency Interface Files=0A=
>  		duration of time between evaluation events.  Windows only elapse=0A=
>  		with IO activity.  Idle periods extend the most recent window.=0A=
>  =0A=
> +IO Priority=0A=
> +~~~~~~~~~~~=0A=
> +=0A=
> +A single attribute controls the behavior of the I/O priority cgroup poli=
cy,=0A=
> +namely the blkio.prio.class attribute. The following values are accepted=
 for=0A=
> +that attribute:=0A=
> +=0A=
> +  0=0A=
> +	Do not modify the I/O priority class.=0A=
> +=0A=
> +  1=0A=
> +	For requests that do not have an I/O priority class (IOPRIO_CLASS_NONE)=
,=0A=
> +	change the I/O priority class into 1 (IOPRIO_CLASS_RT). Do not modify=
=0A=
> +	the I/O priority class of other requests.=0A=
> +=0A=
> +  2=0A=
> +	For requests that do not have an I/O priority class, change the I/O=0A=
> +	priority class into IOPRIO_CLASS_BE. For requests that have the=0A=
> +	priority class RT, change it into BE (2). Do not modify=0A=
> +	the I/O priority class of requests that have priority 3 (IDLE).=0A=
> +=0A=
> +  3=0A=
> +	Change the I/O priority class of all requests into 3 (IDLE),=0A=
> +	the lowest I/O priority class.=0A=
> +=0A=
>  PID=0A=
>  ---=0A=
>  =0A=
> diff --git a/block/Kconfig b/block/Kconfig=0A=
> index 6685578b2a20..319816058298 100644=0A=
> --- a/block/Kconfig=0A=
> +++ b/block/Kconfig=0A=
> @@ -162,6 +162,15 @@ config BLK_CGROUP_IOCOST=0A=
>  	distributes IO capacity between different groups based on=0A=
>  	their share of the overall weight distribution.=0A=
>  =0A=
> +config BLK_CGROUP_IOPRIO=0A=
> +	bool "Cgroup I/O controller for assigning I/O priority"=0A=
> +	depends on BLK_CGROUP=0A=
> +	help=0A=
> +	Enable the .prio interface for assigning an I/O priority to requests.=
=0A=
> +	The I/O priority affects the order in which an I/O scheduler and block=
=0A=
> +	devices process requests. Only some I/O schedulers and some block=0A=
> +	devices support I/O priorities.=0A=
> +=0A=
>  config BLK_DEBUG_FS=0A=
>  	bool "Block layer debugging information in debugfs"=0A=
>  	default y=0A=
> diff --git a/block/Makefile b/block/Makefile=0A=
> index 8d841f5f986f..af3d044abaf1 100644=0A=
> --- a/block/Makefile=0A=
> +++ b/block/Makefile=0A=
> @@ -17,6 +17,7 @@ obj-$(CONFIG_BLK_DEV_BSGLIB)	+=3D bsg-lib.o=0A=
>  obj-$(CONFIG_BLK_CGROUP)	+=3D blk-cgroup.o=0A=
>  obj-$(CONFIG_BLK_CGROUP_RWSTAT)	+=3D blk-cgroup-rwstat.o=0A=
>  obj-$(CONFIG_BLK_DEV_THROTTLING)	+=3D blk-throttle.o=0A=
> +obj-$(CONFIG_BLK_CGROUP_IOPRIO)	+=3D blk-ioprio.o=0A=
>  obj-$(CONFIG_BLK_CGROUP_IOLATENCY)	+=3D blk-iolatency.o=0A=
>  obj-$(CONFIG_BLK_CGROUP_IOCOST)	+=3D blk-iocost.o=0A=
>  obj-$(CONFIG_MQ_IOSCHED_DEADLINE)	+=3D mq-deadline.o=0A=
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c=0A=
> index 3b0f6efaa2b6..7b06a5fa3cac 100644=0A=
> --- a/block/blk-cgroup.c=0A=
> +++ b/block/blk-cgroup.c=0A=
> @@ -31,6 +31,7 @@=0A=
>  #include <linux/tracehook.h>=0A=
>  #include <linux/psi.h>=0A=
>  #include "blk.h"=0A=
> +#include "blk-ioprio.h"=0A=
>  =0A=
>  /*=0A=
>   * blkcg_pol_mutex protects blkcg_policy[] and policy [de]activation.=0A=
> @@ -1187,6 +1188,10 @@ int blkcg_init_queue(struct request_queue *q)=0A=
>  	if (ret)=0A=
>  		goto err_destroy_all;=0A=
>  =0A=
> +	ret =3D blk_ioprio_init(q);=0A=
> +	if (ret)=0A=
> +		goto err_destroy_all;=0A=
> +=0A=
>  	ret =3D blk_throtl_init(q);=0A=
>  	if (ret)=0A=
>  		goto err_destroy_all;=0A=
> diff --git a/block/blk-ioprio.c b/block/blk-ioprio.c=0A=
> new file mode 100644=0A=
> index 000000000000..d7292cdef67d=0A=
> --- /dev/null=0A=
> +++ b/block/blk-ioprio.c=0A=
> @@ -0,0 +1,236 @@=0A=
> +// SPDX-License-Identifier: GPL-2.0=0A=
> +/*=0A=
> + * Block rq-qos policy for assigning an I/O priority to requests.=0A=
> + *=0A=
> + * Using an rq-qos policy for assigning I/O priority has two advantages =
over=0A=
> + * using the ioprio_set() system call:=0A=
> + *=0A=
> + * - This policy is cgroup based so it has all the advantages of cgroups=
.=0A=
> + * - While ioprio_set() does not affect page cache writeback I/O, this r=
q-qos=0A=
> + *   controller affects page cache writeback I/O for filesystems that su=
pport=0A=
> + *   assiociating a cgroup with writeback I/O. See also=0A=
> + *   Documentation/admin-guide/cgroup-v2.rst.=0A=
> + */=0A=
> +=0A=
> +#include <linux/blk-cgroup.h>=0A=
> +#include <linux/blk-mq.h>=0A=
> +#include <linux/blk_types.h>=0A=
> +#include <linux/kernel.h>=0A=
> +#include <linux/module.h>=0A=
> +#include "blk-ioprio.h"=0A=
> +#include "blk-rq-qos.h"=0A=
> +=0A=
> +/*=0A=
> + * The accepted I/O priority values are 0..IOPRIO_CLASS_MAX(3). 0 (defau=
lt)=0A=
> + * means do not modify the I/O priority. Values 1..3 are used to restric=
t the=0A=
> + * I/O priority for a cgroup to the specified priority. See also=0A=
> + * <linux/ioprio.h>.=0A=
> + */=0A=
> +#define IOPRIO_CLASS_MAX IOPRIO_CLASS_IDLE=0A=
> +=0A=
> +static struct blkcg_policy ioprio_policy;=0A=
> +=0A=
> +/**=0A=
> + * struct ioprio_blkg - Per (cgroup, request queue) data.=0A=
> + * @pd: blkg_policy_data structure.=0A=
> + */=0A=
> +struct ioprio_blkg {=0A=
> +	struct blkg_policy_data pd;=0A=
> +};=0A=
> +=0A=
> +/**=0A=
> + * struct ioprio_blkcg - Per cgroup data.=0A=
> + * @cpd: blkcg_policy_data structure.=0A=
> + * @prio_class: One of the IOPRIO_CLASS_* values. See also <linux/ioprio=
.h>.=0A=
> + */=0A=
> +struct ioprio_blkcg {=0A=
> +	struct blkcg_policy_data cpd;=0A=
> +	u8			 prio_class;=0A=
> +};=0A=
> +=0A=
> +static inline struct ioprio_blkg *pd_to_ioprio(struct blkg_policy_data *=
pd)=0A=
> +{=0A=
> +	return pd ? container_of(pd, struct ioprio_blkg, pd) : NULL;=0A=
> +}=0A=
> +=0A=
> +static struct ioprio_blkcg *=0A=
> +ioprio_blkcg_from_css(struct cgroup_subsys_state *css)=0A=
> +{=0A=
> +	struct blkcg *blkcg =3D css_to_blkcg(css);=0A=
> +	struct blkcg_policy_data *cpd =3D blkcg_to_cpd(blkcg, &ioprio_policy);=
=0A=
> +=0A=
> +	return container_of(cpd, struct ioprio_blkcg, cpd);=0A=
> +}=0A=
> +=0A=
> +static struct ioprio_blkcg *ioprio_blkcg_from_bio(struct bio *bio)=0A=
> +{=0A=
> +	struct blkg_policy_data *pd;=0A=
> +=0A=
> +	pd =3D blkg_to_pd(bio->bi_blkg, &ioprio_policy);=0A=
> +	if (!pd)=0A=
> +		return NULL;=0A=
> +=0A=
> +	return container_of(blkcg_to_cpd(pd->blkg->blkcg, &ioprio_policy),=0A=
> +			    struct ioprio_blkcg, cpd);=0A=
> +}=0A=
> +=0A=
> +static u64 ioprio_show_prio_class(struct cgroup_subsys_state *css,=0A=
> +				  struct cftype *cft)=0A=
> +{=0A=
> +	struct ioprio_blkcg *blkcg =3D ioprio_blkcg_from_css(css);=0A=
> +=0A=
> +	return blkcg->prio_class;=0A=
> +}=0A=
> +=0A=
> +static int ioprio_set_prio_class(struct cgroup_subsys_state *css,=0A=
> +				 struct cftype *cft, u64 val)=0A=
> +{=0A=
> +	struct ioprio_blkcg *blkcg =3D ioprio_blkcg_from_css(css);=0A=
> +=0A=
> +	if (val > IOPRIO_CLASS_MAX)=0A=
> +		return -EINVAL;=0A=
=0A=
Where is IOPRIO_CLASS_MAX defined ? I do not see it.=0A=
Why not use ioprio_valid() ?=0A=
=0A=
> +=0A=
> +	blkcg->prio_class =3D val;=0A=
> +	return 0;=0A=
> +}=0A=
> +=0A=
> +static struct blkg_policy_data *ioprio_alloc_pd(gfp_t gfp,=0A=
> +						struct request_queue *q,=0A=
> +						struct blkcg *blkcg)=0A=
> +{=0A=
> +	struct ioprio_blkg *ioprio_blkg;=0A=
> +=0A=
> +	ioprio_blkg =3D kzalloc(sizeof(*ioprio_blkg), gfp);=0A=
> +	if (!ioprio_blkg)=0A=
> +		return NULL;=0A=
> +=0A=
> +	return &ioprio_blkg->pd;=0A=
> +}=0A=
> +=0A=
> +static void ioprio_free_pd(struct blkg_policy_data *pd)=0A=
> +{=0A=
> +	struct ioprio_blkg *ioprio_blkg =3D pd_to_ioprio(pd);=0A=
> +=0A=
> +	kfree(ioprio_blkg);=0A=
> +}=0A=
> +=0A=
> +static struct blkcg_policy_data *ioprio_alloc_cpd(gfp_t gfp)=0A=
> +{=0A=
> +	struct ioprio_blkcg *blkcg;=0A=
> +=0A=
> +	blkcg =3D kzalloc(sizeof(*blkcg), gfp);=0A=
> +	if (!blkcg)=0A=
> +		return NULL;=0A=
> +	blkcg->prio_class =3D IOPRIO_CLASS_NONE;=0A=
> +	return &blkcg->cpd;=0A=
> +}=0A=
> +=0A=
> +static void ioprio_free_cpd(struct blkcg_policy_data *cpd)=0A=
> +{=0A=
> +	struct ioprio_blkcg *blkcg =3D container_of(cpd, typeof(*blkcg), cpd);=
=0A=
> +=0A=
> +	kfree(blkcg);=0A=
> +}=0A=
> +=0A=
> +#define IOPRIO_ATTRS						\=0A=
> +	{							\=0A=
> +		.name		=3D "prio.class",			\=0A=
> +		.read_u64	=3D ioprio_show_prio_class,	\=0A=
> +		.write_u64	=3D ioprio_set_prio_class,	\=0A=
> +	},							\=0A=
> +	{ } /* sentinel */=0A=
> +=0A=
> +/* cgroup v2 attributes */=0A=
> +static struct cftype ioprio_files[] =3D {=0A=
> +	IOPRIO_ATTRS=0A=
> +};=0A=
> +=0A=
> +/* cgroup v1 attributes */=0A=
> +static struct cftype ioprio_legacy_files[] =3D {=0A=
> +	IOPRIO_ATTRS=0A=
> +};=0A=
> +=0A=
> +static struct blkcg_policy ioprio_policy =3D {=0A=
> +	.dfl_cftypes	=3D ioprio_files,=0A=
> +	.legacy_cftypes =3D ioprio_legacy_files,=0A=
> +=0A=
> +	.cpd_alloc_fn	=3D ioprio_alloc_cpd,=0A=
> +	.cpd_free_fn	=3D ioprio_free_cpd,=0A=
> +=0A=
> +	.pd_alloc_fn	=3D ioprio_alloc_pd,=0A=
> +	.pd_free_fn	=3D ioprio_free_pd,=0A=
> +};=0A=
> +=0A=
> +struct blk_ioprio {=0A=
> +	struct rq_qos rqos;=0A=
> +};=0A=
> +=0A=
> +static void blkcg_ioprio_track(struct rq_qos *rqos, struct request *rq,=
=0A=
> +			       struct bio *bio)=0A=
> +{=0A=
> +	struct ioprio_blkcg *blkcg =3D ioprio_blkcg_from_bio(bio);=0A=
> +=0A=
> +	/*=0A=
> +	 * Except for IOPRIO_CLASS_NONE, higher I/O priority numbers=0A=
> +	 * correspond to a lower priority. Hence, the max_t() below selects=0A=
> +	 * the lower priority of bi_ioprio and the cgroup I/O priority class.=
=0A=
> +	 * If the cgroup priority has been set to IOPRIO_CLASS_NONE =3D=3D 0, t=
he=0A=
> +	 * bio I/O priority is not modified. If the bio I/O priority equals=0A=
> +	 * IOPRIO_CLASS_NONE, the cgroup I/O priority is assigned to the bio.=
=0A=
> +	 */=0A=
> +	bio->bi_ioprio =3D max_t(u16, bio->bi_ioprio,=0A=
> +			       IOPRIO_PRIO_VALUE(blkcg->prio_class, 0));=0A=
> +}=0A=
> +=0A=
> +static void blkcg_ioprio_exit(struct rq_qos *rqos)=0A=
> +{=0A=
> +	struct blk_ioprio *blkioprio_blkg =3D=0A=
> +		container_of(rqos, typeof(*blkioprio_blkg), rqos);=0A=
> +=0A=
> +	blkcg_deactivate_policy(rqos->q, &ioprio_policy);=0A=
> +	kfree(blkioprio_blkg);=0A=
> +}=0A=
> +=0A=
> +static struct rq_qos_ops blkcg_ioprio_ops =3D {=0A=
> +	.track =3D blkcg_ioprio_track,=0A=
> +	.exit =3D blkcg_ioprio_exit,=0A=
> +};=0A=
> +=0A=
> +int blk_ioprio_init(struct request_queue *q)=0A=
> +{=0A=
> +	struct blk_ioprio *blkioprio_blkg;=0A=
> +	struct rq_qos *rqos;=0A=
> +	int ret;=0A=
> +=0A=
> +	blkioprio_blkg =3D kzalloc(sizeof(*blkioprio_blkg), GFP_KERNEL);=0A=
> +	if (!blkioprio_blkg)=0A=
> +		return -ENOMEM;=0A=
> +=0A=
> +	ret =3D blkcg_activate_policy(q, &ioprio_policy);=0A=
> +	if (ret) {=0A=
> +		kfree(blkioprio_blkg);=0A=
> +		return ret;=0A=
> +	}=0A=
> +=0A=
> +	rqos =3D &blkioprio_blkg->rqos;=0A=
> +	rqos->id =3D RQ_QOS_IOPRIO;=0A=
> +	rqos->ops =3D &blkcg_ioprio_ops;=0A=
> +	rqos->q =3D q;=0A=
> +=0A=
> +	rq_qos_add(q, rqos);=0A=
> +=0A=
> +	return 0;=0A=
> +}=0A=
> +=0A=
> +static int __init ioprio_init(void)=0A=
> +{=0A=
> +	return blkcg_policy_register(&ioprio_policy);=0A=
> +}=0A=
> +=0A=
> +static void __exit ioprio_exit(void)=0A=
> +{=0A=
> +	blkcg_policy_unregister(&ioprio_policy);=0A=
> +}=0A=
> +=0A=
> +module_init(ioprio_init);=0A=
> +module_exit(ioprio_exit);=0A=
> diff --git a/block/blk-ioprio.h b/block/blk-ioprio.h=0A=
> new file mode 100644=0A=
> index 000000000000..a7785c2f1aea=0A=
> --- /dev/null=0A=
> +++ b/block/blk-ioprio.h=0A=
> @@ -0,0 +1,19 @@=0A=
> +/* SPDX-License-Identifier: GPL-2.0 */=0A=
> +=0A=
> +#ifndef _BLK_IOPRIO_H_=0A=
> +#define _BLK_IOPRIO_H_=0A=
> +=0A=
> +#include <linux/kconfig.h>=0A=
> +=0A=
> +struct request_queue;=0A=
> +=0A=
> +#ifdef CONFIG_BLK_CGROUP_IOPRIO=0A=
> +int blk_ioprio_init(struct request_queue *q);=0A=
> +#else=0A=
> +static inline int blk_ioprio_init(struct request_queue *q)=0A=
> +{=0A=
> +	return 0;=0A=
> +}=0A=
> +#endif=0A=
> +=0A=
> +#endif /* _BLK_IOPRIO_H_ */=0A=
> diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c=0A=
> index 61dccf584c68..3a5400b11af7 100644=0A=
> --- a/block/blk-rq-qos.c=0A=
> +++ b/block/blk-rq-qos.c=0A=
> @@ -11,6 +11,8 @@ const char *rq_qos_id_to_name(enum rq_qos_id id)=0A=
>  		return "latency";=0A=
>  	case RQ_QOS_COST:=0A=
>  		return "cost";=0A=
> +	case RQ_QOS_IOPRIO:=0A=
> +		return "ioprio";=0A=
>  	}=0A=
>  	return "unknown";=0A=
>  }=0A=
> diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h=0A=
> index 6b5f9ae69883..1d4c6e951aa6 100644=0A=
> --- a/block/blk-rq-qos.h=0A=
> +++ b/block/blk-rq-qos.h=0A=
> @@ -16,6 +16,7 @@ enum rq_qos_id {=0A=
>  	RQ_QOS_WBT,=0A=
>  	RQ_QOS_LATENCY,=0A=
>  	RQ_QOS_COST,=0A=
> +	RQ_QOS_IOPRIO,=0A=
>  };=0A=
>  =0A=
>  struct rq_wait {=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
