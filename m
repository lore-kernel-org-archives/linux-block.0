Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319F13E0C5C
	for <linux-block@vger.kernel.org>; Tue, 31 Mar 2026 11:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774958387; cv=none; b=rPXEJ8D/ELqUJnm2/rxQrvuu6OfF4TXFLHE2O1BeyZ+q4CZby/rpb8EGVxwLCvQcoz6HAshsOVSiCr03dheVgVfrcpJ6p6oUeK8++pJJKFLt7oMi6jadEu/Zcb+ork08puWKP+/C1Je9bHxZySSeTyuoXhcVWfD8Q/vdfqLbAcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774958387; c=relaxed/simple;
	bh=bi38GMuqzgBON9twc35jmUv3PH/BFRAmpBGXsoZM8u0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gxvyO5L5lEApzYqlixD7kHuKipI+mPuFyflLc1WIo9vAl6Lz54hSA8sCB/edy/QMokQ+NIpeHgkvqmeLCZmZy0Y71mvTVJkIoAPgFCtms52qg+SKjlCM1n9xdtyCc6DkCUoA2rJ8lM1l+fN6eWEwrMHZnfTmbx8kCAr3uFa5F/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mxaAp8yg; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxaAp8yg"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-486fe2024a9so41083915e9.0
        for <linux-block@vger.kernel.org>; Tue, 31 Mar 2026 04:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774958384; x=1775563184; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eweyP1X0SuZpcDiOQGC7FK3ooyAtIodu+RXiCWpoeOQ=;
        b=mxaAp8yg4/u3P0Qkeo4vuP7c4Bf9nLrWakoVivQ9AyB+YcLA3afKJR5mHwVvewG9/E
         3qTBy/fBbLbY+VphbPNS+aswGGlPdNbbLez7wy+U0OL8CoDSaemYckObASGV3+wwOYhP
         KVtYp37thbcKPmSPTnd1Tf313Ugmdu/tcXGKjzKA4RUL3du3NdzSc/mltAg3y+Gima/P
         0uz3hUDYi/qcIlDufTIWYexz1GK72oh/vKI3+iEEdxSO7TlaVI0tcWIM48SiOrmfSumP
         qSQmYnlSGRfy8FPUGnM2CMf2kaX7EqCbrTh+eXBRb1Ejx87ES7Wa/elriBbLs18DlVJU
         itmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774958384; x=1775563184;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eweyP1X0SuZpcDiOQGC7FK3ooyAtIodu+RXiCWpoeOQ=;
        b=fB/4CozyYTdxN4lD+gWtEbVdaMZR4OZj+sW+kZKfgMZd3GfX5mkGOrwa1cLoBdgyXU
         yuEo+tg12+IM7hqZCW5TDupD084LwMHBIdtw9rguZkUIjtWoGLNhIw3E46wgxR3yOpEO
         zSkxdapbr0YwFNL3Uumm6G6I45CMY01WmW15YFPhS34+0W8vG0+Icw7CU71YET9bAG8Q
         KERAxgBnQ+9qLiQLTM/EHAOL7uBquRw9UqtpGyFXTr2eJ9VIbanC5/ZUQg2JjYZtsViT
         VdT09mkj1Kv6NEx//Omt+HbipR3Q/+Jy7LQWb/p9KZ+bEtIiyJBr9qdDSm8105bjB4kF
         3HhA==
X-Forwarded-Encrypted: i=1; AJvYcCXfv0NnZ0cpmaZqTnb5GqmDFCbJ/6dcxHyYJRlVHVkT1xdM3CoidrfnWwrc92a/AfAazn9Z36oYEzw2cA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyX9LpeO0rB9RE8FX1dpN5zQOO+kb7aE+L6DjcoSec0x0+0/Spg
	wkxXmGfmzwA3kiYfnRqlxeeX5uk+0C2CNIIGpL0akGKcfnifhAWCCCEp
X-Gm-Gg: ATEYQzyWiqwiFRP+3i64VyXKapimCtjnEas944GUd9ka4GTW2kl0gQNg840qadhAgjO
	BbdOC2LpOeag0/lGnf+ooHxfCA7/SCv7VEja+1D9HSqAR9If5B8j5Smh+AgLGhKVzqbY25PxVUj
	48ott71PVzFF8jOsiduNFq8eGLLhRbJSba2FgYd3dL3PS7g6w55hRfqLofKuer4uw8r5f34PdJ9
	wjXI+vBfVaPEwfQlLfBhiN/dGrzxHiNxEaXaEASBKVB3W19LI2FM7Q+oPQz/ijGEf9oKpIcNcBE
	txahh1SqJCvk2oJnvdpquWs/rkVownCbgt0+ln3sboKrt/BWSdOMJthpGUftBI1CT4/pLlHtJCq
	VqbQl/vpRG7F7XgmWHhD0cHx48lQMnrSFdw35NxUphLSt+nzAWltg0q/Gui8nKIThujfd2z72HR
	rAD7CwVPxpnUEBqZxg69R8huyCXnJO
X-Received: by 2002:a05:600c:c178:b0:487:12c:e7e1 with SMTP id 5b1f17b1804b1-48727ef0c19mr275940995e9.11.1774958384225;
        Tue, 31 Mar 2026 04:59:44 -0700 (PDT)
Received: from [192.168.1.116] ([176.74.141.242])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e83682fsm33553155e9.7.2026.03.31.04.59.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 04:59:43 -0700 (PDT)
Message-ID: <4015ed25-9871-48bf-8236-58a972484c1f@gmail.com>
Date: Tue, 31 Mar 2026 13:59:42 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sed-opal: Add STACK_RESET command
To: axboe@kernel.dk
Cc: jonathan.derrick@linux.dev, okozina@redhat.com,
 linux-block@vger.kernel.org
References: <20260310095349.411287-1-gmazyland@gmail.com>
Content-Language: en-US
From: Milan Broz <gmazyland@gmail.com>
Autocrypt: addr=gmazyland@gmail.com; keydata=
 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
In-Reply-To: <20260310095349.411287-1-gmazyland@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/10/26 10:53 AM, Milan Broz wrote:
> The TCG Opal device could enter a state where no new session can be
> created, blocking even Discovery or PSID reset. While a power cycle
> or waiting for the timeout should work, there is another possibility
> for recovery: using the Stack Reset command.

Hi Jens,

is there any chance to merge this for 7.1 (so it goes together with other
Opal changes)?

Thanks,
Milan

> 
> The Stack Reset command is defined in the TCG Storage Architecture Core
> Specification and is mandatory for all Opal devices (see Section 3.3.6
> of the Opal SSC specification).
> 
> This patch implements the Stack Reset command. Sending it should clear
> all active sessions immediately, allowing subsequent commands to run
> successfully. While it is a TCG transport layer command, the Linux
> kernel implements only Opal ioctls, so it makes sense to use the
> IOC_OPAL ioctl interface.
> 
> The Stack Reset takes no arguments; the response can be success or pending.
> If the command reports a pending state, userspace can try to repeat it;
> in this case, the code returns -EBUSY.
> 
> Signed-off-by: Milan Broz <gmazyland@gmail.com>
> ---
>   block/opal_proto.h            | 20 +++++++++++++++
>   block/sed-opal.c              | 47 +++++++++++++++++++++++++++++++++++
>   include/linux/sed-opal.h      |  1 +
>   include/uapi/linux/sed-opal.h |  1 +
>   4 files changed, 69 insertions(+)
> 
> diff --git a/block/opal_proto.h b/block/opal_proto.h
> index d138785b8198..7c24247aa186 100644
> --- a/block/opal_proto.h
> +++ b/block/opal_proto.h
> @@ -19,6 +19,7 @@
>   enum {
>   	TCG_SECP_00 = 0,
>   	TCG_SECP_01,
> +	TCG_SECP_02,
>   };
>   
>   /*
> @@ -273,6 +274,25 @@ struct opal_header {
>   	struct opal_data_subpacket subpkt;
>   };
>   
> +/*
> + * TCG_Storage_Architecture_Core_Spec_v2.01_r1.00
> + * Section: 3.3.4.7.5 STACK_RESET
> + */
> +#define OPAL_STACK_RESET 0x0002
> +
> +struct opal_stack_reset {
> +	u8 extendedComID[4];
> +	__be32 request_code;
> +};
> +
> +struct opal_stack_reset_response {
> +	u8 extendedComID[4];
> +	__be32 request_code;
> +	u8 reserved0[2];
> +	__be16 data_length;
> +	__be32 response;
> +};
> +
>   #define FC_TPER       0x0001
>   #define FC_LOCKING    0x0002
>   #define FC_GEOMETRY   0x0003
> diff --git a/block/sed-opal.c b/block/sed-opal.c
> index c34d19e91201..79b290d9458a 100644
> --- a/block/sed-opal.c
> +++ b/block/sed-opal.c
> @@ -3545,6 +3545,50 @@ static int opal_get_sum_ranges(struct opal_dev *dev, struct opal_sum_ranges *opa
>   	return ret;
>   }
>   
> +static int opal_stack_reset(struct opal_dev *dev)
> +{
> +	struct opal_stack_reset *req;
> +	struct opal_stack_reset_response *resp;
> +	int ret;
> +
> +	mutex_lock(&dev->dev_lock);
> +
> +	memset(dev->cmd, 0, IO_BUFFER_LENGTH);
> +	req = (struct opal_stack_reset *)dev->cmd;
> +	req->extendedComID[0] = dev->comid >> 8;
> +	req->extendedComID[1] = dev->comid & 0xFF;
> +	req->request_code = cpu_to_be32(OPAL_STACK_RESET);
> +
> +	ret = dev->send_recv(dev->data, dev->comid, TCG_SECP_02,
> +			     dev->cmd, IO_BUFFER_LENGTH, true);
> +	if (ret) {
> +		pr_debug("Error sending stack reset: %d\n", ret);
> +		goto out;
> +	}
> +
> +	memset(dev->resp, 0, IO_BUFFER_LENGTH);
> +	ret = dev->send_recv(dev->data, dev->comid, TCG_SECP_02,
> +			     dev->resp, IO_BUFFER_LENGTH, false);
> +	if (ret) {
> +		pr_debug("Error receiving stack reset response: %d\n", ret);
> +		goto out;
> +	}
> +
> +	resp = (struct opal_stack_reset_response *)dev->resp;
> +	if (be16_to_cpu(resp->data_length) != 4) {
> +		pr_debug("Stack reset pending\n");
> +		ret = -EBUSY;
> +		goto out;
> +	}
> +	if (be32_to_cpu(resp->response) != 0) {
> +		pr_debug("Stack reset failed: %u\n", be32_to_cpu(resp->response));
> +		ret = -EIO;
> +	}
> +out:
> +	mutex_unlock(&dev->dev_lock);
> +	return ret;
> +}
> +
>   int sed_ioctl(struct opal_dev *dev, unsigned int cmd, void __user *arg)
>   {
>   	void *p;
> @@ -3642,6 +3686,9 @@ int sed_ioctl(struct opal_dev *dev, unsigned int cmd, void __user *arg)
>   	case IOC_OPAL_GET_SUM_STATUS:
>   		ret = opal_get_sum_ranges(dev, p, arg);
>   		break;
> +	case IOC_OPAL_STACK_RESET:
> +		ret = opal_stack_reset(dev);
> +		break;
>   
>   	default:
>   		break;
> diff --git a/include/linux/sed-opal.h b/include/linux/sed-opal.h
> index aa006edb612b..0630430cc01a 100644
> --- a/include/linux/sed-opal.h
> +++ b/include/linux/sed-opal.h
> @@ -57,6 +57,7 @@ static inline bool is_sed_ioctl(unsigned int cmd)
>   	case IOC_OPAL_LR_SET_START_LEN:
>   	case IOC_OPAL_ENABLE_DISABLE_LR:
>   	case IOC_OPAL_GET_SUM_STATUS:
> +	case IOC_OPAL_STACK_RESET:
>   		return true;
>   	}
>   	return false;
> diff --git a/include/uapi/linux/sed-opal.h b/include/uapi/linux/sed-opal.h
> index 9830298ec51c..ef4d3be6ca7f 100644
> --- a/include/uapi/linux/sed-opal.h
> +++ b/include/uapi/linux/sed-opal.h
> @@ -245,5 +245,6 @@ struct opal_revert_lsp {
>   #define IOC_OPAL_LR_SET_START_LEN   _IOW('p', 243, struct opal_user_lr_setup)
>   #define IOC_OPAL_ENABLE_DISABLE_LR  _IOW('p', 244, struct opal_user_lr_setup)
>   #define IOC_OPAL_GET_SUM_STATUS     _IOW('p', 245, struct opal_sum_ranges)
> +#define IOC_OPAL_STACK_RESET        _IO('p', 246)
>   
>   #endif /* _UAPI_SED_OPAL_H */

