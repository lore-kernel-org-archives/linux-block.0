Return-Path: <axboe@kernel.dk>
Subject: Re: [Bug] block/for-next: IO hang in rq_qos_throttle
To: Ming Lei <tom.leiming@gmail.com>, Josef Bacik <josef@toxicpanda.com>
Cc: Ming Lei <ming.lei@redhat.com>, Josef Bacik <jbacik@fb.com>,
 linux-block <linux-block@vger.kernel.org>
References: <CACVXFVNKAhGkievaHXDvPngw7xW5hWg_0oOSLXD1R4uaxSJs3w@mail.gmail.com>
 <83C56CD1-93E0-41E3-AF41-27C4F33851FE@fb.com>
 <20180722072804.GA955@ming.t460p> <20180727154741.v2ubbwerblyug43a@destiny>
 <CACVXFVOuaCT6Q04ztFubLAZUhPPXjpCdDNckoRquN1jvtb8eZw@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <33dfb9ff-85da-24a6-a17d-1a4dedb589e0@kernel.dk>
Date: Sat, 28 Jul 2018 09:08:02 -0600
MIME-Version: 1.0
In-Reply-To: <CACVXFVOuaCT6Q04ztFubLAZUhPPXjpCdDNckoRquN1jvtb8eZw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 7/28/18 6:11 AM, Ming Lei wrote:
> On Fri, Jul 27, 2018 at 11:47 PM, Josef Bacik <josef@toxicpanda.com> wrote:
>> On Sun, Jul 22, 2018 at 03:28:05PM +0800, Ming Lei wrote:
>>> On Sun, Jul 22, 2018 at 02:15:38AM +0000, Josef Bacik wrote:
>>>> Yup I sent a patch for this on Thursday, sorry about that,
>>>>
>>>
>>> I just applied the patch of 'blk-rq-qos: make depth comparisons unsigned',
>>> looks the same IO hang can be triggered too.
>>
>> Ok I'm back from vacation and I'm trying to reproduce but it's not happening for
>> me.  What testing infrastructure is this?  blktests and xfstests don't have a
>> sanity/ in their test suites.  I'm wondering if there's something else about the
>> test that I'm missing.  Thanks,
> 
> As I mentioned,
> 
> The following IO hang is triggered on dbench test on xfs/usb-storage:
> 
>       dbench -t 20 -s 64

Josef, the key here is likely a queue depth of 1. So if you're running on
sata, then just limit the device depth to 1.

-- 
Jens Axboe
