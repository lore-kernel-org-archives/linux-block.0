Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2AE13AA27
	for <linux-block@vger.kernel.org>; Fri, 23 Aug 2024 07:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724396882; cv=none; b=IJli43dkRHUT/DBuw5Fgsse8QL5d9I4hct5v4mdfH/w4yVzz14yjBMqFtNlWW9AndAtpTzKHP67oYX0+qoSOkKhYuqgrzeedvQcYaLBXV/V10tvmdGbq4A/rhmp7DYujmi+3/Mb9VJJjd7HpQHm+9OMuRPgGEMBvwxCir7u6lH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724396882; c=relaxed/simple;
	bh=/PyioiNkdo5qcTf8VbC7N/3/JtO+eeWG0jCWllaVmLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JTpsRIuIA5RoT3aNxDgHyJbaBtFPe80oKvs5FDd9EG15lRk8YXk7sIHb99kXzp7kRGnk/baA64PWVrGz9kaOnY25zoe7B7HDcB6elUdsu3Te4OPKJWufZg8ElpoZT+p39al2RCHNVVWByKlB10pQoFUJYEb0R121VJBclR0SMlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 088B31F770;
	Fri, 23 Aug 2024 07:07:59 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DFCDB1333E;
	Fri, 23 Aug 2024 07:07:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id URfJNE41yGbecQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 23 Aug 2024 07:07:58 +0000
Date: Fri, 23 Aug 2024 09:07:58 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Martin Wilck <mwilck@suse.com>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>, Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/3] blktests: nvme: skip passthru tests on multipath
 devices
Message-ID: <faa71c11-94b5-4375-a645-b4eb5011ed75@flourine.local>
References: <20240822193814.106111-1-mwilck@suse.com>
 <d1282549-f037-4556-93f7-adb3d890db82@flourine.local>
 <1106fb07918468cb8cacb35ef0448573ec7be156.camel@suse.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1106fb07918468cb8cacb35ef0448573ec7be156.camel@suse.com>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 088B31F770
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 

On Fri, Aug 23, 2024 at 08:41:59AM GMT, Martin Wilck wrote:
> On Fri, 2024-08-23 at 08:35 +0200, Daniel Wagner wrote:
> > On Thu, Aug 22, 2024 at 09:38:12PM GMT, Martin Wilck wrote:
> > > +_require_test_dev_is_nvme_no_mpath() {
> > > +	if [[ "$(readlink -f "$TEST_DEV_SYSFS/device")" =~ /nvme-
> > > subsystem/ ]]; then
> > > +		SKIP_REASONS+=("$TEST_DEV is a NVMe multipath
> > > device")
> > > +		return 1
> > > +	fi
> > > +	return 0
> > > +}
> > 
> > Just a nit: what about _require_test_dev_is_native_multipath?
> 
> The intention was to require a device that is _not_ a native multipath
> device. Change it to "_require_test_dev_is_not_native_multipath"?

I confused mpath with dm-mpath when I read the function name. Doesn't
make any sence obviously but still got me confused. I prefer the more
explicit function name you suggested. But let's here what others say.
