Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B11DF42
	for <linux-block@vger.kernel.org>; Tue,  2 Apr 2024 01:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712021209; cv=none; b=NSzuxqL+OQqFUMf9D6CadqwdtDsJ+o6xICo3z1BTILv2mQRXRWBLt+4gRdTUb4VHxndi4axBU4XSoKHkArB76u0Xai17WlGQwFYsrPJEG5eHoqmH0ZSAIOHAjYztFMpM69jZu0FmDt/smKY/12Y399AR7hqA1D4XTfgnTuvV5Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712021209; c=relaxed/simple;
	bh=WqrYHc1OrW927dxpv9fTrIBfKRqR2NBvDdcY6XIS0bs=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=pfMEl4C36fBntYq3OpdqEcLs93rwMY0i6szipSZ9vJAdUxbs17aFJyMnC6wlfN0YBK1rzKYBw/78JGudnVHaE5W8irinMEwYfssTZO/U5PBLoBY6qAQR1ZngHDg0x0xOTR3XuaHynEIRoihsf1IzQh2lU/JnuCXIljdad9ubaJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=G4lN+Yma; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="G4lN+Yma"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-432b72c706cso35467201cf.1
        for <linux-block@vger.kernel.org>; Mon, 01 Apr 2024 18:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1712021206; x=1712626006; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hRws9YXLN8yb7zuQUc8CIutzWgp4avkTPI09HZCU6cI=;
        b=G4lN+Yma1v3mXG/SF+E4Q4Vmtq9IXlAYYEGNzQXsfUcjzmflAs+JTdgx6LMlAIFL9g
         HDlwt0Akkidq+vZKEYCuIM8jG6PdXrvmlZSZvYvCuuoFw+UXnJWjIQVzVoTaPmseSUjB
         drYQtYihg223VfBX5smeEnjs9qy+vAJ0lPjCvzSMy/HoNWd/TZEAO8q6QRngJdOnp4EN
         9xaNBt90oS9blyJa/pJykeOXUxR6rsO8BLXsKDz6q/rxfL+/lA7UkmJHT3RL6kelYr/t
         eRDPrIDjF8MoOn/FpM4kB5PBwj/pbnZQyNAOl+U0vdT69ZGIZF0SqDAiL/yIpoyYbrEx
         8StA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712021206; x=1712626006;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hRws9YXLN8yb7zuQUc8CIutzWgp4avkTPI09HZCU6cI=;
        b=JHmJgt9B2QQgQrv8Hx7913sL3pP09Brh7rJBM5gtMAAP5K5/Of7z4jxfT+IpPGZ0oS
         /S+hzjpl5n5EPaPYj0YuDjH8ekWK8cwPI7LOEfdKfSPIjWi3X3eiQdczMmyYEr4UHp+B
         moqhCRCCE0wO8x3IreNTSN73842YhTlJDPLc2BcVBlcLXP3SoiiARkVuE3kkJ0O3BeHe
         WaQqKqRQL4j8BSU5ba0jCIhrw6J6+LyhzRePT5ofNaMYo1zRFeqCKc0+o6Nlj6F5hmt/
         iaOePo2PB07jgEKrP9P31L9rLgwWbaPP/ZwV5FULMn8vDxd3+xkcyXCcIoa0lJm2mTYj
         2oXg==
X-Forwarded-Encrypted: i=1; AJvYcCUEYIAx+yJWOUzYxtMeyasGKaaLsj4d1Px9xNxZrnrqEZfAxpKSGgSdJvNOeGZNQL1DYr92b4zkfSvZnLb64hAmU3WvlQ5JDTIOOQE=
X-Gm-Message-State: AOJu0YzplEAFDAcHW8Ifxi6Xn547vbnNaVyUuKMPpB6cBpTevwuc/xAU
	vzASNTn4b4MookKcOawpWf4rL4BT0aXJ7ymhta7cgU8sBUxMNzXdauHVAMM3zQ==
X-Google-Smtp-Source: AGHT+IFZ7SasfMMYh5vB3j/xGXqf/TCs4Bcif8z6dD6zV7+EZAG39P9HJEPaE4K4Urz2UW0TPzSDug==
X-Received: by 2002:a05:622a:4b11:b0:432:de8a:3a8 with SMTP id et17-20020a05622a4b1100b00432de8a03a8mr9661426qtb.18.1712021206548;
        Mon, 01 Apr 2024 18:26:46 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id fw4-20020a05622a4a8400b00432bcd630c8sm4405470qtb.93.2024.04.01.18.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 18:26:46 -0700 (PDT)
Date: Mon, 01 Apr 2024 21:26:45 -0400
Message-ID: <7bc35832c837a23773424bdc2255808b@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=utf-8 
Content-Disposition: inline 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: Fan Wu <wufan@linux.microsoft.com>, corbet@lwn.net, zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com, tytso@mit.edu, ebiggers@kernel.org, axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org, eparis@redhat.com
Cc: linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, fsverity@lists.linux.dev, linux-block@vger.kernel.org, dm-devel@lists.linux.dev, audit@vger.kernel.org, linux-kernel@vger.kernel.org, Fan Wu <wufan@linux.microsoft.com>
Subject: Re: [PATCH v16 15/20] security: add security_inode_setintegrity() hook
References: <1711657047-10526-16-git-send-email-wufan@linux.microsoft.com>
In-Reply-To: <1711657047-10526-16-git-send-email-wufan@linux.microsoft.com>

On Mar 28, 2024 Fan Wu <wufan@linux.microsoft.com> wrote:
> 
> This patch introduces a new hook to save inode's integrity
> data. For example, for fsverity enabled files, LSMs can use this hook to
> save the verified fsverity builtin signature into the inode's security
> blob, and LSMs can make access decisions based on the data inside
> the signature, like the signer certificate.
> 
> Signed-off-by: Fan Wu <wufan@linux.microsoft.com>
> 
> --
> v1-v14:
>   + Not present
> 
> v15:
>   + Introduced
> 
> v16:
>   + Switch to call_int_hook()
> 
> ---
>  include/linux/lsm_hook_defs.h |  2 ++
>  include/linux/security.h      | 10 ++++++++++
>  security/security.c           | 20 ++++++++++++++++++++
>  3 files changed, 32 insertions(+)
> 
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index b391a7f13053..6f746dfdb28b 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -1020,6 +1023,13 @@ static inline int security_inode_copy_up(struct dentry *src, struct cred **new)
>  	return 0;
>  }
>  
> +static inline int security_inode_setintegrity(struct inode *inode,
> +					      enum lsm_integrity_type, type,

Another bonus comma ...

> +					      const void *value, size_t size)
> +{
> +	return 0;
> +}
> +

--
paul-moore.com
