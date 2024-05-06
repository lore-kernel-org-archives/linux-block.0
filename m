Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06F213CFA5
	for <linux-block@vger.kernel.org>; Mon,  6 May 2024 14:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715006930; cv=none; b=UvdHQhiytfSK5Tx7I7KpL8+QmPAWpnzi0ycEEUW8roAJb9nwgycWAWmE51+gJt0vMnaF8dUe7TYIoP22Xpm+fVOmiTpUM+xYl6AyPk/xMwa8XymhOk5Jui3YAXJGHqKaAL8rAHBMuxtz7LqGGX8J2kFu6pCzx1ongMSqIEYnV/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715006930; c=relaxed/simple;
	bh=8DkUUuAYrjpSwwioRR3Ru1SMFKuGL5hn/NDIrT53Ig0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WS5oNEkOATeoZuKrVLfRjj/08Q64fFtHEDhEHDB8q48jx9N6wGfh9XZMmBAkVw66ZfYoDLRMU16IXt6He8HnPtZxKf+gj0bfmb1Dju9XSXsCTcNafUPA5LHWPnTvShsj5BdPXtUZwZExBRa36B/S2IIx3NWihxjVZSYzT0jcuIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Qk1dslLF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PT7rsUoP; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pgaEYfvC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=l0FHoN+j; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Qk1dslLF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PT7rsUoP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pgaEYfvC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="l0FHoN+j"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D9DC8384DE;
	Mon,  6 May 2024 14:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715006927; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XA9W9f1SBSqLQu94gvj/Mh29w+9LvY09mBD6fBmg2As=;
	b=Qk1dslLFITd+O02g8p12Ft1KcwiQPGH8+YYOO49rSAg227qRPiF6anVCOvRYy1+dz1TIcZ
	sEj223RLDlv3bQdrtxU6vxQT8a2Fp5kGFpHGGo17zCYe5NJpaBCaSmwZVSmHTManX7K7Jm
	bM40iZhQ3sEM3QUXRwHWAbWIDtcrJ0Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715006927;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XA9W9f1SBSqLQu94gvj/Mh29w+9LvY09mBD6fBmg2As=;
	b=PT7rsUoPrw7ypD+0y6Z1qG7em8CT954qHyl3QlvsGuB3YcKS6kpfixH8szkXVvEPR7rs3+
	4E2kL0V0ptu5XMBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715006926; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XA9W9f1SBSqLQu94gvj/Mh29w+9LvY09mBD6fBmg2As=;
	b=pgaEYfvCgh2n39ZoIR6fGHVG+/pIMC037k1is5U0mPyG1LZyPE7t6fpTedBfxK4TeBC7az
	tujoYS6HYpsY1AcnINIPiLz9va/hzScDefgrg1BvvAzzI/EDUauu9mDWQAALVRsKjSpCUp
	odYqpzO0AbuW3KMWucJA8yLXdWJMX2Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715006926;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XA9W9f1SBSqLQu94gvj/Mh29w+9LvY09mBD6fBmg2As=;
	b=l0FHoN+jiIz0ljnZaWe+2/DOfHcMQjvThOGIGSDu6XkufAluRu3jCVLP7qcuh1FYX5rY12
	uj5mt1uXu/6WiNBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C68DC13A32;
	Mon,  6 May 2024 14:48:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id c+cDL87tOGbQdgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 06 May 2024 14:48:46 +0000
Date: Mon, 6 May 2024 16:48:46 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	Chaitanya Kulkarni <kch@nvidia.com>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH blktests v4 05/17] common/rc: introduce
 _set_combined_conditions
Message-ID: <rouixsltnzjkefrkx7jtg5ynuhrywsjjb2kafzrhtnqcdybffb@4pksg7ykjn3j>
References: <20240504081448.1107562-1-shinichiro.kawasaki@wdc.com>
 <20240504081448.1107562-6-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240504081448.1107562-6-shinichiro.kawasaki@wdc.com>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]

On Sat, May 04, 2024 at 05:14:36PM GMT, Shin'ichiro Kawasaki wrote:
> When the test case has the "set_conditions" hook, blktests repeats the
> test case multiple times. This allows repeating the test changing one
> condition parameter. However, it is often desired to run the test for
> multiple condition parameters. For example, some test cases in the nvme
> test group are required to run for different "transport types" as well
> as different "backend block device types". In this case, it is required
> to iterate over all combinations of the two condition parameters
> "transport types" and "backend block device types".
> 
> To cover such iteration for the multiple condition parameters, introduce
> the helper function _set_combined_conditions. It takes multiple
> _set_conditions hooks as its arguments, combines them and works as the
> set_conditions() hook. When the hook x iterates x1 and x2, and the other
> hook y iterates y1 and y2, the function iterates (x1, y1), (x2, y1),
> (x1, y2) and (x2, y2). In other words, it iterates over the Cartesian
> product of the given condition sets.
> 
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

I learned a bit on bash variable expansion today :)

Looks good.

Reviewed-by: Daniel Wagner <dwagner@suse.de>
