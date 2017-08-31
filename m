Return-Path: <linux-block-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:53740 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750908AbdHaVYJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Aug 2017 17:24:09 -0400
Date: Thu, 31 Aug 2017 22:24:08 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 1/2] <linux/uaccess.h>: Fix copy_in_user() declaration
Message-ID: <20170831212407.GR5426@ZenIV.linux.org.uk>
References: <20170823222911.29453-1-bart.vanassche@wdc.com>
 <20170823222911.29453-2-bart.vanassche@wdc.com>
 <1504214495.31872.59.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1504214495.31872.59.camel@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Aug 31, 2017 at 09:21:37PM +0000, Bart Van Assche wrote:
> On Wed, 2017-08-23 at 15:29 -0700, Bart Van Assche wrote:
> > copy_in_user() copies data from user-space address @from to user-
> > space address @to. Hence declare both @from and @to as user-space
> > pointers.
> > [ ... ]
> 
> Hi Al,
> 
> Can you have a look at this patch? Patch 2/2 from this series already got
> queued for kernel v4.14 by Jens.

Yes, it's in #for-linus in my local tree.
