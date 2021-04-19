Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 947F8C433ED
	for <linux-block@archiver.kernel.org>; Mon, 19 Apr 2021 17:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6528761246
	for <linux-block@archiver.kernel.org>; Mon, 19 Apr 2021 17:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240201AbhDSRzr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Apr 2021 13:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234295AbhDSRzr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Apr 2021 13:55:47 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D32CC06174A
        for <linux-block@vger.kernel.org>; Mon, 19 Apr 2021 10:55:17 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id s16so30486894iog.9
        for <linux-block@vger.kernel.org>; Mon, 19 Apr 2021 10:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jglTKLzgYrIesctY2vQtD/xz1Et5JU6BMu4jYWlw8VY=;
        b=FgTNkyKppqce+NQy4HO0Ep5Vv79tFHDyknAm4tTCJUH9t9/Lk52vArfZr+2l2a7GFP
         4eq4LKc1IfOaRbn1pJdIx61icuKdsEMp2e+RAXP7tZFhEL1N4YFvRSfOdDNi30QXMH4V
         wbXC/9crwFZQRL8UMrDYAfNwHJyf3t9cUEEM+7mB4KiXvoJHB87CvMmUk94DE1Q0Kr2g
         ZimNHrfo/MmBFKVuqxwhZzWyarNUvhQseM1yKcW4TobIKURbQv8n+Aqxb3wJVrQomlYH
         BbfCWNRItyAu8eRYLkxIJ3OY0I48a1I94cb5p3c3ecTEZHzqMIAttCnPhKnZc5JmbKYM
         TYbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jglTKLzgYrIesctY2vQtD/xz1Et5JU6BMu4jYWlw8VY=;
        b=XLgJVFiCtB2MeYGYgjp83Fpr65VVBvR98ps5rN1pu3wwUFIc5XOLna4jzuXpB/dUZS
         4KZfgvsrk9GRw7GnN1Mh9rsnnrOj95mFjolJbUz0MMBP9A4I3/RAyje2FFrOCOWl2rMe
         bdF72l2vtfRNFyaqhHYNLt7ziXoI6+nbw4u5/Hd0vJDbn78OmaUDD4IJOG8CMSiXlb1b
         vx1JR6U2mqjBcC9Df2ABkVVM0siZtyTtAhSIeIWKKwEhQFKutxch+ZfQwWmZrIIj7XGR
         rKKvIrprlGoxAwsmyIAPbyZ9MDzyTmQLS0nd7Vl5oJsxqr1AL6kRlLWOncl5nEMVVwz7
         fy2A==
X-Gm-Message-State: AOAM530YivxGQQsrZf20Eh0t4BWoBFkDHEUjww3DSzQgiB6zu9vG3krC
        emh8HlYqBnF2ap9yhCDQYrBU5rQ9Gv18mg==
X-Google-Smtp-Source: ABdhPJzAAgS7yPtv/xQPdx67Wa8k/XVcEGnFHfZAWdmZ6s5ksqq23odwaFOIDSEA3AVagDRR9R8B1Q==
X-Received: by 2002:a02:c492:: with SMTP id t18mr14761605jam.59.1618854916068;
        Mon, 19 Apr 2021 10:55:16 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id h4sm7249858ili.52.2021.04.19.10.55.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Apr 2021 10:55:15 -0700 (PDT)
Subject: Re: [PATCH] blkparse: Print time when trace was started
To:     Jan Kara <jack@suse.cz>
Cc:     linux-block@vger.kernel.org
References: <20210113112643.12893-1-jack@suse.cz>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <28c4b538-d39b-79be-a5e8-2a5af5c5069a@kernel.dk>
Date:   Mon, 19 Apr 2021 11:55:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210113112643.12893-1-jack@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/13/21 4:26 AM, Jan Kara wrote:
> For correlating blktrace data with other information, it is useful to
> know when the trace has been captured. Since the absolute timestamp
> is contained in the blktrace file, just output it.

Applied, thanks.

-- 
Jens Axboe

