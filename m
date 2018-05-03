Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v4 0/6] bcache device failure handling fixes for 4.17-rc4
To: Coly Li <colyli@suse.de>, linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org
References: <20180503105137.2922-1-colyli@suse.de>
 <20851814-8ace-ae48-883d-dae8b3c3600a@kernel.dk>
 <d57612b8-5f51-9cab-6e45-d08f8aa938f9@suse.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <243e1716-fea7-cd72-09ad-691a74e3a191@kernel.dk>
Date: Thu, 3 May 2018 09:44:19 -0600
MIME-Version: 1.0
In-Reply-To: <d57612b8-5f51-9cab-6e45-d08f8aa938f9@suse.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 5/3/18 9:40 AM, Coly Li wrote:
> On 2018/5/3 10:34 PM, Jens Axboe wrote:
>> On 5/3/18 4:51 AM, Coly Li wrote:
>>> Hi Jens,
>>>
>>> I receive bug reports from partners for the bcache cache device failure
>>> handling patch set (which is just merged into 4.17-rc1). Fortunately we
>>> are still in 4.17 merge window, I suggest to have these fixes to go into
>>> 4.17 merge window too.
>>
> 
> Hi Jens,
> 
>> We're not, though. The merge window is from when 4.16 is released and
>> until 4.17-rc1 is tagged, so we're way beyond at this point. That doesn't
> 
> I have more clean concept what a merge window is :-)

The merge window is a cleanly defined concept, so there's not a lot of room
for interpretation :-)

>> mean we can't take fixes, but this late in the cycle, they really have
>> to be fixes for regressions introduced in this merge window. Or simple
>> or serious enough that we should take them for this release, instead
>> of pushing them to the 4.18 merge window.
>>
> 
> Maybe next time (if there is) I should say the fixes should go into this
> release, not merge window. Because the merge window is gone after rc1
> released.

Right, generally I'd recommend that you maintain two branches (or however
you want to organize it). One is for fixes that should go into the
current release. You can submit those anytime, just beware of the
limitations of those (as outlined above). The other should be for new
development or fixes that can wait, for the next release. The grunt
of these should be submitted by the time that -rc7 is tagged, so they
have at least a week in my tree before going upstream.

-- 
Jens Axboe
