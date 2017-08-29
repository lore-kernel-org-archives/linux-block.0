Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 1/2] bfq: Re-enable auto-loading when built as a module
To: Ben Hutchings <ben@decadent.org.uk>
Cc: Paolo Valente <paolo.valente@linaro.org>, linux-block@vger.kernel.org
References: <20170813170219.GG18698@decadent.org.uk>
 <20170829143130.GA4857@kernel.dk> <1504020486.4448.13.camel@decadent.org.uk>
 <42dfcdc3-6ba2-57d0-7cbc-9529498be365@kernel.dk>
 <6c0f654f-3a6e-a904-c67c-bb0fec03972a@kernel.dk>
 <1504024458.4448.18.camel@decadent.org.uk>
 <06a60078-1592-dc39-a2d9-df3320460bed@kernel.dk>
 <1504036184.4448.20.camel@decadent.org.uk>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <374764c0-eb64-311f-00dc-d4d4bb4c494a@kernel.dk>
Date: Tue, 29 Aug 2017 13:57:25 -0600
MIME-Version: 1.0
In-Reply-To: <1504036184.4448.20.camel@decadent.org.uk>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/29/2017 01:49 PM, Ben Hutchings wrote:
> On Tue, 2017-08-29 at 10:46 -0600, Jens Axboe wrote:
>> On 08/29/2017 10:34 AM, Ben Hutchings wrote:
>>> On Tue, 2017-08-29 at 09:53 -0600, Jens Axboe wrote:
>>>> On 08/29/2017 09:48 AM, Jens Axboe wrote:
>>>>> On 08/29/2017 09:28 AM, Ben Hutchings wrote:
>>>>>> On Tue, 2017-08-29 at 08:31 -0600, Jens Axboe wrote:
>>>>>>> On Sun, Aug 13 2017, Ben Hutchings wrote:
>>>>>>>> The block core requests modules with the "-iosched" name
>>>>>>>> suffix, but
>>>>>>>> bfq no longer has that suffix.  Add an alias.
>>>>>>>
>>>>>>> I'd apply these two, but both patches are mangled when saved.
>>>>>>> It's
>>>>>>> turning == into =3D and so forth.
>>>>>>>
>>>>>>> Care to check your settings and resend?
>>>>>>
>>>>>> Just tried saving and applying with 'git am' successfully.  I
>>>>>> think the
>>>>>> problem is at your end.
>>>>>
>>>>> Then yours is the only one, I apply patches people send me all day
>>>>> long.
>>>>> Was the case both in tbird and mutt, both of them showed the diffs
>>>>> as mangled, and they showed up mangled when saved.
>>>>
>>>> Here's your email in the archive:
>>>>
>>>> https://marc.info/?l=linux-block&m=150264374920778&q=raw
>>>>
>>>> Note this part:
>>>>
>>>> Content-Transfer-Encoding: quoted-printable
>>>
>>> What about it?  This is used for every mail with a non-ASCII name in
>>> it, for example.  'git am' understands it.
>>
>> What about it? It screws up the patch. Maybe git am understands it, but
>> it's hard/impossible to read manually.
> 
> Where, other than the 'raw' link above, are you seeing the patch with
> q-p encoding not decoded?

When I save it and view it.

>> I'm not going to apply anything
>> that I can't personally read/review easily. Fix your setup, if you are
>> going to be sending patches.
> 
> So you won't accept patches from anyone with a non-ASCII name?

You're being ridiculous.

-- 
Jens Axboe
