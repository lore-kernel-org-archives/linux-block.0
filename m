Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79D64404
	for <linux-block@vger.kernel.org>; Wed, 15 Nov 2023 05:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Zl03/FYT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PZrbibKS"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422868E
	for <linux-block@vger.kernel.org>; Tue, 14 Nov 2023 21:59:41 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 58FA51F8B2;
	Wed, 15 Nov 2023 05:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1700027979; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lNWv+nw1kbaPMMXMwpczXjda+khlOHXRaVbeZzfEFgY=;
	b=Zl03/FYT31wzXArw7s8s63QELOnyOVHZJbVdfGGSKZGDNck1AXSmSbkcJytOkj4OEZlHb3
	dUQA2xhdgDw6uakSsfeazvJqCA8My405zC/yo+RlknDckQSHN1PuRyPM+w7UHrVPvvJ640
	HuSGxCvV/9MselthSDOQuuJAv6L+J1A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1700027979;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lNWv+nw1kbaPMMXMwpczXjda+khlOHXRaVbeZzfEFgY=;
	b=PZrbibKSDCkzd8GlL06BDwtsYS3hnvlFgYoAFZHPDb1GuUibXuKF2NJvZdeestk6+vtHOK
	K3rw7l1Bdd6shXDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2BFD713592;
	Wed, 15 Nov 2023 05:59:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id s2L2CEteVGX4SgAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 15 Nov 2023 05:59:39 +0000
Message-ID: <447d68cc-91d1-4d17-aec6-0105d3b188c5@suse.de>
Date: Wed, 15 Nov 2023 06:59:38 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests 2/2] nvme/{041,042,043,044,045}: require kernel
 config NVME_HOST_AUTH
Content-Language: en-US
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc: Yi Zhang <yi.zhang@redhat.com>
References: <20231115055220.2656965-1-shinichiro.kawasaki@wdc.com>
 <20231115055220.2656965-3-shinichiro.kawasaki@wdc.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20231115055220.2656965-3-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -7.09
X-Spamd-Result: default: False [-7.09 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 BAYES_HAM(-3.00)[100.00%];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]

On 11/15/23 06:52, Shin'ichiro Kawasaki wrote:
> The kernel commit d68006348288 ("nvme: rework NVME_AUTH Kconfig
> selection") in v6.7-rc1 introduced a new kernel config option
> NVME_HOST_AUTH. The nvme test cases from 041 to 045 fail when the option
> is disabled. Check the requirement of the test cases.
> 
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Link: https://lore.kernel.org/linux-nvme/CAHj4cs_Lprbh1zWsJ2yT6+qhNoqjrGDrBgx+XOYvU9SLpmLTtw@mail.gmail.com/
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
>   tests/nvme/041 | 1 +
>   tests/nvme/042 | 1 +
>   tests/nvme/043 | 1 +
>   tests/nvme/044 | 1 +
>   tests/nvme/045 | 1 +
>   5 files changed, 5 insertions(+)
> 
> diff --git a/tests/nvme/041 b/tests/nvme/041
> index d23f10a..a7a5b38 100755
> --- a/tests/nvme/041
> +++ b/tests/nvme/041
> @@ -14,6 +14,7 @@ requires() {
>   	_have_loop
>   	_have_kernel_option NVME_AUTH
>   	_have_kernel_option NVME_TARGET_AUTH
> +	_kver_gt_or_eq 6 7 && _have_kernel_option NVME_HOST_AUTH
>   	_require_nvme_trtype_is_fabrics
>   	_require_nvme_cli_auth
>   }
> diff --git a/tests/nvme/042 b/tests/nvme/042
> index 9fda681..50d56d6 100755
> --- a/tests/nvme/042
> +++ b/tests/nvme/042
> @@ -14,6 +14,7 @@ requires() {
>   	_have_loop
>   	_have_kernel_option NVME_AUTH
>   	_have_kernel_option NVME_TARGET_AUTH
> +	_kver_gt_or_eq 6 7 && _have_kernel_option NVME_HOST_AUTH
>   	_require_nvme_trtype_is_fabrics
>   	_require_nvme_cli_auth
>   }
> diff --git a/tests/nvme/043 b/tests/nvme/043
> index c6a0aa0..b5f10bc 100755
> --- a/tests/nvme/043
> +++ b/tests/nvme/043
> @@ -14,6 +14,7 @@ requires() {
>   	_have_loop
>   	_have_kernel_option NVME_AUTH
>   	_have_kernel_option NVME_TARGET_AUTH
> +	_kver_gt_or_eq 6 7 && _have_kernel_option NVME_HOST_AUTH
>   	_require_nvme_trtype_is_fabrics
>   	_require_nvme_cli_auth
>   	_have_driver dh_generic
> diff --git a/tests/nvme/044 b/tests/nvme/044
> index 7bd43f3..06e17d1 100755
> --- a/tests/nvme/044
> +++ b/tests/nvme/044
> @@ -14,6 +14,7 @@ requires() {
>   	_have_loop
>   	_have_kernel_option NVME_AUTH
>   	_have_kernel_option NVME_TARGET_AUTH
> +	_kver_gt_or_eq 6 7 && _have_kernel_option NVME_HOST_AUTH
>   	_require_nvme_trtype_is_fabrics
>   	_require_nvme_cli_auth
>   	_have_driver dh_generic
> diff --git a/tests/nvme/045 b/tests/nvme/045
> index 1eb1032..126060c 100755
> --- a/tests/nvme/045
> +++ b/tests/nvme/045
> @@ -15,6 +15,7 @@ requires() {
>   	_have_loop
>   	_have_kernel_option NVME_AUTH
>   	_have_kernel_option NVME_TARGET_AUTH
> +	_kver_gt_or_eq 6 7 && _have_kernel_option NVME_HOST_AUTH
>   	_require_nvme_trtype_is_fabrics
>   	_require_nvme_cli_auth
>   	_have_driver dh_generic

Why do we need to check for the kernel version?
Any kernel not having the NVME_HOST_AUTH config symbol clearly will
have it unset, no?
I'd rather update _have_kernel_option to handle the case where
a config symbol is not present, treating it as unset.
That way we can drop the dependency on the kernel version (which, btw, 
is kinda pointless for the development branches anyway).

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

