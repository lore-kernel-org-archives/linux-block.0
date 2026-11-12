Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794474448;
	b=x2tQGw3jEKC1TfHhzn52V0JCmU1VY9S7sN/0mhyfM/CYigHXL8MM6/uCyRTRZj2zRBwl
	 q0DhEmSPsdth94UVZhr0S2u4VK9bS2S44RylsSVgyW93wQMqAsQfKIZXUPgDp8wEcbzgU
	 b8+WZypp5Tjg+B+FDhRqMYT0RaZFlShYIbSAnURrFj67G0c6rK7plCjtk9rcFMgZDGaKL
	 U30UxFJw9tn3awWp+jqOXlxRoWdlhYSyH2jl9pXQtLz8qr9uLY8JT+xzyb93r10tWpu0a
	 tfTj2Ow/uvnX0uTDm4Ld0TgB20K6RW2bUmvThDiK6dK6LYrYG1wQqpFfWGakZ12ttqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794474448;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Spamd-Result:X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:
	 X-Spam-Score:X-Spam-Level:X-Rspamd-Queue-Id;
	bh=Ge3bleOIShzu7IxbhTk5+GDi2Z8J3xHnKGzywhphlEw=;
	b=KD8kgbjstdWkmkWr1tNRXhud7t1uGHq3CespNuo5At0XXCf8gyDG+/O4TdCJZe7TEzbO
	 oQxE+D13jUkJbY21uEgNwReALljaFAXfIpcfrvnb+lzeg6M5tTlfzYIxZOzMfNW/DgRuS
	 3iMLoHwJ9svKUxqwEwZYfvuzjIEVji2OuxY3JlY09GbCmNKDkjAXxQHKzautJBz3PuC4N
	 Bmh1lQ0H0qh8QF+7sZ+0/bhy0Uica5KPAHFRhN4MyKd91flwZLOAfbyeLcGOdRE4fhbsL
	 VURS2wk78arjitrxfAl/0kHOziMTn8k/EEsS4Zm8bxhETPTsb27JxY/lVjhHCYIj50Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=zdgvaGCV;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=VQwPl0aV;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=zdgvaGCV;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=VQwPl0aV;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B674606A321
	for <linux-block@vger.kernel.org>; Thu, 12 Nov 2026 09:07:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B674606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=zdgvaGCV;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=VQwPl0aV;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=zdgvaGCV;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=VQwPl0aV
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2B7291F78D;
	Thu, 12 Nov 2026 09:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794474446; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ge3bleOIShzu7IxbhTk5+GDi2Z8J3xHnKGzywhphlEw=;
	b=zdgvaGCVOCIPW2O3hFfWuBDUdBQym1SbnaW1jIFmKIvvtiB1dJ7dbGY7PavUW9mXWA6JKy
	eV4XJQcS2npoGWI5rse8xLD21RC/BZLhJSIKiq3jHu5eZc2dSZTH5w+J8TAXAXZWgLDjad
	FWaoloOhH2j4DW2kZgkI2ZzgnZ9JPoE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794474446;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ge3bleOIShzu7IxbhTk5+GDi2Z8J3xHnKGzywhphlEw=;
	b=VQwPl0aVakQxf9nmcy2+HN9nJkDLunJnJ6bsK6BstEjfTbJmGHovkUmce1YHM+7LPzp5Ek
	ZYL703M0YYU1cqAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=zdgvaGCV;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=VQwPl0aV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794474446; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ge3bleOIShzu7IxbhTk5+GDi2Z8J3xHnKGzywhphlEw=;
	b=zdgvaGCVOCIPW2O3hFfWuBDUdBQym1SbnaW1jIFmKIvvtiB1dJ7dbGY7PavUW9mXWA6JKy
	eV4XJQcS2npoGWI5rse8xLD21RC/BZLhJSIKiq3jHu5eZc2dSZTH5w+J8TAXAXZWgLDjad
	FWaoloOhH2j4DW2kZgkI2ZzgnZ9JPoE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794474446;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ge3bleOIShzu7IxbhTk5+GDi2Z8J3xHnKGzywhphlEw=;
	b=VQwPl0aVakQxf9nmcy2+HN9nJkDLunJnJ6bsK6BstEjfTbJmGHovkUmce1YHM+7LPzp5Ek
	ZYL703M0YYU1cqAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EEE49134A0;
	Thu, 12 Nov 2026 09:07:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wUuOMs2B9WpmbgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 12 Nov 2026 09:07:25 +0000
Date: Thu, 12 Nov 2026 10:07:21 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH blktests v2 0/6] nvme: tests for fabrics queue mapping
 and isolated or offline CPUs
Message-ID: <6ca6db89-670b-4ec8-952c-c67169f3bbcb@flourine.local>
References: <20261104-nvme-isolcpu-v2-0-2d59f622a2c8@suse.de>
 <avPchJ4rj-xrgH4G@shinmob>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avPchJ4rj-xrgH4G@shinmob>
X-Spamd-Result: default: False [-13.51 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -13.51
X-Spam-Level: 
X-Rspamd-Queue-Id: 2B7291F78D

On Wed, Nov 11, 2026 at 12:48:51PM +0900, Shin'ichiro Kawasaki wrote:
> Daniel, thanks for the v2 patch. I applied the first three patches for
> the test cases above. Please note that I renumbered them to
> nvme/078-080.

Thanks!
> 
> The other three patches look good. IIUC, they depend on another kernel patch
> [*]. I would like to wait for it applied, then take another look on
> them.

Yes, let me ping Keith :)
