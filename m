Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH V2 1/3] blk-mq: refactor the code of issue request
 directly
To: Ming Lei <ming.lei@redhat.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1540569671-6589-1-git-send-email-jianchao.w.wang@oracle.com>
 <1540569671-6589-2-git-send-email-jianchao.w.wang@oracle.com>
 <20181029024937.GC32606@ming.t460p>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <64ec3df3-27f8-4d75-5ec9-6427ffcf1244@oracle.com>
Date: Mon, 29 Oct 2018 13:40:54 +0800
MIME-Version: 1.0
In-Reply-To: <20181029024937.GC32606@ming.t460p>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Ming

On 10/29/18 10:49 AM, Ming Lei wrote:
> On Sat, Oct 27, 2018 at 12:01:09AM +0800, Jianchao Wang wrote:
>> Merge blk_mq_try_issue_directly and __blk_mq_try_issue_directly
>> into one interface which is able to handle the return value from
>> .queue_rq callback. Due to we can only issue directly w/o io
>> scheduler, so remove the blk_mq_get_driver_tag.
> 
> It isn't correct for dm-rq, see blk_insert_cloned_request().
> 

Yes, got it.
when the original requests are issued to the underlying paths as cloned
requests, they should not pass through the io scheduler.

Thanks
Jianchao
