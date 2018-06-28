Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
In-Reply-To: <5e78949d-6169-5a5a-869b-731a3468e2de@wdc.com>
References: <20180627201231.15641-1-bart.vanassche@wdc.com>
 <20180627235005.GE7583@ming.t460p> <4995fc0c-e9d7-d747-7331-67396827a596@wdc.com>
 <20180628003007.GG7583@ming.t460p> <5e78949d-6169-5a5a-869b-731a3468e2de@wdc.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Fri, 29 Jun 2018 07:10:47 +0800
Message-ID: <CACVXFVNzb9j_KwJLor4O=T_fgRRR12KOkZ2DXtniYp=u3Ru3bg@mail.gmail.com>
Subject: Re: [PATCH] block: Make __bio_clone_fast() copy bi_vcnt
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
	Mike Snitzer <snitzer@redhat.com>, Hannes Reinecke <hare@suse.com>,
	Johannes Thumshirn <jthumshirn@suse.de>, Kent Overstreet <kent.overstreet@gmail.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Thu, Jun 28, 2018 at 11:21 PM, Bart Van Assche
<bart.vanassche@wdc.com> wrote:
> On 06/27/18 17:30, Ming Lei wrote:
>>
>> One core idea of immutable bvec is to use bio->bi_iter and the original
>> bvec table to iterate over anywhere in the bio. That is why .bi_io_vec
>> needs to copy, but not see any reason why .bi_vcnt needs to do.
>>
>> Do you have use cases on .bi_vcnt for cloned bio?
>
>
> So far this is only a theoretical concern. There are many functions in the
> block layer that use .bi_vcnt, and it is a lot of work to figure out all the
> callers of all these functions.

No, any functions using .bi_vcnt on a cloned-bio may be a bug, and we should
take a close look.

Thanks,
Ming Lei
