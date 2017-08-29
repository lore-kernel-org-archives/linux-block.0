Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 1/2] bfq: Re-enable auto-loading when built as a module
To: Ben Hutchings <ben@decadent.org.uk>
Cc: Paolo Valente <paolo.valente@linaro.org>, linux-block@vger.kernel.org
References: <20170813170219.GG18698@decadent.org.uk>
 <20170829143130.GA4857@kernel.dk> <1504020486.4448.13.camel@decadent.org.uk>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <42dfcdc3-6ba2-57d0-7cbc-9529498be365@kernel.dk>
Date: Tue, 29 Aug 2017 09:48:46 -0600
MIME-Version: 1.0
In-Reply-To: <1504020486.4448.13.camel@decadent.org.uk>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/29/2017 09:28 AM, Ben Hutchings wrote:
> On Tue, 2017-08-29 at 08:31 -0600, Jens Axboe wrote:
>> On Sun, Aug 13 2017, Ben Hutchings wrote:
>>> The block core requests modules with the "-iosched" name suffix, but
>>> bfq no longer has that suffix.  Add an alias.
>>
>> I'd apply these two, but both patches are mangled when saved. It's
>> turning == into =3D and so forth.
>>
>> Care to check your settings and resend?
> 
> Just tried saving and applying with 'git am' successfully.  I think the
> problem is at your end.

Then yours is the only one, I apply patches people send me all day long.
Was the case both in tbird and mutt, both of them showed the diffs
as mangled, and they showed up mangled when saved.

-- 
Jens Axboe
