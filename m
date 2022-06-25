Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E345BC433EF
	for <linux-block@archiver.kernel.org>; Sat, 25 Jun 2022 09:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbiFYJYA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 25 Jun 2022 05:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbiFYJX7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 25 Jun 2022 05:23:59 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744FAF5A7
        for <linux-block@vger.kernel.org>; Sat, 25 Jun 2022 02:23:58 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0B35968B05; Sat, 25 Jun 2022 11:23:51 +0200 (CEST)
Date:   Sat, 25 Jun 2022 11:23:49 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 51/51] fs/zonefs: Fix sparse warnings in tracing code
Message-ID: <20220625092349.GA23530@lst.de>
References: <20220623180528.3595304-1-bvanassche@acm.org> <20220623180528.3595304-52-bvanassche@acm.org> <20220624045613.GA4505@lst.de> <aa044f61-46f0-5f21-9b17-a1bb1ff9c471@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa044f61-46f0-5f21-9b17-a1bb1ff9c471@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jun 24, 2022 at 12:57:56PM -0700, Bart Van Assche wrote:
> On 6/23/22 21:56, Christoph Hellwig wrote:
>> On Thu, Jun 23, 2022 at 11:05:28AM -0700, Bart Van Assche wrote:
>>> Since __bitwise types are not supported by the tracing infrastructure, store
>>> the operation type as an int in the tracing event.
>>
>> Please give the field in the trace even the proper type instead of
>> all the crazy casting.
>
> Hi Christoph,
>
> I will do that. BTW, I discovered the code in the tracing infrastructure 
> that makes sparse unhappy:
>
> #define is_signed_type(type) (((type)(-1)) < (type)1)
>
> Sparse reports four warnings for that expression if 'type' is a bitwise 
> type. Two of these warnings can be suppressed by changing 'type' into 
> '__force type'. I have not yet found a way to suppress all the sparse 
> warnings triggered by the is_signed_type() macro for bitwise types.

Yeah, that is a bit of a mess.  Rasmus, Steven - any good idea how
we can make the trace even macros fit for sparse?  Maybe just drop the
is_signed_type check for __CHECKER__ ?

