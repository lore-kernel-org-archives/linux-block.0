Return-Path: <linux-block-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:49519 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752194AbcHaCPM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Aug 2016 22:15:12 -0400
To: Andy Grover <agrover@redhat.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org,
        linux-scsi <linux-scsi@vger.kernel.org>,
        target-devel <target-devel@vger.kernel.org>
Subject: Re: Should queue_max_hw_sectors() always be <= max_dev_sectors?
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <202d350b-0e59-1a10-4b65-3563f0afa084@redhat.com>
Date: Tue, 30 Aug 2016 22:15:05 -0400
In-Reply-To: <202d350b-0e59-1a10-4b65-3563f0afa084@redhat.com> (Andy Grover's
        message of "Tue, 30 Aug 2016 09:54:05 -0700")
Message-ID: <yq1y43d7kgm.fsf@sermon.lab.mkp.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

>>>>> "Andy" == Andy Grover <agrover@redhat.com> writes:

Hey Andy,

Andy> ...because limits.max_hw_sectors internally seems to be just the
Andy> controller limit, but what users of queue_max_hw_sectors
Andy> (including sysfs) really want is the lesser of
Andy> limits.max_hw_sectors and limits.max_dev_sectors.

max_dev_sectors is a limit reported by the target device for
READ/WRITE/VERIFY requests. Whereas max_hw_sectors describes the DMA
constraints of the controller.

It is a requirement for SG_IO, firmware updates, tape drives, etc. that
the controller limits are reported correctly since they do I/Os that are
much bigger than typical filesystem requests. When we tried to conflate
the two things broke in interesting ways.

I can't remember why the max_dev_sectors sysfs export patch didn't go
in. But instead (or in addition) we could entertain having a
max_rw_sectors_kb file that reflects the biggest READ/WRITE/VERIFY
request the device can consume if that's the information you're after?

-- 
Martin K. Petersen	Oracle Linux Engineering
