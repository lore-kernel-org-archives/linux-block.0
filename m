Return-Path: <SRS0=8+4U=63=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52DA9C2D0F6
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 02:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EBEF2176D
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 02:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="O+E+nmis"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbgEMCdO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 May 2020 22:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbgEMCdO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 May 2020 22:33:14 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3646BC061A0C
        for <linux-block@vger.kernel.org>; Tue, 12 May 2020 19:33:14 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id y9so3638273plk.10
        for <linux-block@vger.kernel.org>; Tue, 12 May 2020 19:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JBJSD5laxyspTTIoYkWCQTwgMbC24QNWN7qcdj5RGiM=;
        b=O+E+nmis3jYIIkjVLoqcTo2+dOIB96GzN8uTWUFWBAZWN/wltupJZFpH/GXgdYZNPl
         lE5B4Nna0P5e2rRJ3SFhZtoJKAYO7jHAxZsdpBkfY1gL3Mu0LM4ZZDbJRFhV7Q7xU8y2
         8/pro4AEr1b0yJ+pfLELblzMMH1Xo9oivAbkziWF35QW6Rdk7OUU9KFgVQxGOf+6EHYb
         9E30FRKLKo6P43BNDItuWKIgEkeWXJ+DSO5bQJpFgSR4TQn06c3OqeyAb+NExQ313YYo
         ZdLHXEeqnv3eWPzE9VpWaDpIQ0medHmIs7KhYaTd5eDF2yA634wq18aYr6n7BoJTDyNQ
         OPMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JBJSD5laxyspTTIoYkWCQTwgMbC24QNWN7qcdj5RGiM=;
        b=acwj0iUe+3Sq5kMA2O66zPf5bhH+90HNbOtEhNVLp6VjXF9HYTBBQA0SynfIWozxmD
         Nl+ZH56tMRXnOeecxkOVE6nxsb3NY0Gm92o1LMK8rje+6lL30PXRWQaPqMAAuMAV5vaL
         e8ZTe9rBgfx+I7M+LhBRLozK052BEUzklbBTWBkS6aM8tHafWcZLPGfq3+M+3aWA3bBL
         GWRqgEA5wMCJpMf54lVZk5j87M3PFlNJJqLrrqGGeup7OdjhgMwdrbvVRDLQMqb/OF8K
         2Pld1slv96YBlPO9cyZqdgo1KJ0gjno13ffqi3E+gTmysVLjwqV5hoiCMws/UtrpbKC1
         Jn0w==
X-Gm-Message-State: AGi0PuZM0uhcKGkfqKbtA8OHNyAEyMAh+ZleldfFKrSEixUEm/gNtRW6
        smk1rRL9iUvfgY6/NQC4upkPFQ==
X-Google-Smtp-Source: APiQypLIc6CIlCz4OivRgh8tFxHQQVo+ZfhPzYUMjt2At9lId9Vo2V1smLcKILY6Bqk2P/hTKB7p4g==
X-Received: by 2002:a17:902:70c6:: with SMTP id l6mr20949996plt.31.1589337193670;
        Tue, 12 May 2020 19:33:13 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:1d8:eb9:1d84:211c? ([2605:e000:100e:8c61:1d8:eb9:1d84:211c])
        by smtp.gmail.com with ESMTPSA id c14sm11702057pgi.54.2020.05.12.19.33.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2020 19:33:13 -0700 (PDT)
Subject: Re: [PATCH V2] block: add blk_io_schedule() for avoiding task hung in
 sync dio
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Salman Qazi <sqazi@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>
References: <20200503015422.1123994-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <32f8355c-d18a-b962-1d7a-1ca87558cecc@kernel.dk>
Date:   Tue, 12 May 2020 20:33:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200503015422.1123994-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/2/20 7:54 PM, Ming Lei wrote:
> Sync dio could be big, or may take long time in discard or in case of
> IO failure.
> 
> We have prevented task hung in submit_bio_wait() and blk_execute_rq(),
> so apply the same trick for prevent task hung from happening in sync dio.
> 
> Add helper of blk_io_schedule() and use io_schedule_timeout() to prevent
> task hung warning.

Applied, thanks.

-- 
Jens Axboe

