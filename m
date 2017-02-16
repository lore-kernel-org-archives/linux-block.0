Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:9776 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751305AbdBPCLJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Feb 2017 21:11:09 -0500
Date: Wed, 15 Feb 2017 19:01:30 -0700
From: Scott Bauer <scott.bauer@intel.com>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-block@vger.kernel.org,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Jens Axboe <axboe@fb.com>
Subject: Re: [PATCH] opal: Use empty structure when not defined
Message-ID: <20170216020130.GA11596@sbauer-Z170X-UD5>
References: <1487204187-4004-1-git-send-email-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1487204187-4004-1-git-send-email-keith.busch@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Feb 15, 2017 at 07:16:27PM -0500, Keith Busch wrote:
> No need to use space if it can't be used. This reduces the size of struct
> nvme_ctrl by a little over 4k when CONFIG_BLK_SED_OPAL is not set.
> 
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
>  include/linux/sed-opal.h | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/sed-opal.h b/include/linux/sed-opal.h
> index 205d520..ed19902 100644
> --- a/include/linux/sed-opal.h
> +++ b/include/linux/sed-opal.h
> @@ -91,6 +91,7 @@ struct parsed_resp {
>  	struct opal_resp_tok toks[MAX_TOKS];
>  };
>  
> +#ifdef CONFIG_BLK_SED_OPAL
>  /**
>   * struct opal_dev - The structure representing a OPAL enabled SED.
>   * @supported: Whether or not OPAL is supported on this controller.
> @@ -129,7 +130,6 @@ struct opal_dev {
>  	struct list_head unlk_lst;
>  };
>  
> -#ifdef CONFIG_BLK_SED_OPAL
>  bool opal_unlock_from_suspend(struct opal_dev *dev);
>  void init_opal_dev(struct opal_dev *opal_dev, sec_send_recv *send_recv);
>  int sed_ioctl(struct opal_dev *dev, unsigned int cmd, void __user *ioctl_ptr);
> @@ -154,6 +154,9 @@ static inline bool is_sed_ioctl(unsigned int cmd)
>  	return false;
>  }
>  #else
> +struct opal_dev {
> +};
> +
>  static inline bool is_sed_ioctl(unsigned int cmd)
>  {
>  	return false;
> @@ -171,8 +174,6 @@ static inline bool opal_unlock_from_suspend(struct opal_dev *dev)
>  static inline void init_opal_dev(struct opal_dev *opal_dev,
>  				 sec_send_recv *send_recv)
>  {
> -	opal_dev->supported = false;
> -	opal_dev->initialized = true;
>  }
>  #endif /* CONFIG_BLK_SED_OPAL */
>  #endif /* LINUX_OPAL_H */
> -- 
> 2.5.5
> 

Looks good, thank you.
Reviewed-by: Scott Bauer <scott.bauer@intel.com>
