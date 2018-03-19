Return-Path: <scott.bauer@intel.com>
Date: Mon, 19 Mar 2018 13:33:12 -0600
From: Scott Bauer <scott.bauer@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
	Jonathan Derrick <jonathan.derrick@intel.com>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/11] block: sed-opal support write to shadow mbr
Message-ID: <20180319193311.bkwq3ir75dz6awcn@sbauer-Z170X-UD5>
References: <cover.1520946114.git.jonas.rabenstein@studium.uni-erlangen.de>
 <cover.1521482295.git.jonas.rabenstein@studium.uni-erlangen.de>
 <20180319195335.GB3380@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180319195335.GB3380@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Mon, Mar 19, 2018 at 08:53:35PM +0100, Christoph Hellwig wrote:
> On Mon, Mar 19, 2018 at 07:36:42PM +0100, Jonas Rabenstein wrote:
> > Hi,
> > I was advised to resend the patchset as a v2 where all the patches are
> > in a flat hierarchy. So here is a complete set which hopefully pleases
> > all requirements.
> > As the previous fixes have by now all landed into linux-next, no
> > additional patches are required for testing.
> 
> Btw, what userspace do you use for this?  The only one I know so far
> is Scotts sed-opal-temp, which really should grow a more permanent
> name / location.

He has a forked verison here:
https://github.com/ghostav/sed-opal-temp

He sent out a v1, obviously, but I had him clean up/resubmit and CC you. So you could
chime in on the new ioctl.

v1:
https://marc.info/?l=linux-block&m=152094656909515&w=4


As for the moving of sed-opal-temp I am more than willing to place this else where. I just
don't have a location other than github to place it. If people have suggestions on where to store it
that *isnt* on my personal github I will do that. And give access to the necessary maintainers.
