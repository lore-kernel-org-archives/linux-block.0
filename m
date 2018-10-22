Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v2] block: BFQ default for single queue devices
To: Linus Walleij <linus.walleij@linaro.org>, bgurney@redhat.com
Cc: Bart Van Assche <bvanassche@acm.org>, Jan Kara <jack@suse.cz>,
 Paolo Valente <paolo.valente@linaro.org>,
 linux-block <linux-block@vger.kernel.org>,
 linux-mmc <linux-mmc@vger.kernel.org>, linux-mtd@lists.infradead.org,
 Pavel Machek <pavel@ucw.cz>, Ulf Hansson <ulf.hansson@linaro.org>,
 Richard Weinberger <richard@nod.at>, Adrian Hunter
 <adrian.hunter@intel.com>, Artem Bityutskiy <dedekind1@gmail.com>,
 Christoph Hellwig <hch@infradead.org>,
 One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
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
 <d1d082f3-d681-02ed-5bbe-5eb011d6b0da@acm.org>
 <CAHhmqcSb45qePdKsidQcEk7bNeZC5h6Oew-qH=LA7dsQL_uhSg@mail.gmail.com>
 <CACRpkdZZ6RU0aJpUqRn1ndyob1_COhaEs6B9QVRWfa+a60n+Lg@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <eb60af4f-40bb-da3a-1399-60040d2d2fe2@kernel.dk>
Date: Mon, 22 Oct 2018 02:12:15 -0600
MIME-Version: 1.0
In-Reply-To: <CACRpkdZZ6RU0aJpUqRn1ndyob1_COhaEs6B9QVRWfa+a60n+Lg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/19/18 2:42 AM, Linus Walleij wrote:
> On Wed, Oct 17, 2018 at 4:59 PM Bryan Gurney <bgurney@redhat.com> wrote:
> 
>> I feel strongly about the prevention of users running into errors
>> because of an incorrect scheduler default, because I encountered that
>> situation three times in my testing with zoned block devices. The
>> switch to SCSI_MQ would resolve that, since mq-deadline is the
>> default, but in my case, I was using Fedora 28, which disables
>> CONFIG_SCSI_MQ_DEFAULT (which is enabled in the 4.18 kernel), so my
>> default scheduler was cfq.
> 
> I think we should make a patch to the kernel that makes it
> impossible (even from sysfs) to choose a non-zone aware
> scheduler for these devices.
> 
> It's another topic than $SUBJECT patch though. I take this
> into account in this version.

Yes I agree, and I'd be happy to take such a patch. The only matching we
do now is mq-sched for mq-device, and vice versa.  And that will be
going away in 4.21, when there are no more !mq devices that use
scheduling.

If your device is zoned, then you should not be able to switch to a
scheduler that doesn't have support for that. The right approach here
would be to add a capability flag to the IO schedulers.

-- 
Jens Axboe
