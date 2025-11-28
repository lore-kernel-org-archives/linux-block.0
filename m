Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A6D2737EE
	for <linux-block@vger.kernel.org>; Fri, 28 Nov 2025 06:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764310563; cv=none; b=JZ3VRi778PVxq/sguzdkKHRq8IdAVkQoxCoUxz7PSNcZatL5GCjilv2cpSThb0T0c7Ka0cBzx7Zr9tR3pFI4MetN8N1Q2NEqYiD3bFzpIIkklJVTO1/yqcJvbuYGt4OIF2uCeY9vgozJCYieqzxT4UcONCxNSnhwtgiCRYfrhYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764310563; c=relaxed/simple;
	bh=ffhTyij1ReNQCxTshYxvVfuBAAWHI7lGZdQHx3iN9O4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=tKn6SUnxXEAvG5TqPGayQIhg0trr9b273kTT2Bv+aU5JyBA+EHvpJCg8AypAIkKb9y5XlCGfri09u7BPKnoSc5TOFb93Awv2p4/vLbUX6yz6qMFrI0AgsjhTmffprvXyYcQRRzRvwOKBpjCbz8X03xj3T0sj3CrqKK+bSR/VcIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v5eolzbb; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v5eolzbb"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4777771ed1aso8369595e9.2
        for <linux-block@vger.kernel.org>; Thu, 27 Nov 2025 22:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764310559; x=1764915359; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GzOlZeoUbK5GrmA6UDcAo/pAL66N5+Wh7nDV2nIjmh4=;
        b=v5eolzbbOk5WQGVqcVhhKAE2ML7DKdAh/Y+Wzg3EpfH3QU6dopuXxSSdPNwhKKnrJu
         qltMnuRT+OEYlSZ3114IcYr4STkDIpuPI3c1XbS/x/eoGAGtMbjF7PdL7hAa4NDI4ox0
         E27hPv5ozzuMvJsthSqjuDIJK0/T3M6CfrbZ7/47N+n1vE0d3+tim2XruDL3IYZcjlkN
         05zLZsyJxpArs9206Al85zfLqcxE40QDpecVHwWCc9ZzRTWDEIMr9FUSn/L2xtJVmken
         +Yxg7ypY92yPpUCXhcLtBph41jzUAUfeMAPVAWpjPIq5fSAZSXDrD7BCixo78y01on5+
         L+Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764310559; x=1764915359;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GzOlZeoUbK5GrmA6UDcAo/pAL66N5+Wh7nDV2nIjmh4=;
        b=h1MAEOybM+/t8ywlJu/11wNFrWQj3t8OBJejhHyCukzJ18R+I6GOtLAz6QyUwKHMC4
         RzxtV9Qsv0RKg2JdnJ96iv0SUESM+TvAlOxlBgdXxOooT8YiacbAp9ZCMdLR+2SKAgWe
         /PftezyLL3+qGeQVWJCY/T4T39fkCTZwKTpMx69LN5PC+er0uRAoFtZG8vezvoU1EdlG
         22ZGfKYHtON/i3Fd25cdrA+w50vp8WjeP1xA8aOkutrG8pjz6s4Dxtpe+6j9kRL3dHVQ
         Mv3iMUPu7FY2gFBZyaHrYC0b8iW6z3Q1koKYw2fjLGRk5BjbRrktlxhYHbBQ4fypBD8p
         IB4g==
X-Forwarded-Encrypted: i=1; AJvYcCV0xyqKH21v3zP3PvHmK2B1BjffDZT7VYnhd0XJ3o4iISABVegFTffqC/Qpf/R19Z9Lji3dE9Ma6Bxvzg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6vDUTu7iqzD5x8vp9IG7zz6ohzaT+8cVvRsmBAl6bZVaL0Zoc
	aQcmp4k0XmcYA8jJ2WnPHcds0taQrOqkUnETn0F6gM/cmV0n9pn1vE6KjxpX2TX3iFA=
X-Gm-Gg: ASbGncsoGZZ+jjDQbP3+qYJEKvnKctotGpT6LVyv67JgkepuKzLXx6hXOkDGS7wMWWL
	8/8qHw/U1k3OV4S4MaIT9z5xpYW+98HUWtT59PnNJaKYE0oUFlUnN0tuQSBSKCeC51aaFpCpBtR
	kpZVUCkGYc9cIoG8luChy0o+S1xNSmFm9aFcsbsbD1XQOYMVfapjBKNdJRpJLrKTV0SKWZk0XAS
	NQPfBNgEFnHfum0TCyiXKgNhBFt9VuTXCiBRTSbbaRAj7pTyF9u5UTYwjTWJutVE4A1az6Xaz48
	trVRYyjxLY8Heg0w1r8L+7+DNvmt0W+A6k6oxgoq0bLuEuilHiVOU4am/f8gvU8EQ/wrgMEzRBO
	QFGa0LvQSRGk75N7iIMp6k81wn2q6g7GE44EDF95kkmWLarwEOBmyfbxeH5MIkBI8VtniR8y8vG
	b7I3LnieB0Z57TaNVP
X-Google-Smtp-Source: AGHT+IFdIuL1+ag2sXfLUM/g00Zb6LkyXzXLVWwOpnWTkJoN0WxuvEW4Ox+Z1MnircVKNp0kAljDVQ==
X-Received: by 2002:a05:600c:1c85:b0:471:9da:524c with SMTP id 5b1f17b1804b1-477c016eab5mr306888745e9.12.1764310558915;
        Thu, 27 Nov 2025 22:15:58 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-479040d81e4sm88057735e9.3.2025.11.27.22.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 22:15:58 -0800 (PST)
Date: Fri, 28 Nov 2025 09:15:54 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Keith Busch <kbusch@meta.com>,
	dm-devel@lists.linux.dev, linux-block@vger.kernel.org,
	snitzer@kernel.org, hch@lst.de, axboe@kernel.dk,
	ebiggers@kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 3/3] dm-crypt: dynamic scatterlist for many segments
Message-ID: <202511281018.FNOzcP4r-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251124170903.3931792-4-kbusch@meta.com>

Hi Keith,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Keith-Busch/block-remove-stacking-default-dma_alignment/20251125-051340
base:   https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git for-next
patch link:    https://lore.kernel.org/r/20251124170903.3931792-4-kbusch%40meta.com
patch subject: [PATCHv2 3/3] dm-crypt: dynamic scatterlist for many segments
config: i386-randconfig-141-20251127 (https://download.01.org/0day-ci/archive/20251128/202511281018.FNOzcP4r-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202511281018.FNOzcP4r-lkp@intel.com/

New smatch warnings:
drivers/md/dm-crypt.c:1510 crypt_convert_block_skcipher() warn: was || intended here instead of &&?

vim +1510 drivers/md/dm-crypt.c

8f0009a225171c Milan Broz        2017-03-16  1499  	skcipher_request_set_crypt(req, sg_in, sg_out, cc->sector_size, iv);
3a7f6c990ad04e Milan Broz        2008-02-08  1500  
3a7f6c990ad04e Milan Broz        2008-02-08  1501  	if (bio_data_dir(ctx->bio_in) == WRITE)
bbdb23b5d69521 Herbert Xu        2016-01-24  1502  		r = crypto_skcipher_encrypt(req);
3a7f6c990ad04e Milan Broz        2008-02-08  1503  	else
bbdb23b5d69521 Herbert Xu        2016-01-24  1504  		r = crypto_skcipher_decrypt(req);
3a7f6c990ad04e Milan Broz        2008-02-08  1505  
2dc5327d3acb33 Milan Broz        2011-01-13  1506  	if (!r && cc->iv_gen_ops && cc->iv_gen_ops->post)
ef43aa38063a6b Milan Broz        2017-01-04  1507  		r = cc->iv_gen_ops->post(cc, org_iv, dmreq);
ef43aa38063a6b Milan Broz        2017-01-04  1508  
02664d2ac0d3cf Keith Busch       2025-11-24  1509  out:
02664d2ac0d3cf Keith Busch       2025-11-24 @1510  	if (r == -EINPROGRESS && r == -EBUSY) {
                                                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Presumably || was intended as the warning suggests since it can't be
both.

02664d2ac0d3cf Keith Busch       2025-11-24  1511  		kfree(dmreq->__sg_in);
02664d2ac0d3cf Keith Busch       2025-11-24  1512  		kfree(dmreq->__sg_out);
02664d2ac0d3cf Keith Busch       2025-11-24  1513  		dmreq->__sg_in = NULL;
02664d2ac0d3cf Keith Busch       2025-11-24  1514  		dmreq->__sg_out = NULL;
02664d2ac0d3cf Keith Busch       2025-11-24  1515  	}
3a7f6c990ad04e Milan Broz        2008-02-08  1516  	return r;
01482b7671d014 Milan Broz        2008-02-08  1517  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

