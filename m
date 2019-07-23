Return-Path: <SRS0=ppXp=VU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FFC9C76190
	for <linux-block@archiver.kernel.org>; Tue, 23 Jul 2019 15:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0CEA217D4
	for <linux-block@archiver.kernel.org>; Tue, 23 Jul 2019 15:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725601AbfGWPj4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Jul 2019 11:39:56 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41101 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388432AbfGWPjz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Jul 2019 11:39:55 -0400
Received: by mail-pl1-f194.google.com with SMTP id m9so20669920pls.8
        for <linux-block@vger.kernel.org>; Tue, 23 Jul 2019 08:39:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PMNkmI0JwKIWE38ndwkoXj7J/daKkC19/6Ub5V3Y2Uo=;
        b=FettHZjDVlASy/OITko+42iAYw/87LTOnphg9kMBSYR7SRi8DCymP36DgsFXcFty1d
         bJCo1tV0Bap7yJMutn06OEBclv6RsaD5ovMpgRA6IOjd35Evj9MfoNjrOnfgoBntXiat
         6PG9iONaxA8RAosUhyOSwmJyaG2yN7hD6izEK0M/OYM+IZD7zE3Jkqe77QsD9l3G1Eq0
         PmqAjjQq8qdcY//z4CxQEaV6E6ZsOPygfm8dYLXJ4Fn3sXNy3NNxchA7s1B/mrAiKmh6
         McLhsfiipn3vuoZhdJRCdeR37tHss1d6SZGlLFT+8CiSnJEWUxITA+Y8eECB/hItPXm/
         L7tw==
X-Gm-Message-State: APjAAAVPeuCfY9akavCkh9yv2oyWqFY9ehdMg0cnsWNUa9uyMka1+38F
        ZkEvZ2eI+rx0JAmxXBEwEOs=
X-Google-Smtp-Source: APXvYqzMo+kM0avCroGH08NhAlDstB0YiN01vwaXysJ8IgORSbPvOTc9KJmMIlYT3bEVaKHKNRD6mg==
X-Received: by 2002:a17:902:e282:: with SMTP id cf2mr82220094plb.301.1563896394656;
        Tue, 23 Jul 2019 08:39:54 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id n7sm49298814pff.59.2019.07.23.08.39.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2019 08:39:53 -0700 (PDT)
Subject: Re: [PATCH 3/5] block: Micro-optimize bvec_split_segs()
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>
References: <20190722171210.149443-1-bvanassche@acm.org>
 <20190722171210.149443-4-bvanassche@acm.org>
 <20190723082058.GC3997@x250.microfocus.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <28419fcf-63a7-62e1-e91d-00ddd3ecb69e@acm.org>
Date:   Tue, 23 Jul 2019 08:39:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190723082058.GC3997@x250.microfocus.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/23/19 1:20 AM, Johannes Thumshirn wrote:
> Although I'm always interested in performance numbers when a patch claims to
> (micro) optimize something.

Maybe I should have used the word "Simplify" in the patch subject. 
Anyway, thanks for the review.

Bart.


