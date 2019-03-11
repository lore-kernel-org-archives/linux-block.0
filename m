Return-Path: <SRS0=4UPx=RO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E686C43381
	for <linux-block@archiver.kernel.org>; Mon, 11 Mar 2019 07:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB82A2084D
	for <linux-block@archiver.kernel.org>; Mon, 11 Mar 2019 07:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Q6rF+kVM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbfCKHu7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Mar 2019 03:50:59 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:48572 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbfCKHu7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Mar 2019 03:50:59 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2B7mhd9041501;
        Mon, 11 Mar 2019 07:50:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : cc : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=82B3BIcYzc2w7nsmIAF8hZkoUPC8XbuPSD7vrbQoyAI=;
 b=Q6rF+kVMSmGm1pec/gMv8M6o0SqffP+1yMubKJGw7fk4baVMCXGU34Hh7q8UP6sBlDkw
 bHmNbygNf3IrlFHY7B/F+WTZg0X13t6MU09MRXI9JdGaRBxLGUEMuuBGtJOxrPJj6xw/
 XjBTgCWflo0KjVfKBmNvRaparVbec4MnVPMvBwnXZO8MNXMWhXACn3inC1CsHCnVL2ur
 NJQvwixBnwgffenK7MsSKK09xvwRAVg6Hj3uE/Qzf9aNSjNbA1TLWiqONtL8OiRRDd5O
 D6UNl8jhCIkFjYMrk3Xj6gwqrA2iVdRdhctO4rZGI4fTd5/BvPr2/AZQqmWppfFueSxO SA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2r430ed4gq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Mar 2019 07:50:44 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2B7ocJL001726
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Mar 2019 07:50:38 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2B7oaNR014334;
        Mon, 11 Mar 2019 07:50:37 GMT
Received: from [10.182.69.106] (/10.182.69.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 11 Mar 2019 00:50:36 -0700
Subject: Re: NVMe: Regression: write zeros corrupts ext4 file system
To:     Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
References: <20190311022441.GA16849@ming.t460p>
From:   Dongli Zhang <dongli.zhang@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Message-ID: <08f3d0f9-c10c-ef72-72f5-62670388763b@oracle.com>
Date:   Mon, 11 Mar 2019 15:54:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190311022441.GA16849@ming.t460p>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9191 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903110060
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 3/11/19 10:24 AM, Ming Lei wrote:
> Hi,
> 
> It is observed that ext4 is corrupted easily by running some workloads
> on QEMU NVMe, such as:

I cannot reproduce with most recent up-to-date mainline kernel on below qemu
versions:

- qemu-2.10.2
- qemu-3.0.0

> 
> 1) mkfs.ext4 /dev/nvme0n1
> 
> 2) mount /dev/nvme0n1 /mnt
> 
> 3) cd /mnt; git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> 
> 4) then the following error message may show up:
> 
> [ 1642.271816] EXT4-fs error (device nvme0n1): ext4_mb_generate_buddy:747: group 0, block bitmap and bg descriptor inconsistent: 32768 vs 23513 free clusters
> 
> Or fsck.ext4 will complain after running 'umount /mnt'
> 
> The issue disappears by reverting 6e02318eaea53eaafe6 ("nvme: add support for the
> Write Zeroes command").

As above commit is for Write Zeros command, I instrument and add printf at the
beginning of nvme_write_zeros() for qemu-2.10.2.

nvme_write_zeros() are only called for 47 times during "mount /dev/nvme0n1 /mnt".


During "git clone" from torvalds' linux.git, there is no call of nvme_write_zeros().

Perhaps there is some special configuration required to trigger the
nvme_write_zeros() on purpose during "git clone" to involve the
nvme_cmd_write_zeroes on kernel side?

My test nvme image is only about 5GB.

Dongli Zhang


> 
> QEMU version:
> 
> QEMU emulator version 2.10.2(qemu-2.10.2-1.fc27)
> Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers
> 
> Thanks,
> Ming
> 
