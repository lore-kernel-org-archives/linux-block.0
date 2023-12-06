Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IEgt7kxq"
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F9C109
	for <linux-block@vger.kernel.org>; Wed,  6 Dec 2023 01:53:18 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1d053c45897so47495825ad.2
        for <linux-block@vger.kernel.org>; Wed, 06 Dec 2023 01:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701856398; x=1702461198; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P3PUdeMTp59iLacU8h6b17A8a616BgKJZLMgjfjDCJ8=;
        b=IEgt7kxqxbqo/TBZoiA+nRtGnEoiS3Tlkls62oS9wXXh/R6yP/g/WSbLenC4PYrZQZ
         6UXMBV83QIHOe4WMikjMiVAnBDUIPFOvJmH5lo6gjUwMCuocGdm4dER7Bfv7gQMTpO53
         q6mwpjTcpdUPRfgnyoBvcgYooNFDJ//XDav30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701856398; x=1702461198;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P3PUdeMTp59iLacU8h6b17A8a616BgKJZLMgjfjDCJ8=;
        b=oAs9gvpqxV1c6uMLHCeanHyVlaeLgmoxgBkWq60qwQxMaZYeeftzBCpvcu22uVWgMd
         ujAzVflF8giJvbKKArsYLzakb2AdbwH/Ex4lT+LOzra6yA5PGXPl821UlYihJ2ZvjVrv
         /wZZbADfyjbcBV8CC0z3DzpAO+Hc9/M2zLpDUYFxaEn/fOZAoAr+ZtPuC+BAr7oqLhup
         tP1Ke+hA3Z9JRAQca1/g6BkyexH7+3F6agxmh8I3ex2M0g46EIRjUPZM1AhOCc2KNTxf
         iCUN4Gj4wxX+7vEiXRZd1VM2t4KtaPgih/KdgVREau6tPNoFL3HQob/9YuZv+Mbajvla
         cBjg==
X-Gm-Message-State: AOJu0YwuvROXlhka/A8OAgC1Zwgol1juKBUq22+geakVTSkPa89+Sox3
	OXj1BCS0TLQ655w6D+aC3SQGVA==
X-Google-Smtp-Source: AGHT+IENFyDVZppLzGhHMaJfmkH9S35XgHAMM7k7iWJLU/LdoSeCM37CpI1va9qGVzPeXWiqg4Zlgg==
X-Received: by 2002:a17:903:22cf:b0:1d0:4d29:59fe with SMTP id y15-20020a17090322cf00b001d04d2959femr692480plg.11.1701856397742;
        Wed, 06 Dec 2023 01:53:17 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:95bb:1e40:3d62:d431])
        by smtp.gmail.com with ESMTPSA id i4-20020a17090332c400b001d071d58e85sm7869159plr.98.2023.12.06.01.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 01:53:17 -0800 (PST)
Date: Wed, 6 Dec 2023 18:53:12 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Dongyun Liu <dongyun.liu3@gmail.com>, minchan@kernel.org,
	senozhatsky@chromium.org, axboe@kernel.dk,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	lincheng.yang@transsion.com, jiajun.ling@transsion.com,
	ldys2014@foxmail.com, Dongyun Liu <dongyun.liu@transsion.com>
Subject: Re: [PATCH] zram: Using GFP_ATOMIC instead of GFP_KERNEL to allocate
 bitmap memory in backing_dev_store (fwd)
Message-ID: <20231206095312.GA333238@google.com>
References: <8bb6e568-1c79-6410-5893-781621b71331@inria.fr>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8bb6e568-1c79-6410-5893-781621b71331@inria.fr>

Hi,

On (23/12/06 10:33), Julia Lawall wrote:
> Hello,
> 
> The warning is because kvfree is used to free memory that was allocated
> using kmalloc; kfree would be fine.  But I think that the only way you can
> get to out is with bitmap being NULL, so there is no need to free it at
> all.
> 
> Furthermore, it could be safer in the long term to use different labels
> for the different amounts of things that need to be freed, as done in most
> other kernel code, rather than using a single label "out".

[..]

> Date: Wed, 6 Dec 2023 16:08:49 +0800
> From: kernel test robot <lkp@intel.com>
> To: oe-kbuild@lists.linux.dev
> Cc: lkp@intel.com, Julia Lawall <julia.lawall@inria.fr>
> Subject: Re: [PATCH] zram: Using GFP_ATOMIC instead of GFP_KERNEL to allocate
>     bitmap memory in backing_dev_store
> 
> BCC: lkp@intel.com
> CC: oe-kbuild-all@lists.linux.dev
> In-Reply-To: <20231130152047.200169-1-dongyun.liu@transsion.com>
> References: <20231130152047.200169-1-dongyun.liu@transsion.com>
> TO: Dongyun Liu <dongyun.liu3@gmail.com>
> TO: minchan@kernel.org
> TO: senozhatsky@chromium.org
> TO: axboe@kernel.dk
> CC: linux-kernel@vger.kernel.org
> CC: linux-block@vger.kernel.org
> CC: lincheng.yang@transsion.com
> CC: jiajun.ling@transsion.com
> CC: ldys2014@foxmail.com
> CC: Dongyun Liu <dongyun.liu@transsion.com>
> 
> Hi Dongyun,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on axboe-block/for-next]
> [also build test WARNING on linus/master v6.7-rc4 next-20231206]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Dongyun-Liu/zram-Using-GFP_ATOMIC-instead-of-GFP_KERNEL-to-allocate-bitmap-memory-in-backing_dev_store/20231130-233042
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
> patch link:    https://lore.kernel.org/r/20231130152047.200169-1-dongyun.liu%40transsion.com
> patch subject: [PATCH] zram: Using GFP_ATOMIC instead of GFP_KERNEL to allocate bitmap memory in backing_dev_store

This patch won't land upstream. It was NAK-ed.
