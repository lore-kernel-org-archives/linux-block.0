Return-Path: <scott.bauer@intel.com>
Date: Thu, 29 Mar 2018 11:16:42 -0600
From: Scott Bauer <scott.bauer@intel.com>
To: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Cc: Christoph Hellwig <hch@lst.de>,
	Jonathan Derrick <jonathan.derrick@intel.com>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/11] block: sed-opal: ioctl for writing to shadow mbr
Message-ID: <20180329171641.5cgnpldzq7j3ndhp@sbauer-Z170X-UD5>
References: <cover.1520946114.git.jonas.rabenstein@studium.uni-erlangen.de>
 <cover.1521482295.git.jonas.rabenstein@studium.uni-erlangen.de>
 <9f94be9c32887aacdcba75bd6a3902d0350eb987.1521482296.git.jonas.rabenstein@studium.uni-erlangen.de>
 <20180319195224.GA3380@lst.de>
 <20180320093604.qge2sdnc5jrud6kg@studium.uni-erlangen.de>
 <20180320220907.zdzf7baag6haaonm@sbauer-Z170X-UD5>
 <20180321014321.xlkcyvcyr6j3usix@studium.uni-erlangen.de>
 <20180329173002.5mmhnl4urj4wovyo@studium.uni-erlangen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180329173002.5mmhnl4urj4wovyo@studium.uni-erlangen.de>
List-ID: <linux-block@vger.kernel.org>

On Thu, Mar 29, 2018 at 07:30:02PM +0200, Jonas Rabenstein wrote:
> Hi,
> On Wed, Mar 21, 2018 at 02:43:21AM +0100, Jonas Rabenstein wrote:
> > On Tue, Mar 20, 2018 at 04:09:08PM -0600, Scott Bauer wrote:
> > > On Tue, Mar 20, 2018 at 10:36:04AM +0100, Jonas Rabenstein wrote:
> > > > On Mon, Mar 19, 2018 at 08:52:24PM +0100, Christoph Hellwig wrote:
> > > > > On Mon, Mar 19, 2018 at 07:36:50PM +0100, Jonas Rabenstein wrote:
> > > > > I hate doing this as an ioctls.  Can we make this a sysfs binary file
> > > > > so that people can use dd or cat to write the shadow mbr?
> > > > I already thought about providing a sysfs interface for all that instead
> > > > of using ioctls. But as I am pretty new to kernel programming I do not
> > > > have all the required insight. Especially, as writing the mbr requires
> > > > the sed-opal password I am unsure how a clean sysfs interface to provide
> > > > the password together with a simple dd would look like.
> Just wanted to ask, how to proceed with those patches/what I should do.
> Using sysfs instead of an ioctl is probably easier to use from userspace
> _if_ there is a good way to provide the password - which I do not know
> of :(
> If nobody else could think of a solution, shall writes to the shadow mbr
> remain unsupported?
> 
> I'ld really appreciate feedback and possible solutions,
>  Jonas

Yeah, having to autheticate to write the MBR is a real bummer. Theoretically
you could dd a the pw struct + the shador MBR into sysfs. But that's
a pretty disgusting hack just to use sysfs. The other method I thought of
was to authenticate via ioctl then write via sysfs. We already save the PW
in-kernel for unlocks, so perhaps we can re-use the save-for-unlock to
do shadow MBR writes via sysfs?

Re-using an already exposed ioctl for another purpose seems somewhat dangerous?
In the sense that what if the user wants to write the smbr but doesn't want to
unlock on suspends, or does not want their PW hanging around in the kernel.

Overall I think the ioctl is still the best path forward due to the authentication
problem. But am still willing to hear others opinions if they do have an idea.

I can say yes to the Ioctl, but we really need Jens and Christophs Okay on it.

I have some free time tomorrow to work on this, so let me goof with it tomorrow and
over the weekend and I'll see if there is a sane way to get sysfs to work.
