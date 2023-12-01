Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WaFXCE2L"
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A18C1A8
	for <linux-block@vger.kernel.org>; Fri,  1 Dec 2023 07:28:28 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-285b88b9917so2095140a91.1
        for <linux-block@vger.kernel.org>; Fri, 01 Dec 2023 07:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701444508; x=1702049308; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FTQGEo0Gq1nAGsQuhkH/fxmAkBokmUii6biJ9HXJbEc=;
        b=WaFXCE2LN8j4vCk/fzP4+F6EMxM0eIttL+9WHmAN0PIFs9yxzyHN1Hqg4rkrBHa+iW
         A/RW16uq4FZ2xaw5WW6p154GCLcUGTYU034FEkdbPf4cK3w1tjhkZ5e7h6WvL4JYFaVu
         Dr898dOkgfUODKq8+cMKrvTmPqP+ElJAb6kWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701444508; x=1702049308;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FTQGEo0Gq1nAGsQuhkH/fxmAkBokmUii6biJ9HXJbEc=;
        b=nvhF4ARhKEmdPcH2FaVx5Q96bo4egB8xPiYyCZiJx+gsjZXrgaR3NuotW08uDmLLX8
         2yTjdOpQbi1sQkZYUTrfodunNlymfSIk8kd7RvzBsve8hf837h79/Yk3GUOlWgPnD6pT
         qzmY6YhYr5BCDshNQZ9gc8RBONtPH2/NzaWO3xXSRb6cyax6vAVmR3UFAB8l/80Kn78q
         CtJzFbfhBoDe4EM86pVGEySAzAPPZscfhT09EU8v047KbGBFMVUbeXcF2NUX4fTg2gEp
         ckVhHh9wJ4dx1nka9l7WKkqdzhGa4jpBXdz40iEs9fwS7/8ax+cQjji2Ra0R9YsUcY8V
         GJfw==
X-Gm-Message-State: AOJu0YxxfohQhrzm+4faCplff/aPOxu66rKrrczJ4EC26sRS62cA8dJn
	m1T/3ill4iZPyvN5OKIeJ/Du0g==
X-Google-Smtp-Source: AGHT+IGyzIRPsoTkJUx2/cJ2/b+BFFvAkGivUhdUfjYH+m/ZgroTLcGiGQCB8NPG+GM90Z9kn3Px5A==
X-Received: by 2002:a17:90b:1c07:b0:285:a179:7218 with SMTP id oc7-20020a17090b1c0700b00285a1797218mr22275548pjb.9.1701444507773;
        Fri, 01 Dec 2023 07:28:27 -0800 (PST)
Received: from google.com (KD124209171220.ppp-bb.dion.ne.jp. [124.209.171.220])
        by smtp.gmail.com with ESMTPSA id ck11-20020a17090afe0b00b0028593e9eaadsm1433594pjb.31.2023.12.01.07.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 07:28:27 -0800 (PST)
Date: Sat, 2 Dec 2023 00:28:22 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Jens Axboe <axboe@kernel.dk>, Dongyun Liu <dongyun.liu3@gmail.com>
Cc: minchan@kernel.org, senozhatsky@chromium.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	lincheng.yang@transsion.com, jiajun.ling@transsion.com,
	ldys2014@foxmail.com, Dongyun Liu <dongyun.liu@transsion.com>
Subject: Re: [PATCH] zram: Using GFP_ATOMIC instead of GFP_KERNEL to allocate
 bitmap memory in backing_dev_store
Message-ID: <20231201152822.GA404241@google.com>
References: <20231130152047.200169-1-dongyun.liu@transsion.com>
 <feb0a163-c1d3-4087-96dc-f64d0dde235b@kernel.dk>
 <3af0752f-0534-43c4-913f-4d4df8c8501b@gmail.com>
 <b26ab8d0-c719-4bf6-b909-26f4c014574b@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b26ab8d0-c719-4bf6-b909-26f4c014574b@kernel.dk>

On (23/12/01 07:19), Jens Axboe wrote:
> >> IOW, you have a slew of GFP_KERNEL allocations in there, and you
> >> probably just patched the largest one. But the core issue remains.
> >>
> >> The whole handling of backing_dev_store() looks pretty broken.
> >>
> > 
> > Indeed, this patch only solves the biggest problem and does not
> > fundamentally solve it, because there are many processes for holding
> > zram->init_lock before allocation memory in backing_dev_store that
> > need to be fully modified, and I did not consider it thoroughly.
> > Obviously, a larger and better patch is needed to eliminate this risk,
> > but it is currently not necessary.
> 
> You agree that it doesn't fix the issue, it just happens to fix the one
> that you hit. And then you jump to the conclusion that this is all
> that's needed to fix it. Ehm, confused?

Yeah.

zram is very sensitive to memory - zsmalloc pool needs physical pages
(allocated on demand) to keep data written to zram. zram probably simply
should not be used on systems under such heavy memory pressure. Throwing
GPF_ATOMICs at zram isn't going to fix anything.

Jens, you said that zram's backing device handling is broken. Got a minute
to elaborate?
