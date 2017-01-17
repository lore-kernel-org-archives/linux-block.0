Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:50398 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750849AbdAQPHT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Jan 2017 10:07:19 -0500
Date: Tue, 17 Jan 2017 07:06:38 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Moyer <jmoyer@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-nvdimm@ml01.01.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [LSF/MM TOPIC] Future direction of DAX
Message-ID: <20170117150638.GA3747@infradead.org>
References: <20170114002008.GA25379@linux.intel.com>
 <20170114082621.GC10498@birch.djwong.org>
 <x49wpduzseu.fsf@dhcp-25-115.bos.redhat.com>
 <20170117015033.GD10498@birch.djwong.org>
 <20170117075735.GB19654@infradead.org>
 <x49mvep4tzw.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <x49mvep4tzw.fsf@segfault.boston.devel.redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Jan 17, 2017 at 09:54:27AM -0500, Jeff Moyer wrote:
> I spoke with Dave before the holidays, and he indicated that
> PMEM_IMMUTABLE would be an acceptable solution to allowing applications
> to flush data completely from userspace.  I know this subject has been
> beaten to death, but would you mind just summarizing your opinion on
> this one more time?  I'm guessing this will be something more easily
> hashed out at LSF, though.

Come up with a prototype that doesn't suck and allows all fs features to
actually work.  And show an application that actually cares and shows
benefits on publicly available real hardware.  Until then go away and
stop wasting everyones time.
