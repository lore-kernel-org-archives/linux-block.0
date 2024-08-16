Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B30E1BC07B
	for <linux-block@vger.kernel.org>; Fri, 16 Aug 2024 15:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723822833; cv=none; b=PckS5dTU+VS9HhSReypUSxrzy4JaiaMJ8TK7aX3q9r6KHcT5fvwFZDhUH9BoAWdRQsnYbrQfWiNTCG853dk6IeNcm4bB63TD5ZutGPK8xX0g6KNA7mvjud6VyJw0CoW6iyoEzZ96f9P5UzlZUWD7DPFlRjoedYN/Odb1laB0Gas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723822833; c=relaxed/simple;
	bh=Pv51NYQyPUSUekI/+tGGPsoWSBeD+0eqobfKfHoCZWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uaX1cx+G/cui5mdmkVny/P4DaWlpBrMWJ27dz9+Cc+vCIRZa9PGF5RhaB4dtEqXXFk4gBjtLUU78jrtBBOq7jrqvXVoy05FzUq4IHX12LD+VHerT9mGfTjW78+eepoAraJFikYGXgv4rakDtX1cEoI9N+zda2zPstwQcCXBCsls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Gk3DERdj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vEx/8Wv+; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SxCMdmS/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=c2+37phR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Gk3DERdj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vEx/8Wv+";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SxCMdmS/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="c2+37phR"
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EEFA02233D;
	Fri, 16 Aug 2024 15:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723822823; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TN66nSjFqouqkY1td0mKRskBlur/qTl4di2OrY3AgiA=;
	b=Gk3DERdjGyYIEGxbCdeQGe6CYAZRF9VBrLM6tygPg9zF6VbAs3/bGMuVzj5le03UxdKVBv
	WLiNc9Q7IBMh16LcNArHC0MLoOxqdwkfBb81Ory46+tEZnAiAqLvJiMBrdUJDrT9bMbMLI
	pAY0QRPraRTs6Hf9E9gzGqrkDH34jmw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723822823;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TN66nSjFqouqkY1td0mKRskBlur/qTl4di2OrY3AgiA=;
	b=vEx/8Wv+xu4X7f/Z/Da06mnX/PeqxoyWfNqCXmnLMibNd8XnDpJ8plb8hbEnI+zW+gX6/y
	5Auue+YkS/cfwqCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723822822; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TN66nSjFqouqkY1td0mKRskBlur/qTl4di2OrY3AgiA=;
	b=SxCMdmS/amsJEEs9BKAXCfyBsG+CYhL4J5ACkFWb6NTIIxBW8FYqXjWsGy5o0Jbt0gzl8S
	mB8MVf12Qd26X11YK6PhtTJd+JX0W8n20AcYfhYvcaaFb/3BkDOl26YpmTZquDEZD/NCjR
	KXDobOy2wZAvtLKDIVNVGPhJC00tyR8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723822822;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TN66nSjFqouqkY1td0mKRskBlur/qTl4di2OrY3AgiA=;
	b=c2+37phRnmSis3kYroWGzTZlxtvdW+V0zXhcgaZLGEK2NxtfrQ37zHGdoFHwqFc/whLYDJ
	j8w73jcjcvVPrMCQ==
Date: Fri, 16 Aug 2024 17:40:21 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: gjoyce@linux.ibm.com
Cc: linux-block@vger.kernel.org, axboe@kernel.dk,
	jonathan.derrick@linux.dev
Subject: Re: [PATCH 1/1] block: sed-opal: add ioctl IOC_OPAL_SET_SID_PW
Message-ID: <20240816154021.GX26466@kitsune.suse.cz>
References: <20240816153557.11734-1-gjoyce@linux.ibm.com>
 <20240816153557.11734-2-gjoyce@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816153557.11734-2-gjoyce@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.992];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	ARC_NA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+]
X-Spam-Score: -4.30

Hello,

is there a corresponding change to an userspace tool to make use of
this?

Thanks

Michal

On Fri, Aug 16, 2024 at 10:35:57AM -0500, gjoyce@linux.ibm.com wrote:
> From: Greg Joyce <gjoyce@linux.ibm.com>
> 
> After a SED drive is provisioned, there is no way to change the SID
> password via the ioctl() interface. A new ioctl IOC_OPAL_SET_SID_PW
> will allow the password to be changed. The valid current password is
> required.
> 
> Signed-off-by: Greg Joyce <gjoyce@linux.ibm.com>
> ---
>  block/sed-opal.c              | 26 ++++++++++++++++++++++++++
>  include/linux/sed-opal.h      |  1 +
>  include/uapi/linux/sed-opal.h |  1 +
>  3 files changed, 28 insertions(+)
> 
> diff --git a/block/sed-opal.c b/block/sed-opal.c
> index 598fd3e7fcc8..5a28f23f7f22 100644
> --- a/block/sed-opal.c
> +++ b/block/sed-opal.c
> @@ -3037,6 +3037,29 @@ static int opal_set_new_pw(struct opal_dev *dev, struct opal_new_pw *opal_pw)
>  	return ret;
>  }
>  
> +static int opal_set_new_sid_pw(struct opal_dev *dev, struct opal_new_pw *opal_pw)
> +{
> +	int ret;
> +	struct opal_key *newkey = &opal_pw->new_user_pw.opal_key;
> +	struct opal_key *oldkey = &opal_pw->session.opal_key;
> +
> +	const struct opal_step pw_steps[] = {
> +		{ start_SIDASP_opal_session, oldkey },
> +		{ set_sid_cpin_pin, newkey },
> +		{ end_opal_session, }
> +	};
> +
> +	if (!dev)
> +		return -ENODEV;
> +
> +	mutex_lock(&dev->dev_lock);
> +	setup_opal_dev(dev);
> +	ret = execute_steps(dev, pw_steps, ARRAY_SIZE(pw_steps));
> +	mutex_unlock(&dev->dev_lock);
> +
> +	return ret;
> +}
> +
>  static int opal_activate_user(struct opal_dev *dev,
>  			      struct opal_session_info *opal_session)
>  {
> @@ -3286,6 +3309,9 @@ int sed_ioctl(struct opal_dev *dev, unsigned int cmd, void __user *arg)
>  	case IOC_OPAL_DISCOVERY:
>  		ret = opal_get_discv(dev, p);
>  		break;
> +	case IOC_OPAL_SET_SID_PW:
> +		ret = opal_set_new_sid_pw(dev, p);
> +		break;
>  
>  	default:
>  		break;
> diff --git a/include/linux/sed-opal.h b/include/linux/sed-opal.h
> index 2ac50822554e..80f33a93f944 100644
> --- a/include/linux/sed-opal.h
> +++ b/include/linux/sed-opal.h
> @@ -52,6 +52,7 @@ static inline bool is_sed_ioctl(unsigned int cmd)
>  	case IOC_OPAL_GET_GEOMETRY:
>  	case IOC_OPAL_DISCOVERY:
>  	case IOC_OPAL_REVERT_LSP:
> +	case IOC_OPAL_SET_SID_PW:
>  		return true;
>  	}
>  	return false;
> diff --git a/include/uapi/linux/sed-opal.h b/include/uapi/linux/sed-opal.h
> index d3994b7716bc..9025dd5a4f0f 100644
> --- a/include/uapi/linux/sed-opal.h
> +++ b/include/uapi/linux/sed-opal.h
> @@ -215,5 +215,6 @@ struct opal_revert_lsp {
>  #define IOC_OPAL_GET_GEOMETRY       _IOR('p', 238, struct opal_geometry)
>  #define IOC_OPAL_DISCOVERY          _IOW('p', 239, struct opal_discovery)
>  #define IOC_OPAL_REVERT_LSP         _IOW('p', 240, struct opal_revert_lsp)
> +#define IOC_OPAL_SET_SID_PW         _IOW('p', 241, struct opal_new_pw)
>  
>  #endif /* _UAPI_SED_OPAL_H */
> -- 
> gjoyce@linux.ibm.com
> 
