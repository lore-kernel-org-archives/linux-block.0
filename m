Return-Path: <hare@suse.de>
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Hannes Reinecke <hare@suse.de>
Subject: REQ_OP_WRITE_ZEROES clash with REQ_FAILFAST_TRANSPORT ?
Message-ID: <b67451d2-3c01-9fdc-20b3-04d7165db36d@suse.de>
Date: Fri, 21 Sep 2018 11:15:20 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

Hi all,

there's one thing which decidedly puzzles me:

We have:

#define REQ_OP_BITS	8
#define REQ_OP_MASK	((1 << REQ_OP_BITS) - 1)
#define REQ_FLAG_BITS	24

enum req_opf {
	/* read sectors from the device */
	REQ_OP_READ		= 0,
	/* write sectors to the device */
	REQ_OP_WRITE		= 1,
	/* flush the volatile write cache */
	REQ_OP_FLUSH		= 2,
	/* discard sectors */
	REQ_OP_DISCARD		= 3,
	/* get zone information */
	REQ_OP_ZONE_REPORT	= 4,
	/* securely erase sectors */
	REQ_OP_SECURE_ERASE	= 5,
	/* seset a zone write pointer */
	REQ_OP_ZONE_RESET	= 6,
	/* write the same sector many times */
	REQ_OP_WRITE_SAME	= 7,
	/* write the zero filled sector many times */
 >>	REQ_OP_WRITE_ZEROES	= 9,

and

enum req_flag_bits {
	__REQ_FAILFAST_DEV =	/* no driver retries of device errors */
		REQ_OP_BITS,
 >>	__REQ_FAILFAST_TRANSPORT, /* no driver retries of transport errors */
	__REQ_FAILFAST_DRIVER,	/* no driver retries of driver errors */

If my calculation skills are correct, both __REQ_FAILFAST_TRANSPORT and 
REQ_OP_WRITE_ZEROES end up on bit 9.

Which means that
a) any check for REQ_OP_WRITE_ZEROES will be true for a request with 
REQ_FAILFAST_TRANSPORT
and
b) this check:
#define req_op(req) \
	((req)->cmd_flags & REQ_OP_MASK)

will actually _exclude_ REQ_WRITE_ZEROES.
Am I correct?
Is this intended?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
