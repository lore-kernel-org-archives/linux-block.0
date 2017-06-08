Return-Path: <linux-block-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:53399 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750752AbdFHHIE (ORCPT
        <rfc822;groupwise-linux-block@vger.kernel.org:0:0>);
        Thu, 8 Jun 2017 03:08:04 -0400
Subject: Re: [PATCH] Fix loop device flush before configure
To: Christoph Hellwig <hch@infradead.org>
Cc: axboe@fb.com, hare@suse.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, mgorman@suse.com
References: <20170607090104.17337-1-jnwang@suse.com>
 <20170607131718.GC18252@infradead.org>
 <2D8954BF-E3D2-4A61-AAE2-A3FDD080C26A@suse.com>
 <20170608065657.GB14568@infradead.org>
From: James Wang <jnwang@suse.com>
Message-ID: <5e97dcff-b434-40cf-a11a-a933fd04447c@suse.com>
Date: Thu, 8 Jun 2017 15:07:48 +0800
MIME-Version: 1.0
In-Reply-To: <20170608065657.GB14568@infradead.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org



On 06/08/2017 02:56 PM, Christoph Hellwig wrote:
> On Thu, Jun 08, 2017 at 08:45:31AM +0800, James Wang wrote:
>> Ok I got it blktests is a suite. I'd like to contribute something. If you need, we adapt you,;-)!
>> But I have to learn some how to do that, need time.
> I haven't added test myself to blktests yet either, so I'd have to
> learn it as well.  Omar can probably help you though.
>
>
Ah, I have fork this project  in Github.  and write 1 script in 'loop' 
group.

Debuging................


James

-- 
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
