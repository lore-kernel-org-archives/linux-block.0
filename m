Return-Path: <SRS0=7Bp6=PY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3361C43387
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 21:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EB642086D
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 21:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="dg8o6F9v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbfAPVU6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jan 2019 16:20:58 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36377 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729378AbfAPVU6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jan 2019 16:20:58 -0500
Received: by mail-pl1-f196.google.com with SMTP id g9so3620849plo.3
        for <linux-block@vger.kernel.org>; Wed, 16 Jan 2019 13:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WHr+awN9ipE4RpOjR18yB95se29VTOBJWoYb9BeDI/U=;
        b=dg8o6F9v3YXbcmmeVhwYXmmCLhKPyBZExFJ+12ScA5u2UclprBXRvGPLwNDMz6oao0
         CWwsWsgQicE8VhbLo6jolbVf8L9yTX2onfRrc8lka1vOkBAJH5ie/1fvr7ezLb0vw82x
         YJ+7Vpd3c1WYuTLloyTYcPJjaOjOBDTHfmgsnjzd6UNW5JmWvjCOOfzLlm+RJo+Q323f
         fFdceSGkYvE2bXQxcCwFL4dh5r7092MQ2xKeL+3idV9t+UPX4vHuxSXE2+fGHA+kkz5Y
         frd0QL7G1SBnlTDxw+pDkdUJAEemE40h8mWQRoaevBfdKGJP0TJrHuIetYV7mbUH3WSi
         Id4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WHr+awN9ipE4RpOjR18yB95se29VTOBJWoYb9BeDI/U=;
        b=mIXCi3Jkjje7Yi/ucal77I57avH1J+x7Q3DvPBGfCUAZggHyyHa5hHc1MnRexEGIq6
         BD28AEGEYYacsmbajjuB/uAnWHx6xTASUE2zLvmXeNf8BxAqRlhPcjBl2vgPYdKnaMlJ
         mMjVE/jqrPf+RzeMbABldxhfjW5TplztkeUXJelEzrCRj7fMhNkUcRcSz9gDiSsLJ8I4
         76ULp4De6OTcuWZiMgMWy2E3obCWtej25fhpjz7YYLMciWbcgb7QUtftazLNswwGpG1J
         rNYKxGuMN4fz2Tmc/Ie89emuH2aF6lLMPyev/1Dt0/Oxzpg1k8A3JjT0NFdinYF3j3Zj
         XlXw==
X-Gm-Message-State: AJcUukeumGaRaMl1VOOEs2uVO0JUsSxXbGER4mmwEFPpZceHrioA0tqj
        /cuYUR/4euHhjcpTZPMgF8Bn+Q==
X-Google-Smtp-Source: ALg8bN4y0ai7Vg5OqAA3X9j1n9ftcI8BCaqJLyeYLBUDEx3b7aBa0qJw/1Dj8DdYWbZEmDy3daFj2w==
X-Received: by 2002:a17:902:bd86:: with SMTP id q6mr11706278pls.16.1547673657390;
        Wed, 16 Jan 2019 13:20:57 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id a17sm9951387pgm.26.2019.01.16.13.20.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 13:20:56 -0800 (PST)
Subject: Re: [PATCH 12/15] io_uring: add support for pre-mapped user IO
 buffers
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org,
        hch@lst.de, jmoyer@redhat.com, avi@scylladb.com
References: <20190116175003.17880-1-axboe@kernel.dk>
 <20190116175003.17880-13-axboe@kernel.dk> <20190116205338.GQ4205@dastard>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9db63405-6797-9305-3ce1-fdc11edbf49c@kernel.dk>
Date:   Wed, 16 Jan 2019 14:20:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190116205338.GQ4205@dastard>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/16/19 1:53 PM, Dave Chinner wrote:
> On Wed, Jan 16, 2019 at 10:50:00AM -0700, Jens Axboe wrote:
>> If we have fixed user buffers, we can map them into the kernel when we
>> setup the io_context. That avoids the need to do get_user_pages() for
>> each and every IO.
> .....
>> +			return -ENOMEM;
>> +	} while (atomic_long_cmpxchg(&ctx->user->locked_vm, cur_pages,
>> +					new_pages) != cur_pages);
>> +
>> +	return 0;
>> +}
>> +
>> +static int io_sqe_buffer_unregister(struct io_ring_ctx *ctx)
>> +{
>> +	int i, j;
>> +
>> +	if (!ctx->user_bufs)
>> +		return -EINVAL;
>> +
>> +	for (i = 0; i < ctx->sq_entries; i++) {
>> +		struct io_mapped_ubuf *imu = &ctx->user_bufs[i];
>> +
>> +		for (j = 0; j < imu->nr_bvecs; j++) {
>> +			set_page_dirty_lock(imu->bvec[j].bv_page);
>> +			put_page(imu->bvec[j].bv_page);
>> +		}
> 
> Hmmm, so we call set_page_dirty() when the gup reference is dropped...
> 
> .....
> 
>> +static int io_sqe_buffer_register(struct io_ring_ctx *ctx, void __user *arg,
>> +				  unsigned nr_args)
>> +{
> 
> .....
> 
>> +		down_write(&current->mm->mmap_sem);
>> +		pret = get_user_pages_longterm(ubuf, nr_pages, FOLL_WRITE,
>> +						pages, NULL);
>> +		up_write(&current->mm->mmap_sem);
> 
> Thought so. This has the same problem as RDMA w.r.t. using
> file-backed mappings for the user buffer.  It is not synchronised
> against truncate, hole punches, async page writeback cleaning the
> page, etc, and so can lead to data corruption and/or kernel panics.
> 
> It also can't be used with DAX because the above problems are
> actually a user-after-free of storage space, not just a dangling
> page reference that can be cleaned up after the gup pin is dropped.
> 
> Perhaps, at least until we solve the GUP problems w.r.t. file backed
> pages and/or add and require file layout leases for these reference,
> we should error out if the  user buffer pages are file-backed
> mappings?

Thanks for taking a look at this.

I'd be fine with that restriction, especially since it can get relaxed
down the line. Do we have an appropriate API for this? And why isn't
get_user_pages_longterm() that exact API already? Would seem that most
(all?) callers of this API is currently broken then.

-- 
Jens Axboe

