Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:64336 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965165AbcKJXMB (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Nov 2016 18:12:01 -0500
Date: Thu, 10 Nov 2016 18:23:12 -0500
From: Keith Busch <keith.busch@intel.com>
To: Scott Bauer <scott.bauer@intel.com>
Cc: Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, Rafael.Antognolli@intel.com,
        axboe@fb.com, linux-block@vger.kernel.org,
        jonathan.derrick@intel.com, j.naumann@fu-berlin.de
Subject: Re: [RFC PATCH 5/6] nvme: Add unlock_from_suspend
Message-ID: <20161110232312.GG4929@localhost.localdomain>
References: <1477951099-3127-1-git-send-email-scott.bauer@intel.com>
 <1477951099-3127-6-git-send-email-scott.bauer@intel.com>
 <6a6a131a-09fe-4c7c-85a7-01149555e427@grimberg.me>
 <20161101135705.GA32697@infradead.org>
 <20161110230130.GA1923@sbauer-Z170X-UD5>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161110230130.GA1923@sbauer-Z170X-UD5>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Nov 10, 2016 at 04:01:31PM -0700, Scott Bauer wrote:
> On Tue, Nov 01, 2016 at 06:57:05AM -0700, Christoph Hellwig wrote:
> > blk_execute_rq_nowait is the API to use - blk_mq_insert_request isn't
> > even exported.
> 
> I remember now, after I changed it to use rq_nowait, why we added this wrapper
> function and used blk_mq_insert_request.
> 
> When we dispatch opal commands down to the controller we're doing so in an IRQ,
> so if we use rq_nowait, we lockup.

In this case can we push the submission off to a work queue and use
blk_mq_insert_rq_nowait?
