Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCHSET v6] blk-mq scheduling framework
To: Hannes Reinecke <hare@suse.de>, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org
References: <1484170803-9311-1-git-send-email-axboe@fb.com>
 <e1f8f6c5-5347-d8d8-57a2-0367d828dd22@suse.de>
 <5850a4ad-74a1-8d30-e865-fbd35679e84f@suse.de>
 <2e968ed9-7269-488b-4c38-b318ad99ed3f@fb.com>
 <3cda10cb-b74e-0f6c-bbda-37d366b92ad0@suse.de>
 <c8c8f077-a8e2-fd2c-284b-a83ed6ab4100@fb.com>
 <62478d65-8bfb-49bf-c26e-d64daf37c001@suse.de>
 <f5107eaf-67b1-1542-1ef2-1f8d4118bf98@fb.com>
 <80fc3190-3607-b909-66fb-c69ced180335@kernel.dk>
Cc: osandov@osandov.com, bart.vanassche@sandisk.com
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <db37ba6a-316f-fec3-931d-02621254dec0@kernel.dk>
Date: Fri, 13 Jan 2017 14:45:39 -0700
MIME-Version: 1.0
In-Reply-To: <80fc3190-3607-b909-66fb-c69ced180335@kernel.dk>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 01/13/2017 09:02 AM, Jens Axboe wrote:
> Also, would be great if you could pull:
> 
> git://git.kernel.dk/linux-block blk-mq-sched
> 
> into current 'master' and see if it still reproduces. I expect that it
> will, but just want to ensure that it's a problem in the current code
> base as well.

Hannes, can you try the current branch? I believe your problem should be
fixed now, would be great if you could verify.

-- 
Jens Axboe
