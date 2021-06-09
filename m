Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B70C47095
	for <linux-block@archiver.kernel.org>; Wed,  9 Jun 2021 04:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72CC860234
	for <linux-block@archiver.kernel.org>; Wed,  9 Jun 2021 04:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233265AbhFIEsp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Jun 2021 00:48:45 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:54049 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232633AbhFIEsp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Jun 2021 00:48:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1623214039; x=1654750039;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=pI0PAO3oloW7b923VI9jWZ6N7e1UId1lZJzx7g3SZfA=;
  b=c51oBloOa3W0J9uID5bVWhdKrHKCa748/vCxM3Ms/jpEgczViAV+oOY5
   IhsmzKDvOcWRZrvDIQBDnbil6XXH3zDlPLVZhxJmlYtfTlfkIqTPQrch7
   dv5eQVohs6yCNmUpvP1WjWdLge4YYU3KlVySstVizascmQawtlvwQ1a8a
   zjZpTZBxYh5/l/PBApyqMoZbXitbwqXgFrF9A7LAPF0dLNUzXlva+JAAZ
   gd6IiNclCJxguHcJPhmGIjt/vziQ7Jt42ApS0aGsOZJi4VDbMtEPxTORc
   KXXdb8RnZJq2Cji6cMEcsawJ4SiqA6YXtMoTR3NtQKy2Z2qqSVRHxtfWY
   A==;
IronPort-SDR: xge/YczL+fZPjpMkgqh5LSNCfs+AIwamDewW8t90/McL1ydVMEQjcs5OFHkzW+x/OUET7TOcU2
 /ZkOB+VWdDCya5fT8mnryrdt/WE7A7wMD7YPH8Y/teyE91miuOlD+w1DQmlIOKmKFAN6/jnjtE
 7oWOhIzbHIZGrXr9t5WwHh4nDtrJDXpifrpLHln1gReJduCmV8CQsDffJe3EpnOeFcbwGElE7e
 t3lRd0FU/L5cPmCG/6mB5dbb0nFleXZb8V0cwErCPWuu8wXwS6/GwxKpytvazQHMaTThWj9s/i
 P7M=
X-IronPort-AV: E=Sophos;i="5.83,260,1616428800"; 
   d="scan'208";a="275069406"
Received: from mail-mw2nam12lp2046.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.46])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jun 2021 12:47:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FuVSRWtxnpXW5Gn2Zmetx4W0SkR3kE6lJIt+U9BxfJKRy424x2IOiDmPumqVXL0PjVWFIrWCI7W1armAGccfkD/LyayUQ9iA4uiKJm+B4TtEpmzLHR1oubgSKozNSIim7EwYqLquZChWCpwUxbOaEr/8Rdn+hAbYtnmC+WYvQEriGeLFby/iORDFOxAdMLhCDsIBnjdew0s558nz4oGfplIgjJzPDeCjMzBOPor9oNwTUgtwf7CXHdQO3q/+RHaPIQM2rhuXnUUOnZVCsDZefOTAQp+NP8SkuvYqwaEaYA4AD1yE4CKPOQFJ7o6/fWp6E0mlsR58BtYsOZj/6WSP9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t4MXuCKGdChebFdCa4Neqy/kemno5E9PFke+WOAB/GU=;
 b=n6wv3FdASyvTpkUuFoAWEKrKEH5SfNVCLCBtFozPZiVl49s7OEKQuLyId/0qDPpkiymFq7N4TrV6K3Cn4elPMlII5rieAWMgPi749YHQ9b/yCcToP+sQwa4f7YbbOhrypMCeCtdfAa9SD9v/syZPZkY1tz3iOHz0kAzED4FnhqXDQ+TdKH/90qEvR/ZZuDnFBKX6ItsJo6PqY9Ek3t6nITMXaleLSsBQA8xjpaBNd5C28uLUWW5rCX/Nr81Gl05QBRxDwuSm/uXvJljLfq+NTQRErh6DGyyuDHd7KlenJeEyLNzMwnYNiHDCkwolpIw/YTeSqkjAdc2vTShlAB1OgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t4MXuCKGdChebFdCa4Neqy/kemno5E9PFke+WOAB/GU=;
 b=VJpsMi0NBE4gkqU+BeNNgHyOEIKz2o0pyt4gCTYsX552hu1asr/JvABShqPQkJsxhk5/5EmFMbU5BcEngKGmFdTDNrVhnixLWF7DyQi1wuBwaXPVcLW8jR5lUlEQjalu3VRVfVf9hGXBh5Os4Q1EslN7NLWutZUhz2m2REVgIIk=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM6PR04MB6394.namprd04.prod.outlook.com (2603:10b6:5:1f0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Wed, 9 Jun
 2021 04:46:49 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806%9]) with mapi id 15.20.4195.030; Wed, 9 Jun 2021
 04:46:48 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [PATCH 10/14] block/mq-deadline: Improve the sysfs show and store
 macros
Thread-Topic: [PATCH 10/14] block/mq-deadline: Improve the sysfs show and
 store macros
Thread-Index: AQHXXLsU2GDeuvY6R0ez1NAOsbFOwg==
Date:   Wed, 9 Jun 2021 04:46:48 +0000
Message-ID: <DM6PR04MB7081916EE79D419357373085E7369@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20210608230703.19510-1-bvanassche@acm.org>
 <20210608230703.19510-11-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:513e:a3fe:98aa:a7ae]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5b5e5b04-9bf3-4fcc-898d-08d92b0197b6
x-ms-traffictypediagnostic: DM6PR04MB6394:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB6394001395EE486B1BE02D32E7369@DM6PR04MB6394.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5+jakqXUEEfgVA4CBTC5KWOh8bAKdnkiVuQ3JwP+jzO5MFB63chjvGynTmwA1JdRszJcY9EI8DZ3KuOp8niVTIMZFWDU+ueosbg/gYTjcjqpnBjYPsxjfTDqf2DimktrQesYLtc+gQY0UmZsAbdqvLsF7aySIoQEq1i/49+Par8bB4nxN0rCCNNdMd1U+SM0XxdDPEmPxAlLkdnpFNTNuiESGSB9uDSFgC7m1OVoQQfg/1phyYhFIWLp7QVusvixLQ0czLYqGQJP1Iy+20lrBTv+/ZdKRFHobKdpJD/4XTFbCk+uOIqJB4QfYTQks+9T4nXjdH6Hvvi6oETHzViQ4nXz1joe8idN49DaHn6SatFZ73fdSmXgPOzc7NOPYLigjUonWCtNbKN1DgdSZAcsgSdhY4vCPMc+ZnBtwHKUqZFdfbXIfsn7j6PiiAtiLItHh7NEj3tfEf3Jx2ujE6Gndtmj0cjbURU8WHJ7M2QnnYS963xkACIMQmbhek8BG8lWe5m8SqLQhAMZlTd8GnrNsDAckoCKogZPzo08mFaakt+iyy7HJ//eP9h/QC4adgxP5m1KPJawavW1o80d3VGRVA24N/DUrsNmzvsNqJJPGJI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(346002)(396003)(376002)(136003)(55016002)(53546011)(52536014)(2906002)(316002)(9686003)(8676002)(4326008)(6506007)(86362001)(5660300002)(33656002)(7696005)(110136005)(71200400001)(478600001)(66946007)(64756008)(122000001)(76116006)(83380400001)(91956017)(66476007)(66556008)(186003)(8936002)(38100700002)(66446008)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?K5bKB/jRmTD7EHivKIBZnExePwglpXAbPKlstN7+CzsiQzybxrTzISW68tXb?=
 =?us-ascii?Q?sZf8gS9Ym/N6YgI6wkJlxZ3g3fWiCU08G701kAE5+u83I/eJ7WsXIrSZ+J7x?=
 =?us-ascii?Q?N+VMDb6L/cMHZbnT+qEOpgNRwPrxOYTCsVlv+6VpQBzDuXI1OIXqr2j3sr9i?=
 =?us-ascii?Q?6PJjRbFaq90MTlLaLtIl2yl3FcejuwkyqfEUn4II7jyD2HtRqqzQLgnsvDRE?=
 =?us-ascii?Q?/zRtpeQbHGasH+6U+3I7Ug7/k460Os7RfN83fQlpVD0cIxLuhb4p8awUHq3l?=
 =?us-ascii?Q?6NXkMAhxaiKOYSZuMNoDB99DyE1jhL3prtKTMlK5BqJIrUiq7B5MPucwFZZW?=
 =?us-ascii?Q?rvUwgopd/oQIjrJW419w+exRizkYme6pU6l/vTXrv8rlVT8JaCAaSq5Efgi8?=
 =?us-ascii?Q?Gbt3/sr1BReAHB4bu6zRTeZwmSqW5dVXaGWUG4K3zSTY5r4epGth4lhryHwC?=
 =?us-ascii?Q?+XCPIsv+3mieCJKgTw9mgW+DV3QF0ArGfvWskmAgV6rJmG8mlDQz8416BGJq?=
 =?us-ascii?Q?k4ArlGeLsKWB1FV8qLhwXBLLo2nH0ZruMo6fzHPMiHQvvbZp2/RWaI0cabmk?=
 =?us-ascii?Q?z2PsJrHcGvBfH6IBhBQLut7T1Z3b84XZGp7ijn7sEUQHuYrX+nY529Bb51L+?=
 =?us-ascii?Q?KgdzDqWXNifMPvLi+9nMPwQvdfySUvnKUlCeRBjEbbhZ4McDDGXMZJs9gh91?=
 =?us-ascii?Q?HVQAN0kNYxwk7S4rxSkmp/C9NGmEoJ2MR4lO0aDsYBsOFUeGa51Jc8O88Wpx?=
 =?us-ascii?Q?lNAefnv3h3cf4W3eU3LkNDlfkwV9pRBo48lDkxY5Vx5nBynOebWaYLmDdeGz?=
 =?us-ascii?Q?dkOMcUy+UnAtS49rPI9Q3eSlIWc4Cl/LuiKh2fXWDbpXzFbzUOXUOFJvLlFZ?=
 =?us-ascii?Q?tFh9lwzu7g4SMY9uf3uGO+a9hqLqFYfGPnJqJhohQyqA0MDL5IGJh7Jo95Hy?=
 =?us-ascii?Q?ADcgqJmXudsuuAbvBQCaOqfVEpTRmLxYUvbzmImbRuhrkMW7BYOpF3uvxiDn?=
 =?us-ascii?Q?tbUwQ31vBYDbqMt1bG7yWnT1r82S0x6U1v93b5Po8eG/a0E7Aa8FzdCNZ5Nr?=
 =?us-ascii?Q?0sIYiw9IBhNxcUfjOEkbItxt/xDgQLidrM7VraQWoNkyYwOc2/p93AMJFdS+?=
 =?us-ascii?Q?uhd2KBslSq29LqmQ3m1NdmjfJ8hJvEQR3MUzvamXSbkH5pCPtEoOmDtFha8e?=
 =?us-ascii?Q?GVzHu3rEWoDRrEn2oP2w03BuKYf/syzUeva/QqAK7mfS+T6mqib/OSa/2hjj?=
 =?us-ascii?Q?D+dYdfSrlIIOvoN2MOHPRvOwJ8r8ltIEjAHOgqc9+ceK0MIRdbARxqoZ4CuF?=
 =?us-ascii?Q?4/r/r1usTzIqWAJe6M3vJoBwlxcdkRMMkg016+WGXL5R7IAllYIZUNS4ulJS?=
 =?us-ascii?Q?Pon3FSLfxq9jo6AvKvKwRei8x4OBEKYfQa9tkNYl8bnwKbO1kA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b5e5b04-9bf3-4fcc-898d-08d92b0197b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2021 04:46:48.8048
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UvrhdkyD/0An8NLQiUgvnmM7Ce9m7GhxJOPCmhljYmuNvENWe6GJ0yLp0rB5W2DmNsjLahJlX2iuGqeDUu/a/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6394
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/06/09 8:07, Bart Van Assche wrote:=0A=
> Define separate macros for integers and jiffies to improve readability.=
=0A=
> Use sysfs_emit() and kstrtoint() instead of sprintf() and simple_strtol()=
=0A=
> since the former functions are the recommended functions.=0A=
> =0A=
> Cc: Damien Le Moal <damien.lemoal@wdc.com>=0A=
> Cc: Hannes Reinecke <hare@suse.de>=0A=
> Cc: Christoph Hellwig <hch@lst.de>=0A=
> Cc: Ming Lei <ming.lei@redhat.com>=0A=
> Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
> Cc: Himanshu Madhani <himanshu.madhani@oracle.com>=0A=
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>=0A=
> ---=0A=
>  block/mq-deadline.c | 66 ++++++++++++++++++++-------------------------=
=0A=
>  1 file changed, 29 insertions(+), 37 deletions(-)=0A=
> =0A=
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c=0A=
> index 69126beff77d..1d1bb7a41d2a 100644=0A=
> --- a/block/mq-deadline.c=0A=
> +++ b/block/mq-deadline.c=0A=
> @@ -605,58 +605,50 @@ static bool dd_has_work(struct blk_mq_hw_ctx *hctx)=
=0A=
>  /*=0A=
>   * sysfs parts below=0A=
>   */=0A=
> -static ssize_t=0A=
> -deadline_var_show(int var, char *page)=0A=
> -{=0A=
> -	return sprintf(page, "%d\n", var);=0A=
> -}=0A=
> -=0A=
> -static void=0A=
> -deadline_var_store(int *var, const char *page)=0A=
> -{=0A=
> -	char *p =3D (char *) page;=0A=
> -=0A=
> -	*var =3D simple_strtol(p, &p, 10);=0A=
> -}=0A=
> -=0A=
> -#define SHOW_FUNCTION(__FUNC, __VAR, __CONV)				\=0A=
> +#define SHOW_INT(__FUNC, __VAR)						\=0A=
>  static ssize_t __FUNC(struct elevator_queue *e, char *page)		\=0A=
>  {									\=0A=
>  	struct deadline_data *dd =3D e->elevator_data;			\=0A=
> -	int __data =3D __VAR;						\=0A=
> -	if (__CONV)							\=0A=
> -		__data =3D jiffies_to_msecs(__data);			\=0A=
> -	return deadline_var_show(__data, (page));			\=0A=
> -}=0A=
> -SHOW_FUNCTION(deadline_read_expire_show, dd->fifo_expire[DD_READ], 1);=
=0A=
> -SHOW_FUNCTION(deadline_write_expire_show, dd->fifo_expire[DD_WRITE], 1);=
=0A=
> -SHOW_FUNCTION(deadline_writes_starved_show, dd->writes_starved, 0);=0A=
> -SHOW_FUNCTION(deadline_front_merges_show, dd->front_merges, 0);=0A=
> -SHOW_FUNCTION(deadline_fifo_batch_show, dd->fifo_batch, 0);=0A=
> -#undef SHOW_FUNCTION=0A=
> +									\=0A=
> +	return sysfs_emit((page), "%d\n", __VAR);			\=0A=
> +}=0A=
> +#define SHOW_JIFFIES(__FUNC, __VAR) SHOW_INT(__FUNC, jiffies_to_msecs(__=
VAR))=0A=
=0A=
jiffies_to_msecs() returns an unsigned int but sysfs_emit() in SHOW_INT() u=
ses a=0A=
%d format. That will cause problems, no ?=0A=
=0A=
> +SHOW_JIFFIES(deadline_read_expire_show, dd->fifo_expire[DD_READ]);=0A=
> +SHOW_JIFFIES(deadline_write_expire_show, dd->fifo_expire[DD_WRITE]);=0A=
> +SHOW_INT(deadline_writes_starved_show, dd->writes_starved);=0A=
> +SHOW_INT(deadline_front_merges_show, dd->front_merges);=0A=
> +SHOW_INT(deadline_fifo_batch_show, dd->fifo_batch);=0A=
> +#undef SHOW_INT=0A=
> +#undef SHOW_JIFFIES=0A=
>  =0A=
>  #define STORE_FUNCTION(__FUNC, __PTR, MIN, MAX, __CONV)			\=0A=
>  static ssize_t __FUNC(struct elevator_queue *e, const char *page, size_t=
 count)	\=0A=
>  {									\=0A=
>  	struct deadline_data *dd =3D e->elevator_data;			\=0A=
> -	int __data;							\=0A=
> -	deadline_var_store(&__data, (page));				\=0A=
> +	int __data, __ret;						\=0A=
> +									\=0A=
> +	__ret =3D kstrtoint((page), 0, &__data);				\=0A=
> +	if (__ret < 0)							\=0A=
> +		return __ret;						\=0A=
>  	if (__data < (MIN))						\=0A=
>  		__data =3D (MIN);						\=0A=
>  	else if (__data > (MAX))					\=0A=
>  		__data =3D (MAX);						\=0A=
> -	if (__CONV)							\=0A=
> -		*(__PTR) =3D msecs_to_jiffies(__data);			\=0A=
> -	else								\=0A=
> -		*(__PTR) =3D __data;					\=0A=
> +	*(__PTR) =3D __CONV(__data);					\=0A=
>  	return count;							\=0A=
>  }=0A=
> -STORE_FUNCTION(deadline_read_expire_store, &dd->fifo_expire[DD_READ], 0,=
 INT_MAX, 1);=0A=
> -STORE_FUNCTION(deadline_write_expire_store, &dd->fifo_expire[DD_WRITE], =
0, INT_MAX, 1);=0A=
> -STORE_FUNCTION(deadline_writes_starved_store, &dd->writes_starved, INT_M=
IN, INT_MAX, 0);=0A=
> -STORE_FUNCTION(deadline_front_merges_store, &dd->front_merges, 0, 1, 0);=
=0A=
> -STORE_FUNCTION(deadline_fifo_batch_store, &dd->fifo_batch, 0, INT_MAX, 0=
);=0A=
> +#define STORE_INT(__FUNC, __PTR, MIN, MAX)				\=0A=
> +	STORE_FUNCTION(__FUNC, __PTR, MIN, MAX, )=0A=
> +#define STORE_JIFFIES(__FUNC, __PTR, MIN, MAX)				\=0A=
> +	STORE_FUNCTION(__FUNC, __PTR, MIN, MAX, msecs_to_jiffies)=0A=
> +STORE_JIFFIES(deadline_read_expire_store, &dd->fifo_expire[DD_READ], 0, =
INT_MAX);=0A=
> +STORE_JIFFIES(deadline_write_expire_store, &dd->fifo_expire[DD_WRITE], 0=
, INT_MAX);=0A=
> +STORE_INT(deadline_writes_starved_store, &dd->writes_starved, INT_MIN, I=
NT_MAX);=0A=
> +STORE_INT(deadline_front_merges_store, &dd->front_merges, 0, 1);=0A=
> +STORE_INT(deadline_fifo_batch_store, &dd->fifo_batch, 0, INT_MAX);=0A=
>  #undef STORE_FUNCTION=0A=
> +#undef STORE_INT=0A=
> +#undef STORE_JIFFIES=0A=
>  =0A=
>  #define DD_ATTR(name) \=0A=
>  	__ATTR(name, 0644, deadline_##name##_show, deadline_##name##_store)=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
