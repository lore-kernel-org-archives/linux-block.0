Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B0DC7619A
	for <linux-block@archiver.kernel.org>; Wed,  5 Apr 2023 08:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236804AbjDEI2C (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Apr 2023 04:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbjDEI2B (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Apr 2023 04:28:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD2A2106
        for <linux-block@vger.kernel.org>; Wed,  5 Apr 2023 01:28:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9EBA9624BC
        for <linux-block@vger.kernel.org>; Wed,  5 Apr 2023 08:27:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B26DC433EF;
        Wed,  5 Apr 2023 08:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680683278;
        bh=9CJ1ZHaoNRvO4pjWBq+y3KW83y1pk2tvfiwJ1PtONOA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GmhGUei/q6/RX45F+f9Yev7N/X2umA0QMnaI7AfB4f/pbfJKJCchy6CPNIemz3lBG
         05TJyZauXzKLAAVx54neZ3HBIfquIDEzIsga0m50CoFhOVVyVhLYJBvrV9uBN7nkB+
         TiAbIaT/nWldS30/F89p3h9Xkhb6SS0Wo7VXYUqLN6EWurq05Yii2VdxhK7eV7iAuZ
         9PS6XbKUdTXgeUDpmzMTPg/32bKeVo+xY4XsXAV6ib4Uy6Vp8WwOgFo6tEJY4q/6zl
         sEBFS1K1W0Uaw3ahAAngUBm9CLHMrj/hrFhRPJgyOwHFdC/41/LxS7MTQHspA9aAql
         Amup11RZl+9Nw==
Date:   Wed, 5 Apr 2023 10:27:54 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Ondrej Kozina <okozina@redhat.com>
Cc:     linux-block@vger.kernel.org, bluca@debian.org, gmazyland@gmail.com,
        axboe@kernel.dk, hch@infradead.org, rafael.antognolli@intel.com
Subject: Re: [PATCH 5/5] sed-opal: Add command to read locking range
 parameters.
Message-ID: <20230405-komitee-treten-36f2c0a823b6@brauner>
References: <20230322151604.401680-1-okozina@redhat.com>
 <20230322151604.401680-6-okozina@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230322151604.401680-6-okozina@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 22, 2023 at 04:16:04PM +0100, Ondrej Kozina wrote:
> It returns following attributes:
> 
> locking range start
> locking range length
> read lock enabled
> write lock enabled
> lock state (RW, RO or LK)
> 
> It can be retrieved by user authority provided the authority
> was added to locking range via prior IOC_OPAL_ADD_USR_TO_LR
> ioctl command. The command was extended to add user in ACE that
> allows to read attributes listed above.
> 
> Signed-off-by: Ondrej Kozina <okozina@redhat.com>
> Tested-by: Luca Boccassi <bluca@debian.org>
> Tested-by: Milan Broz <gmazyland@gmail.com>
> ---
>  block/sed-opal.c              | 140 ++++++++++++++++++++++++++++++++++
>  include/linux/sed-opal.h      |   1 +
>  include/uapi/linux/sed-opal.h |  11 +++
>  3 files changed, 152 insertions(+)
> 
> diff --git a/block/sed-opal.c b/block/sed-opal.c
> index 27abed4d60ef..9af2c72faf0e 100644
> --- a/block/sed-opal.c
> +++ b/block/sed-opal.c
> @@ -1445,6 +1445,116 @@ static int setup_locking_range(struct opal_dev *dev, void *data)
>  	return finalize_and_send(dev, parse_and_check_status);
>  }
>  
> +static int response_get_column(const struct parsed_resp *resp, int *iter, u8 column, u64 *value)
> +{
> +	const struct opal_resp_tok *tok;
> +	int n = *iter;
> +	u64 val;
> +
> +	tok = response_get_token(resp, n);
> +	if (IS_ERR(tok))
> +		return PTR_ERR(tok);
> +
> +	if (!response_token_matches(tok, OPAL_STARTNAME)) {
> +		pr_debug("Unexpected response token type %d.\n", n);
> +		return OPAL_INVAL_PARAM;
> +	}
> +
> +	if (response_get_u64(resp, ++n) != column) {

Please don't rely on side-effects and increment explicitly before or
after the functin call so ++n and n++ doesn't matter.

> +		pr_debug("Token %d does not match expected column %u.\n", n, column);
> +		return OPAL_INVAL_PARAM;
> +	}
> +
> +	val = response_get_u64(resp, ++n);
> +
> +	tok = response_get_token(resp, ++n);
> +	if (IS_ERR(tok))
> +		return PTR_ERR(tok);
> +
> +	if (!response_token_matches(tok, OPAL_ENDNAME)) {
> +		pr_debug("Unexpected response token type %d.\n", n);
> +		return OPAL_INVAL_PARAM;
> +	}
> +
> +	*value = val;
> +	*iter = ++n;

This is how they explain side-effects in textbooks. :)

> +
> +	return 0;
> +}
> +
> +static int locking_range_status(struct opal_dev *dev, void *data)
> +{
> +	u8 lr_buffer[OPAL_UID_LENGTH];
> +	u64 resp;
> +	bool rlocked, wlocked;
> +	int err, tok_n = 2;
> +	struct opal_lr_status *lrst = data;
> +
> +	err = build_locking_range(lr_buffer, sizeof(lr_buffer),
> +				  lrst->session.opal_key.lr);
> +	if (err)
> +		return err;
> +
> +	err = generic_get_columns(dev, lr_buffer, OPAL_RANGESTART, OPAL_WRITELOCKED);
> +	if (err) {
> +		pr_debug("Couldn't get lr %u table columns %d to %d.\n",
> +			 lrst->session.opal_key.lr, OPAL_RANGESTART,
> +			 OPAL_WRITELOCKED);
> +		return err;
> +	}
> +
> +	/* range start */
> +	err = response_get_column(&dev->parsed, &tok_n, OPAL_RANGESTART, &lrst->range_start);
> +	if (err)
> +		return err;
> +
> +	/* range length */
> +	err = response_get_column(&dev->parsed, &tok_n, OPAL_RANGELENGTH, &lrst->range_length);
> +	if (err)
> +		return err;
> +
> +	/* RLE */
> +	err = response_get_column(&dev->parsed, &tok_n, OPAL_READLOCKENABLED, &resp);
> +	if (err)
> +		return err;
> +
> +	lrst->RLE = !!resp;
> +
> +	/* WLE */
> +	err = response_get_column(&dev->parsed, &tok_n, OPAL_WRITELOCKENABLED, &resp);
> +	if (err)
> +		return err;
> +
> +	lrst->WLE = !!resp;
> +
> +	/* read locked */
> +	err = response_get_column(&dev->parsed, &tok_n, OPAL_READLOCKED, &resp);
> +	if (err)
> +		return err;
> +
> +	rlocked = !!resp;
> +
> +	/* write locked */
> +	err = response_get_column(&dev->parsed, &tok_n, OPAL_WRITELOCKED, &resp);
> +	if (err)
> +		return err;
> +
> +	wlocked = !!resp;
> +
> +	/*opal_lock_state can not map 'read locked' only state. */
> +	lrst->l_state = OPAL_RW;
> +	if (rlocked && wlocked)
> +		lrst->l_state = OPAL_LK;
> +	else if (wlocked)
> +		lrst->l_state = OPAL_RO;
> +	else if (rlocked) {
> +		pr_debug("Can not report read locked only state.\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  static int start_generic_opal_session(struct opal_dev *dev,
>  				      enum opal_uid auth,
>  				      enum opal_uid sp_type,
> @@ -2617,6 +2727,33 @@ static int opal_setup_locking_range(struct opal_dev *dev,
>  	return ret;
>  }
>  
> +static int opal_locking_range_status(struct opal_dev *dev,
> +			  struct opal_lr_status *opal_lrst,
> +			  void __user *data)
> +{
> +	const struct opal_step lr_steps[] = {
> +		{ start_auth_opal_session, &opal_lrst->session },
> +		{ locking_range_status, opal_lrst },
> +		{ end_opal_session, }
> +	};
> +	int ret;
> +
> +	mutex_lock(&dev->dev_lock);
> +	setup_opal_dev(dev);
> +	ret = execute_steps(dev, lr_steps, ARRAY_SIZE(lr_steps));
> +	mutex_unlock(&dev->dev_lock);
> +
> +	/* skip session info when copying back to uspace */
> +	if (!ret && copy_to_user(data + offsetof(struct opal_lr_status, range_start),
> +				(void *)opal_lrst + offsetof(struct opal_lr_status, range_start),

Better written as

(void *)(opal_lrst + offsetof(struct opal_lr_status, range_start))

?

> +				sizeof(*opal_lrst) - offsetof(struct opal_lr_status, range_start))) {
> +		pr_debug("Error copying status to userspace\n");
> +		return -EFAULT;
> +	}
> +
> +	return ret;
> +}
> +
>  static int opal_set_new_pw(struct opal_dev *dev, struct opal_new_pw *opal_pw)
>  {
>  	const struct opal_step pw_steps[] = {
> @@ -2851,6 +2988,9 @@ int sed_ioctl(struct opal_dev *dev, unsigned int cmd, void __user *arg)
>  	case IOC_OPAL_GET_STATUS:
>  		ret = opal_get_status(dev, arg);
>  		break;
> +	case IOC_OPAL_GET_LR_STATUS:
> +		ret = opal_locking_range_status(dev, p, arg);
> +		break;
>  	default:
>  		break;
>  	}
> diff --git a/include/linux/sed-opal.h b/include/linux/sed-opal.h
> index 31ac562a17d7..042c1e2cb0ce 100644
> --- a/include/linux/sed-opal.h
> +++ b/include/linux/sed-opal.h
> @@ -45,6 +45,7 @@ static inline bool is_sed_ioctl(unsigned int cmd)
>  	case IOC_OPAL_WRITE_SHADOW_MBR:
>  	case IOC_OPAL_GENERIC_TABLE_RW:
>  	case IOC_OPAL_GET_STATUS:
> +	case IOC_OPAL_GET_LR_STATUS:
>  		return true;
>  	}
>  	return false;
> diff --git a/include/uapi/linux/sed-opal.h b/include/uapi/linux/sed-opal.h
> index d7a1524023db..3905c8ffedbf 100644
> --- a/include/uapi/linux/sed-opal.h
> +++ b/include/uapi/linux/sed-opal.h
> @@ -78,6 +78,16 @@ struct opal_user_lr_setup {
>  	struct opal_session_info session;
>  };
>  
> +struct opal_lr_status {
> +	struct opal_session_info session;
> +	__u64 range_start;
> +	__u64 range_length;
> +	__u32 RLE; /* Read Lock enabled */
> +	__u32 WLE; /* Write Lock Enabled */

Why is that in capital letters if I may ask? That seems strange uapi for
Linux. And why not just "read_lock_enabled" and "write_lock_enabled"
given that we also have "range_start" and "range_length". Let's not
CREAT one of those weird uapis if we don't have to.

> +	__u32 l_state;

"locking_state"?

> +	__u8  align[4];
> +};
> +
>  struct opal_lock_unlock {
>  	struct opal_session_info session;
>  	__u32 l_state;
> @@ -168,5 +178,6 @@ struct opal_status {
>  #define IOC_OPAL_WRITE_SHADOW_MBR   _IOW('p', 234, struct opal_shadow_mbr)
>  #define IOC_OPAL_GENERIC_TABLE_RW   _IOW('p', 235, struct opal_read_write_table)
>  #define IOC_OPAL_GET_STATUS         _IOR('p', 236, struct opal_status)
> +#define IOC_OPAL_GET_LR_STATUS      _IOW('p', 237, struct opal_lr_status)
>  
>  #endif /* _UAPI_SED_OPAL_H */
> -- 
> 2.31.1
> 
