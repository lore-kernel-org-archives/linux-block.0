Return-Path: <wouter@grep.be>
Date: Tue, 12 Jun 2018 11:22:31 +0200
From: Wouter Verhelst <w@uter.be>
To: Josef Bacik <josef@toxicpanda.com>
Cc: axboe@kernel.dk, nbd@other.debian.org, linux-block@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH] nbd: set discard_alignment to the granularity
Message-ID: <20180612092231.GB6540@grep.be>
References: <20180605154123.3226-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180605154123.3226-1-josef@toxicpanda.com>
List-ID: <linux-block@vger.kernel.org>

Hi Josef,

On Tue, Jun 05, 2018 at 11:41:23AM -0400, Josef Bacik wrote:
> Technically we should be able to get away with 0 as the
> discard_alignment, but there's no way currently for the protocol to
> indicate different alignments,

Actually there is, with the NBD_INFO_BLOCK_SIZE (and related)
response(s) to the NBD_OPT_GO message during negotiation, but
implementing that will probably require some more netlink messages.

(some of this is still being hashed out on the NBD mailinglist; I'm sure
your insights in that would be welcome)

-- 
Could you people please use IRC like normal people?!?

  -- Amaya Rodrigo Sastre, trying to quiet down the buzz in the DebConf 2008
     Hacklab
