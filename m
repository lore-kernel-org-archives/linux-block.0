Return-Path: <hare@suse.de>
Subject: Re: [PATCH 06/12] blk-mq-debugfs: Generate name-to-text translation
 tables
To: Bart Van Assche <bart.vanassche@wdc.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Omar Sandoval <osandov@fb.com>, Hannes Reinecke <hare@suse.com>
References: <20170817232311.25948-1-bart.vanassche@wdc.com>
 <20170817232311.25948-7-bart.vanassche@wdc.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <f9025128-2244-2082-ef0c-605d5ca2f993@suse.de>
Date: Fri, 18 Aug 2017 09:38:11 +0200
MIME-Version: 1.0
In-Reply-To: <20170817232311.25948-7-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/18/2017 01:23 AM, Bart Van Assche wrote:
> It is easy to add a flag to one of the block layer headers and to
> forget to update blk-mq-debugfs.c. E.g. QUEUE_FLAG_SCSI_PASSTHROUGH,
> QUEUE_FLAG_QUIESCED and REQ_NOWAIT are missing from blk-mq-debugfs.c.
> Hence generate the symbol-to-text translation tables.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
> Cc: Omar Sandoval <osandov@fb.com>
> Cc: Hannes Reinecke <hare@suse.com>
> ---
>  block/.gitignore       |   1 +
>  block/Makefile         |  58 ++++++++++++++++++++++
>  block/blk-mq-debugfs.c | 130 +------------------------------------------------
>  3 files changed, 61 insertions(+), 128 deletions(-)
>  create mode 100644 block/.gitignore
> 
> diff --git a/block/.gitignore b/block/.gitignore
> new file mode 100644
> index 000000000000..63b09639ab06
> --- /dev/null
> +++ b/block/.gitignore
> @@ -0,0 +1 @@
> +blk-name-tables.c
> diff --git a/block/Makefile b/block/Makefile
> index 2b281cf258a0..f9bd77426ac1 100644
> --- a/block/Makefile
> +++ b/block/Makefile
> @@ -33,3 +33,61 @@ obj-$(CONFIG_BLK_DEV_ZONED)	+= blk-zoned.o
>  obj-$(CONFIG_BLK_WBT)		+= blk-wbt.o
>  obj-$(CONFIG_BLK_DEBUG_FS)	+= blk-mq-debugfs.o
>  obj-$(CONFIG_BLK_SED_OPAL)	+= sed-opal.o
> +
> +clean-files := blk-name-tables.c
> +
> +$(obj)/blk-mq-debugfs.o: $(obj)/blk-name-tables.c
> +
> +$(obj)/blk-name-tables.c: block/Makefile block/blk.h include/linux/blk-mq.h \
> +		include/linux/blk_types.h include/linux/blkdev.h
> +	@(								\
> +	printf "static const char *const blk_queue_flag_name[] = {\n";	\
> +	s='^#define QUEUE_FLAG_\([^[:blank:]]*\)[[:blank:]]\+[0-9]\+.*';\
> +	r='\t\[QUEUE_FLAG_\1\] = "\1",';				\
> +	sed -n "s/$$s/$$r/p" include/linux/blkdev.h;			\
> +	printf "};\n";							\
> +	printf "\n";							\
> +	printf "static const char *const hctx_state_name[] = {\n";	\
> +	s='^[[:blank:]]BLK_MQ_S_\([^[:blank:]]*\)[[:blank:]]\+=[[:blank:]]*[0-9]\+.*'; \
> +	r='\t\[BLK_MQ_S_\1\] = "\1",';					\
> +	sed -n "s/$$s/$$r/p" include/linux/blk-mq.h;			\
> +	printf "};\n";							\
> +	printf "\n";							\
> +	printf "static const char *const alloc_policy_name[] = {\n";	\
> +	s='^#define BLK_TAG_ALLOC_\([^[:blank:]]*\)[[:blank:]]\+[0-9]\+.*';\
> +	r='\t\[BLK_TAG_ALLOC_\1\] = "\1",';				\
> +	sed -n "s/$$s/$$r/p" include/linux/blkdev.h;			\
> +	printf "};\n";							\
> +	printf "\n";							\
> +	printf "static const char *const hctx_flag_name[] = {\n";	\
> +	s='^[[:blank:]]BLK_MQ_F_\([^[:blank:]]*\)[[:blank:]]\+=[[:blank:]]*[0-9]\+.*'; \
> +	r='\t\[ilog2(BLK_MQ_F_\1)\] = "\1",';				\
> +	sed -n "s/$$s/$$r/p" include/linux/blk-mq.h |			\
> +	grep -v BLK_MQ_F_ALLOC_POLICY_;					\
> +	printf "};\n";							\
> +	printf "\n";							\
> +	printf "static const char *const op_name[] = {\n";		\
> +	s='^[[:blank:]]REQ_OP_\([^[:blank:]]*\)[[:blank:]]\+=[[:blank:]]*[0-9]\+.*';   \
> +	r='\t\[REQ_OP_\1\] = "\1",';					\
> +	sed -n "s/$$s/$$r/p" include/linux/blk_types.h;			\
> +	printf "};\n";							\
> +	printf "\n";							\
> +	printf "static const char *const cmd_flag_name[] = {\n";	\
> +	s='^#define REQ_\([^[:blank:]]*\)[[:blank:]]*(1.*';		\
> +	r='\t\[REQ_\1\] = "\1",';					\
> +	sed -n "s/$$s/$$r/p" include/linux/blk_types.h;			\
> +	printf "};\n";							\
> +	printf "\n";							\
> +	printf "static const char *const rqf_name[] = {\n";		\
> +	s='^#define RQF_\([^[:blank:]]*\)[[:blank:]]\+(.*';		\
> +	r='\t\[RQF_\1\] = "\1",';					\
> +	sed -n "s/$$s/$$r/p" include/linux/blkdev.h;			\
> +	printf "};\n";							\
> +	printf "\n";							\
> +	printf "static const char *const rqaf_name[] = {\n";		\
> +	s='^[[:blank:]]REQ_ATOM_\([^[:blank:],]*\).*';			\
> +	r='\t\[REQ_ATOM_\1\] = "\1",';					\
> +	sed -n "s/$$s/$$r/p" block/blk.h;				\
> +	printf "};\n";							\
> +	printf "\n";							\
> +	) >$@

Can't you just make this a generic function, and run this per header file?
In the end, each file might be changed independently, so we really
should have distinct makefile target here and not lump it all into one.
Plus I need this function for my 'blacklist' sysfs attribute, too.

And, not forgetting, we should be doing some sort of error handling
here. It's all nice and proper to have decoded flags, but if things goes
pearshaped we might end up with invalid values in the respective
variable. In those cases we _really_ want to see those values, hence I
would advocate for printing out _all_ values, decoding those we know
about, and print out the remaining ones verbatim.

Thanks.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
