Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:36540 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751702AbdKDIS0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 4 Nov 2017 04:18:26 -0400
Date: Sat, 4 Nov 2017 09:18:25 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <keith.busch@intel.com>
Cc: Christoph Hellwig <hch@lst.de>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <jg@lightnvm.io>,
        sagi@grimberg.me, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@cnexlabs.com>
Subject: Re: [PATCH 1/3] nvme: do not check for ns on rw path
Message-ID: <20171104081825.GA19180@lst.de>
References: <1509703370-20379-1-git-send-email-javier@cnexlabs.com> <1509703370-20379-2-git-send-email-javier@cnexlabs.com> <20171103125339.GA25186@lst.de> <20171103150203.GA11300@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171103150203.GA11300@localhost.localdomain>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Nov 03, 2017 at 09:02:04AM -0600, Keith Busch wrote:
> If the namespace has metadata, but the request doesn't have a metadata
> payload attached to it for whatever reason, we can't construct the command
> for that format. We also can't have the controller strip/generate the
> payload with PRACT bit set if it's not a T10 format, so we just fail
> the command.

The only metadata payload a READ or WRITE request can have is a protection
information one.  For a namespace formatted with protection information
bio_integrity_prep as called from blk_mq_make_request will ensure we
always have metadata attached.

If a namespace is formatted with non-PI metadata we will never have
metadata attached to the bio/request and should not even present the
namespace to the kernel.
