Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:35445 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754256AbdC3OCo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Mar 2017 10:02:44 -0400
Subject: Re: [PATCH] block: do not put mq context in blk_mq_alloc_request_hctx
To: Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@fb.com>
References: <1490851245-32245-1-git-send-email-minchan@kernel.org>
Cc: kernel-team@lge.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Omar Sandoval <osandov@fb.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <77b5301c-9f17-30d1-61b2-5403ba316857@grimberg.me>
Date: Thu, 30 Mar 2017 17:02:39 +0300
MIME-Version: 1.0
In-Reply-To: <1490851245-32245-1-git-send-email-minchan@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
