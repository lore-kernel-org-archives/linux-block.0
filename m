Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB7D1400C
	for <linux-block@vger.kernel.org>; Thu, 20 Nov 2025 07:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763623158; cv=none; b=oQScLxb9KKDWgJF/+pYrlayLUoCYB8iAbJM7CwK7Z4LRpmUiY5/4amk1owloZoWbBtWgrP01WSd4+qD/cvp6gITJ3726pLiJIoA2w8BjrJv/geqYy67gVIvpmvjGrDAzwVqIXTvD16GWYa0UlakvglptwmbSgAU251ZYaQa4jM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763623158; c=relaxed/simple;
	bh=2MTAVt4Vs/5kahRIGfdKJMaylvojcWZcPLsfV7HtepY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EKsJuO73BzkejjFXYfCkwYZB4JHcdMrTNnZIBRipHIN8xqWFMPoxPJCrjNRPEtu7dYU9V+z8Rt85mERXRgU/rFH/YuA2Lx8B5mFyUrL49DiatKbMyj5SLppJWOrSmMxdM+nJcm3V40D16IHTRJpqthBMfgcTor9LNWZg/FsZMfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SUAmBfxn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Acgtq67/; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=p7gD8KLp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TsF29wb1; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SUAmBfxn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Acgtq67/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="p7gD8KLp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TsF29wb1"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EEE29208D6;
	Thu, 20 Nov 2025 07:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763623155; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CuKKhZfk5lxgY/i5gMcMrZ9RyF6a1xLJU8WklRC0QBg=;
	b=SUAmBfxnus2LgnDxZwk+A7x4BEfOraLhDswikUYJOfH9nL7NL0bRs7Vs55m7dGhZoLae0s
	NlEyDfKeBUaOKjwpbgu/fJYCHjZwfhKcfA4rjfupBc/b/oz3CtfoMYjm1pZfEvs/7tNh3h
	I18PyC7tJM5pGan1FM36Npk3g3fT00o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763623155;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CuKKhZfk5lxgY/i5gMcMrZ9RyF6a1xLJU8WklRC0QBg=;
	b=Acgtq67/MPr/VY6kuTYQuox9Yvv9RnInP1OWCtW5mFjGdrwVtY8IPt9HxhB5XcsFM5Mn6f
	5HQyKIH08dsel5CQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763623154; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CuKKhZfk5lxgY/i5gMcMrZ9RyF6a1xLJU8WklRC0QBg=;
	b=p7gD8KLpuW2wdFvBBbwgB0Ug1UIhEhBmkpQOqGKaXTfNtFj8NnjYqT07kd3vPQTU/eiKN8
	aJ+GQEclne1LpuyvVFU1/aZchAjhPx/PA1nado//ibM5BOd7qz2edtSBDa6Uyh+9piy/ex
	1+/2VCS+B08NQsQCS1ODfm8g6BzqKzY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763623154;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CuKKhZfk5lxgY/i5gMcMrZ9RyF6a1xLJU8WklRC0QBg=;
	b=TsF29wb1c6DVJYSAH3zLmptfcIjjWTBElQxV5iyepuS+pwGUexxcT3gbGS6uPS9XQg3K2N
	53aMV39/S+MJ7iAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CA5123EA61;
	Thu, 20 Nov 2025 07:19:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vOKCL/LAHmnYIwAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 20 Nov 2025 07:19:14 +0000
Message-ID: <43b4daba-3bc3-4b37-8464-324792c8b4de@suse.de>
Date: Thu, 20 Nov 2025 08:19:14 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests] scsi/004: add SCSI_PROC_FS requirement
To: Li Zhijian <lizhijian@fujitsu.com>, linux-block@vger.kernel.org
Cc: shinichiro.kawasaki@wdc.com
References: <20251120012731.3850987-1-lizhijian@fujitsu.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251120012731.3850987-1-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 

On 11/20/25 02:27, Li Zhijian wrote:
> This test will queries message from /proc/scsi/scsi_debug/<num> which
> relies on the kernel option SCSI_PROC_FS
> 
> Prevent the following error report:
> scsi/004 (ensure repeated TASK SET FULL results in EIO on timing out command) [failed]
>      runtime  1.743s  ...  1.935s
>      --- tests/scsi/004.out      2025-04-04 04:36:43.171999880 +0800
>      +++ /root/blktests/results/nodev/scsi/004.out.bad   2025-11-13 12:46:33.807994845 +0800
>      @@ -1,3 +1,4 @@
>       Running scsi/004
>       Input/output error
>      +grep: /proc/scsi/scsi_debug/0: No such file or directory
>       Test complete
> 
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>   tests/scsi/004 | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tests/scsi/004 b/tests/scsi/004
> index 7d0af54..fd4cfb0 100755
> --- a/tests/scsi/004
> +++ b/tests/scsi/004
> @@ -19,6 +19,7 @@ CAN_BE_ZONED=1
>   
>   requires() {
>   	_have_scsi_debug
> +	_have_kernel_option SCSI_PROC_FS
>   }
>   
>   test() {

Please, don't.

SCSI_PROC_FS has been deprecated for ages;
all in information should be available in sysfs.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
