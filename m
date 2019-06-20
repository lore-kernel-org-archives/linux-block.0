Return-Path: <SRS0=D4S7=UT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C67FC43613
	for <linux-block@archiver.kernel.org>; Thu, 20 Jun 2019 09:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 583752082C
	for <linux-block@archiver.kernel.org>; Thu, 20 Jun 2019 09:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Bo3SAk17"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbfFTJ3x (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Jun 2019 05:29:53 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:46697 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfFTJ3x (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Jun 2019 05:29:53 -0400
Received: by mail-yb1-f193.google.com with SMTP id p8so956171ybo.13
        for <linux-block@vger.kernel.org>; Thu, 20 Jun 2019 02:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hj2LK8IWRYBdQ0R1r6pmm07xyZU9AXmd7btS3Jqax5U=;
        b=Bo3SAk17rTWl5zOPk2OgnCMZqs9lRWwiIQS4YR3VUA8VmvI48o4gu7+7OloFoGYlwN
         AkvE5Bfmi0BVjgYJHtP0LQQ0AYKFew9e7Xt0h+2Kakr+tXX4+P1CZXU9cbF6KbfSDhaM
         17KL3fxJaDVdNGOXTaeomYp48XP32+2Cvx2+QNzyLr3UaKk8tmMxEFr6b+YEel0Aio5c
         lsSHeM/VWSS2U86RqnANlLJXTINZxTGcTFbOQEnm7naIwnm7sqsbgWj5RAqJRbAU/j7O
         ZGJfaTdmhLpjkmmvo0q749pwa3mkxgwvHhrlpFN7bH8crdhyfVEQmQikUqOmMHYK5p2S
         s7uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hj2LK8IWRYBdQ0R1r6pmm07xyZU9AXmd7btS3Jqax5U=;
        b=Xrpqed6GnjN8iYZCeeAKwloeaX6PiFcBCqLwq7TYTCuEswHlJGdYMtX57RIxlXhDH8
         yCN3ixWwc3lj8GfXuZvwShr+1pVX159Ydgr4X3uB4ohQfao933tTRoXL8HTOXU6VGoIP
         4UhNbDheLo2trwlNjPhEy7yaQgzLv0SJAjwjjTtIe24fgl343VXJn0imslHCkl4fK6vA
         ZG1+W5VEQiu79kp3rWyE02PoxlXqiLzTm9PjukNR1ZJ86X5OGWtZWnv3fdXOhLjXko39
         XUiAC6ZABLbjOBMxteesKwG3GtQ0L9Rzo83ZEFklw69ECdsf33qdnUb7InCWk+w4HdgG
         IImA==
X-Gm-Message-State: APjAAAVTUrkmDmz8Q+sPsQvc6pELen/XdNsssS7XeB3KDssxgTYXQrF7
        Fuw7XtnJx2mc3K7z5RwU7Flzjw==
X-Google-Smtp-Source: APXvYqyWpX5kcQzhqQVr831NmEzD6uXasQb3bUu/eTNGZZmi3oHFZ1zTiFIotPiCj4RaxWT2pGGI9w==
X-Received: by 2002:a25:d98a:: with SMTP id q132mr63412471ybg.19.1561022992869;
        Thu, 20 Jun 2019 02:29:52 -0700 (PDT)
Received: from ?IPv6:2600:380:5278:90d8:9c74:6b59:c9f5:5bd0? ([2600:380:5278:90d8:9c74:6b59:c9f5:5bd0])
        by smtp.gmail.com with ESMTPSA id 144sm5343556ywb.66.2019.06.20.02.29.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 02:29:52 -0700 (PDT)
Subject: Re: [PATCH] blk-iolatency: only account submitted bios
To:     Dennis Zhou <dennis@kernel.org>, Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190523201018.49615-1-dennis@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <11086c9d-7d73-bcc4-1427-ac7807397997@kernel.dk>
Date:   Thu, 20 Jun 2019 03:29:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190523201018.49615-1-dennis@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/23/19 2:10 PM, Dennis Zhou wrote:
> As is, iolatency recognizes done_bio and cleanup as ending paths. If a
> request is marked REQ_NOWAIT and fails to get a request, the bio is
> cleaned up via rq_qos_cleanup() and ended in bio_wouldblock_error().
> This results in underflowing the inflight counter. Fix this by only
> accounting bios that were actually submitted.

Looks good to me, applied.

-- 
Jens Axboe

