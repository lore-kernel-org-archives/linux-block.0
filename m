Return-Path: <prvs=42332f6725=axboe@fb.com>
Subject: Re: [PATCH] nbd: stop leaking sockets
To: Josef Bacik <jbacik@fb.com>, <axboe@kernel.dk>,
        <nbd-general@lists.sourceforge.net>, <linux-block@vger.kernel.org>,
        <kernel-team@fb.com>
References: <1488386842-16515-1-git-send-email-jbacik@fb.com>
CC: <stable@vger.kernel.org>
From: Jens Axboe <axboe@fb.com>
Message-ID: <55d2e5d8-e4b4-4a5e-8365-598244c9b8dd@fb.com>
Date: Wed, 1 Mar 2017 09:53:26 -0700
MIME-Version: 1.0
In-Reply-To: <1488386842-16515-1-git-send-email-jbacik@fb.com>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-block@vger.kernel.org>

On 03/01/2017 09:47 AM, Josef Bacik wrote:
> This was introduced in the multi-connection patch, we've been leaking
> socket's ever since.
> 
> Fixes: 9561a7a ("nbd: add multi-connection support")
> cc: stable@vger.kernel.org
> Signed-off-by: Josef Bacik <jbacik@fb.com>

Applied for this series, thanks Josef.

-- 
Jens Axboe
