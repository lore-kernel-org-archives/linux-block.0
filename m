Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: Fix unneeded NULL check
To: Ding Xiang <dingxiang@cmss.chinamobile.com>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <1535441413-8583-1-git-send-email-dingxiang@cmss.chinamobile.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <cd7ff39a-fc3b-0938-ad3b-fc070d937aa7@kernel.dk>
Date: Tue, 28 Aug 2018 08:38:17 -0600
MIME-Version: 1.0
In-Reply-To: <1535441413-8583-1-git-send-email-dingxiang@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 8/28/18 1:30 AM, Ding Xiang wrote:
> if icq_cache is null, kmem_cache_destroy will do nothing.
> So, remove the null check.

Identical patch is already queued up:

http://git.kernel.dk/cgit/linux-block/commit/?h=for-linus&id=62d2a1940709198a522a43ff8be8b8f6b3654dec

-- 
Jens Axboe
