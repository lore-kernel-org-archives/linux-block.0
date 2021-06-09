Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B92C47095
	for <linux-block@archiver.kernel.org>; Wed,  9 Jun 2021 05:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D7DA61287
	for <linux-block@archiver.kernel.org>; Wed,  9 Jun 2021 05:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbhFIFMt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Jun 2021 01:12:49 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:11019 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbhFIFMt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Jun 2021 01:12:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1623215455; x=1654751455;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=twkrkXCnpd16Pro5ODBMmhu2pcxjleBYFiiRp9PjzUM=;
  b=XdmgzGxtADvrYV8D19biMTm/70h+yhNbRyo52ajVViLuw2KtNNi/DNqg
   tj0k1rxmil1xI1ebZGcEMv1tUQZoS7vZg8WfUN6ho/+dupZfD5iPd6iRL
   958z1vS8DwgJOFiT29fT33LJDDkHjunTzUCLLRqT7aGMLiwQTI4zQIeko
   0TQsspx42QY5OvDVGK0o5QVCeQHnzV3PAA9ACoQb443AThNi4YnA33ABl
   IZdhNHS0NouaBinX5I15MMVsiMZUGZ+P5vGKE71v6utC7ybClKzioYBSV
   xqIMLr+kOv6Mtb8PCRnKOR97+RDNDHi7qtkfwSJnUx01KqLltTc4/VbS6
   A==;
IronPort-SDR: 6x9PuKFwIFYPM4q1lK9E/05ACtfDs4hPUtKcFn8Aye/dbI1z+ag+eVtydxfu4JTOyIMRDOLsKC
 6CcwtsX0ltfJUM8g6T/zdDdf4Oh/itUahuDK5IW9iZ4UNY3RD87+gn77ISigZgs4jE15ByHz8Q
 5OU6UaIev5wfR0NQk6j7eUmqtqm6RkR3JSdz0AkrzGwuyxOJjgpCOrJUh36fhUkNNnrtolzZBf
 ZnYpo7s6NkVslAEKgn5Xm1fmUP5i2KGR4Rr21WUShClnUpALgBNG9A0M+Bm40vRlE1ssniqnY6
 omE=
X-IronPort-AV: E=Sophos;i="5.83,260,1616428800"; 
   d="scan'208";a="282686648"
Received: from mail-dm6nam12lp2175.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.175])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jun 2021 13:10:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MC1HgZIqaqATsao86CRGqKjkjA1GLb1nndYNy+L8mXMO2oaUJNRyn1lNlbzLaGsaDHRZfpE1r/XpPa7fe6WnZwa0reMGmH2rUABN50GAqx0Mf5cCbLN33oiI+v7YhS6Gsj5oAJKTa5ahN+CJTw/J5hTr3U3Bs61TF5FCOEFR1/26VzldTrrKp55sgkyPU9XrJk/MRSa4KFpxCEeDBNKTiqR9mHk84tGRCyzqaAsckaJM56d7aCWw2EwC8uu7RCAmci05PyXoxNsrMj193Lcj0MFonNm/fUyjODNt/LbQGOanTqm+dINmES7JgN2a7uyWvAnov7y30eGfj84X0uGEGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hRUDysAwXl8GDQxz3ERFPScRTeDSj3MoedB7r5fcnts=;
 b=BmajlM16eSC/GRXwsvDSlV57aEGuOwAkBbiwPgU4RQBAZlA5FZ4lYCsRCwqMZSh2PeGGXY9QnIpYLKQVcMBDrsqxSDleNHYRoPQ/pwOhoANW8xyQTfMk0rKTdpgk1ZePXFtTNpkOcWneSbOKNIvBSUmAheAW+D8bQPRnivg3w/pLcqNcJNZUAfwIRFpg2SwFTQbuaeRmRTsfYzbpIJWgIJy3/3qkDEHGiuy3u3gSvKM3I2VzC0XsqQS3ZeycTEBH86NNkaiCGv6l2CMjvI0wescBqFDi5jitX8cc1pnPbXiwWSr9ALCHLTcXxdW+HeKMpq1/syXNMZhw4tzMdJ3oZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hRUDysAwXl8GDQxz3ERFPScRTeDSj3MoedB7r5fcnts=;
 b=EFnxvzWiffqkFSBYPo5+M2x+FIwcdrIYyDomeSzYVFq8wFv3GOSPnXylb0zfCTOLqSqJmt2SMZysOPIV8u8+N9o6ygYtrKSCoFGUt3UlLdXWDx7w4c17tpWpUzA15HTHaZqn8qZNNiumwCC6Y93rKhfzoCD8joj6N9bugzb+xo4=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM6PR04MB6681.namprd04.prod.outlook.com (2603:10b6:5:24c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Wed, 9 Jun
 2021 05:10:53 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806%9]) with mapi id 15.20.4195.030; Wed, 9 Jun 2021
 05:10:53 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [PATCH 14/14] block/mq-deadline: Prioritize high-priority
 requests
Thread-Topic: [PATCH 14/14] block/mq-deadline: Prioritize high-priority
 requests
Thread-Index: AQHXXLsV6v8auRj8d0CVQCJpNBgnIw==
Date:   Wed, 9 Jun 2021 05:10:53 +0000
Message-ID: <DM6PR04MB7081853B525156C4F4FF0C0AE7369@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20210608230703.19510-1-bvanassche@acm.org>
 <20210608230703.19510-15-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:513e:a3fe:98aa:a7ae]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dd95de04-5f28-461a-3351-08d92b04f4d2
x-ms-traffictypediagnostic: DM6PR04MB6681:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB6681F1BF9504DF12E3030C65E7369@DM6PR04MB6681.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z8zRbvXrruuJFZR0P7VUpnyhyg6uR8CuWnk6FqoFT8nDmO7mv1Xb4ZOPsnr9YJW8G3fVYl+HTOGlqlcNBq5J8jMu4eLeBhBaDPsPyqgEetMLqUbWrvQLzTP945jho2eNcI9lf95LHJOiIdsXUF+pyqFPuO/F+4NMv8UsVOz3qZtBLs9DjCYYsK+S/tB8OG738DXFYkmZBeWuf71l2BT8GKzor3AyiuWI1eUXc/zF0R2gKF/ko8UUzZo8WgKoMgBAjB0vBzxx3kudoFG+aEdqywLazUkbk/fF6DVfmHBgQ1H4G8brk5DVOhE08cuqMuOJDMzM4Ys9CWaA6nxKhdmHLpg15Ag8oSHgbpiv3dOcXG4IRtqdUrH9BTRJx2U5NQ2TqfwRK/QfdULYmC96K8hsItCLy+v/IdQljKRgNBV94JgtxmDySeqI+U4k53nnq8uEq5BJB7IuD/40nHHTHxhfbX0IyguMCNzYeXTFxvn1VC5MtpTTfgdvLSyt1tZdClTENu8OeSSyNa9xVSqJSr/G4sTWFv6o2wd5hq3ZyQHovP1aE7lrCvSQ1ShoCcpNJK7z/xPjUqWR1pAQIqo8aYTxUjXdTxcPXdh1ZrBsuPth6q0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(136003)(396003)(366004)(33656002)(83380400001)(52536014)(2906002)(5660300002)(86362001)(186003)(66446008)(66476007)(122000001)(38100700002)(53546011)(64756008)(91956017)(66556008)(76116006)(66946007)(54906003)(316002)(110136005)(71200400001)(8936002)(8676002)(55016002)(6506007)(478600001)(4326008)(7696005)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZQdAyHw9Qsg1lxU2VXVIgZo2z3/1aKS/00X9gv86yXyoIT4U/VSxG0H0zqYq?=
 =?us-ascii?Q?I1tl3ZN/guVihIgGr0qZD5jO8/dqdZ/cLBKhyjfrBjnqY0wqqPr4ZWsdcTum?=
 =?us-ascii?Q?H6CEB46mDN4C3KxmP6q7vtCVh+3+xBNNJtaF53tl1b6pP92p968zY5puWUqf?=
 =?us-ascii?Q?IvewxFQcWzgwpsSiJbqXnYtFT2fE6wMUMktnz7ck77Okh+P5thl9D+HiZFzn?=
 =?us-ascii?Q?KMPnCm2rSmFQFQR1TKrYCQudKfNSKd626k9ZJ9otRjDKtncSMkuYFMiDN+/a?=
 =?us-ascii?Q?MLA0s+Z82bB/jpCe615RBUdMcFHrhqoRgCJA6HwE/Hn4xl8MhbqVMi7pynCg?=
 =?us-ascii?Q?t15aBXGg2Q/0eLOQGi0ae4atFGMzli3+0y+/ryYnWeritbJCYTGtpDWJspEq?=
 =?us-ascii?Q?cr43tH7UbpxU30s4uo4LUAFFxoAcvO7I3wzlvQY0OCvhoEnCrFy6UO4dYlkk?=
 =?us-ascii?Q?O08+PkwxwR7SBrzdGa+ArcUXWNrwEycU7hnbwOZ1Q6tOGwDUXbJH63R3vfXN?=
 =?us-ascii?Q?KA9clhDtdv0K/AJXZostsjWzKGFWv/Yaaf6jDyo4nYUYsCj1X+B45W5JWdgW?=
 =?us-ascii?Q?p6Dn0UGBRMCDmosm+PbsPyP7UHXY4cVpjijt4KV2x6O1lGC7OMWWR3qQyi9J?=
 =?us-ascii?Q?dJNID7Lhy/mu7bRXMqF6V4iQclLgHFKo9//N6ZHS9JCRU7J5uH/H6IaidozE?=
 =?us-ascii?Q?/HZ1l8qpfo0+w9qs+riXM/qMG3gxzF1kPQcXdno4Vzpnz7kdUUlDiUNUvux1?=
 =?us-ascii?Q?xfHzU4vNRPdZ/4uX1bYt2alA3lrhlZ2M71put9N6g8aJkHWFLJ3MgsXHKxvq?=
 =?us-ascii?Q?3XKeNPqiKsLEhEqJInVGoON9gjfxh6UE1pPpJzMlD+d/+zb6qb5T5vr8jySp?=
 =?us-ascii?Q?D7+H2ZovQdLpRNCSrMYE45kx42DW/tZrE84QbeAQm2YJq4fYxomywGOKJiLc?=
 =?us-ascii?Q?VoirhyfgHD1+wdErTMc0FWp413v18OQ0UBujdsp0z6N8lvR0T8XYF5Y28N3P?=
 =?us-ascii?Q?TrcMP8krfJAsr+r7n9Ln/CdgWcZR459uWAexph9Ir7gZ5BKzPeixObYogZOK?=
 =?us-ascii?Q?9LDP0C/miSMi+OwO6HIAFucJbQ6IGmtkrmCAuVRHk0AoY1YDcnlRfpry6iOB?=
 =?us-ascii?Q?+YkWkvt7tku5lQQvNC43kvwtf55CVQdxg5sJwyrI4YIxi4Ks9y2U9nJgYJA8?=
 =?us-ascii?Q?hZd5o8z+tBEha/0LIy0P7xu2MGeRwvMTkm0Ikm9hLrYSru+MSKrl7XzWU5on?=
 =?us-ascii?Q?Xqyq+G1Za9S14Scc2xLpL5CAXodoOGlwSz64omokimSHN5qJHRLpuyLuyI+r?=
 =?us-ascii?Q?WPD7yY7fHAIbu2e/8lkTmzU406WmKwXv+u2HcczrXMxpK3rWy48TVsqA19wb?=
 =?us-ascii?Q?3QSrLA3k0R27POihQMpTfbuyWugaxNMLC2z6tGBDLuny1fqJWQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd95de04-5f28-461a-3351-08d92b04f4d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2021 05:10:53.5482
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hyGdOMUNRoMNXKzPOwaEyv+p4D7CFTuL+8qo4CGchBfWZyyjGdKz9B3F5wb/SValWx7En6rClIpj35ABcEzD5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6681
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/06/09 8:07, Bart Van Assche wrote:=0A=
> While one or more requests with a certain I/O priority are pending, do no=
t=0A=
> dispatch lower priority requests. Dispatch lower priority requests anyway=
=0A=
> after the "aging" time has expired.=0A=
> =0A=
> This patch has been tested as follows:=0A=
> =0A=
> modprobe scsi_debug ndelay=3D1000000 max_queue=3D16 &&=0A=
> sd=3D'' &&=0A=
> while [ -z "$sd" ]; do=0A=
>   sd=3D/dev/$(basename /sys/bus/pseudo/drivers/scsi_debug/adapter*/host*/=
target*/*/block/*)=0A=
> done &&=0A=
> echo $((100*1000)) > /sys/block/$sd/queue/iosched/aging_expire &&=0A=
> cd /sys/fs/cgroup/blkio/ &&=0A=
> echo $$ >cgroup.procs &&=0A=
> echo 2 >blkio.prio.class &&=0A=
> mkdir -p hipri &&=0A=
> cd hipri &&=0A=
> echo 1 >blkio.prio.class &&=0A=
> { max-iops -a1 -d32 -j1 -e mq-deadline $sd >& ~/low-pri.txt & } &&=0A=
> echo $$ >cgroup.procs &&=0A=
> max-iops -a1 -d32 -j1 -e mq-deadline $sd >& ~/hi-pri.txt=0A=
> =0A=
> Result:=0A=
> * 11000 IOPS for the high-priority job=0A=
> *   400 IOPS for the low-priority job=0A=
> =0A=
> If the aging expiry time is changed from 100s into 0, the IOPS results ch=
ange=0A=
> into 6712 and 6796 IOPS.=0A=
> =0A=
> The max-iops script is a script that runs fio with the following argument=
s:=0A=
> --bs=3D4K --gtod_reduce=3D1 --ioengine=3Dlibaio --ioscheduler=3D${arg_e} =
--runtime=3D60=0A=
> --norandommap --rw=3Dread --thread --buffered=3D0 --numjobs=3D${arg_j}=0A=
> --iodepth=3D${arg_d} --iodepth_batch_submit=3D${arg_a}=0A=
> --iodepth_batch_complete=3D$((arg_d / 2)) --name=3D${positional_argument_=
1}=0A=
> --filename=3D${positional_argument_1}=0A=
> =0A=
> Cc: Damien Le Moal <damien.lemoal@wdc.com>=0A=
> Cc: Hannes Reinecke <hare@suse.de>=0A=
> Cc: Christoph Hellwig <hch@lst.de>=0A=
> Cc: Ming Lei <ming.lei@redhat.com>=0A=
> Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
> Cc: Himanshu Madhani <himanshu.madhani@oracle.com>=0A=
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>=0A=
> ---=0A=
>  block/mq-deadline-main.c | 42 +++++++++++++++++++++++++++++++++++-----=
=0A=
>  1 file changed, 37 insertions(+), 5 deletions(-)=0A=
> =0A=
> diff --git a/block/mq-deadline-main.c b/block/mq-deadline-main.c=0A=
> index 1b2b6c1de5b8..cecdb475a610 100644=0A=
> --- a/block/mq-deadline-main.c=0A=
> +++ b/block/mq-deadline-main.c=0A=
> @@ -32,6 +32,11 @@=0A=
>   */=0A=
>  static const int read_expire =3D HZ / 2;  /* max time before a read is s=
ubmitted. */=0A=
>  static const int write_expire =3D 5 * HZ; /* ditto for writes, these lim=
its are SOFT! */=0A=
> +/*=0A=
> + * Time after which to dispatch lower priority requests even if higher=
=0A=
> + * priority requests are pending.=0A=
> + */=0A=
> +static const int aging_expire =3D 10 * HZ;=0A=
>  static const int writes_starved =3D 2;    /* max times reads can starve =
a write */=0A=
>  static const int fifo_batch =3D 16;       /* # of sequential requests tr=
eated as one=0A=
>  				     by the above parameters. For throughput. */=0A=
> @@ -90,6 +95,7 @@ struct deadline_data {=0A=
>  	int writes_starved;=0A=
>  	int front_merges;=0A=
>  	u32 async_depth;=0A=
> +	int aging_expire;=0A=
>  =0A=
>  	spinlock_t lock;=0A=
>  	spinlock_t zone_lock;=0A=
> @@ -363,10 +369,10 @@ deadline_next_request(struct deadline_data *dd, enu=
m dd_prio prio,=0A=
>  =0A=
>  /*=0A=
>   * deadline_dispatch_requests selects the best request according to=0A=
> - * read/write expire, fifo_batch, etc=0A=
> + * read/write expire, fifo_batch, etc and with a start time <=3D @latest=
.=0A=
>   */=0A=
>  static struct request *__dd_dispatch_request(struct deadline_data *dd,=
=0A=
> -					     enum dd_prio prio)=0A=
> +					enum dd_prio prio, u64 latest_start_ns)=0A=
>  {=0A=
>  	struct request *rq, *next_rq;=0A=
>  	enum dd_data_dir data_dir;=0A=
> @@ -378,6 +384,8 @@ static struct request *__dd_dispatch_request(struct d=
eadline_data *dd,=0A=
>  	if (!list_empty(&dd->dispatch[prio])) {=0A=
>  		rq =3D list_first_entry(&dd->dispatch[prio], struct request,=0A=
>  				      queuelist);=0A=
> +		if (rq->start_time_ns > latest_start_ns)=0A=
> +			return NULL;=0A=
>  		list_del_init(&rq->queuelist);=0A=
>  		goto done;=0A=
>  	}=0A=
> @@ -457,6 +465,8 @@ static struct request *__dd_dispatch_request(struct d=
eadline_data *dd,=0A=
>  	dd->batching =3D 0;=0A=
>  =0A=
>  dispatch_request:=0A=
> +	if (rq->start_time_ns > latest_start_ns)=0A=
> +		return NULL;=0A=
>  	/*=0A=
>  	 * rq is the selected appropriate request.=0A=
>  	 */=0A=
> @@ -493,15 +503,32 @@ static struct request *__dd_dispatch_request(struct=
 deadline_data *dd,=0A=
>  static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)=
=0A=
>  {=0A=
>  	struct deadline_data *dd =3D hctx->queue->elevator->elevator_data;=0A=
> -	struct request *rq;=0A=
> +	const u64 now_ns =3D ktime_get_ns();=0A=
> +	struct request *rq =3D NULL;=0A=
>  	enum dd_prio prio;=0A=
>  =0A=
>  	spin_lock(&dd->lock);=0A=
> -	for (prio =3D 0; prio <=3D DD_PRIO_MAX; prio++) {=0A=
> -		rq =3D __dd_dispatch_request(dd, prio);=0A=
> +	/*=0A=
> +	 * Start with dispatching requests whose deadline expired more than=0A=
> +	 * aging_expire jiffies ago.=0A=
> +	 */=0A=
> +	for (prio =3D DD_BE_PRIO; prio <=3D DD_PRIO_MAX; prio++) {=0A=
> +		rq =3D __dd_dispatch_request(dd, prio, now_ns -=0A=
> +					   jiffies_to_nsecs(dd->aging_expire));=0A=
>  		if (rq)=0A=
> +			goto unlock;=0A=
> +	}=0A=
> +	/*=0A=
> +	 * Next, dispatch requests in priority order. Ignore lower priority=0A=
> +	 * requests if any higher priority requests are pending.=0A=
> +	 */=0A=
> +	for (prio =3D 0; prio <=3D DD_PRIO_MAX; prio++) {=0A=
> +		rq =3D __dd_dispatch_request(dd, prio, now_ns);=0A=
> +		if (rq || dd_queued(dd, prio))=0A=
>  			break;=0A=
>  	}=0A=
> +=0A=
> +unlock:=0A=
>  	spin_unlock(&dd->lock);=0A=
>  =0A=
>  	return rq;=0A=
> @@ -607,6 +634,7 @@ static int dd_init_sched(struct request_queue *q, str=
uct elevator_type *e)=0A=
>  	dd->writes_starved =3D writes_starved;=0A=
>  	dd->front_merges =3D 1;=0A=
>  	dd->fifo_batch =3D fifo_batch;=0A=
> +	dd->aging_expire =3D aging_expire;=0A=
>  	spin_lock_init(&dd->lock);=0A=
>  	spin_lock_init(&dd->zone_lock);=0A=
>  =0A=
> @@ -725,6 +753,7 @@ static void dd_insert_request(struct blk_mq_hw_ctx *h=
ctx, struct request *rq,=0A=
>  	trace_block_rq_insert(rq);=0A=
>  =0A=
>  	if (at_head) {=0A=
> +		rq->fifo_time =3D jiffies;=0A=
>  		list_add(&rq->queuelist, &dd->dispatch[prio]);=0A=
>  	} else {=0A=
>  		deadline_add_rq_rb(dd, rq);=0A=
> @@ -841,6 +870,7 @@ static ssize_t __FUNC(struct elevator_queue *e, char =
*page)		\=0A=
>  #define SHOW_JIFFIES(__FUNC, __VAR) SHOW_INT(__FUNC, jiffies_to_msecs(__=
VAR))=0A=
>  SHOW_JIFFIES(deadline_read_expire_show, dd->fifo_expire[DD_READ]);=0A=
>  SHOW_JIFFIES(deadline_write_expire_show, dd->fifo_expire[DD_WRITE]);=0A=
> +SHOW_JIFFIES(deadline_aging_expire_show, dd->aging_expire);=0A=
>  SHOW_INT(deadline_writes_starved_show, dd->writes_starved);=0A=
>  SHOW_INT(deadline_front_merges_show, dd->front_merges);=0A=
>  SHOW_INT(deadline_fifo_batch_show, dd->fifo_batch);=0A=
> @@ -869,6 +899,7 @@ static ssize_t __FUNC(struct elevator_queue *e, const=
 char *page, size_t count)=0A=
>  	STORE_FUNCTION(__FUNC, __PTR, MIN, MAX, msecs_to_jiffies)=0A=
>  STORE_JIFFIES(deadline_read_expire_store, &dd->fifo_expire[DD_READ], 0, =
INT_MAX);=0A=
>  STORE_JIFFIES(deadline_write_expire_store, &dd->fifo_expire[DD_WRITE], 0=
, INT_MAX);=0A=
> +STORE_JIFFIES(deadline_aging_expire_store, &dd->aging_expire, 0, INT_MAX=
);=0A=
>  STORE_INT(deadline_writes_starved_store, &dd->writes_starved, INT_MIN, I=
NT_MAX);=0A=
>  STORE_INT(deadline_front_merges_store, &dd->front_merges, 0, 1);=0A=
>  STORE_INT(deadline_fifo_batch_store, &dd->fifo_batch, 0, INT_MAX);=0A=
> @@ -885,6 +916,7 @@ static struct elv_fs_entry deadline_attrs[] =3D {=0A=
>  	DD_ATTR(writes_starved),=0A=
>  	DD_ATTR(front_merges),=0A=
>  	DD_ATTR(fifo_batch),=0A=
> +	DD_ATTR(aging_expire),=0A=
>  	__ATTR_NULL=0A=
>  };=0A=
>  =0A=
> =0A=
=0A=
Looks good.=0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
