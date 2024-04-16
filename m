Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5478F43AA5
	for <linux-block@vger.kernel.org>; Tue, 16 Apr 2024 16:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713284632; cv=none; b=IFKTvdySiqcOVkqN01S7dnH2rnn0oe1i+64M5TlSscXaCrsl8i/qzbcBT6W8gDqvSg5YG3BfQekK/WuZOJq+18ygKUkbmmzkk9HF7p7wc93Bnqpy1vcSS43c4eXxeXJ/ACSciM4BTH+W6Y8Wxr0mTxPwg2Oe+nbkvqq1QrGHwx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713284632; c=relaxed/simple;
	bh=g1ATJA9fNgC3nr4IYTAWmsjkvmt9hxDGyBHXwgt/TvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ti7ogdZdz2A+LmkjJpAXbgTbhTFau1Wvn3nBkCkIlJd71OAt/13Ha0JRNWcilEpprN4vEQZHOekv0vnfqlOqx3Rb6uxpOHrSUC7vVCNGqqxob+KOesVlm3TwOtP25vYITCfAx2FHPVpjOAMZgiuDduFzyknxRitSDCktXMm8jH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Fa+6uOED; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fNCg/DZe; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Fa+6uOED; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fNCg/DZe; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Fa+6uOED";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fNCg/DZe";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Fa+6uOED";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fNCg/DZe"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 43BAD5D1A2;
	Tue, 16 Apr 2024 16:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713284628; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QPYJiiry+coQMfwqR6VYFAm42kJ8iAkPrnvOrpNcpVQ=;
	b=Fa+6uOEDIuaUdLhs2kmh33zXHd8dVYDq0tXVjMYWbPf0CehwvlCc/NrQHWfxwsA8pmFdjS
	Jy1aRSe1YqiX5skeQHc3zwksBEW9a/L5h9b/zq1+NnFn98t5hfdVskShcz+UW6kXuJQzCN
	4Up5EJ3ansXEbJrD5t5A6WizielhWIs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713284628;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QPYJiiry+coQMfwqR6VYFAm42kJ8iAkPrnvOrpNcpVQ=;
	b=fNCg/DZe3XGUwsGcvjYg57LFfba7C3tMbgJS+dllSHedc7yLZmmasMGgIiKYdytEu1Qzb5
	PApYEKHUqnS9xtCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Fa+6uOED;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="fNCg/DZe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713284628; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QPYJiiry+coQMfwqR6VYFAm42kJ8iAkPrnvOrpNcpVQ=;
	b=Fa+6uOEDIuaUdLhs2kmh33zXHd8dVYDq0tXVjMYWbPf0CehwvlCc/NrQHWfxwsA8pmFdjS
	Jy1aRSe1YqiX5skeQHc3zwksBEW9a/L5h9b/zq1+NnFn98t5hfdVskShcz+UW6kXuJQzCN
	4Up5EJ3ansXEbJrD5t5A6WizielhWIs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713284628;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QPYJiiry+coQMfwqR6VYFAm42kJ8iAkPrnvOrpNcpVQ=;
	b=fNCg/DZe3XGUwsGcvjYg57LFfba7C3tMbgJS+dllSHedc7yLZmmasMGgIiKYdytEu1Qzb5
	PApYEKHUqnS9xtCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3297313931;
	Tue, 16 Apr 2024 16:23:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1/boChSmHmalGwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 16 Apr 2024 16:23:48 +0000
Date: Tue, 16 Apr 2024 18:23:47 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Daniel Wagner <dwagern@suse.de>, 
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH blktests 05/11] nvme/rc: introduce NVMET_TR_TYPES
Message-ID: <fact36d4ueuna534ktaafuel4uqkexmlkrwasky6ytvpmi33bq@x26qccgbqbnw>
References: <20240411111228.2290407-1-shinichiro.kawasaki@wdc.com>
 <20240411111228.2290407-6-shinichiro.kawasaki@wdc.com>
 <7okerxv2q5k6d2jl4ehdvido37rmycxopqalkt3xcouxeuxxe7@q73je25fv33y>
 <x5xlzl6g3riybq4uuoznt47yp2ieixtltq2sw7w5uodpcosln5@pmx2vne4qgjq>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <x5xlzl6g3riybq4uuoznt47yp2ieixtltq2sw7w5uodpcosln5@pmx2vne4qgjq>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 43BAD5D1A2
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]

On Tue, Apr 16, 2024 at 10:28:49AM +0000, Shinichiro Kawasaki wrote:
> >   # nvme_trtypes=rdma ./check nvme/006     ... works
> >   # NVMET_TRTYPES=(rdma) ./check nvme/006  ... does not work
> > 
> > I will modify the descriptions above in the v2 series to note that both
> > nvme_trtype and NVMET_TRTYPES are supported and usable.
> 
> I rethought this. Now I think it is bad that NVMET_TRTYPES can not be specified
> in command lines. To avoid this drawback, I think it's the better to change
> NVME_TRTYPES from an array to a variable with multiple items separated with
> spaces. For example, three types can be specified to NVMET_TRTYPES like this:
> 
>    NVMET_TRTYPES="loop tcp rdma"
> 
> NVMET_BLKDEV_TYPES has the same restriction then I will change it also from an
> array to a variable in same manner. I will send out v2 soon with this change.
> 
> Daniel,
> 
> I assume this change is fine for your use case. If it is not the case, please
> let me know.

Yes, it's nice that all the configure variables are of the same type.

On this topic, I am a bit confused about the naming scheme. We have the
lower case ones, e.g. 'nvme_trtypes' and now the upper case ones
NVMET_TRYPES. I assume you prefer the upper case to mark them they are
injected from the environment and the lower case ones are globals
variables in the framework. Should we retire the lower case ones and
replace them with upper case ones?
