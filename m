Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:37434 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755925AbeFOHit (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Jun 2018 03:38:49 -0400
Date: Fri, 15 Jun 2018 00:38:46 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Mike Snitzer <snitzer@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, NeilBrown <neilb@suse.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [dm-devel] why does __split_and_process_bio use bio_clone_bioset?
Message-ID: <20180615073846.GA29726@infradead.org>
References: <20180614081947.GA23375@infradead.org>
 <20180614181245.GA1161@redhat.com>
 <20180614200808.GA46373@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180614200808.GA46373@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Jun 14, 2018 at 04:08:09PM -0400, Mike Snitzer wrote:
> The patch below seems to work fine (given quick testing).. It also has a
> side-effect of not breaking integrity support (which commit 18a25da8
> appears to do because it isn't accounting for any of the integrity stuff
> bio_split, or dm.c:clone_bio, does).

Looks sensible to me.  Are you going to queue this up for 4.18?
