Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJrWOzBYNBzGuStrqjzLirUxhC1K02PE9kPdY+GuJF6ynRBZgA@mail.gmail.com>
References: <1453803006-12812-1-git-send-email-roman.penyaev@profitbricks.com> <CAJrWOzBYNBzGuStrqjzLirUxhC1K02PE9kPdY+GuJF6ynRBZgA@mail.gmail.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Thu, 10 May 2018 08:51:54 +0800
Message-ID: <CACVXFVO51Un=nGZCfyUN_SKG11O7+LR4paSkS8QMFsqBL9UewQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] block: fix race between opening blkext device and
 freeing it
To: Roman Penyaev <roman.penyaev@profitbricks.com>
Cc: Keith Busch <keith.busch@intel.com>, stable <stable@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Tue, Feb 2, 2016 at 12:29 AM, Roman Penyaev
<roman.penyaev@profitbricks.com> wrote:
> Hello, Jens.
>
> Could you please take a look at this patch.
> This issue happens quite often on our servers, when udevd
> tries to get detailed info about md raid starting mdadm,
> but this raid device is already in closing state and is
> about to free internal structures, afterwards an oops
> happens and mdadm gets killed.

Looks the issue is still there, so could we consider Roman's approach
for this issue?

Thanks,
Ming Lei
