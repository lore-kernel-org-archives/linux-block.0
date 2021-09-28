Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A47C433F5
	for <linux-block@archiver.kernel.org>; Tue, 28 Sep 2021 10:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F0FF60ED6
	for <linux-block@archiver.kernel.org>; Tue, 28 Sep 2021 10:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240242AbhI1Khs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Sep 2021 06:37:48 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:50007 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240237AbhI1Khq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Sep 2021 06:37:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1632825367; x=1664361367;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=bdefvBUWM1D9fxiIGthckV7ISoVqD8TAhF6Ov5pUNrU=;
  b=oQo0aReliffy0RZlovj0czXsGLJyDSAuGEg+AacqJTxBtiF6bEOO3biA
   qgeyKgsLFHJ07hN0Vh9q4vFj1125Q4dMsRPLuwFmco0RYhLuYsBY+KNG+
   Z+XTVsNDLXYCd3H9kus1pEz7Ob+VRACC0dzjk036eY2k+CJCW4S7T7zTx
   wY0RN/NO+6TvUMMQtCELp2cZWPIAFF9EFo8t6qBCLgPidON09cD41WZYl
   pv1MJR1s4QwHwCgsJvixtjvx9cqVGvI/g4bLoLt+ERoG9UczwjJ/A7nfQ
   4VhlzNkOPo12OjbvhknJ9GRA5g6LxRqLlBDT7nwXST+eMcuag5XXFunVV
   w==;
X-IronPort-AV: E=Sophos;i="5.85,329,1624291200"; 
   d="scan'208";a="185959586"
Received: from mail-dm6nam11lp2175.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.175])
  by ob1.hgst.iphmx.com with ESMTP; 28 Sep 2021 18:36:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LwOfYbsNj06tLAy8JpQsgki0B0yXM44GWYxw+J1SkMgzrZzU/DL99HIMHGKN2gUkaM4fVwN91/IAjEkfWf6QeNQqzj/Qhk199/cfoby9bWrwiRtCIvG1KDQfWBZTwXemRRv2a/gjx7P9MBawx27q2J7xLeAO2nNYFUNELE7Hct5XqSXCef2jKglX8s0FcxGo+k3Fn+eKThgKRpifEKXOKNU7tVsm5LUkpEEf8QQFJvA2ffAvfazGfi+LfK77BdscyJPvpM3dEIkO0VkxmUnQXgcjs56JIydpLGat7GODorMGNei/vwXYoMTs0/OhF+xFeDQWnjWBU9+N754EuLjYGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=3vAXAxmXt7qeaBgHTOXhPXBxEYTOw7Soru+jxrjz53E=;
 b=Bby2m6OnQqmeesLG7aejFQ7ZssyhLLnTeiV9EdOteW2lvfpNcjIuoNPhYNdVHDT4W5kV4w6OAeJE8oR1F0vDiSD0OdhF9H41HF+6R0TbC2XgxJCF3/wrzquuAK5ZpLkiUeO4p5/eWJ06LDH6anQmafcHEkEHV2Gpp37aet2R9ZPe+++8T1GMD5mjiMxMnljLrtOm9Hyj4nrMmMfi7IBZLfBrUQECi0nl/08JCQEms3oA1m7fra3mlZUgG+Xg7wTWywEJ75qkcLZA6hG2FlyrtHf/h4SoFazfWmfCboDIK6KP6LKycZPvehJBpUeDqwmVsuHHiZBQI3VW5npRZ6GiBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3vAXAxmXt7qeaBgHTOXhPXBxEYTOw7Soru+jxrjz53E=;
 b=qamqzsGbvFGS96pZMPpCdvSHS+oa++BydYIwTRtRL+kK6s+XlTOBUkDr1uBfLD6AYqoqRkuzFqDjmMDO+IiU1MG/HDCXYw1aXZ+03nsUuiiS5LPycf7bLfMLCT1THAzMlIULOvSjNkT8g+cRLJZpcFD6rHvM6AQFO9wopVSEmK0=
Received: from PH0PR04MB7158.namprd04.prod.outlook.com (2603:10b6:510:8::18)
 by PH0PR04MB7448.namprd04.prod.outlook.com (2603:10b6:510:b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Tue, 28 Sep
 2021 10:36:04 +0000
Received: from PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::3d04:c2fb:e69f:27e8]) by PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::3d04:c2fb:e69f:27e8%6]) with mapi id 15.20.4544.022; Tue, 28 Sep 2021
 10:36:04 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v2 4/4] block/mq-deadline: Prioritize high-priority
 requests
Thread-Topic: [PATCH v2 4/4] block/mq-deadline: Prioritize high-priority
 requests
Thread-Index: AQHXs+uatM/VKmrUakm8WAOr+0LlwKu5QW6A
Date:   Tue, 28 Sep 2021 10:36:04 +0000
Message-ID: <YVLwE9O6Dqz5GxNW@x1-carbon>
References: <20210927220328.1410161-1-bvanassche@acm.org>
 <20210927220328.1410161-5-bvanassche@acm.org>
In-Reply-To: <20210927220328.1410161-5-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 33aa8bf2-afe4-453f-33b8-08d9826bc5ed
x-ms-traffictypediagnostic: PH0PR04MB7448:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB74489897538C609C5224B7C1F2A89@PH0PR04MB7448.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:843;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WDY7c63rkjlXERj6GkcsBMIj8JQpLywaDoASb4tb/8vL4HcgGviM/o3r/RTW71a6jtz05dy2uEPXqG5AyN1zDRUw2nFc7eE27W+lcWlY2hpUAateW7spvBJiDVvDXtcqzANFJPNyhNBsGgsGWEnCCFYBLpkSeGOLWUZVfCvh5LYAhjCklnlwtXC6rRmkxZumBTMWCitDUJ9EFEYUCHKsueXUNarfGUU9htvlAcXCsXl6xey1mG2kLlSj08J6ypYWEtnMfOYAguBM75XgFcGSh30Qrkhbb/ZuO0/Btz/3RhjywUMr87q9qzYths7LDZEIUK0dQ4JP1/sMRZyG1mmL5mjh6e+lqhiP6zCDFRB1fQQTcErXsyDAN/pnqSVMXinGvC6Ej/bFHFjJ+XkFLWIlrc/84vdr1AJW79NhUaoVDWVn6kwEv1h5/HxTNKQcF0GnrAL45eNc5u/RDT3dXAOIBk40dckrrGok4rkO+uvx5Zl0MWf8WvTNy1cY1DnNxXvjywcR5G1pWvh5XQpt0a9z3nluHyH0a5PGlxH/h75OHbtXhSFymK9OPub281t5vXMJKOG2s7co+VZUFP2onqK2jsMXfoXcu9K+vi0S9+d7ZgA+hHmm1X2q4XY4M13FRH18ECPB9fOlU0xJa9IXKNRi3kVcP0jYgxv6YUDkQg33mHHBBFmal1bk5zxOPoD8JHe2PDLYo4OX3I3vJ2Z07AQRgA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7158.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(366004)(66946007)(66476007)(38100700002)(6512007)(4326008)(316002)(54906003)(83380400001)(6506007)(122000001)(71200400001)(508600001)(9686003)(76116006)(91956017)(186003)(33716001)(6916009)(2906002)(26005)(6486002)(66446008)(64756008)(66556008)(8676002)(38070700005)(8936002)(5660300002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CK9/uVtiGynRjL26cQpbQAnV4Tyl02dY6sWrMV2O6438tuQauK28nEfTgRI7?=
 =?us-ascii?Q?Bsk7+71UKOlyMx4wkwGK1QsmYrqiaalUNYlcDMpgYxXIre14m2qC9XlrYYET?=
 =?us-ascii?Q?mKJSpmCBC6OV2JdvCHd05MnftNC6jg3YKXqEc8dKBZCSrcw362OCUU2yoyiP?=
 =?us-ascii?Q?A4uYmTOnBGtoK3C4dHfBb+kjDzTDf674BCy2ltqFOmlED8OEu7ucge1FbtFO?=
 =?us-ascii?Q?xrLFXJ2jdxesOUbd4flIiVHnSCgtDTwr5VJPtz/0JW5v6srXPX7eK7gixoK1?=
 =?us-ascii?Q?QqbPqjDS8cnkWtjYkATA8Zf8UWMUW4hbn6HVBrGBOi41Q6ZI+EvlVes6TQ6D?=
 =?us-ascii?Q?LdUCjyl8oeWL19+P6ydo1ea9SA++MjhD5uPaHeSRK2Z5JFgWQKG0qAJK9s+k?=
 =?us-ascii?Q?xn+QaDiP25UyDU4fIRyk8r6eAKc97KrwHPFar+5jo6fuKGlcyw6W+GeOPrdf?=
 =?us-ascii?Q?wji6FbuPBhjVas8EXKMckoo+efRH1tys3kuz7ZqpWQqTwU57gTpvImSaTgHF?=
 =?us-ascii?Q?BnHT+iTngjh/Eml1LHeSK1WtpLFUisyiJskth3JtLvufPKEbjwrBf28gY/Pn?=
 =?us-ascii?Q?hC/51M5vDiwAb1RL3FlogpuxkyjQ+2kqkCUErH2eXdohGd6yZRz4Hn5p8XiM?=
 =?us-ascii?Q?978VdEdo7zl3IOqyhSRTNq6z/udxrTdXmOIyMCPbwzH1cBRCO7WokyTIionh?=
 =?us-ascii?Q?x/WLb1PaONqP48Hs+Y/D2JLTQVk+X52BSjyuZOFLblwO3V0HnvwZxI2Wofw3?=
 =?us-ascii?Q?m5njjURx1HCJOqk1JQfbX7QOH3i0tIjdqFkIWMYN/wFxqvpVx4xLqIFgJeLU?=
 =?us-ascii?Q?DObUJN2MT06aOe9nti1fprQvg64YNvSUJkooxE3cU9E74faejEd9bL7a1FmP?=
 =?us-ascii?Q?CuxZx5YfyKlCQGGtRBb9S2REZs/R3VzAdSnqg62r6LJYyiyp7SrNmk/UUH0Y?=
 =?us-ascii?Q?lRzYkTbSsSA9SH8tm439bLqDB1Ag4IdQWCUs+Fd1ZYH3SLv10ylsY02I5tyR?=
 =?us-ascii?Q?ANBPU0abpNrc1gtuOZnisAZv3A/QOSDsxZ4u3a/Tk6WVPJ/zloA+PKw+vmsE?=
 =?us-ascii?Q?kLX5jyO61nNtcn8y6LEM/zUVo+r6G/Jqi4SVTL2NVbwy1D5pl50FlGLrPjPT?=
 =?us-ascii?Q?CXcNeaN6dLVAo8sYi7sYl7//OMog5YenzA39qm1e2/huaieqS4lr0D8dY5xU?=
 =?us-ascii?Q?R3bD5bMRgPXj3B5qlQk6Z00HRE1z+u+/Eljj4q0bVhr7tooO5/62ZxUPz7sC?=
 =?us-ascii?Q?QISwDYSwDzbqVoe08E/lx64miipgC5slnyq65/mjSu9R/6JY4knS6q1WZy6T?=
 =?us-ascii?Q?nLXylQM7+binfiRP8gWQl+Ys?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <884CA9BC83D89D42879DCB6061A912FE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7158.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33aa8bf2-afe4-453f-33b8-08d9826bc5ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2021 10:36:04.2149
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /A/h+NBiX1G2wdsFAwS6gd28wwBAziG6LfGsgc/l1lzHXT7FEaQnnskwS+Qsp8jPjTrQyp/QzXBZ6wY+7WXOCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7448
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Sep 27, 2021 at 03:03:28PM -0700, Bart Van Assche wrote:
> In addition to reverting commit 7b05bf771084 ("Revert "block/mq-deadline:
> Prioritize high-priority requests""), this patch uses 'jiffies' instead
> of ktime_get() in the code for aging lower priority requests.

Considering that this is basically a revert of a revert,
except for the ktime_get() to jiffies change, I think that
you should state the reason for this change in the change log.

> Ran the following script:
>=20
> set -e
> scriptdir=3D$(dirname "$0")
> if [ -e /sys/module/scsi_debug ]; then modprobe -r scsi_debug; fi
> modprobe scsi_debug ndelay=3D1000000 max_queue=3D16
> sd=3D''
> while [ -z "$sd" ]; do
>   sd=3D$(basename /sys/bus/pseudo/drivers/scsi_debug/adapter*/host*/targe=
t*/*/block/*)
> done
> echo $((100*1000)) > "/sys/block/$sd/queue/iosched/prio_aging_expire"
> if [ -e /sys/fs/cgroup/io.prio.class ]; then
>   cd /sys/fs/cgroup
>   echo restrict-to-be >io.prio.class
>   echo +io > cgroup.subtree_control
> else
>   cd /sys/fs/cgroup/blkio/
>   echo restrict-to-be >blkio.prio.class
> fi
> echo $$ >cgroup.procs
> mkdir -p hipri
> cd hipri
> if [ -e io.prio.class ]; then
>   echo none-to-rt >io.prio.class
> else
>   echo none-to-rt >blkio.prio.class
> fi
> { "${scriptdir}/max-iops" -a1 -d32 -j1 -e mq-deadline "/dev/$sd" >& ~/low=
-pri.txt & }
> echo $$ >cgroup.procs
> "${scriptdir}/max-iops" -a1 -d32 -j1 -e mq-deadline "/dev/$sd" >& ~/hi-pr=
i.txt
>=20
> Result:
> * 11000 IOPS for the high-priority job
> *    40 IOPS for the low-priority job
>=20
> If the prio aging expiry time is changed from 100s into 0, the IOPS resul=
ts
> change into 6712 and 6796 IOPS.
>=20
> The max-iops script is a script that runs fio with the following argument=
s:
> --bs=3D4K --gtod_reduce=3D1 --ioengine=3Dlibaio --ioscheduler=3D${arg_e} =
--runtime=3D60
> --norandommap --rw=3Dread --thread --buffered=3D0 --numjobs=3D${arg_j}
> --iodepth=3D${arg_d} --iodepth_batch_submit=3D${arg_a}
> --iodepth_batch_complete=3D$((arg_d / 2)) --name=3D${positional_argument_=
1}
> --filename=3D${positional_argument_1}
>=20
> Cc: Damien Le Moal <damien.lemoal@wdc.com>
> Cc: Niklas Cassel <Niklas.Cassel@wdc.com>
> Cc: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---

With an elaborated change log, this looks good to me:

Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>=
