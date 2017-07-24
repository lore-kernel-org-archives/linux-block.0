Return-Path: <wouter@grep.be>
Date: Mon, 24 Jul 2017 22:08:21 +0200
From: Wouter Verhelst <w@uter.be>
To: josef@toxicpanda.com
Cc: axboe@kernel.dk, nbd-general@lists.sourceforge.net,
	linux-block@vger.kernel.org, kernel-team@fb.com,
	Josef Bacik <jbacik@fb.com>
Subject: Re: [Nbd] [PATCH 1/3] nbd: allow multiple disconnects to be sent
Message-ID: <20170724200821.v5qbx35s637mmlg4@grep.be>
References: <1500648495-13337-1-git-send-email-jbacik@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1500648495-13337-1-git-send-email-jbacik@fb.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, Jul 21, 2017 at 10:48:13AM -0400, josef@toxicpanda.com wrote:
> From: Josef Bacik <jbacik@fb.com>
> 
> There's no reason to limit ourselves to one disconnect message per
> socket.  Sometimes networks do strange things, might as well let
> sysadmins hit the panic button as much as they want.

The protocol spec is pretty clear that any requests sent after the
disconnect request was sent out are not guaranteed to be processed
anymore.

Doesn't this allow more requests to be sent out? Or is the
NBD_DISCONNECT_REQUESTED flag enough to make that impossible?

-- 
Could you people please use IRC like normal people?!?

  -- Amaya Rodrigo Sastre, trying to quiet down the buzz in the DebConf 2008
     Hacklab
