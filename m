Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00003501.pphosted.com ([67.231.152.68]:17863 "EHLO
	mx0a-000cda01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751031AbcHLVt2 (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Fri, 12 Aug 2016 17:49:28 -0400
Received: from pps.filterd (m0075028.ppops.net [127.0.0.1])
	by mx0b-00003501.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id u7CLdx2m013765
	for <linux-block@vger.kernel.org>; Fri, 12 Aug 2016 17:49:27 -0400
Received: from mail-qk0-f200.google.com (mail-qk0-f200.google.com [209.85.220.200])
	by mx0b-00003501.pphosted.com with ESMTP id 24skmvrjf0-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 12 Aug 2016 17:49:27 -0400
Received: by mail-qk0-f200.google.com with SMTP id i140so15559287qke.0
        for <linux-block@vger.kernel.org>; Fri, 12 Aug 2016 14:49:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <yq1lh01n1ul.fsf@sermon.lab.mkp.net>
References: <833713246c1a70d85150289c1537797d6f7dd606.1470903899.git.tom.ty89@gmail.com>
 <yq1r39upy7p.fsf@sermon.lab.mkp.net> <CAGnHSE=E1Bj99EciXrDS31n4Q4VcRL0sDJ2t4ynx0bHgp5RNtw@mail.gmail.com>
 <yq1lh01n1ul.fsf@sermon.lab.mkp.net>
From: Shaun Tancheff <shaun.tancheff@seagate.com>
Date: Fri, 12 Aug 2016 16:49:06 -0500
Message-ID: <CAJVOszDDC39ge6d3h+uy1wtxMBv95_V1eWofumya_G5zg21OrQ@mail.gmail.com>
Subject: Re: [RFC] libata-scsi: make sure Maximum Write Same Length is not too large
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Tom Yan <tom.ty89@gmail.com>, Tejun Heo <tj@kernel.org>,
	Shaun Tancheff <shaun@tancheff.com>, linux-ide@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Aug 12, 2016 at 3:56 PM, Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>>>>>> "Tom" == Tom Yan <tom.ty89@gmail.com> writes:
>
> Tom,
>
>>> put_unaligned_be64(65535 * ATA_MAX_TRIM_RNUM / (sector_size / 512), &rbuf[36]);
>
> How many 8-byte ranges fit in a 4096-byte sector?
>
> Tom> So were you trying to pointing out something I am still missing, or
> Tom> were you merely confirming I was right?
>
> I suggest you drop ATA_MAX_TRIM_RNUM and do:
>
> enum {
>      ATA_TRIM_BLOCKS_PER_RANGE = 65535, /* 0xffff blocks per range desc. */
>      ATA_TRIM_RANGE_SIZE_SHIFT = 3,     /* range descriptor is 8 bytes */
> };
>
> put_unaligned_be64(ATA_TRIM_BLOCKS_PER_RANGE *
>                    sector_size >> ATA_TRIM_RANGE_SIZE_SHIFT, &rbuf[36]);
>
> Might be worthwhile to create an ata_max_lba_range_blocks() wrapper.

Ah, I think I am understanding now. When the sector size is 4K the
minimum page sent with WRITE SAME will be 4K.

If so, we also need to fix the write_same SATL code that is working
under the assumption of a 512 byte sector sector as the largest
guaranteed amount of data in the associated sg pages.
Keying off of sector_size should be straight forward there...

-- 
Shaun Tancheff
