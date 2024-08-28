Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6AD18030;
	Wed, 28 Aug 2024 08:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724834739; cv=none; b=c9afoJTiLcSRMZJD1F8fVLDlveZnYPks/nGANs7zmyeO76gHgY4lE5+JFniuDZQIkfeBrrHvSrFOjOd2rtrXvpPrSrozu2WSe33Eq69sqEga2UtwVa97pDSt8u4sP3kDhZLGFqvI/DyqTRBwx7/6zVm+fUZosXItvgPWQ+5H9u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724834739; c=relaxed/simple;
	bh=tIwiCot+hNofIgTARIg1wqYbhY2VvIyGbcRSCRL2c9E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r1ntj4PWmnnDwxrcMH8zcvzgoPBAXrLGf7S70/Ovvh2ICC8ETZMt6mEWC7HGC6F6BaCvAvH3APFmzZpeGdyts+7GXl+32R/Pn3ZIiDPCTKAJ8SA0UYL2b+DsT/NVieIPl5/7EYgktiA7e063uFMiVxWCuhYu8z7qpEkVVR47tgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TM74TetN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TM74TetN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BC5CC4FEFA;
	Wed, 28 Aug 2024 08:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724834738;
	bh=tIwiCot+hNofIgTARIg1wqYbhY2VvIyGbcRSCRL2c9E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TM74TetNTPgKURGd5uyExzUfl7PjGSvoTipj8S41BjJYmTdWuIf/EcBjSFfRUbXPL
	 ERf9yW+mUh/JcjCp87W1OePDivwDx5QUgKLkZpPguo2RaF1Io54Rx09wJ96dbTn0+0
	 YyR+bto/SNi88R/BX3C4OLyCZpwyydfpiVNgnQEtHknQarZq3x/mRCHsEI1P96hHzu
	 BbBq1rh4oub+Yrp6oUqu4Tpe9uNiOWXoW3Pybmge74jAjbmPw7qPQYbfNr5duc6ggT
	 AAomtiRropi6b43C5jWTzjkavM2KE7Vhj7GUICIRWulnZDKmbM4JjJVZSkdWNbOB3J
	 YbmvBxeXLnsuQ==
Message-ID: <a5609ba3-cc35-41c5-98f1-52063f8a6eec@kernel.org>
Date: Wed, 28 Aug 2024 17:45:36 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Fix validation of ioprio level
To: Ajay Kaher <ajay.kaher@broadcom.com>, axboe@kernel.dk,
 niklas.cassel@wdc.com, hare@suse.de, martin.petersen@oracle.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 alexey.makhalov@broadcom.com, vasavi.sirnapalli@broadcom.com,
 vamsi-krishna.brahmajosyula@broadcom.com
References: <1724833695-22194-1-git-send-email-ajay.kaher@broadcom.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <1724833695-22194-1-git-send-email-ajay.kaher@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/28/24 17:28, Ajay Kaher wrote:
> The commit eca2040972b4 introduced a backward compatibility issue in
> the function ioprio_check_cap.
> 
> Before the change, if ioprio contains a level greater than 0x7, it was
> treated as -EINVAL:
> 
>     data = ioprio & 0x1FFF
>     if data >= 0x7, return -EINVAL 
> 
> Since the change, if ioprio contains a level greater than 0x7 say 0x8
> it is calculated as 0x0:
> 
>     level = ioprio & 0x7
> 
> To maintain backward compatibility the kernel should return -EINVAL in
> the above case as well.
> 
> Fixes: eca2040972b4 ("scsi: block: ioprio: Clean up interface definition")
> Signed-off-by: Ajay Kaher <ajay.kaher@broadcom.com>
> ---
>  block/ioprio.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/block/ioprio.c b/block/ioprio.c
> index 73301a2..f08e76b 100644
> --- a/block/ioprio.c
> +++ b/block/ioprio.c
> @@ -30,6 +30,15 @@
>  #include <linux/security.h>
>  #include <linux/pid_namespace.h>
>  
> +static inline int ioprio_check_level(int ioprio, int max_level)
> +{
> +	int data = IOPRIO_PRIO_DATA(ioprio);
> +
> +	if (IOPRIO_BAD_VALUE(data, max_level))
> +		return -EINVAL;

No, this cannot possibly work correctly because the prio level part of the prio
data is only 3 bits, so 0 to 7. The remaining 10 bits of the prio data are used
for priority hints (IOPRIO_HINT_XXX).

Your change will thus return an error for cases where the prio data has a level
AND also a hint (e.g. for command duration limits). This change would break
command duration limits. So NACK.

The userspace header file has the ioprio_value() that a user should use to
construct an ioprio. Bad values are checked in that function and errors will be
returned if an invalid level is passed.

> +	return 0;
> +}
> +
>  int ioprio_check_cap(int ioprio)
>  {
>  	int class = IOPRIO_PRIO_CLASS(ioprio);
> @@ -49,7 +58,7 @@ int ioprio_check_cap(int ioprio)
>  			fallthrough;
>  			/* rt has prio field too */
>  		case IOPRIO_CLASS_BE:
> -			if (level >= IOPRIO_NR_LEVELS)
> +			if (ioprio_check_level(ioprio, IOPRIO_NR_LEVELS))
>  				return -EINVAL;
>  			break;
>  		case IOPRIO_CLASS_IDLE:

-- 
Damien Le Moal
Western Digital Research

