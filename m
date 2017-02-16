Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:55892 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932694AbdBPSzP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Feb 2017 13:55:15 -0500
Date: Thu, 16 Feb 2017 11:45:29 -0700
From: Scott Bauer <scott.bauer@intel.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Jens Axboe <axboe@fb.com>
Subject: Re: [PATCH] opal: Use empty structure when not defined
Message-ID: <20170216184528.GA3899@sbauer-Z170X-UD5>
References: <1487204187-4004-1-git-send-email-keith.busch@intel.com>
 <20170216075812.GA7662@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170216075812.GA7662@infradead.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Feb 15, 2017 at 11:58:12PM -0800, Christoph Hellwig wrote:
> I'd rather prefer to make the structure separately allocated as
> discussed before.  Scott, can you test the patch below?  I'm not near
> my devices I could test on.
> 
> ---
> From b2cda0c7ec5c0ec66582655751838f519cfa1706 Mon Sep 17 00:00:00 2001
> From: Christoph Hellwig <hch@lst.de>
> Date: Thu, 16 Feb 2017 08:49:56 +0100
> Subject: block/sed-opal: make struct opal_dev private
> 
> This moves the definition of struct opal_dev into sed-opal.c.  For this a
> new private data field is added to it that is passed to the send/receive
> callback.  After that a lot of internals can be made private.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/opal_proto.h       |  23 ++++++++++
>  block/sed-opal.c         | 101 +++++++++++++++++++++++++++++++++++++----
>  drivers/nvme/host/core.c |   9 ++--
>  drivers/nvme/host/nvme.h |  14 ++----
>  drivers/nvme/host/pci.c  |   8 +++-
>  include/linux/sed-opal.h | 116 ++---------------------------------------------
>  6 files changed, 131 insertions(+), 140 deletions(-)
> 
> diff --git a/block/opal_proto.h b/block/opal_proto.h
> index af9abc56c157..f40c9acf8895 100644
> --- a/block/opal_proto.h
> +++ b/block/opal_proto.h
> @@ -19,6 +19,29 @@
>  #ifndef _OPAL_PROTO_H
>  #define _OPAL_PROTO_H
>  
> +/*
> + * These constant values come from:
> + * SPC-4 section
> + * 6.30 SECURITY PROTOCOL IN command / table 265.
> + */
> +enum {
> +	TCG_SECP_00 = 0,
> +	TCG_SECP_01,
> +};
> +
> +/*
> + * Token defs derived from:
> + * TCG_Storage_Architecture_Core_Spec_v2.01_r1.00
> + * 3.2.2 Data Stream Encoding
> + */
> +enum opal_response_token {
> +	OPAL_DTA_TOKENID_BYTESTRING = 0xe0,
> +	OPAL_DTA_TOKENID_SINT = 0xe1,
> +	OPAL_DTA_TOKENID_UINT = 0xe2,
> +	OPAL_DTA_TOKENID_TOKEN = 0xe3, /* actual token is returned */
> +	OPAL_DTA_TOKENID_INVALID = 0X0
> +};
> +
>  #define DTAERROR_NO_METHOD_STATUS 0x89
>  #define GENERIC_HOST_SESSION_NUM 0x41
>  
> diff --git a/block/sed-opal.c b/block/sed-opal.c
> index bf1406e5159b..bdab4dfcbafd 100644
> --- a/block/sed-opal.c
> +++ b/block/sed-opal.c
> @@ -31,6 +31,77 @@
>  
>  #include "opal_proto.h"
>  
> +#define IO_BUFFER_LENGTH 2048
> +#define MAX_TOKS 64
> +
> +typedef int (*opal_step)(struct opal_dev *dev);
> +
> +enum opal_atom_width {
> +	OPAL_WIDTH_TINY,
> +	OPAL_WIDTH_SHORT,
> +	OPAL_WIDTH_MEDIUM,
> +	OPAL_WIDTH_LONG,
> +	OPAL_WIDTH_TOKEN
> +};
> +
> +/*
> + * On the parsed response, we don't store again the toks that are already
> + * stored in the response buffer. Instead, for each token, we just store a
> + * pointer to the position in the buffer where the token starts, and the size
> + * of the token in bytes.
> + */
> +struct opal_resp_tok {
> +	const u8 *pos;
> +	size_t len;
> +	enum opal_response_token type;
> +	enum opal_atom_width width;
> +	union {
> +		u64 u;
> +		s64 s;
> +	} stored;
> +};
> +
> +/*
> + * From the response header it's not possible to know how many tokens there are
> + * on the payload. So we hardcode that the maximum will be MAX_TOKS, and later
> + * if we start dealing with messages that have more than that, we can increase
> + * this number. This is done to avoid having to make two passes through the
> + * response, the first one counting how many tokens we have and the second one
> + * actually storing the positions.
> + */
> +struct parsed_resp {
> +	int num;
> +	struct opal_resp_tok toks[MAX_TOKS];
> +};
> +
> +struct opal_dev {
> +	bool supported;
> +
> +	void *data;
> +	sec_send_recv *send_recv;
> +
> +	const opal_step *funcs;
> +	void **func_data;
> +	int state;
> +	struct mutex dev_lock;
> +	u16 comid;
> +	u32 hsn;
> +	u32 tsn;
> +	u64 align;
> +	u64 lowest_lba;
> +
> +	size_t pos;
> +	u8 cmd[IO_BUFFER_LENGTH];
> +	u8 resp[IO_BUFFER_LENGTH];
> +
> +	struct parsed_resp parsed;
> +	size_t prev_d_len;
> +	void *prev_data;
> +
> +	struct list_head unlk_lst;
> +};
> +
> +
>  static const u8 opaluid[][OPAL_UID_LENGTH] = {
>  	/* users */
>  	[OPAL_SMUID_UID] =
> @@ -243,14 +314,14 @@ static u16 get_comid_v200(const void *data)
>  
>  static int opal_send_cmd(struct opal_dev *dev)
>  {
> -	return dev->send_recv(dev, dev->comid, TCG_SECP_01,
> +	return dev->send_recv(dev->data, dev->comid, TCG_SECP_01,
>  			      dev->cmd, IO_BUFFER_LENGTH,
>  			      true);
>  }
>  
>  static int opal_recv_cmd(struct opal_dev *dev)
>  {
> -	return dev->send_recv(dev, dev->comid, TCG_SECP_01,
> +	return dev->send_recv(dev->data, dev->comid, TCG_SECP_01,
>  			      dev->resp, IO_BUFFER_LENGTH,
>  			      false);
>  }
> @@ -1943,16 +2014,24 @@ static int check_opal_support(struct opal_dev *dev)
>  	return ret;
>  }
>  
> -void init_opal_dev(struct opal_dev *opal_dev, sec_send_recv *send_recv)
> +struct opal_dev *init_opal_dev(void *data, sec_send_recv *send_recv)
>  {
> -	if (opal_dev->initialized)
> -		return;
> -	INIT_LIST_HEAD(&opal_dev->unlk_lst);
> -	mutex_init(&opal_dev->dev_lock);
> -	opal_dev->send_recv = send_recv;
> -	if (check_opal_support(opal_dev) < 0)
> +	struct opal_dev *dev;
> +
> +	dev = kmalloc(sizeof(*dev), GFP_KERNEL);
> +	if (!dev)
> +		return NULL;
> +
> +	INIT_LIST_HEAD(&dev->unlk_lst);
> +	mutex_init(&dev->dev_lock);
> +	dev->data = data;
> +	dev->send_recv = send_recv;
> +	if (check_opal_support(dev) < 0) {
>  		pr_warn("Opal is not supported on this device\n");
> -	opal_dev->initialized = true;
> +		kfree(dev);
> +		return NULL;

We're going to have to change this check_opal_support to be != 0 instead of < 0.
I tested on a controller that does not have opal enabled and I get a kick back of:

[  112.296675] sed_opal:OPAL: Error on step function: 0 with error 1: Not Authorized
[  112.306242]  nvme1n1: p1 p2 p3

So we return the error 1 out of check_opal_support, and we'll never free the opal_dev.
There isnt any issues with potential crashes or other weird behavior
because we set dev->supported to be false, so if you try and call an ioctl on the
unsuported device you'll get a:

[  149.550024] sed_opal:OPAL: Not supported

but the memory is still there.

Also, since init_opal_dev gets called from reset_work any time we do that we'll
spam the user with that pr_warn, is there a pr_warn_once or something we can use
instead?

I looked at the rest of the pr_warns and there is one in discovery0_end that we'll
want to convert to a pr_warn_once as well:

     if (!single_user)
		pr_warn("Device doesn't support single user mode\n");

Since we use discovery0 to get a comid every command we run on a non SUM device
will have that spammed to their dmesg.


Other than the above it looks fine to me.
