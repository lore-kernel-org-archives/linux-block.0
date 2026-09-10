Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C89A4A8A3F;
	Thu, 10 Sep 2026 16:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789059160; cv=none; b=YErJaJF/DuxsJWd6AkJMWRmT84rEKTDIyfwHljHtlYlDdBQHeVasusmM5kM1G3mP7iH38AKZh8nU0AG8VUnEkFj0KiRLkzm5ySxvOuMbzoA94/cXverX7AMBWOYUIu2abg49cnx5XbqUPdVXMCZ0YA88c+Jl3AyDpCvyyPj5VCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789059160; c=relaxed/simple;
	bh=fSYGuunbzZ4i4xCxug8U7PKL0xZovIOy4VVReg+zoQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QohKFEcFHJFz0sriYTbkhAoC+Hqk7WzLVmLnyksAJ7CC2ZvV4RCg46cQdekSYy2IlHZ2Cv0TiJ+q5dH5VpbH3NCs0NGmNFc7yzsykTmHVSPcb9vAKiFVnXLNsbImyyfMo/TmWgbIHGaRNTIp8uCjqBWgqqZ29ZGBv25+8tLd7Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=s/I2dT8q; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iRmjXzS4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=B7YOWDK9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+K1KsJ44; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="s/I2dT8q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iRmjXzS4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="B7YOWDK9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+K1KsJ44"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7E69B21B4D;
	Thu, 10 Sep 2026 16:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789059148; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bPNwGzD19Yd8NTGm2yZRzQmdff/uYw4ynY7Z4lTx+uY=;
	b=s/I2dT8qni8fUFZMuhcUU5FG2aoPeKP2L5jArvIiPbExHEggzFRQGZPgL1HNpa4I0ZlyNv
	+akAyOIk4x+TR/4LVVgIQPwQR957DS6QqtIEpABqQ+/Z1HRxwAfgIiWN9MEUk0x4ghdAYA
	aCCLc96ePQO1OVHDj8hn6ascwxyhe3w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789059148;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bPNwGzD19Yd8NTGm2yZRzQmdff/uYw4ynY7Z4lTx+uY=;
	b=iRmjXzS4BazWV17voQDGUP0M7U9377Bzr70iX+bWLRIBZJVgXUjEZ5qOBHqrFbtYPJSvW9
	mJaSbn+p+tv+KBDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789059144; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bPNwGzD19Yd8NTGm2yZRzQmdff/uYw4ynY7Z4lTx+uY=;
	b=B7YOWDK90eR033QXrNnYSuCYRJN8DArVVOK/vBPr6mNsYzyNMk5DZRmwsy/DSRbuRWPC9I
	GbNKzTzNAKWZAiM5gqg1xmXcug+T3Ifb86LquVlV+TTvqlpMXxAIvCB2ESGCPSQqIM27wu
	3kbTvCON4sbbprPDTlPmfbbobGo9k4g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789059144;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bPNwGzD19Yd8NTGm2yZRzQmdff/uYw4ynY7Z4lTx+uY=;
	b=+K1KsJ44jKmWKd+mW6ClzeMLIxtEMc4QuBoin8T2PluVCvinkg++wW9rtl9pudHgJ1WPas
	/2hqoHUctWd5wzCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 49D4913180;
	Thu, 10 Sep 2026 16:52:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dJEAEkjgomqZaAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 10 Sep 2026 16:52:24 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BEB9AA12EA; Thu, 10 Sep 2026 18:52:23 +0200 (CEST)
Date: Thu, 10 Sep 2026 18:52:23 +0200
From: Jan Kara <jack@suse.cz>
To: Julian Sun <sunjunchao@bytedance.com>
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	gfs2@lists.linux.dev, linux-security-module@vger.kernel.org, jack@suse.cz, 
	agruenba@redhat.com, mic@digikod.net, gnoack@google.com, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, aleksa@amutable.com, legion@kernel.org, 
	djwong@kernel.org, ebiggers@kernel.org, sandeen@redhat.com
Subject: Re: [PATCH 1/7] fs: remove trailing whitespace from
 include/linux/fs.h
Message-ID: <nsy6xdkwzcnl3qezgyug2mnv2ng5744rt2466ua5du3tonrxon@uj6fb4oqri25>
References: <20260909090112.790006-1-sunjunchao@bytedance.com>
 <20260909090112.790006-2-sunjunchao@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909090112.790006-2-sunjunchao@bytedance.com>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.com:email,bytedance.com:email]
X-Spam-Flag: NO

On Wed 09-09-26 17:01:06, Julian Sun wrote:
> Remove trailing whitespace before introducing the inode iterator API.
> This avoids unrelated whitespace changes from automatic editor cleanup
> in the following patches. This also fixes formatting issues in fs.h
> reported by scripts/checkpatch.pl.
> 
> Signed-off-by: Julian Sun <sunjunchao@bytedance.com>

We generally try to avoid whitespace only or style only changes as they
hurt backportability mostly unnecessarily. But this patch looks harmless
enough so feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/fs.h | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index f9d1e05e8ae6..09c4db5e9ae0 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -296,7 +296,7 @@ struct iattr {
>   */
>  #define FILESYSTEM_MAX_STACK_DEPTH 2
>  
> -/** 
> +/**
>   * enum positive_aop_returns - aop return codes with specific semantics
>   *
>   * @AOP_WRITEPAGE_ACTIVATE: Informs the caller that page writeback has
> @@ -306,7 +306,7 @@ struct iattr {
>   * 			    be a candidate for writeback again in the near
>   * 			    future.  Other callers must be careful to unlock
>   * 			    the page if they get this return.  Returned by
> - * 			    writepage(); 
> + *			    writepage();
>   *
>   * @AOP_TRUNCATED_PAGE: The AOP method that was handed a locked page has
>   *  			unlocked it and the page might have been truncated.
> @@ -1315,8 +1315,10 @@ struct file *get_file_active(struct file **f);
>  
>  #define	MAX_NON_LFS	((1UL<<31) - 1)
>  
> -/* Page cache limit. The filesystems should put that into their s_maxbytes 
> -   limits, otherwise bad things can happen in VM. */ 
> +/*
> + * Page cache limit. The filesystems should put that into their s_maxbytes
> + * limits, otherwise bad things can happen in VM.
> + */
>  #if BITS_PER_LONG==32
>  #define MAX_LFS_FILESIZE	((loff_t)ULONG_MAX << PAGE_SHIFT)
>  #elif BITS_PER_LONG==64
> @@ -2285,7 +2287,7 @@ int sync_inode_metadata(struct inode *inode, int wait);
>  struct file_system_type {
>  	const char *name;
>  	int fs_flags;
> -#define FS_REQUIRES_DEV		1 
> +#define FS_REQUIRES_DEV		1
>  #define FS_BINARY_MOUNTDATA	2
>  #define FS_HAS_SUBTYPE		4
>  #define FS_USERNS_MOUNT		8	/* Can be mounted by userns root */
> @@ -2907,7 +2909,7 @@ ssize_t __kernel_read(struct file *file, void *buf, size_t count, loff_t *pos);
>  extern ssize_t kernel_write(struct file *, const void *, size_t, loff_t *);
>  extern ssize_t __kernel_write(struct file *, const void *, size_t, loff_t *);
>  extern struct file * open_exec(const char *);
> - 
> +
>  /* fs/dcache.c -- generic fs support functions */
>  extern bool is_subdir(struct dentry *, struct dentry *);
>  extern bool path_is_under(const struct path *, const struct path *);
> -- 
> 2.39.5
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
