Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 482C7C433FE
	for <linux-block@archiver.kernel.org>; Mon, 28 Nov 2022 19:08:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbiK1TIx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Nov 2022 14:08:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbiK1TIv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Nov 2022 14:08:51 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB6E28735
        for <linux-block@vger.kernel.org>; Mon, 28 Nov 2022 11:08:50 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id k2-20020a17090a4c8200b002187cce2f92so14985528pjh.2
        for <linux-block@vger.kernel.org>; Mon, 28 Nov 2022 11:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vdiFLWGJlZNZEhU3chxdhx2hGdjjeSZKpnJnffDHCx4=;
        b=Q5XoN2CjIrbe+48L5bUfjZfu0U8JKd099j/FY7bwNTUH3aWmw9cAnqT8EgROl9fO4C
         qOJNJTIm54HvYo6ESRa+AGqTKFtczOfLgtde/tjYAQUNfe4U748t/psuR81Mo6eR6XDK
         sXlXiUBIXotQbcclPXQsaJq4Z9p3B5Dj4QF7c2XCk+w+z7/wrBnMz2rI26+IzJPJmuGO
         JKaYF8JhouN3XgWuhpIqqQ6dEd1oqnjkTbX4EWZ5r+qE4YJcamhZhJhQO252DrRpLJS/
         +shfuyh0O9KPr6c/aUrEpA6d1zQ2Pt/J0pfypcEynvs9EKZn9rve8Xm4ZoTR7+fcJ4XX
         7FTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vdiFLWGJlZNZEhU3chxdhx2hGdjjeSZKpnJnffDHCx4=;
        b=5MGJGOQC466Jbj+J0Njv9jXXwf+KjsYRUJCmI0f7ripMTQJHiwdR4/bqpX77/b20j+
         XQ1UQe6OH9RKtUJo2ub17o8M8lKf6/dG0OZfmfQjSVVsbwl2/dFDMmEZFQ8zM7PGQzDs
         NQe3juEtAHiB4qTZWEds6f30dNa0Rnsqdrc6/9UH5o6FE3EthdoCMNqs7V47TUnEajgp
         53rGetEahhx6RUTfwHIL827vp8//INF0gFi+oLXERaoHI5jB9excv00+/X7CdWoN8ict
         ANHFew14WnWO8FwyUZPAkRewZk38N2XbOoCvPdGX2s29xAHwWtqKoOs8nVkH9eBjCyAj
         2ySw==
X-Gm-Message-State: ANoB5pn2OsJX1quX/PkWvp3JGt+wj+TYj1Sun0mB+JcetkEcvXZHhd63
        IS0KxJP5XzcnYYQSOC3cq2s7zQ==
X-Google-Smtp-Source: AA0mqf58eO2rHe3Xr1xr78aQJvkKp/cyJMeBI5F2x7pd0MEGGkcfWTx6fI+wdxL/kuKyRwBa07WrdA==
X-Received: by 2002:a17:902:f651:b0:187:190f:6aa7 with SMTP id m17-20020a170902f65100b00187190f6aa7mr35345914plg.131.1669662529792;
        Mon, 28 Nov 2022 11:08:49 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 6-20020a170902c14600b00187197c499asm9208642plj.164.2022.11.28.11.08.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 11:08:48 -0800 (PST)
Message-ID: <0390c62d-11d9-5d89-ad88-db38526b74e6@kernel.dk>
Date:   Mon, 28 Nov 2022 12:08:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH-block] blk-cgroup: Use css_tryget() in
 blkcg_destroy_blkgs()
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Hillf Danton <hdanton@sina.com>, Yi Zhang <yi.zhang@redhat.com>
References: <20221128033057.1279383-1-longman@redhat.com>
 <d08a0059-7c0b-d65f-d184-5b0cb75c08ed@acm.org>
 <f89e922c-16d5-0bcf-7e7e-096f42793a36@kernel.dk>
 <Y4UG9H9QsMnCvN+D@smile.fi.intel.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y4UG9H9QsMnCvN+D@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/28/22 12:07 PM, Andy Shevchenko wrote:
> On Mon, Nov 28, 2022 at 12:00:55PM -0700, Jens Axboe wrote:
>> On 11/28/22 11:56 AM, Bart Van Assche wrote:
>>> On 11/27/22 19:30, Waiman Long wrote:
>>>> Fixes: 951d1e94801f ("blk-cgroup: Flush stats at blkgs destruction path")
>>>
>>> Has Jens' for-next branch perhaps been rebased? I see the following commit ID for that patch:
>>>
>>> dae590a6c96c ("blk-cgroup: Flush stats at blkgs destruction path")
>>
>> I don't know that sha is from, not from me. for-6.2/block has not been
>> rebased, for-next gets rebased whenever I need to do so as linux-next is
>> continually rebased anyway. But the sha for that commit would not change
>> as a result.
>>
>> I don't even have that sha in my tree, so...
> 
> $ git tag --contains dae590a6c96c
> next-20221117
> next-20221118
> next-20221121
> next-20221122
> next-20221123
> next-20221124
> next-20221125
> next-20221128

That is the right sha, I'm talking about the fixes line in the
patch you're replying to:

Fixes: 951d1e94801f ("blk-cgroup: Flush stats at blkgs destruction path")

which is certainly not from my tree.

-- 
Jens Axboe


