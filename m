Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 1/3] nbd: allow multiple disconnects to be sent
To: josef@toxicpanda.com, nbd-general@lists.sourceforge.net,
 linux-block@vger.kernel.org, kernel-team@fb.com
Cc: Josef Bacik <jbacik@fb.com>
References: <1500648495-13337-1-git-send-email-jbacik@fb.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <33587b63-3b84-6a4b-e99a-4e713a34e394@kernel.dk>
Date: Sat, 22 Jul 2017 11:13:23 -0600
MIME-Version: 1.0
In-Reply-To: <1500648495-13337-1-git-send-email-jbacik@fb.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 07/21/2017 08:48 AM, josef@toxicpanda.com wrote:
> From: Josef Bacik <jbacik@fb.com>
> 
> There's no reason to limit ourselves to one disconnect message per
> socket.  Sometimes networks do strange things, might as well let
> sysadmins hit the panic button as much as they want.

Applied 1-3 for 4.13, thanks Josef.

-- 
Jens Axboe
