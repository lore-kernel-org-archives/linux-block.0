Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v2] block: BFQ default for single queue devices
To: Jan Kara <jack@suse.cz>
Cc: Paolo Valente <paolo.valente@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 linux-block <linux-block@vger.kernel.org>,
 linux-mmc <linux-mmc@vger.kernel.org>, linux-mtd@lists.infradead.org,
 Pavel Machek <pavel@ucw.cz>, Ulf Hansson <ulf.hansson@linaro.org>,
 Richard Weinberger <richard@nod.at>, Adrian Hunter
 <adrian.hunter@intel.com>, Bart Van Assche <bvanassche@acm.org>,
 Artem Bityutskiy <dedekind1@gmail.com>, Christoph Hellwig
 <hch@infradead.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
 Mark Brown <broonie@kernel.org>, Damien Le Moal <Damien.LeMoal@wdc.com>,
 Johannes Thumshirn <jthumshirn@suse.de>,
 Oleksandr Natalenko <oleksandr@natalenko.name>,
 Jonathan Corbet <corbet@lwn.net>
References: <20181015141059.26579-1-linus.walleij@linaro.org>
 <d25e02de-e1be-0fb7-237b-3e53d56c6f64@kernel.dk>
 <307F6078-0A77-4AAA-BE1A-55C2ACC328CC@linaro.org>
 <ab70f1dd-6943-9642-aafa-71840fd44f07@kernel.dk>
 <689F28AA-92B5-48B5-BBE7-0B589F163228@linaro.org>
 <7375c004-ac6e-c692-4282-46de554285d5@kernel.dk>
 <20181017100526.GB23493@quack2.suse.cz>
 <e54c3943-0335-6db4-1c86-f093432fd84b@kernel.dk>
 <20181018072110.GI23493@quack2.suse.cz>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <3a844733-ddcd-2f5f-80fc-645daeec0046@kernel.dk>
Date: Thu, 18 Oct 2018 08:35:49 -0600
MIME-Version: 1.0
In-Reply-To: <20181018072110.GI23493@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/18/18 1:21 AM, Jan Kara wrote:
> On Wed 17-10-18 10:29:22, Jens Axboe wrote:
>> On 10/17/18 4:05 AM, Jan Kara wrote:
>>> On Tue 16-10-18 11:35:59, Jens Axboe wrote:
>>>> On 10/15/18 1:44 PM, Paolo Valente wrote:
>>>>> Here are some old results with a very simple configuration:
>>>>> http://algo.ing.unimo.it/people/paolo/disk_sched/old-results/4.4.0-v7r11/
>>>>> http://algo.ing.unimo.it/people/paolo/disk_sched/old-results/3.14.0-v7r3/
>>>>> http://algo.ing.unimo.it/people/paolo/disk_sched/old-results/3.13.0-v7r2/
>>>>>
>>>>> Then I stopped repeating tests that always yielded the same good results.
>>>>>
>>>>> As for more professional systems, a well-known company doing
>>>>> real-time packet-traffic dumping asked me to modify bfq so as to
>>>>> guarantee lossless data writing also during queries.  The involved box
>>>>> had a RAID reaching a few Gbps, and everything worked well.
>>>>>
>>>>> Anyway, if you have specific issues in mind, I can check more deeply.
>>>>
>>>> Do you have anything more recent? All of these predate the current
>>>> code (by a lot), and isn't even mq. I'm mostly just interested in
>>>> plain fast NVMe device, and a big box hardware raid setup with
>>>> a ton of drives.
>>>>
>>>> I do still think that this should be going through the distros, they
>>>> need to be the ones driving this, as they will ultimately be the
>>>> ones getting customer reports on regressions. The qual/test cycle
>>>> they do is useful for this. In mainline, if we make a change like
>>>> this, we'll figure out if it worked many releases down the line.
>>>
>>> Well, the problem with this is that big distro people really don't care
>>> much because they already use udev for tuning the IO scheduler. So whatever
>>> defaults the kernel is going to pick likely won't be seen by distro
>>> customers. Embedded people seem to be driving this effort because they
>>> either don't run udev or they feel not all their teams building new
>>> products have enough expertise to come up with a proper set of rules...
>>
>> Which is also the approach that I've been advocating for here, instead
>> of a kernel patch...
> 
> I know you've been advocating the use of udev for IO scheduler selection.
> But do you want to force everybody to use udev? And for people who build
> their own (usually small) systems, do you want to force them to think about
> IO scheduler selection and writing appropriate rules? These are the
> problems people were mentioning and I'm not sure what is your opinion on
> this.

I don't want to force everybody to use udev, use whatever you like on
your platform. For most people that is udev, for embedded it's something
else. As you said, distros already do this via udev. When I've had to
do it on my systems, I've added a udev rule to do it.

My opinion is that the kernel makes various schedulers available.
Deciding which one to use is policy that should go into user space.
The default should be something that's solid and works, fancier
setups and tuning should be left to user space.

-- 
Jens Axboe
