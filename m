Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 4/5] blk-mq-debugfs: Show busy requests
To: Bart Van Assche <Bart.VanAssche@sandisk.com>,
 "ming.lei@redhat.com" <ming.lei@redhat.com>
Cc: "hch@lst.de" <hch@lst.de>, "osandov@fb.com" <osandov@fb.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "hare@suse.com" <hare@suse.com>
References: <20170525233810.23211-1-bart.vanassche@sandisk.com>
 <20170525233810.23211-5-bart.vanassche@sandisk.com>
 <20170527005456.GB20421@ming.t460p> <1496165077.2627.15.camel@sandisk.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <2c6537c7-591c-0663-8271-7120fe7c9336@kernel.dk>
Date: Tue, 30 May 2017 11:32:26 -0600
MIME-Version: 1.0
In-Reply-To: <1496165077.2627.15.camel@sandisk.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 05/30/2017 11:24 AM, Bart Van Assche wrote:
>> [ ... ]
>> During this small window, the request can be freed and reallocated
>> in another I/O path, then use-after-free is caused.
> 
> A similar remark applies to all request queue debugfs attributes: the
> queue state can change immediately after having queried the state so
> that's not unique to this attribute. Regarding the "use-after-free":
> the memory that is allocated for requests is only freed after the
> debugfs attributes have been removed so the code that implements this
> attribute will read the contents of a struct request. It is up to the
> person who reads the contents of this attribute to decide how to
> interpret the contents.

I think it's important to stress that the memory is not going away, so
it'll potentially just show a new state of the request. That's perfectly
fine, and will happen all the time for the various debugfs exports. The
useful aspect of them is when things have come to a halt, for whatever
reason. The states will tend to stay stable when that happens, and
provide a useful method of introspection to debug the issue.

The important part here is that the memory is perfectly valid, so we
won't run into issues with that.

-- 
Jens Axboe
