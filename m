Return-Path: <SRS0=PDkS=23=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7643DC3F68F
	for <linux-block@archiver.kernel.org>; Mon,  6 Jan 2020 06:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4942421775
	for <linux-block@archiver.kernel.org>; Mon,  6 Jan 2020 06:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sQrqpLYN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgAFGB4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Jan 2020 01:01:56 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:49338 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgAFGB4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Jan 2020 01:01:56 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0065jCiE006637;
        Mon, 6 Jan 2020 06:01:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=0zelCiREPyenR2QYtmR9ZeGfHkO4MI8l17JPDOcphVg=;
 b=sQrqpLYNqHigKlPsXLD1kuu8LIRjyyWMsVV4wmHH9w/UvRbuExo0savdiJmZvNFthqfQ
 58o3LA5r10qOYNnumg1q5NsNGkTDZZe8rBF67BcPkFIJzZzrgEmEsncjqKWQEJuUaBeE
 CAktISzxwKnPH2nk+pkBi2hZNa0wiX/B3prEWih0GfpPt2ibeLcEuAyuTwK5b70OaFzu
 8FbDEzf5+9VIeC/rCxo88Vk3bGdlDbTTdgdLCkA5tnxTS6SGvEHskmXQJdgPxaJNU/gt
 /EOkwApdrM6eV6qVYzc1Yis7SQNKK/rJnpHxIP5sF8cHFWraxelIis+nsHuNmxAh7TR1 lA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2xakbqd35h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jan 2020 06:01:32 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0065iY14075592;
        Mon, 6 Jan 2020 05:59:32 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2xb47b5mfx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jan 2020 05:59:32 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0065xOPm032657;
        Mon, 6 Jan 2020 05:59:25 GMT
Received: from [192.168.1.14] (/114.88.246.185)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 05 Jan 2020 21:59:24 -0800
Subject: Re: [resend v1 0/5] Add support for block disk resize notification
To:     Balbir Singh <sblbir@amazon.com>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     axboe@kernel.dk, ssomesh@amazon.com, jejb@linux.ibm.com,
        hch@lst.de, mst@redhat.com, Chaitanya.Kulkarni@wdc.com
References: <20200102075315.22652-1-sblbir@amazon.com>
From:   Bob Liu <bob.liu@oracle.com>
Message-ID: <62ef2cd2-42a2-6117-155d-ed052a136c5c@oracle.com>
Date:   Mon, 6 Jan 2020 13:59:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20200102075315.22652-1-sblbir@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9491 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=913
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001060053
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9491 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=957 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001060053
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/2/20 3:53 PM, Balbir Singh wrote:
> Allow block/genhd to notify user space about disk size changes
> using a new helper disk_set_capacity(), which is a wrapper on top
> of set_capacity(). disk_set_capacity() will only notify if
> the current capacity or the target capacity is not zero.
> 

set_capacity_and_notify() may be a more straightforward name.

> Background:
> 
> As a part of a patch to allow sending the RESIZE event on disk capacity
> change, Christoph (hch@lst.de) requested that the patch be made generic
> and the hacks for virtio block and xen block devices be removed and
> merged via a generic helper.
> 
> This series consists of 5 changes. The first one adds the basic
> support for changing the size and notifying. The follow up patches
> are per block subsystem changes. Other block drivers can add their
> changes as necessary on top of this series.
> 
> Testing:
> 1. I did some basic testing with an NVME device, by resizing it in
> the backend and ensured that udevd received the event.
> 
> NOTE: After these changes, the notification might happen before
> revalidate disk, where as it occured later before.
> 

It's better not to change original behavior.
How about something like:

+void set_capacity_and_notify(struct gendisk *disk, sector_t size, bool revalidate)
{
	sector_t capacity = get_capacity(disk);

	set_capacity(disk, size);

+        if (revalidate)
+		revalidate_disk(disk);
	if (capacity != 0 && size != 0) {
		char *envp[] = { "RESIZE=1", NULL };

		kobject_uevent_env(&disk_to_dev(disk)->kobj, KOBJ_CHANGE, envp);
	}
}

> Balbir Singh (5):
>   block/genhd: Notify udev about capacity change
>   drivers/block/virtio_blk.c: Convert to use disk_set_capacity
>   drivers/block/xen-blkfront.c: Convert to use disk_set_capacity
>   drivers/nvme/host/core.c: Convert to use disk_set_capacity
>   drivers/scsi/sd.c: Convert to use disk_set_capacity
> 
>  block/genhd.c                | 19 +++++++++++++++++++
>  drivers/block/virtio_blk.c   |  4 +---
>  drivers/block/xen-blkfront.c |  5 +----
>  drivers/nvme/host/core.c     |  2 +-
>  drivers/scsi/sd.c            |  2 +-
>  include/linux/genhd.h        |  1 +
>  6 files changed, 24 insertions(+), 9 deletions(-)
> 

