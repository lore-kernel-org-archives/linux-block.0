Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC18A3B960B;
	Thu, 28 May 2026 11:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779968301; cv=none; b=r2oRBKc1SAzVVrvXhRShOeA4sWdV0/Us/XkkfH39PofYSH8jLKAE4KWN4S4Z4IrU8ectQuz6JtDs2i7MrUZT++/jR5K7uf6MdEbAgNQn5Qv9LvinbRkLG9AIwyWqobFrHQvhWuo2IBx6DhGt4Y6bsDJqQHfrVQ0JW56VEKKudas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779968301; c=relaxed/simple;
	bh=KhE1Yu4LeiAbzCoLCPQpLigOWaCJPDOgM7r1xhitTF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vg7bMBOJOFKHa3D5Dl6yhdSaGaWhtmCCswxcLA1uKeG+FkSONawqsVVETGZw+VFDJLVZT4k5mTw+dhJRwY/VHL5uDFfyezGboTfvb3skECd1wJauiGOR6C8X0sLdMUsGExAdHr9iUc3Pp6VlhMMsopapAlBvAviqKf3fd+OTavI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 64SBc2Qd056907;
	Thu, 28 May 2026 20:38:02 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.5] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 64SBc2xI056902
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 28 May 2026 20:38:02 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <880665ec-3001-45bd-b97c-b49308cb6237@I-love.SAKURA.ne.jp>
Date: Thu, 28 May 2026 20:38:01 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linux-next:master] [block] 73cf422c6a: EIP:look_up_lock_class
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-block@vger.kernel.org
References: <202605281444.29e7f79b-lkp@intel.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <202605281444.29e7f79b-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav105.rs.sakura.ne.jp
X-Virus-Status: clean

On 2026/05/28 16:05, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "EIP:look_up_lock_class" on:
> 
> commit: 73cf422c6afb067b7e5d395dae8c44e076a00ebb ("block: assign caller-specific lockdep class to disk->open_mutex")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> [test failed on linux-next/master e7d700e14934e68f86338c5610cf2ae76798b663]

Thank you. Fixed in https://sourceforge.net/p/tomoyo/tomoyo.git/ci/c2245c765ebeba9dcb924d9171d8d470a9ac41c8/ .

