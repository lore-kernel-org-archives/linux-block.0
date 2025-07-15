Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1D0274B58
	for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 09:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752571356; cv=none; b=EhNMp9lmurYRn+/HNFpOsca3nXHFeiyH39Jv/Ve1YK7xYJVS/LFdEP5G0bITYWzJbuq5FceezD6uC6fS798LFR4HRZpaTqNpFd/5B1l6xYSXGDq0YPsdEPd7gsBs6p4+yHAVIUVSW4kGORCaEmLgKQ79OQ7A33rx+yVLNY6PoLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752571356; c=relaxed/simple;
	bh=l3Vvp1r1K05aZ5LWzSbpVcWzGGXQ9B4Db3wV8mbpGqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=du9agYbWxS1we/F4zEX8/HOGVp1P7FkZXcVzH3YF5DB/Z8ISSxKmD8kfdFhDaX4B7FIDm2ITvZEdDLLh3XYKv915VFPrpPd7G0eTM5RYunjffwbgryOz0Yt3Y9FOMUBrkRSXVcj99FqoEYlu6jtH11Yq3Bc3bw0oSSx3nTw7ovU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BqlsOXUc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=eBAawbP2; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BqlsOXUc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=eBAawbP2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BqlsOXUc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="eBAawbP2";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BqlsOXUc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="eBAawbP2"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A2BCD21239;
	Tue, 15 Jul 2025 09:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752571352; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S6ocZhVPPt8xSLeEHEmXJ6VormR8qHfmPjnou+hgu/Q=;
	b=BqlsOXUcqFpjixuvZsLAicluOTbEroTtv7BGljFTzZvBxCiSAh7+dWH1EOMkvI1ZMEwRK/
	urhnO4H2ydb/mUqiE+YawV/QOG/299ejmj5B1+JKXeZGz/b/6KBsTkpfEQ8ZZ5RGiyEyEh
	lQI99j2rMtJrYuBY599lj65zllmqaYg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752571352;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S6ocZhVPPt8xSLeEHEmXJ6VormR8qHfmPjnou+hgu/Q=;
	b=eBAawbP2fI1LhRh+GSUX80wwRbEWpmJF9Gj2Qb0CGeTI+3Lxmjq8+vJbc3GdMaFndpqcoT
	0NhXl6LZubkHCPDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=BqlsOXUc;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=eBAawbP2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752571352; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S6ocZhVPPt8xSLeEHEmXJ6VormR8qHfmPjnou+hgu/Q=;
	b=BqlsOXUcqFpjixuvZsLAicluOTbEroTtv7BGljFTzZvBxCiSAh7+dWH1EOMkvI1ZMEwRK/
	urhnO4H2ydb/mUqiE+YawV/QOG/299ejmj5B1+JKXeZGz/b/6KBsTkpfEQ8ZZ5RGiyEyEh
	lQI99j2rMtJrYuBY599lj65zllmqaYg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752571352;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S6ocZhVPPt8xSLeEHEmXJ6VormR8qHfmPjnou+hgu/Q=;
	b=eBAawbP2fI1LhRh+GSUX80wwRbEWpmJF9Gj2Qb0CGeTI+3Lxmjq8+vJbc3GdMaFndpqcoT
	0NhXl6LZubkHCPDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8825213A68;
	Tue, 15 Jul 2025 09:22:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MROSHtgddmg9ZQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 15 Jul 2025 09:22:32 +0000
Date: Tue, 15 Jul 2025 11:22:31 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, Yi Zhang <yi.zhang@redhat.com>, 
	Bart Van Assche <bvanassche@acm.org>, Gulam Mohamed <gulam.mohamed@oracle.com>
Subject: Re: [PATCH blktests v2] loop/010, common/rc: drain udev events after
 test
Message-ID: <92ca86d6-a18a-4926-bcd0-5fbcf55037ac@flourine.local>
References: <20250715043202.28788-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715043202.28788-1-shinichiro.kawasaki@wdc.com>
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,wdc.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: A2BCD21239
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51

On Tue, Jul 15, 2025 at 01:32:02PM +0900, Shin'ichiro Kawasaki wrote:
> The test case repeats creating and deleting a loop device. This
> generates many udev events and makes following test cases fail. To avoid
> the unexpected test case failures, drain the udev events. For that
> purpose, introduce the helper function _drain_udev_events(). When
> systemd-udevd service is running, restart it to discard the events
> quickly. When systemd-udevd service is not available, call
> "udevadm settle", which takes longer time to drain the events.
> 
> Link: https://github.com/linux-blktests/blktests/issues/181
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Suggested-by: Bart Van Assche <bvanassche@acm.org>
> Suggested-by: Daniel Wagner <dwagner@suse.de>
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

Looks good to me. Thanks!

Reviewed-by: Daniel Wagner <dwagner@suse.de>
