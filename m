Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31AF0C47089
	for <linux-block@archiver.kernel.org>; Fri, 28 May 2021 01:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 039AB613B5
	for <linux-block@archiver.kernel.org>; Fri, 28 May 2021 01:40:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbhE1Blm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 May 2021 21:41:42 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:13334 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbhE1Blm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 May 2021 21:41:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1622166012; x=1653702012;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Zf2wHhYW+5KKWu0vyat7pXJ91slDr+CjzdUVnigx2qs=;
  b=iFO7uVPFVX12y+d20sXJChhejCGh69/efHo9t1Yo/n+jK3ofSpbVrb8p
   grL3XQRZzHcA5dH+LVPohD2PRKDRu2QdiB2Mtqi4nYFbU0JJWRDNLSPN3
   ikY9B31w6WpHaMAJ+LItm3P+htiMCCurKs7bheIrWpayoPL2QO4FZMJtN
   ttma1ykxdXz0iPKvcuOU1TCPKN9efIgggiKmffY7hxriNuPDEh0aAXcDf
   JE3eXiVsml4QONDXwzN4I2yhMieeyJFYqDi4YrbQ3mbZ0+v9jKl1Y5bdp
   7EMgWzrR71l/cQOKu211pgJFs2rccuezSiUoZPMQJsvfMYdFays9OyUYo
   A==;
IronPort-SDR: j4K0Y2hH+TTy1AZkaoyLk3vHvvu/5I3Bc7SkHveQbFXg8GEYE6UA6Efi7umH7h/nopDOvUOiaN
 gAB0reRlma0Clr8ZPcCLwPPZwzs1krslwuFIkMbaKRvleol9C2AWqBFpWwjJCmvfxOzO5psbee
 HQvLlG4bldzVfUtcPsG+Q3+v5najgMxeXNziQeYdSxk0Y45NKeDvnBzx/Xg2pMAS7FqpaO38C/
 t0+1lX4bE4GeYHFn55N8raOYlHu6NygWWAxSki4ZQfpnTTu4f1PkbDW6VIhERvr5DYJC+dRoOK
 TeI=
X-IronPort-AV: E=Sophos;i="5.83,228,1616428800"; 
   d="scan'208";a="273650575"
Received: from mail-mw2nam12lp2045.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.45])
  by ob1.hgst.iphmx.com with ESMTP; 28 May 2021 09:40:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kYxMB8WYOJxCQ8D7k7YmNCVPGu+vtm5btkfogpzQE0cvKNQJtmEaALGUJ4mFSQJBHYb2OZRTWj4TfRl5MFUy8JiMMg/4Td1mdkeq2C404EFY03HeiVWar0iWqrwUYcjnfq2jDfHJdRdUoCwzhpXjQVasWaJiiHpbxiLvFCoICmrM/NeVuxvc4UFu3mDthFTFmedPtbEgk8OeWQJ2KsABEPalIBK+3I08MbOGjMI/iaE69quk4FMuVznfymYIp/EeQD9YBR/QkQrYae5mU9onIJcLVWGO7wxakvcaq3CSxImDynNoqmi1CYeFjFGwf10tkXMb/kU1eTGewgzkJX1Brw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1PZHU3KxGOe89p9+NEFeFbFEL+lznQ2I55QoftwbKZY=;
 b=GclmGePN5BMdHRSj+r05TrDBNa4CYWpUpRU/23WJOLvUF7HjbiSRErakiytkgTUvKXo8aS2JGfGj3MQuRTarN31grGcKRbXNCQuMjS9M8/wDYM0Fa+FBmlRblXxsJUCLnHmRnlrwTQ7sEPN6OkM5WHl0ZHAdliNX2+JPQubrJflMlZPu+/1kA8Y9TA3kY9hiese3uK2wxMRp1zNjDGS2aPGhbNHbJgs+4Q3HMsbIDfSD4+pWQ0iv5pVSXY8V1w2/l3sLHseOA+xsxF/u6nKGlQYX7xnlD3DZRJO7BLB+t437GxW5XMxiObc/i7sG7+SycKi8VkDyNLvVJ4h7yzwGxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1PZHU3KxGOe89p9+NEFeFbFEL+lznQ2I55QoftwbKZY=;
 b=gVZktpv6XChdxl7R+iNs57nJLWSvlFq8AOxFGIxVNlOziraxxi9GdNJ1SbLKJ6uvvnKxls0mxP4pQMzUYjQkPY6/cKq9/+olLKZpF/ITVPPU53r8REheHYJ7ZNfEFNw+/jgCQc+K06yLZM4oID5zr0rI8OHB8AAMkV3oOcsjbkQ=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM6PR04MB4538.namprd04.prod.outlook.com (2603:10b6:5:21::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Fri, 28 May
 2021 01:40:06 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806%9]) with mapi id 15.20.4173.020; Fri, 28 May 2021
 01:40:06 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adam Manzanares <Adam.Manzanares@wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 8/9] block/mq-deadline: Add I/O priority support
Thread-Topic: [PATCH 8/9] block/mq-deadline: Add I/O priority support
Thread-Index: AQHXUpPol9EPE/uoT0Or8KEh4kLpzg==
Date:   Fri, 28 May 2021 01:40:06 +0000
Message-ID: <DM6PR04MB70812213394946208B8D60C3E7229@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20210527010134.32448-1-bvanassche@acm.org>
 <20210527010134.32448-9-bvanassche@acm.org>
 <807decf3-b269-e663-f3db-394b74f1da00@suse.de>
 <337d6b15-4549-ec6e-a504-7b7d041d0077@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:4140:5e35:28b2:297]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 55b5a36d-1a98-4a26-f84b-08d92179857e
x-ms-traffictypediagnostic: DM6PR04MB4538:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB45381329893C2A5E860B4722E7229@DM6PR04MB4538.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tNmZA8CuVOS7/HET/fXwvoOQWvJNiI7EqZiAUgqnTJbRrmHfYj4apunTJN5cIG3eZ3L72ujPq74cVt1YChGkLPuo7kD5xBDjudTyC/IGHsBRmLCYsP1JEviXJ0nCvJWyeyk6U4UvEszixIKuEuArg59wXwkBJTT/nUwLmzdrT6jkM3MNykMTrtAHLdy0ti7DSu4WwOFmJU2wsABNX7mmMTUMuDhkPrOgwsAN0+/PUhHmpWd9fFwOcv6f5NdIuJDlIQGjp804ObKSsMsCvVL5IuXi1EgSWsb1TTEJQKSWwSCguT7HUfS8mGBFxNSw+rGaXKobtlhMSy+uDRoW+GjLe/wfbsF4ZfmTtSikrJoxnwdMgnRGWDDGTpcdhoJyPYiDC0nP7yJahIPUZTWCscqOJt9//LR6x+JWOzhWvCmhSQjdTN9AU7QE2NN/9ZhH9UjRtfKTr3HmNp2yE+ZRLrd1z1lyxfHOZsu/PJqjFD4/1XlVxY0G7UA0Ek2Krsp2YXa4FnKqzmWx9LOT6lV1R/M3pA+BqYbuy8ArTLNwL8pOaiez+sFjCte2AfS5Zd5Yya6bJOL1ySidYt650rRKVtPU0RTKTJEncB+b8sn0a86e0mhuwE1uJqu0FLD6IvCgH/YY3BaJ0LjEfOTyKSdnW6EkHjp3hXOHdLvXnhyh/RRvQR62zYQFNb/GJAdnfmLY2GBu9NJeRr7m1/Cx0IY/Bn6zouvP9Xx9lGtd/tWfto5PPAo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(366004)(136003)(396003)(4326008)(9686003)(33656002)(2906002)(83380400001)(8936002)(5660300002)(52536014)(966005)(7696005)(478600001)(55016002)(316002)(186003)(54906003)(110136005)(86362001)(122000001)(8676002)(38100700002)(66946007)(91956017)(71200400001)(76116006)(66556008)(53546011)(6506007)(64756008)(66446008)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?R59RpIUJsstslFytNymaEpHV5jeZ0iO8v/5NfqHCaHNtKOemqdn5XOGZUeYZ?=
 =?us-ascii?Q?goRay8ae2Nxu/ZFkNIj1+3cFvZCMAmspIYR7PB7VZZk9/MC7R8ellkHM1s66?=
 =?us-ascii?Q?gqeGVOl5qUfUKt/s00b+t967pfdpj78vqjCkj4QMM2EndreHaKsCwUi1Uz/w?=
 =?us-ascii?Q?DRhjZthuertb+K65xnKRYFjjM0MMi48OwOj1+NG+flOMIqbpcZ9TA3vKw11B?=
 =?us-ascii?Q?ZXqXQiVCQnZoyg421bCBpTRxtc06p1IoV+Z9KRMhaHpdL2fS5XqtCMgzoXzK?=
 =?us-ascii?Q?2uSz2yZ6Ooc8CGfzyPvkoIOb8LgGKoLiTnkWP/1zSPQ7ZL/aIBwE7c1Fl2Hk?=
 =?us-ascii?Q?1xmI6DNqYzMpJxQOxwA9fEXIiPv6sGfquxcf5a1VRSRZqwt3AESaFILlD+As?=
 =?us-ascii?Q?MW6d4XfAKY3XwHqXQZWW4spmwpFWA4XmCge3ILEe2rLYN69Vi9kcDI7K3CDP?=
 =?us-ascii?Q?dPVkcJOQttqDXviCZeqTH5i/uLLikIDZbQJWMSJK9mVCDi3Zcp4V8l93263J?=
 =?us-ascii?Q?NAq8rMSRhdUzpqSbLLEoe9j6exLhFnOBKTfNeAfsEFkVUHtn+AlPfD0Cm3X2?=
 =?us-ascii?Q?Z+Q6bT655BVsg+HwySNCBLjPZKcG6JhbK2HXgWVlOudGlCe5gu2+odR0hNuu?=
 =?us-ascii?Q?phTP20uyZkq2hI1Xwuz5ciPLvd3ms7yBELEQh1BpKA6YXessKUOlshXuLpoM?=
 =?us-ascii?Q?jnb5ijp42kJ87aVUyEY61hxAnNH/lY+44Rz/hljReNtEaAg0Ve15tXLWpxCj?=
 =?us-ascii?Q?bEx3aRE+Kg/nGWErEpfBHUBziWctmMQR9M9bPNC8Fe6tMgg0x7fJIs8sFui+?=
 =?us-ascii?Q?6pvM52ltG0wRf/sQ4I/9sSpaAQ/dhh+xRfPoZ9WwPuVCFH/QPgMtNdO69n3P?=
 =?us-ascii?Q?rZzDvXj/oAdaJAxFfE0yx38Ql/SWgUYkgdhUIIXHqjd+6FqeX4eff1AEs6Gi?=
 =?us-ascii?Q?G25r8ktdTtfhTO5YwdVpouxJkTGKodhe79V1hsOOLGIA+oY+M8o+47IgjiQf?=
 =?us-ascii?Q?zcJl0zaiMn8nEdDiZQkjJRPrPZqQEPMhVRY2cB5XD6X/roJTs4UaJzJsDWVt?=
 =?us-ascii?Q?yrpM3dzSlwm2U6hkKXZUv7X5rJv90gnthZaVLUzCjiSfH5cy/znhAtxBH4WG?=
 =?us-ascii?Q?iTxLAXqMKydks4CHlqj0lThK/ZVpJEqzk/X6q3WK3mYPpSvY9Mlw+eF7NO9c?=
 =?us-ascii?Q?y8a3ifryak78t/pUTa6+OXh6rJz+1x/04rOSO+33pDVK1Q7MGVph3Vp+Or6j?=
 =?us-ascii?Q?D7oMFkhyDYnGWbjmSjk/D2vPUervt7wGlFjK5kCyypw1Wi4zXlKd/1CION6K?=
 =?us-ascii?Q?48A3Px+3GHC8bZ8E54rFSngEp3E6p5GCxnYzzTWQxk7BYYV8nHyrc3GE30kJ?=
 =?us-ascii?Q?LaDqSMLRtCWmkgwRdI3va0J51K/nNS4JvXj0HXQMKRARHDOD8A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55b5a36d-1a98-4a26-f84b-08d92179857e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2021 01:40:06.3070
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hfFaRRy7sBAZ1krGLTE1/SoJTKziYxh6XEz05ifjoXh2jt2QxDM6RUwtjGARx69r+J9mCivGLijOx+vlz1G9Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4538
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/05/28 5:23, Bart Van Assche wrote:=0A=
> On 5/27/21 12:07 AM, Hannes Reinecke wrote:=0A=
>> On 5/27/21 3:01 AM, Bart Van Assche wrote:=0A=
>>> Maintain one FIFO list per I/O priority: RT, BE and IDLE. Only dispatch=
=0A=
>>> requests for a lower priority after all higher priority requests have=
=0A=
>>> finished. Maintain statistics for each priority level. Split the debugf=
s=0A=
>>> attributes per priority level as follows:=0A=
>>>=0A=
>>> $ ls /sys/kernel/debug/block/.../sched/=0A=
>>> async_depth  dispatch2        read_next_rq      write2_fifo_list=0A=
>>> batching     read0_fifo_list  starved           write_next_rq=0A=
>>> dispatch0    read1_fifo_list  write0_fifo_list=0A=
>>> dispatch1    read2_fifo_list  write1_fifo_list=0A=
>>=0A=
>> Interesting question, though, wrt to request merging and realtime=0A=
>> priority: what takes priority?=0A=
>> Is the realtime priority more important than request merging?=0A=
> =0A=
> We plan to use two I/O priorities: one for foreground applications and=0A=
> one for background applications. We want to lower the application=0A=
> startup time if background I/O is ongoing. The code that associates=0A=
> different cgroups with foreground and background applications is already=
=0A=
> available. We care more about foreground I/O being prioritized over=0A=
> background I/O than about foreground I/O being real-time.=0A=
> =0A=
>> And also the ioprio document states that there are 8 levels of class=0A=
>> data, determining how much time each class should spend on disk access.=
=0A=
>> Have these been taken into consideration?=0A=
> =0A=
> My understanding is that the ioprio document was written before any I/O=
=0A=
> controllers implemented I/O priorities. I'm not sure whether I/O=0A=
> controllers will ever implement more than two I/O priorities. See also=0A=
> commit 8e061784b51e ("ata: Enabling ATA Command Priorities"). A paper=0A=
> about the benefits of I/O controllers supporting I/O priorities is=0A=
> available at=0A=
> https://www.usenix.org/system/files/conference/hotstorage17/hotstorage17-=
paper-manzanares.pdf.=0A=
=0A=
ATA NCQ has only 2 bits, defining 3 different priority levels, one of which=
 is=0A=
not really a priority but rather latency limitation. So yes, basically, ATA=
=0A=
supports only high-priority and no-priority. 2 levels only with all prio le=
vels=0A=
of the RT class mapping to the device high-priority level and everything el=
se=0A=
mapping to device no-priority level.=0A=
=0A=
That said, Command Duration Limits has been standardized and I was planning=
 to=0A=
introduce support for it using a new priority class IOPRIO_CLASS_DURATION w=
ith=0A=
the priority level indicating the duration limit to apply to the IOs. In th=
is=0A=
case, differentiation between the different priority levels of that class m=
ay be=0A=
necessary at the scheduler level. I will probably revisit this when I send=
=0A=
command duration limit support.=0A=
=0A=
> =0A=
>>>  /*=0A=
>>>   * deadline_check_fifo returns 0 if there are no expired requests on t=
he fifo,=0A=
>>>   * 1 otherwise. Requires !list_empty(&dd->fifo_list[data_dir])=0A=
>>>   */=0A=
>>>  static inline int deadline_check_fifo(struct deadline_data *dd,=0A=
>>> +				      enum dd_prio prio,=0A=
>>>  				      enum dd_data_dir data_dir)=0A=
>>>  {=0A=
>>> -	struct request *rq =3D rq_entry_fifo(dd->fifo_list[data_dir].next);=
=0A=
>>> +	struct request *rq =3D rq_entry_fifo(dd->fifo_list[prio][data_dir].ne=
xt);=0A=
>>>  =0A=
>>>  	/*=0A=
>>>  	 * rq is expired!=0A=
>>=0A=
>> I am _so_ not a fan of arrays in C.=0A=
>> Can't you make this an accessor and use=0A=
>> dd->fifo_list[prio * 2 + data_dir] ?=0A=
> =0A=
> That's possible, but if the compiler can translate [prio][data_dir] into=
=0A=
> [prio * 2 + data_dir], should I really do this myself instead of letting=
=0A=
> the compiler generate that transformation?=0A=
> =0A=
> Thanks,=0A=
> =0A=
> Bart.=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
