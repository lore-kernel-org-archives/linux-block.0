Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793722792;
	b=JGc7HLQ0RbhCvWZ275mSmxBLSyjNLTqzM/1nUDoW2D7HaXakNkFwD/Poc1eqCiHMXc9N
	 0ZB8JLiU99YPp7qmhibl4IiObxBzxlfvTTp8sCjeHqLEsWRcMPr0kIliBBBnwnQTRfSnK
	 cwKAujBr/2jsqwF/w0SJEr7JeQFoI2mgsIpnuN0e6WIvcFkuv8cTTxsvYixp2JrV24OfN
	 BshsoTvl/ZWsrVKMYTaIl64OTkJU7bv2pI2DYom4OUxgxyvOjIbj4j0F0OnOx/zC9zGgb
	 ttyCwF1KIkSTjRiMiPubOHnZZ42FMm0B51ezTfbHIXV0Cf/LJ469fpuREF0Hl9ahnwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793722792;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Spam-Flag:X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=xpHfezqL4CrIA/YWN30z+58s5ArRjCM7V4FJXfacvA8=;
	b=TtU8i5FnQT74RW4KEX30H+Ht8fKtdJDvqjqnFhylt/3eWzlivat5alBRIys7+IF8cfYo
	 u622yMad/PZ0EkQj1QgtsnITR3lvuf+O1ZRFkhqlJjPZw2olo91eo9EsJFwdUi0r2QHdA
	 nredkOgwLZ48P3Ncggc15S6+booorkibqfQcLAkrSR/zzyfD5vE5yYW6zcLa2oDnZrey8
	 V8Y9qgByQUkKKIp1l3x6eTKMe4Lphw7WNWHGz0p+iOjn4LNiMpqslLtymIow9egbOmQ60
	 t+q5CzgEZfslZ5Ul7MtSj8/aZO+Jk2lWcRE+Y/HnkXlbcCEyYYk8lBzFt0FUQ9qqOAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=aDJFbn4U;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=4WcV0edj;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=KcehG9YB;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=gPgX8g05;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6FD606A324;
	Tue,  3 Nov 2026 16:19:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F6FD606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=aDJFbn4U;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=4WcV0edj;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=KcehG9YB;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=gPgX8g05
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7A0C61F7C8;
	Tue,  3 Nov 2026 16:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793722789; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xpHfezqL4CrIA/YWN30z+58s5ArRjCM7V4FJXfacvA8=;
	b=aDJFbn4UfCWVzleIqHQkZOzxzD5KopNAjKt3Dn+28Iwk5CK0TuQmoHVCF5Gr6Q37q10Ixx
	9gAMIgLYmqt+QnYFmGWt6gxk8JYKJ1cbpkyVW8wFLjfdJln228N6x0pLcb2kuxEr31NFlx
	VpfD/gxW8RgYqpdj5jRL6yBr5zP71TE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793722789;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xpHfezqL4CrIA/YWN30z+58s5ArRjCM7V4FJXfacvA8=;
	b=4WcV0edjPKML7rTkw1Z0/AM/FyZfnseUDTnjQur1t7IQ8SLqzNJI+kdZ1L8u84HzpieX0+
	sGOwQaO5cmt/mzAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793722788; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xpHfezqL4CrIA/YWN30z+58s5ArRjCM7V4FJXfacvA8=;
	b=KcehG9YBZcg0wpfTWurK6MXhP+sa+DSfVqtSsBwlwbPBGRPPgpyu4h8aQWgmBpRirgsTPs
	z9vyNT/Z11raOwsnTOSQMW49fhprVZc5+Nz2yZ5ZZxakqpzKMpjbDHN21BIUJ7QjeX3IaN
	b6VVAJvbN39hsePQojYZSSalYFib5gE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793722788;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xpHfezqL4CrIA/YWN30z+58s5ArRjCM7V4FJXfacvA8=;
	b=gPgX8g05ZZOofLlMJ3DBqU5IWZx8u0Qjua5v2nx+O15Mi3wmlKfSFt0Y2Ezmy5nkD/Lr+H
	0BjS448HcM1UfXCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 28B6E134B8;
	Tue,  3 Nov 2026 16:19:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jG3NOqMJ6mqKdgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 03 Nov 2026 16:19:48 +0000
Date: Tue, 3 Nov 2026 17:19:42 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Qiliang Yuan <odys.yuan@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, Hannes Reinecke <hare@kernel.org>, 
	Ming Lei <tom.leiming@gmail.com>, Nilay Shroff <nilay@linux.ibm.com>, 
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: Re: [PATCH v2] nvme: remove namespaces in parallel
Message-ID: <b6aab18c-f812-4164-a41d-e1b95e462709@flourine.local>
References: <20261103-bug-nvme-remove-ns-async-v2-1-44e43766e44a@gmail.com>
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
In-Reply-To: <20261103-bug-nvme-remove-ns-async-v2-1-44e43766e44a@gmail.com>
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-11.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,kernel.dk,lst.de,grimberg.me,lists.infradead.org,vger.kernel.org,gmail.com,linux.ibm.com,wdc.com];
	TAGGED_RCPT(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -11.80

On Tue, Nov 03, 2026 at 01:28:02AM -0500, Qiliang Yuan wrote:
> +static void nvme_ns_remove_async(void *data, async_cookie_t cookie)
> +{
> +	nvme_ns_remove(data);
> +}
> +
>  /*
>   * This function iterates the namespace list unlocked to allow recovery from
>   * controller failure. It is up to the caller to ensure the namespace list is
> @@ -4725,6 +4730,7 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
>  {
>  	struct nvme_ns *ns, *next;
>  	LIST_HEAD(ns_list);
> +	ASYNC_DOMAIN(domain);
>  
>  	/*
>  	 * make sure to requeue I/O to all namespaces as these
> @@ -4759,8 +4765,13 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
>  	mutex_unlock(&ctrl->namespaces_lock);
>  	synchronize_srcu(&ctrl->srcu);
>  
> +	/*
> +	 * Remove the namespaces in parallel, as each removal waits for several
> +	 * RCU grace periods.
> +	 */
>  	list_for_each_entry_safe(ns, next, &ns_list, list)
> -		nvme_ns_remove(ns);
> +		async_schedule_domain(nvme_ns_remove_async, ns, &domain);
> +	async_synchronize_full_domain(&domain);

Nice! 

Reviewed-by: Daniel Wagner <dwagner@suse.de>
