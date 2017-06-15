Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:38233 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752481AbdFOIMq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Jun 2017 04:12:46 -0400
Date: Thu, 15 Jun 2017 01:12:44 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        adilger@dilger.ca, hch@infradead.org, martin.petersen@oracle.com
Subject: Re: [PATCHSET v4] Add support for write life time hints
Message-ID: <20170615081244.GA10342@infradead.org>
References: <1497498312-17704-1-git-send-email-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1497498312-17704-1-git-send-email-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Jun 14, 2017 at 09:45:01PM -0600, Jens Axboe wrote:
> A new iteration of this patchset, previously known as write streams.
> As before, this patchset aims at enabling applications split up
> writes into separate streams, based on the perceived life time
> of the data written. This is useful for a variety of reasons:
> 
> - With NVMe 1.3 compliant devices, the device can expose multiple
>   streams.

Nitpick: while the feature is introduce in NVMe 1.3, the NVMe versioning
rules also allow devices that claim conformance with any older spec
version to implement the feature.
