Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256851C9B84
	for <linux-block@vger.kernel.org>; Tue,  1 Oct 2024 16:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727800071; cv=none; b=HkFLKXSL6dNPdcTXIeRqzzqDngfRogxCG3JSwTy6Soz74QzriT85i606yc6m3K5ZvKVaw/N9ozeCuRlA8PtmTs0477lnWdIa2JCt+YzGGEGmK6/mpW/t0AzqZ1ezdnmVTVH1ANDlttS5dmDIGN5jGUfp7cwcj+yyAmy/iO3YwcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727800071; c=relaxed/simple;
	bh=Ce9bpFraW1bYv07TurFUqTAxG9NQzgWtdVxdYhY+vPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QZHzzxScB+vSAm8k+EfPBphBMM3WzAwZcvNQgZiUKH6gxrwgsqDnwRTEgyBXl8j9+D5x97+79YbbYsBGMSwNCYrmlMSaCBJBhwjpMh27TVG/yJLWY9ARvAuyUENU/g0R8eI/rBk+8OD8CNmsxnn+zxcOILmWs1HZj0RPxwK+fk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NNGXPewv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ltzNxVRk; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NNGXPewv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ltzNxVRk; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NNGXPewv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ltzNxVRk";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NNGXPewv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ltzNxVRk"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6969F21B52;
	Tue,  1 Oct 2024 16:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727800068; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TnUobPlKy1NZWZZQ4Zh+O8yWLp+TDg2iNuddZ1NE3vY=;
	b=NNGXPewvnM8TSv0Hpk2dycv8V94DKwkIcznu5vz2R8PTwpic7Q4UVPK3uhXiQK/KeLcbN3
	NlnrohPVd6SUXLK1Z/sp07BmnZHp8HRqU+/gjrDmwohSE+aT4bsUEdfTxDPMGjIJ3/oeWE
	RH1z2g9wmzcYtjvs3Igs738fLQNxBxI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727800068;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TnUobPlKy1NZWZZQ4Zh+O8yWLp+TDg2iNuddZ1NE3vY=;
	b=ltzNxVRkgIjfK3b71A0U8qgCVtVF0GxGeEdEJ3xi04yS1YXD+lwMCmCm9wRcw7ewj49mug
	Bb2U67mAoK5V+9CQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727800068; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TnUobPlKy1NZWZZQ4Zh+O8yWLp+TDg2iNuddZ1NE3vY=;
	b=NNGXPewvnM8TSv0Hpk2dycv8V94DKwkIcznu5vz2R8PTwpic7Q4UVPK3uhXiQK/KeLcbN3
	NlnrohPVd6SUXLK1Z/sp07BmnZHp8HRqU+/gjrDmwohSE+aT4bsUEdfTxDPMGjIJ3/oeWE
	RH1z2g9wmzcYtjvs3Igs738fLQNxBxI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727800068;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TnUobPlKy1NZWZZQ4Zh+O8yWLp+TDg2iNuddZ1NE3vY=;
	b=ltzNxVRkgIjfK3b71A0U8qgCVtVF0GxGeEdEJ3xi04yS1YXD+lwMCmCm9wRcw7ewj49mug
	Bb2U67mAoK5V+9CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 448F813A6E;
	Tue,  1 Oct 2024 16:27:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VU/4DwQj/GZiRgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 01 Oct 2024 16:27:48 +0000
Message-ID: <5da1dc60-8392-47d5-8521-fe3a7b830369@suse.cz>
Date: Tue, 1 Oct 2024 18:27:47 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm, slab: fix use of SLAB_SUPPORTS_SYSFS in
 kmem_cache_release()
Content-Language: en-US
To: Nilay Shroff <nilay@linux.ibm.com>, linux-mm@kvack.org,
 linux-block@vger.kernel.org
Cc: akpm@linux-foundation.org, cl@linux.com, penberg@kernel.org,
 rientjes@google.com, iamjoonsoo.kim@lge.com, roman.gushchin@linux.dev,
 42.hyeyoo@gmail.com, yi.zhang@redhat.com, shinichiro.kawasaki@wdc.com,
 axboe@kernel.dk, gjoyce@linux.ibm.com
References: <20241001140245.306087-1-nilay@linux.ibm.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20241001140245.306087-1-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,linux.com,kernel.org,google.com,lge.com,linux.dev,gmail.com,redhat.com,wdc.com,kernel.dk,linux.ibm.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -2.80
X-Spam-Flag: NO

On 10/1/24 16:02, Nilay Shroff wrote:
> The fix implemented in commit 4ec10268ed98 ("mm, slab: unlink slabinfo,
> sysfs and debugfs immediately") caused a subtle side effect due to which
> while destroying the kmem cache, the code path would never get into
> sysfs_slab_release() function even though SLAB_SUPPORTS_SYSFS is defined
> and slab state is FULL. Due to this side effect, we would never release
> kobject defined for kmem cache and leak the associated memory.
> 
> The issue here's with the use of __is_defined() macro in kmem_cache_
> release(). The __is_defined() macro expands to __take_second_arg(
> arg1_or_junk 1, 0). If "arg1_or_junk" is defined to 1 then it expands to
> __take_second_arg(0, 1, 0) and returns 1. If "arg1_or_junk" is NOT defined
> to any value then it expands to __take_second_arg(... 1, 0) and returns 0.
> 
> In this particular issue, SLAB_SUPPORTS_SYSFS is defined without any
> associated value and that causes __is_defined(SLAB_SUPPORTS_SYSFS) to
> always evaluate to 0 and hence it would never invoke sysfs_slab_release().
> 
> This patch helps fix this issue by defining SLAB_SUPPORTS_SYSFS to 1.
> 
> Fixes: 4ec10268ed98 ("mm, slab: unlink slabinfo, sysfs and debugfs immediately")
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Closes: https://lore.kernel.org/all/CAHj4cs9YCCcfmdxN43-9H3HnTYQsRtTYw1Kzq-L468GfLKAENA@mail.gmail.com/
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>

Added to slab/for-next, thanks!

> ---
>  mm/slab.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/slab.h b/mm/slab.h
> index f22fb760b286..3e0a08ea4c42 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -310,7 +310,7 @@ struct kmem_cache {
>  };
>  
>  #if defined(CONFIG_SYSFS) && !defined(CONFIG_SLUB_TINY)
> -#define SLAB_SUPPORTS_SYSFS
> +#define SLAB_SUPPORTS_SYSFS 1
>  void sysfs_slab_unlink(struct kmem_cache *s);
>  void sysfs_slab_release(struct kmem_cache *s);
>  #else

