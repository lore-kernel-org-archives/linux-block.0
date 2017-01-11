Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:56747 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966737AbdAKNqH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Jan 2017 08:46:07 -0500
Subject: Re: [LSF/MM TOPIC][LSF/MM ATTEND] NAPI polling for block drivers
To: Johannes Thumshirn <jthumshirn@suse.de>,
        "lsf-pc@lists.linux-foundation.org"
        <lsf-pc@lists.linux-foundation.org>
References: <20170111134312.GH6286@linux-x5ow.site>
Cc: linux-block@vger.kernel.org, Linux-scsi@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org,
        Christoph Hellwig <hch@infradead.org>,
        Keith Busch <keith.busch@intel.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <79efbc41-26fb-77e5-751a-05d7c811870d@suse.de>
Date: Wed, 11 Jan 2017 14:46:04 +0100
MIME-Version: 1.0
In-Reply-To: <20170111134312.GH6286@linux-x5ow.site>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 01/11/2017 02:43 PM, Johannes Thumshirn wrote:
> Hi all,
> 
> I'd like to attend LSF/MM and would like to discuss polling for block drivers.
> 
> Currently there is blk-iopoll but it is neither as widely used as NAPI in the
> networking field and accoring to Sagi's findings in [1] performance with
> polling is not on par with IRQ usage.
> 
> On LSF/MM I'd like to whether it is desirable to have NAPI like polling in
> more block drivers and how to overcome the currently seen performance issues.
> 
> [1] http://lists.infradead.org/pipermail/linux-nvme/2016-October/006975.html
> 
Yup.

I'm all for it.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: F. Imend�rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N�rnberg)
