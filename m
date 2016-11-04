Subject: Re: [PATCH V2 2/2] blk-mq: immediately dispatch big size request
To: Christoph Hellwig <hch@infradead.org>
References: <05e8cb8c7e09903c7db36e81a6bbd0b39b24deff.1478217670.git.shli@fb.com>
 <6297c9a39cf21c94c65d5a9b3a19e54ba5b8b573.1478217671.git.shli@fb.com>
 <20161104000954.GA10266@infradead.org>
 <20161104001353.GA58908@omida-mbp.local.dhcp.thefacebook.com>
 <32bef0f6-c194-e31e-3a85-5aa21a6e81a4@fb.com>
 <20161104144614.GA18373@infradead.org>
Cc: Shaohua Li <shli@fb.com>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kernel-team@fb.com
From: Jens Axboe <axboe@fb.com>
Message-ID: <3d7144e3-47e5-3c98-489f-e92d97b60817@fb.com>
Date: Fri, 4 Nov 2016 09:29:07 -0600
MIME-Version: 1.0
In-Reply-To: <20161104144614.GA18373@infradead.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 11/04/2016 08:46 AM, Christoph Hellwig wrote:
> On Thu, Nov 03, 2016 at 10:00:58PM -0600, Jens Axboe wrote:
>> I've applied 1-2 for 4.10, but we probably should look into unifying
>> those parts of sq and mq in general. For instance, it doesn't seem to
>> make a lot of sense why we'd depth limit sq and not mq.
>
> I've spent some time looking the the make_request_fn and to be honest
> I think that whole sq vs mq split is pointless.  They are about 70-80%
> the same anyway, and I think everyone would be served much better
> by merging them.

Yeah, that was my point, at least if we can do it without having too
many extra conditionals. Or at least split some of it into helpers.

-- 
Jens Axboe
