Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH] blk-wbt: get back the missed wakeup from __wbt_done
To: Jens Axboe <axboe@kernel.dk>, Anchal Agarwal <anchalag@amzn.com>
Cc: fllinden@amazon.com,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1535029718-17259-1-git-send-email-jianchao.w.wang@oracle.com>
 <bd84ff08-b75a-0a2f-6b37-07a104452bff@kernel.dk>
 <da9458c632cb4c4695660664bf7c3fb3@EX13D13UWB002.ant.amazon.com>
 <20180823210144.GB5624@kaos-source-ops-60001.pdx1.amazon.com>
 <3eaa20ce-0599-c405-d979-87d91ea331d2@kernel.dk>
 <20180824181223.GA9049@kaos-source-ops-60001.pdx1.amazon.com>
 <677c8648-63fd-601c-b906-40a8502f9782@kernel.dk>
 <20180824203305.GA4690@kaos-source-ops-60001.pdx1.amazon.com>
 <dc734449-7cd8-3a8e-9fdc-d7d854393900@kernel.dk>
 <2fecf2f2-f00b-f6ba-710a-54ceaacfedbb@kernel.dk>
 <00445460-d826-4d85-c5f4-fa565892da01@oracle.com>
 <3876c36c-fec6-6586-435f-dc177dc38c76@oracle.com>
 <f88cd48d-e140-fa61-76f7-8985ca2c2e08@kernel.dk>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <5cd959f0-b40c-b6ac-c037-89f6cc670f47@oracle.com>
Date: Tue, 28 Aug 2018 10:52:57 +0800
MIME-Version: 1.0
In-Reply-To: <f88cd48d-e140-fa61-76f7-8985ca2c2e08@kernel.dk>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Jens

On 08/27/2018 10:51 PM, Jens Axboe wrote:
>>> I cannot get the point of "since we can't rely on just being woken from the ->func handler
>>> we set".
>>> Do you mean there could be someone else could wake up this task ?
> Yeah, you don't know for a fact that the wbt wait queue is the only
> guy waking us up. Any sleep like this needs a loop. It was quite
> easy to reproduce for me, and as expected, you'll get list corruption
> on the wait queue since we leave it on the list and the stack goes
> away.
> 
Yes, got it. Thanks for your kindly response. :)

Thanks
Jianchao
