Subject: Re: [PATCHv4 4/4] block/sed: Embed function data into the function
 sequence
To: Scott Bauer <scott.bauer@intel.com>
References: <1487703556-19913-1-git-send-email-jonathan.derrick@intel.com>
 <1487703556-19913-5-git-send-email-jonathan.derrick@intel.com>
 <20170222071342.GA17472@lst.de> <22a94611-3cbd-792f-8347-3b1c1f200944@fb.com>
 <20170222161331.GA2696@sbauer-Z170X-UD5>
Cc: Christoph Hellwig <hch@lst.de>, Jon Derrick <jonathan.derrick@intel.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Rafael Antognolli <rafael.antognolli@intel.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <51275275-9cff-ce94-f760-3572161dde79@fb.com>
Date: Wed, 22 Feb 2017 09:47:53 -0700
MIME-Version: 1.0
In-Reply-To: <20170222161331.GA2696@sbauer-Z170X-UD5>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 02/22/2017 09:13 AM, Scott Bauer wrote:
> On Wed, Feb 22, 2017 at 09:10:31AM -0700, Jens Axboe wrote:
>> On 02/22/2017 12:13 AM, Christoph Hellwig wrote:
>>>> +	if (!lock_held)
>>>> +		mutex_lock(&dev->dev_lock);
>>>
>>> No conditional locking, please.  I guess I causesd this by asking you
>>> to remove __opal_lock_unlock, but it seems we'd either need to keep it
>>> in the end.
>>>
>>> Except for that the series looks fine to me.
>>>
>>> Jens: given that 1-3 are the important fixes how about you pick those
>>> up ASAP?  They all also had my Reviewed-by for previous postings.
>>
>> I picked up 1-3, and re-added your reviewed by. #4 should be sorted
>> before -rc1, though.
>>
> 
> #4 Is good to go as well. It was resent this morning under
> [PATCH] block/sed: Embed function data into the function sequence
> And contains the changes Christoph requested, I'll re-add my sign-off.
> Once that gets In I can rebase mine and get them out today too.

I see, I found it now. Guys, let's get this process streamlined a bit
more. This whole thing has been a flurry of patches and patchseries,
posted by either you or Jon. Previous patch series was 1-4 patches
posted by you, and then patch #4 is replaced by a single patch from Jon,
posted outside of that thread. Honestly, I feel like this should have
been pushed to 4.12 instead, it clearly wasn't ready before the merge
window.

-- 
Jens Axboe
