Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D741624C9
	for <linux-block@vger.kernel.org>; Fri,  4 Apr 2025 10:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743761299; cv=none; b=OXHvPxOiQHI+QoFJmXdY/vqlVWMo2VmgL6sjcRuRMwT7VLxNVaxU8xKAgViqzybwA1nC6B43sOgZXviOKb54hlv8mPVSx3yDZhM4OeRKjN/hO6W4c2BaOYXKSzg9zCpD2w+75i01y7myVqv3xWDJkuoZ7wN63V+5x4vAvC9Nvbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743761299; c=relaxed/simple;
	bh=i1yWEsoIdahB5bruPbnH3mqvZ/Dws/EoQTvhJmNIMo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hTyyOr0qRo9HasXQ7EerBpCJvebu4AJqV3k+2ChDDRfOPttNTRZz/WJCpcePeCGvsaJOdA8VUPzTWSda3IhARwgd9tMzNeDw5KQMwJOO3GGVOHlPP9HCQKcEHAQJdFwEg+8Cqhxz+RHkW0KI0dpZctMofuO357u3DZAWAi9efFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZZhhG0Mu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=AisoJMkJ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZZhhG0Mu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=AisoJMkJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZZhhG0Mu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AisoJMkJ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZZhhG0Mu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AisoJMkJ"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C303C2119E;
	Fri,  4 Apr 2025 10:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743761295; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G+rVlJ3gw6BUDYyK/+TZGKAXr63UdsYzEPZQY6S/BpQ=;
	b=ZZhhG0MurQM6GCkYcHQzyM5kcU0lnX19jeQSbOnWXr0JZXbxMoD1P1WQs4BqGK7TIqFn9a
	OsYNkBjrzkX8FjVMenJIArWyE+LcX0Whzs5wLTa03TmdYs5K52ohLHtg9p6gBASB+9lM2q
	DtFlHbs/utD9uw0NsPaIqN/iSxZeUs0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743761295;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G+rVlJ3gw6BUDYyK/+TZGKAXr63UdsYzEPZQY6S/BpQ=;
	b=AisoJMkJDNCRaMOrnh++X7Aunk98vgjAF0jt7iHPna99dR4VdI0Tca70uE/5GTlk64R4Mq
	FLEcrx5GcgexTUBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743761295; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G+rVlJ3gw6BUDYyK/+TZGKAXr63UdsYzEPZQY6S/BpQ=;
	b=ZZhhG0MurQM6GCkYcHQzyM5kcU0lnX19jeQSbOnWXr0JZXbxMoD1P1WQs4BqGK7TIqFn9a
	OsYNkBjrzkX8FjVMenJIArWyE+LcX0Whzs5wLTa03TmdYs5K52ohLHtg9p6gBASB+9lM2q
	DtFlHbs/utD9uw0NsPaIqN/iSxZeUs0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743761295;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G+rVlJ3gw6BUDYyK/+TZGKAXr63UdsYzEPZQY6S/BpQ=;
	b=AisoJMkJDNCRaMOrnh++X7Aunk98vgjAF0jt7iHPna99dR4VdI0Tca70uE/5GTlk64R4Mq
	FLEcrx5GcgexTUBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9DCD41364F;
	Fri,  4 Apr 2025 10:08:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ltQgJI+v72dQGwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 04 Apr 2025 10:08:15 +0000
Date: Fri, 4 Apr 2025 12:08:10 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Daniel Wagner <wagi@kernel.org>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests 1/3] common/nvme: add debug nvmet path variable
Message-ID: <de0fb8ce-6f48-43ee-8865-683eeba61d4a@flourine.local>
References: <20250318-test-target-v1-0-01e01142cf2b@kernel.org>
 <20250318-test-target-v1-1-01e01142cf2b@kernel.org>
 <z6rsq3dla6hefacworxfugmb5mzw4xuqr63a5qnfaigzmceieu@gqdsgiwsr262>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <z6rsq3dla6hefacworxfugmb5mzw4xuqr63a5qnfaigzmceieu@gqdsgiwsr262>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[3]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, Apr 04, 2025 at 08:03:33AM +0000, Shinichiro Kawasaki wrote:
> On Mar 18, 2025 / 11:38, Daniel Wagner wrote:
> > Signed-off-by: Daniel Wagner <wagi@kernel.org>
> > ---
> >  common/nvme | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/common/nvme b/common/nvme
> > index 3761329d39e3763136f60a4751ad15de347f6e9b..a3176ecff2e5fbc0fbe09460c21e9f50c68d3bce 100644
> > --- a/common/nvme
> > +++ b/common/nvme
> > @@ -26,6 +26,7 @@ nvmet_blkdev_type=${nvmet_blkdev_type:-"device"}
> >  NVMET_BLKDEV_TYPES=${NVMET_BLKDEV_TYPES:-"device file"}
> >  nvme_target_control="${NVME_TARGET_CONTROL:-}"
> >  NVMET_CFS="/sys/kernel/config/nvmet/"
> > +NVMET_DFS="/sys/kernel/debug/nvmet/"
> 
> This causes the shellcheck warning SC2034.
> 
>   common/nvme:29:1: warning: NVMET_DFS appears unused. Verify use (or export if used externally). [SC2034]
> 
> I suggest to annotate "# shellcheck disable=SC2034" above the added line.

Will do. I keep forgetting to run shellcheck, sorry about that.
