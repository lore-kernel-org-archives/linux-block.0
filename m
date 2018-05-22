Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:52011 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751189AbeEVK2H (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 May 2018 06:28:07 -0400
Subject: Re: [PATCH v2] lib/crc64.c: add license information
To: Kent Overstreet <kent.overstreet@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-bcache@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>
References: <20180522085400.66980-1-colyli@suse.de>
 <abea841e-5dd8-bade-829c-993dfd273f62@suse.de>
 <bd792e3ae793f08881b8ecdb383b46a6e25a1de2.camel@linux.intel.com>
 <739c84e8-a07d-934d-3226-3361f5cc1ed7@suse.de>
 <CAC7rs0vR1xxZy8Zsz1hK8ni9X4psUviGvC9ykRjPzjy4L824dg@mail.gmail.com>
From: Coly Li <colyli@suse.de>
Message-ID: <b10c2718-1942-5190-f935-fff03b36902f@suse.de>
Date: Tue, 22 May 2018 18:27:39 +0800
MIME-Version: 1.0
In-Reply-To: <CAC7rs0vR1xxZy8Zsz1hK8ni9X4psUviGvC9ykRjPzjy4L824dg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 2018/5/22 6:01 PM, Kent Overstreet wrote:
> Postgresql is under its own license, which is basically the BSD
> license under a different name.
> 
> I don't know if there's precedent for calling that BSD or if you
> should just say the postgresql license.
> 

Oh, I just realize the original code is PostgreSQL license. So we cannot
export the symbols by EXPORT_SYMBOL_GPL(). Add Linux kernel requires
lib/crc64.c has a license statement by MODULE_LICENSE(), and I don't see
anywhere else uses MODULE_LICENSE("PostgreSQL").

So I need to ask help from lawyers, and for this moment I will hold
related patches for 4.18.

Thanks.


> On Tue, May 22, 2018 at 5:55 AM, Coly Li <colyli@suse.de> wrote:
>> On 2018/5/22 5:53 PM, Andy Shevchenko wrote:
>>> On Tue, 2018-05-22 at 17:01 +0800, Coly Li wrote:
>>>> On 2018/5/22 4:54 PM, Coly Li wrote:
>>>>> This patch adds MODULE_LICENSE("GPL") to remove a kernel build
>>>>> warning
>>>>> information. Also as Andy Shevchenko suggested, adds a SPDX header
>>>>> into
>>>>> lib/crc64.c file.
>>>>>
>>>
>>>> Could you please to offer a Reviewed-by or Acked-by ? We have an
>>>> agreement that every patch should have a peer reviewer, at this moment
>>>> we are lack of code reviewer but I still want to keep this rule as
>>>> much
>>>> as I can.
>>>
>>> I would love to, but I'm not a lawyer. I can't do it in _this_ case,
>>> sorry.
>>>
>>
>> OK... Then I have to ask someone else to review this patch.
>>
>> Thanks.
>>
>> Coly Li
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bcache" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
