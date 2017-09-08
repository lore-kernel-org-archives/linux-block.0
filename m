Return-Path: <scott.bauer@intel.com>
Date: Fri, 8 Sep 2017 13:36:12 -0600
From: Scott Bauer <scott.bauer@intel.com>
To: Jens <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, hch@infradead.org
Subject: Re: [PATCH V2] block: sed-opal: Set MBRDone on S3 resume path if
 TPER is MBREnabled
Message-ID: <20170908193610.b2nlhawecb2wiuy6@sbauer-Z170X-UD5>
References: <20170901145335.9244-1-scott.bauer@intel.com>
 <bcc3f33b-9ac1-59e5-09f3-41db81659a4a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <bcc3f33b-9ac1-59e5-09f3-41db81659a4a@intel.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Sep 05, 2017 at 04:51:51PM -0600, Jon Derrick wrote:
Jens, sorry to bother, can you take this? Or do you have any follow up comments?

RHEL Is starting to pull changes in for 7.5 I want to get this landed so they can
pick it up.

If it's already on your list, sorry for being impatient.
> Looks good
> 
> Acked-by Jon Derrick: <jonathan.derrick@intel.com>
> 
> 
> On 09/01/2017 08:53 AM, Scott Bauer wrote:
> > Users who are booting off their Opal enabled drives are having
> > issues when they have a shadow MBR set up after s3/resume cycle.
> > When the Drive has a shadow MBR setup the MBRDone flag is set to
> > false upon power loss (S3/S4/S5). When the MBRDone flag is false
> > I/O to LBA 0 -> LBA_END_MBR are remapped to the shadow mbr
> > of the drive. If the drive contains useful data in the 0 -> end_mbr
> > range upon s3 resume the user can never get to that data as the
> > drive will keep remapping it to the MBR. To fix this when we unlock
> > on S3 resume, we need to tell the drive that we're done with the
> > shadow mbr (even though we didnt use it) by setting true to MBRDone.
> > This way the drive will stop the remapping and the user can access
> > their data.
> > 
