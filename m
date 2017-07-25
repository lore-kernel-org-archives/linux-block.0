Return-Path: <wouter@grep.be>
Date: Tue, 25 Jul 2017 12:08:18 +0200
From: Wouter Verhelst <w@uter.be>
To: Josef Bacik <josef@toxicpanda.com>
Cc: axboe@kernel.dk, nbd-general@lists.sourceforge.net,
	linux-block@vger.kernel.org, kernel-team@fb.com,
	Josef Bacik <jbacik@fb.com>
Subject: Re: [Nbd] [PATCH 1/3] nbd: allow multiple disconnects to be sent
Message-ID: <20170725100818.d5chrswz6yxrd5gv@grep.be>
References: <1500648495-13337-1-git-send-email-jbacik@fb.com>
 <20170724200821.v5qbx35s637mmlg4@grep.be>
 <20170724232429.GA7376@destiny>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170724232429.GA7376@destiny>
List-ID: <linux-block@vger.kernel.org>

On Mon, Jul 24, 2017 at 07:24:30PM -0400, Josef Bacik wrote:
> On Mon, Jul 24, 2017 at 10:08:21PM +0200, Wouter Verhelst wrote:
> > On Fri, Jul 21, 2017 at 10:48:13AM -0400, josef@toxicpanda.com wrote:
> > > From: Josef Bacik <jbacik@fb.com>
> > > 
> > > There's no reason to limit ourselves to one disconnect message per
> > > socket.  Sometimes networks do strange things, might as well let
> > > sysadmins hit the panic button as much as they want.
> > 
> > The protocol spec is pretty clear that any requests sent after the
> > disconnect request was sent out are not guaranteed to be processed
> > anymore.
> > 
> > Doesn't this allow more requests to be sent out? Or is the
> > NBD_DISCONNECT_REQUESTED flag enough to make that impossible?
> > 
> 
> This just allows users to call the disconnect ioctl/netlink thing multiple times
> and have it send the DISCONNECT command if they want.

Right.

> We've had problems with our in-hosue nbd server missing messages,

That's pretty bad...

> and it's just a pain to have to unstuck it because the server messed up.
> It's just for the rare case the server is being weird, not because we
> expect/guarantee that subsequent disconnect commands will be processed.
> Thanks,

Okay, makes sense. Just thought I'd ask :-)

-- 
Could you people please use IRC like normal people?!?

  -- Amaya Rodrigo Sastre, trying to quiet down the buzz in the DebConf 2008
     Hacklab
