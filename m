Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DA9284B36
	for <linux-block@vger.kernel.org>; Mon,  2 Feb 2026 23:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770074247; cv=none; b=bvfTjzNxcJUdgIZuygyxRoh9N/Gll+DDjCFQWCNY2fl5ls3+dxn7S/y84rvvp6LHzTUy5/HFa5vlzg1vNRpJ/4Qo8xJjzO9dZ3kC5fnbkrfobwQZX8x4yK4UhJoXvZWaoYLHLMOEhXs8NHloaAi7UuMB+b7u7HjE5aZDgfgbRA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770074247; c=relaxed/simple;
	bh=SmSeQv6kpds0oA3wO3pH6E1dfHZ6vnUZyDEcXUr03rU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t6cPRkev86mPDCyCctuNp61BxZdwvOB1BxmhufTgn3N4fBfm0+6v8YU83WYPnfULhHUm5TfZ6BZAQF2UWUSGtagqDBxTTcN7aiqBojJHGNpwjqIFrsDfDyYeHeSqypPMf8QWZPI3DCmV5He/Za5CoIOTruob2dvf8nalF311Bk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0h/Ti0tv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Zmenf6Co; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0h/Ti0tv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Zmenf6Co; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0h/Ti0tv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Zmenf6Co";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0h/Ti0tv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Zmenf6Co"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A97933E6CA;
	Mon,  2 Feb 2026 23:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770074237; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rf0TU87XIe3S7DdPOVfENER2rHonCjH/lTkhYqpm5KY=;
	b=0h/Ti0tvY17d+SgrN4XPAH1QymTqOfRiEtL3F5KnH6HRCeKuUVEvWGeD7KoKwYZpTcl4HW
	GOa6MU9qiR4acoqEthAsq9gtkDPG79reWKAJl1hUp9XLOhweT5Y4olOZRpX58VKFIZMdJ8
	Fe79Rkp55+VOqyPglo28QHUHcmTmQPE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770074237;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rf0TU87XIe3S7DdPOVfENER2rHonCjH/lTkhYqpm5KY=;
	b=Zmenf6CobeD6TZQU3TIIzph5nFZRkWifC8p/2BmuXKRYu6VA0DYv6VSvw9nTrNSthIkgXS
	W8UcQwJga8tbLDBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="0h/Ti0tv";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Zmenf6Co
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770074237; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rf0TU87XIe3S7DdPOVfENER2rHonCjH/lTkhYqpm5KY=;
	b=0h/Ti0tvY17d+SgrN4XPAH1QymTqOfRiEtL3F5KnH6HRCeKuUVEvWGeD7KoKwYZpTcl4HW
	GOa6MU9qiR4acoqEthAsq9gtkDPG79reWKAJl1hUp9XLOhweT5Y4olOZRpX58VKFIZMdJ8
	Fe79Rkp55+VOqyPglo28QHUHcmTmQPE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770074237;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rf0TU87XIe3S7DdPOVfENER2rHonCjH/lTkhYqpm5KY=;
	b=Zmenf6CobeD6TZQU3TIIzph5nFZRkWifC8p/2BmuXKRYu6VA0DYv6VSvw9nTrNSthIkgXS
	W8UcQwJga8tbLDBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0D74E3EA62;
	Mon,  2 Feb 2026 23:17:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cgoGL3swgWnJJwAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 02 Feb 2026 23:17:15 +0000
Message-ID: <1fc11dc6-f047-4960-8c79-b78870f489bc@suse.de>
Date: Tue, 3 Feb 2026 00:17:13 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] sed-opal: add IOC_OPAL_REACTIVATE_LSP.
To: Ondrej Kozina <okozina@redhat.com>, linux-block@vger.kernel.org
Cc: gmazyland@gmail.com, gjoyce@ibm.com, jonathan.derrick@linux.dev
References: <20260130162527.570255-1-okozina@redhat.com>
 <20260130162527.570255-2-okozina@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260130162527.570255-2-okozina@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,ibm.com,linux.dev];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Rspamd-Queue-Id: A97933E6CA
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 

On 1/30/26 17:25, Ondrej Kozina wrote:
> This adds the 'Reactivate' method as described in the
> "TCG Storage Opal SSC Feature Set: Single User Mode"
> document (ch. 3.1.1.1).
> 
... only you don't. You also add the definition for 'LOCKING TABLE'.
Please mention that in the description.

> The method enables switching an already active SED OPAL2 device,
> with appropriate firmware support for Single User Mode (SUM),
> to or from SUM.
> 
> Signed-off-by: Ondrej Kozina <okozina@redhat.com>
> ---
>   block/opal_proto.h            |  4 ++
>   block/sed-opal.c              | 91 +++++++++++++++++++++++++++++++++++
>   include/linux/sed-opal.h      |  1 +
>   include/uapi/linux/sed-opal.h | 14 ++++++
>   4 files changed, 110 insertions(+)
> 
> diff --git a/block/opal_proto.h b/block/opal_proto.h
> index d247a457bf6e..d138785b8198 100644
> --- a/block/opal_proto.h
> +++ b/block/opal_proto.h
> @@ -125,6 +125,7 @@ enum opal_uid {
>   	OPAL_LOCKING_INFO_TABLE,
>   	OPAL_ENTERPRISE_LOCKING_INFO_TABLE,
>   	OPAL_DATASTORE,
> +	OPAL_LOCKING_TABLE,
>   	/* C_PIN_TABLE object ID's */
>   	OPAL_C_PIN_MSID,
>   	OPAL_C_PIN_SID,
> @@ -154,6 +155,7 @@ enum opal_method {
>   	OPAL_AUTHENTICATE,
>   	OPAL_RANDOM,
>   	OPAL_ERASE,
> +	OPAL_REACTIVATE,
>   };
>   
>   enum opal_token {
> @@ -224,6 +226,8 @@ enum opal_lockingstate {
>   
>   enum opal_parameter {
>   	OPAL_SUM_SET_LIST = 0x060000,
> +	OPAL_SUM_RANGE_POLICY = 0x060001,
> +	OPAL_SUM_ADMIN1_PIN = 0x060002,
>   };
>   
>   enum opal_revertlsp {
> diff --git a/block/sed-opal.c b/block/sed-opal.c
> index a26a94642d84..552aa2b48a7b 100644
> --- a/block/sed-opal.c
> +++ b/block/sed-opal.c
> @@ -162,6 +162,8 @@ static const u8 opaluid[][OPAL_UID_LENGTH] = {
>   		{ 0x00, 0x00, 0x08, 0x01, 0x00, 0x00, 0x00, 0x00 },
>   	[OPAL_DATASTORE] =
>   		{ 0x00, 0x00, 0x10, 0x01, 0x00, 0x00, 0x00, 0x00 },
> +	[OPAL_LOCKING_TABLE] =
> +		{ 0x00, 0x00, 0x08, 0x02, 0x00, 0x00, 0x00, 0x00 },
>   
>   	/* C_PIN_TABLE object ID's */
>   	[OPAL_C_PIN_MSID] =
> @@ -220,6 +222,8 @@ static const u8 opalmethod[][OPAL_METHOD_LENGTH] = {
>   		{ 0x00, 0x00, 0x00, 0x06, 0x00, 0x00, 0x06, 0x01 },
>   	[OPAL_ERASE] =
>   		{ 0x00, 0x00, 0x00, 0x06, 0x00, 0x00, 0x08, 0x03 },
> +	[OPAL_REACTIVATE] =
> +		{ 0x00, 0x00, 0x00, 0x06, 0x00, 0x00, 0x08, 0x01 },
>   };
>   
Maybe split the above in a separate patch.

>   static int end_opal_session_error(struct opal_dev *dev);
> @@ -2287,6 +2291,64 @@ static int activate_lsp(struct opal_dev *dev, void *data)
>   	return finalize_and_send(dev, parse_and_check_status);
>   }
>   
> +static int reactivate_lsp(struct opal_dev *dev, void *data)
> +{
> +	struct opal_lr_react *opal_react = data;
> +	u8 user_lr[OPAL_UID_LENGTH];
> +	int err, i;
> +
> +	err = cmd_start(dev, opaluid[OPAL_THISSP_UID],
> +			opalmethod[OPAL_REACTIVATE]);
> +
> +	if (err) {
> +		pr_debug("Error building Reactivate LockingSP command.\n");
> +		return err;
> +	}
> +
> +	if (opal_react->entire_table) {
> +		add_token_u8(&err, dev, OPAL_STARTNAME);
> +		add_token_u64(&err, dev, OPAL_SUM_SET_LIST);
> +		add_token_bytestring(&err, dev, opaluid[OPAL_LOCKING_TABLE], OPAL_UID_LENGTH);
> +		add_token_u8(&err, dev, OPAL_ENDNAME);
> +	} else if (opal_react->num_lrs) {
> +		err = build_locking_range(user_lr, sizeof(user_lr),
> +					  opal_react->lr[0]);
> +		if (err)
> +			return err;
> +
> +		add_token_u8(&err, dev, OPAL_STARTNAME);
> +		add_token_u64(&err, dev, OPAL_SUM_SET_LIST);
> +
> +		add_token_u8(&err, dev, OPAL_STARTLIST);
> +		add_token_bytestring(&err, dev, user_lr, OPAL_UID_LENGTH);
> +		for (i = 1; i < opal_react->num_lrs; i++) {
> +			user_lr[7] = opal_react->lr[i];
> +			add_token_bytestring(&err, dev, user_lr, OPAL_UID_LENGTH);
> +		}
> +		add_token_u8(&err, dev, OPAL_ENDLIST);
> +
> +		add_token_u8(&err, dev, OPAL_ENDNAME);
> +	}
> +
> +	/* Skipping the rangle policy parameter is same as setting its value to zero */
> +	if (opal_react->range_policy && (opal_react->num_lrs || opal_react->entire_table)) {
> +		add_token_u8(&err, dev, OPAL_STARTNAME);
> +		add_token_u64(&err, dev, OPAL_SUM_RANGE_POLICY);
> +		add_token_u8(&err, dev, 1);
> +		add_token_u8(&err, dev, OPAL_ENDNAME);
> +	}
> +
> +	if (opal_react->new_admin_key.key_len) {
> +		add_token_u8(&err, dev, OPAL_STARTNAME);
> +		add_token_u64(&err, dev, OPAL_SUM_ADMIN1_PIN);
> +		add_token_bytestring(&err, dev, opal_react->new_admin_key.key,
> +				     opal_react->new_admin_key.key_len);
> +		add_token_u8(&err, dev, OPAL_ENDNAME);
> +	}
> +
> +	return finalize_and_send(dev, parse_and_check_status);
> +}
> +
>   /* Determine if we're in the Manufactured Inactive or Active state */
>   static int get_lsp_lifecycle(struct opal_dev *dev, void *data)
>   {
> @@ -2957,6 +3019,32 @@ static int opal_activate_lsp(struct opal_dev *dev,
>   	return ret;
>   }
>   
> +static int opal_reactivate_lsp(struct opal_dev *dev,
> +			       struct opal_lr_react *opal_lr_react)
> +{
> +	const struct opal_step active_steps[] = {
> +		{ start_admin1LSP_opal_session, &opal_lr_react->key },
> +		{ reactivate_lsp, opal_lr_react },
> +		/* No end_opal_session. The controller terminates the session */
> +	};
> +	int ret;
> +
> +	/* use either 'entire_table' parameter or set of locking ranges */
> +	if (opal_lr_react->num_lrs > OPAL_MAX_LRS ||
> +	    (opal_lr_react->num_lrs && opal_lr_react->entire_table))
> +		return -EINVAL;
> +
> +	ret = opal_get_key(dev, &opal_lr_react->key);
> +	if (ret)
> +		return ret;
> +	mutex_lock(&dev->dev_lock);
> +	setup_opal_dev(dev);
> +	ret = execute_steps(dev, active_steps, ARRAY_SIZE(active_steps));
> +	mutex_unlock(&dev->dev_lock);
> +
> +	return ret;
> +}
> +
>   static int opal_setup_locking_range(struct opal_dev *dev,
>   				    struct opal_user_lr_setup *opal_lrs)
>   {
> @@ -3315,6 +3403,9 @@ int sed_ioctl(struct opal_dev *dev, unsigned int cmd, void __user *arg)
>   	case IOC_OPAL_SET_SID_PW:
>   		ret = opal_set_new_sid_pw(dev, p);
>   		break;
> +	case IOC_OPAL_REACTIVATE_LSP:
> +		ret = opal_reactivate_lsp(dev, p);
> +		break;
>   
>   	default:
>   		break;
> diff --git a/include/linux/sed-opal.h b/include/linux/sed-opal.h
> index 80f33a93f944..2ae5e6b0ac21 100644
> --- a/include/linux/sed-opal.h
> +++ b/include/linux/sed-opal.h
> @@ -53,6 +53,7 @@ static inline bool is_sed_ioctl(unsigned int cmd)
>   	case IOC_OPAL_DISCOVERY:
>   	case IOC_OPAL_REVERT_LSP:
>   	case IOC_OPAL_SET_SID_PW:
> +	case IOC_OPAL_REACTIVATE_LSP:
>   		return true;
>   	}
>   	return false;
> diff --git a/include/uapi/linux/sed-opal.h b/include/uapi/linux/sed-opal.h
> index 9025dd5a4f0f..ef3ddb93b3e3 100644
> --- a/include/uapi/linux/sed-opal.h
> +++ b/include/uapi/linux/sed-opal.h
> @@ -74,6 +74,19 @@ struct opal_lr_act {
>   	__u8 align[2]; /* Align to 8 byte boundary */
>   };
>   
> +struct opal_lr_react {
> +	struct opal_key key;
> +	struct opal_key new_admin_key; /* Set new Admin1 PIN if key_len is > 0 */
> +	__u8 num_lrs; /*
> +		       * Configure selected ranges (from lr[]) in SUM.
> +		       * If num_lrs > 0 the 'entire_table' must be 0
> +		       */
> +	__u8 lr[OPAL_MAX_LRS];
> +	__u8 range_policy; /* Set RangePolicy parameter */
> +	__u8 entire_table; /* Set all locking objects in SUM */
> +	__u8 align[4]; /* Align to 8 byte boundary */
> +};
> +
>   struct opal_session_info {
>   	__u32 sum;
>   	__u32 who;
> @@ -216,5 +229,6 @@ struct opal_revert_lsp {
>   #define IOC_OPAL_DISCOVERY          _IOW('p', 239, struct opal_discovery)
>   #define IOC_OPAL_REVERT_LSP         _IOW('p', 240, struct opal_revert_lsp)
>   #define IOC_OPAL_SET_SID_PW         _IOW('p', 241, struct opal_new_pw)
> +#define IOC_OPAL_REACTIVATE_LSP     _IOW('p', 242, struct opal_lr_react)
>   
>   #endif /* _UAPI_SED_OPAL_H */

Otherwise looks good.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
