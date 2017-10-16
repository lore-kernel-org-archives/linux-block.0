Return-Path: <linux-block-owner@vger.kernel.org>
Received: from server.coly.li ([162.144.45.48]:53566 "EHLO server.coly.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752109AbdJPSHi (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Oct 2017 14:07:38 -0400
Subject: Re: [PATCHv3] bcache: only permit to recovery read error when cache
 device is clean
To: Michael Lyle <mlyle@lyle.org>
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
References: <20170921195458.53890-1-colyli@suse.de>
 <CAJ+L6qdqn1i=UFJcaO+xQzgZj_o5RNm71XhnSznrtMqt0P5Tew@mail.gmail.com>
From: Coly Li <i@coly.li>
Message-ID: <dcb97d02-c9cf-5de9-1821-cba6ab747949@coly.li>
Date: Tue, 17 Oct 2017 02:07:25 +0800
MIME-Version: 1.0
In-Reply-To: <CAJ+L6qdqn1i=UFJcaO+xQzgZj_o5RNm71XhnSznrtMqt0P5Tew@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 2017/10/17 上午1:39, Michael Lyle wrote:
> Hey Coly--
> 
> On Thu, Sep 21, 2017 at 12:54 PM, Coly Li <colyli@suse.de> wrote:
>> When bcache does read I/Os, for example in writeback or writethrough mode,
>> if a read request on cache device is failed, bcache will try to recovery
>> the request by reading from cached device. If the data on cached device is
>> not synced with cache device, then requester will get a stale data.
> [...]
>> +       if (s->recoverable &&
>> +           (dc && !atomic_read(&dc->has_dirty)) {
> 
> Looks like this is missing a parens.

Hi Mike,

Oops, I am blind ... Thanks for figure out this.

V4 patch is out, and I think you may change Acked-by to Reviewed-by,
because you reviewed the code and pointed out problem :-)

Thanks.

-- 
Coly Li
