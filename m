Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga17.intel.com ([192.55.52.151]:45102 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751620AbeCMP0O (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Mar 2018 11:26:14 -0400
Date: Tue, 13 Mar 2018 09:01:02 -0600
From: Scott Bauer <scott.bauer@intel.com>
To: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Cc: Jonathan Derrick <jonathan.derrick@intel.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] block: sed-opal: unify cmd start and finalize
Message-ID: <20180313150102.g47bzsqyy2ueazqu@sbauer-Z170X-UD5>
References: <cover.1520946114.git.jonas.rabenstein@studium.uni-erlangen.de>
 <0d64b284cd6e78d61b1c8ef5a49ae13bd4b1dfee.1520946114.git.jonas.rabenstein@studium.uni-erlangen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0d64b284cd6e78d61b1c8ef5a49ae13bd4b1dfee.1520946114.git.jonas.rabenstein@studium.uni-erlangen.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Mar 13, 2018 at 02:08:56PM +0100, Jonas Rabenstein wrote:
> Every step starts with resetting the cmd buffer as well as the comid and
> constructs the appropriate OPAL_CALL command. Consequently, those
> actions may be combined into one generic function.
> 
> Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
> ---
>  block/sed-opal.c | 243 +++++++++++++++----------------------------------------
>  1 file changed, 63 insertions(+), 180 deletions(-)
> 
> diff --git a/block/sed-opal.c b/block/sed-opal.c
> index a228a13f0a08..22dbea7cf4d1 100644
> --- a/block/sed-opal.c
> +++ b/block/sed-opal.c
> @@ -659,6 +659,7 @@ static int cmd_finalize(struct opal_dev *cmd, u32 hsn, u32 tsn)
>  	struct opal_header *hdr;
>  	int err = 0;
>  
> +	add_token_u8(&err, cmd, OPAL_ENDLIST);
>  	add_token_u8(&err, cmd, OPAL_ENDOFDATA);
>  	add_token_u8(&err, cmd, OPAL_STARTLIST);
>  	add_token_u8(&err, cmd, 0);
> @@ -1001,6 +1002,21 @@ static void clear_opal_cmd(struct opal_dev *dev)
>  	memset(dev->cmd, 0, IO_BUFFER_LENGTH);
>  }
>  
> +static int start_opal_cmd(struct opal_dev *dev, const u8 *uid, const u8 *method)
> +{
> +	int err = 0;
> +
> +	clear_opal_cmd(dev);
> +	set_comid(dev, dev->comid);
> +
> +	add_token_u8(&err, dev, OPAL_CALL);
> +	add_token_bytestring(&err, dev, uid, OPAL_UID_LENGTH);
> +	add_token_bytestring(&err, dev, method, OPAL_METHOD_LENGTH);
> +	add_token_u8(&err, dev, OPAL_STARTLIST);

Can you resend this patch (in a bit I'm revewing the rest) with a comment here and
in cmd_finalize explaining that the start_list here gets terminiated by the new
opal_endlist in cmd_finalize.

I'm not a huge fan of having the start/list and end/list in separate functions
since those are used to specify a parameter list for a opal method. I can get over it
since it cleans the code up, as long as there are comments on both sides reminding me
what they're opening/closing off.
