Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871FD1922DB
	for <linux-block@vger.kernel.org>; Fri, 23 Aug 2024 18:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724437081; cv=none; b=Qx5fGI6xjoaX/CV61BkTcr1XX+008jnPy2dI/BwwalBXnfB5kFAEPcrqIl6Wb/5znr8NA1Rjct+nnhVSX09m6eVC1iT05Ytu4ff+uvp5C0savgZXVky582LedDMBW2N5X7TU6oCpgaQfFzwTnFlff18POQCFaCyTh8qjqWC/bpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724437081; c=relaxed/simple;
	bh=us2rdXys21oFgrc3lIMa0w1LdWVH/OnjI7GaLqu0mi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fISl1eCmD1DrZ9yng6RkNzbiQt/Xbe6pEceE33PnPszYdtSRO4+iCtHRX/RQMfs+CYFnoOzm2e3CypW4Lnxvn6D9ukEmTED6qchek3uZ21DRR8A3eIP7bbZAAmBUgJQRaMSAxTPkK8OBzj73fvM8sMuIt+75yAUEZ19B5uvtZEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=GfUlYxIh; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="GfUlYxIh"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-39d311d8091so9341745ab.3
        for <linux-block@vger.kernel.org>; Fri, 23 Aug 2024 11:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1724437076; x=1725041876; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1L2UbMyeA6ZtpjTTf28qzgxKAoNSjMt5tsfvJ8hB874=;
        b=GfUlYxIhh/Nu/xAZbJn7bjXK45QogWB3VoLR+TZC+3pATI157oIPXO8X3vTwdJxnHL
         BmGfP+/t72P3wS6LqhmF/CwYlYMHr8dQFd21VuAy+G3vwbFEDPCH2HhugdSVh3ujiwIL
         YZzwdemqMNuONPNjwvmCnbAKS2GZkLCbKSmLKbIGy6GW2SL6jMgOfjzsBKFd8npRfhKv
         PzOXjb7H5oBvThdjJk9SLZgXOr0Y7dTujowLcl48jPu3grKS+ME7iU6um/f1jXd/nYEq
         +cdx1KQDBcEUbCookwApuOVBqlyB/owwidnlJwE0lMu+gssQP7IOBOf6H94BiesIL7S0
         Q8BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724437076; x=1725041876;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1L2UbMyeA6ZtpjTTf28qzgxKAoNSjMt5tsfvJ8hB874=;
        b=ioBDYa9F9nAZV/8zOzQSxOxFnit+mqcdFooICBSMKBJUQPHX9mKve+q2Xq0UQ6dyum
         zS1rJpWgE/IVS3ugBmaXr4IDV4hGDJ9yRy+ZKEtI6IRqirdj9o+WjoIszhthOF4+5/kX
         RTtJ2rvushukZmkv5BkLAyvgYKleK6xkJq5NJ5jwjymwft10UqT/rfQrHFSfMkXC+Pxk
         U1GPe68yxdX3mIBk8Eh9sUleCSGNP3/A6aBg9gokF1992j8at2OrsRPm+JwP9vni/jgv
         5jdmMgli5OVNiGzx/+i/imffwYalz1bztYFTF8E5mof/SmFFxHyARW9FBzrblHBqBiXW
         Alyg==
X-Forwarded-Encrypted: i=1; AJvYcCVUHUNTeXDv3YqspZ44cr2F44ev3NTeTopGU1nF2ymBwFVk+Tze0IsB/5HKULN9Ksl/L6ing9Qwz2KCOg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe0+60/xNdth8uikZ8Amqe5rWuWOY9RzgFyw0WDAz8wecICEPM
	ECXEJNlQ59dUqCQmm12C257TjOSBn6tSQJwFYJh4ye29uY2KXLcINTvLBdKZ0g4=
X-Google-Smtp-Source: AGHT+IE/2G50xW++565D0QEbsbBjpVPhWGeJ2rBDoGBZkDXHAPhG03bCJzSak3QpcUe2p4QHftCocw==
X-Received: by 2002:a92:ca4c:0:b0:374:aa87:bcaa with SMTP id e9e14a558f8ab-39e3c98c6fcmr38850175ab.14.1724437076349;
        Fri, 23 Aug 2024 11:17:56 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ce70f5c54dsm1036027173.55.2024.08.23.11.17.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 11:17:55 -0700 (PDT)
Message-ID: <6f303c9f-7180-45ef-961e-6f235ed57553@kernel.dk>
Date: Fri, 23 Aug 2024 12:17:54 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] Documentation: Document the kernel flag
 bdev_allow_write_mounted
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>, linux-doc@vger.kernel.org
Cc: corbet@lwn.net, linux-fsdevel@vger.kernel.org,
 linux-block@vger.kernel.org, kernel-dev@igalia.com, kernel@gpiccoli.net,
 Bart Van Assche <bvanassche@acm.org>, "Darrick J. Wong" <djwong@kernel.org>,
 Jan Kara <jack@suse.cz>
References: <20240823180635.86163-1-gpiccoli@igalia.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240823180635.86163-1-gpiccoli@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/23/24 12:05 PM, Guilherme G. Piccoli wrote:
> Commit ed5cc702d311 ("block: Add config option to not allow writing to mounted
> devices") added a Kconfig option along with a kernel command-line tuning to
> control writes to mounted block devices, as a means to deal with fuzzers like
> Syzkaller, that provokes kernel crashes by directly writing on block devices
> bypassing the filesystem (so the FS has no awareness and cannot cope with that).
> 
> The patch just missed adding such kernel command-line option to the kernel
> documentation, so let's fix that.
> 
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Darrick J. Wong <djwong@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> ---
> 
> V3: Dropped reference to page cache (thanks Bart!).
> 
> V2 link: https://lore.kernel.org/r/20240823142840.63234-1-gpiccoli@igalia.com
> 
> 
>  Documentation/admin-guide/kernel-parameters.txt | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 09126bb8cc9f..58b9455baf4a 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -517,6 +517,18 @@
>  			Format: <io>,<irq>,<mode>
>  			See header of drivers/net/hamradio/baycom_ser_hdx.c.
>  
> +	bdev_allow_write_mounted=
> +			Format: <bool>
> +			Control the ability of directly writing to mounted block

Since we're nit picking...

Control the ability to directly write [...]

The directly may be a bit confusing ("does it mean O_DIRECT?"), so maybe
just

Control the ability to write [...]

would be better and more clear.

> +			devices, i.e., allow / disallow writes that bypasses the

Since we're nit picking, s/bypasses/bypass

> +			FS. This was implemented as a means to prevent fuzzers
> +			from crashing the kernel by overwriting the metadata
> +			underneath a mounted FS without its awareness. This
> +			also prevents destructive formatting of mounted
> +			filesystems by naive storage tooling that don't use
> +			O_EXCL. Default is Y and can be changed through the
> +			Kconfig option CONFIG_BLK_DEV_WRITE_MOUNTED.
> +
>  	bert_disable	[ACPI]
>  			Disable BERT OS support on buggy BIOSes.

-- 
Jens Axboe

