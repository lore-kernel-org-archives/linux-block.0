Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46043C4338F
	for <linux-block@archiver.kernel.org>; Thu,  5 Aug 2021 16:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27C886112F
	for <linux-block@archiver.kernel.org>; Thu,  5 Aug 2021 16:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234761AbhHEQtS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Aug 2021 12:49:18 -0400
Received: from mail-pj1-f47.google.com ([209.85.216.47]:55216 "EHLO
        mail-pj1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234640AbhHEQtQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Aug 2021 12:49:16 -0400
Received: by mail-pj1-f47.google.com with SMTP id a8so10274314pjk.4
        for <linux-block@vger.kernel.org>; Thu, 05 Aug 2021 09:49:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6R27bKvcvu0jA9D+BZ/FUGJ/ht+vJ58i7x+oert3W40=;
        b=p1lzZbg0a6bd1DtEHCaGRe525eZc+vnaSx0zUOGuJjlx+ce9je72QsyYjyjUPfx4Rh
         fQDMuR0WKFbQyCyorSBvGq3tNWyRuzzTdAAoLv7bhyCW7cQp249EZJN75XGQ2NkuVlK9
         XUlwW8L+2AzPF7f3s6GJATeq81lrI5QH5PVB358ouFFqBx2tA0ntqxxxcxXX8fvIkHWD
         BAGNw75cx61v8DRNivu8JGNjlizrS9WNu1/AZBKQAZMuT6egZuekk+zg8XPnDrBY6bMO
         DLDWfRl5C8pWgF1QRZRaf2r6JfJo/R/uy9fcBzMhqpqs/S4ipBH4mlPXOWNqyX5IcUf1
         tlIA==
X-Gm-Message-State: AOAM532iFmpdawrHzy92jdjJm5y/LF+JW7DlJiTC9Nq/MD+faCWSbiIE
        69HqxipxOduiC/i7+K07fUc=
X-Google-Smtp-Source: ABdhPJy72e9KLuN0Fq7yu9p4LCzeSxI2e5loJMM06ap0fSwi0R8C2WEiLd4lQZY7dKtNZrf7rwOAJA==
X-Received: by 2002:a17:90b:4c49:: with SMTP id np9mr16590957pjb.210.1628182142274;
        Thu, 05 Aug 2021 09:49:02 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:1:93c2:eaf5:530d:627d])
        by smtp.gmail.com with ESMTPSA id z18sm3078746pfn.88.2021.08.05.09.49.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Aug 2021 09:49:01 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] loop: Select I/O scheduler 'none' from inside
 add_disk()
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Martijn Coenen <maco@android.com>
References: <20210803182304.365053-1-bvanassche@acm.org>
 <20210803182304.365053-3-bvanassche@acm.org> <YQn924DHk4axOUso@T590>
 <bbecb701-48d6-bdfa-2d41-afb6c48a8254@acm.org> <YQtaWz7EtkNAtIkY@T590>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <ed738693-0a08-8047-7300-e84b4e3b6cd5@acm.org>
Date:   Thu, 5 Aug 2021 09:49:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YQtaWz7EtkNAtIkY@T590>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/4/21 8:26 PM, Ming Lei wrote:
> On Wed, Aug 04, 2021 at 10:43:05AM -0700, Bart Van Assche wrote:
>> Thanks for having suggested an alternative. However, isn't the above a
>> policy? Shouldn't a kernel provide mechanisms instead of policies?
> 
> REQ_SWAP means it is one IO written to swap device/file, so the system
> is suffering memory pressure, then isn't it reasonable to bypass io
> scheduler for all SWAP IOs?

Hmm ... I'm not sure that approach is ideal when swapping to a hard disk.

>> Additionally, the above patch does not address all Android loop driver use
>> cases. Reading APEX files is regular I/O and hence REQ_SWAP is not set while
>> reading from APEX files.
> 
> Is APEX file one swap file? If not, can you explain it a bit why you want to
> switch to none when reading APEX file?

As far as I know Android uses the loop driver for two purposes:
- A zram instance is used as swap device and the zram instance is
   configured to use a loop device.
- apexd mounts APEX files read-only and uses the loop driver to access
   these files as a block device.

Bart.
