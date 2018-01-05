Return-Path: <m@bjorling.me>
Return-Path: <m@bjorling.me>
Subject: Re: [GIT PULL 00/25] LightNVM updates for 4.16
To: Jens Axboe <axboe@kernel.dk>
References: <20180105131621.20808-1-m@bjorling.me>
 <20180105155054.GB13829@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <m@bjorling.me>
Message-ID: <83c66c1c-ba27-4cfd-da9e-a57c1f941d47@bjorling.me>
Date: Fri, 5 Jan 2018 19:34:41 +0100
MIME-Version: 1.0
In-Reply-To: <20180105155054.GB13829@kernel.dk>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 01/05/2018 04:50 PM, Jens Axboe wrote:
> On Fri, Jan 05 2018, Matias Bj�rling wrote:
>> Hi Jens,
>>
>> Here is a couple of patches for 4.16.
>>
>> This patchset prepares the lightnvm and pblk source code for the 2.0
>> specification release. The specification is close to its final
>> revision. After these changes, 2.0 support is a quick drop.
>>
>> While adopting 2.0 specification, the rrpc and null_blk
>> implementation had to go. rrpc used the deprecated device-side
>> table mapping table API for the 1.2 specification, and there are
>> no users of it. Similarly, null_blk has not worked with pblk for
>> a while.
>>
>> Javier and Hans have been hard at work at fixing up bugs in pblk,
>> especially concerning synchronization points between user I/O and GC
>> I/O. While also fixing bugs that occurred on bringup/bringdown.
>>
>> They also added support for iostats and added an option to add
>> support for defining the amount of over-provisioning an instance
>> should have.
>
> Apart from the minor comment on one of the later patches, looks fine to
> me. Applied for 4.16.
>

Thanks Jens.
