Return-Path: <SRS0=/6aj=N2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A42D3C43441
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 22:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6478D2084C
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 22:24:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="f+NdaEsV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6478D2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725979AbeKPIeH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Nov 2018 03:34:07 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:41034 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbeKPIeH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Nov 2018 03:34:07 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAFMNuNb162358;
        Thu, 15 Nov 2018 22:24:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=ZV4y79ZVkOEB7edGmSbvb4GT+QUfc6jdPyJEiGtOYCs=;
 b=f+NdaEsV/unuEWq/FnJOnBoCdibXug5pmtGf5xUDXrB4HBLLKREL2cqhPG3XLyHHt6Uh
 GBVS4CkDQ5CrqaE1+c+hoCvND2y0hWQADs5mMBeayzbnp78bUtY3BfgtvGcWHcYKHs+e
 35vT9zVFznTGVW2aJTrG4ctFkquKHCiHYV3kawZ/rZztLUdi50bd2T2StdmqvrnlB9/f
 GgutfpX9muYi0aA7IJJc0jExyQX4S1l43LCYnLwPdVzt6mosPCOZ1/B/81UhwD8JdaC6
 wUeMOJRpFtxMuA9zyHKSdM5Q3e7zEGHmW0Zs1DFcHu5jbFAB2G94g+4vlieh2Y4G1vKi CQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2nr7csc7sb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Nov 2018 22:24:20 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wAFMOK3s017106
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Nov 2018 22:24:20 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wAFMOJ28026000;
        Thu, 15 Nov 2018 22:24:19 GMT
Received: from localhost (/10.159.149.118)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 15 Nov 2018 14:24:19 -0800
Date:   Thu, 15 Nov 2018 14:24:19 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-xfs@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: fix 32 bit overflow in __blkdev_issue_discard()
Message-ID: <20181115222419.GV4235@magnolia>
References: <20181113214337.20581-1-david@fromorbit.com>
 <10a8dd78-7c00-8593-9f4e-b20eb1161b92@kernel.dk>
 <20181115010651.GD32603@ming.t460p>
 <20181115012201.GX19305@dastard>
 <20181115031035.GE32603@ming.t460p>
 <20181115221337.GY19305@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181115221337.GY19305@dastard>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9078 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811150195
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 16, 2018 at 09:13:37AM +1100, Dave Chinner wrote:
> On Thu, Nov 15, 2018 at 11:10:36AM +0800, Ming Lei wrote:
> > On Thu, Nov 15, 2018 at 12:22:01PM +1100, Dave Chinner wrote:
> > > On Thu, Nov 15, 2018 at 09:06:52AM +0800, Ming Lei wrote:
> > > > On Wed, Nov 14, 2018 at 08:18:24AM -0700, Jens Axboe wrote:
> > > > > On 11/13/18 2:43 PM, Dave Chinner wrote:
> > > > > > From: Dave Chinner <dchinner@redhat.com>
> > > > > > 
> > > > > > A discard cleanup merged into 4.20-rc2 causes fstests xfs/259 to
> > > > > > fall into an endless loop in the discard code. The test is creating
> > > > > > a device that is exactly 2^32 sectors in size to test mkfs boundary
> > > > > > conditions around the 32 bit sector overflow region.
> > > > > > 
> > > > > > mkfs issues a discard for the entire device size by default, and
> > > > > > hence this throws a sector count of 2^32 into
> > > > > > blkdev_issue_discard(). It takes the number of sectors to discard as
> > > > > > a sector_t - a 64 bit value.
> > > > > > 
> > > > > > The commit ba5d73851e71 ("block: cleanup __blkdev_issue_discard")
> > > > > > takes this sector count and casts it to a 32 bit value before
> > > > > > comapring it against the maximum allowed discard size the device
> > > > > > has. This truncates away the upper 32 bits, and so if the lower 32
> > > > > > bits of the sector count is zero, it starts issuing discards of
> > > > > > length 0. This causes the code to fall into an endless loop, issuing
> > > > > > a zero length discards over and over again on the same sector.
> > > > > 
> > > > > Applied, thanks. Ming, can you please add a blktests test for
> > > > > this case? This is the 2nd time it's been broken.
> > > > 
> > > > OK, I will add zram discard test in blktests, which should cover the
> > > > 1st report. For the xfs/259, I need to investigate if it is easy to
> > > > do in blktests.
> > > 
> > > Just write a test that creates block devices of 2^32 + (-1,0,1)
> > > sectors and runs a discard across the entire device. That's all that
> > > xfs/259 it doing - exercising mkfs on 2TB, 4TB and 16TB boundaries.
> > > i.e. the boundaries where sectors and page cache indexes (on 4k page
> > > size systems) overflow 32 bit int and unsigned int sizes. mkfs
> > > issues a discard for the entire device, so it's testing that as
> > > well...
> > 
> > Indeed, I can reproduce this issue via the following commands:
> > 
> > modprobe scsi_debug virtual_gb=2049 sector_size=512 lbpws10=1 dev_size_mb=512
> > blkdiscard /dev/sde
> > 
> > > 
> > > You need to write tests that exercise write_same, write_zeros and
> > > discard operations around these boundaries, because they all take
> > > a 64 bit sector count and stuff them into 32 bit size fields in
> > > the bio tha tis being submitted.
> > 
> > write_same/write_zeros are usually used by driver directly, so we
> > may need make the test case on some specific device.
> 
> My local linux iscsi server and client advertise support for them.
> It definitely does not ships zeros across the wire(*) when I use
> things like FALLOC_FL_ZERO_RANGE, but fstests does not have block
> device fallocate() tests for zeroing or punching...

fstests does (generic/{349,350,351}) but those basic functionality tests
don't include creating a 2^32 block device and seeing if overflows
happen... :/

...I also see that Eryu succeeded in kicking those tests out of the
quick group, so they probably don't run that often either.

--D

> 
> Cheers,
> 
> Dave.
> 
> (*) but the back end storage is a sparse file on an XFS filesystem,
> and the iscsi server fails to translate write_zeroes or
> WRITE_SAME(0) to FALLOC_FL_ZERO_RANGE on the storage side and hence
> is really slow because it physically writes zeros to the XFS file.
> i.e. the client offloads the operation to the server to minimise
> wire traffic, but then the server doesn't offload the operation to
> the storage....
> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
