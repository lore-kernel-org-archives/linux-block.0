Return-Path: <jonas.rabenstein@studium.uni-erlangen.de>
Date: Wed, 21 Mar 2018 02:43:21 +0100
From: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
To: Scott Bauer <scott.bauer@intel.com>
Cc: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
	Christoph Hellwig <hch@lst.de>,
	Jonathan Derrick <jonathan.derrick@intel.com>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/11] block: sed-opal: ioctl for writing to shadow mbr
Message-ID: <20180321014321.xlkcyvcyr6j3usix@studium.uni-erlangen.de>
References: <cover.1520946114.git.jonas.rabenstein@studium.uni-erlangen.de>
 <cover.1521482295.git.jonas.rabenstein@studium.uni-erlangen.de>
 <9f94be9c32887aacdcba75bd6a3902d0350eb987.1521482296.git.jonas.rabenstein@studium.uni-erlangen.de>
 <20180319195224.GA3380@lst.de>
 <20180320093604.qge2sdnc5jrud6kg@studium.uni-erlangen.de>
 <20180320220907.zdzf7baag6haaonm@sbauer-Z170X-UD5>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180320220907.zdzf7baag6haaonm@sbauer-Z170X-UD5>
List-ID: <linux-block@vger.kernel.org>

On Tue, Mar 20, 2018 at 04:09:08PM -0600, Scott Bauer wrote:
> On Tue, Mar 20, 2018 at 10:36:04AM +0100, Jonas Rabenstein wrote:
> > On Mon, Mar 19, 2018 at 08:52:24PM +0100, Christoph Hellwig wrote:
> > > On Mon, Mar 19, 2018 at 07:36:50PM +0100, Jonas Rabenstein wrote:
> > > > Allow modification of the shadow mbr. If the shadow mbr is not marked as
> > > > done, this data will be presented read only as the device content. Only
> > > > after marking the shadow mbr as done and unlocking a locking range the
> > > > actual content is accessible.
> > > 
> > > I hate doing this as an ioctls.  Can we make this a sysfs binary file
> > > so that people can use dd or cat to write the shadow mbr?
> > I already thought about providing a sysfs interface for all that instead
> > of using ioctls. But as I am pretty new to kernel programming I do not
> > have all the required insight. Especially, as writing the mbr requires
> > the sed-opal password I am unsure how a clean sysfs interface to provide
> > the password together with a simple dd would look like.
> > Moreover I already have a patch that changes the 'void *data' argument
> > to setup_opal_dev to a kobject pointer. As far as I know, this is the
> > first step to get into the sysfs hierarchy. But as I do not have access
> > to an NVMe drive and have no idea about its implementation, this change
> > works only for the scsi side.
> 
> Post what you have as an RFC (review for comment) and I will test for the NVMe
> side, and or start a port for NVMe. It doesn't have to be perfect since you're
> sending it out as RFC. It's just a base for us to test/look at to see if we
> still like the sysfs way.
Seems, like I failed to make my point in the previous message. I do not
have more than adding a directory 'sed_opal' in sysfs for each sed-opal
enabled disk. But that directory is completely empty. My further plans
are, to fill up that directory with some public info like the one that
gets printed by a call to TCG's 'sedutil-cli --query' command.
The interesting part - where I am clueless how to achieve it -  would be
to have a binary sysfs attribute (like mentioned by Christoph) for the
features (like shadow mbr) requiring some kind of authentication. Until
there is any (good) idea, I do not think it is time for an RFC?

-- Jonas
