Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH V2] block: fix the DISCARD request merge
To: Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Cc: axboe@kernel.dk, martin.petersen@oracle.com, tom.leiming@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1540045777-10290-1-git-send-email-jianchao.w.wang@oracle.com>
 <20181022090601.GA21171@ming.t460p> <20181022090849.GA19053@lst.de>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <c53fc061-2a83-428d-b3c0-87feff375f42@oracle.com>
Date: Mon, 22 Oct 2018 18:14:25 +0800
MIME-Version: 1.0
In-Reply-To: <20181022090849.GA19053@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>



On 10/22/18 5:08 PM, Christoph Hellwig wrote:
> On Mon, Oct 22, 2018 at 05:06:02PM +0800, Ming Lei wrote:
>>
>> The above may be changed to 'if (blk_try_merge(req) == ELEVATOR_DISCARD_MERGE)'
>> or sort of in future, which may has document benefit at least, since
>> ELEVATOR_DISCARD_MERGE means multi-segment discard merge.
> 
> I like that idea, and we should do it for the respin
> 

OK, I will use the blk_try_merge in next version.

Thanks
Jianchao
