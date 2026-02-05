Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45F036E495
	for <linux-block@vger.kernel.org>; Thu,  5 Feb 2026 10:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770288789; cv=none; b=TrqaWKwYGlpkrCCosadvCtrW1AvnHFWwNGFet9t+CCdb5AJyDBlAvMW6yl8cBWUcpOQqHYYN1B6DbUSN+lDDOsGjqG0Ytd7gFRo9Rd0hGjCxPenRvvviZ7WkDHwnOAjRraT5zuA9VgX3dRvo/kDX7ctjldYdgXnxmmoO9U1Hlq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770288789; c=relaxed/simple;
	bh=p5ZxxLhRM7KNb+08JyORQsjnmS9D6hRQY8Q0kAaQ6jM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NiusgdwYHelMez4iPjRQ+nPIomnK/n/4hfwSfkjkrEAFHNcWuWypbjCliwn1Tk/bOmfBsNb44l0IJLTSizzCjcpvZBLREn2lZamb8jV7qgNIwVAvy75MpoS8YRz8j4Y2Cqy9T+IMvamMaBWJE+iHseAEMY8u/P7aPJnuqLMcLLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WpeSKyFv; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WpeSKyFv"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42fb0fc5aa9so623482f8f.1
        for <linux-block@vger.kernel.org>; Thu, 05 Feb 2026 02:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770288787; x=1770893587; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/+c2QLdGZFoULZ/RvBqcUByi9TkEnmi28PPZ5Yodtb0=;
        b=WpeSKyFvKM8h7aFIEQN6w70HUbK0HrFEZ8qaNiOFIaHOkpMGIbtR2BjA+S5/IoNiR/
         pIRIqyRjTPiE1WXZgTMpgu1GgK4pXLBHCasaLyTNZR4fLq9NXEANe1jMYsEh8IvRwJPj
         Q19R7Vhc2H4WB3UuSnPCkdqfURm0cgn+9sGSblFj/TT5J8/k3URRuAuptcMM09qsVoCF
         dAbIxGOrSIMx8vE8GFl5HJ/EjcB9E2dfHItGh7KrjIwKY/m9/Eb5DkQvPeuy4grRld+0
         yKGlsKSfMRG3p8dbZQIBFqVAJAWJ4YE/VKMDle/tvpMMXW85GOtv0MFTOs0WQeyiTTwZ
         8LAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770288787; x=1770893587;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/+c2QLdGZFoULZ/RvBqcUByi9TkEnmi28PPZ5Yodtb0=;
        b=Zc7qO6rxmPHnM5ADJy5G72fKnJZBmGpk7MLUOgbabee79wYyRo3eRjNQavz6pVBaEI
         1jIJnH6cJpCkQDO7xXZT3vSb2xZACTgl7kAFui607/lry+TDI2auqB2+OsdKTplKOz7j
         DrpBemXqkWH5QwZcVwO1Sw6xOSoiT/gumHfR2O07x8XgRYAo+sT0I5YZIZKNfd2aFemk
         gD1T4eeU9XyQ4o1zUgUy4HnqPhF350QeNdxftagrx8loe7UTdgazGlfL1Ir3QUMqvdnW
         mHNADcCayQwpPLIDsPW7NlX4vn6qm6nXMn7qBuoHeHDnHteeZLlI9D+d6rHJRfajAiIg
         4Wug==
X-Forwarded-Encrypted: i=1; AJvYcCVOj0ZHX+qn6FDhzaCz9QoJucAdlg8XGLTX8UUOxrGa7n77UpX3LcztbGY2f+QbuldqsTxTp6Ffz9TZLg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxUiZpU69o/TTEUbAKUhPg37ZU9noja0TAsdL7vh7DY3F2tC9w3
	G+bSL93jAV6vHaEUOcrW8rKMvcv3jfGpRd1cws7XPKUlYN8xOuDDADIU
X-Gm-Gg: AZuq6aLi7k1S6eUh4tJvewQQT2pS62wu6uwbnxx1zWMOXLeFEpKmjtFAdmVBVG/Sqry
	soUhTRQWbjUWohAAqdNE9ueCZoE+cUDFMKODZl0JSVLBxwUUwGFc9TCD3/GftwMAq+fSv63rI7B
	zYba2zHRbyidrHUeTa2m8TfiLM/iyUc7OBxwEMGD4zcXaV8kD9r2twq1MZeS95PUG3AvCXC+rzW
	p1XU0w4BcVxXdxGvpbf7rQxdy8Z/N787jrJvRNfDShnSAT4Jvyxsupb41Ox5Ki79zKyXitVhiwo
	HhYPNouC1pCkyUgYnVDXTIYzV95E89XFKwS77nXcer6EY7wHjjqRjioOHQ7kEIalEweyZ//jPt7
	59r8r0fHtvb6rCjpOTueps/M9UI14ssALND9L4JwlNCsPpJJEtjwiYknnn6XiwS7YTqGMbOVNVB
	JHry6ezopiAmIHJ7k=
X-Received: by 2002:a05:6000:230f:b0:435:b7ca:7521 with SMTP id ffacd0b85a97d-43617e41ef4mr9745313f8f.15.1770288786946;
        Thu, 05 Feb 2026 02:53:06 -0800 (PST)
Received: from [192.168.1.27] ([176.74.141.242])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43617cc9515sm11966963f8f.0.2026.02.05.02.53.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Feb 2026 02:53:06 -0800 (PST)
Message-ID: <c3f45132-de87-4c22-a189-c753a85074dc@gmail.com>
Date: Thu, 5 Feb 2026 11:53:05 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] sed-opal: add IOC_OPAL_REACTIVATE_LSP.
To: Ondrej Kozina <okozina@redhat.com>, linux-block@vger.kernel.org
Cc: gjoyce@ibm.com, jonathan.derrick@linux.dev
References: <20260130162527.570255-1-okozina@redhat.com>
 <20260130162527.570255-2-okozina@redhat.com>
Content-Language: en-US
From: Milan Broz <gmazyland@gmail.com>
Autocrypt: addr=gmazyland@gmail.com; keydata=
 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
In-Reply-To: <20260130162527.570255-2-okozina@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/30/26 5:25 PM, Ondrej Kozina wrote:
> This adds the 'Reactivate' method as described in the
> "TCG Storage Opal SSC Feature Set: Single User Mode"
> document (ch. 3.1.1.1).
> 
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

This addition should be mentioned in commit messages.

Perhaps separate new UID definitions to another patch.

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

Hera I would add comment describing which variants it implement
  - set SUM for whole locking table (no list)
  - set SUM for separate LRs
and how it differs.

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

Remove empty line here?

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

This is optional, if not set, admin key remains unchanged. Add comment?

> +	if (opal_react->new_admin_key.key_len) {
> +		add_token_u8(&err, dev, OPAL_STARTNAME);
> +		add_token_u64(&err, dev, OPAL_SUM_ADMIN1_PIN);
> +		add_token_bytestring(&err, dev, opal_react->new_admin_key.key,
> +				     opal_react->new_admin_key.key_len);
> +		add_token_u8(&err, dev, OPAL_ENDNAME);
> +	}

...


Otherwise looks good.

Milan

p.s.
I implemented similar code in userspace for opal-toolset and tested on several drives.

Original sedutils do not implement SUM / reactivate at all.

That said, there are many drives that have broken SUM implementation... but I am pretty
sure the construction above is according to TCG standard.

