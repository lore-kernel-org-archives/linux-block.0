Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22081C4338F
	for <linux-block@archiver.kernel.org>; Wed,  4 Aug 2021 17:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F182A60E78
	for <linux-block@archiver.kernel.org>; Wed,  4 Aug 2021 17:39:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234283AbhHDRjN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Aug 2021 13:39:13 -0400
Received: from mail-pl1-f170.google.com ([209.85.214.170]:34444 "EHLO
        mail-pl1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbhHDRjM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Aug 2021 13:39:12 -0400
Received: by mail-pl1-f170.google.com with SMTP id d1so3817751pll.1
        for <linux-block@vger.kernel.org>; Wed, 04 Aug 2021 10:38:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=35tmvDoxIDdxsV5RuU9E3kNQIB8zkS61UYEvB+q7zF8=;
        b=LzH6/m9LzO83UanVdgThtpS65+EbivlzpPtGz0s3XZjY9VThYrxqJaToXtU+tzITtL
         ZnJsjhM+F3NHtg2KCPsVEzIIEvkou2Kifz2FNdoRUdFNU8f0U7iAy0qgEHKXhPu6oL+k
         wozMAlw9zoTA/0Am8TaNqm+RE5cjCcIeutd6HFkzXhudqyHDwFqcD0YJriRysZ0yHgbB
         wCzlPhEoinkP5UQzmNbfN/Nki3ugPGPwf0L0OPLhpv8aXMmtQkRwl85nVhJO7ofJclnO
         JCQdz5Dv3J5u9QI+94NVmX34+Itjz8fZECU8mZI7SMyTV1pmYT/HsxvI10gaUnERfFSQ
         m2Rg==
X-Gm-Message-State: AOAM532GtRNYcRK7RQlYdsQ5SS/CKZYX4lGr6JxOHhpWWsZKsa6sik6W
        VhU/qw5gdKDY5FiaGtsCQHc=
X-Google-Smtp-Source: ABdhPJyFD6cA/w37MYtAN21hilsP7eyi/Xzs0/p/GXsoL8VheWcHv8ziynynlth7pHi7dc4UmlzbiA==
X-Received: by 2002:a17:90a:1f49:: with SMTP id y9mr10813040pjy.225.1628098738759;
        Wed, 04 Aug 2021 10:38:58 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:1:8587:b3fe:5419:1ed7])
        by smtp.gmail.com with ESMTPSA id s3sm3487152pfk.61.2021.08.04.10.38.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Aug 2021 10:38:57 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] loop: Add the default_queue_depth kernel module
 parameter
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Martijn Coenen <maco@android.com>
References: <20210803182304.365053-1-bvanassche@acm.org>
 <20210803182304.365053-4-bvanassche@acm.org> <YQouvmh3rTDz2WIE@kroah.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <a7a8da9f-a413-8b43-0025-34a9d7dcd3c9@acm.org>
Date:   Wed, 4 Aug 2021 10:38:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YQouvmh3rTDz2WIE@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/3/21 11:07 PM, Greg KH wrote:
> Should we just bump it up anyway given that modern memory limits are
> probably more now?

As mentioned in the patch description, this patch is not about saving 
memory but about reducing latency. Reducing the queue depth to control 
latency is a common approach for block storage. See e.g. the description 
of CONFIG_BLK_WBT in block/Kconfig.

You may want to know that I looked into reducing the queue depth from 
user space before I came up with this kernel patch 
(https://android-review.googlesource.com/c/platform/system/core/+/1783847/6). 
However, making that approach work requires significant changes in the 
Android SELinux sysfs labeling policy. From my point of view, modifying 
the kernel is much less painful than reworking the Android SELinux 
labeling policy.

Bart.
