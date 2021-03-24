Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30388C433DB
	for <linux-block@archiver.kernel.org>; Wed, 24 Mar 2021 12:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0271761A06
	for <linux-block@archiver.kernel.org>; Wed, 24 Mar 2021 12:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233465AbhCXMhw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Mar 2021 08:37:52 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:49542 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232813AbhCXMhl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Mar 2021 08:37:41 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12OCOqPY121681;
        Wed, 24 Mar 2021 12:37:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2020-01-29;
 bh=Z6rQO/0thJ+I6KdHfRSu+3rmfPJXPuu2wD0l+krFfB8=;
 b=T4cWpzVYrxNvfEtEN47USl8pK8p5B9SSdY1ySx4om93kg/iWorkNtH8y+1ICTFsKfhtG
 3WBdOcrmPBqAvRHHsdp0WwMpCD76/7aPv2seS2uh8VTc4fWfk3rEwf5PJIEJRGc0GAxw
 LnXm5nLtdkTqoWc7lDpOSEN/BG4xD7SRKAI7VjD8J896c0eeIr67Ou0uojByGrhvqaVx
 lirkjMvyb+XS79CGkPrTOJkt5aqFSwr1sRh+fqF465eHrwR+ZQAF0ZovFzRpqknsaLlH
 1Gzzz67T6iqj7t1MWKE+c543i6Ol8W7vxBsQAmE7/d3mrJBUhKvnTmMdZX7KY+XkqrE8 Yw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 37d8frajtb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Mar 2021 12:37:06 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12OCOqiG157781;
        Wed, 24 Mar 2021 12:37:05 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by userp3030.oracle.com with ESMTP id 37dtyysb3e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Mar 2021 12:37:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c+cpmb+ogXeR8jeXh64NTEVqo8zJ/vktJ6jKV+P5i6FdUbJh6JZbEsKTqVl1L4eYZOc0N00oTNWhBx+0fPF3LHCGMZb0sPeF9/T1duJdkKs6tzheyt5PtCacXeFdZ0znWO30vTYdaTiHZxxt1h3GIqmQII+rKt24eLBaFj/mHS+8YF1jrQy9AUGOQbxlTyUOdVW6QK6oD5fATsbP2m/JMf5Qv4s0WwbKiced79JswXrPj1MoxPJHwDoNXOY0g3V1Dd+L6fxj9DJOFAuyojsKyDeszOhYliuVUPSQuhzxY7V+lp3Do+GEKUQkz+ICM2C0YbG0Tj9vaUda+J0jXMHG5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z6rQO/0thJ+I6KdHfRSu+3rmfPJXPuu2wD0l+krFfB8=;
 b=QL8hqJImlhqT2+kFg/PG39dKYVwCufM/lkuDr9JLzr/ewDmYwrUQdrXbEL/fjbHGZAJ8C9tf53IwuDZSnx0tN5rldUtqpX8UiI7B3pQ9oa1inc1BC6V8VIsK5p9igowW+Px+nIgV/53QTx2xrapuYicteHj0EAxb/MW/S3bEW6CNuuzgvPg0VYc+wHE5VDgReQt3mqOlxSGJ1V45L16SWQ7+1I1j4Tx2lutrjkYAb0NcARSB0xGev8/DtpFoNEcaaSRjiTliWXRyhURQ++vSi0rwmmaabAfPcmAWR/Pvg1KKa6d60dfZtj4zZZwwdEfrvTw8+MDGcYoagumrWbHc9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z6rQO/0thJ+I6KdHfRSu+3rmfPJXPuu2wD0l+krFfB8=;
 b=kM8l3IXts6kRUCr4ou6kmovNSAgxpjVRf/xlJnGg5haXMDLNjRf8okXUH4xsoZIu6uQkdscp3c04mzONEur1SmIVEfrKp7jk8V4xP+5peQ+MCBM+B11TaCxhQzcY1jEYkhMo92Wvw4xXz6r1Cuyrl20KbkKwxIgGHMXc2l7spGE=
Received: from CO1PR10MB4563.namprd10.prod.outlook.com (2603:10b6:303:92::6)
 by MWHPR1001MB2270.namprd10.prod.outlook.com (2603:10b6:301:2e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.23; Wed, 24 Mar
 2021 12:37:03 +0000
Received: from CO1PR10MB4563.namprd10.prod.outlook.com
 ([fe80::c15c:67c1:d5bd:eeb3]) by CO1PR10MB4563.namprd10.prod.outlook.com
 ([fe80::c15c:67c1:d5bd:eeb3%3]) with mapi id 15.20.3977.025; Wed, 24 Mar 2021
 12:37:03 +0000
From:   Gulam Mohamed <gulam.mohamed@oracle.com>
To:     "hch@infradead.org" <hch@infradead.org>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     Junxiao Bi <junxiao.bi@oracle.com>,
        Martin Petersen <martin.petersen@oracle.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Race condition in Kernel
Thread-Topic: Race condition in Kernel
Thread-Index: Adcgp2qLb8M/LezAQRGiUPxNQ9d23Q==
Date:   Wed, 24 Mar 2021 12:37:03 +0000
Message-ID: <CO1PR10MB4563A6404AD789EEF93F995798639@CO1PR10MB4563.namprd10.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [49.204.180.183]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9799f0b1-c7c2-464c-f18e-08d8eec18728
x-ms-traffictypediagnostic: MWHPR1001MB2270:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1001MB2270AA4DA2B70C5F97243EC298639@MWHPR1001MB2270.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CdvcJsJFpBFRYkx1lTdwR6pqIPqgSJzETNP1LM8Hjs/nCQrid2rW91AOnh+Mt5N+ZjiBg9PhqoUS/IFwFsI4Gzp/JdcChs1SxDp/Rg4L4+z0O4rg4eRRzliwdSKReeWSe4Uc1irfCh+6mOrZWT5tKDRIR3DL0UCjF+d3KLrIhrD023xhjq0ReOhYyCQCIOUJq+GtuGvrNSterfvMFnPdaQXjGQlNHtjf6FQj0y265Bz9wEAA8XZ6esOvpTZ+XcUEw1qwmpGJhvnMLsnfjsFmYlB6zc17j3mmpurm6kWY+XPq3r7YupM4347Qs8imbz7XFgqlyW/6QMiMcB70fDlVIJ+5Emp1iez+LCTmZITRZcwgaKC+FMLyGf0HLgDoiKuD9JejssZHCq0dIlVpMy1lX0REnU4r7bsNOn3cosjRCGG/sGxtTd1kCHvj9fBP3u2w1yvnKhoTfqUBzlT9U1Dov4CwWHLX+8aD+j4ZUndrPMHpKDIGUgv1VfQBmiLWPo1cVIIXRsbu9pnp/2E+BMSVhIP9eQjKy3NWrLUwap0tUo2vx1HY1EIZq8nygfwjTMGgYFoYUfFllAvF96dTLPryKPuvNQc+5+G/vCfhopJ25dZzKAVScSIYktL3E3+qDgxTNuITTH9SnCXxfA0eBVf5lPmwgmo99gAg0dhIuSckbhrkGefzA/dpQ0CTZ2w5s645Lht4T8j4zY1PF/qiePcOascP3RhJf0JKeGyTY/V9j3M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4563.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(366004)(346002)(376002)(39860400002)(54906003)(8676002)(66556008)(5660300002)(7696005)(71200400001)(66446008)(64756008)(66476007)(52536014)(4326008)(8936002)(6506007)(33656002)(66946007)(2906002)(76116006)(55016002)(9686003)(186003)(26005)(110136005)(316002)(83380400001)(38100700001)(44832011)(478600001)(966005)(3480700007)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?J9paytB4pwOXy77wGbqWo3djK27Dljm4vJwKQuOuRL+TK0M/yX1y2Z6kMOiD?=
 =?us-ascii?Q?RHVTyOxFu0GSmE/nIORR+9uho/h0zp81aXsyONRP9wYs7UywKXkgRC+Up/CZ?=
 =?us-ascii?Q?0TY5qV4FF848iFnzGgmIY41vm/g1Rn1ke4eScfu7I5QrPYI9mXEwoph7sHzN?=
 =?us-ascii?Q?xFUcIh30w9QuSgPmTONX+zlQBOQoNGiqLkLRCwc2sruMXzIyY8yPTdtN1znV?=
 =?us-ascii?Q?OyhMNRhEn/IN/UdCj3K9RXo6hHGiI/WLvMOM7irDR3MZDlqcVSnez7rk0aoz?=
 =?us-ascii?Q?nKz1Gv2lq0YNEDpfXDlNNHw1Pfa5ZeZi3bL7s9X11aTuNOfayfj/0Ygrp9qi?=
 =?us-ascii?Q?hd1SqGfywgpAk1Qp9xeujhv8raFhEUvZksbzM6Uq685NEVqsrqupxKFfByqw?=
 =?us-ascii?Q?/NV+G0B+c2la6DsYU5J8ZkTJS4tA/QLLd9mi4ZyNCv6IUVxBE8vBS/Jq8wTW?=
 =?us-ascii?Q?/l7p+5UESrWh1LgZn785Mxfe4UNNa+i5gbYHIlWdhgFJmTGGxlJfd65WC4Ri?=
 =?us-ascii?Q?ZqoeG0TH3Pao0hE8vRNDmo40aKWvqFraFZkPRVau4zcBH+dPm2h8dTAVNov9?=
 =?us-ascii?Q?krJIVuEO/GM5WNefUw7erAUyyV4YyuFuS/UJ5zjzv8nwGD9Z+fG5JWwCUGsz?=
 =?us-ascii?Q?USvtd9ZXzwtw8oN+2+plQHczRRvYHKpfBKACOa54aRedy7augeXmEAvvtrcl?=
 =?us-ascii?Q?MQVRyboer9Wk5dQAqNlct4FZSPNfUq5pIDCeDDdaJPxNW/G8213cPwEVhKhq?=
 =?us-ascii?Q?fZHiO4/VSysjlfyJjXAfR93uNFxZxR5ItDFUWzHcmyDkUnsCsjDmpTfyh3Z4?=
 =?us-ascii?Q?acJaiH0MVRAsetF8poqs8WfxHWjOne1EumxSNdYSRuTdCHlHMLWfOsEMX6pY?=
 =?us-ascii?Q?c0EBnpQ/n6TexxGkV6zBXeZGRtyhqOdsf39J2Uy7/SZ8wgNZzuOA2RFicsfo?=
 =?us-ascii?Q?LXvi7F/thhWP44XJkQZwUTqmydTxmYYGwoikmalq6cG/wlvFMuwZaInOHXUR?=
 =?us-ascii?Q?9XzVCojpOeAH3HhTjuZxOijYDHbZrOMMdfoHx8cgPC6W8FAil2n08Haf2J42?=
 =?us-ascii?Q?umN3ImX0wuHRxHsa/kJPk9HIHb6mZsWGNMdb+VqVs972IE5Uf8r2vUggb5FU?=
 =?us-ascii?Q?zp766AabgSl0TztVrObb5vkbMzWYpqm/5iYhva+lB8qK0Dcj7rxD6JLZid9L?=
 =?us-ascii?Q?a40GysG7VaqY92qTBvtO7xuVCAMVeemSsXsXU5aIl15BB7V21TcBGGxlfNvw?=
 =?us-ascii?Q?rAOTXC7IZgmiRHWnv8JEJccfyoxeNKzaZrTyv56g/zHmaO1WB7PQcosH29hd?=
 =?us-ascii?Q?Dio=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4563.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9799f0b1-c7c2-464c-f18e-08d8eec18728
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2021 12:37:03.5376
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3Lk/Nf5npVWdyvInRozu84rmOw1YXzMwWd2CY17rLHlYzuv0fqa18OZSQK6wr5b6aBb5IodgfID4EuYCCdjzL/U5MHN08+IngMf4HfOnCrg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2270
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9932 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=835 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103240096
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9932 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103240096
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi All,

We are facing a stale link (of the device) issue during the iscsi-logout pr=
ocess if we use parted command just before the iscsi logout. Here are the d=
etails:
	 	=20
As part of iscsi logout, the partitions and the disk will be removed. The p=
arted command, used to list the partitions, will open the disk in RW mode w=
hich results in systemd-udevd re-reading the partitions. This will trigger =
the rescan partitions which will also delete and re-add the partitions. So,=
 both iscsi logout processing and the parted (through systemd-udevd) will b=
e involved in add/delete of partitions. In our case, the following sequence=
 of operations happened (the iscsi device is /dev/sdb with partition sdb1):
=09
	1. sdb1 was removed by PARTED
	2. kworker, as part of iscsi logout, couldn't remove sdb1 as it was alread=
y removed by PARTED
	3. sdb1 was added by parted
	4. sdb was NOW removed as part of iscsi logout (the last part of the devic=
e removal after remoing the partitions)

Since the symlink /sys/class/block/sdb1 points to /sys/class/devices/platfo=
rm/hostx/sessionx/targetx:x:x:x/x:x:x:x/block/sdb/sdb1 and since sdb is alr=
eady removed, the symlink /sys/class/block/sdb1 will be orphan and stale. S=
o, this stale link is a result of the race condition in kernel between the =
systemd-udevd and iscsi-logout processing as described above. We are able t=
o reproduce this even with latest upstream kernel.
=09
We have come across a patch from Ming Lei which was created for "avoid to d=
rop & re-add partitions if partitions aren't changed":
https://lore.kernel.org/linux-block/20210216084430.GA23694@lst.de/T/
=09
This patch could resolve our problem of stale link but it just seems to be =
a work-around and not the actual fix for the race. We were looking for help=
 to fix this race in kernel. Do you have any idea how to fix this race cond=
ition?
=09
Following is the script we are using to reproduce the issue:
=09
#!/bin/bash
 =20
dir=3D/sys/class/block
iter_count=3D0
while [ $iter_count -lt 10000000 ]; do
    iscsiadm -m node -T iqn.2016-01.com.example:target1 -p 100.100.242.162:=
3260 -l

    poll_loop=3D0
    while [ ! -e /sys/class/block/sdb1 ]; do
        ls  -i -l /sys/class/block/sd* > /dev/null
        let poll_loop+=3D1
        if [ $poll_loop -gt 1000000 ]; then
            ls  -i -l /sys/class/block/sd* --color
            exit 1
        fi
    done

    ls -i -l /sys/class/block/sd* --color
    mount /dev/sdb1 /mnt
    dd of=3D/mnt/sdb1 if=3D/dev/sdb2 bs=3D1M count=3D100 &
    pid_01=3D$!
    wait $pid_01
    umount -l /mnt &
    pid_02=3D$!
    wait $pid_02

    parted /dev/sdb -s print
    iscsiadm -m node -T iqn.2016-01.com.example:target1 -p 100.100.242.162:=
3260 -u &
    pid_1=3D$!

    iscsiadm -m node -T iqn.2016-01.com.example:target2 -p 100.100.242.162:=
3260 -l &
    pid_2=3D$!

    sleep 1
    ls -i -l /sys/class/block/sd* --color

    for i in `ls  $dir`; do
        if [ ! -e $dir/$i ]; then
            echo "broken link: $dir/$i"
            exit 1
        fi
    done

    parted /dev/sdb -s print
    iscsiadm -m node -T iqn.2016-01.com.example:target2 -p 100.100.242.162:=
3260 -u
    iter_count=3D`expr $iter_count + 1`
done


Regards,
Gulam Mohamed.
