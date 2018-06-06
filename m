Return-Path: <axboe@kernel.dk>
Subject: Re: Block IO issue in kernel-v4.17
To: Kent Overstreet <kent.overstreet@gmail.com>, Li Wang <liwang@redhat.com>
Cc: Coly Li <colyli@suse.de>, hch@lst.de, darrick.wong@oracle.com,
 snitzer@redhat.com, linux-block@vger.kernel.org,
 linux-kernel <linux-kernel@vger.kernel.org>
References: <CAEemH2fbPv2wphVBHxSSS+KEK5S-rercXhvgLJ7YMOZnrTpexg@mail.gmail.com>
 <20180606084105.GA10720@kmo-pixel>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <015f6160-216a-31ba-e251-11336e7ff5d6@kernel.dk>
Date: Wed, 6 Jun 2018 08:18:14 -0600
MIME-Version: 1.0
In-Reply-To: <20180606084105.GA10720@kmo-pixel>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 6/6/18 2:41 AM, Kent Overstreet wrote:
> On Wed, Jun 06, 2018 at 04:37:25PM +0800, Li Wang wrote:
>> Hi BIO experts,
>>
>> I catch this panic issue on some kind of arches(x86_64, ppc64,
>> ppc64le..), it seems the root cause is very probably from BIO changes
>> from kernel-4.17-rc7. Plz take a look.
> 
> That's the bioset changes, the fix is out and on its way in

It's already in mainline, since about lunch time yesterday.


-- 
Jens Axboe
