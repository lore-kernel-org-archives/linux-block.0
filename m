Return-Path: <SRS0=UuDU=VA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA8C0C0650E
	for <linux-block@archiver.kernel.org>; Wed,  3 Jul 2019 15:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80CF62189E
	for <linux-block@archiver.kernel.org>; Wed,  3 Jul 2019 15:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfGCPOU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Jul 2019 11:14:20 -0400
Received: from mail-pf1-f182.google.com ([209.85.210.182]:35716 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfGCPOT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Jul 2019 11:14:19 -0400
Received: by mail-pf1-f182.google.com with SMTP id u14so250623pfn.2
        for <linux-block@vger.kernel.org>; Wed, 03 Jul 2019 08:14:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=au819//Ef0qqAwi9QrrqFk91YA1jak3mu2OY38eDTaM=;
        b=r1LP2eiqOEpOQK6IyS5rPkcdcb4yWBnp3/G5K6erR49iTeoRPjQ1hR0O1c+DZWPaTp
         rIccFyDfuJpPPY3uhSXb6zeyxJWslWrOJIFcsMHk3cKSKqpg/7O3/NSSSFRpgchvTF9Z
         vGhDVOhqSiKrGyk0u5dyhRkX34ipJ2rzyUsAo+cF/uESsud+oNElcjzuA7MsFSnzDRAf
         VxESZW2lUTlVKRDeqy+H5Zj3hLxh+/10cEggZQVJ/qWJO8DgOTWIT5S8gIZfVrHzF1p0
         z1rpDWV5xCKZCrnmYXNBWU+EK7qSPR9sl3LG9kcC9SvnY20n8qS+FQhx85ypfThejyq4
         QYhA==
X-Gm-Message-State: APjAAAUpau7/98VeAR2mDcXrx924fC7mWFfL+S73WVYZP1dGIEQvI68F
        +VqEMzXB9cYzopBv2Tcq/r7ZU0feCr0=
X-Google-Smtp-Source: APXvYqz9VvijXSHi5BZSw++YraSQrfNjeusbaUWnJuoWQPiwAyzFOVx1qJjTm5JvzkoxfmmjvFqxWQ==
X-Received: by 2002:a63:3f84:: with SMTP id m126mr36626586pga.213.1562166858702;
        Wed, 03 Jul 2019 08:14:18 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id g6sm2375362pgh.64.2019.07.03.08.14.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 08:14:17 -0700 (PDT)
Subject: Re: [PATCH] block: Document the bio splitting functions
To:     Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>, linux-block@vger.kernel.org
References: <20190701162328.216266-1-bvanassche@acm.org>
 <febb2570-5b5f-2283-c0af-784ef4d6475e@suse.de>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <77f37e93-2b77-2540-7da8-322ff3c4ce4b@acm.org>
Date:   Wed, 3 Jul 2019 08:14:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <febb2570-5b5f-2283-c0af-784ef4d6475e@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/2/19 12:39 AM, Hannes Reinecke wrote:
> Could you add a reference to the bio_set in those descriptions, too?
> It's really non-obvious that 'split' will reference the bio_set of the
> queue, and hence the queue _must not_ go away while the bio is allocated.
> This becomes especially tricky if the bio is remapped to another queue
> later on, as then we'll lose the reference to the original queue, and
> have no idea that suddenly we have a bio with references to _two_
> request queues.

Hi Hannes,

Thanks for having taken a look. I will update this patch as proposed and 
repost it.

Bart.
