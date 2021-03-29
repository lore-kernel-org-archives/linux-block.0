Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E06DCC433DB
	for <linux-block@archiver.kernel.org>; Mon, 29 Mar 2021 18:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A301B601FD
	for <linux-block@archiver.kernel.org>; Mon, 29 Mar 2021 18:14:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbhC2SNh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 Mar 2021 14:13:37 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48016 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbhC2SNW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Mar 2021 14:13:22 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12TIAJds059388;
        Mon, 29 Mar 2021 18:13:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=RtMIadIyOPeNNzsHPZbvHPOGNSQ00jBpvv3vmhW6is8=;
 b=osL/sINfgtHwYwW8GiY+SJ8/lF/XnJf/qoz+FlT0fbnpvt1agdc2gs8thDdz5BNYuq7T
 G9+rsUQGfm4qi5uWnpT9eNzOxHCaKJBUv4nvddVsptONKc1COb6nUusuNED4p3OEz+XY
 tWOnea8L3gaqh124R7JUifbhXZuA/12xCaIHH3Oi0b28XN6nwqOwdW/sRrK1MbvJWi42
 BR7ZOZCVVqAmgKVYDNy49utm9OMXGotOh5N7j6oL0pWcQg1rK6/seiyMSWQf4I6FqbNL
 gAs5IkGfH8C3XXW8HRjq1rWqlBd+yB8c+l09KTiM8KzKG9EUrshHGhHgZvo2WoNRYrhQ 1A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 37hwbncf93-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Mar 2021 18:13:06 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12TIAYpB131880;
        Mon, 29 Mar 2021 18:13:05 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by userp3020.oracle.com with ESMTP id 37jefr3xaj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Mar 2021 18:13:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fxTvl9sADw0VwTZuPhw2Ato2fb9ExpfmCczWTMmHuQ1s6KmUhVY+l++Je0xFOvG6WfJE/hdJEg0cCxHfjouf+p96DkcgOq3uqy9a5G7thZyKY8qWmMjHz4GrPVVFy1DO23MBbtRK68gBSjC+LAoNlB8LSE4o0uwBCHBpwaBss/m5acPbYPrm9HWEx5F/rsLIh6/WwA8cUlbfoTIzEHgnxg2Da7ijTDkjiAEgjtxT35CjMTJ5ihGcwIE4qBvhjxtxoM2zlVip1yxp8/DXe3s2QNeMRPkU0RRd1GpRtI2A1M+Wgj9yN+VYNPSc1F4VXkurOMVS+H/xJophOi+76jyOPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RtMIadIyOPeNNzsHPZbvHPOGNSQ00jBpvv3vmhW6is8=;
 b=mje/vd5FiYVknc5xRj24p/myLtc6nVN8AhYK/jHZhjrXW9l6nwyjcyDbjeijw51L/555xMBUJ4mqaM3Td1+/v4Dpn9iMmh+jIXs7XYl1CrM6nRUoy6Ijbwdij16y6HJakd9UAz6UfhpGt7ctnY7yWKMv0wpEN7s0I9hR1JplhtStIDY7UehDt+LBIqLVjGzet1FgbjWkW2VU0VaXU1JQ4hfIeW/LJ/6m40hR3KAF3lCmUrVmL4uLp7pi4PUWN+Io4M+Jsd0FnOLPtZWBhfDKQwfoLcIS7ufeedy7ItkKVWicaNJnJ9LXtiGTtqgRDma5R5RJNrY6ppFb0fsmLYR1mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RtMIadIyOPeNNzsHPZbvHPOGNSQ00jBpvv3vmhW6is8=;
 b=ojc/wDXmAUIHZtXSWco1XwHcwoX4eUvLGJX3JrqSNcE8Bxgx9ODTw2BJk3+HE/dXmHsAjnW1qnn33K6vvOTeUTbbDvO8y83JimRFulkjrSMwEMRJPcDBSQ46IaoVxpacPjiQBtzHvh9/yRYIBp2f5VSnpY03I6W7NE4gKA4D1q0=
Authentication-Results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB3794.namprd10.prod.outlook.com (2603:10b6:a03:1b2::30)
 by BY5PR10MB3889.namprd10.prod.outlook.com (2603:10b6:a03:1b1::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.30; Mon, 29 Mar
 2021 18:13:03 +0000
Received: from BY5PR10MB3794.namprd10.prod.outlook.com
 ([fe80::c50b:884f:70dd:c978]) by BY5PR10MB3794.namprd10.prod.outlook.com
 ([fe80::c50b:884f:70dd:c978%5]) with mapi id 15.20.3977.033; Mon, 29 Mar 2021
 18:13:03 +0000
Date:   Mon, 29 Mar 2021 12:13:00 -0600
From:   Tom Saeger <tom.saeger@oracle.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: Re: [PATCH 1/1] block: fix trivial typos in comments
Message-ID: <20210329181300.esmoskhf42xcjstb@brm-x62-17.us.oracle.com>
References: <31acb3239b7ab8989db0c9951e8740050aef0205.1616727528.git.tom.saeger@oracle.com>
 <2831e351-0986-28d5-5eef-53edcf8f41c3@kernel.dk>
 <20210326154519.y2ztm2fqirxejaht@dhcp-10-154-182-208.vpn.oracle.com>
 <02e3bdd7-896c-2286-d090-1931c5cd807e@kernel.dk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02e3bdd7-896c-2286-d090-1931c5cd807e@kernel.dk>
X-Originating-IP: [129.157.69.50]
X-ClientProxiedBy: SN7PR04CA0094.namprd04.prod.outlook.com
 (2603:10b6:806:122::9) To BY5PR10MB3794.namprd10.prod.outlook.com
 (2603:10b6:a03:1b2::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brm-x62-17.us.oracle.com (129.157.69.50) by SN7PR04CA0094.namprd04.prod.outlook.com (2603:10b6:806:122::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend Transport; Mon, 29 Mar 2021 18:13:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd06f4c8-b8b9-40e2-9d82-08d8f2de4b64
X-MS-TrafficTypeDiagnostic: BY5PR10MB3889:
X-Microsoft-Antispam-PRVS: <BY5PR10MB3889914EB1553EAABBE016B9FC7E9@BY5PR10MB3889.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s0YJFOL7ysUsWLfiOv0sVAbX673T1sZJiFHao3YYIwgnPhi04ykeiG+L0gKq8L0OiYuc3asTKpzxGceZ++eixoLGCZ93rnHY/4vwJUyF50KLIEOkUwwqYnM2kALvZstsPZXTkJqwFEQUNzxyUGg5QQySN0K1ESJ4NWN4gJfFhQugqd2IM3CoWOl81WO3EOI8Up8l5aas8shQsjzu12Ht6ANcbEpFhBsaypNTc8ifLWltQwo0uo6Y6OfZYQqvplHHp+CipzgtpmvH2+l6t+C0PYY4ENjMz6LSvgdK/Zi+jv4/eYVODSguXru/vnAmk5h2Ng7eIySSvW5LSsQvARxEWwOzeJTC6l8L3aPQDiehqP8WgU8ZPzoe86OcmMItY6DO/3VNbUA2T08UWWVBX4KILsfs7h7Qs3WHWHb2d/I7eKHCk4NjlY8QaaVQOEySp4L0kkxWsNPXD5ipjxoRuJr5n+yC3Ty/CATOFpo81W1n3QJS3vnBqsHC5MRw5nv83BxbvvR5UZvhe3N/7HHKLU/ueWnjKEAY9suiqMCgWfy+DLyZm+CHftCZ3aDhT+hqlgE4qMenUt7IhsWcQsOFRblNUdqYFNy7apmeousrERMrKb+fIK3EZGJy4k0Be3VEqhtPeKOAMyLIri0FwjKY03GZIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3794.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(136003)(396003)(39860400002)(366004)(5660300002)(55016002)(6916009)(1076003)(8936002)(8676002)(316002)(186003)(52116002)(44832011)(956004)(83380400001)(7696005)(66556008)(66946007)(66476007)(86362001)(2906002)(26005)(53546011)(16526019)(38100700001)(478600001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: gKQ2oVECst7wSunIg0CXNi7658Yq/L1Z1vp+tpGKfMwGkroit95q2UCz8DkvyAlWbY6DwWf3TtOpOcM+pRiqXg5u9gRjVY2Q6TuEzOSPLRdb5BYsdjQz4YgdYjHzVmCX3SMoJGNilm634WwMJVQMkdtBOvUo0nHufiJ2gR8xf56I2xBdsr+hg0cjOccTKSsCh2P0lvUQpaaIp3MjLuk3ANamgtOIQsP2nzEjXyw6ePcFHqzw1X8cdoic9UMUztsvoS431POZbhyUGaWjoQGqLflXU9MxIJOftjfyyyAFtDuEHUA3nAPe5pfAioqSXEO9BtCIHZFz8htHqiTo1I+HcRMl67X+qoh1SHDm15m61TR24KKv4Da2eIihqR/aCSDyd69FxASHmTkpp79eiWBN2O4oc182DtFVYut4nfl5hGP0v/x4P4FCu1xtFw59VAlPG7aOQKbOS5Pz4+4PQJTx3LPmJkkO1/v1MSB9GP6ytzO604fe1GGBfuATQ+4Ec+2zEIYD4g6U0MJrQEzQMX/nW6pwUisKAIJRANhuFIapIt77zPv/GXqhxFpoP7N/CiHJP3eJvpA804tVttYuZQL2OadyF6faz2YWiwVrlPlC+AQvwO6aXMwDschEaI7R8Z0ebvQ1UIwMc4E+UwH94/bE4EnLTfC14BeWjFkZTuN35ipafjLiPkJlOWO3ACMZbeWdvRBeiX9hd9KdUG5WihPlVDgHzFLlS5d1T0ceb20uIgE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd06f4c8-b8b9-40e2-9d82-08d8f2de4b64
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3794.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2021 18:13:03.6800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SqV+d8bAC+1hdaoqWYVezK6jUKbfJZi9UjYjhfo3kBDhTiJASKCcQfbdha+C3VOEYdR4uRVFocON8ZC7a5HWGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3889
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9938 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103250000 definitions=main-2103290135
X-Proofpoint-GUID: HlBXEyXrKoa36K6e_KKEgJ37WH2s--b6
X-Proofpoint-ORIG-GUID: HlBXEyXrKoa36K6e_KKEgJ37WH2s--b6
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9938 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 clxscore=1015
 phishscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103290135
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 26, 2021 at 09:46:36AM -0600, Jens Axboe wrote:
> On 3/26/21 9:45 AM, Tom Saeger wrote:
> > On Fri, Mar 26, 2021 at 09:41:49AM -0600, Jens Axboe wrote:
> >> On 3/25/21 9:04 PM, Tom Saeger wrote:
> >>>
> >>> s/Additonal/Additional/
> >>> s/assocaited/associated/
> >>> s/assocaited/associated/
> >>> s/assocating/associating/
> >>> s/becasue/because/
> >>> s/configred/configured/
> >>> s/deactive/deactivate/
> >>> s/followings/following/
> >>> s/funtion/function/
> >>> s/heirarchy/hierarchy/
> >>> s/intiailized/initialized/
> >>> s/prefered/preferred/
> >>> s/readded/read/
> >>> s/Secion/Section/
> >>> s/soley/solely/
> >>
> >> While I'm generally happy to accept any patch that makes sense, the
> >> recent influx of speling fixes have me less than excited. They just
> >> add complications to backports and stable patches, for example, and
> >> I'd prefer not to take them for that reason alone.
> > 
> > Nod.
> > 
> > In that case - perhaps adding these entries to scripts/spelling.txt
> > would at least catch some going forward?
> > 
> > I can send that.
> 
> That seems like a good idea.
> 
> -- 
> Jens Axboe
> 

What would be the process - which avoids the backport complications?

Perhaps a few of these could be fixed when other changes are made to these files?
Granted these are trivial fixes, just trying to understand the process.

Example work-flow based on recent block merge upstream:

$ git log -n1 abed516ecd02ceb30fbd091e9b26205ea3192c65 --oneline
    abed516ecd02 Merge tag 'block-5.12-2021-03-27' of git://git.kernel.dk/linux-block

# get files changed by recent merge (or use commit range of interest)
$ HID=abed516ecd02 ; git diff --name-only "$(git merge-base "${HID}^2" "${HID}^1")".."${HID}^2"
    block/bio.c
    block/blk-merge.c
    block/partitions/core.c
    fs/block_dev.c

# foreach file in recent merge, run checkpatch in typo fix mode
$ HID=abed516ecd02 ; git diff --name-only "$(git merge-base "${HID}^2" "${HID}^1")".."${HID}^2" \
| xargs ./scripts/checkpatch.pl --strict --fix --fix-inplace --types TYPO_SPELLING -f | grep -A4 -F "CHECK:"
    CHECK: 'splitted' may be misspelled - perhaps 'split'?
    #344: FILE: block/blk-merge.c:344:
    +               /* there isn't chance to merge the splitted bio */
                                                       ^^^^^^^^

    --
    CHECK: 'beeing' may be misspelled - perhaps 'being'?
    #934: FILE: fs/block_dev.c:934:
    + * or NULL if the inode is already beeing freed.
                                        ^^^^^^

# what changed?
$ git status -su
     M block/blk-merge.c
     M fs/block_dev.c


Something similar could be done for other checkpatch modes or other linters.
Just an idea - thoughts?

Regards,

--Tom
