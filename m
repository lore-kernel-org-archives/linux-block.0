Return-Path: <BATV+de86e71b538cb4077339+5140+infradead.org+hch@bombadil.srs.infradead.org>
Date: Tue, 19 Sep 2017 13:36:28 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Meng Xu <meng.xu@gatech.edu>
Cc: Christoph Hellwig <hch@infradead.org>,
	Meng Xu <mengxu.gatech@gmail.com>, axboe@kernel.dk,
	linux-block@vger.kernel.org, sanidhya@gatech.edu, taesoo@gatech.edu
Subject: Re: [PATCH] scsi: ensure the header peeked does not change in the
 actual message
Message-ID: <20170919203628.GC731@infradead.org>
References: <1505834638-37142-1-git-send-email-mengxu.gatech@gmail.com>
 <20170919160102.GA17416@infradead.org>
 <11095dd2-e6b1-e3c6-4295-b52941822889@gatech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <11095dd2-e6b1-e3c6-4295-b52941822889@gatech.edu>
List-ID: <linux-block@vger.kernel.org>

On Tue, Sep 19, 2017 at 12:15:57PM -0400, Meng Xu wrote:
> Hi Christoph,
> 
> By saying not copying the byte twice, did you mean
> copy_from_user(req->cmd, sic->data + sizeof(opcode), cmdlen -
> sizeof(opcode)) ?
> 
> Does it affect the how req->cmd will be used later?
> If no, I'll submit another patch as instructed.

No, do something like:

	req->cmd[0] = opcode;
   	if (copy_from_user(req->cmd + 1, sic->data, cmdlen - 1))
   		goto error;
