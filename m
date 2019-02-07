Return-Path: <SRS0=wMCK=QO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 767B7C282C2
	for <linux-block@archiver.kernel.org>; Thu,  7 Feb 2019 22:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4439F21721
	for <linux-block@archiver.kernel.org>; Thu,  7 Feb 2019 22:47:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="dS7jOH9y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbfBGWr2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Feb 2019 17:47:28 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:39309 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbfBGWr2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Feb 2019 17:47:28 -0500
Received: by mail-it1-f195.google.com with SMTP id a6so4228189itl.4
        for <linux-block@vger.kernel.org>; Thu, 07 Feb 2019 14:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=stw+f5UGhv6mGtKazW0Sikoz307xl7l0ipnI/duJVEU=;
        b=dS7jOH9yDWipBNavLYQAyjUc51NR6jAH6/UAtWI9UFq/NxUUQcMR5eFl9ATLiatbbk
         sa7XOPi3mWTB9EtH+zWs8i0zLXmnEkksku17n0/vzbRpsUoFzimvQELtCmAJfvtqEC8m
         3+BvxzKZyZDWNyoR8iL5T8XTUwi668fKWAopsrXNPUGHkWgdlyr/NsdMlnhENL4uBP1A
         o8g8/dV+iUb3hEj6M3KDsRUWfMKaoQjI9W4ggKKjz896lCJ0/pm7l6KR84gjfLLTgdXQ
         Gc7FjAJGwV3wuDkcN4Rijzh9w2rsiEnkAXFyIGK5ZgQz8yiKZWhphgPPJVsivvUijWZd
         QXmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=stw+f5UGhv6mGtKazW0Sikoz307xl7l0ipnI/duJVEU=;
        b=gSCgoHGuQ7gBYEuXO/kd/0CDKtblCFwGt0/3UmxEc/a0iP2Ghlj5lNozOn8dna1FSm
         paahtQpUCmJvx5kczBcUD4bHQuzY6fSCxY6QAgRLcHRf4RcALzcoKdrszvRjKfrAtgG0
         QWLZSkTDro639JdvJdjTAk62U8jsYTOVzjtE9ySQvn35Qk6CrOvwBxFAI9ACWnABHu1z
         gb53s/7Yz347ZzYKP3CO+eg3eY4XujzodymZC61E5/o64STNyJhdPClJJvxJm0m/2ZRZ
         25AyADW6NWjZOk9LFEQYnbqsc/Ze/UuMd7We+ffGrHlu3Pfon/RwMiLeaQp9EH4UV2rP
         Fgyw==
X-Gm-Message-State: AHQUAubmX5NInq04NU1Fv8E/oD0FGrCw/vudpIuGJdbs6aSPvhsm1Yt0
        fPW7RrUeK2yxjR8KzITO/SbQfw==
X-Google-Smtp-Source: AHgI3Ib+R6tqukg0On8aywXNZLFFd3dFlIfCAndFvx/G7IdUdi8v16PpeSgGrq5wsWahtMrEhh7rUQ==
X-Received: by 2002:a02:6:: with SMTP id 6mr9864428jaa.19.1549579647228;
        Thu, 07 Feb 2019 14:47:27 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id r11sm131227iog.46.2019.02.07.14.47.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 14:47:26 -0800 (PST)
Subject: Re: [PATCH 12/18] io_uring: add support for pre-mapped user IO
 buffers
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org, hch@lst.de, avi@scylladb.com,
        jannh@google.com, viro@ZenIV.linux.org.uk
References: <20190207195552.22770-1-axboe@kernel.dk>
 <20190207195552.22770-13-axboe@kernel.dk>
 <x49zhr7442d.fsf@segfault.boston.devel.redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <72dfa45e-0d2e-5966-5343-8d9e2994c2d0@kernel.dk>
Date:   Thu, 7 Feb 2019 15:47:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <x49zhr7442d.fsf@segfault.boston.devel.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/7/19 3:38 PM, Jeff Moyer wrote:
> Hi, Jens,
> 
> Jens Axboe <axboe@kernel.dk> writes:
> 
>> For now, buffers must not be file backed. If file backed buffers are
>> passed in, the registration will fail with -1/EOPNOTSUPP. This
>> restriction may be relaxed in the future.
> 
> [...]
> 
>> +		down_write(&current->mm->mmap_sem);
>> +		pret = get_user_pages_longterm(ubuf, nr_pages, FOLL_WRITE,
>> +						pages, vmas);
>> +		if (pret == nr_pages) {
>> +			/* don't support file backed memory */
>> +			for (j = 0; j < nr_pages; j++) {
>> +				struct vm_area_struct *vma = vmas[j];
>> +
>> +				if (vma->vm_file) {
>> +					ret = -EOPNOTSUPP;
>> +					break;
>> +				}
>> +			}
> 
> Unfortunately, this suffers the same problem as FOLL_ANON.  Huge pages
> are backed by hugetlbfs, and vma->vm_file will be filled in.
> 
> I guess you could check is_file_hugepages(vma->vm_file):
> 
>         if (vma->vm_file &&
>             !is_file_hugepages(vma->vm_file)) {
>                 ret = -EOPNOTSUPP;
>                 break;
>        }
> 
> That works for me.

Thanks, that looks better. Fixed!

-- 
Jens Axboe

