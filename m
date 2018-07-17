Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:46562 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731721AbeGQOxM (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Jul 2018 10:53:12 -0400
Subject: Re: [PATCH 0/4] add crc64 calculation as kernel library
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hannes Reinecke <hare@suse.de>, linux-kernel@vger.kernel.org
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Luis R . Rodriguez" <mcgrof@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Lyle <mlyle@lyle.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Kate Stewart <kstewart@linuxfoundation.org>
References: <20180716165507.23100-1-colyli@suse.de>
 <8538b45b-bf30-926a-50fb-700b4bf1c636@suse.de>
 <608100d7-6e98-13ec-57ab-5c672131e332@suse.de>
 <b85806d5a6085f67fb430ca0808b286d0d4d737e.camel@linux.intel.com>
From: Coly Li <colyli@suse.de>
Message-ID: <a2da98a9-65bb-e483-dbf3-410b5d682c11@suse.de>
Date: Tue, 17 Jul 2018 22:20:07 +0800
MIME-Version: 1.0
In-Reply-To: <b85806d5a6085f67fb430ca0808b286d0d4d737e.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 2018/7/17 4:37 PM, Andy Shevchenko wrote:
> On Tue, 2018-07-17 at 14:19 +0800, Coly Li wrote:
>> On 2018/7/17 1:46 PM, Hannes Reinecke wrote:
> 
>>> Actually, I would merge patch 1 & 2 together (pointless to introduce
>>> an
>>> option for which no code exists).
>>
> 
> I was just about to say the same.
> 
>> The patch 1 was originally from Andy Shevchenko, and I want to keep
>> his
>> contribute. If it seems not a good idea from me, I will merge them
>> into
>> 1 patch in v2 series.
> 
> We have Co-developed-by tag, for example, which you may use here (if you
> choose this way, leave my SoB as well).
> 
Thanks for the hint. I add a Co-developed-by tag for you :-)

Coly Li
