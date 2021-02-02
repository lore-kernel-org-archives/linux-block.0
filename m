Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC42C433E0
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 09:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A96964F61
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 09:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbhBBJKh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Feb 2021 04:10:37 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:36290 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232596AbhBBJGc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Feb 2021 04:06:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612256791; x=1643792791;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=jyjPMPrtgeAikEoupz3ZHTcKAMI8tLKrjineCK53euw=;
  b=P6T3DRx6D/zYToTJA8aJckDRSuQY8gdUXt7qG8wcA1Z25BICZWtTkKx8
   TmiRX5bWdLvDpvegfOkrn/h6SMeIB5QxDdFvScZFoW/wLZ31vR7rjm0RR
   l5BZTy3+QW54AIcX+fswEHn91396HlccMZfkQmvStSEb4DToBMqoXr8Zb
   jXWvQsZd/4uKC5xug9ASwcaa/IP/YVoP1YK7RtAu0Biq4hc8qa4JbEXFK
   v20ywLLdd7wut+YTTRq4iqQRBKSldl4nnexZh4zfCAYV/4F2y9Ea1JeQS
   6IkwI1kIhgrY6Pq+nB+IJmL253TzUyjXNrEdByv2OR5dCRv15PlLjVDse
   g==;
IronPort-SDR: fi2tEApTS/YjG6Yry9yXJCbewEbtdn1G5gZ87Kf+N4A+1vLct66s3CXxafyzZSNzxnH0vXpT0U
 9FzF1DDB8/ZoSfuG5BeRlm+BmplF7JOOggmVJUzlYsyJHVKD2PRrOuLlj3+nTNcsAvcLeU0KRw
 brQOCxsiLEhuM7Op5uUS3voDt/DwmT6MsLLFU1nWeN30s+ovQTmcPQQGwFfPuVmY3AWqoV2H1Q
 W4/VPTuYoLBBuOyk47Iknw0OYwDEjsSB4FAIt5FujfGbFlpmQxGFPcCQnQ8pMVjeAcgKJQ/4Tq
 3O8=
X-IronPort-AV: E=Sophos;i="5.79,394,1602518400"; 
   d="scan'208";a="163350799"
Received: from mail-dm6nam12lp2176.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.176])
  by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2021 17:04:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LvODtlRHnqqlugo4Qc9N9xUc4sFdHjOz1YgX9LTuwWCsB+DRYRQyrXM1Bb4giivxnrIHJX6WczDlz0Q1MTgnCXg0E1UVB6+HLvRhrZZe6EbSIDEmAZ++fYrV6q9qaWrpLFxKVMZxUqGmZZ0WFPRug5MC7TW420bRGFhlfFHQW2q1S7ylELkyGSRhrZNIquU8WikdannGCLT2cdLbB9LsN3fzmAZjwJz6hX+If8jWmjPdzKTlp0ex1Qtjn+xjtQE5rB9q5JH2QR/XHhG8q+Or5UQbwN8vpm0g+nLPETejcWbCq2D58XfRUFqbHGapiEfZx8WwwYH1WJgL+o5xDp7TfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nc+OOBJH7y6hJ5R+qLiPrd+xt87d1dy+LvWRmB+dO3U=;
 b=eZiSsALct3vTaJ1F3KmYw7VzrWjSpq4+ij2jKEweVY9IWXBjx09LGKmODrH+0wquBP1vZSy38VJG/K8dKHxSwXsXh7BDAQXlxV1Yw+W0TofWFkFu+v/tUPjezQH97ljhsZl9G499PRmcFQRNsnGngp1AVIwjHeBi7+3/bzRdPGJt6RD7twbJqb6lFbE7sOQMgHqA020yLFkpeC4LJm3LuJQvl84zAgeNdh4bneDI2vWGxtT8kfMI7F6FbGdCbe0i9KsaCHHTvmS8iqRXlUCUoeZpEM0/X/97ztznCFkUTpTz+Q5LcqLFLOZsJoYxle7AqCRlF4J5BBdldtamgCQnRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nc+OOBJH7y6hJ5R+qLiPrd+xt87d1dy+LvWRmB+dO3U=;
 b=h2BO7/joiwv8cDBuoKNmaEuaurF5pyml5Dj8bL3eDiPLXrlWtYLHnJRqVEqO41krkyxZ1/cdANYYX0ukVerHRW/gSbCV5lAz9faeXO/fLZJYtGI6IE3v/V6cD0rOCy2NhevVS3MEu7j8hvu32ta8HR+UqgXv1GGiNHZmjwpLRuc=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB4641.namprd04.prod.outlook.com (2603:10b6:208:26::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Tue, 2 Feb
 2021 09:04:50 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d%8]) with mapi id 15.20.3805.024; Tue, 2 Feb 2021
 09:04:50 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "paolo.valente@linaro.org" <paolo.valente@linaro.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "dongli.zhang@oracle.com" <dongli.zhang@oracle.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        "joshi.k@samsung.com" <joshi.k@samsung.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        "hare@suse.de" <hare@suse.de>, "colyli@suse.de" <colyli@suse.de>,
        "tj@kernel.org" <tj@kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "jack@suse.cz" <jack@suse.cz>, "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH 1/7] block: remove superfluous param in blk_fill_rwbs()
Thread-Topic: [PATCH 1/7] block: remove superfluous param in blk_fill_rwbs()
Thread-Index: AQHW+SPmKGXvjr8TckWajpJQn918IA==
Date:   Tue, 2 Feb 2021 09:04:50 +0000
Message-ID: <BL0PR04MB6514A277AE05A41C87A344B1E7B59@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210202052544.4108-1-chaitanya.kulkarni@wdc.com>
 <20210202052544.4108-2-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:38be:e4f3:6636:91ce]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 47ea029c-8841-4995-05e8-08d8c75998c8
x-ms-traffictypediagnostic: BL0PR04MB4641:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR04MB46416142733BD22F4147E5A7E7B59@BL0PR04MB4641.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:356;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4MZPeyj/j0toGh+FTxZETcqvPRBwSob3e1RDvHB9przh4ZVt8+smAVbXwJBNLw2paHOktD2tdOUAdGA2u+K9isqPXsKApMSs6CWSBF/l873ViCRJWBiM8Tgc6hwfdk7oEf8Tq5pL1r+YYW9hW6+A/9Kn+FEJQAU+IH4HZ6RvbnQEcnmMAi0RFKt3uFH9iJyzQyhYKh8IOWaVR16Bzg+2oAZaVy5SNk4H2NDmJIvaXHei5/T86Y5Fdd57oY5Zr3rwWVMglF76X9Qlme1Rw97t+vyNha0P5nUmgP4aApAoLK4Dl6Wjv3TSQ4icpGWWp3qt71B4wLzcahb+HjHgCOY+F5YnOgbp1mJjStJC0wBT45VLDcYFR8kxn75QgurZr86a/QZUxu4xlTC0WSuXMVE3Ee1RjRxFfrFtbqDV84aOiYn7/EOXyeJmgCNtvKExy1ImPwx4Xy16FFWosq6WbjLzHw6Cbja530Y7gbJjcwwLzZDUdaHu5ZK8Tc/X3bYP5qKVC8EP0nurOauzvyFKhLsZIg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(376002)(396003)(39860400002)(346002)(316002)(8936002)(7416002)(5660300002)(54906003)(71200400001)(7696005)(33656002)(110136005)(9686003)(83380400001)(86362001)(4326008)(53546011)(2906002)(6506007)(52536014)(66946007)(66476007)(8676002)(66446008)(66556008)(91956017)(55016002)(186003)(64756008)(478600001)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?PBGV3QJO32EQgiPENfaGkRPKZSDzskTuvXFXa2cFAHLIXj+icTv3+gt3E30k?=
 =?us-ascii?Q?hLuLvBt6a09kOs8ie6ty8/AJQtL7+EuDFHJy2DYb3BprGI72vLg1dG5PtSt+?=
 =?us-ascii?Q?UVtypceXW3SO7+SR/sg+cW1Uu4W7ypasOoFcSVHXU+t5OzoAol1QprHItWXX?=
 =?us-ascii?Q?2/Oihdpw1y2rw27ctO1JTvE30G16eEbGAscYsmL/u3lsaosPh+bZ9dzGsbhz?=
 =?us-ascii?Q?vXlNwVG+mWXtcPvYY2Lv9Ri0mv97O8Yz3PZldzClO/1pHXI3Q0wLAUzbWmoP?=
 =?us-ascii?Q?kjznGExiwZE4ZTPTZ6RNf14ffdZtP5ZhFL+asz45eHu+nyn4myfNaBt2wmax?=
 =?us-ascii?Q?+OxOZTbiavCbftLR4dL2mMYADdXMoLt6ZJSJ0dxFJgcnsBepiHDFSfjWvjQ9?=
 =?us-ascii?Q?pRpat41aXAhYWnJeBa3VJ0cWUKXOwaFwynC3n04ErrSB++1R6Rq3sfqBOJ8e?=
 =?us-ascii?Q?4wN6TEUi1um1fECN+0dVcl9OC4YwI/xrnA2ffhGuPn3YzWX4gEh5Q+0ujDmj?=
 =?us-ascii?Q?TEvZwI8UGXpAkC9b8aNIqQ587lYCDj1lDFWEEQuiP3ZPLrQcvq/4PFkFIRQ7?=
 =?us-ascii?Q?/JCNxMQpzR7oBH1qKHF7vBpCtkWBQLH4SxHRLLmJ8xmqmI/LfYzgSkfHgDMf?=
 =?us-ascii?Q?oQQrbSrqcnfNDk9AB5LwTFvhyLx5GCxNspiLS7IC+IqK+Q9fH7ZadS/3DPtx?=
 =?us-ascii?Q?v5AhmODsWxnPWOqvg3Z16RQj2FZ4pWoBAkz02rQW78GfNwdYCi58CFwD0hZw?=
 =?us-ascii?Q?gK4+KYw0JSnVd5e4TBZnI95CqfA7kFwvoe//kjCWqL3D6TKK2jLrzzmF4lDd?=
 =?us-ascii?Q?0jOCjKP0rL9P40EUjWHztfim9OyDttigMOEg7bYbrYXKvKA/6br+IJa1h+aw?=
 =?us-ascii?Q?LENE8dICF0ZA0kllxcooMzgSLi7fIP2Rh/DqZopWorj9KUn76+pC0jrv+qHG?=
 =?us-ascii?Q?v02ClGpnLhE6tNQczcbfYSuiR4P/ZKidChw3tAFiBChDHqeWB1CmpmVcclZJ?=
 =?us-ascii?Q?Hf0DBx1yMGyEcTouB5TBuNuoEyc8ZOK6VFR7DvSB5bhePIfzZrWG6pdZRZXL?=
 =?us-ascii?Q?htS886TLSONYKOU8udkbo1sRZ8up9YjcfEjahuDBKiI6TgL5wSOH8akZ/+Tu?=
 =?us-ascii?Q?dp49uOK0flHwnh7Fb/wRCUy4cWZaqdThlQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47ea029c-8841-4995-05e8-08d8c75998c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2021 09:04:50.0992
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r8Nn6dCpEoHdNGRoRKwjk9Jwow9/MHO+gsu0sspzxen2G4bEkkb07pr8g9tbQhYUjjSTYztyuqBee7YRHx9wsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4641
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/02/02 14:26, Chaitanya Kulkarni wrote:=0A=
> The last parameter for the function blk_fill_rwbs() was added in=0A=
> 5782138e47 ("tracing/events: convert block trace points to=0A=
> TRACE_EVENT()") in order to signal read request and use of that parameter=
=0A=
> was replaced with using switch case REQ_OP_READ with=0A=
> 1b9a9ab78b0 ("blktrace: use op accessors"), but the parameter was never=
=0A=
> removed.=0A=
> =0A=
> Remove the unused parameter and adjust the respective call sites.=0A=
> =0A=
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
Fixes tag ?=0A=
=0A=
> ---=0A=
>  include/linux/blktrace_api.h  |  2 +-=0A=
>  include/trace/events/bcache.h | 10 +++++-----=0A=
>  include/trace/events/block.h  | 16 ++++++++--------=0A=
>  kernel/trace/blktrace.c       |  2 +-=0A=
>  4 files changed, 15 insertions(+), 15 deletions(-)=0A=
> =0A=
> diff --git a/include/linux/blktrace_api.h b/include/linux/blktrace_api.h=
=0A=
> index 05556573b896..11484f1d19a1 100644=0A=
> --- a/include/linux/blktrace_api.h=0A=
> +++ b/include/linux/blktrace_api.h=0A=
> @@ -119,7 +119,7 @@ struct compat_blk_user_trace_setup {=0A=
>  =0A=
>  #endif=0A=
>  =0A=
> -extern void blk_fill_rwbs(char *rwbs, unsigned int op, int bytes);=0A=
> +extern void blk_fill_rwbs(char *rwbs, unsigned int op);=0A=
>  =0A=
>  static inline sector_t blk_rq_trace_sector(struct request *rq)=0A=
>  {=0A=
> diff --git a/include/trace/events/bcache.h b/include/trace/events/bcache.=
h=0A=
> index e41c611d6d3b..899fdacf57b9 100644=0A=
> --- a/include/trace/events/bcache.h=0A=
> +++ b/include/trace/events/bcache.h=0A=
> @@ -28,7 +28,7 @@ DECLARE_EVENT_CLASS(bcache_request,=0A=
>  		__entry->sector		=3D bio->bi_iter.bi_sector;=0A=
>  		__entry->orig_sector	=3D bio->bi_iter.bi_sector - 16;=0A=
>  		__entry->nr_sector	=3D bio->bi_iter.bi_size >> 9;=0A=
> -		blk_fill_rwbs(__entry->rwbs, bio->bi_opf, bio->bi_iter.bi_size);=0A=
> +		blk_fill_rwbs(__entry->rwbs, bio->bi_opf);=0A=
>  	),=0A=
>  =0A=
>  	TP_printk("%d,%d %s %llu + %u (from %d,%d @ %llu)",=0A=
> @@ -102,7 +102,7 @@ DECLARE_EVENT_CLASS(bcache_bio,=0A=
>  		__entry->dev		=3D bio_dev(bio);=0A=
>  		__entry->sector		=3D bio->bi_iter.bi_sector;=0A=
>  		__entry->nr_sector	=3D bio->bi_iter.bi_size >> 9;=0A=
> -		blk_fill_rwbs(__entry->rwbs, bio->bi_opf, bio->bi_iter.bi_size);=0A=
> +		blk_fill_rwbs(__entry->rwbs, bio->bi_opf);=0A=
>  	),=0A=
>  =0A=
>  	TP_printk("%d,%d  %s %llu + %u",=0A=
> @@ -137,7 +137,7 @@ TRACE_EVENT(bcache_read,=0A=
>  		__entry->dev		=3D bio_dev(bio);=0A=
>  		__entry->sector		=3D bio->bi_iter.bi_sector;=0A=
>  		__entry->nr_sector	=3D bio->bi_iter.bi_size >> 9;=0A=
> -		blk_fill_rwbs(__entry->rwbs, bio->bi_opf, bio->bi_iter.bi_size);=0A=
> +		blk_fill_rwbs(__entry->rwbs, bio->bi_opf);=0A=
>  		__entry->cache_hit =3D hit;=0A=
>  		__entry->bypass =3D bypass;=0A=
>  	),=0A=
> @@ -168,7 +168,7 @@ TRACE_EVENT(bcache_write,=0A=
>  		__entry->inode		=3D inode;=0A=
>  		__entry->sector		=3D bio->bi_iter.bi_sector;=0A=
>  		__entry->nr_sector	=3D bio->bi_iter.bi_size >> 9;=0A=
> -		blk_fill_rwbs(__entry->rwbs, bio->bi_opf, bio->bi_iter.bi_size);=0A=
> +		blk_fill_rwbs(__entry->rwbs, bio->bi_opf);=0A=
>  		__entry->writeback =3D writeback;=0A=
>  		__entry->bypass =3D bypass;=0A=
>  	),=0A=
> @@ -238,7 +238,7 @@ TRACE_EVENT(bcache_journal_write,=0A=
>  		__entry->sector		=3D bio->bi_iter.bi_sector;=0A=
>  		__entry->nr_sector	=3D bio->bi_iter.bi_size >> 9;=0A=
>  		__entry->nr_keys	=3D keys;=0A=
> -		blk_fill_rwbs(__entry->rwbs, bio->bi_opf, bio->bi_iter.bi_size);=0A=
> +		blk_fill_rwbs(__entry->rwbs, bio->bi_opf);=0A=
>  	),=0A=
>  =0A=
>  	TP_printk("%d,%d  %s %llu + %u keys %u",=0A=
> diff --git a/include/trace/events/block.h b/include/trace/events/block.h=
=0A=
> index 0d782663a005..879cba8bdfca 100644=0A=
> --- a/include/trace/events/block.h=0A=
> +++ b/include/trace/events/block.h=0A=
> @@ -89,7 +89,7 @@ TRACE_EVENT(block_rq_requeue,=0A=
>  		__entry->sector    =3D blk_rq_trace_sector(rq);=0A=
>  		__entry->nr_sector =3D blk_rq_trace_nr_sectors(rq);=0A=
>  =0A=
> -		blk_fill_rwbs(__entry->rwbs, rq->cmd_flags, blk_rq_bytes(rq));=0A=
> +		blk_fill_rwbs(__entry->rwbs, rq->cmd_flags);=0A=
>  		__get_str(cmd)[0] =3D '\0';=0A=
>  	),=0A=
>  =0A=
> @@ -133,7 +133,7 @@ TRACE_EVENT(block_rq_complete,=0A=
>  		__entry->nr_sector =3D nr_bytes >> 9;=0A=
>  		__entry->error     =3D error;=0A=
>  =0A=
> -		blk_fill_rwbs(__entry->rwbs, rq->cmd_flags, nr_bytes);=0A=
> +		blk_fill_rwbs(__entry->rwbs, rq->cmd_flags);=0A=
>  		__get_str(cmd)[0] =3D '\0';=0A=
>  	),=0A=
>  =0A=
> @@ -166,7 +166,7 @@ DECLARE_EVENT_CLASS(block_rq,=0A=
>  		__entry->nr_sector =3D blk_rq_trace_nr_sectors(rq);=0A=
>  		__entry->bytes     =3D blk_rq_bytes(rq);=0A=
>  =0A=
> -		blk_fill_rwbs(__entry->rwbs, rq->cmd_flags, blk_rq_bytes(rq));=0A=
> +		blk_fill_rwbs(__entry->rwbs, rq->cmd_flags);=0A=
>  		__get_str(cmd)[0] =3D '\0';=0A=
>  		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);=0A=
>  	),=0A=
> @@ -249,7 +249,7 @@ TRACE_EVENT(block_bio_complete,=0A=
>  		__entry->sector		=3D bio->bi_iter.bi_sector;=0A=
>  		__entry->nr_sector	=3D bio_sectors(bio);=0A=
>  		__entry->error		=3D blk_status_to_errno(bio->bi_status);=0A=
> -		blk_fill_rwbs(__entry->rwbs, bio->bi_opf, bio->bi_iter.bi_size);=0A=
> +		blk_fill_rwbs(__entry->rwbs, bio->bi_opf);=0A=
>  	),=0A=
>  =0A=
>  	TP_printk("%d,%d %s %llu + %u [%d]",=0A=
> @@ -276,7 +276,7 @@ DECLARE_EVENT_CLASS(block_bio,=0A=
>  		__entry->dev		=3D bio_dev(bio);=0A=
>  		__entry->sector		=3D bio->bi_iter.bi_sector;=0A=
>  		__entry->nr_sector	=3D bio_sectors(bio);=0A=
> -		blk_fill_rwbs(__entry->rwbs, bio->bi_opf, bio->bi_iter.bi_size);=0A=
> +		blk_fill_rwbs(__entry->rwbs, bio->bi_opf);=0A=
>  		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);=0A=
>  	),=0A=
>  =0A=
> @@ -433,7 +433,7 @@ TRACE_EVENT(block_split,=0A=
>  		__entry->dev		=3D bio_dev(bio);=0A=
>  		__entry->sector		=3D bio->bi_iter.bi_sector;=0A=
>  		__entry->new_sector	=3D new_sector;=0A=
> -		blk_fill_rwbs(__entry->rwbs, bio->bi_opf, bio->bi_iter.bi_size);=0A=
> +		blk_fill_rwbs(__entry->rwbs, bio->bi_opf);=0A=
>  		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);=0A=
>  	),=0A=
>  =0A=
> @@ -474,7 +474,7 @@ TRACE_EVENT(block_bio_remap,=0A=
>  		__entry->nr_sector	=3D bio_sectors(bio);=0A=
>  		__entry->old_dev	=3D dev;=0A=
>  		__entry->old_sector	=3D from;=0A=
> -		blk_fill_rwbs(__entry->rwbs, bio->bi_opf, bio->bi_iter.bi_size);=0A=
> +		blk_fill_rwbs(__entry->rwbs, bio->bi_opf);=0A=
>  	),=0A=
>  =0A=
>  	TP_printk("%d,%d %s %llu + %u <- (%d,%d) %llu",=0A=
> @@ -518,7 +518,7 @@ TRACE_EVENT(block_rq_remap,=0A=
>  		__entry->old_dev	=3D dev;=0A=
>  		__entry->old_sector	=3D from;=0A=
>  		__entry->nr_bios	=3D blk_rq_count_bios(rq);=0A=
> -		blk_fill_rwbs(__entry->rwbs, rq->cmd_flags, blk_rq_bytes(rq));=0A=
> +		blk_fill_rwbs(__entry->rwbs, rq->cmd_flags);=0A=
>  	),=0A=
>  =0A=
>  	TP_printk("%d,%d %s %llu + %u <- (%d,%d) %llu %u",=0A=
> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c=0A=
> index 9e9ee4945043..8a2591c7aa41 100644=0A=
> --- a/kernel/trace/blktrace.c=0A=
> +++ b/kernel/trace/blktrace.c=0A=
> @@ -1867,7 +1867,7 @@ void blk_trace_remove_sysfs(struct device *dev)=0A=
>  =0A=
>  #ifdef CONFIG_EVENT_TRACING=0A=
>  =0A=
> -void blk_fill_rwbs(char *rwbs, unsigned int op, int bytes)=0A=
> +void blk_fill_rwbs(char *rwbs, unsigned int op)=0A=
>  {=0A=
>  	int i =3D 0;=0A=
>  =0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
