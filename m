Return-Path: <SRS0=HuTb=YA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73FF4C352AA
	for <linux-block@archiver.kernel.org>; Mon,  7 Oct 2019 10:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44B862084D
	for <linux-block@archiver.kernel.org>; Mon,  7 Oct 2019 10:02:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbfJGKCW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Oct 2019 06:02:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:46820 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726010AbfJGKCW (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 7 Oct 2019 06:02:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B0CFBB1ED;
        Mon,  7 Oct 2019 10:02:17 +0000 (UTC)
Subject: Re: packet writing support
To:     Mischa Baars <mjbaars1977.linux-block@cyberfiber.eu>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <db5c89c3fe26e4b7ec96443ec97a05df97162889.camel@cyberfiber.eu>
 <6e381f83-9a12-30d7-8f99-caaa6a608c4f@kernel.dk>
 <a4b89c40caf62166ab7078296d73b6ae0f35adaf.camel@cyberfiber.eu>
 <fc70b63f-3780-5654-6bc5-0f2d6115bff0@kernel.dk>
 <6c51a5fe93cfad0f76fdbfe47caaa5f5d3f1ca88.camel@cyberfiber.eu>
 <71a450ed-3f52-fb3a-b0fa-3a08bdc4b3f6@suse.de>
 <977cedab873dfe0705701b3b43c621a7a516e396.camel@cyberfiber.eu>
 <ce56abfd-f309-5471-0201-6226731fa452@suse.de>
 <6eb30ce355f90eca126cbd2f11d359db2bbe69f1.camel@cyberfiber.eu>
From:   Hannes Reinecke <hare@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=hare@suse.de; prefer-encrypt=mutual; keydata=
 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
 azzYF4VRJsdl+d0MCaSy8mUh
Message-ID: <2eb69a14-ad96-573a-4b68-aaabee178b42@suse.de>
Date:   Mon, 7 Oct 2019 12:02:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <6eb30ce355f90eca126cbd2f11d359db2bbe69f1.camel@cyberfiber.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/7/19 11:11 AM, Mischa Baars wrote:
> On Mon, 2019-10-07 at 10:45 +0200, Hannes Reinecke wrote:
>> On 10/7/19 10:07 AM, Mischa Baars wrote:
>>> On Mon, 2019-10-07 at 09:23 +0200, Hannes Reinecke wrote:
>>>> On 10/7/19 9:02 AM, Mischa Baars wrote:
>>>>> On Sun, 2019-10-06 at 09:10 -0600, Jens Axboe wrote:
>>>> [ .. ]
>>>>>> I'm saying that you are comparing apples to oranges. The floppy driver
>>>>>> might be older tech, but it's much more used than pktcdvd. It's not the
>>>>>> case that we must pick one over the other, in terms of what stays and
>>>>>> what goes.
>>>>>>
>>>>>
>>>>> Yes we are, sort of. You can even have my pear. That's exactly the problem with your story :)
>>>>>
>>>>> A DVD is 4Gb and Blueray goes all the way up to 100Gb, while a floppy disc is 1.44Mb.
>>>>> Who would want to write his backup files to 1.44Mb floppy disc these days?
>>>>>
>>>> Why do you keep on bringing up floppy?
>>>> I was under the impression that you wanted to use pktdvd, not floppy...
>>>> And as Jens made it clear, any potential removal of the floppy driver
>>>> will have _zero_ influence on the future of pktdvd.
>>>
>>> I do not keep bringing up the floppy drives. I'm merely trying to point
>>> out that removing the floppy driver is the more logical course of action.
>>>
>> ??
>>
>>> Also, you must be mistaken. It's not about the potential removal of the
>>> floppy driver, it's about the removal of the packet writing driver. There
>>> will be no pktcdvd kernel module in the future. To be precise, both reading
>>> and writing dvd's is already unsupported in the latest linux-next kernel.
>>>
>> I know what pktcddvd is, and I know what it's used for.
>> All what Jens has been complaining is that the code has been
>> unmaintained for quite a while, and only very few bugfixes coming in.
>> Which typically indicates that there are only very few users left, if any.
> 
> Well, I was using it :(
> 
> Hope that isn't any problem?
> 
>>>> And in either case, the main question here was:
>>>> Will you rebase your project to latest mainline once it's ready?
>>>> Or will you settle on a kernel version to do your development on, and
>>>> continue using that for your project?
>>>
>>> No, the code is intended for companies like AMD, Intel or ARM. It
>>> is not indended for the opensource community. Does that mean that
>>> I cannot develop on an opensource platform? Is that you are trying to tell me?
>>>
>> No.
>> What we are trying to tell you is that:
>> a) The code is unmaintained, and (as of now) there hadn't been anyone
>> expressing an interest. If you require this driver for your project,
>> send a mail to Jens Axboe that you are willing to take over
>> maintainership for this driver. Then you get to decide if and when the
>> driver should be obsoleted. You'll be responsible for fixing issues with
>> that driver, true, but to quote the brexit axiom: you can't have the
>> cake and eat it ...
>> b) The underlying hardware is becoming obsolete. SCSI CD-ROM drivers are
>> a thing of the past, and ATAPI hardware is on its way to be replaced
>> with USB Flash. Case in point: ATAPI support got dropped from the ATA
>> spec ACS-4, and most laptops nowadays don't even have a DVD slot
>> anymore. Hence I would question the need for DVD support in the future.
>> Unless, of course, you do happen to work for a company producing said
>> devices, in which case I would strongly recommend going for a) above.
> 
> b) My point exactly, CD, DVD and Blueray is being replaced by USB Flash.
> The problem is, as you can read in my first mail, is that USB is rewritable. Also, I
> can't even image that 100Gb Blueray is a thing of the past. Slots can be
> replaced by USB, but that doesn't make the writer obsolete.
> 
Kingston 128GB USB flash, USD 15 per unit.
What was your question?

> 
> a) If neccesary I could do the maintaining, sure.
> 
Guess it is.
Please send a mail to Jens Axboe applying for pktdvd maintainership.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		      Teamlead Storage & Networking
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 247165 (AG München), GF: Felix Imendörffer
