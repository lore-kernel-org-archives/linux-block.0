Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:7044 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752111AbdBOV3a (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Feb 2017 16:29:30 -0500
Date: Wed, 15 Feb 2017 14:19:52 -0700
From: Scott Bauer <scott.bauer@intel.com>
To: Jon Derrick <jonathan.derrick@intel.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Rafael Antognolli <rafael.antognolli@intel.com>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCHv3 2/4] block/sed: Add helper to qualify response tokens
Message-ID: <20170215211952.GC2178@sbauer-Z170X-UD5>
References: <1487187731-10293-1-git-send-email-jonathan.derrick@intel.com>
 <1487187731-10293-3-git-send-email-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1487187731-10293-3-git-send-email-jonathan.derrick@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Feb 15, 2017 at 12:42:07PM -0700, Jon Derrick wrote:
> Add helper which verifies the response token is valid and matches the
> expected value. Merges token_type and response_get_token.
> 
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> ---
>  block/sed-opal.c | 61 +++++++++++++++++++++++---------------------------------
>  1 file changed, 25 insertions(+), 36 deletions(-)
> 
> diff --git a/block/sed-opal.c b/block/sed-opal.c
> index 77623ad..d6dd604 100644
> --- a/block/sed-opal.c
> +++ b/block/sed-opal.c
> @@ -591,48 +591,25 @@ static int cmd_finalize(struct opal_dev *cmd, u32 hsn, u32 tsn)
>  	return 0;
>  }
>  
> -static enum opal_response_token token_type(const struct parsed_resp *resp,
> -					   int n)
> +static const struct opal_resp_tok *response_get_token(
> +				const struct parsed_resp *resp,
> +				int n)
>  {
>  	const struct opal_resp_tok *tok;
>  
>  	if (n >= resp->num) {
>  		pr_err("Token number doesn't exist: %d, resp: %d\n",
>  		       n, resp->num);
> -		return OPAL_DTA_TOKENID_INVALID;
> +		return ERR_PTR(-EINVAL);
>  	}
>  
>  	tok = &resp->toks[n];
>  	if (tok->len == 0) {
>  		pr_err("Token length must be non-zero\n");
> -		return OPAL_DTA_TOKENID_INVALID;
> +		return ERR_PTR(-EINVAL);
>  	}
>  
> -	return tok->type;
> -}
> -
> -/*
> - * This function returns 0 in case of invalid token. One should call
> - * token_type() first to find out if the token is valid or not.
> - */
> -static enum opal_token response_get_token(const struct parsed_resp *resp,
> -					  int n)
> -{
> -	const struct opal_resp_tok *tok;
> -
> -	if (n >= resp->num) {
> -		pr_err("Token number doesn't exist: %d, resp: %d\n",
> -		       n, resp->num);
> -		return 0;
> -	}
> -
> -	tok = &resp->toks[n];
> -	if (tok->len == 0) {
> -		pr_err("Token length must be non-zero\n");
> -		return 0;
> -	}
> -
> -	return tok->pos[0];
> +	return tok;
>  }
>  
>  static ssize_t response_parse_tiny(struct opal_resp_tok *tok,
> @@ -851,20 +828,32 @@ static u64 response_get_u64(const struct parsed_resp *resp, int n)
>  	return resp->toks[n].stored.u;
>  }
>  
> +static bool response_token_matches(const struct opal_resp_tok *token, u8 match)
> +{
> +	if (IS_ERR_OR_NULL(token) ||
> +	    token->type != OPAL_DTA_TOKENID_TOKEN ||
> +	    token->pos[0] != match)
> +		return false;
> +	return true;
> +}
> +

This is sorta pedantic but from my reading of the code token can never be null. It will
either be a valid pointer or ERR_PTR(-EINVAL), but never null.
So maybe change this to IS_ERR(token) etc. Other than that little nit:

Reviewed-by: Scott Bauer <scott.bauer@intel.com>
