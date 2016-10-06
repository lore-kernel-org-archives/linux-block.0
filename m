Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45862 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751476AbcJFRtp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 6 Oct 2016 13:49:45 -0400
Date: Thu, 6 Oct 2016 13:49:43 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Paolo Valente <paolo.valente@unimore.it>
Cc: Shaohua Li <shli@fb.com>, Tejun Heo <tj@kernel.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@fb.com>, Kernel-team@fb.com,
        jmoyer@redhat.com, Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V3 00/11] block-throttle: add .high limit
Message-ID: <20161006174943.GD17335@redhat.com>
References: <20161004191427.GG4205@htj.duckdns.org>
 <B8B66027-D652-46E2-A0C6-81F227817571@unimore.it>
 <20161004202754.GJ4205@htj.duckdns.org>
 <257945FA-6789-4D80-8DA3-AC75640C71AE@unimore.it>
 <20161005144946.GA26977@htj.duckdns.org>
 <20161005183052.GA97491@anikkar-mbp.local.dhcp.thefacebook.com>
 <E7D744B7-22B1-4D6B-9C42-A43517AA490F@unimore.it>
 <20161005204601.GB1754@anikkar-mbp.local.dhcp.thefacebook.com>
 <5699035C-6DC3-497A-9D7A-A4E43D17C3CD@unimore.it>
 <35D8ECB2-BE20-4A4E-9B93-951B0D5042C9@unimore.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <35D8ECB2-BE20-4A4E-9B93-951B0D5042C9@unimore.it>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Oct 06, 2016 at 03:15:50PM +0200, Paolo Valente wrote:

[..]
> Shaohua, I have just realized that I have unconsciously defended a
> wrong argument.  Although all the facts that I have reported are
> evidently true, I have argued as if the question was: "do we need to
> throw away throttling because there is proportional, or do we need to
> throw away proportional share because there is throttling?".  This
> question is simply wrong, as I think consciously (sorry for my
> dissociated behavior :) ).

I was wondering about the same. We need both and both should be able 
to work with fast devices of today using blk-mq interfaces without
much overhead.

> 
> The best goal to achieve is to have both a good throttling mechanism,
> and a good proportional share scheduler.  This goal would be valid if
> even if there was just one important scenario for each of the two
> approaches.  The vulnus here is that you guys are constantly, and
> rightly, working on solutions to achieve and consolidate reasonable
> QoS guarantees, but an apparently very good proportional-share
> scheduler has been kept off for years.  If you (or others) have good
> arguments to support this state of affairs, then this would probably
> be an important point to discuss.

Paolo, CFQ is legacy now and if we can come up with a proportional
IO mechanism which works reasonably well with fast devices using
blk-mq interfaces, that will be much more interesting.

Vivek
