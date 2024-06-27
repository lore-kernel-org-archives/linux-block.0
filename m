Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7577D23BE
	for <linux-block@vger.kernel.org>; Thu, 27 Jun 2024 09:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719480507; cv=none; b=eWJA/xscBU00KPQt6p7XZ/vKhffSiv9UUZQoCFNpyXsrDjfGsFvstFY59PasvssOcnI2z6A4Ao3sSN0s85X1B6t3tuDtcvCEq9mJdBKxgRQp0tKW4P/FOdJud4vHepFUuWpJh4DxeJt3rZ+pnAcGLaUWZ5M+q3t3Y8DkQoKGO2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719480507; c=relaxed/simple;
	bh=FbFXx3e4zUBrg1PrqS9KXAyTRZ0qIxMxJ8RFRFBJq28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tesy7NiLyhkO8LvLxA3PX6G5SYxP1+zB9rsIjPEkUOMPISoUv9sZxjh9qbsLoRflQroGEM8PmN7oLs2hz8Py4o50qic49+Rs1/kOUUhTryYIKvmEsAc/Tx1eSea7yM6AMDjcgI8JIYpB8lUErZQbVKbMONODxlKhDLkWlrGPYPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C070A1FBB1;
	Thu, 27 Jun 2024 09:28:22 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AE6C51384C;
	Thu, 27 Jun 2024 09:28:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oeKXKLYwfWanGwAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 27 Jun 2024 09:28:22 +0000
Message-ID: <2f1d6ff3-c087-4dce-8e91-41f097f38c6d@suse.de>
Date: Thu, 27 Jun 2024 11:28:22 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests v3 0/3] Add support to run against real target
To: Daniel Wagner <dwagner@suse.de>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20240627091016.12752-1-dwagner@suse.de>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240627091016.12752-1-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Queue-Id: C070A1FBB1
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On 6/27/24 11:10, Daniel Wagner wrote:
> I've added a new hook so that the default variables can be configured via the
> script. This simple overwrite of the defaults allows to use external configured
> setups (there is some trickery involved as it's not possible to do it only once
> due to include orders). The upside of this approach is that we don't have to add
> more environment variables.
> 
Round of applause ... Thanks for doing this!

> I've run blktests against a PowerStore. That worked fairly okay but there were
> some fallouts which is kind of expected at this stage:
> 
I guess we should blank out tests which don't make sense for a real target.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

