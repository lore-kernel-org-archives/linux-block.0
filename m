Return-Path: <linux-block-owner@vger.kernel.org>
Received: from 22.17.110.36.static.bjtelecom.net ([36.110.17.22]:11775 "EHLO
        BJEXMBX011.didichuxing.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751197AbdH1QHi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Aug 2017 12:07:38 -0400
Date: Tue, 29 Aug 2017 00:07:22 +0800
From: weiping zhang <zhangweiping@didichuxing.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block, scheduler: convert xxx_var_store to void
Message-ID: <20170828160722.GA13024@localhost.didichuxing.com>
References: <20170824171127.GA25877@localhost.didichuxing.com>
 <20170828122156.GA29322@localhost.didichuxing.com>
 <ad4b9407-6dd0-0a03-9c36-5e9da24b056a@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <ad4b9407-6dd0-0a03-9c36-5e9da24b056a@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Aug 28, 2017 at 10:00:46AM -0600, Jens Axboe wrote:
> On 08/28/2017 06:22 AM, weiping zhang wrote:
> > On Fri, Aug 25, 2017 at 01:11:33AM +0800, weiping zhang wrote:
> >> The last parameter "count" never be used in xxx_var_store,
> >> convert these functions to void.
> >>
> >
> > Would you please look this misc patch at your convenience ?
> 
> Looks fine. But please don't send reminders so shortly after sending a
> patch, especially when it's just a cleanup. This was received Thursday.
> 
> -- 
> Jens Axboe
> 

Got it, Thanks! ^_^
