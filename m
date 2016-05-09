Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH BUGFIX] block: add missing group association in bio_split
To: Mark Brown <broonie@kernel.org>, Paolo <paolo.valente@linaro.org>
References: <1462567512-3007-1-git-send-email-paolo.valente@linaro.org>
 <x49bn4f71qi.fsf@segfault.boston.devel.redhat.com>
 <x4937pr70z5.fsf@segfault.boston.devel.redhat.com>
 <5730A108.1000703@linaro.org> <20160509145647.GB3458@sirena.org.uk>
Cc: Jeff Moyer <jmoyer@redhat.com>, Tejun Heo <tj@kernel.org>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 ulf.hansson@linaro.org, linus.walleij@linaro.org, stable@vger.kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <5730CFC5.80201@kernel.dk>
Date: Mon, 9 May 2016 11:58:29 -0600
MIME-Version: 1.0
In-Reply-To: <20160509145647.GB3458@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 05/09/2016 08:56 AM, Mark Brown wrote:
> On Mon, May 09, 2016 at 04:39:04PM +0200, Paolo wrote:
>> Il 09/05/2016 16:35, Jeff Moyer ha scritto:
>
>>> Gah, I see that the bi_css member is only present for CONFIG_BLK_CGROUP.
>>> I guess we'll have to live with the ifdef.
>
>> We have already tried to remove it, but it seems it would require other
>> major changes.
>
> It probably should get fixed, but separately to the bug fix.

It's a minor tweak, might as well submit them together. Because if you 
don't, it has a tendency to be forgotten once the original issue is 
resolved.

-- 
Jens Axboe
