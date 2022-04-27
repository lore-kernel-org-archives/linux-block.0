Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DFEC433F5
	for <linux-block@archiver.kernel.org>; Wed, 27 Apr 2022 22:04:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbiD0WHa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Apr 2022 18:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237989AbiD0WH3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Apr 2022 18:07:29 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F0482D37
        for <linux-block@vger.kernel.org>; Wed, 27 Apr 2022 15:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1651097057; x=1682633057;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=k/KRkqEEeZaWUZZuh+D9DotGgW9vx5Ww0QkxXdpO5fk=;
  b=X/eo4PG8GA9jzpmPPa+3aUTeyt6RwxbHYl1Bh0tssUkqh03ZD17b+hKn
   sl2dIHvQw0H19CnTHFWHzrarU/2Y3XwQBk8rM+Zh9fQq4NJc0ay3W5C2f
   JcQYvxWcsqCnbOJFvzR4mi9EVqzUpHe79K2SMDkYfYtI17lo8Dd90bb8x
   9hvi1fOQDFQ1CqEsMK0d3gKQmBYtOiQVEFvuAi9PfYVEIarns0g78K7cG
   xPI48xfkLtoG89aqA30Y0rfH1D9P4uvPJISrR1zYQmPaSwJ2/xFkEw1kg
   ypMItXW0xrNrrPC7h9nJDikeEU3/DcVBI2fFdljvGpPKo0BE0PBQJL5Rb
   A==;
X-IronPort-AV: E=Sophos;i="5.90,294,1643644800"; 
   d="scan'208";a="198996881"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Apr 2022 06:04:16 +0800
IronPort-SDR: 82VoufOCVVviF0ftvfTszDTXtsbr2c3ou3lTEJX1WiViaXkiznb1tr65Ea8I5geYWhktnX0Fi8
 GW/VO4vWj1+uyfy7tRf1kaRhQHjhkcsLhwOtGsYBVRA8JJku2/mu/K20Q8Yr3uXMUpRNmaF5GN
 qmsXtUsg/JL9BjZZccdTZHXMyfsATXrH6DVwDY2R0mIaf/KaGvXhwf2YvsS/HMaCHgSp/dzxEV
 kU3xgVVHyogZozGkvXzvrMp6g2/8czmUD57qj8Cp809/W92aLp3SjgG8SXb2MaFsgudDx74ZPt
 WXfBhX8tbWIvGLf3jwhOiTnH
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Apr 2022 14:34:26 -0700
IronPort-SDR: kH/4FqS64kZ2t97k4DlPg/IvWmI5oJqFCTdEF3Tl8unNowWGC3yKc+UGMNAPECMKIabcNXd+OQ
 3RqBaw4y9/zThzaNxdlUqrB12sQ4juaiyaoBl9Ut39UA0AGRitFu/RWdiN1B9viN4gaf4pH5e5
 pymDF/3VvTMDT1aQPRLu9nZjypc98W83+JSe67s2RvUPPUMv9Y/tYGnFENUnlNuD37bjWiZFk3
 jibU1GbMXtCYAsFxoalp2UYJiVchIK/a/NNAx45yO5xJ8novuZf+spIIi5mFDDWy4LBQwbyluN
 5SM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Apr 2022 15:04:16 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KpXpS39Y9z1Rwrw
        for <linux-block@vger.kernel.org>; Wed, 27 Apr 2022 15:04:16 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1651097055; x=1653689056; bh=k/KRkqEEeZaWUZZuh+D9DotGgW9vx5Ww0Qk
        xXdpO5fk=; b=MbhRBbazzr7D4VA8v3jH+SvGTLoiKFNrqiL+bGru/x3suYWEUDu
        QbkxT4kdI0nlCCCMOMSYG5kG5yQGpR9q/Mc4cPIbCf8wVoLSeX2H+utl5oDJyye8
        421mmsRWhx34o3UNrgDQ4aCvEQOjz65S8mM9GxbsX9C+V9nly+I5olUWpqmNnfIm
        TBBGIxa5pZszyMP/91I0TkU+z4k/3S3V4CyPyS561G+EFPTLXo19FPV0zjm7zDQs
        TxpKz7M6dPKuW6yoUlZvQUnaNa2tZFCFQWAUAj+beWyC8Cr/JT29qyg6Q6cuk9Z+
        xeARN+7uUsuHStnXgwLd2ADfg0j69ZNxFPg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Tikv4z0rij3X for <linux-block@vger.kernel.org>;
        Wed, 27 Apr 2022 15:04:15 -0700 (PDT)
Received: from [10.225.163.27] (unknown [10.225.163.27])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KpXpQ3gm7z1Rvlc;
        Wed, 27 Apr 2022 15:04:14 -0700 (PDT)
Message-ID: <0d3b0a6b-825d-1b01-094a-911f81f5f354@opensource.wdc.com>
Date:   Thu, 28 Apr 2022 07:04:13 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v4 02/10] block: Add copy offload support infrastructure
Content-Language: en-US
To:     Nitesh Shetty <nj.shetty@samsung.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        dm-devel@redhat.com, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, nitheshshetty@gmail.com,
        linux-kernel@vger.kernel.org
References: <20220426101241.30100-1-nj.shetty@samsung.com>
 <CGME20220426101921epcas5p341707619b5e836490284a42c92762083@epcas5p3.samsung.com>
 <20220426101241.30100-3-nj.shetty@samsung.com>
 <7d1fdd1e-c854-4744-8bec-7d222fb9be76@opensource.wdc.com>
 <20220427151535.GC9558@test-zns>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220427151535.GC9558@test-zns>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/28/22 00:15, Nitesh Shetty wrote:
> On Wed, Apr 27, 2022 at 11:45:26AM +0900, Damien Le Moal wrote:
>> On 4/26/22 19:12, Nitesh Shetty wrote:
>>> Introduce blkdev_issue_copy which supports source and destination bdevs,
>>> and an array of (source, destination and copy length) tuples.
>>> Introduce REQ_COPY copy offload operation flag. Create a read-write
>>> bio pair with a token as payload and submitted to the device in order.
>>> Read request populates token with source specific information which
>>> is then passed with write request.
>>> This design is courtesy Mikulas Patocka's token based copy
>>>
>>> Larger copy will be divided, based on max_copy_sectors,
>>> max_copy_range_sector limits.
>>>
>>> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
>>> Signed-off-by: Arnav Dawn <arnav.dawn@samsung.com>
>>> ---
>>>  block/blk-lib.c           | 232 ++++++++++++++++++++++++++++++++++++++
>>>  block/blk.h               |   2 +
>>>  include/linux/blk_types.h |  21 ++++
>>>  include/linux/blkdev.h    |   2 +
>>>  include/uapi/linux/fs.h   |  14 +++
>>>  5 files changed, 271 insertions(+)
>>>
>>> diff --git a/block/blk-lib.c b/block/blk-lib.c
>>> index 09b7e1200c0f..ba9da2d2f429 100644
>>> --- a/block/blk-lib.c
>>> +++ b/block/blk-lib.c
>>> @@ -117,6 +117,238 @@ int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
>>>  }
>>>  EXPORT_SYMBOL(blkdev_issue_discard);
>>>  
>>> +/*
>>> + * Wait on and process all in-flight BIOs.  This must only be called once
>>> + * all bios have been issued so that the refcount can only decrease.
>>> + * This just waits for all bios to make it through bio_copy_end_io. IO
>>> + * errors are propagated through cio->io_error.
>>> + */
>>> +static int cio_await_completion(struct cio *cio)
>>> +{
>>> +	int ret = 0;
>>> +	unsigned long flags;
>>> +
>>> +	spin_lock_irqsave(&cio->lock, flags);
>>> +	if (cio->refcount) {
>>> +		cio->waiter = current;
>>> +		__set_current_state(TASK_UNINTERRUPTIBLE);
>>> +		spin_unlock_irqrestore(&cio->lock, flags);
>>> +		blk_io_schedule();
>>> +		/* wake up sets us TASK_RUNNING */
>>> +		spin_lock_irqsave(&cio->lock, flags);
>>> +		cio->waiter = NULL;
>>> +		ret = cio->io_err;
>>> +	}
>>> +	spin_unlock_irqrestore(&cio->lock, flags);
>>> +	kvfree(cio);
>>
>> cio is allocated with kzalloc() == kmalloc(). So why the kvfree() here ?
>>
> 
> acked.
> 
>>> +
>>> +	return ret;
>>> +}
>>> +
>>> +static void bio_copy_end_io(struct bio *bio)
>>> +{
>>> +	struct copy_ctx *ctx = bio->bi_private;
>>> +	struct cio *cio = ctx->cio;
>>> +	sector_t clen;
>>> +	int ri = ctx->range_idx;
>>> +	unsigned long flags;
>>> +	bool wake = false;
>>> +
>>> +	if (bio->bi_status) {
>>> +		cio->io_err = bio->bi_status;
>>> +		clen = (bio->bi_iter.bi_sector << SECTOR_SHIFT) - ctx->start_sec;
>>> +		cio->rlist[ri].comp_len = min_t(sector_t, clen, cio->rlist[ri].comp_len);
>>
>> long line.
> 
> Is it because line is more than 80 character, I thought limit is 100 now, so
> went with longer lines ?

When it is easy to wrap the lines without readability loss, please do to
keep things under 80 char per line.


>>> +{
>>> +	struct request_queue *src_q = bdev_get_queue(src_bdev);
>>> +	struct request_queue *dest_q = bdev_get_queue(dest_bdev);
>>> +	int ret = -EINVAL;
>>> +
>>> +	if (!src_q || !dest_q)
>>> +		return -ENXIO;
>>> +
>>> +	if (!nr)
>>> +		return -EINVAL;
>>> +
>>> +	if (nr >= MAX_COPY_NR_RANGE)
>>> +		return -EINVAL;
>>
>> Where do you check the number of ranges against what the device can do ?
>>
> 
> The present implementation submits only one range at a time. This was done to 
> make copy offload generic, so that other types of copy implementation such as
> XCOPY should be able to use same infrastructure. Downside at present being
> NVMe copy offload is not optimal.

If you issue one range at a time without checking the number of ranges,
what is the point of the nr ranges queue limit ? The user can submit a
copy ioctl request exceeding it. Please use that limit and enforce it or
remove it entirely.


-- 
Damien Le Moal
Western Digital Research
