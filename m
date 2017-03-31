Return-Path: <arndbergmann@gmail.com>
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <CAPDyKFqiyEcScuWLVXE9kAa2yQyJCZfbXyAdAQOb081nLjyvvw@mail.gmail.com>
References: <CACRpkdbZrkAqEdP1-QqDww0ZuFcY47Jgj9dPqkG_whrx7pwC-w@mail.gmail.com>
 <CAK8P3a1CGtj5VSVoMM34VWn781WpS8ZcHpq6n0UfNOWWYEq=QQ@mail.gmail.com> <CAPDyKFqiyEcScuWLVXE9kAa2yQyJCZfbXyAdAQOb081nLjyvvw@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 31 Mar 2017 10:43:43 +0200
Message-ID: <CAK8P3a1yJJ33R9EPPcErLUO2enFGrSJzWmVRwHdHP+3_2iP7ow@mail.gmail.com>
Subject: Re: Outstanding MQ questions from MMC
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Adrian Hunter <adrian.hunter@intel.com>,
	Paolo Valente <paolo.valente@linaro.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On Thu, Mar 30, 2017 at 6:39 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 30 March 2017 at 14:42, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Wed, Mar 29, 2017 at 5:09 AM, Linus Walleij <linus.walleij@linaro.org> wrote:

>>> In MQ, I have simply locked the host on the first request and then I never
>>> release it. Clearly this does not work. I am uncertain on how to handle this
>>> and whether MQ has a way to tell us that the queue is empty so we may release
>>> the host. I toyed with the idea to just set up a timer, but a "queue
>>> empty" callback
>>> from the block layer is what would be ideal.
>>
>> Would it be possible to change the userspace code to go through
>> the block layer instead and queue a request there, to avoid having
>> to lock the card at all?
>
> That would be good from an I/O scheduling point of view, as it would
> avoid one side being able to starve the other.
>
> However, we would still need a lock, as we also have card detect work
> queue, which also needs to claim the host when it polls for removable
> cards.

Hmm, In theory the card-detect work queue should not be active
at the same time as any I/O, but I see you point. Could the card-detect
wq perhaps also use the blk queue for sending a special request that
triggers the detection logic?

Alternatively, I had this idea that we could translate blk requests into
mmc commands and then have a (short fixed length) set of outstanding
mmc commands in the device that always get done in order. The card
detect and the user space I/O would then directly put mmc commands
onto the command queue, as would the blk-mq scheduler. You
still need a lock to access that command queue, but the mmc host
would just always pick the next command off the list when one
command completes.
This also lets you integrate packed commands: if the next outstanding
command is the same type as the request coming in from blk-mq,
you can merge it into a single mmc command to be submitted
together, otherwise it gets deferred.

      Arnd
