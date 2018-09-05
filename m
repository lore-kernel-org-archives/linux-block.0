Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v7] drbd: Convert from ahash to shash
To: Kees Cook <keescook@chromium.org>,
 Philipp Reisner <philipp.reisner@linbit.com>,
 linux-block <linux-block@vger.kernel.org>, drbd-dev@lists.linbit.com,
 LKML <linux-kernel@vger.kernel.org>
References: <20180806233216.GA6037@beast>
 <CAGXu5jKA6_aZpDXB2UurmW5cEGEC7aMcq=qvJGPVAifjnk17ug@mail.gmail.com>
 <CAGXu5jLyynGbnuhwabbViwzvRFzn-Vj5ktYOrypRGj_qk8UvQw@mail.gmail.com>
 <20180905083320.GA28462@soda.linbit>
 <CAGXu5jL3Pw3s0r1kebQy_9xVDrtNnCqbRTAEqsa_GwK-eAWMkg@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <7a643254-cc1d-0a27-17a7-40651b503256@kernel.dk>
Date: Wed, 5 Sep 2018 10:10:24 -0600
MIME-Version: 1.0
In-Reply-To: <CAGXu5jL3Pw3s0r1kebQy_9xVDrtNnCqbRTAEqsa_GwK-eAWMkg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 9/5/18 10:04 AM, Kees Cook wrote:
> On Wed, Sep 5, 2018 at 1:33 AM, Lars Ellenberg
> <lars.ellenberg@linbit.com> wrote:
>> On Tue, Sep 04, 2018 at 08:04:18PM -0700, Kees Cook wrote:
>>> On Mon, Sep 3, 2018 at 11:04 PM, Kees Cook <keescook@chromium.org> wrote:
>>>> On Mon, Aug 6, 2018 at 4:32 PM, Kees Cook <keescook@chromium.org> wrote:
>>>>> In preparing to remove all stack VLA usage from the kernel[1], this
>>>>> removes the discouraged use of AHASH_REQUEST_ON_STACK in favor of
>>>>> the smaller SHASH_DESC_ON_STACK by converting from ahash-wrapped-shash
>>>>> to direct shash. By removing a layer of indirection this both improves
>>>>> performance and reduces stack usage. The stack allocation will be made
>>>>> a fixed size in a later patch to the crypto subsystem.
>>>>>
>>>>> The bulk of the lines in this change are simple s/ahash/shash/, but the
>>>>> main logic differences are in drbd_csum_ee() and drbd_csum_bio(), which
>>>>> externalizes the page walking with k(un)map_atomic() instead of using
>>>>> scattergather.
>>>>
>>>> Hi Lars! How does this look to you? If you can Ack I assume Jens would
>>>> be able to take this.
>>
>> Sure, I should have ACKed it a month ago already.  As I said, I believe
>> you the crypto. And you added the kmap_atomic as I pointed out.
>> All good.
> 
> Great, thanks! Jens, can you take this?

Done, queued up for 4.20.

-- 
Jens Axboe
