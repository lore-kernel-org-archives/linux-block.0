Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq: Drop explicit timeout sync in hotplug
To: Gabriel Krisman Bertazi <krisman@linux.vnet.ibm.com>
References: <1480352508-5810-1-git-send-email-krisman@linux.vnet.ibm.com>
Cc: linux-block@vger.kernel.org, Ming Lei <ming.lei@canonical.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <9862d7c0-f8e7-bb0c-231d-1a97c3a05fde@kernel.dk>
Date: Tue, 29 Nov 2016 08:04:15 -0700
MIME-Version: 1.0
In-Reply-To: <1480352508-5810-1-git-send-email-krisman@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 11/28/2016 10:01 AM, Gabriel Krisman Bertazi wrote:
> Sorry for the dup.  Missed linux-block address.
>
>> 8
>
> After commit 287922eb0b18 ("block: defer timeouts to a workqueue"),
> deleting the timeout work after freezing the queue shouldn't be
> necessary, since the synchronization is already enforced by the
> acquisition of a q_usage_counter reference in blk_mq_timeout_work.

Added for 4.10, thanks.

-- 
Jens Axboe
