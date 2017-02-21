Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:37831 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751754AbdBUXND (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Feb 2017 18:13:03 -0500
Date: Tue, 21 Feb 2017 16:03:09 -0700
From: Scott Bauer <scott.bauer@intel.com>
To: Jon Derrick <jonathan.derrick@intel.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Rafael Antognolli <rafael.antognolli@intel.com>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCHv4 4/4] block/sed: Embed function data into the function
 sequence
Message-ID: <20170221230308.GA3311@sbauer-Z170X-UD5>
References: <1487703556-19913-1-git-send-email-jonathan.derrick@intel.com>
 <1487703556-19913-5-git-send-email-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1487703556-19913-5-git-send-email-jonathan.derrick@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Feb 21, 2017 at 11:59:16AM -0700, Jon Derrick wrote:
> By embedding the function data with the function sequence, we can
> eliminate the external function data and state variable code. It also
> made obvious some other small cleanups.
> 
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
Reviewed-by: Scott Bauer <scott.bauer@intel.com>

Also Christoph had reviewed-by on 1-3 on friday, I dont think we need a respin,
but wanted to point that out since his tag isnt on 1-3 v4:
https://marc.info/?l=linux-block&m=148725565212351&w=2
https://marc.info/?l=linux-block&m=148725603312475&w=2
https://marc.info/?l=linuxppc-embedded&m=148725612212503&w=2
