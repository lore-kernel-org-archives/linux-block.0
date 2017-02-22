Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:16057 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932710AbdBVROu (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Feb 2017 12:14:50 -0500
Date: Wed, 22 Feb 2017 12:22:39 -0500
From: Keith Busch <keith.busch@intel.com>
To: Jens Axboe <axboe@fb.com>
Cc: Scott Bauer <scott.bauer@intel.com>, linux-block@vger.kernel.org,
        Rafael Antognolli <rafael.antognolli@intel.com>,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: Re: [PATCHv4 4/4] block/sed: Embed function data into the function
 sequence
Message-ID: <20170222172238.GA28937@localhost.localdomain>
References: <1487703556-19913-1-git-send-email-jonathan.derrick@intel.com>
 <1487703556-19913-5-git-send-email-jonathan.derrick@intel.com>
 <20170222071342.GA17472@lst.de>
 <22a94611-3cbd-792f-8347-3b1c1f200944@fb.com>
 <20170222161331.GA2696@sbauer-Z170X-UD5>
 <51275275-9cff-ce94-f760-3572161dde79@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <51275275-9cff-ce94-f760-3572161dde79@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Feb 22, 2017 at 09:47:53AM -0700, Jens Axboe wrote:
> I see, I found it now. Guys, let's get this process streamlined a bit
> more. This whole thing has been a flurry of patches and patchseries,
> posted by either you or Jon. Previous patch series was 1-4 patches
> posted by you, and then patch #4 is replaced by a single patch from Jon,
> posted outside of that thread. Honestly, I feel like this should have
> been pushed to 4.12 instead, it clearly wasn't ready before the merge
> window.

Sorry, I'll run interference to help ensure future patch series are
complete and coherent in one thread.
