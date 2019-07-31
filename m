Return-Path: <SRS0=Z/SB=V4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A88C32751
	for <linux-block@archiver.kernel.org>; Wed, 31 Jul 2019 18:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D80AF206B8
	for <linux-block@archiver.kernel.org>; Wed, 31 Jul 2019 18:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbfGaS0M (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 31 Jul 2019 14:26:12 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35455 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbfGaS0L (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 Jul 2019 14:26:11 -0400
Received: by mail-pf1-f194.google.com with SMTP id u14so32356712pfn.2
        for <linux-block@vger.kernel.org>; Wed, 31 Jul 2019 11:26:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kOUuo3B7wP1IxpJEhJeE2+QKmdnkYNzV2WKgNyojcVw=;
        b=ktpoXsTR7Jz5w+GUVITCyv5VDL1wym1pERHZgQMlXNndj5a03n3oMefC/sZQPXaqcA
         GsxSHfaStTiO4DE7SSgxKPkVv5s2PPhSvHbCKDazdRjN7XTBrSa7nlcz+FPdn+ODGQGJ
         HHPhbFqEwXbLk9mnTVqN0w27lboYI1QmOvqfT6oQ0EEUK8gQiDoOLWRpY3TPCjUVzoIp
         jrZQPDeBJVCzOmVZIOVlypBcGP4ppfSyUEwi25tpSal0at8L+PXJNmnsN99N0rcz2DM3
         tvkAr3WTFeHWk69XAZeka2wuWbHu3kkmbKvoyfvL4JnA28onNJybxq+VekW/n9BQi1y2
         OBzw==
X-Gm-Message-State: APjAAAUAxwGzBdtHLldqG2Yvgj0MeG0fJeKHRkp2i/LyEaQsstE5kEvE
        ElaWBWKzAxOUgWs1yptmLhU=
X-Google-Smtp-Source: APXvYqxtnEfBBmTDAzzCW8IiE+Z0cwXllSlN6Vv/lijRo6G2SWRK3fNDU+rbwIr8vk4wJAyGT+EItg==
X-Received: by 2002:a17:90a:258b:: with SMTP id k11mr4103447pje.110.1564597571145;
        Wed, 31 Jul 2019 11:26:11 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id s67sm2778674pjb.8.2019.07.31.11.26.09
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 11:26:09 -0700 (PDT)
Subject: Re: [PATCH 1/2] block: Verify whether blk_queue_enter() is used when
 necessary
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Alexandru Moise <00moses.alexander00@gmail.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
References: <20190730181757.248832-1-bvanassche@acm.org>
 <20190730181757.248832-2-bvanassche@acm.org>
 <20190731014643.GA4822@ming.t460p>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <d24cba3d-1ba3-22bf-1223-e25264ca4084@acm.org>
Date:   Wed, 31 Jul 2019 11:26:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190731014643.GA4822@ming.t460p>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/30/19 6:46 PM, Ming Lei wrote:
> On Tue, Jul 30, 2019 at 11:17:56AM -0700, Bart Van Assche wrote:
>> It is required to protect blkg_lookup() calls with a blk_queue_enter() /
>> blk_queue_exit() pair. Since it is nontrivial to verify whether this is
> 
> Could you explain the reason why the blk_queue_enter()/blk_queue_exit()
> pair is required for blkg_lookup()? And comment on blkg_lookup() only
> mentioned RCU read lock is needed.
> 
> The request queue reference counter is supposed to be held for any
> caller of submit_bio(), why isn't that ref count enough?

This patch was added to my own tree before commit
47cdee29ef9d ("block: move blk_exit_queue into __blk_release_queue") 
went upstream. Since blk_exit_queue() has been moved from 
blk_cleanup_queue() into __blk_release_queue() I don' think that we 
need this patch series. I will drop these two patches.

Bart.
