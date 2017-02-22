Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:31993 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932493AbdBVQZr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Feb 2017 11:25:47 -0500
Date: Wed, 22 Feb 2017 09:15:51 -0700
From: Scott Bauer <scott.bauer@intel.com>
To: Jon Derrick <jonathan.derrick@intel.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Rafael Antognolli <rafael.antognolli@intel.com>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] block/sed: Embed function data into the function sequence
Message-ID: <20170222161551.GB2696@sbauer-Z170X-UD5>
References: <1487775313-10188-1-git-send-email-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1487775313-10188-1-git-send-email-jonathan.derrick@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Feb 22, 2017 at 07:55:13AM -0700, Jon Derrick wrote:
> By embedding the function data with the function sequence, we can
> eliminate the external function data and state variable code. It also
> made obvious some other small cleanups.
> 
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
Reviewed-by: Scott Bauer <scott.bauer@intel.com>

Christoph's review is here (I don't know if its kosher for me to put it in my message)
http://lists.infradead.org/pipermail/linux-nvme/2017-February/008405.html
