Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:60791 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756036AbdKCMxl (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 3 Nov 2017 08:53:41 -0400
Date: Fri, 3 Nov 2017 13:53:40 +0100
From: Christoph Hellwig <hch@lst.de>
To: Javier =?iso-8859-1?Q?Gonz=E1lez?= <jg@lightnvm.io>
Cc: hch@lst.de, sagi@grimberg.me, keith.busch@intel.com,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@cnexlabs.com>
Subject: Re: [PATCH 1/3] nvme: do not check for ns on rw path
Message-ID: <20171103125339.GA25186@lst.de>
References: <1509703370-20379-1-git-send-email-javier@cnexlabs.com> <1509703370-20379-2-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1509703370-20379-2-git-send-email-javier@cnexlabs.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

> -	if (ns && ns->ms &&
> +	if (ns->ms &&
>  	    (!ns->pi_type || ns->ms != sizeof(struct t10_pi_tuple)) &&
>  	    !blk_integrity_rq(req) && !blk_rq_is_passthrough(req))
>  		return BLK_STS_NOTSUPP;

blk_rq_is_passthrough also can't be true here.

How about:

	if (ns->ms && !blk_integrity_rq(req) &&
	    (!ns->pi_type || ns->ms != sizeof(struct t10_pi_tuple)))
		return BLK_STS_NOTSUPP;

Although I have to admit I don't really understand what this check
is even trying to do.  It basically checks for a namespace that has
a format with metadata that is not T10 protection information and
then rejects all I/O to it.  Why are we even creating a block device
node for such a thing?
