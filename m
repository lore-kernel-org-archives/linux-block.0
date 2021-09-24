Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAAB3C433EF
	for <linux-block@archiver.kernel.org>; Fri, 24 Sep 2021 10:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD2FD61107
	for <linux-block@archiver.kernel.org>; Fri, 24 Sep 2021 10:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244742AbhIXKzl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Sep 2021 06:55:41 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:23849 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244404AbhIXKzk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Sep 2021 06:55:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1632480848; x=1664016848;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=kEzXnjzE6yPfPTAKX/fzLn+QPLyFMFvIa8Li32+ONE4=;
  b=hAEwHZ3WXXoGXGtGZ1niFkw1kZWClqn8S1MkIZy2IsXoa3D8HnXJa9hq
   71YyUCpathS2gxKGY6PEhN2IlvdNKSiZSzzbvYcTLMPY+lU3e2dVYcLXP
   BAeAZqKWjN+m91ebReKOTA/Kqubfn8ANEnQgE0vIBoxLxYMiIqDMuncu5
   tmgvPI/nGq6E3IG0pOd9wUnQnkImNf5rQFq7Bmd45igqFPresH85F6twj
   5XNQ6c901Rk8LlINSNfwGNqretiP1VqiV280vTg54ur3rIzhlPzKvyl4k
   S5vAafoPbdEQIOAUE/9tKHAGod+bc8EQXq8nCAHAUmE/S2gtrQM9wKAJX
   w==;
X-IronPort-AV: E=Sophos;i="5.85,319,1624291200"; 
   d="scan'208";a="292495402"
Received: from mail-dm6nam12lp2177.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.177])
  by ob1.hgst.iphmx.com with ESMTP; 24 Sep 2021 18:54:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iRjVuoWarkfbYtUdr31gU2zbBKF+CzAcpj7/wXoUPC5+Li0H+2NHg3SS06j9LUTsIg6g3RlW4tTjoF4WChZIBmlAmBi4nROfY5iBEvJQenUNQHTitHc4F6a6XakN0HEUcHTgokA/vCA5Oy2sgbYvYxNwaStjJZ/0BbpRy9D3UXEk+PXcfFvBU0RvAS48j+fNSiK4LV+O+9VCRn5asOZeEYPeaiPwoWtaSD6v0Qzhi/a2juhl7kmWqBhtPAsY7fjUkQTqAEiCUMUziwdixv/twzkWlw5iTkXE+LExVYp946ljVj+6MnKxrwY+Rtrn+YeSdktKep0JOwMUPkpZqCjMCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=bumFk5Gd/hePwxs6oUfdSgdFpBonmmn/WI8KZB1MpFA=;
 b=maJAOf5U0DMHvPw3CCbC8J724Baz53nzpsKvcYylSgPEw3wiZzHVfTuuku0Cpas3B1xMk0MQ//G7Z5kJONSb1A5du0DBabSYkHX97mUx3iTIt6gMTPMZO7KY8gUHdv2ASrxYMcGfURMcpvflvbLDlgm0QmZ7C+AJJRpjClvXQRIO1nLpCjqgPSnKuIE8xZb5Ml9jR9gat+x9vmTOk/1qQtCuGyzCrX93m+iWauF4LIAyggRVtkg5o9IzCJ09OAOhU1rHNMwCMMRyo1l0Z2EJHXsmqcDmJh0uXuxO9aE2uP+1jUQ+GXRs9OOQhGKXPWZNBh523QlrJDJYM/YpUaJ8bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bumFk5Gd/hePwxs6oUfdSgdFpBonmmn/WI8KZB1MpFA=;
 b=uwh0tgcGUEUZAmbdzWjQVfMqNCQno0RLlx2p8dEz8GD6zQScn1nq0zSUzrtdqcyF+G+TfDyjljMGNsqBbiD4/kJTsG1Uw2p+lbw1IZux1HICn1v7mHIhapwaRttz6itaI8U55G3kEvOziJiA1xMbI6hIg/APjRzOQuJKsVuZYJ0=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM6PR04MB4537.namprd04.prod.outlook.com (2603:10b6:5:2b::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.18; Fri, 24 Sep
 2021 10:54:05 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::7c0e:3e95:80d3:7a70]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::7c0e:3e95:80d3:7a70%7]) with mapi id 15.20.4544.018; Fri, 24 Sep 2021
 10:54:05 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 1/4] block/mq-deadline: Improve request accounting further
Thread-Topic: [PATCH 1/4] block/mq-deadline: Improve request accounting
 further
Thread-Index: AQHXsNKIHs6cdNtAbkC5hiqUVYpr6A==
Date:   Fri, 24 Sep 2021 10:54:05 +0000
Message-ID: <DM6PR04MB7081B24987534A1390733FBCE7A49@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20210923232358.3907118-1-bvanassche@acm.org>
 <20210923232655.3907383-1-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d0f2b74b-6ba5-41a7-f74e-08d97f49a07e
x-ms-traffictypediagnostic: DM6PR04MB4537:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB45374FD0AB4BC7AA0CFDE008E7A49@DM6PR04MB4537.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aSY8o2GHsdAfqYqyNOz7+BX364Q7PU573Vluqz54ezTfCdHqvQK/kbMCeyZ1CGDeJ3uLvtniWqX1FuRLxUyLIovvpTADhbLCJfOD5mD5ViFa4SB7YI++dVYjnwXT2CkbJ9HGqdfzJUFAefK/1SWJliQH7G/VY5c9aK93fFSKd2kNhKJkI8gzmbydF9Jcgpt4nXrrH9/ikyiEelJfYwNSWrM1RASKI74crgSFvGKbOOcIn9LZ70bGV8++nsO+yrtiVtOmWl137pZi+WQBC7jpOGOTrI4E2iHBFpGjW50IDbp6qfCIEESx5pwBsg/NUR1uNm89wbYWRmNubwXYuZX/8s9/znTWKLsmXbmfocMV/KBHhvmLYp4kmsYY6Q8YH+FdoqYh9qaabsZ2Vjyq0NQRLx89JVuAUN6uE3FjbFeOKEiDwyDndc8SjBo+FHrat4CcPq+03lrNQXUlagqibNqwu7F90MTFT0tui+izVjiDvJBieyfRAxk/FLdpnm3Y+yoF2KyqsYP8QKVo19+G7ud7piPOBEzZxZa0eZEPcR839mE2JfWxQsPrbMoHdmybA/yMlYE6tZ0HIknBTO30Zy/NETsuh/ke6SCg62gU5qTJPz9P7WmzC0HnZdp9rQJXP8rZK0mRiL9IiJyPKTmkbiY/Qk5x4vs8e9cQm2SQ6nNSDc1ofC0slM1OZV2lUD1kPRJv6D1lKfTXBFv+SDjEeq8V9w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(7696005)(53546011)(316002)(5660300002)(54906003)(55016002)(186003)(110136005)(9686003)(33656002)(86362001)(38070700005)(6506007)(4326008)(76116006)(91956017)(122000001)(508600001)(15650500001)(66556008)(71200400001)(52536014)(8676002)(38100700002)(8936002)(64756008)(66946007)(83380400001)(66476007)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?omxmAWAw52jmVpRGRPY6Hd+xBUW+jYhUWsHJSS0kN0hqfyhgXu51JvaPJ7yi?=
 =?us-ascii?Q?V6AkOqRT6jnRnczuwPek6u2dWWOgHbLy+ectqn/rJNlMgRMmnHchrNtMJWvb?=
 =?us-ascii?Q?8LHQVVTZvv0U3PkfwYOcP5ZeMpFzdEOlGHjybYldS4btI6ojivPrp6ZvxzJC?=
 =?us-ascii?Q?kwBsua2apiUKlbOkswQFHNGQN552t9LeF1uIHu5hge5wSHClGmoMdNJfvcDj?=
 =?us-ascii?Q?roz8xptSWwJ5ogYXzTbeZzAiYwHe7djvSBBchAMkdYcFT0gEYf/Mri1cqB4n?=
 =?us-ascii?Q?UOgLqlJFTrAh6ZwOYRMLSOVP84xoacsRLRvDpKrcIYS/qDTD5Zu55g0PNP+/?=
 =?us-ascii?Q?o8Qt1+aOicHU7XUVAevzh+iUjbuiHd3z9yAX7watlPsajFcqSl5XZ9RzLQTR?=
 =?us-ascii?Q?8P+0A996i3PRRsBl450WemY9OIXYbypZBuwt6BOyeBWanQvZbGVLRjTNC/CV?=
 =?us-ascii?Q?kVhkAd5Nk4zEQxnfO7G/nHCvuS+SSNt58G6h/PqxkSQGAPPDsTRdQyeWo/HE?=
 =?us-ascii?Q?mqfPIpa7tLIaWdfXnwAMsWpkK/jWoBcYEbKFGbq/saemx/ZobmscPnmsbsKR?=
 =?us-ascii?Q?kJMD7I3V2BOJ0JIjAA2JWDhBkbUvESOTT0HDQhPUSC/uQWXlNVn0hxBsZ0hO?=
 =?us-ascii?Q?IRCdkFfCyNnapGSKZxo0Qpd7hPX7K/WSk29iXjgg4s5wfMA3GcsT59p80lI/?=
 =?us-ascii?Q?NLtC794l7HXhfQSDox4y4TdDi7nrMxvh3mpldYUBXEwPurre/JjvJrYksj3c?=
 =?us-ascii?Q?Tlly+NUaSZpVVW+eqYrdY2vWdP3w6OEDH+QsmHZTzJtPZY8act2/tvVS+T8L?=
 =?us-ascii?Q?B+hG3UBHG94TZnNeO1h6GeUdPKRCjrVyAK+r1BqZ0UxNn4cu67FUPTLkoS9q?=
 =?us-ascii?Q?locsk01n7NiETIB81Whp/E82IiwsfBTp4iT49l7yq1pidnXyvEtH3UQXAUQ6?=
 =?us-ascii?Q?WoCx1vW7EQujFOpejyTVXRU08QV2gaPj7VCOAftDj6UC3wYX7FPSjRVOts+7?=
 =?us-ascii?Q?GmmYk65lhE3hh9hYwXu99uVcoEOJDvdHlvuw++igOLvzdrr4NAXjNifWxJP8?=
 =?us-ascii?Q?9nkR6RwMh6WfznXIMxfI79HXrgg0g21dlrrve2SfFPLKhfHoGoLT3NSGro5G?=
 =?us-ascii?Q?dsby/QHAf6+f7ZkWuHY2h8TP3l8OYYnrEJrBlRGNBlr7GrOgzJbzoyNB7h/L?=
 =?us-ascii?Q?AhB4lqvVF2Px8PHPP7xFraoeejnb2LwaNxIsN3cFnSt4n4M7LNdleQe82QXq?=
 =?us-ascii?Q?3TTGJthj8TcSsaYCO84qcFrS+Y40zU+3jtYurRw3LiVbXvy7B4ORLx+J3gf2?=
 =?us-ascii?Q?6aCHZ1nQnZrScqQr9jB4G4ATTJVexQJ9/Y8DWqg4kfIWEI0XXPU2F1Y0yJht?=
 =?us-ascii?Q?S8YGuSf+cgNVoh/4d+iEz4IKb/e9GnF0nmZCb+O2VT9tez7s+w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0f2b74b-6ba5-41a7-f74e-08d97f49a07e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2021 10:54:05.0705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O6YsNwic8y2kS/wpYyiHWgICv4VD6ROWiRMBhCHcH1zzH7fEwBJICajMnXh2uMA+d6iLQsAKM2xy9o+9LOT7cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4537
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/09/24 8:27, Bart Van Assche wrote:=0A=
> The scheduler .insert_requests() callback is called when a request is=0A=
> queued for the first time and also when it is requeued. Only count a=0A=
> request the first time it is queued. Additionally, since the mq-deadline=
=0A=
> scheduler only performs zone locking for requests that have been=0A=
> inserted, skip the zone unlock code for requests that have not been=0A=
> inserted into the mq-deadline scheduler.=0A=
> =0A=
> Fixes: 38ba64d12d4c ("block/mq-deadline: Track I/O statistics")=0A=
> Cc: Damien Le Moal <damien.lemoal@wdc.com>=0A=
> Cc: Niklas Cassel <Niklas.Cassel@wdc.com>=0A=
> Cc: Hannes Reinecke <hare@suse.de>=0A=
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>=0A=
> ---=0A=
>  block/mq-deadline.c | 17 ++++++++++-------=0A=
>  1 file changed, 10 insertions(+), 7 deletions(-)=0A=
> =0A=
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c=0A=
> index 7f3c3932b723..b1175e4560ad 100644=0A=
> --- a/block/mq-deadline.c=0A=
> +++ b/block/mq-deadline.c=0A=
> @@ -677,8 +677,10 @@ static void dd_insert_request(struct blk_mq_hw_ctx *=
hctx, struct request *rq,=0A=
>  	blk_req_zone_write_unlock(rq);=0A=
>  =0A=
>  	prio =3D ioprio_class_to_prio[ioprio_class];=0A=
> -	dd_count(dd, inserted, prio);=0A=
> -	rq->elv.priv[0] =3D (void *)(uintptr_t)1;=0A=
> +	if (!rq->elv.priv[0]) {=0A=
> +		dd_count(dd, inserted, prio);=0A=
> +		rq->elv.priv[0] =3D (void *)(uintptr_t)1;=0A=
> +	}=0A=
>  =0A=
>  	if (blk_mq_sched_try_insert_merge(q, rq, &free)) {=0A=
>  		blk_mq_free_requests(&free);=0A=
> @@ -759,12 +761,13 @@ static void dd_finish_request(struct request *rq)=
=0A=
>  =0A=
>  	/*=0A=
>  	 * The block layer core may call dd_finish_request() without having=0A=
> -	 * called dd_insert_requests(). Hence only update statistics for=0A=
> -	 * requests for which dd_insert_requests() has been called. See also=0A=
> -	 * blk_mq_request_bypass_insert().=0A=
> +	 * called dd_insert_requests(). Skip requests that bypassed I/O=0A=
> +	 * scheduling. See also blk_mq_request_bypass_insert().=0A=
>  	 */=0A=
> -	if (rq->elv.priv[0])=0A=
> -		dd_count(dd, completed, prio);=0A=
> +	if (!rq->elv.priv[0])=0A=
> +		return;=0A=
> +=0A=
> +	dd_count(dd, completed, prio);=0A=
>  =0A=
>  	if (blk_queue_is_zoned(q)) {=0A=
>  		unsigned long flags;=0A=
> =0A=
=0A=
Looks good to me.=0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
