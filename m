Return-Path: <prvs=629101232e=axboe@fb.com>
Subject: Re: [PATCH] nbd: fix use after free on module unload
To: Josef Bacik <josef@toxicpanda.com>, <axboe@kernel.dk>,
        <nbd-general@lists.sourceforge.net>, <linux-block@vger.kernel.org>,
        <kernel-team@fb.com>
References: <1493387359-9496-1-git-send-email-jbacik@fb.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <ec758c0a-da9d-ae5a-04cf-b22b79b4cae3@fb.com>
Date: Fri, 28 Apr 2017 08:14:58 -0600
MIME-Version: 1.0
In-Reply-To: <1493387359-9496-1-git-send-email-jbacik@fb.com>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-block@vger.kernel.org>

On 04/28/2017 07:49 AM, Josef Bacik wrote:
> list_for_each_entry() isn't super safe if we're freeing the objects
> while we traverse the list.  Also don't bother taking the extra
> reference, the module refcounting stuff will save us from having anybody
> messing with the device while we're trying to unload.

That looks better/safer. Applied for 4.12.

-- 
Jens Axboe
