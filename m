Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:6089 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932691AbcKGSeh (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 7 Nov 2016 13:34:37 -0500
Date: Mon, 7 Nov 2016 13:45:42 -0500
From: Keith Busch <keith.busch@intel.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Scott Bauer <scott.bauer@intel.com>,
        linux-nvme@lists.infradead.org, Rafael.Antognolli@intel.com,
        axboe@fb.com, jonathan.derrick@intel.com, j.naumann@fu-berlin.de,
        hch@infradead.org, linux-block@vger.kernel.org
Subject: Re: [RFC PATCH 5/6] nvme: Add unlock_from_suspend
Message-ID: <20161107184541.GA21698@localhost.localdomain>
References: <1477951099-3127-1-git-send-email-scott.bauer@intel.com>
 <1477951099-3127-6-git-send-email-scott.bauer@intel.com>
 <6a6a131a-09fe-4c7c-85a7-01149555e427@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6a6a131a-09fe-4c7c-85a7-01149555e427@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Nov 01, 2016 at 10:18:13AM +0200, Sagi Grimberg wrote:
> > -	spin_lock_irq(&nvmeq->q_lock);
> > +	spin_lock_irqsave(&nvmeq->q_lock, flags);
> >  	if (unlikely(nvmeq->cq_vector < 0)) {
> >  		if (ns && !test_bit(NVME_NS_DEAD, &ns->flags))
> >  			ret = BLK_MQ_RQ_QUEUE_BUSY;
> >  		else
> >  			ret = BLK_MQ_RQ_QUEUE_ERROR;
> > -		spin_unlock_irq(&nvmeq->q_lock);
> > +		spin_unlock_irqrestore(&nvmeq->q_lock, flags);
> >  		goto out;
> >  	}
> >  	__nvme_submit_cmd(nvmeq, &cmnd);
> >  	nvme_process_cq(nvmeq);
> > -	spin_unlock_irq(&nvmeq->q_lock);
> > +	spin_unlock_irqrestore(&nvmeq->q_lock, flags);
> 
> No documentation why this is needed...

Let's forget documenting why it's needed; this solution should instead
figure out a way to make it so it's not needed.
