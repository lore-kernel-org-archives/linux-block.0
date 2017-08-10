Return-Path: <bblock@linux.vnet.ibm.com>
Date: Fri, 11 Aug 2017 00:19:53 +0200
From: Benjamin Block <bblock@linux.vnet.ibm.com>
To: Christoph Hellwig <hch@lst.de>
Cc: "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Steffen Maier <maier@linux.vnet.ibm.com>, open-iscsi@googlegroups.com
Subject: Re: [RFC PATCH 5/6] bsg: reduce unnecessary arguments for
 bsg_map_hdr()
References: <cover.1502120928.git.bblock@linux.vnet.ibm.com>
 <6d4d39222a4b76f9b39ec52e0aca5b01a3fac9e1.1502120928.git.bblock@linux.vnet.ibm.com>
 <20170810093531.GP24539@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20170810093531.GP24539@lst.de>
Message-Id: <20170810221953.GC918@bblock-ThinkPad-W530>
List-ID: <linux-block@vger.kernel.org>

On Thu, Aug 10, 2017 at 11:35:31AM +0200, Christoph Hellwig wrote:
> On Wed, Aug 09, 2017 at 04:11:19PM +0200, Benjamin Block wrote:
> > Since struct bsg_command is now used in every calling case, we don't
> > need separation of arguments anymore that are contained in the same
> > bsg_command.
> > 
> > Signed-off-by: Benjamin Block <bblock@linux.vnet.ibm.com>
> > ---
> >  block/bsg.c | 13 ++++++-------
> >  1 file changed, 6 insertions(+), 7 deletions(-)
> > 
> > diff --git a/block/bsg.c b/block/bsg.c
> > index 8517361a9b3f..6ee2ffca808a 100644
> > --- a/block/bsg.c
> > +++ b/block/bsg.c
> > @@ -212,11 +212,12 @@ bsg_validate_sgv4_hdr(struct sg_io_v4 *hdr, int *op)
> >   * map sg_io_v4 to a request.
> >   */
> >  static struct request *
> > -bsg_map_hdr(struct bsg_device *bd, struct sg_io_v4 *hdr, fmode_t has_write_perm,
> > -	    u8 *reply_buffer)
> > +bsg_map_hdr(struct bsg_device *bd, struct bsg_command *bc,
> > +	    fmode_t has_write_perm)
> 
> I wish we could just rename the argument to mode and pass on the
> whole file->f_mode while you are cleaning up this code.  That should
> be a separate patch, though.
> 

Hmm, I did a quick pass through the code and the only place this seems
to be used, is to pass it to blk_verify_command() if the subcommand used
in the BSG request is a SCSI Command. And this has the same semantics.
So I guess this would require adjustments to the whole stack, as this is
also used from the 'normal' SG side of the world.



                                                    Beste Gr��e / Best regards,
                                                      - Benjamin Block
-- 
Linux on z Systems Development         /         IBM Systems & Technology Group
		  IBM Deutschland Research & Development GmbH 
Vorsitz. AufsR.: Martina Koederitz     /        Gesch�ftsf�hrung: Dirk Wittkopp
Sitz der Gesellschaft: B�blingen / Registergericht: AmtsG Stuttgart, HRB 243294
