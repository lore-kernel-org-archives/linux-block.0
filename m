Received: from mail-oa1-f100.google.com (mail-oa1-f100.google.com [209.85.160.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886BDDDAD
	for <linux-block@vger.kernel.org>; Tue, 22 Apr 2025 00:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745280447; cv=none; b=Yk3BL3FNCzxuwIBWka3GpVFTUuLqoKaKUpxPsVo7aaNom3SyipF1tg9xqcYkl9CDjMh5WcHjZn4Rtnozc/1fLzCUuSykhY1Bi95OUHSxkaQbJWHSnUZk/uSmZYhBb2bTLb4dmQ/NEaJJjN7iY6n9aI54Y6uMjgkt7Xq/vLjOMck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745280447; c=relaxed/simple;
	bh=vfwMlnUFMrZL3kEc/oSiDjUGdxvIJRUdYHs+ugHJId8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k/jvYuEulB+NK7WlPENtIY1saJ6Q4D6wXFTzDtyl66t/dVLNunPAXxeX5iR4GdROQBMTvIUkQY3t8CGga7AxPlZT8xMxgJNddfsR2rKW41KDUjjn6WiObXmbnOVx9xN5dBeWXzciMpIfYZ4gOaixpgqCpFQiDQNaxWo1O7wXEV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=cwvDgxG8; arc=none smtp.client-ip=209.85.160.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="cwvDgxG8"
Received: by mail-oa1-f100.google.com with SMTP id 586e51a60fabf-2d54b936ad9so1222617fac.1
        for <linux-block@vger.kernel.org>; Mon, 21 Apr 2025 17:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745280444; x=1745885244; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z2ZKPeibJkPCx6tGjGVebJWlQyx5eLItRNbSWacbbSc=;
        b=cwvDgxG8zNb43g35uJAnzL4VZZKqwrCv3iCHcW7B4URV0d3a25g/UwyPZ8TYJwarWT
         3jIkhMYVej/TIQJk0CnihXWGAhwQOMo27cFNFyeKro7njgm9zi7KwGdqyLT/coVL+qwz
         vcGNrlhtidXezlyVEWyvwOkN5Z3Kl0ULVDJrAdEzr5XE/WR9DOBFBf6J5enYgyl5WyoA
         Vn+LQ+94XSsUyd4Vur1NH+gIhEuVzvXwnENhw2o9UqRczXW8uxLVx6BIN3czZ7XQqQbV
         gNBPzCP4BXzilZMnxpZnpSbrds3eYB9t9b34nDfua7LMIllGzAkvi3AMQylgjq5GyFAK
         woag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745280444; x=1745885244;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z2ZKPeibJkPCx6tGjGVebJWlQyx5eLItRNbSWacbbSc=;
        b=OrV5bqcGjWq9QrPO9jQMOTSkU/ULkM1nk9zhY9mKRtR2Wt019VeA9wkXmZT4ux5hsJ
         N1bnDkWNUyJN68zTRv8RsATRrD+Ioi7V1xbT1BMyfkBRcY/XMfZXef6IcPrQ7bU0u+sD
         1u6IjSyyKIekR3R3lJ0nncmTz06p4wAaTY394CLCd9VGCLe5NiwLxMFjuXb0XDOyYr+m
         fuRPYYsPkveKHRNSq+FcgSltrAxuEzY3+FtqzguQpfo3B/XxUUpe/rfjHMIaYl426TZM
         +qGPkobXy3DcSmEap4Bf7TnXnhCSDt2DA5bieHxNm+OjF3h49KYRcorRROT3DhG1lfh0
         xP/g==
X-Forwarded-Encrypted: i=1; AJvYcCXTTb0NHcXDlSqvZnkJDhlnRiIBvOsBCs5/af0CR5MyFIjJ6fqs6mQsCN9acszRSKrboMsazvL2GpL8mA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+8uLxw5UbAofzvySzxKHQDUi+nH1rDvuCLUCv5OvsFBN/e7rs
	ZISRue7/sGE85hkqaUsXx9ZKX63e3JbprTpLQu6F0VtKAFrKhn+G50jS+lEOYaIkrihtP1sAfC1
	WJFReLXiUALxZTAxsognYbCfcUiP2zVSa
X-Gm-Gg: ASbGnctqwxCqJQ3S02U0bk1JBtaO7fvDe/XdQfRHf8WCkf9CA2F+iIB93JC77qZaRUp
	5uT1TyN23Lr8WOGGPuU1YexxkmznwiT9TTu8ozKs6+4VHsPD+IdTyEC2GM5/tgXMOmmfG3I1yN9
	QKwXcwk+eBoznwrnSRIjTBg+Li1eMtAl5SlJMS2Qr99UwqCg5tA8KVci/GjacD5ht1+fpDyN+4S
	jxt4jSH/Ibtdo6UgOGU9EEJb7KBw3XrkXQ/5h0ZdhKRiDzZ9bVgh5cytTvoU347jVnubr6mCMV3
	/4ZRBZqwhITj5W4TNAUdcRlryU2OkIEy4QizDAz6SpNaog==
X-Google-Smtp-Source: AGHT+IF3vn64i0peqRdAZly6tVBfXIGRZ/KtFft5KGZT+xrmFEgen8w0dSgbwyEB9BWHqnTZGoiOmMHvwlkY
X-Received: by 2002:a05:6871:bd07:b0:2d5:75eb:518f with SMTP id 586e51a60fabf-2d575eb71e5mr3525192fac.2.1745280444492;
        Mon, 21 Apr 2025 17:07:24 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-2d52175b155sm297096fac.25.2025.04.21.17.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 17:07:24 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 066CB3403C6;
	Mon, 21 Apr 2025 18:07:24 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id A96EDE40EC5; Mon, 21 Apr 2025 18:07:23 -0600 (MDT)
Date: Mon, 21 Apr 2025 18:07:23 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 6.15 2/2] selftests: ublk: remove useless 'delay_us' from
 'struct dev_ctx'
Message-ID: <aAbduzqdp9kwazB0@dev-ushankar.dev.purestorage.com>
References: <20250421235947.715272-1-ming.lei@redhat.com>
 <20250421235947.715272-3-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250421235947.715272-3-ming.lei@redhat.com>

On Tue, Apr 22, 2025 at 07:59:42AM +0800, Ming Lei wrote:
> 'delay_us' shouldn't be added to 'struct dev_ctx' since now it is
> handled by per-target command line & 'struct fault_inject_ctx'.
> 
> So remove it.
> 
> Fixes: 81586652bb1f ("selftests: ublk: add generic_06 for covering fault inject")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Reviewed-by: Uday Shankar <ushankar@purestorage.com>

> ---
>  tools/testing/selftests/ublk/kublk.h | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
> index 29571eb296f1..918db5cd633f 100644
> --- a/tools/testing/selftests/ublk/kublk.h
> +++ b/tools/testing/selftests/ublk/kublk.h
> @@ -86,9 +86,6 @@ struct dev_ctx {
>  	unsigned int	fg:1;
>  	unsigned int	recovery:1;
>  
> -	/* fault_inject */
> -	long long	delay_us;
> -
>  	int _evtfd;
>  	int _shmid;
>  
> -- 
> 2.47.0
> 
