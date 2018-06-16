Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:34406 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753988AbeFPPUz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Jun 2018 11:20:55 -0400
Date: Sat, 16 Jun 2018 08:20:52 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Mike Snitzer <snitzer@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, NeilBrown <neilb@suse.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: why does __split_and_process_bio use bio_clone_bioset?
Message-ID: <20180616152052.GA7934@infradead.org>
References: <20180614081947.GA23375@infradead.org>
 <20180614181245.GA1161@redhat.com>
 <20180614200808.GA46373@redhat.com>
 <20180615073846.GA29726@infradead.org>
 <20180615182631.GA6906@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180615182631.GA6906@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Jun 15, 2018 at 02:26:31PM -0400, Mike Snitzer wrote:
> Yes.  Already queued, likely won't send to Linus until end of next week
> though.. unless you want it upstream sooner?

We only really need it as a baseline for the multi-page bio work, so
no real rush.  I think I'll just include it with my pending cleanup
series with a big 'DO NOT APPLY, will be in 4.18-rc2' marker.
