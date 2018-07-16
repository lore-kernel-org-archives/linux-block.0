Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
In-Reply-To: <f6f3f16b66622a9b16acd0d8be7ef311e4da807a.camel@suse.com>
References: <e36f28d8-0eb8-1600-f327-8b066eeaf45c@suse.de> <CACVXFVPVb_8pUkGXPt5joDE4JRu0b4kgTQy7Pd0sL+kXDwys+A@mail.gmail.com>
 <c5073ab4-6b06-16bd-f358-d4c18e18b3e0@kernel.dk> <f6f3f16b66622a9b16acd0d8be7ef311e4da807a.camel@suse.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Mon, 16 Jul 2018 19:45:52 +0800
Message-ID: <CACVXFVPV1ckFvvh3m61QSPCtEY19ussRsMtKoptUbY3LLHKz8A@mail.gmail.com>
Subject: Re: Silent data corruption in blkdev_direct_IO()
To: Martin Wilck <mwilck@suse.com>
Cc: Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Sat, Jul 14, 2018 at 6:29 AM, Martin Wilck <mwilck@suse.com> wrote:
> Hi Ming & Jens,
>
> On Fri, 2018-07-13 at 12:54 -0600, Jens Axboe wrote:
>> On 7/12/18 5:29 PM, Ming Lei wrote:
>> >
>> > Maybe you can try the following patch from Christoph to see if it
>> > makes a
>> > difference:
>> >
>> > https://marc.info/?l=linux-kernel&m=153013977816825&w=2
>>
>> That's not a bad idea.
>
> Are you saying that the previous "nasty hack"  in
> bio_iov_iter_get_pages() was broken, and the new one is not?
> I've scratched my head over that (old) code lately, but I couldn't spot
> an actual error in it.

Yeah, I think the new patch in above link is better, and looks its correctness
is easy to prove.

   https://marc.info/?t=152812081400001&r=1&w=2

So please test the patch if possible.

Thanks,
Ming Lei
