Return-Path: <SRS0=5EYj=43=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60809C10DCE
	for <linux-block@archiver.kernel.org>; Tue, 10 Mar 2020 06:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AF792071B
	for <linux-block@archiver.kernel.org>; Tue, 10 Mar 2020 06:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ok0WB9V9";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="VyFM2c6G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgCJGAK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Mar 2020 02:00:10 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:23216 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgCJGAK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Mar 2020 02:00:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1583820009; x=1615356009;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=OIz2ABeO9OAD6u1sqZJIASE+jS7ubcc3oan9OPG3NAM=;
  b=Ok0WB9V9axd3zz+uUZjgxNKrheo7VVS9HWqnXHjyhRGXJbqoEr94BUua
   2EQB9+VBUdw2iQFwI2KaYjn9GkTFzAfvayH5t3Yf2tLSALJevBUHUOVLr
   gQCRCDjcuTzXxgLdtqkKT4wvZtni7X/mB7bu9qC6qwBtNYeD+50VPu5yz
   TE6BRUaafdkA/N/lFdAM1SYJKZS+FuZgjbnmbZDrbZ9Pg+MFU3RJcsNkL
   ySHx7f/0CC2NMDEwBfTlc3hEz/42NQUNTh95thpzTYfbb/Ou2jxpH+IuC
   hIVs+mdcCbkFn8XjpWx0UeekQgSD+Q2BqBAuhwJeE6gOlrad9LNsHffPQ
   w==;
IronPort-SDR: 7clDsPDPd2wuZFptJYEqBB1RjWA84FiJjW63+lXT+OO8CTBEQxJfHkFa/OPC+9u0ggBL17XCLx
 go5eM0LC2F+Rz7C/5X3AI3tfIhkvyJBnQueTwXNXiSu0IdEOZh2/lSiDud/tCDi9g/rRthsJfw
 nCYwCBJ42n0yobh+g7wE9SjayXCghmwODcRQViY/3yF9Y/8Z6vN7vhHhNhNvY/0mFS6bt5Oh38
 4aossXBEpqEduH4jKhUC1yQaKyMSkwSyOuFS4k6WczrdrZPYKbBit3IAmnipo1RqJefMZM4PvN
 4Gc=
X-IronPort-AV: E=Sophos;i="5.70,535,1574092800"; 
   d="scan'208";a="240303479"
Received: from mail-sn1nam02lp2055.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.55])
  by ob1.hgst.iphmx.com with ESMTP; 10 Mar 2020 14:00:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iYw65sXuEKnXeN70JozM7zqYgZyNaZL9np2FTsIlE5Mg1CxI6nPHkl+OY8C+c/7O3i0MMOop1HpWTI6DhYk+us3lBiscbHi3vA9iznqiJ0ce4OXzWo/Pe8wtsocsPM7gSL0PN/pMcKrb02hC7Ie+0fVLuEhbi9b5tTXHlUJhc3x8ra3ci8fADodMIOCG9yug/NF48AVe4C1SJeZHRmlZINptVVwzn0HJNwnpQ3b3NdgLjB9X9ugwabEWaUbuHpFLlh6m96Ydq2zWY3wd6H6+xPHAWyZZGFs7JbssRqtzU2jGZyaErBjJbeqdA00aZihQIbhooxVhK1TLsxqcAKed3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JkmSTQlnVKqgTNLCGbrd4fNCFBo7x+h/3hxVKysbbK8=;
 b=a5XEM1kPk7q1kXn1czQhpKkdO55HEb5Va+53kAH+8kHmTxyCslYjll+fowhHLK/XZ/oU6t00nQ0rFVrsgXRmywgPBK/01gxt9+IXCr9AiE9megcSUfftDtSAyEGxxgIoflfWUD5M0NQ5bDOvTutJoMIbb1PgH3U8fXe/wY/FBpURHRdrp/XfrI9nN23QkjPkt9r/knSclrW7JJU491Z9WVTxZ2CCKv0tUEiP/0i9rklStbIQvQ6OhqfrESBQKzE6+mA2pxt4kFw6EwPiloeCcMZQhn8CGNJ/MWdYJiWLGK73wOUYuPXmRJ8ikAjGxU4RkffAILGSzRRCHi7S47ddHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JkmSTQlnVKqgTNLCGbrd4fNCFBo7x+h/3hxVKysbbK8=;
 b=VyFM2c6GWVgRtLy3KlI7sMXmqvz+ZlkjGux5B48AoEwXafyMm8XxQWaefJweGt104xBvVEhQrvg+NmTZ6oNvJx7Gc8ak/tJ3gbuYZYwQaZPAMjVNxo4dY4PKtfAn8N+p+p1w+CkyzRmbB+1sse3BjGfDGyxshAVnIVtPdJH9Klc=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (2603:10b6:a03:10e::16)
 by BYAPR04MB4742.namprd04.prod.outlook.com (2603:10b6:a03:5f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Tue, 10 Mar
 2020 06:00:07 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::6daf:1b7c:1a61:8cb2]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::6daf:1b7c:1a61:8cb2%6]) with mapi id 15.20.2793.013; Tue, 10 Mar 2020
 06:00:06 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
CC:     Ming Lei <ming.lei@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: commit 01e99aeca397 causes longer runtime of block/004
Thread-Topic: commit 01e99aeca397 causes longer runtime of block/004
Thread-Index: AQHV8c4FlOkNXDceTU6Nwl3i3vnr/A==
Date:   Tue, 10 Mar 2020 06:00:06 +0000
Message-ID: <BYAPR04MB5816B51DA078EBCECC08D019E7FF0@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20200304095344.GA10390@ming.t460p>
 <20200305011900.2rtgtmclovmr2fbw@shindev.dhcp.fujisawa.hgst.com>
 <20200305024808.GA26733@ming.t460p>
 <20200306060622.t2jl7qkzvkwvvcbx@shindev.dhcp.fujisawa.hgst.com>
 <20200306081309.GA29683@ming.t460p>
 <20200307010222.gtrwivafqe2254i6@shindev.dhcp.fujisawa.hgst.com>
 <20200307041343.GB20579@ming.t460p>
 <20200309000715.sqgsssrauzmmpli2@shindev.dhcp.fujisawa.hgst.com>
 <20200309161430.GA4871@ming.t460p>
 <BYAPR04MB5816C428F1E23B1030579887E7FF0@BYAPR04MB5816.namprd04.prod.outlook.com>
 <20200310055417.o3jghx4sl5xtztci@shindev.dhcp.fujisawa.hgst.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [2400:2411:43c0:6000:9183:2c1d:9c5e:d831]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 63b0d94c-6fe0-4dab-9d0c-08d7c4b8489d
x-ms-traffictypediagnostic: BYAPR04MB4742:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB47424597D0A1C1B4ACE3D72CE7FF0@BYAPR04MB4742.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 033857D0BD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(396003)(136003)(366004)(39860400002)(346002)(189003)(199004)(54906003)(316002)(52536014)(86362001)(9686003)(6862004)(71200400001)(55016002)(4326008)(966005)(66476007)(66556008)(5660300002)(7696005)(6506007)(76116006)(66446008)(478600001)(2906002)(66946007)(6636002)(186003)(33656002)(8676002)(8936002)(53546011)(81156014)(81166006)(64756008)(148743002)(60764002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4742;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SMMpaim1BFELL+6xbjzM9dhEwr0fO3SXAHnBFvBLJL39KX1ogy0IcKZFusVzLtvWrgF8jKSVGlqU3X5+hyoLRrdo1n2asvQ5H+iWzTsq04MzYlv1oqDhWlCH5k3h1CLPQUCMsLY+BdApUwisWo0VcsHgF4fH6+q2PRMcAqgm/UTd1DPiWxHXmU8hdBzRS3apBYzXcS7yRZTdNzRq3n0r9NmfeeG0OORxY+31V23Do2fVuPKikDaWXDNMSEHYptHEU1VxG4SAIqY6TpTrdhTf0aLuwtgvZ86u/qP90qgicp4pfk4d2unUdKGE5mKFFAhKaGV2wskElxMLw1U4bYIGe+AT4meEZKlgagPkgVfjce0McIVctd+tRDxbrOR4FXY5fX29nuumjH2rQMTSPBcXfHnYPmuvrsYGYafNSagwdCCyZp7r/Vq0dwYQTWIMtEaS4/KW5EqtfcLgdD2uIJoz6pxMgq4YEvzGE/uqHrHPlNQ1llUYR4d7+d8bqYJinA+tE5ddxP5oXm6QV3NAT19MMXgLEI+Y9VvW+k5j04w9gOp6vg1nyorJEgS92IQ0olFKPWNW9v9FgKQoclq/WsfB+WUpp+t0WGm/EX2rl3puq6I=
x-ms-exchange-antispam-messagedata: VjRBe4nzQflhFUPA+o84DP1Iv1kcXfE1mbOrzr6KBgHz12ZiufGgtM5aqQWsQ1BQ9cMFlkJQrKj7puqvDdgsY8cby5Oa/CYW9S0wZFRTV+fBjnXCXOeQ+Hg+h8tum9Ew1+bZsvISntWKC3ptCePnIoXZFUC/vZ94XhCth3fbM3K6q6Y6smbbASm2pGpqCrX3fNFPBtyn8ixTOh9LMkREGA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63b0d94c-6fe0-4dab-9d0c-08d7c4b8489d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2020 06:00:06.5771
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f7iE+uQm8Lmi3p2aw1dfgYOnRBEJiwFOq0XNhFt2/RqBuUWBhA64+FyaCJzEipJ75yJNCS5v+9EN7rKsm3ZVtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4742
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/03/10 14:54, Shinichiro Kawasaki wrote:=0A=
[...]=0A=
>>> Yeah, I got the log, and it has been put in the following link:=0A=
>>>=0A=
>>> http://people.redhat.com/minlei/tests/logs/blktests_block_004_perf_degr=
ade.tar.gz=0A=
>>>=0A=
>>> Also I have run some analysis, and block/004 basically call pwrite() &=
=0A=
>>> fsync() in each job.=0A=
>>>=0A=
>>> 1) v5.6-rc kernel=0A=
>>> - write rq average latency: 0.091s =0A=
>>> - flush rq average latency: 0.018s=0A=
>>> - average issue times of write request: 1.978  //how many trace_block_r=
q_issue() is called for one rq=0A=
>>> - average issue times of flush request: 1.052=0A=
>>>=0A=
>>> 2) v5.6-rc patched kernel=0A=
>>> - write rq average latency: 0.031=0A=
>>> - flush rq average latency: 0.035=0A=
>>> - average issue times of write request: 1.466=0A=
>>> - average issue times of flush request: 1.610=0A=
>>>=0A=
>>>=0A=
>>> block/004 starts 64 jobs and AHCI's queue can become saturated easily,=
=0A=
>>> then BLK_MQ_S_SCHED_RESTART should be set, so write request in dispatch=
=0A=
>>> queue can only move on after one request is completed.=0A=
>>>=0A=
>>> Looks the flush request takes shorter time than normal write IO.=0A=
>>> If flush request is added to front of dispatch queue, the next normal=
=0A=
>>> write IO could be queued to lld quicker than adding to tail of dispatch=
=0A=
>>> queue.=0A=
>>> trace_block_rq_issue() is called more than one time is because of=0A=
>>> AHCI or the drive's implementation. It usually means that=0A=
>>> host->hostt->queuecommand() fails for several times when queuing one=0A=
>>> single request. For AHCI, I understand it shouldn't fail normally given=
=0A=
>>> we guarantee that the actual queue depth is <=3D either LUN or host's=
=0A=
>>> queue depth. Maybe it depends on your SMR's implementation about handli=
ng=0A=
>>> flush/write IO. Could you check why .queuecommand() fails in block/004?=
=0A=
> =0A=
> I put some debug prints and confirmed that the .queuecommand function is=
=0A=
> ata_scsi_queuecmd() and it returns SCSI_MLQUEUE_DEVICE_BUSY because=0A=
> ata_std_qc_defer() returns ATA_DEFER_LINK. The comment of ata_std_qc_defe=
r()=0A=
> notes that "Non-NCQ commands cannot run with any other command, NCQ or no=
t.  As=0A=
> upper layer only knows the queue depth, we are responsible for maintainin=
g=0A=
> exclusion.  This function checks whether a new command @qc can be issued.=
" Then=0A=
> I guess .queuecommand() fails because is that Non-NCQ flush command and N=
CQ=0A=
> write command are waiting the completion each other.=0A=
> =0A=
>>=0A=
>> Indeed, that is weird that queuecommand fails. There is nothing SMR spec=
ific in=0A=
>> the AHCI code beside disk probe checks. So write & flush handling does n=
ot=0A=
>> differ between SMR and regular disks. The same applies to the drive side=
. write=0A=
>> and flush commands are the normal commands, no change at all. The only=
=0A=
>> difference being the sequential write constraint which the drive honors =
by not=0A=
>> executing the queued write command out of order. But there are no constr=
aint for=0A=
>> flush on SMR, so we get whatever the drive does, that is, totally drive =
dependent.=0A=
>>=0A=
>> I wonder if the issue may be with the particular AHCI chipset used for t=
his test.=0A=
>>=0A=
>>>=0A=
>>> Also can you provide queue flags via the following command?=0A=
>>>=0A=
>>> 	cat /sys/kernel/debug/block/sdN/state=0A=
> =0A=
> The state sysfs attribute was as follows:=0A=
> =0A=
> SAME_COMP|IO_STAT|ADD_RANDOM|INIT_DONE|WC|STATS|REGISTERED|SCSI_PASSTHROU=
GH|26=0A=
> =0A=
> It didn't change before and after the block/004 run.=0A=
> =0A=
> =0A=
>>>=0A=
>>> I understand flush request should be slower than normal write, however=
=0A=
>>> looks not true in this hardware.=0A=
>>=0A=
>> Probably due to the fact that since the writes are sequential, there is =
a lot of=0A=
>> drive internal optimization that can be done to minimize the cost of flu=
sh=0A=
>> (internal data streaming from cache to media, media-cache use, etc) That=
 is true=0A=
>> for regular disks too. And all of this is highly dependent on the hardwa=
re=0A=
>> implementation.=0A=
> =0A=
> This discussion tempted me to take closer look in the traces. And I notic=
ed that=0A=
> number of flush commands issued is different with and without the patch.=
=0A=
> =0A=
>                         | without patch | with patch=0A=
> ------------------------+---------------+------------=0A=
> block_getrq: rwbs=3DFWS   |      32640    |   32640=0A=
> block_rq_issue: rwbs=3DFF |      32101    |    7593=0A=
> =0A=
> Without the patch, flush command is issued between two write commands. Wi=
th the=0A=
> patch, some write commands are executed without flush between them.=0A=
> =0A=
> I wonder how the requeue list position of flush command (head vs tail) ch=
anges=0A=
> the number of flush commands to issue.=0A=
> =0A=
> Another weird thing is number of block_getrq traces of flush (rwds=3DFWS)=
. It=0A=
> doubles number of writes (256 * 64 =3D 16320). I will chase this further.=
=0A=
> =0A=
> =0A=
>> Shinichiro,=0A=
>>=0A=
>> It may be worth trying the same run with & without Ming's patch on a mac=
hine=0A=
>> with a different chipset...=0A=
> =0A=
> Thanks for the advice. So far, I observer the long block/004 runtime on t=
wo=0A=
> systems. One with Intel C220 Series SATA controller, and the other with I=
ntel=0A=
> 200 Series PCH SATA controller. I will try to find other SATA controller.=
=0A=
=0A=
I do not think it is necessary. I forgot that flush cache is a non-ncq comm=
and.=0A=
That is why queuecommand fails as you found out: it is waiting for all NCQ=
=0A=
commands to complete first. Nothing to do with the chipset type. This is pe=
r ATA=0A=
specs.=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
