Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B18C433EF
	for <linux-block@archiver.kernel.org>; Fri, 24 Sep 2021 11:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D23186124C
	for <linux-block@archiver.kernel.org>; Fri, 24 Sep 2021 11:08:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244727AbhIXLK1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Sep 2021 07:10:27 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:1171 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244623AbhIXLKT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Sep 2021 07:10:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1632481726; x=1664017726;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=a46EbjRori6FNroC/a4wsyf0BWraNnWBiVC+qEg81jk=;
  b=XyrXStPEXfRA3W+bRSByW+k93y3nE9ZGEL1ugWgSeurQIH/Fq/f48GAi
   qm7OpiP0jE1apvPxCiV4V05yWKUjtOBTQyNrGkJxvVgKDM7QQWt1RJHns
   OHkNhjaxL6Ty24F9bhtlAOblkM+gzT6solsOFRaMv+cPhBZP457GPjHSl
   6XMTS915R1h3War8kwxKFWaBT9LBA6Q5t9SBiD/At4MugOa0iiSVcfAMi
   UarBm+eF09kQQI9JetXmEipTklwmT8D/N2M3Anqa7hxTYEZGu05tWkJci
   mUHE0PeX+06CbKz94TCw7YZ65Djt64YLOR5Jc/A+ZkXIJJJPytI6uC2vH
   Q==;
X-IronPort-AV: E=Sophos;i="5.85,319,1624291200"; 
   d="scan'208";a="284658009"
Received: from mail-mw2nam08lp2177.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.177])
  by ob1.hgst.iphmx.com with ESMTP; 24 Sep 2021 19:08:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GYWzcVzbvErwFI6yanI1fAYDeqd5Tz3hz5Hu0jihtCBS2J01MqAogch6I7bcBR+QMrDXjECEb56DKXj+tfJLzr5Yx7M7SZtZAKrRUKwFLlxt5Uhep4wsuOsm8Fc7ReTjSKBq+3OJVzOONWgq1GfFumI9AnK0xnLfBWAy3bn1IGnum/ekhWN9RtEWt4pdS/6yBgJoSaXmRalZUgbrpf04NQL4PhhjOAoWJ1lA+pPl4vRnwP9Yw02EaS9t/j0Kfp/V+mZkMcRRO6YRVWq+Lxk5pLMs0eVZPLuN+TIynBZ8hCfx+qeJ3z5DWk+3VMCb2+8UrymCnjnKUNPAPkK6n3kBNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=SR8R9S8Jfv9mbpqLjuuU7bOFJjPDlRJnp1KhbppFfn4=;
 b=FnmFM1VzM+VPogQdOUncgUdFGaes/u3r72w+W81brlSJS0DS9yJl+gWOGI19C2SUxoPtyXlTqLZYyxc6+c0fJhHQYMezCgvz++u5Olx8vfZMj/YrY9aoVcqC8nPuLz3kod7xUn8Cv7AseCiGh79CWgcgQwXRRN7EvdPRZP49gf/V4L+UySeMWlwlwjQCDCJFp8QmeZhnop5eFLf/8pyK0y4CEJht/8lFDbnlaq0D/jNDDuHM3WQMtcWB7xELGOwtuMFqW2Ci99xnwjir+s1l73dfLDqNzt1MGo7WiB8PVE2dvk2L6z59ZWRsnKcICcBTtJMmgTVF+sbL7gvraaXGNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SR8R9S8Jfv9mbpqLjuuU7bOFJjPDlRJnp1KhbppFfn4=;
 b=Z3RSqPOnib7l9RchNdc6/tAMz2Nkeqj9btHXOIWSw1+FpfaN214W4NQMKJ9Y4ZnUNtGGK1jF+CAILCIeXoSU4ItAv9cYsrSPqjhmvlp20I9JnMc38l2PX63URQuOqG8salCtYWYmq1Z3T/7oLZPcmg9gNjOV8XYjQFl0Qo2PdeY=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM6PR04MB5594.namprd04.prod.outlook.com (2603:10b6:5:163::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Fri, 24 Sep
 2021 11:08:43 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::7c0e:3e95:80d3:7a70]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::7c0e:3e95:80d3:7a70%7]) with mapi id 15.20.4544.018; Fri, 24 Sep 2021
 11:08:43 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 4/4] block/mq-deadline: Prioritize high-priority requests
Thread-Topic: [PATCH 4/4] block/mq-deadline: Prioritize high-priority requests
Thread-Index: AQHXsNKK4o0ADXd9MUOCySU5tuPmqw==
Date:   Fri, 24 Sep 2021 11:08:43 +0000
Message-ID: <DM6PR04MB708107091FD22BC145EDB340E7A49@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20210923232358.3907118-1-bvanassche@acm.org>
 <20210923232655.3907383-1-bvanassche@acm.org>
 <20210923232655.3907383-4-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 20de5bf5-341c-4297-723d-08d97f4bac39
x-ms-traffictypediagnostic: DM6PR04MB5594:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB5594CD90B4BF5DA14835D1F8E7A49@DM6PR04MB5594.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yu6K1ulC+DvGkIrxSCKw0dqzCGoEUNcNYhPyM9zUFjTVcR2XTjsHJ6N/ojpRBC8rzSOfQtKbzAjrw2YCmT9C1p6BKC78zotMx9jpvmcNIIWzl/YU+9TkWwqIAvpRfzkCvtJwQ75g9a8/xxEIpHyCywdXeXXEhbzP8vM6UOjSmNS6Q94A3GfCXaFcLfmjCpGgxhDMh662bm1wjWUYbUPG87wMXvQvshas9Yq2Wp3YJXvbfgIvY6VBlX4pt5aPQuJR4fILIgyrCcvshJfggg+mqOB+sEwwr8jlh8ObO6DTO3iO234R5kiWn6dp/bDJo/WfqS0XmsuA2dLhA7nl9WQe+SarqeCi480a0Fd+SCvMXy5BWy6oY8sRWGvHqK3Hmg08PhV9RAcWYV4lEFvkVtayuLDA6g6kYC//exhqg6IyxDTt+eKiC9FZ9gn7G6agyMLfR7KmbyhX30ai1zLIFEUnxXSzQuNFAU1vRscGJWQi2Mc0G6oUS4bGbSmJOV1zKdoOBOTzbkDOeAU0SUno4hHhkGjsPldbdix1WD/8yHKGpy29lQXTO7yzaXjMQ+pekKG6uxgJjXRVspXcBg9jbgZDKFSC52Nu2YxaQSsFYR1SKoBj4gR5r0vb/GmjyjeIt1AfrX1WPsSQzCXE1IVPNSUFwDsBM7CMrimAIrU2TwqZqFfLJlCqH+EcXduyzDjaVUvsnlsEplA7Z4ZwxWYsgodENPpqDrReCO1qjImOIK6/RPY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(66446008)(66476007)(38100700002)(8676002)(66946007)(7696005)(86362001)(66556008)(4326008)(64756008)(55016002)(52536014)(9686003)(110136005)(83380400001)(76116006)(91956017)(122000001)(33656002)(316002)(54906003)(186003)(2906002)(71200400001)(53546011)(38070700005)(508600001)(6506007)(5660300002)(309714004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0zh5N6h0x5NjiVVn5g7GeDB1VgeMwwB4t8gEK2ZOCA7iuKTNY3GjQNyyCSGQ?=
 =?us-ascii?Q?jUebvxOop5npO06FrsYimg60OuvbhMuFLNA7T1msC1WfxDtT0dFwYvnFuwNu?=
 =?us-ascii?Q?mF0YmRxoxbmkAzZH3fWiXKS66XDPU9t8adTH9PySDIGGijv72q9pK2zzyBZo?=
 =?us-ascii?Q?SMRzEFuTOydDg+5EOmAqa1bZ+kJcJRM/9KvL/GUlRc0bRMTZVJ8y+wbj6P1d?=
 =?us-ascii?Q?8dMhCNbuhZ0lrFOSrppBAnJRyq9scE3TH3qdDWCPdf9IGHKCZPj+ZdRNcBZe?=
 =?us-ascii?Q?bG6ZW4/ZI4i6ThGAdecU4s8FHDP5/hyAs0un5tVILqvUYkp3MF64TwTWdRxM?=
 =?us-ascii?Q?YfKD0bxa0p2oOKUGZplTEgHsOlqxd0ZM/Wz1hm6n5CqC4PcRvoAz4qLuVZAT?=
 =?us-ascii?Q?uyHq0L6YwfQqhz4mhWrvJ5KrqrDQUh3iTyeIBUI5BinQ39zW7haJCI17lK3M?=
 =?us-ascii?Q?2NlHbrevCzjKjYwn+8+pARqTd50jnJVvk0J7bGyUkBMxj6MAjFkJzLkFj9Fh?=
 =?us-ascii?Q?6MDufOn4APelN/MeBXHVCGWBw3028EN+CZ9qM83neTp9ei0DNhYcGQJIuT8x?=
 =?us-ascii?Q?TABsz93KThRGUbOK/UY/FdlVulwTlDiUkyoWXzLXy4xKa1Qd3emk8UZdaY+t?=
 =?us-ascii?Q?DJPYgrKEqMFPQjHftQYNXy44DtdN2CLaVC1P+O4dwwPLHq10SB81QBbyoTkd?=
 =?us-ascii?Q?rat0YOGhUQDiwKicKOa5Cv5nSjrQS0oveXuYKZeGRISM0Uhz1knPMbY20wSr?=
 =?us-ascii?Q?V4w0tkQwpr0m6rH+a0Vsw2eEm6lFmEvIVF56q2GKCkN+emQ6ggWnGMOX0jEh?=
 =?us-ascii?Q?Wd5wOPQzdmFNXnv6DvxiuwC86roz9xnwb+OHnEVT1ZS6jduWS655Ucusz2U0?=
 =?us-ascii?Q?igsETjfVT3dGIykoEQhABrU8CRa3GwRQABDeJlOFdsRxuF9TdOGE/m1KZyBx?=
 =?us-ascii?Q?7bCbQaLxE6Wh9E5T5hb0+GUn52Cy/ZD09+bjlbhADMOCxI7ei2GHhTQjCsqp?=
 =?us-ascii?Q?SjU3BWt+BjS/PcGz/PIWvKq8Iw/3QMeOZsYnSVQ5Wni68VrhhzUbfWQYJBmD?=
 =?us-ascii?Q?lVeLnljcMRf88F7RwYPunT9iKpZaHwtLCuk0pRNJzE8IjKcQW7nSOS2/lUoi?=
 =?us-ascii?Q?w2ESUqczdXODd7i5QQqaHh1zd7+tPe4UUe1mWKQB18eHJBTj58QltfAEGZ5k?=
 =?us-ascii?Q?NA7Q5HjlwBXScZ4fCyJK6bFdxX5Va7b2epdGISGiFYTSpT2JndEZNLo77ULv?=
 =?us-ascii?Q?1oHHSaR/mDFhFrN31UTSHKjkq6iqedO9QHlhV1ysjqQNlCuMwdj9WjgHHixM?=
 =?us-ascii?Q?xzKSJXgC4/NcPpSViS09x5w4pr3MR9VPKx3FGeJmRCbNo9z+IrSNg3wYDVd4?=
 =?us-ascii?Q?lmwubT8PB+mOeePXIobxMmGnVNn0UTlpe1Vxepa0wmDKz7GiVQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20de5bf5-341c-4297-723d-08d97f4bac39
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2021 11:08:43.7341
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +9/wOj3nozfnM8rGfx8TSe5yoA/XXZGGqrlQAdg/B44zuwhUmgI06VoQnPL2wkdFc4ewWaFJLO925tRcylvbLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5594
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/09/24 8:27, Bart Van Assche wrote:=0A=
> In addition to reverting commit 7b05bf771084 ("Revert "block/mq-deadline:=
=0A=
> Prioritize high-priority requests""), this patch uses 'jiffies' instead=
=0A=
> of ktime_get() in the code for aging lower priority requests.=0A=
> =0A=
> This patch has been tested as follows:=0A=
> =0A=
> Measured QD=3D1/jobs=3D1 IOPS for nullb with the mq-deadline scheduler.=
=0A=
> Result without and with this patch: 555 K IOPS.=0A=
> =0A=
> Measured QD=3D1/jobs=3D8 IOPS for nullb with the mq-deadline scheduler.=
=0A=
> Result without and with this patch: about 380 K IOPS.=0A=
> =0A=
> Ran the following script:=0A=
> =0A=
> set -e=0A=
> scriptdir=3D$(dirname "$0")=0A=
> if [ -e /sys/module/scsi_debug ]; then modprobe -r scsi_debug; fi=0A=
> modprobe scsi_debug ndelay=3D1000000 max_queue=3D16=0A=
> sd=3D''=0A=
> while [ -z "$sd" ]; do=0A=
>   sd=3D$(basename /sys/bus/pseudo/drivers/scsi_debug/adapter*/host*/targe=
t*/*/block/*)=0A=
> done=0A=
> echo $((100*1000)) > "/sys/block/$sd/queue/iosched/aging_expire"=0A=
> if [ -e /sys/fs/cgroup/io.prio.class ]; then=0A=
>   cd /sys/fs/cgroup=0A=
>   echo restrict-to-be >io.prio.class=0A=
>   echo +io > cgroup.subtree_control=0A=
> else=0A=
>   cd /sys/fs/cgroup/blkio/=0A=
>   echo restrict-to-be >blkio.prio.class=0A=
> fi=0A=
> echo $$ >cgroup.procs=0A=
> mkdir -p hipri=0A=
> cd hipri=0A=
> if [ -e io.prio.class ]; then=0A=
>   echo none-to-rt >io.prio.class=0A=
> else=0A=
>   echo none-to-rt >blkio.prio.class=0A=
> fi=0A=
> { "${scriptdir}/max-iops" -a1 -d32 -j1 -e mq-deadline "/dev/$sd" >& ~/low=
-pri.txt & }=0A=
> echo $$ >cgroup.procs=0A=
> "${scriptdir}/max-iops" -a1 -d32 -j1 -e mq-deadline "/dev/$sd" >& ~/hi-pr=
i.txt=0A=
> =0A=
> Result:=0A=
> * 11000 IOPS for the high-priority job=0A=
> *    40 IOPS for the low-priority job=0A=
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
> Cc: Niklas Cassel <Niklas.Cassel@wdc.com>=0A=
> Cc: Hannes Reinecke <hare@suse.de>=0A=
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>=0A=
> ---=0A=
>  block/mq-deadline.c | 78 ++++++++++++++++++++++++++++++++++++++++++---=
=0A=
>  1 file changed, 73 insertions(+), 5 deletions(-)=0A=
> =0A=
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c=0A=
> index b0cfc84a4e6b..37440786fdbb 100644=0A=
> --- a/block/mq-deadline.c=0A=
> +++ b/block/mq-deadline.c=0A=
> @@ -31,6 +31,11 @@=0A=
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
=0A=
What about calling this prio_starved, to be consistent with writes_starved =
?=0A=
Or at least let's call it prio_aging_expire to show that it is for priority=
=0A=
levels, and not for requests within a priority queue.=0A=
=0A=
>  static const int writes_starved =3D 2;    /* max times reads can starve =
a write */=0A=
>  static const int fifo_batch =3D 16;       /* # of sequential requests tr=
eated as one=0A=
>  				     by the above parameters. For throughput. */=0A=
> @@ -96,6 +101,7 @@ struct deadline_data {=0A=
>  	int writes_starved;=0A=
>  	int front_merges;=0A=
>  	u32 async_depth;=0A=
> +	int aging_expire;=0A=
>  =0A=
>  	spinlock_t lock;=0A=
>  	spinlock_t zone_lock;=0A=
> @@ -338,12 +344,27 @@ deadline_next_request(struct deadline_data *dd, str=
uct dd_per_prio *per_prio,=0A=
>  	return rq;=0A=
>  }=0A=
>  =0A=
> +/*=0A=
> + * Returns true if and only if @rq started after @latest_start where=0A=
> + * @latest_start is in jiffies.=0A=
> + */=0A=
> +static bool started_after(struct deadline_data *dd, struct request *rq,=
=0A=
> +			  unsigned long latest_start)=0A=
> +{=0A=
> +	unsigned long start_time =3D (unsigned long)rq->fifo_time;=0A=
> +=0A=
> +	start_time -=3D dd->fifo_expire[rq_data_dir(rq)];=0A=
> +=0A=
> +	return time_after(start_time, latest_start);=0A=
> +}=0A=
> +=0A=
>  /*=0A=
>   * deadline_dispatch_requests selects the best request according to=0A=
> - * read/write expire, fifo_batch, etc=0A=
> + * read/write expire, fifo_batch, etc and with a start time <=3D @latest=
.=0A=
>   */=0A=
>  static struct request *__dd_dispatch_request(struct deadline_data *dd,=
=0A=
> -					     struct dd_per_prio *per_prio)=0A=
> +					     struct dd_per_prio *per_prio,=0A=
> +					     unsigned long latest_start)=0A=
>  {=0A=
>  	struct request *rq, *next_rq;=0A=
>  	enum dd_data_dir data_dir;=0A=
> @@ -355,6 +376,8 @@ static struct request *__dd_dispatch_request(struct d=
eadline_data *dd,=0A=
>  	if (!list_empty(&per_prio->dispatch)) {=0A=
>  		rq =3D list_first_entry(&per_prio->dispatch, struct request,=0A=
>  				      queuelist);=0A=
> +		if (started_after(dd, rq, latest_start))=0A=
> +			return NULL;=0A=
>  		list_del_init(&rq->queuelist);=0A=
>  		goto done;=0A=
>  	}=0A=
> @@ -432,6 +455,8 @@ static struct request *__dd_dispatch_request(struct d=
eadline_data *dd,=0A=
>  	dd->batching =3D 0;=0A=
>  =0A=
>  dispatch_request:=0A=
> +	if (started_after(dd, rq, latest_start))=0A=
> +		return NULL;=0A=
=0A=
Nit: add a blank line here ? (for aesthetic :))=0A=
=0A=
>  	/*=0A=
>  	 * rq is the selected appropriate request.=0A=
>  	 */=0A=
> @@ -449,6 +474,34 @@ static struct request *__dd_dispatch_request(struct =
deadline_data *dd,=0A=
>  	return rq;=0A=
>  }=0A=
>  =0A=
> +/*=0A=
> + * Check whether there are any requests with a deadline that expired mor=
e than=0A=
> + * aging_expire jiffies ago.=0A=
=0A=
Hmm... requests do not have a "deadline", so this is a little hard to=0A=
understand. What about something like this:=0A=
=0A=
* Check whether there are any requests at a low priority level inserted=0A=
* more than aging_expire jiffies ago.=0A=
=0A=
> + */=0A=
> +static struct request *dd_dispatch_aged_requests(struct deadline_data *d=
d,=0A=
> +						 unsigned long now)=0A=
=0A=
Same remark as for the aging_expire variable: it may be good to have prio i=
n the=0A=
name of this function. Something like:=0A=
=0A=
dd_dispatch_prio_starved_requests() ?=0A=
=0A=
> +{=0A=
> +	struct request *rq;=0A=
> +	enum dd_prio prio;=0A=
> +	int prio_cnt;=0A=
> +=0A=
> +	lockdep_assert_held(&dd->lock);=0A=
> +=0A=
> +	prio_cnt =3D !!dd_queued(dd, DD_RT_PRIO) + !!dd_queued(dd, DD_BE_PRIO) =
+=0A=
> +		   !!dd_queued(dd, DD_IDLE_PRIO);=0A=
> +	if (prio_cnt < 2)=0A=
> +		return NULL;=0A=
> +=0A=
> +	for (prio =3D DD_BE_PRIO; prio <=3D DD_PRIO_MAX; prio++) {=0A=
> +		rq =3D __dd_dispatch_request(dd, &dd->per_prio[prio],=0A=
> +					   now - dd->aging_expire);=0A=
> +		if (rq)=0A=
> +			return rq;=0A=
> +	}=0A=
> +=0A=
> +	return NULL;=0A=
> +}=0A=
> +=0A=
>  /*=0A=
>   * Called from blk_mq_run_hw_queue() -> __blk_mq_sched_dispatch_requests=
().=0A=
>   *=0A=
> @@ -460,15 +513,26 @@ static struct request *__dd_dispatch_request(struct=
 deadline_data *dd,=0A=
>  static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)=
=0A=
>  {=0A=
>  	struct deadline_data *dd =3D hctx->queue->elevator->elevator_data;=0A=
> -	struct request *rq;=0A=
> +	const unsigned long now =3D jiffies;=0A=
> +	struct request *rq =3D NULL;=0A=
>  	enum dd_prio prio;=0A=
>  =0A=
>  	spin_lock(&dd->lock);=0A=
=0A=
Nit: Add a blank line here to have the spin_lock() stand out ?=0A=
Easier to notice it that way...=0A=
=0A=
> +	rq =3D dd_dispatch_aged_requests(dd, now);=0A=
> +	if (rq)=0A=
> +		goto unlock;=0A=
> +=0A=
> +	/*=0A=
> +	 * Next, dispatch requests in priority order. Ignore lower priority=0A=
> +	 * requests if any higher priority requests are pending.=0A=
> +	 */=0A=
>  	for (prio =3D 0; prio <=3D DD_PRIO_MAX; prio++) {=0A=
> -		rq =3D __dd_dispatch_request(dd, &dd->per_prio[prio]);=0A=
> -		if (rq)=0A=
> +		rq =3D __dd_dispatch_request(dd, &dd->per_prio[prio], now);=0A=
> +		if (rq || dd_queued(dd, prio))=0A=
>  			break;=0A=
>  	}=0A=
> +=0A=
> +unlock:=0A=
>  	spin_unlock(&dd->lock);=0A=
>  =0A=
>  	return rq;=0A=
> @@ -573,6 +637,7 @@ static int dd_init_sched(struct request_queue *q, str=
uct elevator_type *e)=0A=
>  	dd->front_merges =3D 1;=0A=
>  	dd->last_dir =3D DD_WRITE;=0A=
>  	dd->fifo_batch =3D fifo_batch;=0A=
> +	dd->aging_expire =3D aging_expire;=0A=
>  	spin_lock_init(&dd->lock);=0A=
>  	spin_lock_init(&dd->zone_lock);=0A=
>  =0A=
> @@ -796,6 +861,7 @@ static ssize_t __FUNC(struct elevator_queue *e, char =
*page)		\=0A=
>  #define SHOW_JIFFIES(__FUNC, __VAR) SHOW_INT(__FUNC, jiffies_to_msecs(__=
VAR))=0A=
>  SHOW_JIFFIES(deadline_read_expire_show, dd->fifo_expire[DD_READ]);=0A=
>  SHOW_JIFFIES(deadline_write_expire_show, dd->fifo_expire[DD_WRITE]);=0A=
> +SHOW_JIFFIES(deadline_aging_expire_show, dd->aging_expire);=0A=
>  SHOW_INT(deadline_writes_starved_show, dd->writes_starved);=0A=
>  SHOW_INT(deadline_front_merges_show, dd->front_merges);=0A=
>  SHOW_INT(deadline_async_depth_show, dd->front_merges);=0A=
> @@ -825,6 +891,7 @@ static ssize_t __FUNC(struct elevator_queue *e, const=
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
>  STORE_INT(deadline_async_depth_store, &dd->front_merges, 1, INT_MAX);=0A=
> @@ -843,6 +910,7 @@ static struct elv_fs_entry deadline_attrs[] =3D {=0A=
>  	DD_ATTR(front_merges),=0A=
>  	DD_ATTR(async_depth),=0A=
>  	DD_ATTR(fifo_batch),=0A=
> +	DD_ATTR(aging_expire),=0A=
>  	__ATTR_NULL=0A=
>  };=0A=
>  =0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
