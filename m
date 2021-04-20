Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA26C433ED
	for <linux-block@archiver.kernel.org>; Tue, 20 Apr 2021 22:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6975D61400
	for <linux-block@archiver.kernel.org>; Tue, 20 Apr 2021 22:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234188AbhDTW3r (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Apr 2021 18:29:47 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:34454 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233964AbhDTW3r (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Apr 2021 18:29:47 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13KMNZVT026609;
        Tue, 20 Apr 2021 15:29:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=facebook;
 bh=sXQOd+9q9MQq5CDE+6s/2fp6M0Bjq66BifOBUWt6SsI=;
 b=d6EfJqVZHO25gk16OtJjE4fz6SCqpTGIb+SNPtMhqf9AvRjFH60kJ44Ms+koq2oBO4h/
 mBMBpX1BK5FhL/8E8LAgBANYUn9ZaqMXe8roz2js0lC+6YQInWE3M246pdBIWHc080IA
 LUbD9S+F9UmAGItTrz7JLhZTpL4m9ErX3DI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 382726g7hu-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 20 Apr 2021 15:29:13 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 20 Apr 2021 15:29:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LQAYzlkloJnhk5M0wkV0QG6SsUPCCV3gV3Z/qO+ikyyd+pm1ZsZhMHMsN794f2f9qcV/hh10l4Z7MQquUM4CmfHZJBb78uD0435urve/tl/X3acn4VmOZtPv+fhHcYBPe4EtwIiw/jPF+ZM1kZQwpydGODpjt2eSr+hePuzbuNiMcQe5YTs1rCE/ziEMYHVmBJrRGUxHu/u/m6NYkDM2fymkFDKyMLC4xkSj8FwMKvoRRnrRJSI4dQ5+yLZwmBHWMEbi2pyBNVnSt4jLOocUt1Dyfay3zXm4wX8DTR6Oe9P/nXn2NtGv+vK+UvR3VHJA8RGLV/v2HsldbAHIXsTcFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYfPocb6qyEwP4EauJlw8XOeOMIrupg5cOcgm5IaFXs=;
 b=KK060hAZy2N2Gu8Sklvva/NEr4356nk/f6h62wfo0NfXUQmPnHLewXeZ2J4BAnDee7rxPpxZPFGr1PnCPeD6Ghk4fjYUiBcTc3SDsVNIqTfnUKyZcawVfw2jsgQjy0JA/jmqS2hgqOv3VUPjIJyd4RiAxYXn7CAAam1a3L9dgW0Ckq6QVptBKc+zeFYjDZ0nu0qoZ3IvI77XU/TxsE6PgiQAXho+nJrO6rBBWrK0L9VIGZC3aGrcEBRXGhUajBTTPPd6osbeYJGKySe9eWbnnC7F23FmDInz7/dHpJf8Ah8RLnjz/EdBlGTRdDn8K1FF60WqlzgsZBwVhfyZV9VO0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2126.namprd15.prod.outlook.com (2603:10b6:805:5::14)
 by SA1PR15MB4420.namprd15.prod.outlook.com (2603:10b6:806:197::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18; Tue, 20 Apr
 2021 22:29:11 +0000
Received: from SN6PR1501MB2126.namprd15.prod.outlook.com
 ([fe80::49ef:df18:5463:ee60]) by SN6PR1501MB2126.namprd15.prod.outlook.com
 ([fe80::49ef:df18:5463:ee60%7]) with mapi id 15.20.4042.024; Tue, 20 Apr 2021
 22:29:10 +0000
Date:   Tue, 20 Apr 2021 15:29:02 -0700
From:   Saravanan D <saravanand@fb.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <jkkm@fb.com>, <tj@kernel.org>, <kernel-team@fb.com>,
        Calvin Owens <calvinowens@fb.com>
Subject: Re: [PATCH] brd: expose number of allocated pages in debugfs
Message-ID: <20210420222902.scz3jvcirmpnjqnr@devvm1945.atn0.facebook.com>
References: <20210416211829.4002947-1-saravanand@fb.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210416211829.4002947-1-saravanand@fb.com>
X-Originating-IP: [2620:10d:c090:400::5:3a9c]
X-ClientProxiedBy: MW3PR06CA0024.namprd06.prod.outlook.com
 (2603:10b6:303:2a::29) To SN6PR1501MB2126.namprd15.prod.outlook.com
 (2603:10b6:805:5::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from devvm1945.atn0.facebook.com (2620:10d:c090:400::5:3a9c) by MW3PR06CA0024.namprd06.prod.outlook.com (2603:10b6:303:2a::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Tue, 20 Apr 2021 22:29:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7fc6453-6ffd-493b-47a8-08d9044bb76e
X-MS-TrafficTypeDiagnostic: SA1PR15MB4420:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR15MB4420F4C9DD0047CCF2041583A2489@SA1PR15MB4420.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u9D7Aqd0tyEPump63EOKfBlt/GQ90ATf+SDY/Jew9X5lvGmNcpvFD9Xaq5jPXLb6t7CaVot4p8dPZz4A6SlCeiOuvmyMBRP9/ymQ1JYL8AC1rDVPU1+Vb8EdFtbvMUbodMiXwxFbqzIjfgbv1GT9b9fmwH55ZH6g8tJgg0LCZ/nKiClleVpe+RsGGVas49lKWen8/aYWI3izCgqdPUj058XBPxp0w85PYvaxAaQpUHspg4zkn0yy96QqFCEhELZjtXYcfGCqKacxtFK2cOSsfX61Etll1fn2WWQjwuPQD0Qf05+C2rRPsgWaR6WD8tgEFLIA/7mwUsTyctOkJYV3Jwz9BXAB9V9Ra/+mXDfJmFBtvmDbQAizWxXc98RxrbpaYrulJs4Senh+4nc7Zgm76ZQa2WvktJLq8BPY+C/H/v/WxLmjNNA1srGnmj1UraA3p5han9KhhvHJFn5qRotomYMk4rZ/EI/lKzbhOECvOfnuy879Ki3mw+FvftAucMqzc3Tn0kC57Sv7LiF5KF6dUcSzEMlGokAyAoPtqOLPEinrAQKeBo4jVYjm5zv0jAdo3fzOqWP5OJW9VUVX+dKDJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2126.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(366004)(346002)(136003)(396003)(38100700002)(1076003)(316002)(8676002)(478600001)(8936002)(66556008)(83380400001)(16526019)(4326008)(186003)(6506007)(86362001)(7696005)(66946007)(9686003)(52116002)(55016002)(5660300002)(2906002)(6666004)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?iso-8859-1?Q?hk/JqLH4J5X8EmREP16fah2dC6d3aIMTGQ68JHO4bnE1K1+FNExtFiRlxZ?=
 =?iso-8859-1?Q?3bNPMVQHuYg9du2RWIhQwJ4fCIWm6xQHecP0MMfWL8FwxkbAs7tPHU25P+?=
 =?iso-8859-1?Q?ZZ8JIi5ny0DxJ2cUpiJp4rXTyptwtSVGOxYh5LFTDzm3NfkrdRMOQBCc03?=
 =?iso-8859-1?Q?BrxgAdtUVJTOMAKV2zo9d/N3D8cYfX0vYAZD6yNx3HLX1yArfPQs/rpJs0?=
 =?iso-8859-1?Q?gtBeWSdYw87vkr+a7Qb3Q7MlHNfcj9IBOqVIs1fAmez1DOMgHOabSx/KKD?=
 =?iso-8859-1?Q?Cu7KPSKUOxFlrMk9DswI7xAmUOWab1zhLbVIiYMpGa12NtIBhMiMAuZI0h?=
 =?iso-8859-1?Q?Ux65B7dlIw1WS+e0tqoEo3ehOXe/L0F2v4dVe+Ke3AII6NUIPIUMxsgNuO?=
 =?iso-8859-1?Q?7l6EFh9ZkZj9nRXLaK1TezKYVqMdYXDzvd6d74GZD/x8ax2gEEy48cSV73?=
 =?iso-8859-1?Q?qrnsN2qU6W6wzzl+OODHI8Skyxqgdo3gxGADG/JrChTSp3c0ZS+KikJkP/?=
 =?iso-8859-1?Q?xPbInrtO+8Wuh6T+z4RjoBXVL0svMsMX/7I8ULpDdNWUuVql92AddGTBy5?=
 =?iso-8859-1?Q?RkWontOPVeTNT/90OTS6pDyAbd8immWKCy38wHMJ4TVo6ubDZ00sO5H6J0?=
 =?iso-8859-1?Q?fvYBTfjBnffkD28jix5tPgoijyCyqLAicRbemwJlMA20G0FtzJ0CFCBM1e?=
 =?iso-8859-1?Q?/zba9WTcF0AeswVK91k+TgW8MESMlb3QjoFVzG8R0UTknhKS+2MlGMM5Mg?=
 =?iso-8859-1?Q?vS2v90PN2EyRX0HGZCB0LONHhmI5pd15M3wj8SevoXnSXNUJLFnYOnKkYq?=
 =?iso-8859-1?Q?mouoZACP3WAYRCX4LWyMiAIOcAOzNl8CxNbRNOqC1PohijRXwfni17ap2o?=
 =?iso-8859-1?Q?+ony16WF+HLRW+5CV0U+X8lFu+d6i2G2hyCxs3Qm/w7SLGFPyYVR/OCzS3?=
 =?iso-8859-1?Q?WLJpbOTv7orvhW0hcDPfEw0izKD805Z1wlcL+euLtleW1PzFJGEoezlCqX?=
 =?iso-8859-1?Q?L+W5kVEIA6wqQrbD7aejdfNeKZK/SZ86RiNqWCUYIaw9bmcDOp4PQGtHkr?=
 =?iso-8859-1?Q?3b7LXjgB2FFmBdJ62X0QpyN8m1iZGA53hYeRWveuN5TOEHpayqdSU09z86?=
 =?iso-8859-1?Q?Bcyruacmmrw2RvnVEk33niCmY09Uws8gygXbEUPO4hOkEBJ1aZy1PUPnka?=
 =?iso-8859-1?Q?zmk1s31AQMW7+RUdNdGw64AzkinXcke1uf/71uKKRoaKRanA6FjrY0z2vy?=
 =?iso-8859-1?Q?Caf8U1PinaWt3906PFN7RiPizQIfn9/AGO1FpCOn8CyDgm2mGYYFOVIe44?=
 =?iso-8859-1?Q?7CP4ZR/tqPH8lPxevcmeoXQs/OF25QgVbDuV6uarir52qSS+l74+WY6quX?=
 =?iso-8859-1?Q?jgrKqiBXhmPw4wwzDApbQhZ7TVkPereQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f7fc6453-6ffd-493b-47a8-08d9044bb76e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2126.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2021 22:29:10.8634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UDtvAPFfTbRY4kePQZ5GlujJBfsC9Uk58yEa6Bp+v9QxxMf+uWqjtexetqKFWUsrTDbxMJKH/OFc4qy5cXlhrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4420
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: GgucbcDTWiuSmDfnTm_uTmwZw4iFiTwt
X-Proofpoint-GUID: GgucbcDTWiuSmDfnTm_uTmwZw4iFiTwt
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-20_11:2021-04-20,2021-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 mlxscore=0 spamscore=0 malwarescore=0 bulkscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 adultscore=0
 mlxlogscore=999 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2104200157
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 16, 2021 at 02:18:29PM -0700, Saravanan D wrote:
> From: Calvin Owens <calvinowens@fb.com>
> 
> While the maximum size of each ramdisk is defined either
> as a module parameter, or compile time default, it's impossible
> to know how many pages have currently been allocated by each
> ram%d device, since they're allocated when used and never freed.
> 
> This patch creates a new directory at this location:
> 
> »       /sys/kernel/debug/ramdisk_pages/
> 
> ...which will contain a file named "ram%d" for each instantiated
> ramdisk on the system. The file is read-only, and read() will
> output the number of pages currently held by that ramdisk.
> 

Justification : We lose track how much memory a ramdisk is using as
pages once used are simply recycled but never freed.

In instances where we exhaust the size of the ramdisk with a file that
exceeds it, encounter ENOSPC and delete the file for mitigation;
df would show decrease in used and increase in available blocks
but the since we have touched all pages, the memory footprint of the
ramdisk does not reflect the blocks used/available count

...
[root@localhost ~]# mkfs.ext2 /dev/ram15
mke2fs 1.45.6 (20-Mar-2020)
Creating filesystem with 4096 1k blocks and 1024 inodes
[root@localhost ~]# mount /dev/ram15 /mnt/ram15/

[root@localhost ~]# cat
/sys/kernel/debug/ramdisk_pages/ram15
58
[root@kerneltest008.06.prn3 ~]# df /dev/ram15
Filesystem     1K-blocks  Used Available Use% Mounted on
/dev/ram15          3963    31      3728   1% /mnt/ram15
[root@kerneltest008.06.prn3 ~]# dd if=/dev/urandom of=/mnt/ram15/test2
bs=1M count=5
dd: error writing '/mnt/ram15/test2': No space left on device
4+0 records in
3+0 records out
4005888 bytes (4.0 MB, 3.8 MiB) copied, 0.0446614 s, 89.7 MB/s
[root@kerneltest008.06.prn3 ~]# df /mnt/ram15/
Filesystem     1K-blocks  Used Available Use% Mounted on
/dev/ram15          3963  3960         0 100% /mnt/ram15
[root@kerneltest008.06.prn3 ~]# cat
/sys/kernel/debug/ramdisk_pages/ram15
1024
[root@kerneltest008.06.prn3 ~]# rm /mnt/ram15/test2
rm: remove regular file '/mnt/ram15/test2'? y
[root@kerneltest008.06.prn3 /var]# df /dev/ram15
Filesystem     1K-blocks  Used Available Use% Mounted on
/dev/ram15          3963    31      3728   1% /mnt/ram15

# Acutal memory footprint 
[root@kerneltest008.06.prn3 /var]# cat
/sys/kernel/debug/ramdisk_pages/ram15
1024
...

This debugfs counter will always reveal the accurate number of
permanently allocated pages to the ramdisk.
