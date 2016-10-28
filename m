Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 00/14] introduce the BFQ-v0 I/O scheduler as an extra
 scheduler
To: Ulf Hansson <ulf.hansson@linaro.org>
References: <1477474082-2846-1-git-send-email-paolo.valente@linaro.org>
 <20161026113443.GA13587@quack2.suse.cz>
 <4ed3e291-b3e5-5ee3-6838-58644bd3d99b@sandisk.com>
 <12386463.fJy0cVexVD@wuerfel> <20161026152955.GA21262@infradead.org>
 <3ebadbb8-9ac2-851a-66f9-c9db25713695@kernel.dk>
 <38156FA7-9A66-44DC-8D0C-28F149D1E49B@linaro.org>
 <09fc1e06-3fd6-b13d-0dd9-0edfb55b01d1@kernel.dk>
 <CAPDyKFrCNS_ZWzVU9Y=J9q0ewp-7=VFs4LwV69SzgSGHBxTn-g@mail.gmail.com>
 <15ee2d0e-2d3a-81e2-9f83-f875e41bf388@kernel.dk>
 <CAPDyKFoi64Q0H9x2F35oY85PMDNq4hRsmqGYiP+En+qtQ4+Bag@mail.gmail.com>
 <1ac9b794-7e7f-0748-e4c8-a13034aecbc3@kernel.dk>
 <CAPDyKFpLhp0eoS8LWy-jU0_U_cWq4immq2+bPdi-j7=oa24OjA@mail.gmail.com>
 <e792e932-cf16-4272-2388-ae813a0372b6@kernel.dk>
 <CAPDyKFqDqhMgpCN83P_dFf6wgfT3KCVT1Uw4kDMz620=3Hkj+A@mail.gmail.com>
Cc: Paolo Valente <paolo.valente@linaro.org>,
 Christoph Hellwig <hch@infradead.org>, Arnd Bergmann <arnd@arndb.de>,
 Bart Van Assche <bart.vanassche@sandisk.com>, Jan Kara <jack@suse.cz>,
 Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org,
 Linux-Kernal <linux-kernel@vger.kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@kernel.org>,
 Hannes Reinecke <hare@suse.de>, Grant Likely <grant.likely@secretlab.ca>,
 James Bottomley <James.Bottomley@hansenpartnership.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <4948c47a-6e24-0a81-0564-5a61b6be35e9@kernel.dk>
Date: Fri, 28 Oct 2016 08:17:01 -0600
MIME-Version: 1.0
In-Reply-To: <CAPDyKFqDqhMgpCN83P_dFf6wgfT3KCVT1Uw4kDMz620=3Hkj+A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 10/28/2016 12:36 AM, Ulf Hansson wrote:
> [...]
>
>>
>>> Moreover, I am still trying to understand what's the big deal to why
>>> you say no to BFQ as a legacy scheduler. Ideally it shouldn't cause
>>> you any maintenance burden and it doesn't make the removal of the
>>> legacy blk layer any more difficult, right?
>>
>>
>> Not sure I can state it much clearer. It's a new scheduler, and a
>> complicated one at that. It WILL carry a maintenance burden. And I'm
>
> Really? Either you maintain the code or not. And if Paolo would do it,
> then your are off the hook!

Are you trying to be deliberately obtuse? If so, good job. I'd advise 
you to look into how code in the kernel is maintained in general. A 
maintenance burden exists for code A, but it also carries over to the 
subsystem it is under, and the kernel in general. Adding code is never free.

>> really not that interested in adding such a burden for something that
>> will be defunct as soon as the single queue blk-mq version is done.
>> Additionally, if we put BFQ in right now, the motivation to do the real
>> work will be gone.
>
> You have been pushing Paolo in different directions throughout the
> years with his work in BFQ, wasting lots of his time/effort.

I have not. Various entities have advised Paolo approach it in various 
ways. We've had blk-mq for 3 years now, my position should have been 
pretty clear on that.

> You have not given him any credibility for his work in BFQ and now you
> point him yet in another direction.

I don't even know what that means. But I'm not pointing him in a new 
direction.

Ulf, I'm done discussing with you. I've made my position clear, yet you 
continue to beat on a dead horse. As far as I'm concerned, there's 
nothing further to discuss here. I'll be happy to discuss when there's 
some meat on the bone (ie code). Until then, EOD.

-- 
Jens Axboe
