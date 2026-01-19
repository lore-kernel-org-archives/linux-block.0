Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBC63093C7
	for <linux-block@vger.kernel.org>; Mon, 19 Jan 2026 09:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768816484; cv=none; b=AdpVFZHuH5+FFIsXJ2Sts0zZQfHptu2WdeNXm/assiBxx4gjBr3/5lm3AAenYWfzFrptZM29j+hYQsxVaUthrNizp5DrM8Q7W35HxE8m9frLJBfTRfAehC43c3ltWf1jnhiyGxcXB5osuMOxgMe3b+ZjU5+K2Oz+Ig20m71UObI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768816484; c=relaxed/simple;
	bh=5B+OzeDcrxBAFhYw12n0rSBi+T+yNUuYT4W8C4wW7+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=akW3/sECh7wSaYAKAvy0JWSVwFzhmW6MXBM2UQVBf+sbqCsGizoQTAJ/jOM5ZcRx5E8uuNeRb9G47uarGrsLqrxrBrk4ePxXhu0nm1kqQcKz9DPJqpN8BUxm4/RrSEcDvdU6Jsj6btDYhB0Y7jPeM56lJNdnQfUKdf/M3Fp4NBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RcTh8WxO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZI4FyEqu; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=D/e/vq3g; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=q3UkBdmc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RcTh8WxO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZI4FyEqu";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="D/e/vq3g";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="q3UkBdmc"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4991A5BD44;
	Mon, 19 Jan 2026 09:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1768816480; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yTrFGPd2T5A/dLQv5QHem1hLGEsBRxCjWK+PScHrP7o=;
	b=RcTh8WxOMWOSyEeuIknUlW+MrYHAQrLQEB7OGzL4eZIoHA2votrILMixEuBrYjuU/PaK/K
	uwF6NQbigN/5+bbsXrkb2A+8ijX8tPhauzHJFShwEJtw03VgznqMGJg1gSY7BXlRvDf9jh
	MB5b5Ms6RaHToEmLh2g0d4HMiK28L14=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1768816480;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yTrFGPd2T5A/dLQv5QHem1hLGEsBRxCjWK+PScHrP7o=;
	b=ZI4FyEqulkURRUi9wz996fOZi9LGv4MAbNSaozcI4aR0Apr4j6ZNdT2fAROmztxSmyApaB
	/CNSiTb2ib6oNKDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="D/e/vq3g";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=q3UkBdmc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1768816479; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yTrFGPd2T5A/dLQv5QHem1hLGEsBRxCjWK+PScHrP7o=;
	b=D/e/vq3gej4GFGQ97Y0UDc7VMcJz/fGq8aKtPhyID/JOaLLMzcWQ0qqyNv6dEz8RTJ+9gd
	43GoHZohL8O+VTmYXJo/7br839fZ7NY8RBPyfu/37KXcFK8KahfCemuag6TYpaJcBFX0/H
	ADQnlkRbPbad51TxHEoovScGqTNVFbk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1768816479;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yTrFGPd2T5A/dLQv5QHem1hLGEsBRxCjWK+PScHrP7o=;
	b=q3UkBdmc5Hh+TGmkYN4edD5kojYt5jAk2XG6jBWJeW9m1YRLf4Jr/qzHdjZOqVYgcVMUa3
	1Nak1Bs9ood/OmDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3BA263EA63;
	Mon, 19 Jan 2026 09:54:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SqSjDV//bWlAbQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 19 Jan 2026 09:54:39 +0000
Date: Mon, 19 Jan 2026 10:54:34 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, shinichiro.kawasaki@wdc.com, 
	yi.zhang@redhat.com, gjoyce@ibm.com
Subject: Re: [PATCH blktests] check: add kmemleak support to blktests
Message-ID: <1379703f-c48f-4a86-9cfe-fe22d85d5679@flourine.local>
References: <20260113095134.1818646-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113095134.1818646-1-nilay@linux.ibm.com>
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	URIBL_BLOCKED(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,flourine.local:mid];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email]
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Rspamd-Queue-Id: 4991A5BD44
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 

On Tue, Jan 13, 2026 at 03:21:03PM +0530, Nilay Shroff wrote:
> Running blktests can also help uncover kernel memory leaks when the
> kernel is built with CONFIG_DEBUG_KMEMLEAK. However, until now the
> blktests framework had no way to automatically detect or report such
> leaks. Users typically had to manually setup kmemleak and trigger
> scans after running tests[1][2].
> 
> This change integrates kmemleak support directly into the blktests
> framework. Before running each test, the framework checks for the
> presence of /sys/kernel/debug/kmemleak to determine whether kmemleak
> is enabled for the running kernel. If available, before running a test,
> any existing kmemleak reports are cleared to avoid false positives
> from previous tests. After the test completes, the framework explicitly
> triggers a kmemleak scan. If memory leaks are detected, they are written
> to a per-test file at, "results/.../.../<test>.kmemleak" and the
> corresponding test is marked as FAIL. Users can then inspect the
> <test>.kmemleak file to analyze the reported leaks.
> 
> With this enhancement, blktests can automatically detect kernel memory
> leaks (if kerel is configured with CONFIG_DEBUG_KMEMLEAK support)  on
> a per-test basis, removing the need for manual kmemleak setup and scans.
> This should make it easier and faster to identify memory leaks
> introduced by individual tests.
> 
> [1] https://lore.kernel.org/all/CAHj4cs8oJFvz=daCvjHM5dYCNQH4UXwSySPPU4v-WHce_kZXZA@mail.gmail.com/
> [2] https://lore.kernel.org/all/CAHj4cs9wv3SdPo+N01Fw2SHBYDs9tj2M_e1-GdQOkRy=DsBB1w@mail.gmail.com/

Nice!

Reviewed-by: Daniel Wagner <dwagner@suse.de>
