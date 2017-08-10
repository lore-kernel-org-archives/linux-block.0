Return-Path: <bblock@linux.vnet.ibm.com>
Date: Fri, 11 Aug 2017 00:45:15 +0200
From: Benjamin Block <bblock@linux.vnet.ibm.com>
To: Christoph Hellwig <hch@lst.de>
Cc: "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Steffen Maier <maier@linux.vnet.ibm.com>, open-iscsi@googlegroups.com
Subject: Re: [RFC PATCH 1/6] bsg: fix kernel panic resulting from missing
 allocation of a reply-buffer
References: <cover.1502120928.git.bblock@linux.vnet.ibm.com>
 <9e67ce3fc2f3cd42e9e05b2753b00d6676f46ee1.1502120928.git.bblock@linux.vnet.ibm.com>
 <20170810093217.GL24539@lst.de>
 <20170810221038.GA918@bblock-ThinkPad-W530>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20170810221038.GA918@bblock-ThinkPad-W530>
Message-Id: <20170810224515.GD918@bblock-ThinkPad-W530>
List-ID: <linux-block@vger.kernel.org>

On Fri, Aug 11, 2017 at 12:10:38AM +0200, Benjamin Block wrote:
> On Thu, Aug 10, 2017 at 11:32:17AM +0200, Christoph Hellwig wrote:
> > We can't use an on-stack buffer for the sense data, as drivers will
> > dma to it.  So we should reuse the SCSI init_rq_fn() for the BSG
> > queues and/or implement the same scheme.
> > 
> 
...
> 
>  struct sg_io_v4
>  +--------------+
>  |              |  
>  | request-------->+----------------------------+
>  |   + _len     |  |                            |
>  |   (A)        |  | BSG Request                |
>  |              |  | e.g. struct fc_bsg_request | Depends on BSG implementation
>  |              |  |                            | FC vs. iSCSI vs. ...
>  |              |  +----------------------------+
>  |              |
>  | response------->+----------------------------+ Used as _Output_
>  |   + max_len  |  |                            | User doesn't initialize
>  |   (B)        |  | BSG Reply                  | User provides (optional)
>  |              |  | e.g. struct fc_bsg_reply   |   memory; May be NULL.
>  |              |  |                            |
>  |              |  +----------------------------+
>  |              |
>  | dout_xferp----->+-----------------------+ Stuff send on the wire by
>  |   + _len     |  |                       |   the LLD
>  |   (C)        |  | Transport Protocol IU | Aligned on PAGE_SIZE
>  |              |  | e.g. FC-GS-7 CT_IU    |
>  |              |  |                       |
>  |              |  +-----------------------+
>  |              |
>  | din_xferp------>+-----------------------+ Buffer for response data by
>  |   + _len     |  |                       |   the LLD
>  |   (D)        |  | Transport Protocol IU | Aligned on PAGE_SIZE
>  |              |  | e.g. FC-GS-7 CT_IU    |
>  |              |  |                       |
>  |              |  +-----------------------+
>  +--------------+
> 
...
> 
>  struct request (E)
>  +--------------+
>  |              |  struct scsi_request
>  | scsi_request--->+-----------------+
>  |              |  |                 |
>  |              |  | cmd---------------------> Copy of (A)
>  |              |  |  + _len         |         Space in struct or kzalloc
>  |              |  |  (G)            |
>  |              |  |                 |
>  |              |  | sense-------------------> Space for BSG Reply
>  |              |  |  + _len         |         Same Data-Structure as (B)
>  |              |  |  (H)            |         NOT actually pointer (B)
>  |              |  |                 |         'reply_buffer' in my patch 
>  |              |  +-----------------+
>  |              |
>  | bio------------> Mapped via blk_rq_map_user() to (C) dout_xferp
>  |              |
>  | next_rq---------+
>  |              |  |
>  +--------------+  |
>                    |
>  struct request (F)|(if used)
>  +--------------+<-+
>  |              |
>  | scsi_request---> Unused here
>  |              |
>  | bio------------> Mapped via blk_rq_map_user() to (D) din_xferp
>  |              |
>  +--------------+
> 
...
> 
>  struct bsg_job
>  +-----------------+
>  |                 |
>  | request-----------> (G) scsi_request->cmd -> Copy of (A)
>  |   + _len        |       e.g. struct fc_bsg_request
>  |                 |
>  | reply-------------> (H) scsi_request->sense -> 'reply_buffer'
>  |   + _len        |       e.g. struct fc_bsg_reply
>  |                 |
>  | request_payload---> struct scatterlist ... map (E)->bio
>  |   + _len        |
>  |   (I)           |
>  |                 |
>  | reply_payload-----> struct scatterlist ... map (F)->bio
>  |   + _len        |
>  |   (J)           |
>  |                 |
>  +-----------------+
> 
....
> 
> This worked till it broke. Right now every driver that tries to access
> (H) will panic the system, or cause very undefined behavior. I suspect
> no driver right now tries to do any DMA into (H); before the regression,
> this has been also an on-stack variable (I suspect since BSG was
> introduced, haven't checked though).
> 
> The asymmetries between the first struct request (E) and the following
> (F) also makes it hard to use the same scheme as in other drivers, where
> init_rq_fn() gets to initialize each request in the same'ish way. Or?
> Just looking at it right now, this would require some bigger rework that
> is not appropriate for a stable bug-fix.
> 

Just some more brain-dump here.

One more problem for direct DMA into (H) in the current BSG setup is
probably, that the transport classes have each their own private format
for the BSG reply (struct fc_bsg_reply and struct iscsi_bsg_reply right
now I think). The current stack doesn't take any precaution to properly
align this in accords to what the LLDs specifies for the blk-layer... so
lets assume struct fc_bsg_reply. This has fields for actual protocol IUs
(in contrast to iSCSI, where it only has some vendor-reply buffer [an
array with 0 length...]), but they start after some BSG meta-data that
are non-standard. We would have to rewrite that to allow mapping the
start of the protocol IUs in accords to the expectations the LLDs have..
page-aligned and such things. Otherwise we would break whatever handles
the meta-data the LLD pass up the stack - added that this is actually
user visible data, passed back via struct sg_io_v4.

This could be something of a new feature I guess, it would be an
improvement in terms that it could reduce copies even more, but w/o
further research I guess it is a bit more work.



                                                    Beste Gr��e / Best regards,
                                                      - Benjamin Block
-- 
Linux on z Systems Development         /         IBM Systems & Technology Group
		  IBM Deutschland Research & Development GmbH 
Vorsitz. AufsR.: Martina Koederitz     /        Gesch�ftsf�hrung: Dirk Wittkopp
Sitz der Gesellschaft: B�blingen / Registergericht: AmtsG Stuttgart, HRB 243294
