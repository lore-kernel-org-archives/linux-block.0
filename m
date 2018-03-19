Return-Path: <hch@lst.de>
Date: Mon, 19 Mar 2018 20:57:00 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Cc: Scott Bauer <scott.bauer@intel.com>,
	Jonathan Derrick <jonathan.derrick@intel.com>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 03/11] block: sed-opal: unify cmd start and finalize
Message-ID: <20180319195700.GE3380@lst.de>
References: <cover.1520946114.git.jonas.rabenstein@studium.uni-erlangen.de> <cover.1521482295.git.jonas.rabenstein@studium.uni-erlangen.de> <801b85d1a40e87f95b73be00d7343621808d2e85.1521482295.git.jonas.rabenstein@studium.uni-erlangen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <801b85d1a40e87f95b73be00d7343621808d2e85.1521482295.git.jonas.rabenstein@studium.uni-erlangen.de>
List-ID: <linux-block@vger.kernel.org>

On Mon, Mar 19, 2018 at 07:36:45PM +0100, Jonas Rabenstein wrote:
> Every step starts with resetting the cmd buffer as well as the comid and
> constructs the appropriate OPAL_CALL command. Consequently, those
> actions may be combined into one generic function. On should take care,
> that the opening and closing tokens for the argument list are already
> emitted by those functions and thus must not be additionally added.
> 
> Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
> 
> diff --git a/block/sed-opal.c b/block/sed-opal.c
> index 771b4cfff95c..efe5d2a7f3dc 100644
> --- a/block/sed-opal.c
> +++ b/block/sed-opal.c
> @@ -656,6 +656,9 @@ static int cmd_finalize(struct opal_dev *cmd, u32 hsn, u32 tsn)
>  	struct opal_header *hdr;
>  	int err = 0;
>  
> +	/* close the parameter list opened from start_opal_cmd */
> +	add_token_u8(&err, cmd, OPAL_ENDLIST);
> +
>  	add_token_u8(&err, cmd, OPAL_ENDOFDATA);
>  	add_token_u8(&err, cmd, OPAL_STARTLIST);
>  	add_token_u8(&err, cmd, 0);

I think this should be a separate patch, independent of the newly added
start_opal_cmd.


> @@ -998,6 +1001,26 @@ static void clear_opal_cmd(struct opal_dev *dev)
>  	memset(dev->cmd, 0, IO_BUFFER_LENGTH);
>  }
>  
> +static int start_opal_cmd(struct opal_dev *dev, const u8 *uid, const u8 *method)
> +{
> +	int err = 0;

start_opal_cmd and cmd_finalize don't really seem to match in terms
of naming.  I don't really care either way, but a little consistency
would be nice.

> +	/* every method call is followed by its parameters enclosed within
> +	 * OPAL_STARTLIST and OPAL_ENDLIST tokens. We automatically open the
> +	 * parameter list here and close it later in cmd_finalize
> +	 */

Normal Linux comment style would be:

	/*
	 * Every method call is followed by its parameters enclosed within
	 * OPAL_STARTLIST and OPAL_ENDLIST tokens. We automatically open the
	 * parameter list here and close it later in cmd_finalize.
	 */
