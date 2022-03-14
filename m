Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C50D2C433EF
	for <linux-block@archiver.kernel.org>; Mon, 14 Mar 2022 20:07:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234180AbiCNUIS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Mar 2022 16:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244931AbiCNUHs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Mar 2022 16:07:48 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6646F40A28
        for <linux-block@vger.kernel.org>; Mon, 14 Mar 2022 13:06:38 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id 195so19802232iou.0
        for <linux-block@vger.kernel.org>; Mon, 14 Mar 2022 13:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=pNK/mLCgZ08MWUxMB3jRjHDWa9CxmXckF+z5BU9c/js=;
        b=4kHOuCERNruRuZHNwoTUS+Qa525lSX1f4JvIs+FPT6KSZwPUwvkiSztroFhdqUYsap
         ZrS6qUl0bQOFK1BbrL1YXmWDrNJIT15+umgn/M7cBjxNokbnL3l5upF99BT5Ai476hda
         e7Jp0fAIfC/we3KGtvLyEXyLERpp3NsNG9cpyQepB5WyNClvHI+1wsc5RykkmJzfZP5r
         d96oYMyxWgUPYMGkMH54g1yUxVenRFoK2StUzmsQpSdBzYL3WRWbWO3arAQFmmzHsg5f
         OS9tkcvqnJDYDr7+eWZEALyWTmxk93WKCGgIY4HaNV3w2P8vsEp0I3TbNdAkjcvrAzCc
         YKdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pNK/mLCgZ08MWUxMB3jRjHDWa9CxmXckF+z5BU9c/js=;
        b=iM5ozJIkLTMKDKvzEQEQKOUI0aI4U2ddL0GtLQJYJtNAbSxYlxr8eQeEHj3zmEYy5q
         BCpgvIQCQxjzJ1x6wgunsAjr5G9o9FlXrkkZ5btFlG22BsE7kbppyiZ41t2JTruRDdY2
         nCs52XFX+8n/rEEnyx4t5fanXO8jLFIAP5GMe4FEO3ZWoFAv/vmnNR7sXJ7REf4x6Afm
         /FlnMaPT/O8xz5MzJTXqbj/FM2KIIhxStpJgwpGiNznMyr20WCaIiidnm4E0/jmj95OJ
         DMckrHbkANfPWHRjY8eCf2g3THKVWWPRt5pqTyewCpYJvEAjsdJMPjm2N/hc/DJd+F/6
         ARWQ==
X-Gm-Message-State: AOAM531YO00iTqmLiVhdSLMdnzwdpKnHq/HHvqwN+wJpKNkA2eV5rwk9
        l+GUMJYQ+0LYkSpgWJt7KtD7cg==
X-Google-Smtp-Source: ABdhPJxpltXYVgjr7+HOEGz9h4e31kr6H0zOlScN+VqNzc44T677L54zAPCZD13JOCIyK0HfVegUkw==
X-Received: by 2002:a05:6638:2686:b0:319:acb4:46e6 with SMTP id o6-20020a056638268600b00319acb446e6mr21036767jat.231.1647288397782;
        Mon, 14 Mar 2022 13:06:37 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id s3-20020a056e021a0300b002c7a545c3c3sm1913809ild.66.2022.03.14.13.06.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Mar 2022 13:06:37 -0700 (PDT)
Message-ID: <57c08222-cf24-605b-ed51-5338698e55bd@kernel.dk>
Date:   Mon, 14 Mar 2022 14:06:36 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] block: release rq qos structures for queue without disk
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        stable@vger.kernel.org,
        syzbot+b42749a851a47a0f581b@syzkaller.appspotmail.com
References: <20220314043018.177141-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220314043018.177141-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/13/22 10:30 PM, Ming Lei wrote:
> blkcg_init_queue() may add rq qos structures to request queue, previously
> blk_cleanup_queue() calls rq_qos_exit() to release them, but commit
> 8e141f9eb803 ("block: drain file system I/O on del_gendisk")
> moves rq_qos_exit() into del_gendisk(), so memory leak is caused
> because queues may not have disk, such as un-present scsi luns, nvme
> admin queue, ...
> 
> Fixes the issue by adding rq_qos_exit() to blk_cleanup_queue() back.
> 
> BTW, v5.18 won't need this patch any more since we move
> blkcg_init_queue()/blkcg_exit_queue() into disk allocation/release
> handler, and patches have been in for-5.18/block.

Applied, but it's a bit strange to send a 5.17 only patch against the
5.18 tree... Hand applied.

-- 
Jens Axboe

